Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB672C88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 23:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8140480DC2;
	Sun, 13 Sep 2026 23:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEQfLdoT7VOE; Sun, 13 Sep 2026 23:20:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B7A1780CEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789341611;
	b=AR55xIbBxB1rTLEi3ubow6vMN1gAYK29IkW91biwtQ9NracsRWowExuugRFniG5hucdR
	 CuNqy6aRJWdAibVayY8RRCkinC9ogh10nzTj5bqN/J7qi+r/2GNiKPYg5cvq184Pe1mzB
	 cHnIgSdTZpbrqd16+s/WjbdYGVIQ2ycJ4bXJFS6AZtZVOASni29yq8wGZHaTNHY0qeXzN
	 qPaSuprnYwJNhQgQw9R589f0QDclkPSo1Jk7exK15GvPpGtImoa5uzztqW0KXjSlSM2ec
	 D5bHxmV608lg/iveQ/aNoM0vrDoknmoXF51RLNAevsvE3hbAccqA6maLe09EOOiaOsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789341611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IyTaF5Vi0j4XSorhL5BMwuwioiLrEHisUGOyV55m4mo=;
	b=leVLCOhIT/KpZADki67BWaPPVA/UxSAFi6ryoRjKOMdJvT0Am7Sn81Y9FE0BguLaDKZI
	 3hX4TJb0eCHX2N61xPqPMUkdtJr0mASCm99XtjWxG4RgcU1ydqjHK9cWeEA6HxQ1oZC/z
	 /K6PDP7gQ1N3ObkHWg5M7i83Idf2ppir1OKF9qsRlHAfYTAMXBmzM8k5yPzzq127oRA2u
	 Qm8FevyyqDPs3hTfwm27v92mD769ep5E/uID0K9Ub6SjqVdVcW+zUwjLtLbfIUtF8x8Py
	 QKpM/ApdyRTLwC55zl/n+r5IJM8Fg3BJAO4pteb7HDMGZuTu4PAzdUJnmX4JL6z1o4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789341611;
	bh=IyTaF5Vi0j4XSorhL5BMwuwioiLrEHisUGOyV55m4mo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BOEK+8OlBY223nh2M7HDbY/Jc2UHKsDflG0Q4tnVoToiq4P2ZJRbTw8vG4t2Nh5Ol
	 a+AQjjiCfEEJfIlcUawXd1x56WfhE1Y7dCohhZrlk6FIul1NCIJqcy/+h/AtYeBLsD
	 1BMhKMhxgdLDoSex9YlqfXrWw5peMk05SuUCp9+ldHrM9MK4wuxniQ/wGMaP13Kzeh
	 ytX7TSPOjW2voEQtA84G0FSh4DCJpifc/OBTmF6nuzWh1NdKATMwJnJsuT3oI7osWi
	 M+sbK5FKeeYlfQKuEtB/M2o4Ynx/RHwBunV2qDsRX8DnmhZfM2g26VBoHKSYrr9/5n
	 AA7Vdl9n/8DOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7A1780CEA;
	Sun, 13 Sep 2026 23:20:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A28D423F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9444740599
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-6nQ6HUwNYm for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 15:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 339244058C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789314769;
 b=Y6+DiJqQDbBUUz20PHoyb0lNbxgGA+rORQ1kVYDmiOWiEN9Grg7siV2JPROEkEn72xwJ
 3N0N08xs1+xVA+uZBgR3tnEiDNtIk1+bMmdT+Il+zza6O9F3jtW9HfWVEQyC/FDt2ER9+
 sJzd4lu/0/bp7w1C+YaDDqjpeFAxxq/hX/X2uiR5LUM5USlVl6sp1ylfwYnncw64AXY48
 IkGJuTzmkQt43lrL33shVVN6UtfxDm5xw+KOpoegWnTDiuNmZXH4dsEM0Nk59b5FDvJaW
 lHaTdZhxNItGU4ZDsz+YYy1XIvmvWQJZqLwPUVIdpEb/hY+bGVaETqfI9wM4L/5OT0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789314769;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=IyTaF5Vi0j4XSorhL5BMwuwioiLrEHisUGOyV55m4mo=;
 b=MzZLXKLg+6ga/AYevm5j+Pr1pVPCY1LsNelAzM27U4MadSH6xEUL7XWSn2T/d/Htn0DX
 62Y93GD1zUDvBz1wMEtXxXa0ufGAgpCMQUY4/9hBwLSYZnONpFyjKloeG1NKo2oOXRCCN
 GQ/1H/4rZUQV9D+gw6kbbRAY+bjpc0Y8klr+943OGVM3e0mM+IqI2d52W3jQdz103XYEp
 IZIK+RAKK+exBAidumRjUdjzxwPPYMXPQgqoXa37qSe+/05LV3jFTLOts5ba1t2LNZa5i
 7UEGzG5TlO96I6eSjPiFF0PQt7zVKUcFzuLToeIEZRn4mtoaKQ3GTWc71G+YnCeyaKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="i/ACgDkE"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com;
 envelope-from=aford173@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=i/ACgDkE
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 339244058C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 15:52:48 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-9103f5b813aso18191286d6.3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789314767; x=1789919567;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IyTaF5Vi0j4XSorhL5BMwuwioiLrEHisUGOyV55m4mo=;
 b=i/ACgDkEgnXKt5fAMWZCnky+A2xlbUr/wbnfMkzt3eGZx2qAHgw8KHkz3avrc9AynG
 2lI/vdeDB3vSYFeywR4IINaZ57a0435seCk9P2DAx0+TLODHCq7YyzmcL7+0Qw8DYFgO
 KYvlq9o2cTO4ir3GdhNPRMF7h0h8f6zv0Mvsdk5dCw68E1AHUUlKx7TuUv2UuGSKKrqT
 kZoT+HlwPybqGAo+6PM0u+41kdfU5qHhAxLGbiL39IC3NDEbpD/ezgCCigAcF2Z5MPbd
 Cu5KZVW+YOUGmShDRSrBKu2bHVNzYqAeWDEKSap8usqt8Rt/GMskffa6y4sI7rYi9g0u
 N0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789314767; x=1789919567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IyTaF5Vi0j4XSorhL5BMwuwioiLrEHisUGOyV55m4mo=;
 b=aLCqgYlJd+21ItcqwlSnKew6C+NRVZMiWhdau81GJvdLYtT3inm/CTJoTCJdbqG6LZ
 2VcfZqsycOSXV1erEhputfwQEbPM1grr+zNqnEflAgQGJDLVfYxbkFoSih5anyY0IF9n
 MLSm1y0NcicWWtii+nutac20VDYqkEqjPjB9ldx5aGHYx7A+jMnh0tiy8fEaS0EK6RM7
 E7qUg4r+38ziJCNxWxw2IduCZDfNjBGEmiOgB8IO0WR9U/QbJpsjVTUCC4tFYLdjmY5a
 u0VJRQuDVfIQb72Q8alj489IkgpNOON0ZTaryPqyuUzgeKiSoEeD1uYazt4lZhNe6CCj
 bZHA==
X-Gm-Message-State: AFuF++k64vCpqKLlHQ9VarlMOUjGLIvs9j0pzvGBhFAmgvM+ZoTfDZ67
 lWYL4nbOPBuiy/QxOUPZv9TxAasjYaNkaIbwAsWYReC+IUvak0lPZVVb2utawg==
X-Gm-Gg: AYBFou0kp8jaA5FKDSQnABNBoAqVHwzkBt3rIOXjFAR9l+m97cqY5tIfiVY8Iq7RhKv
 tERJDbM4ox0o/Xxa23vckKlYAO+Wch84GPIAWL8m1lNGwjA26TOIiKOxWYJA38HixhfHUHwn8pE
 v2TiwFJJ5fLAAvx+Tn4/LjXQyho7WhapeH9FTnfox31PB2KQ/tWFscubcHH+qCGoxERaFX7cseC
 KrIVcqEslFqcy3FZCzbP8Klwvjrc1nyk1KfDEoIEIDQjwrtJrbGiqdVY1vu4B4dUFjGMch+/dSy
 BBSC02uwvhoFuwjjMmqyc80E2HnKV2EcBaa7JROOWb5hqINwj4eWM9QY4sYRPkwaJhbCu1Gdg4N
 2Rf5O5gQPI6bB2E7TcgPGKXNSwWSNzQBRWP3uotasZ95KRao0M8j+lZEYsOltRjP3JB2qQ2tTGi
 eo5qzPPjRPz8Sd27A6kFwrms+toOUdg7Tb86kBmq7vh3XseuRp9uwkD70sUEF3erchjPWSNiAzb
 5FGJtc9byCAiW39J7O8/sruV5mDvS0WLsSlOYkCuAm6tdNEFvDa
X-Received: by 2002:a05:620a:288b:b0:939:8856:d8d9 with SMTP id
 af79cd13be357-939ea27cc52mr1739814885a.41.1789314767018; 
 Sun, 13 Sep 2026 08:52:47 -0700 (PDT)
Received: from aford-System-Version.lan (c-73-94-212-116.hsd1.mn.comcast.net.
 [73.94.212.116]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e803dc90sm759283185a.17.2026.09.13.08.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 08:52:46 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>
Subject: [PATCH] board: davinci: Remove DA850 EVM support
Date: Sun, 13 Sep 2026 10:52:42 -0500
Message-ID: <20260913155242.84148-1-aford173@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 23:20:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Remove the TI DA850 EVM board support along with its defconfigs,
config header, U-Boot device tree overlay and Kconfig target. The
OMAP-L138 LCDK continues to live in board/davinci/da8xxevm, so only
the DA850 EVM specific pieces are dropped and the shared README files
are updated to no longer describe the EVM.

The SPL linker script in the board directory is kept since it is used
by every DaVinci board.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/da850-evm-u-boot.dtsi    |  45 ---
 arch/arm/mach-davinci/Kconfig         |   7 -
 board/davinci/da8xxevm/Kconfig        |  28 --
 board/davinci/da8xxevm/MAINTAINERS    |   9 -
 board/davinci/da8xxevm/Makefile       |   1 -
 board/davinci/da8xxevm/README.da850   |  23 +-
 board/davinci/da8xxevm/da850evm.c     | 433 --------------------------
 configs/da850evm_defconfig            | 116 -------
 configs/da850evm_direct_nor_defconfig |  95 ------
 configs/da850evm_nand_defconfig       | 119 -------
 doc/README.davinci                    |  29 +-
 drivers/mtd/nand/raw/Kconfig          |   1 -
 include/configs/da850evm.h            | 172 ----------
 13 files changed, 6 insertions(+), 1072 deletions(-)
 delete mode 100644 arch/arm/dts/da850-evm-u-boot.dtsi
 delete mode 100644 board/davinci/da8xxevm/da850evm.c
 delete mode 100644 configs/da850evm_defconfig
 delete mode 100644 configs/da850evm_direct_nor_defconfig
 delete mode 100644 configs/da850evm_nand_defconfig
 delete mode 100644 include/configs/da850evm.h

diff --git a/arch/arm/dts/da850-evm-u-boot.dtsi b/arch/arm/dts/da850-evm-u-boot.dtsi
deleted file mode 100644
index 309130479a5..00000000000
--- a/arch/arm/dts/da850-evm-u-boot.dtsi
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * da850-evm U-Boot Additions
- *
- * Copyright (C) 2017 Logic PD, Inc.
- * Copyright (C) Adam Ford
- */
-
-/ {
-	soc@1c00000 {
-		bootph-pre-ram;
-	};
-
-	nand {
-		compatible = "ti,davinci-nand";
-	};
-
-	panel {
-		bootph-all;
-	};
-};
-
-&eth0 {
-	pinctrl-0 = <&mii_pins>, <&mdio_pins>;
-};
-
-&flash {
-	compatible = "m25p64", "jedec,spi-nor";
-};
-
-&mmc0 {
-	bootph-pre-ram;
-};
-
-&serial2 {
-	bootph-pre-ram;
-};
-
-&spi1 {
-	bootph-pre-ram;
-};
-
-&gpio {
-	bootph-pre-ram;
-};
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 8fa2660a0cd..2b84b7c4a7e 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -4,13 +4,6 @@ choice
 	prompt "DaVinci board select"
 	optional
 
-config TARGET_DA850EVM
-	bool "DA850 EVM board"
-	select MACH_DAVINCI_DA850_EVM
-	select SOC_DA850
-	select SUPPORT_SPL
-	imply OF_UPSTREAM
-
 config TARGET_OMAPL138_LCDK
 	bool "OMAPL138 LCDK"
 	select SOC_DA8XX
diff --git a/board/davinci/da8xxevm/Kconfig b/board/davinci/da8xxevm/Kconfig
index 34055f69754..633f1c54354 100644
--- a/board/davinci/da8xxevm/Kconfig
+++ b/board/davinci/da8xxevm/Kconfig
@@ -1,31 +1,3 @@
-if TARGET_DA850EVM
-
-config SYS_BOARD
-	default "da8xxevm"
-
-config SYS_VENDOR
-	default "davinci"
-
-config SYS_CONFIG_NAME
-	default "da850evm"
-
-menuconfig DA850_MAC
-	bool "Use MAC Address"
-	default y
-
-if DA850_MAC
-config MAC_ADDR_IN_SPIFLASH
-	bool "MAC address in SPI Flash"
-	default y
-	help
-	  The OMAP-L138 and AM1808 SoM are programmed with
-	  their MAC address in SPI Flash from the factory
-	  Enable this option to read the MAC from SPI Flash
-
-endif
-
-endif
-
 if TARGET_OMAPL138_LCDK
 
 config SYS_BOARD
diff --git a/board/davinci/da8xxevm/MAINTAINERS b/board/davinci/da8xxevm/MAINTAINERS
index 993b22f2f63..4ee7df12b72 100644
--- a/board/davinci/da8xxevm/MAINTAINERS
+++ b/board/davinci/da8xxevm/MAINTAINERS
@@ -1,12 +1,3 @@
-DA850_EVM BOARD
-M:	Adam Ford <aford173@gmail.com>
-S:	Maintained
-F:	board/davinci/da8xxevm/
-F:	include/configs/da850evm.h
-F:	configs/da850evm_defconfig
-F:	configs/da850evm_nand_defconfig
-F:	configs/da850evm_direct_nor_defconfig
-
 OMAPL138_LCDK BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
diff --git a/board/davinci/da8xxevm/Makefile b/board/davinci/da8xxevm/Makefile
index fe043d517f2..974c4a79ef9 100644
--- a/board/davinci/da8xxevm/Makefile
+++ b/board/davinci/da8xxevm/Makefile
@@ -5,5 +5,4 @@
 #
 # Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
 
-obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= da850evm.o
 obj-$(CONFIG_TARGET_OMAPL138_LCDK)	+= omapl138_lcdk.o
diff --git a/board/davinci/da8xxevm/README.da850 b/board/davinci/da8xxevm/README.da850
index 50ef401b7c9..f9c6b40ea71 100644
--- a/board/davinci/da8xxevm/README.da850
+++ b/board/davinci/da8xxevm/README.da850
@@ -27,11 +27,10 @@ loading the next image from a different media, etc).
 
 Compilation
 ===========
-The exact build target you need will depend on the board you have.  For
-Logic PD boards, or other boards which store the ethernet MAC address at
-the end of SPI flash, run 'make da850evm'.  Once this build completes you will have a
-u-boot.ais file that needs to be written to the correct persistent
-storage.
+The exact build target you need will depend on the board you have, for
+example 'make omapl138_lcdk_defconfig'.  Once this build completes you
+will have a u-boot.ais file that needs to be written to the correct
+persistent storage.
 
 
 Flashing the images to SPI
@@ -86,14 +85,6 @@ In this case the commands would be simplified to:
   U-Boot > nand erase.part bootloader
   U-Boot > nand write 0xc0700000 bootloader
 
-On the DA850-EVM, NAND can also be written with SW7:7-8 ON and
-
-  sudo mono sfh_OMAP-L138.exe -targetType AM1808 -p /dev/ttyUSB0 \
-	-flash_noubl -flashType NAND ~/src/u-boot/u-boot.ais
-
-To boot the DA850-EVM from NAND, SW7:5 should be switched on and all others
-off.
-
 Flashing the images to MMC
 ==========================
 If the boot pins are set to boot from mmc, the RBL will try to load the
@@ -127,16 +118,10 @@ to initialize hardware that's normally done by SPL.
 For this case, CONFIG_TEXT_BASE=0x60000000 which is the address to
 which the bootloader jumps when powered on.
 
-Example:
-For the da850evm, there is a defconfig setup to use the NOR flash on
-the UI expander board called da850evm_direct_nor_defconfig.
-
 Flash to NOR directly using
 sudo mono ./sfh_OMAP-L138.exe -p /dev/ttyUSB0 -flash_noubl
   -flashType NOR u-boot.bin
 
-SW7:5 through SW7:7 should be switched on and all others off.
-
 Recovery
 ========
 
diff --git a/board/davinci/da8xxevm/da850evm.c b/board/davinci/da8xxevm/da850evm.c
deleted file mode 100644
index 0011c828523..00000000000
--- a/board/davinci/da8xxevm/da850evm.c
+++ /dev/null
@@ -1,433 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
- *
- * Based on da830evm.c. Original Copyrights follow:
- *
- * Copyright (C) 2009 Nick Thompson, GE Fanuc, Ltd. <nick.thompson@gefanuc.com>
- * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
- */
-
-#include <config.h>
-#include <dm.h>
-#include <env.h>
-#include <i2c.h>
-#include <init.h>
-#include <net.h>
-#include <spi.h>
-#include <spi_flash.h>
-#include <asm/arch/hardware.h>
-#include <asm/global_data.h>
-#include <asm/ti-common/davinci_nand.h>
-#include <asm/arch/emac_defs.h>
-#include <asm/arch/pinmux_defs.h>
-#include <asm/io.h>
-#include <asm/arch/davinci_misc.h>
-#include <linux/errno.h>
-#include <hwconfig.h>
-#include <asm/mach-types.h>
-#include <asm/gpio.h>
-
-#ifdef CONFIG_MMC_DAVINCI
-#include <mmc.h>
-#include <asm/arch/sdmmc_defs.h>
-#endif
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#ifdef CONFIG_DRIVER_TI_EMAC
-#ifdef CONFIG_DRIVER_TI_EMAC_USE_RMII
-#define HAS_RMII 1
-#else
-#define HAS_RMII 0
-#endif
-#endif /* CONFIG_DRIVER_TI_EMAC */
-
-#define CFG_MAC_ADDR_SPI_BUS	0
-#define CFG_MAC_ADDR_SPI_CS	0
-#define CFG_MAC_ADDR_SPI_MAX_HZ	CONFIG_SF_DEFAULT_SPEED
-#define CFG_MAC_ADDR_SPI_MODE	SPI_MODE_3
-
-#define CFG_MAC_ADDR_OFFSET	(flash->size - SZ_64K)
-
-#ifdef CONFIG_MAC_ADDR_IN_SPIFLASH
-static int get_mac_addr(u8 *addr)
-{
-	struct spi_flash *flash;
-	int ret;
-
-	flash = spi_flash_probe(CFG_MAC_ADDR_SPI_BUS, CFG_MAC_ADDR_SPI_CS,
-			CFG_MAC_ADDR_SPI_MAX_HZ, CFG_MAC_ADDR_SPI_MODE);
-	if (!flash) {
-		printf("Error - unable to probe SPI flash.\n");
-		return -1;
-	}
-
-	ret = spi_flash_read(flash, (CFG_MAC_ADDR_OFFSET), 6, addr);
-	if (ret) {
-		printf("Error - unable to read MAC address from SPI flash.\n");
-		return -1;
-	}
-
-	return ret;
-}
-#endif
-
-void dsp_lpsc_on(unsigned domain, unsigned int id)
-{
-	dv_reg_p mdstat, mdctl, ptstat, ptcmd;
-	struct davinci_psc_regs *psc_regs;
-
-	psc_regs = davinci_psc0_regs;
-	mdstat = &psc_regs->psc0.mdstat[id];
-	mdctl = &psc_regs->psc0.mdctl[id];
-	ptstat = &psc_regs->ptstat;
-	ptcmd = &psc_regs->ptcmd;
-
-	while (*ptstat & (0x1 << domain))
-		;
-
-	if ((*mdstat & 0x1f) == 0x03)
-		return;                 /* Already on and enabled */
-
-	*mdctl |= 0x03;
-
-	*ptcmd = 0x1 << domain;
-
-	while (*ptstat & (0x1 << domain))
-		;
-	while ((*mdstat & 0x1f) != 0x03)
-		;		/* Probably an overkill... */
-}
-
-static void dspwake(void)
-{
-	unsigned *resetvect = (unsigned *)DAVINCI_L3CBARAM_BASE;
-	u32 val;
-
-	/* if the device is ARM only, return */
-	if ((readl(CHIP_REV_ID_REG) & 0x3f) == 0x10)
-		return;
-
-	if (hwconfig_subarg_cmp_f("dsp", "wake", "no", NULL))
-		return;
-
-	*resetvect++ = 0x1E000; /* DSP Idle */
-	/* clear out the next 10 words as NOP */
-	memset(resetvect, 0, sizeof(unsigned) *10);
-
-	/* setup the DSP reset vector */
-	writel(DAVINCI_L3CBARAM_BASE, HOST1CFG);
-
-	dsp_lpsc_on(1, DAVINCI_LPSC_GEM);
-	val = readl(PSC0_MDCTL + (15 * 4));
-	val |= 0x100;
-	writel(val, (PSC0_MDCTL + (15 * 4)));
-}
-
-int misc_init_r(void)
-{
-	dspwake();
-
-#if defined(CONFIG_MAC_ADDR_IN_SPIFLASH)
-	uchar env_enetaddr[6], buff[6];
-	int enetaddr_found, spi_mac_read;
-
-	enetaddr_found = eth_env_get_enetaddr("ethaddr", env_enetaddr);
-
-	spi_mac_read = get_mac_addr(buff);
-	buff[0] = 0;
-
-	/*
-	 * MAC address not present in the environment
-	 * try and read the MAC address from SPI flash
-	 * and set it.
-	 */
-	if (!enetaddr_found) {
-		if (!spi_mac_read) {
-			if (is_valid_ethaddr(buff)) {
-				if (eth_env_set_enetaddr("ethaddr", buff)) {
-					printf("Warning: Failed to "
-					"set MAC address from SPI flash\n");
-				}
-			} else {
-					printf("Warning: Invalid "
-					"MAC address read from SPI flash\n");
-			}
-		}
-	} else {
-		/*
-		 * MAC address present in environment compare it with
-		 * the MAC address in SPI flash and warn on mismatch
-		 */
-		if (!spi_mac_read && is_valid_ethaddr(buff) &&
-		    memcmp(env_enetaddr, buff, 6))
-			printf("Warning: MAC address in SPI flash don't match "
-					"with the MAC address in the environment\n");
-		printf("Default using MAC address from environment\n");
-	}
-#endif
-	return 0;
-}
-
-static const struct pinmux_config gpio_pins[] = {
-#ifdef CONFIG_MTD_NOR_FLASH
-	/* GP0[11] is required for NOR to work on Rev 3 EVMs */
-	{ pinmux(0), 8, 4 },	/* GP0[11] */
-#endif
-#ifdef CONFIG_MMC_DAVINCI
-	/* GP0[11] is required for SD to work on Rev 3 EVMs */
-	{ pinmux(0),  8, 4 },	/* GP0[11] */
-#endif
-};
-
-const struct pinmux_resource pinmuxes[] = {
-#ifdef CONFIG_DRIVER_TI_EMAC
-	PINMUX_ITEM(emac_pins_mdio),
-#ifdef CONFIG_DRIVER_TI_EMAC_USE_RMII
-	PINMUX_ITEM(emac_pins_rmii),
-#else
-	PINMUX_ITEM(emac_pins_mii),
-#endif
-#endif
-#ifdef CONFIG_SPI_FLASH
-	PINMUX_ITEM(spi1_pins_base),
-	PINMUX_ITEM(spi1_pins_scs0),
-#endif
-	PINMUX_ITEM(uart2_pins_txrx),
-	PINMUX_ITEM(uart2_pins_rtscts),
-	PINMUX_ITEM(i2c0_pins),
-#ifdef CONFIG_NAND_DAVINCI
-	PINMUX_ITEM(emifa_pins_cs3),
-	PINMUX_ITEM(emifa_pins_cs4),
-	PINMUX_ITEM(emifa_pins_nand),
-#elif defined(CONFIG_MTD_NOR_FLASH)
-	PINMUX_ITEM(emifa_pins_cs2),
-	PINMUX_ITEM(emifa_pins_nor),
-#endif
-	PINMUX_ITEM(gpio_pins),
-#ifdef CONFIG_MMC_DAVINCI
-	PINMUX_ITEM(mmc0_pins),
-#endif
-};
-
-const int pinmuxes_size = ARRAY_SIZE(pinmuxes);
-
-const struct lpsc_resource lpsc[] = {
-	{ DAVINCI_LPSC_AEMIF },	/* NAND, NOR */
-	{ DAVINCI_LPSC_SPI1 },	/* Serial Flash */
-	{ DAVINCI_LPSC_EMAC },	/* image download */
-	{ DAVINCI_LPSC_UART2 },	/* console */
-	{ DAVINCI_LPSC_GPIO },
-#ifdef CONFIG_MMC_DAVINCI
-	{ DAVINCI_LPSC_MMC_SD },
-#endif
-};
-
-const int lpsc_size = ARRAY_SIZE(lpsc);
-
-#ifndef CFG_DA850_EVM_MAX_CPU_CLK
-#define CFG_DA850_EVM_MAX_CPU_CLK	300000000
-#endif
-
-#define REV_AM18X_EVM		0x100
-
-#ifdef CONFIG_REVISION_TAG
-/*
- * get_board_rev() - setup to pass kernel board revision information
- * Returns:
- * bit[0-3]	Maximum cpu clock rate supported by onboard SoC
- *		0000b - 300 MHz
- *		0001b - 372 MHz
- *		0010b - 408 MHz
- *		0011b - 456 MHz
- */
-u32 get_board_rev(void)
-{
-	char *s;
-	u32 maxcpuclk = CFG_DA850_EVM_MAX_CPU_CLK;
-	u32 rev = 0;
-
-	s = env_get("maxcpuclk");
-	if (s)
-		maxcpuclk = dectoul(s, NULL);
-
-	if (maxcpuclk >= 456000000)
-		rev = 3;
-	else if (maxcpuclk >= 408000000)
-		rev = 2;
-	else if (maxcpuclk >= 372000000)
-		rev = 1;
-	return rev;
-}
-#endif
-
-int board_early_init_f(void)
-{
-	/*
-	 * Power on required peripherals
-	 * ARM does not have access by default to PSC0 and PSC1
-	 * assuming here that the DSP bootloader has set the IOPU
-	 * such that PSC access is available to ARM
-	 */
-	if (da8xx_configure_lpsc_items(lpsc, ARRAY_SIZE(lpsc)))
-		return 1;
-
-	return 0;
-}
-
-int board_init(void)
-{
-	irq_init();
-
-#ifdef CONFIG_NAND_DAVINCI
-	/*
-	 * NAND CS setup - cycle counts based on da850evm NAND timings in the
-	 * Linux kernel @ 25MHz EMIFA
-	 */
-	writel((DAVINCI_ABCR_WSETUP(2) |
-		DAVINCI_ABCR_WSTROBE(2) |
-		DAVINCI_ABCR_WHOLD(1) |
-		DAVINCI_ABCR_RSETUP(1) |
-		DAVINCI_ABCR_RSTROBE(4) |
-		DAVINCI_ABCR_RHOLD(0) |
-		DAVINCI_ABCR_TA(1) |
-		DAVINCI_ABCR_ASIZE_8BIT),
-	       &davinci_emif_regs->ab2cr); /* CS3 */
-#endif
-
-	/* arch number of the board */
-	gd->bd->bi_arch_number = MACH_TYPE_DAVINCI_DA850_EVM;
-
-	/* address of boot parameters */
-	gd->bd->bi_boot_params = LINUX_BOOT_PARAM_ADDR;
-
-	/* setup the SUSPSRC for ARM to control emulation suspend */
-	writel(readl(&davinci_syscfg_regs->suspsrc) &
-	       ~(DAVINCI_SYSCFG_SUSPSRC_EMAC | DAVINCI_SYSCFG_SUSPSRC_I2C |
-		 DAVINCI_SYSCFG_SUSPSRC_SPI1 | DAVINCI_SYSCFG_SUSPSRC_TIMER0 |
-		 DAVINCI_SYSCFG_SUSPSRC_UART2),
-	       &davinci_syscfg_regs->suspsrc);
-
-#ifdef CONFIG_MTD_NOR_FLASH
-	/* Set the GPIO direction as output */
-	clrbits_le32((u32 *)GPIO_BANK0_REG_DIR_ADDR, (0x01 << 11));
-
-	/* Set the output as low */
-	writel(0x01 << 11, GPIO_BANK0_REG_CLR_ADDR);
-#endif
-
-#ifdef CONFIG_MMC_DAVINCI
-	/* Set the GPIO direction as output */
-	clrbits_le32((u32 *)GPIO_BANK0_REG_DIR_ADDR, (0x01 << 11));
-
-	/* Set the output as high */
-	writel(0x01 << 11, GPIO_BANK0_REG_SET_ADDR);
-#endif
-
-#ifdef CONFIG_DRIVER_TI_EMAC
-	davinci_emac_mii_mode_sel(HAS_RMII);
-#endif /* CONFIG_DRIVER_TI_EMAC */
-
-	return 0;
-}
-
-#ifdef CONFIG_DRIVER_TI_EMAC
-
-#ifdef CONFIG_DRIVER_TI_EMAC_USE_RMII
-/**
- * rmii_hw_init
- *
- * DA850/OMAP-L138 EVM can interface to a daughter card for
- * additional features. This card has an I2C GPIO Expander TCA6416
- * to select the required functions like camera, RMII Ethernet,
- * character LCD, video.
- *
- * Initialization of the expander involves configuring the
- * polarity and direction of the ports. P07-P05 are used here.
- * These ports are connected to a Mux chip which enables only one
- * functionality at a time.
- *
- * For RMII phy to respond, the MII MDIO clock has to be  disabled
- * since both the PHY devices have address as zero. The MII MDIO
- * clock is controlled via GPIO2[6].
- *
- * This code is valid for Beta version of the hardware
- */
-int rmii_hw_init(void)
-{
-	const struct pinmux_config gpio_pins[] = {
-		{ pinmux(6), 8, 1 }
-	};
-	u_int8_t buf[2];
-	unsigned int temp;
-	int ret;
-
-	/* PinMux for GPIO */
-	if (davinci_configure_pin_mux(gpio_pins, ARRAY_SIZE(gpio_pins)) != 0)
-		return 1;
-
-	/* I2C Exapnder configuration */
-	/* Set polarity to non-inverted */
-	buf[0] = 0x0;
-	buf[1] = 0x0;
-	ret = i2c_write(CFG_SYS_I2C_EXPANDER_ADDR, 4, 1, buf, 2);
-	if (ret) {
-		printf("\nExpander @ 0x%02x write FAILED!!!\n",
-				CFG_SYS_I2C_EXPANDER_ADDR);
-		return ret;
-	}
-
-	/* Configure P07-P05 as outputs */
-	buf[0] = 0x1f;
-	buf[1] = 0xff;
-	ret = i2c_write(CFG_SYS_I2C_EXPANDER_ADDR, 6, 1, buf, 2);
-	if (ret) {
-		printf("\nExpander @ 0x%02x write FAILED!!!\n",
-				CFG_SYS_I2C_EXPANDER_ADDR);
-	}
-
-	/* For Ethernet RMII selection
-	 * P07(SelA)=0
-	 * P06(SelB)=1
-	 * P05(SelC)=1
-	 */
-	if (i2c_read(CFG_SYS_I2C_EXPANDER_ADDR, 2, 1, buf, 1)) {
-		printf("\nExpander @ 0x%02x read FAILED!!!\n",
-				CFG_SYS_I2C_EXPANDER_ADDR);
-	}
-
-	buf[0] &= 0x1f;
-	buf[0] |= (0 << 7) | (1 << 6) | (1 << 5);
-	if (i2c_write(CFG_SYS_I2C_EXPANDER_ADDR, 2, 1, buf, 1)) {
-		printf("\nExpander @ 0x%02x write FAILED!!!\n",
-				CFG_SYS_I2C_EXPANDER_ADDR);
-	}
-
-	/* Set the output as high */
-	temp = REG(GPIO_BANK2_REG_SET_ADDR);
-	temp |= (0x01 << 6);
-	REG(GPIO_BANK2_REG_SET_ADDR) = temp;
-
-	/* Set the GPIO direction as output */
-	temp = REG(GPIO_BANK2_REG_DIR_ADDR);
-	temp &= ~(0x01 << 6);
-	REG(GPIO_BANK2_REG_DIR_ADDR) = temp;
-
-	return 0;
-}
-#endif /* CONFIG_DRIVER_TI_EMAC_USE_RMII */
-
-/*
- * Initializes on-board ethernet controllers.
- */
-int board_eth_init(struct bd_info *bis)
-{
-#ifdef CONFIG_DRIVER_TI_EMAC_USE_RMII
-	/* Select RMII fucntion through the expander */
-	if (rmii_hw_init())
-		printf("RMII hardware init failed!!!\n");
-#endif
-	return 0;
-}
-#endif /* CONFIG_DRIVER_TI_EMAC */
diff --git a/configs/da850evm_defconfig b/configs/da850evm_defconfig
deleted file mode 100644
index c76f6847d85..00000000000
--- a/configs/da850evm_defconfig
+++ /dev/null
@@ -1,116 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
-CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
-CONFIG_SYS_THUMB_BUILD=y
-CONFIG_ARCH_DAVINCI=y
-CONFIG_TEXT_BASE=0xc1080000
-CONFIG_SYS_MALLOC_LEN=0x110000
-CONFIG_SYS_MALLOC_F_LEN=0x800
-CONFIG_TARGET_DA850EVM=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0000f20
-CONFIG_SF_DEFAULT_SPEED=30000000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_STACK=0x8001ff00
-CONFIG_SPL_TEXT_BASE=0x80000000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xc0000000
-CONFIG_SYS_LOAD_ADDR=0xc0700000
-CONFIG_SPL=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_LTO=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run envboot; run mmcboot; "
-CONFIG_DEFAULT_FDT_FILE="da850-evm.dtb"
-CONFIG_SYS_PBSIZE=1050
-# CONFIG_DISPLAY_CPUINFO is not set
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_CLOCKS=y
-CONFIG_HWCONFIG=y
-CONFIG_MISC_INIT_R=y
-CONFIG_SPL_PAD_TO=0x8000
-CONFIG_SPL_FOOTPRINT_LIMIT=y
-CONFIG_SPL_MAX_FOOTPRINT=0x8000
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0f70000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x110000
-# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
-CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x8000
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="U-Boot > "
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MX_CYCLIC=y
-CONFIG_CMD_DM=y
-# CONFIG_CMD_GPT is not set
-CONFIG_CMD_MTD=y
-# CONFIG_CMD_SF is not set
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-# CONFIG_CMD_TIME is not set
-# CONFIG_CMD_EXT4 is not set
-CONFIG_CMD_FS_UUID=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:32k(SPL),480k(u-boot),64k(u-boot-env),7552k(kernel-spare),64k(MAC-Address)"
-CONFIG_CMD_DIAG=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_SPL_BLOCK_CACHE=y
-CONFIG_DA8XX_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DAVINCI=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_EMAC=y
-CONFIG_PHY=y
-CONFIG_PHY_DA8XX_USB=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_DAVINCI_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_DA8XX=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_DA8XX=y
-CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
-# CONFIG_FAT_WRITE is not set
diff --git a/configs/da850evm_direct_nor_defconfig b/configs/da850evm_direct_nor_defconfig
deleted file mode 100644
index 936de610713..00000000000
--- a/configs/da850evm_direct_nor_defconfig
+++ /dev/null
@@ -1,95 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_DAVINCI=y
-CONFIG_TEXT_BASE=0x60000000
-CONFIG_SYS_MALLOC_LEN=0x110000
-CONFIG_SYS_MALLOC_F_LEN=0x800
-CONFIG_TARGET_DA850EVM=y
-CONFIG_DA850_LOWLEVEL=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8001ff00
-CONFIG_ENV_SIZE=0x2800
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
-CONFIG_SYS_LOAD_ADDR=0xc0700000
-CONFIG_ENV_ADDR=0x60100000
-CONFIG_LTO=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="mem=32M console=ttyS2,115200n8 root=/dev/mtdblock2 rw noinitrd ip=dhcp"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run envboot; run mmcboot; "
-CONFIG_SYS_PBSIZE=1050
-# CONFIG_DISPLAY_CPUINFO is not set
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_CLOCKS=y
-CONFIG_HWCONFIG=y
-CONFIG_MISC_INIT_R=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="U-Boot > "
-# CONFIG_CMD_BOOTZ is not set
-CONFIG_CMD_IMLS=y
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MX_CYCLIC=y
-CONFIG_CMD_DM=y
-# CONFIG_CMD_GPT is not set
-CONFIG_CMD_MTD=y
-# CONFIG_CMD_PART is not set
-# CONFIG_CMD_SF is not set
-# CONFIG_CMD_SPI is not set
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-# CONFIG_CMD_TIME is not set
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=physmap-flash.2"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=physmap-flash.2:1m(u-boot),128k(u-boot-env),-(spare)"
-CONFIG_CMD_DIAG=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_DA8XX_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DAVINCI=y
-# CONFIG_MMC is not set
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_PROTECTION=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=67
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_EMAC=y
-CONFIG_PHY=y
-CONFIG_PHY_DA8XX_USB=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_DAVINCI_SPI=y
-CONFIG_USB=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_DA8XX=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_DA8XX=y
-CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defconfig
deleted file mode 100644
index 655cb5d4e9e..00000000000
--- a/configs/da850evm_nand_defconfig
+++ /dev/null
@@ -1,119 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
-CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
-CONFIG_SYS_THUMB_BUILD=y
-CONFIG_ARCH_DAVINCI=y
-CONFIG_TEXT_BASE=0xc1080000
-CONFIG_SYS_MALLOC_LEN=0x110000
-CONFIG_SYS_MALLOC_F_LEN=0x800
-CONFIG_TARGET_DA850EVM=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0000f20
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_STACK=0x8001ff00
-CONFIG_SPL_TEXT_BASE=0x80000000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xc0000000
-CONFIG_SYS_LOAD_ADDR=0xc0700000
-CONFIG_SPL=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_LTO=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run envboot; run mmcboot; "
-CONFIG_DEFAULT_FDT_FILE="da850-evm.dtb"
-CONFIG_SYS_PBSIZE=1050
-# CONFIG_DISPLAY_CPUINFO is not set
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_CLOCKS=y
-CONFIG_HWCONFIG=y
-CONFIG_SPL_PAD_TO=0x8000
-CONFIG_SPL_FOOTPRINT_LIMIT=y
-CONFIG_SPL_MAX_FOOTPRINT=0x8000
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0f70000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x110000
-# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
-CONFIG_SPL_NAND_SIMPLE=y
-CONFIG_SPL_NAND_BASE=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="U-Boot > "
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MX_CYCLIC=y
-CONFIG_CMD_DM=y
-# CONFIG_CMD_GPT is not set
-CONFIG_CMD_NAND=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-# CONFIG_CMD_TIME is not set
-# CONFIG_CMD_EXT4 is not set
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=nand512"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand512:128k(u-boot env),512k(u-boot),128k(spl-os),8m(kernel),-(rootfs)"
-CONFIG_CMD_DIAG=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_DA8XX_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_USE_FLASH_BBT=y
-CONFIG_NAND_DAVINCI=y
-CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x28000
-CONFIG_SYS_NAND_HW_ECC_OOBFIRST=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_EMAC=y
-CONFIG_PHY=y
-CONFIG_PHY_DA8XX_USB=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_DAVINCI_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_DA8XX=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_DA8XX=y
-CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
-# CONFIG_FAT_WRITE is not set
diff --git a/doc/README.davinci b/doc/README.davinci
index ea81279a0f3..97ca0dc39a6 100644
--- a/doc/README.davinci
+++ b/doc/README.davinci
@@ -9,8 +9,6 @@ part number but is very similar to the DaVinci series.
 
 Currently the following boards are supported:
 
-* TI DA850 EVM
-
 * TI OMAP-L138 LCDK
 
 * Lego EV3
@@ -18,11 +16,6 @@ Currently the following boards are supported:
 Build
 =====
 
-* TI DA850 EVM:
-
-make da850evm_config
-make
-
 * TI OMAP-L138 LCDK
 
 make omapl138_lcdk_defconfig
@@ -42,33 +35,15 @@ initialization.
 
 The SPL is built as u-boot.ais for all DA850 defconfigs except those booting
 from NOR flash. The resulting image file can be programmed to the SPI flash
-of the DA850 EVM/LCDK.
+of the LCDK.
 
 Devices that support booting from NOR utilize execute in place (XIP) and do
 not require SPL to perform low level initialization.
 
-Environment Variables
-=====================
-
-The DA850 EVM allows the user to specify the maximum cpu clock allowed by the
-silicon, in Hz, via an environment variable "maxcpuclk".
-
-The maximum clock rate allowed depends on the silicon populated on the EVM.
-Please make sure you understand the restrictions placed on this clock in the
-device specific datasheet before setting up this variable. This information is
-passed to the Linux kernel using the ATAG_REVISION atag.
-
-If "maxcpuclk" is not defined, the configuration CFG_DA850_EVM_MAX_CPU_CLK
-is used to obtain this information.
-
 Links
 =====
 
-1) TI DA850 EVM
-http://focus.ti.com/docs/prod/folders/print/omap-l138.html
-http://www.logicpd.com/products/development-kits/zoom-omap-l138-evm-development-kit
-
-2) TI OMAP-L138 LCDK
+1) TI OMAP-L138 LCDK
 http://focus.ti.com/docs/prod/folders/print/omap-l138.html
 https://www.ti.com/tool/TMDXLCDK138
 
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b5dfad7380f..6084b614358 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -155,7 +155,6 @@ config NAND_BRCMNAND_IPROC
 config NAND_DAVINCI
 	bool "Support TI Davinci NAND controller"
 	depends on ARCH_DAVINCI || ARCH_KEYSTONE
-	select SYS_NAND_SELF_INIT if TARGET_DA850EVM
 	help
 	  Enable this driver for NAND flash controllers available in TI Davinci
 	  and Keystone2 platforms
diff --git a/include/configs/da850evm.h b/include/configs/da850evm.h
deleted file mode 100644
index 8db849c6d09..00000000000
--- a/include/configs/da850evm.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
- *
- * Based on davinci_dvevm.h. Original Copyrights follow:
- *
- * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-/*
- * Board
- */
-
-/*
- * SoC Configuration
- */
-#define CFG_SYS_EXCEPTION_VECTORS_HIGH
-#define CFG_SYS_OSCIN_FREQ		24000000
-#define CFG_SYS_TIMERBASE		DAVINCI_TIMER0_BASE
-#define CFG_SYS_HZ_CLOCK		clk_get(DAVINCI_AUXCLK_CLKID)
-
-#ifdef CONFIG_MTD_NOR_FLASH
-#define CFG_SYS_DV_NOR_BOOT_CFG	(0x11)
-#endif
-
-/*
- * Memory Info
- */
-#define PHYS_SDRAM_1		DAVINCI_DDR_EMIF_DATA_BASE /* DDR Start */
-#define PHYS_SDRAM_1_SIZE	(64 << 20) /* SDRAM size 64MB */
-#define CFG_MAX_RAM_BANK_SIZE (512 << 20) /* max size from SPRS586*/
-/* memtest start addr */
-
-/* memtest will be run on 16MB */
-
-#define CFG_SYS_DA850_SYSCFG_SUSPSRC (	\
-	DAVINCI_SYSCFG_SUSPSRC_TIMER0 |		\
-	DAVINCI_SYSCFG_SUSPSRC_SPI1 |		\
-	DAVINCI_SYSCFG_SUSPSRC_UART2 |		\
-	DAVINCI_SYSCFG_SUSPSRC_EMAC |		\
-	DAVINCI_SYSCFG_SUSPSRC_I2C)
-
-/*
- * PLL configuration
- */
-
-#define CFG_SYS_DA850_PLL0_PLLM     24
-#define CFG_SYS_DA850_PLL1_PLLM     21
-
-/*
- * DDR2 memory configuration
- */
-#define CFG_SYS_DA850_DDR2_DDRPHYCR (DV_DDR_PHY_PWRDNEN | \
-					DV_DDR_PHY_EXT_STRBEN | \
-					(0x4 << DV_DDR_PHY_RD_LATENCY_SHIFT))
-
-#define CFG_SYS_DA850_DDR2_SDBCR (		\
-	(1 << DV_DDR_SDCR_MSDRAMEN_SHIFT) |	\
-	(1 << DV_DDR_SDCR_DDREN_SHIFT) |	\
-	(1 << DV_DDR_SDCR_SDRAMEN_SHIFT) |	\
-	(1 << DV_DDR_SDCR_BUS_WIDTH_SHIFT) |	\
-	(0x3 << DV_DDR_SDCR_CL_SHIFT) |		\
-	(0x2 << DV_DDR_SDCR_IBANK_SHIFT) |	\
-	(0x2 << DV_DDR_SDCR_PAGESIZE_SHIFT))
-
-/* SDBCR2 is only used if IBANK_POS bit in SDBCR is set */
-#define CFG_SYS_DA850_DDR2_SDBCR2 0
-
-#define CFG_SYS_DA850_DDR2_SDTIMR (		\
-	(14 << DV_DDR_SDTMR1_RFC_SHIFT) |	\
-	(2 << DV_DDR_SDTMR1_RP_SHIFT) |		\
-	(2 << DV_DDR_SDTMR1_RCD_SHIFT) |	\
-	(1 << DV_DDR_SDTMR1_WR_SHIFT) |		\
-	(5 << DV_DDR_SDTMR1_RAS_SHIFT) |	\
-	(8 << DV_DDR_SDTMR1_RC_SHIFT) |		\
-	(1 << DV_DDR_SDTMR1_RRD_SHIFT) |	\
-	(0 << DV_DDR_SDTMR1_WTR_SHIFT))
-
-#define CFG_SYS_DA850_DDR2_SDTIMR2 (		\
-	(7 << DV_DDR_SDTMR2_RASMAX_SHIFT) |	\
-	(0 << DV_DDR_SDTMR2_XP_SHIFT) |		\
-	(0 << DV_DDR_SDTMR2_ODT_SHIFT) |	\
-	(17 << DV_DDR_SDTMR2_XSNR_SHIFT) |	\
-	(199 << DV_DDR_SDTMR2_XSRD_SHIFT) |	\
-	(0 << DV_DDR_SDTMR2_RTP_SHIFT) |	\
-	(0 << DV_DDR_SDTMR2_CKE_SHIFT))
-
-#define CFG_SYS_DA850_DDR2_SDRCR    0x00000494
-#define CFG_SYS_DA850_DDR2_PBBPR    0x30
-
-/*
- * Serial Driver info
- */
-#define CFG_SYS_NS16550_CLK	clk_get(DAVINCI_UART2_CLKID)
-
-#define CFG_SYS_SPI_CLK		clk_get(DAVINCI_SPI1_CLKID)
-
-/*
- * I2C Configuration
- */
-#define CFG_SYS_I2C_EXPANDER_ADDR   0x20
-
-/*
- * Flash & Environment
- */
-#ifdef CONFIG_MTD_RAW_NAND
-#define CFG_SYS_NAND_CS		3
-#define CFG_SYS_NAND_BASE		DAVINCI_ASYNC_EMIF_DATA_CE3_BASE
-#define CFG_SYS_NAND_MASK_CLE		0x10
-#define CFG_SYS_NAND_MASK_ALE		0x8
-#define CFG_SYS_NAND_U_BOOT_SIZE	0x40000
-#define CFG_SYS_NAND_U_BOOT_DST	0xc1080000
-#define CFG_SYS_NAND_U_BOOT_START	CFG_SYS_NAND_U_BOOT_DST
-#define CFG_SYS_NAND_ECCPOS		{				\
-				24, 25, 26, 27, 28, \
-				29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
-				39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
-				49, 50, 51, 52, 53, 54, 55, 56, 57, 58, \
-				59, 60, 61, 62, 63 }
-#define CFG_SYS_NAND_ECCSIZE		512
-#define CFG_SYS_NAND_ECCBYTES	10
-#endif
-
-#ifdef CONFIG_MTD_NOR_FLASH
-#define CFG_SYS_FLASH_BASE		DAVINCI_ASYNC_EMIF_DATA_CE2_BASE
-#define PHYS_FLASH_SIZE			(8 << 20) /* Flash size 8MB */
-#endif
-
-/*
- * U-Boot general configuration
- */
-
-/*
- * Linux Information
- */
-#define LINUX_BOOT_PARAM_ADDR	(PHYS_SDRAM_1 + 0x100)
-
-#define DEFAULT_LINUX_BOOT_ENV \
-	"loadaddr=0xc0700000\0" \
-	"fdtaddr=0xc0600000\0" \
-	"scriptaddr=0xc0600000\0"
-
-#include <env/ti/mmc.h>
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	DEFAULT_LINUX_BOOT_ENV \
-	DEFAULT_MMC_TI_ARGS \
-	"bootpart=0:2\0" \
-	"bootdir=/boot\0" \
-	"bootfile=zImage\0" \
-	"fdtfile=da850-evm.dtb\0" \
-	"boot_fdt=yes\0" \
-	"boot_fit=0\0" \
-	"console=ttyS2,115200n8\0" \
-	"hwconfig=dsp:wake=yes"
-
-#ifdef CONFIG_XPL_BUILD
-/* defines for SPL */
-
-#endif
-
-/* Load U-Boot Image From MMC */
-
-/* additions for new relocation code, must added to all boards */
-#define CFG_SYS_SDRAM_BASE		0xc0000000
-
-#include <asm/arch/hardware.h>
-
-#endif /* __CONFIG_H */
-- 
2.53.0

