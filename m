Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E625C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA01788CD8;
	Thu,  2 May 2024 03:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gcU2oEq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A74E88CDB; Thu,  2 May 2024 03:34:00 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDAB88CC5
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-436ee76c3b8so57815621cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613635; x=1715218435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwEHoAcp0NbWdvOeMwvrqn8ZVnezIAO9mStcQDWWVHM=;
 b=gcU2oEq1MNc9vwbMcTV82vd3JEWeYhtnT4mndF9Seu+8JB21DoAprnXNssSTVpkqHZ
 OB7XofG+76VUKYyKLqokAr2NIMp0B5GtOPJ4LTU5rRIPHijfn9yezYM5jh7tb/KgcLzX
 vZsTpP6vDDZYrlAk56WeOYhcTCDa9KcxlcOBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613635; x=1715218435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwEHoAcp0NbWdvOeMwvrqn8ZVnezIAO9mStcQDWWVHM=;
 b=JWmorA5Re9NA3mf86cXzlgmiTIYLCx/i8QlxhBYxSHBpNVv80FepKtZbrVoa7COUm5
 l31XVKpZRLb4ioZJCXP6vgn8jbCuET1PIYvxo4Je9IABTSTAP3KsayxH8V5yS934ERGA
 FiIQXtPL8/XuPpvMiphtcua7+2Za0NAGxrmS4Mv9rAOFH+VE3wd0fP1spbQqQB5N//2h
 FN+DGcQzz0kZRr10uWz0KP05nzESL0HpycJFZGVzrzUlwtn/xbJQ+8Brrimk3CzVpAHO
 XsS2G1H9Dni++iSltMQ0Fmdw5O4ISYqI+zwBWOU3cNzIpludqeliv0dZanKyUw3jxG/t
 mA5w==
X-Gm-Message-State: AOJu0YwIpJviXGvgASHy/giB043PHJ48dVj5cUoLM5/TPu8JcSbLbZTX
 xDt9uWX6s1n2HuqD/xchRGHmMV1LtAsi5u2RSRLcuvGsWOjtW5JYnFssHiiCpYoGFRtoJKGPbhe
 CfJZPzoC1
X-Google-Smtp-Source: AGHT+IG4yyyWqwa+ZUCnhICJMbVzoWSqRZ9GJ0XfuNT1DeyYdlxiPDV21u9j1lout97mrLyJmoYrNA==
X-Received: by 2002:a05:622a:11c5:b0:43a:dede:73b8 with SMTP id
 n5-20020a05622a11c500b0043adede73b8mr5093113qtk.57.1714613635653; 
 Wed, 01 May 2024 18:33:55 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marex@denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, Ye Li <ye.li@nxp.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 69/81] thermal: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:26 -0600
Message-Id: <20240502013138.2383421-69-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: Benjamin Hahn <B.Hahn@phytec.de>
---
 drivers/thermal/imx_scu_thermal.c | 1 -
 drivers/thermal/imx_thermal.c     | 1 -
 drivers/thermal/imx_tmu.c         | 1 -
 drivers/thermal/thermal-uclass.c  | 1 -
 drivers/thermal/thermal_sandbox.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/thermal/imx_scu_thermal.c b/drivers/thermal/imx_scu_thermal.c
index 3ec131cbc6e1..fc2b0e227b29 100644
--- a/drivers/thermal/imx_scu_thermal.c
+++ b/drivers/thermal/imx_scu_thermal.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2f6343e7a180..ea1fcc3dcb29 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -6,7 +6,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <div64.h>
 #include <fuse.h>
 #include <log.h>
diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index ea6c8329c0a6..70d002aee25b 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/drivers/thermal/thermal-uclass.c b/drivers/thermal/thermal-uclass.c
index 700df8af2549..f0fe912e3131 100644
--- a/drivers/thermal/thermal-uclass.c
+++ b/drivers/thermal/thermal-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_THERMAL
 
-#include <common.h>
 #include <dm.h>
 #include <thermal.h>
 #include <errno.h>
diff --git a/drivers/thermal/thermal_sandbox.c b/drivers/thermal/thermal_sandbox.c
index 7dc0d108b8ca..9af0d0247cbd 100644
--- a/drivers/thermal/thermal_sandbox.c
+++ b/drivers/thermal/thermal_sandbox.c
@@ -6,7 +6,6 @@
  * Sandbox driver for the thermal uclass.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <thermal.h>
 
-- 
2.34.1

