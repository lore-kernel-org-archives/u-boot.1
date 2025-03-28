Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D11C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACAB81E06;
	Fri, 28 Mar 2025 16:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ScirF68r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF4781F00; Fri, 28 Mar 2025 16:36:01 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FB781E60
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d57143ee39so19823185ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176157; x=1743780957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucVkqIQqdMlvMjIHtkrZl/HKBFA12X5KipEQPlZIyKA=;
 b=ScirF68rwqSe03F3i291mVni9xZ9HlfYq+rSnnigQMj6UWW3cfPPTiCQexRaYpwC6O
 lHASamdV8kHy9aiVjY2JRHkanSlwnMjwI59sAFznAyV3s67lGEVediKWv52qrydNNg4T
 fhrYyQt74uxoDueHcVXKhntyoCK5CAIgXRSC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176157; x=1743780957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucVkqIQqdMlvMjIHtkrZl/HKBFA12X5KipEQPlZIyKA=;
 b=mPRq9ETvbW2ZWgVOpWOWlv3zyRoedWPMfqLcwJOG729tAzrGAlKqeqJNtcxfadn9Pz
 ouy0Q4NpuZp1tadlPuP+Z4jAnUdHJEEDgI4190K7+WqQdhJvcBGGsTyS4XJA7A33rGXm
 BqGSHlet7mbO0tG2ZTgSThm5Je6NKoWfFhW+Imiq6ZN0+e14YX+eg6ONGtcIOtfOb+N+
 T/5KRnkeViSSXu7xYB0h3obymuCFB7K7dDSSDMV8sjgRQKMH3U9xygYK7TcSyg3FJW/C
 Y3wdkqtY29PNbKYf/cxHxcf4O2OWLpUY288eGP7v0uandbIhrKZRHqCEO7FNbtJtYvPW
 RKSw==
X-Gm-Message-State: AOJu0YxxyVlWgxEV50ddm07zxP2/nFkPKVNnuCQv2r8ILa/vnUuRMV06
 +uUcD2B2sBYzDG9R4akft7Nql8QpGQLYaQIiloiNHhxtkZ2tjDi/5ZG+lK5zI3jJgWEb+O0Onfg
 =
X-Gm-Gg: ASbGnct/5X7T74lD88ADAs8d4/wnmQ9SNQeGS+/DLkOmDhe9DOt3pG11t4/I5uC/bIL
 5ZCN2u2YLTjxGJ6jOIGB128a+v67wBx7n1L/8KtPzFNeIn/NnAhFovetX+T0/8r4SjedCUmG1JL
 uY5V1vwrngZkGMIuVtYAsLb0qT5wbxEs9gMy87qaX7iS/SYUG220yYG/F87jJR7gFR9UNWQmwoQ
 6gkLgwPrHtG55hJJPuAxG/ukDqAFNTvdJAZpEbTnAad/EQwUWYDg0Zi8tqsy9x06hyx7rSliLOj
 fRTyMetcnA5qvQrjVz0okIq4kVruepuUdhGOMslkfW41WErph9L6DVgpIwnCLc8MQ0vBNA8Lgeg
 b5kJi1w==
X-Google-Smtp-Source: AGHT+IG7Ss7/61WtDVLLUEZQ4BJ3c0t/pPsL52wIhKERmq3d81UFmLfLgQymhZWJcoXffDW6ljPViw==
X-Received: by 2002:a05:6e02:1948:b0:3d4:35d3:87d3 with SMTP id
 e9e14a558f8ab-3d5ccdc5bf5mr92379505ab.4.1743176157076; 
 Fri, 28 Mar 2025 08:35:57 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 08/31] rockchip: dts: Create a template for the FIT
Date: Fri, 28 Mar 2025 09:34:48 -0600
Message-ID: <20250328153522.3555472-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Move the FIT description into a template so that it can (later) be used
in multiple places in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes in v3:
- Use HAS_FIT for the SPI node also
- Leave fit { node open within #ifdef HAS_FIT
- Move placement of CONFIG_SPL_PAD_TO
- Keep the FIT filename

 arch/arm/dts/rockchip-u-boot.dtsi | 61 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8aea2e6f571..460bf15e003 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,6 +19,10 @@
 #define COMP	"none"
 #endif
 
+#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
+#define HAS_FIT
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -27,28 +31,9 @@
 
 #ifdef CONFIG_SPL
 &binman {
-	simple-bin {
-		filename = "u-boot-rockchip.bin";
-		pad-byte = <0xff>;
-
-		mkimage {
-			filename = "idbloader.img";
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
-			multiple-data-files;
-
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
-			};
-		};
-
-#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
-		fit: fit {
+#ifdef HAS_FIT
+	common_part: template-1 {
+			type = "fit";
 #ifdef CONFIG_ARM64
 			description = "FIT image for U-Boot with bl31 (TF-A)";
 #else
@@ -56,10 +41,8 @@
 #endif
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
-			filename = "u-boot.itb";
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 			fit,align = <512>;
-			offset = <CONFIG_SPL_PAD_TO>;
 			images {
 				u-boot {
 					description = "U-Boot";
@@ -164,12 +147,38 @@
 					fit,loadables;
 				};
 			};
+	};
+#endif /* HAS_FIT */
+
+	simple-bin {
+		filename = "u-boot-rockchip.bin";
+		pad-byte = <0xff>;
+
+		mkimage {
+			filename = "idbloader.img";
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			multiple-data-files;
+
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+			rockchip-tpl {
+			};
+#elif defined(CONFIG_TPL)
+			u-boot-tpl {
+			};
+#endif
+			u-boot-spl {
+			};
 		};
+
+#ifdef HAS_FIT
+		fit {
+			filename = "u-boot.itb";
+			insert-template = <&common_part>;
 #else
 		u-boot-img {
+#endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
-#endif
 
 		fdtmap {
 		};
@@ -196,7 +205,7 @@
 			};
 		};
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
+#ifdef HAS_FIT
 		fit {
 			type = "blob";
 			filename = "u-boot.itb";
-- 
2.43.0

