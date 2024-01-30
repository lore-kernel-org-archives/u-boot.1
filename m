Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDD5C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A667687D8C;
	Tue, 30 Jan 2024 13:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDaiP4tU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D453D87C44; Tue, 30 Jan 2024 11:40:54 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F365877AF
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 11:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppighouse@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d74045c463so20023015ad.3
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706611250; x=1707216050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=79Ldr126af2p6IhRGQAFww97a5z+iXTLxFVEAw1gyOU=;
 b=KDaiP4tUYp12D2/38M+Rp94yVbb0PMTJ+mP+F80XE0BTZrIiNRUEJnhf8UxciBi6Yk
 m2YhQvi4rnlqIXf8cAVKlJU1rAZj88/3efvgcQZUcFzO/HIKk8AclJg1XQOuLD/YIz5m
 bf5eGG598vcrdcNTDQBDHelffh/vfu8hALiEisVSRSfSKKIzWFYWRI2ymin3NqCCnV+0
 9z5U6vp93qSduNBioHJCKyr9ixG29ufE69AzufgmkO81wca+nfxJCcY619u21ItZ2REK
 FdnY4uxZOAhZdvlOze5bc2D5kuE/eINNtZrWLWjMIrHZfJw0pKdLveRNgLHglmBF99Ca
 vVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706611250; x=1707216050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79Ldr126af2p6IhRGQAFww97a5z+iXTLxFVEAw1gyOU=;
 b=wtFwGb4WtJQB2zGNHE62M3VAy17YGCpBCJ8YSBfFRTZexKJ/oEY9Pk5qDOa8bK4azI
 MZzEkLjJT4AJhNsF6OzdcuAer3ckCflCy9FaZZO9EDsr8LeEAQ1r8vNOmBzbK8s8jldd
 /1b8V6YKDYk/CIpJ3fHBQBjAMSUAlYcVJ800z0Jh2COyyRlHIDvSv88/VcZF9jIf1el4
 Ch5VbXhaZFaVMZy6zGkyFYM0nAlJyZnAD/0xf0TXEiMCR+oIMeLstbI/BAxkNZlIj3UZ
 1LDaantt2fTg9DvM8UwlLVsNlcIpbEVPSNhYU4MWtAwSMUf9NB1+gMFIEPgmkk4H5AFy
 ftYQ==
X-Gm-Message-State: AOJu0YymTUGt54xqBm+jJfuDPfehv81UgCQGySI98HF24nbFdeNM8Zej
 SraMTEr/Gy519JQnO+AxNsoh0wtdRwJKfuOtW2a4kRJ8XiU54pkfd4FIU9LZX6g=
X-Google-Smtp-Source: AGHT+IE7uu8+wo+5kHWQILEBLhyyXFL5yhJpFeBR9YxETUCzWm2S7aBrjkRQG4eEmrGzqIDw8AElbQ==
X-Received: by 2002:a17:903:2581:b0:1d9:f6e:a1a8 with SMTP id
 jb1-20020a170903258100b001d90f6ea1a8mr662844plb.53.1706611249986; 
 Tue, 30 Jan 2024 02:40:49 -0800 (PST)
Received: from localhost.localdomain ([124.218.12.74])
 by smtp.gmail.com with ESMTPSA id
 jk5-20020a170903330500b001d740687d1csm3994672plb.193.2024.01.30.02.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:40:49 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: u-boot@lists.denx.de
Cc: openbmc@lists.ozlabs.org, kelly_hung@asus.com,
 Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH] dts: ast2600: add x4tf dts for asus product
Date: Tue, 30 Jan 2024 18:40:45 +0800
Message-Id: <20240130104045.199879-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jan 2024 13:53:57 +0100
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

This initial device-tree provides the necessary configuration for
basic BMC functionality and work on ASUS X4TF production.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 arch/arm/dts/Makefile         |   3 +-
 arch/arm/dts/ast2600-x4tf.dts | 239 ++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/ast2600-x4tf.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 37675a32..6d4a6ed0 100755
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -698,7 +698,8 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	ast2600-slt.dtb \
 	ast2600-tacoma.dtb \
 	ast2600-intel.dtb \
-	ast2600-tacoma.dtb
+	ast2600-tacoma.dtb \
+	ast2600-x4tf.dtb
 
 dtb-$(CONFIG_ARCH_STI) += stih410-b2260.dtb
 
diff --git a/arch/arm/dts/ast2600-x4tf.dts b/arch/arm/dts/ast2600-x4tf.dts
new file mode 100644
index 00000000..3c478058
--- /dev/null
+++ b/arch/arm/dts/ast2600-x4tf.dts
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2020 IBM Corp.
+/dts-v1/;
+
+#include "ast2600-u-boot.dtsi"
+
+/ {
+	model = "AST2600 ASUS";
+	compatible = "aspeed,ast2600-evb", "aspeed,ast2600";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	aliases {
+		spi0 = &fmc;
+		ethernet0 = &mac2;
+		ethernet1 = &mac3;
+	};
+
+	cpus {
+		cpu@0 {
+			clock-frequency = <800000000>;
+		};
+		cpu@1 {
+			clock-frequency = <800000000>;
+		};
+	};
+};
+
+&uart5 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&sdrammc {
+	clock-frequency = <400000000>;
+};
+
+&wdt1 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&wdt2 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&wdt3 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <	&pinctrl_mdio3_default &pinctrl_mdio4_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ethphy2: ethernet-phy@2 {
+		reg = <0>;
+	};
+
+	ethphy3: ethernet-phy@3 {
+		reg = <0>;
+	};
+};
+
+&mac2 {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor", "macronix,mx66l2g45g";
+		status = "okay";
+		spi-max-frequency = <25000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+
+	flash@1 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <25000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&emmc_slot0 {
+	status = "okay";
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emmc_default>;
+};
+
+&hace {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&acry {
+	u-boot,dm-pre-reloc;
+	status = "disabled";
+};
+
+&i2c0 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+};
+
+&i2c1 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_default>;
+};
+
+&i2c2 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_default>;
+};
+
+&i2c3 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4_default>;
+};
+
+&i2c4 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c5_default>;
+};
+
+&i2c5 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c6_default>;
+};
+
+&i2c6 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c7_default>;
+};
+
+&i2c7 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c8_default>;
+};
+
+&i2c8 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c9_default>;
+};
+
+&i2c9 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c10_default>;
+};
+
+&i2c10 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c11_default>;
+};
+
+&i2c11 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c12_default>;
+};
+
+&i2c12 {
+	u-boot,dm-pre-reloc;
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c13_default>;
+};
+
+&i2c13 {
+	u-boot,dm-pre-reloc;
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c14_default>;
+};
+
+&i2c14 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c15_default>;
+};
+
+&i2c15 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c16_default>;
+};
+
+&display_port {
+	status = "okay";
+};
-- 
2.25.1

