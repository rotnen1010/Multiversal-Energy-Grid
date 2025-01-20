;; Energy Transfer Contract

(define-data-var transfer-counter uint u0)

(define-map energy-transfers uint {
  source-universe: uint,
  destination-universe: uint,
  energy-amount: uint,
  status: (string-ascii 20)
})

(define-public (initiate-transfer (source uint) (destination uint) (amount uint))
  (let
      ((new-id (+ (var-get transfer-counter) u1)))
      (map-set energy-transfers new-id {
          source-universe: source,
          destination-universe: destination,
          energy-amount: amount,
          status: "pending"
      })
      (var-set transfer-counter new-id)
      (ok new-id)
  )
)

(define-public (update-transfer-status (id uint) (new-status (string-ascii 20)))
  (let
      ((transfer (unwrap! (map-get? energy-transfers id) (err u404))))
      (ok (map-set energy-transfers id
          (merge transfer { status: new-status })))
  )
)

(define-read-only (get-transfer (id uint))
  (map-get? energy-transfers id)
)

(define-read-only (get-transfer-count)
  (var-get transfer-counter)
)

