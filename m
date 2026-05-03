Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7552FF886F
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2745783FEC;
	Sun,  3 May 2026 22:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZYiGuuLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B4BD84198; Sun,  3 May 2026 22:49:54 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C4283EF9
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6966d16b978so1235962eaf.3
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841389; x=1778446189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z0nlokKnLCj+yZaZKHoGJmX/VPrJf957nzaTBny243U=;
 b=ZYiGuuLx5ASIMZYEfRZDbTP/SMuJqWIvfR1hVlqizUFCXWljGKBtp2QAeJ7w83XdnX
 J6r048UhX52WN64t3c2jn1lhheZpLCzsG4ktaO4fsKEGYEU+HOz79kWJoXfNCHejsRyl
 rs4fAqNgVsTjhjwAKsQn2qQ4Mo9NyXFieYV/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841389; x=1778446189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0nlokKnLCj+yZaZKHoGJmX/VPrJf957nzaTBny243U=;
 b=SVW/bC82sCeuDL0TTi1yWf8RCm5PIVrE8F+JIc3bHQXosRda055BX4ajeBNHkzSUEQ
 1QwLoTGgTTjfKMq3kSCXnH9uQK2wRR7SbHTPAGT7RFAAHrk/ZnSViywQ4vio2KuTej/u
 EpamsS17s5IBjmU5tHEHLHtIBsvm6eebitWKur3xtRsRSBMuWcWCL1JawD8VrMv/8I0V
 W9voI59oTBdKGVAO1dDob7uIUTEG8j+Fbkqi1Rqzn5PpTC9SQYdvXQtufOVUeWS8V+7A
 e1Va3p0/jLjsRLJFPdNxVK2CMC+daSR8mpeGZ9i3OC+1pLBhsx4odsYs3DEzBQPDhyMx
 noiQ==
X-Gm-Message-State: AOJu0Yx4eBX7EnflM60Ppr98aLCo1EjetGoBjRSVPSv+IrXEDb2APATB
 7aQ8Sd9fFwOMYmkUeicZJM8Dfk7CYYExQ4aS3sjr81IzpqPgND+eQX7VbaNncR3c7qZj87BscYo
 zsofSyw==
X-Gm-Gg: AeBDies4uN4uiWN2L6r70eXR6vqfxBQiH+7Ye3Z2cic5CgrlA4uSoaM+fpcViMPBUTg
 CVr1WFmcoZfOZMsvEaBD6Tr+hlahoTNc2AJlVpmCzMFU+NQmFmdMC5fA2SBIBYn+etjyfUeSfd4
 W109MWu2AnTB98KpdNK7z8qxs7pgZVcYBp0fyDrDmH0S+NkKM0A8DXQ1zjKsryXRIGpQLQy40JB
 1hfFQT9cow7F8WADlH9ELRP5NA/jllTbm0875gvF9BtpgXMLCb/CIbVSAnVgLclWN6Hei8mMcoP
 PIYB7wV0jJmqINLSf10j1LS3pfsoERcBMb9ejusWovaX6oFVHp/gtZRbTaOiHdpUtOG9heBHKwB
 Xnl1z7K5YkBf34phlf+dGGWSKi2WuwjM7cH40kc7VfA4CxfaDKOwt5XYVTRswH1Sa/Bt4xwaDnk
 DCIPcDkstZFXlhtj/yrbdvUPEGVb8X
X-Received: by 2002:a05:6820:906:b0:696:1a25:fdc9 with SMTP id
 006d021491bc7-69697c6545fmr3174703eaf.28.1777841389320; 
 Sun, 03 May 2026 13:49:49 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:49:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, Cyril Jean <cyril.jean@microchip.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Heiko Schocher <hs@nabladev.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <lukma@nabladev.com>
Subject: [PATCH 0/6] test: Quote variables in 'test -n' expressions across
 boards
Date: Sun,  3 May 2026 14:49:18 -0600
Message-ID: <20260503204936.3151124-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Several boards use 'test -n ${var}' (unquoted) in env scripts to
detect an empty variable and trigger a fallback or skip a hook. That
works only because of a U-Boot 'test' quirk where calls with argc <
3 returned false; an empty variable made the expression 'test -n'
(one operand) and hit that path.

8b0619579b22 ("cmd: test: fix handling of single-argument form of
test") aligned 'test' with POSIX so those expressions flipped to
true.  f7e7c55e53e8 ("cmd: test: add bug-compatibility special case
for 'test -n'") restored the old behaviour for the exact 'test -n'
(one arg) case, so the boards are not broken at runtime today, but
the reliance on a bug-compat path isn't great.

This series updates various boards to quote each affected variable so
the emptiness check is explicit and does not depend on the
special-case path.

Each commit carries a Fixes: tag pointing at 8b0619579b22


Simon Glass (6):
  toradex: Quote fdtfile in preboot test
  ti: Quote board_init in ti_common.env
  siemens: Quote A/B flags in env tests
  beaglev_fire: Quote no_of_overlays in design test
  mccmon6: Quote recovery_status in bootcmd test
  aristainetos2: Quote rescue_reason in rescueboot test

 configs/apalis-imx8_defconfig          |  2 +-
 configs/apalis_imx6_defconfig          |  2 +-
 configs/colibri-imx6ull-emmc_defconfig |  2 +-
 configs/colibri-imx6ull_defconfig      |  2 +-
 configs/colibri-imx8x_defconfig        |  2 +-
 configs/colibri_imx6_defconfig         |  2 +-
 configs/colibri_imx7_defconfig         |  2 +-
 configs/colibri_imx7_emmc_defconfig    |  2 +-
 configs/colibri_vf_defconfig           |  2 +-
 configs/toradex-smarc-imx8mp_defconfig |  2 +-
 configs/toradex-smarc-imx95_defconfig  |  2 +-
 configs/verdin-am62_a53_defconfig      |  2 +-
 configs/verdin-am62p_a53_defconfig     |  2 +-
 configs/verdin-imx8mm_defconfig        |  2 +-
 configs/verdin-imx8mp_defconfig        |  2 +-
 include/configs/aristainetos2.h        |  2 +-
 include/configs/beaglev_fire.h         |  2 +-
 include/configs/draco-etamin.h         |  4 ++--
 include/configs/mccmon6.h              |  2 +-
 include/configs/siemens-am33x-common.h | 12 ++++++------
 include/configs/siemens-env-common.h   |  8 ++++----
 include/env/ti/ti_common.env           |  2 +-
 22 files changed, 31 insertions(+), 31 deletions(-)

---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
branch: env-test-us

-- 
2.43.0

