Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2670FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224DE81671;
	Tue, 11 Mar 2025 14:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CqbI/8Yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF04811C1; Tue, 11 Mar 2025 14:35:44 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823358003E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c1c9b7bd9aso2558289fac.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741700138; x=1742304938; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=is36Na8dvk/foHAtQozAr7j8VafFohAS2dzm0pzp9J8=;
 b=CqbI/8YfPt36jSERUD60wt+axb58JCypA3gW2yVgmY7qrvUYTTFp9Dx/udZLQjknG+
 YoLBlOgtczbJ/eO9Fc5BnUJn3fMXfTsq7FJQEp1WeDmauT4zjyOY3ui+EiuSeA4F2WTV
 p1rrYmrrlM+WVYwFn1xGD2dH/eCZz8+utuV8K177glEwDrK9m+OzfnjGWlnWBQVi4T08
 u3bq+hXRV/6vxL5n3foGIWuDI4rH33YtMGvEGk8RcscUYGd4fF2g7fu6NzR5T6xmQTrJ
 9S9NpuKa93m1ioGesw4kiGjFspC0eazCF0al0oesqxI6EDId4ZJOlFJJWGG/HFrsTkL7
 EY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700138; x=1742304938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is36Na8dvk/foHAtQozAr7j8VafFohAS2dzm0pzp9J8=;
 b=o/bBdb+GRMF6JDH9WabbDhKJWaRfkoFl6SgAWsEZW3KOT4d8sgeZtv992nnGA/at4+
 HVhbkNpv4u8+nUAocbIqd/cA93sljkPFygcr3nDBPxP18OY9T4HQwNVw3cJTXWTWMBTs
 1PDy9IPSxqpdxEz82F6t0C5u8dThmPJfjEkzkhl9G0GL78yyluSXhphZkMT0T9reRzAA
 koFiu2iAixYqCuxbV1f5ekbyhRYG109vkxpe78O+zEd64ZMyPcwjSW7jB/ORyGtxV82H
 446kevFbz38Vqt0zc06L+0fAXSX7IMNTyZpYc1n1h8CPlHE9vodHSyKln1Tm9bO/m/fZ
 Rl6g==
X-Gm-Message-State: AOJu0YwSw9p1PR5wcAzoYM0DaE7Ji2BOj6Jbk/FoiUgYf1zc1MHaJc6x
 WBaf50vfZFCoIB+969Qb/rKCL99teMUM+VmJaAX1UoB/oqW1bsBK5f+pmSRw1F75QGsau6HPoim
 B
X-Gm-Gg: ASbGncv8ZNfbeLMEF6AJwWOZBPm5ueycVSIiztEam5+MsPfFWNN0B1c/L4CxAvsjCvk
 uBtEfpK+odi1buL64plfykDx5yZZuq1WNd1/ogf+GWcmwdheDkJq3p/5JJc9GoqpFXgc8NOqZw5
 C1jRwneEjImiHX/Hn3fL/9NVXBwZqbtRC4Zvezn3lwYntpyxCUi41IvFgxtMJp6JcDbRz4kFkiS
 Vs4CkLYyWsBNWnitYiAm9OG+nE7S4GhWPUc1xvGExeDs+xdr7T0h/Gb6h+ICYKw8ZnP9+aGoc6i
 vVoevVHEdSdWwAhCcVYrwiku6ubW/hEFhZGes1vrHDjzk30bhG/ImDuKClv9DiC2hRqM80QvvcN
 c
X-Google-Smtp-Source: AGHT+IEcqDdKVMopxS6/vX0RgSlhA+KfjVM2bUcd4QMmbsNVzFgjjdQcmiajWZM9o/DWynjWNif0sA==
X-Received: by 2002:a05:6871:530d:b0:2b8:3c87:b491 with SMTP id
 586e51a60fabf-2c2614313e3mr9856238fac.26.1741700138094; 
 Tue, 11 Mar 2025 06:35:38 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-2c24883035bsm2578036fac.5.2025.03.11.06.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:35:37 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v1 2/3] riscv: Select appropriate image type
Date: Tue, 11 Mar 2025 13:35:04 +0000
Message-ID: <20250311133506.124914-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311133506.124914-1-mchitale@ventanamicro.com>
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
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

Select between the 32-bit or 64-bit arch type for the image headers
depending on how the build is configured.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/dts/binman.dtsi      | 14 ++++++++++----
 arch/riscv/include/asm/u-boot.h |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 0405faca574..a1a566b511b 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -5,6 +5,12 @@
 
 #include <config.h>
 
+#ifdef CONFIG_64BIT
+#define ARCH "riscv64"
+#else
+#define ARCH "riscv"
+
+#endif
 / {
 	binman: binman {
 		multiple-images;
@@ -31,7 +37,7 @@
 					description = "U-Boot";
 					type = "standalone";
 					os = "U-Boot";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
@@ -44,7 +50,7 @@
 					description = "Linux";
 					type = "standalone";
 					os = "Linux";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
@@ -57,7 +63,7 @@
 				tee {
 					description = "OP-TEE";
 					type = "tee";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					os = "tee";
 					load = /bits/ 64 <CONFIG_SPL_OPTEE_LOAD_ADDR>;
@@ -71,7 +77,7 @@
 					description = "OpenSBI fw_dynamic Firmware";
 					type = "firmware";
 					os = "opensbi";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
 					entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
diff --git a/arch/riscv/include/asm/u-boot.h b/arch/riscv/include/asm/u-boot.h
index d5e1d5f3231..a90cc4c21cf 100644
--- a/arch/riscv/include/asm/u-boot.h
+++ b/arch/riscv/include/asm/u-boot.h
@@ -23,6 +23,10 @@
 #include <asm/u-boot-riscv.h>
 
 /* For image.h:image_check_target_arch() */
+#ifdef CONFIG_64BIT
+#define IH_ARCH_DEFAULT IH_ARCH_RISCV64
+#else
 #define IH_ARCH_DEFAULT IH_ARCH_RISCV
+#endif
 
 #endif	/* _U_BOOT_H_ */
-- 
2.43.0

