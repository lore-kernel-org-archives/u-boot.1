Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F02C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133DF82A16;
	Fri,  4 Apr 2025 16:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mcTY3+zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D41582A0D; Fri,  4 Apr 2025 16:49:45 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8E1828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2295d78b45cso27878365ad.0
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743778181; x=1744382981; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=is36Na8dvk/foHAtQozAr7j8VafFohAS2dzm0pzp9J8=;
 b=mcTY3+zh1JVeGk1VNp6R/VkQgJ6gb8ghb1yTkoDN/LBE215Zg7qfoNyxfdCC/8UtCk
 xGVaHBpGkDLP2y20dJ3MT2Kdem5u7obBbMdOdYoyea5UuD4Z3oIWRZEQCAq8Ul2vZ8Rv
 UgMGbSfPpO1v+IivpYPasV9aLqmR0O+Qrm7Z/lQc2G/oz81Eysom9YU7KvQYOCeC48w6
 RV48ssksyiTMU0StSaGBLgAeMpyhi/+jK9HzZZxc4YfGdvsBG+wGInWXoCDiw0BV523o
 eqXj7TP96TfqmgmW+I4y5XyipAr1VciHHFT+QY9pwayLVK7IxsADq0VNOJYJg4KPEzPW
 WL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778181; x=1744382981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=is36Na8dvk/foHAtQozAr7j8VafFohAS2dzm0pzp9J8=;
 b=bRBYiNunwclEsPkn6UFrsCe9c460RaMudi47ITGbHjfUuswxXL0HkiKy7f9Ic/FDP3
 2voAjjzOFvPy/TI3rH3S484aTivalb2H3vR7u0POb7JypGRWWGzLte1ivBhaSwBUmkbB
 Ajkfk0cRbXF+jB0wYu/FrbsFTo7v/NGGY4QJFt5bOgG345jjCivHJUE0yMZ9LBVxm6DN
 mhB0vAqe59AVCPrXu6wL+C/zNftx3xXkW63I5YXAW8MFVIKL9mVhN+SVaaCXh1E7GNYy
 PnS89L5QIaYcBnsnVtviDDsXDls+Qp0JOuibdzJUJp0r9whDvs3iH1701ph7naxH/4ST
 gE7A==
X-Gm-Message-State: AOJu0YxN8/xlfXFv1x+Njhe7Oa5LlElPnKaaaEIT5BMtcJxR4lH6HAWx
 6LWl7g5HBU3ycirLaV3EyEMeVIsSq+kHqsXlS5bxtTOqju5kGNnDuK8FDVh0NMmh6Xr1DOfysCO
 4
X-Gm-Gg: ASbGncvdUWwoWAo4Nmn02TKi6dR+ihAcGyR0Orij0aJzr/+/E3Y6P/3bn9nyuwsXLuy
 mwMP9XYcCN3wRZhlihtYxGPsRbL8ZNbarriFSGaq1mPkfXXQmgMzy0K72YMImGZMbDBv0pdIQRG
 SVVb5l3dzmL6nEE41SarEPfQGISplwcmb0iduAcmee6gYsJXfPiYD0NEvGzeyT1oE4DJxJtyZvE
 9Fk7rRZBIXAT52BDJ94zPSwlAEyOg8VNZJq6D8w1C/YJ4TufQo/mDGxwWWvy6juwwCg/qva6LjU
 lw4iuxcgQ8I8X3z9eMD17EL4WFz5Z3VNhhCdYv2CzTqLy0RIyLtSYPHMjgBcuzxUxQ==
X-Google-Smtp-Source: AGHT+IEisIWQnI12k+8r3niCud09aMlGGPHm7YH/WrUWuBfAO1pb2+uRF5i4iSFWV1go5Rz0aUScUg==
X-Received: by 2002:a17:903:22d1:b0:21f:c67:a68a with SMTP id
 d9443c01a7336-22a8a067a4dmr46515575ad.31.1743778180899; 
 Fri, 04 Apr 2025 07:49:40 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2297866dccbsm32950705ad.176.2025.04.04.07.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:49:40 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v2 2/3] riscv: Select appropriate image type
Date: Fri,  4 Apr 2025 14:48:56 +0000
Message-ID: <20250404144859.112313-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
References: <20250404144859.112313-1-mchitale@ventanamicro.com>
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

