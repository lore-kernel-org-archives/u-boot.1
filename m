Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE564C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD6B87CB2;
	Tue, 23 Jan 2024 09:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="a6IthTf0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tsPBq+8r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a6IthTf0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tsPBq+8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252A2879B3; Tue, 23 Jan 2024 09:08:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DCB876D0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87A831F74D;
 Tue, 23 Jan 2024 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPxUnbs9JHV3jYAPJf0AMV5InuVXW6ivCPVGbbkwZtQ=;
 b=a6IthTf0E3fVHG8vGi6nq3GpgJhao/I8Q7utR6By1Om9uqAsHo5J4O0Il3ChwqyzN3uv1V
 trHAASmr1TQoehrDjDHCA2/6AREt8kdtlZaFMjEdpWqsn6oa8TjNezI20jZ5dLYgsWqKTC
 Xs8MAMvOtnNKdP6NPnTejH53AinPcW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPxUnbs9JHV3jYAPJf0AMV5InuVXW6ivCPVGbbkwZtQ=;
 b=tsPBq+8rTLyDBF0M6+sOCSobWKvIABEKQLLPNDkr9Q98vcrfDpNqVPErd2wB3J0edDunAa
 1rUSaJubeqoPB6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPxUnbs9JHV3jYAPJf0AMV5InuVXW6ivCPVGbbkwZtQ=;
 b=a6IthTf0E3fVHG8vGi6nq3GpgJhao/I8Q7utR6By1Om9uqAsHo5J4O0Il3ChwqyzN3uv1V
 trHAASmr1TQoehrDjDHCA2/6AREt8kdtlZaFMjEdpWqsn6oa8TjNezI20jZ5dLYgsWqKTC
 Xs8MAMvOtnNKdP6NPnTejH53AinPcW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPxUnbs9JHV3jYAPJf0AMV5InuVXW6ivCPVGbbkwZtQ=;
 b=tsPBq+8rTLyDBF0M6+sOCSobWKvIABEKQLLPNDkr9Q98vcrfDpNqVPErd2wB3J0edDunAa
 1rUSaJubeqoPB6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D901D13786;
 Tue, 23 Jan 2024 08:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MFkmMgd0r2XOagAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 23 Jan 2024 08:08:39 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v5 5/7] mmc: bcmstb: Add support for bcm2712 SD controller
Date: Tue, 23 Jan 2024 10:07:57 +0200
Message-ID: <20240123080819.13625-6-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123080819.13625-1-iivanov@suse.de>
References: <20240123080819.13625-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]
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

Make sure that core SDHCI accessors are used and add
device specific card detection initialization, which
is borrowed from vendor Linux driver code.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/mmc/bcmstb_sdhci.c | 64 +++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/bcmstb_sdhci.c b/drivers/mmc/bcmstb_sdhci.c
index dc96818cff..49846adcf5 100644
--- a/drivers/mmc/bcmstb_sdhci.c
+++ b/drivers/mmc/bcmstb_sdhci.c
@@ -38,15 +38,52 @@
  */
 #define BCMSTB_SDHCI_MINIMUM_CLOCK_FREQUENCY	400000
 
-/*
- * This driver has only been tested with eMMC devices; SD devices may
- * not work.
- */
+#define SDIO_CFG_CTRL				0x0
+#define  SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
+#define  SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+
+#define SDIO_CFG_SD_PIN_SEL			0x44
+#define  SDIO_CFG_SD_PIN_SEL_MASK		0x3
+#define  SDIO_CFG_SD_PIN_SEL_CARD		BIT(1)
+
 struct sdhci_bcmstb_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
 
+struct sdhci_brcmstb_dev_priv {
+	int (*init)(struct udevice *dev);
+};
+
+static int sdhci_brcmstb_init_2712(struct udevice *dev)
+{
+	struct sdhci_host *host = dev_get_priv(dev);
+	void *cfg_regs;
+	u32 reg;
+
+	/* Map in the non-standard CFG registers */
+	cfg_regs = dev_remap_addr_name(dev, "cfg");
+	if (!cfg_regs)
+		return -ENOENT;
+
+	if ((host->mmc->host_caps & MMC_CAP_NONREMOVABLE) ||
+	    (host->mmc->host_caps & MMC_CAP_NEEDS_POLL)) {
+		/* Force presence */
+		reg = readl(cfg_regs + SDIO_CFG_CTRL);
+		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
+		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
+		writel(reg, cfg_regs + SDIO_CFG_CTRL);
+	} else {
+		/* Enable card detection line */
+		reg = readl(cfg_regs + SDIO_CFG_SD_PIN_SEL);
+		reg &= ~SDIO_CFG_SD_PIN_SEL_MASK;
+		reg |= SDIO_CFG_SD_PIN_SEL_CARD;
+		writel(reg, cfg_regs + SDIO_CFG_SD_PIN_SEL);
+	}
+
+	return 0;
+}
+
 static int sdhci_bcmstb_bind(struct udevice *dev)
 {
 	struct sdhci_bcmstb_plat *plat = dev_get_plat(dev);
@@ -54,14 +91,20 @@ static int sdhci_bcmstb_bind(struct udevice *dev)
 	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
 }
 
+/* No specific SDHCI operations are required */
+static const struct sdhci_ops bcmstb_sdhci_ops = { 0 };
+
 static int sdhci_bcmstb_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct sdhci_bcmstb_plat *plat = dev_get_plat(dev);
 	struct sdhci_host *host = dev_get_priv(dev);
+	struct sdhci_brcmstb_dev_priv *dev_priv;
 	fdt_addr_t base;
 	int ret;
 
+	dev_priv = (struct sdhci_brcmstb_dev_priv *)dev_get_driver_data(dev);
+
 	base = dev_read_addr(dev);
 	if (base == FDT_ADDR_T_NONE)
 		return -EINVAL;
@@ -75,6 +118,8 @@ static int sdhci_bcmstb_probe(struct udevice *dev)
 
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
+	host->ops = &bcmstb_sdhci_ops;
+
 	ret = sdhci_setup_cfg(&plat->cfg, host,
 			      BCMSTB_SDHCI_MAXIMUM_CLOCK_FREQUENCY,
 			      BCMSTB_SDHCI_MINIMUM_CLOCK_FREQUENCY);
@@ -84,10 +129,21 @@ static int sdhci_bcmstb_probe(struct udevice *dev)
 	upriv->mmc = &plat->mmc;
 	host->mmc->priv = host;
 
+	if (dev_priv && dev_priv->init) {
+		ret = dev_priv->init(dev);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_probe(dev);
 }
 
+static const struct sdhci_brcmstb_dev_priv match_priv_2712 = {
+	.init = sdhci_brcmstb_init_2712,
+};
+
 static const struct udevice_id sdhci_bcmstb_match[] = {
+	{ .compatible = "brcm,bcm2712-sdhci", .data = (ulong)&match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci" },
 	{ .compatible = "brcm,sdhci-brcmstb" },
 	{ }
-- 
2.43.0

