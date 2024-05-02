Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E9C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E14288CBE;
	Thu,  2 May 2024 03:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tZR9E4eR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 479FD88CC0; Thu,  2 May 2024 03:33:49 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9470F88CBE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-43ab2b2f11bso12485001cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613624; x=1715218424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKrNsogFInAjTfK+Y0J/3tTJOdF5LnuiSICyjf8gKLs=;
 b=tZR9E4eRxz/U4y/CCCz+xrIish+CogDRigiJywMWFkClQcLMAXZ0rpQIwwdgveFC+s
 Zkn88iWCSHJ2jelh+RdatIJ7ljuHmu3DRNXhuSQeXWPQZO+rKpVGLT+316ZKyjdFf06z
 bMWu1dtRnQENK9QaBQltNCKYc9s1Rzw3QWDjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613624; x=1715218424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKrNsogFInAjTfK+Y0J/3tTJOdF5LnuiSICyjf8gKLs=;
 b=TzcZ7xC4FedcbCaBnkQFW0V6CyXgDv8BPCqWjeBkoGdtdLmnx/U7P+rD3c2f103+om
 ewcb0wipCvmx0wL7YbjpTEYxJ/1W/exOPqeAAFHBF6bg8bjeVj1WIpnyC6Cl9NlSdQMF
 idQISVFAQq2ocMK9ROu6lkjvPFwbI/calubFuidiP8ZXg9WRyXw6lPU1Eamdu2/26Ul9
 CgdXt/YB2uwNdjG3C+rKNKmNEyrEWUn77eaap8O7Utyqnu+Js9yHrX0u8SkJ3p+PVqeq
 Kh1abN0smLLHZ6VidHu7/re75fnydu9J2M9jD6E7N6pfTd2oFZX/ty2MXNKAkjhQ9P0U
 58Mw==
X-Gm-Message-State: AOJu0YzNiFEb5zKAVu+aZMI9cwoRMlqeUseHybub6ckbR2Gym79ERth6
 UYQG9arYyeYWnALhlw7IFLkpEFXxp3P97PbJnj0Z89OxCqMpM93J6DLE7k9G8zNvz1bzk9+oxez
 ZMq03WP1B
X-Google-Smtp-Source: AGHT+IG66YEWfdFa2YFgQPwGPVINMevxOjteOr+P7ziCGlZlJHdzYiP0TphBmyT2HOWGH2ucUWl4pQ==
X-Received: by 2002:ac8:570b:0:b0:43a:f150:a4ac with SMTP id
 11-20020ac8570b000000b0043af150a4acmr4321631qtw.48.1714613624337; 
 Wed, 01 May 2024 18:33:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH 63/81] soc: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:20 -0600
Message-Id: <20240502013138.2383421-63-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>
Cc: Bryan Brattlof <bb@ti.com>
---
 drivers/soc/soc-uclass.c            | 1 -
 drivers/soc/soc_sandbox.c           | 1 -
 drivers/soc/soc_ti_k3.c             | 1 -
 drivers/soc/soc_xilinx_versal.c     | 1 -
 drivers/soc/soc_xilinx_versal_net.c | 1 -
 drivers/soc/soc_xilinx_zynqmp.c     | 1 -
 drivers/soc/ti/k3-navss-ringacc.c   | 1 -
 drivers/soc/ti/keystone_serdes.c    | 1 -
 drivers/soc/ti/pruss.c              | 1 -
 9 files changed, 9 deletions(-)

diff --git a/drivers/soc/soc-uclass.c b/drivers/soc/soc-uclass.c
index 8b3044fed8d2..744cdda2e187 100644
--- a/drivers/soc/soc-uclass.c
+++ b/drivers/soc/soc-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_SOC
 
-#include <common.h>
 #include <soc.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/soc/soc_sandbox.c b/drivers/soc/soc_sandbox.c
index 15fdd9930cb4..8d621e88f567 100644
--- a/drivers/soc/soc_sandbox.c
+++ b/drivers/soc/soc_sandbox.c
@@ -6,7 +6,6 @@
  * Dave Gerlach <d-gerlach@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <soc.h>
 
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index 3a4e58bba671..b585e47d46fe 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -4,7 +4,6 @@
  *	Dave Gerlach <d-gerlach@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <soc.h>
 
diff --git a/drivers/soc/soc_xilinx_versal.c b/drivers/soc/soc_xilinx_versal.c
index 3d8c25c19bb6..7427f8432c8b 100644
--- a/drivers/soc/soc_xilinx_versal.c
+++ b/drivers/soc/soc_xilinx_versal.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <soc.h>
 #include <zynqmp_firmware.h>
diff --git a/drivers/soc/soc_xilinx_versal_net.c b/drivers/soc/soc_xilinx_versal_net.c
index 146d068bb4ae..d64fc366a6d1 100644
--- a/drivers/soc/soc_xilinx_versal_net.c
+++ b/drivers/soc/soc_xilinx_versal_net.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022, Advanced Micro Devices, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <soc.h>
 #include <zynqmp_firmware.h>
diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index d8b4f172a39d..a2d5b82fd34d 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -9,7 +9,6 @@
  * Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <asm/cache.h>
diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index ed39ff2fa4c7..d3f3d4761c2f 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/cache.h>
diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/keystone_serdes.c
index 0e1bf8ff39db..b19617997e1a 100644
--- a/drivers/soc/ti/keystone_serdes.c
+++ b/drivers/soc/ti/keystone_serdes.c
@@ -7,7 +7,6 @@
  */
 
 #include <errno.h>
-#include <common.h>
 #include <asm/io.h>
 #include <asm/ti-common/keystone_serdes.h>
 #include <linux/bitops.h>
diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 461390925d2c..8df8140cc186 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/of_access.h>
 #include <errno.h>
-- 
2.34.1

