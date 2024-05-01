Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF164C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A859F88CCB;
	Wed,  1 May 2024 04:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="thctmCa7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BECC88CD3; Wed,  1 May 2024 04:45:58 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA3E88C1B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47a404c6decso1862462137.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531555; x=1715136355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GueCjI0dw3Xd6Vyy5CFDkikeUrE4XCiSlAjCDi3a3EM=;
 b=thctmCa7Gm9szFdYboSnXiU0gxxPiQ185ZCCxinP46sTd1wu2rUsn0Ogwf2e1xrwO8
 HcqU4OSImNtHQl0FluN5A+mk9koRQtZzrsbuEnraTtZWBH1Qw0DTqGgwkIZGlLCmaZyo
 oBskSD/Pl0D1dJn+4/0XSxCDp10M8/FadpmTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531555; x=1715136355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GueCjI0dw3Xd6Vyy5CFDkikeUrE4XCiSlAjCDi3a3EM=;
 b=r8VmTKUctjopd/eismp8WpN5v3xPfCVx88dnE3e2ikAnniruKfbpPAD4L7jYy75gp3
 o3y0eMNYZg8+cpzkPlIqNO9eoTznD8PXJCMZLQLxTJrQYfx5XRxLKrl0K26iQE8j1bxL
 +bAPACstLvpcnvFwKYzckW68uUVOCgUS1lEXtjf3ZJyasNyBDRjGdYOvrCVUXynRmPWd
 py5Z9b/aDYp6YIACG+SfSxXT6xtCSE6wTh3h06/Ny+Y2UmqZmJzA0UeAQhVvH4CyGRu/
 7jTIfGpPxy/1LX0TeYNcfI315C61HTzqWZrjLgnGsOX0NG26pfvrLcxJHaPJ3FnOipFs
 HuTA==
X-Gm-Message-State: AOJu0YwYEUVYIriiKuQBSKby0KPP6xOx/E6G6+2x6dNciuFULImTHK6m
 MZ+Pxqn0sMdvR+YgpwFtYqblx2iui12fArzsijFz1+ijOfpRYrurcNpP2YSwHb/3IoJh0lV9HFu
 F1wVI0vwP
X-Google-Smtp-Source: AGHT+IHdSjhHj4hK09BNWawlFutHk8WkRpP5lN4s1XFzfO0Mp/BvoYY2ZCL/w7OgwZjrJJaZ86K1kA==
X-Received: by 2002:a05:6102:2174:b0:47c:3033:5faa with SMTP id
 i20-20020a056102217400b0047c30335faamr1627863vsg.20.1714531554821; 
 Tue, 30 Apr 2024 19:45:54 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH 137/149] board: toradex: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:04 -0600
Message-Id: <20240501024316.1767971-137-trini@konsulko.com>
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
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c         | 1 -
 board/toradex/apalis-tk1/apalis-tk1.c           | 1 -
 board/toradex/apalis-tk1/as3722_init.c          | 1 -
 board/toradex/apalis_imx6/apalis_imx6.c         | 2 +-
 board/toradex/apalis_imx6/do_fuse.c             | 1 -
 board/toradex/apalis_imx6/pf0100.c              | 1 -
 board/toradex/apalis_t30/apalis_t30-spl.c       | 1 -
 board/toradex/apalis_t30/apalis_t30.c           | 1 -
 board/toradex/colibri-imx6ull/colibri-imx6ull.c | 2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c     | 1 -
 board/toradex/colibri_imx6/colibri_imx6.c       | 2 +-
 board/toradex/colibri_imx6/do_fuse.c            | 1 -
 board/toradex/colibri_imx6/pf0100.c             | 1 -
 board/toradex/colibri_imx7/colibri_imx7.c       | 1 -
 board/toradex/colibri_t20/colibri_t20.c         | 1 -
 board/toradex/colibri_t30/colibri_t30-spl.c     | 1 -
 board/toradex/colibri_t30/colibri_t30.c         | 1 -
 board/toradex/colibri_vf/colibri_vf.c           | 1 -
 board/toradex/common/tdx-cfg-block.c            | 2 +-
 board/toradex/common/tdx-common.c               | 2 +-
 board/toradex/verdin-imx8mm/spl.c               | 1 -
 board/toradex/verdin-imx8mm/verdin-imx8mm.c     | 2 +-
 board/toradex/verdin-imx8mp/spl.c               | 1 -
 board/toradex/verdin-imx8mp/verdin-imx8mp.c     | 2 +-
 24 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 0f993e644d71..72d67d90d418 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Toradex
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/toradex/apalis-tk1/apalis-tk1.c b/board/toradex/apalis-tk1/apalis-tk1.c
index ee87d9f4145f..4557ed1f1f2f 100644
--- a/board/toradex/apalis-tk1/apalis-tk1.c
+++ b/board/toradex/apalis-tk1/apalis-tk1.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016-2018 Toradex, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/toradex/apalis-tk1/as3722_init.c b/board/toradex/apalis-tk1/as3722_init.c
index e9bd1028bed5..8971f7aa16a1 100644
--- a/board/toradex/apalis-tk1/as3722_init.c
+++ b/board/toradex/apalis-tk1/as3722_init.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2012-2016 Toradex, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/tegra_i2c.h>
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 0da245374a0d..2dcc042ab266 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -6,7 +6,7 @@
  * copied from nitrogen6x
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <image.h>
diff --git a/board/toradex/apalis_imx6/do_fuse.c b/board/toradex/apalis_imx6/do_fuse.c
index 6991b1bc136e..b404b01e032e 100644
--- a/board/toradex/apalis_imx6/do_fuse.c
+++ b/board/toradex/apalis_imx6/do_fuse.c
@@ -7,7 +7,6 @@
  * Helpers for i.MX OTP fusing during module production
 */
 
-#include <common.h>
 #ifndef CONFIG_SPL_BUILD
 #include <command.h>
 #include <console.h>
diff --git a/board/toradex/apalis_imx6/pf0100.c b/board/toradex/apalis_imx6/pf0100.c
index c89052ff5daa..157aaec6fe08 100644
--- a/board/toradex/apalis_imx6/pf0100.c
+++ b/board/toradex/apalis_imx6/pf0100.c
@@ -7,7 +7,6 @@
  * Helpers for Freescale PMIC PF0100
 */
 
-#include <common.h>
 #include <command.h>
 #include <i2c.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/toradex/apalis_t30/apalis_t30-spl.c b/board/toradex/apalis_t30/apalis_t30-spl.c
index 6e544641833e..250494524952 100644
--- a/board/toradex/apalis_t30/apalis_t30-spl.c
+++ b/board/toradex/apalis_t30/apalis_t30-spl.c
@@ -7,7 +7,6 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/toradex/apalis_t30/apalis_t30.c b/board/toradex/apalis_t30/apalis_t30.c
index b10beb447965..02e8f8eb1fed 100644
--- a/board/toradex/apalis_t30/apalis_t30.c
+++ b/board/toradex/apalis_t30/apalis_t30.c
@@ -4,7 +4,6 @@
  *  Marcel Ziswiler <marcel@ziswiler.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/toradex/colibri-imx6ull/colibri-imx6ull.c b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
index 9b9fb342c9d9..7bfe200d6e4c 100644
--- a/board/toradex/colibri-imx6ull/colibri-imx6ull.c
+++ b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2018-2019 Toradex AG
  */
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <linux/delay.h>
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 356578525951..2a71e7b92de4 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -3,7 +3,6 @@
  * Copyright 2019 Toradex
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index ce19a9c79752..34e82c2b0780 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -6,7 +6,7 @@
  * copied from nitrogen6x
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <env.h>
diff --git a/board/toradex/colibri_imx6/do_fuse.c b/board/toradex/colibri_imx6/do_fuse.c
index 6991b1bc136e..b404b01e032e 100644
--- a/board/toradex/colibri_imx6/do_fuse.c
+++ b/board/toradex/colibri_imx6/do_fuse.c
@@ -7,7 +7,6 @@
  * Helpers for i.MX OTP fusing during module production
 */
 
-#include <common.h>
 #ifndef CONFIG_SPL_BUILD
 #include <command.h>
 #include <console.h>
diff --git a/board/toradex/colibri_imx6/pf0100.c b/board/toradex/colibri_imx6/pf0100.c
index 8f08d8c7337c..58b7bc3bb9ae 100644
--- a/board/toradex/colibri_imx6/pf0100.c
+++ b/board/toradex/colibri_imx6/pf0100.c
@@ -7,7 +7,6 @@
  * Helpers for Freescale PMIC PF0100
 */
 
-#include <common.h>
 #include <command.h>
 #include <i2c.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index c37c5e0af6d9..e966ffbf7818 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016-2018 Toradex AG
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibri_t20/colibri_t20.c
index 97e33d00f0d6..6425fa881ea6 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -3,7 +3,6 @@
  *  Copyright (C) 2012 Lucas Stach
  */
 
-#include <common.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
diff --git a/board/toradex/colibri_t30/colibri_t30-spl.c b/board/toradex/colibri_t30/colibri_t30-spl.c
index 6e544641833e..250494524952 100644
--- a/board/toradex/colibri_t30/colibri_t30-spl.c
+++ b/board/toradex/colibri_t30/colibri_t30-spl.c
@@ -7,7 +7,6 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/toradex/colibri_t30/colibri_t30.c b/board/toradex/colibri_t30/colibri_t30.c
index 0da247de98f9..342673ac506c 100644
--- a/board/toradex/colibri_t30/colibri_t30.c
+++ b/board/toradex/colibri_t30/colibri_t30.c
@@ -4,7 +4,6 @@
  *  Stefan Agner <stefan@agner.ch>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <asm/arch/gp_padctrl.h>
diff --git a/board/toradex/colibri_vf/colibri_vf.c b/board/toradex/colibri_vf/colibri_vf.c
index 35920008805f..87f82396d63a 100644
--- a/board/toradex/colibri_vf/colibri_vf.c
+++ b/board/toradex/colibri_vf/colibri_vf.c
@@ -6,7 +6,6 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 
diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index dcf00d2b6325..2225cefec167 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2016-2020 Toradex
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include "tdx-cfg-block.h"
 #include "tdx-eeprom.h"
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index 9f09788137d5..a6b45cdab810 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -4,7 +4,7 @@
  */
 
 #include <dm.h>
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <g_dnl.h>
 #include <init.h>
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8mm/spl.c
index afa3686083a4..1020078afea2 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Toradex
  */
 
-#include <common.h>
 #include <command.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 55c02653da68..020ee6774807 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -3,7 +3,7 @@
  * Copyright 2020-2021 Toradex
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/toradex/verdin-imx8mp/spl.c b/board/toradex/verdin-imx8mp/spl.c
index 73729a42b458..8628112a7825 100644
--- a/board/toradex/verdin-imx8mp/spl.c
+++ b/board/toradex/verdin-imx8mp/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Toradex
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
index e16a771e3ec1..e57ec3b68967 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -3,7 +3,7 @@
  * Copyright 2022 Toradex
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
-- 
2.34.1

