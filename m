Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EB5CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1942838AB;
	Fri, 17 Oct 2025 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Wj4ZT0mg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911358382E; Fri, 17 Oct 2025 17:22:15 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E028051F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 86E1C25D61;
 Fri, 17 Oct 2025 17:22:13 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLIWTrAgGWyR; Fri, 17 Oct 2025 17:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714533; bh=D9iy6F4T+3dfgSLWVrmzdxVB2Mylb+oCCJbSXE2mmqg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Wj4ZT0mgZfPfHihE6DDst2RlfDyHQhq8Ova+6DWP7r9GolK/PP6lPbtvlEd+YXdc6
 GlcasyseOysJkZQ94ZbfnvRjVkKU+WxzPi3Rjjbt8FPQVPgoiCpRemy0p9R6BzfKKD
 C00Vvp/q148Ecw6ZM+7XeLfXN1UWLM0lu7u+TYdmxcedgM75FK42VrOTi9+qTgrPD2
 YlQ88VneXWbmwepThAJ4JaUDRj0J+10Eta7tunLZ4795FZUretG92247Klb2NnluxB
 +Rv77EzBOq1cDSsjajf+pryaBThc5zRI7+p6E4gnOJIlccyMTzwge05iPIWjXQwRFB
 AwvXCI0cBKmog==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:51:31 +0530
Subject: [PATCH 3/6] clk: exynos: add support for PLL1417X
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-clk-exynos7870-v1-3-83f90d425699@disroot.org>
References: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
In-Reply-To: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714499; l=1281;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=D9iy6F4T+3dfgSLWVrmzdxVB2Mylb+oCCJbSXE2mmqg=;
 b=EbHBzDjlxG9F9MShSLn/hl5E5sQaFG8f9XCelVTmltkcqyePrjzqOMTQ20f75FwJYFUFPWqoJ
 KYk8hMGkhSlBAGjf7qfa+hsQBdoz2YhFo9UQ8yc5N3smQMgwEnJVRIq
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:22:22 +0200
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

PLL1417X seem to be compatible with PLL0822X, as also seen in the
respective Linux kernel driver. Add an enum entry for the type, while
merely being an alias for PLL0822X.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/clk/exynos/clk-pll.c | 1 +
 drivers/clk/exynos/clk-pll.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
index fc7e638134a9529edac644d1dfff173adc3e1c5d..4b67591af109ff942e6487907c1e106495868a24 100644
--- a/drivers/clk/exynos/clk-pll.c
+++ b/drivers/clk/exynos/clk-pll.c
@@ -117,6 +117,7 @@ static struct clk *_samsung_clk_register_pll(void __iomem *base,
 
 	switch (pll_clk->type) {
 	case pll_0822x:
+	case pll_1417x:
 		drv_name = UBOOT_DM_CLK_SAMSUNG_PLL0822X;
 		break;
 	case pll_0831x:
diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
index 22cc15a40a4f8933d0e79da864f4f50b732c86a4..d5dfc8934ba90b31c5fa1ab002751f6b3a3819c1 100644
--- a/drivers/clk/exynos/clk-pll.h
+++ b/drivers/clk/exynos/clk-pll.h
@@ -20,6 +20,7 @@ struct samsung_pll_clock;
 enum samsung_pll_type {
 	pll_0822x,
 	pll_0831x,
+	pll_1417x,
 };
 
 void samsung_clk_register_pll(struct udevice *dev, void __iomem *base,

-- 
2.51.0

