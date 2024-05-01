Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E0CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D779888B8B;
	Wed,  1 May 2024 04:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FCPK7SnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763CA88BC6; Wed,  1 May 2024 04:44:54 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE49E88BCB
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6a0b4622ea0so21040476d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531490; x=1715136290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RE0TOpspQs2sjqA3XQxOoIK8DWfJMFYFwJllwUuE2i8=;
 b=FCPK7SnMJfNP6k6rrxluKhkNQHlFvsVUQFFHekN5EZ7HGX4H2O07QiaMzYyKkkM2hG
 vhLtlFXQ+oGXK/SoOU7PWGP+o/6lfGdT/UKd+LyEO13d5GEw/6tvqhUQfqsQrTrUEF/g
 jp1c4ObiOz53kA6uJXzZL2d40P0JfIW1zsbo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531490; x=1715136290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE0TOpspQs2sjqA3XQxOoIK8DWfJMFYFwJllwUuE2i8=;
 b=TvzDiFxnjmxJHdvtxWgz8GnWThcc6iB9lr848MwqoeumFBfch3JuWpplbZlY+Nnk1v
 +uu99PWKEmM3RaQxI1nKMGStfesHDzzfiZKLq+pDeHq4Ur6v4N0aLFXLBF4gPvdidWOq
 RYUkSQaGxwX5r8vBJTxmPChf7oPdaRmexp7P3zjPxShX6uSlpLPR+BBd5DYV/jA8uEH9
 PHFDGHUSSQiyglLt90XiGZmuaR2rbBH+uWl9f4H/ctGICGL9TxfWt17QP1mbh5mp3v2s
 UHI0N89dhJOPw2yJ3sRZsUV1YitQZN1iCImOBjgKsqBvFugvZHch+BiPO1DJ2sQjneaX
 CsBw==
X-Gm-Message-State: AOJu0YxW/tVdyK9Zlp/2dH6aKuEyaxOzUkyhLXIUj072XjHvne6wvqYl
 SyaCcpnjbTyeVV06/CaCrzP1p40w9drUNG4ViSbOGiK4Dhe5Mu+zLk1G8vABmAohKizU5YmyAlX
 xvGJzuA==
X-Google-Smtp-Source: AGHT+IF8gTwe1DETcgV5pydJJq6rby0FjNmzGPkea5WGrryJMbP/Ijlqqa3Ncx+CEmm8hId+bu3vaA==
X-Received: by 2002:a05:6214:ca4:b0:6a0:cd68:901e with SMTP id
 s4-20020a0562140ca400b006a0cd68901emr1565512qvs.45.1714531490601; 
 Tue, 30 Apr 2024 19:44:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Holger Brunck <holger.brunck@hitachienergy.com>,
 Heiko Schocher <hs@denx.de>, Niel Fourie <lusus@denx.de>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Rainer Boschung <rainer.boschung@hitachienergy.com>
Subject: [PATCH 078/149] board: keymile: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:05 -0600
Message-Id: <20240501024316.1767971-78-trini@konsulko.com>
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
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Heiko Schocher <hs@denx.de>
Cc: Niel Fourie <lusus@denx.de>
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
Cc: Rainer Boschung <rainer.boschung@hitachienergy.com>
---
 board/keymile/common/common.c       | 2 +-
 board/keymile/common/ivm.c          | 3 ++-
 board/keymile/common/qrio.c         | 2 +-
 board/keymile/km83xx/km83xx.c       | 2 +-
 board/keymile/pg-wcom-ls102xa/ddr.c | 2 +-
 board/keymile/secu1/socfpga.c       | 1 -
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/board/keymile/common/common.c b/board/keymile/common/common.c
index 991022ac833a..9358c25dcb05 100644
--- a/board/keymile/common/common.c
+++ b/board/keymile/common/common.c
@@ -7,7 +7,7 @@
  * Holger Brunck, Keymile GmbH Hannover, holger.brunck@keymile.com
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <ioports.h>
 #include <command.h>
diff --git a/board/keymile/common/ivm.c b/board/keymile/common/ivm.c
index 67db0c50f47c..f01fe44303c9 100644
--- a/board/keymile/common/ivm.c
+++ b/board/keymile/common/ivm.c
@@ -4,10 +4,11 @@
  * Holger Brunck, Keymile GmbH Hannover, holger.brunck@keymile.com
  */
 
-#include <common.h>
 #include <cli_hush.h>
 #include <env.h>
 #include <i2c.h>
+#include <stdio.h>
+#include <vsprintf.h>
 #include "common.h"
 
 #define MAC_STR_SZ	20
diff --git a/board/keymile/common/qrio.c b/board/keymile/common/qrio.c
index b433f69675ab..c8299483299d 100644
--- a/board/keymile/common/qrio.c
+++ b/board/keymile/common/qrio.c
@@ -4,7 +4,7 @@
  * Valentin Longchamp <valentin.longchamp@keymile.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 
diff --git a/board/keymile/km83xx/km83xx.c b/board/keymile/km83xx/km83xx.c
index acd13105dd55..40718aa58a7b 100644
--- a/board/keymile/km83xx/km83xx.c
+++ b/board/keymile/km83xx/km83xx.c
@@ -13,7 +13,7 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <event.h>
 #include <fdt_support.h>
diff --git a/board/keymile/pg-wcom-ls102xa/ddr.c b/board/keymile/pg-wcom-ls102xa/ddr.c
index 556d39d4d4e3..51938a1b4d88 100644
--- a/board/keymile/pg-wcom-ls102xa/ddr.c
+++ b/board/keymile/pg-wcom-ls102xa/ddr.c
@@ -4,7 +4,7 @@
  * Copyright 2020 Hitachi Power Grids. All rights reserved.
  */
 
-#include <common.h>
+#include <config.h>
 #include <fsl_ddr_sdram.h>
 #include <fsl_ddr_dimm_params.h>
 #include <asm/io.h>
diff --git a/board/keymile/secu1/socfpga.c b/board/keymile/secu1/socfpga.c
index 6a4cb21786ac..1a626c520680 100644
--- a/board/keymile/secu1/socfpga.c
+++ b/board/keymile/secu1/socfpga.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2017-2020 Hitachi Power Grids
  */
-#include <common.h>
 #include <i2c.h>
 #include <asm/gpio.h>
 
-- 
2.34.1

