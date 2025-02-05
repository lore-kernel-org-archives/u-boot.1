Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D478C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53BD5807FB;
	Wed,  5 Feb 2025 02:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hit1wFx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059A9801F5; Wed,  5 Feb 2025 02:56:41 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6DE807A8
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5fa3714d4bbso2790491eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720596; x=1739325396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q24sxur2fqJMIexuMGBE0DHjrZiinlondVHA8Bc2qUc=;
 b=Hit1wFx1LbwHxUPc9QwD8Of6IwtL0FpVACWfSIv+xkRyofYkem5wC4UTwYoZY88XnU
 cXcLF0IaOI7R/VfuYKTXPENJYA31+nUjy9RnHbmC94aGdKJjbRR3ql7HiDOsX4sRl1Se
 iY/tBaNNV21PxZNAL0Qq1Pqi96iynIFerN0F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720596; x=1739325396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q24sxur2fqJMIexuMGBE0DHjrZiinlondVHA8Bc2qUc=;
 b=rz4B1Zffs14+YZ8Z3j6Rn0fhHFNuksqHSulMoLE7m6NyFvFZAig9fvtMQJWfDJmBpx
 dcCgzOX+iZ/ixTC15CIhEfv43go87S4cQDJolmmnNxacLzcxch5/OAxDzfNwS9sO+fQc
 NuxF+cZuoTuBueIHaQVmBYN4gsg2/ocpj37WMHeuBhvl3tcddmzVgChphyA9R/Q7ruER
 BjqDbVAFc5ylfDOrV8M3f/y1JOgR/PUDmtxxXlU6CZoY2Y31+lIFnBFtvw2qInuR7kqO
 NA/fFf0c3tpf1R51wJ6rDVTFxX2bQJbhmGhBJC66dyiZEuh4Foo2zbPcEARZi7pWhbMe
 T9bQ==
X-Gm-Message-State: AOJu0Yx7A3B/CHopLll9a85jeRWCgMvOH9LZjzIrUM2A5OXfIWg+1xDf
 Z8fiA8mqiw2J0B1/2LIvMRnTQTGytax5hk3upazQcc3ZXOcwZrPxdAhGvfn4bmux9dMSt4Ae2T4
 =
X-Gm-Gg: ASbGnctzK5yzQV4e1E6udyfOBdzJGO83N90Qd5N3OmBmzY80AGunq5oNusV0xJVzGAh
 MBbcoGRNXVNrlL7kJNRsKNYvLBCDPg6gJr3Ahn4ph2KqKF0cTlMuvxdSNhe0Rt+qA0E4EGNhCyc
 NJlY4pLGx/sl1epm2ccOWMkZDNr3WYIBhOmSoqzgU9A9KZMUNNJQH2+7rV/mc5Zt75x7VJvIcqN
 PzOvXmZEXySON9xOGanYqYkETzjLUzgiDWJL5RTRF1AZNLyklwbO+xh759FMJL2n26rNK1vNVqc
 Sfqxon8omShY0riFd2XQCQIPUpar4gNAilSvdBZPCY9JLvI0hdkU
X-Google-Smtp-Source: AGHT+IHtB56LTVsjrgpOZdVp3tstgj6IPpLJenflNDU0CoCQR34FMFBb2FeP8TxEdEPKnVL9qN+Jug==
X-Received: by 2002:a05:6820:290f:b0:5fa:5c7d:db42 with SMTP id
 006d021491bc7-5fc47790ac4mr971539eaf.0.1738720596678; 
 Tue, 04 Feb 2025 17:56:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 06/29] rockchip: dts: Factor out arch and compression
Date: Tue,  4 Feb 2025 18:54:56 -0700
Message-ID: <20250205015606.2686149-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Declare these at the top of the file to avoid needing #ifdefs in every
usage.

Add a few comments to help with the remaining #ifdefs

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e50..8d6b2184f43 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -5,6 +5,20 @@
 
 #include <config.h>
 
+#ifdef CONFIG_ARM64
+#define ARCH	"arm64"
+#else
+#define ARCH	"arm"
+#endif
+
+#if defined(CONFIG_SPL_GZIP)
+#define COMP	"gzip"
+#elif defined(CONFIG_SPL_LZMA)
+#define COMP	"lzma"
+#else
+#define COMP	"none"
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -51,26 +65,12 @@
 					description = "U-Boot";
 					type = "standalone";
 					os = "U-Boot";
-#ifdef CONFIG_ARM64
-					arch = "arm64";
-#else
-					arch = "arm";
-#endif
-#if defined(CONFIG_SPL_GZIP)
-					compression = "gzip";
-#elif defined(CONFIG_SPL_LZMA)
-					compression = "lzma";
-#else
-					compression = "none";
-#endif
+					arch = ARCH;
+					compression = COMP;
 					load = <CONFIG_TEXT_BASE>;
 					entry = <CONFIG_TEXT_BASE>;
 					u-boot-nodtb {
-#if defined(CONFIG_SPL_GZIP)
-					compress = "gzip";
-#elif defined(CONFIG_SPL_LZMA)
-					compress = "lzma";
-#endif
+					compress = COMP;
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 					hash {
@@ -84,7 +84,7 @@
 					fit,operation = "split-elf";
 					description = "ARM Trusted Firmware";
 					type = "firmware";
-					arch = "arm64";
+					arch = ARCH;
 					os = "arm-trusted-firmware";
 					compression = "none";
 					fit,load;
@@ -103,7 +103,7 @@
 					fit,operation = "split-elf";
 					description = "TEE";
 					type = "tee";
-					arch = "arm64";
+					arch = ARCH;
 					os = "tee";
 					compression = "none";
 					fit,load;
@@ -119,11 +119,11 @@
 					};
 #endif
 				};
-#else
+#else /* !CONFIG_ARM64 */
 				op-tee {
 					description = "OP-TEE";
 					type = "tee";
-					arch = "arm";
+					arch = ARCH;
 					os = "tee";
 					compression = "none";
 					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
@@ -137,7 +137,7 @@
 					};
 #endif
 				};
-#endif
+#endif /* CONFIG_ARM64 */
 
 				@fdt-SEQ {
 					description = "fdt-NAME";
-- 
2.43.0

