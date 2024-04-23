Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD57EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 06:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E9E88536;
	Tue, 23 Apr 2024 08:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ewzfhwWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753EB88573; Tue, 23 Apr 2024 08:39:11 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41FF88514
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 08:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso34300295ad.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713854347; x=1714459147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dVgbGoRHBuy/69uPPDQ1zRpfdZTmrCTvuFWkaCiG/LM=;
 b=ewzfhwWn5LYoqnnD6TrGu0EJXbhntEYlcNnOnivFC7rEymITXxE76We/nN3B6cvVK3
 rlbOKXmiIUnekLyEaPmZxJWrOnBz4JAFV/2Od2a4LKYx++zpsbq938IwT28fBF6p0qYN
 K4jS/B04TL+kTX0fS5zY3w5ykQWcXBYRCU7VJl5vNljkwxTvknjiYhsMfV5Oj7pAxNQD
 NAOfe9XaWxjZ2sWQsCLaaRStGhaDWwyUsvBkmksPNKQAH2zSECP9TAHjUxDOTp6LsNQH
 zNKcnrua/j3v2UlWX3sDhs6rpUTat5bb4+tn/rkmAwWb+Zcvvcy36llLdpkikPIIaWR6
 m0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713854347; x=1714459147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dVgbGoRHBuy/69uPPDQ1zRpfdZTmrCTvuFWkaCiG/LM=;
 b=OxYEGbhbRRdLpqq7F+AHBfdfK+ZQQoT91qRfCR2N6Sm673nHoTYAe6zQoAli4FZvHj
 uolISHbkyrVsUahEoJmYo4Gkir736qRY+M2MFhxdxOahkBEdpyG/fvqWox5pCK662mQw
 4rZP5KQSFkRky5TP85GOFoULPeYc2Fje6uTVBY4fxXVJje7tIMgzg1XjyO3oXaKeZ+em
 iZiofEmYh/MP+xfUIRt0OyWxxpaXZICzR5fM/POMRG9KMbCg+yzgFq1Zg1ehCcYfwcgd
 rs5oX6UYc2+z4SCwAFdotuW/2w+HNU4ovWlpPItW7nkbgmufCxwfdikvB2x5AqDA3vlS
 JcjQ==
X-Gm-Message-State: AOJu0YwSH3JwBXJ7TMcbVt0brxOs+ZIGhX9nRLYlAsv/L8ZNvLGD3xxk
 zYY1p2KdnVhAUpeKkE5yGvw+/KGXgCwZHnTTVTC6Lj8xrzwGQnQo
X-Google-Smtp-Source: AGHT+IHI1t8QKCF6vGVAZ3BVwohqdtulSmhSNYJ7UnmrFpQZ3Nzumr3Ix7EWg2DkQ/tNmcHCAOZFLw==
X-Received: by 2002:a17:902:7890:b0:1e1:3300:702b with SMTP id
 q16-20020a170902789000b001e13300702bmr10074655pll.15.1713854347393; 
 Mon, 22 Apr 2024 23:39:07 -0700 (PDT)
Received: from localhost.localdomain ([180.217.143.235])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902e34a00b001e49bce99d9sm9243966plc.95.2024.04.22.23.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 23:39:06 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: KWLIU@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com, jagan@amarulasolutions.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] spi: npcm_pspi: Reset HW in driver probe
Date: Tue, 23 Apr 2024 14:38:42 +0800
Message-Id: <20240423063842.1919456-1-JJLIU0@nuvoton.com>
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

Reset HW to clear old status and use default data mode(8-bit).

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/spi/npcm_pspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/npcm_pspi.c b/drivers/spi/npcm_pspi.c
index eb14185273..c9441304f5 100644
--- a/drivers/spi/npcm_pspi.c
+++ b/drivers/spi/npcm_pspi.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <spi.h>
 #include <clk.h>
+#include <reset.h>
 #include <asm/gpio.h>
 #include <linux/iopoll.h>
 
@@ -194,6 +195,7 @@ static int npcm_pspi_probe(struct udevice *bus)
 {
 	struct npcm_pspi_priv *priv = dev_get_priv(bus);
 	int node = dev_of_offset(bus);
+	struct reset_ctl reset;
 	int ret;
 
 	ret = clk_get_by_index(bus, 0, &priv->clk);
@@ -205,6 +207,14 @@ static int npcm_pspi_probe(struct udevice *bus)
 	gpio_request_by_name_nodev(offset_to_ofnode(node), "cs-gpios", 0,
 				   &priv->cs_gpio, GPIOD_IS_OUT| GPIOD_ACTIVE_LOW);
 
+	/* Reset HW */
+	ret = reset_get_by_index(bus, 0, &reset);
+	if (!ret) {
+		reset_assert(&reset);
+		udelay(5);
+		reset_deassert(&reset);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

