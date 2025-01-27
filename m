Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E8CC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E94F48129F;
	Mon, 27 Jan 2025 14:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+mpDvaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703E38128B; Mon, 27 Jan 2025 14:41:20 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E3381221
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so3914822f8f.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985278; x=1738590078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zo2bEjJmpT3dUZKU1ej6VFRJjLdawvYAYDBFsQYULY0=;
 b=m+mpDvaa94B/vsZw6j/5RzGuF36wrgROEeB7FApTrfTnvhQvxKkc185JirXXf6auPV
 Os4s+IKYzuohV3alzDqd0kbfFbXlGi82xPZhuKTYnuIzXBqwckPn+/S1NmX7JgQuPEqJ
 wKa0dR7dS9409T3BhTztsklSnlgjcCZxxUWvifjAKaQZ6RhFSFixTwn3Xlgk40gRRmwj
 h2nfxaf43S+CYd4MryZtBBYJMeO0bzbgqcSv99YCGFaJhwgB3UpxRPunD0Z6Z2DUj29U
 biUhiBQTjT47YO4Wn2mnkkjPOOniE55iQzR0RAnnIUMUoX4hoIlzQspm3msfzTwmMyLs
 C4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985278; x=1738590078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zo2bEjJmpT3dUZKU1ej6VFRJjLdawvYAYDBFsQYULY0=;
 b=Z14kCAkXyvg/VAPdtniq3tjRPwjquGtBHvtTGAbrZnyjFYwQlm6omagJtTjALUl7Ml
 EL6+R/rOm9MFO5FKYcdPQZCjMctiZTvNiHvY1U/86TcAMQcZoTmr+sM0UwW6bEqpU8aX
 4jay7gIz7zNiO9cFZsrfL1EjT2Bqj3oITUOodm9afYLsd76NbpkWayquRrePmkinRyB+
 FlUqDO/akhHffldVQ3+jPhY0qkTRkL5M4bnw04HKRdnkVOoUiH7VHrjBdmtpPF2na36X
 rqUV829vdcWhlh5ouhSk3VEGreaddjZ/DFE8XIBEJmOVQzmxp2PpurAeZbffP5MQB41Z
 8k6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlNL18IwOiOVcOr2CQ6KwiJjUn3dZR2c0d5E/772vbDQz+4MgLatBn7DdBKGkTAFtG0S+rXxY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0AFKilhIY0EypKEH/H8qWRMxlDqqpQCWlYyQ3YOdggvfcNJcY
 u61K3SPTt/72qvw2IBfRhoO7zEU4bfsebc1pfAesMDnZzToTUiBkYAn85A==
X-Gm-Gg: ASbGncuF77MbCWBIecENq2cKcHMapQ1a3niI0T9l90K8NpEwge53A1HCMZQfYDVq74k
 PNQJpm+vGflqtrev16lYBVkv1a1P1H5SfkJR4FFzDB2qxWvGXsA8qTwpeCjw8NUF6DYtSAve35P
 vEwTGwjcN+APnaUQ/M9zORHWaSZuRH8mFhr9hc6gxLO7e1fQGMB1w2XujMlBraqotoVSZp2J+ag
 2ZXUo8Ikqs3tOANoIXWMBdIme4IT473fQYwRAiIgpaMV0HuLflc7uGwEGGFNchkT8weiw/tE0XQ
 VCVGY6HUVSt3Ut0u8m425SuLBIZqh3vGtIDdJTENJO2UmSr/pTDFqeYh9Qrt
X-Google-Smtp-Source: AGHT+IF4vmHTWldXM3YcycE53uOSwWmcUwxId34dLAxPB7vE3I0GMfZD3ZVBluumBsqBfC8jNtgasg==
X-Received: by 2002:a05:6000:1fa4:b0:38a:888c:7df1 with SMTP id
 ffacd0b85a97d-38bf5677fb4mr40159702f8f.11.1737985277633; 
 Mon, 27 Jan 2025 05:41:17 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:17 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 6/8] mediatek: mt7981: move gpio-controller up and rename
 pinctrl to pio
Date: Mon, 27 Jan 2025 14:40:43 +0100
Message-ID: <20250127134046.26345-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

Move gpio-controller up to pinctrl node and rename label to "pio" to
match the label used in upstream kernel linux.

Update any DTS that reference the pinctrl to follow the new naming and
structure.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981-emmc-rfb.dts | 4 ++--
 arch/arm/dts/mt7981-rfb.dts      | 4 ++--
 arch/arm/dts/mt7981-sd-rfb.dts   | 4 ++--
 arch/arm/dts/mt7981.dtsi         | 8 +++-----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/mt7981-emmc-rfb.dts b/arch/arm/dts/mt7981-emmc-rfb.dts
index d6590f01cf8..67f178bc232 100644
--- a/arch/arm/dts/mt7981-emmc-rfb.dts
+++ b/arch/arm/dts/mt7981-emmc-rfb.dts
@@ -48,7 +48,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 39 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -56,7 +56,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spic_pins: spi1-pins-func-1 {
 		mux {
 			function = "spi";
diff --git a/arch/arm/dts/mt7981-rfb.dts b/arch/arm/dts/mt7981-rfb.dts
index d6ebd6539c3..08e1b76b473 100644
--- a/arch/arm/dts/mt7981-rfb.dts
+++ b/arch/arm/dts/mt7981-rfb.dts
@@ -39,7 +39,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 39 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -47,7 +47,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spi_flash_pins: spi0-pins-func-1 {
 		mux {
 			function = "flash";
diff --git a/arch/arm/dts/mt7981-sd-rfb.dts b/arch/arm/dts/mt7981-sd-rfb.dts
index 2adbc374725..2f43e65ac5b 100644
--- a/arch/arm/dts/mt7981-sd-rfb.dts
+++ b/arch/arm/dts/mt7981-sd-rfb.dts
@@ -48,7 +48,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 39 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -56,7 +56,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spic_pins: spi1-pins-func-1 {
 		mux {
 			function = "spi";
diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 3c8b9ab0574..b2c4cd7b54a 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -106,7 +106,7 @@
 		bootph-all;
 	};
 
-	pinctrl: pinctrl@11d00000 {
+	pio: pinctrl@11d00000 {
 		compatible = "mediatek,mt7981-pinctrl";
 		reg = <0x11d00000 0x1000>,
 		      <0x11c00000 0x1000>,
@@ -120,10 +120,8 @@
 		reg-names = "gpio", "iocfg_rt", "iocfg_rm",
 			    "iocfg_rb", "iocfg_lb", "iocfg_bl",
 			    "iocfg_tm", "iocfg_tl", "eint";
-		gpio: gpio-controller {
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 
 	pwm: pwm@10048000 {
-- 
2.47.1

