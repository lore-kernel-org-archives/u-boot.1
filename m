Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9325BC5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 03:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB929835AE;
	Thu, 29 May 2025 05:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Kax00CuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981FE835B9; Thu, 29 May 2025 05:31:08 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171AA835B9
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 05:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso320399b3a.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748489464; x=1749094264; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjpKS/vykiZHwasFWv2uoMWctmzYcUZdTQHR+TKV8zg=;
 b=Kax00CuLfP6PaCDOKDqSqxTCY7pUUfyIMWcR5OwnasUA/x9lPgRAtX49gTRYTJDl6P
 XfbjBER7FzfHxKLxgNI0w15+shp74pKSMKFzASzAt+9UTf/GHM8Xbs0QOOk4J8t+hXNn
 0KX41wVdNfr9dxyG2AHuIxOD8qprXmLPHTpgY01lg1NqPUSXI7hJZPbYTE1WqVeMh/Ek
 wW0pJMW6YyDioemGyYEqbP9nN/X9NpqKYwOmLbLa5imuMLfMO8VRfITSK2uGpTBOg9nP
 s6CGgE/S/ZLhZLPdQmjvLZjVmmDnlA5br9ZfbGYzkfevvxhbqlugStVkbYE393W98fhy
 h8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748489464; x=1749094264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjpKS/vykiZHwasFWv2uoMWctmzYcUZdTQHR+TKV8zg=;
 b=sAqmIqSoOdj3BfYGfPMUFsUBV6zMw3VgE/UKH6n+htXmRyKuQsMHSXcmooC+sBfbFe
 I58ke3aeZFv4mcQzskQbZYFNQZfrzHBVT9fBcj976YSYrotaKaFU/qlMiEsI1gtmVd+Z
 lquWfIXcm4XtKcpTt3/k0CYJOYiATtTTlK7oOPZ6QyoCVUYY8idGnMJRfBJ9W5FtkyUr
 aKbNghxsK0t7LwKPPh+E4+QuI6FLSeUUt/7L+enho0x2uTPDsscAkrC0vwnbNlFHEC7n
 VwM+pB2ll6xUL7/5vP9zh1zPy0rKTqrjlMhOJtLQThpAEXECVEyK4W0GNneedRAq7o9+
 kL0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5rUTjxHCRYtGC8xBOoHcfoxMyf5PzUkMbDlq8HFRA0CQKrt1mNUGkwMjTE42NBX92HQgIX8o=@lists.denx.de
X-Gm-Message-State: AOJu0Yww8gVCgGsHt6ugtcbGuQRWkub4IU3y1LDosdkhufq8TQd1qiMP
 ue3EvKV7/OE/8ocdyLcl3gjqHWinhtZy34dVw2ql6N20i84hYqSQ1+/fu0WzqVuHP68=
X-Gm-Gg: ASbGnctJrWjmy+JEiDKHTNZoNezJw/FlHWfRKXckx/EgtpTXhAmMXX9CvrGh6dBmVnX
 P5F8EeujcSFfo244nQAK3I3mwoasUtD0GjqvjfzjaG+HuHz6Fp6yqS0GOTTUO7dagXtiHqwaSuK
 67kqz4N3mO39HQOO/maQUDft+HLvs3E/wOk9U96Fw4P4iFbQoRFcl1vIWqB6cNSfoJB+/FEN2yx
 yCXzk7kuhf5aw0QYPehIO07Wh69TLnb3c/asjcNVhK4o5umuw8rC0VRUC3ZiBqk4rgiCGLoWXTm
 QoijjRe6CwMcHBIlp1e8vg6nosRLiOlIiNLRgfzcoiYrhWTtzJRG3g3TDHt306PE/F1Gk59+
X-Google-Smtp-Source: AGHT+IGIhxKZlVyyDjfbGR6AnKadtuB0/FFzKF2RBY1LwL4YrEyzqWK5CjDEZAG3EKk3sZ+8vg30cg==
X-Received: by 2002:a05:6a21:4a4c:b0:1f5:6b36:f57a with SMTP id
 adf61e73a8af0-2188c3b32afmr31215794637.39.1748489464571; 
 Wed, 28 May 2025 20:31:04 -0700 (PDT)
Received: from localhost.localdomain ([223.228.139.23])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b2d9872cca0sm1847252a12.15.2025.05.28.20.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 20:31:04 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: trini@konsulko.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	u-boot@lists.denx.de
Subject: [PATCH] Revert "riscv: Select appropriate image type"
Date: Thu, 29 May 2025 03:30:50 +0000
Message-ID: <20250529033052.399573-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529033052.399573-1-mchitale@ventanamicro.com>
References: <20250529033052.399573-1-mchitale@ventanamicro.com>
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

This reverts commit 027a316828528da95a77d20632370b1bc2823f0b as
discussed in [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-May/590841.html

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/dts/binman.dtsi      | 14 ++++----------
 arch/riscv/include/asm/u-boot.h |  4 ----
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index c5b0464d6a7..b518560bb94 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -5,12 +5,6 @@
 
 #include <config.h>
 
-#ifdef CONFIG_64BIT
-#define ARCH "riscv64"
-#else
-#define ARCH "riscv"
-
-#endif
 / {
 	binman: binman {
 		multiple-images;
@@ -37,7 +31,7 @@
 					description = "U-Boot";
 					type = "standalone";
 					os = "U-Boot";
-					arch = ARCH;
+					arch = "riscv";
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
@@ -49,7 +43,7 @@
 					description = "Linux";
 					type = "standalone";
 					os = "Linux";
-					arch = ARCH;
+					arch = "riscv";
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
@@ -62,7 +56,7 @@
 				tee {
 					description = "OP-TEE";
 					type = "tee";
-					arch = ARCH;
+					arch = "riscv";
 					compression = "none";
 					os = "tee";
 					load = /bits/ 64 <CONFIG_SPL_OPTEE_LOAD_ADDR>;
@@ -76,7 +70,7 @@
 					description = "OpenSBI fw_dynamic Firmware";
 					type = "firmware";
 					os = "opensbi";
-					arch = ARCH;
+					arch = "riscv";
 					compression = "none";
 					load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
 					entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
diff --git a/arch/riscv/include/asm/u-boot.h b/arch/riscv/include/asm/u-boot.h
index a90cc4c21cf..d5e1d5f3231 100644
--- a/arch/riscv/include/asm/u-boot.h
+++ b/arch/riscv/include/asm/u-boot.h
@@ -23,10 +23,6 @@
 #include <asm/u-boot-riscv.h>
 
 /* For image.h:image_check_target_arch() */
-#ifdef CONFIG_64BIT
-#define IH_ARCH_DEFAULT IH_ARCH_RISCV64
-#else
 #define IH_ARCH_DEFAULT IH_ARCH_RISCV
-#endif
 
 #endif	/* _U_BOOT_H_ */
-- 
2.43.0

