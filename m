Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95601CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D603A84996;
	Fri, 12 Jun 2026 14:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EBFA8005D; Fri, 12 Jun 2026 11:43:19 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC728005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 12 Jun
 2026 17:43:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 12 Jun 2026 17:43:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 12 Jun 2026 17:43:08 +0800
Subject: [PATCH v4 1/6] spi: aspeed: add AST2700 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260612-ast2700_clk-v4-1-9bea29cfdc39@aspeedtech.com>
References: <20260612-ast2700_clk-v4-0-9bea29cfdc39@aspeedtech.com>
In-Reply-To: <20260612-ast2700_clk-v4-0-9bea29cfdc39@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Andre Przywara
 <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, "Kuan-Wei
 Chiu" <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>, Stefan Roese
 <stefan.roese@mailbox.org>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781257392; l=16125;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=l9VACXKdfeI6pPcOBv3mnKHqh/gEo5IJ8uOqPgBTHGY=;
 b=EpO5vmBfeeKSDDs4S0JiIDPZQvdX1eTsAxkFo7wajc/BzLVywsrKmMgA3XHwZHHYjUrMXnIjB
 UnyxBpAXFOxC14011w43x6DG/63XvpjE7hPfr+JD9f8w3pogeUSVJqm
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

AST2700 is a 64-bit SoC whose flash AHB windows are decoded above
the 32-bit address space, so rework AHB addresses to uintptr_t and
decoded window sizes to size_t.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 219 +++++++++++++++++++++++++++++++------------
 1 file changed, 158 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index ca29cfd7c88..0186b01ad9a 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -53,18 +53,20 @@ struct aspeed_spi_regs {
 	u32 dma_len;                    /* 0x8c DMA Length Register */
 	u32 dma_checksum;               /* 0x90 Checksum Calculation Result */
 	u32 timings[ASPEED_SPI_MAX_CS]; /* 0x94 Read Timing Compensation */
+	u32 _reserved3[83];             /* 0xA8 - 0x1F0 */
+	u32 val_kept_wdt;               /* 0x1F4 Value Kept WDT */
 };
 
 struct aspeed_spi_plat {
 	u8 max_cs;
-	void __iomem *ahb_base; /* AHB address base for all flash devices. */
+	uintptr_t ahb_base; /* AHB address base for all flash devices. */
 	fdt_size_t ahb_sz; /* Overall AHB window size for all flash device. */
 	u32 hclk_rate; /* AHB clock rate */
 };
 
 struct aspeed_spi_flash {
-	void __iomem *ahb_base;
-	u32 ahb_decoded_sz;
+	uintptr_t ahb_base;
+	size_t ahb_decoded_sz;
 	u32 ce_ctrl_user;
 	u32 ce_ctrl_read;
 	u32 max_freq;
@@ -84,9 +86,9 @@ struct aspeed_spi_info {
 	u32 min_decoded_sz;
 	u32 clk_ctrl_mask;
 	void (*set_4byte)(struct udevice *bus, u32 cs);
-	u32 (*segment_start)(struct udevice *bus, u32 reg);
-	u32 (*segment_end)(struct udevice *bus, u32 reg);
-	u32 (*segment_reg)(u32 start, u32 end);
+	uintptr_t (*segment_start)(struct udevice *bus, u32 reg);
+	uintptr_t (*segment_end)(struct udevice *bus, u32 reg);
+	u32 (*segment_reg)(uintptr_t start, uintptr_t end);
 	int (*adjust_decoded_sz)(struct udevice *bus);
 	u32 (*get_clk_setting)(struct udevice *dev, uint hz);
 };
@@ -118,30 +120,30 @@ static u32 aspeed_spi_get_io_mode(u32 bus_width)
 	}
 }
 
-static u32 ast2400_spi_segment_start(struct udevice *bus, u32 reg)
+static uintptr_t ast2400_spi_segment_start(struct udevice *bus, u32 reg)
 {
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
-	u32 start_offset = ((reg >> 16) & 0xff) << 23;
+	uintptr_t start_offset = ((reg >> 16) & 0xff) << 23;
 
 	if (start_offset == 0)
-		return (u32)plat->ahb_base;
+		return plat->ahb_base;
 
-	return (u32)plat->ahb_base + start_offset;
+	return plat->ahb_base + start_offset;
 }
 
-static u32 ast2400_spi_segment_end(struct udevice *bus, u32 reg)
+static uintptr_t ast2400_spi_segment_end(struct udevice *bus, u32 reg)
 {
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
-	u32 end_offset = ((reg >> 24) & 0xff) << 23;
+	uintptr_t end_offset = ((reg >> 24) & 0xff) << 23;
 
 	/* Meaningless end_offset, set to physical ahb base. */
 	if (end_offset == 0)
-		return (u32)plat->ahb_base;
+		return plat->ahb_base;
 
-	return (u32)plat->ahb_base + end_offset;
+	return plat->ahb_base + end_offset;
 }
 
-static u32 ast2400_spi_segment_reg(u32 start, u32 end)
+static u32 ast2400_spi_segment_reg(uintptr_t start, uintptr_t end)
 {
 	if (start == end)
 		return 0;
@@ -206,30 +208,30 @@ static u32 ast2400_get_clk_setting(struct udevice *dev, uint max_hz)
 	return hclk_div;
 }
 
-static u32 ast2500_spi_segment_start(struct udevice *bus, u32 reg)
+static uintptr_t ast2500_spi_segment_start(struct udevice *bus, u32 reg)
 {
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
-	u32 start_offset = ((reg >> 16) & 0xff) << 23;
+	uintptr_t start_offset = ((reg >> 16) & 0xff) << 23;
 
 	if (start_offset == 0)
-		return (u32)plat->ahb_base;
+		return plat->ahb_base;
 
-	return (u32)plat->ahb_base + start_offset;
+	return plat->ahb_base + start_offset;
 }
 
-static u32 ast2500_spi_segment_end(struct udevice *bus, u32 reg)
+static uintptr_t ast2500_spi_segment_end(struct udevice *bus, u32 reg)
 {
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
-	u32 end_offset = ((reg >> 24) & 0xff) << 23;
+	uintptr_t end_offset = ((reg >> 24) & 0xff) << 23;
 
 	/* Meaningless end_offset, set to physical ahb base. */
 	if (end_offset == 0)
-		return (u32)plat->ahb_base;
+		return plat->ahb_base;
 
-	return (u32)plat->ahb_base + end_offset;
+	return plat->ahb_base + end_offset;
 }
 
-static u32 ast2500_spi_segment_reg(u32 start, u32 end)
+static u32 ast2500_spi_segment_reg(uintptr_t start, uintptr_t end)
 {
 	if (start == end)
 		return 0;
@@ -346,30 +348,30 @@ end:
 	return hclk_div;
 }
 
-static u32 ast2600_spi_segment_start(struct udevice *bus, u32 reg)
+static uintptr_t ast2600_spi_segment_start(struct udevice *bus, u32 reg)
 {
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
-	u32 start_offset = (reg << 16) & 0x0ff00000;
+	uintptr_t start_offset = (reg << 16) & 0x0ff00000;
 
 	if (start_offset == 0)
-		return (u32)plat->ahb_base;
+		return plat->ahb_base;
 
-	return (u32)plat->ahb_base + start_offset;
+	return plat->ahb_base + start_offset;
 }
 
-static u32 ast2600_spi_segment_end(struct udevice *bus, u32 reg)
+static uintptr_t ast2600_spi_segment_end(struct udevice *bus, u32 reg)
 {
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
-	u32 end_offset = reg & 0x0ff00000;
+	uintptr_t end_offset = reg & 0x0ff00000;
 
 	/* Meaningless end_offset, set to physical ahb base. */
 	if (end_offset == 0)
-		return (u32)plat->ahb_base;
+		return plat->ahb_base;
 
-	return (u32)plat->ahb_base + end_offset + 0x100000;
+	return plat->ahb_base + end_offset + 0x100000;
 }
 
-static u32 ast2600_spi_segment_reg(u32 start, u32 end)
+static u32 ast2600_spi_segment_reg(uintptr_t start, uintptr_t end)
 {
 	if (start == end)
 		return 0;
@@ -473,6 +475,70 @@ static u32 ast2600_get_clk_setting(struct udevice *dev, uint max_hz)
 	return hclk_div;
 }
 
+static uintptr_t ast2700_spi_segment_start(struct udevice *bus, u32 reg)
+{
+	struct aspeed_spi_plat *plat = dev_get_plat(bus);
+	uintptr_t start_offset = (reg & 0x0000ffff) << 16;
+
+	if (start_offset == 0)
+		return plat->ahb_base;
+
+	return plat->ahb_base + start_offset;
+}
+
+static uintptr_t ast2700_spi_segment_end(struct udevice *bus, u32 reg)
+{
+	struct aspeed_spi_plat *plat = dev_get_plat(bus);
+	uintptr_t end_offset = reg & 0xffff0000;
+
+	/* Meaningless end_offset, set to physical ahb base. */
+	if (end_offset == 0)
+		return plat->ahb_base;
+
+	return plat->ahb_base + end_offset;
+}
+
+static u32 ast2700_spi_segment_reg(uintptr_t start, uintptr_t end)
+{
+	if (start == end)
+		return 0;
+
+	return (((start >> 16) & 0x7fff) | ((end + 1) & 0x7fff0000));
+}
+
+static void ast2700_spi_chip_set_4byte(struct udevice *bus, u32 cs)
+{
+	struct aspeed_spi_priv *priv = dev_get_priv(bus);
+	u32 reg_val;
+
+	reg_val = readl(&priv->regs->ctrl);
+	reg_val |= 0x11 << cs;
+	writel(reg_val, &priv->regs->ctrl);
+
+	reg_val = readl(&priv->regs->val_kept_wdt);
+	reg_val |= (0x11 << 4) << cs;
+	writel(reg_val, &priv->regs->val_kept_wdt);
+}
+
+static int ast2700_adjust_decoded_size(struct udevice *bus)
+{
+	struct aspeed_spi_plat *plat = dev_get_plat(bus);
+	struct aspeed_spi_priv *priv = dev_get_priv(bus);
+	struct aspeed_spi_flash *flashes = &priv->flashes[0];
+	int ret;
+	int cs;
+
+	/* Close unused CS. */
+	for (cs = priv->num_cs; cs < plat->max_cs; cs++)
+		flashes[cs].ahb_decoded_sz = 0;
+
+	ret = aspeed_spi_trim_decoded_size(bus);
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
 /*
  * As the flash size grows up, we need to trim some decoded
  * size if needed for the sake of conforming the maximum
@@ -512,12 +578,12 @@ static int aspeed_spi_trim_decoded_size(struct udevice *bus)
 	return 0;
 }
 
-static int aspeed_spi_read_from_ahb(void __iomem *ahb_base, void *buf,
+static int aspeed_spi_read_from_ahb(uintptr_t ahb_base, void *buf,
 				    size_t len)
 {
 	size_t offset = 0;
 
-	if (IS_ALIGNED((uintptr_t)ahb_base, sizeof(uintptr_t)) &&
+	if (IS_ALIGNED(ahb_base, sizeof(uintptr_t)) &&
 	    IS_ALIGNED((uintptr_t)buf, sizeof(uintptr_t))) {
 		readsl(ahb_base, buf, len >> 2);
 		offset = len & ~0x3;
@@ -529,12 +595,12 @@ static int aspeed_spi_read_from_ahb(void __iomem *ahb_base, void *buf,
 	return 0;
 }
 
-static int aspeed_spi_write_to_ahb(void __iomem *ahb_base, const void *buf,
+static int aspeed_spi_write_to_ahb(uintptr_t ahb_base, const void *buf,
 				   size_t len)
 {
 	size_t offset = 0;
 
-	if (IS_ALIGNED((uintptr_t)ahb_base, sizeof(uintptr_t)) &&
+	if (IS_ALIGNED(ahb_base, sizeof(uintptr_t)) &&
 	    IS_ALIGNED((uintptr_t)buf, sizeof(uintptr_t))) {
 		writesl(ahb_base, buf, len >> 2);
 		offset = len & ~0x3;
@@ -589,7 +655,7 @@ static int aspeed_spi_exec_op_user_mode(struct spi_slave *slave,
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(slave->dev);
 	u32 cs = slave_plat->cs[0];
-	u32 ce_ctrl_reg = (u32)&priv->regs->ce_ctrl[cs];
+	uintptr_t ce_ctrl_reg = (uintptr_t)&priv->regs->ce_ctrl[cs];
 	u32 ce_ctrl_val;
 	struct aspeed_spi_flash *flash = &priv->flashes[cs];
 	u8 dummy_data[16] = {0};
@@ -602,7 +668,7 @@ static int aspeed_spi_exec_op_user_mode(struct spi_slave *slave,
 		op->data.nbytes, op->data.buswidth);
 
 	if (priv->info == &ast2400_spi_info)
-		ce_ctrl_reg = (u32)&priv->regs->ctrl;
+		ce_ctrl_reg = (uintptr_t)&priv->regs->ctrl;
 
 	/*
 	 * Set controller to 4-byte address mode
@@ -670,7 +736,7 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	u32 i;
 	u32 cs = slave_plat->cs[0];
 	u32 cmd_io_conf;
-	u32 ce_ctrl_reg;
+	uintptr_t ce_ctrl_reg;
 
 	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT) {
 		/*
@@ -681,9 +747,9 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		return -EOPNOTSUPP;
 	}
 
-	ce_ctrl_reg = (u32)&priv->regs->ce_ctrl[cs];
+	ce_ctrl_reg = (uintptr_t)&priv->regs->ce_ctrl[cs];
 	if (info == &ast2400_spi_info)
-		ce_ctrl_reg = (u32)&priv->regs->ctrl;
+		ce_ctrl_reg = (uintptr_t)&priv->regs->ctrl;
 
 	if (desc->info.length > 0x1000000)
 		priv->info->set_4byte(bus, cs);
@@ -693,7 +759,7 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		priv->flashes[cs].ahb_decoded_sz = desc->info.length;
 
 		for (i = 0; i < priv->num_cs; i++) {
-			dev_dbg(dev, "cs: %d, sz: 0x%x\n", i,
+			dev_dbg(dev, "cs: %d, sz: 0x%zx\n", i,
 				priv->flashes[cs].ahb_decoded_sz);
 		}
 
@@ -728,7 +794,7 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 cs = slave_plat->cs[0];
 	int ret;
 
-	dev_dbg(dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
+	dev_dbg(dev, "read op:0x%x, addr:0x%llx, len:0x%zx\n",
 		desc->info.op_tmpl.cmd.opcode, offs, len);
 
 	if (priv->flashes[cs].ahb_decoded_sz < offs + len ||
@@ -738,7 +804,10 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		if (ret != 0)
 			return 0;
 	} else {
-		memcpy_fromio(buf, priv->flashes[cs].ahb_base + offs, len);
+		memcpy_fromio(buf,
+			      (void __iomem *)(priv->flashes[cs].ahb_base +
+					       (uintptr_t)offs),
+			      len);
 	}
 
 	return len;
@@ -783,19 +852,19 @@ static void aspeed_spi_decoded_range_set(struct udevice *bus)
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
 	u32 decoded_reg_val;
-	u32 start_addr, end_addr;
+	uintptr_t start_addr, end_addr;
 	u32 cs;
 
 	for (cs = 0; cs < plat->max_cs; cs++) {
-		start_addr = (u32)priv->flashes[cs].ahb_base;
-		end_addr = (u32)priv->flashes[cs].ahb_base +
+		start_addr = priv->flashes[cs].ahb_base;
+		end_addr = priv->flashes[cs].ahb_base +
 			   priv->flashes[cs].ahb_decoded_sz;
 
 		decoded_reg_val = priv->info->segment_reg(start_addr, end_addr);
 
 		writel(decoded_reg_val, &priv->regs->segment_addr[cs]);
 
-		dev_dbg(bus, "cs: %d, decoded_reg: 0x%x, start: 0x%x, end: 0x%x\n",
+		dev_dbg(bus, "cs: %d, decoded_reg: 0x%x, start: 0x%lx, end: 0x%lx\n",
 			cs, decoded_reg_val, start_addr, end_addr);
 	}
 }
@@ -851,13 +920,13 @@ static int aspeed_spi_decoded_ranges_sanity(struct udevice *bus)
 	 * address base	are monotonic increasing with CE#.
 	 */
 	for (cs = plat->max_cs - 1; cs > 0; cs--) {
-		if ((u32)priv->flashes[cs].ahb_base != 0 &&
-		    (u32)priv->flashes[cs].ahb_base <
-		    (u32)priv->flashes[cs - 1].ahb_base +
+		if (priv->flashes[cs].ahb_base != 0 &&
+		    priv->flashes[cs].ahb_base <
+		    priv->flashes[cs - 1].ahb_base +
 		    priv->flashes[cs - 1].ahb_decoded_sz) {
-			dev_err(bus, "decoded range overlay 0x%08x 0x%08x\n",
-				(u32)priv->flashes[cs].ahb_base,
-				(u32)priv->flashes[cs - 1].ahb_base);
+			dev_err(bus, "decoded range overlay 0x%08lx 0x%08lx\n",
+				priv->flashes[cs].ahb_base,
+				priv->flashes[cs - 1].ahb_base);
 			return -EINVAL;
 		}
 	}
@@ -895,14 +964,13 @@ static int aspeed_spi_read_fixed_decoded_ranges(struct udevice *bus)
 		return ret;
 
 	for (i = 0; i < count; i++) {
-		priv->flashes[ranges[i].cs].ahb_base =
-				(void __iomem *)ranges[i].ahb_base;
+		priv->flashes[ranges[i].cs].ahb_base = ranges[i].ahb_base;
 		priv->flashes[ranges[i].cs].ahb_decoded_sz =
 				ranges[i].sz;
 	}
 
 	for (i = 0; i < plat->max_cs; i++) {
-		dev_dbg(bus, "ahb_base: 0x%p, size: 0x%08x\n",
+		dev_dbg(bus, "ahb_base: 0x%lx, size: 0x%08zx\n",
 			priv->flashes[i].ahb_base,
 			priv->flashes[i].ahb_decoded_sz);
 	}
@@ -1063,6 +1131,32 @@ static const struct aspeed_spi_info ast2600_spi_info = {
 	.get_clk_setting = ast2600_get_clk_setting,
 };
 
+static const struct aspeed_spi_info ast2700_fmc_info = {
+	.io_mode_mask = 0xf0000000,
+	.max_bus_width = 4,
+	.min_decoded_sz = 0x10000,
+	.clk_ctrl_mask = 0x0f000f00,
+	.set_4byte = ast2700_spi_chip_set_4byte,
+	.segment_start = ast2700_spi_segment_start,
+	.segment_end = ast2700_spi_segment_end,
+	.segment_reg = ast2700_spi_segment_reg,
+	.adjust_decoded_sz = ast2700_adjust_decoded_size,
+	.get_clk_setting = ast2600_get_clk_setting,
+};
+
+static const struct aspeed_spi_info ast2700_spi_info = {
+	.io_mode_mask = 0xf0000000,
+	.max_bus_width = 4,
+	.min_decoded_sz = 0x10000,
+	.clk_ctrl_mask = 0x0f000f00,
+	.set_4byte = ast2700_spi_chip_set_4byte,
+	.segment_start = ast2700_spi_segment_start,
+	.segment_end = ast2700_spi_segment_end,
+	.segment_reg = ast2700_spi_segment_reg,
+	.adjust_decoded_sz = ast2700_adjust_decoded_size,
+	.get_clk_setting = ast2600_get_clk_setting,
+};
+
 static int aspeed_spi_claim_bus(struct udevice *dev)
 {
 	struct udevice *bus = dev->parent;
@@ -1129,7 +1223,8 @@ static int apseed_spi_of_to_plat(struct udevice *bus)
 		return -EINVAL;
 	}
 
-	plat->ahb_base = devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahb_sz);
+	plat->ahb_base =
+		(uintptr_t)devfdt_get_addr_size_index_ptr(bus, 1, &plat->ahb_sz);
 	if (!plat->ahb_base) {
 		dev_err(bus, "wrong AHB base\n");
 		return -EINVAL;
@@ -1147,8 +1242,8 @@ static int apseed_spi_of_to_plat(struct udevice *bus)
 
 	plat->hclk_rate = clk_get_rate(&hclk);
 
-	dev_dbg(bus, "ctrl_base = 0x%x, ahb_base = 0x%p, size = 0x%llx\n",
-		(u32)priv->regs, plat->ahb_base, (fdt64_t)plat->ahb_sz);
+	dev_dbg(bus, "ctrl_base = 0x%p, ahb_base = 0x%lx, size = 0x%llx\n",
+		priv->regs, plat->ahb_base, (fdt64_t)plat->ahb_sz);
 	dev_dbg(bus, "hclk = %dMHz, max_cs = %d\n",
 		plat->hclk_rate / 1000000, plat->max_cs);
 
@@ -1199,6 +1294,8 @@ static const struct udevice_id aspeed_spi_ids[] = {
 	{ .compatible = "aspeed,ast2500-spi", .data = (ulong)&ast2500_spi_info, },
 	{ .compatible = "aspeed,ast2600-fmc", .data = (ulong)&ast2600_fmc_info, },
 	{ .compatible = "aspeed,ast2600-spi", .data = (ulong)&ast2600_spi_info, },
+	{ .compatible = "aspeed,ast2700-fmc", .data = (ulong)&ast2700_fmc_info, },
+	{ .compatible = "aspeed,ast2700-spi", .data = (ulong)&ast2700_spi_info, },
 	{ }
 };
 

-- 
2.34.1

