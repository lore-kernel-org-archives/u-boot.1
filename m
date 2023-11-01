Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769C5C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E32C87D29;
	Wed,  1 Nov 2023 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PDFEZCeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F1E87D34; Wed,  1 Nov 2023 17:28:40 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0ED87707
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d060aa2a4so52546d6.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856109; x=1699460909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Aqm1SK032DIqMQ4R7vm1xe43GJdUvWMtWooYdH7Zxsw=;
 b=PDFEZCeTn/G15/EkQpK49sIfQrFJKqFQU3l+u8A9yjhnQEWxskoTwV56MtuHny3c0x
 eX+uCXpGVw/pxQwBNB5exPZcFLGQk6WyIM5hOokGYEh9Aeabni7K47GCNpcp39wLIyGs
 7YvTbxy+0/QwJgkCTz8x6Bmu/hqAzLdXEo7B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856109; x=1699460909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aqm1SK032DIqMQ4R7vm1xe43GJdUvWMtWooYdH7Zxsw=;
 b=VxUBnugC01BZXRlQ/PsihXBQ+Va51ZJnGjgPkIVlD3yHY7YR2ru+DHug86cdWO6X/6
 L7F3jU0KWJreba4sLclp4zGpqp/5Nbe7xo5pck1WQwYRqBH2K775VOkHZR9YVxTW1e/f
 0dsxmkwV9803+ukWVCGUWgarGZkKIU90HhUwxgu3/yCrWZ/HbMoGeizszGxXS4Z24GT0
 mvcqpktEXNbB2xeld7+9f5frinRlUHnAz9/D7uMxRirv8yplZIsvJ7QnAHPscJGfeQx2
 Xmu1/AqBtYn+U174Qg2iWzjQtJd7qT7Mh7SjGYAgLZJmXPK3bkSMbQiePEYeiDM8DXZC
 OmfA==
X-Gm-Message-State: AOJu0Yz+vifLwNRGn+06YQUPzQzLIJa0iJNSIQI+ebbepOO91dZpj/jV
 ljqphOr0b86CUFvOL+2e5MtmUCGFvBH7AgZBBLil8g==
X-Google-Smtp-Source: AGHT+IFD7cdRlrFNve3GnikwdGQw4fYhTkCLD1QPugMgKAsUzDEC8YRAPQuVi+wuyusGxNPcFAqHCg==
X-Received: by 2002:ad4:5ecd:0:b0:66d:28b3:798 with SMTP id
 jm13-20020ad45ecd000000b0066d28b30798mr19793162qvb.10.1698856109107; 
 Wed, 01 Nov 2023 09:28:29 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 04/20] fsl_qe: Drop common.h
Date: Wed,  1 Nov 2023 12:28:08 -0400
Message-Id: <20231101162824.3755579-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

In both include/fsl_qe.h and then also remove common.h from the files
which had included fsl_qe.h

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/cpu/mpc83xx/cpu_init.c             | 1 -
 arch/powerpc/cpu/mpc85xx/cpu_init.c             | 1 -
 board/freescale/common/arm_sleep.c              | 1 -
 board/freescale/common/mpc85xx_sleep.c          | 1 -
 board/freescale/ls1021aqds/ls1021aqds.c         | 1 -
 board/freescale/ls1021atsn/ls1021atsn.c         | 1 -
 board/freescale/ls1021atwr/ls1021atwr.c         | 1 -
 board/freescale/ls1043ardb/ls1043ardb.c         | 1 -
 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 1 -
 drivers/net/fm/fm.c                             | 1 -
 drivers/net/qe/uccf.c                           | 1 -
 drivers/qe/fdt.c                                | 1 -
 drivers/qe/qe.c                                 | 1 -
 include/fsl_qe.h                                | 1 -
 14 files changed, 14 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/cpu_init.c b/arch/powerpc/cpu/mpc83xx/cpu_init.c
index f5cb000de6bf..8e6d3d28fc63 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu_init.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2004-2009 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm-offsets.h>
 #include <mpc83xx.h>
 #include <system-constants.h>
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 96183ac2c84b..b770d294e616 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -9,7 +9,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/freescale/common/arm_sleep.c b/board/freescale/common/arm_sleep.c
index 46ffd817b44b..228f07502f7a 100644
--- a/board/freescale/common/arm_sleep.c
+++ b/board/freescale/common/arm_sleep.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/freescale/common/mpc85xx_sleep.c b/board/freescale/common/mpc85xx_sleep.c
index d3323b9ec1e5..770fa0d62be5 100644
--- a/board/freescale/common/mpc85xx_sleep.c
+++ b/board/freescale/common/mpc85xx_sleep.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/immap_85xx.h>
diff --git a/board/freescale/ls1021aqds/ls1021aqds.c b/board/freescale/ls1021aqds/ls1021aqds.c
index a618ce11a584..930ef6be3850 100644
--- a/board/freescale/ls1021aqds/ls1021aqds.c
+++ b/board/freescale/ls1021aqds/ls1021aqds.c
@@ -4,7 +4,6 @@
  * Copyright 2019, 2021 NXP
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <fdt_support.h>
 #include <i2c.h>
diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
index d0e4e796c606..b7e043b2e62f 100644
--- a/board/freescale/ls1021atsn/ls1021atsn.c
+++ b/board/freescale/ls1021atsn/ls1021atsn.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2016-2019, 2021 NXP
  */
-#include <common.h>
 #include <clock_legacy.h>
 #include <fdt_support.h>
 #include <init.h>
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
index 27b9d79e5f0b..78006afce869 100644
--- a/board/freescale/ls1021atwr/ls1021atwr.c
+++ b/board/freescale/ls1021atwr/ls1021atwr.c
@@ -4,7 +4,6 @@
  * Copyright 2019, 2021-2022 NXP
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <command.h>
 #include <fdt_support.h>
diff --git a/board/freescale/ls1043ardb/ls1043ardb.c b/board/freescale/ls1043ardb/ls1043ardb.c
index 18869d8c1df5..cf84ff9e638e 100644
--- a/board/freescale/ls1043ardb/ls1043ardb.c
+++ b/board/freescale/ls1043ardb/ls1043ardb.c
@@ -4,7 +4,6 @@
  * Copyright 2021-2022 NXP
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
index 21c21aac221f..01786d938de1 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Hitachi Power Grids. All rights reserved.
  */
 
-#include <common.h>
 #include <event.h>
 #include <i2c.h>
 #include <asm/io.h>
diff --git a/drivers/net/fm/fm.c b/drivers/net/fm/fm.c
index 7dfa82190949..a8caa0f0927d 100644
--- a/drivers/net/fm/fm.c
+++ b/drivers/net/fm/fm.c
@@ -3,7 +3,6 @@
  * Copyright 2009-2011 Freescale Semiconductor, Inc.
  *	Dave Liu <daveliu@freescale.com>
  */
-#include <common.h>
 #include <env.h>
 #include <fs_loader.h>
 #include <image.h>
diff --git a/drivers/net/qe/uccf.c b/drivers/net/qe/uccf.c
index 306f1ea1db68..00848a1a37d7 100644
--- a/drivers/net/qe/uccf.c
+++ b/drivers/net/qe/uccf.c
@@ -6,7 +6,6 @@
  * based on source code of Shlomi Gridish
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/errno.h>
 #include <asm/io.h>
diff --git a/drivers/qe/fdt.c b/drivers/qe/fdt.c
index 6195c7c4442c..fa9e40655603 100644
--- a/drivers/qe/fdt.c
+++ b/drivers/qe/fdt.c
@@ -6,7 +6,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/drivers/qe/qe.c b/drivers/qe/qe.c
index 2825dc6f9aa6..736dd8558b60 100644
--- a/drivers/qe/qe.c
+++ b/drivers/qe/qe.c
@@ -6,7 +6,6 @@
  * based on source code of Shlomi Gridish
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <command.h>
 #include <asm/global_data.h>
diff --git a/include/fsl_qe.h b/include/fsl_qe.h
index 48accb8d8918..309ca7ea6afc 100644
--- a/include/fsl_qe.h
+++ b/include/fsl_qe.h
@@ -9,7 +9,6 @@
 #ifndef __QE_H__
 #define __QE_H__
 
-#include "common.h"
 #ifdef CONFIG_U_QE
 #include <linux/immap_qe.h>
 #endif
-- 
2.34.1

