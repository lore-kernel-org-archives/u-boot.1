Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC86D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DB083B85;
	Fri, 23 Jan 2026 12:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="s3DqZ5LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE1B83B91; Fri, 23 Jan 2026 12:45:54 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC4B83B82
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A1BEDC20308;
 Fri, 23 Jan 2026 11:45:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6AB6E6070A;
 Fri, 23 Jan 2026 11:45:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F9C8119A87C1; Fri, 23 Jan 2026 12:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168750; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=m1WMCoU/uNbZpwH0nTjcoDTJGXR9fa+INtIknz5liK8=;
 b=s3DqZ5LU7/lI/eHq9fFOSxM6XdGSf6oaUOYx2ZFW10AMH+rFt0CFYiLytz8KMx4KDc+boU
 hYPV4gSZzrJdJbkFTBzQ58hY870RLOvxUsi9qt2bfk4ZJ6nE2CxRkXt0ySnFoRWbPVwT+d
 RzbA1WfBgy7WIarF5pDWTDtUNBV4GVfH9V+gB87xGD67OBotPvk9KX60uI4RCWzmb3sOan
 vprQJnl7bSmbfvceOzmYzSKLXJnbD55H3WE10W8wuNdjpbS+y/mXdwxF/1Qgi1UPoigVIb
 VhiGlAdPpMSXBYON6LuD5j66SUlIrI0EqA3ugLp7RfdpKYdnh7a3XblHu8YFBg==
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
Subject: [PATCH v3 05/26] mtd: rawnand: sunxi: remove usage of struct
 sunxi_ccm_reg
Date: Fri, 23 Jan 2026 12:44:40 +0100
Message-ID: <20260123114507.1400918-6-richard.genoud@bootlin.com>
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

The sunxi_ccm_reg is legacy, drop its usage from nand related code

For that, CCU_NAND0_CLK_CFG and CCU_AHB_GATE1 are added to the clock
files when missing.
And clock code in sunxi_nand{,_spl}.c and board.c are changed to use the
new scheme.

Moreover, drop AHB_DIV_1 in favor of the more readable CCM_NAND_CTRL_M/N

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 arch/arm/include/asm/arch-sunxi/clock_sun4i.h      |  1 +
 arch/arm/include/asm/arch-sunxi/clock_sun6i.h      |  1 +
 arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h |  1 +
 arch/arm/include/asm/arch-sunxi/clock_sun9i.h      |  2 ++
 board/sunxi/board.c                                | 11 ++++++-----
 drivers/mtd/nand/raw/sunxi_nand.c                  | 11 +++++------
 drivers/mtd/nand/raw/sunxi_nand_spl.c              | 13 +++++++------
 7 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
index 00bdd5f938df..caa4b62b3e2d 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
@@ -11,6 +11,7 @@
 #define _SUNXI_CLOCK_SUN4I_H
 
 #define CCU_AHB_GATE0		0x60
+#define CCU_NAND0_CLK_CFG	0x80
 #define CCU_MMC0_CLK_CFG	0x88
 #define CCU_MMC1_CLK_CFG	0x8c
 #define CCU_MMC2_CLK_CFG	0x90
diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun6i.h b/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
index 28c3faccbbcf..c8f3a16e7d05 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun6i.h
@@ -11,6 +11,7 @@
 #define _SUNXI_CLOCK_SUN6I_H
 
 #define CCU_AHB_GATE0		0x060
+#define CCU_NAND0_CLK_CFG	0x080
 #define CCU_MMC0_CLK_CFG	0x088
 #define CCU_MMC1_CLK_CFG	0x08c
 #define CCU_MMC2_CLK_CFG	0x090
diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
index 5ad2163926ad..98c69f47f321 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun8i_a83t.h
@@ -14,6 +14,7 @@
 #define _SUNXI_CLOCK_SUN8I_A83T_H
 
 #define CCU_AHB_GATE0		0x060
+#define CCU_NAND0_CLK_CFG	0x080
 #define CCU_MMC0_CLK_CFG	0x088
 #define CCU_MMC1_CLK_CFG	0x08c
 #define CCU_MMC2_CLK_CFG	0x090
diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
index 8d696e533f8f..3448f3fb3225 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun9i.h
@@ -12,11 +12,13 @@
 #include <linux/bitops.h>
 #endif
 
+#define CCU_NAND0_CLK_CFG	0x400
 #define CCU_MMC0_CLK_CFG	0x410
 #define CCU_MMC1_CLK_CFG	0x414
 #define CCU_MMC2_CLK_CFG	0x418
 #define CCU_MMC3_CLK_CFG	0x41c
 #define CCU_AHB_GATE0		0x580
+#define CCU_AHB_GATE1		0x584
 #define CCU_AHB_RESET0_CFG	0x5a0
 
 struct sunxi_ccm_reg {
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 2929bc17f084..09b531b7f52a 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -307,15 +307,16 @@ static void nand_pinmux_setup(void)
 
 static void nand_clock_setup(void)
 {
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void * const ccm = (void *)SUNXI_CCM_BASE;
 
-	setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
+	setbits_le32(ccm + CCU_AHB_GATE0,
+		     (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
 #if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
     defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
-	setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
+	setbits_le32(ccm + CCU_AHB_RESET0_CFG, (1 << AHB_GATE_OFFSET_NAND0));
 #endif
-	setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
+	setbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
+		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
 }
 
 void board_nand_init(void)
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index c6b9b2a4ebac..ba2740ed1876 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -289,8 +289,7 @@ static inline struct sunxi_nfc *to_sunxi_nfc(struct nand_hw_control *ctrl)
 
 static void sunxi_nfc_set_clk_rate(unsigned long hz)
 {
-	struct sunxi_ccm_reg *const ccm =
-	(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void * const ccm = (void *)SUNXI_CCM_BASE;
 	int div_m, div_n;
 
 	div_m = (clock_get_pll6() + hz - 1) / hz;
@@ -305,14 +304,14 @@ static void sunxi_nfc_set_clk_rate(unsigned long hz)
 	/* config mod clock */
 	writel(CCM_NAND_CTRL_ENABLE | CCM_NAND_CTRL_PLL6 |
 	       CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
-	       &ccm->nand0_clk_cfg);
+	       ccm + CCU_NAND0_CLK_CFG);
 
 	/* gate on nand clock */
-	setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_NAND0));
+	setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_NAND0));
 #ifdef CONFIG_MACH_SUN9I
-	setbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
+	setbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
 #else
-	setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
+	setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
 #endif
 }
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index bd6fcd07be50..ab569d8086a3 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -531,14 +531,15 @@ unsigned int nand_page_size(void)
 
 void nand_deselect(void)
 {
-	struct sunxi_ccm_reg *const ccm =
-		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	void * const ccm = (void *)SUNXI_CCM_BASE;
 
-	clrbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
+	clrbits_le32(ccm + CCU_AHB_GATE0,
+		     (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
 #ifdef CONFIG_MACH_SUN9I
-	clrbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
+	clrbits_le32(ccm + CCU_AHB_GATE1, (1 << AHB_GATE_OFFSET_DMA));
 #else
-	clrbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
+	clrbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
 #endif
-	clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
+	clrbits_le32(ccm + CCU_NAND0_CLK_CFG, CCM_NAND_CTRL_ENABLE |
+		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
 }
-- 
2.47.3

