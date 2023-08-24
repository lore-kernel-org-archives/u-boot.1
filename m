Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50989C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 01:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4983786434;
	Thu, 24 Aug 2023 03:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JiRvF51Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6703686439; Thu, 24 Aug 2023 03:18:27 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E98586427
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 03:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34ccedcc584so1211455ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692839902; x=1693444702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uxohqis76XBjMuGB/6928iQFezDe/OyIMeP0mh17CEU=;
 b=JiRvF51ZMrBUooxYFvKGVnyJcmXqtCASmP/vi8ZWZ0yrKi1NEAtJKzEJKQX58S7VJG
 kKZxXLrJLv5j3bV3vTqYty6jLgGIQiAqHxIm3HmfM1Lwj0EHymIY+a8RGtqIxPfcgpOu
 CbKnLSISV7TgIjiiW2W/83wjLfG70Y7AblQKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692839902; x=1693444702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxohqis76XBjMuGB/6928iQFezDe/OyIMeP0mh17CEU=;
 b=CPiJxclLsx5U4pMrTndF7R6Q6CEnDCLu7e3SovYml03u5qOEcMesUNQFFmnA+Uxmvr
 4iK/Phs/Aik5QG84zV+1O4OlK12Tcp9+qtDmdQ2a75HZLtUCmH1GNhzbXDJmGcmzSeM3
 k4UwWQJHjmBbSUrlMSsFdrdn5yGzenQrLC7MZFb03yX2VRrsOv65N2of1FEehICLQRI2
 /67TmoMQ7mOUgvApJa9FrfhFq4R+0gMHSIqZ0R3g+gfzjlIRU3X9cUyLFIGJnaeaRyi4
 K5ZEeWc5CVLyMIL7QaoVp5r/BigLUcO3gttDErgb2w15SUbfgVQqH2IdU6NrX9HTpJKC
 E2dw==
X-Gm-Message-State: AOJu0YylFreDzPtxuFsYbMA78Wr3Hrof3ujEY18rIFqwScfOIrwaWZ6P
 30y+NUuhP32BmK40LCWBRJlhRAzomMFfRcVCACo=
X-Google-Smtp-Source: AGHT+IFj2fJJ54g8L8dnz0+XVOFfu9plyuaxAoeokf0Y5yq8eOfciY3b66wMQ917WYV6AfKB1zx0JA==
X-Received: by 2002:a92:c567:0:b0:346:390a:1ce6 with SMTP id
 b7-20020a92c567000000b00346390a1ce6mr3642383ilj.8.1692839902083; 
 Wed, 23 Aug 2023 18:18:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 g10-20020a0566380c4a00b0042b3bf0baacsm4053793jal.138.2023.08.23.18.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:18:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>, Stefano Babic <sbabic@denx.de>,
 Su Baocheng <baocheng.su@siemens.com>
Subject: [PATCH 1/2] imx: Drop unneeded phandle in FIT template
Date: Wed, 23 Aug 2023 19:18:01 -0600
Message-ID: <20230824011804.1501058-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

Adding a phandle to a template node is not allowed, since when the node is
instantiated multiple times, we end up with duplicate phandles.

Drop this invalid constructs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi | 2 ++
 arch/arm/dts/imx8mm-u-boot.dtsi                   | 2 +-
 arch/arm/dts/imx8mn-u-boot.dtsi                   | 2 +-
 arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi        | 2 ++
 arch/arm/dts/imx8mp-u-boot.dtsi                   | 4 ++--
 arch/arm/dts/imx8qm-u-boot.dtsi                   | 2 +-
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi      | 8 ++++----
 7 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi b/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
index 484e31824b85..d93e1cbd8a71 100644
--- a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
@@ -41,9 +41,11 @@
 	};
 };
 
+/* This cannot work since it refers to a template node
 &binman_configuration {
 	loadables = "atf", "fip";
 };
+*/
 
 &fec1 {
 	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 035282bf0b00..6085128e24ec 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -140,7 +140,7 @@
 			configurations {
 				default = "@config-DEFAULT-SEQ";
 
-				binman_configuration: @config-SEQ {
+				@config-SEQ {
 					description = "NAME";
 					fdt = "fdt-SEQ";
 					firmware = "uboot";
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 5046b38e4e29..bc57566a108f 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -204,7 +204,7 @@
 			configurations {
 				default = "@config-DEFAULT-SEQ";
 
-				binman_configuration: @config-SEQ {
+				@config-SEQ {
 					description = "NAME";
 					fdt = "fdt-SEQ";
 					firmware = "uboot";
diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
index f3fb44046d5c..c4ea536b29bb 100644
--- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
@@ -162,6 +162,8 @@
 	};
 };
 
+/* This cannot work since it refers to a template node
 &binman_configuration {
 	loadables = "atf", "fip";
 };
+*/
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 36e7444a627b..200938a98072 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -146,7 +146,7 @@
 					type = "flat_dt";
 					compression = "none";
 
-					uboot_fdt_blob: blob-ext {
+					blob-ext {
 						filename = "u-boot.dtb";
 					};
 				};
@@ -155,7 +155,7 @@
 			configurations {
 				default = "@config-DEFAULT-SEQ";
 
-				binman_configuration: @config-SEQ {
+				@config-SEQ {
 					description = "NAME";
 					fdt = "fdt-SEQ";
 					firmware = "uboot";
diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-boot.dtsi
index a3e0af48109b..d316e869516f 100644
--- a/arch/arm/dts/imx8qm-u-boot.dtsi
+++ b/arch/arm/dts/imx8qm-u-boot.dtsi
@@ -112,7 +112,7 @@
 			configurations {
 				default = "@config-DEFAULT-SEQ";
 
-				binman_configuration: @config-SEQ {
+				@config-SEQ {
 					description = "NAME";
 					fdt = "fdt-SEQ";
 					firmware = "uboot";
diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index 3ecb461b0110..64318d09cf0a 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -41,7 +41,7 @@
 					os = "arm-trusted-firmware";
 					load = <CONFIG_K3_ATF_LOAD_ADDR>;
 					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
-					atf: atf-bl31 {
+					atf-bl31 {
 					};
 				};
 
@@ -53,7 +53,7 @@
 					os = "tee";
 					load = <0x9e800000>;
 					entry = <0x9e800000>;
-					tee: tee-os {
+					tee-os {
 					};
 				};
 
@@ -78,7 +78,7 @@
 					compression = "none";
 					load = <CONFIG_SPL_TEXT_BASE>;
 					entry = <CONFIG_SPL_TEXT_BASE>;
-					u_boot_spl_nodtb: blob-ext {
+					blob-ext {
 						filename = "spl/u-boot-spl-nodtb.bin";
 					};
 				};
@@ -88,7 +88,7 @@
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
-					spl_am65x_evm_dtb: blob-ext {
+					blob-ext {
 						filename = "spl/dts/k3-am65-iot2050-spl.dtb";
 					};
 				};
-- 
2.42.0.rc1.204.g551eb34607-goog

