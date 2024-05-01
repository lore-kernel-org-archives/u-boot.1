Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A1C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B6588AB7;
	Wed,  1 May 2024 04:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tGlyVoJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5178088A7E; Wed,  1 May 2024 04:43:39 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5CD88AB3
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a05f376effso49627106d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531416; x=1715136216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bMYD4iA2G2CrX2Igmn3BHbfb3VGJSMlCAp10QnJ14U=;
 b=tGlyVoJob/UX4Ot6vqMHwCZaiC4A/FWOO+eXpcfLXMLDELEuUMcSzu/7jA21jOyYgO
 eDk3fiL9W6XrcTege61BLHDgavme8jBV9Z4Hi5vr7qNMMDKXVtnMkuY8YU8PX2iO5nbo
 w1xNjl1pFQ3wf+kGTirhdHLlG0xda36g2maoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531416; x=1715136216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bMYD4iA2G2CrX2Igmn3BHbfb3VGJSMlCAp10QnJ14U=;
 b=wCzXp9aOsF8NfZMB0MXe3h6hsgnckhyRUVxRADZ6ih5yFBpOhA9xrZTNyuK8Dx1AfN
 R8exZl9ljfk0ZsJ5X/o/rubJCVw2wZQ1gUnm8YSpG9Pd3teMKRWKQDsbLr8viS+SBLH0
 tsMcFQ1TM1yBgQozZGwjUfnp2WnCqeYZ76LyX/REWs/wMgSeRCUdHiDkKRyABCtI/wNl
 AunDSVC/m0udFvciXwE43dp9lcZKmlYgGokoQFI3Dza8y/9R7y9Agdd2RvCdviYQOqxu
 yIOScbwWZwN3vYEOkLfDG70snQNRCnMYdN1nvEQw0RWtxsfkMWQk5WmdmZegC8H4BNqA
 KPwg==
X-Gm-Message-State: AOJu0YzY2cPoSEI+x78EesmuunxyBczYH/p9o4iJKxgypf39j2uFCuM2
 hvV6KBMpcY8HoiIJhzPrhx77s0EkDrNAfLourCA8LbV3y+8rzYhEzmKwOapXinJ1ndxnSe7wskX
 8KzYY2w==
X-Google-Smtp-Source: AGHT+IECSpPLI7MN7MRVfCANW3XnJu2n58/Q/Upv+blSsYfXH2Brp/j5vRbdS+6/6azE4C55ifGOqA==
X-Received: by 2002:ad4:5dcf:0:b0:6a0:b705:2800 with SMTP id
 m15-20020ad45dcf000000b006a0b7052800mr1203809qvh.23.1714531415691; 
 Tue, 30 Apr 2024 19:43:35 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Viacheslav Bocharov <adeep@lexina.in>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH 016/149] board: amlogic: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:03 -0600
Message-Id: <20240501024316.1767971-16-trini@konsulko.com>
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
Cc: Christian Hewitt <christianshewitt@gmail.com>
Cc: Viacheslav Bocharov <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>
---
 board/amlogic/beelink-s922x/beelink-s922x.c     | 1 -
 board/amlogic/jethub-j100/jethub-j100.c         | 1 -
 board/amlogic/jethub-j80/jethub-j80.c           | 1 -
 board/amlogic/odroid-go-ultra/odroid-go-ultra.c | 2 +-
 board/amlogic/odroid-n2/odroid-n2.c             | 1 -
 board/amlogic/p200/p200.c                       | 1 -
 board/amlogic/p201/p201.c                       | 1 -
 board/amlogic/p212/p212.c                       | 1 -
 board/amlogic/q200/q200.c                       | 1 -
 board/amlogic/s400/s400.c                       | 1 -
 board/amlogic/sei510/sei510.c                   | 1 -
 board/amlogic/sei610/sei610.c                   | 1 -
 board/amlogic/u200/u200.c                       | 1 -
 board/amlogic/vim3/vim3.c                       | 1 -
 board/amlogic/w400/w400.c                       | 1 -
 15 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/board/amlogic/beelink-s922x/beelink-s922x.c b/board/amlogic/beelink-s922x/beelink-s922x.c
index c2776310a3dc..ccb2f7d1bb19 100644
--- a/board/amlogic/beelink-s922x/beelink-s922x.c
+++ b/board/amlogic/beelink-s922x/beelink-s922x.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
index 010fc0df7d18..b770a1f8c537 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -4,7 +4,6 @@
  * Author: Vyacheslav Bocharov <adeep@lexina.in>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
index 0b781666e985..07a08dcd1700 100644
--- a/board/amlogic/jethub-j80/jethub-j80.c
+++ b/board/amlogic/jethub-j80/jethub-j80.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <adc.h>
 #include <env.h>
diff --git a/board/amlogic/odroid-go-ultra/odroid-go-ultra.c b/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
index bbd23e20fcdd..8f3f2045d74d 100644
--- a/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
+++ b/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2023 Neil Armstrong <neil.armstrong@linaro.org>
  */
 
-#include <common.h>
+#include <log.h>
 #include <asm/arch/boot.h>
 #include <power/regulator.h>
 
diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index a4bcc62174a0..ae953d0e4bab 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <adc.h>
 #include <env.h>
diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 754242e4a9fa..3bede46b324c 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/amlogic/p201/p201.c b/board/amlogic/p201/p201.c
index 769e2735d27e..d44ebae07dde 100644
--- a/board/amlogic/p201/p201.c
+++ b/board/amlogic/p201/p201.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/amlogic/p212/p212.c b/board/amlogic/p212/p212.c
index f6e60ae3af17..ae9834c0bf8d 100644
--- a/board/amlogic/p212/p212.c
+++ b/board/amlogic/p212/p212.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
index 47f1566a9d3d..0c0afccb38c2 100644
--- a/board/amlogic/q200/q200.c
+++ b/board/amlogic/q200/q200.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/amlogic/s400/s400.c b/board/amlogic/s400/s400.c
index 06a9044fd808..96244c9ccb11 100644
--- a/board/amlogic/s400/s400.c
+++ b/board/amlogic/s400/s400.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/amlogic/sei510/sei510.c b/board/amlogic/sei510/sei510.c
index bb188c21f75f..1a978d1290a5 100644
--- a/board/amlogic/sei510/sei510.c
+++ b/board/amlogic/sei510/sei510.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/board/amlogic/sei610/sei610.c b/board/amlogic/sei610/sei610.c
index 6490bac9eb55..8a096b15bfb2 100644
--- a/board/amlogic/sei610/sei610.c
+++ b/board/amlogic/sei610/sei610.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/board/amlogic/u200/u200.c b/board/amlogic/u200/u200.c
index 06a9044fd808..96244c9ccb11 100644
--- a/board/amlogic/u200/u200.c
+++ b/board/amlogic/u200/u200.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index a4850364f418..bbc2d826e050 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env_internal.h>
 #include <init.h>
diff --git a/board/amlogic/w400/w400.c b/board/amlogic/w400/w400.c
index 4199198496b1..b84366aaeb15 100644
--- a/board/amlogic/w400/w400.c
+++ b/board/amlogic/w400/w400.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env_internal.h>
 #include <init.h>
-- 
2.34.1

