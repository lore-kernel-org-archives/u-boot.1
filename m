Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA3CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78AD287549;
	Tue,  7 Nov 2023 17:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kJv4Mi55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09EF87538; Tue,  7 Nov 2023 17:18:54 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546EE8753E
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B33301C0002;
 Tue,  7 Nov 2023 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBLsUFrj7ZzWV72ZFUXIPF3tVIvHneUaw39hWMePdUw=;
 b=kJv4Mi55lPrRCQXqIY8nsi0hqnz0PexIuCK8QRvWW2z/rG/L/tSHeReeCSNkyG+ideFfm9
 Tlue9mL2SBjKAUISvK0zEumpzmS5d48e+55El7HKuB8nrl1GhkUQacXnszJIt05qzV46wR
 FPTKaL5xZ6Q3dPXYYNCpv83P5/YnDg4liY6oHOdxCsV4Xw7540AlQlXtiF1n4WyyBhVsRu
 /tU43dEEp3XmjB0Q8KGny5sDw1KL6MRe/o9nx3WheqpETGGsDTlMjvMLOO9sdu2HoaoFz0
 Jv1RX47XKniF1EA2nCMZRd5QywNiPj5B+fVBUP4tA7kd5ijzWwzLI5Xh/DegIw==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 5/8] ram: k3-ddrss: Add exit retention support
Date: Tue,  7 Nov 2023 17:17:59 +0100
Message-Id: <20231107161802.855154-6-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107161802.855154-1-thomas.richard@bootlin.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

Add the exit retention support.
The enter retention is done by DM-Firmware.
A part of the exit retention sequence is specific to the board.
It is done in board_k3_ddrss_lpddr4_release_retention.

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

---

Changes in v2:
- Set exit retention code for DDR behind CONFIG_K3_J721E_DDRSS

 drivers/ram/k3-ddrss/k3-ddrss.c | 307 ++++++++++++++++++++++++++++++++
 1 file changed, 307 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index b54557f02c..e47f615032 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -413,6 +413,306 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 	return ret;
 }
 
+#if defined(CONFIG_K3_J721E_DDRSS)
+
+void __weak board_k3_ddrss_lpddr4_release_retention(void) {}
+
+int __weak board_is_resuming(void)
+{
+	return 0;
+}
+
+#define PLL12_CTRL  0x0068C020
+
+#define k3_ddrss_readreg(k3_ddrss, block, shift, reg, pt) do {		\
+		u32 offset = 0U;					\
+		u32 result = 0U;					\
+		TH_OFFSET_FROM_REG(reg, shift, offset);			\
+		result = k3_ddrss->driverdt->readreg(&k3_ddrss->pd, block, offset, pt); \
+		if (result > 0U) {					\
+			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
+			hang();						\
+		}							\
+	} while (0)
+
+#define k3_ddrss_writereg(k3_ddrss, block, shift, reg, value) do {	\
+		u32 offset = 0U;					\
+		u32 result = 0U;					\
+		TH_OFFSET_FROM_REG(reg, shift, offset);			\
+		result = k3_ddrss->driverdt->writereg(&k3_ddrss->pd, block, offset, value); \
+		if (result > 0U) {					\
+			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
+			hang();						\
+		}							\
+	} while (0)
+
+#define k3_ddrss_readreg_ctl(ddrss, reg, pt) \
+	k3_ddrss_readreg(ddrss, LPDDR4_CTL_REGS, CTL_SHIFT, reg, pt)
+
+#define k3_ddrss_readreg_pi(ddrss, reg, pt) \
+	k3_ddrss_readreg(ddrss, LPDDR4_PHY_INDEP_REGS, PI_SHIFT, reg, pt)
+
+#define k3_ddrss_readreg_phy(ddrss, reg, pt) \
+	k3_ddrss_readreg(ddrss, LPDDR4_PHY_REGS, PHY_SHIFT, reg, pt)
+
+#define k3_ddrss_writereg_ctl(ddrss, reg, value) \
+	k3_ddrss_writereg(ddrss, LPDDR4_CTL_REGS, CTL_SHIFT, reg, value)
+
+#define k3_ddrss_writereg_pi(ddrss, reg, value) \
+	k3_ddrss_writereg(ddrss, LPDDR4_PHY_INDEP_REGS, PI_SHIFT, reg, value)
+
+#define k3_ddrss_writereg_phy(ddrss, reg, value) \
+	k3_ddrss_writereg(ddrss, LPDDR4_PHY_REGS, PHY_SHIFT, reg, value)
+
+#define k3_ddrss_set_ctl(k3_ddrss, reg, mask) do {	\
+	u32 val;					\
+	k3_ddrss_readreg_ctl(ddrss, reg, &val);		\
+	val |= mask;					\
+	k3_ddrss_writereg_ctl(ddrss, reg, val);		\
+	} while (0)
+
+#define k3_ddrss_clr_ctl(k3_ddrss, reg, mask) do {		\
+		u32 val;					\
+		k3_ddrss_readreg_ctl(ddrss, reg, &val);		\
+		val &= ~(mask);					\
+		k3_ddrss_writereg_ctl(ddrss, reg, val);		\
+	} while (0)
+
+#define k3_ddrss_set_pi(k3_ddrss, reg, mask) do {		\
+		u32 val;					\
+		k3_ddrss_readreg_pi(ddrss, reg, &val);		\
+		val |= mask;					\
+		k3_ddrss_writereg_pi(ddrss, reg, val);		\
+	} while (0)
+
+#define k3_ddrss_clr_pi(k3_ddrss, reg, mask) do {		\
+		u32 val;					\
+		k3_ddrss_readreg_pi(ddrss, reg, &val);		\
+		val &= ~(mask);					\
+		k3_ddrss_writereg_pi(ddrss, reg, val);		\
+	} while (0)
+
+#define k3_ddrss_set_phy(ddrss, reg, mask) do {		\
+	u32 val;					\
+	k3_ddrss_readreg_phy(ddrss, reg, &val);		\
+	val |= mask;					\
+	k3_ddrss_writereg_phy(ddrss, reg, val);		\
+	} while (0)
+
+#define k3_ddrss_clr_phy(ddrss, reg, mask) do {		\
+	u32 val;					\
+	k3_ddrss_readreg_phy(ddrss, reg, &val);		\
+	val &= ~(mask);					\
+	k3_ddrss_writereg_phy(ddrss, reg, val);		\
+	} while (0)
+
+static void k3_ddrss_lpddr4_exit_retention(struct k3_ddrss_desc *ddrss)
+{
+	u32 regval;
+	unsigned long tmo;
+	volatile unsigned int val;
+
+	/* disable auto entry / exit */
+	k3_ddrss_clr_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, (0xF << 24) | (0xF << 16));
+
+	/* Configure DFI Interface, DDR retention exit occurs through PHY */
+	k3_ddrss_readreg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, &regval);
+	regval &= ~0xF0F; // Set DFI_Input_1 = 0
+	regval |= 0x01;   // Set DFI Input_0 = 1
+	k3_ddrss_writereg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, regval);
+
+	/* PWRUP_SREFRESH_EXIT = 1 */
+	k3_ddrss_set_ctl(ddrss, LPDDR4__PWRUP_SREFRESH_EXIT__REG, 0x1);
+
+	/* PI_PWRUP_SREFRESH_EXIT = 0 */
+	k3_ddrss_clr_ctl(ddrss, LPDDR4__PI_COL_DIFF__REG, 0x1 << 16);
+
+	/* DFIBUS_BOOT_FREQ = 0 */
+	k3_ddrss_clr_ctl(ddrss, LPDDR4__DFIBUS_BOOT_FREQ__REG, 0x3);
+
+	/* DFIBUS_FREQ_INIT = 2 */
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, &regval);
+	regval &= ~(0x3 << 24);
+	regval |= (0x1 << 24);
+	k3_ddrss_writereg_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, regval);
+
+	/* Force Leveling during Initialization, Enable Link Training */
+
+	/* PI_INIT_LVL_EN = 1 */
+	k3_ddrss_set_pi(ddrss, LPDDR4__PI_NORMAL_LVL_SEQ__REG, (1 << 8));
+
+	/* PI_DRAM_INIT_EN = 0 */
+	k3_ddrss_clr_pi(ddrss, LPDDR4__PI_DLL_RST__REG, (0x1 << 8));
+
+	/* PI_DFI_PHYMSTR_STATE_SEL_R = 1  (force memory into self-refresh) */
+	k3_ddrss_set_pi(ddrss, LPDDR4__PI_DFI_VERSION__REG, (1 << 24));
+
+	/*  PHY_INDEP_INIT_MODE = 0 */
+	k3_ddrss_clr_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, (0x1 << 16));
+	/* PHY_INDEP_TRAIN_MODE = 1 */
+	k3_ddrss_set_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, 0x1);
+
+	/* PI_INIT_WORK_FREQ = 1 */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_INIT_WORK_FREQ__REG, &regval);
+	regval &= ~0x1F;
+	regval |= 0x01;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_INIT_WORK_FREQ__REG, regval);
+
+	/* PI_FREQ_MAP[2:0] */
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_FREQ_MAP__REG, 0x03);
+
+	/* Training/leveling configurations for different frequency set points */
+
+	/* PI_CALVL_EN_F0 = 01b; PI_CALVL_EN_F1 = 01b; PI_CALVL_EN_F2 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_CALVL_EN_F0__REG, &regval);
+	regval &= ~0x030303;
+	regval |= 0x010101;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_CALVL_EN_F0__REG, regval);
+
+	/* PI_WRLVL_EN_F0 = 00b; PI_WRLVL_EN_F1 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_TDFI_CTRL_DELAY_F1__REG, &regval);
+	regval &= ~0x03030000;
+	regval |= 0x01000000;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_TDFI_CTRL_DELAY_F1__REG, regval);
+
+	/* PI_WRLVL_EN_F2 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_WRLVL_EN_F2__REG, &regval);
+	regval &= ~0x03;
+	regval |= 0x01;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_WRLVL_EN_F2__REG, regval);
+
+	/* PI_RDLVL_EN_F0 = 00b; PI_RDLVL_EN_F1 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F0__REG, &regval);
+	regval &= ~0x030003;
+	regval |= 0x010000;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F0__REG, regval);
+
+	/* PI_RDLVL_EN_F2 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F2__REG, &regval);
+	regval &= ~0x03;
+	regval |= 0x01;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F2__REG, regval);
+
+	/* PI_RDLVL_GATE_EN_F0 = 00b; PI_RDLVL_GATE_EN_F1 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F0__REG, &regval);
+	regval &= ~0x03000300;
+	regval |= 0x01000000;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F0__REG, regval);
+
+	/* PI_RDLVL_GATE_EN_F2 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F2__REG, &regval);
+	regval &= ~0x0300;
+	regval |= 0x0100;
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_RDLVL_EN_F2__REG, regval);
+
+	/* PI_WDQLVL_EN_F0 = 00b */
+	k3_ddrss_clr_pi(ddrss, LPDDR4__PI_WDQLVL_VREF_DELTA_F0__REG, (0x3 << 8));
+
+	/* PI_WDQLVL_EN_F1 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_VREF_DELTA_F1__REG, &regval);
+	regval &= ~(0x3 << 24);
+	regval |= (0x1 << 24);
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_WDQLVL_VREF_DELTA_F1__REG, regval);
+
+	/* PI_WDQLVL_EN_F2 = 01b */
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_VREF_DELTA_F2__REG, &regval);
+	regval &= ~(0x3 << 8);
+	regval |= (0x1 << 8);
+	k3_ddrss_writereg_pi(ddrss, LPDDR4__PI_WDQLVL_VREF_DELTA_F2__REG, regval);
+
+	*(unsigned int *)PLL12_CTRL |= 0x80000000;
+	val = *(volatile unsigned int *)PLL12_CTRL;
+
+	if ((val & 0x80000000) != 0x80000000)
+		val = *(volatile unsigned int *)PLL12_CTRL;
+
+	board_k3_ddrss_lpddr4_release_retention();
+
+	/* LPC_SR_PHYMSTR_EN */
+	k3_ddrss_clr_ctl(ddrss, LPDDR4__LPC_SR_CTRLUPD_EN__REG, (0x1 << 16));
+	/* PI_START=1 */
+	k3_ddrss_set_pi(ddrss, LPDDR4__PI_START__REG, 0x01);
+	/* START=1 */
+	k3_ddrss_set_ctl(ddrss, LPDDR4__START__REG, 0x01);
+
+	debug("%s: PPL12 = %x\n", __func__, *(volatile unsigned int *)PLL12_CTRL);
+	ddrss->ddr_fhs_cnt = 5;
+	k3_lpddr4_freq_update(ddrss);
+	debug("%s: PPL12 = %x\n", __func__, *(volatile unsigned int *)PLL12_CTRL);
+
+	tmo = timer_get_us() + 100000;
+	do {
+		k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+		debug("%s: DDRSS_PI_79 = %x\n", __func__, regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 0)) == 0x00);
+
+	tmo = timer_get_us() + 4000;
+	do {
+		k3_ddrss_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 9)) == 0x00);
+
+	k3_ddrss_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+	debug("%s: PI interrupt status: 0x%08x\n", __func__, regval);
+
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+	debug("%s: Controller interrupt status: 0x%08x\n", __func__, regval);
+
+	debug("%s: Successfully exited Retention\n", __func__);
+
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	k3_ddrss_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, &regval);
+	regval &= ~(0x7F << 24);
+	regval |= (0x2 << 24); // set low power mode exit
+	k3_ddrss_writereg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, regval);
+
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* wait until low power operation has been completed */
+	tmo = timer_get_us() + 4000;
+	do {
+		k3_ddrss_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (0x1 << 10)) == 0);
+
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	k3_ddrss_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	/*
+	 * bit 6 / 14 -- lp_state valid
+	 * bits 13:8 / 5:0 0x0F SRPD Long with Mem and Controller Clk Gating
+	 */
+	tmo = timer_get_us() + 4000;
+	do {
+		k3_ddrss_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & 0x4F4F) != 0x4040);
+
+	k3_ddrss_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+}
+#endif /* CONFIG_K3_J721E_DDRSS */
+
 void k3_lpddr4_probe(struct k3_ddrss_desc *ddrss)
 {
 	u32 status = 0U;
@@ -637,6 +937,13 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+#if defined(CONFIG_K3_J721E_DDRSS)
+	if (board_is_resuming()) {
+		k3_ddrss_lpddr4_exit_retention(ddrss);
+		return 0;
+	}
+#endif
+
 	k3_lpddr4_start(ddrss);
 
 	if (ddrss->ti_ecc_enabled) {
-- 
2.39.2

