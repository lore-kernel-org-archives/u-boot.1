Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D09D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6328783946;
	Sun, 30 Nov 2025 22:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2B583979; Sun, 30 Nov 2025 22:46:20 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1804D8389A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 06A17340E36;
 Sun, 30 Nov 2025 21:46:13 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 30 Nov 2025 21:45:13 +0000
Subject: [PATCH v2 04/10] clock: a733: implement support for mmc/uart
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-01-a733-soc-support-v2-4-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6247; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=O8c8LMvjYce2HQxHwg9d8WPQ8EomidHcZi3DDubTVj4=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLsCFGz7KCm23OWjfm5gXQHX02YELvAtQXZH6
 fxzgxALYk+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy7Al8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277eMPD/9LggdqYZR5C0ODKK
 8AjHhpi7B1wViDyd4xm910qsaAGwOCHrpvvcoxllZskawu6Dt6hlhb98IBSILSio6JqjvbS9nbY
 YK9MM+3yQjmbuZVXYHfyNlFNo0w7sWTVpoPmHsTwsPki0C6NF5hxsiJA76taXmJwOP4kkTHDDDE
 FirSepN2M1fMLuNGk4oqTqkQfmjlf4FUZWCTtWH/up9PVPKsQWPxdFWdZpV1f3/H6n7tF0ds4fl
 1F9CNQlKMNtDCAg03Mj2cNkDxWdfWwOz2uqF9BAA4gL/p7EpqELQ+LipupyZfHAYu37MqiEdPaD
 c7iscHMrpPodoT3rpJAV5rSmUMhhYXYY/lUHRLSAsh1B9mzI67HqCXy2ZaE12II1vHki+7slTQk
 /oRQGpQhYZNCPcGfUPOWDLYNubp00H4j4CMamxXotu4qf4p7icSapvbXARMFbXTmaQuhMeoftOz
 4FpXdJnSg2gtcpDMP9+zV+b5iQ4emZbkVrnsTaIhRfVBcckjrT+RAjp3ekfcwH9kCkyI5EW5wZn
 IL0Y9MB9ljv5g4Mk/JsSy4rb9us/pBFqOT0gYd29gTN2a0mpoVqw7ELPw0Vx/0th9ZOLHcWezeO
 XS2YwgcIyjZwDL9F23RRr9RGizUdKE6JLvh0yJ2JFbh3ElANQ4am+SIAg5F9oa8CYIzg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add clock initialization support to set UART/I2C/MMC clock frequency.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h | 31 +++++++++++++++++++
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h | 36 +++++++++++++++++++++++
 arch/arm/mach-sunxi/clock_sun50i_h6.c             | 14 ++++++---
 3 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 45fa4ab6e57..3783e5fc0e0 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -32,6 +32,25 @@
 #define CCU_H6_UART_GATE_RESET		0x90c
 #define CCU_H6_I2C_GATE_RESET		0x91c
 
+/* A733 CCU register offsets */
+#define CCU_A733_PLL6_CFG		0x0a0
+#define CCU_A733_APB_UART_CLK_CFG	0x538
+#define CCU_A733_UART_GATE_RESET	0xe00
+
+#ifdef CONFIG_MACH_SUN60I_A733				/* A733 */
+
+#define CCU_PLL6_CFG			CCU_A733_PLL6_CFG
+#define CCU_UART_CLK_CFG		CCU_A733_APB_UART_CLK_CFG
+#define CCU_UART_GATE_RESET		CCU_A733_UART_GATE_RESET
+
+#else										/* H6 */
+
+#define CCU_PLL6_CFG			CCU_H6_PLL6_CFG
+#define CCU_UART_CLK_CFG		CCU_H6_APB2_CFG
+#define CCU_UART_GATE_RESET		CCU_H6_UART_GATE_RESET
+
+#endif
+
 /* A523 CPU PLL offsets */
 #define CPC_CPUA_PLL_CTRL		0x04
 #define CPC_DSU_PLL_CTRL		0x08
@@ -65,7 +84,11 @@
 #define CCM_PLL5_CTRL_DIV2(div0)	((div0) << 1)
 
 /* pll6 bit field */
+#ifdef CONFIG_MACH_SUN60I_A733
+#define CCM_PLL6_CTRL_P0_SHIFT		20
+#else
 #define CCM_PLL6_CTRL_P0_SHIFT		16
+#endif
 #define CCM_PLL6_CTRL_P0_MASK		(0x7 << CCM_PLL6_CTRL_P0_SHIFT)
 #define CCM_PLL6_CTRL_N_SHIFT		8
 #define CCM_PLL6_CTRL_N_MASK		(0xff << CCM_PLL6_CTRL_N_SHIFT)
@@ -115,6 +138,14 @@
 #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002	    /* 200 MHz */
 #define CCM_APB1_DEFAULT		0x03000005	    /* APB0 really */
 #define CCM_APB2_DEFAULT		0x03000005	    /* APB1 really */
+
+#elif CONFIG_MACH_SUN60I_A733				/* A733 */
+
+#define CCM_PLL6_DEFAULT		0xee126310	    /* 1200/800/480 MHz */
+#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002	    /* 200 MHz */
+#define CCM_APB1_DEFAULT		0x03000005	    /* APB0 really */
+#define CCM_APB2_DEFAULT		0x03000005	    /* APB1 really */
+
 #endif
 
 /* apb2 bit field */
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index bcfdc0a41c5..e12a8c18c8f 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -7,6 +7,18 @@
 #ifndef _SUNXI_CPU_SUNXI_NCAT2_H
 #define _SUNXI_CPU_SUNXI_NCAT2_H
 
+#ifdef CONFIG_MACH_SUN60I_A733
+
+#define SUNXI_CCM_BASE			0x02002000
+#define SUNXI_TIMER_BASE		0x02052000
+
+#define SUNXI_TWI0_BASE			0x02510000
+#define SUNXI_TWI1_BASE			0x02511000
+#define SUNXI_TWI2_BASE			0x02512000
+#define SUNXI_TWI3_BASE			0x02513000
+
+#else
+
 #define SUNXI_CCM_BASE			0x02001000
 #define SUNXI_TIMER_BASE		0x02050000
 
@@ -15,11 +27,15 @@
 #define SUNXI_TWI2_BASE			0x02502800
 #define SUNXI_TWI3_BASE			0x02502C00
 
+#endif
+
 #define SUNXI_SRAMC_BASE		0x03000000
 /* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
 #define SUNXI_SIDC_BASE			0x03006000
 #define SUNXI_SID_BASE			0x03006200
+#ifndef CONFIG_MACH_SUN60I_A733
 #define SUNXI_GIC400_BASE		0x03020000
+#endif
 
 #ifdef CONFIG_MACH_SUN55I_A523
 #define SUNXI_DRAM_COM_BASE		0x03120000
@@ -27,10 +43,28 @@
 #define SUNXI_DRAM_PHY0_BASE		0x03140000
 #endif
 
+#ifdef CONFIG_MACH_SUN60I_A733
+#define SUNXI_GIC600_BASE		0x03400000
+#endif
+
 #define SUNXI_MMC0_BASE			0x04020000
 #define SUNXI_MMC1_BASE			0x04021000
 #define SUNXI_MMC2_BASE			0x04022000
 
+#ifdef CONFIG_MACH_SUN60I_A733
+
+#define SUNXI_PRCM_BASE			0x07010000
+#define SUNXI_R_WDOG_BASE		0x07021000
+#define SUNXI_R_CPUCFG_BASE		0x07050000
+#define SUNXI_R_TWI_BASE		0x07083000
+#define SUNXI_RTC_BASE			0x07090000
+
+#define SUNXI_CPUCFG_BASE		0x08860000
+
+#define SUNXI_CPU_PLL_CFG_BASE		0x08870000
+
+#else /* CONFIG_MACH_SUN60I_A733 */
+
 #ifndef CONFIG_MACH_SUN55I_A523
 #define SUNXI_R_CPUCFG_BASE		0x07000400
 #endif
@@ -50,6 +84,8 @@
 
 #define SUNXI_CPU_PLL_CFG_BASE		0x08817000
 
+#endif /* !CONFIG_MACH_SUN60I_A733 */
+
 #ifndef __ASSEMBLY__
 void sunxi_board_init(void);
 void sunxi_reset(void);
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 80004f13a1e..5ea27fc56c5 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -16,6 +16,10 @@ void clock_init_safe(void)
 	void *const ccm = (void *)SUNXI_CCM_BASE;
 	void *const prcm = (void *)SUNXI_PRCM_BASE;
 
+	/* skip clock init for A733 for now */
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return;
+
 	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
 		setbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, 0x10);
 	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
@@ -82,14 +86,14 @@ void clock_init_uart(void)
 	writel(APB2_CLK_SRC_OSC24M|
 	       APB2_CLK_RATE_N_1|
 	       APB2_CLK_RATE_M(1),
-	       ccm + CCU_H6_APB2_CFG);
+	       ccm + CCU_UART_CLK_CFG);
 
 	/* open the clock for uart */
-	setbits_le32(ccm + CCU_H6_UART_GATE_RESET,
+	setbits_le32(ccm + CCU_UART_GATE_RESET,
 		     1 << (CONFIG_CONS_INDEX - 1));
 
 	/* deassert uart reset */
-	setbits_le32(ccm + CCU_H6_UART_GATE_RESET,
+	setbits_le32(ccm + CCU_UART_GATE_RESET,
 		     1 << (RESET_SHIFT + CONFIG_CONS_INDEX - 1));
 }
 
@@ -236,7 +240,7 @@ int clock_twi_onoff(int port, int state)
 unsigned int clock_get_pll6(void)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
-	uint32_t rval = readl(ccm + CCU_H6_PLL6_CFG);
+	u32 rval = readl(ccm + CCU_PLL6_CFG);
 	int n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
 	int div2 = ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
 		    CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
@@ -257,6 +261,8 @@ unsigned int clock_get_pll6(void)
 	 */
 	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
 		m = 4;
+	else if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		m = 1;
 	else
 		m = 2;
 

-- 
2.51.2

