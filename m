Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E38C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A57E83B0B;
	Thu, 22 Jan 2026 00:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HiIXFS/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD756839D5; Wed, 21 Jan 2026 23:38:31 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB1683A3B
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 23:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-404254ffe8aso209237fac.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 14:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769035108; x=1769639908;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/aDHLph7QIwsNQ+9/9LqAKewiGpDoJQ6clmfZmaZRjo=;
 b=HiIXFS/jJrrPuJdv5Pos8pk+FTsGwLNKrz4sf6Zal8s8glucklkWKn/wtw5rfmRtGu
 I2PR0gQipahClCcQ1q/6u+2DWpLpwKgA+pHBaIMzLJIVMFBztCFZh0YXb1TxdxiZuIjb
 txhdngP/XRx/rWbdTVnLEfcWT9i4jrcDDnHGSUEkJJSfa+E1WCO4rEq4rZOmwK6mPCfI
 t1la0uBfWq0wvuGSGQGOAH6BQzPt+bMLAu0quC3hk8lDqVjIXMDPdbqqc6WuxI3MxIxQ
 vELgQRdIZn+5vqgXQd8dlS6JRKYW5L9yeZBVE3JAwnWlcIOZvQVIjBArGaJIb7FJALDK
 AOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769035108; x=1769639908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/aDHLph7QIwsNQ+9/9LqAKewiGpDoJQ6clmfZmaZRjo=;
 b=FuLcGFOk2M2PwtLU3YyGNOINkLKxwy9OpeF4LOQPfa9Eu03ud4xkKLWlaPmA5xyxjH
 8YwnBhkQtcRf8q7rjRkU4XI2w3nLd1F6Lbm5Gigd4Gxd8QOC7sJEpWkjwhfM5qaT1rrL
 VFn6isPFK7bRYGw+xcV7GUzx8IbsBLp80WsL0FlgarPEUSdFAkas/9e7ZSqumtiTpdG5
 vBWG5g9+aJvDArphKRF1ql02lBAw2am9PquXD/J6brTAfKohtuOBqmVC4nQ1iQb8cY/e
 VcdOy5UA46RP/iyUvvPe1Xe17nwlnPgJNFYj8IqlpEVYkHGS59lghihBnUnONpKEbAU5
 6qRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdsO6EgBgMx8mwnr+pQy3faLf6+LZNIlIdOnC3EJCdzvZuGrj2Mhxtf6Gw14a1nTSP4LdsOyc=@lists.denx.de
X-Gm-Message-State: AOJu0YwVjxWH1U4qAapzklt2i4sb0SmSE/8xGVuFxnSy1IB1lPVA2Gc7
 g/prrf+OJWeox6Pn9wM/+67CN8tuJmKRAEfDHdmKEvHCl9vtYsv8Zx2fOklfKNpisJM=
X-Gm-Gg: AZuq6aIJxWblJiUR/W5o8/CPi4RJfkrMdST1Ekq/I+xDzEMyz8FkZw2OE2niv3zDaNQ
 hXgS4FTNeYVLLhAEypIIAT1DwrmkVmtF15uWqXUlemk0XUePQy5zxz4P22d2bR4fWtCjYlDql7b
 1oUSXmLLf6eUiTCUyA+0nC3RWkL93saToTbRgk7Mq2aIBWVkVHIZwyRMDPsgks+dxklzM1HQu1/
 uavpdzz/qJi+FJKL5NVH2u6fsVSfaDUyrahfx1s73VJFz8rg7C0vUd0pqaYRb8CN4W6LRUE3J8w
 FXCtEtPTuF/sZkm2aXNk8usmIdLnGY2Y/INHojYttcjI/RUZriJZRqXfGFah7S/fr+zRrnrey5g
 IsWxcpkBrahn1JCr+ul6YW63z+XNY1bIxgO4Q0IKpvA5xhAgAI0ealS+qsrhHNB8Ev6CerZnlpQ
 RxrjRp9hrUT/wb
X-Received: by 2002:a05:6870:418d:b0:404:1abd:9798 with SMTP id
 586e51a60fabf-40882cc7d52mr681776fac.11.1769035108057; 
 Wed, 21 Jan 2026 14:38:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9a8b:7a9:24fa:a0a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd150dasm12452458fac.14.2026.01.21.14.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:38:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 21 Jan 2026 16:36:26 -0600
Subject: [PATCH 3/3] mmc: mediatek: add DMA mode support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-mmc-mtk-dma-support-v1-3-3764b487c087@baylibre.com>
References: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
In-Reply-To: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, "ht.lin" <ht.lin@mediatek.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8854; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WDXb6SSynjjx0Nx0SioWPrYdgOcrx1KB21Ux5BJGgqg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpcVVXdD9Drb0UAaNa/vQ+G6tLKvbiN+jnoqRo3
 kVL5bqrTFOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXFVVxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AII8H+gIxumXmhPT+2G0JHDUjFCsGxVXSbldA5n/GrqO
 ryFzCA+9X3G1icEAaug7EV1I3nkOsaBRvnzmVAZtY/rAp5vCQGDA3GveuY4xwGy4dESjCa+sW/E
 mzAIyTSAbt9UzOlCudhb4DUOEYyvXZRG1BqwgWdrjyL2Dn7KZF0WIXrba4VwV5OC1UniSHfd6Uj
 zVaOfcrWm0py3lxIjToU0gj/E+z4VlZl5PCsbpyLXCiRaemnNdIk363WeJYPWjTp+0NM7W3punY
 /XZHv4eNeZp3+1qgggZOMGCB9S0uCpB+Ysz7TlScfJoTCoBUHMMkeT88nKg9qL4rXNmTdlHENHB
 Wdco=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:22 +0100
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

From: "ht.lin" <ht.lin@mediatek.com>

Implement DMA support in the MediaTek MMC driver to enhance data
transfer speed.

- Define DMA control and configuration registers
- Implement functions for starting, stopping, and completing DMA
  transfers
- Modify data transfer logic to utilize DMA when enabled
- Ensure proper cache management during DMA operations

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Signed-off-by: ht.lin <ht.lin@mediatek.com>
Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Obviously, I didn't write this patch, but I did review and test it.
On MT8365 EVK, reading a 32MiB partition from the eMMC increased from
~16MiB/s to ~46MiB/s. And I did a crc32 on the data read to ensure it
was the same as before.
---
 drivers/mmc/mtk-sd.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index d434363508c..4928a880038 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -7,6 +7,7 @@
  */
 
 #include <clk.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <mmc.h>
 #include <errno.h>
@@ -14,6 +15,7 @@
 #include <mapmem.h>
 #include <stdbool.h>
 #include <asm/gpio.h>
+#include <asm/types.h>
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <linux/bitfield.h>
@@ -56,6 +58,8 @@
 #define MSDC_INT_XFER_COMPL		BIT(12)
 #define MSDC_INT_DATTMO			BIT(14)
 #define MSDC_INT_DATCRCERR		BIT(15)
+#define MSDC_INT_BDCSERR		BIT(17)
+#define MSDC_INT_GPDCSERR		BIT(18)
 
 /* MSDC_FIFOCS */
 #define MSDC_FIFOCS_CLR			BIT(31)
@@ -83,6 +87,16 @@
 /* SDC_ADV_CFG0 */
 #define SDC_RX_ENHANCE_EN		BIT(20)
 
+/* MSDC_DMA_CTRL */
+#define MSDC_DMA_CTRL_BURSTSZ		GENMASK(14, 12)
+#define MSDC_DMA_CTRL_LASTBUF		BIT(10)
+#define MSDC_DMA_CTRL_MODE		BIT(8)
+#define MSDC_DMA_CTRL_STOP		BIT(1)
+#define MSDC_DMA_CTRL_START		BIT(0)
+
+/* DMA_CFG */
+#define MSDC_DMA_CFG_STS		BIT(0)
+
 /* PATCH_BIT0 */
 #define MSDC_INT_DAT_LATCH_CK_SEL	GENMASK(9, 7)
 
@@ -195,7 +209,8 @@
 	(MSDC_INT_CMDRDY | MSDC_INT_RSPCRCERR | MSDC_INT_CMDTMO)
 
 #define DATA_INTS_MASK	\
-	(MSDC_INT_XFER_COMPL | MSDC_INT_DATTMO | MSDC_INT_DATCRCERR)
+	(MSDC_INT_XFER_COMPL | MSDC_INT_DATTMO | MSDC_INT_DATCRCERR | \
+	MSDC_INT_BDCSERR | MSDC_INT_GPDCSERR)
 
 /* Register offset */
 struct mtk_sd_regs {
@@ -294,6 +309,7 @@ struct msdc_compatible {
 	bool builtin_pad_ctrl;
 	bool default_pad_dly;
 	bool use_internal_cd;
+	bool use_dma_mode;
 };
 
 struct msdc_delay_phase {
@@ -502,6 +518,9 @@ static int msdc_cmd_done(struct msdc_host *host, int events,
 			ret = -EIO;
 	}
 
+	/* Clear CMD interrupt */
+	writel(events & CMD_INTS_MASK, &host->base->msdc_int);
+
 	return ret;
 }
 
@@ -549,10 +568,9 @@ static int msdc_start_command(struct msdc_host *host, struct mmc_cmd *cmd,
 	    FIELD_GET(MSDC_FIFOCS_RXCNT, readl(&host->base->msdc_fifocs))) {
 		pr_err("TX/RX FIFO non-empty before start of IO. Reset\n");
 		msdc_reset_hw(host);
+		msdc_fifo_clr(host);
 	}
 
-	msdc_fifo_clr(host);
-
 	host->last_resp_type = cmd->resp_type;
 	host->last_data_write = 0;
 
@@ -561,8 +579,6 @@ static int msdc_start_command(struct msdc_host *host, struct mmc_cmd *cmd,
 	if (data)
 		blocks = data->blocks;
 
-	writel(CMD_INTS_MASK, &host->base->msdc_int);
-	writel(DATA_INTS_MASK, &host->base->msdc_int);
 	writel(blocks, &host->base->sdc_blk_num);
 	writel(cmd->cmdarg, &host->base->sdc_arg);
 	writel(rawcmd, &host->base->sdc_cmd);
@@ -704,14 +720,11 @@ static int msdc_pio_write(struct msdc_host *host, const u8 *ptr, u32 size)
 	return ret;
 }
 
-static int msdc_start_data(struct msdc_host *host, struct mmc_data *data)
+static int msdc_pio_transfer(struct msdc_host *host, struct mmc_data *data)
 {
 	u32 size;
 	int ret;
 
-	if (data->flags == MMC_DATA_WRITE)
-		host->last_data_write = 1;
-
 	size = data->blocks * data->blocksize;
 
 	if (data->flags == MMC_DATA_WRITE)
@@ -719,6 +732,124 @@ static int msdc_start_data(struct msdc_host *host, struct mmc_data *data)
 	else
 		ret = msdc_pio_read(host, (u8 *)data->dest, size);
 
+	return ret;
+}
+
+static dma_addr_t msdc_flush_membuf(const void *ptr, size_t size, enum dma_data_direction dir)
+{
+	dma_addr_t addr = (dma_addr_t)ptr;
+
+	if (dir == DMA_FROM_DEVICE)
+		invalidate_dcache_range(addr, addr + size);
+	else
+		flush_dcache_range(addr, addr + size);
+
+	return addr;
+}
+
+static void msdc_dma_start(struct msdc_host *host, dma_addr_t addr, u32 size)
+{
+	writel((u32)addr, &host->base->dma_sa);
+	clrsetbits_le32(&host->base->dma_ctrl, MSDC_DMA_CTRL_BURSTSZ,
+			FIELD_PREP(MSDC_DMA_CTRL_BURSTSZ, 6));
+
+	/* BASIC_DMA mode */
+	clrbits_le32(&host->base->dma_ctrl, MSDC_DMA_CTRL_MODE);
+
+	/* This is the last buffer */
+	setbits_le32(&host->base->dma_ctrl, MSDC_DMA_CTRL_LASTBUF);
+
+	/* Total transfer size */
+	writel(size, &host->base->dma_length);
+
+	/* Trigger DMA start */
+	setbits_le32(&host->base->dma_ctrl, MSDC_DMA_CTRL_START);
+}
+
+static void msdc_dma_stop(struct msdc_host *host)
+{
+	u32 reg;
+
+	setbits_le32(&host->base->dma_ctrl, MSDC_DMA_CTRL_STOP);
+	readl_poll_timeout(&host->base->dma_cfg, reg,
+			   !(reg & MSDC_DMA_CFG_STS), 1000000);
+}
+
+static int msdc_dma_done(struct msdc_host *host, int events)
+{
+	int ret = 0;
+	u32 rawcmd, arg;
+
+	if (!(events & MSDC_INT_XFER_COMPL)) {
+		rawcmd = readl(&host->base->sdc_cmd);
+		arg = readl(&host->base->sdc_arg);
+
+		if (events & MSDC_INT_DATTMO)
+			ret = -ETIMEDOUT;
+		else if (events & (MSDC_INT_DATCRCERR | MSDC_INT_GPDCSERR | MSDC_INT_BDCSERR))
+			ret = -EIO;
+		else
+			ret = -EBADRQC;
+
+		pr_err("MSDC: start data failure with %d, INT(0x%x), rawcmd=0x%x, arg=0x%x\n",
+		       ret, events, rawcmd, arg);
+	}
+
+	/* Clear DAT interrupt */
+	writel(events & DATA_INTS_MASK, &host->base->msdc_int);
+
+	return ret;
+}
+
+static int msdc_dma_transfer(struct msdc_host *host, struct mmc_data *data)
+{
+	u32 size, status;
+	int ret;
+	const void *buf;
+	enum dma_data_direction dir;
+	dma_addr_t dma_addr;
+
+	size = data->blocks * data->blocksize;
+	if (data->flags == MMC_DATA_WRITE) {
+		buf = data->src;
+		dir = DMA_TO_DEVICE;
+	} else {
+		buf = data->dest;
+		dir = DMA_FROM_DEVICE;
+	}
+
+	dma_addr = msdc_flush_membuf(buf, size, dir);
+	msdc_dma_start(host, dma_addr, size);
+
+	ret = readl_poll_timeout(&host->base->msdc_int, status,
+				 status & DATA_INTS_MASK, 5000000);
+	if (ret)
+		status = MSDC_INT_DATTMO;
+
+	msdc_dma_stop(host);
+
+	/*
+	 * Need invalidate the dcache again to avoid any
+	 * cache-refill during the DMA operations (pre-fetching)
+	 */
+	if (data->flags & MMC_DATA_READ)
+		invalidate_dcache_range(dma_addr, dma_addr + size);
+
+	return msdc_dma_done(host, status);
+}
+
+static int msdc_start_data(struct msdc_host *host, struct mmc_data *data)
+{
+	int ret;
+
+	if (data->flags == MMC_DATA_WRITE)
+		host->last_data_write = 1;
+
+	if (host->dev_comp->use_dma_mode)
+		ret = msdc_dma_transfer(host, data);
+	else
+		ret = msdc_pio_transfer(host, data);
+
 	if (ret) {
 		msdc_reset_hw(host);
 		msdc_fifo_clr(host);
@@ -1174,12 +1305,14 @@ skip_fall:
 	if (final_maxlen == final_rise_delay.maxlen) {
 		clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
 		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
-				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, final_rise_delay.final_phase));
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY,
+					   final_rise_delay.final_phase));
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		setbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
 		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
-				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, final_fall_delay.final_phase));
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY,
+					   final_fall_delay.final_phase));
 		final_delay = final_fall_delay.final_phase;
 	}
 
@@ -1425,8 +1558,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	/* Configure to MMC/SD mode, clock free running */
 	setbits_le32(&host->base->msdc_cfg, MSDC_CFG_MODE);
 
-	/* Use PIO mode */
-	setbits_le32(&host->base->msdc_cfg, MSDC_CFG_PIO);
+	/* Data transfer mode */
+	if (host->dev_comp->use_dma_mode)
+		clrbits_le32(&host->base->msdc_cfg, MSDC_CFG_PIO);
+	else
+		setbits_le32(&host->base->msdc_cfg, MSDC_CFG_PIO);
 
 	/* Reset */
 	msdc_reset_hw(host);
@@ -1839,6 +1975,8 @@ static const struct msdc_compatible mt8183_compat = {
 	.data_tune = true,
 	.busy_check = true,
 	.stop_clk_fix = true,
+	.enhance_rx = true,
+	.use_dma_mode = true,
 };
 
 static const struct udevice_id msdc_ids[] = {

-- 
2.43.0

