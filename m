Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B44CD4F3C
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 07:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582858460E;
	Thu, 21 May 2026 09:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="l/jBoYaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8B5805D7; Thu, 21 May 2026 08:46:17 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8310680433
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 08:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3E9091A365B;
 Thu, 21 May 2026 06:46:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0B01160495;
 Thu, 21 May 2026 06:46:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED962107EA6C1; 
 Thu, 21 May 2026 08:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779345973; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rH3LTea0qfOeqxgb2mu3uhg+N9HJdUrWp1aUaxWd8OA=;
 b=l/jBoYaKY6Q/U2XIMkjKkx0cUFE1Bzcma6ONbVJIhV9AbliFIruBNfMKyXJ0gkefPQNzgn
 a24fIHYbKY9tHpq3j3Vh8VgxTH4PWcslPU9bQ4ZlY0qnYnH/Q5A50Q6vTBT1isJPs/hM24
 443/0XcFMlWIaC0bdeSOPnKYn7C3O8zZhDTZHBRkfSmGza1z5jS7bFQ9p2INh7iYprBEo4
 kEsH/dff5D5DCByWub3RQ6woHYEXgOTF7JS6zrwVKMr+N4DuaSUANjBn3qwMnpyGM8pwiW
 K5FzJafm+Mvs+gV3ItvCj36yA6HW3+ke5ObE6z7wC59iOiF/e9ZioOCT8SSSJA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:45:53 +0200
Subject: [PATCH v2 2/6] arm: ti: omap: Extract common clock definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-omap4-support-v2-2-b46cfff7a47b@bootlin.com>
References: <20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com>
In-Reply-To: <20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 21 May 2026 09:50:52 +0200
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

Lots of clock definitions are common to OMAP3, OMAP4 and OMAP5. So the
same macros are defined both in arch-am33xx/clock.h and in
arch-omap5/clock.h. Upcoming support for OMAP4 will again need the same
macros.

Group these common macro definitions into a common omap_clock header
shared across the OMAP2+ families.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 arch/arm/include/asm/arch-am33xx/clock.h    |  43 +----------
 arch/arm/include/asm/arch-omap5/clock.h     | 101 +-----------------------
 arch/arm/include/asm/ti-common/omap_clock.h | 114 ++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 141 deletions(-)

diff --git a/arch/arm/include/asm/arch-am33xx/clock.h b/arch/arm/include/asm/arch-am33xx/clock.h
index 13960db2fbd..80b0707131f 100644
--- a/arch/arm/include/asm/arch-am33xx/clock.h
+++ b/arch/arm/include/asm/arch-am33xx/clock.h
@@ -12,31 +12,10 @@
 
 #include <asm/arch/clocks_am33xx.h>
 #include <asm/arch/hardware.h>
+#include <asm/ti-common/omap_clock.h>
 
 #define LDELAY 1000000
 
-/*CM_<clock_domain>__CLKCTRL */
-#define CD_CLKCTRL_CLKTRCTRL_SHIFT		0
-#define CD_CLKCTRL_CLKTRCTRL_MASK		3
-
-#define CD_CLKCTRL_CLKTRCTRL_NO_SLEEP		0
-#define CD_CLKCTRL_CLKTRCTRL_SW_SLEEP		1
-#define CD_CLKCTRL_CLKTRCTRL_SW_WKUP		2
-
-/* CM_<clock_domain>_<module>_CLKCTRL */
-#define MODULE_CLKCTRL_MODULEMODE_SHIFT		0
-#define MODULE_CLKCTRL_MODULEMODE_MASK		3
-#define MODULE_CLKCTRL_IDLEST_SHIFT		16
-#define MODULE_CLKCTRL_IDLEST_MASK		(3 << 16)
-
-#define MODULE_CLKCTRL_MODULEMODE_SW_DISABLE		0
-#define MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN	2
-
-#define MODULE_CLKCTRL_IDLEST_FULLY_FUNCTIONAL	0
-#define MODULE_CLKCTRL_IDLEST_TRANSITIONING	1
-#define MODULE_CLKCTRL_IDLEST_IDLE		2
-#define MODULE_CLKCTRL_IDLEST_DISABLED		3
-
 /* CM_CLKMODE_DPLL */
 #define CM_CLKMODE_DPLL_SSC_EN_SHIFT		12
 #define CM_CLKMODE_DPLL_SSC_EN_MASK		(1 << 12)
@@ -53,26 +32,6 @@
 #define CM_CLKMODE_DPLL_DRIFTGUARD_EN_MASK	(1 << 8)
 #define CM_CLKMODE_DPLL_RAMP_RATE_SHIFT		5
 #define CM_CLKMODE_DPLL_RAMP_RATE_MASK		(0x7 << 5)
-#define CM_CLKMODE_DPLL_EN_SHIFT		0
-#define CM_CLKMODE_DPLL_EN_MASK			(0x7 << 0)
-
-#define CM_CLKMODE_DPLL_DPLL_EN_SHIFT		0
-#define CM_CLKMODE_DPLL_DPLL_EN_MASK		7
-
-#define DPLL_EN_STOP			1
-#define DPLL_EN_MN_BYPASS		4
-#define DPLL_EN_LOW_POWER_BYPASS	5
-#define DPLL_EN_FAST_RELOCK_BYPASS	6
-#define DPLL_EN_LOCK			7
-
-/* CM_IDLEST_DPLL fields */
-#define ST_DPLL_CLK_MASK		1
-
-/* CM_CLKSEL_DPLL */
-#define CM_CLKSEL_DPLL_M_SHIFT			8
-#define CM_CLKSEL_DPLL_M_MASK			(0x7FF << 8)
-#define CM_CLKSEL_DPLL_N_SHIFT			0
-#define CM_CLKSEL_DPLL_N_MASK			0x7F
 
 /* CM_SSC_DELTAM_DPLL */
 #define CM_SSC_DELTAM_DPLL_FRAC_SHIFT		0
diff --git a/arch/arm/include/asm/arch-omap5/clock.h b/arch/arm/include/asm/arch-omap5/clock.h
index aaa5e573115..02dcc0e4356 100644
--- a/arch/arm/include/asm/arch-omap5/clock.h
+++ b/arch/arm/include/asm/arch-omap5/clock.h
@@ -9,6 +9,8 @@
 #ifndef _CLOCKS_OMAP5_H_
 #define _CLOCKS_OMAP5_H_
 
+#include <asm/ti-common/omap_clock.h>
+
 /*
  * Assuming a maximum of 1.5 GHz ARM speed and a minimum of 2 cycles per
  * loop, allow for a minimum of 2 ms wait (in reality the wait will be
@@ -19,7 +21,6 @@
 /* CM_DLL_CTRL */
 #define CM_DLL_CTRL_OVERRIDE_SHIFT		0
 #define CM_DLL_CTRL_OVERRIDE_MASK		(1 << 0)
-#define CM_DLL_CTRL_NO_OVERRIDE			0
 
 /* CM_CLKMODE_DPLL */
 #define CM_CLKMODE_DPLL_REGM4XEN_SHIFT		11
@@ -32,20 +33,6 @@
 #define CM_CLKMODE_DPLL_DRIFTGUARD_EN_MASK	(1 << 8)
 #define CM_CLKMODE_DPLL_RAMP_RATE_SHIFT		5
 #define CM_CLKMODE_DPLL_RAMP_RATE_MASK		(0x7 << 5)
-#define CM_CLKMODE_DPLL_EN_SHIFT		0
-#define CM_CLKMODE_DPLL_EN_MASK			(0x7 << 0)
-
-#define CM_CLKMODE_DPLL_DPLL_EN_SHIFT		0
-#define CM_CLKMODE_DPLL_DPLL_EN_MASK		7
-
-#define DPLL_EN_STOP			1
-#define DPLL_EN_MN_BYPASS		4
-#define DPLL_EN_LOW_POWER_BYPASS	5
-#define DPLL_EN_FAST_RELOCK_BYPASS	6
-#define DPLL_EN_LOCK			7
-
-/* CM_IDLEST_DPLL fields */
-#define ST_DPLL_CLK_MASK		1
 
 /* SGX */
 #define CLKSEL_GPU_HYD_GCLK_MASK		(1 << 25)
@@ -54,24 +41,6 @@
 /* CM_CLKSEL_DPLL */
 #define CM_CLKSEL_DPLL_DPLL_SD_DIV_SHIFT	24
 #define CM_CLKSEL_DPLL_DPLL_SD_DIV_MASK		(0xFF << 24)
-#define CM_CLKSEL_DPLL_M_SHIFT			8
-#define CM_CLKSEL_DPLL_M_MASK			(0x7FF << 8)
-#define CM_CLKSEL_DPLL_N_SHIFT			0
-#define CM_CLKSEL_DPLL_N_MASK			0x7F
-#define CM_CLKSEL_DCC_EN_SHIFT			22
-#define CM_CLKSEL_DCC_EN_MASK			(1 << 22)
-
-/* CM_SYS_CLKSEL */
-#define CM_SYS_CLKSEL_SYS_CLKSEL_MASK  7
-
-/* CM_CLKSEL_CORE */
-#define CLKSEL_CORE_SHIFT	0
-#define CLKSEL_L3_SHIFT		4
-#define CLKSEL_L4_SHIFT		8
-
-#define CLKSEL_CORE_X2_DIV_1	0
-#define CLKSEL_L3_CORE_DIV_2	1
-#define CLKSEL_L4_L3_DIV_2	1
 
 /* CM_ABE_PLL_REF_CLKSEL */
 #define CM_ABE_PLL_REF_CLKSEL_CLKSEL_SHIFT	0
@@ -91,57 +60,12 @@
 
 #define DPLL_IVA_CLKSEL_CORE_X2_DIV_2		1
 
-/* CM_SHADOW_FREQ_CONFIG1 */
-#define SHADOW_FREQ_CONFIG1_FREQ_UPDATE_MASK	1
-#define SHADOW_FREQ_CONFIG1_DLL_OVERRIDE_MASK	4
-#define SHADOW_FREQ_CONFIG1_DLL_RESET_MASK	8
-
-#define SHADOW_FREQ_CONFIG1_DPLL_EN_SHIFT	8
-#define SHADOW_FREQ_CONFIG1_DPLL_EN_MASK	(7 << 8)
-
-#define SHADOW_FREQ_CONFIG1_M2_DIV_SHIFT	11
-#define SHADOW_FREQ_CONFIG1_M2_DIV_MASK		(0x1F << 11)
-
-/*CM_<clock_domain>__CLKCTRL */
-#define CD_CLKCTRL_CLKTRCTRL_SHIFT		0
-#define CD_CLKCTRL_CLKTRCTRL_MASK		3
-
-#define CD_CLKCTRL_CLKTRCTRL_NO_SLEEP		0
-#define CD_CLKCTRL_CLKTRCTRL_SW_SLEEP		1
-#define CD_CLKCTRL_CLKTRCTRL_SW_WKUP		2
-#define CD_CLKCTRL_CLKTRCTRL_HW_AUTO		3
-
-/* CM_<clock_domain>_<module>_CLKCTRL */
-#define MODULE_CLKCTRL_MODULEMODE_SHIFT		0
-#define MODULE_CLKCTRL_MODULEMODE_MASK		3
-#define MODULE_CLKCTRL_IDLEST_SHIFT		16
-#define MODULE_CLKCTRL_IDLEST_MASK		(3 << 16)
-
-#define MODULE_CLKCTRL_MODULEMODE_SW_DISABLE		0
-#define MODULE_CLKCTRL_MODULEMODE_HW_AUTO		1
-#define MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN	2
-
-#define MODULE_CLKCTRL_IDLEST_FULLY_FUNCTIONAL	0
-#define MODULE_CLKCTRL_IDLEST_TRANSITIONING	1
-#define MODULE_CLKCTRL_IDLEST_IDLE		2
-#define MODULE_CLKCTRL_IDLEST_DISABLED		3
-
-/* CM_L4PER_GPIO4_CLKCTRL */
-#define GPIO4_CLKCTRL_OPTFCLKEN_MASK		(1 << 8)
-
-/* CM_L3INIT_HSMMCn_CLKCTRL */
-#define HSMMC_CLKCTRL_CLKSEL_MASK		(1 << 24)
-#define HSMMC_CLKCTRL_CLKSEL_DIV_MASK		(3 << 25)
-
 /* CM_IPU1_IPU1_CLKCTRL CLKSEL MASK */
 #define IPU1_CLKCTRL_CLKSEL_MASK		BIT(24)
 
 /* CM_L3INIT_SATA_CLKCTRL */
 #define SATA_CLKCTRL_OPTFCLKEN_MASK		(1 << 8)
 
-/* CM_WKUP_GPTIMER1_CLKCTRL */
-#define GPTIMER1_CLKCTRL_CLKSEL_MASK		(1 << 24)
-
 /* CM_CAM_ISS_CLKCTRL */
 #define ISS_CLKCTRL_OPTFCLKEN_MASK		(1 << 8)
 
@@ -181,12 +105,6 @@
 /* CM_L3INIT_OCP2SCP1_CLKCTRL */
 #define OCP2SCP1_CLKCTRL_MODULEMODE_HW	(1 << 0)
 
-/* CM_MPU_MPU_CLKCTRL */
-#define MPU_CLKCTRL_CLKSEL_EMIF_DIV_MODE_SHIFT	24
-#define MPU_CLKCTRL_CLKSEL_EMIF_DIV_MODE_MASK	(3 << 24)
-#define MPU_CLKCTRL_CLKSEL_ABE_DIV_MODE_SHIFT	26
-#define MPU_CLKCTRL_CLKSEL_ABE_DIV_MODE_MASK	(1 << 26)
-
 /* CM_WKUPAON_SCRM_CLKCTRL */
 #define OPTFCLKEN_SCRM_PER_SHIFT		9
 #define OPTFCLKEN_SCRM_PER_MASK			(1 << 9)
@@ -201,9 +119,6 @@
 #define RSTTIME1_SHIFT				0
 #define RSTTIME1_MASK				(0x3ff << 0)
 
-/* Clock frequencies */
-#define OMAP_SYS_CLK_IND_38_4_MHZ	6
-
 /* CTRL_CORE_SRCOMP_NORTH_SIDE */
 #define USB2PHY_DISCHGDET	(1 << 29)
 #define USB2PHY_AUTORESUME_EN (1 << 30)
@@ -399,16 +314,4 @@
 /* CKO buffer control */
 #define CKOBUFFER_CLK_ENABLE_MASK	(1 << 28)
 
-/* AUXCLKx reg fields */
-#define AUXCLK_ENABLE_MASK		(1 << 8)
-#define AUXCLK_SRCSELECT_SHIFT		1
-#define AUXCLK_SRCSELECT_MASK		(3 << 1)
-#define AUXCLK_CLKDIV_SHIFT		16
-#define AUXCLK_CLKDIV_MASK		(0xF << 16)
-
-#define AUXCLK_SRCSELECT_SYS_CLK	0
-#define AUXCLK_SRCSELECT_CORE_DPLL	1
-#define AUXCLK_SRCSELECT_PER_DPLL	2
-#define AUXCLK_SRCSELECT_ALTERNATE	3
-
 #endif /* _CLOCKS_OMAP5_H_ */
diff --git a/arch/arm/include/asm/ti-common/omap_clock.h b/arch/arm/include/asm/ti-common/omap_clock.h
new file mode 100644
index 00000000000..4a37b0bc8c3
--- /dev/null
+++ b/arch/arm/include/asm/ti-common/omap_clock.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef	_OMAP_CLOCK_H_
+#define	_OMAP_CLOCK_H_
+
+/* CM_CLKMODE_DPLL */
+#define CM_CLKMODE_DPLL_EN_SHIFT	0
+#define CM_CLKMODE_DPLL_EN_MASK		(0x7 << 0)
+
+#define CM_CLKMODE_DPLL_DPLL_EN_SHIFT	0
+#define CM_CLKMODE_DPLL_DPLL_EN_MASK	7
+
+#define DPLL_EN_STOP			1
+#define DPLL_EN_MN_BYPASS		4
+#define DPLL_EN_LOW_POWER_BYPASS	5
+#define DPLL_EN_FAST_RELOCK_BYPASS	6
+#define DPLL_EN_LOCK			7
+
+#define DPLL_NO_LOCK		0
+#define DPLL_LOCK		1
+
+/* CM_IDLEST_DPLL fields */
+#define ST_DPLL_CLK_MASK	1
+
+/* CM_CLKSEL_CORE */
+#define CLKSEL_CORE_SHIFT	0
+#define CLKSEL_L3_SHIFT		4
+#define CLKSEL_L4_SHIFT		8
+
+/* CM_DLL_CTRL */
+#define CM_DLL_CTRL_NO_OVERRIDE		0
+
+/* CM_CLKSEL_DPLL */
+#define CM_CLKSEL_DPLL_N_SHIFT		0
+#define CM_CLKSEL_DPLL_N_MASK		0x7F
+#define CM_CLKSEL_DPLL_M_SHIFT		8
+#define CM_CLKSEL_DPLL_M_MASK		(0x7FF << 8)
+#define CM_CLKSEL_DCC_EN_SHIFT		22
+#define CM_CLKSEL_DCC_EN_MASK		BIT(22)
+
+#define CLKSEL_CORE_X2_DIV_1	0
+#define CLKSEL_L3_CORE_DIV_2	1
+#define CLKSEL_L4_L3_DIV_2	1
+
+/* CM_SYS_CLKSEL */
+#define CM_SYS_CLKSEL_SYS_CLKSEL_MASK		7
+
+/*CM_<clock_domain>__CLKCTRL */
+#define CD_CLKCTRL_CLKTRCTRL_SHIFT	0
+#define CD_CLKCTRL_CLKTRCTRL_MASK	3
+
+#define CD_CLKCTRL_CLKTRCTRL_NO_SLEEP	0
+#define CD_CLKCTRL_CLKTRCTRL_SW_SLEEP	1
+#define CD_CLKCTRL_CLKTRCTRL_SW_WKUP	2
+#define CD_CLKCTRL_CLKTRCTRL_HW_AUTO	3
+
+/* CM_SHADOW_FREQ_CONFIG1 */
+#define SHADOW_FREQ_CONFIG1_FREQ_UPDATE_MASK	1
+#define SHADOW_FREQ_CONFIG1_DLL_OVERRIDE_MASK	4
+#define SHADOW_FREQ_CONFIG1_DLL_RESET_MASK	8
+
+#define SHADOW_FREQ_CONFIG1_DPLL_EN_SHIFT	8
+#define SHADOW_FREQ_CONFIG1_DPLL_EN_MASK	(7 << 8)
+
+#define SHADOW_FREQ_CONFIG1_M2_DIV_SHIFT	11
+#define SHADOW_FREQ_CONFIG1_M2_DIV_MASK		(0x1F << 11)
+
+/* CM_<clock_domain>_<module>_CLKCTRL */
+#define MODULE_CLKCTRL_MODULEMODE_SHIFT		0
+#define MODULE_CLKCTRL_MODULEMODE_MASK		3
+#define MODULE_CLKCTRL_IDLEST_SHIFT		16
+#define MODULE_CLKCTRL_IDLEST_MASK		(3 << 16)
+
+#define MODULE_CLKCTRL_MODULEMODE_SW_DISABLE		0
+#define MODULE_CLKCTRL_MODULEMODE_HW_AUTO		1
+#define MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN	2
+
+#define MODULE_CLKCTRL_IDLEST_FULLY_FUNCTIONAL		0
+#define MODULE_CLKCTRL_IDLEST_TRANSITIONING		1
+#define MODULE_CLKCTRL_IDLEST_IDLE			2
+#define MODULE_CLKCTRL_IDLEST_DISABLED			3
+
+/* CM_L4PER_GPIO4_CLKCTRL */
+#define GPIO4_CLKCTRL_OPTFCLKEN_MASK	BIT(8)
+
+/* CM_WKUP_GPTIMER1_CLKCTRL */
+#define GPTIMER1_CLKCTRL_CLKSEL_MASK	BIT(24)
+
+/* CM_L3INIT_HSMMCn_CLKCTRL */
+#define HSMMC_CLKCTRL_CLKSEL_MASK	BIT(24)
+#define HSMMC_CLKCTRL_CLKSEL_DIV_MASK	(3 << 25)
+
+/* Clock frequencies */
+#define OMAP_SYS_CLK_IND_38_4_MHZ	6
+
+/* AUXCLKx reg fields */
+#define AUXCLK_ENABLE_MASK		BIT(8)
+#define AUXCLK_SRCSELECT_SHIFT		1
+#define AUXCLK_SRCSELECT_MASK		(3 << 1)
+#define AUXCLK_CLKDIV_SHIFT		16
+#define AUXCLK_CLKDIV_MASK		(0xF << 16)
+#define AUXCLK_CLKDIV_2			1
+
+#define AUXCLK_SRCSELECT_SYS_CLK	0
+#define AUXCLK_SRCSELECT_CORE_DPLL	1
+#define AUXCLK_SRCSELECT_PER_DPLL	2
+#define AUXCLK_SRCSELECT_ALTERNATE	3
+
+/* CM_MPU_MPU_CLKCTRL */
+#define MPU_CLKCTRL_CLKSEL_EMIF_DIV_MODE_SHIFT	24
+#define MPU_CLKCTRL_CLKSEL_EMIF_DIV_MODE_MASK	(3 << 24)
+#define MPU_CLKCTRL_CLKSEL_ABE_DIV_MODE_SHIFT	26
+#define MPU_CLKCTRL_CLKSEL_ABE_DIV_MODE_MASK	BIT(26)
+
+#endif /* _OMAP_CLOCK_H_ */

-- 
2.54.0

