Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9430C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3F7883E6;
	Mon, 10 Jun 2024 03:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hJQnpIc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9648846D; Mon, 10 Jun 2024 03:12:37 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE1388428
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-24c0dbd2866so2115996fac.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981954; x=1718586754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ul4x83pvUauiV7lNM4UeKwyz1dPih6c34KL/rocNKoU=;
 b=hJQnpIc3eU8CJ8IgF2YsLKWs4EeISMswilNxIBKRrxYepOG08fv+A4Yp5RjBS8jPOe
 8lK5Pyz7Elof1c8Qc9BU98AH73ScwQvpJHMDEUGyeDfGGQeJjA5Z/xr61VJkc9QDDkgT
 IkVCd7X9hLZ9CudyuWibvS5G1yEwiBWssJsku2J4EE3nx0n26sKe8c3EDmAgxRz6041L
 AZx/aRZJGxIEiTX9u1j88rykrmxaCm3v+EUKRj80BTCmofxqnSMdtjZwtXdj2I2Q06Vf
 ZysHCTr1PGIScCCcu3U439GjalSkw1SYiQQUjwFGYiTAqGXg+c5A6IrM4tBo7YSE0AOv
 296w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981954; x=1718586754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ul4x83pvUauiV7lNM4UeKwyz1dPih6c34KL/rocNKoU=;
 b=DI/b8QPqnaBsc4AORV8yzU02EhNIjsnVhPrFVyWi7DCOWjq/SSiDSzRxkJFXblMMAU
 bBYGoi4DyZE52CRxiccSqurcn1DLclcmT9MmcK3RMSwGQ0LJwvqnwkhFGEPq6bH2X/1F
 kWfCYdROXfe+rcJpE8c80C1cYEbgUcHpDOAGB2Folbx1W7zAh3FC7vBqheFnrqwg0Y6J
 zOSCJZYQuIkgI50WnLIC6STbLFCs0yN3BLdXjx/0W9qFop/9tAXmzZeeco/LCHQ33jni
 Q1Pi/U2UiJiILAhujbJNkyZjS6uZi93wlfc/EVvHlEBfVaC+tIPSfkgSQssFxsZDoypG
 RVCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYou+YXhgrdWuofKvGJm5WgBgeV6917LfdmtyKU+xitmXNgWI7XXpBe4AX9xFRSUUK7dvZ/djEPHAUnZNM1iJL4d7Dhw==
X-Gm-Message-State: AOJu0Yxq0mBQSDQc/Lt06yaEOiHQcof3BV9GgxQmAHMpYV/ygpttmFy7
 Jd/WfBBy2vG2Rve93tMsjXcmlU2NltccZcoHGBrbHxPJnZhq666v8hLpy/mk+bPp7/8qp4DgLEq
 A
X-Google-Smtp-Source: AGHT+IEU5BR9duLX9c4tmk3Tn2yBKFZiC6L8gXYG9zS5YZry+h2+gWDkeibsiecrV2jFrLFPbvbPFw==
X-Received: by 2002:a05:6870:3107:b0:24c:b0ca:9650 with SMTP id
 586e51a60fabf-254644641edmr9998345fac.1.1717981953890; 
 Sun, 09 Jun 2024 18:12:33 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254bd5bf058sm425851fac.38.2024.06.09.18.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:33 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 10/40] mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
Date: Sun,  9 Jun 2024 20:11:56 -0500
Message-Id: <20240610011226.4050-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

