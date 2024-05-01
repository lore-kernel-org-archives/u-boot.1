Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F133C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11F788AE3;
	Wed,  1 May 2024 04:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TK9vOjXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024E888AC1; Wed,  1 May 2024 04:43:49 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C6988ACB
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6a04bae512aso32491996d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531425; x=1715136225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgNb8+H7OquRw2ghz5a1h0+nkyhB+3SRx9sPzS7DehQ=;
 b=TK9vOjXXVVF5zyE+B6PA5U05ILRtzTIX6TDBn/iOYTXQ3c9GqBEbQJykvmWIhed8wg
 hucGN6JOgo9uCT1fX1qHmc/MuNosdQe6M9KSB1rCdz5EHGus1FcVOSGfCY/z9RQNZCPC
 dA7kihycfBAOnwQOrzhLMxyv8mGUxBZZevvUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531425; x=1715136225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgNb8+H7OquRw2ghz5a1h0+nkyhB+3SRx9sPzS7DehQ=;
 b=BRxKM8w+0m+WPAcTkfdjpMw3A+UX4cgRafcOsPlpQKJvfSB+lmEoqrR3KVcpwZK/FJ
 RtfgYgD32bcCk4MN1AJZejNh2N4dp67WsOIgjtSH9aZEIjdrhw9Te9FZW/n/Fl7eF2PJ
 6hyMGSrLj6PakzpetrTLtD7PygGJe9OYjOuCCueYk52Ee9MCsnaiZ/uhX/pe1+mNPpiL
 9Mt3dEri4i0ZTrOrRze1W1Xgf64GZB/xYv/shqMR8jE1KGbdGyAVBOfbFRCt04+ionlM
 ERF2KgkshkvXy/Cyz3g3wP94jJrPTOqLZEgRPKRO/N/TNoWPfrCssBO7gysn/TnuoqIB
 EFZw==
X-Gm-Message-State: AOJu0Yx21dr9+QOpXH2Ql+Rq3uusCdvLYdKeFjP2UbxdBNKZrb7v69fb
 3BzYHaFfHpm4ebfPqHEXNniTaKm4xS7crJNVfyS0DiezISmN/aXH4QtnGtd4NtM7pkHggPVze26
 xYe7UdQ==
X-Google-Smtp-Source: AGHT+IGuM0Bh7s2JcuZasRZYn1kaa1QYgG2Nc28f+A3z3ECnyZcOLXnyM6dBVa/OeqIi+6ET2ZfMbQ==
X-Received: by 2002:a05:6214:c2a:b0:6a0:cd4b:1227 with SMTP id
 a10-20020a0562140c2a00b006a0cd4b1227mr1178537qvd.23.1714531425573; 
 Tue, 30 Apr 2024 19:43:45 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>
Subject: [PATCH 023/149] board: beacon: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:10 -0600
Message-Id: <20240501024316.1767971-23-trini@konsulko.com>
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
Cc: Adam Ford <aford173@gmail.com>
---
 board/beacon/beacon-rzg2m/beacon-rzg2m.c | 1 -
 board/beacon/imx8mm/lpddr4_timing.c      | 1 -
 board/beacon/imx8mm/spl.c                | 1 -
 board/beacon/imx8mn/spl.c                | 1 -
 board/beacon/imx8mp/imx8mp_beacon.c      | 1 -
 board/beacon/imx8mp/spl.c                | 1 -
 6 files changed, 6 deletions(-)

diff --git a/board/beacon/beacon-rzg2m/beacon-rzg2m.c b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
index 99fe1edfb330..099053235ded 100644
--- a/board/beacon/beacon-rzg2m/beacon-rzg2m.c
+++ b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Compass Electronics Group, LLC
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 
diff --git a/board/beacon/imx8mm/lpddr4_timing.c b/board/beacon/imx8mm/lpddr4_timing.c
index 8e48b9d81b77..c1498dd5eaf4 100644
--- a/board/beacon/imx8mm/lpddr4_timing.c
+++ b/board/beacon/imx8mm/lpddr4_timing.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/beacon/imx8mm/spl.c b/board/beacon/imx8mm/spl.c
index 1632238bf5dd..12013aa5a4da 100644
--- a/board/beacon/imx8mm/spl.c
+++ b/board/beacon/imx8mm/spl.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
index b4d46f11f98d..f03841e5a01d 100644
--- a/board/beacon/imx8mn/spl.c
+++ b/board/beacon/imx8mn/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2020 Compass Electronics Group, LLC
  */
 
-#include <common.h>
 #include <hang.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/beacon/imx8mp/imx8mp_beacon.c b/board/beacon/imx8mp/imx8mp_beacon.c
index 8963a51fbba0..dd74e7c0f755 100644
--- a/board/beacon/imx8mp/imx8mp_beacon.c
+++ b/board/beacon/imx8mp/imx8mp_beacon.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* Copyright 2023 Logic PD, Inc dba Beacon EmbeddedWorks */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 591e8ca9ab5b..30d577f7e0e3 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

