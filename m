Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9064C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0302F8777F;
	Sun, 21 Jan 2024 18:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lGham37D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y+bI/QYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A9E8775F; Sun, 21 Jan 2024 18:32:36 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B2B877B1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TJ0mK2QW5z9sGX;
 Sun, 21 Jan 2024 18:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tEcqvmfI19lYDgEFuFrA/98n9DUyEMRMmwzg597KUrs=;
 b=lGham37DgmfNHRCJEtiX1DYTy+hycfW/v2xGwILvO7ng7U8VEnT0GFUiWIGk7LWVNaLgyW
 p28wXLUZSY1EXd4rdLoGgo1bSYaPNE1x4yVUgVYgt48/cY/31CWAdKgUusP6eVHUB5M+9Z
 DP05Dgpr2GKJtAcsZSUNUp8TYfMxBHqOOQNA2+orCdIGtrnhOlOt6tBT3AUPbhtOij9Ipe
 f4Wcfzymxnd/X+JQdHWaDQj06axcvPVsTwehj2chNW/y5eE0JsvMlq533KAOK4sA+HsUDh
 Ui0X1FAYDuMKrnASmMCjFdeJ1pB/XzkP9hPfgYz5gdhuepxLtM4LgmTFaALRlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tEcqvmfI19lYDgEFuFrA/98n9DUyEMRMmwzg597KUrs=;
 b=Y+bI/QYjwjvp/rfnuCAC1542wfrMw0XAVAQNqlJc1zoXGP7enkyxZX6mD7MbF2CTiTDk9f
 WT/2KdZbI2EZpL0KxobqosiHdIQQjkcIvj9rhouc0Am2lmQC02KgpCuRt0VLm8gWhsu428
 ZsUnqdoT3cStAJwFiMgUfEUrbL2C7rwEjuEfWRiyzv/rvwpojLMc8t7J0K0PmyoKxayd9d
 cD1QhgfeJiI/PSPp9dXrK/gkCf8OvkkATq1/8BPRzUeaX1RY8pAe14fEwF4bT5lsrK2vvL
 a2MybI9HcFvPqRfzyKttsNrS2tVAhER/S6klLbJbLcrNJfw+JjoyXApTqRABrA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/3] clk: renesas: Drop include common.h
Date: Sun, 21 Jan 2024 18:31:21 +0100
Message-ID: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 47a88acd6d11c39ab69
X-MBO-RS-META: 48ogem665jsb7dae4uooedwi4dxewn8q
X-Rspamd-Queue-Id: 4TJ0mK2QW5z9sGX
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

The header file is not necessary in either of those files,
remove it as common.h is going away.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/clk/renesas/clk-rcar-gen2.c     | 1 -
 drivers/clk/renesas/clk-rcar-gen3.c     | 1 -
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a774e1-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a7790-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7791-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7792-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7794-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77970-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77980-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r9a06g032-clocks.c  | 1 -
 drivers/clk/renesas/rcar-cpg-lib.c      | 1 -
 drivers/clk/renesas/renesas-cpg-mssr.c  | 1 -
 23 files changed, 23 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 850d6411190..66ffef96b69 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2016 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index 0d274bb986e..196903e406c 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2016 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 6f94906cc99..d23041a8026 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2016 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 
diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index 1a794980319..81d7dfe5421 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2016 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 
diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index ec8ce6ad7d6..f92fd25c0f7 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a774e1-cpg-mssr.c b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
index 6a8fe92b975..7c7cb7b6a05 100644
--- a/drivers/clk/renesas/r8a774e1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2015 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a7790-cpg-mssr.c b/drivers/clk/renesas/r8a7790-cpg-mssr.c
index 686f2af0052..190b68ee7d3 100644
--- a/drivers/clk/renesas/r8a7790-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7790-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2013 Ideas On Board SPRL
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a7791-cpg-mssr.c b/drivers/clk/renesas/r8a7791-cpg-mssr.c
index dcb0fd85c52..30711bf8921 100644
--- a/drivers/clk/renesas/r8a7791-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7791-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2013 Ideas On Board SPRL
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a7792-cpg-mssr.c b/drivers/clk/renesas/r8a7792-cpg-mssr.c
index 496e51aa73f..623981e9c38 100644
--- a/drivers/clk/renesas/r8a7792-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7792-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2013 Ideas On Board SPRL
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a7794-cpg-mssr.c b/drivers/clk/renesas/r8a7794-cpg-mssr.c
index f1828a6e543..c4124917923 100644
--- a/drivers/clk/renesas/r8a7794-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7794-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2013 Ideas On Board SPRL
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 0e9b9ccf979..e511f74982b 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index d741d547ec8..02b078ad3df 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -12,7 +12,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index cf4503803d0..037861eb9b4 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -11,7 +11,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a77970-cpg-mssr.c b/drivers/clk/renesas/r8a77970-cpg-mssr.c
index 32923b423fe..d8bb5aab1fe 100644
--- a/drivers/clk/renesas/r8a77970-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77970-cpg-mssr.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2015 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a77980-cpg-mssr.c b/drivers/clk/renesas/r8a77980-cpg-mssr.c
index f35032b95f1..9d8335af783 100644
--- a/drivers/clk/renesas/r8a77980-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77980-cpg-mssr.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2015 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index 87b06666c8b..4c9acd76e18 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index dd2c9483292..f49faa47cb3 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <linux/bitops.h>
diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index 652bfe4f6d3..ba086be0268 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 
diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 643e8b8da97..108655f145d 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -7,7 +7,6 @@
  * Based on r8a779a0-cpg-mssr.c
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 
diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 219024a7416..781806eed58 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -7,7 +7,6 @@
  * Based on r8a779f0-cpg-mssr.c
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index d2f61236fee..d207bf615ce 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -7,7 +7,6 @@
  * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index a2fca660a8e..8862fbc7579 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -10,7 +10,6 @@
  * Copyright (C) 2016 Glider bvba
  */
 
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 10bd54d6002..35bad7f5f73 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -9,7 +9,6 @@
  *
  * Copyright (C) 2016 Glider bvba
  */
-#include <common.h>
 #include <clk-uclass.h>
 #include <dm.h>
 #include <errno.h>
-- 
2.43.0

