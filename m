Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A4CC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B2C885FA;
	Mon, 22 Jul 2024 19:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gzFu/9yE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743E7885CE; Mon, 22 Jul 2024 19:57:51 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA53884AC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70365f905b6so3012253a34.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671068; x=1722275868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkSjjSgefooPtdfg8UJb3GaBykHruI04D5TWcHQtrRI=;
 b=gzFu/9yEDB62fJUwo92SIsEN/8C7QUR2DSYALmWRA3fyr5nW13vd5i8lDeIvhelyKC
 tWLI8NtnMa1oCaG2+rInFE58OKARajHOPncc/5AUZwDB+CbiPbIpEr4X1Ur7zj0mOzSW
 shrK/efFpU9wselz68/I1vyccttTmYe83DoA//NTg4yPyMfNiuNIYDqFjitdv7BflHGu
 HDV9ftSpyZk4P1JcJxxeyoDXmKn00B1V9yq9EnTg7A4geZ4gyZX6LFPirlVALpg7uv1H
 Sw6olkVsmxR5smmADV5cxB25SHV8o/hjPZnF7xjSabiUfsLnapahEAhCZ8nTxZb42tBk
 fdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671068; x=1722275868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkSjjSgefooPtdfg8UJb3GaBykHruI04D5TWcHQtrRI=;
 b=FnlO1aTwpJCw5wvkdRBMPNDmLXbO9nm8IvdWtQkL0JnAczuyORA3xMLw8eNNh5/IFX
 FaGlP+B12ul9uHJpxjdP4AXYwcCShPxZmNmpswRKs0ucvGmLQuFVUtLiDiqhFAzvbYOo
 A1QyYm2GBygDim6i/Ak1vVIUL0L4BcaVCAAtu6t3RVKOSrAhrTvgt3Fok8iwQFpXJgbC
 8EnmFQig++LWhWU7c9tm5njwS0XkdphGC/W3kDqNjREGQLJy3bA2NU4qPm26182QGU91
 NH+V7mnpz07YuV1pBzYPOw4X/75rJNK0sqNtifP2IWkOg5SLavpJtQyiCZogjS6Y4eiW
 W52w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXMcLaIz42eoeskcoVJ8FPBmP2ZQv5/77gMMGWVs9g4p4JUrXtQTgu3o7JzUaza61mFvixF2yCYrZl/hxt1OH98x9/LQ==
X-Gm-Message-State: AOJu0Yz1UQi1ihSjXwbNEOG1+jMeYAAU0eTAau/K9GF9jCzJmWe9ajKB
 kRNxT58SjAy18uG0SRX+YEftwZYyxgWHGTVEAZbIMxXQpE1Q47PpTivNC0MdyjdhZ9WVFPYe/kp
 h
X-Google-Smtp-Source: AGHT+IHCrGnsrCYlJuxPp8PJ+f2i8GSHu00XV1shWT9frRL+dIJNtKYd7jR9v8d9RJ/3lB6o/djZDw==
X-Received: by 2002:a05:6830:3c83:b0:704:7c75:b13b with SMTP id
 46e09a7af769-709008804damr8501761a34.6.1721671068112; 
 Mon, 22 Jul 2024 10:57:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6174359sm1595089a34.61.2024.07.22.10.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:47 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 09/38] mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
Date: Mon, 22 Jul 2024 12:57:11 -0500
Message-Id: <20240722175740.6985-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/dw_mmc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 8bec43f0bd16..a77023ff4cd6 100644
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

