Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511ED606A33F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mi2NQ1Iu;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=OKj70LwF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA95760E9E;
	Fri, 13 Nov 2026 02:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9Jri2UxHWAP; Fri, 13 Nov 2026 02:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50F3B60E91
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537212;
	b=RGjE8POl/JDgRzl5AUStOHYyUZVERNZPg3J+21oiobEYwHmLEKh4LEIdAHebo4X+Ll1+
	 oxUxVZ5nE5ujuw9rr12tiuuuv37sRhoRn8oCtgWgxHKCI5f8qsE1U0SHvdfSV9U1FONxx
	 m0gwEQW7vt0PLBOrePfxrHdl5S8vBLRTNMtDY8wd8c+qLZpQT9EOXnCdsMD4hjpu74xq0
	 sD1w125kOeuT6YFrqyS654U5CDNwEHxfQnVzE1c+SlPO7+3X+XzGWyqE4enXAanSdaW2u
	 67dqKqhR0cIwG9dZwDYTc1uX77QEruTX0F1E3hkU5vPWsWrDzuTUN7EuNowrwJaXhoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hq9Qvhsc/EZuLb+01eFOH1Qm8cshH5O9cxClGJ4RUvM=;
	b=bI/ISWjCC4NCH07ciXwN0v7DLAUmzERSbFdcey9jsoI2wONIQQn8sXy8jLaU/53DJMlM
	 kIF7XdZlehv63T717ejIQsn7H+QnmNbrbp2nZ90RuMtel0WX4Bm4s9ObFOT7mntKtpdH6
	 0CGLX6suKZVxE6u9j1aQ7SJKhvZtABVFt3NB1sIEsmpvarEfV5OQqp6W9AowKgDtPLxEY
	 uEw8cB7x7gBIgAIcETAE1PfDndBp6+lwW31mBkGu1zdROr5g9kmxWvEyor9IIaT3rBTpb
	 7KHfv/FKoqYkNrXbo1Tnt4XOxN2wDU8I1EMe+XcvWkdvm+cXiGZ7f9pCDfcxHy93Ryg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537212;
	bh=hq9Qvhsc/EZuLb+01eFOH1Qm8cshH5O9cxClGJ4RUvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mi2NQ1IuJozjJJCll7+v7XOebZIUAc4q+wrW4UrCmMlQStJc90H/7ogZ4A2fLiQP7
	 bHHGF/eIeRm4s6RKXZo0lZFefEd3I69Onz381iVEdC3zX5Utfd/stitxJRXFSZRHy6
	 iOeP5SWprQUoRWAUWfAqX0VLzGZTIhuyB/+baZv31Ov+fR1M3ou39u++DIUg0yMS9F
	 Z12IsKtPvfm266n0lpZPNVlwYdNEa0+nAYmwg/xKw+2f5Y+ngp/iKy/+Nu64bAWHS1
	 +GP0uWAvYQWGOnrIDgYXO5U6Wy/MylMuE22j6RDLw4Ep84TizBQLYZjjQTd6TXRggj
	 kKyz4NllItuXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50F3B60E91;
	Fri, 13 Nov 2026 02:33:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E020DF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C600E400E6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6c2fulnjdug for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9991B40082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=OKj70LwF
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9991B40082
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:29 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 2E25E45738;
 Fri, 13 Nov 2026 13:33:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hq9Qvhsc/EZuLb+01eFOH1Qm8cshH5O9cxClGJ4RUvM=;
 b=OKj70LwFsN52zOC1L/NhvRSi7woQJl+vXxjOwH6J+jHjJXZysxEPdOym5Lr03CewfU434q
 ggXhOGlXDT9t80v8z/tuJX6c8N4haSkRnAN8v+QwkNytHrcSixVX8csYpWQOtzFln6gMPu
 ISnQatvrjJPesXKDyzszAY5kRvDFDj+oA72LTkh9YFf4T2BOrmDvoK/bauhXMHIGz6aFpu
 k/t1GoGJUGbX/ui25vygZQlm/Xurf8QO6tjgfodv9vYmSJdjayiTjzxyi4hXd/IhZjJQk7
 cqPe3cn5HlMYpDDt9wQow27SqPRK36iuidbFMNI8gx8jPCgCad+ZwW+IZtOzoA==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 09/26] clock: a733: implement support for mmc/uart
Date: Fri, 13 Nov 2026 13:32:19 +1100
Message-ID: <20261113023236.569054-10-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yixun Lan <dlan@gentoo.org>

Add peripheral base addresses and SPL clock initialization support for
UART, I2C, MMC, MBUS, and ZQ/pad resistor calibration on the Allwinner
A733 SoC.

Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-4-f19dcd098f60@gentoo.org
Signed-off-by: Yixun Lan <dlan@gentoo.org>
[Alastair: fix CPUCFG/WDT bases and PLL6 factor, add MBUS/RESCAL,
 I2C BGR, and PLL1 guard]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 19 +++++
 .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  | 42 ++++++++--
 arch/arm/mach-sunxi/clock_sun50i_h6.c         | 81 +++++++++++++++++--
 3 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
index 8d1c7c18548..2443cf36eb3 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
@@ -29,13 +29,30 @@
 #define CCU_NAND0_CLK_CFG		0x810
 #define CCU_NAND1_CLK_CFG		0x814
 #define CCU_H6_NAND_GATE_RESET		0x82c
+#if defined(CONFIG_MACH_SUN60I_A733)
+#define CCU_MMC0_CLK_CFG		0x0d00
+#define CCU_MMC1_CLK_CFG		0x0d10
+#define CCU_MMC2_CLK_CFG		0x0d20
+#else
 #define CCU_MMC0_CLK_CFG		0x830
 #define CCU_MMC1_CLK_CFG		0x834
 #define CCU_MMC2_CLK_CFG		0x838
+#endif
 #define CCU_H6_MMC_GATE_RESET		0x84c
 #define CCU_H6_UART_GATE_RESET		0x90c
 #define CCU_H6_I2C_GATE_RESET		0x91c
 
+/* A733 CCU register offsets */
+#define CCU_A733_PLL6_CFG		0x0a0
+#define CCU_A733_APB_UART_CFG		0x538
+#define CCU_A733_MMC_CLK_STRIDE		0x10
+#define CCU_A733_MMC_BGR_BASE		0x0d0c
+#define CCU_A733_MMC_BGR_REG(n)		(CCU_A733_MMC_BGR_BASE + (n) * CCU_A733_MMC_CLK_STRIDE)
+#define CCU_A733_UART_BGR_BASE		0x0e00
+#define CCU_A733_UART_BGR_REG(n)	(CCU_A733_UART_BGR_BASE + (n) * 4)
+#define CCU_A733_I2C_BGR_BASE		0x0e80
+#define CCU_A733_I2C_BGR_REG(n)		(CCU_A733_I2C_BGR_BASE + (n) * 4)
+
 /* A523 CPU PLL offsets */
 #define CPC_CPUA_PLL_CTRL		0x04
 #define CPC_DSU_PLL_CTRL		0x08
@@ -69,6 +86,8 @@
 #define CCM_PLL5_CTRL_DIV2(div0)	((div0) << 1)
 
 /* pll6 bit field */
+#define CCM_A733_PLL6_CTRL_P0_SHIFT	20
+#define CCM_A733_PLL6_CTRL_P0_MASK	(0x7 << CCM_A733_PLL6_CTRL_P0_SHIFT)
 #define CCM_PLL6_CTRL_P0_SHIFT		16
 #define CCM_PLL6_CTRL_P0_MASK		(0x7 << CCM_PLL6_CTRL_P0_SHIFT)
 #define CCM_PLL6_CTRL_N_SHIFT		8
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
index bcfdc0a41c5..260fed24741 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
@@ -7,19 +7,32 @@
 #ifndef _SUNXI_CPU_SUNXI_NCAT2_H
 #define _SUNXI_CPU_SUNXI_NCAT2_H
 
+#if defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_CCM_BASE			0x02002000
+#define SUNXI_WDT_BASE			0x02050000
+#define SUNXI_TIMER_BASE		0x02052000
+#define SUNXI_TWI0_BASE			0x02510000
+#define SUNXI_TWI1_BASE			0x02511000
+#define SUNXI_TWI2_BASE			0x02512000
+#define SUNXI_TWI3_BASE			0x02513000
+#else
 #define SUNXI_CCM_BASE			0x02001000
 #define SUNXI_TIMER_BASE		0x02050000
-
 #define SUNXI_TWI0_BASE			0x02502000
 #define SUNXI_TWI1_BASE			0x02502400
 #define SUNXI_TWI2_BASE			0x02502800
 #define SUNXI_TWI3_BASE			0x02502C00
+#endif
 
 #define SUNXI_SRAMC_BASE		0x03000000
 /* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
 #define SUNXI_SIDC_BASE			0x03006000
 #define SUNXI_SID_BASE			0x03006200
+#ifdef CONFIG_MACH_SUN60I_A733
+#define SUNXI_GIC600_BASE		0x03400000
+#else
 #define SUNXI_GIC400_BASE		0x03020000
+#endif
 
 #ifdef CONFIG_MACH_SUN55I_A523
 #define SUNXI_DRAM_COM_BASE		0x03120000
@@ -31,24 +44,37 @@
 #define SUNXI_MMC1_BASE			0x04021000
 #define SUNXI_MMC2_BASE			0x04022000
 
-#ifndef CONFIG_MACH_SUN55I_A523
-#define SUNXI_R_CPUCFG_BASE		0x07000400
-#endif
 #define SUNXI_PRCM_BASE			0x07010000
+#if defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_R_WDOG_BASE		0x07021000
+#else
 #define SUNXI_R_WDOG_BASE		0x07020400
-#ifdef CONFIG_MACH_SUN55I_A523
+#endif
+#if defined(CONFIG_MACH_SUN55I_A523) || defined(CONFIG_MACH_SUN60I_A733)
 #define SUNXI_R_CPUCFG_BASE		0x07050000
+#else
+#define SUNXI_R_CPUCFG_BASE		0x07000400
 #endif
+#if defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_R_TWI_BASE		0x07083000
+#else
 #define SUNXI_R_TWI_BASE		0x07081400
+#endif
 #define SUNXI_RTC_BASE			0x07090000
 
-#ifdef CONFIG_MACH_SUN55I_A523
+#if defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_CPUCFG_BASE		0x08000000
+#define SUNXI_CPU_DA_DDR_CTRL_REG	(SUNXI_CPUCFG_BASE + 0x0200)
+#define SUNXI_CLU0_CPU0_CTRL_REG	(SUNXI_CPUCFG_BASE + 0x1000)
+#define SUNXI_CLUSTER_CFG_BASE		0x08860000
+#define SUNXI_CPU_PLL_CFG_BASE		0x08870000
+#elif defined(CONFIG_MACH_SUN55I_A523)
 #define SUNXI_CPUCFG_BASE		0x08815000
+#define SUNXI_CPU_PLL_CFG_BASE		0x08817000
 #else
 #define SUNXI_CPUCFG_BASE		0x09010000
-#endif
-
 #define SUNXI_CPU_PLL_CFG_BASE		0x08817000
+#endif
 
 #ifndef __ASSEMBLY__
 void sunxi_board_init(void);
diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/clock_sun50i_h6.c
index 80004f13a1e..517fdcb56ea 100644
--- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
@@ -11,8 +11,47 @@
 #endif
 
 #ifdef CONFIG_XPL_BUILD
+#ifdef CONFIG_MACH_SUN60I_A733
+#define SUNXI_CCU_MBUS_MAT_CLK_GATING		(SUNXI_CCM_BASE + 0x05c0UL)
+#define SUNXI_CCU_MBUS_MAT_CLK_GATING_VAL	0x110103ffU
+#define SUNXI_CCU_MBUS_MAT_CLK_ENABLE		(SUNXI_CCM_BASE + 0x05e0UL)
+#define SUNXI_CCU_MBUS_MAT_CLK_ENABLE_VAL	0xf1055803U
+#define SUNXI_CCU_MBUS_MASTER_GATE		(SUNXI_CCM_BASE + 0x05e4UL)
+#define SUNXI_CCU_MBUS_MASTER_GATE_VAL		0x0007ffffU
+
+#define SUNXI_SYSCTRL_RESCAL_CTRL		(SUNXI_SRAMC_BASE + 0x0160UL)
+#define SUNXI_SYSCTRL_RESCAL_CTRL_EN		BIT(8)
+#define SUNXI_SYSCTRL_RESCAL_CAL		(SUNXI_SRAMC_BASE + 0x0168UL)
+#define SUNXI_SYSCTRL_RESCAL_CAL_MASK		0xffU
+
+/*
+ * On A733, the BROM configures PLL_PERIPH0 and APB/AXI root dividers before
+ * SPL entry, while TF-A BL31 (sunxi_security_setup) configures TrustZone SPC,
+ * CCU/PRCM security switches, and IOMMU bypass before Non-Secure EL2 entry.
+ * SPL only needs to ungate the MBUS matrix clocks and enable SYSCTRL ZQ/pad
+ * resistor calibration prior to LPDDR5 training.
+ */
+static void sunxi_a733_bus_and_rescal_init(void)
+{
+	writel(SUNXI_CCU_MBUS_MAT_CLK_GATING_VAL,
+	       (void __iomem *)SUNXI_CCU_MBUS_MAT_CLK_GATING);
+	writel(SUNXI_CCU_MBUS_MAT_CLK_ENABLE_VAL,
+	       (void __iomem *)SUNXI_CCU_MBUS_MAT_CLK_ENABLE);
+	writel(SUNXI_CCU_MBUS_MASTER_GATE_VAL,
+	       (void __iomem *)SUNXI_CCU_MBUS_MASTER_GATE);
+
+	setbits_le32((void __iomem *)SUNXI_SYSCTRL_RESCAL_CTRL,
+		     SUNXI_SYSCTRL_RESCAL_CTRL_EN);
+	clrbits_le32((void __iomem *)SUNXI_SYSCTRL_RESCAL_CAL,
+		     SUNXI_SYSCTRL_RESCAL_CAL_MASK);
+}
+#endif
+
 void clock_init_safe(void)
 {
+#ifdef CONFIG_MACH_SUN60I_A733
+	sunxi_a733_bus_and_rescal_init();
+#else
 	void *const ccm = (void *)SUNXI_CCM_BASE;
 	void *const prcm = (void *)SUNXI_PRCM_BASE;
 
@@ -72,12 +111,26 @@ void clock_init_safe(void)
 		writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3),
 		       ccm + CCU_H6_MBUS_CFG);
 	}
+#endif
 }
 
 void clock_init_uart(void)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
 
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733)) {
+		/* A733: APB_UART clock source is OSC24M / 1 */
+		writel(APB2_CLK_SRC_OSC24M |
+		       APB2_CLK_RATE_N_1 |
+		       APB2_CLK_RATE_M(1),
+		       ccm + CCU_A733_APB_UART_CFG);
+
+		/* Deassert reset and enable clock gate for console UART */
+		setbits_le32(ccm + CCU_A733_UART_BGR_REG(CONFIG_CONS_INDEX - 1),
+			     BIT(RESET_SHIFT) | BIT(GATE_SHIFT));
+		return;
+	}
+
 	/* uart clock source is apb2 */
 	writel(APB2_CLK_SRC_OSC24M|
 	       APB2_CLK_RATE_N_1|
@@ -199,6 +252,10 @@ void clock_set_pll1(unsigned int clk)
 
 	clk /= 24000000;
 
+	/* BROM and TF-A configure cluster PLLs on A733 */
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return;
+
 	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
 		clock_a523_set_cpu_plls(clk);
 	else
@@ -217,6 +274,9 @@ int clock_twi_onoff(int port, int state)
 	if (port == 5) {
 		shift = 0;
 		ptr = prcm + CCU_PRCM_I2C_GATE_RESET;
+	} else if (IS_ENABLED(CONFIG_MACH_SUN60I_A733)) {
+		shift = 0;
+		ptr = ccm + CCU_A733_I2C_BGR_REG(port);
 	} else {
 		shift = port;
 		ptr = ccm + CCU_H6_I2C_GATE_RESET;
@@ -236,13 +296,22 @@ int clock_twi_onoff(int port, int state)
 unsigned int clock_get_pll6(void)
 {
 	void *const ccm = (void *)SUNXI_CCM_BASE;
-	uint32_t rval = readl(ccm + CCU_H6_PLL6_CFG);
-	int n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
-	int div2 = ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
-		    CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
-	int div1, m;
+	int div1, div2, m, n;
+	u32 rval;
+
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		rval = readl(ccm + CCU_A733_PLL6_CFG);
+	else
+		rval = readl(ccm + CCU_H6_PLL6_CFG);
+
+	n = ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
+	div2 = ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
+		CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
 
-	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733)) {
+		div1 = ((rval & CCM_A733_PLL6_CTRL_P0_MASK) >>
+			CCM_A733_PLL6_CTRL_P0_SHIFT) + 1;
+	} else if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
 		div1 = ((rval & CCM_PLL6_CTRL_P0_MASK) >>
 			CCM_PLL6_CTRL_P0_SHIFT) + 1;
 	} else {
-- 
2.53.0

