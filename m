Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AE9C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 09:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E7D88276;
	Mon, 29 Jul 2024 11:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKhazN0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108DC885F5; Mon, 29 Jul 2024 11:06:19 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C7C88056
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so18351765ad.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722243975; x=1722848775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J3dKz/SfvvuKtnNXaj0GV8BxLbA75MT1Amemt684iCM=;
 b=TKhazN0JIOTd2mAJkOoQzG84P/C3rtQ+4oHlt5iri85cOX1aT4g27f3+2A3ZbvQTxB
 wTprMyvDO+HXuBBMPjASXutkzbJPdG9NT4tsiL3fqLBmG4peJXavA+UMbiT6d6b+MXL2
 naV+iFq/H+79x5WAIVyTO9OtNOPUblm3CNmSNC0T1f/5HeOSoKFhTKz7hU8CTTFq/Fx4
 9h2sQz0oAtGxfuyjFurFhwnDGvBVEUX26DHtsj/nrHrbrqHf5U3HSBbhdTgipGhBsPyF
 9QffAqCTX3aLpq73ywaOxfezl6cKJVURGrGfGP/HprWghCwSBQniSlSNNHfVOWANurQ3
 jVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243975; x=1722848775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3dKz/SfvvuKtnNXaj0GV8BxLbA75MT1Amemt684iCM=;
 b=FPcSniyjKscOdzJ+1TwpzDXa7OTS0sVtZHreBBl8F/NiYQ05XWv1zN00+do5dbWDgP
 Gxpm+kfLh8eyJEhfn/oAjaGFRdhDOJ34w2G4XkdiCcDPJnkZT4kGOsoopGFQwZygV0f9
 Cm0Gi032psZKnmQWMhN0amGX+q74ULnYA90JNOh10nrE19szywOK008e+dokCMXewOD9
 lShOtuuEdJ+HZVY5qr3Yl0oPTIL1X2BOg2B+KUJB5PBqvMbNWKFIXBLz11iCdeceulHN
 fTPr1o1bQKShdzEr4ivLtzltSgT9R1xbOgUz78wG+jf8zfDwjTPxeyfz5ACqvvOQsiNk
 czbg==
X-Gm-Message-State: AOJu0YykCl+JVXSZR9UuBc6cjmzf+XpbTRMf70kTD9qEU2VvOVs2Ubw2
 cVU1BQr6rha1s/L3COq8V1VrAiv8mXZ2XynNc3HXiapqnqDppahdG0Zaaw==
X-Google-Smtp-Source: AGHT+IGQMN5EnY6eenf6ea4rnXnsKII+e6JolTO3dcaOodh5CxnDxq93vT/hfPCzRGCg1SS00oZj8A==
X-Received: by 2002:a17:903:428f:b0:1fa:fc6a:858a with SMTP id
 d9443c01a7336-1ff04828ffbmr37907115ad.15.1722243975211; 
 Mon, 29 Jul 2024 02:06:15 -0700 (PDT)
Received: from cs20-buildserver.. ([1.200.155.58])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7eef4f0sm78083145ad.178.2024.07.29.02.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 02:06:14 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] timer: npcm: Change counter source
Date: Mon, 29 Jul 2024 17:04:06 +0800
Message-Id: <20240729090406.3738089-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

The counter value read from TDR register may not be correct.
Read SECCNT and CNTR25M instead to get the correct timestamp.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/timer/npcm-timer.c | 83 ++++++++++----------------------------
 1 file changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/timer/npcm-timer.c b/drivers/timer/npcm-timer.c
index 9463fd29ce..a9106b619e 100644
--- a/drivers/timer/npcm-timer.c
+++ b/drivers/timer/npcm-timer.c
@@ -3,93 +3,54 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
 
-#include <clk.h>
+#include <common.h>
 #include <dm.h>
 #include <timer.h>
 #include <asm/io.h>
 
-#define NPCM_TIMER_CLOCK_RATE	1000000UL		/* 1MHz timer */
-#define NPCM_TIMER_INPUT_RATE	25000000UL		/* Rate of input clock */
-#define NPCM_TIMER_TDR_MASK	GENMASK(23, 0)
-#define NPCM_TIMER_MAX_VAL	NPCM_TIMER_TDR_MASK	/* max counter value */
+#define NPCM_TIMER_CLOCK_RATE	25000000UL	/* 25MHz */
 
 /* Register offsets */
-#define TCR0	0x0	/* Timer Control and Status Register */
-#define TICR0	0x8	/* Timer Initial Count Register */
-#define TDR0	0x10	/* Timer Data Register */
+#define SECCNT	0x0	/* Seconds Counter Register */
+#define CNTR25M	0x4	/* 25MHz Counter Register */
 
-/* TCR fields */
-#define TCR_MODE_PERIODIC	BIT(27)
-#define TCR_EN			BIT(30)
-#define TCR_PRESCALE		(NPCM_TIMER_INPUT_RATE / NPCM_TIMER_CLOCK_RATE - 1)
-
-enum input_clock_type {
-	INPUT_CLOCK_FIXED,	/* input clock rate is fixed */
-	INPUT_CLOCK_NON_FIXED
-};
-
-/**
- * struct npcm_timer_priv - private data for npcm timer driver
- * npcm timer is a 24-bits down-counting timer.
- *
- * @last_count: last hw counter value
- * @counter: the value to be returned for get_count ops
- */
 struct npcm_timer_priv {
 	void __iomem *base;
-	u32 last_count;
-	u64 counter;
 };
 
 static u64 npcm_timer_get_count(struct udevice *dev)
 {
 	struct npcm_timer_priv *priv = dev_get_priv(dev);
-	u32 val;
+	u64 reg_sec, reg_25m;
+	u64 counter;
 
-	/* The timer is counting down */
-	val = readl(priv->base + TDR0) & NPCM_TIMER_TDR_MASK;
-	if (val <= priv->last_count)
-		priv->counter += priv->last_count - val;
-	else
-		priv->counter += priv->last_count + (NPCM_TIMER_MAX_VAL + 1 - val);
-	priv->last_count = val;
+	reg_sec = readl(priv->base + SECCNT);
+	reg_25m = readl(priv->base + CNTR25M);
+	/*
+	 * When CNTR25M reaches 25M, it goes to 0 and SECCNT is increased by 1.
+	 * When CNTR25M is zero, wait for CNTR25M to become non-zero in case
+	 * SECCNT is not updated yet.
+	 */
+	if (reg_25m == 0) {
+		while (reg_25m == 0)
+			reg_25m = readl(priv->base + CNTR25M);
+		reg_sec = readl(priv->base + SECCNT);
+	}
+	counter = reg_sec * NPCM_TIMER_CLOCK_RATE + reg_25m;
 
-	return priv->counter;
+	return counter;
 }
 
 static int npcm_timer_probe(struct udevice *dev)
 {
 	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct npcm_timer_priv *priv = dev_get_priv(dev);
-	enum input_clock_type type = dev_get_driver_data(dev);
-	struct clk clk;
-	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -EINVAL;
 	uc_priv->clock_rate = NPCM_TIMER_CLOCK_RATE;
 
-	if (type == INPUT_CLOCK_NON_FIXED) {
-		ret = clk_get_by_index(dev, 0, &clk);
-		if (ret < 0)
-			return ret;
-
-		ret = clk_set_rate(&clk, NPCM_TIMER_INPUT_RATE);
-		if (ret < 0)
-			return ret;
-	}
-
-	/*
-	 * Configure timer and start
-	 * periodic mode
-	 * timer clock rate = input clock / prescale
-	 */
-	writel(0, priv->base + TCR0);
-	writel(NPCM_TIMER_MAX_VAL, priv->base + TICR0);
-	writel(TCR_EN | TCR_MODE_PERIODIC | TCR_PRESCALE,
-	       priv->base + TCR0);
-
 	return 0;
 }
 
@@ -98,8 +59,8 @@ static const struct timer_ops npcm_timer_ops = {
 };
 
 static const struct udevice_id npcm_timer_ids[] = {
-	{ .compatible = "nuvoton,npcm845-timer", .data = INPUT_CLOCK_FIXED},
-	{ .compatible = "nuvoton,npcm750-timer", .data = INPUT_CLOCK_NON_FIXED},
+	{ .compatible = "nuvoton,npcm845-timer"},
+	{ .compatible = "nuvoton,npcm750-timer"},
 	{}
 };
 
-- 
2.34.1

