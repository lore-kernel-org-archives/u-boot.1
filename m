Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2E5C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4327488570;
	Thu, 25 Jul 2024 22:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sxqNRlGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C1A88585; Thu, 25 Jul 2024 22:45:36 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B10883BB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-261112c303bso418176fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940331; x=1722545131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIHOBfSnlWIxNFku9QoIOH1bwkOR7KLwevCNk0BvPNw=;
 b=sxqNRlGqaikriX9bTryGIz7tck1UVR0XHRcMgXRwM3/bBjg+D+8+65E/rTV9U7BlQb
 W7mA8Njv20y7/ahXQOCxy0WTi7ORqtAhRTNjSYuKQ7kIvtC9YiYJxsA0jWQoaefvTbfs
 Mec+YQ0oLtvq9NLxa9VwqADqe11JHH/dpwJYgupRwTPwVPjYIe0g1M8NX38nmTmjWaep
 PttIqte9GHApNPkDvyJATDRbF2UOA+g8XghQAbcNraJPz/VP3Cmg6aFBgVzyhCasdNFs
 NGOAPxq4zBNII6/P5DBKDrLZcI0qPJ6IS8o7h+pZzm+b4BGTbTz6eutc6UfjB7KHGKwt
 TVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940331; x=1722545131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIHOBfSnlWIxNFku9QoIOH1bwkOR7KLwevCNk0BvPNw=;
 b=XUBBcMpwMBv1L5hvGCjhdVcR9xf/4Ha2TsU4UXtMtZKkSu+vj174VpPRnxYZtKYHa/
 EGVmztNa9f4V2RJyS2lE72SpnWR4qe0EQHMVpd0YrNzVCCk19jCaBF989k0a7y1JnpjD
 KLT0Xom4clapJvGr9+C3yEHLTMMwPLvELrPeLswpamg727nj6/xuuSLg08FUy+1vZqj3
 /rZHLmNX+GScus1+aYBziE/t0SuaFPqYrUv0H59Uv9MlYA1AgLvmr/aEWX2tn0PmxwW0
 02zVgJ28867HaB8HHDbu1AiB9xr2Ts9aq4sRjUGIah4H1MCVhExsgzdK7t9uim/opQR0
 6hXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVig2MBhHrWIp03d6+upPl9e77b0asZ0HGwAJEJxKKhtYMUOFqEbbHR1b8tuk6eqHvoK+G6fQINIJ+3p+qe3IB0sagCaQ==
X-Gm-Message-State: AOJu0Yzdy2iuk/HzGuRKeiUfh5yX6TS0HWPaCPHcG0N+Uw8eQI/e07ZE
 6UQfFNQwGN9+jcHxTge7RIb3LipM4z2YuOc8o8zDeLnIirO+3sQT8XXOoztSqr0=
X-Google-Smtp-Source: AGHT+IHyLkfS1v88w+pWAPehd62DoCpXEvEGKbdP3wkXwSD3ft7KM2/DBXvOPuomSVJ7n195DmfHZg==
X-Received: by 2002:a05:6870:d62c:b0:25e:1cdf:c604 with SMTP id
 586e51a60fabf-266edde0cd1mr3978094fac.31.1721940331017; 
 Thu, 25 Jul 2024 13:45:31 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093050a055sm453325a34.2.2024.07.25.13.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:30 -0700 (PDT)
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
Subject: [PATCH v4 13/38] mmc: dw_mmc: Improve coding style
Date: Thu, 25 Jul 2024 15:44:55 -0500
Message-Id: <20240725204520.18134-14-semen.protsenko@linaro.org>
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

Fix most of checkpatch warnings and other obvious style issues.

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

 drivers/mmc/dw_mmc.c |  68 ++++++++++----------
 include/dwmmc.h      | 149 ++++++++++++++++++++++---------------------
 2 files changed, 110 insertions(+), 107 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 47dcc37c2c7c..8551eac70185 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -125,8 +125,9 @@ static void dwmci_prepare_desc(struct dwmci_host *host, struct mmc_data *data,
 		if (blk_cnt <= 8) {
 			flags |= DWMCI_IDMAC_LD;
 			cnt = data->blocksize * blk_cnt;
-		} else
+		} else {
 			cnt = data->blocksize * 8;
+		}
 
 		if (host->dma_64bit_address) {
 			dwmci_set_idma_desc64(desc64, flags, cnt,
@@ -150,10 +151,8 @@ static void dwmci_prepare_desc(struct dwmci_host *host, struct mmc_data *data,
 	flush_dcache_range(data_start, roundup(data_end, ARCH_DMA_MINALIGN));
 }
 
-static void dwmci_prepare_data(struct dwmci_host *host,
-			       struct mmc_data *data,
-			       void *cur_idmac,
-			       void *bounce_buffer)
+static void dwmci_prepare_data(struct dwmci_host *host, struct mmc_data *data,
+			       void *cur_idmac, void *bounce_buffer)
 {
 	const u32 idmacl = virt_to_phys(cur_idmac) & 0xffffffff;
 	const u32 idmacu = (u64)virt_to_phys(cur_idmac) >> 32;
@@ -277,7 +276,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 
 	for (;;) {
 		mask = dwmci_readl(host, DWMCI_RINTSTS);
-		/* Error during data transfer. */
+		/* Error during data transfer */
 		if (mask & (DWMCI_DATA_ERR | DWMCI_DATA_TOUT)) {
 			debug("%s: DATA ERROR!\n", __func__);
 			ret = -EINVAL;
@@ -286,16 +285,15 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 
 		ret = dwmci_data_transfer_fifo(host, data, mask);
 
-		/* Data arrived correctly. */
+		/* Data arrived correctly */
 		if (mask & DWMCI_INTMSK_DTO) {
 			ret = 0;
 			break;
 		}
 
-		/* Check for timeout. */
+		/* Check for timeout */
 		if (get_timer(start) > timeout) {
-			debug("%s: Timeout waiting for data!\n",
-			      __func__);
+			debug("%s: Timeout waiting for data!\n", __func__);
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -317,8 +315,8 @@ static int dwmci_dma_transfer(struct dwmci_host *host, uint flags,
 	else
 		mask = DWMCI_IDINTEN_TI;
 
-	ret = wait_for_bit_le32(host->ioaddr + host->regs->idsts,
-				mask, true, 1000, false);
+	ret = wait_for_bit_le32(host->ioaddr + host->regs->idsts, mask, true,
+				1000, false);
 	if (ret)
 		debug("%s: DWMCI_IDINTEN mask 0x%x timeout\n", __func__, mask);
 
@@ -334,7 +332,7 @@ static int dwmci_dma_transfer(struct dwmci_host *host, uint flags,
 }
 
 static int dwmci_set_transfer_mode(struct dwmci_host *host,
-		struct mmc_data *data)
+				   struct mmc_data *data)
 {
 	unsigned long mode;
 
@@ -380,12 +378,12 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 		} else {
 			if (data->flags == MMC_DATA_READ) {
 				ret = bounce_buffer_start(&bbstate,
-						(void*)data->dest,
+						(void *)data->dest,
 						data->blocksize *
 						data->blocks, GEN_BB_WRITE);
 			} else {
 				ret = bounce_buffer_start(&bbstate,
-						(void*)data->src,
+						(void *)data->src,
 						data->blocksize *
 						data->blocks, GEN_BB_READ);
 			}
@@ -420,9 +418,9 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 	if (cmd->resp_type & MMC_RSP_CRC)
 		flags |= DWMCI_CMD_CHECK_CRC;
 
-	flags |= (cmd->cmdidx | DWMCI_CMD_START | DWMCI_CMD_USE_HOLD_REG);
+	flags |= cmd->cmdidx | DWMCI_CMD_START | DWMCI_CMD_USE_HOLD_REG;
 
-	debug("Sending CMD%d\n",cmd->cmdidx);
+	debug("Sending CMD%d\n", cmd->cmdidx);
 
 	dwmci_writel(host, DWMCI_CMD, flags);
 
@@ -436,7 +434,7 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 	}
 
 	if (i == retry) {
-		debug("%s: Timeout.\n", __func__);
+		debug("%s: Timeout\n", __func__);
 		return -ETIMEDOUT;
 	}
 
@@ -449,14 +447,14 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 		 * below shall be debug(). eMMC cards also do not favor
 		 * CMD8, please keep that in mind.
 		 */
-		debug("%s: Response Timeout.\n", __func__);
+		debug("%s: Response Timeout\n", __func__);
 		return -ETIMEDOUT;
 	} else if (mask & DWMCI_INTMSK_RE) {
-		debug("%s: Response Error.\n", __func__);
+		debug("%s: Response Error\n", __func__);
 		return -EIO;
 	} else if ((cmd->resp_type & MMC_RSP_CRC) &&
 		   (mask & DWMCI_INTMSK_RCRC)) {
-		debug("%s: Response CRC Error.\n", __func__);
+		debug("%s: Response CRC Error\n", __func__);
 		return -EIO;
 	}
 
@@ -555,24 +553,24 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 	unsigned long sclk;
 	int ret;
 
-	if ((freq == host->clock) || (freq == 0))
+	if (freq == host->clock || freq == 0)
 		return 0;
+
 	/*
-	 * If host->get_mmc_clk isn't defined,
-	 * then assume that host->bus_hz is source clock value.
-	 * host->bus_hz should be set by user.
+	 * If host->get_mmc_clk isn't defined, then assume that host->bus_hz is
+	 * source clock value. host->bus_hz should be set by user.
 	 */
-	if (host->get_mmc_clk)
+	if (host->get_mmc_clk) {
 		sclk = host->get_mmc_clk(host, freq);
-	else if (host->bus_hz)
+	} else if (host->bus_hz) {
 		sclk = host->bus_hz;
-	else {
-		debug("%s: Didn't get source clock value.\n", __func__);
+	} else {
+		debug("%s: Didn't get source clock value\n", __func__);
 		return -EINVAL;
 	}
 
 	if (sclk == freq)
-		div = 0;	/* bypass mode */
+		div = 0; /* bypass mode */
 	else
 		div = DIV_ROUND_UP(sclk, 2 * freq);
 
@@ -596,7 +594,7 @@ static int dwmci_set_ios(struct mmc *mmc)
 	struct dwmci_host *host = (struct dwmci_host *)mmc->priv;
 	u32 ctype, regs;
 
-	debug("Buswidth = %d, clock: %d\n", mmc->bus_width, mmc->clock);
+	debug("Bus width = %d, clock: %d\n", mmc->bus_width, mmc->clock);
 
 	dwmci_setup_bus(host, mmc->clock);
 	switch (mmc->bus_width) {
@@ -710,10 +708,10 @@ static int dwmci_init(struct mmc *mmc)
 	/* Enumerate at 400KHz */
 	dwmci_setup_bus(host, mmc->cfg->f_min);
 
-	dwmci_writel(host, DWMCI_RINTSTS, 0xFFFFFFFF);
+	dwmci_writel(host, DWMCI_RINTSTS, 0xffffffff);
 	dwmci_writel(host, DWMCI_INTMASK, 0);
 
-	dwmci_writel(host, DWMCI_TMOUT, 0xFFFFFFFF);
+	dwmci_writel(host, DWMCI_TMOUT, 0xffffffff);
 
 	dwmci_writel(host, DWMCI_BMOD, 1);
 	dwmci_init_fifo(host);
@@ -747,7 +745,7 @@ static const struct mmc_ops dwmci_ops = {
 #endif
 
 void dwmci_setup_cfg(struct mmc_config *cfg, struct dwmci_host *host,
-		u32 max_clk, u32 min_clk)
+		     u32 max_clk, u32 min_clk)
 {
 	cfg->name = host->name;
 #ifndef CONFIG_DM_MMC
@@ -783,7 +781,7 @@ int add_dwmci(struct dwmci_host *host, u32 max_clk, u32 min_clk)
 	dwmci_setup_cfg(&host->cfg, host, max_clk, min_clk);
 
 	host->mmc = mmc_create(&host->cfg, host);
-	if (host->mmc == NULL)
+	if (!host->mmc)
 		return -1;
 
 	return 0;
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 77c8989148a1..a99b2f3bf0cc 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -15,31 +15,31 @@
 #define DWMCI_CTRL		0x000
 #define	DWMCI_PWREN		0x004
 #define DWMCI_CLKDIV		0x008
-#define DWMCI_CLKSRC		0x00C
+#define DWMCI_CLKSRC		0x00c
 #define DWMCI_CLKENA		0x010
 #define DWMCI_TMOUT		0x014
 #define DWMCI_CTYPE		0x018
-#define DWMCI_BLKSIZ		0x01C
+#define DWMCI_BLKSIZ		0x01c
 #define DWMCI_BYTCNT		0x020
 #define DWMCI_INTMASK		0x024
 #define DWMCI_CMDARG		0x028
-#define DWMCI_CMD		0x02C
+#define DWMCI_CMD		0x02c
 #define DWMCI_RESP0		0x030
 #define DWMCI_RESP1		0x034
 #define DWMCI_RESP2		0x038
-#define DWMCI_RESP3		0x03C
+#define DWMCI_RESP3		0x03c
 #define DWMCI_MINTSTS		0x040
 #define DWMCI_RINTSTS		0x044
 #define DWMCI_STATUS		0x048
-#define DWMCI_FIFOTH		0x04C
+#define DWMCI_FIFOTH		0x04c
 #define DWMCI_CDETECT		0x050
 #define DWMCI_WRTPRT		0x054
 #define DWMCI_GPIO		0x058
-#define DWMCI_TCMCNT		0x05C
+#define DWMCI_TCMCNT		0x05c
 #define DWMCI_TBBCNT		0x060
 #define DWMCI_DEBNCE		0x064
 #define DWMCI_USRID		0x068
-#define DWMCI_VERID		0x06C
+#define DWMCI_VERID		0x06c
 #define DWMCI_HCON		0x070
 #define DWMCI_UHS_REG		0x074
 #define DWMCI_BMOD		0x080
@@ -47,7 +47,7 @@
 #define DWMCI_DATA		0x200
 /* Registers to support IDMAC 32-bit address mode */
 #define DWMCI_DBADDR		0x088
-#define DWMCI_IDSTS		0x08C
+#define DWMCI_IDSTS		0x08c
 #define DWMCI_IDINTEN		0x090
 #define DWMCI_DSCADDR		0x094
 #define DWMCI_BUFADDR		0x098
@@ -63,94 +63,94 @@
 
 /* Interrupt Mask register */
 #define DWMCI_INTMSK_ALL	0xffffffff
-#define DWMCI_INTMSK_RE		(1 << 1)
-#define DWMCI_INTMSK_CDONE	(1 << 2)
-#define DWMCI_INTMSK_DTO	(1 << 3)
-#define DWMCI_INTMSK_TXDR	(1 << 4)
-#define DWMCI_INTMSK_RXDR	(1 << 5)
-#define DWMCI_INTMSK_RCRC	(1 << 6)
-#define DWMCI_INTMSK_DCRC	(1 << 7)
-#define DWMCI_INTMSK_RTO	(1 << 8)
-#define DWMCI_INTMSK_DRTO	(1 << 9)
-#define DWMCI_INTMSK_HTO	(1 << 10)
-#define DWMCI_INTMSK_FRUN	(1 << 11)
-#define DWMCI_INTMSK_HLE	(1 << 12)
-#define DWMCI_INTMSK_SBE	(1 << 13)
-#define DWMCI_INTMSK_ACD	(1 << 14)
-#define DWMCI_INTMSK_EBE	(1 << 15)
-
-/* Raw interrupt Regsiter */
-#define DWMCI_DATA_ERR	(DWMCI_INTMSK_EBE | DWMCI_INTMSK_SBE | DWMCI_INTMSK_HLE |\
-			DWMCI_INTMSK_FRUN | DWMCI_INTMSK_EBE | DWMCI_INTMSK_DCRC)
-#define DWMCI_DATA_TOUT	(DWMCI_INTMSK_HTO | DWMCI_INTMSK_DRTO)
+#define DWMCI_INTMSK_RE		BIT(1)
+#define DWMCI_INTMSK_CDONE	BIT(2)
+#define DWMCI_INTMSK_DTO	BIT(3)
+#define DWMCI_INTMSK_TXDR	BIT(4)
+#define DWMCI_INTMSK_RXDR	BIT(5)
+#define DWMCI_INTMSK_RCRC	BIT(6)
+#define DWMCI_INTMSK_DCRC	BIT(7)
+#define DWMCI_INTMSK_RTO	BIT(8)
+#define DWMCI_INTMSK_DRTO	BIT(9)
+#define DWMCI_INTMSK_HTO	BIT(10)
+#define DWMCI_INTMSK_FRUN	BIT(11)
+#define DWMCI_INTMSK_HLE	BIT(12)
+#define DWMCI_INTMSK_SBE	BIT(13)
+#define DWMCI_INTMSK_ACD	BIT(14)
+#define DWMCI_INTMSK_EBE	BIT(15)
+
+/* Raw interrupt register */
+#define DWMCI_DATA_ERR		(DWMCI_INTMSK_EBE | DWMCI_INTMSK_SBE | \
+				 DWMCI_INTMSK_HLE | DWMCI_INTMSK_FRUN | \
+				 DWMCI_INTMSK_EBE | DWMCI_INTMSK_DCRC)
+#define DWMCI_DATA_TOUT		(DWMCI_INTMSK_HTO | DWMCI_INTMSK_DRTO)
+
 /* CTRL register */
-#define DWMCI_CTRL_RESET	(1 << 0)
-#define DWMCI_CTRL_FIFO_RESET	(1 << 1)
-#define DWMCI_CTRL_DMA_RESET	(1 << 2)
-#define DWMCI_DMA_EN		(1 << 5)
-#define DWMCI_CTRL_SEND_AS_CCSD	(1 << 10)
-#define DWMCI_IDMAC_EN		(1 << 25)
+#define DWMCI_CTRL_RESET	BIT(0)
+#define DWMCI_CTRL_FIFO_RESET	BIT(1)
+#define DWMCI_CTRL_DMA_RESET	BIT(2)
+#define DWMCI_DMA_EN		BIT(5)
+#define DWMCI_CTRL_SEND_AS_CCSD	BIT(10)
+#define DWMCI_IDMAC_EN		BIT(25)
 #define DWMCI_RESET_ALL		(DWMCI_CTRL_RESET | DWMCI_CTRL_FIFO_RESET |\
 				DWMCI_CTRL_DMA_RESET)
 
 /* CMD register */
-#define DWMCI_CMD_RESP_EXP	(1 << 6)
-#define DWMCI_CMD_RESP_LENGTH	(1 << 7)
-#define DWMCI_CMD_CHECK_CRC	(1 << 8)
-#define DWMCI_CMD_DATA_EXP	(1 << 9)
-#define DWMCI_CMD_RW		(1 << 10)
-#define DWMCI_CMD_SEND_STOP	(1 << 12)
-#define DWMCI_CMD_ABORT_STOP	(1 << 14)
-#define DWMCI_CMD_PRV_DAT_WAIT	(1 << 13)
-#define DWMCI_CMD_UPD_CLK	(1 << 21)
-#define DWMCI_CMD_USE_HOLD_REG	(1 << 29)
-#define DWMCI_CMD_START		(1 << 31)
+#define DWMCI_CMD_RESP_EXP	BIT(6)
+#define DWMCI_CMD_RESP_LENGTH	BIT(7)
+#define DWMCI_CMD_CHECK_CRC	BIT(8)
+#define DWMCI_CMD_DATA_EXP	BIT(9)
+#define DWMCI_CMD_RW		BIT(10)
+#define DWMCI_CMD_SEND_STOP	BIT(12)
+#define DWMCI_CMD_ABORT_STOP	BIT(14)
+#define DWMCI_CMD_PRV_DAT_WAIT	BIT(13)
+#define DWMCI_CMD_UPD_CLK	BIT(21)
+#define DWMCI_CMD_USE_HOLD_REG	BIT(29)
+#define DWMCI_CMD_START		BIT(31)
 
 /* CLKENA register */
-#define DWMCI_CLKEN_ENABLE	(1 << 0)
-#define DWMCI_CLKEN_LOW_PWR	(1 << 16)
+#define DWMCI_CLKEN_ENABLE	BIT(0)
+#define DWMCI_CLKEN_LOW_PWR	BIT(16)
 
-/* Card-type registe */
+/* Card type register */
 #define DWMCI_CTYPE_1BIT	0
-#define DWMCI_CTYPE_4BIT	(1 << 0)
-#define DWMCI_CTYPE_8BIT	(1 << 16)
+#define DWMCI_CTYPE_4BIT	BIT(0)
+#define DWMCI_CTYPE_8BIT	BIT(16)
 
-/* Status Register */
-#define DWMCI_FIFO_EMPTY	(1 << 2)
-#define DWMCI_FIFO_FULL		(1 << 3)
-#define DWMCI_BUSY		(1 << 9)
+/* Status register */
+#define DWMCI_FIFO_EMPTY	BIT(2)
+#define DWMCI_FIFO_FULL		BIT(3)
+#define DWMCI_BUSY		BIT(9)
 #define DWMCI_FIFO_MASK		0x1fff
 #define DWMCI_FIFO_SHIFT	17
 
-/* FIFOTH Register */
+/* FIFOTH register */
 #define MSIZE(x)		((x) << 28)
 #define RX_WMARK(x)		((x) << 16)
 #define TX_WMARK(x)		(x)
 #define RX_WMARK_SHIFT		16
 #define RX_WMARK_MASK		(0xfff << RX_WMARK_SHIFT)
 
-#define DWMCI_IDMAC_OWN		(1 << 31)
-#define DWMCI_IDMAC_CH		(1 << 4)
-#define DWMCI_IDMAC_FS		(1 << 3)
-#define DWMCI_IDMAC_LD		(1 << 2)
+#define DWMCI_IDMAC_OWN		BIT(31)
+#define DWMCI_IDMAC_CH		BIT(4)
+#define DWMCI_IDMAC_FS		BIT(3)
+#define DWMCI_IDMAC_LD		BIT(2)
 
-/*  Bus Mode Register */
-#define DWMCI_BMOD_IDMAC_RESET	(1 << 0)
-#define DWMCI_BMOD_IDMAC_FB	(1 << 1)
-#define DWMCI_BMOD_IDMAC_EN	(1 << 7)
+/* Bus Mode register */
+#define DWMCI_BMOD_IDMAC_RESET	BIT(0)
+#define DWMCI_BMOD_IDMAC_FB	BIT(1)
+#define DWMCI_BMOD_IDMAC_EN	BIT(7)
 
 /* UHS register */
-#define DWMCI_DDR_MODE	(1 << 16)
+#define DWMCI_DDR_MODE		BIT(16)
 
 /* Internal IDMAC interrupt defines */
-#define DWMCI_IDINTEN_RI		BIT(1)
-#define DWMCI_IDINTEN_TI		BIT(0)
+#define DWMCI_IDINTEN_RI	BIT(1)
+#define DWMCI_IDINTEN_TI	BIT(0)
+#define DWMCI_IDINTEN_MASK	(DWMCI_IDINTEN_TI | DWMCI_IDINTEN_RI)
 
-#define DWMCI_IDINTEN_MASK	(DWMCI_IDINTEN_TI | \
-				 DWMCI_IDINTEN_RI)
-
-/* quirks */
-#define DWMCI_QUIRK_DISABLE_SMU		(1 << 0)
+/* Quirks */
+#define DWMCI_QUIRK_DISABLE_SMU	BIT(0)
 
 /**
  * struct dwmci_idmac_regs - Offsets of IDMAC registers
@@ -230,6 +230,7 @@ struct dwmci_host {
 	 * return that value too. Then DWMMC will put itself in bypass mode.
 	 */
 	unsigned int (*get_mmc_clk)(struct dwmci_host *host, uint freq);
+
 #ifndef CONFIG_BLK
 	struct mmc_config cfg;
 #endif
@@ -253,6 +254,7 @@ static inline void dwmci_writeb(struct dwmci_host *host, int reg, u8 val)
 {
 	writeb(val, host->ioaddr + reg);
 }
+
 static inline u32 dwmci_readl(struct dwmci_host *host, int reg)
 {
 	return readl(host->ioaddr + reg);
@@ -269,6 +271,7 @@ static inline u8 dwmci_readb(struct dwmci_host *host, int reg)
 }
 
 #ifdef CONFIG_BLK
+
 /**
  * dwmci_setup_cfg() - Set up the configuration for DWMMC
  * @cfg:	Configuration structure to fill in (generally &plat->mmc)
@@ -301,7 +304,7 @@ static inline u8 dwmci_readb(struct dwmci_host *host, int reg)
  * See rockchip_dw_mmc.c for an example.
  */
 void dwmci_setup_cfg(struct mmc_config *cfg, struct dwmci_host *host,
-		u32 max_clk, u32 min_clk);
+		     u32 max_clk, u32 min_clk);
 
 /**
  * dwmci_bind() - Set up a new MMC block device
@@ -321,6 +324,7 @@ void dwmci_setup_cfg(struct mmc_config *cfg, struct dwmci_host *host,
 int dwmci_bind(struct udevice *dev, struct mmc *mmc, struct mmc_config *cfg);
 
 #else
+
 /**
  * add_dwmci() - Add a new DWMMC interface
  * @host:	DWMMC host structure
@@ -332,6 +336,7 @@ int dwmci_bind(struct udevice *dev, struct mmc *mmc, struct mmc_config *cfg);
  * Return: 0 if OK, -ve on error
  */
 int add_dwmci(struct dwmci_host *host, u32 max_clk, u32 min_clk);
+
 #endif /* !CONFIG_BLK */
 
 #ifdef CONFIG_DM_MMC
-- 
2.39.2

