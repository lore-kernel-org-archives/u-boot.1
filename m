Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE1C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187DF88D09;
	Thu,  2 May 2024 03:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G8KIrwDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF4388D14; Thu,  2 May 2024 03:34:17 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7E088CC5
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-de60a51fe21so3185625276.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613653; x=1715218453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUaeiAIOamXq69CqWep7HpZiWv/jaC1d2239PAMoe3w=;
 b=G8KIrwDCcQ/X1p9OQ06Yjv5Yxiq5b2e4hYHytKSWyHb/V5CJhyzxq0qpLOVzjiDHUW
 MlD14l2jx0UheyZ+cREaXx/BFffNtmvOTt6Sjf2+Wd0mJYPvo1ych4DinpdAvIsxvfz3
 pLXqYArhv5rno7bXn8TeGtsmuBkVNsIQ7mV6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613653; x=1715218453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUaeiAIOamXq69CqWep7HpZiWv/jaC1d2239PAMoe3w=;
 b=km6NG+x/wAQIFXyFubn0j6QBMgAjmnyIcLMa47ba+Ck0Svb4DVFsXP5JfOnQM+29be
 OlJihks6QiRw2seNvWFes2xSdoRqBd7DFI1t/P1xAzTlQZUADwidVtIePUYy63P+uH6d
 15GP1jkRFKDC3fzWr6Ikj8zw8YwN0W+CGHdxnK+kp9qdxZuD5+rGDF/YEW8pNcGBP6Lz
 8NJzw4G0BTK/zNZNjnceYn6VhuHdYnjJbRxf14HwzC3cr5jWIBXFrEY0klPrJbnM4sZQ
 WICwpJcuwACpV2eBt7XiBNCSIRYsA0yjqSN8DwXSBgu6ddUtStUD0dceRwYwujmJpZgw
 JdjA==
X-Gm-Message-State: AOJu0YwVTPwF8+7002jMcVOhUXWoRZZBNUrjMwMEOm+qLLXOPmwAdGDu
 AfUZh1EAAzoKnMMtgHaRVohvm+stakONk9qHIhtg51QAbb2Xyp+0ZD88AcqqhgHBChwZt+Thv1h
 byTtz+q+F
X-Google-Smtp-Source: AGHT+IF2tDl3eVYAtcqQAO0vgIxzjQx1A14u0MhdH9fnKWseKJ/h2yKpkyREdA/O4YVGMdZGcsJu8Q==
X-Received: by 2002:a05:6902:250e:b0:de6:fe6:68a2 with SMTP id
 dt14-20020a056902250e00b00de60fe668a2mr829516ybb.23.1714613653594; 
 Wed, 01 May 2024 18:34:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Michal Simek <michal.simek@amd.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Michael Walle <michael@walle.cc>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 78/81] watchdog: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:35 -0600
Message-Id: <20240502013138.2383421-78-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/watchdog/armada-37xx-wdt.c   | 1 -
 drivers/watchdog/ast2600_wdt.c       | 1 -
 drivers/watchdog/ast_wdt.c           | 1 -
 drivers/watchdog/at91sam9_wdt.c      | 1 -
 drivers/watchdog/bcm6345_wdt.c       | 1 -
 drivers/watchdog/cdns_wdt.c          | 1 -
 drivers/watchdog/cortina_wdt.c       | 1 -
 drivers/watchdog/designware_wdt.c    | 1 -
 drivers/watchdog/ftwdt010_wdt.c      | 1 -
 drivers/watchdog/imx_watchdog.c      | 1 -
 drivers/watchdog/mcf_wdt.c           | 2 +-
 drivers/watchdog/mpc8xxx_wdt.c       | 1 -
 drivers/watchdog/mt7621_wdt.c        | 1 -
 drivers/watchdog/mtk_wdt.c           | 1 -
 drivers/watchdog/omap_wdt.c          | 1 -
 drivers/watchdog/orion_wdt.c         | 1 -
 drivers/watchdog/rti_wdt.c           | 1 -
 drivers/watchdog/s5p_wdt.c           | 1 -
 drivers/watchdog/sandbox_alarm-wdt.c | 1 -
 drivers/watchdog/sandbox_wdt.c       | 1 -
 drivers/watchdog/sbsa_gwdt.c         | 1 -
 drivers/watchdog/sl28cpld-wdt.c      | 1 -
 drivers/watchdog/sp805_wdt.c         | 1 -
 drivers/watchdog/stm32mp_wdt.c       | 1 -
 drivers/watchdog/tangier_wdt.c       | 1 -
 drivers/watchdog/ulp_wdog.c          | 1 -
 drivers/watchdog/wdt-uclass.c        | 1 -
 drivers/watchdog/xilinx_tb_wdt.c     | 1 -
 drivers/watchdog/xilinx_wwdt.c       | 1 -
 29 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/watchdog/armada-37xx-wdt.c b/drivers/watchdog/armada-37xx-wdt.c
index e09f5ac9e34e..4b51178e1b8c 100644
--- a/drivers/watchdog/armada-37xx-wdt.c
+++ b/drivers/watchdog/armada-37xx-wdt.c
@@ -5,7 +5,6 @@
  * Marek Behún <kabel@kernel.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <wdt.h>
 #include <asm/global_data.h>
diff --git a/drivers/watchdog/ast2600_wdt.c b/drivers/watchdog/ast2600_wdt.c
index bc9842089bea..190490f3692b 100644
--- a/drivers/watchdog/ast2600_wdt.c
+++ b/drivers/watchdog/ast2600_wdt.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Aspeed Technology, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/watchdog/ast_wdt.c b/drivers/watchdog/ast_wdt.c
index f7b5a1adc108..e61e13fdc49d 100644
--- a/drivers/watchdog/ast_wdt.c
+++ b/drivers/watchdog/ast_wdt.c
@@ -3,7 +3,6 @@
  * Copyright 2017 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 647ae325e9ae..c809a8936b89 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -18,7 +18,6 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/at91_wdt.h>
-#include <common.h>
 #include <div64.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/watchdog/bcm6345_wdt.c b/drivers/watchdog/bcm6345_wdt.c
index 677b1347ca7a..6ebe901c2b82 100644
--- a/drivers/watchdog/bcm6345_wdt.c
+++ b/drivers/watchdog/bcm6345_wdt.c
@@ -7,7 +7,6 @@
  *	Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/cdns_wdt.c b/drivers/watchdog/cdns_wdt.c
index 743ab6487bcd..cb5a786c5891 100644
--- a/drivers/watchdog/cdns_wdt.c
+++ b/drivers/watchdog/cdns_wdt.c
@@ -6,7 +6,6 @@
  * Author(s):	Shreenidhi Shedi <yesshedi@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/cortina_wdt.c b/drivers/watchdog/cortina_wdt.c
index 7ab9d7b2db97..9f09ac0e15ff 100644
--- a/drivers/watchdog/cortina_wdt.c
+++ b/drivers/watchdog/cortina_wdt.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hang.h>
 #include <asm/io.h>
diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
index b22e0ee06a4e..bd9d7105366b 100644
--- a/drivers/watchdog/designware_wdt.c
+++ b/drivers/watchdog/designware_wdt.c
@@ -4,7 +4,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <reset.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index 1f5f301b1251..4769b967e527 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -14,7 +14,6 @@
  * 22/08/2022 Port to DM
  */
 
-#include <common.h>
 #include <dm.h>
 #include <wdt.h>
 #include <log.h>
diff --git a/drivers/watchdog/imx_watchdog.c b/drivers/watchdog/imx_watchdog.c
index 894158b304a7..ea770217e590 100644
--- a/drivers/watchdog/imx_watchdog.c
+++ b/drivers/watchdog/imx_watchdog.c
@@ -4,7 +4,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <hang.h>
diff --git a/drivers/watchdog/mcf_wdt.c b/drivers/watchdog/mcf_wdt.c
index b36488bb5b96..5092a256af0c 100644
--- a/drivers/watchdog/mcf_wdt.c
+++ b/drivers/watchdog/mcf_wdt.c
@@ -6,7 +6,7 @@
  *
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <hang.h>
 #include <asm/io.h>
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index f28636ca9015..036ff690d3fd 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -3,7 +3,6 @@
  * Copyright 2017 CS Systemes d'Information
  */
 
-#include <common.h>
 #include <env.h>
 #include <dm.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index f7d201b921a1..6308d9632a81 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -9,7 +9,6 @@
  *   Copyright (C) 2013 John Crispin <blogic@openwrt.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <wdt.h>
 #include <asm/global_data.h>
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 368b36849c8d..706deb9da846 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -6,7 +6,6 @@
  * Author: Ryder Lee <ryder.lee@mediatek.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hang.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index f0e57b4f7286..5fd02ddf564f 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -36,7 +36,6 @@
  *	Use the driver model and standard identifiers; handle bigger timeouts.
  */
 
-#include <common.h>
 #include <log.h>
 #include <watchdog.h>
 #include <asm/ti-common/omap_wdt.h>
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 127766df58af..4562b2a37e34 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -12,7 +12,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <clk.h>
 #include <log.h>
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 8d93f19b984a..99168d0cad03 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -8,7 +8,6 @@
  * Derived from linux/drivers/watchdog/rti_wdt.c
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/watchdog/s5p_wdt.c b/drivers/watchdog/s5p_wdt.c
index 80524a00101b..c244f15a8952 100644
--- a/drivers/watchdog/s5p_wdt.c
+++ b/drivers/watchdog/s5p_wdt.c
@@ -4,7 +4,6 @@
  * Minkyu Kang <mk7.kang@samsung.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/watchdog.h>
diff --git a/drivers/watchdog/sandbox_alarm-wdt.c b/drivers/watchdog/sandbox_alarm-wdt.c
index 71bb5d924ea5..8dbbfc249e7c 100644
--- a/drivers/watchdog/sandbox_alarm-wdt.c
+++ b/drivers/watchdog/sandbox_alarm-wdt.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <dm.h>
 #include <os.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
index 535614f04d63..cd5eadbfd213 100644
--- a/drivers/watchdog/sandbox_wdt.c
+++ b/drivers/watchdog/sandbox_wdt.c
@@ -3,7 +3,6 @@
  * Copyright 2017 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <wdt.h>
 #include <asm/state.h>
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 96d04665d52c..03585529bb63 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -7,7 +7,6 @@
 
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <common.h>
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
 #include <dm/read.h>
diff --git a/drivers/watchdog/sl28cpld-wdt.c b/drivers/watchdog/sl28cpld-wdt.c
index af5a6b1a28ac..c5b4f8a9f665 100644
--- a/drivers/watchdog/sl28cpld-wdt.c
+++ b/drivers/watchdog/sl28cpld-wdt.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2021 Michael Walle <michael@walle.cc>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <wdt.h>
 #include <sl28cpld.h>
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 6d58fd3cfdab..10fe3e282323 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -8,7 +8,6 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <common.h>
 #include <clk.h>
 #include <dm/device.h>
 #include <dm/fdtaddr.h>
diff --git a/drivers/watchdog/stm32mp_wdt.c b/drivers/watchdog/stm32mp_wdt.c
index 7ebcd2552668..97ab8cfe7ab1 100644
--- a/drivers/watchdog/stm32mp_wdt.c
+++ b/drivers/watchdog/stm32mp_wdt.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_WDT
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/watchdog/tangier_wdt.c b/drivers/watchdog/tangier_wdt.c
index bdc65597dcff..8fbfac31b1e1 100644
--- a/drivers/watchdog/tangier_wdt.c
+++ b/drivers/watchdog/tangier_wdt.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2017 Intel Corporation
  */
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
index 0eea04ed2c6e..83f19dc0e86b 100644
--- a/drivers/watchdog/ulp_wdog.c
+++ b/drivers/watchdog/ulp_wdog.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 417e8d7eef95..c88312ec7218 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_WDT
 
-#include <common.h>
 #include <cyclic.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/watchdog/xilinx_tb_wdt.c b/drivers/watchdog/xilinx_tb_wdt.c
index b38c40001611..8a8e55370a0e 100644
--- a/drivers/watchdog/xilinx_tb_wdt.c
+++ b/drivers/watchdog/xilinx_tb_wdt.c
@@ -8,7 +8,6 @@
  * Copyright (c) 2011-2018 Xilinx Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
index 963ab22fb452..41eff1a46450 100644
--- a/drivers/watchdog/xilinx_wwdt.c
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -9,7 +9,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <wdt.h>
-- 
2.34.1

