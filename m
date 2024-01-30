Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5596CC47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDC787D80;
	Tue, 30 Jan 2024 13:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChvFLsYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCA687C44; Tue, 30 Jan 2024 11:35:29 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FD08796E
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 11:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppighouse@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ddc1b30458so3323958b3a.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706610925; x=1707215725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=79Ldr126af2p6IhRGQAFww97a5z+iXTLxFVEAw1gyOU=;
 b=ChvFLsYv/DNzR/NmPMWU0WUtUViB/4cLx9EPGy2Wdhr/uwdiYLQ6yHXsNWe2duL6ny
 wg5QTesyCBokUuAJuZ1N8gUggHr6d4kW3yQhgfRMqRvfvDJ0To0HqTlQSZ+8CiirPW5I
 ccm3uwb//qu/TT/vYF6ZxsFDOxTcGtZVUIucNcZJVXhcLK4sZtg+Q2Vc/SBEl/VKRdyC
 eSx2EJ66q3JMLdAfkky0kpFxcHo3ZxPQANgv/9qZdVj2yhLsnotEQTbvS6RzjTzS8knx
 kkMmuv3phT9mxLTJZAKZKhQ6g5tc9O0/2IQ3fmxEna2tOujtQCakWRokmNejglw/9F1Q
 UEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610925; x=1707215725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79Ldr126af2p6IhRGQAFww97a5z+iXTLxFVEAw1gyOU=;
 b=XthfqJ6+JGeQDwUNpRpI1nNgQ6ulloxpq4T5ODpa2tjoPYpHv1N/R4Ddl5MbfJw//G
 kIhdCtoih+LM66W99mmAI0N5Oe4v4IR+Wki81ULOPYi4xoBGLDONNrPaIyS+xOUeWcXP
 Cbr/byWtbo6Bmi15vCUDG8cqpCZYcVEKDkncXt02w9aNSDZ87g+FM7skUZ6edslx2Orn
 zPSGIy7GH3snWWsTzEF0jaIvmf6FnWMYvwJWNLZN1TUa0pSH4EUino5MJODITNOc9fyR
 sGRJAdESJBYQjJFj6idzfTewZLjDJCiSgrq29qTm1tcWBPUTVOpisc+WnvUUfAtrW8F3
 x8zA==
X-Gm-Message-State: AOJu0YwdGYY3guOeCglI9DlWQPVmB5CXu6sovxMga8ajZojNrqgLAgud
 WXsh3YlkzqkAXy0zRZs6ptksQyjDXvI6CqzFcSCKC9e/HrKNWP0YQY5HqoXzZps=
X-Google-Smtp-Source: AGHT+IG3gZAMbjyIKVXuc3cLRY+bylc1VYEr/lcolGEUmNMs0ehXhS5XFT4lV4g5FHE0G24Ncjdd/g==
X-Received: by 2002:a05:6a00:2b4f:b0:6db:d1b4:1b27 with SMTP id
 du15-20020a056a002b4f00b006dbd1b41b27mr6095329pfb.4.1706610925179; 
 Tue, 30 Jan 2024 02:35:25 -0800 (PST)
Received: from localhost.localdomain ([124.218.12.74])
 by smtp.gmail.com with ESMTPSA id
 36-20020a630c64000000b005cf5cbac29asm7864287pgm.53.2024.01.30.02.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:35:24 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: u-boot@lists.denx.de
Cc: openbmc@lists.ozlabs.org, kelly_hung@asus.com,
 Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH] ARM: dts: ast2600: add dts for asus product
Date: Tue, 30 Jan 2024 18:35:19 +0800
Message-Id: <20240130103519.199646-1-Kelly_Hung@asus.com>
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

