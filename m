Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C9C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529BF87F7B;
	Tue, 20 Feb 2024 09:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="J9wPmO4+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ac6yyduI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C3A87F91; Tue, 20 Feb 2024 09:37:07 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F74D87F6F
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TfCSY1pPFz9scM;
 Tue, 20 Feb 2024 09:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ROZFzPAp8KPzLvgn1oS93NDGdsKYU/PalnelHuWOmOE=;
 b=J9wPmO4+C1b2ljm+ePyBnUwbFRo7pepubfiuVqAiuZyOmTGP71GP7gNWudPpTzvqyyuRY5
 kORFHFaMmrJzNrNpsNNLZUieq9qXR5t9hEo+qXO8dGq6eQb1LufzHGmr7yxIYPJ0drvsqB
 tD+82MEAbZnoqrtme4fnHfKiVLmZSb9CdKUhpzFJVvUgD7YJfLVsDK4UewWo7N50am0Tda
 VuXCAiX81YmwsRh+pX3KnazTgDhcz7Hj5hfXsZohOz8q90MJJTKrg/iF6RQp4TolfEqUA2
 W1GKLfBfQA8M0+4uKOJc0NXpYRDPCxmTyNGRhAwv6YxnDuZc2j1zMQ0dqOX3NA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ROZFzPAp8KPzLvgn1oS93NDGdsKYU/PalnelHuWOmOE=;
 b=Ac6yyduIzg1VTaVgDbD0FtYF2+2N5MAD0mES71VuMEzJFgJvOsU3UQ7x81D/nfcfUUaFeE
 hZhnSd0i3AfyymsrDhxk7LkQy3ucgHGwIslDk2uW/oruQGjwZ9jcEJTCCFWn8qR9HyclSB
 66h/IBIxLAaF3bg3GAb3Ozi6HQfsEkwUdMaXBMoMmFIIGsYpPxwl8xKEHwPYUAN+x84RIN
 X2qsfPCnXdR+Fuiioz7s2vb+0vdK12p7Nbg4NC79jGca+YMpTUFIoCzyQOn3JJezDAUqE+
 r3EeHxwhwK7UBJcfSUHxzDY1T7KlHX7XGkjHFBz4yFiF7Q9czoWj24COS5fGnw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] mmc: Drop unused mmc_send_tuning() cmd_error parameter
Date: Tue, 20 Feb 2024 09:36:23 +0100
Message-ID: <20240220083642.34389-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a6d956c761978a46ade
X-MBO-RS-META: cswsfd7ydhd95ursafbz9idokbgy1xgb
X-Rspamd-Queue-Id: 4TfCSY1pPFz9scM
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

The cmd_error parameter is not used, remove it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/am654_sdhci.c    |  2 +-
 drivers/mmc/fsl_esdhc.c      |  2 +-
 drivers/mmc/fsl_esdhc_imx.c  |  2 +-
 drivers/mmc/mmc.c            |  2 +-
 drivers/mmc/mtk-sd.c         | 21 ++++++++++-----------
 drivers/mmc/octeontx_hsmmc.c |  8 +++++++-
 drivers/mmc/omap_hsmmc.c     |  6 +++---
 drivers/mmc/renesas-sdhi.c   |  2 +-
 drivers/mmc/sdhci-cadence.c  |  2 +-
 include/mmc.h                |  2 +-
 10 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 05595bdac39..2139fea04d5 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -390,7 +390,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	for (itap = 0; itap < ITAP_MAX; itap++) {
 		am654_sdhci_write_itapdly(plat, itap);
 
-		cur_val = !mmc_send_tuning(mmc, opcode, NULL);
+		cur_val = !mmc_send_tuning(mmc, opcode);
 		if (cur_val && !prev_val)
 			pass_window = itap;
 
diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
index d5066666698..d44dfa5d06f 100644
--- a/drivers/mmc/fsl_esdhc.c
+++ b/drivers/mmc/fsl_esdhc.c
@@ -1123,7 +1123,7 @@ static int fsl_esdhc_execute_tuning(struct udevice *dev, uint32_t opcode)
 	esdhc_write32(&regs->irqstaten, IRQSTATEN_BRR);
 
 	for (i = 0; i < MAX_TUNING_LOOP; i++) {
-		mmc_send_tuning(mmc, opcode, NULL);
+		mmc_send_tuning(mmc, opcode);
 		mdelay(1);
 
 		val = esdhc_read32(&regs->autoc12err);
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 7c39c86c5e9..b74c0140020 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -882,7 +882,7 @@ static int fsl_esdhc_execute_tuning(struct udevice *dev, uint32_t opcode)
 		esdhc_write32(&regs->mixctrl, val);
 
 		/* We are using STD tuning, no need to check return value */
-		mmc_send_tuning(mmc, opcode, NULL);
+		mmc_send_tuning(mmc, opcode);
 
 		ctrl = esdhc_read32(&regs->autoc12err);
 		if ((!(ctrl & MIX_CTRL_EXE_TUNE)) &&
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index d96db7a0f83..83f9ae8bb7d 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -360,7 +360,7 @@ static const u8 tuning_blk_pattern_8bit[] = {
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
-int mmc_send_tuning(struct mmc *mmc, u32 opcode, int *cmd_error)
+int mmc_send_tuning(struct mmc *mmc, u32 opcode)
 {
 	struct mmc_cmd cmd;
 	struct mmc_data data;
diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 5a0c61daed5..296aaee7331 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1131,7 +1131,7 @@ static int hs400_tune_response(struct udevice *dev, u32 opcode)
 				i << PAD_CMD_TUNE_RX_DLY3_S);
 
 		for (j = 0; j < 3; j++) {
-			mmc_send_tuning(mmc, opcode, &cmd_err);
+			cmd_err = mmc_send_tuning(mmc, opcode);
 			if (!cmd_err) {
 				cmd_delay |= (1 << i);
 			} else {
@@ -1181,7 +1181,7 @@ static int msdc_tune_response(struct udevice *dev, u32 opcode)
 				i << MSDC_PAD_TUNE_CMDRDLY_S);
 
 		for (j = 0; j < 3; j++) {
-			mmc_send_tuning(mmc, opcode, &cmd_err);
+			cmd_err = mmc_send_tuning(mmc, opcode);
 			if (!cmd_err) {
 				rise_delay |= (1 << i);
 			} else {
@@ -1203,7 +1203,7 @@ static int msdc_tune_response(struct udevice *dev, u32 opcode)
 				i << MSDC_PAD_TUNE_CMDRDLY_S);
 
 		for (j = 0; j < 3; j++) {
-			mmc_send_tuning(mmc, opcode, &cmd_err);
+			cmd_err = mmc_send_tuning(mmc, opcode);
 			if (!cmd_err) {
 				fall_delay |= (1 << i);
 			} else {
@@ -1238,7 +1238,7 @@ skip_fall:
 		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
 				i << MSDC_PAD_TUNE_CMDRRDLY_S);
 
-		mmc_send_tuning(mmc, opcode, &cmd_err);
+		cmd_err = mmc_send_tuning(mmc, opcode);
 		if (!cmd_err)
 			internal_delay |= (1 << i);
 	}
@@ -1264,7 +1264,6 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0, };
 	u8 final_delay, final_maxlen;
 	void __iomem *tune_reg = &host->base->pad_tune;
-	int cmd_err;
 	int i, ret;
 
 	if (host->dev_comp->pad_tune0)
@@ -1277,10 +1276,10 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
 		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
 				i << MSDC_PAD_TUNE_DATRRDLY_S);
 
-		ret = mmc_send_tuning(mmc, opcode, &cmd_err);
+		ret = mmc_send_tuning(mmc, opcode);
 		if (!ret) {
 			rise_delay |= (1 << i);
-		} else if (cmd_err) {
+		} else {
 			/* in this case, retune response is needed */
 			ret = msdc_tune_response(dev, opcode);
 			if (ret)
@@ -1300,10 +1299,10 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
 		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
 				i << MSDC_PAD_TUNE_DATRRDLY_S);
 
-		ret = mmc_send_tuning(mmc, opcode, &cmd_err);
+		ret = mmc_send_tuning(mmc, opcode);
 		if (!ret) {
 			fall_delay |= (1 << i);
-		} else if (cmd_err) {
+		} else {
 			/* in this case, retune response is needed */
 			ret = msdc_tune_response(dev, opcode);
 			if (ret)
@@ -1362,7 +1361,7 @@ static int msdc_tune_together(struct udevice *dev, u32 opcode)
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
 		msdc_set_cmd_delay(host, i);
 		msdc_set_data_delay(host, i);
-		ret = mmc_send_tuning(mmc, opcode, NULL);
+		ret = mmc_send_tuning(mmc, opcode);
 		if (!ret)
 			rise_delay |= (1 << i);
 	}
@@ -1378,7 +1377,7 @@ static int msdc_tune_together(struct udevice *dev, u32 opcode)
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
 		msdc_set_cmd_delay(host, i);
 		msdc_set_data_delay(host, i);
-		ret = mmc_send_tuning(mmc, opcode, NULL);
+		ret = mmc_send_tuning(mmc, opcode);
 		if (!ret)
 			fall_delay |= (1 << i);
 	}
diff --git a/drivers/mmc/octeontx_hsmmc.c b/drivers/mmc/octeontx_hsmmc.c
index 4ee62df9d40..7f9c4f4d36d 100644
--- a/drivers/mmc/octeontx_hsmmc.c
+++ b/drivers/mmc/octeontx_hsmmc.c
@@ -1653,6 +1653,12 @@ static int octeontx_mmc_test_cmd(struct mmc *mmc, u32 opcode, int *statp)
 	return err;
 }
 
+static int octeontx_mmc_send_tuning(struct mmc *mmc, u32 opcode, int *error)
+{
+	*error = 0;
+	return mmc_send_tuning(mmc, opcode);
+}
+
 static int octeontx_mmc_test_get_ext_csd(struct mmc *mmc, u32 opcode,
 					 int *statp)
 {
@@ -2006,7 +2012,7 @@ struct adj adj[] = {
 	{ "CMD_IN", 48, octeontx_mmc_test_cmd, MMC_CMD_SEND_STATUS,
 	  false, false, false, 2, },
 /*	{ "CMD_OUT", 32, octeontx_mmc_test_cmd, MMC_CMD_SEND_STATUS, },*/
-	{ "DATA_IN(HS200)", 16, mmc_send_tuning,
+	{ "DATA_IN(HS200)", 16, octeontx_mmc_send_tuning,
 		MMC_CMD_SEND_TUNING_BLOCK_HS200, false, true, false, 2, },
 	{ "DATA_IN", 16, octeontx_mmc_test_get_ext_csd, 0, false, false,
 	  true, 2, },
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index a2595d19e7f..99f21b2c546 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -666,7 +666,7 @@ static int omap_hsmmc_execute_tuning(struct udevice *dev, uint opcode)
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		omap_hsmmc_set_dll(mmc, phase_delay);
 
-		cur_match = !mmc_send_tuning(mmc, opcode, NULL);
+		cur_match = !mmc_send_tuning(mmc, opcode);
 
 		if (cur_match) {
 			if (prev_match) {
@@ -731,7 +731,7 @@ static int omap_hsmmc_execute_tuning(struct udevice *dev, uint opcode)
 	 */
 	for (i = 3; i <= 10; i++) {
 		omap_hsmmc_set_dll(mmc, phase_delay + i);
-		if (mmc_send_tuning(mmc, opcode, NULL)) {
+		if (mmc_send_tuning(mmc, opcode)) {
 			if (temperature < 10000)
 				phase_delay += i + 6;
 			else if (temperature < 20000)
@@ -749,7 +749,7 @@ static int omap_hsmmc_execute_tuning(struct udevice *dev, uint opcode)
 
 	for (i = 2; i >= -10; i--) {
 		omap_hsmmc_set_dll(mmc, phase_delay + i);
-		if (mmc_send_tuning(mmc, opcode, NULL)) {
+		if (mmc_send_tuning(mmc, opcode)) {
 			if (temperature < 10000)
 				phase_delay += i + 12;
 			else if (temperature < 20000)
diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index a74559ca686..9770b6bb5e1 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -605,7 +605,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
 		caps = priv->caps;
 		priv->caps &= ~TMIO_SD_CAP_DMA_INTERNAL;
 
-		ret = mmc_send_tuning(mmc, opcode, NULL);
+		ret = mmc_send_tuning(mmc, opcode);
 
 		priv->caps = caps;
 
diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 327a05ad11d..c0a9f60b149 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -224,7 +224,7 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
 		if (sdhci_cdns_set_tune_val(plat, i) ||
-		    mmc_send_tuning(mmc, opcode, NULL)) { /* bad */
+		    mmc_send_tuning(mmc, opcode)) { /* bad */
 			cur_streak = 0;
 		} else { /* good */
 			cur_streak++;
diff --git a/include/mmc.h b/include/mmc.h
index 1022db3ffa7..2b9a6aa8ee0 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -795,7 +795,7 @@ int mmc_unbind(struct udevice *dev);
 int mmc_initialize(struct bd_info *bis);
 int mmc_init_device(int num);
 int mmc_init(struct mmc *mmc);
-int mmc_send_tuning(struct mmc *mmc, u32 opcode, int *cmd_error);
+int mmc_send_tuning(struct mmc *mmc, u32 opcode);
 int mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd, struct mmc_data *data);
 int mmc_deinit(struct mmc *mmc);
 
-- 
2.43.0

