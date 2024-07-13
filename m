Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA43C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3684788747;
	Sat, 13 Jul 2024 15:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M8SPfIm5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iqnHMp3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FB188836; Sat, 13 Jul 2024 15:21:18 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697E486E40
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpy40j7Fz9sTd;
 Sat, 13 Jul 2024 15:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SNfyAVlzYDWFV5IoNb9t/Uc/hr0riywrmQw8Nm71EM=;
 b=M8SPfIm5ryD8uxEHRUeH1wKx5z2RcApn00xNkf/pKwCtQ3PcRsMPNeE4iKy/6pjn1zgui5
 zuDu+tfIpv5JPRhhPPxQS4t91YjiH++zgGFTWv51tcHQAWt8k4RTKou+Nr6uKrVpZ+fHc0
 A4ncycgo5xxCLpTqn2lobLBRkg5DeULG9IjwqpPufFgpUehhqi6vFP5zES9m2lY/AOJsXj
 cN4o2yl1tIezqVZMb2w8ZiL3aecc2YZdKUcJMI5wFceRyTghoHHh0HNBgM5g/epBKHSKin
 xiK5DcQ2F2WPXksAritTGOvaS+x464mKgB949vAL2tr3wHkOpNZfWDZWLdSJzg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SNfyAVlzYDWFV5IoNb9t/Uc/hr0riywrmQw8Nm71EM=;
 b=iqnHMp3HdXCikOMpaYuTLYZm1FzEvFfj5GexLlltO9GmAqz5zoHJDbP53TD4IucPSw010J
 CAdpZrnMDxHygOGA/O6PKKWlokZEHhNDgS3AOpBr7hX9w/SRUGenxEShdnUf5JBvqaIi4g
 jm/KCIgbdaGieQXdLEWkhimQ5aqgcBfskRqn1S0C5EzgaEFBuUUPfoMOaaMqEYewSJJuV7
 3BG8c29CtiwivchbnYCIZXfql4UxKk0bHqBQC+mNzAwPl4wiHlb8otkYLpxKS+zlaoOE3h
 zG+2tNmKWta17gCIXcv2mfEYJaxtWKsH2XvmojRrlnIsQJRaDuN5mLSbLCxOfA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/45] arm: include: imx: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:00 +0200
Message-ID: <20240713132021.57650-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 01297411f3b1c329e23
X-MBO-RS-META: 7zk8cctt419croa9eqooudpgeuqubeeg
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-mx27/gpio.h       | 1 -
 arch/arm/include/asm/arch-mx27/imx-regs.h   | 1 -
 arch/arm/include/asm/arch-mx31/gpio.h       | 1 -
 arch/arm/include/asm/arch-mx31/imx-regs.h   | 2 --
 arch/arm/include/asm/arch-mx5/gpio.h        | 1 -
 arch/arm/include/asm/arch-mx6/gpio.h        | 1 -
 arch/arm/include/asm/arch-mx6/imx-regs.h    | 1 -
 arch/arm/include/asm/arch-mx7/crm_regs.h    | 4 ----
 arch/arm/include/asm/arch-mx7/imx-regs.h    | 2 --
 arch/arm/include/asm/arch-mx7ulp/imx-regs.h | 2 --
 arch/arm/include/asm/arch-mx7ulp/iomux.h    | 2 --
 arch/arm/include/asm/arch-mx7ulp/pcc.h      | 3 ---
 arch/arm/include/asm/arch-mx7ulp/scg.h      | 1 -
 13 files changed, 22 deletions(-)

diff --git a/arch/arm/include/asm/arch-mx27/gpio.h b/arch/arm/include/asm/arch-mx27/gpio.h
index 9f342eb7f71..af05d1eb887 100644
--- a/arch/arm/include/asm/arch-mx27/gpio.h
+++ b/arch/arm/include/asm/arch-mx27/gpio.h
@@ -4,7 +4,6 @@
  * Philippe Reynes <tremyfr@yahoo.fr>
  */
 
-
 #ifndef __ASM_ARCH_MX27_GPIO_H
 #define __ASM_ARCH_MX27_GPIO_H
 
diff --git a/arch/arm/include/asm/arch-mx27/imx-regs.h b/arch/arm/include/asm/arch-mx27/imx-regs.h
index 77794d7d03d..60499189b2c 100644
--- a/arch/arm/include/asm/arch-mx27/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx27/imx-regs.h
@@ -236,7 +236,6 @@ struct fuse_bank0_regs {
 #define SDCS1_SEL	(1 << 1)
 #define SDCS0_SEL	(1 << 0)
 
-
 /* important definition of some bits of WCR */
 #define WCR_WDE 0x04
 
diff --git a/arch/arm/include/asm/arch-mx31/gpio.h b/arch/arm/include/asm/arch-mx31/gpio.h
index 45e9fc61937..1bfe28f95c9 100644
--- a/arch/arm/include/asm/arch-mx31/gpio.h
+++ b/arch/arm/include/asm/arch-mx31/gpio.h
@@ -4,7 +4,6 @@
  * Stefano Babic, DENX Software Engineering, <sbabic@denx.de>
  */
 
-
 #ifndef __ASM_ARCH_MX31_GPIO_H
 #define __ASM_ARCH_MX31_GPIO_H
 
diff --git a/arch/arm/include/asm/arch-mx31/imx-regs.h b/arch/arm/include/asm/arch-mx31/imx-regs.h
index a0ab3a0e665..a608732f765 100644
--- a/arch/arm/include/asm/arch-mx31/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx31/imx-regs.h
@@ -585,7 +585,6 @@ struct esdc_regs {
 #define GET_PLL_MFI(x)		(((x) >> 10) & 0xf)
 #define GET_PLL_MFN(x)		(((x) >> 0) & 0x3ff)
 
-
 #define WEIM_ESDCTL0	0xB8001000
 #define WEIM_ESDCFG0	0xB8001004
 #define WEIM_ESDCTL1	0xB8001008
@@ -777,7 +776,6 @@ struct esdc_regs {
 #define MUX_CTL_NFC_ALE		0xD6
 #define MUX_CTL_NFC_CLE		0xD7
 
-
 #define MUX_CTL_CAPTURE		0x150
 #define MUX_CTL_COMPARE		0x151
 
diff --git a/arch/arm/include/asm/arch-mx5/gpio.h b/arch/arm/include/asm/arch-mx5/gpio.h
index dad40bd3d7e..98f9d63e9a8 100644
--- a/arch/arm/include/asm/arch-mx5/gpio.h
+++ b/arch/arm/include/asm/arch-mx5/gpio.h
@@ -4,7 +4,6 @@
  * Stefano Babic, DENX Software Engineering, <sbabic@denx.de>
  */
 
-
 #ifndef __ASM_ARCH_MX5_GPIO_H
 #define __ASM_ARCH_MX5_GPIO_H
 
diff --git a/arch/arm/include/asm/arch-mx6/gpio.h b/arch/arm/include/asm/arch-mx6/gpio.h
index b3913199337..f5c8d336991 100644
--- a/arch/arm/include/asm/arch-mx6/gpio.h
+++ b/arch/arm/include/asm/arch-mx6/gpio.h
@@ -4,7 +4,6 @@
  * Stefano Babic, DENX Software Engineering, <sbabic@denx.de>
  */
 
-
 #ifndef __ASM_ARCH_MX6_GPIO_H
 #define __ASM_ARCH_MX6_GPIO_H
 
diff --git a/arch/arm/include/asm/arch-mx6/imx-regs.h b/arch/arm/include/asm/arch-mx6/imx-regs.h
index 8fd3dd2df3a..7f216c70e8b 100644
--- a/arch/arm/include/asm/arch-mx6/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx6/imx-regs.h
@@ -385,7 +385,6 @@
 			  ((is_mx6ull()) ?	\
 			  MX6ULL_LCDIF1_BASE_ADDR : MX6SX_LCDIF1_BASE_ADDR)))
 
-
 extern void imx_get_mac_from_fuse(int dev_id, unsigned char *mac);
 
 #define SRC_SCR_CORE_1_RESET_OFFSET     14
diff --git a/arch/arm/include/asm/arch-mx7/crm_regs.h b/arch/arm/include/asm/arch-mx7/crm_regs.h
index bfa68a9d2a0..bb2642d46c8 100644
--- a/arch/arm/include/asm/arch-mx7/crm_regs.h
+++ b/arch/arm/include/asm/arch-mx7/crm_regs.h
@@ -229,7 +229,6 @@ struct mxc_ccm_anatop_reg {
 #define ANADIG_PLL_ENET_PWDN_MASK			(0x01 << 5)
 #define ANADIG_PLL_VIDEO_PWDN_MASK			(0x01 << 12)
 
-
 #define ANATOP_PFD480B_PFD4_FRAC_MASK			0x0000003f
 #define ANATOP_PFD480B_PFD4_FRAC_320M_VAL		0x0000001B
 #define ANATOP_PFD480B_PFD4_FRAC_392M_VAL		0x00000016
@@ -1784,7 +1783,6 @@ struct mxc_ccm_anatop_reg {
 #define PMU_LOWPWR_CTRL_TOG_CONTROL1_SHIFT       24
 #define PMU_LOWPWR_CTRL_TOG_CONTROL1(x)          (((uint32_t)(((uint32_t)(x))<<PMU_LOWPWR_CTRL_TOG_CONTROL1_SHIFT))&PMU_LOWPWR_CTRL_TOG_CONTROL1_MASK)
 
-
 /* HW_ANADIG_TEMPSENSE0 Bit Fields */
 #define TEMPMON_HW_ANADIG_TEMPSENSE0_LOW_ALARM_VALUE_MASK 0x1FFu
 #define TEMPMON_HW_ANADIG_TEMPSENSE0_LOW_ALARM_VALUE_SHIFT 0
@@ -1998,7 +1996,6 @@ struct mxc_ccm_anatop_reg {
 #define TEMPMON_HW_ANADIG_TEMPSENSE_TRIM_TOG_T_MUX_ADDR_SHIFT 29
 #define TEMPMON_HW_ANADIG_TEMPSENSE_TRIM_TOG_T_MUX_ADDR(x) (((uint32_t)(((uint32_t)(x))<<TEMPMON_HW_ANADIG_TEMPSENSE_TRIM_TOG_T_MUX_ADDR_SHIFT))&TEMPMON_HW_ANADIG_TEMPSENSE_TRIM_TOG_T_MUX_ADDR_MASK)
 
-
 #define CCM_GPR(i)		(CCM_BASE_ADDR + CCM_GPR0_OFFSET + 0x10 * (i))
 #define CCM_OBSERVE(i)		(CCM_BASE_ADDR + CCM_OBSERVE0_OFFSET + 0x10 * (i))
 #define CCM_SCTRL(i)		(CCM_BASE_ADDR + CCM_SCTRL0_OFFSET + 0x10 * (i))
@@ -2091,7 +2088,6 @@ struct mxc_ccm_anatop_reg {
 #define CLK_ROOT_ALT6		0x06000000
 #define CLK_ROOT_ALT7		0x07000000
 
-
 #define DRAM_CLK_ROOT_POST_DIV_MASK	0x00000007
 #define CLK_ROOT_POST_DIV_MASK	0x0000003f
 #define CLK_ROOT_POST_DIV_SHIFT	0
diff --git a/arch/arm/include/asm/arch-mx7/imx-regs.h b/arch/arm/include/asm/arch-mx7/imx-regs.h
index 6f5ae5173c0..849c5482241 100644
--- a/arch/arm/include/asm/arch-mx7/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx7/imx-regs.h
@@ -71,7 +71,6 @@
 #define GLOBAL_TIMER_BASE_ADDR          (ARM_PERIPHBASE + 0x0200)
 #define PRIVATE_TIMERS_WD_BASE_ADDR     (ARM_PERIPHBASE + 0x0600)
 
-
 /* Defines for Blocks connected via AIPS (SkyBlue) */
 #define AIPS_TZ1_BASE_ADDR              AIPS1_ARB_BASE_ADDR
 #define AIPS_TZ2_BASE_ADDR              AIPS2_ARB_BASE_ADDR
@@ -1162,7 +1161,6 @@ struct rdc_sema_regs {
 #define	LCDIF_VDCTRL4_DOTCLK_H_VALID_DATA_CNT_MASK		0x3ffff
 #define	LCDIF_VDCTRL4_DOTCLK_H_VALID_DATA_CNT_OFFSET		0
 
-
 extern void check_cpu_temperature(void);
 
 extern void pcie_power_up(void);
diff --git a/arch/arm/include/asm/arch-mx7ulp/imx-regs.h b/arch/arm/include/asm/arch-mx7ulp/imx-regs.h
index 33a699ff71a..02e434f2e65 100644
--- a/arch/arm/include/asm/arch-mx7ulp/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx7ulp/imx-regs.h
@@ -124,7 +124,6 @@
 #define IOMUXC_PSMI_IMUX_ALT6		(0x6)
 #define IOMUXC_PSMI_IMUX_ALT7		(0x7)
 
-
 #define SIM_SOPT1_EN_SNVS_HARD_RST	(1<<8)
 #define SIM_SOPT1_PMIC_STBY_REQ		(1<<2)
 #define SIM_SOPT1_A7_SW_RESET		(1<<0)
@@ -240,7 +239,6 @@
 #define IOMUXC_DPCR_DDR_DQS2	((IOMUXC_DDR_RBASE + (4 * 34)))
 #define IOMUXC_DPCR_DDR_DQS3	((IOMUXC_DDR_RBASE + (4 * 35)))
 
-
 #define IOMUXC_DPCR_DDR_DQ0	((IOMUXC_DDR_RBASE + (4 * 0)))
 #define IOMUXC_DPCR_DDR_DQ1	((IOMUXC_DDR_RBASE + (4 * 1)))
 #define IOMUXC_DPCR_DDR_DQ2	((IOMUXC_DDR_RBASE + (4 * 2)))
diff --git a/arch/arm/include/asm/arch-mx7ulp/iomux.h b/arch/arm/include/asm/arch-mx7ulp/iomux.h
index f067c02062f..3eec2c78e56 100644
--- a/arch/arm/include/asm/arch-mx7ulp/iomux.h
+++ b/arch/arm/include/asm/arch-mx7ulp/iomux.h
@@ -69,7 +69,6 @@ typedef u64 iomux_cfg_t;
 #define NEW_PAD_CTRL(cfg, pad)	(((cfg) & ~MUX_PAD_CTRL_MASK) | \
 					MUX_PAD_CTRL(pad))
 
-
 #define IOMUX_CONFIG_MPORTS       0x20
 #define MUX_MODE_MPORTS           ((iomux_v3_cfg_t)IOMUX_CONFIG_MPORTS << \
 				MUX_MODE_SHIFT)
@@ -87,7 +86,6 @@ typedef u64 iomux_cfg_t;
 #define PAD_CTL_PUS_UP       ((1 << 0) | PAD_CTL_PUE)
 #define PAD_CTL_PUS_DOWN     ((0 << 0) | PAD_CTL_PUE)
 
-
 void mx7ulp_iomux_setup_pad(iomux_cfg_t pad);
 void mx7ulp_iomux_setup_multiple_pads(iomux_cfg_t const *pad_list,
 				      unsigned count);
diff --git a/arch/arm/include/asm/arch-mx7ulp/pcc.h b/arch/arm/include/asm/arch-mx7ulp/pcc.h
index 8f0d7006286..09b9b9b8f34 100644
--- a/arch/arm/include/asm/arch-mx7ulp/pcc.h
+++ b/arch/arm/include/asm/arch-mx7ulp/pcc.h
@@ -278,7 +278,6 @@ enum pcc3_entry {
 	RSVD127_PCC3_SLOT		= 127,
 };
 
-
 /* PCC registers */
 #define PCC_PR_OFFSET	31
 #define PCC_PR_MASK		(0x1 << PCC_PR_OFFSET)
@@ -293,7 +292,6 @@ enum pcc3_entry {
 #define PCC_PCD_OFFSET	0
 #define PCC_PCD_MASK	(0x7 << PCC_PCD_OFFSET)
 
-
 enum pcc_clksrc_type {
 	CLKSRC_PER_PLAT = 0,
 	CLKSRC_PER_BUS = 1,
@@ -353,7 +351,6 @@ enum pcc_clk {
 	PER_CLK_GPU2D,
 };
 
-
 /* This structure keeps info for each pcc slot */
 struct pcc_entry {
 	u32 pcc_base;
diff --git a/arch/arm/include/asm/arch-mx7ulp/scg.h b/arch/arm/include/asm/arch-mx7ulp/scg.h
index 3b5b7f6803c..57e9fb2a27c 100644
--- a/arch/arm/include/asm/arch-mx7ulp/scg.h
+++ b/arch/arm/include/asm/arch-mx7ulp/scg.h
@@ -145,7 +145,6 @@
 
 #define SCG_UPLL_CSR_UPLLVLD_MASK       (0x01000000)
 
-
 #define SCG_PLL_PFD3_GATE_MASK          (0x80000000)
 #define SCG_PLL_PFD2_GATE_MASK          (0x00800000)
 #define SCG_PLL_PFD1_GATE_MASK          (0x00008000)
-- 
2.43.0

