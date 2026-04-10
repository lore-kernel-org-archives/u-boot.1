Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6988DF364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0765A841DF;
	Sat, 11 Apr 2026 09:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JimXVuzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A5C84120; Fri, 10 Apr 2026 15:58:44 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03BE84105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50d880e6fbbso18808481cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829521; x=1776434321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFRjGsUOVZGtBjArQ0DfQ4BQHkzkU3nOuvEpLihMAkE=;
 b=JimXVuzkrknAMJzPBmrt2ZYkOQ/6wi+6pVLg1D/QodJxkTHp+G5rb2udJ5wp7uyyTK
 jzRPwZsG7tGZUqfB8CkQs1ymlop35CWhPGk2CpxkZQW68HLGzixD66Sq2EXSorkwWpnl
 UpVUJVs/SttHjh0YshpmItKpPhfAyBOj5S2LYMXYq6k7jONbqP5lH5HeQlmSfi7KmIyy
 sWphiZF/cMxi+MyIzqLqboEmhoaSsP0g/ySTOBvaMjBNVR0WabLE7jTZ+j1EZglQLZ4K
 97KRvY05MRJngVFASYViGylYN3tL6xHRzRhQtdsNJCfPoEMtIxbMo0bN1nRlzmI4c6Ti
 oaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829521; x=1776434321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFRjGsUOVZGtBjArQ0DfQ4BQHkzkU3nOuvEpLihMAkE=;
 b=TFoNo1CZn9hcQtA4THw7Ql0CuxgnjiWShFi4kw4YaNDpqyZWyhuKmN2J6xRmxSkIQC
 W5IA4GDZEXyKikMz9fFaI8AjNRhOFWXSXEjB1+dr7mnVeOUUXWJIchL78ASHHHu5t2Zx
 lTv6Yyfjfta7xIwT8Q19l/O/5sGYrz7Clk/NqQ15U2PI2NXQHJf1tcfSATK2zikS1spm
 P6017rWCmXByssYoji5P9NHy82HHZWkbJ7q7Ndwd7L+UGGQl9qQ1dOQeoX2oCyclfB4G
 nyMqDtqZjKlWw8E98Ba47Bd9dhPGk/gv4pUuszjOXV0UjIsGcC7VsRJp7uAfHVR69Uzg
 AK0g==
X-Gm-Message-State: AOJu0YyzcvHmyUjDNXJLEB5IL1JixkXmesE/e14hZpp/ilVpiCfD3tPe
 NeGPaJtjEE8iQzCx6NQsjTeegVQfGe/v9qigUdeYaIhn5/iftD35JOBr/3FkFe9F
X-Gm-Gg: AeBDieu0KzAeQVH+2nfs2XcUkoRR5M5D7aPgcBwtivse3lUQBcdzaaQY99ZMZg3Ox1w
 7vw9OQZhX5GjzI5ycf56aqkWjIjZ7+IPJTA5HYHuihyCaht/s8ehLnltRB6b3iRbnKQa15A0bV9
 bOKoG3zd2rMsiLQ28T+M0gjuC4OOOvcgEKfqW1AVd0HuZhW6R/4jcwR4IVmVJzx1TeILTnhPXeQ
 EYQzehKHshIeFXPtsZWS6XgAqGDCZLWyDwK1CNofCn6/Xx0uiCrIM7Ohd95BXpWSa2jpsO1pDVH
 AfOxrJ4K9fg4e0WomjNWO34z5KS9fFeFC8zYnCvd+aBTgBEq0+QeD8RAs5Ff4jsTqGi+OMrmJGR
 tfJ2TvGi9jgM6ayzI207ZEfFwOZwfbjH/OTCikMRw32HDfwk0bWTXd8xplV3H8NIUQscpofWUSq
 3H7z6i26LuxWH7PxZt7I6JkbumxFSUSC8Lfg==
X-Received: by 2002:a05:622a:4805:b0:50b:3249:828f with SMTP id
 d75a77b69052e-50dd6be9ee4mr33876911cf.28.1775829521388; 
 Fri, 10 Apr 2026 06:58:41 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:40 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 08/14] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
Date: Fri, 10 Apr 2026 09:58:03 -0400
Message-Id: <3a2072447d92e1d4203955ed8e7a981fe1f4dc22.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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
index e0ce5fabd78..d3f775b13e8 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -46,7 +46,7 @@ CONFIG_SPL_OF_CONTROL=y
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

