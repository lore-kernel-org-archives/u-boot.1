Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192AFC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E1C87F05;
	Wed, 13 Mar 2024 11:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtbHXQXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806348644E; Wed, 13 Mar 2024 10:27:37 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CD487DF9
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 10:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppighouse@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6b54a28d0so576419b3a.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710322052; x=1710926852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rJX05Kk9UWVVyQP9OuJCMUblu+Bdscs2MIKBAKq6AU=;
 b=KtbHXQXjESPwF7Q415CY9RxqklyIU7QQUXBhnkfafAvnGf7Fzzr4UT43EKA2iRoDk0
 G0sWaV/INrpfSZlyIX8UC5hmY2geUwew7odfOSorcbGl15X8omBDin6cG6sINMOynLd8
 uoEhhPnFO2kYrZzQdRJ2ux4AjY4y5XsYQqKRrXFtKRxc3dk3E4oKOkYW5OtMGqNOtsOO
 P97fRkBq5mzans4uCdzUnrb7XQ5HycCqeG/cWNlvEEX492QHancKAnPps2jvEN+TnkaO
 D0E9516mpdIqgF1mCRWYplrFRFCm0E1B287BLwaz6g6nQA8rCn+wzFLHanYpQCEEg2+0
 oo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710322052; x=1710926852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rJX05Kk9UWVVyQP9OuJCMUblu+Bdscs2MIKBAKq6AU=;
 b=I4yRGY5F4TbKuddpvEcKQaRe1oubsktCHOff+ft+9RffKlKOO0AsCAvevothopo/rd
 Ylo+HcXfdH0T7xgaCmnJ2dKaKmjf9xtRyb/DfVjKjLNlrytEChiZ52VLOL++HzXxCK1s
 4M+ByVOKRWrZaKPXAirZHnBlzuHXWNaUiIuAfVreTb23uuSYjbuHqE2SQXIgZLsv+GfN
 SJx5ply8pQ3Ff12OcHXaE6lV3kyJRtNpf40deaLEg3wsgP/JN9EdKdf9ZjaTfEu42y+Q
 X83tBi2gBtcGj3+0AqYzHD0GQtu5T5qjUHC0416uli1DAasMrdi7wiPV0kGj8c2PvmxS
 atHQ==
X-Gm-Message-State: AOJu0Yy8ZsztwmCHGN2SvgjffHDLt4iN2EhiC7DZuK++uUg7BlFzKc1A
 D6VIl9AsPsv+bPnb6e2Lj5JohGnQmdOB8VY/wOcZBmmZUvctgNV/YoioSedstqI=
X-Google-Smtp-Source: AGHT+IF3vV2N2ArmyrTGEhpNSnjoOp88qcL3K4JfYPHV6qjcS2waumytjRR5T8hvLmlbcyoWmUTWyA==
X-Received: by 2002:a05:6a20:3c8a:b0:1a1:4cd2:40a4 with SMTP id
 b10-20020a056a203c8a00b001a14cd240a4mr11616103pzj.6.1710322052450; 
 Wed, 13 Mar 2024 02:27:32 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net.
 [125.229.150.10]) by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001dc3916853csm8177461pli.73.2024.03.13.02.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 02:27:32 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, michal.simek@amd.com,
 marex@denx.de, neil.armstrong@linaro.org, jonas@kwiboo.se,
 cnsztl@gmail.com, clamor95@gmail.com, hai.pham.ud@renesas.com,
 naoki@radxa.com, patrick.delaunay@foss.st.com, christianshewitt@gmail.com,
 kelly_hung@asus.com, Allenyy_Hsu@asus.com, Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v1 1/1] arm: dts: ast2600-x4tf: Add new dts for ASUS X4TF
Date: Wed, 13 Mar 2024 17:27:21 +0800
Message-Id: <20240313092721.2066531-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313092721.2066531-1-Kelly_Hung@asus.com>
References: <20240313092721.2066531-1-Kelly_Hung@asus.com>
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
index b102ffb5f6..d91b71e109 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1366,7 +1366,9 @@ dtb-$(CONFIG_BCM6878) += \
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

