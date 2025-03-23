Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3B2C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0C581D0B;
	Sun, 23 Mar 2025 12:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381DF81219; Sun, 23 Mar 2025 12:36:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4A927819B1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7296F1595;
 Sun, 23 Mar 2025 04:36:27 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D063F694;
 Sun, 23 Mar 2025 04:36:19 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 08/34] sunxi: clock: H6: remove struct sunxi_prcm_reg
Date: Sun, 23 Mar 2025 11:35:18 +0000
Message-ID: <20250323113544.7933-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

With the SPL clock code and the DRAM init routine we converted all users
of the H6 class "struct sunxi_prcm_reg" over to use #define'd register
offsets now.

Drop the whole definition of this struct now, since it's not needed
anymore, for all H6 and H616 boards.
This removes the entire fragile and questionable definition, and allows
new SoCs to share the code more easily.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/prcm_sun50i.h | 40 -------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h b/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h
index 738cd68320c..d6653c3bb06 100644
--- a/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h
+++ b/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h
@@ -9,7 +9,6 @@
 #define _SUN50I_PRCM_H
 
 #ifndef __ASSEMBLY__
-#include <linux/compiler.h>
 
 #define CCU_PRCM_I2C_GATE_RESET		0x19c
 #define CCU_PRCM_PLL_LDO_CFG		0x244
@@ -17,45 +16,6 @@
 #define CCU_PRCM_RES_CAL_CTRL		0x310
 #define CCU_PRCM_OHMS240		0x318
 
-struct sunxi_prcm_reg {
-	u32 cpus_cfg;		/* 0x000 */
-	u8 res0[0x8];		/* 0x004 */
-	u32 apbs1_cfg;		/* 0x00c */
-	u32 apbs2_cfg;		/* 0x010 */
-	u8 res1[0x108];		/* 0x014 */
-	u32 tmr_gate_reset;	/* 0x11c */
-	u8 res2[0xc];		/* 0x120 */
-	u32 twd_gate_reset;	/* 0x12c */
-	u8 res3[0xc];		/* 0x130 */
-	u32 pwm_gate_reset;	/* 0x13c */
-	u8 res4[0x4c];		/* 0x140 */
-	u32 uart_gate_reset;	/* 0x18c */
-	u8 res5[0xc];		/* 0x190 */
-	u32 twi_gate_reset;	/* 0x19c */
-	u8 res6[0x1c];		/* 0x1a0 */
-	u32 rsb_gate_reset;	/* 0x1bc */
-	u32 cir_cfg;		/* 0x1c0 */
-	u8 res7[0x8];		/* 0x1c4 */
-	u32 cir_gate_reset;	/* 0x1cc */
-	u8 res8[0x10];		/* 0x1d0 */
-	u32 w1_cfg;		/* 0x1e0 */
-	u8 res9[0x8];		/* 0x1e4 */
-	u32 w1_gate_reset;	/* 0x1ec */
-	u8 res10[0x1c];		/* 0x1f0 */
-	u32 rtc_gate_reset;	/* 0x20c */
-	u8 res11[0x34];		/* 0x210 */
-	u32 pll_ldo_cfg;	/* 0x244 */
-	u8 res12[0x8];		/* 0x248 */
-	u32 sys_pwroff_gating;	/* 0x250 */
-	u8 res13[0xbc];		/* 0x254 */
-	u32 res_cal_ctrl;	/* 0x310 */
-	u32 ohms200;		/* 0x314 */
-	u32 ohms240;		/* 0x318 */
-	u32 res_cal_status;	/* 0x31c */
-};
-check_member(sunxi_prcm_reg, rtc_gate_reset, 0x20c);
-check_member(sunxi_prcm_reg, res_cal_status, 0x31c);
-
 #define PRCM_TWI_GATE		(1 << 0)
 #define PRCM_TWI_RESET		(1 << 16)
 
-- 
2.46.3

