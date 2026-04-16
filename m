Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8051F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32CF8447D;
	Fri, 17 Apr 2026 14:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2ab7jDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A97C8421D; Thu, 16 Apr 2026 17:20:24 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523D18420C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8acb856a674so9090396d6.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352821; x=1776957621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvS4ih63Xj70/+vNWaR1mMBfjUWVwDyHHv5tTqRiYEg=;
 b=O2ab7jDizoN0tblQ/cmmwT7XiVY71FlgwswpygFLsWlSmOCnJXHJRkYFIIoG2PCQCL
 O5do6i6j3v9rxvAnt8s0D6VUPdumu6ME2RVKbIr6WSRc54q9xlbGK7qPUWfCdQKHlC1P
 h+oYUvNZqhnoicTmiTvka70QOZ6TacE4z8B9FvZYFwwUwOncv5UnnYd+AUs7QP34UWio
 M7LU4Xw/TVIdz37AEIRMGEHBLlLe1M5IMRtSYVz3VJ+yzH/2Lw0FI28/h/QYgJvaCxUw
 oxl6qatGW1JgR+wFdFGJzrH1RELj5pMF70HHjbcrbcdJjbdWjmhKQqIl2Q4nnUVrHURB
 OU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352821; x=1776957621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vvS4ih63Xj70/+vNWaR1mMBfjUWVwDyHHv5tTqRiYEg=;
 b=T8Sno/LyGAO3xj/PDyCDT4iTvuKGkpxVxdeQ0qE4vwxVQ1+8gnYZd7QEc030liHJPi
 Zk8H1wGPKhiki50rhqY2jvlpoJZGXYCEyyfWw8xdeuDuNFilkql3wGxuptNnhAR/YHv6
 ZAioO350psfB0mNK31AAZA1uTv9dNsuOR7+jyE7Nhpid5nO1vZ0SAsaM5jpAvshQwYPx
 gc4bjv396xSaadnP97JbtppVgRNH4GeOytZpy2eliCMZWhbz7xAWC2BmMF9az09a0dZQ
 iNl0hzmmqNCf/1tCQIcidsjnhY3DxI8cSuhyEx9iP2bM4pr/7ilDIRWWBeo1AQmVfgMR
 D51Q==
X-Gm-Message-State: AOJu0Yz8xNn3JRL/gCcmp1Po9WmS1iKYRau2fa+MLkfSbic4J9xHRvsY
 kNjCFRdhErUq5QMPH2mlCO2OY0E18idxsV7gYPk02ySoStzkmZ8d7VvK8+vCwShE
X-Gm-Gg: AeBDieu558Wv1Lp5yZibqcQgPCaD3ARIOyBa5nY4kLTxZJacZ7xJvwy5MUyEuUQ9zmB
 hhNYWvf6pI+RVZQ9oSfX+vu89eSW4j/oPll1Uhd4y5cWUTKCUcKv00pgON/1ha2XxQXW9u8B1tL
 79CI2kvv0BYT/BeOaF3jfwZZBgcNnNplRkY9GlVfJ0J/POzGQ0V5iwqjka1wkGBIbfj9oM4022A
 8PKfHKPO+6dHPsZmpJ4iaJIk3O5v1t59SwWIRZiO+6yTN3xe/c+AMS59Kwi/iKy9aRvvbZZC7hP
 jbnSar9St5rokywwkyalmhbpvL8b6cDDXXH//vDysQGZQezP0lqDefeCeN3oJhp0cVl2oKJpNz2
 LGbrPltQIQlLKaXxikhJjnnEbOA6x5V4dRlFqeR+MwvfaAKMh8NdgIuC/Y5Y7YCw68oO7SCMYRm
 XEKxC67g3BKriQjO4cJZXVhSKVg1OpHve6Zw==
X-Received: by 2002:a05:6214:1d0a:b0:8ac:a6f7:8a6d with SMTP id
 6a1803df08f44-8b01db458e4mr27279206d6.13.1776352820975; 
 Thu, 16 Apr 2026 08:20:20 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:20 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 08/14] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
Date: Thu, 16 Apr 2026 11:19:43 -0400
Message-Id: <89302771cb07f6f8ff7b5bf09c822d79bec4223e.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Rename the SC573 EZKIT board to EZLITE across the device tree,
defconfig, board file, and related Kconfig/Makefile entries to
match with release naming. EZKIT was used internally before the
official product release.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/Makefile                                     | 2 +-
 arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts}        | 4 ++--
 arch/arm/mach-sc5xx/Kconfig                               | 8 ++++----
 arch/arm/mach-sc5xx/init/dmcinit.c                        | 2 +-
 board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig           | 8 ++++----
 board/adi/{sc573-ezkit => sc573-ezlite}/Makefile          | 2 +-
 .../sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c}         | 0
 .../sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env}     | 0
 configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} | 2 +-
 doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml           | 2 +-
 include/configs/{sc573-ezkit.h => sc573-ezlite.h}         | 4 ++--
 11 files changed, 17 insertions(+), 17 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env} (100%)
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (98%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4085d4c2de1..5e7ddb56ddc 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1181,7 +1181,7 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
 					imx8mm-cl-iot-gate-ied-tpm0.dtbo \
 					imx8mm-cl-iot-gate-ied-tpm1.dtbo
 
-dtb-$(CONFIG_TARGET_SC573_EZKIT) += sc573-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC573_EZLITE) += sc573-ezlite.dtb
 dtb-$(CONFIG_TARGET_SC584_EZKIT) += sc584-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC589_MINI) += sc589-mini.dtb
 dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
diff --git a/arch/arm/dts/sc573-ezkit.dts b/arch/arm/dts/sc573-ezlite.dts
similarity index 98%
rename from arch/arm/dts/sc573-ezkit.dts
rename to arch/arm/dts/sc573-ezlite.dts
index 4a3d1ed5c56..57604d707f7 100644
--- a/arch/arm/dts/sc573-ezkit.dts
+++ b/arch/arm/dts/sc573-ezlite.dts
@@ -9,8 +9,8 @@
 #include "sc57x.dtsi"
 
 / {
-	model = "ADI SC573-EZKIT";
-	compatible = "adi,sc573-ezkit", "adi,sc57x";
+	model = "ADI SC573-EZLITE";
+	compatible = "adi,sc573-ezlite", "adi,sc57x";
 };
 
 &i2c0 {
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 70fab57fb3c..e311a8adf9a 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -25,7 +25,7 @@ config SC57X
 	bool "SC57x series"
 	select COMMON_CLK_ADI_SC57X
 	select CPU_V7A
-	select TARGET_SC573_EZKIT
+	select TARGET_SC573_EZLITE
 
 config SC58X
 	bool "SC58x series"
@@ -51,8 +51,8 @@ endchoice
 
 if SC57X
 
-config TARGET_SC573_EZKIT
-	bool "Support SC573-EZKIT"
+config TARGET_SC573_EZLITE
+	bool "Support SC573-EZLITE"
 
 endif
 
@@ -600,6 +600,6 @@ source "board/adi/sc594-som-ezlite/Kconfig"
 source "board/adi/sc589-ezkit/Kconfig"
 source "board/adi/sc589-mini/Kconfig"
 source "board/adi/sc584-ezkit/Kconfig"
-source "board/adi/sc573-ezkit/Kconfig"
+source "board/adi/sc573-ezlite/Kconfig"
 
 endif
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/dmcinit.c
index 12052613feb..2026735cc21 100644
--- a/arch/arm/mach-sc5xx/init/dmcinit.c
+++ b/arch/arm/mach-sc5xx/init/dmcinit.c
@@ -101,7 +101,7 @@
 
 #ifdef CONFIG_TARGET_SC584_EZKIT
 	#define DMC_PADCTL2_VALUE	0x0078283C
-#elif CONFIG_TARGET_SC573_EZKIT
+#elif CONFIG_TARGET_SC573_EZLITE
 	#define DMC_PADCTL2_VALUE	0x00782828
 #elif CONFIG_TARGET_SC589_MINI || CONFIG_TARGET_SC589_EZKIT
 	#define DMC_PADCTL2_VALUE	0x00783C3C
diff --git a/board/adi/sc573-ezkit/Kconfig b/board/adi/sc573-ezlite/Kconfig
similarity index 92%
rename from board/adi/sc573-ezkit/Kconfig
rename to board/adi/sc573-ezlite/Kconfig
index 328563c1296..f3b848ef0f7 100644
--- a/board/adi/sc573-ezkit/Kconfig
+++ b/board/adi/sc573-ezlite/Kconfig
@@ -2,19 +2,19 @@
 #
 # (C) Copyright 2024 - Analog Devices, Inc.
 
-if TARGET_SC573_EZKIT
+if TARGET_SC573_EZLITE
 
 config SYS_BOARD
-	default "sc573-ezkit"
+	default "sc573-ezlite"
 
 config SYS_CONFIG_NAME
-	default "sc573-ezkit"
+	default "sc573-ezlite"
 
 config LDR_CPU
 	default "ADSP-SC573-0.0"
 
 config DEFAULT_DEVICE_TREE
-	default "sc573-ezkit"
+	default "sc573-ezlite"
 
 config ADI_IMAGE
 	default "tiny"
diff --git a/board/adi/sc573-ezkit/Makefile b/board/adi/sc573-ezlite/Makefile
similarity index 79%
rename from board/adi/sc573-ezkit/Makefile
rename to board/adi/sc573-ezlite/Makefile
index 0ea725b992b..77c55af6240 100644
--- a/board/adi/sc573-ezkit/Makefile
+++ b/board/adi/sc573-ezlite/Makefile
@@ -3,4 +3,4 @@
 # (C) Copyright 2025 - Analog Devices, Inc.
 #
 
-obj-y	+= sc573-ezkit.o
+obj-y	+= sc573-ezlite.o
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.c b/board/adi/sc573-ezlite/sc573-ezlite.c
similarity index 100%
rename from board/adi/sc573-ezkit/sc573-ezkit.c
rename to board/adi/sc573-ezlite/sc573-ezlite.c
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezlite/sc573-ezlite.env
similarity index 100%
rename from board/adi/sc573-ezkit/sc573-ezkit.env
rename to board/adi/sc573-ezlite/sc573-ezlite.env
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezlite_defconfig
similarity index 98%
rename from configs/sc573-ezkit_defconfig
rename to configs/sc573-ezlite_defconfig
index 4320c73fd39..f6305451c27 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="sc573-ezkit"
+CONFIG_HOSTNAME="sc573-ezlite"
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_IP_DEFRAG=y
 CONFIG_SPL_CLK=y
diff --git a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
index df976c7ae73..ae3b5e6092a 100644
--- a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
+++ b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
@@ -18,7 +18,7 @@ properties:
     oneOf:
       - description: SC57X Series Boards
         items:
-          - const: adi,sc573-ezkit
+          - const: adi,sc573-ezlite
           - const: adi,sc57x
 
       - description: SC58X Series Boards
diff --git a/include/configs/sc573-ezkit.h b/include/configs/sc573-ezlite.h
similarity index 79%
rename from include/configs/sc573-ezkit.h
rename to include/configs/sc573-ezlite.h
index 42e42f8150b..590a8f06fb5 100644
--- a/include/configs/sc573-ezkit.h
+++ b/include/configs/sc573-ezlite.h
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#ifndef __CONFIG_SC573_EZKIT_H
-#define __CONFIG_SC573_EZKIT_H
+#ifndef __CONFIG_SC573_EZLITE_H
+#define __CONFIG_SC573_EZLITE_H
 
 /*
  * Memory Settings
-- 
2.34.1

