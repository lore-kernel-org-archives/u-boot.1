Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A6DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 01:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD3688758A;
	Sat,  2 Dec 2023 02:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701481751;
	bh=vdLow1VHj1Has3RXdJyrB6GR/NhxxulfFWtDQ+koB4w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I3W2uel4++wg4mp2pxpbrhlLfYW6vZhiX4nAEm3VNwp3/tL9/25NU5iFtuokZoRYH
	 StKE6dqDzw2ZNmRNWpMcWJ31DF86CDnDyTCSgNp/dkpwrha2QbnIHXdVMWu9PywKMl
	 p8tu80cjW/+GkVmJZ0Zte6ejzd63sZ/rxF1O3CKQbcV9y5Er3VHUc4u8k3KwYl5bqd
	 BTXeECd8wshgZBEdKfzxFT4f4xQoE7cjIXpmlr7cZqH/pqOLEcJtnnYIs17V0vSPfR
	 sE/88jcHCXzziJ4BoKhENQgKgzN9oXXzjkoID8qVKfR7owKZqyraL+CaC1zmrwcw8P
	 rZopge0kHJ0RQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1081187444;
 Sat,  2 Dec 2023 02:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701481751;
 bh=vdLow1VHj1Has3RXdJyrB6GR/NhxxulfFWtDQ+koB4w=;
 h=From:To:Cc:Subject:Date:From;
 b=l+8I6l7xxDwuRmhA7YZT0wVznV/Uxfsk2tieDD7xxF+5CMvw6N/QJuJggBvk1aH1Q
 E8vBPgvvaQqQmOql0OPvnR7FeR4KIhFhRxTYDwlFi288evgxvIeXSMvxMsIjY+WX6a
 /7OXwKsYCZfq76tMzkHtBTeiM69+R2uqb2g0V4r6ksQMXHRqbOnqrD+Ky6H1w6cFiS
 fKxBXxu+hzsMED1WymE9oJut41Q5WhRDJbKtHy6zITuQ+qSQlUSX/aljkJ/Ucpcz9r
 s40o4rpZPbZc40nWmbzXv3L3erNOxIynF6IzH3SkLUZErnw00r+bI+tNmrt2FEoCCO
 +ES0HHTnsU7/w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] ddr: imx: Add 3600 MTps rate support
Date: Sat,  2 Dec 2023 02:48:40 +0100
Message-ID: <20231202014906.212885-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Add PLL settings for DDR 3600 MTps . This is very similar to 3200 MTps
PLL setting, except the divider is not 9 but 8 .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c | 1 +
 drivers/ddr/imx/phy/ddrphy_utils.c     | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index 986870799d3..a24eb744601 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -56,6 +56,7 @@ int enable_i2c_clk(unsigned char enable, unsigned i2c_num)
 static struct imx_int_pll_rate_table imx8mm_fracpll_tbl[] = {
 	PLL_1443X_RATE(1000000000U, 250, 3, 1, 0),
 	PLL_1443X_RATE(933000000U, 311, 4, 1, 0),
+	PLL_1443X_RATE(900000000U, 300, 8, 0, 0),
 	PLL_1443X_RATE(800000000U, 300, 9, 0, 0),
 	PLL_1443X_RATE(750000000U, 250, 8, 0, 0),
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index d5dac0fce92..45e1a70dbd4 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -117,6 +117,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(933));
 		dram_disable_bypass();
 		break;
+	case 3600:
+		dram_pll_init(MHZ(900));
+		dram_disable_bypass();
+		break;
 	case 3200:
 		dram_pll_init(MHZ(800));
 		dram_disable_bypass();
-- 
2.42.0

