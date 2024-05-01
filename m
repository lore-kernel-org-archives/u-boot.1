Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A68C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFBE88B1C;
	Wed,  1 May 2024 04:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pp2ZgYOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C2788B35; Wed,  1 May 2024 04:44:10 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C672D88B23
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4dcc7c1055bso2004173e0c.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531446; x=1715136246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzpzVNqp+i+Y0bpldMTN7oZV1QtCKHsmdnBRC0I1zsw=;
 b=Pp2ZgYOF6sMspaszVmtlju+U4dxE6Kd6I7vF3Hl6cdUR1IjwErDFfxJVuwXs64YuDR
 cwRyINyVAE7DBODa9QkoE5/QDWRpo0DAou4seZSD+H6Di6op7mR0LngOWLY9PAHrFKTm
 eBt86GnRTGPAqXsNHIoFII+61z9EkAYPItKQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531446; x=1715136246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzpzVNqp+i+Y0bpldMTN7oZV1QtCKHsmdnBRC0I1zsw=;
 b=LkSomsdAqvHOg/6Age4g0SA9OjQ+Q++kjtCBmnDvJozlXBTSksH9i55T7QbTaMyM/F
 4iEffdPY5phTTLhfpbClNy8gEVImUCWz0rRfesDQZbr1kbRk1lm+yehFV5AKfuzRRO9b
 Z+Qd92eTuhiBreedCREgO7v4U/qvi59pI2jLKwe9mnfAGU+f9UKncRzGGT18Sj0BvTs8
 B1JyHStYU0O0GptmIaEPMmOcqYMpDoCyvtvTqRn8rj/ZjvM6nGauBiNM1E8tTGdXgUNR
 H1fdq8VzHTnFlm0jt0qoZNnKXaZlyx0wvi3Zuw4Ep0OYumcDbOuLmUn0OouIxuAgynXi
 OTfw==
X-Gm-Message-State: AOJu0YxDUztRML4F9MBFcTGgi96QE+eWz2k0+GFYS/IG94DcglDfrab+
 in1HFYnpX5K5Fw2IOwMRitYTEh1xfqt7hIPFw23F5IIcsLfvKtT8wfnxMhrHNsGXE3X9/yoXR1+
 fBlKIGw==
X-Google-Smtp-Source: AGHT+IGZpOV6s2og6RMVIzX3TxWz6AcpKCgmbyjTTTizxlAT6kRv9/uWpizG5/PBsZ/7k1o0DQOK2w==
X-Received: by 2002:a05:6122:3c43:b0:4d4:3621:b245 with SMTP id
 fv3-20020a0561223c4300b004d43621b245mr1495195vkb.16.1714531446447; 
 Tue, 30 Apr 2024 19:44:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Uri Mashiach <uri.mashiach@compulab.co.il>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Tom Warren <twarren@nvidia.com>, Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 041/149] board: compulab: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:28 -0600
Message-Id: <20240501024316.1767971-41-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Uri Mashiach <uri.mashiach@compulab.co.il>
Cc: Nikita Kiryanov <nikita@compulab.co.il>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Tom Warren <twarren@nvidia.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
---
 board/compulab/cl-som-imx7/cl-som-imx7.c                       | 2 +-
 board/compulab/cl-som-imx7/common.c                            | 1 -
 board/compulab/cl-som-imx7/mux.c                               | 2 +-
 board/compulab/cl-som-imx7/spl.c                               | 1 -
 board/compulab/cm_fx6/cm_fx6.c                                 | 2 +-
 board/compulab/cm_fx6/common.c                                 | 1 -
 board/compulab/cm_fx6/spl.c                                    | 1 -
 board/compulab/cm_t43/cm_t43.c                                 | 2 +-
 board/compulab/cm_t43/mux.c                                    | 1 -
 board/compulab/cm_t43/spl.c                                    | 2 +-
 board/compulab/common/common.c                                 | 1 -
 board/compulab/common/eeprom.c                                 | 3 ++-
 board/compulab/common/omap3_smc911x.c                          | 1 -
 board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c                    | 1 -
 .../imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.1_2.c        | 1 -
 board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.c | 1 -
 board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff000110.c | 1 -
 board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff020008.c | 1 -
 board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c                 | 2 +-
 board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c         | 1 -
 board/compulab/imx8mm-cl-iot-gate/spl.c                        | 1 -
 board/compulab/trimslice/trimslice.c                           | 1 -
 22 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/board/compulab/cl-som-imx7/cl-som-imx7.c b/board/compulab/cl-som-imx7/cl-som-imx7.c
index af19a658b542..7853c4d024a3 100644
--- a/board/compulab/cl-som-imx7/cl-som-imx7.c
+++ b/board/compulab/cl-som-imx7/cl-som-imx7.c
@@ -7,7 +7,7 @@
  * Author: Uri Mashiach <uri.mashiach@compulab.co.il>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <init.h>
 #include <mmc.h>
diff --git a/board/compulab/cl-som-imx7/common.c b/board/compulab/cl-som-imx7/common.c
index 40ba0f7a9605..ae8e83466207 100644
--- a/board/compulab/cl-som-imx7/common.c
+++ b/board/compulab/cl-som-imx7/common.c
@@ -7,7 +7,6 @@
  * Author: Uri Mashiach <uri.mashiach@compulab.co.il>
  */
 
-#include <common.h>
 #include <fsl_esdhc_imx.h>
 #include <asm-generic/gpio.h>
 #include "common.h"
diff --git a/board/compulab/cl-som-imx7/mux.c b/board/compulab/cl-som-imx7/mux.c
index 18f16a48738c..25123ee145a6 100644
--- a/board/compulab/cl-som-imx7/mux.c
+++ b/board/compulab/cl-som-imx7/mux.c
@@ -7,7 +7,7 @@
  * Author: Uri Mashiach <uri.mashiach@compulab.co.il>
  */
 
-#include <common.h>
+#include <linux/kernel.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/arch-mx7/mx7-pins.h>
 
diff --git a/board/compulab/cl-som-imx7/spl.c b/board/compulab/cl-som-imx7/spl.c
index 98c3b831f1e1..9b6bbb974da7 100644
--- a/board/compulab/cl-som-imx7/spl.c
+++ b/board/compulab/cl-som-imx7/spl.c
@@ -7,7 +7,6 @@
  * Author: Uri Mashiach <uri.mashiach@compulab.co.il>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index 7bce09e432c0..4a6cc3e56308 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -7,7 +7,7 @@
  * Author: Nikita Kiryanov <nikita@compulab.co.il>
  */
 
-#include <common.h>
+#include <config.h>
 #include <ahci.h>
 #include <dm.h>
 #include <dwc_ahsata.h>
diff --git a/board/compulab/cm_fx6/common.c b/board/compulab/cm_fx6/common.c
index ed8c7a3bf5f8..a71861b1731b 100644
--- a/board/compulab/cm_fx6/common.c
+++ b/board/compulab/cm_fx6/common.c
@@ -7,7 +7,6 @@
  * Author: Nikita Kiryanov <nikita@compulab.co.il>
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
 #include <asm/mach-imx/spi.h>
diff --git a/board/compulab/cm_fx6/spl.c b/board/compulab/cm_fx6/spl.c
index 079f196200e5..b11bf2d28c68 100644
--- a/board/compulab/cm_fx6/spl.c
+++ b/board/compulab/cm_fx6/spl.c
@@ -7,7 +7,6 @@
  * Author: Nikita Kiryanov <nikita@compulab.co.il>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/compulab/cm_t43/cm_t43.c b/board/compulab/cm_t43/cm_t43.c
index 5df378a62e3c..181581926c37 100644
--- a/board/compulab/cm_t43/cm_t43.c
+++ b/board/compulab/cm_t43/cm_t43.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015 Compulab, Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <miiphy.h>
 #include <cpsw.h>
diff --git a/board/compulab/cm_t43/mux.c b/board/compulab/cm_t43/mux.c
index 778ea05e84cb..f10910565d50 100644
--- a/board/compulab/cm_t43/mux.c
+++ b/board/compulab/cm_t43/mux.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Compulab, Ltd.
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mux.h>
 #include "board.h"
diff --git a/board/compulab/cm_t43/spl.c b/board/compulab/cm_t43/spl.c
index a6223a477fef..212bfeb5c307 100644
--- a/board/compulab/cm_t43/spl.c
+++ b/board/compulab/cm_t43/spl.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Compulab, Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
diff --git a/board/compulab/common/common.c b/board/compulab/common/common.c
index 528c97df19a4..6ffebe6bdb41 100644
--- a/board/compulab/common/common.c
+++ b/board/compulab/common/common.c
@@ -5,7 +5,6 @@
  * Authors: Igor Grinberg <grinberg@compulab.co.il>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/bootm.h>
 #include <asm/gpio.h>
diff --git a/board/compulab/common/eeprom.c b/board/compulab/common/eeprom.c
index 4c752821d6cd..efdaf342d5c3 100644
--- a/board/compulab/common/eeprom.c
+++ b/board/compulab/common/eeprom.c
@@ -6,12 +6,13 @@
  *	    Igor Grinberg <grinberg@compulab.co.il>
  */
 
-#include <common.h>
 #include <i2c.h>
+#include <vsprintf.h>
 #include <eeprom_layout.h>
 #include <eeprom_field.h>
 #include <asm/setup.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include "eeprom.h"
 
 #define EEPROM_LAYOUT_VER_OFFSET	44
diff --git a/board/compulab/common/omap3_smc911x.c b/board/compulab/common/omap3_smc911x.c
index f0d365272c1b..411fc4943bac 100644
--- a/board/compulab/common/omap3_smc911x.c
+++ b/board/compulab/common/omap3_smc911x.c
@@ -5,7 +5,6 @@
  * Authors: Igor Grinberg <grinberg@compulab.co.il>
  */
 
-#include <common.h>
 #include <netdev.h>
 #include <linux/delay.h>
 
diff --git a/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c b/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c
index b230478b611a..99d3bf3af3bc 100644
--- a/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c
+++ b/board/compulab/imx8mm-cl-iot-gate/ddr/ddr.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <errno.h>
diff --git a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.1_2.c b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.1_2.c
index 9019a1f2035c..efcc95c739fd 100644
--- a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.1_2.c
+++ b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.1_2.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.c b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.c
index 5141c04f12dc..67f59ed9407f 100644
--- a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.c
+++ b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_01061010.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff000110.c b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff000110.c
index 2334722497db..273ee89c0bc6 100644
--- a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff000110.c
+++ b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff000110.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff020008.c b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff020008.c
index e65445e01559..1243800b3241 100644
--- a/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff020008.c
+++ b/board/compulab/imx8mm-cl-iot-gate/ddr/lpddr4_timing_ff020008.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c b/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
index 90cc33a6e460..1256848f9a98 100644
--- a/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/eeprom_spl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* (C) Copyright 2019 CompuLab, Ltd. <www.compulab.co.il> */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <linux/kernel.h>
 #include <asm/arch/imx8mq_pins.h>
diff --git a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
index af070ec315c4..ba1587341428 100644
--- a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
+++ b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
@@ -4,7 +4,6 @@
  * Copyright 2020 Linaro
  */
 
-#include <common.h>
 #include <efi.h>
 #include <efi_loader.h>
 #include <env.h>
diff --git a/board/compulab/imx8mm-cl-iot-gate/spl.c b/board/compulab/imx8mm-cl-iot-gate/spl.c
index 19c1acd8a525..6d9af2538b63 100644
--- a/board/compulab/imx8mm-cl-iot-gate/spl.c
+++ b/board/compulab/imx8mm-cl-iot-gate/spl.c
@@ -4,7 +4,6 @@
  * Copyright 2020 Linaro
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <hang.h>
diff --git a/board/compulab/trimslice/trimslice.c b/board/compulab/trimslice/trimslice.c
index 21ff0cda7f70..af05c0c0f059 100644
--- a/board/compulab/trimslice/trimslice.c
+++ b/board/compulab/trimslice/trimslice.c
@@ -4,7 +4,6 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/tegra.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

