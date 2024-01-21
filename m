Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3524EC47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760138783B;
	Sun, 21 Jan 2024 18:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qXkbQnKt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eErNSqpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AA68775F; Sun, 21 Jan 2024 18:32:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2B7877F8
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TJ0mK70Wyz9sZg;
 Sun, 21 Jan 2024 18:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TJxpjqh9SJsts3SzwQnUTQf0uWAraxYFj3y6XgdQUg=;
 b=qXkbQnKtddNnXV/rcoBH4ngIN029Rfm6FyadzNFXjdQL20pG42EVSgVsbLDpcuwMraf96J
 ialoxMtcB0Gg4IhQsx7xFN81JuL1JFiAmPZQ5vK6D7ODQg0EpbLuxzi5/PrwHL/VGmKq9k
 OL1zjPN+sj+ttRBePwQjenpYsSYoZOCmgXt0b6hAbYdevUyqRAUGrlY8UjPTRqjoC15x+p
 D88fEi1UP759KqalMgHAdxGYDmbs3TTSVtURv9gLAy0UQGCjlEXy8OdQxby8n0bzHgm6p4
 UHtpwD+kqozh3aKQ2le7kZqbAQQteEjuX1MM7k3v8t1eQUR8un4wJdulALPsmw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TJxpjqh9SJsts3SzwQnUTQf0uWAraxYFj3y6XgdQUg=;
 b=eErNSqpqQRWYYOSsdx8sx/0r0n1a2NRLqUSJpc5HREpZOtiVWTzMEaSPxfe8SHyMhPPB0I
 xLambX2sSg1edKNExV5RY5NkatTdASXyhKbTVldqT5zGXhXFiXurJLuBeScOrLFYXQwgRD
 ZJOk/gbsWQIUixLvhEjH+N2dvCceDmnJVWM8dcsJOKi7SzfYBS6VRE3ap+SRn+lsPuWqEJ
 s31ppCfMuBOeGG6C37IZFeN88VBfyVovqWwq2jVBkoJYB60gNoGR7aCGu8Dz2zKBhOV5R9
 Wa4C5B1PJjm+abbkg9octilHrF3o2C6RqMLZmP/OEoYLhepD2qpnGI5GuFG0UA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 2/3] pinctrl: renesas: Drop include common.h
Date: Sun, 21 Jan 2024 18:31:22 +0100
Message-ID: <20240121173211.273726-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4891f25c7fed5ffdb45
X-MBO-RS-META: cfh9a4en13se91qydfzpcabre7sj6k3y
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
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/pinctrl/renesas/pfc-r8a7790.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a7791.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a7792.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a7794.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a77951.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a7796.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a77965.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a77970.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a77980.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a77990.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a77995.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a779a0.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a779f0.c | 1 -
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 1 -
 drivers/pinctrl/renesas/pfc.c          | 1 -
 drivers/pinctrl/renesas/pinctrl-rza1.c | 1 -
 16 files changed, 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7790.c b/drivers/pinctrl/renesas/pfc-r8a7790.c
index 7203648bbc8..e1811c4c908 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7790.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7790.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2012  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a7791.c b/drivers/pinctrl/renesas/pfc-r8a7791.c
index b25453ed285..fa94a51e5e7 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7791.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7791.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2014-2017 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a7792.c b/drivers/pinctrl/renesas/pfc-r8a7792.c
index 08f1f97af6e..7c1e6d40749 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7792.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7792.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2016 Cogent Embedded, Inc., <source@cogentembedded.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a7794.c b/drivers/pinctrl/renesas/pfc-r8a7794.c
index e5d125ceca0..29eab2610c1 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7794.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7794.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2015-2017 Cogent Embedded, Inc. <source@cogentembedded.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index 5d1c81c3eae..81568ae4a5e 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015-2019 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/renesas/pfc-r8a7796.c
index 163d1805dfb..3de43febbd3 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7796.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
@@ -11,7 +11,6 @@
  * Copyright (C) 2015  Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/renesas/pfc-r8a77965.c
index 377143d3918..3a6813cee61 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77965.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
@@ -12,7 +12,6 @@
  * Copyright (C) 2015  Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a77970.c b/drivers/pinctrl/renesas/pfc-r8a77970.c
index 1cc6fa4f3fc..3c9c060d245 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77970.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77970.c
@@ -12,7 +12,6 @@
  * Copyright (C) 2015  Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a77980.c b/drivers/pinctrl/renesas/pfc-r8a77980.c
index 523faa0ac8f..14a4b4dc731 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77980.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77980.c
@@ -12,7 +12,6 @@
  * Copyright (C) 2015 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a77990.c b/drivers/pinctrl/renesas/pfc-r8a77990.c
index 215a19ef9cd..e3a9c5e053d 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77990.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77990.c
@@ -11,7 +11,6 @@
  * Copyright (C) 2016-2017 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/renesas/pfc-r8a77995.c
index c0d69937ddb..eccf5c15907 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77995.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
@@ -11,7 +11,6 @@
  * Copyright (C) 2015  Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/renesas/pfc-r8a779a0.c
index 3c4b03b1b4c..6f898385027 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
@@ -7,7 +7,6 @@
  * This file is based on the drivers/pinctrl/renesas/pfc-r8a7795.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/renesas/pfc-r8a779f0.c
index 5123e26e0ac..de5ec6c812a 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
@@ -7,7 +7,6 @@
  * This file is based on the drivers/pinctrl/renesas/pfc-r8a779a0.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 20498a1c2f7..6749c15f4ea 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -7,7 +7,6 @@
  * This file is based on the drivers/pinctrl/renesas/pfc-r8a779a0.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/pinctrl.h>
diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index 3ac25cbd080..4ceb5db47ff 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -11,7 +11,6 @@
 
 #define DRV_NAME "sh-pfc"
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <dm/device_compat.h>
diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index a445cdba713..2d993be2b2a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/lists.h>
-- 
2.43.0

