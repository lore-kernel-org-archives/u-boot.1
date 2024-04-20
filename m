Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A53C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4F3885D7;
	Sat, 20 Apr 2024 02:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="sUXvI2Jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BE5885D7; Sat, 20 Apr 2024 02:03:47 +0200 (CEST)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [IPv6:2001:41d0:203:375::af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98ED88634
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMzPyHXbOQWPIO3wvZEVMLraltX+9cKUlUqGJ6gLShs=;
 b=sUXvI2Jm835LJGx4Y2xKbEuuBY06xX67INHrZst8KeF+aS9jtVjRZrRDbnmh1iS6U8d1/P
 tk2CIOVQZalFO7RSMycI8qrJUQqK68x0mCQuGfrsQXQpmiHKlLcGunlfw6N1ljxb3qxlpN
 UgzwO7/4LZ4WZ1imwMT2jcE3rOfHa1A3A832x318ncKsbuuGe/w3EyGvClxT8/qBYOiVZo
 I84QtDujy7D1KK5ync8+dgOG1nV1F8PAyNgUzVrZBrausbds+aNDYsfrPcaLUovGbkgKaR
 rrgYF3mZnAZQe7lUueinolqx1iBpzP0owehwRJPKw4Nsr0rQCfG1C/oTbf80Xg==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:34 +1000
Subject: [PATCH RFC 1/9] sunxi: clock: support H6/D1 video clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-1-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571363; l=5736;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=xEXLRG7YN7TAro4qiYtYHZoWTBViz32rLkH19ffOWrw=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABA8kpcAD0J9P6osJxBLOVfIoZ
 LGxJjS3mOoqrd0lOv0LOjUF1PG7w9ue2ddV5pPHG2j7kMgPxClz2k50e2vYeOAQUAAOoV
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This code adds support for clocking VIDEO0 and VIDEO1, as well as
registers used for the DE2.

This code deliberately uses a 12MHz step in clocking to align with
the DE2 code's expectation of double 6MHz steps.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h | 56 ++++++++++++++++++
 arch/arm/mach-sunxi/clock_sun50i_h6.c             | 71 +++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index a84a57e5b4..dfe8d9315f 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -236,6 +236,28 @@ struct sunxi_ccm_reg {
 #define CCM_PLL1_CTRL_P(p)		((p) << 16)
 #define CCM_PLL1_CTRL_N(n)		(((n) - 1) << 8)
 
+/* pll3 (video0) bit field */
+#define CCM_PLL3_CTRL_EN		BIT(31)
+#define CCM_PLL3_LDO_EN			BIT(30)
+#define CCM_PLL3_LOCK_EN		BIT(29)
+#define CCM_PLL3_LOCK			BIT(28)
+#define CCM_PLL3_OUT_EN			BIT(27)
+#define CCM_PLL3_INPUT_DIV2		BIT(1)
+#define CCM_PLL3_CTRL_N(n)		(((n) - 1) << 8)
+#define CCM_PLL3_CTRL_N_SHIFT		8
+#define CCM_PLL3_CTRL_N_MASK		(0xff << CCM_PLL3_CTRL_N_SHIFT)
+
+/* video1 bit field */
+#define CCM_VIDEO1_CTRL_EN		BIT(31)
+#define CCM_VIDEO1_LDO_EN		BIT(30)
+#define CCM_VIDEO1_LOCK_EN		BIT(29)
+#define CCM_VIDEO1_LOCK			BIT(28)
+#define CCM_VIDEO1_OUT_EN		BIT(27)
+#define CCM_VIDEO1_INPUT_DIV2		BIT(1)
+#define CCM_VIDEO1_CTRL_N(n)		(((n) - 1) << 8)
+#define CCM_VIDEO1_CTRL_N_SHIFT		8
+#define CCM_VIDEO1_CTRL_N_MASK		(0xff << CCM_VIDEO1_CTRL_N_SHIFT)
+
 /* pll5 bit field */
 #define CCM_PLL5_CTRL_EN		BIT(31)
 #define CCM_PLL5_LOCK_EN		BIT(29)
@@ -258,6 +280,16 @@ struct sunxi_ccm_reg {
 #define CCM_PLL6_CTRL_DIV2_SHIFT	1
 #define CCM_PLL6_CTRL_DIV2_MASK		(0x1 << CCM_PLL6_CTRL_DIV2_SHIFT)
 
+/* pll10 bit field */
+#define CCM_PLL10_CTRL_EN		BIT(31)
+#define CCM_PLL10_LOCK_EN		BIT(29)
+#define CCM_PLL10_LOCK			BIT(28)
+#define CCM_PLL10_OUT_EN		BIT(27)
+#define CCM_PLL10_INPUT_DIV2		BIT(1)
+#define CCM_PLL10_CTRL_N(n)		(((n) - 1) << 8)
+#define CCM_PLL10_CTRL_N_SHIFT		8
+#define CCM_PLL10_CTRL_N_MASK		(0xff << CCM_PLL10_CTRL_N_SHIFT)
+
 /* cpu_axi bit field*/
 #define CCM_CPU_AXI_MUX_MASK		(0x3 << 24)
 #define CCM_CPU_AXI_MUX_OSC24M		(0x0 << 24)
@@ -341,9 +373,33 @@ struct sunxi_ccm_reg {
 #define CCM_MMC_CTRL_OCLK_DLY(a)	((void) (a), 0)
 #define CCM_MMC_CTRL_SCLK_DLY(a)	((void) (a), 0)
 
+/* TCON0 clock bit field */
+#define CCM_TCON0_CTRL_ENABLE		(0x1 << 31)
+#define CCM_TCON0_CTRL_VIDEO0_4X	(0x1 << 24)
+#define CCM_TCON0_CTRL_M(m)		((((m) - 1) & 0xf) << 0)
+
+/* TCON1 clock bit field */
+#define CCM_TCON1_CTRL_ENABLE		(0x1 << 31)
+#define CCM_TCON1_CTRL_VIDEO0_4X	(0x1 << 24)
+#define CCM_TCON1_CTRL_M(m)		((((m) - 1) & 0xf) << 0)
+
+/* CCM bits common to all Display Engine 2.0 clock ctrl regs */
+#define CCM_DE2_CTRL_M(n)		((((n) - 1) & 0xf) << 0)
+#define CCM_DE2_CTRL_PLL_MASK		(3 << 24)
+#define CCM_DE2_CTRL_PLL10_H6		(0 << 24)
+#define CCM_DE2_CTRL_VIDEO1_4X_NCAT	(2 << 24)
+#define CCM_DE2_CTRL_GATE		(0x1 << 31)
+
 #ifndef __ASSEMBLY__
 void clock_set_pll1(unsigned int hz);
 unsigned int clock_get_pll6(void);
+
+#ifdef CONFIG_SUNXI_DE2
+void clock_set_pll3(unsigned int hz);
+void clock_set_video1(unsigned int hz);
+void clock_set_pll10(unsigned int hz);
+unsigned int clock_get_pll3(void);
+#endif
 #endif
 
 #endif /* _SUNXI_CLOCK_SUN50I_H6_H */
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index dac3663e1b..11e303f801 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -160,3 +160,74 @@ int clock_twi_onoff(int port, int state)
 
 	return 0;
 }
+
+#ifdef CONFIG_SUNXI_DE2
+
+void clock_set_pll3(unsigned int clk)
+{
+	struct sunxi_ccm_reg * const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+
+	if (clk == 0) {
+		clrbits_le32(&ccm->pll3_cfg, CCM_PLL3_CTRL_EN);
+		return;
+	}
+
+	/* PLL3 rate = 24000000 * n / 2 */
+	writel(CCM_PLL3_CTRL_EN | CCM_PLL3_LOCK_EN | CCM_PLL3_OUT_EN | CCM_PLL3_LDO_EN |
+	       CCM_PLL3_INPUT_DIV2 | CCM_PLL3_CTRL_N(clk / 12000000),
+	       &ccm->pll3_cfg);
+
+	while (!(readl(&ccm->pll3_cfg) & CCM_PLL3_LOCK))
+		;
+}
+
+void clock_set_video1(unsigned int clk)
+{
+	struct sunxi_ccm_reg * const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+
+	if (clk == 0) {
+		clrbits_le32(&ccm->pll_video1_cfg, CCM_VIDEO1_CTRL_EN);
+		return;
+	}
+
+	/* VIDEO1 rate = 24000000 * n / 2 */
+	writel(CCM_VIDEO1_CTRL_EN | CCM_VIDEO1_LOCK_EN | CCM_VIDEO1_OUT_EN | CCM_VIDEO1_LDO_EN |
+	       CCM_VIDEO1_INPUT_DIV2 | CCM_VIDEO1_CTRL_N(clk / 12000000),
+	       &ccm->pll_video1_cfg);
+
+	while (!(readl(&ccm->pll_video1_cfg) & CCM_VIDEO1_LOCK))
+		;
+}
+
+void clock_set_pll10(unsigned int clk)
+{
+	struct sunxi_ccm_reg * const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+
+	if (clk == 0) {
+		clrbits_le32(&ccm->pll10_cfg, CCM_PLL10_CTRL_EN);
+		return;
+	}
+
+	/* PLL10 rate = 24000000 * n / 2 */
+	writel(CCM_PLL10_CTRL_EN | CCM_PLL10_LOCK_EN | CCM_PLL10_OUT_EN |
+	       CCM_PLL10_INPUT_DIV2 | CCM_PLL10_CTRL_N(clk / 12000000),
+	       &ccm->pll_video1_cfg);
+
+	while (!(readl(&ccm->pll_video1_cfg) & CCM_PLL10_LOCK))
+		;
+}
+
+unsigned int clock_get_pll3(void)
+{
+	struct sunxi_ccm_reg *const ccm =
+		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	u32 rval = readl(&ccm->pll3_cfg);
+	int n = ((rval & CCM_PLL3_CTRL_N_MASK) >> CCM_PLL3_CTRL_N_SHIFT) + 1;
+
+	return 12000 * n * 1000;
+}
+
+#endif

-- 
2.44.0

