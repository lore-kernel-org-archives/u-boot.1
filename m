Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4577C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0146F88204;
	Sun, 21 Jul 2024 17:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ho2CMAXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A04987E64; Sun, 21 Jul 2024 17:26:43 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787CA87ED1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42795086628so24359205e9.3
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575601; x=1722180401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lns/UqDX1K5bbUTG26jpHzv+qnqQwuqr/Fp80TrhaY=;
 b=Ho2CMAXVzaLQzBOsC+aLUwqRxjtVfW9ZhVqXHyjgAq1xP4AGNn9WIoi696A36rdrD8
 apMu3lQyY7v0iENJRq32D94PMwbBAYbA9wcnmiIYYc6GwqLUj4d85qCVW8KXoOPn4sLD
 EAIizx8z0geOR7RyRFPEiZV6q5askl1Yg8J0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575601; x=1722180401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lns/UqDX1K5bbUTG26jpHzv+qnqQwuqr/Fp80TrhaY=;
 b=fd8DcP+i1NHzO9QuYUL3P83HFOX8sZlvei4qp/VDCJ/e9ZIGaS3Awf7TdBM4tADpCG
 yveUD/lXZ52GkpXHdwVsSQIizfV0U7vtY39M8SZUXOtHd39R24BXNLgysNorvHm8507J
 Xx0/PI0dewLolS4g9lBxQA/iTEY13kk5t+LHD+OEK9SD5ElSe7n6J6r1n6mcLvL6mnDT
 my6n3StWl2YcTiw0kUQ6PEVIsX469CSOR2qylCkUt4R3rtW6LfBzupUlmVMKbLzHfFrY
 rxABW2r3fKk+NktDStXk/HTZcez+VHnvtEfc45QKLXtd6bKNKDHDtuTGegh3ow7ACci0
 tGcA==
X-Gm-Message-State: AOJu0Yym6Y5IpOdMCBwB7ZxU/vBOM9DnDsL4DTDThEPloKDcMlzf3wN8
 hOZeqsnOD1oYhEYU/PUwQtBw+m0r17n4jLf+kRNt1iSwgsrsvDMNtZfXrtRLZumcVYNxJczw5EI
 =
X-Google-Smtp-Source: AGHT+IECGyT/91OPbGGYLiFmn3fdWJeutXxOirtrLFETmiDQqPs5Q/MvbYewydINpwUgixMxucxQsQ==
X-Received: by 2002:a05:600c:1c8b:b0:426:54c9:dfed with SMTP id
 5b1f17b1804b1-427dc57654bmr25609395e9.28.1721575600762; 
 Sun, 21 Jul 2024 08:26:40 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 05/14] mmc: Use logging instead of printf()
Date: Sun, 21 Jul 2024 16:25:50 +0100
Message-Id: <20240721152600.3212917-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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

The code makes quite a few uses of __func__ which puts the function
name into the resulting SPL image. Use the log subsystem instead, to
reduce size.

The CONFIG_LOGF_FUNC option can be used to enable the function name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Various updates to log messages
- Drop an unnecessary cast

 drivers/mmc/sdhci.c | 46 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 560b7e889c7..eb5a144f8d4 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
 		if (timeout == 0) {
-			printf("%s: Reset 0x%x never completed.\n",
-			       __func__, (int)mask);
+			log_warning("Reset %x never completed\n", mask);
 			return;
 		}
 		timeout--;
@@ -139,8 +138,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
 	do {
 		stat = sdhci_readl(host, SDHCI_INT_STATUS);
 		if (stat & SDHCI_INT_ERROR) {
-			pr_debug("%s: Error detected in status(0x%X)!\n",
-				 __func__, stat);
+			log_debug("Error detected in status(%x)!\n", stat);
 			return -EIO;
 		}
 		if (!transfer_done && (stat & rdy)) {
@@ -173,7 +171,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
 		if (timeout-- > 0)
 			udelay(10);
 		else {
-			printf("%s: Transfer data timeout\n", __func__);
+			log_err("Transfer data timeout\n");
 			return -ETIMEDOUT;
 		}
 	} while (!(stat & SDHCI_INT_DATA_END));
@@ -232,7 +230,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
 		if (time >= cmd_timeout) {
-			printf("%s: MMC: %d busy ", __func__, mmc_dev);
+			log_warning("mmc%d busy ", mmc_dev);
 			if (2 * cmd_timeout <= SDHCI_CMD_MAX_TIMEOUT) {
 				cmd_timeout += cmd_timeout;
 				printf("timeout increasing to: %u ms.\n",
@@ -316,8 +314,8 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 		}
 
 		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
-			printf("%s: Timeout for status update: %08x %08x\n",
-			       __func__, stat, mask);
+			log_warning("Timeout for status update: %08x %08x\n",
+				    stat, mask);
 			return -ETIMEDOUT;
 		}
 	} while ((stat & mask) != mask);
@@ -358,7 +356,7 @@ static int sdhci_execute_tuning(struct udevice *dev, uint opcode)
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
 	struct sdhci_host *host = mmc->priv;
 
-	debug("%s\n", __func__);
+	log_debug("sdhci tuning\n");
 
 	if (host->ops && host->ops->platform_execute_tuning) {
 		err = host->ops->platform_execute_tuning(mmc, opcode);
@@ -380,8 +378,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) &
 			   (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
 		if (timeout == 0) {
-			printf("%s: Timeout to wait cmd & data inhibit\n",
-			       __func__);
+			log_err("Timeout waiting for cmd & data inhibit\n");
 			return -EBUSY;
 		}
 
@@ -397,7 +394,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
 	if (host->ops && host->ops->set_delay) {
 		ret = host->ops->set_delay(host);
 		if (ret) {
-			printf("%s: Error while setting tap delay\n", __func__);
+			log_err("Error while setting tap delay\n");
 			return ret;
 		}
 	}
@@ -405,7 +402,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
 	if (host->ops && host->ops->config_dll) {
 		ret = host->ops->config_dll(host, clock, false);
 		if (ret) {
-			printf("%s: Error while configuring dll\n", __func__);
+			log_err("Error configuring dll\n");
 			return ret;
 		}
 	}
@@ -456,7 +453,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
 	if (host->ops && host->ops->config_dll) {
 		ret = host->ops->config_dll(host, clock, true);
 		if (ret) {
-			printf("%s: Error while configuring dll\n", __func__);
+			log_err("Error enabling dll\n");
 			return ret;
 		}
 	}
@@ -472,8 +469,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
-			printf("%s: Internal clock never stabilised.\n",
-			       __func__);
+			log_err("Internal clock never stabilised.\n");
 			return -EBUSY;
 		}
 		timeout--;
@@ -738,8 +734,7 @@ static int sdhci_init(struct mmc *mmc)
 	if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) {
 		host->align_buffer = memalign(8, 512 * 1024);
 		if (!host->align_buffer) {
-			printf("%s: Aligned buffer alloc failed!!!\n",
-			       __func__);
+			log_err("Aligned buffer alloc failed\n");
 			return -ENOMEM;
 		}
 	}
@@ -881,20 +876,18 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
 #else
 	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
 #endif
-	debug("%s, caps: 0x%x\n", __func__, caps);
+	log_debug("caps: 0x%x\n", caps);
 
 #if CONFIG_IS_ENABLED(MMC_SDHCI_SDMA)
 	if ((caps & SDHCI_CAN_DO_SDMA)) {
 		host->flags |= USE_SDMA;
 	} else {
-		debug("%s: Your controller doesn't support SDMA!!\n",
-		      __func__);
+		log_debug("Controller doesn't support SDMA\n");
 	}
 #endif
 #if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
 	if (!(caps & SDHCI_CAN_DO_ADMA2)) {
-		printf("%s: Your controller doesn't support ADMA!!\n",
-		       __func__);
+		log_err("Controller doesn't support ADMA\n");
 		return -EINVAL;
 	}
 	if (!host->adma_desc_table) {
@@ -927,7 +920,7 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
 #else
 		caps_1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 #endif
-		debug("%s, caps_1: 0x%x\n", __func__, caps_1);
+		log_debug("caps_1: %x\n", caps_1);
 		host->clk_mul = (caps_1 & SDHCI_CLOCK_MUL_MASK) >>
 				SDHCI_CLOCK_MUL_SHIFT;
 
@@ -953,8 +946,7 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
 			host->max_clk *= host->clk_mul;
 	}
 	if (host->max_clk == 0) {
-		printf("%s: Hardware doesn't specify base clock frequency\n",
-		       __func__);
+		log_err("Hardware doesn't specify base clock frequency\n");
 		return -EINVAL;
 	}
 	if (f_max && (f_max < host->max_clk))
@@ -1047,7 +1039,7 @@ int add_sdhci(struct sdhci_host *host, u32 f_max, u32 f_min)
 
 	host->mmc = mmc_create(&host->cfg, host);
 	if (host->mmc == NULL) {
-		printf("%s: mmc create fail!\n", __func__);
+		log_err("mmc create fail\n");
 		return -ENOMEM;
 	}
 
-- 
2.34.1

