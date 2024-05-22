Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6100C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8FC88549;
	Thu, 23 May 2024 01:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GavdtQn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5478852F; Thu, 23 May 2024 01:31:47 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB95884E7
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f12ed79fdfso2688478a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420704; x=1717025504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6pTAOnOkc9AD5gRKa3X2xjHQEQ3BujpCO7cVExN+Ro=;
 b=GavdtQn7ss3z7pRugmLJ8tGwEcU5OvzfJVY+msL/zWZKBm5qV3v0y2wDwlZSEEdYLj
 v4kAizomE1bG7WUS4LajdyvzL/R7BAdauVCiWDF7DSEr04kVWoGQkM0qVbbBBBfSpKXg
 W7YPAiBgX8YL4Tr1WxXxl/JvRngSodWyhVNCPldThv4+ne4K9cOElARaVbVD82k/X4Ww
 fCXvQqBdANv2fKramVCU0HvIjl21MtzyPA011sZg/z3V4WFxZs7XVSdSzokcheL5++Dc
 A3nx6XUP7mE60xwoA7TcRcbBIQmQZbbNlObCdmtv+x2+tggWHqK/gXGqpGkZFsihneF+
 kuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420704; x=1717025504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6pTAOnOkc9AD5gRKa3X2xjHQEQ3BujpCO7cVExN+Ro=;
 b=V3RN0gZmNdsSBCk2q8PhU4FKnKRnI5bOuKpcE4vzUDB77nKTOvTRHYJ33HNpe+Mka9
 BnL6HAgfUjVmg+PD0kt6fjmZQOv7gGHaJWsLsihB+XvQpO3tpn97o8fl8N0+cVERLcwO
 SggIiw3qYceB6SVD/TNy7kfBsQeBq8w5elPukrc6yrtCHHfER28JSfT5aHlzZgnErhWD
 zSS+x64ltdH8/dzHLHvNNRtzDp0AzkXPTXFujA9uAL/MAbgSrRHjGK1PGg91lMB59OGQ
 tsPZ+CH5tJV/zSbVN00nxrXLxfakV9SuMBQoF8Tk11KvXmSkQ/maKMB20V8HQ5Cbs704
 SYEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5RV95PzpZAdRHKFRyvAq1mapWn9iGHKSqeWP82nfwPVmyWM3wuq8toARuAveBqJ549yaopr1GGHIyQw38AvvBh6c9bQ==
X-Gm-Message-State: AOJu0Yw8eXC/2h3RoXIg3MuWxQ0P1RO0MY6V13kfijh7Dk3jPKyHz42A
 vqqh7gCBWV26XkssAkZZQweFGCUT3e2ilND+OiTQLtoRnmhSuw5hRoGv16gYMKc=
X-Google-Smtp-Source: AGHT+IGRe80AVZwz0TISqdCTlq3cPePGU+0z/bHOHaxHp6EMoA9QTBlJVa+LI0m9ClR4bUCWwpHivg==
X-Received: by 2002:a05:6830:1217:b0:6f0:706c:1382 with SMTP id
 46e09a7af769-6f665c27bddmr3868495a34.7.1716420704156; 
 Wed, 22 May 2024 16:31:44 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0f03633fesm4619202a34.79.2024.05.22.16.31.43
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
Subject: [PATCH 10/42] mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
Date: Wed, 22 May 2024 18:31:03 -0500
Message-Id: <20240522233135.26835-11-semen.protsenko@linaro.org>
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

Prepare for adding 64-bit IDMAC descriptors by renaming current 32-bit
descriptor and its fields accordingly. While at it, make use of
virt_to_phys() to make it more obvious in which places the physical
addresses have to be used.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 16601cacfc00..8e04ab39c2c5 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -20,11 +20,12 @@
 
 #define PAGE_SIZE 4096
 
-struct dwmci_idmac {
-	u32 flags;
-	u32 cnt;
-	u32 addr;
-	u32 next_addr;
+/* Internal DMA Controller (IDMAC) descriptor for 32-bit addressing mode */
+struct dwmci_idmac32 {
+	u32 des0;	/* Control descriptor */
+	u32 des1;	/* Buffer size */
+	u32 des2;	/* Buffer physical address */
+	u32 des3;	/* Next descriptor physical address */
 } __aligned(ARCH_DMA_MINALIGN);
 
 static int dwmci_wait_reset(struct dwmci_host *host, u32 value)
@@ -42,22 +43,23 @@ static int dwmci_wait_reset(struct dwmci_host *host, u32 value)
 	return 0;
 }
 
-static void dwmci_set_idma_desc(struct dwmci_idmac *idmac,
-		u32 desc0, u32 desc1, u32 desc2)
+static void dwmci_set_idma_desc32(struct dwmci_idmac32 *desc, u32 control,
+				  u32 buf_size, u32 buf_addr)
 {
-	struct dwmci_idmac *desc = idmac;
+	phys_addr_t desc_phys = virt_to_phys(desc);
+	u32 next_desc_phys = desc_phys + sizeof(struct dwmci_idmac32);
 
-	desc->flags = desc0;
-	desc->cnt = desc1;
-	desc->addr = desc2;
-	desc->next_addr = (ulong)desc + sizeof(struct dwmci_idmac);
+	desc->des0 = control;
+	desc->des1 = buf_size;
+	desc->des2 = buf_addr;
+	desc->des3 = next_desc_phys;
 }
 
 static void dwmci_prepare_desc(struct mmc_data *data,
-			       struct dwmci_idmac *cur_idmac,
+			       struct dwmci_idmac32 *cur_idmac,
 			       void *bounce_buffer)
 {
-	struct dwmci_idmac *desc = cur_idmac;
+	struct dwmci_idmac32 *desc32 = cur_idmac;
 	ulong data_start, data_end;
 	unsigned int blk_cnt, i;
 
@@ -65,6 +67,7 @@ static void dwmci_prepare_desc(struct mmc_data *data,
 	blk_cnt = data->blocks;
 
 	for (i = 0;; i++) {
+		phys_addr_t buf_phys = virt_to_phys(bounce_buffer);
 		unsigned int flags, cnt;
 
 		flags = DWMCI_IDMAC_OWN | DWMCI_IDMAC_CH;
@@ -76,22 +79,22 @@ static void dwmci_prepare_desc(struct mmc_data *data,
 		} else
 			cnt = data->blocksize * 8;
 
-		dwmci_set_idma_desc(desc, flags, cnt,
-				    (ulong)bounce_buffer + i * PAGE_SIZE);
-		desc++;
+		dwmci_set_idma_desc32(desc32, flags, cnt,
+				      buf_phys + i * PAGE_SIZE);
+		desc32++;
 
 		if (blk_cnt <= 8)
 			break;
 		blk_cnt -= 8;
 	}
 
-	data_end = (ulong)desc;
+	data_end = (ulong)desc32;
 	flush_dcache_range(data_start, roundup(data_end, ARCH_DMA_MINALIGN));
 }
 
 static void dwmci_prepare_data(struct dwmci_host *host,
 			       struct mmc_data *data,
-			       struct dwmci_idmac *cur_idmac,
+			       struct dwmci_idmac32 *cur_idmac,
 			       void *bounce_buffer)
 {
 	unsigned long ctrl;
@@ -308,7 +311,7 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 {
 #endif
 	struct dwmci_host *host = mmc->priv;
-	ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac, cur_idmac,
+	ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac32, cur_idmac,
 				 data ? DIV_ROUND_UP(data->blocks, 8) : 0);
 	int ret = 0, flags = 0, i;
 	u32 retry = 100000;
-- 
2.39.2

