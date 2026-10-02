Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C4CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EA481192;
	Fri,  2 Oct 2026 16:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 71MBZ2vQIrqq; Fri,  2 Oct 2026 16:47:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A937A8122B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959656;
	b=BXiG3b/xepcncgn1w+9cWGra6XDtREIUX6ajf7uprqLG4UhKcPfWNn0pkl0PWKoDmhks
	 gSfD+AGW4+BzzJP/PkB2h8fnBwqEpO37nQxWRJpPLDK2jNIZ655PJFEVFB39WNk95jVNF
	 Gm9Vuo9Rt1hYJxGL5di/pVwQNzwSwUudVGg8rZti007E2yTBslpmeJiu6YoT8k44vQ5Jf
	 wrsacf7fE6jnIDkuWs7xZfZ4qk12j/VHpPrucSXLj8x6jqhH4l0NsVQNFTPcL1EyP+LhE
	 hoKmmsfFKzZ46JTSyUcOhYYPRcbG/2ev9rIC5Lo6/ocrF4fXHk5zJO/BaaUawZ+ybhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I1CaDmcOjJA0yD8cP/aEyg/0SPrduKDWWlpnG2hO1Nw=;
	b=a0SK+khNxvFPcL02u4o4I+mmziXq4SOyTYIRS9Wl/OH5p2RYK67Hyyk38QGQofpRMg/P
	 om8BgHif0ewBoajhpmWTr7KXJzQ8dnk4VRy2XPnar4qkkTNBiYXzYk97qWPD/xlZorhJ1
	 w1S9rb6tboC0VNnczuex3Yuge/5Fg6eKWT4rDEvqACaOnFFxUyPwH2caEgppQoy+zmbqQ
	 6LmnEFmfusk0dyT2UBVuQC2VREFyrjGJWybIMhJJCTMzlisVU0evE1q7A0W/KUgpbylBd
	 q8/qirLiAcwjN7bLmaZehBE6maCczWKDSramv2QCUcFfiv/0WE9wFTiCawryKteyJKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CihynBB3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959656;
	bh=I1CaDmcOjJA0yD8cP/aEyg/0SPrduKDWWlpnG2hO1Nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yirFiiyg2rXrHbfh8wpWo1dL2h1wNOAQMCPsBw6hNrN/zZtjd6QlK+gnb/oZq+ERh
	 FXFGAYeAj711W+xsjj+LXlfXTsHnrgNWsD1wj3DW+hTPWEcfuFowMxVBUJanxSGbgN
	 1j9mXsQze2gZVMo+1v0m1zs8VsmxhWlK4XoRzJZ2CVTBRi5LpXq7I4unsU3a6Ww3pb
	 ot7tbPW9lUsradIQFRfckO8gZ9hB93ODkS23J3OCjDbIcLb6khnq38Yp63z+SJ6POb
	 yzOysjb3kU5vfqJNDhTAg2t40hroIin14JPx+Z/xdbc/c9lJPbZUUGb4AM7T2lpVDT
	 RUBSK6XPkneSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A937A8122B;
	Fri,  2 Oct 2026 16:47:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9F914C2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC347812AB
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PsvoxvTCXkE5 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5185C81291
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946865;
 b=nqxuntUK/luI+Xmc6DrYaSIngCg63XGRLAQ0UwvlSl4EauOL9ujlMhPIVN8rElF+lloX
 hGmpdH1iFBsUWhq9UQqVhjnczAiDVX2+3Tfnwpw2VRRqdD5OnmoH6pHJ/wssU37Dlescr
 qUW8oHuKlQL01UhXnzfKHBiBTvO9WFjsYiTZ9WHGHCjYemquHxmDW/JIlzEr9bCBAut6I
 6L+jJg9JBWptrxs5ptuhZh0apgT6awWVS/aiDUkUY6/8A7AJxbUtZ/tR1PLrtkgp8TQhl
 6MdeVDZ8lYTN7J/Wimfy2iQ6PZHFMUAOqJ3owzw1yYqsFoypdj6eBZhia/n8zjHIRHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946865;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=I1CaDmcOjJA0yD8cP/aEyg/0SPrduKDWWlpnG2hO1Nw=;
 b=FMytmKQFR268dCMUOdLs9f2rwRGDPEi/6ZSNQFZH1ztCpBZm3UvTDVxTbHAGEB2140BU
 tjCYnaqqZa4pP6sN0pz8cZMNbM4ee2FXIFmZV+1av6TbMwh9nNbtN1SdoyWMMSokq9e14
 77b0YgdtCxOEqzd3gPxV7DFBwkG8C4Djp96UioIA2pW7uL80rFDCrTHrCqKP2DIiBO8qZ
 p563v5e8XEeTdpLGrmybsrc1fVlMuZBiBHwwa+ido31/71WWpOygoW+lZ/lrKlPCS+GTC
 gIaLOu9mCxC6Hrlrc7uoTdLf+/zw47V521v7fXD6ggTM6llIJhq1UGOVCOUQI5u5UMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=CihynBB3; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=CihynBB3
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5185C81291
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2ABF04E41114;
 Fri,  2 Oct 2026 13:14:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EF7AA603DC;
 Fri,  2 Oct 2026 13:14:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E301F103281F4; 
 Fri,  2 Oct 2026 15:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946860; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=I1CaDmcOjJA0yD8cP/aEyg/0SPrduKDWWlpnG2hO1Nw=;
 b=CihynBB3lPZqnPd45KnHLKYhPYFRjheiwFXYawhqCdOMWEIPml7O5ld6xomZC1pgNKaRGX
 EUHZMR/IXp+GhBKCI2WkBGqY2UME/pAYvEFwenq7dsOSOJW6FCKKq6iwYgv6slJTxt2RtV
 M0moLJFljZVTAC2cA3RQoVzevczye8lPIwu6DAJ9I7KrPWIAQvDbFOQ5yBZitu67gSQ0CH
 zzsPgoqpbZA5BC55X9Kq21toFzDhS6tIkHVBVq1IrBYfj55dYEJz6MMjQKJ6YnVIwlvQ62
 krJD2RFqz3TJcFEHlzijWvAe0lvM7OFtcndV+jDT5gIWbK1q1NbD/y2uI2cH0A==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:24 +0200
Subject: [PATCH 06/10] mmc: metanoia_sdhci: Add SDHCI driver for Metanoia
 MT2824 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-6-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add an SDHCI driver for the DesignWare Mobile Storage Host Controller
(DWC MSHC) integrated in the Metanoia MT2824 SoC. It supports eMMC up to
HS400/HS400ES and SD cards, and implements the MMC driver model.

The controller is a DWC MSHC instance, but its PHY programming,
voltage/speed-mode handling and tuning model are silicon-specific
and differ from the existing DWC MSHC drivers.

The PHY pad drive strength, receiver select and weak-pull settings
depend on the card type (eMMC vs SD) and are re-applied on every ios,
whereas snps_sdhci.c uses fixed pad values.

High-speed modes force 1.8V signalling and HS400 uses an explicit PHY
DLL lock sequence (set_control_reg()/set_ios_post()), which snps_sdhci.c
does not implement.

Tuning relies on the generic SDHCI core tuner, whereas snps_sdhci.c uses
the hardware auto-tuning block.

Keeping a dedicated driver avoids per-variant branches in the shared
DWC MSHC drivers, matching how snps_sdhci.c, adi_sdhci.c and
cv1800b_sdhci.c are already split in U-Boot.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/Kconfig          |  11 +
 drivers/mmc/Makefile         |   1 +
 drivers/mmc/metanoia_sdhci.c | 494 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 506 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f9f7aa5cf97..b4ac68c04c3 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -654,6 +654,17 @@ config MMC_SDHCI_F_SDH30
 	  If you have a controller with this interface, say Y here.
 	  If unsure, say N.
 
+config MMC_SDHCI_METANOIA
+	bool "SDHCI support for Metanoia MT2824 SoC"
+	depends on MMC_SDHCI
+	depends on OF_CONTROL
+	help
+	  Support for SDHCI host controller on Metanoia MT2824 SoC platform.
+
+	  If you have a controller with this interface, say Y here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_MSM
 	bool "Qualcomm SDHCI controller"
 	depends on MMC_SDHCI && ARCH_SNAPDRAGON
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index a23336d7d8d..f9e60370dd2 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence6.o
 obj-$(CONFIG_MMC_SDHCI_CV1800B)		+= cv1800b_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_AM654)		+= am654_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= iproc_sdhci.o
+obj-$(CONFIG_MMC_SDHCI_METANOIA)	+= metanoia_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= msm_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MV)		+= mv_sdhci.o
 obj-$(CONFIG_MMC_SDHCI_NPCM)            += npcm_sdhci.o
diff --git a/drivers/mmc/metanoia_sdhci.c b/drivers/mmc/metanoia_sdhci.c
new file mode 100644
index 00000000000..e109eebd0db
--- /dev/null
+++ b/drivers/mmc/metanoia_sdhci.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ * Wilson Kang, Metanoia Communications Inc. <wilson.kang@metanoia-comm.com>
+ */
+
+#include <config.h>
+#include <clk.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/sizes.h>
+#include <sdhci.h>
+
+#define DWCMSHC_CTRL_HS400 0x7
+#define EMMC_MIN_FREQ 400000
+
+/* PHY register area pointer */
+#define DWC_MSHC_PHY_REGS 0x300
+
+#define DWC_MSHC_PHY_CNFG_REG (DWC_MSHC_PHY_REGS + 0x00)
+#define PHY_CNFG_RSTN_DEASSERT 0x1 /* Deassert PHY reset */
+#define PHY_PAD_SN_MASK GENMASK(23, 20)
+#define PHY_PAD_SN_SD 0x8
+#define PHY_PAD_SN_EMMC 0x8
+#define PHY_PAD_SP_MASK GENMASK(19, 16)
+#define PHY_PAD_SP_SD 0x9
+#define PHY_PAD_SP_EMMC 0x8
+#define PHY_PWRGOOD BIT(1)
+#define PHY_RSTN BIT(0)
+
+#define PHY_CMDPAD_CNFG_REG (DWC_MSHC_PHY_REGS + 0x04)
+#define PHY_DATPAD_CNFG_REG (DWC_MSHC_PHY_REGS + 0x06)
+#define PHY_CLKPAD_CNFG_REG (DWC_MSHC_PHY_REGS + 0x08)
+#define PHY_STBPAD_CNFG_REG (DWC_MSHC_PHY_REGS + 0x0a)
+#define PHY_RSTNPAD_CNFG_REG (DWC_MSHC_PHY_REGS + 0x0c)
+#define PHY_SMPLDL_CNFG_REG (DWC_MSHC_PHY_REGS + 0x20)
+#define PHY_ATDL_CNFG_REG (DWC_MSHC_PHY_REGS + 0x21)
+#define PHY_DLL_CTRL_REG (DWC_MSHC_PHY_REGS + 0x24)
+#define PHY_DLL_CNFG1_REG (DWC_MSHC_PHY_REGS + 0x25)
+#define PHY_DLLDL_CNFG_REG (DWC_MSHC_PHY_REGS + 0x28)
+#define PHY_DLL_STATUS_REG (DWC_MSHC_PHY_REGS + 0x2e)
+
+#define PHY_RXSEL_MASK GENMASK(2, 0)
+#define PHY_RXSEL_180V 0x01
+#define PHY_RXSEL_330V 0x02
+
+#define PHY_TXSLEW_CTRL_N_MASK GENMASK(12, 9)
+#define PHY_TXSLEW_CTRL_N_EMMC 0x2
+#define PHY_TXSLEW_CTRL_N_SD 0x1
+#define PHY_TXSLEW_CTRL_P_MASK GENMASK(8, 5)
+#define PHY_TXSLEW_CTRL_P_EMMC 0x2
+#define PHY_TXSLEW_CTRL_P_SD 0x1
+#define PHY_TXSLEW_CTRL_P_DS 0x3
+
+#define PHY_WEAKPULL_EN_PULLUP 0x08
+#define PHY_WEAKPULL_EN_PULLDOWN 0x10
+
+/* Vendor specific Registers */
+#define VENDOR_SPECIFIC_AREA_BASE 0x500
+
+#define DWCMSHC_HOST_CTRL3_REG (VENDOR_SPECIFIC_AREA_BASE + 0x08)
+#define DWCMSHC_CMD_CONFLICT_CHECK BIT(0)
+#define DWCMSHC_NEGEDGE_DATAOUT_EN BIT(1)
+#define NEDGE_SMPL_EN BIT(7)
+
+#define DWCMSHC_EMMC_CTRL_REG (VENDOR_SPECIFIC_AREA_BASE + 0x2c)
+#define ENH_STROBE_ENABLE BIT(8)
+#define CARD_IS_EMMC BIT(0)
+
+#define DWCMSHC_AT_CTRL_REG (VENDOR_SPECIFIC_AREA_BASE + 0x40)
+#define TUNE_CLK_STOP_EN BIT(16)
+
+static inline int metanoia_boundary_ok(dma_addr_t addr, int len)
+{
+	return ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)));
+}
+
+struct metanoia_sdhc_plat {
+	struct mmc_config cfg;
+	struct mmc mmc;
+};
+
+struct metanoia_sdhc {
+	struct sdhci_host host;
+};
+
+static void metanoia_sdhci_sw_reset(struct sdhci_host *host, u8 mask)
+{
+	u8 val;
+	int retries = 100;
+
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+	do {
+		udelay(1000);
+		val = sdhci_readb(host, SDHCI_SOFTWARE_RESET);
+		if (!(val & mask))
+			break;
+	} while (--retries > 0);
+
+	if (retries <= 0)
+		pr_warn("%s: Reset 0x%x never completed.\n", __func__,
+			(int)mask);
+}
+
+static bool metanoia_sdhci_is_emmc(struct mmc *mmc)
+{
+	u32 bus_width;
+
+	if (IS_MMC(mmc))
+		return true;
+	if (IS_SD(mmc))
+		return false;
+
+	/*
+	 * Card type may be unknown early (before op-cond completes). Fall back
+	 * to board description (e.g. non-removable in DT -> eMMC).
+	 */
+	if (mmc->dev) {
+		bus_width = dev_read_u32_default(mmc->dev, "bus-width", 0);
+		if (bus_width == 8)
+			return true;
+		if (dev_read_bool(mmc->dev, "non-removable"))
+			return true;
+	}
+
+	return false;
+}
+
+void metanoia_sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+				    dma_addr_t addr, int len, bool end)
+{
+	int tmplen, offset;
+
+	if (likely(!len || metanoia_boundary_ok(addr, len))) {
+		sdhci_adma_write_desc(host, desc, addr, len, end);
+		return;
+	}
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	sdhci_adma_write_desc(host, desc, addr, tmplen, false);
+
+	addr += tmplen;
+	len -= tmplen;
+	sdhci_adma_write_desc(host, desc, addr, len, end);
+}
+
+static int metanoia_sdhci_of_to_plat(struct udevice *dev)
+{
+	struct metanoia_sdhc_plat *plat = dev_get_plat(dev);
+	struct sdhci_host *host = dev_get_priv(dev);
+	struct mmc_config *cfg = &plat->cfg;
+	int ret;
+
+	host->name = dev->name;
+	host->ioaddr = dev_read_addr_ptr(dev);
+	ret = mmc_of_parse(dev, cfg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int metanoia_sdhci_bind(struct udevice *dev)
+{
+	struct metanoia_sdhc_plat *plat = dev_get_plat(dev);
+
+	return sdhci_bind(dev, &plat->mmc, &plat->cfg);
+}
+
+static void metanoia_emmc_phy_pad_cfg(struct sdhci_host *host, bool is_emmc)
+{
+	u16 val;
+	u16 txslew_n = 0;
+	u16 txslew_p = 0;
+	u16 rx_sel = PHY_RXSEL_330V;
+
+	if (host->mmc->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+		rx_sel = PHY_RXSEL_180V;
+
+	if (is_emmc) {
+		txslew_n = PHY_TXSLEW_CTRL_N_EMMC;
+		txslew_p = PHY_TXSLEW_CTRL_P_EMMC;
+	} else {
+		txslew_n = PHY_TXSLEW_CTRL_N_SD;
+		txslew_p = PHY_TXSLEW_CTRL_P_SD;
+	}
+
+	val = PHY_WEAKPULL_EN_PULLUP;
+	val |= FIELD_PREP(PHY_TXSLEW_CTRL_N_MASK, txslew_n);
+	val |= FIELD_PREP(PHY_TXSLEW_CTRL_P_MASK, txslew_p);
+	val |= FIELD_PREP(PHY_RXSEL_MASK, rx_sel);
+
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_REG);
+	sdhci_writew(host, val, PHY_DATPAD_CNFG_REG);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_REG);
+
+	val = FIELD_PREP(PHY_TXSLEW_CTRL_N_MASK, txslew_n);
+	val |= FIELD_PREP(PHY_TXSLEW_CTRL_P_MASK, txslew_p);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_REG);
+
+	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
+		val = PHY_WEAKPULL_EN_PULLDOWN;
+		val |= FIELD_PREP(PHY_TXSLEW_CTRL_N_MASK, PHY_TXSLEW_CTRL_N_SD);
+		val |= FIELD_PREP(PHY_TXSLEW_CTRL_P_MASK, PHY_TXSLEW_CTRL_P_DS);
+		val |= FIELD_PREP(PHY_RXSEL_MASK, PHY_RXSEL_180V);
+		sdhci_writew(host, val, PHY_STBPAD_CNFG_REG);
+	}
+}
+
+static void metanoia_emmc_phy_dl_cfg(struct sdhci_host *host)
+{
+	sdhci_writeb(host, 0x0C, PHY_SMPLDL_CNFG_REG);
+	sdhci_writeb(host, 0x0C, PHY_ATDL_CNFG_REG);
+}
+
+static void metanoia_sdhci_apply_phy_type(struct sdhci_host *host, bool is_emmc)
+{
+	u32 val;
+
+	u32 phy_pad_sn = is_emmc ? PHY_PAD_SN_EMMC : PHY_PAD_SN_SD;
+	u32 phy_pad_sp = is_emmc ? PHY_PAD_SP_EMMC : PHY_PAD_SP_SD;
+
+	val = sdhci_readl(host, DWC_MSHC_PHY_CNFG_REG);
+	val &= ~(PHY_PAD_SN_MASK | PHY_PAD_SP_MASK);
+	val |= FIELD_PREP(PHY_PAD_SN_MASK, phy_pad_sn);
+	val |= FIELD_PREP(PHY_PAD_SP_MASK, phy_pad_sp);
+	sdhci_writel(host, val, DWC_MSHC_PHY_CNFG_REG);
+
+	metanoia_emmc_phy_pad_cfg(host, is_emmc);
+}
+
+static void metanoia_sdhci_apply_hs400_phy(struct sdhci_host *host)
+{
+	u16 clk;
+	u8 val;
+	int retries = 10;
+
+	/* configure DLL as user guide suggest */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	sdhci_writeb(host, 0x20, PHY_DLL_CNFG1_REG);
+	sdhci_writeb(host, 0x60, PHY_DLLDL_CNFG_REG);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	udelay(10);
+
+	sdhci_writeb(host, 0x1, PHY_DLL_CTRL_REG);
+
+	do {
+		udelay(1);
+		val = sdhci_readb(host, PHY_DLL_STATUS_REG);
+		if ((val & 0x1) == 0x1)
+			break;
+	} while (--retries);
+
+	if (!retries)
+		pr_err("eMMC dll has not locked\n");
+
+	val = sdhci_readb(host, PHY_DLL_STATUS_REG);
+	if (val & 0x2)
+		pr_err("eMMC dll has locked and has errors\n");
+
+	metanoia_sdhci_sw_reset(host, 0x3 << 1);
+}
+
+static int metanoia_sdhci_phy_init(struct sdhci_host *host)
+{
+	u32 val;
+	int ret;
+
+	/* Wait powergood before deassert phy reset */
+	ret = readl_poll_timeout(host->ioaddr + DWC_MSHC_PHY_CNFG_REG, val,
+				 val & PHY_PWRGOOD, 20000);
+	if (ret) {
+		pr_warn("%s: Internal clock never stabilised.\n", __func__);
+		return ret;
+	}
+
+	val = sdhci_readl(host, DWC_MSHC_PHY_CNFG_REG);
+	if (!(val & PHY_RSTN)) {
+		val |= PHY_RSTN;
+		sdhci_writel(host, val, DWC_MSHC_PHY_CNFG_REG);
+	}
+
+	/* Set TUNE_CLK_STOP_EN to prevent glitching */
+	val = sdhci_readl(host, DWCMSHC_AT_CTRL_REG);
+	val |= TUNE_CLK_STOP_EN;
+	sdhci_writel(host, val, DWCMSHC_AT_CTRL_REG);
+
+	return 0;
+}
+
+static int metanoia_sdhci_apply_phy(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	bool is_emmc = metanoia_sdhci_is_emmc(mmc);
+	bool is_hs400 = is_emmc && (mmc->selected_mode == MMC_HS_400 ||
+				    mmc->selected_mode == MMC_HS_400_ES);
+	u32 emmc_ctrl;
+	int ret;
+
+	metanoia_emmc_phy_dl_cfg(host);
+	metanoia_sdhci_apply_phy_type(host, is_emmc);
+
+	emmc_ctrl = sdhci_readl(host, DWCMSHC_EMMC_CTRL_REG);
+	if (is_emmc)
+		emmc_ctrl |= CARD_IS_EMMC;
+	else
+		emmc_ctrl &= ~CARD_IS_EMMC;
+	sdhci_writel(host, emmc_ctrl, DWCMSHC_EMMC_CTRL_REG);
+
+	/*
+	 * PHY pad/voltage settings are programmed above based on the current
+	 * ios. Ensure the PHY is out of reset afterwards; otherwise voltage
+	 * switching (e.g. SD 3.3V -> 1.8V) can fail.
+	 */
+	ret = metanoia_sdhci_phy_init(host);
+	if (ret)
+		return ret;
+
+	if (is_hs400)
+		metanoia_sdhci_apply_hs400_phy(host);
+
+	return 0;
+}
+
+static int metanoia_sdhci_set_ios_post(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 reg;
+	int ret;
+
+	/* Disable cmd conflict check, especially for clk 200MHz */
+	reg = sdhci_readb(host, DWCMSHC_HOST_CTRL3_REG);
+	reg &= ~DWCMSHC_CMD_CONFLICT_CHECK;
+	if (host->mmc->ddr_mode && (mmc->selected_mode == MMC_DDR_52 ||
+				    mmc->selected_mode == UHS_DDR50)) {
+		/*
+		 * Databook claims this bit only for HS400, however, it does
+		 * not work on real silicon.
+		 */
+		reg |= DWCMSHC_NEGEDGE_DATAOUT_EN;
+	} else {
+		reg &= ~DWCMSHC_NEGEDGE_DATAOUT_EN;
+	}
+
+	if (mmc->selected_mode == MMC_HS_400 ||
+	    mmc->selected_mode == MMC_HS_400_ES) {
+		/* Samples CMD/DATA with respect to negative edge of cclk_rx */
+		reg |= NEDGE_SMPL_EN;
+	} else {
+		reg &= ~NEDGE_SMPL_EN;
+	}
+
+	sdhci_writeb(host, reg, DWCMSHC_HOST_CTRL3_REG);
+
+	ret = metanoia_sdhci_apply_phy(host);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int metanoia_sdhci_set_enhanced_strobe(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 val;
+
+	val = sdhci_readl(host, DWCMSHC_EMMC_CTRL_REG);
+	if (mmc->selected_mode == MMC_HS_400_ES)
+		val |= ENH_STROBE_ENABLE;
+	else
+		val &= ~ENH_STROBE_ENABLE;
+	sdhci_writel(host, val, DWCMSHC_EMMC_CTRL_REG);
+
+	return 0;
+}
+
+static void metanoia_sdhci_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	u32 val;
+
+	if (mmc->selected_mode == MMC_HS || mmc->selected_mode == MMC_HS_52) {
+		pr_debug("force 1.8v for MMC\n");
+		mmc->signal_voltage = MMC_SIGNAL_VOLTAGE_180;
+	}
+
+	sdhci_set_control_reg(host);
+
+	if (mmc->selected_mode == MMC_HS_400 ||
+	    mmc->selected_mode == MMC_HS_400_ES) {
+		val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		val &= ~SDHCI_CTRL_UHS_MASK;
+		val |= DWCMSHC_CTRL_HS400;
+		sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+	}
+
+	/*
+	 * Reinitializing the device tries to set it to lower-speed modes
+	 * first, which fails if the Enhanced Strobe bit is set, making
+	 * the device impossible to use. Set the correct value here to
+	 * let reinitialization attempts succeed.
+	 */
+	if (CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT))
+		metanoia_sdhci_set_enhanced_strobe(host);
+}
+
+static const struct sdhci_ops metanoia_sdhci_ops = {
+	.set_ios_post = metanoia_sdhci_set_ios_post,
+	.set_control_reg = metanoia_sdhci_set_control_reg,
+	.set_enhanced_strobe = metanoia_sdhci_set_enhanced_strobe,
+#if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA_HELPERS)
+	.adma_write_desc = metanoia_sdhci_adma_write_desc,
+#endif
+};
+
+static int metanoia_sdhci_probe(struct udevice *dev)
+{
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
+	struct metanoia_sdhc_plat *plat = dev_get_plat(dev);
+	struct metanoia_sdhc *priv = dev_get_priv(dev);
+	struct mmc_config *cfg = &plat->cfg;
+	struct sdhci_host *host = &priv->host;
+	struct clk clk = {};
+	ulong clk_rate = 0;
+	int ret;
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (!ret) {
+		clk_rate = clk_get_rate(&clk);
+		if (IS_ERR_VALUE(clk_rate))
+			clk_rate = 0;
+	}
+
+	if (!clk_rate) {
+		u32 max_freq;
+
+		dev_read_u32(dev, "max-frequency", &max_freq);
+		clk_rate = max_freq;
+	}
+
+	if (clk_rate) {
+		host->max_clk = clk_rate;
+		if (!cfg->f_max || cfg->f_max > clk_rate)
+			cfg->f_max = clk_rate;
+	} else {
+		host->max_clk = cfg->f_max;
+	}
+
+	host->ops = &metanoia_sdhci_ops;
+	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_USE_WIDE8;
+	host->mmc = &plat->mmc;
+	host->mmc->priv = &priv->host;
+	host->mmc->dev = dev;
+	upriv->mmc = host->mmc;
+
+	ret = metanoia_sdhci_apply_phy(host);
+	if (ret)
+		return ret;
+
+	ret = sdhci_setup_cfg(cfg, host, cfg->f_max, EMMC_MIN_FREQ);
+	if (ret)
+		return ret;
+
+	cfg->host_caps |= MMC_MODE_8BIT | MMC_CAP(MMC_DDR_52);
+
+	return sdhci_probe(dev);
+}
+
+static const struct udevice_id metanoia_sdhci_ids[] = {
+	{ .compatible = "metanoia,mt2824-dwcmshc" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(metanoia_sdhci_drv) = {
+	.name = "metanoia_sdhci",
+	.id = UCLASS_MMC,
+	.of_match = metanoia_sdhci_ids,
+	.of_to_plat = metanoia_sdhci_of_to_plat,
+	.ops = &sdhci_ops,
+	.bind = metanoia_sdhci_bind,
+	.probe = metanoia_sdhci_probe,
+	.priv_auto = sizeof(struct metanoia_sdhc),
+	.plat_auto = sizeof(struct metanoia_sdhc_plat),
+};

-- 
2.55.0

