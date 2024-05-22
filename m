Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F451C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 12:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0685788490;
	Wed, 22 May 2024 14:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E7288473; Wed, 22 May 2024 14:16:07 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF2488828
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 14:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i5e860cd9.versanet.de ([94.134.12.217] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1s9kt1-0000L4-2O; Wed, 22 May 2024 14:16:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: kever.yang@rock-chips.com,
	philipp.tomsich@vrull.eu,
	sjg@chromium.org
Cc: lukma@denx.de, seanga2@gmail.com, quentin.schulz@theobroma-systems.com,
 zhangqing@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH RESEND] clk: rockchip: rk3588: Set SPLL frequency during SPL
 stage
Date: Wed, 22 May 2024 14:15:59 +0200
Message-Id: <20240522121559.1024535-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

All parts expect the SPLL to run at 702MHz. In U-Boot it's the SPLL_HZ
declaring this rate and in the kernel it's a fixed clock definition.

While everything is expecting 702MHz, the SPLL is not running that
frequency when coming from the bootrom though, instead it's running
at 351MHz and the vendor-u-boot just sets it to the expected frequency.

The SPLL itself is located inside the secure-BUSCRU and in theory
accessible as an SCMI clock, though this requires an unknown amount
of cooperation from trusted-firmware to set at a later stage, though
during the SPL stage we can still access the relevant CRU directly.

The SPLL is for example necessary for the DSI controllers to produce
output.

As the SPLL is "just" another rk3588 pll, just set the desired rate
directly during the SPL stage.

Tested on rk3588-rock5b and rk3588-tiger by reading back the PLL rate
and also observing working DSI output with this change.

Fixes: 6737771600d4 ("rockchip: rk3588: Add support for sdmmc clocks in SPL")
Suggested-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>
---
Resend, because I forgot the u-boot list

 .../include/asm/arch-rockchip/cru_rk3588.h    |  1 +
 drivers/clk/rockchip/clk_rk3588.c             | 26 ++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index a4507e5fdd7..85b4da0bc2c 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -29,6 +29,7 @@ enum rk3588_pll_id {
 	V0PLL,
 	AUPLL,
 	PPLL,
+	SPLL,
 	PLL_COUNT,
 };
 
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 4c611a39049..5384b3213f5 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -37,6 +37,7 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
 	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
 	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
 	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
+	RK3588_PLL_RATE(702000000, 3, 351, 2, 0),
 	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
 	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
 	RK3588_PLL_RATE(200000000, 3, 400, 4, 0),
@@ -65,6 +66,11 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
 		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
+#ifdef CONFIG_SPL_BUILD
+	/* SBUSCRU MODE_CON has the same register offset as the main MODE_CON */
+	[SPLL] = PLL(pll_rk3588, 0, RK3588_PLL_CON(136),
+		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
+#endif
 };
 
 #ifndef CONFIG_SPL_BUILD
@@ -2044,6 +2050,7 @@ U_BOOT_DRIVER(rockchip_rk3588_cru) = {
 
 #ifdef CONFIG_SPL_BUILD
 #define SCRU_BASE			0xfd7d0000
+#define BUSSCRU_BASE			0xfd7d8000
 
 static ulong rk3588_scru_clk_get_rate(struct clk *clk)
 {
@@ -2118,15 +2125,28 @@ static ulong rk3588_scru_clk_set_rate(struct clk *clk, ulong rate)
 	return rk3588_scru_clk_get_rate(clk);
 }
 
+static int rk3588_scru_clk_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = rockchip_pll_set_rate(&rk3588_pll_clks[SPLL],
+				    (void *)BUSSCRU_BASE, SPLL, SPLL_HZ);
+	if (ret)
+		debug("%s setting spll rate failed %d\n", __func__, ret);
+
+	return 0;
+}
+
 static const struct clk_ops rk3588_scru_clk_ops = {
 	.get_rate = rk3588_scru_clk_get_rate,
 	.set_rate = rk3588_scru_clk_set_rate,
 };
 
 U_BOOT_DRIVER(rockchip_rk3588_scru) = {
-	.name = "rockchip_rk3588_scru",
-	.id = UCLASS_CLK,
-	.ops = &rk3588_scru_clk_ops,
+	.name	= "rockchip_rk3588_scru",
+	.id	= UCLASS_CLK,
+	.ops	= &rk3588_scru_clk_ops,
+	.probe	= rk3588_scru_clk_probe,
 };
 
 static int rk3588_scmi_spl_glue_bind(struct udevice *dev)
-- 
2.39.2

