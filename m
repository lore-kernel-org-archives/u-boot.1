Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEBEC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 07:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40575882E8;
	Mon, 13 May 2024 09:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DiSs6brp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F4588308; Mon, 13 May 2024 09:26:18 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CC4882E8
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 09:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2b43490e0e2so2677302a91.2
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715585175; x=1716189975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UCVTLdymBnQ9E2uWrNrlmT/2Q1hungbnuk4o2CVdIic=;
 b=DiSs6brpqfgcKttSj1KccWTpNB9FWd8ef0PynFtDkkDnOafBa/hURVZz7AyEJdGeeK
 7nv9zWFWppKiPDJKpd7XX115UoSrYrhbt6cQtx+8Ir6HqZAAQWgpIj1YkM9pqI5vTr5d
 +k4pE1mC1tXYEZRfkr+/70eWwOme9N3M06TqDtT26FE06fqpytxmyUq3LLSAM301g0f7
 6+tiEo2iT/0qfUh8UpXZXsPE46J+n6dzYXJnU1r2TrKgcbu7wA0i2DwOSsy/qvaRMNz6
 RlnVnkRTDJIvGPG2KUXR0ypKMsuS82Ud8DLVQYgmo66X2yA0HW5Yb6eJOH5VsgN4b1mN
 IzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715585175; x=1716189975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UCVTLdymBnQ9E2uWrNrlmT/2Q1hungbnuk4o2CVdIic=;
 b=SilVnrLO+3yDxN5L9ixlZlVsaAusbUvjlG/4VjssnFNtw/U+dQSEaH+pvs9fEGKWWr
 bI2Gg9Q5gIlndiHhhb33qOAye8z+P72nH1CU1MHGV5FdkCbRLZ7++jByTFBaUkaa1XqC
 HDvlaJxE3YcpbClPkOjJuJ9a5cJO7X8Mqac/rrjnEwha3Z/Bhu8J7HOVfvSyp9kPr/K8
 N+aipY+laVLDJwyEjjIdW+lx8Qwwe0OIA8UZUNnpMETdHHBSDDmOo20tYBtaw6aCtOar
 eUJgpglYMa5LCO8us5ArsfWZSStwjLWT0mQhcnzG7yyF6bhhyEr/w9gK+2rCwmtg7xcf
 dg2w==
X-Gm-Message-State: AOJu0YwmuIw5vMrW8JSMhqKWmIWa8CfiPuuriceUWgQ9avlF11Ba5JEK
 tKg9tiIUeqYAZXXjpQzoMd1uXZqvtmPEd7aunqu5xGGWSIAC8sho
X-Google-Smtp-Source: AGHT+IFSVaqyB/OObZHcFA23e16UnWOdIUeRwofY3XdEWvV8fPJqg+M/JldG/vA5VSL134nsVlBpyw==
X-Received: by 2002:a17:90a:9503:b0:2b5:af07:1cde with SMTP id
 98e67ed59e1d1-2b6ccb7e603mr7538826a91.34.1715585174678; 
 Mon, 13 May 2024 00:26:14 -0700 (PDT)
Received: from localhost.localdomain ([180.217.146.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628849c40sm9192226a91.18.2024.05.13.00.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:26:14 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, trini@konsulko.com,
 jim.t90615@gmail.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH] timer: npcm: Change counter source
Date: Mon, 13 May 2024 15:26:03 +0800
Message-Id: <20240513072603.1598677-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

From: Stanley Chu <yschu@nuvoton.com>

The counter value read from TDR register may not be correct.
Read SECCNT and CNTR25M instead to get the correct timestamp.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm7xx.dtsi | 12 ++--
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 13 ++--
 drivers/timer/npcm-timer.c               | 81 ++++++------------------
 3 files changed, 30 insertions(+), 76 deletions(-)

diff --git a/arch/arm/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/dts/nuvoton-common-npcm7xx.dtsi
index feb88872fc..093d5427e3 100644
--- a/arch/arm/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm7xx.dtsi
@@ -95,6 +95,11 @@
 			compatible = "nuvoton,npcm750-rst", "syscon", "simple-mfd";
 			reg = <0x801000 0x6C>;
 		};
+
+		timer0: timer@f0801068 {
+			compatible = "nuvoton,npcm750-timer";
+			reg = <0x801068 0x8>;
+		};
 	};
 
 	ahb {
@@ -245,13 +250,6 @@
 				status = "disabled";
 			};
 
-			timer0: timer@8000 {
-				compatible = "nuvoton,npcm750-timer";
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM7XX_CLK_TIMER>;
-			};
-
 			watchdog0: watchdog@801C {
 				compatible = "nuvoton,npcm750-wdt";
 				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index db7517cc9b..be06b2a0ca 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -62,6 +62,11 @@
 			reg = <0x0 0xf0801000 0x0 0x1000>;
 		};
 
+		timer0: timer@f0801068 {
+			compatible = "nuvoton,npcm845-timer";
+			reg = <0x0 0xf0801068 0x0 0x8>;
+		};
+
 		sdhci0: sdhci@f0842000 {
 			compatible = "nuvoton,npcm845-sdhci";
 			reg = <0x0 0xf0842000 0x0 0x100>;
@@ -157,14 +162,6 @@
 				status = "disabled";
 			};
 
-			timer0: timer@8000 {
-				compatible = "nuvoton,npcm845-timer";
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
-				clock-names = "refclk";
-			};
-
 			serial0: serial@0 {
 				compatible = "nuvoton,npcm845-uart", "nuvoton,npcm750-uart";
 				reg = <0x0 0x1000>;
diff --git a/drivers/timer/npcm-timer.c b/drivers/timer/npcm-timer.c
index 4562a6f231..af683b4c11 100644
--- a/drivers/timer/npcm-timer.c
+++ b/drivers/timer/npcm-timer.c
@@ -4,93 +4,52 @@
  */
 
 #include <common.h>
-#include <clk.h>
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
+	u64 counter, reg_sec, reg_25m;
 
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
 
@@ -99,8 +58,8 @@ static const struct timer_ops npcm_timer_ops = {
 };
 
 static const struct udevice_id npcm_timer_ids[] = {
-	{ .compatible = "nuvoton,npcm845-timer", .data = INPUT_CLOCK_FIXED},
-	{ .compatible = "nuvoton,npcm750-timer", .data = INPUT_CLOCK_NON_FIXED},
+	{ .compatible = "nuvoton,npcm845-timer"},
+	{ .compatible = "nuvoton,npcm750-timer"},
 	{}
 };
 
-- 
2.25.1

