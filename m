Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD51C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 13:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BDB871DA;
	Mon,  4 Dec 2023 14:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mV2NZjSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05FD6871DA; Mon,  4 Dec 2023 14:41:50 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0BD87479
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 14:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a1a496a73ceso397003166b.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701697307; x=1702302107;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ricLM1lIG5KKwLq18PO1K7fhI8l69B7pMn7y4sorvRo=;
 b=mV2NZjSKvM3+AbAmvC4vnLVOaDRn0tdleP3ZUZTrgdSHzY4NW+1MPT8QnKTEcGK473
 WAWZCTnqSRy/iOQvKgs/StgqYBV0sLWrBNYQN7880uvoh9Lk8fU3h25HzaM6v9JtPvX4
 c3FqX4YIyXqK9RDgaFjGVqF2eFsPubTCWUPmb2owzOpuwWaUfurNbHJtviuxhh05CJax
 3iNikJY/LqRZEFdeBsYR94ZExr4riEQT9yXsG+hCP24hCBVTmvBsdIHWiH4PTmmGBoLa
 DqYttUiEXCX67fuCSdcLz7cS8ohGy0yiSUzJnmazHiGIn5h52Vl8ooJbLj3+N18tyqQs
 lgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701697307; x=1702302107;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ricLM1lIG5KKwLq18PO1K7fhI8l69B7pMn7y4sorvRo=;
 b=ipj9cc2DjTqcyNoz83dw6CyrAx62M4hfTb3OYH03oePVI/60oG7xI4LaS+kQrnig+O
 Mldgw2yan9d8VHRtKyxNOyzwrtpbHqMJKjv7bjoLgPak1GWVwziwLO5ontUZk5j2g3BS
 r6wVe6gFzRkj3KFEhFiUpLZqGOaYerfcS7kfJ9x4ibYGzF7FZvBBPz866rvJQNjlCDMp
 9j6XyQrZKvMp97P4OeVjXS71w6orP3FT02vG3mHB7dC6IrsgmqWV6lAb52s4AavaYCf9
 gn0dnx8BR5m+IgOO5Xd7mq5RE/qDwz4hfeOhwjFKwm2G2+ePiLS4iiUyFKNtiaPXHQHS
 oL8w==
X-Gm-Message-State: AOJu0YxrAPdBWexGTPoBf23gUXXLBGQ52vDdRKLFbJHlfBpeCP+R7buc
 +T8Zqo0WPsKkAMTDyRL889cS9jQzW5+MwgiJKiCL6w==
X-Google-Smtp-Source: AGHT+IFhDccmG4XbDt7SclJSUFDjrHy/1XhbQ2XKGwHt0yuvc8TLQyxWN1fJoDCb1TK3gwbQYHj94Q==
X-Received: by 2002:a17:906:44:b0:a04:a274:2a0a with SMTP id
 4-20020a170906004400b00a04a2742a0amr3769589ejg.73.1701697307330; 
 Mon, 04 Dec 2023 05:41:47 -0800 (PST)
Received: from localhost ([2a04:cec2:b:6009:c298:6724:4971:1296])
 by smtp.gmail.com with ESMTPSA id
 r23-20020a170906365700b00a177e311e09sm5258023ejb.70.2023.12.04.05.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 05:41:46 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Ryder
 Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mmc: mediatek: set b_max according
 CONFIG_SYS_MMC_MAX_BLK_COUNT
Date: Mon,  4 Dec 2023 14:41:45 +0100
Message-ID: <87edg23x0m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

The block count limit on MMC based devices should be set according to
CONFIG_SYS_MMC_MAX_BLK_COUNT instead of hardcoding value.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index d21a30c954..5a0c61daed 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1665,7 +1665,7 @@ static int msdc_drv_probe(struct udevice *dev)
 	if (cfg->f_max < cfg->f_min || cfg->f_max > host->src_clk_freq)
 		cfg->f_max = host->src_clk_freq;
 
-	cfg->b_max = 1024;
+	cfg->b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
 	cfg->voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	host->mmc = &plat->mmc;
-- 
2.43.0

