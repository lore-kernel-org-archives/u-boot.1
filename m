Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC977C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C9888B99;
	Wed,  1 May 2024 04:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rBJSq7Qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFF188BB8; Wed,  1 May 2024 04:44:48 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FF188A7F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b9365e584so3643236d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531484; x=1715136284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rj9Env6Q6q6x/Li6klqiIv4RTKzcX+Z2T3BR02o7rI=;
 b=rBJSq7QrsFi7npKBeNCi7Etfa1yYHPdqJlCv0O5Vdio7zaHdnUbvzwPhEBm+TiHFcq
 d/+5sETvtkUwIRM3a43npTglgF+rvqYBRGbNhnhl+ejFzjFR2AkZk89h1+2iDIS3X/Ag
 iB3wauubbtGhjum2DcnwxhWX3MYy3Hj2Arirs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531484; x=1715136284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rj9Env6Q6q6x/Li6klqiIv4RTKzcX+Z2T3BR02o7rI=;
 b=unaD9YelGi58LsN6szIeqkd8GGwc4JmPAsQV7ou8TMYmggPNedkS6N0iM0qkx/IZOM
 F8QirmYRn6lnmNe2U0ls7RSagcYraw1Mf0KeaX3oJcAgriub7H2T43PphPYSYqgQIniy
 jG6mRfjQfFk2T7NJFdcwVDOnuT2OaYBws+BI70XpdYc1pVx1nOb1iBWnfuzkyE9Ud+gX
 IG6+5bo7/nzZamp+UI6fb2YR1PuemEPc7WSW8gwouJ7Jd4xB5xmdZxuC3WIsFANWGEbO
 75/NXOIdHRZBuVRKO1o5qkhHgLzCdrSDUcgTAVRjeyprmrOHbVGbrxHjTMd/3SyUYOM+
 GeXQ==
X-Gm-Message-State: AOJu0YzWwXkE6EdT4S0+Yd2JDNsGc3lGdMsE764pRlaCiXH/4ajCfQJe
 NsJmhIEdxGu2tu+rVFfwCdhiGyUQAvRw9L2pqJeBR4j1SfHnFGRpEIYqmttba5IWHjHo77E0AWd
 iJVvxuQ==
X-Google-Smtp-Source: AGHT+IGgNIeq0a6J+tlABJPQLtB76B8wQ6Bbkh03nVA7RCx1jEde+B8o6X1S9Mbi0F5URe0Y1qH2wg==
X-Received: by 2002:a0c:c781:0:b0:6a0:d1f3:1992 with SMTP id
 k1-20020a0cc781000000b006a0d1f31992mr6645985qvj.9.1714531484669; 
 Tue, 30 Apr 2024 19:44:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Simon Glass <sjg@chromium.org>, Aiden Park <aiden.park@intel.com>
Subject: [PATCH 073/149] board: intel: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:00 -0600
Message-Id: <20240501024316.1767971-73-trini@konsulko.com>
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
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Aiden Park <aiden.park@intel.com>
---
 board/intel/cherryhill/cherryhill.c         | 1 -
 board/intel/cougarcanyon2/cougarcanyon2.c   | 1 -
 board/intel/crownbay/crownbay.c             | 1 -
 board/intel/edison/edison.c                 | 1 -
 board/intel/galileo/galileo.c               | 1 -
 board/intel/minnowmax/minnowmax.c           | 1 -
 board/intel/slimbootloader/slimbootloader.c | 1 -
 7 files changed, 7 deletions(-)

diff --git a/board/intel/cherryhill/cherryhill.c b/board/intel/cherryhill/cherryhill.c
index c037d5b14cd7..b4378afee152 100644
--- a/board/intel/cherryhill/cherryhill.c
+++ b/board/intel/cherryhill/cherryhill.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/arch/gpio.h>
 #include <asm/fsp1/fsp_support.h>
 
diff --git a/board/intel/cougarcanyon2/cougarcanyon2.c b/board/intel/cougarcanyon2/cougarcanyon2.c
index 7f61ef8b366b..e5cda068e17d 100644
--- a/board/intel/cougarcanyon2/cougarcanyon2.c
+++ b/board/intel/cougarcanyon2/cougarcanyon2.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/intel/crownbay/crownbay.c b/board/intel/crownbay/crownbay.c
index 55095deeadd7..036beb1146dc 100644
--- a/board/intel/crownbay/crownbay.c
+++ b/board/intel/crownbay/crownbay.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/ibmpc.h>
 #include <asm/pnp_def.h>
diff --git a/board/intel/edison/edison.c b/board/intel/edison/edison.c
index 11e7f74e47cc..911ffda2fc78 100644
--- a/board/intel/edison/edison.c
+++ b/board/intel/edison/edison.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2017 Intel Corporation
  */
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <mmc.h>
diff --git a/board/intel/galileo/galileo.c b/board/intel/galileo/galileo.c
index 341b627a65f5..19e5d0952fb8 100644
--- a/board/intel/galileo/galileo.c
+++ b/board/intel/galileo/galileo.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/device.h>
 #include <asm/arch/quark.h>
diff --git a/board/intel/minnowmax/minnowmax.c b/board/intel/minnowmax/minnowmax.c
index b02e3f0d4e5c..cdc2e0b75d81 100644
--- a/board/intel/minnowmax/minnowmax.c
+++ b/board/intel/minnowmax/minnowmax.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015, Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/intel/slimbootloader/slimbootloader.c b/board/intel/slimbootloader/slimbootloader.c
index b20ddf0c682e..f92c0b5112f0 100644
--- a/board/intel/slimbootloader/slimbootloader.c
+++ b/board/intel/slimbootloader/slimbootloader.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <init.h>
 
 int board_early_init_r(void)
-- 
2.34.1

