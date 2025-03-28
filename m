Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83004C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A848281F0D;
	Fri, 28 Mar 2025 16:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZTU0JTGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCEB81E6C; Fri, 28 Mar 2025 16:36:03 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DE881F4E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85b4277d0fbso73548339f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176154; x=1743780954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHZnd0mwOshmQtuvTBWlCo1/6SDsJOI5nNj9qm+rQ2c=;
 b=ZTU0JTGES5ngfu9LUCp8EA4Xbsfi2CS/Dw7cxIgzJqSDgJJ0tcBiVcwsRg9XtrRoBU
 777dYurRJmZjocye6q+1yIRPSskJpqDOcHnw1frMmuhWowhQSwtX3NvBWmyAiK3gtYru
 AyPRXY7/tsPNfA9veUYjOXLdhGWiT3HmfO8cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176154; x=1743780954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHZnd0mwOshmQtuvTBWlCo1/6SDsJOI5nNj9qm+rQ2c=;
 b=r9GaXJNCae0xbsLns4KKWsSwFI7dDUWBLBjNUYRXEg6iqzEwBhhuxCZQecWjfXOySC
 w7mb+4nvBa5xsZ/mUDYHNYLxHE/xnMPvvboT36uiYYK2hG00bX9wXJ8vQadQeODOOMw6
 ViPlR/tad3ePNEII/nqqQnlV6+MoOy6p0GBm3ZW05XfJWokrcVIv0cJsXHE+mOs7uqSB
 JLccjj0NS6dG75H5wv7A7GmGI4oSO9oMvI5kqApJSIUF/zi6Fl7t5ui7WruAwy6tPbym
 v2HOHs9PmPbYdHvvLwWB03N40xM9L6AOKdZRydgYVrKDJAzpnXjv2/18odsrjIya4JIr
 vlFg==
X-Gm-Message-State: AOJu0YzTeGI8aBiLsbswYHj3Hjpc+Z5EyO6WV6qUrbQyhMMn9kCYhoEl
 ybg8hjHKeqQKlGHC50d5lcydEci+MG8zP6aPBzx9G5bW1C8qQf3nasJmM8eFvbcA9GYJJnU+uSY
 =
X-Gm-Gg: ASbGnctMedZpKg+rR5VEelDoU8qcx6hskP2KO+aZgLo476n5xeWD2q1iryOGJgzIdzD
 4YAtLGgAv/AxDbz1v1GlVbckq/PvuIpIeF+bieMukHeA2m8n8L7mUA9rPYYcPuXMM1F0kYVnTib
 9yo4WKaZK6K/zmcZfTat8k+0rmf0vEeQHihnygaMczrsTccc1vwQVT4u65y/M5isx+LjTnXqlA2
 0Ly3bnWo/C6dyBAuswqbICv5OYuAjF2/qaF5V18EHg+blUR5+o0r05VS2LdlxTdgkayy4TpxFzY
 Sa0QO2K5nLBzAdDZMeXm31rH8P9e/gKkbcYXdZF4cRhHcREbMAsbTUlQvrQsQIAlC9MTQetl9S4
 3sOd2xWhEZh5r5zmF
X-Google-Smtp-Source: AGHT+IFyylxZaiapmKA1XtQZojqTuVpkOP/WWE8FF6GE+ZC4cFmcSwk3NpHuZB6yW0P2P0qyl3wIYg==
X-Received: by 2002:a05:6602:3897:b0:85c:c7f9:9a23 with SMTP id
 ca18e2360f4ac-85e8217f462mr1179195739f.14.1743176153553; 
 Fri, 28 Mar 2025 08:35:53 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 06/31] rockchip: dts: Factor out arch and compression
Date: Fri, 28 Mar 2025 09:34:46 -0600
Message-ID: <20250328153522.3555472-7-sjg@chromium.org>
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

