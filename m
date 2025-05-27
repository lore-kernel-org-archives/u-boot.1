Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068E5C5B542
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 22:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F0B838CB;
	Wed, 28 May 2025 00:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CZ22bBXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535FE82E2D; Wed, 28 May 2025 00:18:45 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4990A82E2D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72ec58e45baso2141666a34.2
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748384320; x=1748989120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=msnsdakTiUqT/RxM7R7iHk8ZQtl65N4UB6lEGkWYnbo=;
 b=CZ22bBXsPA0XAA2fvnSh+jpecZ472MAcrIrwZwuZ1r9kajczAx8Jf5X61chjauFLHW
 W4eB2dIAq769d5J+Ds49rWdo4P2g7lC3SdvnJwtKo0UI6Hfy7qgq8shasDYPTCtJu2yb
 NNwhjt6MX7kt16QzR6hYHRuXMaUaFWuThoL2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748384320; x=1748989120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msnsdakTiUqT/RxM7R7iHk8ZQtl65N4UB6lEGkWYnbo=;
 b=iTlVvflTfkQM2iV+jKUQ0ytbzAPcxMRKc50wtk8JGmTF0x20RWv960XFED4UuSme9y
 OyZRxudTzH+14vhDFc6uBgsg6RqEITn51d48zTELVuOvpkIRxn6WXpZs2MowF9hC3e9T
 HEVHypDpx2PDuMVJzqBgDju3cwwDwlP72eIfihKS5e6kUSvNLlNNQYvCEew0CBDLr+uZ
 CP59PoUfM5uDF7yz3gHvacNaEQTzpPsBX4JvXDNgrBrw3fAVtRRroeRDpOlQ15qohMK4
 gHg1ZH3fCL4c/IbrylvYNPRkL3vmwq3YWw50eMn3npW4qM2gUyWpFGDALglcgPlxR5vZ
 npkA==
X-Gm-Message-State: AOJu0YwWFp4LuD+s+xxj2/wBtVTPv1ajpYxWZDxgJioyP8ajiBXFDv+E
 MYXu6WZ2q5c6D6Fs4O4xFc7xwOJRv0/S/32VHp72bfGy5Ero0kB8qEiRHCsk2Bn6cveYncyvmt1
 Yp1SR64s=
X-Gm-Gg: ASbGncuKU/ysLa+WUhAA0QNTyQ72ejm8e1/9WaIMDxubN6uZhLF+bppgIZtGgsRsf78
 w5YW6FCsX+MmF5nHzPP2R3pdUg65jwTUNvWm8UrJRwqqNKxD31u2bkB4Bjos6sxuYWEAekWwX81
 LvB5Yu/K3ooyzvAcqQ4c27APwF4oJ5408JNs3r6pCOeYrGW134JCNQnvNFRokeuw1rXenrUzgat
 talROUqWNMIwzDRRRDfSmjdoCodMu5v+N46HeSR/Msov7QA0MI1EjQlA4NE99yA+S4gy+721wfg
 q81DF2SzW5LN6t4eRA+uKdglQR/t/arC4jHpTrajtzNmsUEnVzE9OAGvs25OdbbO+4F76ao5VnK
 R0sYktTxFPemFbKA=
X-Google-Smtp-Source: AGHT+IEFOZFLfVEeJYRKZVovsf+gTkF5j1HrBfzrtm91OA531UVlGaKCKcuybDeQwYFZ1UoZqQFLrg==
X-Received: by 2002:a05:6808:1649:b0:3fc:1f7b:c3b3 with SMTP id
 5614622812f47-40646842b42mr7946537b6e.33.1748384319671; 
 Tue, 27 May 2025 15:18:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd7d39abasm51124eaf.32.2025.05.27.15.18.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 15:18:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] include/dt-bindings: Remove unused headers
Date: Tue, 27 May 2025 16:18:33 -0600
Message-ID: <20250527221837.2987226-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As part of moving to using OF_UPSTREAM and so the upstream dt-bindings
headers we have a number of these headers that are in our include
directory and not referenced by any code outside of dts/upstream. We can
remove these now to prevent future conflicts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/dt-bindings/arm/coresight-cti-dt.h    |  37 ----
 include/dt-bindings/clock/omap4.h             | 149 --------------
 include/dt-bindings/clock/omap5.h             | 129 ------------
 include/dt-bindings/clock/sun4i-a10-pll2.h    |  53 -----
 include/dt-bindings/clock/xlnx-versal-clk.h   | 123 ------------
 .../dt-bindings/interrupt-controller/irq-st.h |  30 ---
 .../interrupt-controller/mips-gic.h           |   9 -
 include/dt-bindings/leds/leds-netxbig.h       |  18 --
 include/dt-bindings/leds/leds-ns2.h           |   9 -
 include/dt-bindings/mux/ti-serdes.h           | 190 ------------------
 include/dt-bindings/net/mscc-phy-vsc8531.h    |  31 ---
 include/dt-bindings/phy/phy-am654-serdes.h    |  13 --
 .../dt-bindings/pinctrl/brcm,pinctrl-ns3.h    |  41 ----
 include/dt-bindings/pinctrl/k3.h              |  50 -----
 .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ----------
 include/dt-bindings/sound/tlv320aic31xx.h     |  14 --
 16 files changed, 1001 deletions(-)
 delete mode 100644 include/dt-bindings/arm/coresight-cti-dt.h
 delete mode 100644 include/dt-bindings/clock/omap4.h
 delete mode 100644 include/dt-bindings/clock/omap5.h
 delete mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h
 delete mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h
 delete mode 100644 include/dt-bindings/interrupt-controller/irq-st.h
 delete mode 100644 include/dt-bindings/interrupt-controller/mips-gic.h
 delete mode 100644 include/dt-bindings/leds/leds-netxbig.h
 delete mode 100644 include/dt-bindings/leds/leds-ns2.h
 delete mode 100644 include/dt-bindings/mux/ti-serdes.h
 delete mode 100644 include/dt-bindings/net/mscc-phy-vsc8531.h
 delete mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
 delete mode 100644 include/dt-bindings/pinctrl/brcm,pinctrl-ns3.h
 delete mode 100644 include/dt-bindings/pinctrl/k3.h
 delete mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h
 delete mode 100644 include/dt-bindings/sound/tlv320aic31xx.h

diff --git a/include/dt-bindings/arm/coresight-cti-dt.h b/include/dt-bindings/arm/coresight-cti-dt.h
deleted file mode 100644
index 61e7bdf8ea6e..000000000000
--- a/include/dt-bindings/arm/coresight-cti-dt.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for the defined trigger signal
- * types on CoreSight CTI.
- */
-
-#ifndef _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
-#define _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
-
-#define GEN_IO		0
-#define GEN_INTREQ	1
-#define GEN_INTACK	2
-#define GEN_HALTREQ	3
-#define GEN_RESTARTREQ	4
-#define PE_EDBGREQ	5
-#define PE_DBGRESTART	6
-#define PE_CTIIRQ	7
-#define PE_PMUIRQ	8
-#define PE_DBGTRIGGER	9
-#define ETM_EXTOUT	10
-#define ETM_EXTIN	11
-#define SNK_FULL	12
-#define SNK_ACQCOMP	13
-#define SNK_FLUSHCOMP	14
-#define SNK_FLUSHIN	15
-#define SNK_TRIGIN	16
-#define STM_ASYNCOUT	17
-#define STM_TOUT_SPTE	18
-#define STM_TOUT_SW	19
-#define STM_TOUT_HETE	20
-#define STM_HWEVENT	21
-#define ELA_TSTART	22
-#define ELA_TSTOP	23
-#define ELA_DBGREQ	24
-#define CTI_TRIG_MAX	25
-
-#endif /*_DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H */
diff --git a/include/dt-bindings/clock/omap4.h b/include/dt-bindings/clock/omap4.h
deleted file mode 100644
index 88d73be84b94..000000000000
--- a/include/dt-bindings/clock/omap4.h
+++ /dev/null
@@ -1,149 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2017 Texas Instruments, Inc.
- */
-#ifndef __DT_BINDINGS_CLK_OMAP4_H
-#define __DT_BINDINGS_CLK_OMAP4_H
-
-#define OMAP4_CLKCTRL_OFFSET	0x20
-#define OMAP4_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)
-
-/* mpuss clocks */
-#define OMAP4_MPU_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* tesla clocks */
-#define OMAP4_DSP_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* abe clocks */
-#define OMAP4_L4_ABE_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_AESS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_MCPDM_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_DMIC_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
-#define OMAP4_MCASP_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x40)
-#define OMAP4_MCBSP1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x48)
-#define OMAP4_MCBSP2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x50)
-#define OMAP4_MCBSP3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x58)
-#define OMAP4_SLIMBUS1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x60)
-#define OMAP4_TIMER5_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x68)
-#define OMAP4_TIMER6_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x70)
-#define OMAP4_TIMER7_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x78)
-#define OMAP4_TIMER8_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x80)
-#define OMAP4_WD_TIMER3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x88)
-
-/* l4_ao clocks */
-#define OMAP4_SMARTREFLEX_MPU_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_SMARTREFLEX_IVA_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_SMARTREFLEX_CORE_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
-
-/* l3_1 clocks */
-#define OMAP4_L3_MAIN_1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* l3_2 clocks */
-#define OMAP4_L3_MAIN_2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_GPMC_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_OCMC_RAM_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-
-/* ducati clocks */
-#define OMAP4_IPU_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* l3_dma clocks */
-#define OMAP4_DMA_SYSTEM_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* l3_emif clocks */
-#define OMAP4_DMM_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_EMIF1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_EMIF2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
-
-/* d2d clocks */
-#define OMAP4_C2C_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* l4_cfg clocks */
-#define OMAP4_L4_CFG_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_SPINLOCK_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_MAILBOX_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-
-/* l3_instr clocks */
-#define OMAP4_L3_MAIN_3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_L3_INSTR_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_OCP_WP_NOC_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x40)
-
-/* ivahd clocks */
-#define OMAP4_IVA_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_SL2IF_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-
-/* iss clocks */
-#define OMAP4_ISS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_FDIF_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-
-/* l3_dss clocks */
-#define OMAP4_DSS_CORE_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* l3_gfx clocks */
-#define OMAP4_GPU_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-/* l3_init clocks */
-#define OMAP4_MMC1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_MMC2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_HSI_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
-#define OMAP4_USB_HOST_HS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x58)
-#define OMAP4_USB_OTG_HS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x60)
-#define OMAP4_USB_TLL_HS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x68)
-#define OMAP4_USB_HOST_FS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xd0)
-#define OMAP4_OCP2SCP_USB_PHY_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xe0)
-
-/* l4_per clocks */
-#define OMAP4_TIMER10_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_TIMER11_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_TIMER2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
-#define OMAP4_TIMER3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x40)
-#define OMAP4_TIMER4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x48)
-#define OMAP4_TIMER9_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x50)
-#define OMAP4_ELM_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x58)
-#define OMAP4_GPIO2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x60)
-#define OMAP4_GPIO3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x68)
-#define OMAP4_GPIO4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x70)
-#define OMAP4_GPIO5_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x78)
-#define OMAP4_GPIO6_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x80)
-#define OMAP4_HDQ1W_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x88)
-#define OMAP4_I2C1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xa0)
-#define OMAP4_I2C2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xa8)
-#define OMAP4_I2C3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xb0)
-#define OMAP4_I2C4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xb8)
-#define OMAP4_L4_PER_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xc0)
-#define OMAP4_MCBSP4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xe0)
-#define OMAP4_MCSPI1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xf0)
-#define OMAP4_MCSPI2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0xf8)
-#define OMAP4_MCSPI3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x100)
-#define OMAP4_MCSPI4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x108)
-#define OMAP4_MMC3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x120)
-#define OMAP4_MMC4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x128)
-#define OMAP4_SLIMBUS2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x138)
-#define OMAP4_UART1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x140)
-#define OMAP4_UART2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x148)
-#define OMAP4_UART3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x150)
-#define OMAP4_UART4_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x158)
-#define OMAP4_MMC5_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x160)
-
-/* l4_secure clocks */
-#define OMAP4_L4_SECURE_CLKCTRL_OFFSET	0x1a0
-#define OMAP4_L4_SECURE_CLKCTRL_INDEX(offset)	((offset) - OMAP4_L4_SECURE_CLKCTRL_OFFSET)
-#define OMAP4_AES1_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1a0)
-#define OMAP4_AES2_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1a8)
-#define OMAP4_DES3DES_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1b0)
-#define OMAP4_PKA_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1b8)
-#define OMAP4_RNG_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1c0)
-#define OMAP4_SHA2MD5_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1c8)
-#define OMAP4_CRYPTODMA_CLKCTRL	OMAP4_L4_SECURE_CLKCTRL_INDEX(0x1d8)
-
-/* l4_wkup clocks */
-#define OMAP4_L4_WKUP_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-#define OMAP4_WD_TIMER2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_GPIO1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
-#define OMAP4_TIMER1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x40)
-#define OMAP4_COUNTER_32K_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x50)
-#define OMAP4_KBD_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x78)
-
-/* emu_sys clocks */
-#define OMAP4_DEBUGSS_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
-
-#endif
diff --git a/include/dt-bindings/clock/omap5.h b/include/dt-bindings/clock/omap5.h
deleted file mode 100644
index 41775272fd27..000000000000
--- a/include/dt-bindings/clock/omap5.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2017 Texas Instruments, Inc.
- */
-#ifndef __DT_BINDINGS_CLK_OMAP5_H
-#define __DT_BINDINGS_CLK_OMAP5_H
-
-#define OMAP5_CLKCTRL_OFFSET	0x20
-#define OMAP5_CLKCTRL_INDEX(offset)	((offset) - OMAP5_CLKCTRL_OFFSET)
-
-/* mpu clocks */
-#define OMAP5_MPU_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* dsp clocks */
-#define OMAP5_MMU_DSP_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* abe clocks */
-#define OMAP5_L4_ABE_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-#define OMAP5_AESS_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
-#define OMAP5_MCPDM_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
-#define OMAP5_DMIC_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x38)
-#define OMAP5_MCBSP1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x48)
-#define OMAP5_MCBSP2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x50)
-#define OMAP5_MCBSP3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x58)
-#define OMAP5_TIMER5_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x68)
-#define OMAP5_TIMER6_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x70)
-#define OMAP5_TIMER7_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x78)
-#define OMAP5_TIMER8_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x80)
-
-/* l3main1 clocks */
-#define OMAP5_L3_MAIN_1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* l3main2 clocks */
-#define OMAP5_L3_MAIN_2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* ipu clocks */
-#define OMAP5_MMU_IPU_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* dma clocks */
-#define OMAP5_DMA_SYSTEM_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* emif clocks */
-#define OMAP5_DMM_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-#define OMAP5_EMIF1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
-#define OMAP5_EMIF2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x38)
-
-/* l4cfg clocks */
-#define OMAP5_L4_CFG_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-#define OMAP5_SPINLOCK_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
-#define OMAP5_MAILBOX_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
-
-/* l3instr clocks */
-#define OMAP5_L3_MAIN_3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-#define OMAP5_L3_INSTR_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
-
-/* l4per clocks */
-#define OMAP5_TIMER10_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
-#define OMAP5_TIMER11_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
-#define OMAP5_TIMER2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x38)
-#define OMAP5_TIMER3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x40)
-#define OMAP5_TIMER4_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x48)
-#define OMAP5_TIMER9_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x50)
-#define OMAP5_GPIO2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x60)
-#define OMAP5_GPIO3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x68)
-#define OMAP5_GPIO4_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x70)
-#define OMAP5_GPIO5_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x78)
-#define OMAP5_GPIO6_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x80)
-#define OMAP5_I2C1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xa0)
-#define OMAP5_I2C2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xa8)
-#define OMAP5_I2C3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xb0)
-#define OMAP5_I2C4_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xb8)
-#define OMAP5_L4_PER_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xc0)
-#define OMAP5_MCSPI1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xf0)
-#define OMAP5_MCSPI2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xf8)
-#define OMAP5_MCSPI3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x100)
-#define OMAP5_MCSPI4_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x108)
-#define OMAP5_GPIO7_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x110)
-#define OMAP5_GPIO8_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x118)
-#define OMAP5_MMC3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x120)
-#define OMAP5_MMC4_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x128)
-#define OMAP5_UART1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x140)
-#define OMAP5_UART2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x148)
-#define OMAP5_UART3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x150)
-#define OMAP5_UART4_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x158)
-#define OMAP5_MMC5_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x160)
-#define OMAP5_I2C5_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x168)
-#define OMAP5_UART5_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x170)
-#define OMAP5_UART6_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x178)
-
-/* l4_secure clocks */
-#define OMAP5_L4_SECURE_CLKCTRL_OFFSET	0x1a0
-#define OMAP5_L4_SECURE_CLKCTRL_INDEX(offset)	((offset) - OMAP5_L4_SECURE_CLKCTRL_OFFSET)
-#define OMAP5_AES1_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1a0)
-#define OMAP5_AES2_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1a8)
-#define OMAP5_DES3DES_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1b0)
-#define OMAP5_FPKA_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1b8)
-#define OMAP5_RNG_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1c0)
-#define OMAP5_SHA2MD5_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1c8)
-#define OMAP5_DMA_CRYPTO_CLKCTRL	OMAP5_L4_SECURE_CLKCTRL_INDEX(0x1d8)
-
-/* iva clocks */
-#define OMAP5_IVA_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-#define OMAP5_SL2IF_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
-
-/* dss clocks */
-#define OMAP5_DSS_CORE_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* gpu clocks */
-#define OMAP5_GPU_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-
-/* l3init clocks */
-#define OMAP5_MMC1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x28)
-#define OMAP5_MMC2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
-#define OMAP5_USB_HOST_HS_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x58)
-#define OMAP5_USB_TLL_HS_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x68)
-#define OMAP5_SATA_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x88)
-#define OMAP5_OCP2SCP1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xe0)
-#define OMAP5_OCP2SCP3_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xe8)
-#define OMAP5_USB_OTG_SS_CLKCTRL	OMAP5_CLKCTRL_INDEX(0xf0)
-
-/* wkupaon clocks */
-#define OMAP5_L4_WKUP_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x20)
-#define OMAP5_WD_TIMER2_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x30)
-#define OMAP5_GPIO1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x38)
-#define OMAP5_TIMER1_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x40)
-#define OMAP5_COUNTER_32K_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x50)
-#define OMAP5_KBD_CLKCTRL	OMAP5_CLKCTRL_INDEX(0x78)
-
-#endif
diff --git a/include/dt-bindings/clock/sun4i-a10-pll2.h b/include/dt-bindings/clock/sun4i-a10-pll2.h
deleted file mode 100644
index 071c8112d531..000000000000
--- a/include/dt-bindings/clock/sun4i-a10-pll2.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright 2015 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_SUN4I_A10_PLL2_H_
-#define __DT_BINDINGS_CLOCK_SUN4I_A10_PLL2_H_
-
-#define SUN4I_A10_PLL2_1X	0
-#define SUN4I_A10_PLL2_2X	1
-#define SUN4I_A10_PLL2_4X	2
-#define SUN4I_A10_PLL2_8X	3
-
-#endif /* __DT_BINDINGS_CLOCK_SUN4I_A10_PLL2_H_ */
diff --git a/include/dt-bindings/clock/xlnx-versal-clk.h b/include/dt-bindings/clock/xlnx-versal-clk.h
deleted file mode 100644
index 264d634d226e..000000000000
--- a/include/dt-bindings/clock/xlnx-versal-clk.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 2019 Xilinx Inc.
- *
- */
-
-#ifndef _DT_BINDINGS_CLK_VERSAL_H
-#define _DT_BINDINGS_CLK_VERSAL_H
-
-#define PMC_PLL					1
-#define APU_PLL					2
-#define RPU_PLL					3
-#define CPM_PLL					4
-#define NOC_PLL					5
-#define PLL_MAX					6
-#define PMC_PRESRC				7
-#define PMC_POSTCLK				8
-#define PMC_PLL_OUT				9
-#define PPLL					10
-#define NOC_PRESRC				11
-#define NOC_POSTCLK				12
-#define NOC_PLL_OUT				13
-#define NPLL					14
-#define APU_PRESRC				15
-#define APU_POSTCLK				16
-#define APU_PLL_OUT				17
-#define APLL					18
-#define RPU_PRESRC				19
-#define RPU_POSTCLK				20
-#define RPU_PLL_OUT				21
-#define RPLL					22
-#define CPM_PRESRC				23
-#define CPM_POSTCLK				24
-#define CPM_PLL_OUT				25
-#define CPLL					26
-#define PPLL_TO_XPD				27
-#define NPLL_TO_XPD				28
-#define APLL_TO_XPD				29
-#define RPLL_TO_XPD				30
-#define EFUSE_REF				31
-#define SYSMON_REF				32
-#define IRO_SUSPEND_REF				33
-#define USB_SUSPEND				34
-#define SWITCH_TIMEOUT				35
-#define RCLK_PMC				36
-#define RCLK_LPD				37
-#define WDT					38
-#define TTC0					39
-#define TTC1					40
-#define TTC2					41
-#define TTC3					42
-#define GEM_TSU					43
-#define GEM_TSU_LB				44
-#define MUXED_IRO_DIV2				45
-#define MUXED_IRO_DIV4				46
-#define PSM_REF					47
-#define GEM0_RX					48
-#define GEM0_TX					49
-#define GEM1_RX					50
-#define GEM1_TX					51
-#define CPM_CORE_REF				52
-#define CPM_LSBUS_REF				53
-#define CPM_DBG_REF				54
-#define CPM_AUX0_REF				55
-#define CPM_AUX1_REF				56
-#define QSPI_REF				57
-#define OSPI_REF				58
-#define SDIO0_REF				59
-#define SDIO1_REF				60
-#define PMC_LSBUS_REF				61
-#define I2C_REF					62
-#define TEST_PATTERN_REF			63
-#define DFT_OSC_REF				64
-#define PMC_PL0_REF				65
-#define PMC_PL1_REF				66
-#define PMC_PL2_REF				67
-#define PMC_PL3_REF				68
-#define CFU_REF					69
-#define SPARE_REF				70
-#define NPI_REF					71
-#define HSM0_REF				72
-#define HSM1_REF				73
-#define SD_DLL_REF				74
-#define FPD_TOP_SWITCH				75
-#define FPD_LSBUS				76
-#define ACPU					77
-#define DBG_TRACE				78
-#define DBG_FPD					79
-#define LPD_TOP_SWITCH				80
-#define ADMA					81
-#define LPD_LSBUS				82
-#define CPU_R5					83
-#define CPU_R5_CORE				84
-#define CPU_R5_OCM				85
-#define CPU_R5_OCM2				86
-#define IOU_SWITCH				87
-#define GEM0_REF				88
-#define GEM1_REF				89
-#define GEM_TSU_REF				90
-#define USB0_BUS_REF				91
-#define UART0_REF				92
-#define UART1_REF				93
-#define SPI0_REF				94
-#define SPI1_REF				95
-#define CAN0_REF				96
-#define CAN1_REF				97
-#define I2C0_REF				98
-#define I2C1_REF				99
-#define DBG_LPD					100
-#define TIMESTAMP_REF				101
-#define DBG_TSTMP				102
-#define CPM_TOPSW_REF				103
-#define USB3_DUAL_REF				104
-#define OUTCLK_MAX				105
-#define REF_CLK					106
-#define PL_ALT_REF_CLK				107
-#define MUXED_IRO				108
-#define PL_EXT					109
-#define PL_LB					110
-#define MIO_50_OR_51				111
-#define MIO_24_OR_25				112
-
-#endif
diff --git a/include/dt-bindings/interrupt-controller/irq-st.h b/include/dt-bindings/interrupt-controller/irq-st.h
deleted file mode 100644
index 6baa9ad2644c..000000000000
--- a/include/dt-bindings/interrupt-controller/irq-st.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *  include/linux/irqchip/irq-st.h
- *
- *  Copyright (C) 2014 STMicroelectronics All Rights Reserved
- *
- *  Author: Lee Jones <lee.jones@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ST_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ST_H
-
-#define ST_IRQ_SYSCFG_EXT_0		0
-#define ST_IRQ_SYSCFG_EXT_1		1
-#define ST_IRQ_SYSCFG_EXT_2		2
-#define ST_IRQ_SYSCFG_CTI_0		3
-#define ST_IRQ_SYSCFG_CTI_1		4
-#define ST_IRQ_SYSCFG_PMU_0		5
-#define ST_IRQ_SYSCFG_PMU_1		6
-#define ST_IRQ_SYSCFG_pl310_L2		7
-#define ST_IRQ_SYSCFG_DISABLED		0xFFFFFFFF
-
-#define ST_IRQ_SYSCFG_EXT_1_INV		0x1
-#define ST_IRQ_SYSCFG_EXT_2_INV		0x2
-#define ST_IRQ_SYSCFG_EXT_3_INV		0x4
-
-#endif
diff --git a/include/dt-bindings/interrupt-controller/mips-gic.h b/include/dt-bindings/interrupt-controller/mips-gic.h
deleted file mode 100644
index cf35a577e371..000000000000
--- a/include/dt-bindings/interrupt-controller/mips-gic.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-#define GIC_SHARED 0
-#define GIC_LOCAL 1
-
-#endif
diff --git a/include/dt-bindings/leds/leds-netxbig.h b/include/dt-bindings/leds/leds-netxbig.h
deleted file mode 100644
index 92658b0310b2..000000000000
--- a/include/dt-bindings/leds/leds-netxbig.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This header provides constants for netxbig LED bindings.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef _DT_BINDINGS_LEDS_NETXBIG_H
-#define _DT_BINDINGS_LEDS_NETXBIG_H
-
-#define NETXBIG_LED_OFF		0
-#define NETXBIG_LED_ON		1
-#define NETXBIG_LED_SATA	2
-#define NETXBIG_LED_TIMER1	3
-#define NETXBIG_LED_TIMER2	4
-
-#endif /* _DT_BINDINGS_LEDS_NETXBIG_H */
diff --git a/include/dt-bindings/leds/leds-ns2.h b/include/dt-bindings/leds/leds-ns2.h
deleted file mode 100644
index fd615749e703..000000000000
--- a/include/dt-bindings/leds/leds-ns2.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DT_BINDINGS_LEDS_NS2_H
-#define _DT_BINDINGS_LEDS_NS2_H
-
-#define NS_V2_LED_OFF	0
-#define NS_V2_LED_ON	1
-#define NS_V2_LED_SATA	2
-
-#endif
diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
deleted file mode 100644
index b0b1091aad6d..000000000000
--- a/include/dt-bindings/mux/ti-serdes.h
+++ /dev/null
@@ -1,190 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for SERDES MUX for TI SoCs
- */
-
-#ifndef _DT_BINDINGS_MUX_TI_SERDES
-#define _DT_BINDINGS_MUX_TI_SERDES
-
-/*
- * These bindings are deprecated, because they do not match the actual
- * concept of bindings but rather contain pure constants values used only
- * in DTS board files.
- * Instead include the header in the DTS source directory.
- */
-#warning "These bindings are deprecated. Instead, use the header in the DTS source directory."
-
-/* J721E */
-
-#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
-#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
-#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
-#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
-#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
-#define J721E_SERDES0_LANE1_USB3_0		0x2
-#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
-#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
-#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
-#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
-
-#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
-#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
-#define J721E_SERDES1_LANE1_USB3_1		0x2
-#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
-
-#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
-#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
-#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
-#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
-
-#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
-#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
-#define J721E_SERDES2_LANE1_USB3_1		0x2
-#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
-
-#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
-#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
-#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
-#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
-#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
-#define J721E_SERDES3_LANE1_USB3_0		0x2
-#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
-#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
-#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
-#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
-#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
-#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
-#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
-#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
-#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
-
-/* J7200 */
-
-#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
-#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
-#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
-#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
-#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
-#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
-#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
-#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
-#define J7200_SERDES0_LANE3_USB			0x2
-#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
-
-/* AM64 */
-
-#define AM64_SERDES0_LANE0_PCIE0		0x0
-#define AM64_SERDES0_LANE0_USB			0x1
-
-/* J721S2 */
-
-#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
-#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
-#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
-#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
-#define J721S2_SERDES0_LANE1_USB		0x2
-#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
-#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
-#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
-#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
-#define J721S2_SERDES0_LANE3_USB		0x2
-#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
-
-/* J784S4 */
-
-#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
-#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
-#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
-#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
-#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
-#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
-#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
-#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
-#define J784S4_SERDES0_LANE3_USB		0x2
-#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
-#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
-#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
-#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
-#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
-#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
-#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
-#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
-#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
-#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
-#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
-#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
-#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
-#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
-#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
-#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
-#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
-#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
-#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
-
-#endif /* _DT_BINDINGS_MUX_TI_SERDES */
diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
deleted file mode 100644
index c340437414fb..000000000000
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Device Tree constants for Microsemi VSC8531 PHY
- *
- * Author: Nagaraju Lakkaraju
- *
- * Copyright (c) 2017 Microsemi Corporation
- */
-
-#ifndef _DT_BINDINGS_MSCC_VSC8531_H
-#define _DT_BINDINGS_MSCC_VSC8531_H
-
-/* PHY LED Modes */
-#define VSC8531_LINK_ACTIVITY			0
-#define VSC8531_LINK_1000_ACTIVITY		1
-#define VSC8531_LINK_100_ACTIVITY		2
-#define VSC8531_LINK_10_ACTIVITY		3
-#define VSC8531_LINK_100_1000_ACTIVITY		4
-#define VSC8531_LINK_10_1000_ACTIVITY		5
-#define VSC8531_LINK_10_100_ACTIVITY		6
-#define VSC8584_LINK_100FX_1000X_ACTIVITY	7
-#define VSC8531_DUPLEX_COLLISION		8
-#define VSC8531_COLLISION			9
-#define VSC8531_ACTIVITY			10
-#define VSC8584_100FX_1000X_ACTIVITY		11
-#define VSC8531_AUTONEG_FAULT			12
-#define VSC8531_SERIAL_MODE			13
-#define VSC8531_FORCE_LED_OFF			14
-#define VSC8531_FORCE_LED_ON			15
-
-#endif
diff --git a/include/dt-bindings/phy/phy-am654-serdes.h b/include/dt-bindings/phy/phy-am654-serdes.h
deleted file mode 100644
index e8d901729ed9..000000000000
--- a/include/dt-bindings/phy/phy-am654-serdes.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for AM654 SERDES.
- */
-
-#ifndef _DT_BINDINGS_AM654_SERDES
-#define _DT_BINDINGS_AM654_SERDES
-
-#define AM654_SERDES_CMU_REFCLK	0
-#define AM654_SERDES_LO_REFCLK	1
-#define AM654_SERDES_RO_REFCLK	2
-
-#endif /* _DT_BINDINGS_AM654_SERDES */
diff --git a/include/dt-bindings/pinctrl/brcm,pinctrl-ns3.h b/include/dt-bindings/pinctrl/brcm,pinctrl-ns3.h
deleted file mode 100644
index 81ebd58ca503..000000000000
--- a/include/dt-bindings/pinctrl/brcm,pinctrl-ns3.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2020 Broadcom.
- */
-
-#ifndef __DT_BINDINGS_PINCTRL_BRCM_STINGRAY_H__
-#define __DT_BINDINGS_PINCTRL_BRCM_STINGRAY_H__
-
-/* Alternate functions available in MUX controller */
-#define MODE_NITRO				0
-#define MODE_NAND				1
-#define MODE_PNOR				2
-#define MODE_GPIO				3
-
-/* Pad configuration attribute */
-#define PAD_SLEW_RATE_ENA			BIT(0)
-#define PAD_SLEW_RATE_ENA_MASK			BIT(0)
-
-#define PAD_DRIVE_STRENGTH_2_MA			(0 << 1)
-#define PAD_DRIVE_STRENGTH_4_MA			BIT(1)
-#define PAD_DRIVE_STRENGTH_6_MA			(2 << 1)
-#define PAD_DRIVE_STRENGTH_8_MA			(3 << 1)
-#define PAD_DRIVE_STRENGTH_10_MA		(4 << 1)
-#define PAD_DRIVE_STRENGTH_12_MA		(5 << 1)
-#define PAD_DRIVE_STRENGTH_14_MA		(6 << 1)
-#define PAD_DRIVE_STRENGTH_16_MA		(7 << 1)
-#define PAD_DRIVE_STRENGTH_MASK			(7 << 1)
-
-#define PAD_PULL_UP_ENA				BIT(4)
-#define PAD_PULL_UP_ENA_MASK			BIT(4)
-
-#define PAD_PULL_DOWN_ENA			BIT(5)
-#define PAD_PULL_DOWN_ENA_MASK			BIT(5)
-
-#define PAD_INPUT_PATH_DIS			BIT(6)
-#define PAD_INPUT_PATH_DIS_MASK			BIT(6)
-
-#define PAD_HYSTERESIS_ENA			BIT(7)
-#define PAD_HYSTERESIS_ENA_MASK			BIT(7)
-
-#endif
diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
deleted file mode 100644
index e8418318eb9c..000000000000
--- a/include/dt-bindings/pinctrl/k3.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for pinctrl bindings for TI's K3 SoC
- * family.
- *
- * Copyright (C) 2018-2021 Texas Instruments Incorporated - https://www.ti.com/
- */
-#ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
-#define _DT_BINDINGS_PINCTRL_TI_K3_H
-
-#define PULLUDEN_SHIFT		(16)
-#define PULLTYPESEL_SHIFT	(17)
-#define RXACTIVE_SHIFT		(18)
-
-#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
-#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
-
-#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
-#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
-
-#define INPUT_EN		(1 << RXACTIVE_SHIFT)
-#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
-
-/* Only these macros are expected be used directly in device tree files */
-#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
-#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
-#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
-#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
-
-#define AM65X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM65X_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J721E_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J721E_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM64X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM64X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#endif
diff --git a/include/dt-bindings/reset/xlnx-versal-resets.h b/include/dt-bindings/reset/xlnx-versal-resets.h
deleted file mode 100644
index 895424e9b0e5..000000000000
--- a/include/dt-bindings/reset/xlnx-versal-resets.h
+++ /dev/null
@@ -1,105 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 2020 Xilinx, Inc.
- */
-
-#ifndef _DT_BINDINGS_VERSAL_RESETS_H
-#define _DT_BINDINGS_VERSAL_RESETS_H
-
-#define VERSAL_RST_PMC_POR			(0xc30c001U)
-#define VERSAL_RST_PMC				(0xc410002U)
-#define VERSAL_RST_PS_POR			(0xc30c003U)
-#define VERSAL_RST_PL_POR			(0xc30c004U)
-#define VERSAL_RST_NOC_POR			(0xc30c005U)
-#define VERSAL_RST_FPD_POR			(0xc30c006U)
-#define VERSAL_RST_ACPU_0_POR			(0xc30c007U)
-#define VERSAL_RST_ACPU_1_POR			(0xc30c008U)
-#define VERSAL_RST_OCM2_POR			(0xc30c009U)
-#define VERSAL_RST_PS_SRST			(0xc41000aU)
-#define VERSAL_RST_PL_SRST			(0xc41000bU)
-#define VERSAL_RST_NOC				(0xc41000cU)
-#define VERSAL_RST_NPI				(0xc41000dU)
-#define VERSAL_RST_SYS_RST_1			(0xc41000eU)
-#define VERSAL_RST_SYS_RST_2			(0xc41000fU)
-#define VERSAL_RST_SYS_RST_3			(0xc410010U)
-#define VERSAL_RST_FPD				(0xc410011U)
-#define VERSAL_RST_PL0				(0xc410012U)
-#define VERSAL_RST_PL1				(0xc410013U)
-#define VERSAL_RST_PL2				(0xc410014U)
-#define VERSAL_RST_PL3				(0xc410015U)
-#define VERSAL_RST_APU				(0xc410016U)
-#define VERSAL_RST_ACPU_0			(0xc410017U)
-#define VERSAL_RST_ACPU_1			(0xc410018U)
-#define VERSAL_RST_ACPU_L2			(0xc410019U)
-#define VERSAL_RST_ACPU_GIC			(0xc41001aU)
-#define VERSAL_RST_RPU_ISLAND			(0xc41001bU)
-#define VERSAL_RST_RPU_AMBA			(0xc41001cU)
-#define VERSAL_RST_R5_0				(0xc41001dU)
-#define VERSAL_RST_R5_1				(0xc41001eU)
-#define VERSAL_RST_SYSMON_PMC_SEQ_RST		(0xc41001fU)
-#define VERSAL_RST_SYSMON_PMC_CFG_RST		(0xc410020U)
-#define VERSAL_RST_SYSMON_FPD_CFG_RST		(0xc410021U)
-#define VERSAL_RST_SYSMON_FPD_SEQ_RST		(0xc410022U)
-#define VERSAL_RST_SYSMON_LPD			(0xc410023U)
-#define VERSAL_RST_PDMA_RST1			(0xc410024U)
-#define VERSAL_RST_PDMA_RST0			(0xc410025U)
-#define VERSAL_RST_ADMA				(0xc410026U)
-#define VERSAL_RST_TIMESTAMP			(0xc410027U)
-#define VERSAL_RST_OCM				(0xc410028U)
-#define VERSAL_RST_OCM2_RST			(0xc410029U)
-#define VERSAL_RST_IPI				(0xc41002aU)
-#define VERSAL_RST_SBI				(0xc41002bU)
-#define VERSAL_RST_LPD				(0xc41002cU)
-#define VERSAL_RST_QSPI				(0xc10402dU)
-#define VERSAL_RST_OSPI				(0xc10402eU)
-#define VERSAL_RST_SDIO_0			(0xc10402fU)
-#define VERSAL_RST_SDIO_1			(0xc104030U)
-#define VERSAL_RST_I2C_PMC			(0xc104031U)
-#define VERSAL_RST_GPIO_PMC			(0xc104032U)
-#define VERSAL_RST_GEM_0			(0xc104033U)
-#define VERSAL_RST_GEM_1			(0xc104034U)
-#define VERSAL_RST_SPARE			(0xc104035U)
-#define VERSAL_RST_USB_0			(0xc104036U)
-#define VERSAL_RST_UART_0			(0xc104037U)
-#define VERSAL_RST_UART_1			(0xc104038U)
-#define VERSAL_RST_SPI_0			(0xc104039U)
-#define VERSAL_RST_SPI_1			(0xc10403aU)
-#define VERSAL_RST_CAN_FD_0			(0xc10403bU)
-#define VERSAL_RST_CAN_FD_1			(0xc10403cU)
-#define VERSAL_RST_I2C_0			(0xc10403dU)
-#define VERSAL_RST_I2C_1			(0xc10403eU)
-#define VERSAL_RST_GPIO_LPD			(0xc10403fU)
-#define VERSAL_RST_TTC_0			(0xc104040U)
-#define VERSAL_RST_TTC_1			(0xc104041U)
-#define VERSAL_RST_TTC_2			(0xc104042U)
-#define VERSAL_RST_TTC_3			(0xc104043U)
-#define VERSAL_RST_SWDT_FPD			(0xc104044U)
-#define VERSAL_RST_SWDT_LPD			(0xc104045U)
-#define VERSAL_RST_USB				(0xc104046U)
-#define VERSAL_RST_DPC				(0xc208047U)
-#define VERSAL_RST_PMCDBG			(0xc208048U)
-#define VERSAL_RST_DBG_TRACE			(0xc208049U)
-#define VERSAL_RST_DBG_FPD			(0xc20804aU)
-#define VERSAL_RST_DBG_TSTMP			(0xc20804bU)
-#define VERSAL_RST_RPU0_DBG			(0xc20804cU)
-#define VERSAL_RST_RPU1_DBG			(0xc20804dU)
-#define VERSAL_RST_HSDP				(0xc20804eU)
-#define VERSAL_RST_DBG_LPD			(0xc20804fU)
-#define VERSAL_RST_CPM_POR			(0xc30c050U)
-#define VERSAL_RST_CPM				(0xc410051U)
-#define VERSAL_RST_CPMDBG			(0xc208052U)
-#define VERSAL_RST_PCIE_CFG			(0xc410053U)
-#define VERSAL_RST_PCIE_CORE0			(0xc410054U)
-#define VERSAL_RST_PCIE_CORE1			(0xc410055U)
-#define VERSAL_RST_PCIE_DMA			(0xc410056U)
-#define VERSAL_RST_CMN				(0xc410057U)
-#define VERSAL_RST_L2_0				(0xc410058U)
-#define VERSAL_RST_L2_1				(0xc410059U)
-#define VERSAL_RST_ADDR_REMAP			(0xc41005aU)
-#define VERSAL_RST_CPI0				(0xc41005bU)
-#define VERSAL_RST_CPI1				(0xc41005cU)
-#define VERSAL_RST_XRAM				(0xc30c05dU)
-#define VERSAL_RST_AIE_ARRAY			(0xc10405eU)
-#define VERSAL_RST_AIE_SHIM			(0xc10405fU)
-
-#endif
diff --git a/include/dt-bindings/sound/tlv320aic31xx.h b/include/dt-bindings/sound/tlv320aic31xx.h
deleted file mode 100644
index 4a80238ab250..000000000000
--- a/include/dt-bindings/sound/tlv320aic31xx.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_TLV320AIC31XX_H
-#define __DT_TLV320AIC31XX_H
-
-#define MICBIAS_2_0V		1
-#define MICBIAS_2_5V		2
-#define MICBIAS_AVDDV		3
-
-#define PLL_CLKIN_MCLK		0x00
-#define PLL_CLKIN_BCLK		0x01
-#define PLL_CLKIN_GPIO1		0x02
-#define PLL_CLKIN_DIN		0x03
-
-#endif /* __DT_TLV320AIC31XX_H */
-- 
2.43.0

