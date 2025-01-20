;; Universe Registry Contract

(define-data-var universe-counter uint u0)

(define-map universes uint {
  name: (string-ascii 50),
  energy-constant: uint,
  dimensional-frequency: uint,
  stability-index: uint
})

(define-public (register-universe (name (string-ascii 50)) (energy-constant uint) (dimensional-frequency uint))
  (let
      ((new-id (+ (var-get universe-counter) u1)))
      (map-set universes new-id {
          name: name,
          energy-constant: energy-constant,
          dimensional-frequency: dimensional-frequency,
          stability-index: u100
      })
      (var-set universe-counter new-id)
      (ok new-id)
  )
)

(define-public (update-universe-stability (id uint) (new-stability uint))
  (let
      ((universe (unwrap! (map-get? universes id) (err u404))))
      (ok (map-set universes id
          (merge universe { stability-index: new-stability })))
  )
)

(define-read-only (get-universe (id uint))
  (map-get? universes id)
)

(define-read-only (get-universe-count)
  (var-get universe-counter)
)

