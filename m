Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7897ECCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8DE8392C;
	Fri, 17 Oct 2025 17:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="MImxyUQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22DDD83857; Fri, 17 Oct 2025 17:26:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3234283826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7AD53262BB;
 Fri, 17 Oct 2025 17:26:33 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64v4QGAfaIQO; Fri, 17 Oct 2025 17:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714792; bh=MYTCyrL9fnhqVo+RD5uy+hJagYi6G7gj58VbXGsWFx4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MImxyUQFXci0y7bem4elBYn33rI8/U/8N7GOI/zScQkRYUKa4arGDw4k6nHpW9Uqs
 dnzOe7+hxrHCLlADkqmKlLJtw0ndgODf6rgqllk4STsUioXPwyziGOHbnR3/2ynSTJ
 jZWCZv7ZmxoQ7gVu80/RSY4xQLYoUTZD1ibqOMNC7Rx2bFxpxBG9S5nk+HBnFYG+9d
 xaMsDYDs/FJ0YBdAADzHXafXMv0DyOOSWEjHdo6FAxCNRDxfGhHm60lt0BWDxu4HBC
 xED+WDD+CCn7XiDKJoLn6mQvzgKABfgQZUJum40um9IvNecBWmqotQDE8LzZdGhuA2
 5qbfWjjEjBlxQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:12 +0530
Subject: [PATCH 7/9] mmc: exynos_dw_mmc: add support for MMC HS200 and
 HS400 modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=5141;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=MYTCyrL9fnhqVo+RD5uy+hJagYi6G7gj58VbXGsWFx4=;
 b=0hkyvNghteTaoVr4g+Y88JGTrkVZmNkeSvMih8nloTiQpjJ01asjPnJYf48yMltlDtY0CoCqk
 X0anFKgN635DX++Cf/W3NdHhodz53cdtCUZsY3TCbNzvi2yZJZsWe8F
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

MMC HS200 and HS400 modes are already supported by the Exynos DW-MMC
driver in mainline Linux. Using that as reference, add support in the
U-Boot driver.

The maximum frequency was capped to 50000000, increase it to 200000000,
which is the required frequency for HS200/HS400. Moreover, add
MMC_MODE_HS200 and MMC_MODE_HS400 to host capailities. These changes
allow both host and card to recognize support for HS200/HS400.

This change also includes a new ops function, namely execute_tuning.
Implementing it would mean that we can no longer rely on the default ops
provided by dw_mmc.c, thus a new ops instance is created with proper
fields. The execute_tuning function is modeled after the one available
in the Linux driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/exynos_dw_mmc.c | 88 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 12e37cb4b7884c5cdac0303245c93988d034459a..8311036109837d710ec141137684cd4f45ae449f 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -18,13 +18,18 @@
 #include <linux/printk.h>
 
 #define	DWMMC_MAX_CH_NUM		4
-#define	DWMMC_MAX_FREQ			52000000
+#define	DWMMC_MAX_FREQ			200000000
 #define	DWMMC_MIN_FREQ			400000
 #define	DWMMC_MMC0_SDR_TIMING_VAL	0x03030001
 #define	DWMMC_MMC2_SDR_TIMING_VAL	0x03020001
 
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
+/* CLKSEL register defines */
+#define CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
+#define CLKSEL_UP_SAMPLE(x, y)	(((x) & ~CLKSEL_CCLK_SAMPLE(7)) |\
+					 CLKSEL_CCLK_SAMPLE(y))
+
 /* Quirks */
 #define DWMCI_QUIRK_DISABLE_SMU		BIT(0)
 
@@ -166,8 +171,9 @@ static unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	u8 clk_div;
 	int err;
 
-	/* Should be double rate for DDR mode */
-	if (host->mmc->selected_mode == MMC_DDR_52 && host->mmc->bus_width == 8)
+	/* Should be double rate for DDR or HS mode */
+	if ((host->mmc->selected_mode == MMC_DDR_52 && host->mmc->bus_width == 8) ||
+	    host->mmc->selected_mode == MMC_HS_400)
 		freq *= 2;
 
 	clk_div = exynos_dwmmc_get_ciu_div(host);
@@ -282,6 +288,72 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
+{
+	u8 i;
+
+	for (i = 0; i < 8; i++) {
+		candidates = (candidates >> 1) | (candidates << 7); /* ror */
+		if ((candidates & 0xc7) == 0xc7)
+			return i;
+	}
+
+	for (i = 0; i < 8; i++) {
+		candidates = (candidates >> 1) | (candidates << 7); /* ror */
+		if ((candidates & 0x83) == 0x83)
+			return i;
+	}
+
+	/*
+	 * If no valid clock sample values are found, use the first
+	 * canditate bit for clock sample value.
+	 */
+	for (i = 0; i < 8; i++) {
+		candidates = (candidates >> 1) | (candidates << 7); /* ror */
+		if ((candidates & 0x1) == 0x1)
+			return i;
+	}
+
+	return -EIO;
+}
+
+static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
+{
+	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
+	struct dwmci_host *host = &priv->host;
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	u8 start_smpl, smpl, candidates = 0;
+	u32 clksel;
+	int ret;
+
+	clksel = dwmci_readl(host, priv->chip->clksel);
+	start_smpl = CLKSEL_CCLK_SAMPLE(clksel);
+
+	do {
+		dwmci_writel(host, DWMCI_TMOUT, ~0);
+
+		/* move to the next clksmpl */
+		smpl = (clksel + 1) & 0x7;
+		clksel = CLKSEL_UP_SAMPLE(clksel, smpl);
+		dwmci_writel(host, priv->chip->clksel, clksel);
+
+		if (!mmc_send_tuning(mmc, opcode))
+			candidates |= (1 << smpl);
+
+	} while (start_smpl != smpl);
+
+	ret = exynos_dwmmc_get_best_clksmpl(candidates);
+	if (ret < 0) {
+		printf("DWMMC%d: No candidates for clksmpl\n", host->dev_index);
+		return ret;
+	}
+
+	dwmci_writel(host, priv->chip->clksel,
+		     CLKSEL_UP_SAMPLE(clksel, ret));
+
+	return 0;
+}
+
 static int exynos_dwmmc_probe(struct udevice *dev)
 {
 	struct exynos_mmc_plat *plat = dev_get_plat(dev);
@@ -321,7 +393,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 
 	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
-	host->caps = MMC_MODE_DDR_52MHz;
+	host->caps = MMC_MODE_DDR_52MHz | MMC_MODE_HS200 | MMC_MODE_HS400;
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 
@@ -388,6 +460,12 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	{ }
 };
 
+struct dm_mmc_ops exynos_dwmmc_ops = {
+	.send_cmd	= dwmci_send_cmd,
+	.set_ios	= dwmci_set_ios,
+	.execute_tuning	= exynos_dwmmc_execute_tuning,
+};
+
 U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.name		= "exynos_dwmmc",
 	.id		= UCLASS_MMC,
@@ -395,7 +473,7 @@ U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.of_to_plat	= exynos_dwmmc_of_to_plat,
 	.bind		= exynos_dwmmc_bind,
 	.probe		= exynos_dwmmc_probe,
-	.ops		= &dm_dwmci_ops,
+	.ops		= &exynos_dwmmc_ops,
 	.priv_auto	= sizeof(struct dwmci_exynos_priv_data),
 	.plat_auto	= sizeof(struct exynos_mmc_plat),
 };

-- 
2.51.0

