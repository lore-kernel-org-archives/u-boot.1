Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A887CD711C8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B44833C6;
	Fri, 19 Dec 2025 00:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJuHlJ/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A7583642; Thu, 18 Dec 2025 23:59:58 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A198334F
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 23:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso1258818a91.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766098794; x=1766703594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32o14xWFFYdb3vUrWVbUxLNYJCRtJwYMnby1eaVcYnA=;
 b=WJuHlJ/T8hDmdyDiMzUnCr2v8u5SkI/P2XBSWuZ3TxD6Qk6QNUexfmfUHA8qPo6baC
 8StJhViAHnwVF04qi7J1gM9Ih/RktxCGCVRfHwtS29CN8SawaLPrYk83q9pSJr9I5F1V
 XXhT0tin8hbe+jNgXQHUpaZ5kUXaYbOPFO9eaaVZ3PCBPQP8XWCvVStoE+v+9Cmy3rUW
 xneKe0RUAByqgazKEFXTOkZ4zIWXtrJJy6q4ko5ugZTP5HsaKZ+RFtCoDqvfLYFjMZeF
 7FNpaFFMxQh+8Jq5DCZ56YeDvszliPVIkRH7EW8zHJvjMuSeMuYMzUW41Io2ju1ld5yr
 gCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766098794; x=1766703594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=32o14xWFFYdb3vUrWVbUxLNYJCRtJwYMnby1eaVcYnA=;
 b=mfUKQghOx3AfUNN5CVToKMdrqfm32YKima0dvAquHdMNA7lgJRkRRvjzbXQJQawBEq
 od//EmHxUZjbD8wpwLb3FmFU4FzkpXfDT0Eu0PsaTTqwsMHlQVWU4Vuq8LkI0L0SqxTG
 WDTAHgmk/aB9DQFPX7JIUmcyQ1K1qrmxIlnCA+3x3GMamJwxjcCtz5nUYdq2nvl00NTM
 CH2qvcgxm5ljnwBI3L2edfr4R4SyvgPfhM4QHqg5TA5Cm9rGHGVavq8tw8GtMxqBT/Xu
 /e9+kxWtcYSL0StWgBC50Haz2iuP5HikG82OVj6OykXYWn4asnDFg6bbZHFrnL6ctf3+
 O92Q==
X-Gm-Message-State: AOJu0YxV6P5Ta8nIVpjKpliYnTbMZ4bGg2mZHxLqDQbATFfE0Y5N7a4a
 exOww6zktjW1T4qkE5SxSfmveo9da1VeFJVtopE7SeyxvJkAzND09qu6
X-Gm-Gg: AY/fxX76eGs9PhGUt0BSqHhvT9lIrnSPpNON/m2Yl6W9wx8VPqeah9s2HCLvCCdFVou
 N7a8kQf6qk8NyTlC66yJNn4Qw9CIdmyJlMDfU/rfj0RObllqmKHgDwUgg/XjQkZyeVObADhH+Tv
 r210ULpKUsqnAFjmVD5Fv4/SYgnqk75ING2n3wSrrYDieh56T08fTjjzftyXaRwZFFO+oT14dc5
 L70eQ7R8BEZ4JJBODoEFtWroUaQYNlUS4wUVXttlzEfKTR1SVOwrAmEWdLmKxOYMQDZw9C7ssaI
 Si/RyjLW3E+VvVHVxghwAaS3vvFtqcOAcvN/1tGy8R8GoyXvJDazKbBv8F7BgYhgve6XwYKhHw2
 gqV3Qj2i6xt+WlXazBWAwFiWQmEABeZVYqP6hwymItgMIqjjoz15Gi2VK7jQFLr1tJAz4ZiA0Ix
 IIlXAHgrCPQ0itD2v09HRu5yMS
X-Google-Smtp-Source: AGHT+IEBkXMhIbZl7fWkhkUEZMAJNelBa8pRgR3071k47CvcOz5CigHAIrUxMN8PFtzqDjfR0ykRig==
X-Received: by 2002:a17:90a:dfc6:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-34e921e60d9mr697156a91.37.1766098794275; 
 Thu, 18 Dec 2025 14:59:54 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d6565esm3431356a91.6.2025.12.18.14.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 14:59:53 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH v3 3/3] arm: mvebu: Add Allied Telesis x220
Date: Fri, 19 Dec 2025 11:59:36 +1300
Message-ID: <20251218225936.2016920-4-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218225936.2016920-1-judge.packham@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
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

Add the Allied Telesis x220 board. There are a number of other variants
with the same CPU block that are sold under some different brand names
but the x220 was first.

The x220 uses the AlleyCat3 switch chip with integrated ARMv7 CPU.
Because of this it is reliant on a binary blob for the DDR training. In
upstream u-boot this is replaced by an empty file.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

Notes:
    Changes in v3:
    - Move README to new style doc/board
    Changes in v2:
    - None

 arch/arm/dts/Makefile                    |   1 +
 arch/arm/dts/armada-xp-atl-x220.dts      | 162 +++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig              |   7 +
 board/alliedtelesis/x220/.gitattributes  |   1 +
 board/alliedtelesis/x220/.gitignore      |   1 +
 board/alliedtelesis/x220/MAINTAINERS     |   8 ++
 board/alliedtelesis/x220/Makefile        |  14 ++
 board/alliedtelesis/x220/binary.0        | Bin 0 -> 423 bytes
 board/alliedtelesis/x220/kwbimage.cfg.in |  12 ++
 board/alliedtelesis/x220/x220.c          |  67 ++++++++++
 configs/x220_defconfig                   |  76 +++++++++++
 doc/board/alliedtelesis/index.rst        |  11 ++
 doc/board/alliedtelesis/x220.rst         |  39 ++++++
 doc/board/index.rst                      |   1 +
 include/configs/x220.h                   |  20 +++
 15 files changed, 420 insertions(+)
 create mode 100644 arch/arm/dts/armada-xp-atl-x220.dts
 create mode 100644 board/alliedtelesis/x220/.gitattributes
 create mode 100644 board/alliedtelesis/x220/.gitignore
 create mode 100644 board/alliedtelesis/x220/MAINTAINERS
 create mode 100644 board/alliedtelesis/x220/Makefile
 create mode 100644 board/alliedtelesis/x220/binary.0
 create mode 100644 board/alliedtelesis/x220/kwbimage.cfg.in
 create mode 100644 board/alliedtelesis/x220/x220.c
 create mode 100644 configs/x220_defconfig
 create mode 100644 doc/board/alliedtelesis/index.rst
 create mode 100644 doc/board/alliedtelesis/x220.rst
 create mode 100644 include/configs/x220.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fcad6fb2fc71..797d9a61154c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_MVEBU) +=			\
 	armada-388-gp.dtb			\
 	armada-388-helios4.dtb			\
 	armada-38x-controlcenterdc.dtb		\
+	armada-xp-atl-x220.dtb			\
 	armada-xp-crs305-1g-4s.dtb		\
 	armada-xp-crs305-1g-4s-bit.dtb		\
 	armada-xp-crs326-24g-2s.dtb		\
diff --git a/arch/arm/dts/armada-xp-atl-x220.dts b/arch/arm/dts/armada-xp-atl-x220.dts
new file mode 100644
index 000000000000..5b3307ed2884
--- /dev/null
+++ b/arch/arm/dts/armada-xp-atl-x220.dts
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for x220 board
+ *
+ * Copyright (C) 2025 Allied Telesis Labs
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-xp-98dx3236.dtsi"
+#include "mvebu-u-boot.dtsi"
+
+/ {
+	model = "x220";
+	compatible = "marvell,armadaxp-98dx3236", "marvell,armadaxp-mv78260",
+		     "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		bootargs = "console=ttyS0,115200";
+	};
+
+	aliases {
+		i2c0 = &i2c0;
+		spi0 = &spi0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+};
+
+&L2 {
+	arm,parity-enable;
+	marvell,ecc-enable;
+};
+
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	rtc@68 {
+		compatible = "dallas,ds1340";
+		reg = <0x68>;
+	};
+
+	adt7476a@2e {
+		compatible = "adi,adt7476";
+		reg = <0x2e>;
+	};
+
+	sfpgpio: gpio@27 {
+		#address-cells = <2>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	systemgpio: gpio@25 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		nand-protect {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "nand-protect";
+		};
+
+		usb-enable {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "usb-enable";
+		};
+
+		phy-reset {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "phy-reset";
+		};
+
+		led-enable {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led-enable";
+		};
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-flash", "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&nand_controller {
+	compatible = "marvell,armada370-nand-controller";
+	label = "pxa3xx_nand-0";
+	status = "okay";
+	nand-rb = <0>;
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+};
+
+&{/} {
+	boot-board {
+		compatible = "atl,boot-board";
+		present-gpio = <&systemgpio 12 GPIO_ACTIVE_HIGH>;
+		override-gpio = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+	};
+};
+
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index b76510ab4527..bc009163ed96 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -226,6 +226,10 @@ config TARGET_X240
 	select ALLEYCAT_5
 	imply BOOTSTD_DEFAULTS
 
+config TARGET_X220
+	bool "Support Allied Telesis x220"
+	select 98DX3336
+
 config TARGET_DB_XC3_24G4XG
 	bool "Support DB-XC3-24G4XG"
 	select 98DX3336
@@ -310,6 +314,7 @@ config SYS_BOARD
 	default "x530" if TARGET_X530
 	default "x250" if TARGET_X250
 	default "x240" if TARGET_X240
+	default "x220" if TARGET_X220
 	default "db-xc3-24g4xg" if TARGET_DB_XC3_24G4XG
 	default "crs3xx-98dx3236" if TARGET_CRS3XX_98DX3236
 	default "mvebu_alleycat-5" if TARGET_MVEBU_ALLEYCAT5
@@ -335,6 +340,7 @@ config SYS_CONFIG_NAME
 	default "x530" if TARGET_X530
 	default "x250" if TARGET_X250
 	default "x240" if TARGET_X240
+	default "x220" if TARGET_X220
 	default "db-xc3-24g4xg" if TARGET_DB_XC3_24G4XG
 	default "crs3xx-98dx3236" if TARGET_CRS3XX_98DX3236
 	default "mvebu_alleycat-5" if TARGET_MVEBU_ALLEYCAT5
@@ -360,6 +366,7 @@ config SYS_VENDOR
 	default "alliedtelesis" if TARGET_X530
 	default "alliedtelesis" if TARGET_X250
 	default "alliedtelesis" if TARGET_X240
+	default "alliedtelesis" if TARGET_X220
 	default "mikrotik" if TARGET_CRS3XX_98DX3236
 	default "Marvell" if TARGET_MVEBU_ALLEYCAT5
 
diff --git a/board/alliedtelesis/x220/.gitattributes b/board/alliedtelesis/x220/.gitattributes
new file mode 100644
index 000000000000..2aeb4eee6416
--- /dev/null
+++ b/board/alliedtelesis/x220/.gitattributes
@@ -0,0 +1 @@
+binary.0 binary
diff --git a/board/alliedtelesis/x220/.gitignore b/board/alliedtelesis/x220/.gitignore
new file mode 100644
index 000000000000..775b9346b859
--- /dev/null
+++ b/board/alliedtelesis/x220/.gitignore
@@ -0,0 +1 @@
+kwbimage.cfg
diff --git a/board/alliedtelesis/x220/MAINTAINERS b/board/alliedtelesis/x220/MAINTAINERS
new file mode 100644
index 000000000000..63da2725f716
--- /dev/null
+++ b/board/alliedtelesis/x220/MAINTAINERS
@@ -0,0 +1,8 @@
+x220 BOARD
+M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
+S:	Maintained
+F:	board/alliedtelesis/x220
+F:	include/configs/x220.h
+F:	configs/x220_defconfig
+F:	arch/arm/dts/armada-xp-atl-x220.dts
+F:	doc/board/alliedtelesis/x220.rst
diff --git a/board/alliedtelesis/x220/Makefile b/board/alliedtelesis/x220/Makefile
new file mode 100644
index 000000000000..a74f0a769484
--- /dev/null
+++ b/board/alliedtelesis/x220/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Allied Telesis Labs
+
+obj-y	:= x220.o
+extra-y	:= kwbimage.cfg
+
+quiet_cmd_sed = SED     $@
+      cmd_sed = sed $(SEDFLAGS_$(@F)) $< >$(dir $@)$(@F)
+
+SEDFLAGS_kwbimage.cfg =-e "s|^BINARY.*|BINARY $(srctree)/$(@D)/binary.0 0000005b 00000068|"
+$(obj)/kwbimage.cfg: $(src)/kwbimage.cfg.in include/autoconf.mk \
+		include/config/auto.conf
+	  $(call if_changed,sed)
diff --git a/board/alliedtelesis/x220/binary.0 b/board/alliedtelesis/x220/binary.0
new file mode 100644
index 0000000000000000000000000000000000000000..8dd687286a001c5df3cbc878d527d2a764f8c40b
GIT binary patch
literal 423
zcmYk2F>b>!3`KXHf(NjDfNtqhWN3z>MaF`*7)y;z29zAvw=ZR<MFmad=l_pv+x@xo
z;q7!hy*#-`p>^*eX1K&ekb}(0!ysHRGL%5jNB#_6VI(HSLLT~cYly}%GA4LMy;Dl=
zqkR@B5T{$BiOiuy;SLVj<Q8Cmm{qNjR^Te+A<f<lx1^YV4eq4bCL34?0^SMGSJh^6
zOE^%F<VhRIVnr+)%^vRJgd@R#3_blrUShG$3XrO3?wmVbV3qk{4_B7Owv{@xh+ZR)
ze|uj<t5l&ERNvGvt_Als=K@TXOh9QP+aU{mm;IiB)Eq5*W3*GEt`G<f-ywS&8)UlG
J%kTW1`vEC^lKcPw

literal 0
HcmV?d00001

diff --git a/board/alliedtelesis/x220/kwbimage.cfg.in b/board/alliedtelesis/x220/kwbimage.cfg.in
new file mode 100644
index 000000000000..8beda907ba45
--- /dev/null
+++ b/board/alliedtelesis/x220/kwbimage.cfg.in
@@ -0,0 +1,12 @@
+#
+# Copyright (C) 2025 Allied Telesis Labs
+#
+
+# Armada XP uses version 1 image format
+VERSION		1
+
+# Boot Media configurations
+BOOT_FROM	spi
+
+# Binary Header (bin_hdr) with DDR3 training code
+BINARY board/alliedtelesis/x220/binary.0 0000005b 00000068
diff --git a/board/alliedtelesis/x220/x220.c b/board/alliedtelesis/x220/x220.c
new file mode 100644
index 000000000000..7c9a73de9a24
--- /dev/null
+++ b/board/alliedtelesis/x220/x220.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Allied Telesis Labs
+ */
+
+#include <i2c.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/gpio.h>
+#include <linux/bitops.h>
+#include <linux/mbus.h>
+#include <linux/io.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/soc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define X220_GPP_OUT_ENA_LOW	(~(BIT(12) | BIT(17) | BIT(18) | BIT(31)))
+#define X220_GPP_OUT_ENA_MID	(~(0))
+#define X220_GPP_OUT_VAL_LOW	(BIT(12) | BIT(18))
+#define X220_GPP_OUT_VAL_MID	0x0
+#define X220_GPP_POL_LOW	0x0
+#define X220_GPP_POL_MID	0x0
+
+int board_early_init_f(void)
+{
+	/* Configure MPP */
+	writel(0x44042222, MVEBU_MPP_BASE + 0x00);
+	writel(0x11000004, MVEBU_MPP_BASE + 0x04);
+	writel(0x44444004, MVEBU_MPP_BASE + 0x08);
+	writel(0x04444444, MVEBU_MPP_BASE + 0x0c);
+	writel(0x00000004, MVEBU_MPP_BASE + 0x10);
+
+	/* Set GPP Out value */
+	writel(X220_GPP_OUT_VAL_LOW, MVEBU_GPIO0_BASE + 0x00);
+	writel(X220_GPP_OUT_VAL_MID, MVEBU_GPIO1_BASE + 0x00);
+
+	/* Set GPP Polarity */
+	writel(X220_GPP_POL_LOW, MVEBU_GPIO0_BASE + 0x0c);
+	writel(X220_GPP_POL_MID, MVEBU_GPIO1_BASE + 0x0c);
+
+	/* Set GPP Out Enable */
+	writel(X220_GPP_OUT_ENA_LOW, MVEBU_GPIO0_BASE + 0x04);
+	writel(X220_GPP_OUT_ENA_MID, MVEBU_GPIO1_BASE + 0x04);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = mvebu_sdram_bar(0) + 0x100;
+
+	/* Disable MBUS Err Prop - in order to avoid data aborts */
+	clrbits_le32(MVEBU_CPU_WIN_BASE + 0x200, (1 << 8));
+
+	return 0;
+}
+
+#ifdef CONFIG_DISPLAY_BOARDINFO
+int checkboard(void)
+{
+	puts("Board: Allied Telesis x220\n");
+
+	return 0;
+}
+#endif
diff --git a/configs/x220_defconfig b/configs/x220_defconfig
new file mode 100644
index 000000000000..4318f5e6ef1d
--- /dev/null
+++ b/configs/x220_defconfig
@@ -0,0 +1,76 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_SYS_KWD_CONFIG="board/alliedtelesis/x220/kwbimage.cfg"
+CONFIG_TEXT_BASE=0x00800000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_X220=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="armada-xp-atl-x220"
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x00800000
+CONFIG_SYS_MEMTEST_END=0x00ffffff
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SYS_MAXARGS=96
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand:112M(user),8M(errlog),8M(nand-bbt)"
+CONFIG_CMD_UBI=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_GPIO_HOG=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+# CONFIG_MMC is not set
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_PXA3XX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_PCI_MVEBU=y
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_WDT=y
+CONFIG_WDT_ORION=y
diff --git a/doc/board/alliedtelesis/index.rst b/doc/board/alliedtelesis/index.rst
new file mode 100644
index 000000000000..a8de29866095
--- /dev/null
+++ b/doc/board/alliedtelesis/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Allied Telesis Labs
+
+Allied Telesis
+==============
+
+.. toctree::
+   :maxdepth: 2
+
+   x220
+
diff --git a/doc/board/alliedtelesis/x220.rst b/doc/board/alliedtelesis/x220.rst
new file mode 100644
index 000000000000..6ca5f61ec4e1
--- /dev/null
+++ b/doc/board/alliedtelesis/x220.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Allied Telesis Labs
+
+x220 Platforms
+==============
+
+Introduction
+------------
+
+The x220 has is a range of L2+ switches using the Marvell AlleyCat3 switch with
+integrated ARMv7 CPU. It is also sold under some different brands for different
+markets.
+
+- x220-52GP
+- x220-52GT
+- x220-28GS
+- GS980M/52PS
+- GS980M/52
+- x230-52
+
+DDR Traning (binhdr)
+--------------------
+
+The AlleyCat3 uses a binary blob for it's DDR training. This is launched by
+the built-in bootloader prior to U-Boot starting.
+
+To generate binary.0 from Marvell's bin_hdr.elf use the following command
+
+.. prompt:: bash $
+
+  arm-softfloat-linux-gnueabi-objcopy -S -O binary bin_hdr.elf \
+     board/alliedtelesis/x220/binary.0
+
+Alternatively, it is possible to extract the binary.0 from an existing U-Boot
+image
+
+.. prompt:: bash $
+
+   ./tools/dumpimage -T kwbimage -p 1 -o board/alliedtelesis/x220/binary.0 u-boot.kwb
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 7870f1bc2461..22c63f88e863 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -10,6 +10,7 @@ Board-specific doc
    actions/index
    advantech/index
    andestech/index
+   alliedtelesis/index
    allwinner/index
    amlogic/index
    anbernic/index
diff --git a/include/configs/x220.h b/include/configs/x220.h
new file mode 100644
index 000000000000..3022ad491b7e
--- /dev/null
+++ b/include/configs/x220.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Allied Telesis Labs
+ */
+
+#ifndef _CONFIG_X220_H
+#define _CONFIG_X220_H
+
+/* Keep device tree and initrd in lower memory so the kernel can access them */
+#define CFG_EXTRA_ENV_SETTINGS	\
+	"fdt_high=0x10000000\0"		\
+	"initrd_high=0x10000000\0"
+
+/*
+ * mv-common.h should be defined after CMD configs since it used them
+ * to enable certain macros
+ */
+#include "mv-common.h"
+
+#endif /* _CONFIG_X220_H */
-- 
2.52.0

