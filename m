Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04BBC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B87487227;
	Mon, 18 Dec 2023 22:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="NbGv/QjH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mv0vjv7/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NbGv/QjH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mv0vjv7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC0FC874F3; Mon, 18 Dec 2023 22:03:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8349D875DB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07C81222A0;
 Mon, 18 Dec 2023 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP1ZnUgZbbfrrj9GCsaBsy/nQj7H8r6do86LEnTV99Y=;
 b=NbGv/QjHBl2RkJvR6nKp9uvf3bewa/Jp5ykWs/ULuKNb1e1kp0q0TCiM3d88QGrhaOkktM
 ARQoLZXxNSqS1EXqsPA7VQyuJpg3iM74I+GTJfNdlIDDYeA4JLrY6MexUOxdVl1EgxjaPf
 8qkaGm9uEwoD2sactKTn0rgBg5C7Ej0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP1ZnUgZbbfrrj9GCsaBsy/nQj7H8r6do86LEnTV99Y=;
 b=mv0vjv7/43Gm9IJuOWZT6NQDNDmZdNrBoTyjx7Yu5AAnyTgKtyFYldUlt18PDNHm701rhG
 AxUSg7hqv1qJTiDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP1ZnUgZbbfrrj9GCsaBsy/nQj7H8r6do86LEnTV99Y=;
 b=NbGv/QjHBl2RkJvR6nKp9uvf3bewa/Jp5ykWs/ULuKNb1e1kp0q0TCiM3d88QGrhaOkktM
 ARQoLZXxNSqS1EXqsPA7VQyuJpg3iM74I+GTJfNdlIDDYeA4JLrY6MexUOxdVl1EgxjaPf
 8qkaGm9uEwoD2sactKTn0rgBg5C7Ej0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP1ZnUgZbbfrrj9GCsaBsy/nQj7H8r6do86LEnTV99Y=;
 b=mv0vjv7/43Gm9IJuOWZT6NQDNDmZdNrBoTyjx7Yu5AAnyTgKtyFYldUlt18PDNHm701rhG
 AxUSg7hqv1qJTiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FAB513C92;
 Mon, 18 Dec 2023 21:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YHTRGLezgGUtZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 18 Dec 2023 21:03:51 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v3 5/7] mmc: bcmstb: Add support for bcm2712 SD controller
Date: Mon, 18 Dec 2023 23:03:39 +0200
Message-ID: <20231218210341.30073-6-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
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

Borrow SD quirks from vendor Linux driver.

"BCM2712 unfortunately carries with it a perennial bug with the SD
controller register interface present on previous chips (2711/2709/2708).
Accesses must be dword-sized and a read-modify-write cycle to the 32-bit
registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
BCM2712 does not seem to need the extreme delay between each write as on
previous chips, just the serialisation of writes to these registers in a
single 32-bit operation."

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/mmc/bcmstb_sdhci.c | 173 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/bcmstb_sdhci.c b/drivers/mmc/bcmstb_sdhci.c
index dc96818cff..21489e66c0 100644
--- a/drivers/mmc/bcmstb_sdhci.c
+++ b/drivers/mmc/bcmstb_sdhci.c
@@ -38,6 +38,16 @@
  */
 #define BCMSTB_SDHCI_MINIMUM_CLOCK_FREQUENCY	400000
 
+#define SDIO_CFG_CTRL				0x0
+#define  SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
+#define  SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+
+#define SDIO_CFG_SD_PIN_SEL			0x44
+#define  SDIO_CFG_SD_PIN_SEL_MASK		0x3
+#define  SDIO_CFG_SD_PIN_SEL_CARD		BIT(1)
+
+#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
+
 /*
  * This driver has only been tested with eMMC devices; SD devices may
  * not work.
@@ -47,6 +57,53 @@ struct sdhci_bcmstb_plat {
 	struct mmc mmc;
 };
 
+struct sdhci_bcmstb_host {
+	struct sdhci_host host;
+	u32 shadow_cmd;
+	u32 shadow_blk;
+	bool is_cmd_shadowed;
+	bool is_blk_shadowed;
+};
+
+struct sdhci_brcmstb_dev_priv {
+	int (*init)(struct udevice *dev);
+	struct sdhci_ops *ops;
+};
+
+static inline struct sdhci_bcmstb_host *to_bcmstb_host(struct sdhci_host *host)
+{
+	return container_of(host, struct sdhci_bcmstb_host, host);
+}
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
@@ -58,10 +115,14 @@ static int sdhci_bcmstb_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct sdhci_bcmstb_plat *plat = dev_get_plat(dev);
-	struct sdhci_host *host = dev_get_priv(dev);
+	struct sdhci_bcmstb_host *bcmstb = dev_get_priv(dev);
+	struct sdhci_host *host = &bcmstb->host;
+	struct sdhci_brcmstb_dev_priv *dev_priv;
 	fdt_addr_t base;
 	int ret;
 
+	dev_priv = (struct sdhci_brcmstb_dev_priv *)dev_get_driver_data(dev);
+
 	base = dev_read_addr(dev);
 	if (base == FDT_ADDR_T_NONE)
 		return -EINVAL;
@@ -75,6 +136,10 @@ static int sdhci_bcmstb_probe(struct udevice *dev)
 
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
+
+	if (dev_priv && dev_priv->ops)
+		host->ops = dev_priv->ops;
+
 	ret = sdhci_setup_cfg(&plat->cfg, host,
 			      BCMSTB_SDHCI_MAXIMUM_CLOCK_FREQUENCY,
 			      BCMSTB_SDHCI_MINIMUM_CLOCK_FREQUENCY);
@@ -84,10 +149,116 @@ static int sdhci_bcmstb_probe(struct udevice *dev)
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
 
+static u16 sdhci_brcmstb_32bits_readw(struct sdhci_host *host, int reg)
+{
+	struct sdhci_bcmstb_host *bcmstb = to_bcmstb_host(host);
+	u16 word;
+	u32 val;
+
+	if (reg == SDHCI_TRANSFER_MODE && bcmstb->is_cmd_shadowed) {
+		/* Get the saved transfer mode */
+		val = bcmstb->shadow_cmd;
+	} else if ((reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) &&
+		   bcmstb->is_blk_shadowed) {
+		/* Get the saved block info */
+		val = bcmstb->shadow_blk;
+	} else {
+		val = readl(host->ioaddr + (reg & ~3));
+	}
+
+	word = val >> REG_OFFSET_IN_BITS(reg) & 0xffff;
+	return word;
+}
+
+static u8 sdhci_brcmstb_32bits_readb(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + (reg & ~3));
+	u8 byte = val >> REG_OFFSET_IN_BITS(reg) & 0xff;
+	return byte;
+}
+
+/*
+ * BCM2712 unfortunately carries with it a perennial bug with the SD
+ * controller register interface present on previous chips (2711/2709/2708).
+ * Accesses must be dword-sized and a read-modify-write cycle to the
+ * 32-bit registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
+ * BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
+ * BCM2712 does not seem to need the extreme delay between each write as
+ * on previous chips, just the serialisation of writes to these registers
+ * in a single 32-bit operation.
+ */
+static void sdhci_brcmstb_32bits_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_bcmstb_host *bcmstb = to_bcmstb_host(host);
+	u32 word_shift = REG_OFFSET_IN_BITS(reg);
+	u32 mask = 0xffff << word_shift;
+	u32 oldval, newval;
+
+	if (reg == SDHCI_COMMAND) {
+		/* Write the block now as we are issuing a command */
+		if (bcmstb->is_blk_shadowed) {
+			writel(bcmstb->shadow_blk, host->ioaddr + SDHCI_BLOCK_SIZE);
+			bcmstb->is_blk_shadowed = false;
+		}
+		oldval = bcmstb->shadow_cmd;
+		bcmstb->is_cmd_shadowed = false;
+	} else if ((reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) &&
+		   bcmstb->is_blk_shadowed) {
+		/* Block size and count are stored in shadow reg */
+		oldval = bcmstb->shadow_blk;
+	} else {
+		/* Read reg, all other registers are not shadowed */
+		oldval = readl(host->ioaddr + (reg & ~3));
+	}
+	newval = (oldval & ~mask) | (val << word_shift);
+
+	if (reg == SDHCI_TRANSFER_MODE) {
+		/* Save the transfer mode until the command is issued */
+		bcmstb->shadow_cmd = newval;
+		bcmstb->is_cmd_shadowed = true;
+	} else if (reg == SDHCI_BLOCK_SIZE || reg == SDHCI_BLOCK_COUNT) {
+		/* Save the block info until the command is issued */
+		bcmstb->shadow_blk = newval;
+		bcmstb->is_blk_shadowed = true;
+	} else {
+		/* Command or other regular 32-bit write */
+		writel(newval, host->ioaddr + (reg & ~3));
+	}
+}
+
+static void sdhci_brcmstb_32bits_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	u32 oldval = readl(host->ioaddr + (reg & ~3));
+	u32 byte_shift = REG_OFFSET_IN_BITS(reg);
+	u32 mask = 0xff << byte_shift;
+	u32 newval = (oldval & ~mask) | (val << byte_shift);
+
+	writel(newval, host->ioaddr + (reg & ~3));
+}
+
+static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
+	.read_b    = sdhci_brcmstb_32bits_readb,
+	.read_w    = sdhci_brcmstb_32bits_readw,
+	.write_w   = sdhci_brcmstb_32bits_writew,
+	.write_b   = sdhci_brcmstb_32bits_writeb,
+};
+
+static const struct sdhci_brcmstb_dev_priv match_priv_2712 = {
+	.init = sdhci_brcmstb_init_2712,
+	.ops = &sdhci_brcmstb_ops_2712,
+};
+
 static const struct udevice_id sdhci_bcmstb_match[] = {
+	{ .compatible = "brcm,bcm2712-sdhci", .data = (ulong)&match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci" },
 	{ .compatible = "brcm,sdhci-brcmstb" },
 	{ }
-- 
2.35.3

