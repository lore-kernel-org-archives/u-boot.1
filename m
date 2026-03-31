Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A48C109B464
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 13:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CF283DA6;
	Tue, 31 Mar 2026 15:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TIIBsT89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B8684011; Tue, 31 Mar 2026 10:10:23 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0282D83DBF
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfb723793so1237396f8f.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774944620; x=1775549420; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NNYYRz/5uEQDjcGONCxhSYsVP23SxxdQszr6+bgYWQ0=;
 b=TIIBsT89t7pnKAg6tLeYuhigmxCDkSw1mNxi7g4LKchMC8HEKo1SZ8lc3C+QP1zrFM
 nkXRxeHqaOFxN3YuM4FgH45kjaDXcnd7xi+cgR9HxNxrK3kdmPbIQWEXzhPIk4LlBP7D
 4Wozx+RVrqP0KSZy+iJaYTd71E/aS0Hpz7jC4PBRHZlxbTdqZ23//YzCbGrI4dQV8R6t
 oXCgp0qRoPS6nS5eamIonT47QNUi0qTtGwa/SPQKDdWTjmrP4x2QHU8nofoI5bPJeS23
 NoBJkBma+qDvFg0/vY8+zu4bBAyCzl9KTRLhCi7KgKxMJvNGGdiQ3sezLLIGin49ihEG
 7iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944620; x=1775549420;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNYYRz/5uEQDjcGONCxhSYsVP23SxxdQszr6+bgYWQ0=;
 b=AKG5d8u4hSAYj1pW8X4Ji0WvbyEzai3nOO6qt4Ai0IY+pcOzP0uLU6djbJWajJQYHP
 gtXKxpkzXEvPIlJr2/K65XIXuxlxAPZ42+pwUsBAKpifKdBMkPeCQdnFT46TFUbkp2nZ
 Ui5L4xn0ttlAXL7rcsb3cupLBblY5vC0CZz7TB4jTG17MsrArUupCqPtq/xhGmcMSPo8
 n56rcCWdXwNhgB5xFKkLSIjG88RQ/nR1Yr8f7JRYjLnd4iruuOuj9vpUHK8Qb61zP2Mj
 gq6mY+J7GEmusddd+jGcF7KvQtpTWQtLdmj5ds6WcYDe/DNBcqa3wM6xKXHHqZohXbol
 lhsg==
X-Gm-Message-State: AOJu0YwMNyGOOIkdMQnPatLS/FhDmz6WRxgemw0RjEF1u54Yc2CkkWvQ
 6lGKD6mWBzaUPQEI67H+LNSLbRBXt9aBp+5G7RUCgfhR5INdLMV6uNs8nixBN0G3
X-Gm-Gg: ATEYQzx98dUpIeh8SG5mHLLXv8nySaI7m4l0U8gff2LOh8/3Q7w6RFUQoyfjhFR2kLz
 FuAhczJRwqvgLL4K2RUMLi0IA6CEZArMETnrewWxsOK9oHsy9HkX/jsgxH1dXrc5kDsiZzAOL5h
 Vdpk7sWhyN7C8r05kTEnfTuA4HPvv4SYNiwRNhOBdyHpShDl2LBFFllgZ4fmX9pOfehN6gZQMnX
 fl1aqvSBaXyRITxbFGLaoUOZvGEaAUn2baDa6iY6i87x4qgwLm9xdKBQzWXDdz4vNhLWvqxpJeC
 KwvGwPWMrmtyFbACJnKQc8Wnbam3aPv3k/XsupEvQY8kWXXaMK7I52sjJM6jyWZ01LuTDNePkJj
 ROT/kYHU6Eeaw+KnJG/WZF5Z13kMdgc62YMqz1YY5g4XBxQMJ/xNu18q1duV6tOUTXMZZp/jzPo
 jxqhYmoJFlm1WkOAa+EKElBBqWeDZ4KQGKkCtQKFXvuILbLEeLO4s+76WUxK/tIOiLJ3NIg1RVg
 hPTp8vXW7UbQQk+XPmJ45RLVTcfsLfWBHuG41IgRXWN9v6H2n4phFfd/HRbI/CBvdbi+1G3x/Mi
X-Received: by 2002:a05:6000:2283:b0:43d:934:82 with SMTP id
 ffacd0b85a97d-43d093400c4mr3829363f8f.21.1774944620028; 
 Tue, 31 Mar 2026 01:10:20 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf257cbc3sm25038614f8f.35.2026.03.31.01.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 01:10:19 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Tue, 31 Mar 2026 10:10:10 +0200
Subject: [PATCH] board: toradex: Quote variables in `test` cmd expression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
X-B4-Tracking: v=1; b=H4sIAGGBy2kC/x2MywqAIBAAf0X23IIP8tCvRAfTtfbQA5UopH9PO
 g7MTIVMiSnDICokujjzsTdQnQC/un0h5NAYtNRWGiMx8o2FckG/BaTtLA86beeeYjRWKWjhmah
 Z/3Sc3vcDR7lEQmQAAAA=
X-Change-ID: 20260330-fix-test-cmd-empty-a26b5eff3611
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 31 Mar 2026 15:08:26 +0200
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

From: Franz Schnyder <franz.schnyder@toradex.com>

With correct POSIX handling, unquoted empty variables can turn the
expression like
	test -n ${fdtfile}
into
	test -n

The POSIX handling for single argument `test` evaluates it as true,
so the fallback initialization will be skipped unexpectedly.
Quoting variable expansions in `test` expressions will always result in
correct behavior for empty and non-empty values.
This change was triggered by
commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
The aim is to have a less fragile codebase that is not dependent on a
quirk of the shell implementation.

Use quoted variable expansions in `test` expressions throughout.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/aquila-am69/aquila-am69.env   | 6 +++---
 board/toradex/smarc-imx8mp/smarc-imx8mp.env | 2 +-
 board/toradex/smarc-imx95/smarc-imx95.env   | 2 +-
 board/toradex/verdin-am62p/verdin-am62p.env | 6 +++---
 configs/apalis-imx8_defconfig               | 2 +-
 configs/apalis_imx6_defconfig               | 2 +-
 configs/aquila-am69_a72_defconfig           | 2 +-
 configs/colibri-imx6ull-emmc_defconfig      | 2 +-
 configs/colibri-imx6ull_defconfig           | 2 +-
 configs/colibri-imx8x_defconfig             | 2 +-
 configs/colibri_imx6_defconfig              | 2 +-
 configs/colibri_imx7_defconfig              | 2 +-
 configs/colibri_imx7_emmc_defconfig         | 2 +-
 configs/colibri_vf_defconfig                | 2 +-
 configs/toradex-smarc-imx8mp_defconfig      | 2 +-
 configs/toradex-smarc-imx95_defconfig       | 2 +-
 configs/verdin-am62_a53_defconfig           | 2 +-
 configs/verdin-am62p_a53_defconfig          | 2 +-
 configs/verdin-imx8mm_defconfig             | 2 +-
 configs/verdin-imx8mp_defconfig             | 2 +-
 20 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/board/toradex/aquila-am69/aquila-am69.env b/board/toradex/aquila-am69/aquila-am69.env
index f8b7363dcf5..ac2828e0b58 100644
--- a/board/toradex/aquila-am69/aquila-am69.env
+++ b/board/toradex/aquila-am69/aquila-am69.env
@@ -21,21 +21,21 @@ dfu_alt_info_ram=
 
 update_tiboot3=
 		askenv confirm Did you load tiboot3.bin (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x0 ${blkcnt};
 		fi
 
 update_tispl=
 		askenv confirm Did you load tispl.bin (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x400 ${blkcnt};
 		fi
 
 update_uboot=
 		askenv confirm Did you load u-boot.img (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x1400 ${blkcnt};
 		fi
diff --git a/board/toradex/smarc-imx8mp/smarc-imx8mp.env b/board/toradex/smarc-imx8mp/smarc-imx8mp.env
index 58f152e6b51..1480db8e5fc 100644
--- a/board/toradex/smarc-imx8mp/smarc-imx8mp.env
+++ b/board/toradex/smarc-imx8mp/smarc-imx8mp.env
@@ -13,7 +13,7 @@ scriptaddr=0x50280000
 
 update_uboot=
 		askenv confirm Did you load flash.bin (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt
 			${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x0
 			${blkcnt};
diff --git a/board/toradex/smarc-imx95/smarc-imx95.env b/board/toradex/smarc-imx95/smarc-imx95.env
index b94250bbc52..35d26b7cfba 100644
--- a/board/toradex/smarc-imx95/smarc-imx95.env
+++ b/board/toradex/smarc-imx95/smarc-imx95.env
@@ -13,7 +13,7 @@ scriptaddr=0x9c600000
 
 update_uboot=
 		askenv confirm Did you load flash.bin (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt
 			${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x0
 			${blkcnt};
diff --git a/board/toradex/verdin-am62p/verdin-am62p.env b/board/toradex/verdin-am62p/verdin-am62p.env
index f8b7363dcf5..ac2828e0b58 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.env
+++ b/board/toradex/verdin-am62p/verdin-am62p.env
@@ -21,21 +21,21 @@ dfu_alt_info_ram=
 
 update_tiboot3=
 		askenv confirm Did you load tiboot3.bin (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x0 ${blkcnt};
 		fi
 
 update_tispl=
 		askenv confirm Did you load tispl.bin (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x400 ${blkcnt};
 		fi
 
 update_uboot=
 		askenv confirm Did you load u-boot.img (y/N)?;
-		if test $confirm = y; then
+		if test "$confirm" = y; then
 			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
 			mmc dev 0 1; mmc write ${loadaddr} 0x1400 ${blkcnt};
 		fi
diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 6ab4dd3dc57..17090ac682b 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -25,7 +25,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-apalis${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-apalis${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_LOG=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index cd9811aca61..791be4df283 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -31,7 +31,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1055
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/aquila-am69_a72_defconfig b/configs/aquila-am69_a72_defconfig
index 0f85b228b06..0237a703813 100644
--- a/configs/aquila-am69_a72_defconfig
+++ b/configs/aquila-am69_a72_defconfig
@@ -34,7 +34,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am69-aquila-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am69-aquila-${fdt_board}.dtb"
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 439ddeb8f0b..c54ff48fdf7 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=547
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index 1c400f9534d..cda7a6ada3a 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -21,7 +21,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot || run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=547
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index fd6a6b47fcf..3300922b172 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -26,7 +26,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_LOG=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 0f5abb51f76..34037e1c134 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -30,7 +30,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6dl-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6dl-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1056
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 2a3cb84c3b6..8a84f49f42f 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot ; echo ; echo ubiboot failed ; run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb "
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb "
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index a95a3214d0c..4c661d4cda1 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -19,7 +19,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 1364fe45291..4ce14baef4f 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -23,7 +23,7 @@ CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ubiboot || run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=1056
 CONFIG_LOGLEVEL=3
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 13a0e5f028b..7be67df3130 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -40,7 +40,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mp-toradex-smarc-dev.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx8mp-toradex-smarc-dev.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_LOG=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index ad908949b59..4faff7977df 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -37,7 +37,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx95-toradex-smarc-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx95-toradex-smarc-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_LOG=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index f04858099da..3f3cd2a53b1 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -34,7 +34,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am625-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am625-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index 3dbffa78662..6cca7427485 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -36,7 +36,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_BOARD_SETUP_EXTENDED=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 45437205837..88f337bd347 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -33,7 +33,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mm-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx8mm-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_LOG=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 99749c50194..ca815b9de78 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -42,7 +42,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mp-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx8mp-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_LOG=y

---
base-commit: d9eee3d17882ec40f8ca5e231046bbf287ab4369
change-id: 20260330-fix-test-cmd-empty-a26b5eff3611

Best regards,
-- 
Franz Schnyder <franz.schnyder@toradex.com>

