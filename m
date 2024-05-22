Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEE2C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B6188538;
	Thu, 23 May 2024 01:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eWyztIkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D5D88522; Thu, 23 May 2024 01:31:47 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA52884E5
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c99e8958faso2812879b6e.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420703; x=1717025503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1lxjTB9anvmNkHpZIKVLikRZfWQ4H1XhJaRX5x9MRI=;
 b=eWyztIkBVMlo9XN6i8Losu2CRK2penYkXVzqBGqzhfTFUrBCtEZNVnP1DhfAf0Ag+4
 +UtdsnRRMvE55Zk1wVsOMKXOvhm7QfRKtwc9nwyFq2DzsRdx/uVDounTAFvKv1GwaX15
 2f6r8Zn88GH4WIfdVNVafHSujg0DAVPlgGi86vAAXvGuCcT8XoanKojIb/pYIoynyiIB
 tPbetwfwoLK2pJfE16fjYlCSSLxdZPnsM5t1UAHKVs0tokpUKPnQnMq5lmKDMlxDmgKd
 8rk8ZiSiiG6mthPd+s9KCDf1sR8G+ypJToMEkyOh5W35Lq+ffjqT4qU16ycmgU5hqIr1
 uGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420703; x=1717025503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1lxjTB9anvmNkHpZIKVLikRZfWQ4H1XhJaRX5x9MRI=;
 b=qgZK7UrAiuA6VG+cxSVcM1lHSfYy8AGBsS1EFxDm1yh3glq0bQRh6ewAG5NLDEYQOD
 5iG+ZC2/JSsFv9b0FCqHVaJKoDbzM1KAGFiX03sZ3Af/gznvlrR6qhOFuO6Nzep4zx99
 Bv9kxNdguPl33h/0YvpmOLS8jrZ6wD39YzNTNLi5zS2kPUEJxzDDLspkd3oT3tLi4P20
 LDhT7UlQIVu/tjumYwvoOFMMEcrKcZJNXVzgQcuwCUYpViNr4NbCYuLwuME9IsXpieHx
 RW/u6VyJl67KqZwdH/wPQ/DmttuS0WoHqr7GxMRfbN+U2QqImXe84+KOjl7gad6aKzyZ
 glQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQhAPsPk8NfwFT3F4dtfhY4twf6U+XmWo+0TRzyeuPdmKe8+tK5iER3JwB4dqtCkSUwqwxFoKV+XrWnWlboB6v+dTECw==
X-Gm-Message-State: AOJu0YzWG4uCpITeUEY4Gr41PK5/GsycR0Tm94/kxWrJmo4Hs1u4mOQW
 9gbI7dpP/VIJlAa32gePpvqVWxLIiKT1EHc1+sO7JKaYboQ5WdITTXg7M4M+Xoc=
X-Google-Smtp-Source: AGHT+IFWY8vUqarvsfg9J1UC/2VHhW7FV8MbPjxWij8Dvr/+9qyZEO/xrODe1oGItH54IodPucObUA==
X-Received: by 2002:a05:6808:d4f:b0:3c9:714d:cc7b with SMTP id
 5614622812f47-3cdb51984c8mr4413299b6e.9.1716420703407; 
 Wed, 22 May 2024 16:31:43 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c9974a3a5csm4687393b6e.17.2024.05.22.16.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:43 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 09/42] mmc: dw_mmc: Extract setting the DMA descriptor into a
 separate routine
Date: Wed, 22 May 2024 18:31:02 -0500
Message-Id: <20240522233135.26835-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

Make dwmci_prepare_data() function easier to read by extracting the
preparation of IDMAC descriptor into a dedicated function.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 52 ++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 439f8eb3fb4c..16601cacfc00 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -53,47 +53,57 @@ static void dwmci_set_idma_desc(struct dwmci_idmac *idmac,
 	desc->next_addr = (ulong)desc + sizeof(struct dwmci_idmac);
 }
 
-static void dwmci_prepare_data(struct dwmci_host *host,
-			       struct mmc_data *data,
+static void dwmci_prepare_desc(struct mmc_data *data,
 			       struct dwmci_idmac *cur_idmac,
 			       void *bounce_buffer)
 {
-	unsigned long ctrl;
-	unsigned int i = 0, flags, cnt, blk_cnt;
+	struct dwmci_idmac *desc = cur_idmac;
 	ulong data_start, data_end;
+	unsigned int blk_cnt, i;
 
-
+	data_start = (ulong)cur_idmac;
 	blk_cnt = data->blocks;
 
-	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
+	for (i = 0;; i++) {
+		unsigned int flags, cnt;
 
-	/* Clear IDMAC interrupt */
-	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
-
-	data_start = (ulong)cur_idmac;
-	dwmci_writel(host, DWMCI_DBADDR, (ulong)cur_idmac);
-
-	do {
-		flags = DWMCI_IDMAC_OWN | DWMCI_IDMAC_CH ;
-		flags |= (i == 0) ? DWMCI_IDMAC_FS : 0;
+		flags = DWMCI_IDMAC_OWN | DWMCI_IDMAC_CH;
+		if (i == 0)
+			flags |= DWMCI_IDMAC_FS;
 		if (blk_cnt <= 8) {
 			flags |= DWMCI_IDMAC_LD;
 			cnt = data->blocksize * blk_cnt;
 		} else
 			cnt = data->blocksize * 8;
 
-		dwmci_set_idma_desc(cur_idmac, flags, cnt,
-				    (ulong)bounce_buffer + (i * PAGE_SIZE));
+		dwmci_set_idma_desc(desc, flags, cnt,
+				    (ulong)bounce_buffer + i * PAGE_SIZE);
+		desc++;
 
-		cur_idmac++;
 		if (blk_cnt <= 8)
 			break;
 		blk_cnt -= 8;
-		i++;
-	} while(1);
+	}
 
-	data_end = (ulong)cur_idmac;
+	data_end = (ulong)desc;
 	flush_dcache_range(data_start, roundup(data_end, ARCH_DMA_MINALIGN));
+}
+
+static void dwmci_prepare_data(struct dwmci_host *host,
+			       struct mmc_data *data,
+			       struct dwmci_idmac *cur_idmac,
+			       void *bounce_buffer)
+{
+	unsigned long ctrl;
+
+	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
+
+	/* Clear IDMAC interrupt */
+	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
+
+	dwmci_writel(host, DWMCI_DBADDR, (ulong)cur_idmac);
+
+	dwmci_prepare_desc(data, cur_idmac, bounce_buffer);
 
 	ctrl = dwmci_readl(host, DWMCI_CTRL);
 	ctrl |= DWMCI_IDMAC_EN | DWMCI_DMA_EN;
-- 
2.39.2

