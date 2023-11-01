Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF31AC4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FA087D66;
	Wed,  1 Nov 2023 17:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IgW9gyji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292C187D5C; Wed,  1 Nov 2023 17:28:53 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B5887D33
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-672096e0e89so80506d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856120; x=1699460920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v3orS5t3KquFHwL6I6rLF4x7gOdrROeecb8N/AzXdJg=;
 b=IgW9gyjiUzY/fw7Q64U4Q1FPDPfPCtRPj4rNol7Cqf5CjzRj4tNiNyqskQlZsIKI0f
 WBns7c0LpEJjKEMRRPVQYVucfhfl6BKcqXdbDU3PxO8ngF+NkuCATLipXKi/k70aDsVc
 uiinshmZWW+rgNRz/zk9fHLJcofIQfmCEsg3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856120; x=1699460920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3orS5t3KquFHwL6I6rLF4x7gOdrROeecb8N/AzXdJg=;
 b=XYcHxy2Qfg0doC1J9/9zHau2CucYbSPJCgKnoQ8rYHKw53Rz8DaQq94RLFNBhHptdp
 BLqTnzBqg2df0yyqKf2E7gXUh5+8QSsq8Zd+QSWEU6ia8LwxYKOKuJuIYIjhfxV9dKDx
 iN6LUXg01z8o9HlVnZKXLRlEuFt8TisLIQA0JK2AKko1ShnZF1KZ3QYsFHYxQhczsPsy
 JCRmGO/G1oSCcSPylXt0ee1P+n9+BqduR77ESBTb0aiwc/BDDvpbq/L696G6pabR7QD/
 lpKF2lBXRrZ/retHgAaGaf+zq6PHwMFOqlK+UFrIFtFLqN8JnXyKxDv45qECgB2c7jFD
 REaA==
X-Gm-Message-State: AOJu0YykiSxOJl4m/bwe9Ic5dNdHqHGgw0Y44GH30ZPTE5P8LWcnHrzo
 XfRhA5m0/sWS89QbeUWF7NCk0doAD13aOHF1xB0mxQ==
X-Google-Smtp-Source: AGHT+IF/Exgq107ad17018xRTRs9dJ4lzhRAqW0Fm1cteZxa3wX6w4UPm6W5ZBt01xGGoRS6yyN6JQ==
X-Received: by 2002:ad4:5bc7:0:b0:672:4e8c:9ab1 with SMTP id
 t7-20020ad45bc7000000b006724e8c9ab1mr10598367qvt.53.1698856119879; 
 Wed, 01 Nov 2023 09:28:39 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 17/20] ti: k3: Drop <common.h> usage
Date: Wed,  1 Nov 2023 12:28:21 -0400
Message-Id: <20231101162824.3755579-17-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

None of these files need <common.h> to be included, drop it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-k3/am62ax/am62a_qos_data.c | 1 -
 arch/arm/mach-k3/am642_init.c            | 1 -
 arch/arm/mach-k3/am654_init.c            | 1 -
 arch/arm/mach-k3/arm64-mmu.c             | 1 -
 arch/arm/mach-k3/common.c                | 1 -
 arch/arm/mach-k3/j721e_init.c            | 1 -
 arch/arm/mach-k3/j721s2_init.c           | 1 -
 arch/arm/mach-k3/r5_mpu.c                | 1 -
 arch/arm/mach-k3/security.c              | 1 -
 arch/arm/mach-k3/sysfw-loader.c          | 1 -
 board/ti/am62ax/evm.c                    | 1 -
 board/ti/am64x/evm.c                     | 1 -
 board/ti/am65x/evm.c                     | 1 -
 board/ti/j721e/evm.c                     | 1 -
 board/ti/j721s2/evm.c                    | 1 -
 15 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a_qos_data.c b/arch/arm/mach-k3/am62ax/am62a_qos_data.c
index 01b76f7493c3..38db4f2f5c8e 100644
--- a/arch/arm/mach-k3/am62ax/am62a_qos_data.c
+++ b/arch/arm/mach-k3/am62ax/am62a_qos_data.c
@@ -5,7 +5,6 @@
  *
  * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
  */
-#include <common.h>
 #include <asm/arch/hardware.h>
 #include "common.h"
 
diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
index c871e92330bc..6085379f1db1 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am642_init.c
@@ -7,7 +7,6 @@
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-k3/am654_init.c b/arch/arm/mach-k3/am654_init.c
index 0d3889cde2ba..2c5d6334527c 100644
--- a/arch/arm/mach-k3/am654_init.c
+++ b/arch/arm/mach-k3/am654_init.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index f8087d2421e7..14e7c896f915 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
 
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index c3006ba387ec..eff2fff3c706 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <image.h>
 #include <init.h>
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b1f7e25ed092..099301d61ac0 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
index a5be84b147c0..7d4481009041 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2_init.c
@@ -6,7 +6,6 @@
  *	David Huang <d-huang@ti.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-k3/r5_mpu.c b/arch/arm/mach-k3/r5_mpu.c
index 2aec96277e6f..6786e7e1e5af 100644
--- a/arch/arm/mach-k3/r5_mpu.c
+++ b/arch/arm/mach-k3/r5_mpu.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include "common.h"
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 89659f479eed..3b7c26c6125a 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -7,7 +7,6 @@
  */
 
 #include <asm/io.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <hang.h>
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index ef245fef9c4b..aa401ae3a09e 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -6,7 +6,6 @@
  *	Andreas Dannenberg <dannenberg@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <image.h>
 #include <log.h>
diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index f2dd3b4192ee..cd3360a43029 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -8,7 +8,6 @@
 
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
-#include <common.h>
 #include <dm/uclass.h>
 #include <env.h>
 #include <fdt_support.h>
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index a080b2b0d258..a6dcff2eb434 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
 #include <k3-ddrss.h>
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 8bb13ef5b2b3..97a70954b232 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <image.h>
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index d4f7c1d9f938..de9034206ae9 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <generic-phy.h>
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 7795300abc80..7a911381094a 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <generic-phy.h>
-- 
2.34.1

