Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE28C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683DB841F2;
	Fri,  3 Jul 2026 09:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLBCXxbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9532849F3; Fri,  3 Jul 2026 03:49:56 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4FB84857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-497d294e0e5so33168b6e.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043392; x=1783648192; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kJj1q3k3NrH2/6P6Qrt35a8d5b978GzZ9ceYPN5RhkA=;
 b=OLBCXxbWzrFMMcqnz1X7h4BPRL/E6AhjryuWfnuHSDpupYiHmhPLzthU1QfhsUbWBa
 JZrRlnSi8JtdQoh3vwaYyix8WcxvV+8IhjWiQvnwWI98nt485tTCuFU5EeGq6/m2I2TG
 ue24Zvp5YrycHtKbwv9Opu7WrTNS5ieInNTHNu8/FMNtgKl1y2Q+EIySQZG4rccKjucJ
 bYGvng8b19rZ5K1530eEZw9vvnpPd107vWx0ANxxaslAHD5ol1N0uc/1iFa25SVhzudK
 JGDSWF5oR0dLeWfbCILX693yM5m0OzUegZEm/HfZU1WRSDvj00r4Gckp8vQFwa0K71Sz
 M4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043392; x=1783648192;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kJj1q3k3NrH2/6P6Qrt35a8d5b978GzZ9ceYPN5RhkA=;
 b=c+lRbYfmc5yCWzc5pRoZIgvDgqmtslidAXb8XeOoTm3dIgH9CAlPuao1lOSZOpLSFu
 2YLVvzB4lXB5wORSV8O+VPZs+VgCFqz7rDsEEnlJlW/J/601zdtrI5dL1KK1hsJDbHEl
 otXFYrIwLHI1ac1yGxfWAW7A0WvuvPCNB+YV+NsB4J92KJ6DvckHZ37Gk0DBDv46lsgS
 yfSeuOOk7BR7XhGSbOSUFSNNFA4e0lbAj4xfgcE7XqqCpZIi+I5cfvp6GS0INY1ZJ1tY
 RBjhrzxanQAy7SB8aw5uMmlCFTi6SmRdCqwPpY/u0J1sRE/jqK+hPOTP82qOR14/BeIj
 ZA2w==
X-Gm-Message-State: AOJu0YxskgzYTo/8kimA80ZiMFVbzeWSTMnX/v3iSBqhHLimPxYaKe67
 4hObGyYRsE06V9hjE1pdbcs1TspAr2v9LG1fhkQRQgKNXTLuNAqkN78g
X-Gm-Gg: AfdE7ckTquUXSNptthdyOEpKq5kYP8oL8y9bf+HYpCwxZxWGeuu2p2T60QSycAVfoyq
 PJRBYSaET0b/l+chwjHoEcuc7eCW+DUu9f19AMI3L2z313NY97DmGujj3+ncyAWwX12yrlnzXXe
 0zQCsS0Dnm58wDtF0Cqz75mXMcJqJRzy27EcJJGCSAc93MxpbqnhdV4c8wxp4OB0+8s13PQuS/C
 pSw8LQmhFxYZG3P+1P0emezucqhsSgcbdy8acRRj66kTML086Z3PkY9aNqi5SKeArvx6ZUcFDKo
 +Xdnt95hnKyoU9bJR7Gj8VF08G4WJQtn52CBpSzM9LvOYRR07D9xdQk5XP4bRG19DVR4H0Mme7F
 pgZS7ljdPxxNxkic8ge8cmbYxzWXZaKEF6/v6z5nYZhoq3KYUMREWvwTyVwaydZgDUGkMKeHvQX
 gzPKehM/0uWKeMT18PePPkR3oBgLsgm26LjbC11McgdQcw1e7BSJS05SgsZGbw9aVFQermbzwqT
 9L8UE14Xg+y2GrvfkHtVtDKZ5OJh+FI2xSTGYyXGD3+ZYrOUqGZH1izW/t9n0ErgWW9bg==
X-Received: by 2002:a05:6808:87d1:b0:495:faa4:a742 with SMTP id
 5614622812f47-4962d90f383mr5455317b6e.41.1783043392170; 
 Thu, 02 Jul 2026 18:49:52 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:49:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 00/10] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Thu, 02 Jul 2026 19:49:45 -0600
Message-Id: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBBA4VfRXJtak6y8ilwwBqP8tIuUvLvF5
 bn4zgVenIqHIrrAyaFelzkExRHwUM+9oLahgQxlxhpCvzeTbsiCv8SDMK2tbRJrOMsZglyddHp
 +17L6O7BReHtXcN8PsUnQuXcAAAA=
X-Change-ID: 20260702-submit-ce-series-v2-4a77b170c68c
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series enables Allwinner Crypto Engine backed FIT decryption and
FIT signature/hash validation for secure-boot flows on H6/H616-class
boards, covering both SPL and U-Boot proper.

The purpose is to use CE-backed AES for encrypted FIT payloads on H6/H616
and CE-backed ECDSA validation where the CE ECC engine is available,
currently H616, instead of relying only on software crypto paths.

At a high level this adds:

  - SPL driver-model crypto plumbing for AES and hash providers.
  - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
    decrypt an encrypted U-Boot proper FIT without allocating another full
    payload buffer.
  - A shared sun8i-ce parent driver with AES and hash children for H6/H616.
  - An H616 ECDSA child for CE-backed FIT signature validation, plus common
    ECDSA curve-size and key-encoding fixes for secp224r1, prime256v1,
    secp384r1 and secp521r1.

The AES child supports software-provided AES-128/192/256 keys in ECB and
CBC modes. The hash child supports the CE one-shot MD5/SHA1/SHA256/SHA384/
SHA512 methods used by FIT verification. The ECDSA child exposes the H616
CE ECC verifier through UCLASS_ECDSA.

Tested flows include:

  - SPL loading an encrypted and signed U-Boot proper FIT with CE-backed
    AES decryption, hash verification and ECDSA signature verification.
  - U-Boot proper loading an encrypted and signed FIT with CE-backed AES
    decryption, hash verification and ECDSA signature verification.
  - U-Boot proper AES command paths using the DM AES provider.
  - CE ECDSA verification with secp224r1, prime256v1, secp384r1 and
    secp521r1 FIT signatures.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Add a cover letter for the series  (suggested by Peter Robinson)
  - Describe the purpose and supported devices  (suggested by Peter Robinson)
  - Limit AES command patch to argv fix  (suggested by Simon Glass)
  - Add Fixes tag for the AES command bug  (suggested by Simon Glass)
  - Select SPL_CRYPTO from SPL_DM_AES  (suggested by Simon Glass)
  - Add SPL_DM_HASH for SPL FIT verification through UCLASS_HASH
  - Let AES providers choose the software-provided key slot
  - Return -ENOSYS without an SPL decrypt provider  (suggested by Simon Glass)
  - Explain FIT cipher validation  (suggested by Simon Glass)
  - Explain host-tool decrypt handling  (suggested by Simon Glass)
  - Explain phase-keyed lib/aes builds  (suggested by Simon Glass)
  - Decrypt external SPL FIT payloads in place  (suggested by Simon Glass)
  - Skip self-memmove after direct decrypt  (suggested by Simon Glass)
  - Add Simon's Reviewed-by tag to the sunxi CE clock/reset patch
  - Explain the RSA impact of fdt_add_bignum()  (suggested by Simon Glass)
  - Document ECDSA public key byte-array widths  (suggested by Simon Glass)
  - Document ecdsa_curve_size()  (suggested by Simon Glass)
  - Keep fdt_add_bignum() errors in libfdt space  (suggested by Simon Glass)
  - Explain the SPL_DM dependency for SPL_ECDSA_VERIFY
  - Document the ECDSA input-buffer layout  (suggested by Simon Glass)
  - Document ECC byte-sized task length  (suggested by Simon Glass)
  - Make CE ECDSA curves individually selectable  (suggested by Simon Glass)
  - Use neutral wording for the CE ECDSA buffer-layout comments
  - Reject oversized bit-length hash tasks  (suggested by Simon Glass)
  - Feed the watchdog while polling CE completion  (suggested by Simon Glass)
  - Drop the post-operation schedule() call  (suggested by Simon Glass)
  - Bounce only word-unaligned hash input

To: Svyatoslav Ryhel <clamor95@gmail.com>
To: Ion Agorria <ion@agorria.com>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Anton Ivanov <anton@binarly.io>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Cc: Randolph Sapp <rs@ti.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Francesco Valla <francesco@valla.it>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: E Shattow <e@freeshell.de>
Cc: Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: Lucas Dietrich <ld.adecy@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Francois Berder <fberder@outlook.fr>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jerome Forissier <jerome.forissier@arm.com>

---
James Hilliard (10):
      cmd: aes: fix DM operation handling
      crypto: aes: allow DM AES in SPL
      boot: image: add FIT decrypt-to-buffer helper
      spl: fit: support encrypted payloads
      clk: sunxi: add H6/H616 CE gates and reset
      lib: ecdsa: support additional curve sizes
      crypto: allwinner: add sun8i-ce AES driver
      crypto: allwinner: add sun8i-ce ECDSA verifier
      crypto: hash: allow DM hash in SPL
      crypto: allwinner: add sun8i-ce hash driver

 MAINTAINERS                                        |   1 +
 boot/Kconfig                                       |   8 +
 boot/image-cipher.c                                |  38 +-
 boot/image-fit.c                                   |  97 +++--
 cmd/aes.c                                          |   8 +-
 common/spl/spl_fit.c                               |  68 +++-
 doc/mkimage.1                                      |   3 +
 doc/usage/fit/signature.rst                        |   9 +-
 drivers/clk/sunxi/clk_h6.c                         |   5 +
 drivers/clk/sunxi/clk_h616.c                       |   5 +
 drivers/crypto/Kconfig                             |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/aes/Kconfig                         |   8 +
 drivers/crypto/aes/aes-sw.c                        |   6 +
 drivers/crypto/aes/aes-uclass.c                    |  15 +
 drivers/crypto/allwinner/Kconfig                   |   3 +
 drivers/crypto/allwinner/Makefile                  |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig          | 158 ++++++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 413 ++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 408 +++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 434 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 298 ++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |  72 ++++
 drivers/crypto/hash/Kconfig                        |  10 +
 drivers/crypto/hash/Makefile                       |   2 +-
 drivers/crypto/tegra/tegra_aes.c                   |   7 +
 include/image.h                                    |  39 +-
 include/u-boot/aes.h                               |  10 +
 include/u-boot/ecdsa.h                             |  22 ++
 include/u-boot/fdt-libcrypto.h                     |   6 +-
 include/uboot_aes.h                                |  38 +-
 lib/Makefile                                       |   2 +-
 lib/aes/aes-decrypt.c                              | 108 ++++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++++---
 lib/ecdsa/ecdsa-verify.c                           |  39 +-
 lib/fdt-libcrypto.c                                |  60 +--
 tools/image-sig-host.c                             |   7 +
 39 files changed, 2363 insertions(+), 199 deletions(-)
---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

