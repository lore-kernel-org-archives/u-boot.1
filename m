Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC75E7D26A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E6186BCE;
	Tue, 26 Sep 2023 11:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfG9d/52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75F286C13; Tue, 26 Sep 2023 11:04:20 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F7D86A7D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57bbb38d5d4so2057028eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695719057; x=1696323857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oUR2UtN55kPrJT0gkjK2CvY/Fh891LoEJvio/wKyL0M=;
 b=hfG9d/52R5C8VCWRsntBxWc9fS4vNE26U4Jk6Wq+DS98g+2+bPOnfDHeAeB5EJZEXi
 8E7i6hjefaZiWtSrO0HwgmIzyIAdIOEqfM6CgJjXpbzoKEoA6YDmkmBpkpfEc4tzoaLl
 PmLhAs38PAGnhqKVgDRc/Aaptmb5t+dWA6NQI8lMzkqytWR8qLPxgGIDkQfoCsr4u29Y
 Ge3m98pXGMSZVQuYjZ9Jp+d766JwmcQ5l/nautZcGUjRF6zFy6sTCm5Pwu/e0mAvOo/3
 f9TYaeZZ00sl1CK37Eh5tAenxb4qLRGUw0pLAzUCanv1m2YCNQAgZZ76CSeD/K3B9ssu
 RrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695719057; x=1696323857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUR2UtN55kPrJT0gkjK2CvY/Fh891LoEJvio/wKyL0M=;
 b=iZcLBnqaeWW0doK2KrpawAwasXmIdyeA3wB4U0UlWAF8BUmrAkCwaMcIM7O/RWduYV
 FqM4HHMvcxcvkpBnDA6taXHMSTDP8rfQjx52H+DUnYx0i/u6jleplE9LmZQwf4EU/r5Z
 2J9i/+YxQRt2FUsyn5hANNji3ulupay7bbXByf2qsabu9YwiMj6/OIKuNdzNu6z3+kLk
 Sv2xoIqZGMCf2/p3bgyEbhjXUnlJBtQ6BJRbl2v/gAv2NSchjVldxR4Aj5hnz26emx6g
 kqhM+exJVOquI/Ks/vJvmhx2N58PJChiSbzYKtnI6JiWkJzqDGborUQyJzwxHOwszAQr
 Sbbw==
X-Gm-Message-State: AOJu0YwinJmXs8C2n+5QykziwyuGqjGs32o6Q+VYg8MmjUkNZkYrYYlY
 4tOzLClKkThWrVKdHIn4k1M=
X-Google-Smtp-Source: AGHT+IF8iFNl7E5FnSS8ZQ5LBrjxuo7soV8UZy114FV+PpR++FXkGy0hx9hqkJVUb7JnnOC2tEGCBg==
X-Received: by 2002:a05:6358:4287:b0:135:6d9:2399 with SMTP id
 s7-20020a056358428700b0013506d92399mr10908922rwc.30.1695719057235; 
 Tue, 26 Sep 2023 02:04:17 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a633c4a000000b005740aa41237sm9136241pgn.74.2023.09.26.02.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:04:16 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, sr@denx.de
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] wdt: nuvoton: fix reset/expire function error and add dts
Date: Tue, 26 Sep 2023 17:04:07 +0800
Message-Id: <20230926090407.407769-1-JJLIU0@nuvoton.com>
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

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 24 ++++++++++++++++++++++++
 drivers/watchdog/npcm_wdt.c              | 12 ++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index fabe5925b7..87c77dcb2c 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -154,6 +154,30 @@
 				clock-names = "refclk";
 			};
 
+			watchdog0: watchdog@801c {
+				compatible = "nuvoton,npcm750-wdt";
+				reg = <0x801c 0x4>;
+				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			watchdog1: watchdog@901c {
+				compatible = "nuvoton,npcm750-wdt";
+				reg = <0x901c 0x4>;
+				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			watchdog2: watchdog@a01c {
+				compatible = "nuvoton,npcm750-wdt";
+				reg = <0xa01c 0x4>;
+				clocks = <&clk NPCM8XX_CLK_REFCLK>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			serial0: serial@0 {
 				compatible = "nuvoton,npcm845-uart", "nuvoton,npcm750-uart";
 				reg = <0x0 0x1000>;
diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index e56aa0ebe1..d6792bab35 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -69,17 +69,21 @@ static int npcm_wdt_stop(struct udevice *dev)
 static int npcm_wdt_reset(struct udevice *dev)
 {
 	struct npcm_wdt_priv *priv = dev_get_priv(dev);
+	u32 val;
 
-	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
+	val = readl(priv->regs);
+	writel(val | NPCM_WTR, priv->regs);
 
 	return 0;
 }
-
 static int npcm_wdt_expire_now(struct udevice *dev, ulong flags)
 {
-	return npcm_wdt_reset(dev);
-}
+	struct npcm_wdt_priv *priv = dev_get_priv(dev);
 
+	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
+
+	return 0;
+}
 static int npcm_wdt_of_to_plat(struct udevice *dev)
 {
 	struct npcm_wdt_priv *priv = dev_get_priv(dev);
-- 
2.25.1

