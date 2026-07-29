Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD6C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50ABC40B39;
	Wed, 29 Jul 2026 08:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VxBisygVitv6; Wed, 29 Jul 2026 08:17:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36CD340A8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785313057;
	bh=rkvcxHgAX6K+ikHDvWxd6jgG7JEuuf7tEI6NWhbfp6A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QOBSZXfoA7foC4kdH5u0DPLW7HWiQ2xAvIPdUM/XPYdJIr6Ld0eScv/f1AIO1qaYj
	 9l33dBVtWf18K+lPKfVyEqBqK7rlxvt9nUUYcVBogCbIAIbVoqJHWBtEpMPEKZ2Wje
	 HxKFWWK8pL64XVcLF/ykeXPTihER+JSqHHAek+PmzqPZKDmO6WtaixiYsBj+AtyabK
	 setEiiEyGc1dsF6eF4Gi9aicBlPRhuJu3J+78PR85PGXGw9Jf/8AXJwq3DnPW07Wfq
	 3pzs9SIYKQ/8tYcAM/6zg5aDWeNpTkJSZa1jv499tW18eg5ZwG9v7YA0MSiqO8TtEp
	 a7ty+7L3O/3DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36CD340A8A;
	Wed, 29 Jul 2026 08:17:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08C7A194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEE968113B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQ2P0wmqB-5u for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:17:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=judge.packham@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EEBB88113D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEBB88113D
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEBB88113D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:17:34 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so577868a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 01:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785313054; x=1785917854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rkvcxHgAX6K+ikHDvWxd6jgG7JEuuf7tEI6NWhbfp6A=;
 b=K0lRNEisWJ4ltDwJ1mUKMnnOoXpc2c7VQdqRJwUxrJXVB1EFIR1I0HG2TlMXl6roXi
 IzX16OJ0Ek5V5mHIOSMc5USJmWTM3vk3vQk9/uf3JfZQtZYOREvuQ29vC8jtP7k57BQe
 MIa8ooXKf1zyvJFn2kzOuEsGht+K2GhRdPljyqsDp5J+IierL7a5Bkz1jfGtnq63Ki7P
 9uzjNpBAbSCmZDD5aKmdg0cwFEYff8qNlozOnEZd1rwhknw7RJyiLM7/cJkyfC/yzcwY
 HnWiJoOj/YHOr/BbtJXfEcd0oFMfzXVwuBgL4QKQVnjmFuOp+0GUXXi4rKXP2Yw6fNfu
 fDng==
X-Gm-Message-State: AOJu0Yx+GaBcPJt9er7auALBraPXLH6MhjP0dt1uirZKtGU4bFMq/x/P
 cCJ+QoT/snC37FUFAdTNTwODE2jDumvds+44mA/4/KoOKPYFYVl5R6r6
X-Gm-Gg: AR+sD10k/45CwYSI0j1NpIIsD8eWdyN/7ttomUCUlHfoaSS6m38l+qMuWwCDYJ2GB7A
 qDXeUEMfSnxJxznrS3NjRU/wU0mseYa2zgyKHxOP0s803BbTGUvdBQAFqjXlphalx8MlnY3d2LG
 C8UliK9Qq1lnNhy+pBaCVf21Rk7d11iKKSJk4AZhEHukQfmrK0rnn6BoqQbYeru6HUEiVt7mtzl
 wsLHGfxJ7vLTt3LdAN5z/2zDcP8nrTliLGL5UZ29QlsFk0sNUKLtBhvA8NPKmyWWIp4fn77XiDC
 GAs/6SU0M0UeSD4B8jl3X1tjUO/NndRLtT6aGZS94zJ93qhj/ovLFoPFeQ4+94mvXWkV3IIgTBJ
 DeU9v1iSGAD4GWCOutGDIcWLH8BH1pTGjpnR1PFFdADAfnXZLLavtDnyyqksRA0DsEudc5wlf1+
 sUSb7/umeYwz0ZDtvnCjebjyfjLfape0XL8bCTNGTvPC23Rav078b7QBPNP4u/5IIyUz5qO3gF2
 2uQAF/5k3sDAgmPDa1UEUQDQZ6fbCM/y1EjwmZix0nBwg==
X-Received: by 2002:a05:6a20:54a1:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3c8aaf80575mr6908654637.7.1785313053977; 
 Wed, 29 Jul 2026 01:17:33 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:222c:3d14:205a:5f64])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d2ec2asm8499376eec.21.2026.07.29.01.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:17:33 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, stefan.roese@mailbox.org
Cc: u-boot@lists.u-boot-project.org,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] arm: mvebu: Add Allied Telesis x960 board
Date: Wed, 29 Jul 2026 20:17:19 +1200
Message-ID: <20260729081719.1074442-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785313054; x=1785917854;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rkvcxHgAX6K+ikHDvWxd6jgG7JEuuf7tEI6NWhbfp6A=;
 b=f5lVzTKm5bzMkDjJ+iREocyrzYldK54J41od/1DEedL36z6shZihE+8HtoV9bAswgp
 YS0gNqIKZ54hfdMuk+c8WgN23JnWoUsk+oBcLVVe72RSR80KIfMbKLUKSYf/em0gogMI
 upHKL4f+N4Z27N2IEM7SgAqLF2VKd/v2Wq2DWprzWzJTVPkk99yGP1M7wJn2jqhu0qXZ
 zWZ/o5dLUDoTPgsbjAR4kw4mKbTmP+dtM/ZRsWP0XxAiMkiBhrXrtTyGbv/BPV+X1Ekt
 w2c4dk8XvTw8aNte0vgfc25qKDX/8u5+CoKNHXiZ8c/bcya14pug/Ywqb9Op2g891o1b
 ayPQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=f5lVzTKm
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The  x960-28YSQ is a 25G/100G layer 3 switch from Allied Telesis.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 arch/arm/dts/Makefile                  |   3 +-
 arch/arm/dts/cn9130-atl-x960-28ysq.dts | 313 +++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig            |   8 +
 board/alliedtelesis/x960/MAINTAINERS   |   7 +
 board/alliedtelesis/x960/Makefile      |   6 +
 board/alliedtelesis/x960/x960.c        |  19 ++
 configs/x960_defconfig                 | 104 ++++++++
 include/configs/x960.h                 |  28 +++
 8 files changed, 487 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/cn9130-atl-x960-28ysq.dts
 create mode 100644 board/alliedtelesis/x960/MAINTAINERS
 create mode 100644 board/alliedtelesis/x960/Makefile
 create mode 100644 board/alliedtelesis/x960/x960.c
 create mode 100644 configs/x960_defconfig
 create mode 100644 include/configs/x960.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dada5f9eba26..a02dad22f274 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -170,7 +170,8 @@ dtb-$(CONFIG_ARCH_MVEBU) +=			\
 	cn9130-crb-B.dtb			\
 	ac5-98dx35xx-rd.dtb			\
 	ac5-98dx35xx-atl-x240.dtb		\
-	cn9130-atl-x250.dtb
+	cn9130-atl-x250.dtb			\
+	cn9130-atl-x960-28ysq.dtb
 endif
 
 dtb-$(CONFIG_ARCH_SYNQUACER) += synquacer-sc2a11-developerbox.dtb
diff --git a/arch/arm/dts/cn9130-atl-x960-28ysq.dts b/arch/arm/dts/cn9130-atl-x960-28ysq.dts
new file mode 100644
index 000000000000..177d09b25b3b
--- /dev/null
+++ b/arch/arm/dts/cn9130-atl-x960-28ysq.dts
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Allied Telesis Labs
+ */
+
+#include "cn9130.dtsi"
+
+/ {
+	model = "Allied Telesis x960-28YSQ";
+	compatible = "alliedtelesis,x960-28ysq",
+		"marvell,cn9130",
+		"marvell,armada-ap806-quad",
+		"marvell,armada-ap806";
+
+	aliases {
+		serial0 = &uart0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+
+};
+
+/*
+ * AP related configuration
+ */
+&ap_pinctl {
+	/* AP_MPP Pins:
+	 * GPIO & NC [0-10,12]
+	 * UART0 [11,19]
+	 */
+		/*   0 1 2 3 4 5 6 7 8 9 */
+	pin-func = < 0 0 0 0 0 0 0 0 0 0
+		     0 3 0 0 0 0 0 0 0 3 >;
+};
+
+&ap_gpio0 {
+	pp-reset {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "pp-reset";
+	};
+
+	usb-en {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-en";
+	};
+
+	fan-en {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "fan-en";
+	};
+};
+
+/*
+ * CP related configuration
+ */
+&cp0_pinctl {
+	/* MPP Bus:
+	 *	[0-1]	DEV
+	 *	[2-8]	GPIO
+	 *	[9]	DEV
+	 *	[10-12]	GPIO
+	 *	[13]	ND_RB
+	 *	[14]	GPIO
+	 *	[15-28]	DEV
+	 *	[29-30]	GPIO
+	 *	[31]	DEV
+	 *	[32-34]	GPIO
+	 *	[35-36]	I2C1
+	 *	[37-38]	I2C0
+	 *	[39-46]	GPIO
+	 *	[47]	SMI
+	 *	[48]	GPIO
+	 *	[49]	SMI
+	 *	[49-55]	GPIO
+	 *	[56-60]	SPI
+	 *	[61-62]	GPIO
+	 */
+		/*   0   1   2   3   4   5   6   7   8   9 */
+	pin-func = < 1   1   0   0   0   0   0   0   0   1
+		     0   0   0   2   0   1   1   1   1   1
+		     1   1   1   1   1   1   1   1   1   0
+		     0   1   0   0   0   2   2   2   2   0
+		     0   0   0   0   0   0   0   8   0   8
+		     0   0   0   0   0   0   6   6   6   6
+		     6   0   0>;
+
+	cp0_i2c0_pins: cp0-i2c-pins-0 {
+		marvell,pins = <37 38>;
+		marvell,function = <2>;
+	};
+
+	cp0_i2c1_pins: cp0-i2c-pins-1 {
+		marvell,pins = <35 36>;
+		marvell,function = <2>;
+	};
+
+	cp0_nand_pins: cp0-nand-pins {
+		marvell,pins = <0 1 9 15 16 17 18 19 20 21 22 23 24 25 26 27 28 31>;
+		marvell,function = <1>;
+	};
+
+	cp0_smi_pins: cp0-smi-pins {
+		marvell,pins = <47 49>;
+		marvell,function = <8>;
+	};
+
+	cp0_nand_rb: cp0-nand-rb {
+		marvell,pins = <13>;
+		marvell,function = <2>;
+	};
+
+	cp0_spi0_pins: cp0-spi-pins-0 {
+		marvell,pins = <56 57 58 59 60>;
+		marvell,function = <6>;
+	};
+};
+
+&cp0_i2c0 {
+	status = "okay";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+
+	mux@70 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+		reset-gpios = <&ap_gpio0 2 GPIO_ACTIVE_LOW>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			hwmon@2d {
+				compatible = "adi,adt7476";
+				reg = <0x2d>;
+				adi,pwm-active-state = <0 0 0>;
+			};
+
+			hwmon@2e {
+				compatible = "adi,adt7476";
+				reg = <0x2e>;
+			};
+
+			rtc:rtc@68 {
+				compatible = "adi,max31343";
+				reg = <0x68>;
+			};
+		};
+
+		/* Switch/EEPROM */
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		/* PSU0 */
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			eeprom@51 {
+				compatible = "i2c-eeprom";
+				reg = <0x51>;
+			};
+		};
+
+		/* PSU1 */
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			eeprom@51 {
+				compatible = "i2c-eeprom";
+				reg = <0x51>;
+			};
+		};
+
+	};
+};
+
+&cp0_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+};
+
+&cp0_comphy {
+	phy0 {
+		phy-type = <COMPHY_TYPE_PEX0>;
+	};
+
+	phy1 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy2 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy3 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy4 {
+		phy-type = <COMPHY_TYPE_IGNORE>;
+	};
+
+	phy5 {
+		phy-type = <COMPHY_TYPE_SGMII0>;
+		phy-speed = <COMPHY_SPEED_1_25G>;
+	};
+};
+
+&cp0_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_smi_pins>;
+	status = "okay";
+	cp0_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth2 {
+	status = "okay";
+	phy = <&cp0_phy0>;
+	phy-mode = "sgmii";
+	phy-reset-gpios = <&cp0_gpio0 10 GPIO_ACTIVE_LOW>;
+};
+
+&cp0_pcie0 {
+	num-lanes = <1>;
+		/* non-prefetchable memory */
+	ranges =<0x82000000 0 0xc0000000 0 0xc0000000 0 0x2000000>;
+	status = "disabled";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&cp0_utmi0 {
+	status = "okay";
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+};
+
+&cp0_spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi0_pins>;
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+	};
+};
+
+&cp0_nand {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_nand_pins &cp0_nand_rb>;
+	nand-ecc-strength = <8>;
+	nand-ecc-step-size = <512>;
+	nand-timing-mode = <4>;
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@user {
+			reg = <0x00000000 0x20000000>;
+			label = "user";
+		};
+	};
+};
+
+&cp0_gpio0
+{
+	nand-protect {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "nand-protect";
+	};
+};
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 3465ccfc1510..1a8dbf2792ef 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -238,6 +238,11 @@ config TARGET_X220
 	bool "Support Allied Telesis x220"
 	select 98DX3336
 
+config TARGET_X960
+	bool "Support Allied Telesis x960"
+	select ARMADA_8K
+	imply BOOTSTD_DEFAULTS
+
 config TARGET_DB_XC3_24G4XG
 	bool "Support DB-XC3-24G4XG"
 	select 98DX3336
@@ -323,6 +328,7 @@ config SYS_BOARD
 	default "x250" if TARGET_X250
 	default "x240" if TARGET_X240
 	default "x220" if TARGET_X220
+	default "x960" if TARGET_X960
 	default "db-xc3-24g4xg" if TARGET_DB_XC3_24G4XG
 	default "crs3xx-98dx3236" if TARGET_CRS3XX_98DX3236
 	default "mvebu_alleycat-5" if TARGET_MVEBU_ALLEYCAT5
@@ -349,6 +355,7 @@ config SYS_CONFIG_NAME
 	default "x250" if TARGET_X250
 	default "x240" if TARGET_X240
 	default "x220" if TARGET_X220
+	default "x960" if TARGET_X960
 	default "db-xc3-24g4xg" if TARGET_DB_XC3_24G4XG
 	default "crs3xx-98dx3236" if TARGET_CRS3XX_98DX3236
 	default "mvebu_alleycat-5" if TARGET_MVEBU_ALLEYCAT5
@@ -375,6 +382,7 @@ config SYS_VENDOR
 	default "alliedtelesis" if TARGET_X250
 	default "alliedtelesis" if TARGET_X240
 	default "alliedtelesis" if TARGET_X220
+	default "alliedtelesis" if TARGET_X960
 	default "mikrotik" if TARGET_CRS3XX_98DX3236
 	default "Marvell" if TARGET_MVEBU_ALLEYCAT5
 
diff --git a/board/alliedtelesis/x960/MAINTAINERS b/board/alliedtelesis/x960/MAINTAINERS
new file mode 100644
index 000000000000..23452b5cbe98
--- /dev/null
+++ b/board/alliedtelesis/x960/MAINTAINERS
@@ -0,0 +1,7 @@
+X960 BOARD
+M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
+S:	Maintained
+F:	board/alliedtelesis/x960/
+F:	arch/arm/dts/cn9130-atl-x960.dts
+F:	include/configs/x960.h
+F:	configs/x960_defconfig
diff --git a/board/alliedtelesis/x960/Makefile b/board/alliedtelesis/x960/Makefile
new file mode 100644
index 000000000000..d5c32c02accf
--- /dev/null
+++ b/board/alliedtelesis/x960/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Allied Telesis
+#
+
+obj-y	+= x960.o
diff --git a/board/alliedtelesis/x960/x960.c b/board/alliedtelesis/x960/x960.c
new file mode 100644
index 000000000000..66c782698ffa
--- /dev/null
+++ b/board/alliedtelesis/x960/x960.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier:    GPL-2.0+
+
+#include <config.h>
+#include <asm/global_data.h>
+#include <linux/io.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DEVICE_BUS_SYNC_CTRL	0xF27004C8
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	/* DEV_READYn is not needed for NVS, ignore it when accessing CS1 */
+	writel(0x00004001, DEVICE_BUS_SYNC_CTRL);
+
+	return 0;
+}
diff --git a/configs/x960_defconfig b/configs/x960_defconfig
new file mode 100644
index 000000000000..f03bca376aee
--- /dev/null
+++ b/configs/x960_defconfig
@@ -0,0 +1,104 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_X960=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xf80000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="cn9130-atl-x960-28ysq"
+CONFIG_SYS_LOAD_ADDR=0x10000000
+CONFIG_DEBUG_UART_BASE=0xf0512000
+CONFIG_DEBUG_UART_CLOCK=200000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run distro_bootcmd"
+CONFIG_USE_PREBOOT=y
+CONFIG_SPL_SILENT_CONSOLE=y
+CONFIG_TPL_SILENT_CONSOLE=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_UBI=y
+CONFIG_MAC_PARTITION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_IPV6=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+# CONFIG_INPUT is not set
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+# CONFIG_MMC is not set
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_PXA3XX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_ATMEL=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_GIGE=y
+CONFIG_E1000=y
+CONFIG_MVPP2=y
+CONFIG_PHY_MARVELL=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_MVEBU=y
+CONFIG_PHY=y
+CONFIG_MVEBU_COMPHY_SUPPORT=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_ARMADA_8K=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1307=y
+CONFIG_RTC_MAX313XX=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_SYS_NS16550=y
+CONFIG_KIRKWOOD_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/include/configs/x960.h b/include/configs/x960.h
new file mode 100644
index 000000000000..b9699518751e
--- /dev/null
+++ b/include/configs/x960.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Allied Telesis
+ */
+
+#ifndef __X960_H_
+#define __X960_H_
+
+/*
+ * High Level Configuration Options (easy to change)
+ */
+#define CFG_SYS_TCLK		250000000	/* 250MHz */
+
+/* additions for new ARM relocation support */
+#define CFG_SYS_SDRAM_BASE	0x00000000
+
+#define BOOT_TARGETS	"usb scsi pxe dhcp"
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"scriptaddr=0x6d00000\0"        \
+	"pxefile_addr_r=0x6e00000\0"    \
+	"fdt_addr_r=0x6f00000\0"        \
+	"kernel_addr_r=0x7000000\0"     \
+	"ramdisk_addr_r=0xa000000\0"    \
+	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"boot_targets=" BOOT_TARGETS "\0"
+
+#endif /* __X960_H_ */
-- 
2.54.0

