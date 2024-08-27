Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52749C54736
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 20:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D27C88A8B;
	Tue, 27 Aug 2024 22:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724789094;
	bh=K1D4OX8OsIQbkM+yJFZ56qPMfO6LDPPqVuw5575ORhk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tq/Zqon86IXCQT7RAJ+tdqYQvy5hz2tyeYKNNYYfEyRepRatagOE/YOKRokcE6kw6
	 eeyKCBNpSlgYkthT5glODO0WH9oGqcsQ0zT7aNRC3CY798jpGOWQeAW6ZdCe0KGg2W
	 O1WCnVBD+d8c1f53OQya4QWlnQd+qVBSkDscQcmxCNP28iQ/Y4Gm5l/yHxmYPuToLY
	 F5J9nQbyROy+MGhYYLKy68bjkYeY34JUQ6llEZ/pBF0uYMt4ZJ3O1XrXfhaF5ZRoe0
	 LJqmJ2AdOfhMhg5n642VKUCCpVgvsWkIGfUtwxnd76lixA1o8diLZ0h+qPgzaAIsaG
	 gG+ELJVloAGJg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6069D88A30;
 Tue, 27 Aug 2024 22:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724789093;
 bh=K1D4OX8OsIQbkM+yJFZ56qPMfO6LDPPqVuw5575ORhk=;
 h=From:To:Cc:Subject:Date:From;
 b=OcIBZ+T2MupMb6EPKBZS2slEHQlsiWMcbkYFeNhie4PcqgxKYBYlHqGlrZfM+ajYs
 wd8yrYP4Ra/EmBCwWI3QKtVAKSbb+T667LAoSUkqg3sVo3GR2ZwgjVlB+VV5jf9ypK
 Gick+3F7m5TL0NTSf0Gcw99HdLdM1RJiPL7V5kpIFJeHNJIAIjNjT10n/yqetSFtzR
 Vw5pVfs2noJ14X83BL047Sc9oEoAxlBW5T5veJYyIr4DUUkoCksw4/6GoPTjkE/LfY
 SPRTj343nXHmtYuzz/HF8IQbKcc2niRwC/dJ52kIlcAT6jGfBROpmfwcVgX5y44wF0
 ZIuruMGNAh4Yg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: imx: Make PLL settings configurable at board level
Date: Tue, 27 Aug 2024 22:04:27 +0200
Message-ID: <20240827200441.217109-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Staticize intpll_configure(). Add weak board_imx_intpll_override()
function which can be defined at board level to override specific
PLL frequency settings early during boot. This can be used to for
example force faster CPU core clock frequency if the hardware can
handle it.

Example of increasing CPU core clock to 1600 MHz on i.MX8M Plus:
```
int board_imx_intpll_override(enum pll_clocks pll, ulong *freq)
{
       if (pll == ANATOP_ARM_PLL)
               *freq = MHZ(1600);
       return 0;
}
```

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index de630e940c9..d7fd102c955 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -181,10 +181,19 @@ void dram_disable_bypass(void)
 }
 #endif
 
-int intpll_configure(enum pll_clocks pll, ulong freq)
+__weak int board_imx_intpll_override(enum pll_clocks pll, ulong *freq)
+{
+	return 0;
+}
+
+static int intpll_configure(enum pll_clocks pll, ulong freq)
 {
 	void __iomem *pll_gnrl_ctl, __iomem *pll_div_ctl;
 	u32 pll_div_ctl_val, pll_clke_masks;
+	int ret = board_imx_intpll_override(pll, &freq);
+
+	if (ret)
+		return ret;
 
 	switch (pll) {
 	case ANATOP_SYSTEM_PLL1:
-- 
2.45.2

