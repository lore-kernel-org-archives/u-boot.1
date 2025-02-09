Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741B5C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C2280C69;
	Sun,  9 Feb 2025 22:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EBL20wYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FD680C69; Sun,  9 Feb 2025 22:15:49 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702FB807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3cf880d90bdso12394685ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135745; x=1739740545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHZnd0mwOshmQtuvTBWlCo1/6SDsJOI5nNj9qm+rQ2c=;
 b=EBL20wYEXusSVIRHW/2O4/pGni66iy5YPqe18idWf4Q7d+QqUCDoat2Tr/kebke8bi
 dPTUHrfokquL8V/HeyIZZ6Q7ZUI40k9bswYSxJf8DPoD0NrGMpjVnvypHFp7SSsReJ+g
 ziRUu/Hb49JNYCS5pYO97gj7G6xhShxkkwvuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135746; x=1739740546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHZnd0mwOshmQtuvTBWlCo1/6SDsJOI5nNj9qm+rQ2c=;
 b=C9xUEmd67/ivWVDFOWYWSldZG4YrI9DtfZhJ7lMyp5ak8XeiyZ6x8ccYacYeA/LLzE
 Utc9BeH22TzrBQgqQA5DVZMCSEwfZ2TVdE4p/sur/z1we3lrUltPkUy/agBKkzPn6jra
 BgC6fnguLU3rB+ysMwJEwMhbacpJaeoc6OUC1egj1nrVhh4/5ATEZ3b5xOek5ku0Exix
 A4mNEApfnkqkOw6isuZJth63zYgCRb+LB3S8s3Bi3nevVwpOPiZjmwc4+SFVXJt5zxpr
 ltJKaybNLinoELJIa9yHfPEBUmZr8nd9Ow9pg2Q7hGbuIDKSv5IkjK7UxRFgvst6wCyM
 nPIQ==
X-Gm-Message-State: AOJu0YwPLcMjdEqrLE1rk0iuFGiGOBfNDj0LExOkmC89BuwNj6QZBaPb
 AjnTHO2BMU1l8pWCRqY8adcTyFRZYAHmBWVBCgqP2Yvf0gKEnbXuLZo44FYjXlqarJdbeQrITwE
 =
X-Gm-Gg: ASbGncsmp2DcvGdkixCbc4wAsdJKhqRTTkSZtdouMRukdPXIK6XtM/uDGatIg3TKUCN
 VYhVLp8FcF74ZfmiPfLqT5eTlb+3FseR6pcD/XkAqgqW5cmJeConJ5Bw6bnh6o8yxCTsNZik9vl
 PG8JUdzxOShYbAc2hJJJWtntv48DGIhSGLAUZOV2r1EGpuL8HRQc4saxPobGrLdYtkZVsaYSh5K
 S7lz2cgcuTuI/7X9U7pw43msKX3J1djW2X/o9mfu1vpqdooQpn7DCGCMDSHGs57EfDiGg+oVP2Y
 BneKQZopkTyZTkDxSY0CUyGSC5pS+GvYO8PyCKnyBcrpKcS3OTnm
X-Google-Smtp-Source: AGHT+IH2WjCGx2ahxZJtxrkmP/195YdEmbWAzyS2XHu0y9Q9EPyMgySCoKntu7I35gwVc8bip0YPDQ==
X-Received: by 2002:a05:6e02:1c83:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d13dd2c372mr80506045ab.1.1739135745682; 
 Sun, 09 Feb 2025 13:15:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 10/35] rockchip: dts: Factor out arch and compression
Date: Sun,  9 Feb 2025 14:14:31 -0700
Message-ID: <20250209211502.2299245-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index e9ed1d4b573..2b01dc66056 100644
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
 					os = "u-boot";
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

