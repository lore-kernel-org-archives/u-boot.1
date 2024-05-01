Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD99BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BF988C3B;
	Wed,  1 May 2024 04:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T/+3Gpfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B604F88C3F; Wed,  1 May 2024 04:45:20 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEE188C2F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-69b44071a07so60777756d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531517; x=1715136317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sE24TsLMeEQNfdiT64ciXdVf7LkUOL1fo57wa/MXq9E=;
 b=T/+3GpfaxDNeGAck+q6SzKB6DjiGaf4fMbKqVZc5Z/HRW5XnROx/GsxlEe+Ctfxxvn
 HPN+N4KTmDauIqFErf85wpWYEWLzfPbiRHpc1WL0/ntZOKx/353kYKfgW2WONy0wgirC
 9cj04zFgoHbVh5W9g5wpqYJRfYv1LIPAuCg9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531517; x=1715136317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sE24TsLMeEQNfdiT64ciXdVf7LkUOL1fo57wa/MXq9E=;
 b=ezpJ9DFW+VY84W01lRZW0gssYtzG1AWOvE3/Gq07LJOz9uXuLKzaGS8s+Pi7shpLu9
 HFQKZSjoml/eA3wofXc5FP0ka2gP8J1VICtS23m8XyCHMccOe7+/wOvBHSLU9LYbwVul
 /3WPRE6nYB9fPSDJtn+inKEs5oPwF89wrmdCPmKHc6ic1Oqzd7e1/fN6561DQwVbFEFD
 mdNweOcwG+m4hnjhsYlLWs7qwg7Vfbi/v7wDeIJIckUX7d2t33e8ln7Q0TnFJGjaMB3I
 UEFOle+tOcdm+un2GA65lb9kD8X6eUTYg8s3T39dvjlYuSAHWY2D6brDgldD5rrvvDR3
 aXUw==
X-Gm-Message-State: AOJu0YxUgUA1QWyp6zuFp/sF8qHIj9ITMuVvMmmZ2ErFhQ/cnGj4oPNu
 xASb340AStbXorFpb8ABS39pIkCN+vW86VdFADkeMDV/rmbkvzHb3EUnO/p0tRtDIsemhQvVN46
 X5yzJ/8x/
X-Google-Smtp-Source: AGHT+IFtdRg6iKTyYGhPXLSf/qz4X2J2eIP4znnV25GrmQ0IhJK8RysQMd9QfM3DjKaMtRha+vV3tQ==
X-Received: by 2002:a05:6214:2623:b0:69b:7af:62e2 with SMTP id
 gv3-20020a056214262300b0069b07af62e2mr1384111qvb.36.1714531517078; 
 Tue, 30 Apr 2024 19:45:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Parthiban Nallathambi <parthitce@gmail.com>,
 "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>,
 Niel Fourie <lusus@denx.de>, Teresa Remmet <t.remmet@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 103/149] board: phytec: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:30 -0600
Message-Id: <20240501024316.1767971-103-trini@konsulko.com>
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
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Parthiban Nallathambi <parthitce@gmail.com>
Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
Cc: Niel Fourie <lusus@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: Daniel Schultz <d.schultz@phytec.de>
Cc: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Fabio Estevam <festevam@gmail.com>
---
 board/phytec/common/imx8m_som_detection.c    | 1 -
 board/phytec/common/phytec_som_detection.c   | 1 -
 board/phytec/pcl063/spl.c                    | 2 +-
 board/phytec/pcm052/pcm052.c                 | 1 -
 board/phytec/pcm058/pcm058.c                 | 1 -
 board/phytec/phycore_am335x_r2/board.c       | 2 +-
 board/phytec/phycore_am335x_r2/mux.c         | 1 -
 board/phytec/phycore_imx8mm/phycore-imx8mm.c | 1 -
 board/phytec/phycore_imx8mm/spl.c            | 1 -
 board/phytec/phycore_imx8mp/phycore-imx8mp.c | 1 -
 board/phytec/phycore_imx8mp/spl.c            | 1 -
 board/phytec/phycore_rk3288/phycore-rk3288.c | 1 -
 12 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
index ee34a5b95791..bfd60ffb7773 100644
--- a/board/phytec/common/imx8m_som_detection.c
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -4,7 +4,6 @@
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 78c173df20d4..b14bb3dbb7fa 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -4,7 +4,6 @@
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
-#include <common.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
diff --git a/board/phytec/pcl063/spl.c b/board/phytec/pcl063/spl.c
index b6d459fdfce6..b98c46dbcbd4 100644
--- a/board/phytec/pcl063/spl.c
+++ b/board/phytec/pcl063/spl.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2015-2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
diff --git a/board/phytec/pcm052/pcm052.c b/board/phytec/pcm052/pcm052.c
index 0f7235979b04..20f2aac332da 100644
--- a/board/phytec/pcm052/pcm052.c
+++ b/board/phytec/pcm052/pcm052.c
@@ -6,7 +6,6 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/phytec/pcm058/pcm058.c b/board/phytec/pcm058/pcm058.c
index b37c6fe218da..ecc5b75d8d42 100644
--- a/board/phytec/pcm058/pcm058.c
+++ b/board/phytec/pcm058/pcm058.c
@@ -9,7 +9,6 @@
  * Both NAND and eMMC cannot be set because they share the
  * same pins (SD4)
  */
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/crm_regs.h>
diff --git a/board/phytec/phycore_am335x_r2/board.c b/board/phytec/phycore_am335x_r2/board.c
index 5700effbd3f6..2022525651dc 100644
--- a/board/phytec/phycore_am335x_r2/board.c
+++ b/board/phytec/phycore_am335x_r2/board.c
@@ -10,7 +10,7 @@
  * Copyright (C) 2019 DENX Software Engineering GmbH
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/arch/cpu.h>
diff --git a/board/phytec/phycore_am335x_r2/mux.c b/board/phytec/phycore_am335x_r2/mux.c
index 7091c985ba12..bb1c48da0fe5 100644
--- a/board/phytec/phycore_am335x_r2/mux.c
+++ b/board/phytec/phycore_am335x_r2/mux.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2019 DENX Software Engineering GmbH
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
index ef6472916903..06cffbca3a69 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -4,7 +4,6 @@
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8mm/spl.c
index 690a51f7a72e..8d858590a39b 100644
--- a/board/phytec/phycore_imx8mm/spl.c
+++ b/board/phytec/phycore_imx8mm/spl.c
@@ -4,7 +4,6 @@
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mm_pins.h>
diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index dbdd6bb79373..35683591433c 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -4,7 +4,6 @@
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index df158024654e..352f803e4541 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -4,7 +4,6 @@
  * Author: Teresa Remmet <t.remmet@phytec.de>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mp_pins.h>
diff --git a/board/phytec/phycore_rk3288/phycore-rk3288.c b/board/phytec/phycore_rk3288/phycore-rk3288.c
index 1ddb4a4f8085..a970634b4c33 100644
--- a/board/phytec/phycore_rk3288/phycore-rk3288.c
+++ b/board/phytec/phycore_rk3288/phycore-rk3288.c
@@ -9,7 +9,6 @@
 #include <net.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
-- 
2.34.1

