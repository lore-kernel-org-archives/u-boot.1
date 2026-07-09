Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB00C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E4284B01;
	Fri, 10 Jul 2026 14:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rrm1TtXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDEE84BA3; Fri, 10 Jul 2026 00:46:52 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018E98484A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6a379b68f76so172499eaf.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783637209; x=1784242009; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LJMDbq8JWG8gLM228rAF9jWVRS2ybdRS1PCkN7Sa25I=;
 b=rrm1TtXiGVdUsK/GVGEMvUtzUsHn7FGMbQVbn1zD37hHSHgvqtxOeld0MF5r5UXShS
 bbpdsJn2WkwvVTMPUQ+Th7X/0xvrCeDQMsx79Y2xN3ayaCmnoB4+b3YgqSF49hqzvO8Y
 gYm/pj3Aa7HjB4UaNrzAX78dH+5fdJueT6UYIUjrdsTrntIBG51quIQWSzghk2tjQOyR
 QzGSosinDhkLgR9U1DPka+FSyqor+iTtOcahV2PAm52lqDxMVc5ST4+nQTd5UasHVO6j
 kkj6wZm/pWT6vPfL31TiEEm46L+0Dj8yMM52s52dT8iOgbM1czcK2agkli8Fflctb32V
 hEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637209; x=1784242009;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LJMDbq8JWG8gLM228rAF9jWVRS2ybdRS1PCkN7Sa25I=;
 b=atfyngKGqr/K51J+rVK4flTBklPShGCVynZ6SDt1LRqPSnU3Lwq3SqOSOMC2e+ft1d
 51pmRxfeLFw33i37ZYJrMZR/7gsklJrK3PUVFkusL3d3lof6rdVd1WcN16e6O1UtkUzk
 SccD8iDF0vokVd0QfnOUUIV7haRjuRWdwOOLv+sRHDYAE4jZmZugfk06sMNsD1fFabn7
 po4u94Mo5DwerPmSeA+v5UcpwwnQ2R8E1ehvXPl7LEpqTbgsrfF6RZXJPKtz4hzVkO13
 yU6tfQk9U2a9Oy4spEbE+Nc9HxXuXwi0cmPBzaFPXWhh0E9+IoR0EDFwkAH+H5PnnkCf
 K9zw==
X-Gm-Message-State: AOJu0YyZyIu70L9VGZ4wI9Md3WXSVQL6rdVLP5c+s/85l8Nf0Sw3F5DP
 FWuXUflNsi3eKV5CcjXWZTlMfDInq5SypqQxJy2LNbmV3gPdbG03OFRH
X-Gm-Gg: AfdE7cmZgG+TsxyaiCjPEL0SgHubynv5tX64r5/nBZRhvCpVtaH0t991ZLW5JjFM42v
 zlsmCvnxsrj7LPsi9R0uhovkgWm4OtEiyqKXEDZyYeqomZbuT1oFfCYk9nH04Ua2oxPEaXMhLv2
 Jkc3d1z1uVSR9mwEx1XkPzpS/bC0q+YFn8Umq2zzPMgn1yVGYxvPc3sOB5pSmNd9bXkponHVv6l
 30FL1N2tc0R5j0coxmYNe+zSRoSYWca/MNNyMEIyT/ZZzPE0v2My4+xiu0a5lb3nxyl3idMsdKS
 V35+Yeter2zhEB7N9IHAlHCI0FpUAEomnhmwebu1sv5rGrxOvv3MQvfnQBAa1Vwf0Cb6+ZrZdIR
 rUhnBycHbK+d409n984CN8RCuRR2UIi8NG2rBa+0MG+Ym5JxjsnGv+BSmZwkfxGZEiO6RALl8Iw
 0IF5cUIM6JEhkOx9l820X/HlFu7cRl6mmFT0HSliVR1J740jh+eCeWa/sXI8/yoOv08M53ZY1vv
 /2xE5J6zh8tsk297DjaizH2gcX4k1B3sSuYgHVYyHHb1HkAZxiFLzYt7JP7h88d
X-Received: by 2002:a05:6820:1612:b0:6a3:7c8b:a6f2 with SMTP id
 006d021491bc7-6a37c8babe2mr3379989eaf.45.1783637208569; 
 Thu, 09 Jul 2026 15:46:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm3310749fac.11.2026.07.09.15.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 15:46:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 00/10] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Thu, 09 Jul 2026 16:46:22 -0600
Message-Id: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TW1CiWe/A/DoZQtrBFq2tpoC
 P9ugbvJXF4yb2aGQJ4pwLWYwVPiwG7KcD4UYAY99YTcZQYpZCWUkBje7cgRDeFuYpJ40Uq1JyV
 MVRvI5suT5c+2em92ztqDTFyn1sbAITr/3W6TXHv/H3IEWtvpsqWurLW99aPm59G4EZplWX5eN
 Md+yAAAAA==
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
 Jerome Forissier <jerome.forissier@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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
Changes in v3:
- Rebase on U-Boot master.
- Add review tags from Svyatoslav Ryhel and Simon Glass.
- Simplify the AES decrypt helper guard and validation flow.
- Document the AES provider in-place CBC decrypt contract.
- Tighten SPL encrypted-FIT buffer handling and error reporting.
- Clean up the SPL DM hash fallback and Kconfig help text.
- Link to v2: https://patch.msgid.link/20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com

To: Svyatoslav Ryhel <clamor95@gmail.com>
To: Ion Agorria <ion@agorria.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Anton Ivanov <anton@binarly.io>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Francois Berder <fberder@outlook.fr>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Randolph Sapp <rs@ti.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Francesco Valla <francesco@valla.it>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: E Shattow <e@freeshell.de>
Cc: Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lucas Dietrich <ld.adecy@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>

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
 boot/image-fit.c                                   |  85 ++--
 cmd/aes.c                                          |   8 +-
 common/spl/spl_fit.c                               |  75 +++-
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
 drivers/crypto/hash/Kconfig                        |  13 +
 drivers/crypto/hash/Makefile                       |   2 +-
 drivers/crypto/tegra/tegra_aes.c                   |   7 +
 include/image.h                                    |  39 +-
 include/u-boot/aes.h                               |  10 +
 include/u-boot/ecdsa.h                             |  22 ++
 include/u-boot/fdt-libcrypto.h                     |   6 +-
 include/uboot_aes.h                                |  40 +-
 lib/Makefile                                       |   2 +-
 lib/aes/aes-decrypt.c                              | 104 ++++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++++---
 lib/ecdsa/ecdsa-verify.c                           |  39 +-
 lib/fdt-libcrypto.c                                |  60 +--
 tools/image-sig-host.c                             |   7 +
 39 files changed, 2364 insertions(+), 194 deletions(-)
---
base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

