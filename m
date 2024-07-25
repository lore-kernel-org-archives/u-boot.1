Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58962C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F25F885EC;
	Thu, 25 Jul 2024 22:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="muZZtIvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53928855B; Thu, 25 Jul 2024 22:45:31 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CDE88363
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d5bc93e09dso186820eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940328; x=1722545128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYuRs6bkhwN0qlbOF9g9zQ6AC9ywRIb96YslnQYh20M=;
 b=muZZtIvRwG8ivyHLZS2o8d+sGS/HToUe5EP+zRvNHuIpo2D6IOBnkjkLwh2XL3vsW2
 +cGIdpaZk7zAT2UaRwYLf8nIM7DbUBIsFY4EVjr9M0YW6DrRJEPiZcVO2we/wcCtxQ2A
 k8iMeeMS05HgqI1Y3R4w1pmClJ1nAvBYyhRpi8YVhiz06EZviRxOVC3JNr65pn1esk1n
 ZeZRpNx354wXEfLkasOdOr2kNOfbs33HoPodm7OiPtAtN6WAdCH38+R+BHjUS+BK5MD4
 yNmZqK9CaJJuRXjOpt//owtFNc4DP5zpqkLvYcmtDXh3S2O3d4No1E9EeUF89MB6MPG3
 JHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940328; x=1722545128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYuRs6bkhwN0qlbOF9g9zQ6AC9ywRIb96YslnQYh20M=;
 b=t4P5zlNQOVi/67IgtlRBx3efLLuqXEC24Yb7hCPK2iNQcKaYr1Dxk2vXcbbZBJuL1m
 F9DRblIO2tS0YCL8KeGDebaIq6VQh2VQym5v2B/HN8HIjs4dK+PWo6ZGG4Jhdz1rrSj9
 1AWhKQ5ujEITD1Ul05u3SmFvjgoInU+p8UJODhK2df0bNYmMFfO7lrhYMc+N7sYfpEi5
 I8Ihri/tueC5akWS60fbmEZUqtgmo43639eRg+HCw3lLXHfcrxC+DztN+7VaQTj4ScP9
 elDqkQt75loS7m3w3ZGS5CKMTj0DLu3yCslZmMV7dHrtNoZYwOM6hnx6pWUliVcM98HP
 kh7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7GHOhh4r4PdK4HM+EgiZuyzCowMElZNr6l6Ueh9T48BVu1XnOB0C/WHbUI+GVPs5wiGaExsbG7eKSS6AWx+uv5A2JQ==
X-Gm-Message-State: AOJu0Yyp9TaXC0df4Pdb+uCP9u9ykHzrsGpZp68w6JSM0qSE1kp6wkal
 ++SA4oyLvWtKksL5xSLj6q7ra8iumd/sDwAmlu1kPFoJ1/q5qeaL1w1qvla+tro=
X-Google-Smtp-Source: AGHT+IEQKLwwflwVVqFwR4G7pxoK6roHSWgMgKKIXrN0DmrlKwvW427+cuttkF1ZXXYJ3+9mONWfvA==
X-Received: by 2002:a05:6820:4b83:b0:5d5:bce7:677 with SMTP id
 006d021491bc7-5d5bce7099dmr1759491eaf.7.1721940327989; 
 Thu, 25 Jul 2024 13:45:27 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b36ca84csm249978eaf.48.2024.07.25.13.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:27 -0700 (PDT)
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
Subject: [PATCH v4 09/38] mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
Date: Thu, 25 Jul 2024 15:44:51 -0500
Message-Id: <20240725204520.18134-10-semen.protsenko@linaro.org>
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

Prepare for adding 64-bit IDMAC descriptors by renaming current 32-bit
descriptor and its fields accordingly. While at it, make use of
virt_to_phys() to make it more obvious in which places the physical
addresses have to be used.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/dw_mmc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index d73d58bcf7d7..3e7073f7de1b 100644
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

