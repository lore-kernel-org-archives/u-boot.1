Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C18C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 01:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BADC3875E9;
	Tue, 23 Jan 2024 02:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="IYu9WNLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7861B8780E; Mon, 22 Jan 2024 23:12:28 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533E887559
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick9876@free.fr
Received: from hulk.fork.zz (unknown [82.65.94.41])
 (Authenticated sender: patrick9876@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5A31F78032A;
 Mon, 22 Jan 2024 23:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1705961545;
 bh=UKgZzxcgMNB3ga36OmcGrvq+ftwIHwA1un5Z/cHM+U0=;
 h=From:To:Cc:Subject:Date:Reply-To:From;
 b=IYu9WNLU31kHyRBq+5vR5PpUw6bEicoGt6q2hPeUJC0HGDjeX64lLMJ4jL0nDELoy
 402zmcPsKWtmpU2xUOs8sXfU72Bf1qM4siJkDnbRAnxoQY1DizDhnkeU/ODI+3LBK4
 XPkWZMeyxVBg+3e+PnHoFzO+fssVRMdE0PUvhDqPGsLgCGFkEYBJ8EFMtDeOz1oPbx
 rt9xTqrj1W4lS+4h9xuspOjobebHI/QCAmTpMLlqtcdA2qc90EqqKdjhBFhpvjGZHR
 JVmdN2gDQ5h/UUxyDvBaW1K0tRxL95imeGylLzVTs50lbC/coMYGOu7AMGUJhjtvBt
 LWfwQuPonaxog==
From: patrick9876@free.fr
To: u-boot@lists.denx.de
Cc: jernej.skrabec@siol.net, andre.przywara@arm.com,
 Patrick Lerda <patrick9876@free.fr>
Subject: [PATCH] sunxi: dram: h6: fix the unreliability related to the DDR3
 sequence
Date: Mon, 22 Jan 2024 23:12:18 +0100
Message-ID: <20240122221220.22587-1-patrick9876@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jan 2024 02:09:39 +0100
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
Reply-To: patrick9876@free.fr
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Patrick Lerda <patrick9876@free.fr>

Indeed, the DDR3 has a non-zero probability to not be properly
initialized. This could be the PLL that is not locked or anything else.
When this happens and the code tests the correct board configuration,
the proper board configuration is not set. The board could end with
half the expected memory size, or u-boot could stall.

This change adds a loop to execute the DDR3 sequence again until the
stable state is reached.

My H6 TX6 board was prone to this issue. Once fixed with this change,
the same board can now handle 10000+ consecutive reboots properly.

Fixes: ec9cdaaa13d ("sunxi: dram: h6: Improve DDR3 config detection")
Signed-off-by: Patrick Lerda <patrick9876@free.fr>
---
 arch/arm/mach-sunxi/dram_sun50i_h6.c | 207 ++++++++++++++-------------
 1 file changed, 111 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index 62bc2a0231..462adb1c9e 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -420,116 +420,131 @@ static bool mctl_channel_init(struct dram_para *para)
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 	struct sunxi_mctl_phy_reg * const mctl_phy =
 			(struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
-	int i;
+	int i, j = 0;
 	u32 val;
 
-	setbits_le32(&mctl_ctl->dfiupd[0], BIT(31) | BIT(30));
-	setbits_le32(&mctl_ctl->zqctl[0], BIT(31) | BIT(30));
-	writel(0x2f05, &mctl_ctl->sched[0]);
-	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
-	setbits_le32(&mctl_ctl->dfimisc, BIT(0));
-	setbits_le32(&mctl_ctl->unk_0x00c, BIT(8));
-	clrsetbits_le32(&mctl_phy->pgcr[1], 0x180, 0xc0);
-	/* TODO: non-LPDDR3 types */
-	clrsetbits_le32(&mctl_phy->pgcr[2], GENMASK(17, 0), ns_to_t(7800));
-	clrbits_le32(&mctl_phy->pgcr[6], BIT(0));
-	clrsetbits_le32(&mctl_phy->dxccr, 0xee0, 0x220);
-	/* TODO: VT compensation */
-	clrsetbits_le32(&mctl_phy->dsgcr, BIT(0), 0x440060);
-	clrbits_le32(&mctl_phy->vtcr[1], BIT(1));
-
-	for (i = 0; i < 4; i++)
-		clrsetbits_le32(&mctl_phy->dx[i].gcr[0], 0xe00, 0x800);
-	for (i = 0; i < 4; i++)
-		clrsetbits_le32(&mctl_phy->dx[i].gcr[2], 0xffff, 0x5555);
-	for (i = 0; i < 4; i++)
-		clrsetbits_le32(&mctl_phy->dx[i].gcr[3], 0x3030, 0x1010);
-
-	udelay(100);
+	do {
+		setbits_le32(&mctl_ctl->dfiupd[0], BIT(31) | BIT(30));
+		setbits_le32(&mctl_ctl->zqctl[0], BIT(31) | BIT(30));
+		writel(0x2f05, &mctl_ctl->sched[0]);
+		setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
+		setbits_le32(&mctl_ctl->dfimisc, BIT(0));
+		setbits_le32(&mctl_ctl->unk_0x00c, BIT(8));
+		clrsetbits_le32(&mctl_phy->pgcr[1], 0x180, 0xc0);
+		/* TODO: non-LPDDR3 types */
+		clrsetbits_le32(&mctl_phy->pgcr[2], GENMASK(17, 0),
+				ns_to_t(7800));
+		clrbits_le32(&mctl_phy->pgcr[6], BIT(0));
+		clrsetbits_le32(&mctl_phy->dxccr, 0xee0, 0x220);
+		/* TODO: VT compensation */
+		clrsetbits_le32(&mctl_phy->dsgcr, BIT(0), 0x440060);
+		clrbits_le32(&mctl_phy->vtcr[1], BIT(1));
 
-	if (para->ranks == 2)
-		setbits_le32(&mctl_phy->dtcr[1], 0x30000);
-	else
-		clrsetbits_le32(&mctl_phy->dtcr[1], 0x30000, 0x10000);
+		for (i = 0; i < 4; i++)
+			clrsetbits_le32(&mctl_phy->dx[i].gcr[0], 0xe00, 0x800);
+		for (i = 0; i < 4; i++)
+			clrsetbits_le32(&mctl_phy->dx[i].gcr[2], 0xffff,
+					0x5555);
+		for (i = 0; i < 4; i++)
+			clrsetbits_le32(&mctl_phy->dx[i].gcr[3], 0x3030,
+					0x1010);
 
-	if (sunxi_dram_is_lpddr(para->type))
-		clrbits_le32(&mctl_phy->dtcr[1], BIT(1));
-	if (para->ranks == 2) {
-		writel(0x00010001, &mctl_phy->rankidr);
-		writel(0x20000, &mctl_phy->odtcr);
-	} else {
-		writel(0x0, &mctl_phy->rankidr);
-		writel(0x10000, &mctl_phy->odtcr);
-	}
+		udelay(100);
 
-	/* set bits [3:0] to 1? 0 not valid in ZynqMP d/s */
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
-		clrsetbits_le32(&mctl_phy->dtcr[0], 0xF0000000, 0x10000040);
-	else
-		clrsetbits_le32(&mctl_phy->dtcr[0], 0xF0000000, 0x10000000);
-	if (para->clk <= 792) {
-		if (para->clk <= 672) {
-			if (para->clk <= 600)
-				val = 0x300;
-			else
-				val = 0x400;
+		if (para->ranks == 2)
+			setbits_le32(&mctl_phy->dtcr[1], 0x30000);
+		else
+			clrsetbits_le32(&mctl_phy->dtcr[1], 0x30000, 0x10000);
+
+		if (sunxi_dram_is_lpddr(para->type))
+			clrbits_le32(&mctl_phy->dtcr[1], BIT(1));
+		if (para->ranks == 2) {
+			writel(0x00010001, &mctl_phy->rankidr);
+			writel(0x20000, &mctl_phy->odtcr);
 		} else {
-			val = 0x500;
+			writel(0x0, &mctl_phy->rankidr);
+			writel(0x10000, &mctl_phy->odtcr);
 		}
-	} else {
-		val = 0x600;
-	}
-	/* FIXME: NOT REVIEWED YET */
-	clrsetbits_le32(&mctl_phy->zq[0].zqcr, 0x700, val);
-	clrsetbits_le32(&mctl_phy->zq[0].zqpr[0], 0xff,
-			CONFIG_DRAM_ZQ & 0xff);
-	clrbits_le32(&mctl_phy->zq[0].zqor[0], 0xfffff);
-	setbits_le32(&mctl_phy->zq[0].zqor[0], (CONFIG_DRAM_ZQ >> 8) & 0xff);
-	setbits_le32(&mctl_phy->zq[0].zqor[0], (CONFIG_DRAM_ZQ & 0xf00) - 0x100);
-	setbits_le32(&mctl_phy->zq[0].zqor[0], (CONFIG_DRAM_ZQ & 0xff00) << 4);
-	clrbits_le32(&mctl_phy->zq[1].zqpr[0], 0xfffff);
-	setbits_le32(&mctl_phy->zq[1].zqpr[0], (CONFIG_DRAM_ZQ >> 16) & 0xff);
-	setbits_le32(&mctl_phy->zq[1].zqpr[0], ((CONFIG_DRAM_ZQ >> 8) & 0xf00) - 0x100);
-	setbits_le32(&mctl_phy->zq[1].zqpr[0], (CONFIG_DRAM_ZQ & 0xff0000) >> 4);
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR3) {
-		for (i = 1; i < 14; i++)
-			writel(0x06060606, &mctl_phy->acbdlr[i]);
-	}
 
-	val = PIR_ZCAL | PIR_DCAL | PIR_PHYRST | PIR_DRAMINIT | PIR_QSGATE |
-	      PIR_RDDSKW | PIR_WRDSKW | PIR_RDEYE | PIR_WREYE;
-	if (para->type == SUNXI_DRAM_TYPE_DDR3)
-		val |= PIR_DRAMRST | PIR_WL;
-	mctl_phy_pir_init(val);
+		/* set bits [3:0] to 1? 0 not valid in ZynqMP d/s */
+		if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
+			clrsetbits_le32(&mctl_phy->dtcr[0], 0xF0000000,
+					0x10000040);
+		else
+			clrsetbits_le32(&mctl_phy->dtcr[0], 0xF0000000,
+					0x10000000);
+		if (para->clk <= 792) {
+			if (para->clk <= 672) {
+				if (para->clk <= 600)
+					val = 0x300;
+				else
+					val = 0x400;
+			} else {
+				val = 0x500;
+			}
+		} else {
+			val = 0x600;
+		}
+		/* FIXME: NOT REVIEWED YET */
+		clrsetbits_le32(&mctl_phy->zq[0].zqcr, 0x700, val);
+		clrsetbits_le32(&mctl_phy->zq[0].zqpr[0], 0xff,
+				CONFIG_DRAM_ZQ & 0xff);
+		clrbits_le32(&mctl_phy->zq[0].zqor[0], 0xfffff);
+		setbits_le32(&mctl_phy->zq[0].zqor[0],
+			     (CONFIG_DRAM_ZQ >> 8) & 0xff);
+		setbits_le32(&mctl_phy->zq[0].zqor[0],
+			     (CONFIG_DRAM_ZQ & 0xf00) - 0x100);
+		setbits_le32(&mctl_phy->zq[0].zqor[0], (CONFIG_DRAM_ZQ & 0xff00)
+							       << 4);
+		clrbits_le32(&mctl_phy->zq[1].zqpr[0], 0xfffff);
+		setbits_le32(&mctl_phy->zq[1].zqpr[0],
+			     (CONFIG_DRAM_ZQ >> 16) & 0xff);
+		setbits_le32(&mctl_phy->zq[1].zqpr[0],
+			     ((CONFIG_DRAM_ZQ >> 8) & 0xf00) - 0x100);
+		setbits_le32(&mctl_phy->zq[1].zqpr[0],
+			     (CONFIG_DRAM_ZQ & 0xff0000) >> 4);
+		if (para->type == SUNXI_DRAM_TYPE_LPDDR3) {
+			for (i = 1; i < 14; i++)
+				writel(0x06060606, &mctl_phy->acbdlr[i]);
+		}
 
-	/* TODO: DDR4 types ? */
-	for (i = 0; i < 4; i++)
-		writel(0x00000909, &mctl_phy->dx[i].gcr[5]);
+		val = PIR_ZCAL | PIR_DCAL | PIR_PHYRST | PIR_DRAMINIT |
+		      PIR_QSGATE | PIR_RDDSKW | PIR_WRDSKW | PIR_RDEYE |
+		      PIR_WREYE;
+		if (para->type == SUNXI_DRAM_TYPE_DDR3)
+			val |= PIR_DRAMRST | PIR_WL;
+		mctl_phy_pir_init(val);
 
-	for (i = 0; i < 4; i++) {
-		if (IS_ENABLED(CONFIG_DRAM_ODT_EN))
-			val = 0x0;
-		else
-			val = 0xaaaa;
-		clrsetbits_le32(&mctl_phy->dx[i].gcr[2], 0xffff, val);
+		/* TODO: DDR4 types ? */
+		for (i = 0; i < 4; i++)
+			writel(0x00000909, &mctl_phy->dx[i].gcr[5]);
 
-		if (IS_ENABLED(CONFIG_DRAM_ODT_EN))
-			val = 0x0;
-		else
-			val = 0x2020;
-		clrsetbits_le32(&mctl_phy->dx[i].gcr[3], 0x3030, val);
-	}
+		for (i = 0; i < 4; i++) {
+			if (IS_ENABLED(CONFIG_DRAM_ODT_EN))
+				val = 0x0;
+			else
+				val = 0xaaaa;
+			clrsetbits_le32(&mctl_phy->dx[i].gcr[2], 0xffff, val);
 
-	mctl_bit_delay_set(para);
-	udelay(1);
+			if (IS_ENABLED(CONFIG_DRAM_ODT_EN))
+				val = 0x0;
+			else
+				val = 0x2020;
+			clrsetbits_le32(&mctl_phy->dx[i].gcr[3], 0x3030, val);
+		}
 
-	setbits_le32(&mctl_phy->pgcr[6], BIT(0));
-	clrbits_le32(&mctl_phy->pgcr[6], 0xfff8);
-	for (i = 0; i < 4; i++)
-		clrbits_le32(&mctl_phy->dx[i].gcr[3], ~0x3ffff);
-	udelay(10);
+		mctl_bit_delay_set(para);
+		udelay(1);
+
+		setbits_le32(&mctl_phy->pgcr[6], BIT(0));
+		clrbits_le32(&mctl_phy->pgcr[6], 0xfff8);
+		for (i = 0; i < 4; i++)
+			clrbits_le32(&mctl_phy->dx[i].gcr[3], ~0x3ffff);
+		udelay(10);
+		val = readl(&mctl_phy->pgsr[0]) & 0xff00000;
+	} while (val && j++ < 64);
 
-	if (readl(&mctl_phy->pgsr[0]) & 0xff00000) {
+	if (val) {
 		/* Oops! There's something wrong! */
 		debug("PLL = %x\n", readl(0x3001010));
 		debug("DRAM PHY PGSR0 = %x\n", readl(&mctl_phy->pgsr[0]));
-- 
2.43.0

