Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33A0C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5235F8069D;
	Fri, 17 Jan 2025 02:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iUbNUpao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FCE806FB; Fri, 17 Jan 2025 02:57:35 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C76980312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so28569945ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 17:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737079052; x=1737683852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Oy0OUK0Eb9ouqYWoSkEn7G7OVyYBPPlE65VZtBHMWE=;
 b=iUbNUpaoNYs+lmOYqoPiAwXtzSS5cFV4qEh+dt9CuT/+bjvBZCD3yn5sXrCjzvjbqX
 c/8lMvXWyHCT7XbaqAz+ESJB2fRDCZS7XnXQ/o6TUCGABaYFZ7FIby/3sNikvp09CPLo
 VpfnnGETCFvgoWQk9FH+FEvis04btMmsyCqxZ6BLl0oowgYD2Fus/iWGx/zjR4f5EHr8
 NIsHx4tCGTMUF03uTMx3T4PtXs2sljQAxwP0YukDZC3ClRB3EZBVZErITtsflbKuCTt4
 Z2c9SujkjHAfPDwp4jwvNQXkxjgx/9wCMmJE0eE4yO4kqR+p9jV3PMNB2mHK8MM/HFk6
 QeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737079052; x=1737683852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Oy0OUK0Eb9ouqYWoSkEn7G7OVyYBPPlE65VZtBHMWE=;
 b=mrqwFAIv4+RkBo10sQuEMJ8Ykvlz3JwukRJ9WNF1WfRmy19XkEu17sb3UtUHyYVr6Y
 zVZ9luKELXB/hW4aok77d36yJEHw/D6xnsSFw+j2eqOi/ljIP7vkio7SUXXF8M99Y/ad
 U15I0C6m7CFY3EhLw31iob5mnij3QyfXBFPnvccNeuDrYrhXOUPYxVCqDWQr8r0B7/3G
 oIPEsKhYm1BObLVNz2I3f+TbH7BPekmhcvBEO2ESmlgFgMmHHXdT1QK4S28Wpur6s7rm
 jNBhatZBLTDNrfuccaabdgQOWq6nxYAuHmGzENcZFGQSko1C6JBtb67tZ39v8QAutVjo
 6t2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJM6Z3GAswJwwPbQiB/WjU6dtSrN1Ka4TtC4xQ/h0Xx4jaPstUvzL7s6rq7/sr4lKnza2pBrQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt/6FudKnBFXXqmam9hNmN4Zr7NH41vLpsONe4VWdJoYbGHkKG
 JGUCURac4z8nTZdmomqXWN9/BUDoyHEjLVOKiqry4LX34NSuhthX
X-Gm-Gg: ASbGncuJL/+yOSNAO3qLriXJDBOvtglAYcpe7HXGFYzjrYBI7SU9/JB5H7pek6OSiOd
 WtWxF8RJ2Yc2R4vsZ8i2sTiWD9GC1Y0qkDHRwZNTrGfkPtvmhe4a+n99uVwENw1IOq1DdgckhGo
 9yDXfcsk9t1WN+hId2y2V2tWrBpaywaVQGMBXyI/tYDSP64nGhaGE93H8eTIklZPhUpfraFOCKH
 O7AL+xa5yXPLRhRiDVU9pFHLpVewjhBqZp6VrLhvuvURNjSkvsCPi7K9rTh7K2dYPIAwpY=
X-Google-Smtp-Source: AGHT+IGaXRoqgHHEI3zfewPhsYZwiGEJilG/bZ/ZIhOJNoiJPxiGDRAfTx8jS/3RheD39aF8VODZEw==
X-Received: by 2002:a05:6a20:8724:b0:1e1:bd5b:b84b with SMTP id
 adf61e73a8af0-1eb215fb386mr1063982637.40.1737079051913; 
 Thu, 16 Jan 2025 17:57:31 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b1a4:73e9:7e6a:ebcd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba4eaacsm692964b3a.135.2025.01.16.17.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 17:57:31 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: uboot-imx@nxp.com, peng.fan@nxp.com, y.moog@phytec.de,
 u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE 
Date: Thu, 16 Jan 2025 22:56:42 -0300
Message-Id: <20250117015642.2373824-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Guard binman nodes with CONFIG_OPTEE to fix the following error
when building without optee support:

  BINMAN  .binman_stamp
Image 'image' has faked external blobs and is non-functional: tee.bin

Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Some images are invalid
make: *** [Makefile:1135: .binman_stamp] Error 103

While at it, only pass tee to the loadables lines when CONFIG_OPTEE is
defined.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes since v1:
- Also guard the loadables line. (Tim)

 arch/arm/dts/imx8mm-u-boot.dtsi | 6 ++++++
 arch/arm/dts/imx8mn-u-boot.dtsi | 6 ++++++
 arch/arm/dts/imx8mp-u-boot.dtsi | 6 ++++++
 arch/arm/dts/imx8mq-u-boot.dtsi | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index ecc2319279ea..8608fa004fdc 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -164,6 +164,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -178,6 +179,7 @@
 							optional;
 						};
 					};
+#endif
 
 					binman_fip: fip {
 						arch = "arm64";
@@ -207,7 +209,11 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 4a4498b36b01..bf2bb0f17c77 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -240,6 +240,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -254,6 +255,7 @@
 							optional;
 						};
 					};
+#endif
 
 					binman_fip: fip {
 						arch = "arm64";
@@ -283,7 +285,11 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 9ede98a11e42..9e590c3bba07 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -185,6 +185,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -199,6 +200,7 @@
 							optional;
 						};
 					};
+#endif
 
 					@fdt-SEQ {
 						description = "NAME";
@@ -219,7 +221,11 @@
 						fdt = "fdt-SEQ";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 93e2ef27f7ce..458657fc4749 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -144,6 +144,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -158,6 +159,7 @@
 							optional;
 						};
 					};
+#endif
 
 					fdt {
 						compression = "none";
@@ -179,7 +181,11 @@
 						fdt = "fdt";
 						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
 						loadables = "atf", "tee";
+#else
+						loadables = "atf";
+#endif
 #endif
 					};
 				};
-- 
2.34.1

