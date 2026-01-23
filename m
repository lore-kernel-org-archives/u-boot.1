Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48565D7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278B283D7A;
	Fri, 23 Jan 2026 12:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KBqqH/nB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA25F83DB6; Fri, 23 Jan 2026 12:46:52 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E755983DDD
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A0F861A2B5E;
 Fri, 23 Jan 2026 11:46:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6E9316070A;
 Fri, 23 Jan 2026 11:46:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1CBFF119A83E7; Fri, 23 Jan 2026 12:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168800; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=cim3YTGIWOVJrd5wGzN/Sn2Xr9cRKY1dATujxBMgebA=;
 b=KBqqH/nBf4My/9b3kYo0c0pZwrI9jiFIgNXIXFstoNipt/x7DYCwUwuSyg4G3OsVPz+S8H
 A7WGIK2dLfgz45BUCx4xaP7Z2T1802bya1cOLbfsDTOjHL+0kyTV1FRknHj4ANzLn4qg+9
 bJ0xU1FgI6LG5f97ix69Ge9VAgptpJnrsRaFnDi9DqZ3tPcYJkXXxpaBG8vyXboD82PHaB
 tskHu7my0Wdim3vd/I2JUs0eVphRmcDYED+tY6onqj1ycdBEibIZVHTA3YYQDv+JiINK0d
 x5q9lT7vef96Pf+uF8zOYUVhizkavfUR9FgjT1glsmYlkHmovXOcCaxJXnJ7oQ==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 23/26] mtd: rawnand: sunxi_spl: add support for H6/H616
 nand controller
Date: Fri, 23 Jan 2026 12:44:58 +0100
Message-ID: <20260123114507.1400918-24-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Introduce H6/H616 NAND controller support for SPL

The H616 NAND controller has the same base as A10/A23, with some
differences:
- MDMA is based on chained buffers
- its ECC supports up to 80bit per 1024bytes
- some registers layouts are a bit different, mainly due do the stronger
ECC.
- it uses USER_DATA_LEN registers along USER_DATA registers.
- it needs a specific clock for ECC and MBUS.

For SPL, most of the work was setting the clocks, adding the new
capability structure for H616 and supporting the new USER_DATA_LEN
registers.

Tested on Whatsminer H616 board (with and without scrambling, ECC)

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 board/sunxi/board.c                   |  8 +++
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 89 ++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 09b531b7f52a..9fade60d4897 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -309,11 +309,19 @@ static void nand_clock_setup(void)
 {
 	void * const ccm = (void *)SUNXI_CCM_BASE;
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	setbits_le32(ccm + CCU_H6_NAND_GATE_RESET,
+		     (1 << GATE_SHIFT) | (1 << RESET_SHIFT));
+	setbits_le32(ccm + CCU_H6_MBUS_GATE, (1 << MBUS_GATE_OFFSET_NAND));
+	setbits_le32(ccm + CCU_NAND1_CLK_CFG, CCM_NAND_CTRL_ENABLE |
+		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
+#else
 	setbits_le32(ccm + CCU_AHB_GATE0,
 		     (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
 #if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
     defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
 	setbits_le32(ccm + CCU_AHB_RESET0_CFG, (1 << AHB_GATE_OFFSET_NAND0));
+#endif
 #endif
 	setbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
 		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 76458c2063ea..c69f704497a7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -52,6 +52,10 @@ const uint16_t random_seed[128] = {
 	0x7c57, 0x0fbe, 0x46ce, 0x4939, 0x6b17, 0x37bb, 0x3e91, 0x76db,
 };
 
+static const u8 sunxi_user_data_len_h6[] = {
+	0, 4, 8, 12, 16, 20, 24, 28, 32
+};
+
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
 	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
@@ -62,6 +66,18 @@ __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.random_en_mask = BIT(9),
 };
 
+__maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
+	.reg_user_data_len = NFC_REG_H6_USER_DATA_LEN,
+	.reg_spare_area = NFC_REG_H6_SPARE_AREA,
+	.reg_pat_found = NFC_REG_H6_PAT_FOUND,
+	.pat_found_mask = GENMASK(31, 0),
+	.ecc_mode_mask = GENMASK(15, 8),
+	.ecc_err_mask = GENMASK(31, 0),
+	.user_data_len_tab = sunxi_user_data_len_h6,
+	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
+	.random_en_mask = BIT(5),
+};
+
 #define DEFAULT_TIMEOUT_US	100000
 
 static int check_value_inner(int offset, int expected_bits,
@@ -197,7 +213,61 @@ static int nand_change_column(u16 column)
 	return 0;
 }
 
-static const int ecc_bytes[] = {32, 46, 54, 60, 74, 88, 102, 110, 116};
+/*
+ * On H6/H616 the user_data length has to be set in specific registers
+ * before writing.
+ */
+static void sunxi_nfc_reset_user_data_len(const struct nfc_config *nfc)
+{
+	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
+
+	/* not all SoCs have this register */
+	if (!NFC_REG_USER_DATA_LEN(nfc, 0))
+		return;
+
+	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
+		writel(0, SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, i));
+}
+
+static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
+					int len, int step)
+{
+	bool found = false;
+	u32 val;
+	int i;
+
+	/* not all SoCs have this register */
+	if (!nfc->caps->reg_user_data_len)
+		return;
+
+	for (i = 0; i < nfc->caps->nuser_data_tab; i++) {
+		if (len == nfc->caps->user_data_len_tab[i]) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		printf("Unsupported length for user data reg: %d\n", len);
+		return;
+	}
+
+	val = readl(SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, step));
+
+	val &= ~NFC_USER_DATA_LEN_MSK(step);
+	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
+	writel(val, SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, step));
+}
+
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+static const int ecc_bytes[] = {
+	32, 46, 54, 60, 74, 82, 88, 96, 102, 110, 116, 124, 130, 138, 144
+};
+#else
+static const int ecc_bytes[] = {
+	32, 46, 54, 60, 74, 88, 102, 110, 116
+};
+#endif
 
 static void nand_readlcpy(u32 *dest, u32 * __iomem src, size_t len)
 {
@@ -256,8 +326,11 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		 * the data.
 		 */
 		nand_change_column(oob_off);
-		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 
+		sunxi_nfc_reset_user_data_len(conf);
+		sunxi_nfc_set_user_data_len(conf, 4, 0);
+
+		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 		/* Get the ECC status */
 		ecc_st = readl(SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 
@@ -412,7 +485,10 @@ static int nand_detect_config(struct nfc_config *conf, u32 offs, void *dest)
 	if (conf->valid)
 		return 0;
 
-	conf->caps = &sunxi_nfc_a10_caps;
+	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) || IS_ENABLED(CONFIG_MACH_SUN50I_H6))
+		conf->caps = &sunxi_nfc_h616_caps;
+	else
+		conf->caps = &sunxi_nfc_a10_caps;
 
 	/*
 	 * Modern NANDs are more likely than legacy ones, so we start testing
@@ -515,12 +591,19 @@ void nand_deselect(void)
 {
 	void * const ccm = (void *)SUNXI_CCM_BASE;
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	clrbits_le32(ccm + CCU_H6_NAND_GATE_RESET,
+		     (1 << GATE_SHIFT) | (1 << RESET_SHIFT));
+	clrbits_le32(ccm + CCU_H6_MBUS_GATE, (1 << MBUS_GATE_OFFSET_NAND));
+	clrbits_le32(ccm + CCU_NAND1_CLK_CFG, CCM_NAND_CTRL_ENABLE);
+#else
 	clrbits_le32(ccm + CCU_AHB_GATE0,
 		     (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
 #ifdef CONFIG_MACH_SUN9I
 	clrbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
 #else
 	clrbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
+#endif
 #endif
 	clrbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
 		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
-- 
2.47.3

