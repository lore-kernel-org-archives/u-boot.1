Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5868C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C0488C06;
	Thu,  2 May 2024 03:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t1rIeFcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A3D88C01; Thu,  2 May 2024 03:31:58 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE9E88BF7
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43969307359so46359161cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613514; x=1715218314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xfWIb5g9G96nSi3jm7VDeQikpMElDpYy1inRxdrZEQ=;
 b=t1rIeFcS97fHCOAVZl3wqJNw7dBD+NwRh8tKpvh+nj21q+v0C2Y8QCf/hlJTaAoQ9B
 QFvz6AiKCCWpfDngnDi0x5QwpCHbp0kNBho7GQOs0a4K9FfD7ORc84WlggUdLFOorrej
 Dd1iQAKMFudru8Ho/OnyMiRBxhvmO9PyMSDuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613514; x=1715218314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xfWIb5g9G96nSi3jm7VDeQikpMElDpYy1inRxdrZEQ=;
 b=g8QST36jUIzSGLN9W1IxAdKHRWuZtknXp+KQKL8dfVjLppkGHWuKZigEFKYWcmBQsw
 /OMkG1wopq0wXKR5gGc9W/RpKHHGqx6u/aZ0U37HdR+0DQfCyp6XgorOkoAfkaYz3/6s
 3dSXMFkxw6mVvCz9rcjuUzafPM7kxDTkLD6Ww4Bnm1wteIRHpSZUtD6S4YiAhQxeSImK
 9a3lvEu+gxdE3oS8MCezcNrOfGNC9YtOHNl7/cH5VIi97vCCDckVzQv/rBrRZDic2WYo
 xWUCrcvgoFJet10xTW50ws11sz/zG1p8AzQ8i/karmA0Q1HXApsDowGfwssuu1o/c0WM
 8hGQ==
X-Gm-Message-State: AOJu0YyEjLueWe8qUn6gTI6L85GD0bL6AIkb6QLsmAJVC2WHcGYIKwrk
 UEZCO04QH0H4FiT+0TNIaRErACls9kbaBtPVKj5njG3bRa4T0e/a0R4hB7U5CQQ/lcfFwh/OH1K
 EDQTIsHC5
X-Google-Smtp-Source: AGHT+IGfkeaipQFRGBFEEjGcoZE2sBx4NWsykQDzL/Za72XUZsRFuEE/D4ZhP4Sc2nry8JMI7LqvxA==
X-Received: by 2002:a05:622a:1827:b0:43b:1561:6c45 with SMTP id
 t39-20020a05622a182700b0043b15616c45mr4881715qtc.11.1714613514560; 
 Wed, 01 May 2024 18:31:54 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Samuel Holland <samuel@sholland.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Johan Jonker <jbx6244@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Tony Dinh <mibodhi@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: [PATCH 11/81] ata: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:28 -0600
Message-Id: <20240502013138.2383421-11-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Sam Edwards <CFSworks@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Bin Meng <bmeng@tinylab.org>
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
---
 drivers/ata/ahci-pci.c     | 1 -
 drivers/ata/ahci-uclass.c  | 1 -
 drivers/ata/ahci.c         | 2 +-
 drivers/ata/ahci_mvebu.c   | 1 -
 drivers/ata/ahci_sunxi.c   | 1 -
 drivers/ata/dwc_ahci.c     | 1 -
 drivers/ata/dwc_ahsata.c   | 1 -
 drivers/ata/fsl_sata.c     | 1 -
 drivers/ata/libata.c       | 2 +-
 drivers/ata/mtk_ahci.c     | 1 -
 drivers/ata/sata.c         | 1 -
 drivers/ata/sata_bootdev.c | 1 -
 drivers/ata/sata_ceva.c    | 1 -
 drivers/ata/sata_mv.c      | 2 +-
 drivers/ata/sata_sil.c     | 1 -
 15 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci-pci.c b/drivers/ata/ahci-pci.c
index 5356b9d83d34..f2102aaa6353 100644
--- a/drivers/ata/ahci-pci.c
+++ b/drivers/ata/ahci-pci.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <scsi.h>
 #include <dm.h>
diff --git a/drivers/ata/ahci-uclass.c b/drivers/ata/ahci-uclass.c
index d398b50b9a1e..7affb3f1ec79 100644
--- a/drivers/ata/ahci-uclass.c
+++ b/drivers/ata/ahci-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_AHCI
 
-#include <common.h>
 #include <ahci.h>
 #include <dm.h>
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 04ddc3394648..ac869296d525 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -8,10 +8,10 @@
  *
  * This driver provides a SCSI interface to SATA.
  */
-#include <common.h>
 #include <blk.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index f05150d61ddf..f6e2d6bee45b 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 9064774e6614..6cf5cee055e7 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <ahci.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index 15fd3e365b2b..b480cde4465b 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -8,7 +8,6 @@
  * Author: Mugunthan V N <mugunthanvnm@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <ahci.h>
 #include <scsi.h>
diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
index b4d4e39c9b3b..a29d641343ed 100644
--- a/drivers/ata/dwc_ahsata.c
+++ b/drivers/ata/dwc_ahsata.c
@@ -4,7 +4,6 @@
  * Terry Lv <r65388@freescale.com>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <blk.h>
 #include <cpu_func.h>
diff --git a/drivers/ata/fsl_sata.c b/drivers/ata/fsl_sata.c
index 969bc191f8e8..4990148388b6 100644
--- a/drivers/ata/fsl_sata.c
+++ b/drivers/ata/fsl_sata.c
@@ -5,7 +5,6 @@
  * Author: Dave Liu <daveliu@freescale.com>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <blk.h>
 #include <command.h>
diff --git a/drivers/ata/libata.c b/drivers/ata/libata.c
index 47e2c5c1cc40..ef659cb1728a 100644
--- a/drivers/ata/libata.c
+++ b/drivers/ata/libata.c
@@ -5,9 +5,9 @@
  *		port from the libata of linux kernel
  */
 
-#include <common.h>
 #include <compiler.h>
 #include <libata.h>
+#include <stdio.h>
 
 u64 ata_id_n_sectors(u16 *id)
 {
diff --git a/drivers/ata/mtk_ahci.c b/drivers/ata/mtk_ahci.c
index 2c5227df306b..53aabee0a5e6 100644
--- a/drivers/ata/mtk_ahci.c
+++ b/drivers/ata/mtk_ahci.c
@@ -8,7 +8,6 @@
  * Author: Frank Wunderlich <frank-w@public-files.de>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index 784d9bbeacb4..84437d3d346b 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -9,7 +9,6 @@
  *		Dave Liu <daveliu@freescale.com>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <blk.h>
 #include <dm.h>
diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
index f638493ce04f..a5ca6f6fd5bb 100644
--- a/drivers/ata/sata_bootdev.c
+++ b/drivers/ata/sata_bootdev.c
@@ -5,7 +5,6 @@
  * Copyright 2023 Tony Dinh <mibodhi@gmail.com>
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <bootdev.h>
 #include <dm.h>
diff --git a/drivers/ata/sata_ceva.c b/drivers/ata/sata_ceva.c
index 7769d4f99efd..a81b3165992a 100644
--- a/drivers/ata/sata_ceva.c
+++ b/drivers/ata/sata_ceva.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2015 - 2016 Xilinx, Inc.
  * Michal Simek <michal.simek@amd.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <ahci.h>
 #include <generic-phy.h>
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 94d7369351a3..ac78760a33eb 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -31,7 +31,6 @@
  * No port multiplier support
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <blk.h>
 #include <bootdev.h>
@@ -46,6 +45,7 @@
 #include <libata.h>
 #include <malloc.h>
 #include <sata.h>
+#include <time.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 43a91a79120a..5b80f6249d76 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -5,7 +5,6 @@
  * Author: Tang Yuantian <b29983@freescale.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <cpu_func.h>
 #include <dm.h>
-- 
2.34.1

