Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C51C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0B687F25;
	Wed, 13 Mar 2024 11:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbxlWx1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D470D875FA; Wed, 13 Mar 2024 11:27:41 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1506D87B82
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppighouse@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d944e8f367so7346975ad.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710325656; x=1710930456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNKdIJK1p9MJ23nCnTh6b8pdxKFP2N/HtsbD5LhKpPU=;
 b=jbxlWx1qGtxofFix8+EEC9QaRbFVh72AwDHb/bI7XRrYjrVQ+EF8Qkuy8n3fHpm8gE
 5B0kSau2Vk69/s7MB6ALCaZmo9s3ZOUR7kvmE4J4N2tmb0+a1gdN4dgtHOxdW1AuRk35
 dfg8h95EzgoSddYYHZOvxvHJ2HDfPu1i+TyIKWsRNpVtnwyTi1plbRRMKOxI+MZoe/O6
 iBPhz6QHP1wYcv0O9AJFAQRosMzdO02vvNcGpP5bNQok1SpkfIdTZEs/eIs6K9VC4n8L
 WwGKP40By8+n8TQt9w45tvLFExDE8xxfMN4TbpoKoDN+xU6zmXtwdtyApcMA0x8E2uCj
 +OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325656; x=1710930456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNKdIJK1p9MJ23nCnTh6b8pdxKFP2N/HtsbD5LhKpPU=;
 b=jz8BZZtgJpZUb6hKvGFEcuY/lWd7bsLAv4MXx7OieaTnvd33q0r7tY3z+Wkzlp5FPD
 eSglr/FJFBmWAKQZ8W0EF0S3FRK4E081WzKBozYkvk9WjkZYcrO2pzG3+r1S8W+ZcSVm
 B7Py57aqKtkv40QunKuYgQwkcu3EY0OuIv5oQ3ZFv/Au2dl+i05ZkWE7ff1to79PZDVc
 y0iugI0PoOrG/pJX1qLKnwmt2+SHn0EdfXR5kJPR5Diu8ZGrUuABbHXdNn8vDm227oDD
 Lt8hm6ODFx/VXWINNCnjXuhHeiOuP9XJUA8Cq+x0JYxYW1dQTk/Jgp8M7phmmfS4xowi
 IkOg==
X-Gm-Message-State: AOJu0YzrEbdZwRJqz2ZOGilojX9wcCOYBhjJrLOtHIvlB4Ov1u5awMxq
 1aNf5ffyT6r+KgA8uuzUCKWsekpwhbZsTKJiPx9mglD+jAThVcwya49KGnZSZ0k=
X-Google-Smtp-Source: AGHT+IFfnqqu+8B9t9lRX6CFSz9OA77aaVCcKKhEWsLHcsgyFUIfNfB+AygVrDBczjXp0n1LxNUX7w==
X-Received: by 2002:a17:902:a386:b0:1dd:b3ef:4528 with SMTP id
 x6-20020a170902a38600b001ddb3ef4528mr2361299pla.52.1710325656391; 
 Wed, 13 Mar 2024 03:27:36 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net.
 [125.229.150.10]) by smtp.gmail.com with ESMTPSA id
 jz3-20020a170903430300b001db63cfe07dsm8249282plb.283.2024.03.13.03.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:27:35 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, michal.simek@amd.com,
 marex@denx.de, neil.armstrong@linaro.org, jonas@kwiboo.se,
 cnsztl@gmail.com, clamor95@gmail.com, hai.pham.ud@renesas.com,
 naoki@radxa.com, patrick.delaunay@foss.st.com, christianshewitt@gmail.com,
 openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com,
 Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH next v1 1/1] arm: dts: ast2600-x4tf: Add new dts for ASUS X4TF
Date: Wed, 13 Mar 2024 18:27:25 +0800
Message-Id: <20240313102725.2067651-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313102725.2067651-1-Kelly_Hung@asus.com>
References: <20240313102725.2067651-1-Kelly_Hung@asus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 11:56:10 +0100
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

This is the new bmc dts for ASUS X4TF server.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
V1: Add a new bmc dts for ASUS X4TF server.
---
 arch/arm/dts/Makefile         |   4 +-
 arch/arm/dts/ast2600-x4tf.dts | 161 ++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/ast2600-x4tf.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 784192125d..ebbc0b21fc 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1359,7 +1359,9 @@ dtb-$(CONFIG_BCM6878) += \
 	bcm96878.dtb
 
 dtb-$(CONFIG_ASPEED_AST2500) += ast2500-evb.dtb
-dtb-$(CONFIG_ASPEED_AST2600) += ast2600-evb.dtb
+dtb-$(CONFIG_ASPEED_AST2600) += \
+	ast2600-evb.dtb \
+	ast2600-x4tf.dtb
 
 dtb-$(CONFIG_ARCH_STI) += stih410-b2260.dtb
 
diff --git a/arch/arm/dts/ast2600-x4tf.dts b/arch/arm/dts/ast2600-x4tf.dts
new file mode 100644
index 0000000000..4bf4b66a9c
--- /dev/null
+++ b/arch/arm/dts/ast2600-x4tf.dts
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2024 ASUS Corp.
+/dts-v1/;
+
+#include "ast2600-u-boot.dtsi"
+
+/ {
+	model = "AST2600 ASUS X4TF";
+	compatible = "aspeed,ast2600-asus", "aspeed,ast2600";
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
+
+		cpu@1 {
+			clock-frequency = <800000000>;
+		};
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&sdrammc {
+	clock-frequency = <400000000>;
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&wdt3 {
+	status = "okay";
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
+
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
+&hace {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "disabled";
+};
+
+&i2c13 {
+	status = "disabled";
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&display_port {
+	status = "okay";
+};
-- 
2.25.1

