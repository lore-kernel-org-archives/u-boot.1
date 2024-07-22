Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215CEC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F29A8857C;
	Mon, 22 Jul 2024 19:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iBhVTTsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEA188511; Mon, 22 Jul 2024 19:57:52 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8CC883DE
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70448cae1e0so2468822a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671069; x=1722275869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MHyIdpoAUyw54t/oGINv3NyldAoLCepLGpJFqSJ1Yk=;
 b=iBhVTTsAGE60vj2GdhN3SETc37Ojegw7ItnVTLgWG+eoK5pC4zvjitgk9RUh7PCbBH
 DOyQg5sYTnty2QeQMJO6Y71H4+BqgROCXRUuoRmLUBXkaBdYcOqTc7/l91ooJPXOAeiw
 HkxRYVqR9aduelECKlZc7ZFi6gBtjMKipk2GtE1hoQIeatKhPzuGELY8q49WQdp1GVFd
 VPoBPDU4DZLuww4OAaUEOFVWSFelh+j1RfsYPjxdjSOZ14il2zR/Q5QlNUfYb4TcHGDZ
 C3+osJG1ucDbH61jZB5cTzkiXHDkUIQGZjrKlUArF7G+4DRa4qH/E8TmAPe3W1nhUgdB
 6Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671069; x=1722275869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MHyIdpoAUyw54t/oGINv3NyldAoLCepLGpJFqSJ1Yk=;
 b=Yiw3UeevUR9AUl5kbXYyu7N4IvBsBmwjiEelgqmx+N3rSlfnVwcr/3j0b9uYbV/b5n
 cRGSANJfGdyY59gGGSlWqMGPSkxoUriu7vlQYMdFhMR0JVNaT5mn95sAIeaGIY4srHCU
 IElzd/RcZVftjnS4OlUCpIEtqjS00ALqVGFeKc+w2wzvezLM7JqsWz6ddJ9xCEeL7YUo
 aiKUNeMoTPIWddLVsreVPUuIgtqZqMFwnAMcaKSAE0R+huGx5Ix3e8M5jgRFkAXugimI
 A+qfnpPkAslyTwlW/uyeP0nmJO1VrwLGTRG6/wae4QBkJuxAPxPegXTFafOWTGf6mBzr
 vzDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Go155NEpjysi9b4l17VfJp5V9qXd/dTmrZzpuNmJLiZM7imhUGn4qHzbjVEnkFuaormPRxRzE+7ud9oragKfYsGCzg==
X-Gm-Message-State: AOJu0YzJQVu8NpkhRsooPnEweHfAldQtB1OwB56Y5j0DRXo1WX7oaRur
 dDR4tm92rfc5O8MLf3yZbFJ+LUd8eZJQbncNZrM1XMEvfnXfaqzPah8EGY+S+tk=
X-Google-Smtp-Source: AGHT+IEce0/ajQ6gzJFL1h4gmDyfjDBHDH5fo8z6Jt1rZDPkb7SQAvDEWQ2o8v17CjIqJIIFaoAodQ==
X-Received: by 2002:a05:6830:9c4:b0:703:5e7e:4ec8 with SMTP id
 46e09a7af769-709008d0985mr10358745a34.1.1721671068842; 
 Mon, 22 Jul 2024 10:57:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60c2b55sm1643192a34.21.2024.07.22.10.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:48 -0700 (PDT)
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
Subject: [PATCH v3 10/38] mmc: dw_mmc: Add support for 64-bit IDMAC
Date: Mon, 22 Jul 2024 12:57:12 -0500
Message-Id: <20240722175740.6985-11-semen.protsenko@linaro.org>
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

Some DW MMC blocks (e.g. those on modern Exynos chips) support 64-bit
DMA addressing mode. 64-bit DW MMC variants differ from their 32-bit
counterparts:
  - the register layout is a bit different (because there are additional
    IDMAC registers present for storing upper part of 64-bit addresses)
  - DMA descriptor structure is bigger and different from 32-bit one

Introduce all necessary changes to enable support for 64-bit DMA capable
DW MMC blocks. Next changes were made:

  1. Check which DMA address mode is supported in current IP-core
     version. HCON register (bit 27) indicates whether it's 32-bit or
     64-bit addressing. Add boolean .dma_64bit_address field to struct
     dwmci_host and store the result there. dwmci_init_dma() function is
     introduced for doing so, which is called on driver's init.

  2. Add 64-bit DMA descriptor (struct dwmci_idmac64) and use it in
     dwmci_prepare_desc() in case if .dma_64bit_address field is true.
     A new dwmci_set_idma_desc64() function was added for populating that
     descriptor.

  3. Add registers for 64-bit DMA capable blocks. To make the access to
     IDMAC registers universal between 32-bit / 64-bit cases, a new
     struct dwmci_idmac_regs (and corresponding host->regs field) was
     introduced, which abstracts the hardware by being set to
     appropriate offset constants on init. All direct calls to IDMAC
     registers were correspondingly replaced by accessing host->regs.

  4. Allocate and use 64-bit DMA descriptors buffer in case when IDMAC
     is 64-bit capable. Extract all the code (except for the IDMAC
     descriptors buffer allocation) from dwmci_send_cmd() to
     dwmci_send_cmd_common(), so that it's possible to keep IDMAC
     buffer (either 32-bit or 64-bit) on stack during send_cmd routine.

The insights for this implementation were taken from Linux kernel DW MMC
driver.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/dw_mmc.c | 152 ++++++++++++++++++++++++++++++++++---------
 include/dwmmc.h      |  39 ++++++++++-
 2 files changed, 160 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index a77023ff4cd6..7aa3dbbe83ad 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -28,6 +28,39 @@ struct dwmci_idmac32 {
 	u32 des3;	/* Next descriptor physical address */
 } __aligned(ARCH_DMA_MINALIGN);
 
+/* Internal DMA Controller (IDMAC) descriptor for 64-bit addressing mode */
+struct dwmci_idmac64 {
+	u32 des0;	/* Control descriptor */
+	u32 des1;	/* Reserved */
+	u32 des2;	/* Buffer sizes */
+	u32 des3;	/* Reserved */
+	u32 des4;	/* Lower 32-bits of Buffer Address Pointer 1 */
+	u32 des5;	/* Upper 32-bits of Buffer Address Pointer 1 */
+	u32 des6;	/* Lower 32-bits of Next Descriptor Address */
+	u32 des7;	/* Upper 32-bits of Next Descriptor Address */
+} __aligned(ARCH_DMA_MINALIGN);
+
+/* Register offsets for DW MMC blocks with 32-bit IDMAC */
+static const struct dwmci_idmac_regs dwmci_idmac_regs32 = {
+	.dbaddrl	= DWMCI_DBADDR,
+	.idsts		= DWMCI_IDSTS,
+	.idinten	= DWMCI_IDINTEN,
+	.dscaddrl	= DWMCI_DSCADDR,
+	.bufaddrl	= DWMCI_BUFADDR,
+};
+
+/* Register offsets for DW MMC blocks with 64-bit IDMAC */
+static const struct dwmci_idmac_regs dwmci_idmac_regs64 = {
+	.dbaddrl	= DWMCI_DBADDRL,
+	.dbaddru	= DWMCI_DBADDRU,
+	.idsts		= DWMCI_IDSTS64,
+	.idinten	= DWMCI_IDINTEN64,
+	.dscaddrl	= DWMCI_DSCADDRL,
+	.dscaddru	= DWMCI_DSCADDRU,
+	.bufaddrl	= DWMCI_BUFADDRL,
+	.bufaddru	= DWMCI_BUFADDRU,
+};
+
 static int dwmci_wait_reset(struct dwmci_host *host, u32 value)
 {
 	unsigned long timeout = 1000;
@@ -55,11 +88,27 @@ static void dwmci_set_idma_desc32(struct dwmci_idmac32 *desc, u32 control,
 	desc->des3 = next_desc_phys;
 }
 
-static void dwmci_prepare_desc(struct mmc_data *data,
-			       struct dwmci_idmac32 *cur_idmac,
-			       void *bounce_buffer)
+static void dwmci_set_idma_desc64(struct dwmci_idmac64 *desc, u32 control,
+				  u32 buf_size, u64 buf_addr)
+{
+	phys_addr_t desc_phys = virt_to_phys(desc);
+	u64 next_desc_phys = desc_phys + sizeof(struct dwmci_idmac64);
+
+	desc->des0 = control;
+	desc->des1 = 0;
+	desc->des2 = buf_size;
+	desc->des3 = 0;
+	desc->des4 = buf_addr & 0xffffffff;
+	desc->des5 = buf_addr >> 32;
+	desc->des6 = next_desc_phys & 0xffffffff;
+	desc->des7 = next_desc_phys >> 32;
+}
+
+static void dwmci_prepare_desc(struct dwmci_host *host, struct mmc_data *data,
+			       void *cur_idmac, void *bounce_buffer)
 {
 	struct dwmci_idmac32 *desc32 = cur_idmac;
+	struct dwmci_idmac64 *desc64 = cur_idmac;
 	ulong data_start, data_end;
 	unsigned int blk_cnt, i;
 
@@ -79,34 +128,47 @@ static void dwmci_prepare_desc(struct mmc_data *data,
 		} else
 			cnt = data->blocksize * 8;
 
-		dwmci_set_idma_desc32(desc32, flags, cnt,
-				      buf_phys + i * PAGE_SIZE);
-		desc32++;
+		if (host->dma_64bit_address) {
+			dwmci_set_idma_desc64(desc64, flags, cnt,
+					      buf_phys + i * PAGE_SIZE);
+			desc64++;
+		} else {
+			dwmci_set_idma_desc32(desc32, flags, cnt,
+					      buf_phys + i * PAGE_SIZE);
+			desc32++;
+		}
 
 		if (blk_cnt <= 8)
 			break;
 		blk_cnt -= 8;
 	}
 
-	data_end = (ulong)desc32;
+	if (host->dma_64bit_address)
+		data_end = (ulong)desc64;
+	else
+		data_end = (ulong)desc32;
 	flush_dcache_range(data_start, roundup(data_end, ARCH_DMA_MINALIGN));
 }
 
 static void dwmci_prepare_data(struct dwmci_host *host,
 			       struct mmc_data *data,
-			       struct dwmci_idmac32 *cur_idmac,
+			       void *cur_idmac,
 			       void *bounce_buffer)
 {
+	const u32 idmacl = virt_to_phys(cur_idmac) & 0xffffffff;
+	const u32 idmacu = (u64)virt_to_phys(cur_idmac) >> 32;
 	unsigned long ctrl;
 
 	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
 
 	/* Clear IDMAC interrupt */
-	dwmci_writel(host, DWMCI_IDSTS, 0xFFFFFFFF);
+	dwmci_writel(host, host->regs->idsts, 0xffffffff);
 
-	dwmci_writel(host, DWMCI_DBADDR, (ulong)cur_idmac);
+	dwmci_writel(host, host->regs->dbaddrl, idmacl);
+	if (host->dma_64bit_address)
+		dwmci_writel(host, host->regs->dbaddru, idmacu);
 
-	dwmci_prepare_desc(data, cur_idmac, bounce_buffer);
+	dwmci_prepare_desc(host, data, cur_idmac, bounce_buffer);
 
 	ctrl = dwmci_readl(host, DWMCI_CTRL);
 	ctrl |= DWMCI_IDMAC_EN | DWMCI_DMA_EN;
@@ -257,13 +319,13 @@ static int dwmci_dma_transfer(struct dwmci_host *host, uint flags,
 	else
 		mask = DWMCI_IDINTEN_TI;
 
-	ret = wait_for_bit_le32(host->ioaddr + DWMCI_IDSTS,
+	ret = wait_for_bit_le32(host->ioaddr + host->regs->idsts,
 				mask, true, 1000, false);
 	if (ret)
 		debug("%s: DWMCI_IDINTEN mask 0x%x timeout\n", __func__, mask);
 
 	/* Clear interrupts */
-	dwmci_writel(host, DWMCI_IDSTS, DWMCI_IDINTEN_MASK);
+	dwmci_writel(host, host->regs->idsts, DWMCI_IDINTEN_MASK);
 
 	ctrl = dwmci_readl(host, DWMCI_CTRL);
 	ctrl &= ~DWMCI_DMA_EN;
@@ -300,20 +362,10 @@ static void dwmci_wait_while_busy(struct dwmci_host *host, struct mmc_cmd *cmd)
 	}
 }
 
-#ifdef CONFIG_DM_MMC
-static int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
-		   struct mmc_data *data)
+static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
+				 struct mmc_data *data, void *cur_idmac)
 {
-	struct mmc *mmc = mmc_get_mmc_dev(dev);
-#else
-static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
-		struct mmc_data *data)
-{
-#endif
-	struct dwmci_host *host = mmc->priv;
-	ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac32, cur_idmac,
-				 data ? DIV_ROUND_UP(data->blocks, 8) : 0);
-	int ret = 0, flags = 0, i;
+	int ret, flags = 0, i;
 	u32 retry = 100000;
 	u32 mask;
 	struct bounce_buffer bbstate;
@@ -433,6 +485,28 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 	return ret;
 }
 
+#ifdef CONFIG_DM_MMC
+static int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
+			  struct mmc_data *data)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+#else
+static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
+			  struct mmc_data *data)
+{
+#endif
+	struct dwmci_host *host = mmc->priv;
+	const size_t buf_size = data ? DIV_ROUND_UP(data->blocks, 8) : 0;
+
+	if (host->dma_64bit_address) {
+		ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac64, idmac, buf_size);
+		return dwmci_send_cmd_common(host, cmd, data, idmac);
+	} else {
+		ALLOC_CACHE_ALIGN_BUFFER(struct dwmci_idmac32, idmac, buf_size);
+		return dwmci_send_cmd_common(host, cmd, data, idmac);
+	}
+}
+
 static int dwmci_control_clken(struct dwmci_host *host, bool on)
 {
 	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
@@ -594,6 +668,27 @@ static void dwmci_init_fifo(struct dwmci_host *host)
 	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
 }
 
+static void dwmci_init_dma(struct dwmci_host *host)
+{
+	int addr_config;
+
+	if (host->fifo_mode)
+		return;
+
+	addr_config = (dwmci_readl(host, DWMCI_HCON) >> 27) & 0x1;
+	if (addr_config == 1) {
+		host->dma_64bit_address = true;
+		host->regs = &dwmci_idmac_regs64;
+		debug("%s: IDMAC supports 64-bit address mode\n", __func__);
+	} else {
+		host->dma_64bit_address = false;
+		host->regs = &dwmci_idmac_regs32;
+		debug("%s: IDMAC supports 32-bit address mode\n", __func__);
+	}
+
+	dwmci_writel(host, host->regs->idinten, DWMCI_IDINTEN_MASK);
+}
+
 static int dwmci_init(struct mmc *mmc)
 {
 	struct dwmci_host *host = mmc->priv;
@@ -616,16 +711,13 @@ static int dwmci_init(struct mmc *mmc)
 
 	dwmci_writel(host, DWMCI_TMOUT, 0xFFFFFFFF);
 
-	dwmci_writel(host, DWMCI_IDINTEN, 0);
 	dwmci_writel(host, DWMCI_BMOD, 1);
 	dwmci_init_fifo(host);
+	dwmci_init_dma(host);
 
 	dwmci_writel(host, DWMCI_CLKENA, 0);
 	dwmci_writel(host, DWMCI_CLKSRC, 0);
 
-	if (!host->fifo_mode)
-		dwmci_writel(host, DWMCI_IDINTEN, DWMCI_IDINTEN_MASK);
-
 	return 0;
 }
 
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 7e4acf096dce..de18fda68ac8 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -44,12 +44,22 @@
 #define DWMCI_UHS_REG		0x074
 #define DWMCI_BMOD		0x080
 #define DWMCI_PLDMND		0x084
+#define DWMCI_DATA		0x200
+/* Registers to support IDMAC 32-bit address mode */
 #define DWMCI_DBADDR		0x088
 #define DWMCI_IDSTS		0x08C
 #define DWMCI_IDINTEN		0x090
 #define DWMCI_DSCADDR		0x094
 #define DWMCI_BUFADDR		0x098
-#define DWMCI_DATA		0x200
+/* Registers to support IDMAC 64-bit address mode */
+#define DWMCI_DBADDRL		0x088
+#define DWMCI_DBADDRU		0x08c
+#define DWMCI_IDSTS64		0x090
+#define DWMCI_IDINTEN64		0x094
+#define DWMCI_DSCADDRL		0x098
+#define DWMCI_DSCADDRU		0x09c
+#define DWMCI_BUFADDRL		0x0a0
+#define DWMCI_BUFADDRU		0x0a4
 
 /* Interrupt Mask register */
 #define DWMCI_INTMSK_ALL	0xffffffff
@@ -142,6 +152,29 @@
 /* quirks */
 #define DWMCI_QUIRK_DISABLE_SMU		(1 << 0)
 
+/**
+ * struct dwmci_idmac_regs - Offsets of IDMAC registers
+ *
+ * @dbaddrl:	Descriptor base address, lower 32 bits
+ * @dbaddru:	Descriptor base address, upper 32 bits
+ * @idsts:	Internal DMA status
+ * @idinten:	Internal DMA interrupt enable
+ * @dscaddrl:	IDMAC descriptor address, lower 32 bits
+ * @dscaddru:	IDMAC descriptor address, upper 32 bits
+ * @bufaddrl:	Current data buffer address, lower 32 bits
+ * @bufaddru:	Current data buffer address, upper 32 bits
+ */
+struct dwmci_idmac_regs {
+	u32 dbaddrl;
+	u32 dbaddru;
+	u32 idsts;
+	u32 idinten;
+	u32 dscaddrl;
+	u32 dscaddru;
+	u32 bufaddrl;
+	u32 bufaddru;
+};
+
 /**
  * struct dwmci_host - Information about a designware MMC host
  *
@@ -157,6 +190,8 @@
  * @fifoth_val:	Value for FIFOTH register (or 0 to leave unset)
  * @mmc:	Pointer to generic MMC structure for this device
  * @priv:	Private pointer for use by controller
+ * @dma_64bit_address: Whether DMA supports 64-bit address mode or not
+ * @regs:	Registers that can vary for different DW MMC block versions
  */
 struct dwmci_host {
 	const char *name;
@@ -196,6 +231,8 @@ struct dwmci_host {
 
 	/* use fifo mode to read and write data */
 	bool fifo_mode;
+	bool dma_64bit_address;
+	const struct dwmci_idmac_regs *regs;
 };
 
 static inline void dwmci_writel(struct dwmci_host *host, int reg, u32 val)
-- 
2.39.2

