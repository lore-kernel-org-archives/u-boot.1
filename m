Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228B4C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9ADA88C6D;
	Sat, 20 Jul 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fHNK/j1U";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yPs3cx5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5FF88C7D; Sat, 20 Jul 2024 14:43:51 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFDD88C4A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nd0k6Vz9sWs;
 Sat, 20 Jul 2024 14:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vo6MZo9DKhAsVssi60Ejohn2L2+fQrfRMIt3k7GeVSw=;
 b=fHNK/j1UfKkkr86m7UI6iRjDnEJZK9qa9n54lwVpNqkOSQdNJIFUvKjfz0TMcQBmGay8j8
 8AF2I0l7CjJuewfZG7bQ1DLfzL4YYISXraW5Dmd2fMBRLSHZnMlD+SGciMlC3u3RSG+vcM
 OAH1qLGyckXasl2IWkjhF2rLrFXXKejHTJSPXFh/TkOFPCOE5OVMvsOkznvjaTNCa/aybo
 7YCr/vLTtzIV9pMBfoAqrk5xCnpez/rb8wuc1AX41v2e6XY3G5yE96eb9QWYTUpQXwH8b5
 6E+EpLRjoJQE5ZRlpliEleLhS9nDsUoOFPbzAvCTlih03ZxU8Lu6rk7OJYoUvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vo6MZo9DKhAsVssi60Ejohn2L2+fQrfRMIt3k7GeVSw=;
 b=yPs3cx5cOg39sfbqs1R4iXhaJsSVoIJRRJXtHRfZNgwXG0oL0Er0elIdXWXAsSx6wE6IwX
 Vbpd4z+cS0nqap3hqgJYhLAeSEJb2B77WPCMfdZ1P2sQdfpnhvdswr4/ccKD2QasnHrbtZ
 IikMSQNdDw+tmK9uDVoquOdkkbLpYYY5k1F/5LOuF8Iq/DMzoAo2jzoQBx30tFwpA2LRNy
 ddkG7ktfDWXz2frm36vjhlx0Ad1Zfjlrgd9oAGq4tBds40AtahxDo00/yzVuet/mMedpo3
 69ygWrEXWPlR/8yuS/5Ny/YsT4TDSoPnFSoLPbJPS5qDi3u8+wjg/nq0S/BRBA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/40] drivers: mmc: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:43 +0200
Message-ID: <20240720124239.7553-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bbc84648ae6f6265f72
X-MBO-RS-META: xrafntsjyjqgttzkqudehgq7ttjwosxe
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/mmc/aspeed_sdhci.c  | 1 -
 drivers/mmc/davinci_mmc.c   | 1 -
 drivers/mmc/dw_mmc.c        | 2 --
 drivers/mmc/fsl_esdhc.c     | 1 -
 drivers/mmc/fsl_esdhc_spl.c | 1 -
 drivers/mmc/mmc-uclass.c    | 1 -
 drivers/mmc/mmc.c           | 1 -
 drivers/mmc/msm_sdhci.c     | 1 -
 drivers/mmc/mtk-sd.c        | 1 -
 drivers/mmc/piton_mmc.c     | 1 -
 drivers/mmc/rpmb.c          | 1 -
 drivers/mmc/tegra_mmc.c     | 1 -
 12 files changed, 13 deletions(-)

diff --git a/drivers/mmc/aspeed_sdhci.c b/drivers/mmc/aspeed_sdhci.c
index 87a6f66ebb3..b1752d2f881 100644
--- a/drivers/mmc/aspeed_sdhci.c
+++ b/drivers/mmc/aspeed_sdhci.c
@@ -93,7 +93,6 @@ U_BOOT_DRIVER(aspeed_sdhci_drv) = {
 	.plat_auto	= sizeof(struct aspeed_sdhci_plat),
 };
 
-
 static int aspeed_sdc_probe(struct udevice *parent)
 {
 	struct clk clk;
diff --git a/drivers/mmc/davinci_mmc.c b/drivers/mmc/davinci_mmc.c
index 5107fcd8362..e055026847f 100644
--- a/drivers/mmc/davinci_mmc.c
+++ b/drivers/mmc/davinci_mmc.c
@@ -473,7 +473,6 @@ int davinci_mmc_init(struct bd_info *bis, struct davinci_mmc *host)
 }
 #else
 
-
 static int davinci_mmc_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e6107c770fe..f4ecd7422ce 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -55,7 +55,6 @@ static void dwmci_prepare_data(struct dwmci_host *host,
 	unsigned int i = 0, flags, cnt, blk_cnt;
 	ulong data_start, data_end;
 
-
 	blk_cnt = data->blocks;
 
 	dwmci_wait_reset(host, DWMCI_CTRL_FIFO_RESET);
@@ -357,7 +356,6 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 		return -EIO;
 	}
 
-
 	if (cmd->resp_type & MMC_RSP_PRESENT) {
 		if (cmd->resp_type & MMC_RSP_136) {
 			cmd->response[0] = dwmci_readl(host, DWMCI_RESP3);
diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
index 0c66980b621..683a7931c98 100644
--- a/drivers/mmc/fsl_esdhc.c
+++ b/drivers/mmc/fsl_esdhc.c
@@ -850,7 +850,6 @@ __weak int esdhc_status_fixup(void *blob, const char *compat)
 	return 0;
 }
 
-
 #if CONFIG_IS_ENABLED(DM_MMC)
 static int fsl_esdhc_get_cd(struct udevice *dev);
 static void esdhc_disable_for_no_card(void *blob)
diff --git a/drivers/mmc/fsl_esdhc_spl.c b/drivers/mmc/fsl_esdhc_spl.c
index 1a11258be4d..3dd106bed4b 100644
--- a/drivers/mmc/fsl_esdhc_spl.c
+++ b/drivers/mmc/fsl_esdhc_spl.c
@@ -25,7 +25,6 @@ extern uchar mmc_u_boot_offs[];
 #define MBRDBR_BOOT_SIG_55	0x1fe
 #define MBRDBR_BOOT_SIG_AA	0x1ff
 
-
 void mmc_spl_load_image(uint32_t offs, unsigned int size, void *vdst)
 {
 	uint blk_start, blk_cnt, err;
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index da6a39b7d99..83cdc9fd66d 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -538,7 +538,6 @@ U_BOOT_DRIVER(mmc_blk) = {
 };
 #endif /* CONFIG_BLK */
 
-
 UCLASS_DRIVER(mmc) = {
 	.id		= UCLASS_MMC,
 	.name		= "mmc",
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index b18dc331f78..cf8277cbed8 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -785,7 +785,6 @@ static int mmc_complete_op_cond(struct mmc *mmc)
 	return 0;
 }
 
-
 int mmc_send_ext_csd(struct mmc *mmc, u8 *ext_csd)
 {
 	struct mmc_cmd cmd;
diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 4ce0de6c47d..f5e9930c799 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -114,7 +114,6 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
 	writel(readl(prv->base + SDCC_MCI_POWER) | SDCC_MCI_POWER_SW_RST,
 	       prv->base + SDCC_MCI_POWER);
 
-
 	/* Wait for reset to be written to register */
 	if (wait_for_bit_le32(prv->base + SDCC_MCI_STATUS2,
 			      SDCC_MCI_STATUS2_MCI_ACT, false, 10, false)) {
diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index ebd72178b59..d676cf9e314 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1631,7 +1631,6 @@ static void msdc_init_hw(struct msdc_host *host)
 	clrsetbits_le32(&host->base->sdc_cfg, SDC_CFG_DTOC_M,
 			3 << SDC_CFG_DTOC_S);
 
-
 	host->def_tune_para.iocon = readl(&host->base->msdc_iocon);
 	host->def_tune_para.pad_tune = readl(&host->base->pad_tune);
 }
diff --git a/drivers/mmc/piton_mmc.c b/drivers/mmc/piton_mmc.c
index fed1f841608..5ef2781eedf 100644
--- a/drivers/mmc/piton_mmc.c
+++ b/drivers/mmc/piton_mmc.c
@@ -22,7 +22,6 @@
 #include <log.h>
 #include <mmc.h>
 
-
 #define PITON_MMC_DUMMY_F_MAX 20000000
 #define PITON_MMC_DUMMY_F_MIN 10000000
 #define PITON_MMC_DUMMY_CAPACITY SZ_4G << 3
diff --git a/drivers/mmc/rpmb.c b/drivers/mmc/rpmb.c
index 0658ce22cf1..fa3ac2d9e37 100644
--- a/drivers/mmc/rpmb.c
+++ b/drivers/mmc/rpmb.c
@@ -60,7 +60,6 @@ static const char * const rpmb_err_msg[] = {
 	"Authentication key not yet programmed",
 };
 
-
 /* Structure of RPMB data frame. */
 struct s_rpmb {
 	unsigned char stuff[RPMB_SZ_STUFF];
diff --git a/drivers/mmc/tegra_mmc.c b/drivers/mmc/tegra_mmc.c
index 5ed7f01d3f3..355991beb0f 100644
--- a/drivers/mmc/tegra_mmc.c
+++ b/drivers/mmc/tegra_mmc.c
@@ -80,7 +80,6 @@ static void tegra_mmc_prepare_data(struct tegra_mmc_priv *priv,
 {
 	unsigned char ctrl;
 
-
 	debug("buf: %p (%p), data->blocks: %u, data->blocksize: %u\n",
 		bbstate->bounce_buffer, bbstate->user_buffer, data->blocks,
 		data->blocksize);
-- 
2.43.0

