Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02525C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56A1885A8;
	Thu, 25 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AtTPphZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD847884E2; Thu, 25 Jul 2024 22:45:30 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841EA88297
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3dab336717fso205640b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940327; x=1722545127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruvCrl4J6m5yDHflv99YfWUnqYW+PtjzSr6qfo4u14c=;
 b=AtTPphZGtn2lM1qftGNgLgEgMb1HO6xQe31rxtM9eEjT7Iv/30IsNfkbO/Feeg9HNF
 JcVsLGBLZ25aGDrThdcazAr+Dq//Jwy8z2sZuR6t3aGYpKWMcxodXxsfNESQIEtFBpyE
 sl9Ldney4Whv1W9kl5aR9WRaGyBUfgQX3kE0byNpAYxuyLiqNpuMnfZ1ZXEXw0L2L/iJ
 Jo6WSwOX8XPqCva7iGFqOQoIXlvfwtxD7+RU7sXmzdf6XvE9vJvbjhH8nCNN8C2X8ORs
 rd1NeuvAMjFvLgCsWx/0eqvDru5HM7BkqKPWASu3kS2baR5B+T48WgnYgCp7WqjsneRB
 idNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940327; x=1722545127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruvCrl4J6m5yDHflv99YfWUnqYW+PtjzSr6qfo4u14c=;
 b=lSFNOYPNbWJllLIRte4/xV4kUD2xJmzMZY8Lh8w4Ay8v0H9xwjtfSUrsNXta6Z0qGA
 LNLKTMc121ZuSKG/oh76l+JesGpmpqXVQuNo/Lw/dhyWfYD365m50v3okUhK/hqdJ9Wj
 Em5FqehjF+fob3CGnHUJr8XBAzc945te34RaCtxuJD9iTPnHjmu0vO4girXh/pjMY8N/
 o+bfzxN8y26XJ5BSl9WbLLUofSKS5BPFW8Y8CqdUcfiLTCZIECmmUX09CEM+UB6s5Y/3
 xf0veN9bD+H8gVEzeftrwc1NkOb/JlwRFIKm1OymSk4LH7GACEKlzZUQ4Em6hp+HO8v9
 35uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBpV/98miLMFs+3eHUisiY8xL48liZ9RsfK9ecEYiGxhO3F/abbFiv3DsCYBABSXUwb2OC68u6ZggWnO4a5CG5K0Wphw==
X-Gm-Message-State: AOJu0YwQ83F3v0LrAoEsTnREYiT/LLEthp/DubX7IQfFju1wN7bfC45b
 7nebqEsYoFM27qNBBwc2bNOZwU8XSkTs8d7GfHS5WxC6AZzwbodtUKGMPyYndb4=
X-Google-Smtp-Source: AGHT+IFPTSAQ2EgPLqSFUX9bXq0kFyH+0jMXDRrwXTNEgLX9bldFtDxZv5pLVJ/ASxlyuOBo5rrovA==
X-Received: by 2002:a05:6808:171c:b0:3da:a032:24bc with SMTP id
 5614622812f47-3db1109b545mr4554198b6e.33.1721940327224; 
 Thu, 25 Jul 2024 13:45:27 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db135544f3sm422923b6e.51.2024.07.25.13.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:26 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 08/38] mmc: dw_mmc: Extract setting the DMA descriptor into
 a separate routine
Date: Thu, 25 Jul 2024 15:44:50 -0500
Message-Id: <20240725204520.18134-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
  - Rebased on top of the most recent master

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 8fc26399034b..d73d58bcf7d7 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -53,46 +53,57 @@ static void dwmci_set_idma_desc(struct dwmci_idmac *idmac,
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
 
+	data_start = (ulong)cur_idmac;
 	blk_cnt = data->blocks;
 
-	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
-
-	/* Clear IDMAC interrupt */
-	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
+	for (i = 0;; i++) {
+		unsigned int flags, cnt;
 
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

