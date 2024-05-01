Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E90C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB2188B2D;
	Wed,  1 May 2024 04:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MK68kX0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E0D88AD7; Wed,  1 May 2024 04:44:16 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9701988AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78f0628da1eso448626185a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531453; x=1715136253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYucNiX/7L9JQOZDtCAdxK3lYKSnUy5JdvzwENp6rrc=;
 b=MK68kX0M41Bp3NOGFi4Hr/p1GnAGfKejCngKTadqgr5kZL98IVyTM8yf+QeSS+QYZT
 RAiKZapvTiMWVGSjE+LX0umeRgWsTPISAZfs+T+eOzPG+cj6vTourJem3PJmGe3vratZ
 phNEMGO0S8DldzcYnWP3uRMaXO/tpu3xceyxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531453; x=1715136253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYucNiX/7L9JQOZDtCAdxK3lYKSnUy5JdvzwENp6rrc=;
 b=uw5rlB0EEf2I3m3Ou6IYpW3Vq4jB2b5SdjuvEnVhNiPDqy8kYw5jdgCTMYdb1gKz0Z
 tZA7H17u3cGypuVmf+bwBP1mzOLf1txZGTXjbJpdZwJToVT/FCg1sVvlbz94DDSU/Dz9
 Ofu9FhyeCvM/CP66bJtNn78Z8GfXJ4E2G+KlgOHXcowvkmFCIXJQmIUNCL1o+nkGWYbZ
 PPCYX6m/0Qk8OXI6csjXzqhOqMyqmLfweJm+Q+UlKMzFOQsUVp+yMUmI3ZNUFmuWj3M7
 eOr1PjrTAaUGvFmj/+/waT0jkVYctCcSCrtyr6rINnY3mKHxKHYiC9QbaWJ0By4/hp4G
 RKug==
X-Gm-Message-State: AOJu0YyCnfbYls5S5o4JqgcKGzGCaHSCKrr2FKwFQwJtJV01ab2bKvRk
 MbZPtkG+bM3tKoT09ATAniGM3s270YaK4vrrDt1J55dhf/ctYKf8j6M0MySJWXLET3x3hwUYelA
 bv7CSWA==
X-Google-Smtp-Source: AGHT+IHLE0maVGQxLGkTShICfBPfx0xNPsEtYtPXJGomqlPfvMMcxAsM9jbhMlWs95gnA4ORhkbPOw==
X-Received: by 2002:a05:6214:21e3:b0:6a0:cef9:d45e with SMTP id
 p3-20020a05621421e300b006a0cef9d45emr1187910qvj.50.1714531453241; 
 Tue, 30 Apr 2024 19:44:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 047/149] board: data_modul: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:34 -0600
Message-Id: <20240501024316.1767971-47-trini@konsulko.com>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 board/data_modul/common/common.c                            | 1 -
 board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c | 1 -
 board/data_modul/imx8mm_edm_sbc/spl.c                       | 1 -
 board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c | 1 -
 board/data_modul/imx8mp_edm_sbc/spl.c                       | 1 -
 5 files changed, 5 deletions(-)

diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index 4ece82c73039..b4d74a8fd8bd 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm-generic/gpio.h>
 #include <asm-generic/sections.h>
 #include <asm/arch/clock.h>
diff --git a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
index bfb2bddc1d1f..339702e83927 100644
--- a/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mm_pins.h>
 #include <asm/io.h>
diff --git a/board/data_modul/imx8mm_edm_sbc/spl.c b/board/data_modul/imx8mm_edm_sbc/spl.c
index 4a9c62fb86fc..17aafd719c9d 100644
--- a/board/data_modul/imx8mm_edm_sbc/spl.c
+++ b/board/data_modul/imx8mm_edm_sbc/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
index f0f373aa2800..138acd36ad24 100644
--- a/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
+++ b/board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/io.h>
diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index cc2d253e391e..c19358985332 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <image.h>
 #include <init.h>
-- 
2.34.1

