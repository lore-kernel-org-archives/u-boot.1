Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC79C3DA44
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D07388766;
	Mon,  8 Jul 2024 14:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gd8EEedG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D21B886AF; Mon,  8 Jul 2024 09:52:37 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988DA8861D
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4687qHEw002505;
 Mon, 8 Jul 2024 02:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720425137;
 bh=tZThyM8XmqhQyvUDjxWzCkkpnrRP0kw/QhyWmRK9BZ4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gd8EEedGjv8EfDRWq7mT2nCF5gpuqBnNT1rcVgTVDqCRnazGFwdCF18L5yKDCceh3
 9Z++Ouubrv2blxVxLOiwYelKBORsMC0PC4Hk10ho/C8cplnRq3asc355ToVKo5FGAZ
 HDZcaW/wKRx6ZFsJWQDIJg/3TJU09pU4PIW5H1lc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4687qHfP010820
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 02:52:17 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 02:52:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 02:52:16 -0500
Received: from localhost (scaria-hp-zbook-15-g5.dhcp.ti.com [172.24.31.134])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4687qFZR115970;
 Mon, 8 Jul 2024 02:52:16 -0500
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <s-kochidanadu@ti.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: [PATCH 3/6] sound: ti: Add MCASP driver for transfer of Audio data to
 sound codec
Date: Mon, 8 Jul 2024 13:22:04 +0530
Message-ID: <20240708075207.37207-4-s-kochidanadu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708075207.37207-1-s-kochidanadu@ti.com>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

This patch adds driver for I2S interface for TI AM62x Soc.
Configure the MCASP [1] component with appropriate settings and
hardware parameters according to the audio data and devicetree.
Set up the MCASP pins and fill the transmit buffers. The driver
uses polling method to transfer data to the codec, since
u-boot does not have DMA driver or interrupt functionality.

The TRM for the AM62X SoC contain the information for the MCASP
component-
Link: https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf [1] (Section
12.1.1 : Audio Peripherals-MCASP)

The driver is based on the kernel mcasp driver[2].
Link:
https://gitlab.com/linux-kernel/linux-next/-/blob/master/sound/soc/ti/davinci-mcasp.c
[2]

Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
---
 MAINTAINERS                   |    2 +
 drivers/sound/Makefile        |    1 +
 drivers/sound/davinci-mcasp.h |  413 ++++++++++++
 drivers/sound/mcasp_i2s.c     | 1123 +++++++++++++++++++++++++++++++++
 4 files changed, 1539 insertions(+)
 create mode 100644 drivers/sound/davinci-mcasp.h
 create mode 100644 drivers/sound/mcasp_i2s.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d7c260bfc..6097b3ba62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -738,6 +738,8 @@ F:	drivers/reset/reset-ti-sci.c
 F:	drivers/rtc/davinci.c
 F:	drivers/serial/serial_omap.c
 F:	drivers/soc/ti/
+F:	drivers/sound/davinci-mcasp.h
+F:	drivers/sound/mcasp_i2s.c
 F:	drivers/sound/ti_sound.c
 F:	drivers/sound/tlv320aic3106.c
 F:	drivers/sound/tlv320aic3106.h
diff --git a/drivers/sound/Makefile b/drivers/sound/Makefile
index 1e9fbd1000..2068649172 100644
--- a/drivers/sound/Makefile
+++ b/drivers/sound/Makefile
@@ -24,4 +24,5 @@ obj-$(CONFIG_SOUND_RT5677)	+= rt5677.o
 obj-$(CONFIG_INTEL_BROADWELL)	+= broadwell_i2s.o broadwell_sound.o
 obj-$(CONFIG_SOUND_IVYBRIDGE)	+= ivybridge_sound.o
 obj-$(CONFIG_I2S_TI)    += ti_sound.o
+obj-$(CONFIG_I2S_TI)    += mcasp_i2s.o
 obj-$(CONFIG_SOUND_TLV320AIC3106)       += tlv320aic3106.o
diff --git a/drivers/sound/davinci-mcasp.h b/drivers/sound/davinci-mcasp.h
new file mode 100644
index 0000000000..83c77ba26c
--- /dev/null
+++ b/drivers/sound/davinci-mcasp.h
@@ -0,0 +1,413 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ALSA SoC McASP Audio Layer for TI DAVINCI processor
+ *
+ * MCASP related definitions
+ *
+ * Author: Nirmal Pandey <n-pandey@ti.com>,
+ *         Suresh Rajashekara <suresh.r@ti.com>
+ *         Steve Chen <schen@.mvista.com>
+ *
+ * Copyright:   (C) 2009 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2009  Texas Instruments, India
+ */
+
+#ifndef DAVINCI_MCASP_H
+#define DAVINCI_MCASP_H
+
+/*
+ * McASP register definitions
+ */
+#define DAVINCI_MCASP_PID_REG		0x00
+#define DAVINCI_MCASP_PWREMUMGT_REG	0x04
+
+#define DAVINCI_MCASP_PFUNC_REG		0x10
+#define DAVINCI_MCASP_PDIR_REG		0x14
+#define DAVINCI_MCASP_PDOUT_REG		0x18
+#define DAVINCI_MCASP_PDSET_REG		0x1c
+
+#define DAVINCI_MCASP_PDCLR_REG		0x20
+
+#define DAVINCI_MCASP_TLGC_REG		0x30
+#define DAVINCI_MCASP_TLMR_REG		0x34
+
+#define DAVINCI_MCASP_GBLCTL_REG	0x44
+#define DAVINCI_MCASP_AMUTE_REG		0x48
+#define DAVINCI_MCASP_LBCTL_REG		0x4c
+
+#define DAVINCI_MCASP_TXDITCTL_REG	0x50
+
+#define DAVINCI_MCASP_GBLCTLR_REG	0x60
+#define DAVINCI_MCASP_RXMASK_REG	0x64
+#define DAVINCI_MCASP_RXFMT_REG		0x68
+#define DAVINCI_MCASP_RXFMCTL_REG	0x6c
+
+#define DAVINCI_MCASP_ACLKRCTL_REG	0x70
+#define DAVINCI_MCASP_AHCLKRCTL_REG	0x74
+#define DAVINCI_MCASP_RXTDM_REG		0x78
+#define DAVINCI_MCASP_EVTCTLR_REG	0x7c
+
+#define DAVINCI_MCASP_RXSTAT_REG	0x80
+#define DAVINCI_MCASP_RXTDMSLOT_REG	0x84
+#define DAVINCI_MCASP_RXCLKCHK_REG	0x88
+#define DAVINCI_MCASP_REVTCTL_REG	0x8c
+
+#define DAVINCI_MCASP_GBLCTLX_REG	0xa0
+#define DAVINCI_MCASP_TXMASK_REG	0xa4
+#define DAVINCI_MCASP_TXFMT_REG		0xa8
+#define DAVINCI_MCASP_TXFMCTL_REG	0xac
+
+#define DAVINCI_MCASP_ACLKXCTL_REG	0xb0
+#define DAVINCI_MCASP_AHCLKXCTL_REG	0xb4
+#define DAVINCI_MCASP_TXTDM_REG		0xb8
+#define DAVINCI_MCASP_EVTCTLX_REG	0xbc
+
+#define DAVINCI_MCASP_TXSTAT_REG	0xc0
+#define DAVINCI_MCASP_TXTDMSLOT_REG	0xc4
+#define DAVINCI_MCASP_TXCLKCHK_REG	0xc8
+#define DAVINCI_MCASP_XEVTCTL_REG	0xcc
+
+/* Left(even TDM Slot) Channel Status Register File */
+#define DAVINCI_MCASP_DITCSRA_REG	0x100
+/* Right(odd TDM slot) Channel Status Register File */
+#define DAVINCI_MCASP_DITCSRB_REG	0x118
+/* Left(even TDM slot) User Data Register File */
+#define DAVINCI_MCASP_DITUDRA_REG	0x130
+/* Right(odd TDM Slot) User Data Register File */
+#define DAVINCI_MCASP_DITUDRB_REG	0x148
+
+/* Serializer n Control Register */
+#define DAVINCI_MCASP_XRSRCTL_BASE_REG	0x180
+#define DAVINCI_MCASP_XRSRCTL_REG(n)	(DAVINCI_MCASP_XRSRCTL_BASE_REG + \
+						((n) << 2))
+
+/* Transmit Buffer for Serializer n */
+#define DAVINCI_MCASP_TXBUF_REG(n)	(0x200 + ((n) << 2))
+/* Receive Buffer for Serializer n */
+#define DAVINCI_MCASP_RXBUF_REG(n)	(0x280 + ((n) << 2))
+
+/* McASP FIFO Registers */
+#define DAVINCI_MCASP_V2_AFIFO_BASE	(0x1010)
+#define DAVINCI_MCASP_V3_AFIFO_BASE	(0x1000)
+
+/* FIFO register offsets from AFIFO base */
+#define MCASP_WFIFOCTL_OFFSET		(0x0)
+#define MCASP_WFIFOSTS_OFFSET		(0x4)
+#define MCASP_RFIFOCTL_OFFSET		(0x8)
+#define MCASP_RFIFOSTS_OFFSET		(0xc)
+
+/*
+ * DAVINCI_MCASP_PWREMUMGT_REG - Power Down and Emulation Management
+ *     Register Bits
+ */
+#define MCASP_FREE	BIT(0)
+#define MCASP_SOFT	BIT(1)
+
+/*
+ * DAVINCI_MCASP_PFUNC_REG - Pin Function / GPIO Enable Register Bits
+ * DAVINCI_MCASP_PDIR_REG - Pin Direction Register Bits
+ * DAVINCI_MCASP_PDOUT_REG - Pin output in GPIO mode
+ * DAVINCI_MCASP_PDSET_REG - Pin input in GPIO mode
+ */
+#define PIN_BIT_AXR(n)	(n)
+#define PIN_BIT_AMUTE	25
+#define PIN_BIT_ACLKX	26
+#define PIN_BIT_AHCLKX	27
+#define PIN_BIT_AFSX	28
+#define PIN_BIT_ACLKR	29
+#define PIN_BIT_AHCLKR	30
+#define PIN_BIT_AFSR	31
+
+/*
+ * DAVINCI_MCASP_TXDITCTL_REG - Transmit DIT Control Register Bits
+ */
+#define DITEN	BIT(0)	/* Transmit DIT mode enable/disable */
+#define VA	BIT(2)
+#define VB	BIT(3)
+
+/*
+ * DAVINCI_MCASP_TXFMT_REG - Transmit Bitstream Format Register Bits
+ */
+#define TXROT(val)	(val)
+#define TXSEL		BIT(3)
+#define TXSSZ(val)	((val) << 4)
+#define TXPBIT(val)	((val) << 8)
+#define TXPAD(val)	((val) << 13)
+#define TXORD		BIT(15)
+#define FSXDLY(val)	((val) << 16)
+
+/*
+ * DAVINCI_MCASP_RXFMT_REG - Receive Bitstream Format Register Bits
+ */
+#define RXROT(val)	(val)
+#define RXSEL		BIT(3)
+#define RXSSZ(val)	((val) << 4)
+#define RXPBIT(val)	((val) << 8)
+#define RXPAD(val)	((val) << 13)
+#define RXORD		BIT(15)
+#define FSRDLY(val)	((val) << 16)
+
+/*
+ * DAVINCI_MCASP_TXFMCTL_REG -  Transmit Frame Control Register Bits
+ */
+#define FSXPOL		BIT(0)
+#define AFSXE		BIT(1)
+#define FSXDUR		BIT(4)
+#define FSXMOD(val)	((val) << 7)
+
+/*
+ * DAVINCI_MCASP_RXFMCTL_REG - Receive Frame Control Register Bits
+ */
+#define FSRPOL		BIT(0)
+#define AFSRE		BIT(1)
+#define FSRDUR		BIT(4)
+#define FSRMOD(val)	((val) << 7)
+
+/*
+ * DAVINCI_MCASP_ACLKXCTL_REG - Transmit Clock Control Register Bits
+ */
+#define ACLKXDIV(val)	(val)
+#define ACLKXE		BIT(5)
+#define TX_ASYNC	BIT(6)
+#define ACLKXPOL	BIT(7)
+#define ACLKXDIV_MASK	0x1f
+
+/*
+ * DAVINCI_MCASP_ACLKRCTL_REG Receive Clock Control Register Bits
+ */
+#define ACLKRDIV(val)	(val)
+#define ACLKRE		BIT(5)
+#define RX_ASYNC	BIT(6)
+#define ACLKRPOL	BIT(7)
+#define ACLKRDIV_MASK	0x1f
+
+/*
+ * DAVINCI_MCASP_AHCLKXCTL_REG - High Frequency Transmit Clock Control
+ *     Register Bits
+ */
+#define AHCLKXDIV(val)	(val)
+#define AHCLKXPOL	BIT(14)
+#define AHCLKXE		BIT(15)
+#define AHCLKXDIV_MASK	0xfff
+
+/*
+ * DAVINCI_MCASP_AHCLKRCTL_REG - High Frequency Receive Clock Control
+ *     Register Bits
+ */
+#define AHCLKRDIV(val)	(val)
+#define AHCLKRPOL	BIT(14)
+#define AHCLKRE		BIT(15)
+#define AHCLKRDIV_MASK	0xfff
+
+/*
+ * DAVINCI_MCASP_XRSRCTL_BASE_REG -  Serializer Control Register Bits
+ */
+#define MODE(val)	(val)
+#define DISMOD_3STATE	(0x0)
+#define DISMOD_LOW	(0x2 << 2)
+#define DISMOD_HIGH	(0x3 << 2)
+#define DISMOD_VAL(x)	((x) << 2)
+#define DISMOD_MASK	DISMOD_HIGH
+#define TXSTATE		BIT(4)
+#define RXSTATE		BIT(5)
+#define SRMOD_MASK	3
+#define SRMOD_INACTIVE	0
+
+/*
+ * DAVINCI_MCASP_LBCTL_REG - Loop Back Control Register Bits
+ */
+#define LBEN		BIT(0)
+#define LBORD		BIT(1)
+#define LBGENMODE(val)	((val) << 2)
+
+/*
+ * DAVINCI_MCASP_TXTDMSLOT_REG - Transmit TDM Slot Register configuration
+ */
+#define TXTDMS(n)	(1 << (n))
+
+/*
+ * DAVINCI_MCASP_RXTDMSLOT_REG - Receive TDM Slot Register configuration
+ */
+#define RXTDMS(n)	(1 << (n))
+
+/*
+ * DAVINCI_MCASP_GBLCTL_REG -  Global Control Register Bits
+ */
+#define RXCLKRST	BIT(0)	/* Receiver Clock Divider Reset */
+#define RXHCLKRST	BIT(1)	/* Receiver High Frequency Clock Divider */
+#define RXSERCLR	BIT(2)	/* Receiver Serializer Clear */
+#define RXSMRST		BIT(3)	/* Receiver State Machine Reset */
+#define RXFSRST		BIT(4)	/* Frame Sync Generator Reset */
+#define TXCLKRST	BIT(8)	/* Transmitter Clock Divider Reset */
+#define TXHCLKRST	BIT(9)	/* Transmitter High Frequency Clock Divider*/
+#define TXSERCLR	BIT(10)	/* Transmit Serializer Clear */
+#define TXSMRST		BIT(11)	/* Transmitter State Machine Reset */
+#define TXFSRST		BIT(12)	/* Frame Sync Generator Reset */
+
+/*
+ * DAVINCI_MCASP_TXSTAT_REG - Transmitter Status Register Bits
+ * DAVINCI_MCASP_RXSTAT_REG - Receiver Status Register Bits
+ */
+#define XRERR		BIT(8) /* Transmit/Receive error */
+#define XRDATA		BIT(5) /* Transmit/Receive data ready */
+
+/*
+ * DAVINCI_MCASP_AMUTE_REG -  Mute Control Register Bits
+ */
+#define MUTENA(val)	(val)
+#define MUTEINPOL	BIT(2)
+#define MUTEINENA	BIT(3)
+#define MUTEIN		BIT(4)
+#define MUTER		BIT(5)
+#define MUTEX		BIT(6)
+#define MUTEFSR		BIT(7)
+#define MUTEFSX		BIT(8)
+#define MUTEBADCLKR	BIT(9)
+#define MUTEBADCLKX	BIT(10)
+#define MUTERXDMAERR	BIT(11)
+#define MUTETXDMAERR	BIT(12)
+
+/*
+ * DAVINCI_MCASP_REVTCTL_REG - Receiver DMA Event Control Register bits
+ */
+#define RXDATADMADIS	BIT(0)
+
+/*
+ * DAVINCI_MCASP_XEVTCTL_REG - Transmitter DMA Event Control Register bits
+ */
+#define TXDATADMADIS	BIT(0)
+
+/*
+ * DAVINCI_MCASP_EVTCTLR_REG - Receiver Interrupt Control Register Bits
+ */
+#define ROVRN		BIT(0)
+
+/*
+ * DAVINCI_MCASP_EVTCTLX_REG - Transmitter Interrupt Control Register Bits
+ */
+#define XUNDRN		BIT(0)
+
+/*
+ * DAVINCI_MCASP_W[R]FIFOCTL - Write/Read FIFO Control Register bits
+ */
+#define FIFO_ENABLE	BIT(16)
+#define NUMEVT_MASK	(0xFF << 8)
+#define NUMEVT(x)	(((x) & 0xFF) << 8)
+#define NUMDMA_MASK	(0xFF)
+
+/* Source of High-frequency transmit/receive clock */
+#define MCASP_CLK_HCLK_AHCLK		0 /* AHCLKX/R */
+#define MCASP_CLK_HCLK_AUXCLK		1 /* Internal functional clock */
+
+/* clock divider IDs */
+#define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
+#define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
+#define MCASP_CLKDIV_BCLK_FS_RATIO	2 /* to set BCLK FS ration */
+
+#define INACTIVE_MODE	0
+#define TX_MODE		1
+#define RX_MODE		2
+
+#define DAVINCI_MCASP_IIS_MODE	0
+#define DAVINCI_MCASP_DIT_MODE	1
+
+enum {
+	SNDRV_PCM_STREAM_PLAYBACK = 0,
+	SNDRV_PCM_STREAM_CAPTURE,
+	SNDRV_PCM_STREAM_LAST = SNDRV_PCM_STREAM_CAPTURE,
+};
+
+enum {
+	MCASP_VERSION_1 = 0,	/* DM646x */
+	MCASP_VERSION_2,	/* DA8xx/OMAPL1x */
+	MCASP_VERSION_3,        /* TI81xx/AM33xx */
+	MCASP_VERSION_4,	/* DRA7xxx */
+	MCASP_VERSION_OMAP,	/* OMAP4/5 */
+};
+
+/* Some SND defaults */
+
+#define SND_SOC_DAIFMT_FORMAT_MASK		0x000f
+#define SND_SOC_DAIFMT_CLOCK_MASK		0x00f0
+#define SND_SOC_DAIFMT_INV_MASK			0x0f00
+#define SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK	0xf000
+
+#define SND_SOC_DAIFMT_CBP_CFP		BIT(12) /* codec clk provider & frame provider */
+#define SND_SOC_DAIFMT_CBC_CFP		(2 << 12) /* codec clk consumer & frame provider */
+#define SND_SOC_DAIFMT_CBP_CFC		(3 << 12) /* codec clk provider & frame consumer */
+#define SND_SOC_DAIFMT_CBC_CFC		(4 << 12) /* codec clk consumer & frame consumer */
+
+/* when passed to set_fmt directly indicate if the device is provider or consumer */
+#define SND_SOC_DAIFMT_BP_FP		SND_SOC_DAIFMT_CBP_CFP
+#define SND_SOC_DAIFMT_BC_FP		SND_SOC_DAIFMT_CBC_CFP
+#define SND_SOC_DAIFMT_BP_FC		SND_SOC_DAIFMT_CBP_CFC
+#define SND_SOC_DAIFMT_BC_FC		SND_SOC_DAIFMT_CBC_CFC
+
+#define SND_SOC_DAIFMT_NB_NF_UBT		(0 << 8) /* normal bit clock + frame */
+#define SND_SOC_DAIFMT_NB_IF		(2 << 8) /* normal BCLK + inv FRM */
+#define SND_SOC_DAIFMT_IB_NF		(3 << 8) /* invert BCLK + nor FRM */
+#define SND_SOC_DAIFMT_IB_IF		(4 << 8) /* invert BCLK + FRM */
+
+/*
+ * Master Clock Directions
+ */
+#define SND_SOC_CLOCK_IN		0
+#define SND_SOC_CLOCK_OUT		1
+
+typedef int __bitwise snd_pcm_format_t;
+#define	SNDRV_PCM_FORMAT_S8	((snd_pcm_format_t)0)
+#define	SNDRV_PCM_FORMAT_U8	((snd_pcm_format_t)1)
+#define	SNDRV_PCM_FORMAT_S16_LE	((snd_pcm_format_t)2)
+#define	SNDRV_PCM_FORMAT_S16_BE	((snd_pcm_format_t)3)
+#define	SNDRV_PCM_FORMAT_U16_LE	((snd_pcm_format_t)4)
+#define	SNDRV_PCM_FORMAT_U16_BE	((snd_pcm_format_t)5)
+#define	SNDRV_PCM_FORMAT_S24_LE	((snd_pcm_format_t)6) /* low three bytes */
+#define	SNDRV_PCM_FORMAT_S24_BE	((snd_pcm_format_t)7) /* low three bytes */
+#define	SNDRV_PCM_FORMAT_U24_LE	((snd_pcm_format_t)8) /* low three bytes */
+#define	SNDRV_PCM_FORMAT_U24_BE	((snd_pcm_format_t)9) /* low three bytes */
+#define	SNDRV_PCM_FORMAT_S32_LE	((snd_pcm_format_t)10)
+#define	SNDRV_PCM_FORMAT_S32_BE	((snd_pcm_format_t)11)
+#define	SNDRV_PCM_FORMAT_U32_LE	((snd_pcm_format_t)12)
+#define	SNDRV_PCM_FORMAT_U32_BE	((snd_pcm_format_t)13)
+#define	SNDRV_PCM_FORMAT_FLOAT_LE	((snd_pcm_format_t)14)
+#define	SNDRV_PCM_FORMAT_FLOAT_BE	((snd_pcm_format_t)15)
+#define	SNDRV_PCM_FORMAT_FLOAT64_LE	((snd_pcm_format_t)16)
+#define	SNDRV_PCM_FORMAT_FLOAT64_BE	((snd_pcm_format_t)17)
+#define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE ((snd_pcm_format_t)18)
+#define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE ((snd_pcm_format_t)19)
+#define	SNDRV_PCM_FORMAT_MU_LAW		((snd_pcm_format_t)20)
+#define	SNDRV_PCM_FORMAT_A_LAW		((snd_pcm_format_t)21)
+#define	SNDRV_PCM_FORMAT_IMA_ADPCM	((snd_pcm_format_t)22)
+#define	SNDRV_PCM_FORMAT_MPEG		((snd_pcm_format_t)23)
+#define	SNDRV_PCM_FORMAT_GSM		((snd_pcm_format_t)24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((snd_pcm_format_t)25) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE	((snd_pcm_format_t)26) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE	((snd_pcm_format_t)27) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE	((snd_pcm_format_t)28) /* in four bytes, LSB justified */
+/* gap in the numbering for a future standard linear format */
+#define	SNDRV_PCM_FORMAT_SPECIAL	((snd_pcm_format_t)31)
+#define	SNDRV_PCM_FORMAT_S24_3LE	((snd_pcm_format_t)32)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S24_3BE	((snd_pcm_format_t)33)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U24_3LE	((snd_pcm_format_t)34)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U24_3BE	((snd_pcm_format_t)35)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S20_3LE	((snd_pcm_format_t)36)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S20_3BE	((snd_pcm_format_t)37)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U20_3LE	((snd_pcm_format_t)38)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U20_3BE	((snd_pcm_format_t)39)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S18_3LE	((snd_pcm_format_t)40)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_S18_3BE	((snd_pcm_format_t)41)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U18_3LE	((snd_pcm_format_t)42)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_U18_3BE	((snd_pcm_format_t)43)	/* in three bytes */
+#define	SNDRV_PCM_FORMAT_G723_24	((snd_pcm_format_t)44) /* 8 samples in 3 bytes */
+#define	SNDRV_PCM_FORMAT_G723_24_1B	((snd_pcm_format_t)45) /* 1 sample in 1 byte */
+#define	SNDRV_PCM_FORMAT_G723_40	((snd_pcm_format_t)46) /* 8 Samples in 5 bytes */
+#define	SNDRV_PCM_FORMAT_G723_40_1B	((snd_pcm_format_t)47) /* 1 sample in 1 byte */
+#define	SNDRV_PCM_FORMAT_DSD_U8		((snd_pcm_format_t)48) /* DSD, 1-byte samples DSD (x8) */
+#define	SNDRV_PCM_FORMAT_DSD_U16_LE	((snd_pcm_format_t)49)
+#define	SNDRV_PCM_FORMAT_DSD_U32_LE	((snd_pcm_format_t)50)
+#define	SNDRV_PCM_FORMAT_DSD_U16_BE	((snd_pcm_format_t)51)
+#define	SNDRV_PCM_FORMAT_DSD_U32_BE	((snd_pcm_format_t)52)
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
+#define	SNDRV_PCM_FORMAT_FIRST		SNDRV_PCM_FORMAT_S8
+
+#endif	/* DAVINCI_MCASP_H */
diff --git a/drivers/sound/mcasp_i2s.c b/drivers/sound/mcasp_i2s.c
new file mode 100644
index 0000000000..6da4badd9c
--- /dev/null
+++ b/drivers/sound/mcasp_i2s.c
@@ -0,0 +1,1123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Scaria M Kochidanadu, s-kochidanadu@ti.com
+ *
+ * based on the linux MCASP driver, which is
+ *
+ * Author: Nirmal Pandey <n-pandey@ti.com>,
+ *         Suresh Rajashekara <suresh.r@ti.com>
+ *         Steve Chen <schen@.mvista.com>
+ *
+ * Copyright:   (C) 2009 MontaVista Software, Inc., <source@mvista.com>
+ * Copyright:   (C) 2009  Texas Instruments, India
+ */
+
+#include <asm/u-boot.h> /* boot information for Linux kernel */
+/* Pull in stuff for the build system */
+#ifdef DO_DEPS_ONLY
+#include <env_internal.h>
+#endif
+#include <dm.h>
+#include <i2s.h>
+#include <log.h>
+#include <sound.h>
+#include <asm/io.h>
+#include <linux/bitmap.h>
+#include <linux/math64.h>
+#include <linux/ioport.h>
+#include "davinci-mcasp.h"
+
+#define MCASP_MAX_AFIFO_DEPTH  64
+
+struct mcasp_priv {
+	void __iomem *base;
+	u32 fifo_base;
+	struct i2s_uc_priv *pdata;
+	struct udevice *dev;
+	unsigned int dai_fmt;
+	unsigned long dat_port_addr;
+
+	/* McASP specific data */
+	int	tdm_slots;
+	u32	tdm_mask[2];
+	int	slot_width;
+	u8	op_mode;
+	u8	dismod;
+	u8	num_serializer;
+	u32	*serial_dir;
+	u8	version;
+	u8	bclk_div;
+	int	streams;
+
+	int	sysclk_freq;
+	bool	bclk_master;
+
+	unsigned long pdir; /* Pin direction bitfield */
+
+	/* McASP FIFO related */
+	u8	txnumevt;
+	u8	rxnumevt;
+
+	bool	dat_port;
+
+	/* Used for comstraint setting on the second stream */
+	u32	channels;
+	int	max_format_width;
+	u8	active_serializers[2];
+
+	bool missing_audio_param;
+
+};
+
+/* Register Data manipulation Functions */
+
+static inline void set_bit_pdir(int nbit, unsigned long *pdir)
+{
+	*pdir = *pdir | BIT(nbit);
+}
+
+static inline void clear_bit_pdir(int nbit, unsigned long *pdir)
+{
+	*pdir = *pdir & (~BIT(nbit));
+}
+
+static inline void mcasp_set_bits(struct mcasp_priv *mcasp, u32 offset, u32 val)
+{
+	void __iomem *reg = mcasp->base + offset;
+
+	__raw_writel(__raw_readl(reg) | val, reg);
+}
+
+static inline void mcasp_clr_bits(struct mcasp_priv *mcasp, u32 offset,
+				  u32 val)
+{
+	void __iomem *reg = mcasp->base + offset;
+
+	__raw_writel((__raw_readl(reg) & ~(val)), reg);
+}
+
+static inline void mcasp_mod_bits(struct mcasp_priv *mcasp, u32 offset,
+				  u32 val, u32 mask)
+{
+	void __iomem *reg = mcasp->base + offset;
+
+	__raw_writel((__raw_readl(reg) & ~mask) | val, reg);
+}
+
+static inline void mcasp_set_reg(struct mcasp_priv *mcasp, u32 offset,
+				 u32 val)
+{
+	__raw_writel(val, mcasp->base + offset);
+}
+
+static inline u32 mcasp_get_reg(struct mcasp_priv *mcasp, u32 offset)
+{
+	return (u32)__raw_readl(mcasp->base + offset);
+}
+
+static void mcasp_set_ctl_reg(struct mcasp_priv *mcasp, u32 ctl_reg, u32 val)
+{
+	int i = 0;
+
+	mcasp_set_bits(mcasp, ctl_reg, val);
+
+	/* programming GBLCTL needs to read back from GBLCTL and verfiy */
+	/* loop count is to avoid the lock-up */
+	for (i = 0; i < 1000; i++) {
+		if ((mcasp_get_reg(mcasp, ctl_reg) & val) == val)
+			break;
+	}
+
+	if (i == 1000 && ((mcasp_get_reg(mcasp, ctl_reg) & val) != val))
+		printf("GBLCTL write error\n");
+}
+
+/********************************************************************/
+static bool mcasp_is_synchronous(struct mcasp_priv *mcasp)
+{
+	u32 rxfmctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG);
+	u32 aclkxctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG);
+
+	return !(aclkxctl & TX_ASYNC) && rxfmctl & AFSRE;
+}
+
+static inline void mcasp_set_clk_pdir(struct mcasp_priv *mcasp, bool enable)
+{
+	u32 bit = PIN_BIT_AMUTE;
+
+	for_each_set_bit_from(bit, &mcasp->pdir, PIN_BIT_AFSR + 1) {
+		if (enable)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+	}
+}
+
+static inline void mcasp_set_axr_pdir(struct mcasp_priv *mcasp, bool enable)
+{
+	u32 bit;
+
+	for_each_set_bit(bit, &mcasp->pdir, PIN_BIT_AMUTE) {
+		if (enable)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+	}
+}
+
+static int davinci_mcasp_get_config(struct mcasp_priv *mcasp)
+{
+	u32 val;
+
+	if (!dev_read_u32u(mcasp->dev, "op-mode", &val)) {
+		mcasp->op_mode = val;
+	} else {
+		mcasp->missing_audio_param = true;
+		goto out;
+	}
+
+	if (!dev_read_u32u(mcasp->dev, "tdm-slots", &val)) {
+		if (val < 2 || val > 32)
+			debug("tdm-slots must be in range[2-32]\n");
+
+		mcasp->tdm_slots = val;
+	} else if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		mcasp->missing_audio_param = true;
+		goto out;
+	}
+
+	/* In u-boot we do not have DMA => We do not use DAT_port for transfer*/
+	mcasp->dat_port = false;
+	mcasp->dat_port_addr = 0x02b18000;
+
+	/* serial-dir */
+	u32 *of_serial_dir32;
+
+	if (!dev_read_u32_array(mcasp->dev, "serial-dir", of_serial_dir32, 16)) {
+		mcasp->serial_dir = of_serial_dir32;
+		mcasp->num_serializer = 16;
+	} else {
+		printf("error in reading serial-dir from DT\n");
+	}
+
+	if (!dev_read_u32u(mcasp->dev, "tx-num-evt", &val))
+		mcasp->txnumevt = val;
+	else
+		printf("error in reading tx-num-evt\n");
+
+	if (!dev_read_u32u(mcasp->dev, "rx-num-evt", &val))
+		mcasp->rxnumevt = val;
+	else
+		printf("error in reading tx-num-evt\n");
+
+	if (!dev_read_u32u(mcasp->dev, "dismod", &val)) {
+		if (val == 0 || val == 2 || val == 3) {
+			mcasp->dismod = DISMOD_VAL(val);
+		} else {
+			printf("Invalid dismod value: %u\n", val);
+			mcasp->dismod = DISMOD_LOW;
+		}
+	} else {
+		mcasp->dismod = DISMOD_LOW;
+	}
+
+out:
+	if (mcasp->missing_audio_param) {
+		printf("Insufficient DT parameter(s)\n");
+		return -ENODEV;
+	}
+	/* sanity check for tdm slots parameter */
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		if (mcasp->tdm_slots < 2) {
+			printf("invalid tdm slots: %d\n",
+			       mcasp->tdm_slots);
+			mcasp->tdm_slots = 2;
+		} else if (mcasp->tdm_slots > 32) {
+			printf("invalid tdm slots: %d\n",
+			       mcasp->tdm_slots);
+			mcasp->tdm_slots = 32;
+		}
+	} else {
+		mcasp->tdm_slots = 32;
+	}
+	return 0;
+}
+
+static int mcasp_i2s_of_to_plat(struct udevice *dev)
+{
+	struct i2s_uc_priv *priv = dev_get_uclass_priv(dev);
+	ulong base;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE) {
+		debug("%s: Missing  i2s base\n", __func__);
+		return -EINVAL;
+	}
+	priv->base_address = base;
+
+	if (dev_read_u32u(dev, "ti,i2s-epll-clock-frequency",
+			  &priv->audio_pll_clk))
+		goto err;
+	debug("audio_pll_clk = %d\n", priv->audio_pll_clk);
+	if (dev_read_u32u(dev, "ti,i2s-sampling-rate",
+			  &priv->samplingrate))
+		goto err;
+	debug("samplingrate = %d\n", priv->samplingrate);
+	if (dev_read_u32u(dev, "ti,i2s-bits-per-sample",
+			  &priv->bitspersample))
+		goto err;
+	debug("bitspersample = %d\n", priv->bitspersample);
+	if (dev_read_u32u(dev, "ti,i2s-channels", &priv->channels))
+		goto err;
+	debug("channels = %d\n", priv->channels);
+	if (dev_read_u32u(dev, "ti,i2s-lr-clk-framesize", &priv->rfs))
+		goto err;
+	debug("rfs = %d\n", priv->rfs);
+	if (dev_read_u32u(dev, "ti,i2s-bit-clk-framesize", &priv->bfs))
+		goto err;
+	debug("bfs = %d\n", priv->bfs);
+
+	if (dev_read_u32u(dev, "ti,i2s-id", &priv->id))
+		goto err;
+	debug("id = %d\n", priv->id);
+	return 0;
+
+err:
+	debug("fail to get sound i2s node properties\n");
+	return -EINVAL;
+}
+
+static int davinci_mcasp_set_dai_fmt(struct mcasp_priv *mcasp,
+				     unsigned int fmt)
+{
+	int ret = 0;
+	u32 data_delay;
+	bool fs_pol_rising;
+	bool inv_fs = false;
+
+	if (!fmt)
+		return 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		/* 1st data bit occur one ACLK cycle after the frame sync */
+		data_delay = 1;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_AC97:
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		/* No delay after FS */
+		data_delay = 0;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		/* configure a full-word SYNC pulse (LRCLK) */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		/* 1st data bit occur one ACLK cycle after the frame sync */
+		data_delay = 1;
+		/* FS need to be inverted */
+		inv_fs = true;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_LEFT_J:
+		/* configure a full-word SYNC pulse (LRCLK) */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		/* No delay after FS */
+		data_delay = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, FSXDLY(data_delay),
+		       FSXDLY(3));
+	mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, FSRDLY(data_delay),
+		       FSRDLY(3));
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_BP_FP:
+		/* codec is clock and frame slave */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		/* BCLK */
+
+		set_bit_pdir(PIN_BIT_ACLKX, &mcasp->pdir);
+		set_bit_pdir(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		set_bit_pdir(PIN_BIT_AFSX, &mcasp->pdir);
+		set_bit_pdir(PIN_BIT_AFSR, &mcasp->pdir);
+
+		mcasp->bclk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_BP_FC:
+		/* codec is clock slave and frame master */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		/* BCLK */
+		set_bit_pdir(PIN_BIT_ACLKX, &mcasp->pdir);
+		set_bit_pdir(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		clear_bit_pdir(PIN_BIT_AFSX, &mcasp->pdir);
+		clear_bit_pdir(PIN_BIT_AFSR, &mcasp->pdir);
+
+		mcasp->bclk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_BC_FP:
+		/* codec is clock master and frame slave */
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		/* BCLK */
+		clear_bit_pdir(PIN_BIT_ACLKX, &mcasp->pdir);
+		clear_bit_pdir(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		set_bit_pdir(PIN_BIT_AFSX, &mcasp->pdir);
+		set_bit_pdir(PIN_BIT_AFSR, &mcasp->pdir);
+
+		mcasp->bclk_master = 0;
+		break;
+	case SND_SOC_DAIFMT_BC_FC:
+		/* codec is clock and frame master */
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		/* BCLK */
+		clear_bit_pdir(PIN_BIT_ACLKX, &mcasp->pdir);
+		clear_bit_pdir(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		clear_bit_pdir(PIN_BIT_AFSX, &mcasp->pdir);
+		clear_bit_pdir(PIN_BIT_AFSR, &mcasp->pdir);
+
+		mcasp->bclk_master = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		fs_pol_rising = true;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		fs_pol_rising = false;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		fs_pol_rising = false;
+		break;
+	case SND_SOC_DAIFMT_NB_NF_UBT:
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		fs_pol_rising = true;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (inv_fs)
+		fs_pol_rising = !fs_pol_rising;
+
+	if (fs_pol_rising) {
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+	} else {
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+	}
+
+	mcasp->dai_fmt = fmt;
+out:
+	return ret;
+}
+
+static int mcasp_common_hw_param(struct mcasp_priv *mcasp, int stream,
+				 int period_words, int channels)
+{
+	int i;
+	u8 tx_ser = 0;
+	u8 rx_ser = 0;
+	u8 slots = mcasp->tdm_slots;
+	u8 max_active_serializers, max_rx_serializers, max_tx_serializers;
+	int active_serializers, numevt;
+	u32 reg;
+	/* In DIT mode we only allow maximum of one serializers for now */
+	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
+		max_active_serializers = 1;
+	else
+		max_active_serializers = (channels + slots - 1) / slots;
+
+	/* Default configuration */
+	if (mcasp->version < MCASP_VERSION_3)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
+		max_tx_serializers = max_active_serializers;
+		max_rx_serializers =
+		mcasp->active_serializers[SNDRV_PCM_STREAM_CAPTURE];
+	} else {
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_REVTCTL_REG, RXDATADMADIS);
+		max_tx_serializers =
+			mcasp->active_serializers[SNDRV_PCM_STREAM_PLAYBACK];
+		max_rx_serializers = max_active_serializers;
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++) {
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+			       mcasp->serial_dir[i]);
+		if (mcasp->serial_dir[i] == TX_MODE && tx_ser < max_tx_serializers) {
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+				       mcasp->dismod, DISMOD_MASK);
+			set_bit_pdir(PIN_BIT_AXR(i), &mcasp->pdir);
+			tx_ser++;
+		} else if (mcasp->serial_dir[i] == RX_MODE &&
+					rx_ser < max_rx_serializers) {
+			clear_bit_pdir(PIN_BIT_AXR(i), &mcasp->pdir);
+			rx_ser++;
+		} else {
+			/* Inactive or unused pin, set it to inactive */
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+				       SRMOD_INACTIVE, SRMOD_MASK);
+			/* If unused, set DISMOD for the pin */
+			if (mcasp->serial_dir[i] != INACTIVE_MODE)
+				mcasp_mod_bits(mcasp,
+					       DAVINCI_MCASP_XRSRCTL_REG(i),
+					       mcasp->dismod, DISMOD_MASK);
+			clear_bit_pdir(PIN_BIT_AXR(i), &mcasp->pdir);
+		}
+	}
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		active_serializers = tx_ser;
+		numevt = mcasp->txnumevt;
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+	} else {
+		active_serializers = rx_ser;
+		numevt = mcasp->rxnumevt;
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+	}
+
+	if (active_serializers < max_active_serializers) {
+		debug("stream has more channels (%d) than are enabled in mcasp (%d)\n", channels,
+		      active_serializers * slots);
+		return -EINVAL;
+	}
+
+	if (period_words % active_serializers) {
+		debug("Invalid combination of period words and active serializers: %d, %d\n",
+		      period_words, active_serializers);
+		return -EINVAL;
+	}
+
+	/*
+	 * Calculate the optimal AFIFO depth for platform side:
+	 * The number of words for numevt need to be in steps of active
+	 * serializers.
+	 */
+	numevt = (numevt / active_serializers) * active_serializers;
+
+	while (period_words % numevt && numevt > 0)
+		numevt -= active_serializers;
+	if (numevt <= 0)
+		numevt = active_serializers;
+
+	mcasp_mod_bits(mcasp, reg, active_serializers, NUMDMA_MASK);
+	mcasp_mod_bits(mcasp, reg, NUMEVT(numevt), NUMEVT_MASK);
+
+	mcasp->active_serializers[stream] = active_serializers;
+
+	return 0;
+}
+
+static int mcasp_i2s_hw_param(struct mcasp_priv *mcasp, int stream,
+			      int channels)
+{
+	int i, active_slots;
+	int total_slots;
+	int active_serializers;
+	u32 mask = 0;
+	u32 busel = 0;
+
+	total_slots = mcasp->tdm_slots;
+
+	/*
+	 * If more than one serializer is needed, then use them with
+	 * all the specified tdm_slots. Otherwise, one serializer can
+	 * cope with the transaction using just as many slots as there
+	 * are channels in the stream.
+	 */
+	if (mcasp->tdm_mask[stream]) {
+		active_slots = hweight32(mcasp->tdm_mask[stream]);
+		active_serializers = (channels + active_slots - 1) /
+			active_slots;
+		if (active_serializers == 1)
+			active_slots = channels;
+		for (i = 0; i < total_slots; i++) {
+			if ((1 << i) & mcasp->tdm_mask[stream]) {
+				mask |= (1 << i);
+				if (--active_slots <= 0)
+					break;
+			}
+		}
+	} else {
+		active_serializers = (channels + total_slots - 1) / total_slots;
+		if (active_serializers == 1)
+			active_slots = channels;
+		else
+			active_slots = total_slots;
+
+		for (i = 0; i < active_slots; i++)
+			mask |= (1 << i);
+	}
+
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
+
+	if (!mcasp->dat_port)
+		busel = TXSEL;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_TXTDM_REG, mask);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, busel | TXORD);
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
+			       FSXMOD(total_slots), FSXMOD(0x1FF));
+	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_RXTDM_REG, mask);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
+			       FSRMOD(total_slots), FSRMOD(0x1FF));
+		/*
+		 * If McASP is set to be TX/RX synchronous and the playback is
+		 * not running already we need to configure the TX slots in
+		 * order to have correct FSX on the bus
+		 */
+		if (mcasp_is_synchronous(mcasp) && !mcasp->channels)
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
+				       FSXMOD(total_slots), FSXMOD(0x1FF));
+	}
+
+	return 0;
+}
+
+static int davinci_config_channel_size(struct mcasp_priv *mcasp,
+				       int sample_width)
+{
+	u32 fmt;
+	u32 tx_rotate, rx_rotate, slot_width;
+	u32 mask = (1ULL << sample_width) - 1;
+
+	if (mcasp->slot_width)
+		slot_width = mcasp->slot_width;
+	else if (mcasp->max_format_width)
+		slot_width = mcasp->max_format_width;
+	else
+		slot_width = sample_width;
+	/*
+	 * TX rotation:
+	 * right aligned formats: rotate w/ slot_width
+	 * left aligned formats: rotate w/ sample_width
+	 *
+	 * RX rotation:
+	 * right aligned formats: no rotation needed
+	 * left aligned formats: rotate w/ (slot_width - sample_width)
+	 */
+	if ((mcasp->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+	    SND_SOC_DAIFMT_RIGHT_J) {
+		tx_rotate = (slot_width / 4) & 0x7;
+		rx_rotate = 0;
+	} else {
+		tx_rotate = (sample_width / 4) & 0x7;
+		rx_rotate = (slot_width - sample_width) / 4;
+	}
+
+	/* mapping of the XSSZ bit-field as described in the datasheet */
+	fmt = (slot_width >> 1) - 1;
+
+	if (mcasp->op_mode != DAVINCI_MCASP_DIT_MODE) {
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, RXSSZ(fmt),
+			       RXSSZ(0x0F));
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXSSZ(fmt),
+			       TXSSZ(0x0F));
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXROT(tx_rotate),
+			       TXROT(7));
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, RXROT(rx_rotate),
+			       RXROT(7));
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_RXMASK_REG, mask);
+	} else {
+		/*
+		 * according to the TRM it should be TXROT=0, this one works:
+		 * 16 bit to 23-8 (TXROT=6, rotate 24 bits)
+		 * 24 bit to 23-0 (TXROT=0, rotate 0 bits)
+		 *
+		 * TXROT = 0 only works with 24bit samples
+		 */
+		tx_rotate = (sample_width / 4 + 2) & 0x7;
+
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXROT(tx_rotate),
+			       TXROT(7));
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXSSZ(15),
+			       TXSSZ(0x0F));
+	}
+
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXMASK_REG, mask);
+
+	return 0;
+}
+
+static int __davinci_mcasp_set_clkdiv(struct mcasp_priv *mcasp, int div_id,
+				      int div, bool explicit)
+{
+	switch (div_id) {
+	case MCASP_CLKDIV_AUXCLK:			/* MCLK divider */
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+			       AHCLKXDIV(div - 1), AHCLKXDIV_MASK);
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+			       AHCLKRDIV(div - 1), AHCLKRDIV_MASK);
+		break;
+
+	case MCASP_CLKDIV_BCLK:			/* BCLK divider */
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
+			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
+		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG,
+			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
+		if (explicit)
+			mcasp->bclk_div = div;
+		break;
+
+	case MCASP_CLKDIV_BCLK_FS_RATIO:
+		/*
+		 * BCLK/LRCLK ratio descries how many bit-clock cycles
+		 * fit into one frame. The clock ratio is given for a
+		 * full period of data (for I2S format both left and
+		 * right channels), so it has to be divided by number
+		 * of tdm-slots (for I2S - divided by 2).
+		 * Instead of storing this ratio, we calculate a new
+		 * tdm_slot width by dividing the ratio by the
+		 * number of configured tdm slots.
+		 */
+		mcasp->slot_width = div / mcasp->tdm_slots;
+		if (div % mcasp->tdm_slots)
+			debug("%s(): BCLK/LRCLK %d is not divisible by %d tdm slots",
+			      __func__, div, mcasp->tdm_slots);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int davinci_mcasp_calc_clk_div(struct mcasp_priv *mcasp,
+				      unsigned int sysclk_freq,
+				      unsigned int bclk_freq, bool set)
+{
+	u32 reg = mcasp_get_reg(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG);
+	int div = sysclk_freq / bclk_freq;
+	int rem = sysclk_freq % bclk_freq;
+	int error_ppm;
+	int aux_div = 1;
+
+	if (div > (ACLKXDIV_MASK + 1)) {
+		if (reg & AHCLKXE) {
+			aux_div = div / (ACLKXDIV_MASK + 1);
+			if (div % (ACLKXDIV_MASK + 1))
+				aux_div++;
+
+			sysclk_freq /= aux_div;
+			div = sysclk_freq / bclk_freq;
+			rem = sysclk_freq % bclk_freq;
+		} else if (set) {
+			debug("Too fast reference clock (%u)\n",
+			      sysclk_freq);
+		}
+	}
+
+	if (rem != 0) {
+		if (div == 0 ||
+		    ((sysclk_freq / div) - bclk_freq) >
+		    (bclk_freq - (sysclk_freq / (div + 1)))) {
+			div++;
+			rem = rem - bclk_freq;
+		}
+	}
+	error_ppm = (div * 1000000 + (int)div64_long(1000000LL * rem,
+		     (int)bclk_freq)) / div - 1000000;
+
+	if (set) {
+		if (error_ppm)
+			debug("Sample-rate is off by %d PPM\n",
+			      error_ppm);
+
+		__davinci_mcasp_set_clkdiv(mcasp, MCASP_CLKDIV_BCLK, div, 0);
+		if (reg & AHCLKXE)
+			__davinci_mcasp_set_clkdiv(mcasp, MCASP_CLKDIV_AUXCLK,
+						   aux_div, 0);
+	}
+
+	return error_ppm;
+}
+
+static int davinci_mcasp_hw_params(struct mcasp_priv *mcasp)
+{
+	int word_length;
+	int channels = mcasp->pdata->channels;
+	int period_size = 1000;
+	int ret;
+	int params_format = 2;
+
+	switch (params_format) {
+	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_S8:
+		word_length = 8;
+		break;
+
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+		word_length = 16;
+		break;
+
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		word_length = 24;
+		break;
+
+	case SNDRV_PCM_FORMAT_U24_LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+		word_length = 24;
+		break;
+
+	case SNDRV_PCM_FORMAT_U32_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		word_length = 32;
+		break;
+
+	default:
+		debug("davinci-mcasp: unsupported PCM format\n");
+		return -EINVAL;
+	}
+
+	ret = davinci_mcasp_set_dai_fmt(mcasp, mcasp->dai_fmt);
+	if (ret)
+		return ret;
+
+	/*
+	 * If mcasp is BCLK master, and a BCLK divider was not provided by
+	 * the machine driver, we need to calculate the ratio.
+	 */
+	if (mcasp->bclk_master && mcasp->bclk_div == 0 && mcasp->sysclk_freq) {
+		int slots = mcasp->tdm_slots;
+		// int rate = params_rate(params);
+		// int sbits = params_width(params);
+		int rate = mcasp->pdata->samplingrate;
+		int sbits = mcasp->pdata->bitspersample;
+		unsigned int bclk_target;
+
+		if (mcasp->slot_width)
+			sbits = mcasp->slot_width;
+
+		if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE)
+			bclk_target = rate * sbits * slots;
+		else
+			bclk_target = rate * 128;
+
+		davinci_mcasp_calc_clk_div(mcasp, mcasp->sysclk_freq,
+					   bclk_target, true);
+	}
+
+	/* 0 is put in place of stream, because we only support transmission */
+	ret = mcasp_common_hw_param(mcasp, 0,
+				    period_size * channels, channels);
+	if (ret)
+		return ret;
+
+	ret = mcasp_i2s_hw_param(mcasp, 0,
+				 channels);
+
+	if (ret)
+		return ret;
+
+	davinci_config_channel_size(mcasp, word_length);
+
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		mcasp->channels = channels;
+		if (!mcasp->max_format_width)
+			mcasp->max_format_width = word_length;
+	}
+
+	return 0;
+}
+
+static int davinci_mcasp_set_sysclk(struct mcasp_priv *mcasp, int clk_id,
+				    unsigned int freq, int dir)
+{
+	if (dir == SND_SOC_CLOCK_IN) {
+		switch (clk_id) {
+		case MCASP_CLK_HCLK_AHCLK:
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			clear_bit_pdir(PIN_BIT_AHCLKX, &mcasp->pdir);
+			break;
+		case MCASP_CLK_HCLK_AUXCLK:
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			set_bit_pdir(PIN_BIT_AHCLKX, &mcasp->pdir);
+			break;
+		default:
+			debug("Invalid clk id: %d\n", clk_id);
+			goto out;
+		}
+	} else {
+		/* Select AUXCLK as HCLK */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		set_bit_pdir(PIN_BIT_AHCLKX, &mcasp->pdir);
+	}
+	/*
+	 * When AHCLK X/R is selected to be output it means that the HCLK is
+	 * the same clock - coming via AUXCLK.
+	 */
+	mcasp->sysclk_freq = freq;
+out:
+	return 0;
+}
+
+static void mcasp_start_tx(struct mcasp_priv *mcasp)
+{
+	if (mcasp->txnumevt) {	/* enable FIFO */
+		u32 reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+
+		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
+		mcasp_set_bits(mcasp, reg, FIFO_ENABLE);
+	}
+
+	/* Start clocks */
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+	mcasp_set_clk_pdir(mcasp, true);
+
+	// Disabling DMA req
+	mcasp_set_bits(mcasp, DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
+}
+
+static void mcasp_stop_tx(struct mcasp_priv *mcasp)
+{
+	u32 val = 0;
+	/*
+	 * In synchronous mode keep TX clocks running if the capture stream is
+	 * still running.
+	 */
+	if (mcasp_is_synchronous(mcasp) && mcasp->streams)
+		val =  TXHCLKRST | TXCLKRST | TXFSRST;
+	else
+		mcasp_set_clk_pdir(mcasp, false);
+
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, val);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+
+	if (mcasp->txnumevt) {	/* disable FIFO */
+		u32 reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+
+		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
+	}
+
+	mcasp_set_axr_pdir(mcasp, false);
+}
+
+int i2s_transfer_data(struct mcasp_priv *mcasp, void *data, uint data_size)
+{
+	u32 *ptr;
+
+	ptr = data;
+
+	if (data_size < MCASP_MAX_AFIFO_DEPTH) {
+		debug("%s : Invalid data size\n", __func__);
+		return -ENODATA;
+	}
+
+	/* Activate serializer(s) */
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFF);
+
+	int error_cnt = 0;
+stage_A:
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
+
+	//Are serializers active
+	if (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG) & BIT(10))) {
+		debug("%s : serializer not active\n", __func__);
+		return -EINVAL;
+	}
+
+	//is transmit slot 0 active in polling mode
+	if (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_TXTDMSLOT_REG) & BIT(0)))
+		printf("not active in polling mode\n");
+
+	//is XDATA set
+	if (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) & XRDATA)) {
+		printf("XDATA is not 1\n");
+		error_cnt++;
+		if (error_cnt > 10) {
+			debug("%s : XDATA is not set\n", __func__);
+			return -EINVAL;
+		}
+		goto stage_A;
+	}
+
+	//getting the data
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXBUF_REG(0), *ptr++);
+	data_size -= sizeof(*ptr);
+
+	/* wait for XDATA to be cleared */
+	int cnt = 0;
+
+	while ((mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) & XRDATA) &&
+	       (cnt < 100000))
+		cnt++;
+
+	mcasp_set_axr_pdir(mcasp, true);
+
+	/* Release TX state machine */
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTL_REG, TXSMRST);
+	/* Release Frame Sync generator */
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTL_REG, TXFSRST);
+
+	while (data_size > 0) {
+		/*wait for XDATA to be set*/
+		int cnt = 0;
+
+		while (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) & XRDATA) && cnt < 1000000)
+			cnt++;
+
+		for (int i = 0, j = 0;
+		     i < mcasp->num_serializer && j < mcasp->active_serializers[0]; i++) {
+			if ((mcasp_get_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i)) & BIT(4)) &&
+			    (mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) & BIT(5))) {
+				mcasp_set_reg(mcasp, DAVINCI_MCASP_TXBUF_REG(i), *ptr++);
+				data_size -= sizeof(*ptr);
+				j++;
+			}
+		}
+
+		if ((mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) & BIT(0))) {
+			debug("Underrun fault has occurred\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int mcasp_i2s_tx_data(struct udevice *dev, void *data, uint data_size)
+{
+	struct mcasp_priv *mcasp = dev_get_priv(dev);
+
+	mcasp_start_tx(mcasp);
+
+	/*sound play*/
+
+	int ret = i2s_transfer_data(mcasp, data, data_size);
+
+	if (ret)
+		printf("no audio playback");
+
+	mcasp_stop_tx(mcasp);
+
+	return 0;
+}
+
+static int mcasp_i2s_probe(struct udevice *dev)
+{
+	struct i2s_uc_priv *priv = dev_get_uclass_priv(dev);
+	struct mcasp_priv *mcasp = dev_get_priv(dev);
+	int ret;
+
+	mcasp->dev = dev;
+	mcasp->pdata = priv;
+	mcasp->base = dev_remap_addr_name(dev, "mpu");
+	mcasp->version = MCASP_VERSION_3;
+	ret = davinci_mcasp_get_config(mcasp);
+	if (ret) {
+		printf("error in get_config\n");
+		goto err;
+	}
+	/* All pins as McASP*/
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+
+	//FIFO base address
+	mcasp->fifo_base = DAVINCI_MCASP_V3_AFIFO_BASE;
+
+	ret = davinci_mcasp_set_sysclk(mcasp, priv->id, priv->audio_pll_clk, SND_SOC_CLOCK_IN);
+	if (ret) {
+		printf("error in set_sysclk\n");
+		goto err;
+	}
+	int fmt = SND_SOC_DAIFMT_BC_FC | SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
+
+	ret = davinci_mcasp_set_dai_fmt(mcasp, fmt);
+	if  (ret) {
+		printf("error in set_dai_fmt\n");
+		goto err;
+	}
+
+	ret = davinci_mcasp_hw_params(mcasp);
+	if (ret) {
+		printf("error in hw_params\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	printf("error in probe\n");
+	return ret;
+}
+
+static const struct i2s_ops mcasp_i2s_ops = {
+	.tx_data	= mcasp_i2s_tx_data,
+};
+
+static const struct udevice_id mcasp_i2s_ids[] = {
+	{ .compatible = "ti,am33xx-mcasp-audio" },
+	{ }
+};
+
+U_BOOT_DRIVER(mcasp_i2s) = {
+	.name		= "mcasp_i2s",
+	.id		= UCLASS_I2S,
+	.of_match	= mcasp_i2s_ids,
+	.probe		= mcasp_i2s_probe,
+	.of_to_plat	= mcasp_i2s_of_to_plat,
+	.ops		= &mcasp_i2s_ops,
+	.priv_auto	= sizeof(struct mcasp_priv)
+};
-- 
2.34.1

