Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF75D70DF2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB30833C6;
	Thu, 18 Dec 2025 20:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UEmhVp3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7DC8367F; Thu, 18 Dec 2025 20:42:56 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFEE8334F
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so14404805ad.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766086972; x=1766691772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pt7Xlfka7eMlDPAeuMgDqboJpdvHY9BfI/RWD+gLTo=;
 b=UEmhVp3rkzR540lStopeu2CaMdi9orNJQ0FD/GgmGVM2M0w+j+VfdoBcDhGE/2roC0
 1pdMM1fd8k15h539PxSesFvk83KruVn8Q57dcIcYebbypnoJeSNgAgOTI6PY36rKN6PU
 VYyKjLiPrFDAlJm0FgmpT0xpY+QX0UnEFk3PBPieQaV3kAGBXZIifspEdKpCUTH36Gla
 mrmoPEGPkbhhafnPvUkQMalb8zYGiknV8gWuNPvcuU2uTxEEGCqGzrB1s8Qg3B0k4RO7
 3UlbaGfOgdrrJrMH6yCFmMakbv8HY8MqmXfaMA/6Zio+7TlTQdi+Lii1NqpNrLGiXUD/
 pc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766086972; x=1766691772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5pt7Xlfka7eMlDPAeuMgDqboJpdvHY9BfI/RWD+gLTo=;
 b=NupO3ZN2cPQgwXExdxs+B79iUe7afxrjVYhK9M3/QlIQpNYCV9KADiNqnoqig18Q7b
 74LQk9F+Brtp3gZC1aVBUXyCqLY7jijhi0GSSK5JCN9AOHOhylVFtNgCmK4jSqaYAeWH
 FQzp6YqluoLGTX+uMt/DF9RvnTZ1yMlB4e96KzMCRzsnDcQ1ylrgVz5sXDvzeQGxMK3m
 LVFCp/4xQA6V9OFKNXcyWYMWIHtT61TTBziNKShXH5v//V4rtdlnx4o1Kf1kiOYGUO2A
 wIaub6NXrMWSdPhnYmCxrWNtnWesay0BAtnlX9iPvzMTSU22TyXX5WUIJQbZIq9w4Gc7
 Q08Q==
X-Gm-Message-State: AOJu0Yw3QT8NrINo8jCTZxBpC74ptH94+ATGbWLiaq7yPMgsYrMU1DM5
 ZMjFooUAD07qRBcUkSEGWP/9N76X5xRWxrIpF9Dufvvs5OQq+BZFIwk4
X-Gm-Gg: AY/fxX7KLB2vdks9xwNJf+RQ49bvgzZKdqz9bs6+6+lx4EHRae/yXmboZoAbZQk4Yeg
 agCdEgHBjeRfOju/9D/0sHNtd6/G8+V6EQbpUjAa41Q63Skx63SnwQUH5MoJU8XWIhWZ1++Rews
 RcHFRdCrG6ydU+ZoY8fREuD/MWu9dlb6GQt9u16PLjCIM711r7jxsIJA36wSUryNvfUPUmYX0cY
 WFuLmt7zgrK9xOIDDy0AwMWssVZ7vxJBMRpWg9MEaLkzsEcGQCai7sex6jExSonLoKp4LDuPb69
 AX1FxdSqju2L3Ubpoe4Wqu1JIf5PJTCDPf7Z5hn2SsvitJKt32M1F0ZXQjDoZ4clWG2pi82lR74
 fyT7KwUiuTeZFCt9dpbosgMMrVAlCD2VNypMIGoBi4d60OzTd+2wZLh2JzaVfbyJ379O4PfBpAy
 Pw0UHuhNtZ/K/4vmm9pUJxqSaM
X-Google-Smtp-Source: AGHT+IFTR43Hnbx5mZnikYFJxwj8GOUuzGbmOVQFEXXh/w6orYoyN//+AqtGDE63ANO++OSmRN2ZUw==
X-Received: by 2002:a17:903:2450:b0:2a0:f469:1f5f with SMTP id
 d9443c01a7336-2a2f221fa26mr3780155ad.13.1766086972339; 
 Thu, 18 Dec 2025 11:42:52 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c146aabsm116413a12.25.2025.12.18.11.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:42:51 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH v2 3/3] arm: mvebu: Add Allied Telesis x220
Date: Fri, 19 Dec 2025 08:42:18 +1300
Message-ID: <20251218194218.1972757-4-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218194218.1972757-1-judge.packham@gmail.com>
References: <20251218194218.1972757-1-judge.packham@gmail.com>
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
    Changes in v2:
    - None

 arch/arm/dts/Makefile                    |   1 +
 arch/arm/dts/armada-xp-atl-x220.dts      | 162 +++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig              |   7 +
 board/alliedtelesis/x220/.gitattributes  |   1 +
 board/alliedtelesis/x220/.gitignore      |   1 +
 board/alliedtelesis/x220/MAINTAINERS     |   7 +
 board/alliedtelesis/x220/Makefile        |  14 ++
 board/alliedtelesis/x220/README          |   4 +
 board/alliedtelesis/x220/binary.0        | Bin 0 -> 423 bytes
 board/alliedtelesis/x220/kwbimage.cfg.in |  12 ++
 board/alliedtelesis/x220/x220.c          |  67 ++++++++++
 configs/x220_defconfig                   |  76 +++++++++++
 include/configs/x220.h                   |  20 +++
 13 files changed, 372 insertions(+)
 create mode 100644 arch/arm/dts/armada-xp-atl-x220.dts
 create mode 100644 board/alliedtelesis/x220/.gitattributes
 create mode 100644 board/alliedtelesis/x220/.gitignore
 create mode 100644 board/alliedtelesis/x220/MAINTAINERS
 create mode 100644 board/alliedtelesis/x220/Makefile
 create mode 100644 board/alliedtelesis/x220/README
 create mode 100644 board/alliedtelesis/x220/binary.0
 create mode 100644 board/alliedtelesis/x220/kwbimage.cfg.in
 create mode 100644 board/alliedtelesis/x220/x220.c
 create mode 100644 configs/x220_defconfig
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
index 000000000000..299ccda45e20
--- /dev/null
+++ b/board/alliedtelesis/x220/MAINTAINERS
@@ -0,0 +1,7 @@
+x220 BOARD
+M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
+S:	Maintained
+F:	board/alliedtelesis/x220
+F:	include/configs/x220.h
+F:	configs/x220_defconfig
+F:	arch/arm/dts/armada-xp-atl-x220.dts
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
diff --git a/board/alliedtelesis/x220/README b/board/alliedtelesis/x220/README
new file mode 100644
index 000000000000..b90f0f879ddf
--- /dev/null
+++ b/board/alliedtelesis/x220/README
@@ -0,0 +1,4 @@
+To generate binary.0 from Marvell's bin_hdr.elf use the following command
+
+    arm-softfloat-linux-gnueabi-objcopy -S -O binary bin_hdr.elf \
+       board/alliedtelesis/x220/binary.0
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

