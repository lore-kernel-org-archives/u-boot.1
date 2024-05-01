Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D44C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C7D88BA3;
	Wed,  1 May 2024 04:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SmTSDwmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CDA88B95; Wed,  1 May 2024 04:44:39 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2329A88B68
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7f16ff3aa86so527022241.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531476; x=1715136276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s183MRilSELGmj0oxtfzjrgWYXtZ+K5n38YP9ZfvKSk=;
 b=SmTSDwmQN5bX7x6gdUGJjE3SSmWCg4VB79hsXa0q5I0MPiBrrMwHOp8aD3w1P7l4Rn
 QakIOsc1ZL9ciSOiRq91tv7hw8Cmg0WMaOcn+00r/T/HmWZbQ6lo4LlhmMXUwuj+zd+h
 wFQWBCFHyRIdm+ayGq8Lf1lfVKzNTskfbaDSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531476; x=1715136276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s183MRilSELGmj0oxtfzjrgWYXtZ+K5n38YP9ZfvKSk=;
 b=lAtXKEiWRYKxVR7iP3PeH7qDenw/gsaOOrDezr4vEzFTZYCuypZsfLiVnb+oXzCKHJ
 IPk86RSRYIToUog9zf1+igILXb7IUJwH9UyDKD3//aSaA4Jx6WW3Cc/CqqDRFA1Yol4Z
 07LPP/FHWO/1V9gyIsuI18DTi17xleW9t2cG+6BqpegzjJyAqGgtJ7pk1BK5ZRaw7DuF
 0WmZM8F1X0LSWvnSQp2jppt1qvd1Rs0GdYHU2y4slaIagarkKaA9yCBOJbxA1Mpno/Z7
 bHb2+1xwCVTSQhTcwPKGZRpultgoZ1mBZi4Jikj0z8VlpoQceJIjfHSgQ78QSWg45Alc
 dibQ==
X-Gm-Message-State: AOJu0YygQGlFIKx9UrWbWYT8/UQqLcEpaAwB6xTt9JrrBup9oPfoLSXc
 LyhgELxNHvsESONDuAPge5i96tXSgxUxT9/rz9DXC6YgfGdN+/XL43NRupB004zj1pzuTJBOCll
 J4q7ZvA==
X-Google-Smtp-Source: AGHT+IE/phjOotZoZbiNt4wn89oxXIsvjevWJuXwJUitv+waVtHzY/EdZYJus60rv1l8dSOj0YCKTA==
X-Received: by 2002:a05:6102:357:b0:47b:9df6:f91f with SMTP id
 e23-20020a056102035700b0047b9df6f91fmr1392043vsa.30.1714531475726; 
 Tue, 30 Apr 2024 19:44:35 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mario Six <mario.six@gdsys.cc>
Subject: [PATCH 065/149] board: gdsys: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:52 -0600
Message-Id: <20240501024316.1767971-65-trini@konsulko.com>
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
Cc: Mario Six <mario.six@gdsys.cc>
---
 board/gdsys/a38x/controlcenterdc.c | 2 +-
 board/gdsys/a38x/dt_helpers.c      | 1 -
 board/gdsys/a38x/hre.c             | 1 -
 board/gdsys/a38x/hydra.c           | 2 +-
 board/gdsys/a38x/ihs_phys.c        | 1 -
 board/gdsys/a38x/keyprogram.c      | 1 -
 board/gdsys/common/cmd_ioloop.c    | 1 -
 board/gdsys/common/dp501.c         | 1 -
 board/gdsys/common/ihs_mdio.c      | 1 -
 board/gdsys/common/ioep-fpga.c     | 1 -
 board/gdsys/common/osd.c           | 1 -
 board/gdsys/common/osd_cmd.c       | 1 -
 board/gdsys/mpc8308/gazerbeam.c    | 1 -
 board/gdsys/mpc8308/mpc8308.c      | 1 -
 board/gdsys/mpc8308/sdram.c        | 2 +-
 15 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/board/gdsys/a38x/controlcenterdc.c b/board/gdsys/a38x/controlcenterdc.c
index 0f620c2d9172..4abb3e451285 100644
--- a/board/gdsys/a38x/controlcenterdc.c
+++ b/board/gdsys/a38x/controlcenterdc.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2016 Mario Six <mario.six@gdsys.cc>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <dm.h>
 #include <event.h>
diff --git a/board/gdsys/a38x/dt_helpers.c b/board/gdsys/a38x/dt_helpers.c
index 61d30c2e6373..a12e115c72cb 100644
--- a/board/gdsys/a38x/dt_helpers.c
+++ b/board/gdsys/a38x/dt_helpers.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <fdt_support.h>
 #include <asm-generic/gpio.h>
diff --git a/board/gdsys/a38x/hre.c b/board/gdsys/a38x/hre.c
index d16233ed78ee..f303793b63b7 100644
--- a/board/gdsys/a38x/hre.c
+++ b/board/gdsys/a38x/hre.c
@@ -4,7 +4,6 @@
  * Reinhard Pfau, Guntermann & Drunck GmbH, reinhard.pfau@gdsys.cc
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <fs.h>
diff --git a/board/gdsys/a38x/hydra.c b/board/gdsys/a38x/hydra.c
index 495a97691881..970d508ff328 100644
--- a/board/gdsys/a38x/hydra.c
+++ b/board/gdsys/a38x/hydra.c
@@ -1,8 +1,8 @@
-#include <common.h>
 #include <command.h>
 #include <console.h> /* ctrlc */
 #include <pci.h>
 #include <asm/io.h>
+#include <mach/soc.h>
 
 #include "hydra.h"
 
diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 60a5c37aeffb..690a29690b9c 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <dm.h>
 #include <miiphy.h>
 #include <asm-generic/gpio.h>
diff --git a/board/gdsys/a38x/keyprogram.c b/board/gdsys/a38x/keyprogram.c
index 7020fae18941..15c36e22684f 100644
--- a/board/gdsys/a38x/keyprogram.c
+++ b/board/gdsys/a38x/keyprogram.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <tpm-v1.h>
diff --git a/board/gdsys/common/cmd_ioloop.c b/board/gdsys/common/cmd_ioloop.c
index 1412421a0218..fb6313f01975 100644
--- a/board/gdsys/common/cmd_ioloop.c
+++ b/board/gdsys/common/cmd_ioloop.c
@@ -4,7 +4,6 @@
  * Dirk Eibach, Guntermann & Drunck GmbH, dirk.eibach@gdsys.cc
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <linux/bitops.h>
diff --git a/board/gdsys/common/dp501.c b/board/gdsys/common/dp501.c
index 9ca69ebcbbe7..7698e76b5248 100644
--- a/board/gdsys/common/dp501.c
+++ b/board/gdsys/common/dp501.c
@@ -8,7 +8,6 @@
 
 #ifdef CONFIG_GDSYS_LEGACY_DRIVERS
 
-#include <common.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <i2c.h>
diff --git a/board/gdsys/common/ihs_mdio.c b/board/gdsys/common/ihs_mdio.c
index 5f1215e9e8a6..a814566beaf0 100644
--- a/board/gdsys/common/ihs_mdio.c
+++ b/board/gdsys/common/ihs_mdio.c
@@ -4,7 +4,6 @@
  * Dirk Eibach,  Guntermann & Drunck GmbH, dirk.eibach@gdsys.cc
  */
 
-#include <common.h>
 #include <linux/delay.h>
 
 #include <miiphy.h>
diff --git a/board/gdsys/common/ioep-fpga.c b/board/gdsys/common/ioep-fpga.c
index 7292d7ab5a41..f01b48b5c8e9 100644
--- a/board/gdsys/common/ioep-fpga.c
+++ b/board/gdsys/common/ioep-fpga.c
@@ -6,7 +6,6 @@
 
 #ifdef CONFIG_GDSYS_LEGACY_DRIVERS
 
-#include <common.h>
 
 #include <gdsys_fpga.h>
 #include <linux/bitops.h>
diff --git a/board/gdsys/common/osd.c b/board/gdsys/common/osd.c
index dc548efbc7a4..bd9c5ca99698 100644
--- a/board/gdsys/common/osd.c
+++ b/board/gdsys/common/osd.c
@@ -6,7 +6,6 @@
 
 #ifdef CONFIG_GDSYS_LEGACY_DRIVERS
 
-#include <common.h>
 #include <command.h>
 #include <i2c.h>
 #include <malloc.h>
diff --git a/board/gdsys/common/osd_cmd.c b/board/gdsys/common/osd_cmd.c
index 6a9c0b4c24f0..39e64f5f2eb3 100644
--- a/board/gdsys/common/osd_cmd.c
+++ b/board/gdsys/common/osd_cmd.c
@@ -9,7 +9,6 @@
  * Dirk Eibach,  Guntermann & Drunck GmbH, eibach@gdsys.de
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <hexdump.h>
diff --git a/board/gdsys/mpc8308/gazerbeam.c b/board/gdsys/mpc8308/gazerbeam.c
index cc608c4ac434..05e4d84460ae 100644
--- a/board/gdsys/mpc8308/gazerbeam.c
+++ b/board/gdsys/mpc8308/gazerbeam.c
@@ -5,7 +5,6 @@
  * SPDX-License-Identifier:	GPL-2.0+
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/board/gdsys/mpc8308/mpc8308.c b/board/gdsys/mpc8308/mpc8308.c
index 0f90f8ad327b..42c45ecedcea 100644
--- a/board/gdsys/mpc8308/mpc8308.c
+++ b/board/gdsys/mpc8308/mpc8308.c
@@ -4,7 +4,6 @@
  * Dirk Eibach,  Guntermann & Drunck GmbH, dirk.eibach@gdsys.cc
  */
 
-#include <common.h>
 #include <command.h>
 #include <init.h>
 #include <asm/processor.h>
diff --git a/board/gdsys/mpc8308/sdram.c b/board/gdsys/mpc8308/sdram.c
index 4fac146353da..2933de0f3048 100644
--- a/board/gdsys/mpc8308/sdram.c
+++ b/board/gdsys/mpc8308/sdram.c
@@ -13,7 +13,7 @@
 
 #ifndef CONFIG_MPC83XX_SDRAM
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <mpc83xx.h>
 #include <spd_sdram.h>
-- 
2.34.1

