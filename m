Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5177A1098783
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C348407E;
	Fri, 20 Mar 2026 14:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h86gg6pK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDEDE83F00; Fri, 20 Mar 2026 13:52:54 +0100 (CET)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B2C83CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-899fbf92bdbso21501806d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774011171; x=1774615971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BJyWL1D7ka+06r1tO6UAiQa0qfpjgQURWwN5an9sMg=;
 b=h86gg6pKHTZT8CEWg0MKyHvXpL7BO8URl1aGrEKUKHLLJRcoSaIp9C4vLNrQ7/eT+I
 fMk7V7DCHfSULQ2WZhV8GEaYkGEIhU7unPQrO47R/FvsswfQ0qY42pcmBFZ+qdW6ef9j
 V3FBxyvEwHmo+Z1TMoLG33F0nAZ3oi4lrUI6g1pInuv/iq4QdUtePKOYBEcnU5amiL19
 Ge2jXeH4rQus1xSD2Gs5Iae4Q/PrfJATfji66WTBSx9FZR7zx4Cr5CVb4d2ZlOlN8r36
 QteaoqPLUeF8PoJs9tDrxYDwclC7j9Z5zzyIbp7uqhZNceEkRCqoB6WcvkrBjVmepStw
 Y7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011171; x=1774615971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7BJyWL1D7ka+06r1tO6UAiQa0qfpjgQURWwN5an9sMg=;
 b=pvGl5whTj9SoJqXMzAdVsldWqD25hhAm95wDwMatjlQEwh2yfk+r9wvMscXccm8aR+
 seWr/7kZBkptK7MV1QlO+QgHq69G3W0QmxKbqbGIScR5VmIk5M5ELmVEKzaWqmwVcipv
 ROzjMghqOJtZHn3Ug8bNBzTJ/oo+zJEAgHYSld+kwE7H8zVmwGKX9liIDRkIbWhJoHJf
 Iiiw8qPbxduUUrcVQhWqCM0o7ruY1PEAbPaVqjLwadonm+MI+vgYtOUuWoBriS2N4aaS
 nsX6+CHo0EbwBUkU83EzpZDalCwjI1O7WCa4q0EPIhOjHpaai0AT/UnOd08yd0YI6e44
 +6Qg==
X-Gm-Message-State: AOJu0Yyo1MDY4VfogTdCFir4AoJjzDyFyiRLePZ/MA0hR0uIQIzG+XRT
 xOgK3YA5Bukfd59mJauv1xDeRwlpQKbMPL08zc8NdJPweo32RU+QtGmJ6WBbBtkhIzn7lg==
X-Gm-Gg: ATEYQzy7Ocb1U8wDKmip/fLmP1sCXzTT3kn9BARSE3hCQ3QOSKkIj82iFKH+AfhCNoA
 NFq55NnzdenYaepUzpr4gGkBhp2FMJB1gybbvjaeQf01rRJmp0xEfYMUkwquy3gAC5aBea5vZKx
 v0AwJx+y89AbixM1JZ1gbEYQf4EzdR8ycFkaAvbsC6xXwLlMcdve0t2DQnSnjfELQvsL1MM6BgG
 IuPJxNJHx51Hf0Y+t/MaaH5YF9y7ZMhxxhZWbFa4kC62e4AKJqjidMWwe21zh+36A45MIZN1NRU
 NemdA3jxN0f0NFL6edp/UFte4dCsNc0LbjR96fdkouGhD57i29lXbs4cGUxExzAaTqx/V6NUTPf
 dMcONYuUfx4bQd9DvgHX4Tw9ce/6TpRm5m4+5fvCqMuj/Zu5eckOKbk40vCvO2RhuNE1aKyLueV
 FenQwBa2FhMzLG63+Sps3AzXqhPk2AVyfB6w==
X-Received: by 2002:ad4:5cc5:0:b0:89a:61bb:7314 with SMTP id
 6a1803df08f44-89c85a58cbbmr45563106d6.42.1774011171309; 
 Fri, 20 Mar 2026 05:52:51 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8537c3b5sm19168166d6.47.2026.03.20.05.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:52:51 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 linux@analog.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 08/11] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
Date: Fri, 20 Mar 2026 08:50:23 -0400
Message-Id: <a503bb17b6d9df1aab4d87d4a133ececae403ee2.1774008927.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774008927.git.jcethrid@gmail.com>
References: <cover.1774008927.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Mar 2026 14:06:14 +0100
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
index 0e8f777619d..5279fc230f7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1190,7 +1190,7 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
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
index b048d537c33..9c1d623f8a3 100644
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
index 276d173912a..e42ea85ca9b 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -22,7 +22,7 @@ config SC57X
 	bool "SC57x series"
 	select COMMON_CLK_ADI_SC57X
 	select CPU_V7A
-	select TARGET_SC573_EZKIT
+	select TARGET_SC573_EZLITE
 
 config SC58X
 	bool "SC58x series"
@@ -48,8 +48,8 @@ endchoice
 
 if SC57X
 
-config TARGET_SC573_EZKIT
-	bool "Support SC573-EZKIT"
+config TARGET_SC573_EZLITE
+	bool "Support SC573-EZLITE"
 
 endif
 
@@ -597,6 +597,6 @@ source "board/adi/sc594-som-ezlite/Kconfig"
 source "board/adi/sc589-ezkit/Kconfig"
 source "board/adi/sc589-mini/Kconfig"
 source "board/adi/sc584-ezkit/Kconfig"
-source "board/adi/sc573-ezkit/Kconfig"
+source "board/adi/sc573-ezlite/Kconfig"
 
 endif
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/dmcinit.c
index 2bf2cc53a9f..f3d5c11f437 100644
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
index 43c7f0ce4bd..2a083f6ab10 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -48,7 +48,7 @@ CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
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

