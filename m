Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F82BCD343F
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 07:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30146846DF;
	Thu, 21 May 2026 09:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ird3rV8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEE583FB0; Thu, 21 May 2026 08:46:30 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 019FF80433
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 08:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id AE5F3C2C64E;
 Thu, 21 May 2026 06:47:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AD2AC60495;
 Thu, 21 May 2026 06:46:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FA89107EA12C; 
 Thu, 21 May 2026 08:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779345983; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RJPrdYNY0L6CUYhz3xjrV0Q4U0toi8ztVpol5oq+zrg=;
 b=ird3rV8gcdPzz0ROTXnEeHgxOdqyys4X0cxtXVgu1ZBiYAxaa5GWePE6rfEVpKHJOw3yXl
 x93NUN8W5k/PMlExLyPhX8V2Fv1pZ3k2FGZx7e9SVzmrDYAT1OmAx6+xyskMX71nf6JSS2
 HqbGmeeYzPfifW0it/Cq+dVv9oPxbGAis0Oov3Kclt4YNBE4m3f0/LBjldTTMx/Rc/0JVp
 eQru+xPunN17OS1sOFh3VawDLJEFDP2Q6lBm8DQYD1V9ETqOpigoYgubGHiN04r9MwDk2x
 nH/S8Q1klAfz7PHB29gWvyyq6AeoOaDuTpUll4pIfeReWrstlTDYw+schXbDvQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:45:56 +0200
Subject: [PATCH v2 5/6] arm: ti: Introduce back omap4 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-omap4-support-v2-5-b46cfff7a47b@bootlin.com>
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

omap4 support was dropped by b0ee3fe642c ("arm: ti: Remove omap4 platform
support") because the supported boards hadn't done the conversion to
CONFIG_DM_I2C in time. It still exists some omap4-based products and
they could benefit from the latest U-Boot support for obvious security
reasons.

Revert part of b0ee3fe642c to introduce back a minimal support for the
omap4 platform.
Fix the checkpatch's warning/errors induced by this revert. Following
warnings are still present:
| arch/arm/include/asm/arch-omap4/clock.h:445: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
| arch/arm/mach-omap2/omap4/hwinit.c:24: WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
| arch/arm/mach-omap2/omap4/sdram_elpida.c:142: CHECK: Avoid CamelCase: <tRPab>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:143: CHECK: Avoid CamelCase: <tRCD>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:144: CHECK: Avoid CamelCase: <tWR>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:145: CHECK: Avoid CamelCase: <tRASmin>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:146: CHECK: Avoid CamelCase: <tRRD>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:147: CHECK: Avoid CamelCase: <tWTRx2>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:148: CHECK: Avoid CamelCase: <tXSR>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:149: CHECK: Avoid CamelCase: <tXPx2>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:150: CHECK: Avoid CamelCase: <tRFCab>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:151: CHECK: Avoid CamelCase: <tRTPx2>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:152: CHECK: Avoid CamelCase: <tCKE>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:153: CHECK: Avoid CamelCase: <tCKESR>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:154: CHECK: Avoid CamelCase: <tZQCS>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:155: CHECK: Avoid CamelCase: <tZQCL>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:156: CHECK: Avoid CamelCase: <tZQINIT>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:157: CHECK: Avoid CamelCase: <tDQSCKMAXx2>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:158: CHECK: Avoid CamelCase: <tRASmax>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:159: CHECK: Avoid CamelCase: <tFAW>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:209: CHECK: Avoid CamelCase: <tRL>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:210: CHECK: Avoid CamelCase: <tRP_AB>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:213: CHECK: Avoid CamelCase: <tRAS_MIN>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:215: CHECK: Avoid CamelCase: <tWTR>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:216: CHECK: Avoid CamelCase: <tXP>
| arch/arm/mach-omap2/omap4/sdram_elpida.c:217: CHECK: Avoid CamelCase: <tRTP>
I didn't find an clean way to fix the "don't use #ifdef" warning as we
need to define the gpio_bank for the SPL build only.
For the CamelCase warnings, the incriminated attributes represent
timings, so IMHO, it is more readable with CamelCase.

Set myself as OMAP4 maintainer.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 MAINTAINERS                                    |   8 +
 arch/arm/include/asm/arch-omap4/clock.h        |  84 +++++
 arch/arm/include/asm/arch-omap4/cpu.h          | 109 +++++++
 arch/arm/include/asm/arch-omap4/ehci.h         |  38 +++
 arch/arm/include/asm/arch-omap4/gpio.h         |  34 ++
 arch/arm/include/asm/arch-omap4/hardware.h     |  25 ++
 arch/arm/include/asm/arch-omap4/i2c.h          |  11 +
 arch/arm/include/asm/arch-omap4/mem.h          |  61 ++++
 arch/arm/include/asm/arch-omap4/mmc_host_def.h |  16 +
 arch/arm/include/asm/arch-omap4/mux_omap4.h    | 325 +++++++++++++++++++
 arch/arm/include/asm/arch-omap4/omap.h         | 143 +++++++++
 arch/arm/include/asm/arch-omap4/spl.h          |  22 ++
 arch/arm/include/asm/arch-omap4/sys_proto.h    |  73 +++++
 arch/arm/include/asm/omap_common.h             |  16 +-
 arch/arm/mach-omap2/Kconfig                    |  24 +-
 arch/arm/mach-omap2/Makefile                   |   3 +-
 arch/arm/mach-omap2/omap4/Kconfig              |   6 +
 arch/arm/mach-omap2/omap4/Makefile             |  10 +
 arch/arm/mach-omap2/omap4/boot.c               | 103 ++++++
 arch/arm/mach-omap2/omap4/hw_data.c            | 420 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap4/hwinit.c             | 182 +++++++++++
 arch/arm/mach-omap2/omap4/prcm-regs.c          | 306 ++++++++++++++++++
 arch/arm/mach-omap2/omap4/sdram_elpida.c       | 265 ++++++++++++++++
 common/spl/Kconfig                             |   4 +-
 drivers/i2c/Kconfig                            |   2 +-
 drivers/mmc/Kconfig                            |   2 +-
 26 files changed, 2278 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dcc7243124..4d4af983596 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -831,6 +831,14 @@ F:	drivers/watchdog/omap_wdt.c
 F:	include/linux/pruss_driver.h
 F:	include/linux/soc/ti/
 
+ARM TI OMAP4
+M:	Bastien Curutchet <bastien.curutchet@bootlin.com>
+S:	Maintained
+F:	arch/arm/dts/omap4*
+F:	arch/arm/include/asm/arch-omap4/
+F:	arch/arm/mach-omap2/omap4/
+F:	include/configs/ti_omap4_common.h
+
 ARM U8500
 M:	Stephan Gerhold <stephan@gerhold.net>
 R:	Linus Walleij <linusw@kernel.org>
diff --git a/arch/arm/include/asm/arch-omap4/clock.h b/arch/arm/include/asm/arch-omap4/clock.h
new file mode 100644
index 00000000000..f020c94428a
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/clock.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ *
+ * Aneesh V <aneesh@ti.com>
+ */
+#ifndef _CLOCKS_OMAP4_H_
+#define _CLOCKS_OMAP4_H_
+
+#define LDELAY		1000000
+
+#include <asm/ti-common/omap_clock.h>
+
+/* ALTCLKSRC */
+#define ALTCLKSRC_MODE_ACTIVE		1
+#define ALTCLKSRC_MODE_MASK		3
+#define ALTCLKSRC_ENABLE_INT_MASK	4
+#define ALTCLKSRC_ENABLE_EXT_MASK	8
+
+/* CM_COREAON_USB_PHY_CORE_CLKCTRL */
+#define USBPHY_CORE_CLKCTRL_OPTFCLKEN_CLK32K	BIT(8)
+
+/* CM_L3INIT_USBPHY_CLKCTRL */
+#define USBPHY_CLKCTRL_OPTFCLKEN_PHY_48M_MASK	BIT(8)
+
+/* TWL6030 SMPS */
+#define SMPS_REG_ADDR_VCORE1	0x55
+#define SMPS_REG_ADDR_VCORE2	0x5B
+#define SMPS_REG_ADDR_VCORE3	0x61
+/* TWL6032 SMPS */
+#define SMPS_REG_ADDR_SMPS1	0x55
+#define SMPS_REG_ADDR_SMPS2	0x5B
+#define SMPS_REG_ADDR_SMPS5	0x49
+
+/* PMIC */
+#define SMPS_I2C_SLAVE_ADDR	0x12
+
+/* Clock Defines */
+#define V_OSCK			38400000	/* Clock output from T2 */
+#define V_SCLK                   V_OSCK
+
+struct omap4_scrm_regs {
+	u32 revision;           /* 0x0000 */
+	u32 pad00[63];
+	u32 clksetuptime;       /* 0x0100 */
+	u32 pmicsetuptime;      /* 0x0104 */
+	u32 pad01[2];
+	u32 altclksrc;          /* 0x0110 */
+	u32 pad02[2];
+	u32 c2cclkm;            /* 0x011c */
+	u32 pad03[56];
+	u32 extclkreq;          /* 0x0200 */
+	u32 accclkreq;          /* 0x0204 */
+	u32 pwrreq;             /* 0x0208 */
+	u32 pad04[1];
+	u32 auxclkreq0;         /* 0x0210 */
+	u32 auxclkreq1;         /* 0x0214 */
+	u32 auxclkreq2;         /* 0x0218 */
+	u32 auxclkreq3;         /* 0x021c */
+	u32 auxclkreq4;         /* 0x0220 */
+	u32 auxclkreq5;         /* 0x0224 */
+	u32 pad05[3];
+	u32 c2cclkreq;          /* 0x0234 */
+	u32 pad06[54];
+	u32 auxclk0;            /* 0x0310 */
+	u32 auxclk1;            /* 0x0314 */
+	u32 auxclk2;            /* 0x0318 */
+	u32 auxclk3;            /* 0x031c */
+	u32 auxclk4;            /* 0x0320 */
+	u32 auxclk5;            /* 0x0324 */
+	u32 pad07[54];
+	u32 rsttime_reg;        /* 0x0400 */
+	u32 pad08[6];
+	u32 c2crstctrl;         /* 0x041c */
+	u32 extpwronrstctrl;    /* 0x0420 */
+	u32 pad09[59];
+	u32 extwarmrstst_reg;   /* 0x0510 */
+	u32 apewarmrstst_reg;   /* 0x0514 */
+	u32 pad10[1];
+	u32 c2cwarmrstst_reg;   /* 0x051C */
+};
+
+#endif /* _CLOCKS_OMAP4_H_ */
diff --git a/arch/arm/include/asm/arch-omap4/cpu.h b/arch/arm/include/asm/arch-omap4/cpu.h
new file mode 100644
index 00000000000..4c9ed455833
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/cpu.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2006-2010
+ * Texas Instruments, <www.ti.com>
+ */
+
+#ifndef _CPU_H
+#define _CPU_H
+
+#if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
+#include <asm/types.h>
+#endif /* !(__KERNEL_STRICT_NAMES || __ASSEMBLY__) */
+
+#include <asm/arch/hardware.h>
+
+#ifndef __KERNEL_STRICT_NAMES
+#ifndef __ASSEMBLY__
+struct gptimer {
+	u32 tidr;		/* 0x00 r */
+	u8 res[0xc];
+	u32 tiocp_cfg;		/* 0x10 rw */
+	u32 tistat;		/* 0x14 r */
+	u32 tisr;		/* 0x18 rw */
+	u32 tier;		/* 0x1c rw */
+	u32 twer;		/* 0x20 rw */
+	u32 tclr;		/* 0x24 rw */
+	u32 tcrr;		/* 0x28 rw */
+	u32 tldr;		/* 0x2c rw */
+	u32 ttgr;		/* 0x30 rw */
+	u32 twpc;		/* 0x34 r */
+	u32 tmar;		/* 0x38 rw */
+	u32 tcar1;		/* 0x3c r */
+	u32 tcicr;		/* 0x40 rw */
+	u32 tcar2;		/* 0x44 r */
+};
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL_STRICT_NAMES */
+
+/* enable sys_clk NO-prescale /1 */
+#define GPT_EN			((0x0 << 2) | (0x1 << 1) | (0x1 << 0))
+
+/* Watchdog */
+#ifndef __KERNEL_STRICT_NAMES
+#ifndef __ASSEMBLY__
+struct watchdog {
+	u8 res1[0x34];
+	u32 wwps;		/* 0x34 r */
+	u8 res2[0x10];
+	u32 wspr;		/* 0x48 rw */
+};
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL_STRICT_NAMES */
+
+#define WD_UNLOCK1		0xAAAA
+#define WD_UNLOCK2		0x5555
+
+#define TCLR_ST			(0x1 << 0)
+#define TCLR_AR			(0x1 << 1)
+#define TCLR_PRE		(0x1 << 5)
+
+/* I2C base */
+#define I2C_BASE1		(OMAP44XX_L4_PER_BASE + 0x70000)
+#define I2C_BASE2		(OMAP44XX_L4_PER_BASE + 0x72000)
+#define I2C_BASE3		(OMAP44XX_L4_PER_BASE + 0x60000)
+#define I2C_BASE4		(OMAP44XX_L4_PER_BASE + 0x350000)
+
+/* MUSB base */
+#define MUSB_BASE		(OMAP44XX_L4_CORE_BASE + 0xAB000)
+
+/* OMAP4 GPIO registers */
+#define OMAP_GPIO_REVISION		0x0000
+#define OMAP_GPIO_SYSCONFIG		0x0010
+#define OMAP_GPIO_SYSSTATUS		0x0114
+#define OMAP_GPIO_IRQSTATUS1		0x0118
+#define OMAP_GPIO_IRQSTATUS2		0x0128
+#define OMAP_GPIO_IRQENABLE2		0x012c
+#define OMAP_GPIO_IRQENABLE1		0x011c
+#define OMAP_GPIO_WAKE_EN		0x0120
+#define OMAP_GPIO_CTRL			0x0130
+#define OMAP_GPIO_OE			0x0134
+#define OMAP_GPIO_DATAIN		0x0138
+#define OMAP_GPIO_DATAOUT		0x013c
+#define OMAP_GPIO_LEVELDETECT0		0x0140
+#define OMAP_GPIO_LEVELDETECT1		0x0144
+#define OMAP_GPIO_RISINGDETECT		0x0148
+#define OMAP_GPIO_FALLINGDETECT		0x014c
+#define OMAP_GPIO_DEBOUNCE_EN		0x0150
+#define OMAP_GPIO_DEBOUNCE_VAL		0x0154
+#define OMAP_GPIO_CLEARIRQENABLE1	0x0160
+#define OMAP_GPIO_SETIRQENABLE1		0x0164
+#define OMAP_GPIO_CLEARWKUENA		0x0180
+#define OMAP_GPIO_SETWKUENA		0x0184
+#define OMAP_GPIO_CLEARDATAOUT		0x0190
+#define OMAP_GPIO_SETDATAOUT		0x0194
+
+/*
+ * PRCM
+ */
+
+/* PRM */
+#define PRM_BASE		0x4A306000
+#define PRM_DEVICE_BASE		(PRM_BASE + 0x1B00)
+
+#define PRM_RSTCTRL		PRM_DEVICE_BASE
+#define PRM_RSTCTRL_RESET	0x01
+#define PRM_RSTST		(PRM_DEVICE_BASE + 0x4)
+#define PRM_RSTST_WARM_RESET_MASK	0x07EA
+
+#endif /* _CPU_H */
diff --git a/arch/arm/include/asm/arch-omap4/ehci.h b/arch/arm/include/asm/arch-omap4/ehci.h
new file mode 100644
index 00000000000..447c6b1320f
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/ehci.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * OMAP EHCI port support
+ * Based on LINUX KERNEL
+ * drivers/usb/host/ehci-omap.c and drivers/mfd/omap-usb-host.c
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com
+ * Author: Govindraj R <govindraj.raja@ti.com>
+ */
+
+#ifndef _OMAP4_EHCI_H_
+#define _OMAP4_EHCI_H_
+
+#define OMAP_EHCI_BASE				(OMAP44XX_L4_CORE_BASE + 0x64C00)
+#define OMAP_UHH_BASE				(OMAP44XX_L4_CORE_BASE + 0x64000)
+#define OMAP_USBTLL_BASE			(OMAP44XX_L4_CORE_BASE + 0x62000)
+
+/* UHH, TLL and opt clocks */
+#define CM_L3INIT_HSUSBHOST_CLKCTRL		0x4A009358UL
+
+#define HSUSBHOST_CLKCTRL_CLKSEL_UTMI_P1_MASK	BIT(24)
+
+/* TLL Register Set */
+#define OMAP_USBTLL_SYSCONFIG_SIDLEMODE		BIT(3)
+#define OMAP_USBTLL_SYSCONFIG_ENAWAKEUP		BIT(2)
+#define OMAP_USBTLL_SYSCONFIG_SOFTRESET		BIT(1)
+#define OMAP_USBTLL_SYSCONFIG_CACTIVITY		BIT(8)
+#define OMAP_USBTLL_SYSSTATUS_RESETDONE		1
+
+#define OMAP_UHH_SYSCONFIG_SOFTRESET		1
+#define OMAP_UHH_SYSSTATUS_EHCI_RESETDONE	BIT(2)
+#define OMAP_UHH_SYSCONFIG_NOIDLE		BIT(2)
+#define OMAP_UHH_SYSCONFIG_NOSTDBY		BIT(4)
+
+#define OMAP_UHH_SYSCONFIG_VAL	(OMAP_UHH_SYSCONFIG_NOIDLE | \
+					OMAP_UHH_SYSCONFIG_NOSTDBY)
+
+#endif /* _OMAP4_EHCI_H_ */
diff --git a/arch/arm/include/asm/arch-omap4/gpio.h b/arch/arm/include/asm/arch-omap4/gpio.h
new file mode 100644
index 00000000000..aceb3e227c9
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/gpio.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2009 Wind River Systems, Inc.
+ * Tom Rix <Tom.Rix@windriver.com>
+ *
+ * This work is derived from the linux 2.6.27 kernel source
+ * To fetch, use the kernel repository
+ * git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+ * Use the v2.6.27 tag.
+ *
+ * Below is the original's header including its copyright
+ *
+ *  linux/arch/arm/plat-omap/gpio.c
+ *
+ * Support functions for OMAP GPIO
+ *
+ * Copyright (C) 2003-2005 Nokia Corporation
+ * Written by Juha Yrjölä <juha.yrjola@nokia.com>
+ */
+#ifndef _GPIO_OMAP4_H
+#define _GPIO_OMAP4_H
+
+#include <asm/omap_gpio.h>
+
+#define OMAP_MAX_GPIO			192
+
+#define OMAP44XX_GPIO1_BASE		0x4A310000
+#define OMAP44XX_GPIO2_BASE		0x48055000
+#define OMAP44XX_GPIO3_BASE		0x48057000
+#define OMAP44XX_GPIO4_BASE		0x48059000
+#define OMAP44XX_GPIO5_BASE		0x4805B000
+#define OMAP44XX_GPIO6_BASE		0x4805D000
+
+#endif /* _GPIO_OMAP4_H */
diff --git a/arch/arm/include/asm/arch-omap4/hardware.h b/arch/arm/include/asm/arch-omap4/hardware.h
new file mode 100644
index 00000000000..67e3dae7bce
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/hardware.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * hardware.h
+ *
+ * hardware specific header
+ *
+ * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
+ */
+
+#ifndef __OMAP_HARDWARE_H
+#define __OMAP_HARDWARE_H
+
+#include <asm/arch/omap.h>
+
+/*
+ * Common hardware definitions
+ */
+
+/* BCH Error Location Module */
+#define ELM_BASE			0x48078000
+
+/* GPMC Base address */
+#define GPMC_BASE			0x50000000
+
+#endif
diff --git a/arch/arm/include/asm/arch-omap4/i2c.h b/arch/arm/include/asm/arch-omap4/i2c.h
new file mode 100644
index 00000000000..c8f2f9716f1
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/i2c.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2004-2010
+ * Texas Instruments, <www.ti.com>
+ */
+#ifndef _OMAP4_I2C_H_
+#define _OMAP4_I2C_H_
+
+#define I2C_DEFAULT_BASE	I2C_BASE1
+
+#endif /* _OMAP4_I2C_H_ */
diff --git a/arch/arm/include/asm/arch-omap4/mem.h b/arch/arm/include/asm/arch-omap4/mem.h
new file mode 100644
index 00000000000..3026a002db3
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/mem.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2006-2008
+ * Texas Instruments, <www.ti.com>
+ *
+ * Author
+ *		Mansoor Ahamed <mansoor.ahamed@ti.com>
+ *
+ * Initial Code from:
+ *		Richard Woodruff <r-woodruff2@ti.com>
+ */
+
+#ifndef _MEM_H_
+#define _MEM_H_
+
+/*
+ * GPMC settings -
+ * Definitions is as per the following format
+ * #define <PART>_GPMC_CONFIG<x> <value>
+ * Where:
+ * PART is the part name e.g. STNOR - Intel Strata Flash
+ * x is GPMC config registers from 1 to 6 (there will be 6 macros)
+ * Value is corresponding value
+ *
+ * For every valid PRCM configuration there should be only one definition of
+ * the same. if values are independent of the board, this definition will be
+ * present in this file if values are dependent on the board, then this should
+ * go into corresponding mem-boardName.h file
+ *
+ * Currently valid part Names are (PART):
+ * M_NAND - Micron NAND
+ * STNOR - STMicrolelctronics M29W128GL
+ */
+#define GPMC_SIZE_256M		0x0
+#define GPMC_SIZE_128M		0x8
+#define GPMC_SIZE_64M		0xC
+#define GPMC_SIZE_32M		0xE
+#define GPMC_SIZE_16M		0xF
+
+#define M_NAND_GPMC_CONFIG1	0x00000800
+#define M_NAND_GPMC_CONFIG2	0x001e1e00
+#define M_NAND_GPMC_CONFIG3	0x001e1e00
+#define M_NAND_GPMC_CONFIG4	0x16051807
+#define M_NAND_GPMC_CONFIG5	0x00151e1e
+#define M_NAND_GPMC_CONFIG6	0x16000f80
+#define M_NAND_GPMC_CONFIG7	0x00000008
+
+#define STNOR_GPMC_CONFIG1	0x00001200
+#define STNOR_GPMC_CONFIG2	0x00101000
+#define STNOR_GPMC_CONFIG3	0x00030301
+#define STNOR_GPMC_CONFIG4	0x10041004
+#define STNOR_GPMC_CONFIG5	0x000C1010
+#define STNOR_GPMC_CONFIG6	0x08070280
+#define STNOR_GPMC_CONFIG7	0x00000F48
+
+/* max number of GPMC Chip Selects */
+#define GPMC_MAX_CS		8
+/* max number of GPMC regs */
+#define GPMC_MAX_REG		7
+
+#endif /* endif _MEM_H_ */
diff --git a/arch/arm/include/asm/arch-omap4/mmc_host_def.h b/arch/arm/include/asm/arch-omap4/mmc_host_def.h
new file mode 100644
index 00000000000..bda9bc7db82
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/mmc_host_def.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef MMC_HOST_DEF_H
+#define MMC_HOST_DEF_H
+
+#include <asm/omap_mmc.h>
+
+/*
+ * OMAP HSMMC register definitions
+ */
+
+#define OMAP_HSMMC1_BASE	0x4809C000
+#define OMAP_HSMMC2_BASE	0x480B4000
+#define OMAP_HSMMC3_BASE	0x480AD000
+
+#endif /* MMC_HOST_DEF_H */
diff --git a/arch/arm/include/asm/arch-omap4/mux_omap4.h b/arch/arm/include/asm/arch-omap4/mux_omap4.h
new file mode 100644
index 00000000000..637d920e0f3
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/mux_omap4.h
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2004-2009
+ * Texas Instruments Incorporated
+ * Richard Woodruff		<r-woodruff2@ti.com>
+ * Aneesh V			<aneesh@ti.com>
+ * Balaji Krishnamoorthy	<balajitk@ti.com>
+ */
+#ifndef _MUX_OMAP4_H_
+#define _MUX_OMAP4_H_
+
+#include <asm/types.h>
+
+struct pad_conf_entry {
+	u16 offset;
+	u16 val;
+};
+
+#ifdef CONFIG_OFF_PADCONF
+#define OFF_PD          BIT(12)
+#define OFF_PU          (3 << 12)
+#define OFF_OUT_PTD     (0 << 10)
+#define OFF_OUT_PTU     (2 << 10)
+#define OFF_IN          BIT(10)
+#define OFF_OUT         (0 << 10)
+#define OFF_EN          BIT(9)
+#else
+#define OFF_PD          (0 << 12)
+#define OFF_PU          (0 << 12)
+#define OFF_OUT_PTD     (0 << 10)
+#define OFF_OUT_PTU     (0 << 10)
+#define OFF_IN          (0 << 10)
+#define OFF_OUT         (0 << 10)
+#define OFF_EN          (0 << 9)
+#endif
+
+#define IEN             BIT(8)
+#define IDIS            (0 << 8)
+#define PTU             (3 << 3)
+#define PTD             BIT(3)
+#define EN              BIT(3)
+#define DIS             (0 << 3)
+
+#define M0              0
+#define M1              1
+#define M2              2
+#define M3              3
+#define M4              4
+#define M5              5
+#define M6              6
+#define M7              7
+
+#define SAFE_MODE	M7
+
+#ifdef CONFIG_OFF_PADCONF
+#define OFF_IN_PD       (OFF_PD | OFF_IN | OFF_EN)
+#define OFF_IN_PU       (OFF_PU | OFF_IN | OFF_EN)
+#define OFF_OUT_PD      (OFF_OUT_PTD | OFF_OUT | OFF_EN)
+#define OFF_OUT_PU      (OFF_OUT_PTU | OFF_OUT | OFF_EN)
+#else
+#define OFF_IN_PD       0
+#define OFF_IN_PU       0
+#define OFF_OUT_PD      0
+#define OFF_OUT_PU      0
+#endif
+
+#define CORE_REVISION		0x0000
+#define CORE_HWINFO		0x0004
+#define CORE_SYSCONFIG		0x0010
+#define GPMC_AD0		0x0040
+#define GPMC_AD1		0x0042
+#define GPMC_AD2		0x0044
+#define GPMC_AD3		0x0046
+#define GPMC_AD4		0x0048
+#define GPMC_AD5		0x004A
+#define GPMC_AD6		0x004C
+#define GPMC_AD7		0x004E
+#define GPMC_AD8		0x0050
+#define GPMC_AD9		0x0052
+#define GPMC_AD10		0x0054
+#define GPMC_AD11		0x0056
+#define GPMC_AD12		0x0058
+#define GPMC_AD13		0x005A
+#define GPMC_AD14		0x005C
+#define GPMC_AD15		0x005E
+#define GPMC_A16		0x0060
+#define GPMC_A17		0x0062
+#define GPMC_A18		0x0064
+#define GPMC_A19		0x0066
+#define GPMC_A20		0x0068
+#define GPMC_A21		0x006A
+#define GPMC_A22		0x006C
+#define GPMC_A23		0x006E
+#define GPMC_A24		0x0070
+#define GPMC_A25		0x0072
+#define GPMC_NCS0		0x0074
+#define GPMC_NCS1		0x0076
+#define GPMC_NCS2		0x0078
+#define GPMC_NCS3		0x007A
+#define GPMC_NWP		0x007C
+#define GPMC_CLK		0x007E
+#define GPMC_NADV_ALE		0x0080
+#define GPMC_NOE		0x0082
+#define GPMC_NWE		0x0084
+#define GPMC_NBE0_CLE		0x0086
+#define GPMC_NBE1		0x0088
+#define GPMC_WAIT0		0x008A
+#define GPMC_WAIT1		0x008C
+#define C2C_DATA11		0x008E
+#define C2C_DATA12		0x0090
+#define C2C_DATA13		0x0092
+#define C2C_DATA14		0x0094
+#define C2C_DATA15		0x0096
+#define HDMI_HPD		0x0098
+#define HDMI_CEC		0x009A
+#define HDMI_DDC_SCL		0x009C
+#define HDMI_DDC_SDA		0x009E
+#define CSI21_DX0		0x00A0
+#define CSI21_DY0		0x00A2
+#define CSI21_DX1		0x00A4
+#define CSI21_DY1		0x00A6
+#define CSI21_DX2		0x00A8
+#define CSI21_DY2		0x00AA
+#define CSI21_DX3		0x00AC
+#define CSI21_DY3		0x00AE
+#define CSI21_DX4		0x00B0
+#define CSI21_DY4		0x00B2
+#define CSI22_DX0		0x00B4
+#define CSI22_DY0		0x00B6
+#define CSI22_DX1		0x00B8
+#define CSI22_DY1		0x00BA
+#define CAM_SHUTTER		0x00BC
+#define CAM_STROBE		0x00BE
+#define CAM_GLOBALRESET		0x00C0
+#define USBB1_ULPITLL_CLK	0x00C2
+#define USBB1_ULPITLL_STP	0x00C4
+#define USBB1_ULPITLL_DIR	0x00C6
+#define USBB1_ULPITLL_NXT	0x00C8
+#define USBB1_ULPITLL_DAT0	0x00CA
+#define USBB1_ULPITLL_DAT1	0x00CC
+#define USBB1_ULPITLL_DAT2	0x00CE
+#define USBB1_ULPITLL_DAT3	0x00D0
+#define USBB1_ULPITLL_DAT4	0x00D2
+#define USBB1_ULPITLL_DAT5	0x00D4
+#define USBB1_ULPITLL_DAT6	0x00D6
+#define USBB1_ULPITLL_DAT7	0x00D8
+#define USBB1_HSIC_DATA		0x00DA
+#define USBB1_HSIC_STROBE	0x00DC
+#define USBC1_ICUSB_DP		0x00DE
+#define USBC1_ICUSB_DM		0x00E0
+#define SDMMC1_CLK		0x00E2
+#define SDMMC1_CMD		0x00E4
+#define SDMMC1_DAT0		0x00E6
+#define SDMMC1_DAT1		0x00E8
+#define SDMMC1_DAT2		0x00EA
+#define SDMMC1_DAT3		0x00EC
+#define SDMMC1_DAT4		0x00EE
+#define SDMMC1_DAT5		0x00F0
+#define SDMMC1_DAT6		0x00F2
+#define SDMMC1_DAT7		0x00F4
+#define ABE_MCBSP2_CLKX		0x00F6
+#define ABE_MCBSP2_DR		0x00F8
+#define ABE_MCBSP2_DX		0x00FA
+#define ABE_MCBSP2_FSX		0x00FC
+#define ABE_MCBSP1_CLKX		0x00FE
+#define ABE_MCBSP1_DR		0x0100
+#define ABE_MCBSP1_DX		0x0102
+#define ABE_MCBSP1_FSX		0x0104
+#define ABE_PDM_UL_DATA		0x0106
+#define ABE_PDM_DL_DATA		0x0108
+#define ABE_PDM_FRAME		0x010A
+#define ABE_PDM_LB_CLK		0x010C
+#define ABE_CLKS		0x010E
+#define ABE_DMIC_CLK1		0x0110
+#define ABE_DMIC_DIN1		0x0112
+#define ABE_DMIC_DIN2		0x0114
+#define ABE_DMIC_DIN3		0x0116
+#define UART2_CTS		0x0118
+#define UART2_RTS		0x011A
+#define UART2_RX		0x011C
+#define UART2_TX		0x011E
+#define HDQ_SIO			0x0120
+#define I2C1_SCL		0x0122
+#define I2C1_SDA		0x0124
+#define I2C2_SCL		0x0126
+#define I2C2_SDA		0x0128
+#define I2C3_SCL		0x012A
+#define I2C3_SDA		0x012C
+#define I2C4_SCL		0x012E
+#define I2C4_SDA		0x0130
+#define MCSPI1_CLK		0x0132
+#define MCSPI1_SOMI		0x0134
+#define MCSPI1_SIMO		0x0136
+#define MCSPI1_CS0		0x0138
+#define MCSPI1_CS1		0x013A
+#define MCSPI1_CS2		0x013C
+#define MCSPI1_CS3		0x013E
+#define UART3_CTS_RCTX		0x0140
+#define UART3_RTS_SD		0x0142
+#define UART3_RX_IRRX		0x0144
+#define UART3_TX_IRTX		0x0146
+#define SDMMC5_CLK		0x0148
+#define SDMMC5_CMD		0x014A
+#define SDMMC5_DAT0		0x014C
+#define SDMMC5_DAT1		0x014E
+#define SDMMC5_DAT2		0x0150
+#define SDMMC5_DAT3		0x0152
+#define MCSPI4_CLK		0x0154
+#define MCSPI4_SIMO		0x0156
+#define MCSPI4_SOMI		0x0158
+#define MCSPI4_CS0		0x015A
+#define UART4_RX		0x015C
+#define UART4_TX		0x015E
+#define USBB2_ULPITLL_CLK	0x0160
+#define USBB2_ULPITLL_STP	0x0162
+#define USBB2_ULPITLL_DIR	0x0164
+#define USBB2_ULPITLL_NXT	0x0166
+#define USBB2_ULPITLL_DAT0	0x0168
+#define USBB2_ULPITLL_DAT1	0x016A
+#define USBB2_ULPITLL_DAT2	0x016C
+#define USBB2_ULPITLL_DAT3	0x016E
+#define USBB2_ULPITLL_DAT4	0x0170
+#define USBB2_ULPITLL_DAT5	0x0172
+#define USBB2_ULPITLL_DAT6	0x0174
+#define USBB2_ULPITLL_DAT7	0x0176
+#define USBB2_HSIC_DATA		0x0178
+#define USBB2_HSIC_STROBE	0x017A
+#define UNIPRO_TX0		0x017C
+#define UNIPRO_TY0		0x017E
+#define UNIPRO_TX1		0x0180
+#define UNIPRO_TY1		0x0182
+#define UNIPRO_TX2		0x0184
+#define UNIPRO_TY2		0x0186
+#define UNIPRO_RX0		0x0188
+#define UNIPRO_RY0		0x018A
+#define UNIPRO_RX1		0x018C
+#define UNIPRO_RY1		0x018E
+#define UNIPRO_RX2		0x0190
+#define UNIPRO_RY2		0x0192
+#define USBA0_OTG_CE		0x0194
+#define USBA0_OTG_DP		0x0196
+#define USBA0_OTG_DM		0x0198
+#define FREF_CLK1_OUT		0x019A
+#define FREF_CLK2_OUT		0x019C
+#define SYS_NIRQ1		0x019E
+#define SYS_NIRQ2		0x01A0
+#define SYS_BOOT0		0x01A2
+#define SYS_BOOT1		0x01A4
+#define SYS_BOOT2		0x01A6
+#define SYS_BOOT3		0x01A8
+#define SYS_BOOT4		0x01AA
+#define SYS_BOOT5		0x01AC
+#define DPM_EMU0		0x01AE
+#define DPM_EMU1		0x01B0
+#define DPM_EMU2		0x01B2
+#define DPM_EMU3		0x01B4
+#define DPM_EMU4		0x01B6
+#define DPM_EMU5		0x01B8
+#define DPM_EMU6		0x01BA
+#define DPM_EMU7		0x01BC
+#define DPM_EMU8		0x01BE
+#define DPM_EMU9		0x01C0
+#define DPM_EMU10		0x01C2
+#define DPM_EMU11		0x01C4
+#define DPM_EMU12		0x01C6
+#define DPM_EMU13		0x01C8
+#define DPM_EMU14		0x01CA
+#define DPM_EMU15		0x01CC
+#define DPM_EMU16		0x01CE
+#define DPM_EMU17		0x01D0
+#define DPM_EMU18		0x01D2
+#define DPM_EMU19		0x01D4
+#define WAKEUPEVENT_0		0x01D8
+#define WAKEUPEVENT_1		0x01DC
+#define WAKEUPEVENT_2		0x01E0
+#define WAKEUPEVENT_3		0x01E4
+#define WAKEUPEVENT_4		0x01E8
+#define WAKEUPEVENT_5		0x01EC
+#define WAKEUPEVENT_6		0x01F0
+
+#define WKUP_REVISION		0x0000
+#define WKUP_HWINFO		0x0004
+#define WKUP_SYSCONFIG		0x0010
+#define PAD0_SIM_IO		0x0040
+#define PAD1_SIM_CLK		0x0042
+#define PAD0_SIM_RESET		0x0044
+#define PAD1_SIM_CD		0x0046
+#define PAD0_SIM_PWRCTRL		0x0048
+#define PAD1_SR_SCL		0x004A
+#define PAD0_SR_SDA		0x004C
+#define PAD1_FREF_XTAL_IN		0x004E
+#define PAD0_FREF_SLICER_IN	0x0050
+#define PAD1_FREF_CLK_IOREQ	0x0052
+#define PAD0_FREF_CLK0_OUT		0x0054
+#define PAD1_FREF_CLK3_REQ		0x0056
+#define PAD0_FREF_CLK3_OUT		0x0058
+#define PAD1_FREF_CLK4_REQ		0x005A
+#define PAD0_FREF_CLK4_OUT		0x005C
+#define PAD1_SYS_32K		0x005E
+#define PAD0_SYS_NRESPWRON		0x0060
+#define PAD1_SYS_NRESWARM		0x0062
+#define PAD0_SYS_PWR_REQ		0x0064
+#define PAD1_SYS_PWRON_RESET	0x0066
+#define PAD0_SYS_BOOT6		0x0068
+#define PAD1_SYS_BOOT7		0x006A
+#define PAD0_JTAG_NTRST		0x006C
+#define PAD1_JTAG_TCK		0x006D
+#define PAD0_JTAG_RTCK		0x0070
+#define PAD1_JTAG_TMS_TMSC		0x0072
+#define PAD0_JTAG_TDI		0x0074
+#define PAD1_JTAG_TDO		0x0076
+#define PADCONF_WAKEUPEVENT_0	0x007C
+#define CONTROL_SMART1NOPMIO_PADCONF_0		0x05A0
+#define CONTROL_SMART1NOPMIO_PADCONF_1		0x05A4
+#define PADCONF_MODE		0x05A8
+#define CONTROL_XTAL_OSCILLATOR			0x05AC
+#define CONTROL_CONTROL_I2C_2			0x0604
+#define CONTROL_CONTROL_JTAG			0x0608
+#define CONTROL_CONTROL_SYS			0x060C
+#define CONTROL_SPARE_RW		0x0614
+#define CONTROL_SPARE_R		0x0618
+#define CONTROL_SPARE_R_C0		0x061C
+
+#define CONTROL_WKUP_PAD1_FREF_CLK4_REQ	0x4A31E05A
+#endif /* _MUX_OMAP4_H_ */
diff --git a/arch/arm/include/asm/arch-omap4/omap.h b/arch/arm/include/asm/arch-omap4/omap.h
new file mode 100644
index 00000000000..2912bbc6376
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/omap.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ *
+ * Authors:
+ *	Aneesh V <aneesh@ti.com>
+ *
+ * Derived from OMAP3 work by
+ *	Richard Woodruff <r-woodruff2@ti.com>
+ *	Syed Mohammed Khasim <x0khasim@ti.com>
+ */
+
+#ifndef _OMAP4_H_
+#define _OMAP4_H_
+
+#if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
+#include <asm/types.h>
+#endif /* !(__KERNEL_STRICT_NAMES || __ASSEMBLY__) */
+
+#include <linux/sizes.h>
+
+/*
+ * L4 Peripherals - L4 Wakeup and L4 Core now
+ */
+#define OMAP44XX_L4_CORE_BASE	0x4A000000
+#define OMAP44XX_L4_WKUP_BASE	0x4A300000
+#define OMAP44XX_L4_PER_BASE	0x48000000
+
+#define OMAP44XX_DRAM_ADDR_SPACE_START	0x80000000
+#define OMAP44XX_DRAM_ADDR_SPACE_END	0xD0000000
+#define DRAM_ADDR_SPACE_START	OMAP44XX_DRAM_ADDR_SPACE_START
+#define DRAM_ADDR_SPACE_END	OMAP44XX_DRAM_ADDR_SPACE_END
+
+/* CONTROL_ID_CODE */
+#define CONTROL_ID_CODE		0x4A002204
+
+#define OMAP4_CONTROL_ID_CODE_ES1_0	0x0B85202F
+#define OMAP4_CONTROL_ID_CODE_ES2_0	0x1B85202F
+#define OMAP4_CONTROL_ID_CODE_ES2_1	0x3B95C02F
+#define OMAP4_CONTROL_ID_CODE_ES2_2	0x4B95C02F
+#define OMAP4_CONTROL_ID_CODE_ES2_3	0x6B95C02F
+#define OMAP4460_CONTROL_ID_CODE_ES1_0	0x0B94E02F
+#define OMAP4460_CONTROL_ID_CODE_ES1_1	0x2B94E02F
+#define OMAP4470_CONTROL_ID_CODE_ES1_0	0x0B97502F
+
+/* UART */
+#define UART1_BASE		(OMAP44XX_L4_PER_BASE + 0x6a000)
+#define UART2_BASE		(OMAP44XX_L4_PER_BASE + 0x6c000)
+#define UART3_BASE		(OMAP44XX_L4_PER_BASE + 0x20000)
+
+/* General Purpose Timers */
+#define GPT1_BASE		(OMAP44XX_L4_WKUP_BASE + 0x18000)
+#define GPT2_BASE		(OMAP44XX_L4_PER_BASE  + 0x32000)
+#define GPT3_BASE		(OMAP44XX_L4_PER_BASE  + 0x34000)
+
+/* Watchdog Timer2 - MPU watchdog */
+#define WDT2_BASE		(OMAP44XX_L4_WKUP_BASE + 0x14000)
+
+/*
+ * Hardware Register Details
+ */
+
+/* Watchdog Timer */
+#define WD_UNLOCK1		0xAAAA
+#define WD_UNLOCK2		0x5555
+
+/* GP Timer */
+#define TCLR_ST			(0x1 << 0)
+#define TCLR_AR			(0x1 << 1)
+#define TCLR_PRE		(0x1 << 5)
+
+/* Control Module */
+#define LDOSRAM_ACTMODE_VSET_IN_MASK	(0x1F << 5)
+#define LDOSRAM_VOLT_CTRL_OVERRIDE	0x0401040f
+#define CONTROL_EFUSE_1_OVERRIDE	0x1C4D0110
+#define CONTROL_EFUSE_2_OVERRIDE	0x99084000
+
+/* LPDDR2 IO regs */
+#define CONTROL_LPDDR2IO_SLEW_125PS_DRV8_PULL_DOWN	0x1C1C1C1C
+#define CONTROL_LPDDR2IO_SLEW_325PS_DRV8_GATE_KEEPER	0x9E9E9E9E
+#define CONTROL_LPDDR2IO_SLEW_315PS_DRV12_PULL_DOWN	0x7C7C7C7C
+#define LPDDR2IO_GR10_WD_MASK				(3 << 17)
+#define CONTROL_LPDDR2IO_3_VAL		0xA0888C0F
+
+/* CONTROL_EFUSE_2 */
+#define CONTROL_EFUSE_2_NMOS_PMOS_PTV_CODE_1		0x00ffc000
+
+#define MMC1_PWRDNZ					BIT(26)
+#define MMC1_PBIASLITE_PWRDNZ				BIT(22)
+#define MMC1_PBIASLITE_VMODE				BIT(21)
+
+#ifndef __ASSEMBLY__
+
+struct s32ktimer {
+	unsigned char res[0x10];
+	unsigned int s32k_cr;	/* 0x10 */
+};
+
+#define DEVICE_TYPE_SHIFT (0x8)
+#define DEVICE_TYPE_MASK (0x7 << DEVICE_TYPE_SHIFT)
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * Non-secure SRAM Addresses
+ * Non-secure RAM starts at 0x40300000 for GP devices. But we keep SRAM_BASE
+ * at 0x40304000(EMU base) so that our code works for both EMU and GP
+ */
+#define NON_SECURE_SRAM_START	0x40304000
+#define NON_SECURE_SRAM_END	0x4030E000	/* Not inclusive */
+#define NON_SECURE_SRAM_IMG_END	0x4030C000
+#define SRAM_SCRATCH_SPACE_ADDR	(NON_SECURE_SRAM_IMG_END - SZ_1K)
+/* base address for indirect vectors (internal boot mode) */
+#define SRAM_ROM_VECT_BASE	0x4030D000
+
+/* ABB settings */
+#define OMAP_ABB_SETTLING_TIME		50
+#define OMAP_ABB_CLOCK_CYCLES		16
+
+/* ABB tranxdone mask */
+#define OMAP_ABB_MPU_TXDONE_MASK	(0x1 << 7)
+
+#define OMAP44XX_SAR_RAM_BASE		0x4a326000
+#define OMAP_REBOOT_REASON_OFFSET	0xA0C
+#define OMAP_REBOOT_REASON_SIZE		0x0F
+
+/* Boot parameters */
+#ifndef __ASSEMBLY__
+struct omap_boot_parameters {
+	unsigned int boot_message;
+	unsigned int boot_device_descriptor;
+	unsigned char boot_device;
+	unsigned char reset_reason;
+	unsigned char ch_flags;
+};
+
+int omap_reboot_mode(char *mode, unsigned int length);
+int omap_reboot_mode_clear(void);
+int omap_reboot_mode_store(char *mode);
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/arch-omap4/spl.h b/arch/arm/include/asm/arch-omap4/spl.h
new file mode 100644
index 00000000000..d24944af0ae
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/spl.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2012
+ * Texas Instruments, <www.ti.com>
+ */
+#ifndef	_ASM_ARCH_SPL_H_
+#define	_ASM_ARCH_SPL_H_
+
+#define BOOT_DEVICE_NONE	0x00
+#define BOOT_DEVICE_XIP		0x01
+#define BOOT_DEVICE_XIPWAIT	0x02
+#define BOOT_DEVICE_NAND	0x03
+#define BOOT_DEVICE_ONENAND	0x04
+#define BOOT_DEVICE_MMC1	0x05
+#define BOOT_DEVICE_MMC2	0x06
+#define BOOT_DEVICE_MMC2_2	0x07
+#define BOOT_DEVICE_UART	0x43
+#define BOOT_DEVICE_USB		0x45
+
+#define MMC_BOOT_DEVICES_START	BOOT_DEVICE_MMC1
+#define MMC_BOOT_DEVICES_END	BOOT_DEVICE_MMC2_2
+#endif
diff --git a/arch/arm/include/asm/arch-omap4/sys_proto.h b/arch/arm/include/asm/arch-omap4/sys_proto.h
new file mode 100644
index 00000000000..c6e6f6ca480
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap4/sys_proto.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ */
+
+#ifndef _SYS_PROTO_H_
+#define _SYS_PROTO_H_
+
+#include <asm/arch/omap.h>
+#include <asm/arch/clock.h>
+#include <asm/io.h>
+#include <asm/omap_common.h>
+#include <linux/mtd/omap_gpmc.h>
+#include <asm/arch/mux_omap4.h>
+#include <asm/ti-common/sys_proto.h>
+
+#ifdef CONFIG_SYS_EMIF_PRECALCULATED_TIMING_REGS
+extern const struct emif_regs emif_regs_elpida_200_mhz_2cs;
+extern const struct emif_regs emif_regs_elpida_380_mhz_1cs;
+extern const struct emif_regs emif_regs_elpida_400_mhz_1cs;
+extern const struct emif_regs emif_regs_elpida_400_mhz_2cs;
+extern const struct dmm_lisa_map_regs lisa_map_2G_x_1_x_2;
+extern const struct dmm_lisa_map_regs lisa_map_2G_x_2_x_2;
+extern const struct dmm_lisa_map_regs ma_lisa_map_2G_x_2_x_2;
+#else
+extern const struct lpddr2_device_details elpida_2G_S4_details;
+extern const struct lpddr2_device_details elpida_4G_S4_details;
+#endif
+
+#ifdef CONFIG_SYS_DEFAULT_LPDDR2_TIMINGS
+extern const struct lpddr2_device_timings jedec_default_timings;
+#else
+extern const struct lpddr2_device_timings elpida_2G_S4_timings;
+#endif
+
+struct omap_sysinfo {
+	char *board_string;
+};
+
+extern const struct omap_sysinfo sysinfo;
+
+void gpmc_init(void);
+void watchdog_init(void);
+u32 get_device_type(void);
+void do_set_mux(u32 base, struct pad_conf_entry const *array, int size);
+void set_muxconf_regs(void);
+u32 wait_on_value(u32 read_bit_mask, u32 match_value, void *read_addr,
+		  u32 bound);
+void sdelay(unsigned long loops);
+void setup_early_clocks(void);
+void prcm_init(void);
+void do_board_detect(void);
+void bypass_dpll(u32 const base);
+void freq_update_core(void);
+u32 get_sys_clk_freq(void);
+u32 omap4_ddr_clk(void);
+void cancel_out(u32 *num, u32 *den, u32 den_limit);
+void sdram_init(void);
+u32 omap_sdram_size(void);
+u32 cortex_rev(void);
+void save_omap_boot_params(void);
+void init_omap_revision(void);
+void do_io_settings(void);
+void sri2c_init(void);
+int omap_vc_bypass_send_value(u8 sa, u8 reg_addr, u8 reg_data);
+u32 warm_reset(void);
+void force_emif_self_refresh(void);
+void setup_warmreset_time(void);
+
+#define OMAP4_SERVICE_PL310_CONTROL_REG_SET	0x102
+
+#endif
diff --git a/arch/arm/include/asm/omap_common.h b/arch/arm/include/asm/omap_common.h
index 5e74f41dd97..9945eeb66b8 100644
--- a/arch/arm/include/asm/omap_common.h
+++ b/arch/arm/include/asm/omap_common.h
@@ -490,7 +490,7 @@ struct omap_sys_ctrl_regs {
 	u32 ctrl_core_sma_sw_1;
 };
 
-#if defined(CONFIG_OMAP54XX)
+#if defined(CONFIG_OMAP44XX) || defined(CONFIG_OMAP54XX)
 struct dpll_params {
 	u32 m;
 	u32 n;
@@ -523,7 +523,7 @@ struct dpll_regs {
 	u32 cm_div_h23_dpll;
 	u32 cm_div_h24_dpll;
 };
-#endif /* CONFIG_OMAP54XX */
+#endif /* CONFIG_OMAP44XX || CONFIG_OMAP54XX */
 
 struct dplls {
 	const struct dpll_params *mpu;
@@ -547,7 +547,7 @@ struct pmic_data {
 	int (*pmic_write)(u8 sa, u8 reg_addr, u8 reg_data);
 };
 
-#if defined(CONFIG_OMAP54XX)
+#if defined(CONFIG_OMAP44XX) || defined(CONFIG_OMAP54XX)
 enum {
 	OPP_LOW,
 	OPP_NOM,
@@ -593,7 +593,7 @@ struct vcores_data {
 	struct volts eve;
 	struct volts iva;
 };
-#endif /* CONFIG_OMAP54XX */
+#endif /* CONFIG_OMAP44XX || CONFIG_OMAP54XX */
 
 extern struct prcm_regs const **prcm;
 extern struct prcm_regs const omap5_es1_prcm;
@@ -626,7 +626,7 @@ const struct dpll_params *get_iva_dpll_params(struct dplls const *);
 const struct dpll_params *get_usb_dpll_params(struct dplls const *);
 const struct dpll_params *get_abe_dpll_params(struct dplls const *);
 
-#if defined(CONFIG_OMAP54XX)
+#if defined(CONFIG_OMAP44XX) || defined(CONFIG_OMAP54XX)
 void do_enable_clocks(u32 const *clk_domains,
 		      u32 const *clk_modules_hw_auto,
 		      u32 const *clk_modules_explicit_en,
@@ -635,7 +635,7 @@ void do_enable_clocks(u32 const *clk_domains,
 void do_disable_clocks(u32 const *clk_domains,
 		       u32 const *clk_modules_disable,
 		       u8 wait_for_disable);
-#endif /* CONFIG_OMAP54XX */
+#endif /* CONFIG_OMAP44XX || CONFIG_OMAP54XX */
 
 void do_enable_ipu_clocks(u32 const *clk_domains,
 			  u32 const *clk_modules_hw_auto,
@@ -653,9 +653,9 @@ void enable_basic_uboot_clocks(void);
 void enable_usb_clocks(int index);
 void disable_usb_clocks(int index);
 
-#if defined(CONFIG_OMAP54XX)
+#if defined(CONFIG_OMAP44XX) || defined(CONFIG_OMAP54XX)
 void scale_vcores(struct vcores_data const *);
-#endif /* CONFIG_OMAP54XX */
+#endif /* CONFIG_OMAP44XX || CONFIG_OMAP54XX */
 int get_voltrail_opp(int rail_offset);
 u32 get_offset_code(u32 volt_offset, struct pmic_data *pmic);
 void do_scale_vcore(u32 vcore_reg, u32 volt_mv, struct pmic_data *pmic);
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1e989ac48ac..767ca904b61 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -29,6 +29,25 @@ config OMAP34XX
 	imply SYS_THUMB_BUILD
 	imply TWL4030_POWER
 
+config OMAP44XX
+	bool "OMAP44XX SoC"
+	select DM_EVENT
+	select SPL_USE_TINY_PRINTF
+	select SPL_SYS_NO_VECTOR_TABLE if SPL
+	imply SPL_FS_FAT
+	imply SPL_GPIO
+	imply SPL_LIBCOMMON_SUPPORT
+	imply SPL_LIBDISK_SUPPORT
+	imply SPL_LIBGENERIC_SUPPORT
+	imply SPL_MMC
+	imply SPL_POWER
+	imply SPL_SERIAL
+	imply SYS_I2C_OMAP24XX
+	imply SYS_THUMB_BUILD
+	help
+	  Support for OMAP44x SOC from Texas Instruments.
+	  OMAP44x features two Cortex-A9 cores.
+
 config OMAP54XX
 	bool "OMAP54XX SoC"
 	select ARM_CORTEX_A15_CVE_2017_5715
@@ -139,7 +158,7 @@ config SYS_AUTOMATIC_SDRAM_DETECTION
 	bool
 
 choice
-	depends on OMAP54XX
+	depends on OMAP44XX || OMAP54XX
 	prompt "Static or dynamic DDR timing calculations"
 	default SYS_EMIF_PRECALCULATED_TIMING_REGS
 	help
@@ -152,6 +171,7 @@ config SYS_EMIF_PRECALCULATED_TIMING_REGS
 
 config SYS_DEFAULT_LPDDR2_TIMINGS
 	bool "Use default LPDDR2 timing values"
+	depends on !OMAP44XX
 	select SYS_AUTOMATIC_SDRAM_DETECTION
 
 endchoice
@@ -195,6 +215,8 @@ endif
 
 source "arch/arm/mach-omap2/omap3/Kconfig"
 
+source "arch/arm/mach-omap2/omap4/Kconfig"
+
 source "arch/arm/mach-omap2/omap5/Kconfig"
 
 source "arch/arm/mach-omap2/am33xx/Kconfig"
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fb5ea97e56e..c34caca78af 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(if $(filter am33xx,$(SOC)),y) += am33xx/
 obj-$(CONFIG_OMAP34XX) += omap3/
+obj-$(CONFIG_OMAP44XX) += omap4/
 obj-$(CONFIG_OMAP54XX) += omap5/
 
 obj-y	+= reset.o
@@ -18,7 +19,7 @@ endif
 obj-y	+= utils.o
 
 obj-y	+= sysinfo-common.o
-ifdef CONFIG_OMAP54XX
+ifneq ($(CONFIG_OMAP44XX)$(CONFIG_OMAP54XX),)
 obj-y	+= hwinit-common.o
 obj-y	+= clocks-common.o
 obj-y	+= emif-common.o
diff --git a/arch/arm/mach-omap2/omap4/Kconfig b/arch/arm/mach-omap2/omap4/Kconfig
new file mode 100644
index 00000000000..b320490d666
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/Kconfig
@@ -0,0 +1,6 @@
+if OMAP44XX
+
+config SYS_SOC
+	default "omap4"
+
+endif
diff --git a/arch/arm/mach-omap2/omap4/Makefile b/arch/arm/mach-omap2/omap4/Makefile
new file mode 100644
index 00000000000..2566c6ca2d3
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2000-2010
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+
+obj-y	+= boot.o
+obj-y	+= sdram_elpida.o
+obj-y	+= hwinit.o
+obj-y	+= prcm-regs.o
+obj-y	+= hw_data.o
diff --git a/arch/arm/mach-omap2/omap4/boot.c b/arch/arm/mach-omap2/omap4/boot.c
new file mode 100644
index 00000000000..fc71db42d90
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/boot.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * OMAP4 boot
+ *
+ * Copyright (C) 2015 Paul Kocialkowski <contact@paulk.fr>
+ */
+
+#include <asm/io.h>
+#include <asm/omap_common.h>
+#include <asm/arch/sys_proto.h>
+#include <spl.h>
+
+static u32 boot_devices[] = {
+	BOOT_DEVICE_MMC2,
+	BOOT_DEVICE_XIP,
+	BOOT_DEVICE_XIPWAIT,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_XIPWAIT,
+	BOOT_DEVICE_MMC1,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_MMC2,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_XIPWAIT,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_MMC1,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_MMC2,
+	BOOT_DEVICE_XIP,
+	BOOT_DEVICE_XIPWAIT,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_MMC1,
+	BOOT_DEVICE_MMC1,
+	BOOT_DEVICE_ONENAND,
+	BOOT_DEVICE_MMC2,
+	BOOT_DEVICE_XIP,
+	BOOT_DEVICE_MMC2_2,
+	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_MMC2_2,
+	BOOT_DEVICE_MMC1,
+	BOOT_DEVICE_MMC2_2,
+	BOOT_DEVICE_MMC2_2,
+	BOOT_DEVICE_NONE,
+	BOOT_DEVICE_XIPWAIT,
+};
+
+u32 omap_sys_boot_device(void)
+{
+	u32 sys_boot;
+
+	/* Grab the first 5 bits of the status register for SYS_BOOT. */
+	sys_boot = readl((u32 *)(*ctrl)->control_status) & ((1 << 5) - 1);
+
+	if (sys_boot >= (sizeof(boot_devices) / sizeof(u32)))
+		return BOOT_DEVICE_NONE;
+
+	return boot_devices[sys_boot];
+}
+
+int omap_reboot_mode(char *mode, unsigned int length)
+{
+	unsigned int limit;
+	unsigned int i;
+
+	if (length < 2)
+		return -1;
+
+	if (!warm_reset())
+		return -1;
+
+	limit = (length < OMAP_REBOOT_REASON_SIZE) ? length :
+		OMAP_REBOOT_REASON_SIZE;
+
+	for (i = 0; i < (limit - 1); i++)
+		mode[i] = readb((u8 *)(OMAP44XX_SAR_RAM_BASE +
+			OMAP_REBOOT_REASON_OFFSET + i));
+
+	mode[i] = '\0';
+
+	return 0;
+}
+
+int omap_reboot_mode_clear(void)
+{
+	writeb(0, (u8 *)(OMAP44XX_SAR_RAM_BASE + OMAP_REBOOT_REASON_OFFSET));
+
+	return 0;
+}
+
+int omap_reboot_mode_store(char *mode)
+{
+	unsigned int i;
+
+	for (i = 0; i < (OMAP_REBOOT_REASON_SIZE - 1) && mode[i] != '\0'; i++)
+		writeb(mode[i], (u8 *)(OMAP44XX_SAR_RAM_BASE +
+			OMAP_REBOOT_REASON_OFFSET + i));
+
+	writeb('\0', (u8 *)(OMAP44XX_SAR_RAM_BASE +
+		OMAP_REBOOT_REASON_OFFSET + i));
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/omap4/hw_data.c b/arch/arm/mach-omap2/omap4/hw_data.c
new file mode 100644
index 00000000000..bda7443da79
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/hw_data.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * HW data initialization for OMAP4
+ *
+ * (C) Copyright 2013
+ * Texas Instruments, <www.ti.com>
+ *
+ * Sricharan R <r.sricharan@ti.com>
+ */
+#include <asm/arch/omap.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/omap_common.h>
+#include <asm/arch/clock.h>
+#include <asm/omap_gpio.h>
+#include <asm/io.h>
+
+/* TPS */
+#define TPS62361_REG_ADDR_SET1	0x1
+#define TPS62361_VSEL0_GPIO	7
+#define TPS62361_BASE_VOLT_MV	500
+
+#define PHOENIX_SMPS_BASE_VOLT_STD_MODE_WITH_OFFSET_UV	709000
+#define PHOENIX_SMPS_BASE_VOLT_STD_MODE_UV		607700
+
+struct prcm_regs const **prcm =	(struct prcm_regs const **)OMAP_SRAM_SCRATCH_PRCM_PTR;
+struct dplls const **dplls_data = (struct dplls const **)OMAP_SRAM_SCRATCH_DPLLS_PTR;
+struct vcores_data const **omap_vcores = (struct vcores_data const **)OMAP_SRAM_SCRATCH_VCORES_PTR;
+struct omap_sys_ctrl_regs const **ctrl =
+	(struct omap_sys_ctrl_regs const **)OMAP_SRAM_SCRATCH_SYS_CTRL;
+
+/*
+ * The M & N values in the following tables are created using the
+ * following tool:
+ * tools/omap/clocks_get_m_n.c
+ * Please use this tool for creating the table for any new frequency.
+ */
+
+/*
+ * dpll locked at 1400 MHz MPU clk at 700 MHz(OPP100) - DCC OFF
+ * OMAP4460 OPP_NOM frequency
+ */
+static const struct dpll_params mpu_dpll_params_1400mhz[NUM_SYS_CLKS] = {
+	{175, 2, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 12 MHz   */
+	{700, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 13 MHz   */
+	{125, 2, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 16.8 MHz */
+	{401, 10, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 19.2 MHz */
+	{350, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 26 MHz   */
+	{700, 26, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 27 MHz   */
+	{638, 34, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1}	/* 38.4 MHz */
+};
+
+/*
+ * dpll locked at 1600 MHz - MPU clk at 800 MHz(OPP Turbo 4430)
+ * OMAP4430 OPP_TURBO frequency
+ * OMAP4470 OPP_NOM frequency
+ */
+static const struct dpll_params mpu_dpll_params_1600mhz[NUM_SYS_CLKS] = {
+	{200, 2, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 12 MHz   */
+	{800, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 13 MHz   */
+	{619, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 16.8 MHz */
+	{125, 2, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 19.2 MHz */
+	{400, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 26 MHz   */
+	{800, 26, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 27 MHz   */
+	{125, 5, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1}		/* 38.4 MHz */
+};
+
+/*
+ * dpll locked at 1200 MHz - MPU clk at 600 MHz
+ * OMAP4430 OPP_NOM frequency
+ */
+static const struct dpll_params mpu_dpll_params_1200mhz[NUM_SYS_CLKS] = {
+	{50, 0, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},		/* 12 MHz   */
+	{600, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 13 MHz   */
+	{250, 6, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 16.8 MHz */
+	{125, 3, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 19.2 MHz */
+	{300, 12, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 26 MHz   */
+	{200, 8, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 27 MHz   */
+	{125, 7, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1}		/* 38.4 MHz */
+};
+
+/* OMAP4460 OPP_NOM frequency */
+/* OMAP4470 OPP_NOM (Low Power) frequency */
+static const struct dpll_params core_dpll_params_1600mhz[NUM_SYS_CLKS] = {
+	{200, 2, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 12 MHz   */
+	{800, 12, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 13 MHz   */
+	{619, 12, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 16.8 MHz */
+	{125, 2, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 19.2 MHz */
+	{400, 12, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 26 MHz   */
+	{800, 26, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 27 MHz   */
+	{125, 5, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1}	/* 38.4 MHz */
+};
+
+/* OMAP4430 ES1 OPP_NOM frequency */
+static const struct dpll_params core_dpll_params_es1_1524mhz[NUM_SYS_CLKS] = {
+	{127, 1, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 12 MHz   */
+	{762, 12, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 13 MHz   */
+	{635, 13, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 16.8 MHz */
+	{635, 15, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 19.2 MHz */
+	{381, 12, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 26 MHz   */
+	{254, 8, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 27 MHz   */
+	{496, 24, 1, 5, 8, 4, 6, 5, -1, -1, -1, -1}	/* 38.4 MHz */
+};
+
+/* OMAP4430 ES2.X OPP_NOM frequency */
+static const struct dpll_params
+		core_dpll_params_es2_1600mhz_ddr200mhz[NUM_SYS_CLKS] = {
+	{200, 2, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 12 MHz   */
+	{800, 12, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 13 MHz   */
+	{619, 12, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 16.8 MHz */
+	{125, 2, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 19.2 MHz */
+	{400, 12, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 26 MHz   */
+	{800, 26, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1},	/* 27 MHz   */
+	{125, 5, 2, 5, 8, 4, 6, 5, -1, -1, -1, -1}	/* 38.4 MHz */
+};
+
+static const struct dpll_params per_dpll_params_1536mhz[NUM_SYS_CLKS] = {
+	{64, 0, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1},	/* 12 MHz   */
+	{768, 12, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1},	/* 13 MHz   */
+	{320, 6, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1},	/* 16.8 MHz */
+	{40, 0, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1},	/* 19.2 MHz */
+	{384, 12, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1},	/* 26 MHz   */
+	{256, 8, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1},	/* 27 MHz   */
+	{20, 0, 8, 6, 12, 9, 4, 5, -1, -1, -1, -1}	/* 38.4 MHz */
+};
+
+static const struct dpll_params iva_dpll_params_1862mhz[NUM_SYS_CLKS] = {
+	{931, 11, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1},	/* 12 MHz   */
+	{931, 12, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1},	/* 13 MHz   */
+	{665, 11, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1},	/* 16.8 MHz */
+	{727, 14, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1},	/* 19.2 MHz */
+	{931, 25, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1},	/* 26 MHz   */
+	{931, 26, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1},	/* 27 MHz   */
+	{291, 11, -1, -1, 4, 7, -1, -1, -1, -1, -1, -1}		/* 38.4 MHz */
+};
+
+/* ABE M & N values with 32K clock as source */
+static const struct dpll_params abe_dpll_params_32k_196608khz = {
+	750, 0, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static const struct dpll_params usb_dpll_params_1920mhz[NUM_SYS_CLKS] = {
+	{80, 0, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1},		/* 12 MHz   */
+	{960, 12, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 13 MHz   */
+	{400, 6, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 16.8 MHz */
+	{50, 0, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1},		/* 19.2 MHz */
+	{480, 12, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 26 MHz   */
+	{320, 8, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1},	/* 27 MHz   */
+	{25, 0, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1}		/* 38.4 MHz */
+};
+
+struct dplls omap4430_dplls_es1 = {
+	.mpu = mpu_dpll_params_1200mhz,
+	.core = core_dpll_params_es1_1524mhz,
+	.per = per_dpll_params_1536mhz,
+	.iva = iva_dpll_params_1862mhz,
+	.abe = &abe_dpll_params_32k_196608khz,
+	.usb = usb_dpll_params_1920mhz,
+	.ddr = NULL
+};
+
+struct dplls omap4430_dplls_es20 = {
+	.mpu = mpu_dpll_params_1200mhz,
+	.core = core_dpll_params_es2_1600mhz_ddr200mhz,
+	.per = per_dpll_params_1536mhz,
+	.iva = iva_dpll_params_1862mhz,
+	.abe = &abe_dpll_params_32k_196608khz,
+	.usb = usb_dpll_params_1920mhz,
+	.ddr = NULL
+};
+
+struct dplls omap4430_dplls = {
+	.mpu = mpu_dpll_params_1200mhz,
+	.core = core_dpll_params_1600mhz,
+	.per = per_dpll_params_1536mhz,
+	.iva = iva_dpll_params_1862mhz,
+	.abe = &abe_dpll_params_32k_196608khz,
+	.usb = usb_dpll_params_1920mhz,
+	.ddr = NULL
+};
+
+struct dplls omap4460_dplls = {
+	.mpu = mpu_dpll_params_1400mhz,
+	.core = core_dpll_params_1600mhz,
+	.per = per_dpll_params_1536mhz,
+	.iva = iva_dpll_params_1862mhz,
+	.abe = &abe_dpll_params_32k_196608khz,
+	.usb = usb_dpll_params_1920mhz,
+	.ddr = NULL
+};
+
+struct dplls omap4470_dplls = {
+	.mpu = mpu_dpll_params_1600mhz,
+	.core = core_dpll_params_1600mhz,
+	.per = per_dpll_params_1536mhz,
+	.iva = iva_dpll_params_1862mhz,
+	.abe = &abe_dpll_params_32k_196608khz,
+	.usb = usb_dpll_params_1920mhz,
+	.ddr = NULL
+};
+
+struct pmic_data twl6030_4430es1 = {
+	.base_offset = PHOENIX_SMPS_BASE_VOLT_STD_MODE_UV,
+	.step = 12660, /* 12.66 mV represented in uV */
+	/* The code starts at 1 not 0 */
+	.start_code = 1,
+	.i2c_slave_addr	= SMPS_I2C_SLAVE_ADDR,
+	.pmic_bus_init	= sri2c_init,
+	.pmic_write	= omap_vc_bypass_send_value,
+};
+
+/* twl6030 struct is used for TWL6030 and TWL6032 PMIC */
+struct pmic_data twl6030 = {
+	.base_offset = PHOENIX_SMPS_BASE_VOLT_STD_MODE_WITH_OFFSET_UV,
+	.step = 12660, /* 12.66 mV represented in uV */
+	/* The code starts at 1 not 0 */
+	.start_code = 1,
+	.i2c_slave_addr	= SMPS_I2C_SLAVE_ADDR,
+	.pmic_bus_init	= sri2c_init,
+	.pmic_write	= omap_vc_bypass_send_value,
+};
+
+struct pmic_data tps62361 = {
+	.base_offset = TPS62361_BASE_VOLT_MV,
+	.step = 10000, /* 10 mV represented in uV */
+	.start_code = 0,
+	.gpio = TPS62361_VSEL0_GPIO,
+	.gpio_en = 1,
+	.i2c_slave_addr	= SMPS_I2C_SLAVE_ADDR,
+	.pmic_bus_init	= sri2c_init,
+	.pmic_write	= omap_vc_bypass_send_value,
+};
+
+struct vcores_data omap4430_volts_es1 = {
+	.mpu.value[OPP_NOM] = 1325,
+	.mpu.addr = SMPS_REG_ADDR_VCORE1,
+	.mpu.pmic = &twl6030_4430es1,
+
+	.core.value[OPP_NOM] = 1200,
+	.core.addr = SMPS_REG_ADDR_VCORE3,
+	.core.pmic = &twl6030_4430es1,
+
+	.mm.value[OPP_NOM] = 1200,
+	.mm.addr = SMPS_REG_ADDR_VCORE2,
+	.mm.pmic = &twl6030_4430es1,
+};
+
+struct vcores_data omap4430_volts = {
+	.mpu.value[OPP_NOM] = 1325,
+	.mpu.addr = SMPS_REG_ADDR_VCORE1,
+	.mpu.pmic = &twl6030,
+
+	.core.value[OPP_NOM] = 1200,
+	.core.addr = SMPS_REG_ADDR_VCORE3,
+	.core.pmic = &twl6030,
+
+	.mm.value[OPP_NOM] = 1200,
+	.mm.addr = SMPS_REG_ADDR_VCORE2,
+	.mm.pmic = &twl6030,
+};
+
+struct vcores_data omap4460_volts = {
+	.mpu.value[OPP_NOM] = 1203,
+	.mpu.addr = TPS62361_REG_ADDR_SET1,
+	.mpu.pmic = &tps62361,
+
+	.core.value[OPP_NOM] = 1200,
+	.core.addr = SMPS_REG_ADDR_VCORE1,
+	.core.pmic = &twl6030,
+
+	.mm.value[OPP_NOM] = 1200,
+	.mm.addr = SMPS_REG_ADDR_VCORE2,
+	.mm.pmic = &twl6030,
+};
+
+/*
+ * Take closest integer part of the mV value corresponding to a TWL6032 SMPS
+ * voltage selection code. Aligned with OMAP4470 ES1.0 OCA V.0.7.
+ */
+struct vcores_data omap4470_volts = {
+	.mpu.value[OPP_NOM] = 1202,
+	.mpu.addr = SMPS_REG_ADDR_SMPS1,
+	.mpu.pmic = &twl6030,
+
+	.core.value[OPP_NOM] = 1126,
+	.core.addr = SMPS_REG_ADDR_SMPS2,
+	.core.pmic = &twl6030,
+
+	.mm.value[OPP_NOM] = 1139,
+	.mm.addr = SMPS_REG_ADDR_SMPS5,
+	.mm.pmic = &twl6030,
+};
+
+/*
+ * Enable essential clock domains, modules and
+ * do some additional special settings needed
+ */
+void enable_basic_clocks(void)
+{
+	u32 const clk_domains_essential[] = {
+		(*prcm)->cm_l4per_clkstctrl,
+		(*prcm)->cm_l3init_clkstctrl,
+		(*prcm)->cm_memif_clkstctrl,
+		(*prcm)->cm_l4cfg_clkstctrl,
+		0
+	};
+
+	u32 const clk_modules_hw_auto_essential[] = {
+		(*prcm)->cm_l3_gpmc_clkctrl,
+		(*prcm)->cm_memif_emif_1_clkctrl,
+		(*prcm)->cm_memif_emif_2_clkctrl,
+		(*prcm)->cm_l4cfg_l4_cfg_clkctrl,
+		(*prcm)->cm_wkup_gpio1_clkctrl,
+		(*prcm)->cm_l4per_gpio2_clkctrl,
+		(*prcm)->cm_l4per_gpio3_clkctrl,
+		(*prcm)->cm_l4per_gpio4_clkctrl,
+		(*prcm)->cm_l4per_gpio5_clkctrl,
+		(*prcm)->cm_l4per_gpio6_clkctrl,
+		0
+	};
+
+	u32 const clk_modules_explicit_en_essential[] = {
+		(*prcm)->cm_wkup_gptimer1_clkctrl,
+		(*prcm)->cm_l3init_hsmmc1_clkctrl,
+		(*prcm)->cm_l3init_hsmmc2_clkctrl,
+		(*prcm)->cm_l4per_gptimer2_clkctrl,
+		(*prcm)->cm_wkup_wdtimer2_clkctrl,
+		(*prcm)->cm_l4per_uart3_clkctrl,
+		(*prcm)->cm_l4per_i2c1_clkctrl,
+		(*prcm)->cm_l4per_i2c2_clkctrl,
+		(*prcm)->cm_l4per_i2c3_clkctrl,
+		(*prcm)->cm_l4per_i2c4_clkctrl,
+		0
+	};
+
+	/* Enable optional additional functional clock for GPIO4 */
+	setbits_le32((*prcm)->cm_l4per_gpio4_clkctrl, GPIO4_CLKCTRL_OPTFCLKEN_MASK);
+
+	/* Enable 96 MHz clock for MMC1 & MMC2 */
+	setbits_le32((*prcm)->cm_l3init_hsmmc1_clkctrl, HSMMC_CLKCTRL_CLKSEL_MASK);
+	setbits_le32((*prcm)->cm_l3init_hsmmc2_clkctrl, HSMMC_CLKCTRL_CLKSEL_MASK);
+
+	/* Select 32KHz clock as the source of GPTIMER1 */
+	setbits_le32((*prcm)->cm_wkup_gptimer1_clkctrl, GPTIMER1_CLKCTRL_CLKSEL_MASK);
+
+	/* Enable optional 48M functional clock for USB PHY */
+	setbits_le32((*prcm)->cm_l3init_usbphy_clkctrl, USBPHY_CLKCTRL_OPTFCLKEN_PHY_48M_MASK);
+
+	/* Enable 32 KHz clock for USB PHY */
+	setbits_le32((*prcm)->cm_coreaon_usb_phy1_core_clkctrl,
+		     USBPHY_CORE_CLKCTRL_OPTFCLKEN_CLK32K);
+
+	do_enable_clocks(clk_domains_essential,
+			 clk_modules_hw_auto_essential,
+			 clk_modules_explicit_en_essential,
+			 1);
+}
+
+void enable_basic_uboot_clocks(void)
+{
+	u32 const clk_domains_essential[] = {
+		0
+	};
+
+	u32 const clk_modules_hw_auto_essential[] = {
+		(*prcm)->cm_l3init_hsusbotg_clkctrl,
+		(*prcm)->cm_l3init_usbphy_clkctrl,
+		(*prcm)->cm_clksel_usb_60mhz,
+		(*prcm)->cm_l3init_hsusbtll_clkctrl,
+		0
+	};
+
+	u32 const clk_modules_explicit_en_essential[] = {
+		(*prcm)->cm_l4per_mcspi1_clkctrl,
+		(*prcm)->cm_l3init_hsusbhost_clkctrl,
+		0
+	};
+
+	do_enable_clocks(clk_domains_essential,
+			 clk_modules_hw_auto_essential,
+			 clk_modules_explicit_en_essential,
+			 1);
+}
+
+void hw_data_init(void)
+{
+	u32 omap_rev = omap_revision();
+
+	(*prcm) = &omap4_prcm;
+
+	switch (omap_rev) {
+	case OMAP4430_ES1_0:
+		*dplls_data = &omap4430_dplls_es1;
+		*omap_vcores = &omap4430_volts_es1;
+		break;
+	case OMAP4430_ES2_0:
+		*dplls_data = &omap4430_dplls_es20;
+		*omap_vcores = &omap4430_volts;
+		break;
+	case OMAP4430_ES2_1:
+	case OMAP4430_ES2_2:
+	case OMAP4430_ES2_3:
+		*dplls_data = &omap4430_dplls;
+		*omap_vcores = &omap4430_volts;
+		break;
+	case OMAP4460_ES1_0:
+	case OMAP4460_ES1_1:
+		*dplls_data = &omap4460_dplls;
+		*omap_vcores = &omap4460_volts;
+		break;
+	case OMAP4470_ES1_0:
+		*dplls_data = &omap4470_dplls;
+		*omap_vcores = &omap4470_volts;
+		break;
+	default:
+		printf("\n INVALID OMAP REVISION ");
+	}
+
+	*ctrl = &omap4_ctrl;
+}
diff --git a/arch/arm/mach-omap2/omap4/hwinit.c b/arch/arm/mach-omap2/omap4/hwinit.c
new file mode 100644
index 00000000000..9beecb8ad49
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/hwinit.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * Common functions for OMAP4 based boards
+ *
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ *
+ * Author :
+ *	Aneesh V	<aneesh@ti.com>
+ *	Steve Sakoman	<steve@sakoman.com>
+ */
+#include <palmas.h>
+#include <asm/armv7.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/sizes.h>
+#include <asm/emif.h>
+#include <asm/arch/gpio.h>
+#include <asm/omap_common.h>
+
+u32 *const omap_si_rev = (u32 *)OMAP_SRAM_SCRATCH_OMAP_REV;
+
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+static const struct gpio_bank gpio_bank_44xx[6] = {
+	{ (void *)OMAP44XX_GPIO1_BASE },
+	{ (void *)OMAP44XX_GPIO2_BASE },
+	{ (void *)OMAP44XX_GPIO3_BASE },
+	{ (void *)OMAP44XX_GPIO4_BASE },
+	{ (void *)OMAP44XX_GPIO5_BASE },
+	{ (void *)OMAP44XX_GPIO6_BASE },
+};
+
+const struct gpio_bank *const omap_gpio_bank = gpio_bank_44xx;
+#endif
+
+/*
+ * Some tuning of IOs for optimal power and performance
+ */
+void do_io_settings(void)
+{
+	u32 omap4_rev = omap_revision();
+	u32 lpddr2io;
+
+	if (omap4_rev == OMAP4430_ES1_0)
+		lpddr2io = CONTROL_LPDDR2IO_SLEW_125PS_DRV8_PULL_DOWN;
+	else if (omap4_rev == OMAP4430_ES2_0)
+		lpddr2io = CONTROL_LPDDR2IO_SLEW_325PS_DRV8_GATE_KEEPER;
+	else
+		lpddr2io = CONTROL_LPDDR2IO_SLEW_315PS_DRV12_PULL_DOWN;
+
+	/* EMIF1 */
+	writel(lpddr2io, (*ctrl)->control_lpddr2io1_0);
+	writel(lpddr2io, (*ctrl)->control_lpddr2io1_1);
+	/* No pull for GR10 as per hw team's recommendation */
+	writel(lpddr2io & ~LPDDR2IO_GR10_WD_MASK, (*ctrl)->control_lpddr2io1_2);
+	writel(CONTROL_LPDDR2IO_3_VAL, (*ctrl)->control_lpddr2io1_3);
+
+	/* EMIF2 */
+	writel(lpddr2io, (*ctrl)->control_lpddr2io2_0);
+	writel(lpddr2io, (*ctrl)->control_lpddr2io2_1);
+	/* No pull for GR10 as per hw team's recommendation */
+	writel(lpddr2io & ~LPDDR2IO_GR10_WD_MASK, (*ctrl)->control_lpddr2io2_2);
+	writel(CONTROL_LPDDR2IO_3_VAL, (*ctrl)->control_lpddr2io2_3);
+
+	/*
+	 * Some of these settings (TRIM values) come from eFuse and are
+	 * in turn programmed in the eFuse at manufacturing time after
+	 * calibration of the device. Do the software over-ride only if
+	 * the device is not correctly trimmed
+	 */
+	if (!(readl((*ctrl)->control_std_fuse_opp_bgap) & 0xFFFF)) {
+		writel(LDOSRAM_VOLT_CTRL_OVERRIDE,
+		       (*ctrl)->control_ldosram_iva_voltage_ctrl);
+
+		writel(LDOSRAM_VOLT_CTRL_OVERRIDE,
+		       (*ctrl)->control_ldosram_mpu_voltage_ctrl);
+
+		writel(LDOSRAM_VOLT_CTRL_OVERRIDE,
+		       (*ctrl)->control_ldosram_core_voltage_ctrl);
+	}
+
+	/*
+	 * Over-ride the register
+	 *	i. unconditionally for all 4430
+	 *	ii. only if un-trimmed for 4460
+	 */
+	if (!readl((*ctrl)->control_efuse_1))
+		writel(CONTROL_EFUSE_1_OVERRIDE, (*ctrl)->control_efuse_1);
+
+	if (omap4_rev < OMAP4460_ES1_0 || !readl((*ctrl)->control_efuse_2))
+		writel(CONTROL_EFUSE_2_OVERRIDE, (*ctrl)->control_efuse_2);
+}
+
+/* dummy function for omap4 */
+void config_data_eye_leveling_samples(u32 emif_base)
+{
+}
+
+void init_omap_revision(void)
+{
+	/*
+	 * For some of the ES2/ES1 boards ID_CODE is not reliable:
+	 * Also, ES1 and ES2 have different ARM revisions
+	 * So use ARM revision for identification
+	 */
+	unsigned int arm_rev = cortex_rev();
+
+	switch (arm_rev) {
+	case MIDR_CORTEX_A9_R0P1:
+		*omap_si_rev = OMAP4430_ES1_0;
+		break;
+	case MIDR_CORTEX_A9_R1P2:
+		switch (readl(CONTROL_ID_CODE)) {
+		case OMAP4_CONTROL_ID_CODE_ES2_0:
+			*omap_si_rev = OMAP4430_ES2_0;
+			break;
+		case OMAP4_CONTROL_ID_CODE_ES2_1:
+			*omap_si_rev = OMAP4430_ES2_1;
+			break;
+		case OMAP4_CONTROL_ID_CODE_ES2_2:
+			*omap_si_rev = OMAP4430_ES2_2;
+			break;
+		default:
+			*omap_si_rev = OMAP4430_ES2_0;
+			break;
+		}
+		break;
+	case MIDR_CORTEX_A9_R1P3:
+		*omap_si_rev = OMAP4430_ES2_3;
+		break;
+	case MIDR_CORTEX_A9_R2P10:
+		switch (readl(CONTROL_ID_CODE)) {
+		case OMAP4470_CONTROL_ID_CODE_ES1_0:
+			*omap_si_rev = OMAP4470_ES1_0;
+			break;
+		case OMAP4460_CONTROL_ID_CODE_ES1_1:
+			*omap_si_rev = OMAP4460_ES1_1;
+			break;
+		case OMAP4460_CONTROL_ID_CODE_ES1_0:
+		default:
+			*omap_si_rev = OMAP4460_ES1_0;
+			break;
+		}
+		break;
+	default:
+		*omap_si_rev = OMAP4430_SILICON_ID_INVALID;
+		break;
+	}
+}
+
+void omap_die_id(unsigned int *die_id)
+{
+	die_id[0] = readl((*ctrl)->control_std_fuse_die_id_0);
+	die_id[1] = readl((*ctrl)->control_std_fuse_die_id_1);
+	die_id[2] = readl((*ctrl)->control_std_fuse_die_id_2);
+	die_id[3] = readl((*ctrl)->control_std_fuse_die_id_3);
+}
+
+void v7_outer_cache_enable(void)
+{
+	if (!IS_ENABLED(CONFIG_SYS_L2CACHE_OFF))
+		omap_smc1(OMAP4_SERVICE_PL310_CONTROL_REG_SET, 1);
+}
+
+void v7_outer_cache_disable(void)
+{
+	if (!IS_ENABLED(CONFIG_SYS_L2CACHE_OFF))
+		omap_smc1(OMAP4_SERVICE_PL310_CONTROL_REG_SET, 0);
+}
+
+void vmmc_pbias_config(uint voltage)
+{
+	u32 value = 0;
+
+	value = readl((*ctrl)->control_pbiaslite);
+	value &= ~(MMC1_PBIASLITE_PWRDNZ | MMC1_PWRDNZ);
+	writel(value, (*ctrl)->control_pbiaslite);
+	value = readl((*ctrl)->control_pbiaslite);
+	value |= MMC1_PBIASLITE_VMODE | MMC1_PBIASLITE_PWRDNZ | MMC1_PWRDNZ;
+	writel(value, (*ctrl)->control_pbiaslite);
+}
diff --git a/arch/arm/mach-omap2/omap4/prcm-regs.c b/arch/arm/mach-omap2/omap4/prcm-regs.c
new file mode 100644
index 00000000000..eaf98b38914
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/prcm-regs.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * HW regs data for OMAP4
+ *
+ * (C) Copyright 2013
+ * Texas Instruments, <www.ti.com>
+ *
+ * Sricharan R <r.sricharan@ti.com>
+ */
+
+#include <asm/omap_common.h>
+
+struct prcm_regs const omap4_prcm = {
+	/* cm1.ckgen */
+	.cm_clksel_core  = 0x4a004100,
+	.cm_clksel_abe = 0x4a004108,
+	.cm_dll_ctrl = 0x4a004110,
+	.cm_clkmode_dpll_core = 0x4a004120,
+	.cm_idlest_dpll_core = 0x4a004124,
+	.cm_autoidle_dpll_core = 0x4a004128,
+	.cm_clksel_dpll_core = 0x4a00412c,
+	.cm_div_m2_dpll_core = 0x4a004130,
+	.cm_div_m3_dpll_core = 0x4a004134,
+	.cm_div_m4_dpll_core = 0x4a004138,
+	.cm_div_m5_dpll_core = 0x4a00413c,
+	.cm_div_m6_dpll_core = 0x4a004140,
+	.cm_div_m7_dpll_core = 0x4a004144,
+	.cm_ssc_deltamstep_dpll_core = 0x4a004148,
+	.cm_ssc_modfreqdiv_dpll_core = 0x4a00414c,
+	.cm_emu_override_dpll_core = 0x4a004150,
+	.cm_clkmode_dpll_mpu = 0x4a004160,
+	.cm_idlest_dpll_mpu = 0x4a004164,
+	.cm_autoidle_dpll_mpu = 0x4a004168,
+	.cm_clksel_dpll_mpu = 0x4a00416c,
+	.cm_div_m2_dpll_mpu = 0x4a004170,
+	.cm_ssc_deltamstep_dpll_mpu = 0x4a004188,
+	.cm_ssc_modfreqdiv_dpll_mpu = 0x4a00418c,
+	.cm_bypclk_dpll_mpu = 0x4a00419c,
+	.cm_clkmode_dpll_iva = 0x4a0041a0,
+	.cm_idlest_dpll_iva = 0x4a0041a4,
+	.cm_autoidle_dpll_iva = 0x4a0041a8,
+	.cm_clksel_dpll_iva = 0x4a0041ac,
+	.cm_div_m4_dpll_iva = 0x4a0041b8,
+	.cm_div_m5_dpll_iva = 0x4a0041bc,
+	.cm_ssc_deltamstep_dpll_iva = 0x4a0041c8,
+	.cm_ssc_modfreqdiv_dpll_iva = 0x4a0041cc,
+	.cm_bypclk_dpll_iva = 0x4a0041dc,
+	.cm_clkmode_dpll_abe = 0x4a0041e0,
+	.cm_idlest_dpll_abe = 0x4a0041e4,
+	.cm_autoidle_dpll_abe = 0x4a0041e8,
+	.cm_clksel_dpll_abe = 0x4a0041ec,
+	.cm_div_m2_dpll_abe = 0x4a0041f0,
+	.cm_div_m3_dpll_abe = 0x4a0041f4,
+	.cm_ssc_deltamstep_dpll_abe = 0x4a004208,
+	.cm_ssc_modfreqdiv_dpll_abe = 0x4a00420c,
+	.cm_clkmode_dpll_ddrphy = 0x4a004220,
+	.cm_idlest_dpll_ddrphy = 0x4a004224,
+	.cm_autoidle_dpll_ddrphy = 0x4a004228,
+	.cm_clksel_dpll_ddrphy = 0x4a00422c,
+	.cm_div_m2_dpll_ddrphy = 0x4a004230,
+	.cm_div_m4_dpll_ddrphy = 0x4a004238,
+	.cm_div_m5_dpll_ddrphy = 0x4a00423c,
+	.cm_div_m6_dpll_ddrphy = 0x4a004240,
+	.cm_ssc_deltamstep_dpll_ddrphy = 0x4a004248,
+	.cm_shadow_freq_config1 = 0x4a004260,
+	.cm_mpu_mpu_clkctrl = 0x4a004320,
+
+	/* cm1.dsp */
+	.cm_dsp_clkstctrl = 0x4a004400,
+	.cm_dsp_dsp_clkctrl = 0x4a004420,
+
+	/* cm1.abe */
+	.cm1_abe_clkstctrl = 0x4a004500,
+	.cm1_abe_l4abe_clkctrl = 0x4a004520,
+	.cm1_abe_aess_clkctrl = 0x4a004528,
+	.cm1_abe_pdm_clkctrl = 0x4a004530,
+	.cm1_abe_dmic_clkctrl = 0x4a004538,
+	.cm1_abe_mcasp_clkctrl = 0x4a004540,
+	.cm1_abe_mcbsp1_clkctrl = 0x4a004548,
+	.cm1_abe_mcbsp2_clkctrl = 0x4a004550,
+	.cm1_abe_mcbsp3_clkctrl = 0x4a004558,
+	.cm1_abe_slimbus_clkctrl = 0x4a004560,
+	.cm1_abe_timer5_clkctrl = 0x4a004568,
+	.cm1_abe_timer6_clkctrl = 0x4a004570,
+	.cm1_abe_timer7_clkctrl = 0x4a004578,
+	.cm1_abe_timer8_clkctrl = 0x4a004580,
+	.cm1_abe_wdt3_clkctrl = 0x4a004588,
+
+	/* cm2.ckgen */
+	.cm_clksel_mpu_m3_iss_root = 0x4a008100,
+	.cm_clksel_usb_60mhz = 0x4a008104,
+	.cm_scale_fclk = 0x4a008108,
+	.cm_core_dvfs_perf1 = 0x4a008110,
+	.cm_core_dvfs_perf2 = 0x4a008114,
+	.cm_core_dvfs_perf3 = 0x4a008118,
+	.cm_core_dvfs_perf4 = 0x4a00811c,
+	.cm_core_dvfs_current = 0x4a008124,
+	.cm_iva_dvfs_perf_tesla = 0x4a008128,
+	.cm_iva_dvfs_perf_ivahd = 0x4a00812c,
+	.cm_iva_dvfs_perf_abe = 0x4a008130,
+	.cm_iva_dvfs_current = 0x4a008138,
+	.cm_clkmode_dpll_per = 0x4a008140,
+	.cm_idlest_dpll_per = 0x4a008144,
+	.cm_autoidle_dpll_per = 0x4a008148,
+	.cm_clksel_dpll_per = 0x4a00814c,
+	.cm_div_m2_dpll_per = 0x4a008150,
+	.cm_div_m3_dpll_per = 0x4a008154,
+	.cm_div_m4_dpll_per = 0x4a008158,
+	.cm_div_m5_dpll_per = 0x4a00815c,
+	.cm_div_m6_dpll_per = 0x4a008160,
+	.cm_div_m7_dpll_per = 0x4a008164,
+	.cm_ssc_deltamstep_dpll_per = 0x4a008168,
+	.cm_ssc_modfreqdiv_dpll_per = 0x4a00816c,
+	.cm_emu_override_dpll_per = 0x4a008170,
+	.cm_clkmode_dpll_usb = 0x4a008180,
+	.cm_idlest_dpll_usb = 0x4a008184,
+	.cm_autoidle_dpll_usb = 0x4a008188,
+	.cm_clksel_dpll_usb = 0x4a00818c,
+	.cm_div_m2_dpll_usb = 0x4a008190,
+	.cm_ssc_deltamstep_dpll_usb = 0x4a0081a8,
+	.cm_ssc_modfreqdiv_dpll_usb = 0x4a0081ac,
+	.cm_clkdcoldo_dpll_usb = 0x4a0081b4,
+	.cm_clkmode_dpll_unipro = 0x4a0081c0,
+	.cm_idlest_dpll_unipro = 0x4a0081c4,
+	.cm_autoidle_dpll_unipro = 0x4a0081c8,
+	.cm_clksel_dpll_unipro = 0x4a0081cc,
+	.cm_div_m2_dpll_unipro = 0x4a0081d0,
+	.cm_ssc_deltamstep_dpll_unipro = 0x4a0081e8,
+	.cm_ssc_modfreqdiv_dpll_unipro = 0x4a0081ec,
+	.cm_coreaon_usb_phy1_core_clkctrl = 0x4a008640,
+
+	/* cm2.core */
+	.cm_l3_1_clkstctrl = 0x4a008700,
+	.cm_l3_1_dynamicdep = 0x4a008708,
+	.cm_l3_1_l3_1_clkctrl = 0x4a008720,
+	.cm_l3_2_clkstctrl = 0x4a008800,
+	.cm_l3_2_dynamicdep = 0x4a008808,
+	.cm_l3_2_l3_2_clkctrl = 0x4a008820,
+	.cm_l3_gpmc_clkctrl = 0x4a008828,
+	.cm_l3_2_ocmc_ram_clkctrl = 0x4a008830,
+	.cm_mpu_m3_clkstctrl = 0x4a008900,
+	.cm_mpu_m3_staticdep = 0x4a008904,
+	.cm_mpu_m3_dynamicdep = 0x4a008908,
+	.cm_mpu_m3_mpu_m3_clkctrl = 0x4a008920,
+	.cm_sdma_clkstctrl = 0x4a008a00,
+	.cm_sdma_staticdep = 0x4a008a04,
+	.cm_sdma_dynamicdep = 0x4a008a08,
+	.cm_sdma_sdma_clkctrl = 0x4a008a20,
+	.cm_memif_clkstctrl = 0x4a008b00,
+	.cm_memif_dmm_clkctrl = 0x4a008b20,
+	.cm_memif_emif_fw_clkctrl = 0x4a008b28,
+	.cm_memif_emif_1_clkctrl = 0x4a008b30,
+	.cm_memif_emif_2_clkctrl = 0x4a008b38,
+	.cm_memif_dll_clkctrl = 0x4a008b40,
+	.cm_memif_emif_h1_clkctrl = 0x4a008b50,
+	.cm_memif_emif_h2_clkctrl = 0x4a008b58,
+	.cm_memif_dll_h_clkctrl = 0x4a008b60,
+	.cm_c2c_clkstctrl = 0x4a008c00,
+	.cm_c2c_staticdep = 0x4a008c04,
+	.cm_c2c_dynamicdep = 0x4a008c08,
+	.cm_c2c_sad2d_clkctrl = 0x4a008c20,
+	.cm_c2c_modem_icr_clkctrl = 0x4a008c28,
+	.cm_c2c_sad2d_fw_clkctrl = 0x4a008c30,
+	.cm_l4cfg_clkstctrl = 0x4a008d00,
+	.cm_l4cfg_dynamicdep = 0x4a008d08,
+	.cm_l4cfg_l4_cfg_clkctrl = 0x4a008d20,
+	.cm_l4cfg_hw_sem_clkctrl = 0x4a008d28,
+	.cm_l4cfg_mailbox_clkctrl = 0x4a008d30,
+	.cm_l4cfg_sar_rom_clkctrl = 0x4a008d38,
+	.cm_l3instr_clkstctrl = 0x4a008e00,
+	.cm_l3instr_l3_3_clkctrl = 0x4a008e20,
+	.cm_l3instr_l3_instr_clkctrl = 0x4a008e28,
+	.cm_l3instr_intrconn_wp1_clkct = 0x4a008e40,
+	.cm_ivahd_clkstctrl = 0x4a008f00,
+
+	/* cm2.ivahd */
+	.cm_ivahd_ivahd_clkctrl = 0x4a008f20,
+	.cm_ivahd_sl2_clkctrl = 0x4a008f28,
+
+	/* cm2.cam */
+	.cm_cam_clkstctrl = 0x4a009000,
+	.cm_cam_iss_clkctrl = 0x4a009020,
+	.cm_cam_fdif_clkctrl = 0x4a009028,
+
+	/* cm2.dss */
+	.cm_dss_clkstctrl = 0x4a009100,
+	.cm_dss_dss_clkctrl = 0x4a009120,
+
+	/* cm2.sgx */
+	.cm_sgx_clkstctrl = 0x4a009200,
+	.cm_sgx_sgx_clkctrl = 0x4a009220,
+
+	/* cm2.l3init */
+	.cm_l3init_clkstctrl = 0x4a009300,
+	.cm_l3init_hsmmc1_clkctrl = 0x4a009328,
+	.cm_l3init_hsmmc2_clkctrl = 0x4a009330,
+	.cm_l3init_hsi_clkctrl = 0x4a009338,
+	.cm_l3init_hsusbhost_clkctrl = 0x4a009358,
+	.cm_l3init_hsusbotg_clkctrl = 0x4a009360,
+	.cm_l3init_hsusbtll_clkctrl = 0x4a009368,
+	.cm_l3init_p1500_clkctrl = 0x4a009378,
+	.cm_l3init_fsusb_clkctrl = 0x4a0093d0,
+	.cm_l3init_usbphy_clkctrl = 0x4a0093e0,
+
+	/* cm2.l4per */
+	.cm_l4per_clkstctrl = 0x4a009400,
+	.cm_l4per_dynamicdep = 0x4a009408,
+	.cm_l4per_adc_clkctrl = 0x4a009420,
+	.cm_l4per_gptimer10_clkctrl = 0x4a009428,
+	.cm_l4per_gptimer11_clkctrl = 0x4a009430,
+	.cm_l4per_gptimer2_clkctrl = 0x4a009438,
+	.cm_l4per_gptimer3_clkctrl = 0x4a009440,
+	.cm_l4per_gptimer4_clkctrl = 0x4a009448,
+	.cm_l4per_gptimer9_clkctrl = 0x4a009450,
+	.cm_l4per_elm_clkctrl = 0x4a009458,
+	.cm_l4per_gpio2_clkctrl = 0x4a009460,
+	.cm_l4per_gpio3_clkctrl = 0x4a009468,
+	.cm_l4per_gpio4_clkctrl = 0x4a009470,
+	.cm_l4per_gpio5_clkctrl = 0x4a009478,
+	.cm_l4per_gpio6_clkctrl = 0x4a009480,
+	.cm_l4per_hdq1w_clkctrl = 0x4a009488,
+	.cm_l4per_hecc1_clkctrl = 0x4a009490,
+	.cm_l4per_hecc2_clkctrl = 0x4a009498,
+	.cm_l4per_i2c1_clkctrl = 0x4a0094a0,
+	.cm_l4per_i2c2_clkctrl = 0x4a0094a8,
+	.cm_l4per_i2c3_clkctrl = 0x4a0094b0,
+	.cm_l4per_i2c4_clkctrl = 0x4a0094b8,
+	.cm_l4per_l4per_clkctrl = 0x4a0094c0,
+	.cm_l4per_mcasp2_clkctrl = 0x4a0094d0,
+	.cm_l4per_mcasp3_clkctrl = 0x4a0094d8,
+	.cm_l4per_mcbsp4_clkctrl = 0x4a0094e0,
+	.cm_l4per_mgate_clkctrl = 0x4a0094e8,
+	.cm_l4per_mcspi1_clkctrl = 0x4a0094f0,
+	.cm_l4per_mcspi2_clkctrl = 0x4a0094f8,
+	.cm_l4per_mcspi3_clkctrl = 0x4a009500,
+	.cm_l4per_mcspi4_clkctrl = 0x4a009508,
+	.cm_l4per_mmcsd3_clkctrl = 0x4a009520,
+	.cm_l4per_mmcsd4_clkctrl = 0x4a009528,
+	.cm_l4per_msprohg_clkctrl = 0x4a009530,
+	.cm_l4per_slimbus2_clkctrl = 0x4a009538,
+	.cm_l4per_uart1_clkctrl = 0x4a009540,
+	.cm_l4per_uart2_clkctrl = 0x4a009548,
+	.cm_l4per_uart3_clkctrl = 0x4a009550,
+	.cm_l4per_uart4_clkctrl = 0x4a009558,
+	.cm_l4per_mmcsd5_clkctrl = 0x4a009560,
+	.cm_l4per_i2c5_clkctrl = 0x4a009568,
+	.cm_l4sec_clkstctrl = 0x4a009580,
+	.cm_l4sec_staticdep = 0x4a009584,
+	.cm_l4sec_dynamicdep = 0x4a009588,
+	.cm_l4sec_aes1_clkctrl = 0x4a0095a0,
+	.cm_l4sec_aes2_clkctrl = 0x4a0095a8,
+	.cm_l4sec_des3des_clkctrl = 0x4a0095b0,
+	.cm_l4sec_pkaeip29_clkctrl = 0x4a0095b8,
+	.cm_l4sec_rng_clkctrl = 0x4a0095c0,
+	.cm_l4sec_sha2md51_clkctrl = 0x4a0095c8,
+	.cm_l4sec_cryptodma_clkctrl = 0x4a0095d8,
+
+	/* l4 wkup regs */
+	.cm_abe_pll_ref_clksel = 0x4a30610c,
+	.cm_sys_clksel = 0x4a306110,
+	.cm_wkup_clkstctrl = 0x4a307800,
+	.cm_wkup_l4wkup_clkctrl = 0x4a307820,
+	.cm_wkup_wdtimer1_clkctrl = 0x4a307828,
+	.cm_wkup_wdtimer2_clkctrl = 0x4a307830,
+	.cm_wkup_gpio1_clkctrl = 0x4a307838,
+	.cm_wkup_gptimer1_clkctrl = 0x4a307840,
+	.cm_wkup_gptimer12_clkctrl = 0x4a307848,
+	.cm_wkup_synctimer_clkctrl = 0x4a307850,
+	.cm_wkup_usim_clkctrl = 0x4a307858,
+	.cm_wkup_sarram_clkctrl = 0x4a307860,
+	.cm_wkup_keyboard_clkctrl = 0x4a307878,
+	.cm_wkup_rtc_clkctrl = 0x4a307880,
+	.cm_wkup_bandgap_clkctrl = 0x4a307888,
+	.prm_vc_val_bypass = 0x4a307ba0,
+	.prm_vc_cfg_channel = 0x4a307ba4,
+	.prm_vc_cfg_i2c_mode = 0x4a307ba8,
+	.prm_vc_cfg_i2c_clk = 0x4a307bac,
+};
+
+struct omap_sys_ctrl_regs const omap4_ctrl = {
+	.control_status				= 0x4A0022C4,
+	.control_std_fuse_die_id_0		= 0x4A002200,
+	.control_std_fuse_die_id_1		= 0x4A002208,
+	.control_std_fuse_die_id_2		= 0x4A00220C,
+	.control_std_fuse_die_id_3		= 0x4A002210,
+	.control_std_fuse_opp_bgap		= 0x4a002260,
+	.control_status				= 0x4a0022c4,
+	.control_ldosram_iva_voltage_ctrl	= 0x4A002320,
+	.control_ldosram_mpu_voltage_ctrl	= 0x4A002324,
+	.control_ldosram_core_voltage_ctrl	= 0x4A002328,
+	.control_usbotghs_ctrl			= 0x4A00233C,
+	.control_padconf_core_base		= 0x4A100000,
+	.control_pbiaslite			= 0x4A100600,
+	.control_lpddr2io1_0			= 0x4A100638,
+	.control_lpddr2io1_1			= 0x4A10063C,
+	.control_lpddr2io1_2			= 0x4A100640,
+	.control_lpddr2io1_3			= 0x4A100644,
+	.control_lpddr2io2_0			= 0x4A100648,
+	.control_lpddr2io2_1			= 0x4A10064C,
+	.control_lpddr2io2_2			= 0x4A100650,
+	.control_lpddr2io2_3			= 0x4A100654,
+	.control_efuse_1			= 0x4A100700,
+	.control_efuse_2			= 0x4A100704,
+	.control_padconf_wkup_base		= 0x4A31E000,
+};
diff --git a/arch/arm/mach-omap2/omap4/sdram_elpida.c b/arch/arm/mach-omap2/omap4/sdram_elpida.c
new file mode 100644
index 00000000000..b2bac429a85
--- /dev/null
+++ b/arch/arm/mach-omap2/omap4/sdram_elpida.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Timing and Organization details of the Elpida parts used in OMAP4
+ * SDPs and Panda
+ *
+ * (C) Copyright 2010
+ * Texas Instruments, <www.ti.com>
+ *
+ * Aneesh V <aneesh@ti.com>
+ */
+
+#include <asm/emif.h>
+#include <asm/arch/sys_proto.h>
+
+/*
+ * This file provides details of the LPDDR2 SDRAM parts used on OMAP4430
+ * SDP and Panda. Since the parts used and geometry are identical for
+ * SDP and Panda for a given OMAP4 revision, this information is kept
+ * here instead of being in board directory. However the key functions
+ * exported are weakly linked so that they can be over-ridden in the board
+ * directory if there is a OMAP4 board in the future that uses a different
+ * memory device or geometry.
+ *
+ * For any new board with different memory devices over-ride one or more
+ * of the following functions as per the CONFIG flags you intend to enable:
+ * - emif_get_reg_dump()
+ * - emif_get_dmm_regs()
+ * - emif_get_device_details()
+ * - emif_get_device_timings()
+ */
+
+const struct emif_regs emif_regs_elpida_200_mhz_2cs = {
+	.sdram_config_init		= 0x80000eb9,
+	.sdram_config			= 0x80001ab9,
+	.ref_ctrl			= 0x0000030c,
+	.sdram_tim1			= 0x08648311,
+	.sdram_tim2			= 0x101b06ca,
+	.sdram_tim3			= 0x0048a19f,
+	.read_idle_ctrl			= 0x000501ff,
+	.zq_config			= 0x500b3214,
+	.temp_alert_config		= 0xd8016893,
+	.emif_ddr_phy_ctlr_1_init	= 0x049ffff5,
+	.emif_ddr_phy_ctlr_1		= 0x049ff808
+};
+
+const struct emif_regs emif_regs_elpida_380_mhz_1cs = {
+	.sdram_config_init		= 0x80000eb1,
+	.sdram_config			= 0x80001ab1,
+	.ref_ctrl			= 0x000005cd,
+	.sdram_tim1			= 0x10cb0622,
+	.sdram_tim2			= 0x20350d52,
+	.sdram_tim3			= 0x00b1431f,
+	.read_idle_ctrl			= 0x000501ff,
+	.zq_config			= 0x500b3214,
+	.temp_alert_config		= 0x58016893,
+	.emif_ddr_phy_ctlr_1_init	= 0x049ffff5,
+	.emif_ddr_phy_ctlr_1		= 0x049ff418
+};
+
+const struct emif_regs emif_regs_elpida_400_mhz_1cs = {
+	.sdram_config_init		= 0x80800eb2,
+	.sdram_config			= 0x80801ab2,
+	.ref_ctrl			= 0x00000618,
+	.sdram_tim1			= 0x10eb0662,
+	.sdram_tim2			= 0x20370dd2,
+	.sdram_tim3			= 0x00b1c33f,
+	.read_idle_ctrl			= 0x000501ff,
+	.zq_config			= 0x500b3215,
+	.temp_alert_config		= 0x58016893,
+	.emif_ddr_phy_ctlr_1_init	= 0x049ffff5,
+	.emif_ddr_phy_ctlr_1		= 0x049ff418
+};
+
+const struct emif_regs emif_regs_elpida_400_mhz_2cs = {
+	.sdram_config_init		= 0x80000eb9,
+	.sdram_config			= 0x80001ab9,
+	.ref_ctrl			= 0x00000618,
+	.sdram_tim1			= 0x10eb0662,
+	.sdram_tim2			= 0x20370dd2,
+	.sdram_tim3			= 0x00b1c33f,
+	.read_idle_ctrl			= 0x000501ff,
+	.zq_config			= 0xd00b3214,
+	.temp_alert_config		= 0xd8016893,
+	.emif_ddr_phy_ctlr_1_init	= 0x049ffff5,
+	.emif_ddr_phy_ctlr_1		= 0x049ff418
+};
+
+const struct dmm_lisa_map_regs lisa_map_2G_x_1_x_2 = {
+	.dmm_lisa_map_0 = 0xFF020100,
+	.dmm_lisa_map_1 = 0,
+	.dmm_lisa_map_2 = 0,
+	.dmm_lisa_map_3 = 0x80540300,
+	.is_ma_present	= 0x0
+};
+
+const struct dmm_lisa_map_regs lisa_map_2G_x_2_x_2 = {
+	.dmm_lisa_map_0 = 0xFF020100,
+	.dmm_lisa_map_1 = 0,
+	.dmm_lisa_map_2 = 0,
+	.dmm_lisa_map_3 = 0x80640300,
+	.is_ma_present	= 0x0
+};
+
+const struct dmm_lisa_map_regs ma_lisa_map_2G_x_2_x_2 = {
+	.dmm_lisa_map_0 = 0xFF020100,
+	.dmm_lisa_map_1 = 0,
+	.dmm_lisa_map_2 = 0,
+	.dmm_lisa_map_3 = 0x80640300,
+	.is_ma_present	= 0x1
+};
+
+__weak void emif_get_reg_dump(u32 emif_nr, const struct emif_regs **regs)
+{
+	u32 omap4_rev = omap_revision();
+
+	/* Same devices and geometry on both EMIFs */
+	if (omap4_rev == OMAP4430_ES1_0)
+		*regs = &emif_regs_elpida_380_mhz_1cs;
+	else if (omap4_rev == OMAP4430_ES2_0)
+		*regs = &emif_regs_elpida_200_mhz_2cs;
+	else if (omap4_rev < OMAP4470_ES1_0)
+		*regs = &emif_regs_elpida_400_mhz_2cs;
+	else
+		*regs = &emif_regs_elpida_400_mhz_1cs;
+}
+
+__weak void emif_get_dmm_regs(const struct dmm_lisa_map_regs **dmm_lisa_regs)
+{
+	u32 omap_rev = omap_revision();
+
+	if (omap_rev == OMAP4430_ES1_0)
+		*dmm_lisa_regs = &lisa_map_2G_x_1_x_2;
+	else if (omap_rev < OMAP4460_ES1_0)
+		*dmm_lisa_regs = &lisa_map_2G_x_2_x_2;
+	else
+		*dmm_lisa_regs = &ma_lisa_map_2G_x_2_x_2;
+}
+
+static const struct lpddr2_ac_timings timings_elpida_400_mhz = {
+	.max_freq	= 400000000,
+	.RL		= 6,
+	.tRPab		= 21,
+	.tRCD		= 18,
+	.tWR		= 15,
+	.tRASmin	= 42,
+	.tRRD		= 10,
+	.tWTRx2		= 15,
+	.tXSR		= 140,
+	.tXPx2		= 15,
+	.tRFCab		= 130,
+	.tRTPx2		= 15,
+	.tCKE		= 3,
+	.tCKESR		= 15,
+	.tZQCS		= 90,
+	.tZQCL		= 360,
+	.tZQINIT	= 1000,
+	.tDQSCKMAXx2	= 11,
+	.tRASmax	= 70,
+	.tFAW		= 50
+};
+
+static const struct lpddr2_ac_timings timings_elpida_333_mhz = {
+	.max_freq	= 333000000,
+	.RL		= 5,
+	.tRPab		= 21,
+	.tRCD		= 18,
+	.tWR		= 15,
+	.tRASmin	= 42,
+	.tRRD		= 10,
+	.tWTRx2		= 15,
+	.tXSR		= 140,
+	.tXPx2		= 15,
+	.tRFCab		= 130,
+	.tRTPx2		= 15,
+	.tCKE		= 3,
+	.tCKESR		= 15,
+	.tZQCS		= 90,
+	.tZQCL		= 360,
+	.tZQINIT	= 1000,
+	.tDQSCKMAXx2	= 11,
+	.tRASmax	= 70,
+	.tFAW		= 50
+};
+
+static const struct lpddr2_ac_timings timings_elpida_200_mhz = {
+	.max_freq	= 200000000,
+	.RL		= 3,
+	.tRPab		= 21,
+	.tRCD		= 18,
+	.tWR		= 15,
+	.tRASmin	= 42,
+	.tRRD		= 10,
+	.tWTRx2		= 20,
+	.tXSR		= 140,
+	.tXPx2		= 15,
+	.tRFCab		= 130,
+	.tRTPx2		= 15,
+	.tCKE		= 3,
+	.tCKESR		= 15,
+	.tZQCS		= 90,
+	.tZQCL		= 360,
+	.tZQINIT	= 1000,
+	.tDQSCKMAXx2	= 11,
+	.tRASmax	= 70,
+	.tFAW		= 50
+};
+
+static const struct lpddr2_min_tck min_tck_elpida = {
+	.tRL		= 3,
+	.tRP_AB		= 3,
+	.tRCD		= 3,
+	.tWR		= 3,
+	.tRAS_MIN	= 3,
+	.tRRD		= 2,
+	.tWTR		= 2,
+	.tXP		= 2,
+	.tRTP		= 2,
+	.tCKE		= 3,
+	.tCKESR		= 3,
+	.tFAW		= 8
+};
+
+static const struct lpddr2_ac_timings *elpida_ac_timings[MAX_NUM_SPEEDBINS] = {
+		&timings_elpida_200_mhz,
+		&timings_elpida_333_mhz,
+		&timings_elpida_400_mhz
+};
+
+const struct lpddr2_device_timings elpida_2G_S4_timings = {
+	.ac_timings	= elpida_ac_timings,
+	.min_tck	= &min_tck_elpida,
+};
+
+__weak void emif_get_device_timings(u32 emif_nr,
+				    const struct lpddr2_device_timings **cs0_device_timings,
+				    const struct lpddr2_device_timings **cs1_device_timings)
+{
+	u32 omap_rev = omap_revision();
+
+	/* Identical devices on EMIF1 & EMIF2 */
+	*cs0_device_timings = &elpida_2G_S4_timings;
+
+	if (omap_rev == OMAP4430_ES1_0 || omap_rev == OMAP4470_ES1_0)
+		*cs1_device_timings = NULL;
+	else
+		*cs1_device_timings = &elpida_2G_S4_timings;
+}
+
+const struct lpddr2_mr_regs mr_regs = {
+	.mr1	= MR1_BL_8_BT_SEQ_WRAP_EN_NWR_3,
+	.mr2	= 0x4,
+	.mr3	= -1,
+	.mr10	= MR10_ZQ_ZQINIT,
+	.mr16	= MR16_REF_FULL_ARRAY
+};
+
+void get_lpddr2_mr_regs(const struct lpddr2_mr_regs **regs)
+{
+	*regs = &mr_regs;
+}
+
+__weak const struct read_write_regs *get_bug_regs(u32 *iterations)
+{
+	return 0;
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..295dcf97898 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -541,7 +541,7 @@ config SPL_SYS_MMCSD_RAW_MODE
 		     ARCH_MX6 || ARCH_MX7 || \
 		     ARCH_ROCKCHIP || ARCH_MVEBU || ARCH_SOCFPGA_GEN5 || \
 		     ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
-		     OMAP54XX || AM33XX || AM43XX || \
+		     OMAP44XX || OMAP54XX || AM33XX || AM43XX || \
 		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
 	help
 	  Support booting from an MMC without a filesystem.
@@ -585,7 +585,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	default 0x100 if ARCH_UNIPHIER
 	default 0x0 if ARCH_MVEBU
 	default 0x200 if ARCH_SOCFPGA_GEN5 || ARCH_AT91
-	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
+	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || OMAP44XX || \
 		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
 	default 0x4000 if ARCH_ROCKCHIP
 	default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 55465dc1d46..73ffbb33871 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -800,7 +800,7 @@ config SYS_I2C_BUS_MAX
 	int "Max I2C busses"
 	depends on ARCH_OMAP2PLUS || ARCH_SOCFPGA
 	default 3 if OMAP34XX || AM33XX || AM43XX
-	default 4 if ARCH_SOCFPGA
+	default 4 if ARCH_SOCFPGA || OMAP44XX
 	default 5 if OMAP54XX
 	help
 	  Define the maximum number of available I2C buses.
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 22bd3a972bd..eb7661bc648 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -415,7 +415,7 @@ config MMC_OMAP36XX_PINS
 
 config HSMMC2_8BIT
 	bool "Enable 8-bit interface for eMMC (interface #2)"
-	depends on MMC_OMAP_HS && (OMAP54XX || DRA7XX || AM33XX || \
+	depends on MMC_OMAP_HS && (OMAP44XX || OMAP54XX || DRA7XX || AM33XX || \
 		AM43XX || ARCH_KEYSTONE)
 
 config SH_MMCIF

-- 
2.54.0

