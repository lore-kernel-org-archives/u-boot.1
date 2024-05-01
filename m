Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1191C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7607788AB6;
	Wed,  1 May 2024 04:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RlWoFS10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88CAA88B5D; Wed,  1 May 2024 04:44:20 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7EF788B49
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78ebc7e1586so47388785a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531456; x=1715136256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jthz9Hb/qEBxQ4TT8FDV+12rhyiSw6WacgQzLKdXS+4=;
 b=RlWoFS10hmXqpoww8aUMP/sBsq7hkL3zT6coYfblzDIPcDy0wuJ6VtAUVWH72krPa8
 cwgR3KTYaEc6lPKuDLqPfvy/ntuMRy2zv/FSlD0Wi1mQLTggw4XUGmbZQhqACVi/c2PN
 YenYOwoR9jXExnDQrL/3s15BTZ9QVk/dU6L64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531456; x=1715136256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jthz9Hb/qEBxQ4TT8FDV+12rhyiSw6WacgQzLKdXS+4=;
 b=wJGeS8HN9de72lcyCXWkIoWp5I0+OPigWHhd6myg9i+v8/vD9YYMRQ3wk5ZQVfupU6
 S/q/vJSM3UgYkfSBZP4rKZAZC+T+FFlKPxmMW2je6WIgRdgVT9Ua+q+ejEyXAqtAXail
 V3vU9RraaF3mpb9Rhrb5WTKOoecE1vCXbmYCgz729gcw8t/DZ6fDrbq2zKfJXkAdtnIF
 m6WJw14wM/riliXLB6S8yd45IMzqsJRw1ybN7ZZ/MCgM6NLTXzFr8E+vnixsdPRhRmYT
 /UEpOhYCUniPACUKGvGiF6RKqimnLjQfEI7BmuuTSgtwGO1Y8iHvmwbnvPjNacTM97ce
 Y7GA==
X-Gm-Message-State: AOJu0Ywdlu+IXJFnE6AatY/ucFzfcIgVAugy3dq3gC45oZgNjstLnveC
 T2aCgT6K62inR1h27GzR7NEZ0xlARVHFJhMqlExQaI1EKBsukW6ehLpMH4LCNHOEJ6X9LotR282
 P4/F4PA==
X-Google-Smtp-Source: AGHT+IGM0DxTNATCpQl9j4qpDJz4e4DfHKmqmZJxaWStEB6Vc6YxJ8E1fBna7duN5iPQPwSZV5GUZQ==
X-Received: by 2002:a05:6214:500a:b0:6a0:b014:c880 with SMTP id
 jo10-20020a056214500a00b006a0b014c880mr2455183qvb.29.1714531456647; 
 Tue, 30 Apr 2024 19:44:16 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Marek Vasut <marex@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 050/149] board: dhelectronics: Remove <common.h> and add
 needed includes
Date: Tue, 30 Apr 2024 20:41:37 -0600
Message-Id: <20240501024316.1767971-50-trini@konsulko.com>
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
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 board/dhelectronics/common/dh_common.c            | 1 -
 board/dhelectronics/common/dh_imx.c               | 2 +-
 board/dhelectronics/dh_imx6/dh_imx6.c             | 1 -
 board/dhelectronics/dh_imx6/dh_imx6_spl.c         | 1 -
 board/dhelectronics/dh_imx8mp/common.c            | 1 -
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 1 -
 board/dhelectronics/dh_imx8mp/spl.c               | 1 -
 board/dhelectronics/dh_stm32mp1/board.c           | 1 -
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 34094a020b07..32c50b4f0f59 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -4,7 +4,6 @@
  * Copyright 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c_eeprom.h>
 #include <net.h>
diff --git a/board/dhelectronics/common/dh_imx.c b/board/dhelectronics/common/dh_imx.c
index 7f451bad59c7..3d6487dd0d8c 100644
--- a/board/dhelectronics/common/dh_imx.c
+++ b/board/dhelectronics/common/dh_imx.c
@@ -4,9 +4,9 @@
  * Copyright 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
  */
 
+#include <linux/errno.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <common.h>
 #include <net.h>
 #include "dh_imx.h"
 
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 9dcfcec9e9e6..c8dd30dfeaf5 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2017 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/dhelectronics/dh_imx6/dh_imx6_spl.c b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
index e6d5657c62d0..3a5495ea18e3 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6_spl.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2017 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/arch/clock.h>
diff --git a/board/dhelectronics/dh_imx8mp/common.c b/board/dhelectronics/dh_imx8mp/common.c
index 44456da681ce..f6db9f678042 100644
--- a/board/dhelectronics/dh_imx8mp/common.c
+++ b/board/dhelectronics/dh_imx8mp/common.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index ff2c0e872151..c635735d89cb 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index 7d228da8e5b7..714f846521e0 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index 22af423536d5..20c9d70737ec 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <adc.h>
 #include <log.h>
 #include <net.h>
-- 
2.34.1

