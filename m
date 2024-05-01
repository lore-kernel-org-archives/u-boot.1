Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDFAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6839C88ADB;
	Wed,  1 May 2024 04:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sXvcV8eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1754288B08; Wed,  1 May 2024 04:43:57 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C49688AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6a0c8fb3540so4314816d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531434; x=1715136234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8y7n5Ku0NBLdhn43MH76WLCEbbwpiR1WaIZD3dxoJxA=;
 b=sXvcV8eujGccu4dJWeoxuJq9ZqS6nVWffZG+BQV6jdlFy3laEIrwhuhrOIX+3jouVu
 Ix9fPFnWZujmY1WAlehPVtH2s4skHuoG1aw+jkTJJuSvVJg8/MxQq5BglQ45k1k0Gy4u
 +JSqY0bX9hxQdlI4qKwPCYxCveJjuXziVaiWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531434; x=1715136234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8y7n5Ku0NBLdhn43MH76WLCEbbwpiR1WaIZD3dxoJxA=;
 b=a2kcHI3B3W37HA3IOEHcXK13OoRKvdBmzpKXQOu3agpuVQmhZRa2RgcxOVVidk5JyF
 AVg/juvfdhNPNc5SFP2F5nsL8ZCUGYe9AiAy0yZVffYjXAiSQGIWgIwhxtKa1irftLsA
 G+8C3u3MBLkUxbRUEUoIFhj5RLWWdIcgjsy6oUvnX6YRlNNyBsKViRnL52lTYVo9mTu3
 HAnk4bwabMsKkD5ekK66vovGUDtJSadFmQdP/SMfXv6UKu1A3AA1Xv4PeqoT1cb9/0ML
 5SIqODKJ9GaXXERCTZnAzgGyJyRPw1mgkXdcYokklv+Di15ZQwmvH3U62iSZudrh+B1A
 sf+Q==
X-Gm-Message-State: AOJu0YweFJHCyhsdyOT/XzTwm9ozCmbvxhz+pTq/E7I1koT+59QzcPqW
 hRtStkJOMmSmtZCUHO5tRtCIq9HBJxOZi1ucPu39G6jK5L3tBDqcD9euo4s7oCibMTFTzjD7bok
 eys8o9w==
X-Google-Smtp-Source: AGHT+IHSN4pEmHivvwclFUyKy+Pl8BgGMVEg3hoQrzhxUMde3dCmcuIrAX6JFeaFQ9uAgjZtqb4dsw==
X-Received: by 2002:a05:6214:1d26:b0:6a0:a9dc:b11a with SMTP id
 f6-20020a0562141d2600b006a0a9dcb11amr2853387qvd.3.1714531433704; 
 Tue, 30 Apr 2024 19:43:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 030/149] board: bsh: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:17 -0600
Message-Id: <20240501024316.1767971-30-trini@konsulko.com>
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
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c | 1 -
 board/bsh/imx6ulz_smm_m2/spl.c            | 1 -
 board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c b/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c
index c82eabbfbea1..c03e390762a9 100644
--- a/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c
+++ b/board/bsh/imx6ulz_smm_m2/imx6ulz_smm_m2.c
@@ -14,7 +14,6 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
-#include <common.h>
 #include <env.h>
 #include <linux/sizes.h>
 
diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index 5b4812e129e3..724841b57456 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
index 0ebf208be82a..c99896873991 100644
--- a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
+++ b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
@@ -3,7 +3,6 @@
  * Copyright 2021 Collabora Ltd.
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <env.h>
 
-- 
2.34.1

