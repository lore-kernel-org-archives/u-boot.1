Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9411C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F7C88887;
	Wed, 22 May 2024 16:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+mlPwF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A1C88849; Wed, 22 May 2024 16:23:43 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAE888464
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44d2b3130so2444568b3a.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716387814; x=1716992614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCHJzjZTVEdVmLzWXDQP5y0T573oamjL1g1qiCZzctA=;
 b=O+mlPwF0IUzUohmPvdAB9d6pbjgpLBAUdQ+hy/mu886uE7xwAm5XHRnbX4SnI91vTZ
 SPxMdPefMoLHSGQnAnQO/j/gnNT78/rvH0ZTlkVuostX7JM9kgcWXmGnG4V5iEnavqNB
 gGm22KbjLH7zV1DCyvW49x1vKtWVz0zkBnmOpyIyYQt0/tLFRK7Tw4RV2wJdmclo1W/O
 ydMe/yluJ17M8nrBOxmQiaG3S6l63mdx5aC99lPa/GhFIgoz3HlckGhgin7KisB0okPI
 SvNq9WRIzQwrmehbKDiHXsXJKt/FC2kRgJQUpuYsbg0hyudI7tq8G5qWYzNhfNw/t/ba
 BjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387814; x=1716992614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qCHJzjZTVEdVmLzWXDQP5y0T573oamjL1g1qiCZzctA=;
 b=W8WEKVl0kAGjtb/IpySM1VGnqortLtHv0tjhiBLbUgH8elQZMKKHBoJU4ASFmTuBV+
 odBzpNjTOJW9rD4L+E5Hpxh2BThjOmyU3Ua8MIpew+dwVS6+ua8sVvH74cdt71yqiJ74
 PKywrWAw6zDmXqRxxbCA3gRvjYgN9PhrLTkesBHp6TK2niVOy5/SE/Lr/zq/ttx3LAUD
 v+kjvBMzKA6c9daV3Fyy1SBXvvfLfIeV2joPDgsMO57oA43Ad7Mu+gbnJaEW9Sk4tZAd
 J712tNTLsFVVhG2xkJsc1El1g7X/EGUZnQymtAa11eQ1v6wZy7cqZPYs4oSVB+9iWzog
 jQCA==
X-Gm-Message-State: AOJu0YygJjjOOHmDCgujJSzhjqXrYyf2RNZlHT/x6bJb2b8WRWoT0CIC
 NbZLyyPsLqSG9o7d30jfxznnUVCUEvX5xvrUaQMEFezI4tTyJfBa1aiBOy9hmPA=
X-Google-Smtp-Source: AGHT+IF0u+VL9poT9DC+3hmeIdKj4Ynvxo4gwn99yG0mdB/Nde6kfuc3E1TI3eI2eQ4hWW47q0ouZA==
X-Received: by 2002:a05:6a20:7483:b0:1af:ccd8:c11c with SMTP id
 adf61e73a8af0-1b1f8804dcdmr2464200637.29.1716387812985; 
 Wed, 22 May 2024 07:23:32 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6596fde8fa7sm9410942a12.13.2024.05.22.07.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:23:32 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] usb: dwc2: Extract USB DWC2 register definitions
Date: Wed, 22 May 2024 22:22:48 +0800
Message-ID: <20240522142311.17351-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240522142311.17351-1-seashell11234455@gmail.com>
References: <20240522142311.17351-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 May 2024 16:51:03 +0200
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

Extract the register definitions and their bit definitions from the USB
DWC2 driver host and device into a common file.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 drivers/usb/common/Makefile                |   2 +
 drivers/usb/common/dwc2_core.c             |  53 ++
 drivers/usb/common/dwc2_core.h             | 556 ++++++++++++++++
 drivers/usb/gadget/dwc2_udc_otg.c          | 124 ++--
 drivers/usb/gadget/dwc2_udc_otg_regs.h     | 247 +------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++-----
 drivers/usb/host/dwc2.c                    | 362 +++++-----
 drivers/usb/host/dwc2.h                    | 736 ---------------------
 8 files changed, 988 insertions(+), 1398 deletions(-)
 create mode 100644 drivers/usb/common/dwc2_core.c
 create mode 100644 drivers/usb/common/dwc2_core.h

diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 2e9353b76a..708f13c52c 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -4,6 +4,8 @@
 #
 
 obj-$(CONFIG_$(SPL_)DM_USB) += common.o
+obj-$(CONFIG_USB_DWC2) += dwc2_core.o
+obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
 obj-$(CONFIG_USB_ISP1760) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
new file mode 100644
index 0000000000..2fa11fd59d
--- /dev/null
+++ b/drivers/usb/common/dwc2_core.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <wait_bit.h>
+
+#include "dwc2_core.h"
+
+void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
+{
+	int ret;
+
+	log_debug("Flush Tx FIFO %d\n", num);
+
+	/* Wait for AHB master IDLE state */
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
+	if (ret)
+		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
+
+	writel(GRSTCTL_TXFFLSH | FIELD_PREP(GRSTCTL_TXFNUM_MASK, num), &regs->global_regs.grstctl);
+
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_TXFFLSH, false, 1000, false);
+	if (ret)
+		log_warning("%s: Waiting for GRSTCTL_TXFFLSH timeout\n", __func__);
+
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+void dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
+{
+	int ret;
+
+	log_debug("Flush Rx FIFO\n");
+
+	/* Wait for AHB master IDLE state */
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
+	if (ret)
+		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
+
+	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
+
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH, false, 1000, false);
+	if (ret)
+		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
+
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
diff --git a/drivers/usb/common/dwc2_core.h b/drivers/usb/common/dwc2_core.h
new file mode 100644
index 0000000000..8303153446
--- /dev/null
+++ b/drivers/usb/common/dwc2_core.h
@@ -0,0 +1,556 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __DWC2_CORE_H_
+#define __DWC2_CORE_H_
+
+#include <linux/bitops.h>
+
+struct dwc2_global_regs {
+	u32 gotgctl;
+	u32 gotgint;
+	u32 gahbcfg;
+	u32 gusbcfg;
+	u32 grstctl;
+	u32 gintsts;
+	u32 gintmsk;
+	u32 grxstsr;
+	u32 grxstsp;
+	u32 grxfsiz;
+	u32 gnptxfsiz;
+	u32 gnptxsts;
+	u32 gi2cctl;
+	u32 gpvndctl;
+	u32 ggpio;
+	u32 guid;
+	u32 gsnpsid;
+	u32 ghwcfg1;
+	u32 ghwcfg2;
+	u32 ghwcfg3;
+	u32 ghwcfg4;
+	u32 glpmcfg;
+	u32 gpwrdn;
+	u32 gdfifocfg;
+	u32 gadpctl;
+	u32 grefclk;
+	u32 gintmsk2;
+	u32 gintsts2;
+	u8  _pad_from_0x70_to_0x100[0x100 - 0x70];
+	u32 hptxfsiz;
+	u32 dptxfsizn[15];
+	u8  _pad_from_0x140_to_0x400[0x400 - 0x140];
+};
+
+struct dwc2_hc_regs {
+	u32 hcchar;
+	u32 hcsplt;
+	u32 hcint;
+	u32 hcintmsk;
+	u32 hctsiz;
+	u32 hcdma;
+	u32 reserved;
+	u32 hcdmab;
+};
+
+struct dwc2_host_regs {
+	u32 hcfg;
+	u32 hfir;
+	u32 hfnum;
+	u32 _pad_0x40c;
+	u32 hptxsts;
+	u32 haint;
+	u32 haintmsk;
+	u32 hflbaddr;
+	u8  _pad_from_0x420_to_0x440[0x440 - 0x420];
+	u32 hprt0;
+	u8  _pad_from_0x444_to_0x500[0x500 - 0x444];
+	struct dwc2_hc_regs hc[16];
+	u8  _pad_from_0x700_to_0x800[0x800 - 0x700];
+};
+
+struct dwc2_dev_in_endp {
+	u32 diepctl;
+	u32 reserved0;
+	u32 diepint;
+	u32 reserved1;
+	u32 dieptsiz;
+	u32 diepdma;
+	u32 reserved2;
+	u32 diepdmab;
+};
+
+struct dwc2_dev_out_endp {
+	u32 doepctl;
+	u32 reserved0;
+	u32 doepint;
+	u32 reserved1;
+	u32 doeptsiz;
+	u32 doepdma;
+	u32 reserved2;
+	u32 doepdmab;
+};
+
+struct dwc2_device_regs {
+	u32 dcfg;
+	u32 dctl;
+	u32 dsts;
+	u32 _pad_0x80c;
+	u32 diepmsk;
+	u32 doepmsk;
+	u32 daint;
+	u32 daintmsk;
+	u32 dtknqr1;
+	u32 dtknqr2;
+	u32 dvbusdis;
+	u32 dvbuspulse;
+	u32 dtknqr3;
+	u32 dtknqr4;
+	u8  _pad_from_0x838_to_0x900[0x900 - 0x838];
+	struct dwc2_dev_in_endp  in_endp[16];
+	struct dwc2_dev_out_endp out_endp[16];
+};
+
+struct dwc2_core_regs {
+	struct dwc2_global_regs  global_regs;
+	struct dwc2_host_regs    host_regs;
+	struct dwc2_device_regs  device_regs;
+	u8  _pad_from_0xd00_to_0xe00[0xe00 - 0xd00];
+	u32 pcgcctl;
+	u8  _pad_from_0xe04_to_0x1000[0x1000 - 0xe04];
+	u8  ep_fifo[16][0x1000];
+};
+
+void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num);
+void dwc2_flush_rx_fifo(struct dwc2_core_regs *regs);
+
+/* Core Global Register */
+#define GOTGCTL_CHIRPEN				BIT(27)
+#define GOTGCTL_MULT_VALID_BC_MASK		GENMASK(26, 22)
+#define GOTGCTL_CURMODE_HOST			BIT(21)
+#define GOTGCTL_OTGVER				BIT(20)
+#define GOTGCTL_BSESVLD				BIT(19)
+#define GOTGCTL_ASESVLD				BIT(18)
+#define GOTGCTL_DBNC_SHORT			BIT(17)
+#define GOTGCTL_CONID_B				BIT(16)
+#define GOTGCTL_DBNCE_FLTR_BYPASS		BIT(15)
+#define GOTGCTL_DEVHNPEN			BIT(11)
+#define GOTGCTL_HSTSETHNPEN			BIT(10)
+#define GOTGCTL_HNPREQ				BIT(9)
+#define GOTGCTL_HSTNEGSCS			BIT(8)
+#define GOTGCTL_BVALOVAL			BIT(7)
+#define GOTGCTL_BVALOEN				BIT(6)
+#define GOTGCTL_AVALOVAL			BIT(5)
+#define GOTGCTL_AVALOEN				BIT(4)
+#define GOTGCTL_VBVALOVAL			BIT(3)
+#define GOTGCTL_VBVALOEN			BIT(2)
+#define GOTGCTL_SESREQ				BIT(1)
+#define GOTGCTL_SESREQSCS			BIT(0)
+
+#define GOTGINT_DBNCE_DONE			BIT(19)
+#define GOTGINT_A_DEV_TOUT_CHG			BIT(18)
+#define GOTGINT_HST_NEG_DET			BIT(17)
+#define GOTGINT_HST_NEG_SUC_STS_CHNG		BIT(9)
+#define GOTGINT_SES_REQ_SUC_STS_CHNG		BIT(8)
+#define GOTGINT_SES_END_DET			BIT(2)
+
+#define GAHBCFG_AHB_SINGLE			BIT(23)
+#define GAHBCFG_NOTI_ALL_DMA_WRIT		BIT(22)
+#define GAHBCFG_REM_MEM_SUPP			BIT(21)
+#define GAHBCFG_P_TXF_EMP_LVL			BIT(8)
+#define GAHBCFG_NP_TXF_EMP_LVL			BIT(7)
+#define GAHBCFG_DMA_EN				BIT(5)
+#define GAHBCFG_HBSTLEN_MASK			GENMASK(4, 1)
+#define GAHBCFG_HBSTLEN_SINGLE			0
+#define GAHBCFG_HBSTLEN_INCR			1
+#define GAHBCFG_HBSTLEN_INCR4			3
+#define GAHBCFG_HBSTLEN_INCR8			5
+#define GAHBCFG_HBSTLEN_INCR16			7
+#define GAHBCFG_GLBL_INTR_EN			BIT(0)
+#define GAHBCFG_CTRL_MASK			(GAHBCFG_P_TXF_EMP_LVL | \
+						 GAHBCFG_NP_TXF_EMP_LVL | \
+						 GAHBCFG_DMA_EN | \
+						 GAHBCFG_GLBL_INTR_EN)
+
+#define GUSBCFG_FORCEDEVMODE			BIT(30)
+#define GUSBCFG_FORCEHOSTMODE			BIT(29)
+#define GUSBCFG_TXENDDELAY			BIT(28)
+#define GUSBCFG_ICTRAFFICPULLREMOVE		BIT(27)
+#define GUSBCFG_ICUSBCAP			BIT(26)
+#define GUSBCFG_ULPI_INT_PROT_DIS		BIT(25)
+#define GUSBCFG_INDICATORPASSTHROUGH		BIT(24)
+#define GUSBCFG_INDICATORCOMPLEMENT		BIT(23)
+#define GUSBCFG_TERMSELDLPULSE			BIT(22)
+#define GUSBCFG_ULPI_INT_VBUS_IND		BIT(21)
+#define GUSBCFG_ULPI_EXT_VBUS_DRV		BIT(20)
+#define GUSBCFG_ULPI_CLK_SUSP_M			BIT(19)
+#define GUSBCFG_ULPI_AUTO_RES			BIT(18)
+#define GUSBCFG_ULPI_FS_LS			BIT(17)
+#define GUSBCFG_OTG_UTMI_FS_SEL			BIT(16)
+#define GUSBCFG_PHY_LP_CLK_SEL			BIT(15)
+#define GUSBCFG_USBTRDTIM_MASK			GENMASK(14, 10)
+#define GUSBCFG_HNPCAP				BIT(9)
+#define GUSBCFG_SRPCAP				BIT(8)
+#define GUSBCFG_DDRSEL				BIT(7)
+#define GUSBCFG_PHYSEL				BIT(6)
+#define GUSBCFG_FSINTF				BIT(5)
+#define GUSBCFG_ULPI_UTMI_SEL			BIT(4)
+#define GUSBCFG_PHYIF16				BIT(3)
+#define GUSBCFG_TOUTCAL_MASK			GENMASK(2, 0)
+
+#define GRSTCTL_AHBIDLE				BIT(31)
+#define GRSTCTL_DMAREQ				BIT(30)
+#define GRSTCTL_CSFTRST_DONE			BIT(29)
+#define GRSTCTL_TXFNUM_MASK			GENMASK(10, 6)
+#define GRSTCTL_TXFFLSH				BIT(5)
+#define GRSTCTL_RXFFLSH				BIT(4)
+#define GRSTCTL_IN_TKNQ_FLSH			BIT(3)
+#define GRSTCTL_FRMCNTRRST			BIT(2)
+#define GRSTCTL_HSFTRST				BIT(1)
+#define GRSTCTL_CSFTRST				BIT(0)
+
+#define GINTSTS_WKUPINT				BIT(31)
+#define GINTSTS_SESSREQINT			BIT(30)
+#define GINTSTS_DISCONNINT			BIT(29)
+#define GINTSTS_CONIDSTSCHNG			BIT(28)
+#define GINTSTS_LPMTRANRCVD			BIT(27)
+#define GINTSTS_PTXFEMP				BIT(26)
+#define GINTSTS_HCHINT				BIT(25)
+#define GINTSTS_PRTINT				BIT(24)
+#define GINTSTS_RESETDET			BIT(23)
+#define GINTSTS_FET_SUSP			BIT(22)
+#define GINTSTS_INCOMPL_IP			BIT(21)
+#define GINTSTS_INCOMPL_SOOUT			BIT(21)
+#define GINTSTS_INCOMPL_SOIN			BIT(20)
+#define GINTSTS_OEPINT				BIT(19)
+#define GINTSTS_IEPINT				BIT(18)
+#define GINTSTS_EPMIS				BIT(17)
+#define GINTSTS_RESTOREDONE			BIT(16)
+#define GINTSTS_EOPF				BIT(15)
+#define GINTSTS_ISOUTDROP			BIT(14)
+#define GINTSTS_ENUMDONE			BIT(13)
+#define GINTSTS_USBRST				BIT(12)
+#define GINTSTS_USBSUSP				BIT(11)
+#define GINTSTS_ERLYSUSP			BIT(10)
+#define GINTSTS_I2CINT				BIT(9)
+#define GINTSTS_ULPI_CK_INT			BIT(8)
+#define GINTSTS_GOUTNAKEFF			BIT(7)
+#define GINTSTS_GINNAKEFF			BIT(6)
+#define GINTSTS_NPTXFEMP			BIT(5)
+#define GINTSTS_RXFLVL				BIT(4)
+#define GINTSTS_SOF				BIT(3)
+#define GINTSTS_OTGINT				BIT(2)
+#define GINTSTS_MODEMIS				BIT(1)
+#define GINTSTS_CURMODE_HOST			BIT(0)
+
+#define GRXSTS_FN_MASK				GENMASK(31, 25)
+#define GRXSTS_PKTSTS_MASK			GENMASK(20, 17)
+#define GRXSTS_PKTSTS_GLOBALOUTNAK		1
+#define GRXSTS_PKTSTS_OUTRX			2
+#define GRXSTS_PKTSTS_HCHIN			2
+#define GRXSTS_PKTSTS_OUTDONE			3
+#define GRXSTS_PKTSTS_HCHIN_XFER_COMP		3
+#define GRXSTS_PKTSTS_SETUPDONE			4
+#define GRXSTS_PKTSTS_DATATOGGLEERR		5
+#define GRXSTS_PKTSTS_SETUPRX			6
+#define GRXSTS_PKTSTS_HCHHALTED			7
+#define GRXSTS_DPID_MASK			GENMASK(16, 15)
+#define GRXSTS_BYTECNT_MASK			GENMASK(14, 4)
+#define GRXSTS_HCHNUM_MASK			GENMASK(3, 0)
+
+#define GRXFSIZ_DEPTH_MASK			GENMASK(15, 0)
+
+#define GI2CCTL_BSYDNE				BIT(31)
+#define GI2CCTL_RW				BIT(30)
+#define GI2CCTL_I2CDATSE0			BIT(28)
+#define GI2CCTL_I2CDEVADDR_MASK			GENMASK(27, 26)
+#define GI2CCTL_I2CSUSPCTL			BIT(25)
+#define GI2CCTL_ACK				BIT(24)
+#define GI2CCTL_I2CEN				BIT(23)
+#define GI2CCTL_ADDR_MASK			GENMASK(22, 16)
+#define GI2CCTL_REGADDR_MASK			GENMASK(15, 8)
+#define GI2CCTL_RWDATA_MASK			GENMASK(7, 0)
+
+#define GGPIO_STM32_OTG_GCCFG_IDEN		BIT(22)
+#define GGPIO_STM32_OTG_GCCFG_VBDEN		BIT(21)
+#define GGPIO_STM32_OTG_GCCFG_PWRDWN		BIT(16)
+
+#define GSNPSID_ID_MASK				GENMASK(31, 16)
+#define GSNPSID_OTG_ID				0x4f54
+#define GSNPSID_VER_MASK			GENMASK(15, 0)
+
+#define GHWCFG2_OTG_ENABLE_IC_USB		BIT(31)
+#define GHWCFG2_DEV_TOKEN_Q_DEPTH_MASK		GENMASK(30, 26)
+#define GHWCFG2_HOST_PERIO_TX_Q_DEPTH_MASK	GENMASK(25, 24)
+#define GHWCFG2_NONPERIO_TX_Q_DEPTH_MASK	GENMASK(23, 22)
+#define GHWCFG2_MULTI_PROC_INT			BIT(20)
+#define GHWCFG2_DYNAMIC_FIFO			BIT(19)
+#define GHWCFG2_PERIO_EP_SUPPORTED		BIT(18)
+#define GHWCFG2_NUM_HOST_CHAN_MASK		GENMASK(17, 14)
+#define GHWCFG2_NUM_DEV_EP_MASK			GENMASK(13, 10)
+#define GHWCFG2_FS_PHY_TYPE_MASK		GENMASK(9, 8)
+#define GHWCFG2_FS_PHY_TYPE_NOT_SUPPORTED	0
+#define GHWCFG2_FS_PHY_TYPE_DEDICATED		1
+#define GHWCFG2_FS_PHY_TYPE_SHARED_UTMI		2
+#define GHWCFG2_FS_PHY_TYPE_SHARED_ULPI		3
+#define GHWCFG2_HS_PHY_TYPE_MASK		GENMASK(7, 6)
+#define GHWCFG2_HS_PHY_TYPE_NOT_SUPPORTED	0
+#define GHWCFG2_HS_PHY_TYPE_UTMI		1
+#define GHWCFG2_HS_PHY_TYPE_ULPI		2
+#define GHWCFG2_HS_PHY_TYPE_UTMI_ULPI		3
+#define GHWCFG2_POINT2POINT			BIT(5)
+#define GHWCFG2_ARCHITECTURE_MASK		GENMASK(4, 3)
+#define GHWCFG2_SLAVE_ONLY_ARCH			0
+#define GHWCFG2_EXT_DMA_ARCH			1
+#define GHWCFG2_INT_DMA_ARCH			2
+#define GHWCFG2_OP_MODE_MASK			GENMASK(2, 0)
+#define GHWCFG2_OP_MODE_HNP_SRP_CAPABLE		0
+#define GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE	1
+#define GHWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE	2
+#define GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE	3
+#define GHWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE	4
+#define GHWCFG2_OP_MODE_SRP_CAPABLE_HOST	5
+#define GHWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST	6
+#define GHWCFG2_OP_MODE_UNDEFINED		7
+
+#define GHWCFG4_DESC_DMA_DYN			BIT(31)
+#define GHWCFG4_DESC_DMA			BIT(30)
+#define GHWCFG4_NUM_IN_EPS_MASK			GENMASK(29, 26)
+#define GHWCFG4_DED_FIFO_EN			BIT(25)
+#define GHWCFG4_SESSION_END_FILT_EN		BIT(24)
+#define GHWCFG4_B_VALID_FILT_EN			BIT(23)
+#define GHWCFG4_A_VALID_FILT_EN			BIT(22)
+#define GHWCFG4_VBUS_VALID_FILT_EN		BIT(21)
+#define GHWCFG4_IDDIG_FILT_EN			BIT(20)
+#define GHWCFG4_NUM_DEV_MODE_CTRL_EP_MASK	GENMASK(19, 16)
+#define GHWCFG4_UTMI_PHY_DATA_WIDTH_MASK	GENMASK(15, 14)
+#define GHWCFG4_UTMI_PHY_DATA_WIDTH_8		0
+#define GHWCFG4_UTMI_PHY_DATA_WIDTH_16		1
+#define GHWCFG4_UTMI_PHY_DATA_WIDTH_8_OR_16	2
+#define GHWCFG4_ACG_SUPPORTED			BIT(12)
+#define GHWCFG4_IPG_ISOC_SUPPORTED		BIT(11)
+#define GHWCFG4_SERVICE_INTERVAL_SUPPORTED      BIT(10)
+#define GHWCFG4_XHIBER				BIT(7)
+#define GHWCFG4_HIBER				BIT(6)
+#define GHWCFG4_MIN_AHB_FREQ			BIT(5)
+#define GHWCFG4_POWER_OPTIMIZ			BIT(4)
+#define GHWCFG4_NUM_DEV_PERIO_IN_EP_MASK	GENMASK(3, 0)
+
+#define FIFOSIZE_DEPTH_MASK			GENMASK(31, 16)
+#define FIFOSIZE_STARTADDR_MASK			GENMASK(15, 0)
+
+/* Host Register */
+#define HCFG_MODECHTIMEN			BIT(31)
+#define HCFG_PERSCHEDENA			BIT(26)
+#define HCFG_FRLISTEN_MASK			GENMASK(25, 24)
+#define HCFG_FRLISTEN_8				0
+#define HCFG_FRLISTEN_16			1
+#define HCFG_FRLISTEN_32			2
+#define HCFG_FRLISTEN_64			3
+#define HCFG_DESCDMA				BIT(23)
+#define HCFG_RESVALID_MASK			GENMASK(15, 8)
+#define HCFG_ENA32KHZ				BIT(7)
+#define HCFG_FSLSSUPP				BIT(2)
+#define HCFG_FSLSPCLKSEL_MASK			GENMASK(2, 0)
+#define HCFG_FSLSPCLKSEL_30_60_MHZ		0
+#define HCFG_FSLSPCLKSEL_48_MHZ			1
+#define HCFG_FSLSPCLKSEL_6_MHZ			2
+
+#define HFNUM_FRREM_MASK			GENMASK(31, 16)
+#define HFNUM_FRNUM_MASK			GENMASK(15, 0)
+
+#define HPRT0_SPD_MASK				GENMASK(18, 17)
+#define HPRT0_SPD_HIGH_SPEED			0
+#define HPRT0_SPD_FULL_SPEED			1
+#define HPRT0_SPD_LOW_SPEED			2
+#define HPRT0_TSTCTL_MASK			GENMASK(16, 13)
+#define HPRT0_PWR				BIT(12)
+#define HPRT0_LNSTS_MASK			GENMASK(11, 10)
+#define HPRT0_RST				BIT(8)
+#define HPRT0_SUSP				BIT(7)
+#define HPRT0_RES				BIT(6)
+#define HPRT0_OVRCURRCHG			BIT(5)
+#define HPRT0_OVRCURRACT			BIT(4)
+#define HPRT0_ENACHG				BIT(3)
+#define HPRT0_ENA				BIT(2)
+#define HPRT0_CONNDET				BIT(1)
+#define HPRT0_CONNSTS				BIT(0)
+#define HPRT0_W1C_MASK				(HPRT0_CONNDET | \
+						 HPRT0_ENA | \
+						 HPRT0_ENACHG | \
+						 HPRT0_OVRCURRCHG)
+
+#define HCCHAR_CHENA				BIT(31)
+#define HCCHAR_CHDIS				BIT(30)
+#define HCCHAR_ODDFRM				BIT(29)
+#define HCCHAR_DEVADDR_MASK			GENMASK(28, 22)
+#define HCCHAR_MULTICNT_MASK			GENMASK(21, 20)
+#define HCCHAR_EPTYPE_MASK			GENMASK(19, 18)
+#define HCCHAR_EPTYPE_CONTROL			0
+#define HCCHAR_EPTYPE_ISOC			1
+#define HCCHAR_EPTYPE_BULK			2
+#define HCCHAR_EPTYPE_INTR			3
+#define HCCHAR_LSPDDEV				BIT(17)
+#define HCCHAR_EPDIR				BIT(15)
+#define HCCHAR_EPNUM_MASK			GENMASK(14, 11)
+#define HCCHAR_MPS_MASK				GENMASK(10, 0)
+
+#define HCSPLT_SPLTENA				BIT(31)
+#define HCSPLT_COMPSPLT				BIT(16)
+#define HCSPLT_XACTPOS_MASK			GENMASK(15, 14)
+#define HCSPLT_XACTPOS_MID			0
+#define HCSPLT_XACTPOS_END			1
+#define HCSPLT_XACTPOS_BEGIN			2
+#define HCSPLT_XACTPOS_ALL			3
+#define HCSPLT_HUBADDR_MASK			GENMASK(13, 7)
+#define HCSPLT_PRTADDR_MASK			GENMASK(6, 0)
+
+#define HCINTMSK_FRM_LIST_ROLL			BIT(13)
+#define HCINTMSK_XCS_XACT			BIT(12)
+#define HCINTMSK_BNA				BIT(11)
+#define HCINTMSK_DATATGLERR			BIT(10)
+#define HCINTMSK_FRMOVRUN			BIT(9)
+#define HCINTMSK_BBLERR				BIT(8)
+#define HCINTMSK_XACTERR			BIT(7)
+#define HCINTMSK_NYET				BIT(6)
+#define HCINTMSK_ACK				BIT(5)
+#define HCINTMSK_NAK				BIT(4)
+#define HCINTMSK_STALL				BIT(3)
+#define HCINTMSK_AHBERR				BIT(2)
+#define HCINTMSK_CHHLTD				BIT(1)
+#define HCINTMSK_XFERCOMPL			BIT(0)
+
+#define TSIZ_DOPNG				BIT(31)
+#define TSIZ_SC_MC_PID_MASK			GENMASK(30, 29)
+#define TSIZ_SC_MC_PID_DATA0			0
+#define TSIZ_SC_MC_PID_DATA2			1
+#define TSIZ_SC_MC_PID_DATA1			2
+#define TSIZ_SC_MC_PID_MDATA			3
+#define TSIZ_SC_MC_PID_SETUP			3
+#define TSIZ_PKTCNT_MASK			GENMASK(28, 19)
+#define TSIZ_NTD_MASK				GENMASK(15, 8)
+#define TSIZ_SCHINFO_MASK			GENMASK(7, 0)
+#define TSIZ_XFERSIZE_MASK			GENMASK(18, 0)
+
+/* Device Mode Register */
+#define DCFG_DESCDMA_EN				BIT(23)
+#define DCFG_EPMISCNT_MASK			GENMASK(22, 18)
+#define DCFG_IPG_ISOC_SUPPORDED			BIT(17)
+#define DCFG_PERFRINT_MASK			GENMASK(12, 11)
+#define DCFG_DEVADDR_MASK			GENMASK(10, 4)
+#define DCFG_NZ_STS_OUT_HSHK			BIT(2)
+#define DCFG_DEVSPD_MASK			GENMASK(1, 0)
+#define DCFG_DEVSPD_HS				0
+#define DCFG_DEVSPD_FS				1
+#define DCFG_DEVSPD_LS				2
+#define DCFG_DEVSPD_FS48			3
+
+#define DCTL_SERVICE_INTERVAL_SUPPORTED		BIT(19)
+#define DCTL_PWRONPRGDONE			BIT(11)
+#define DCTL_CGOUTNAK				BIT(10)
+#define DCTL_SGOUTNAK				BIT(9)
+#define DCTL_CGNPINNAK				BIT(8)
+#define DCTL_SGNPINNAK				BIT(7)
+#define DCTL_TSTCTL_MASK			GENMASK(6, 4)
+#define DCTL_GOUTNAKSTS				BIT(3)
+#define DCTL_GNPINNAKSTS			BIT(2)
+#define DCTL_SFTDISCON				BIT(1)
+#define DCTL_RMTWKUPSIG				BIT(0)
+
+#define DSTS_SOFFN_MASK				GENMASK(21, 8)
+#define DSTS_ERRATICERR				BIT(3)
+#define DSTS_ENUMSPD_MASK			GENMASK(2, 1)
+#define DSTS_ENUMSPD_HS				0
+#define DSTS_ENUMSPD_FS				1
+#define DSTS_ENUMSPD_LS				2
+#define DSTS_ENUMSPD_FS48			3
+#define DSTS_SUSPSTS				BIT(0)
+
+#define DIEPMSK_NAKMSK				BIT(13)
+#define DIEPMSK_BNAININTRMSK			BIT(9)
+#define DIEPMSK_TXFIFOUNDRNMSK			BIT(8)
+#define DIEPMSK_TXFIFOEMPTY			BIT(7)
+#define DIEPMSK_INEPNAKEFFMSK			BIT(6)
+#define DIEPMSK_INTKNEPMISMSK			BIT(5)
+#define DIEPMSK_INTKNTXFEMPMSK			BIT(4)
+#define DIEPMSK_TIMEOUTMSK			BIT(3)
+#define DIEPMSK_AHBERRMSK			BIT(2)
+#define DIEPMSK_EPDISBLDMSK			BIT(1)
+#define DIEPMSK_XFERCOMPLMSK			BIT(0)
+
+#define DOEPMSK_BNAMSK				BIT(9)
+#define DOEPMSK_BACK2BACKSETUP			BIT(6)
+#define DOEPMSK_STSPHSERCVDMSK			BIT(5)
+#define DOEPMSK_OUTTKNEPDISMSK			BIT(4)
+#define DOEPMSK_SETUPMSK			BIT(3)
+#define DOEPMSK_AHBERRMSK			BIT(2)
+#define DOEPMSK_EPDISBLDMSK			BIT(1)
+#define DOEPMSK_XFERCOMPLMSK			BIT(0)
+
+#define DAINT_OUTEP_MASK			GENMASK(31, 16)
+#define DAINT_INEP_MASK				GENMASK(15, 0)
+
+#define D0EPCTL_MPS_MASK			GENMASK(1, 0)
+#define D0EPCTL_MPS_64				0
+#define D0EPCTL_MPS_32				1
+#define D0EPCTL_MPS_16				2
+#define D0EPCTL_MPS_8				3
+
+#define DXEPCTL_EPENA				BIT(31)
+#define DXEPCTL_EPDIS				BIT(30)
+#define DXEPCTL_SETD1PID			BIT(29)
+#define DXEPCTL_SETODDFR			BIT(29)
+#define DXEPCTL_SETD0PID			BIT(28)
+#define DXEPCTL_SETEVENFR			BIT(28)
+#define DXEPCTL_SNAK				BIT(27)
+#define DXEPCTL_CNAK				BIT(26)
+#define DXEPCTL_TXFNUM_MASK			GENMASK(25, 22)
+#define DXEPCTL_STALL				BIT(21)
+#define DXEPCTL_SNP				BIT(20)
+#define DXEPCTL_EPTYPE_MASK			GENMASK(19, 18)
+#define DXEPCTL_EPTYPE_CONTROL			0
+#define DXEPCTL_EPTYPE_ISO			1
+#define DXEPCTL_EPTYPE_BULK			2
+#define DXEPCTL_EPTYPE_INTERRUPT		3
+#define DXEPCTL_NAKSTS				BIT(17)
+#define DXEPCTL_DPID				BIT(16)
+#define DXEPCTL_EOFRNUM				BIT(16)
+#define DXEPCTL_USBACTEP			BIT(15)
+#define DXEPCTL_NEXTEP_MASK			GENMASK(14, 11)
+#define DXEPCTL_MPS_MASK			GENMASK(10, 0)
+
+#define DXEPINT_SETUP_RCVD			BIT(15)
+#define DXEPINT_NYETINTRPT			BIT(14)
+#define DXEPINT_NAKINTRPT			BIT(13)
+#define DXEPINT_BBLEERRINTRPT			BIT(12)
+#define DXEPINT_PKTDRPSTS			BIT(11)
+#define DXEPINT_BNAINTR				BIT(9)
+#define DXEPINT_TXFIFOUNDRN			BIT(8)
+#define DXEPINT_OUTPKTERR			BIT(8)
+#define DXEPINT_TXFEMP				BIT(7)
+#define DXEPINT_INEPNAKEFF			BIT(6)
+#define DXEPINT_BACK2BACKSETUP			BIT(6)
+#define DXEPINT_INTKNEPMIS			BIT(5)
+#define DXEPINT_STSPHSERCVD			BIT(5)
+#define DXEPINT_INTKNTXFEMP			BIT(4)
+#define DXEPINT_OUTTKNEPDIS			BIT(4)
+#define DXEPINT_TIMEOUT				BIT(3)
+#define DXEPINT_SETUP				BIT(3)
+#define DXEPINT_AHBERR				BIT(2)
+#define DXEPINT_EPDISBLD			BIT(1)
+#define DXEPINT_XFERCOMPL			BIT(0)
+
+#define DIEPTSIZ0_PKTCNT_MASK			GENMASK(20, 19)
+#define DIEPTSIZ0_XFERSIZE_MASK			GENMASK(6, 0)
+
+#define DOEPTSIZ0_SUPCNT_MASK			GENMASK(30, 29)
+#define DOEPTSIZ0_PKTCNT			BIT(19)
+#define DOEPTSIZ0_XFERSIZE_MASK			GENMASK(6, 0)
+
+#define DXEPTSIZ_MC_MASK			GENMASK(30, 29)
+#define DXEPTSIZ_PKTCNT_MASK			GENMASK(28, 19)
+#define DXEPTSIZ_XFERSIZE_MASK			GENMASK(18, 0)
+
+#endif /* __DWC2_CORE_H_ */
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 27082f5152..ac902b325a 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/printk.h>
 
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 
@@ -41,11 +42,9 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 #include <asm/io.h>
-
-#include <asm/mach-types.h>
-
 #include <power/regulator.h>
 
+#include "../common/dwc2_core.h"
 #include "dwc2_udc_otg_regs.h"
 #include "dwc2_udc_otg_priv.h"
 
@@ -155,11 +154,11 @@ static struct usb_ep_ops dwc2_ep_ops = {
 
 /***********************************************************/
 
-struct dwc2_usbotg_reg *reg;
+struct dwc2_core_regs *reg;
 
 bool dfu_usb_get_reset(void)
 {
-	return !!(readl(&reg->gintsts) & INT_RESET);
+	return !!(readl(&reg->global_regs.gintsts) & GINTSTS_USBRST);
 }
 
 __weak void otg_phy_init(struct dwc2_udc *dev) {}
@@ -230,7 +229,7 @@ static int udc_enable(struct dwc2_udc *dev)
 
 	debug_cond(DEBUG_SETUP != 0,
 		   "DWC2 USB 2.0 OTG Controller Core Initialized : 0x%x\n",
-		    readl(&reg->gintmsk));
+		    readl(&reg->global_regs.gintmsk));
 
 	dev->gadget.speed = USB_SPEED_UNKNOWN;
 
@@ -239,8 +238,8 @@ static int udc_enable(struct dwc2_udc *dev)
 
 static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
 {
-	clrsetbits_le32(&reg->dctl, SOFT_DISCONNECT,
-			is_on ? 0 : SOFT_DISCONNECT);
+	clrsetbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON,
+			is_on ? 0 : DCTL_SFTDISCON);
 
 	return 0;
 }
@@ -464,12 +463,14 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 {
 	/* 2. Soft-reset OTG Core and then unreset again. */
 	int i;
-	unsigned int uTemp = writel(CORE_SOFT_RESET, &reg->grstctl);
+	unsigned int uTemp;
 	uint32_t dflt_gusbcfg;
 	uint32_t rx_fifo_sz, tx_fifo_sz, np_tx_fifo_sz;
 	u32 max_hw_ep;
 	int pdata_hw_ep;
 
+	writel(GRSTCTL_CSFTRST, &reg->global_regs.grstctl);
+
 	debug("Resetting OTG controller\n");
 
 	dflt_gusbcfg =
@@ -491,47 +492,48 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 	if (dev->pdata->usb_gusbcfg)
 		dflt_gusbcfg = dev->pdata->usb_gusbcfg;
 
-	writel(dflt_gusbcfg, &reg->gusbcfg);
+	writel(dflt_gusbcfg, &reg->global_regs.gusbcfg);
 
 	/* 3. Put the OTG device core in the disconnected state.*/
-	uTemp = readl(&reg->dctl);
-	uTemp |= SOFT_DISCONNECT;
-	writel(uTemp, &reg->dctl);
+	uTemp = readl(&reg->device_regs.dctl);
+	uTemp |= DCTL_SFTDISCON;
+	writel(uTemp, &reg->device_regs.dctl);
 
 	udelay(20);
 
 	/* 4. Make the OTG device core exit from the disconnected state.*/
-	uTemp = readl(&reg->dctl);
-	uTemp = uTemp & ~SOFT_DISCONNECT;
-	writel(uTemp, &reg->dctl);
+	uTemp = readl(&reg->device_regs.dctl);
+	uTemp = uTemp & ~DCTL_SFTDISCON;
+	writel(uTemp, &reg->device_regs.dctl);
 
 	/* 5. Configure OTG Core to initial settings of device mode.*/
 	/* [][1: full speed(30Mhz) 0:high speed]*/
-	writel(EP_MISS_CNT(1) | DEV_SPEED_HIGH_SPEED_20, &reg->dcfg);
+	writel(FIELD_PREP(DCFG_EPMISCNT_MASK, 1) |
+	       FIELD_PREP(DCFG_DEVSPD_MASK, DCFG_DEVSPD_HS), &reg->device_regs.dcfg);
 
 	mdelay(1);
 
 	/* 6. Unmask the core interrupts*/
-	writel(GINTMSK_INIT, &reg->gintmsk);
+	writel(GINTMSK_INIT, &reg->global_regs.gintmsk);
 
 	/* 7. Set NAK bit of EP0, EP1, EP2*/
-	writel(DEPCTL_EPDIS|DEPCTL_SNAK, &reg->out_endp[EP0_CON].doepctl);
-	writel(DEPCTL_EPDIS|DEPCTL_SNAK, &reg->in_endp[EP0_CON].diepctl);
+	writel(DXEPCTL_EPDIS | DXEPCTL_SNAK, &reg->device_regs.out_endp[EP0_CON].doepctl);
+	writel(DXEPCTL_EPDIS | DXEPCTL_SNAK, &reg->device_regs.in_endp[EP0_CON].diepctl);
 
 	for (i = 1; i < DWC2_MAX_ENDPOINTS; i++) {
-		writel(DEPCTL_EPDIS|DEPCTL_SNAK, &reg->out_endp[i].doepctl);
-		writel(DEPCTL_EPDIS|DEPCTL_SNAK, &reg->in_endp[i].diepctl);
+		writel(DXEPCTL_EPDIS | DXEPCTL_SNAK, &reg->device_regs.out_endp[i].doepctl);
+		writel(DXEPCTL_EPDIS | DXEPCTL_SNAK, &reg->device_regs.in_endp[i].diepctl);
 	}
 
 	/* 8. Unmask EPO interrupts*/
-	writel(((1 << EP0_CON) << DAINT_OUT_BIT)
-	       | (1 << EP0_CON), &reg->daintmsk);
+	writel(FIELD_PREP(DAINT_OUTEP_MASK, BIT(EP0_CON)) |
+	       FIELD_PREP(DAINT_INEP_MASK, BIT(EP0_CON)), &reg->device_regs.daintmsk);
 
 	/* 9. Unmask device OUT EP common interrupts*/
-	writel(DOEPMSK_INIT, &reg->doepmsk);
+	writel(DOEPMSK_INIT, &reg->device_regs.doepmsk);
 
 	/* 10. Unmask device IN EP common interrupts*/
-	writel(DIEPMSK_INIT, &reg->diepmsk);
+	writel(DIEPMSK_INIT, &reg->device_regs.diepmsk);
 
 	rx_fifo_sz = RX_FIFO_SIZE;
 	np_tx_fifo_sz = NPTX_FIFO_SIZE;
@@ -545,15 +547,15 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 		tx_fifo_sz = dev->pdata->tx_fifo_sz;
 
 	/* 11. Set Rx FIFO Size (in 32-bit words) */
-	writel(rx_fifo_sz, &reg->grxfsiz);
+	writel(rx_fifo_sz, &reg->global_regs.grxfsiz);
 
 	/* 12. Set Non Periodic Tx FIFO Size */
-	writel((np_tx_fifo_sz << 16) | rx_fifo_sz,
-	       &reg->gnptxfsiz);
+	writel(FIELD_PREP(FIFOSIZE_DEPTH_MASK, np_tx_fifo_sz) |
+	       FIELD_PREP(FIFOSIZE_STARTADDR_MASK, rx_fifo_sz),
+	       &reg->global_regs.gnptxfsiz);
 
 	/* retrieve the number of IN Endpoints (excluding ep0) */
-	max_hw_ep = (readl(&reg->ghwcfg4) & GHWCFG4_NUM_IN_EPS_MASK) >>
-		    GHWCFG4_NUM_IN_EPS_SHIFT;
+	max_hw_ep = FIELD_GET(GHWCFG4_NUM_IN_EPS_MASK, readl(&reg->global_regs.ghwcfg4));
 	pdata_hw_ep = dev->pdata->tx_fifo_sz_nb;
 
 	/* tx_fifo_sz_nb should equal to number of IN Endpoint */
@@ -565,28 +567,25 @@ static void reconfig_usbd(struct dwc2_udc *dev)
 		if (pdata_hw_ep)
 			tx_fifo_sz = dev->pdata->tx_fifo_sz_array[i];
 
-		writel((rx_fifo_sz + np_tx_fifo_sz + (tx_fifo_sz * i)) |
-			tx_fifo_sz << 16, &reg->dieptxf[i]);
+		writel(FIELD_PREP(FIFOSIZE_DEPTH_MASK, tx_fifo_sz) |
+		       FIELD_PREP(FIFOSIZE_STARTADDR_MASK,
+				  rx_fifo_sz + np_tx_fifo_sz + tx_fifo_sz * i),
+		       &reg->global_regs.dptxfsizn[i]);
 	}
 	/* Flush the RX FIFO */
-	writel(RX_FIFO_FLUSH, &reg->grstctl);
-	while (readl(&reg->grstctl) & RX_FIFO_FLUSH)
-		debug("%s: waiting for DWC2_UDC_OTG_GRSTCTL\n", __func__);
+	dwc2_flush_rx_fifo(reg);
 
 	/* Flush all the Tx FIFO's */
-	writel(TX_FIFO_FLUSH_ALL, &reg->grstctl);
-	writel(TX_FIFO_FLUSH_ALL | TX_FIFO_FLUSH, &reg->grstctl);
-	while (readl(&reg->grstctl) & TX_FIFO_FLUSH)
-		debug("%s: waiting for DWC2_UDC_OTG_GRSTCTL\n", __func__);
+	dwc2_flush_tx_fifo(reg, 0x10);
 
 	/* 13. Clear NAK bit of EP0, EP1, EP2*/
 	/* For Slave mode*/
 	/* EP0: Control OUT */
-	writel(DEPCTL_EPDIS | DEPCTL_CNAK,
-	       &reg->out_endp[EP0_CON].doepctl);
+	writel(DXEPCTL_EPDIS | DXEPCTL_CNAK,
+	       &reg->device_regs.out_endp[EP0_CON].doepctl);
 
 	/* 14. Initialize OTG Link Core.*/
-	writel(GAHBCFG_INIT, &reg->gahbcfg);
+	writel(GAHBCFG_INIT, &reg->global_regs.gahbcfg);
 }
 
 static void set_max_pktsize(struct dwc2_udc *dev, enum usb_device_speed speed)
@@ -611,12 +610,12 @@ static void set_max_pktsize(struct dwc2_udc *dev, enum usb_device_speed speed)
 		dev->ep[i].ep.maxpacket = ep_fifo_size;
 
 	/* EP0 - Control IN (64 bytes)*/
-	ep_ctrl = readl(&reg->in_endp[EP0_CON].diepctl);
-	writel(ep_ctrl|(0<<0), &reg->in_endp[EP0_CON].diepctl);
+	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
+	writel(ep_ctrl | (0 << 0), &reg->device_regs.in_endp[EP0_CON].diepctl);
 
 	/* EP0 - Control OUT (64 bytes)*/
-	ep_ctrl = readl(&reg->out_endp[EP0_CON].doepctl);
-	writel(ep_ctrl|(0<<0), &reg->out_endp[EP0_CON].doepctl);
+	ep_ctrl = readl(&reg->device_regs.out_endp[EP0_CON].doepctl);
+	writel(ep_ctrl | (0 << 0), &reg->device_regs.out_endp[EP0_CON].doepctl);
 }
 
 static int dwc2_ep_enable(struct usb_ep *_ep,
@@ -905,7 +904,7 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 
 	dev->pdata = pdata;
 
-	reg = (struct dwc2_usbotg_reg *)pdata->regs_otg;
+	reg = (struct dwc2_core_regs *)pdata->regs_otg;
 
 	dev->gadget.is_dualspeed = 1;	/* Hack only*/
 	dev->gadget.is_otg = 0;
@@ -933,8 +932,8 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 
 int dwc2_udc_handle_interrupt(void)
 {
-	u32 intr_status = readl(&reg->gintsts);
-	u32 gintmsk = readl(&reg->gintmsk);
+	u32 intr_status = readl(&reg->global_regs.gintsts);
+	u32 gintmsk = readl(&reg->global_regs.gintmsk);
 
 	if (intr_status & gintmsk)
 		return dwc2_udc_irq(1, (void *)the_controller);
@@ -1093,8 +1092,8 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
 {
 	struct dwc2_plat_otg_data *plat = dev_get_plat(dev);
 	struct dwc2_priv_data *priv = dev_get_priv(dev);
-	struct dwc2_usbotg_reg *usbotg_reg =
-		(struct dwc2_usbotg_reg *)plat->regs_otg;
+	struct dwc2_core_reg *usbotg_reg =
+		(struct dwc2_core_reg *)plat->regs_otg;
 	int ret;
 
 	ret = dwc2_udc_otg_clk_init(dev, &priv->clks);
@@ -1129,21 +1128,22 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
 		if (plat->force_b_session_valid &&
 		    !plat->force_vbus_detection) {
 			/* Override VBUS detection: enable then value*/
-			setbits_le32(&usbotg_reg->gotgctl, VB_VALOEN);
-			setbits_le32(&usbotg_reg->gotgctl, VB_VALOVAL);
+			setbits_le32(&usbotg_reg->global_regs.gotgctl, GOTGCTL_VBVALOEN);
+			setbits_le32(&usbotg_reg->global_regs.gotgctl, GOTGCTL_VBVALOVAL);
 		} else {
 			/* Enable VBUS sensing */
-			setbits_le32(&usbotg_reg->ggpio,
+			setbits_le32(&usbotg_reg->global_regs.ggpio,
 				     GGPIO_STM32_OTG_GCCFG_VBDEN);
 		}
 		if (plat->force_b_session_valid) {
 			/* Override B session bits: enable then value */
-			setbits_le32(&usbotg_reg->gotgctl, A_VALOEN | B_VALOEN);
-			setbits_le32(&usbotg_reg->gotgctl,
-				     A_VALOVAL | B_VALOVAL);
+			setbits_le32(&usbotg_reg->global_regs.gotgctl,
+				     GOTGCTL_AVALOEN | GOTGCTL_BVALOEN);
+			setbits_le32(&usbotg_reg->global_regs.gotgctl,
+				     GOTGCTL_AVALOVAL | GOTGCTL_BVALOVAL);
 		} else {
 			/* Enable ID detection */
-			setbits_le32(&usbotg_reg->ggpio,
+			setbits_le32(&usbotg_reg->global_regs.ggpio,
 				     GGPIO_STM32_OTG_GCCFG_IDEN);
 		}
 	}
@@ -1196,9 +1196,9 @@ U_BOOT_DRIVER(dwc2_udc_otg) = {
 int dwc2_udc_B_session_valid(struct udevice *dev)
 {
 	struct dwc2_plat_otg_data *plat = dev_get_plat(dev);
-	struct dwc2_usbotg_reg *usbotg_reg =
-		(struct dwc2_usbotg_reg *)plat->regs_otg;
+	struct dwc2_core_reg *usbotg_reg =
+		(struct dwc2_core_reg *)plat->regs_otg;
 
-	return readl(&usbotg_reg->gotgctl) & B_SESSION_VALID;
+	return readl(&usbotg_reg->global_regs.gotgctl) & GOTGCTL_BSESVLD;
 }
 #endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
index 9ca6f42375..e1c5c2d4c4 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
+++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
@@ -10,133 +10,7 @@
 #ifndef __ASM_ARCH_REGS_USB_OTG_HS_H
 #define __ASM_ARCH_REGS_USB_OTG_HS_H
 
-/* USB2.0 OTG Controller register */
-#include <linux/bitops.h>
-struct dwc2_usbotg_phy {
-	u32 phypwr;
-	u32 phyclk;
-	u32 rstcon;
-};
-
-/* Device Logical IN Endpoint-Specific Registers */
-struct dwc2_dev_in_endp {
-	u32 diepctl;
-	u8  res1[4];
-	u32 diepint;
-	u8  res2[4];
-	u32 dieptsiz;
-	u32 diepdma;
-	u8  res3[4];
-	u32 diepdmab;
-};
-
-/* Device Logical OUT Endpoint-Specific Registers */
-struct dwc2_dev_out_endp {
-	u32 doepctl;
-	u8  res1[4];
-	u32 doepint;
-	u8  res2[4];
-	u32 doeptsiz;
-	u32 doepdma;
-	u8  res3[4];
-	u32 doepdmab;
-};
-
-struct ep_fifo {
-	u32 fifo;
-	u8  res[4092];
-};
-
-/* USB2.0 OTG Controller register */
-struct dwc2_usbotg_reg {
-	/* Core Global Registers */
-	u32 gotgctl; /* OTG Control & Status */
-	u32 gotgint; /* OTG Interrupt */
-	u32 gahbcfg; /* Core AHB Configuration */
-	u32 gusbcfg; /* Core USB Configuration */
-	u32 grstctl; /* Core Reset */
-	u32 gintsts; /* Core Interrupt */
-	u32 gintmsk; /* Core Interrupt Mask */
-	u32 grxstsr; /* Receive Status Debug Read/Status Read */
-	u32 grxstsp; /* Receive Status Debug Pop/Status Pop */
-	u32 grxfsiz; /* Receive FIFO Size */
-	u32 gnptxfsiz; /* Non-Periodic Transmit FIFO Size */
-	u8  res0[12];
-	u32 ggpio;     /* 0x038 */
-	u8  res1[20];
-	u32 ghwcfg4; /* User HW Config4 */
-	u8  res2[176];
-	u32 dieptxf[15]; /* Device Periodic Transmit FIFO size register */
-	u8  res3[1728];
-	/* Device Configuration */
-	u32 dcfg; /* Device Configuration Register */
-	u32 dctl; /* Device Control */
-	u32 dsts; /* Device Status */
-	u8  res4[4];
-	u32 diepmsk; /* Device IN Endpoint Common Interrupt Mask */
-	u32 doepmsk; /* Device OUT Endpoint Common Interrupt Mask */
-	u32 daint; /* Device All Endpoints Interrupt */
-	u32 daintmsk; /* Device All Endpoints Interrupt Mask */
-	u8  res5[224];
-	struct dwc2_dev_in_endp in_endp[16];
-	struct dwc2_dev_out_endp out_endp[16];
-	u8  res6[768];
-	struct ep_fifo ep[16];
-};
-
-/*===================================================================== */
-/*definitions related to CSR setting */
-
-/* DWC2_UDC_OTG_GOTGCTL */
-#define B_SESSION_VALID			BIT(19)
-#define A_SESSION_VALID			BIT(18)
-#define B_VALOVAL			BIT(7)
-#define B_VALOEN			BIT(6)
-#define A_VALOVAL			BIT(5)
-#define A_VALOEN			BIT(4)
-#define VB_VALOVAL			BIT(3)
-#define VB_VALOEN			BIT(2)
-
-/* DWC2_UDC_OTG_GOTINT */
-#define GOTGINT_SES_END_DET		(1<<2)
-
-/* DWC2_UDC_OTG_GAHBCFG */
-#define PTXFE_HALF			(0<<8)
-#define PTXFE_ZERO			(1<<8)
-#define NPTXFE_HALF			(0<<7)
-#define NPTXFE_ZERO			(1<<7)
-#define MODE_SLAVE			(0<<5)
-#define MODE_DMA			(1<<5)
-#define BURST_SINGLE			(0<<1)
-#define BURST_INCR			(1<<1)
-#define BURST_INCR4			(3<<1)
-#define BURST_INCR8			(5<<1)
-#define BURST_INCR16			(7<<1)
-#define GBL_INT_UNMASK			(1<<0)
-#define GBL_INT_MASK			(0<<0)
-
-/* DWC2_UDC_OTG_GRSTCTL */
-#define AHB_MASTER_IDLE		(1u<<31)
-#define CORE_SOFT_RESET		(0x1<<0)
-
-/* DWC2_UDC_OTG_GINTSTS/DWC2_UDC_OTG_GINTMSK core interrupt register */
-#define INT_RESUME			(1u<<31)
-#define INT_DISCONN			(0x1<<29)
-#define INT_CONN_ID_STS_CNG		(0x1<<28)
-#define INT_OUT_EP			(0x1<<19)
-#define INT_IN_EP			(0x1<<18)
-#define INT_ENUMDONE			(0x1<<13)
-#define INT_RESET			(0x1<<12)
-#define INT_SUSPEND			(0x1<<11)
-#define INT_EARLY_SUSPEND		(0x1<<10)
-#define INT_NP_TX_FIFO_EMPTY		(0x1<<5)
-#define INT_RX_FIFO_NOT_EMPTY		(0x1<<4)
-#define INT_SOF			(0x1<<3)
-#define INT_OTG			(0x1<<2)
-#define INT_DEV_MODE			(0x0<<0)
-#define INT_HOST_MODE			(0x1<<1)
-#define INT_GOUTNakEff			(0x01<<7)
-#define INT_GINNakEff			(0x01<<6)
+#include "../common/dwc2_core.h"
 
 #define FULL_SPEED_CONTROL_PKT_SIZE	8
 #define FULL_SPEED_BULK_PKT_SIZE	64
@@ -148,75 +22,9 @@ struct dwc2_usbotg_reg {
 #define NPTX_FIFO_SIZE			(1024)
 #define PTX_FIFO_SIZE			(384)
 
-#define DEPCTL_TXFNUM_0		(0x0<<22)
-#define DEPCTL_TXFNUM_1		(0x1<<22)
-#define DEPCTL_TXFNUM_2		(0x2<<22)
-#define DEPCTL_TXFNUM_3		(0x3<<22)
-#define DEPCTL_TXFNUM_4		(0x4<<22)
-
-/* Enumeration speed */
-#define USB_HIGH_30_60MHZ		(0x0<<1)
-#define USB_FULL_30_60MHZ		(0x1<<1)
-#define USB_LOW_6MHZ			(0x2<<1)
-#define USB_FULL_48MHZ			(0x3<<1)
-
-/* DWC2_UDC_OTG_GRXSTSP STATUS */
-#define OUT_PKT_RECEIVED		(0x2<<17)
-#define OUT_TRANSFER_COMPLELTED	(0x3<<17)
-#define SETUP_TRANSACTION_COMPLETED	(0x4<<17)
-#define SETUP_PKT_RECEIVED		(0x6<<17)
-#define GLOBAL_OUT_NAK			(0x1<<17)
-
-/* DWC2_UDC_OTG_DCTL device control register */
-#define NORMAL_OPERATION		(0x1<<0)
-#define SOFT_DISCONNECT		(0x1<<1)
-
-/* DWC2_UDC_OTG_DAINT device all endpoint interrupt register */
-#define DAINT_OUT_BIT			(16)
-#define DAINT_MASK			(0xFFFF)
-
-/* DWC2_UDC_OTG_DIEPCTL0/DOEPCTL0 device
-   control IN/OUT endpoint 0 control register */
-#define DEPCTL_EPENA			(0x1<<31)
-#define DEPCTL_EPDIS			(0x1<<30)
-#define DEPCTL_SETD1PID		(0x1<<29)
-#define DEPCTL_SETD0PID		(0x1<<28)
-#define DEPCTL_SNAK			(0x1<<27)
-#define DEPCTL_CNAK			(0x1<<26)
-#define DEPCTL_STALL			(0x1<<21)
-#define DEPCTL_TYPE_BIT		(18)
-#define DEPCTL_TYPE_MASK		(0x3<<18)
-#define DEPCTL_CTRL_TYPE		(0x0<<18)
-#define DEPCTL_ISO_TYPE		(0x1<<18)
-#define DEPCTL_BULK_TYPE		(0x2<<18)
-#define DEPCTL_INTR_TYPE		(0x3<<18)
-#define DEPCTL_USBACTEP		(0x1<<15)
-#define DEPCTL_NEXT_EP_BIT		(11)
-#define DEPCTL_MPS_BIT			(0)
-#define DEPCTL_MPS_MASK		(0x7FF)
-
-#define DEPCTL0_MPS_64			(0x0<<0)
-#define DEPCTL0_MPS_32			(0x1<<0)
-#define DEPCTL0_MPS_16			(0x2<<0)
-#define DEPCTL0_MPS_8			(0x3<<0)
 #define DEPCTL_MPS_BULK_512		(512<<0)
 #define DEPCTL_MPS_INT_MPS_16		(16<<0)
 
-#define DIEPCTL0_NEXT_EP_BIT		(11)
-
-
-/* DWC2_UDC_OTG_DIEPMSK/DOEPMSK device IN/OUT endpoint
-   common interrupt mask register */
-/* DWC2_UDC_OTG_DIEPINTn/DOEPINTn device IN/OUT endpoint interrupt register */
-#define BACK2BACK_SETUP_RECEIVED	(0x1<<6)
-#define INTKNEPMIS			(0x1<<5)
-#define INTKN_TXFEMP			(0x1<<4)
-#define NON_ISO_IN_EP_TIMEOUT		(0x1<<3)
-#define CTRL_OUT_EP_SETUP_PHASE_DONE	(0x1<<3)
-#define AHB_ERROR			(0x1<<2)
-#define EPDISBLD			(0x1<<1)
-#define TRANSFER_DONE			(0x1<<0)
-
 #define USB_PHY_CTRL_EN0                (0x1 << 0)
 
 /* OPHYPWR */
@@ -245,52 +53,13 @@ struct dwc2_usbotg_reg {
 #define EXYNOS4X12_CLK_SEL_12MHZ	(0x02 << 0)
 #define EXYNOS4X12_CLK_SEL_24MHZ	(0x05 << 0)
 
-/* Device Configuration Register DCFG */
-#define DEV_SPEED_HIGH_SPEED_20         (0x0 << 0)
-#define DEV_SPEED_FULL_SPEED_20         (0x1 << 0)
-#define DEV_SPEED_LOW_SPEED_11          (0x2 << 0)
-#define DEV_SPEED_FULL_SPEED_11         (0x3 << 0)
-#define EP_MISS_CNT(x)                  (x << 18)
-#define DEVICE_ADDRESS(x)               (x << 4)
-
-/* Core Reset Register (GRSTCTL) */
-#define TX_FIFO_FLUSH                   (0x1 << 5)
-#define RX_FIFO_FLUSH                   (0x1 << 4)
-#define TX_FIFO_NUMBER(x)               (x << 6)
-#define TX_FIFO_FLUSH_ALL               TX_FIFO_NUMBER(0x10)
-
 /* Masks definitions */
-#define GINTMSK_INIT	(INT_OUT_EP | INT_IN_EP | INT_RESUME | INT_ENUMDONE\
-			| INT_RESET | INT_SUSPEND | INT_OTG)
-#define DOEPMSK_INIT	(CTRL_OUT_EP_SETUP_PHASE_DONE | AHB_ERROR|TRANSFER_DONE)
-#define DIEPMSK_INIT	(NON_ISO_IN_EP_TIMEOUT|AHB_ERROR|TRANSFER_DONE)
-#define GAHBCFG_INIT	(PTXFE_HALF | NPTXFE_HALF | MODE_DMA | BURST_INCR4\
-			| GBL_INT_UNMASK)
-
-/* Device Endpoint X Transfer Size Register (DIEPTSIZX) */
-#define DIEPT_SIZ_PKT_CNT(x)                      (x << 19)
-#define DIEPT_SIZ_XFER_SIZE(x)                    (x << 0)
-
-/* Device OUT Endpoint X Transfer Size Register (DOEPTSIZX) */
-#define DOEPT_SIZ_PKT_CNT(x)                      (x << 19)
-#define DOEPT_SIZ_XFER_SIZE(x)                    (x << 0)
-#define DOEPT_SIZ_XFER_SIZE_MAX_EP0               (0x7F << 0)
-#define DOEPT_SIZ_XFER_SIZE_MAX_EP                (0x7FFF << 0)
-
-/* Device Endpoint-N Control Register (DIEPCTLn/DOEPCTLn) */
-#define DIEPCTL_TX_FIFO_NUM(x)                    (x << 22)
-#define DIEPCTL_TX_FIFO_NUM_MASK                  (~DIEPCTL_TX_FIFO_NUM(0xF))
-
-/* Device ALL Endpoints Interrupt Register (DAINT) */
-#define DAINT_IN_EP_INT(x)                        (x << 0)
-#define DAINT_OUT_EP_INT(x)                       (x << 16)
-
-/* User HW Config4 */
-#define GHWCFG4_NUM_IN_EPS_MASK		(0xf << 26)
-#define GHWCFG4_NUM_IN_EPS_SHIFT	26
-
-/* OTG general core configuration register (OTG_GCCFG:0x38) for STM32MP1 */
-#define GGPIO_STM32_OTG_GCCFG_VBDEN               BIT(21)
-#define GGPIO_STM32_OTG_GCCFG_IDEN                BIT(22)
+#define GINTMSK_INIT	(GINTSTS_WKUPINT | GINTSTS_OEPINT | GINTSTS_IEPINT | GINTSTS_ENUMDONE | \
+			 GINTSTS_USBRST | GINTSTS_USBSUSP | GINTSTS_OTGINT)
+#define DOEPMSK_INIT	(DOEPMSK_SETUPMSK | DOEPMSK_AHBERRMSK | DOEPMSK_XFERCOMPLMSK)
+#define DIEPMSK_INIT	(DIEPMSK_TIMEOUTMSK | DIEPMSK_AHBERRMSK | DIEPMSK_XFERCOMPLMSK)
+#define GAHBCFG_INIT	(GAHBCFG_DMA_EN | \
+			 FIELD_PREP(GAHBCFG_HBSTLEN_MASK, GAHBCFG_HBSTLEN_INCR4) | \
+			 GAHBCFG_GLBL_INTR_EN)
 
 #endif
diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index 1c34b75351..faba63c87e 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -20,6 +20,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 
 static u8 clear_feature_num;
@@ -33,15 +34,16 @@ static inline void dwc2_udc_ep0_zlp(struct dwc2_udc *dev)
 {
 	u32 ep_ctrl;
 
-	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr), &reg->in_endp[EP0_CON].diepdma);
-	writel(DIEPT_SIZ_PKT_CNT(1), &reg->in_endp[EP0_CON].dieptsiz);
+	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
+	       &reg->device_regs.in_endp[EP0_CON].diepdma);
+	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1), &reg->device_regs.in_endp[EP0_CON].dieptsiz);
 
-	ep_ctrl = readl(&reg->in_endp[EP0_CON].diepctl);
-	writel(ep_ctrl|DEPCTL_EPENA|DEPCTL_CNAK,
-	       &reg->in_endp[EP0_CON].diepctl);
+	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
+	writel(ep_ctrl | DXEPCTL_EPENA | DXEPCTL_CNAK,
+	       &reg->device_regs.in_endp[EP0_CON].diepctl);
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->in_endp[EP0_CON].diepctl));
+		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	dev->ep0state = WAIT_FOR_IN_COMPLETE;
 }
 
@@ -52,17 +54,18 @@ static void dwc2_udc_pre_setup(void)
 	debug_cond(DEBUG_IN_EP,
 		   "%s : Prepare Setup packets.\n", __func__);
 
-	writel(DOEPT_SIZ_PKT_CNT(1) | sizeof(struct usb_ctrlrequest),
-	       &reg->out_endp[EP0_CON].doeptsiz);
-	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr), &reg->out_endp[EP0_CON].doepdma);
+	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | sizeof(struct usb_ctrlrequest),
+	       &reg->device_regs.out_endp[EP0_CON].doeptsiz);
+	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
+	       &reg->device_regs.out_endp[EP0_CON].doepdma);
 
-	ep_ctrl = readl(&reg->out_endp[EP0_CON].doepctl);
-	writel(ep_ctrl|DEPCTL_EPENA, &reg->out_endp[EP0_CON].doepctl);
+	ep_ctrl = readl(&reg->device_regs.out_endp[EP0_CON].doepctl);
+	writel(ep_ctrl | DXEPCTL_EPENA, &reg->device_regs.out_endp[EP0_CON].doepctl);
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->in_endp[EP0_CON].diepctl));
+		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DOEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->out_endp[EP0_CON].doepctl));
+		__func__, readl(&reg->device_regs.out_endp[EP0_CON].doepctl));
 
 }
 
@@ -71,25 +74,26 @@ static inline void dwc2_ep0_complete_out(void)
 	u32 ep_ctrl;
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->in_endp[EP0_CON].diepctl));
+		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DOEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->out_endp[EP0_CON].doepctl));
+		__func__, readl(&reg->device_regs.out_endp[EP0_CON].doepctl));
 
 	debug_cond(DEBUG_IN_EP,
 		"%s : Prepare Complete Out packet.\n", __func__);
 
-	writel(DOEPT_SIZ_PKT_CNT(1) | sizeof(struct usb_ctrlrequest),
-	       &reg->out_endp[EP0_CON].doeptsiz);
-	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr), &reg->out_endp[EP0_CON].doepdma);
+	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | sizeof(struct usb_ctrlrequest),
+	       &reg->device_regs.out_endp[EP0_CON].doeptsiz);
+	writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
+	       &reg->device_regs.out_endp[EP0_CON].doepdma);
 
-	ep_ctrl = readl(&reg->out_endp[EP0_CON].doepctl);
-	writel(ep_ctrl|DEPCTL_EPENA|DEPCTL_CNAK,
-	       &reg->out_endp[EP0_CON].doepctl);
+	ep_ctrl = readl(&reg->device_regs.out_endp[EP0_CON].doepctl);
+	writel(ep_ctrl | DXEPCTL_EPENA | DXEPCTL_CNAK,
+	       &reg->device_regs.out_endp[EP0_CON].doepctl);
 
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DIEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->in_endp[EP0_CON].diepctl));
+		__func__, readl(&reg->device_regs.in_endp[EP0_CON].diepctl));
 	debug_cond(DEBUG_EP0 != 0, "%s:EP0 ZLP DOEPCTL0 = 0x%x\n",
-		__func__, readl(&reg->out_endp[EP0_CON].doepctl));
+		__func__, readl(&reg->device_regs.out_endp[EP0_CON].doepctl));
 
 }
 
@@ -112,25 +116,26 @@ static int setdma_rx(struct dwc2_ep *ep, struct dwc2_request *req)
 	else
 		pktcnt = (length - 1)/(ep->ep.maxpacket) + 1;
 
-	ctrl =  readl(&reg->out_endp[ep_num].doepctl);
+	ctrl =  readl(&reg->device_regs.out_endp[ep_num].doepctl);
 
 	invalidate_dcache_range((unsigned long) ep->dma_buf,
 				(unsigned long) ep->dma_buf +
 				ROUND(ep->len, CONFIG_SYS_CACHELINE_SIZE));
 
-	writel(phys_to_bus((unsigned long)ep->dma_buf), &reg->out_endp[ep_num].doepdma);
-	writel(DOEPT_SIZ_PKT_CNT(pktcnt) | DOEPT_SIZ_XFER_SIZE(length),
-	       &reg->out_endp[ep_num].doeptsiz);
-	writel(DEPCTL_EPENA|DEPCTL_CNAK|ctrl, &reg->out_endp[ep_num].doepctl);
+	writel(phys_to_bus((unsigned long)ep->dma_buf), &reg->device_regs.out_endp[ep_num].doepdma);
+	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
+	       FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
+	       &reg->device_regs.out_endp[ep_num].doeptsiz);
+	writel(DXEPCTL_EPENA | DXEPCTL_CNAK | ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
 
 	debug_cond(DEBUG_OUT_EP != 0,
 		   "%s: EP%d RX DMA start : DOEPDMA = 0x%x,"
 		   "DOEPTSIZ = 0x%x, DOEPCTL = 0x%x\n"
 		   "\tbuf = 0x%p, pktcnt = %d, xfersize = %d\n",
 		   __func__, ep_num,
-		   readl(&reg->out_endp[ep_num].doepdma),
-		   readl(&reg->out_endp[ep_num].doeptsiz),
-		   readl(&reg->out_endp[ep_num].doepctl),
+		   readl(&reg->device_regs.out_endp[ep_num].doepdma),
+		   readl(&reg->device_regs.out_endp[ep_num].doeptsiz),
+		   readl(&reg->device_regs.out_endp[ep_num].doepctl),
 		   buf, pktcnt, length);
 	return 0;
 
@@ -161,34 +166,32 @@ static int setdma_tx(struct dwc2_ep *ep, struct dwc2_request *req)
 		pktcnt = (length - 1)/(ep->ep.maxpacket) + 1;
 
 	/* Flush the endpoint's Tx FIFO */
-	writel(TX_FIFO_NUMBER(ep->fifo_num), &reg->grstctl);
-	writel(TX_FIFO_NUMBER(ep->fifo_num) | TX_FIFO_FLUSH, &reg->grstctl);
-	while (readl(&reg->grstctl) & TX_FIFO_FLUSH)
-		;
+	dwc2_flush_tx_fifo(reg, ep->fifo_num);
 
-	writel(phys_to_bus((unsigned long)ep->dma_buf), &reg->in_endp[ep_num].diepdma);
-	writel(DIEPT_SIZ_PKT_CNT(pktcnt) | DIEPT_SIZ_XFER_SIZE(length),
-	       &reg->in_endp[ep_num].dieptsiz);
+	writel(phys_to_bus((unsigned long)ep->dma_buf), &reg->device_regs.in_endp[ep_num].diepdma);
+	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
+	       FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
+	       &reg->device_regs.in_endp[ep_num].dieptsiz);
 
-	ctrl = readl(&reg->in_endp[ep_num].diepctl);
+	ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
 
 	/* Write the FIFO number to be used for this endpoint */
-	ctrl &= DIEPCTL_TX_FIFO_NUM_MASK;
-	ctrl |= DIEPCTL_TX_FIFO_NUM(ep->fifo_num);
+	ctrl &= ~DXEPCTL_TXFNUM_MASK;
+	ctrl |= FIELD_PREP(DXEPCTL_TXFNUM_MASK, ep->fifo_num);
 
 	/* Clear reserved (Next EP) bits */
-	ctrl = (ctrl&~(EP_MASK<<DEPCTL_NEXT_EP_BIT));
+	ctrl &= ~DXEPCTL_NEXTEP_MASK;
 
-	writel(DEPCTL_EPENA|DEPCTL_CNAK|ctrl, &reg->in_endp[ep_num].diepctl);
+	writel(DXEPCTL_EPENA | DXEPCTL_CNAK | ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
 
 	debug_cond(DEBUG_IN_EP,
 		"%s:EP%d TX DMA start : DIEPDMA0 = 0x%x,"
 		"DIEPTSIZ0 = 0x%x, DIEPCTL0 = 0x%x\n"
 		"\tbuf = 0x%p, pktcnt = %d, xfersize = %d\n",
 		__func__, ep_num,
-		readl(&reg->in_endp[ep_num].diepdma),
-		readl(&reg->in_endp[ep_num].dieptsiz),
-		readl(&reg->in_endp[ep_num].diepctl),
+		readl(&reg->device_regs.in_endp[ep_num].diepdma),
+		readl(&reg->device_regs.in_endp[ep_num].dieptsiz),
+		readl(&reg->device_regs.in_endp[ep_num].diepctl),
 		buf, pktcnt, length);
 
 	return length;
@@ -209,12 +212,12 @@ static void complete_rx(struct dwc2_udc *dev, u8 ep_num)
 	}
 
 	req = list_entry(ep->queue.next, struct dwc2_request, queue);
-	ep_tsr = readl(&reg->out_endp[ep_num].doeptsiz);
+	ep_tsr = readl(&reg->device_regs.out_endp[ep_num].doeptsiz);
 
 	if (ep_num == EP0_CON)
-		xfer_size = (ep_tsr & DOEPT_SIZ_XFER_SIZE_MAX_EP0);
+		xfer_size = FIELD_PREP(DIEPTSIZ0_XFERSIZE_MASK, ep_tsr);
 	else
-		xfer_size = (ep_tsr & DOEPT_SIZ_XFER_SIZE_MAX_EP);
+		xfer_size = FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, ep_tsr);
 
 	xfer_size = ep->len - xfer_size;
 
@@ -290,7 +293,7 @@ static void complete_tx(struct dwc2_udc *dev, u8 ep_num)
 
 	req = list_entry(ep->queue.next, struct dwc2_request, queue);
 
-	ep_tsr = readl(&reg->in_endp[ep_num].dieptsiz);
+	ep_tsr = readl(&reg->device_regs.in_endp[ep_num].dieptsiz);
 
 	xfer_size = ep->len;
 	is_short = (xfer_size < ep->ep.maxpacket);
@@ -375,23 +378,23 @@ static void process_ep_in_intr(struct dwc2_udc *dev)
 	u32 ep_intr, ep_intr_status;
 	u8 ep_num = 0;
 
-	ep_intr = readl(&reg->daint);
+	ep_intr = readl(&reg->device_regs.daint);
 	debug_cond(DEBUG_IN_EP,
 		"*** %s: EP In interrupt : DAINT = 0x%x\n", __func__, ep_intr);
 
-	ep_intr &= DAINT_MASK;
+	ep_intr = FIELD_GET(DAINT_INEP_MASK, ep_intr);
 
 	while (ep_intr) {
-		if (ep_intr & DAINT_IN_EP_INT(1)) {
-			ep_intr_status = readl(&reg->in_endp[ep_num].diepint);
+		if (ep_intr & BIT(EP0_CON)) {
+			ep_intr_status = readl(&reg->device_regs.in_endp[ep_num].diepint);
 			debug_cond(DEBUG_IN_EP,
 				   "\tEP%d-IN : DIEPINT = 0x%x\n",
 				   ep_num, ep_intr_status);
 
 			/* Interrupt Clear */
-			writel(ep_intr_status, &reg->in_endp[ep_num].diepint);
+			writel(ep_intr_status, &reg->device_regs.in_endp[ep_num].diepint);
 
-			if (ep_intr_status & TRANSFER_DONE) {
+			if (ep_intr_status & DIEPMSK_XFERCOMPLMSK) {
 				complete_tx(dev, ep_num);
 
 				if (ep_num == 0) {
@@ -422,31 +425,30 @@ static void process_ep_out_intr(struct dwc2_udc *dev)
 	u32 ep_intr, ep_intr_status;
 	u8 ep_num = 0;
 	u32 ep_tsr = 0, xfer_size = 0;
-	u32 epsiz_reg = reg->out_endp[ep_num].doeptsiz;
+	u32 epsiz_reg = reg->device_regs.out_endp[ep_num].doeptsiz;
 	u32 req_size = sizeof(struct usb_ctrlrequest);
 
-	ep_intr = readl(&reg->daint);
+	ep_intr = readl(&reg->device_regs.daint);
 	debug_cond(DEBUG_OUT_EP != 0,
 		   "*** %s: EP OUT interrupt : DAINT = 0x%x\n",
 		   __func__, ep_intr);
 
-	ep_intr = (ep_intr >> DAINT_OUT_BIT) & DAINT_MASK;
+	ep_intr = FIELD_GET(DAINT_OUTEP_MASK, ep_intr);
 
 	while (ep_intr) {
-		if (ep_intr & 0x1) {
-			ep_intr_status = readl(&reg->out_endp[ep_num].doepint);
+		if (ep_intr & BIT(EP0_CON)) {
+			ep_intr_status = readl(&reg->device_regs.out_endp[ep_num].doepint);
 			debug_cond(DEBUG_OUT_EP != 0,
 				   "\tEP%d-OUT : DOEPINT = 0x%x\n",
 				   ep_num, ep_intr_status);
 
 			/* Interrupt Clear */
-			writel(ep_intr_status, &reg->out_endp[ep_num].doepint);
+			writel(ep_intr_status, &reg->device_regs.out_endp[ep_num].doepint);
 
 			if (ep_num == 0) {
-				if (ep_intr_status & TRANSFER_DONE) {
+				if (ep_intr_status & DOEPMSK_XFERCOMPLMSK) {
 					ep_tsr = readl(&epsiz_reg);
-					xfer_size = ep_tsr &
-						   DOEPT_SIZ_XFER_SIZE_MAX_EP0;
+					xfer_size = ep_tsr & DOEPTSIZ0_XFERSIZE_MASK;
 
 					if (xfer_size == req_size &&
 					    dev->ep0state == WAIT_FOR_SETUP) {
@@ -460,14 +462,13 @@ static void process_ep_out_intr(struct dwc2_udc *dev)
 					}
 				}
 
-				if (ep_intr_status &
-				    CTRL_OUT_EP_SETUP_PHASE_DONE) {
+				if (ep_intr_status & DOEPMSK_SETUPMSK) {
 					debug_cond(DEBUG_OUT_EP != 0,
 						   "SETUP packet arrived\n");
 					dwc2_handle_ep0(dev);
 				}
 			} else {
-				if (ep_intr_status & TRANSFER_DONE)
+				if (ep_intr_status & DOEPMSK_XFERCOMPLMSK)
 					complete_rx(dev, ep_num);
 			}
 		}
@@ -488,27 +489,27 @@ static int dwc2_udc_irq(int irq, void *_dev)
 
 	spin_lock_irqsave(&dev->lock, flags);
 
-	intr_status = readl(&reg->gintsts);
-	gintmsk = readl(&reg->gintmsk);
+	intr_status = readl(&reg->global_regs.gintsts);
+	gintmsk = readl(&reg->global_regs.gintmsk);
 
 	debug_cond(DEBUG_ISR,
 		  "\n*** %s : GINTSTS=0x%x(on state %s), GINTMSK : 0x%x,"
 		  "DAINT : 0x%x, DAINTMSK : 0x%x\n",
 		  __func__, intr_status, state_names[dev->ep0state], gintmsk,
-		  readl(&reg->daint), readl(&reg->daintmsk));
+		  readl(&reg->device_regs.daint), readl(&reg->device_regs.daintmsk));
 
 	if (!intr_status) {
 		spin_unlock_irqrestore(&dev->lock, flags);
 		return IRQ_HANDLED;
 	}
 
-	if (intr_status & INT_ENUMDONE) {
+	if (intr_status & GINTSTS_ENUMDONE) {
 		debug_cond(DEBUG_ISR, "\tSpeed Detection interrupt\n");
 
-		writel(INT_ENUMDONE, &reg->gintsts);
-		usb_status = (readl(&reg->dsts) & 0x6);
+		writel(GINTSTS_ENUMDONE, &reg->global_regs.gintsts);
+		usb_status = FIELD_GET(DSTS_ENUMSPD_MASK, readl(&reg->device_regs.dsts));
 
-		if (usb_status & (USB_FULL_30_60MHZ | USB_FULL_48MHZ)) {
+		if (usb_status != DSTS_ENUMSPD_HS) {
 			debug_cond(DEBUG_ISR,
 				   "\t\tFull Speed Detection\n");
 			set_max_pktsize(dev, USB_SPEED_FULL);
@@ -521,16 +522,16 @@ static int dwc2_udc_irq(int irq, void *_dev)
 		}
 	}
 
-	if (intr_status & INT_EARLY_SUSPEND) {
+	if (intr_status & GINTSTS_ERLYSUSP) {
 		debug_cond(DEBUG_ISR, "\tEarly suspend interrupt\n");
-		writel(INT_EARLY_SUSPEND, &reg->gintsts);
+		writel(GINTSTS_ERLYSUSP, &reg->global_regs.gintsts);
 	}
 
-	if (intr_status & INT_SUSPEND) {
-		usb_status = readl(&reg->dsts);
+	if (intr_status & GINTSTS_USBSUSP) {
+		usb_status = readl(&reg->device_regs.dsts);
 		debug_cond(DEBUG_ISR,
 			"\tSuspend interrupt :(DSTS):0x%x\n", usb_status);
-		writel(INT_SUSPEND, &reg->gintsts);
+		writel(GINTSTS_USBSUSP, &reg->global_regs.gintsts);
 
 		if (dev->gadget.speed != USB_SPEED_UNKNOWN
 		    && dev->driver) {
@@ -539,8 +540,8 @@ static int dwc2_udc_irq(int irq, void *_dev)
 		}
 	}
 
-	if (intr_status & INT_OTG) {
-		gotgint = readl(&reg->gotgint);
+	if (intr_status & GINTSTS_OTGINT) {
+		gotgint = readl(&reg->global_regs.gotgint);
 		debug_cond(DEBUG_ISR,
 			   "\tOTG interrupt: (GOTGINT):0x%x\n", gotgint);
 
@@ -553,12 +554,12 @@ static int dwc2_udc_irq(int irq, void *_dev)
 				spin_lock_irqsave(&dev->lock, flags);
 			}
 		}
-		writel(gotgint, &reg->gotgint);
+		writel(gotgint, &reg->global_regs.gotgint);
 	}
 
-	if (intr_status & INT_RESUME) {
+	if (intr_status & GINTSTS_WKUPINT) {
 		debug_cond(DEBUG_ISR, "\tResume interrupt\n");
-		writel(INT_RESUME, &reg->gintsts);
+		writel(GINTSTS_WKUPINT, &reg->global_regs.gintsts);
 
 		if (dev->gadget.speed != USB_SPEED_UNKNOWN
 		    && dev->driver
@@ -568,13 +569,13 @@ static int dwc2_udc_irq(int irq, void *_dev)
 		}
 	}
 
-	if (intr_status & INT_RESET) {
-		usb_status = readl(&reg->gotgctl);
+	if (intr_status & GINTSTS_USBRST) {
+		usb_status = readl(&reg->global_regs.gotgctl);
 		debug_cond(DEBUG_ISR,
 			"\tReset interrupt - (GOTGCTL):0x%x\n", usb_status);
-		writel(INT_RESET, &reg->gintsts);
+		writel(GINTSTS_USBRST, &reg->global_regs.gintsts);
 
-		if ((usb_status & 0xc0000) == (0x3 << 18)) {
+		if (usb_status & (GOTGCTL_ASESVLD | GOTGCTL_BSESVLD)) {
 			if (reset_available) {
 				debug_cond(DEBUG_ISR,
 					"\t\tOTG core got reset (%d)!!\n",
@@ -593,10 +594,10 @@ static int dwc2_udc_irq(int irq, void *_dev)
 		}
 	}
 
-	if (intr_status & INT_IN_EP)
+	if (intr_status & GINTSTS_IEPINT)
 		process_ep_in_intr(dev);
 
-	if (intr_status & INT_OUT_EP)
+	if (intr_status & GINTSTS_OEPINT)
 		process_ep_out_intr(dev);
 
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -678,14 +679,14 @@ static int dwc2_queue(struct usb_ep *_ep, struct usb_request *_req,
 			req = 0;
 
 		} else if (ep_is_in(ep)) {
-			gintsts = readl(&reg->gintsts);
+			gintsts = readl(&reg->global_regs.gintsts);
 			debug_cond(DEBUG_IN_EP,
 				   "%s: ep_is_in, DWC2_UDC_OTG_GINTSTS=0x%x\n",
 				   __func__, gintsts);
 
 			setdma_tx(ep, req);
 		} else {
-			gintsts = readl(&reg->gintsts);
+			gintsts = readl(&reg->global_regs.gintsts);
 			debug_cond(DEBUG_OUT_EP != 0,
 				   "%s:ep_is_out, DWC2_UDC_OTG_GINTSTS=0x%x\n",
 				   __func__, gintsts);
@@ -767,14 +768,15 @@ static int dwc2_fifo_read(struct dwc2_ep *ep, void *cp, int max)
  */
 static void udc_set_address(struct dwc2_udc *dev, unsigned char address)
 {
-	u32 ctrl = readl(&reg->dcfg);
-	writel(DEVICE_ADDRESS(address) | ctrl, &reg->dcfg);
+	u32 ctrl = readl(&reg->device_regs.dcfg);
+
+	writel(FIELD_PREP(DCFG_DEVADDR_MASK, address) | ctrl, &reg->device_regs.dcfg);
 
 	dwc2_udc_ep0_zlp(dev);
 
 	debug_cond(DEBUG_EP0 != 0,
 		   "%s: USB OTG 2.0 Device address=%d, DCFG=0x%x\n",
-		   __func__, address, readl(&reg->dcfg));
+		   __func__, address, readl(&reg->device_regs.dcfg));
 
 	dev->usb_address = address;
 }
@@ -785,19 +787,19 @@ static inline void dwc2_udc_ep0_set_stall(struct dwc2_ep *ep)
 	u32		ep_ctrl = 0;
 
 	dev = ep->dev;
-	ep_ctrl = readl(&reg->in_endp[EP0_CON].diepctl);
+	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
 
 	/* set the disable and stall bits */
-	if (ep_ctrl & DEPCTL_EPENA)
-		ep_ctrl |= DEPCTL_EPDIS;
+	if (ep_ctrl & DXEPCTL_EPENA)
+		ep_ctrl |= DXEPCTL_EPDIS;
 
-	ep_ctrl |= DEPCTL_STALL;
+	ep_ctrl |= DXEPCTL_STALL;
 
-	writel(ep_ctrl, &reg->in_endp[EP0_CON].diepctl);
+	writel(ep_ctrl, &reg->device_regs.in_endp[EP0_CON].diepctl);
 
 	debug_cond(DEBUG_EP0 != 0,
 		   "%s: set ep%d stall, DIEPCTL0 = 0x%p\n",
-		   __func__, ep_index(ep), &reg->in_endp[EP0_CON].diepctl);
+		   __func__, ep_index(ep), &reg->device_regs.in_endp[EP0_CON].diepctl);
 	/*
 	 * The application can only set this bit, and the core clears it,
 	 * when a SETUP token is received for this endpoint
@@ -936,13 +938,13 @@ static int dwc2_udc_get_status(struct dwc2_udc *dev,
 			   (unsigned long) usb_ctrl +
 			   ROUND(sizeof(g_status), CONFIG_SYS_CACHELINE_SIZE));
 
-	writel(phys_to_bus(usb_ctrl_dma_addr), &reg->in_endp[EP0_CON].diepdma);
-	writel(DIEPT_SIZ_PKT_CNT(1) | DIEPT_SIZ_XFER_SIZE(2),
-	       &reg->in_endp[EP0_CON].dieptsiz);
+	writel(phys_to_bus(usb_ctrl_dma_addr), &reg->device_regs.in_endp[EP0_CON].diepdma);
+	writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, 2),
+	       &reg->device_regs.in_endp[EP0_CON].dieptsiz);
 
-	ep_ctrl = readl(&reg->in_endp[EP0_CON].diepctl);
-	writel(ep_ctrl|DEPCTL_EPENA|DEPCTL_CNAK,
-	       &reg->in_endp[EP0_CON].diepctl);
+	ep_ctrl = readl(&reg->device_regs.in_endp[EP0_CON].diepctl);
+	writel(ep_ctrl | DXEPCTL_EPENA | DXEPCTL_CNAK,
+	       &reg->device_regs.in_endp[EP0_CON].diepctl);
 	dev->ep0state = WAIT_FOR_NULL_COMPLETE;
 
 	return 0;
@@ -957,17 +959,17 @@ static void dwc2_udc_set_nak(struct dwc2_ep *ep)
 	debug("%s: ep_num = %d, ep_type = %d\n", __func__, ep_num, ep->ep_type);
 
 	if (ep_is_in(ep)) {
-		ep_ctrl = readl(&reg->in_endp[ep_num].diepctl);
-		ep_ctrl |= DEPCTL_SNAK;
-		writel(ep_ctrl, &reg->in_endp[ep_num].diepctl);
+		ep_ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
+		ep_ctrl |= DXEPCTL_SNAK;
+		writel(ep_ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
 		debug("%s: set NAK, DIEPCTL%d = 0x%x\n",
-			__func__, ep_num, readl(&reg->in_endp[ep_num].diepctl));
+			__func__, ep_num, readl(&reg->device_regs.in_endp[ep_num].diepctl));
 	} else {
-		ep_ctrl = readl(&reg->out_endp[ep_num].doepctl);
-		ep_ctrl |= DEPCTL_SNAK;
-		writel(ep_ctrl, &reg->out_endp[ep_num].doepctl);
+		ep_ctrl = readl(&reg->device_regs.out_endp[ep_num].doepctl);
+		ep_ctrl |= DXEPCTL_SNAK;
+		writel(ep_ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
 		debug("%s: set NAK, DOEPCTL%d = 0x%x\n",
-		      __func__, ep_num, readl(&reg->out_endp[ep_num].doepctl));
+		      __func__, ep_num, readl(&reg->device_regs.out_endp[ep_num].doepctl));
 	}
 
 	return;
@@ -983,27 +985,27 @@ static void dwc2_udc_ep_set_stall(struct dwc2_ep *ep)
 	debug("%s: ep_num = %d, ep_type = %d\n", __func__, ep_num, ep->ep_type);
 
 	if (ep_is_in(ep)) {
-		ep_ctrl = readl(&reg->in_endp[ep_num].diepctl);
+		ep_ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
 
 		/* set the disable and stall bits */
-		if (ep_ctrl & DEPCTL_EPENA)
-			ep_ctrl |= DEPCTL_EPDIS;
+		if (ep_ctrl & DXEPCTL_EPENA)
+			ep_ctrl |= DXEPCTL_EPDIS;
 
-		ep_ctrl |= DEPCTL_STALL;
+		ep_ctrl |= DXEPCTL_STALL;
 
-		writel(ep_ctrl, &reg->in_endp[ep_num].diepctl);
+		writel(ep_ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
 		debug("%s: set stall, DIEPCTL%d = 0x%x\n",
-		      __func__, ep_num, readl(&reg->in_endp[ep_num].diepctl));
+		      __func__, ep_num, readl(&reg->device_regs.in_endp[ep_num].diepctl));
 
 	} else {
-		ep_ctrl = readl(&reg->out_endp[ep_num].doepctl);
+		ep_ctrl = readl(&reg->device_regs.out_endp[ep_num].doepctl);
 
 		/* set the stall bit */
-		ep_ctrl |= DEPCTL_STALL;
+		ep_ctrl |= DXEPCTL_STALL;
 
-		writel(ep_ctrl, &reg->out_endp[ep_num].doepctl);
+		writel(ep_ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
 		debug("%s: set stall, DOEPCTL%d = 0x%x\n",
-		      __func__, ep_num, readl(&reg->out_endp[ep_num].doepctl));
+		      __func__, ep_num, readl(&reg->device_regs.out_endp[ep_num].doepctl));
 	}
 
 	return;
@@ -1018,10 +1020,10 @@ static void dwc2_udc_ep_clear_stall(struct dwc2_ep *ep)
 	debug("%s: ep_num = %d, ep_type = %d\n", __func__, ep_num, ep->ep_type);
 
 	if (ep_is_in(ep)) {
-		ep_ctrl = readl(&reg->in_endp[ep_num].diepctl);
+		ep_ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
 
 		/* clear stall bit */
-		ep_ctrl &= ~DEPCTL_STALL;
+		ep_ctrl &= ~DXEPCTL_STALL;
 
 		/*
 		 * USB Spec 9.4.5: For endpoints using data toggle, regardless
@@ -1031,27 +1033,27 @@ static void dwc2_udc_ep_clear_stall(struct dwc2_ep *ep)
 		 */
 		if (ep->bmAttributes == USB_ENDPOINT_XFER_INT
 		    || ep->bmAttributes == USB_ENDPOINT_XFER_BULK) {
-			ep_ctrl |= DEPCTL_SETD0PID; /* DATA0 */
+			ep_ctrl |= DXEPCTL_SETD0PID; /* DATA0 */
 		}
 
-		writel(ep_ctrl, &reg->in_endp[ep_num].diepctl);
+		writel(ep_ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
 		debug("%s: cleared stall, DIEPCTL%d = 0x%x\n",
-			__func__, ep_num, readl(&reg->in_endp[ep_num].diepctl));
+			__func__, ep_num, readl(&reg->device_regs.in_endp[ep_num].diepctl));
 
 	} else {
-		ep_ctrl = readl(&reg->out_endp[ep_num].doepctl);
+		ep_ctrl = readl(&reg->device_regs.out_endp[ep_num].doepctl);
 
 		/* clear stall bit */
-		ep_ctrl &= ~DEPCTL_STALL;
+		ep_ctrl &= ~DXEPCTL_STALL;
 
 		if (ep->bmAttributes == USB_ENDPOINT_XFER_INT
 		    || ep->bmAttributes == USB_ENDPOINT_XFER_BULK) {
-			ep_ctrl |= DEPCTL_SETD0PID; /* DATA0 */
+			ep_ctrl |= DXEPCTL_SETD0PID; /* DATA0 */
 		}
 
-		writel(ep_ctrl, &reg->out_endp[ep_num].doepctl);
+		writel(ep_ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
 		debug("%s: cleared stall, DOEPCTL%d = 0x%x\n",
-		      __func__, ep_num, readl(&reg->out_endp[ep_num].doepctl));
+		      __func__, ep_num, readl(&reg->device_regs.out_endp[ep_num].doepctl));
 	}
 
 	return;
@@ -1113,11 +1115,11 @@ static void dwc2_udc_ep_activate(struct dwc2_ep *ep)
 
 	/* Read DEPCTLn register */
 	if (ep_is_in(ep)) {
-		ep_ctrl = readl(&reg->in_endp[ep_num].diepctl);
-		daintmsk = 1 << ep_num;
+		ep_ctrl = readl(&reg->device_regs.in_endp[ep_num].diepctl);
+		daintmsk = FIELD_PREP(DAINT_INEP_MASK, BIT(ep_num));
 	} else {
-		ep_ctrl = readl(&reg->out_endp[ep_num].doepctl);
-		daintmsk = (1 << ep_num) << DAINT_OUT_BIT;
+		ep_ctrl = readl(&reg->device_regs.out_endp[ep_num].doepctl);
+		daintmsk = FIELD_PREP(DAINT_OUTEP_MASK, BIT(ep_num));
 	}
 
 	debug("%s: EPCTRL%d = 0x%x, ep_is_in = %d\n",
@@ -1125,29 +1127,29 @@ static void dwc2_udc_ep_activate(struct dwc2_ep *ep)
 
 	/* If the EP is already active don't change the EP Control
 	 * register. */
-	if (!(ep_ctrl & DEPCTL_USBACTEP)) {
-		ep_ctrl = (ep_ctrl & ~DEPCTL_TYPE_MASK) |
-			(ep->bmAttributes << DEPCTL_TYPE_BIT);
-		ep_ctrl = (ep_ctrl & ~DEPCTL_MPS_MASK) |
-			(ep->ep.maxpacket << DEPCTL_MPS_BIT);
-		ep_ctrl |= (DEPCTL_SETD0PID | DEPCTL_USBACTEP | DEPCTL_SNAK);
+	if (!(ep_ctrl & DXEPCTL_USBACTEP)) {
+		ep_ctrl = (ep_ctrl & ~DXEPCTL_EPTYPE_MASK) |
+			FIELD_PREP(DXEPCTL_EPTYPE_MASK, ep->bmAttributes);
+		ep_ctrl = (ep_ctrl & ~DXEPCTL_MPS_MASK) |
+			FIELD_PREP(DXEPCTL_MPS_MASK, ep->ep.maxpacket);
+		ep_ctrl |= (DXEPCTL_SETD0PID | DXEPCTL_USBACTEP | DXEPCTL_SNAK);
 
 		if (ep_is_in(ep)) {
-			writel(ep_ctrl, &reg->in_endp[ep_num].diepctl);
+			writel(ep_ctrl, &reg->device_regs.in_endp[ep_num].diepctl);
 			debug("%s: USB Ative EP%d, DIEPCTRL%d = 0x%x\n",
 			      __func__, ep_num, ep_num,
-			      readl(&reg->in_endp[ep_num].diepctl));
+			      readl(&reg->device_regs.in_endp[ep_num].diepctl));
 		} else {
-			writel(ep_ctrl, &reg->out_endp[ep_num].doepctl);
+			writel(ep_ctrl, &reg->device_regs.out_endp[ep_num].doepctl);
 			debug("%s: USB Ative EP%d, DOEPCTRL%d = 0x%x\n",
 			      __func__, ep_num, ep_num,
-			      readl(&reg->out_endp[ep_num].doepctl));
+			      readl(&reg->device_regs.out_endp[ep_num].doepctl));
 		}
 	}
 
 	/* Unmask EP Interrtupt */
-	writel(readl(&reg->daintmsk)|daintmsk, &reg->daintmsk);
-	debug("%s: DAINTMSK = 0x%x\n", __func__, readl(&reg->daintmsk));
+	writel(readl(&reg->device_regs.daintmsk) | daintmsk, &reg->device_regs.daintmsk);
+	debug("%s: DAINTMSK = 0x%x\n", __func__, readl(&reg->device_regs.daintmsk));
 
 }
 
diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 637eb2dd06..93ed9604c2 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -20,11 +20,13 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
 #include <power/regulator.h>
 #include <reset.h>
 
+#include "../common/dwc2_core.h"
 #include "dwc2.h"
 
 /* Use only HC channel 0. */
@@ -87,68 +89,24 @@ static void init_fslspclksel(struct dwc2_core_regs *regs)
 	uint32_t phyclk;
 
 #if (DWC2_PHY_TYPE == DWC2_PHY_TYPE_FS)
-	phyclk = DWC2_HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
+	phyclk = HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
 #else
 	/* High speed PHY running at full speed or high speed */
-	phyclk = DWC2_HCFG_FSLSPCLKSEL_30_60_MHZ;
+	phyclk = HCFG_FSLSPCLKSEL_30_60_MHZ;
 #endif
 
 #ifdef DWC2_ULPI_FS_LS
-	uint32_t hwcfg2 = readl(&regs->ghwcfg2);
-	uint32_t hval = (ghwcfg2 & DWC2_HWCFG2_HS_PHY_TYPE_MASK) >>
-			DWC2_HWCFG2_HS_PHY_TYPE_OFFSET;
-	uint32_t fval = (ghwcfg2 & DWC2_HWCFG2_FS_PHY_TYPE_MASK) >>
-			DWC2_HWCFG2_FS_PHY_TYPE_OFFSET;
+	u32 hwcfg2 = readl(&regs->global_regs.ghwcfg2);
+	u32 hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
+	u32 fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
 
 	if (hval == 2 && fval == 1)
-		phyclk = DWC2_HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
+		phyclk = HCFG_FSLSPCLKSEL_48_MHZ;	/* Full speed PHY */
 #endif
 
 	clrsetbits_le32(&regs->host_regs.hcfg,
-			DWC2_HCFG_FSLSPCLKSEL_MASK,
-			phyclk << DWC2_HCFG_FSLSPCLKSEL_OFFSET);
-}
-
-/*
- * Flush a Tx FIFO.
- *
- * @param regs Programming view of DWC_otg controller.
- * @param num Tx FIFO to flush.
- */
-static void dwc_otg_flush_tx_fifo(struct udevice *dev,
-				  struct dwc2_core_regs *regs, const int num)
-{
-	int ret;
-
-	writel(DWC2_GRSTCTL_TXFFLSH | (num << DWC2_GRSTCTL_TXFNUM_OFFSET),
-	       &regs->grstctl);
-	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_TXFFLSH,
-				false, 1000, false);
-	if (ret)
-		dev_info(dev, "%s: Timeout!\n", __func__);
-
-	/* Wait for 3 PHY Clocks */
-	udelay(1);
-}
-
-/*
- * Flush Rx FIFO.
- *
- * @param regs Programming view of DWC_otg controller.
- */
-static void dwc_otg_flush_rx_fifo(struct udevice *dev,
-				  struct dwc2_core_regs *regs)
-{
-	int ret;
-
-	writel(DWC2_GRSTCTL_RXFFLSH, &regs->grstctl);
-	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_RXFFLSH,
-				false, 1000, false);
-	if (ret)
-		dev_info(dev, "%s: Timeout!\n", __func__);
-
-	/* Wait for 3 PHY Clocks */
-	udelay(1);
+			HCFG_FSLSPCLKSEL_MASK,
+			FIELD_PREP(HCFG_FSLSPCLKSEL_MASK, phyclk));
 }
 
 /*
@@ -161,14 +119,14 @@ static void dwc_otg_core_reset(struct udevice *dev,
 	int ret;
 
 	/* Wait for AHB master IDLE state. */
-	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_AHBIDLE,
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
 				true, 1000, false);
 	if (ret)
 		dev_info(dev, "%s: Timeout!\n", __func__);
 
 	/* Core Soft Reset */
-	writel(DWC2_GRSTCTL_CSFTRST, &regs->grstctl);
-	ret = wait_for_bit_le32(&regs->grstctl, DWC2_GRSTCTL_CSFTRST,
+	writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
+	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST,
 				false, 1000, false);
 	if (ret)
 		dev_info(dev, "%s: Timeout!\n", __func__);
@@ -256,67 +214,59 @@ static void dwc_otg_core_host_init(struct udevice *dev,
 	/* Initialize Host Configuration Register */
 	init_fslspclksel(regs);
 #ifdef DWC2_DFLT_SPEED_FULL
-	setbits_le32(&regs->host_regs.hcfg, DWC2_HCFG_FSLSSUPP);
+	setbits_le32(&regs->host_regs.hcfg, HCFG_FSLSSUPP);
 #endif
 
 	/* Configure data FIFO sizes */
 #ifdef DWC2_ENABLE_DYNAMIC_FIFO
-	if (readl(&regs->ghwcfg2) & DWC2_HWCFG2_DYNAMIC_FIFO) {
+	if (readl(&regs->global_regs.ghwcfg2) & GHWCFG2_DYNAMIC_FIFO) {
 		/* Rx FIFO */
-		writel(DWC2_HOST_RX_FIFO_SIZE, &regs->grxfsiz);
+		writel(DWC2_HOST_RX_FIFO_SIZE, &regs->global_regs.grxfsiz);
 
 		/* Non-periodic Tx FIFO */
-		nptxfifosize |= DWC2_HOST_NPERIO_TX_FIFO_SIZE <<
-				DWC2_FIFOSIZE_DEPTH_OFFSET;
-		nptxfifosize |= DWC2_HOST_RX_FIFO_SIZE <<
-				DWC2_FIFOSIZE_STARTADDR_OFFSET;
-		writel(nptxfifosize, &regs->gnptxfsiz);
+		nptxfifosize |= FIELD_PREP(FIFOSIZE_DEPTH_MASK, DWC2_HOST_NPERIO_TX_FIFO_SIZE);
+		nptxfifosize |= FIELD_PREP(FIFOSIZE_STARTADDR_MASK, DWC2_HOST_RX_FIFO_SIZE);
+		writel(nptxfifosize, &regs->global_regs.gnptxfsiz);
 
 		/* Periodic Tx FIFO */
-		ptxfifosize |= DWC2_HOST_PERIO_TX_FIFO_SIZE <<
-				DWC2_FIFOSIZE_DEPTH_OFFSET;
-		ptxfifosize |= (DWC2_HOST_RX_FIFO_SIZE +
-				DWC2_HOST_NPERIO_TX_FIFO_SIZE) <<
-				DWC2_FIFOSIZE_STARTADDR_OFFSET;
-		writel(ptxfifosize, &regs->hptxfsiz);
+		ptxfifosize |= FIELD_PREP(FIFOSIZE_DEPTH_MASK, DWC2_HOST_PERIO_TX_FIFO_SIZE);
+		ptxfifosize |= FIELD_PREP(FIFOSIZE_STARTADDR_MASK, DWC2_HOST_RX_FIFO_SIZE +
+					  DWC2_HOST_NPERIO_TX_FIFO_SIZE);
+		writel(ptxfifosize, &regs->global_regs.hptxfsiz);
 	}
 #endif
 
 	/* Clear Host Set HNP Enable in the OTG Control Register */
-	clrbits_le32(&regs->gotgctl, DWC2_GOTGCTL_HSTSETHNPEN);
+	clrbits_le32(&regs->global_regs.gotgctl, GOTGCTL_HSTSETHNPEN);
 
 	/* Make sure the FIFOs are flushed. */
-	dwc_otg_flush_tx_fifo(dev, regs, 0x10);	/* All Tx FIFOs */
-	dwc_otg_flush_rx_fifo(dev, regs);
+	dwc2_flush_tx_fifo(regs, 0x10);	/* All Tx FIFOs */
+	dwc2_flush_rx_fifo(regs);
 
 	/* Flush out any leftover queued requests. */
-	num_channels = readl(&regs->ghwcfg2);
-	num_channels &= DWC2_HWCFG2_NUM_HOST_CHAN_MASK;
-	num_channels >>= DWC2_HWCFG2_NUM_HOST_CHAN_OFFSET;
-	num_channels += 1;
+	num_channels = FIELD_GET(GHWCFG2_NUM_HOST_CHAN_MASK, readl(&regs->global_regs.ghwcfg2)) + 1;
 
 	for (i = 0; i < num_channels; i++)
-		clrsetbits_le32(&regs->hc_regs[i].hcchar,
-				DWC2_HCCHAR_CHEN | DWC2_HCCHAR_EPDIR,
-				DWC2_HCCHAR_CHDIS);
+		clrsetbits_le32(&regs->host_regs.hc[i].hcchar, HCCHAR_CHENA | HCCHAR_EPDIR,
+				HCCHAR_CHDIS);
 
 	/* Halt all channels to put them into a known state. */
 	for (i = 0; i < num_channels; i++) {
-		clrsetbits_le32(&regs->hc_regs[i].hcchar,
-				DWC2_HCCHAR_EPDIR,
-				DWC2_HCCHAR_CHEN | DWC2_HCCHAR_CHDIS);
-		ret = wait_for_bit_le32(&regs->hc_regs[i].hcchar,
-					DWC2_HCCHAR_CHEN, false, 1000, false);
+		clrsetbits_le32(&regs->host_regs.hc[i].hcchar,
+				HCCHAR_EPDIR,
+				HCCHAR_CHENA | HCCHAR_CHDIS);
+		ret = wait_for_bit_le32(&regs->host_regs.hc[i].hcchar,
+					HCCHAR_CHENA, false, 1000, false);
 		if (ret)
 			dev_info(dev, "%s: Timeout!\n", __func__);
 	}
 
 	/* Turn on the vbus power. */
-	if (readl(&regs->gintsts) & DWC2_GINTSTS_CURMODE_HOST) {
-		hprt0 = readl(&regs->hprt0) & ~DWC2_HPRT0_W1C_MASK;
-		if (!(hprt0 & DWC2_HPRT0_PRTPWR)) {
-			hprt0 |= DWC2_HPRT0_PRTPWR;
-			writel(hprt0, &regs->hprt0);
+	if (readl(&regs->global_regs.gintsts) & GINTSTS_CURMODE_HOST) {
+		hprt0 = readl(&regs->host_regs.hprt0) & ~HPRT0_W1C_MASK;
+		if (!(hprt0 & HPRT0_PWR)) {
+			hprt0 |= HPRT0_PWR;
+			writel(hprt0, &regs->host_regs.hprt0);
 		}
 	}
 
@@ -339,26 +289,26 @@ static void dwc_otg_core_init(struct udevice *dev)
 	uint8_t brst_sz = DWC2_DMA_BURST_SIZE;
 
 	/* Common Initialization */
-	usbcfg = readl(&regs->gusbcfg);
+	usbcfg = readl(&regs->global_regs.gusbcfg);
 
 	/* Program the ULPI External VBUS bit if needed */
 	if (priv->ext_vbus) {
-		usbcfg |= DWC2_GUSBCFG_ULPI_EXT_VBUS_DRV;
+		usbcfg |= GUSBCFG_ULPI_EXT_VBUS_DRV;
 		if (!priv->oc_disable) {
-			usbcfg |= DWC2_GUSBCFG_ULPI_INT_VBUS_INDICATOR |
-				  DWC2_GUSBCFG_INDICATOR_PASSTHROUGH;
+			usbcfg |= GUSBCFG_ULPI_INT_VBUS_IND |
+				  GUSBCFG_INDICATORPASSTHROUGH;
 		}
 	} else {
-		usbcfg &= ~DWC2_GUSBCFG_ULPI_EXT_VBUS_DRV;
+		usbcfg &= ~GUSBCFG_ULPI_EXT_VBUS_DRV;
 	}
 
 	/* Set external TS Dline pulsing */
 #ifdef DWC2_TS_DLINE
-	usbcfg |= DWC2_GUSBCFG_TERM_SEL_DL_PULSE;
+	usbcfg |= GUSBCFG_TERMSELDLPULSE;
 #else
-	usbcfg &= ~DWC2_GUSBCFG_TERM_SEL_DL_PULSE;
+	usbcfg &= ~GUSBCFG_TERMSELDLPULSE;
 #endif
-	writel(usbcfg, &regs->gusbcfg);
+	writel(usbcfg, &regs->global_regs.gusbcfg);
 
 	/* Reset the Controller */
 	dwc_otg_core_reset(dev, regs);
@@ -370,7 +320,7 @@ static void dwc_otg_core_init(struct udevice *dev)
 #if defined(DWC2_DFLT_SPEED_FULL) && \
 	(DWC2_PHY_TYPE == DWC2_PHY_TYPE_FS)
 	/* If FS mode with FS PHY */
-	setbits_le32(&regs->gusbcfg, DWC2_GUSBCFG_PHYSEL);
+	setbits_le32(&regs->global_regs.gusbcfg, GUSBCFG_PHYSEL);
 
 	/* Reset after a PHY select */
 	dwc_otg_core_reset(dev, regs);
@@ -380,18 +330,18 @@ static void dwc_otg_core_init(struct udevice *dev)
 	 * Also do this on HNP Dev/Host mode switches (done in dev_init
 	 * and host_init).
 	 */
-	if (readl(&regs->gintsts) & DWC2_GINTSTS_CURMODE_HOST)
+	if (readl(&regs->global_regs.gintsts) & GINTSTS_CURMODE_HOST)
 		init_fslspclksel(regs);
 
 #ifdef DWC2_I2C_ENABLE
 	/* Program GUSBCFG.OtgUtmifsSel to I2C */
-	setbits_le32(&regs->gusbcfg, DWC2_GUSBCFG_OTGUTMIFSSEL);
+	setbits_le32(&regs->global_regs.gusbcfg, GUSBCFG_OTG_UTMI_FS_SEL);
 
 	/* Program GI2CCTL.I2CEn */
-	clrsetbits_le32(&regs->gi2cctl, DWC2_GI2CCTL_I2CEN |
-			DWC2_GI2CCTL_I2CDEVADDR_MASK,
-			1 << DWC2_GI2CCTL_I2CDEVADDR_OFFSET);
-	setbits_le32(&regs->gi2cctl, DWC2_GI2CCTL_I2CEN);
+	clrsetbits_le32(&regs->global_regs.gi2cctl, GI2CCTL_I2CEN |
+			GI2CCTL_I2CDEVADDR_MASK,
+			FIELD_PREP(GI2CCTL_I2CDEVADDR_MASK, 1));
+	setbits_le32(&regs->global_regs.gi2cctl, GI2CCTL_I2CEN);
 #endif
 
 #else
@@ -402,81 +352,74 @@ static void dwc_otg_core_init(struct udevice *dev)
 	 * soft reset so only program the first time. Do a soft reset
 	 * immediately after setting phyif.
 	 */
-	usbcfg &= ~(DWC2_GUSBCFG_ULPI_UTMI_SEL | DWC2_GUSBCFG_PHYIF);
-	usbcfg |= DWC2_PHY_TYPE << DWC2_GUSBCFG_ULPI_UTMI_SEL_OFFSET;
+	usbcfg &= ~(GUSBCFG_ULPI_UTMI_SEL | GUSBCFG_PHYIF16);
+	usbcfg |= FIELD_PREP(GUSBCFG_ULPI_UTMI_SEL, DWC2_PHY_TYPE);
 
-	if (usbcfg & DWC2_GUSBCFG_ULPI_UTMI_SEL) {	/* ULPI interface */
+	if (usbcfg & GUSBCFG_ULPI_UTMI_SEL) {	/* ULPI interface */
 #ifdef DWC2_PHY_ULPI_DDR
-		usbcfg |= DWC2_GUSBCFG_DDRSEL;
-#else
-		usbcfg &= ~DWC2_GUSBCFG_DDRSEL;
+		usbcfg |= GUSBCFG_DDRSEL;
+		usbcfg &= ~GUSBCFG_DDRSEL;
 #endif
 	} else {	/* UTMI+ interface */
 #if (DWC2_UTMI_WIDTH == 16)
-		usbcfg |= DWC2_GUSBCFG_PHYIF;
+		usbcfg |= GUSBCFG_PHYIF16;
 #endif
 	}
 
-	writel(usbcfg, &regs->gusbcfg);
+	writel(usbcfg, &regs->global_regs.gusbcfg);
 
 	/* Reset after setting the PHY parameters */
 	dwc_otg_core_reset(dev, regs);
 #endif
 
-	usbcfg = readl(&regs->gusbcfg);
-	usbcfg &= ~(DWC2_GUSBCFG_ULPI_FSLS | DWC2_GUSBCFG_ULPI_CLK_SUS_M);
+	usbcfg = readl(&regs->global_regs.gusbcfg);
+	usbcfg &= ~(GUSBCFG_ULPI_FS_LS | GUSBCFG_ULPI_CLK_SUSP_M);
 #ifdef DWC2_ULPI_FS_LS
-	uint32_t hwcfg2 = readl(&regs->ghwcfg2);
-	uint32_t hval = (ghwcfg2 & DWC2_HWCFG2_HS_PHY_TYPE_MASK) >>
-			DWC2_HWCFG2_HS_PHY_TYPE_OFFSET;
-	uint32_t fval = (ghwcfg2 & DWC2_HWCFG2_FS_PHY_TYPE_MASK) >>
-			DWC2_HWCFG2_FS_PHY_TYPE_OFFSET;
-	if (hval == 2 && fval == 1) {
-		usbcfg |= DWC2_GUSBCFG_ULPI_FSLS;
-		usbcfg |= DWC2_GUSBCFG_ULPI_CLK_SUS_M;
+	u32 hwcfg2 = readl(&regs->global_regs.ghwcfg2);
+	u32 hval = FIELD_GET(GHWCFG2_HS_PHY_TYPE_MASK, ghwcfg2);
+	u32 fval = FIELD_GET(GHWCFG2_FS_PHY_TYPE_MASK, ghwcfg2);
+
+	if (hval == GHWCFG2_FS_PHY_TYPE_SHARED_UTMI && fval == GHWCFG2_HS_PHY_TYPE_UTMI) {
+		usbcfg |= GUSBCFG_ULPI_FS_LS;
+		usbcfg |= GUSBCFG_ULPI_CLK_SUSP_M;
 	}
 #endif
 	if (priv->hnp_srp_disable)
-		usbcfg |= DWC2_GUSBCFG_FORCEHOSTMODE;
+		usbcfg |= GUSBCFG_FORCEHOSTMODE;
 
-	writel(usbcfg, &regs->gusbcfg);
+	writel(usbcfg, &regs->global_regs.gusbcfg);
 
 	/* Program the GAHBCFG Register. */
-	switch (readl(&regs->ghwcfg2) & DWC2_HWCFG2_ARCHITECTURE_MASK) {
-	case DWC2_HWCFG2_ARCHITECTURE_SLAVE_ONLY:
+	switch (FIELD_GET(GHWCFG2_ARCHITECTURE_MASK, readl(&regs->global_regs.ghwcfg2))) {
+	case GHWCFG2_SLAVE_ONLY_ARCH:
 		break;
-	case DWC2_HWCFG2_ARCHITECTURE_EXT_DMA:
-		while (brst_sz > 1) {
-			ahbcfg |= ahbcfg + (1 << DWC2_GAHBCFG_HBURSTLEN_OFFSET);
-			ahbcfg &= DWC2_GAHBCFG_HBURSTLEN_MASK;
-			brst_sz >>= 1;
-		}
-
+	case GHWCFG2_EXT_DMA_ARCH:
+		ahbcfg |= FIELD_PREP(GAHBCFG_HBSTLEN_MASK, LOG2(brst_sz));
 #ifdef DWC2_DMA_ENABLE
-		ahbcfg |= DWC2_GAHBCFG_DMAENABLE;
+		ahbcfg |= GAHBCFG_DMA_EN;
 #endif
 		break;
 
-	case DWC2_HWCFG2_ARCHITECTURE_INT_DMA:
-		ahbcfg |= DWC2_GAHBCFG_HBURSTLEN_INCR4;
+	case GHWCFG2_INT_DMA_ARCH:
+		ahbcfg |= FIELD_PREP(GAHBCFG_HBSTLEN_MASK, GAHBCFG_HBSTLEN_INCR4);
 #ifdef DWC2_DMA_ENABLE
-		ahbcfg |= DWC2_GAHBCFG_DMAENABLE;
+		ahbcfg |= GAHBCFG_DMA_EN;
 #endif
 		break;
 	}
 
-	writel(ahbcfg, &regs->gahbcfg);
+	writel(ahbcfg, &regs->global_regs.gahbcfg);
 
 	/* Program the capabilities in GUSBCFG Register */
 	usbcfg = 0;
 
 	if (!priv->hnp_srp_disable)
-		usbcfg |= DWC2_GUSBCFG_HNPCAP | DWC2_GUSBCFG_SRPCAP;
+		usbcfg |= GUSBCFG_HNPCAP | GUSBCFG_SRPCAP;
 #ifdef DWC2_IC_USB_CAP
-	usbcfg |= DWC2_GUSBCFG_IC_USB_CAP;
+	usbcfg |= GUSBCFG_ICUSBCAP;
 #endif
 
-	setbits_le32(&regs->gusbcfg, usbcfg);
+	setbits_le32(&regs->global_regs.gusbcfg, usbcfg);
 }
 
 /*
@@ -492,15 +435,15 @@ static void dwc_otg_hc_init(struct dwc2_core_regs *regs, uint8_t hc_num,
 		struct usb_device *dev, uint8_t dev_addr, uint8_t ep_num,
 		uint8_t ep_is_in, uint8_t ep_type, uint16_t max_packet)
 {
-	struct dwc2_hc_regs *hc_regs = &regs->hc_regs[hc_num];
-	uint32_t hcchar = (dev_addr << DWC2_HCCHAR_DEVADDR_OFFSET) |
-			  (ep_num << DWC2_HCCHAR_EPNUM_OFFSET) |
-			  (ep_is_in << DWC2_HCCHAR_EPDIR_OFFSET) |
-			  (ep_type << DWC2_HCCHAR_EPTYPE_OFFSET) |
-			  (max_packet << DWC2_HCCHAR_MPS_OFFSET);
+	struct dwc2_hc_regs *hc_regs = &regs->host_regs.hc[hc_num];
+	u32 hcchar = FIELD_PREP(HCCHAR_DEVADDR_MASK, dev_addr) |
+			  FIELD_PREP(HCCHAR_EPNUM_MASK, ep_num) |
+			  FIELD_PREP(HCCHAR_EPDIR, ep_is_in) |
+			  FIELD_PREP(HCCHAR_EPTYPE_MASK, ep_type) |
+			  FIELD_PREP(HCCHAR_MPS_MASK, max_packet);
 
 	if (dev->speed == USB_SPEED_LOW)
-		hcchar |= DWC2_HCCHAR_LSPDDEV;
+		hcchar |= HCCHAR_LSPDDEV;
 
 	/*
 	 * Program the HCCHARn register with the endpoint characteristics
@@ -517,9 +460,9 @@ static void dwc_otg_hc_init_split(struct dwc2_hc_regs *hc_regs,
 {
 	uint32_t hcsplt = 0;
 
-	hcsplt = DWC2_HCSPLT_SPLTENA;
-	hcsplt |= hub_devnum << DWC2_HCSPLT_HUBADDR_OFFSET;
-	hcsplt |= hub_port << DWC2_HCSPLT_PRTADDR_OFFSET;
+	hcsplt = HCSPLT_SPLTENA;
+	hcsplt |= FIELD_PREP(HCSPLT_HUBADDR_MASK, hub_devnum);
+	hcsplt |= FIELD_PREP(HCSPLT_PRTADDR_MASK, hub_port);
 
 	/* Program the HCSPLIT register for SPLITs */
 	writel(hcsplt, &hc_regs->hcsplt);
@@ -554,31 +497,34 @@ static int dwc_otg_submit_rh_msg_in_status(struct dwc2_core_regs *regs,
 		len = 4;
 		break;
 	case USB_RECIP_OTHER | USB_TYPE_CLASS:
-		hprt0 = readl(&regs->hprt0);
-		if (hprt0 & DWC2_HPRT0_PRTCONNSTS)
+		hprt0 = readl(&regs->host_regs.hprt0);
+		if (hprt0 & HPRT0_CONNSTS)
 			port_status |= USB_PORT_STAT_CONNECTION;
-		if (hprt0 & DWC2_HPRT0_PRTENA)
+		if (hprt0 & HPRT0_ENA)
 			port_status |= USB_PORT_STAT_ENABLE;
-		if (hprt0 & DWC2_HPRT0_PRTSUSP)
+		if (hprt0 & HPRT0_SUSP)
 			port_status |= USB_PORT_STAT_SUSPEND;
-		if (hprt0 & DWC2_HPRT0_PRTOVRCURRACT)
+		if (hprt0 & HPRT0_OVRCURRACT)
 			port_status |= USB_PORT_STAT_OVERCURRENT;
-		if (hprt0 & DWC2_HPRT0_PRTRST)
+		if (hprt0 & HPRT0_RST)
 			port_status |= USB_PORT_STAT_RESET;
-		if (hprt0 & DWC2_HPRT0_PRTPWR)
+		if (hprt0 & HPRT0_PWR)
 			port_status |= USB_PORT_STAT_POWER;
 
-		if ((hprt0 & DWC2_HPRT0_PRTSPD_MASK) == DWC2_HPRT0_PRTSPD_LOW)
+		switch (FIELD_GET(HPRT0_SPD_MASK, hprt0)) {
+		case HPRT0_SPD_LOW_SPEED:
 			port_status |= USB_PORT_STAT_LOW_SPEED;
-		else if ((hprt0 & DWC2_HPRT0_PRTSPD_MASK) ==
-			 DWC2_HPRT0_PRTSPD_HIGH)
+			break;
+		case HPRT0_SPD_HIGH_SPEED:
 			port_status |= USB_PORT_STAT_HIGH_SPEED;
+			break;
+		}
 
-		if (hprt0 & DWC2_HPRT0_PRTENCHNG)
+		if (hprt0 & HPRT0_ENACHG)
 			port_change |= USB_PORT_STAT_C_ENABLE;
-		if (hprt0 & DWC2_HPRT0_PRTCONNDET)
+		if (hprt0 & HPRT0_CONNDET)
 			port_change |= USB_PORT_STAT_C_CONNECTION;
-		if (hprt0 & DWC2_HPRT0_PRTOVRCURRCHNG)
+		if (hprt0 & HPRT0_OVRCURRCHG)
 			port_change |= USB_PORT_STAT_C_OVERCURRENT;
 
 		*(uint32_t *)buffer = cpu_to_le32(port_status |
@@ -744,7 +690,7 @@ static int dwc_otg_submit_rh_msg_out(struct dwc2_priv *priv,
 	case (USB_REQ_CLEAR_FEATURE << 8) | USB_RECIP_OTHER | USB_TYPE_CLASS:
 		switch (wValue) {
 		case USB_PORT_FEAT_C_CONNECTION:
-			clrsetbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK, DWC2_HPRT0_PRTCONNDET);
+			clrsetbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK, HPRT0_CONNDET);
 			break;
 		}
 		break;
@@ -755,13 +701,13 @@ static int dwc_otg_submit_rh_msg_out(struct dwc2_priv *priv,
 			break;
 
 		case USB_PORT_FEAT_RESET:
-			clrsetbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK, DWC2_HPRT0_PRTRST);
+			clrsetbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK, HPRT0_RST);
 			mdelay(50);
-			clrbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK | DWC2_HPRT0_PRTRST);
+			clrbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK | HPRT0_RST);
 			break;
 
 		case USB_PORT_FEAT_POWER:
-			clrsetbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK, DWC2_HPRT0_PRTRST);
+			clrsetbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK, HPRT0_RST);
 			break;
 
 		case USB_PORT_FEAT_ENABLE:
@@ -812,24 +758,23 @@ int wait_for_chhltd(struct dwc2_hc_regs *hc_regs, uint32_t *sub, u8 *toggle)
 	int ret;
 	uint32_t hcint, hctsiz;
 
-	ret = wait_for_bit_le32(&hc_regs->hcint, DWC2_HCINT_CHHLTD, true,
+	ret = wait_for_bit_le32(&hc_regs->hcint, HCINTMSK_CHHLTD, true,
 				2000, false);
 	if (ret)
 		return ret;
 
 	hcint = readl(&hc_regs->hcint);
 	hctsiz = readl(&hc_regs->hctsiz);
-	*sub = (hctsiz & DWC2_HCTSIZ_XFERSIZE_MASK) >>
-		DWC2_HCTSIZ_XFERSIZE_OFFSET;
-	*toggle = (hctsiz & DWC2_HCTSIZ_PID_MASK) >> DWC2_HCTSIZ_PID_OFFSET;
+	*sub = FIELD_GET(TSIZ_XFERSIZE_MASK, hctsiz);
+	*toggle = FIELD_GET(TSIZ_SC_MC_PID_MASK, hctsiz);
 
 	debug("%s: HCINT=%08x sub=%u toggle=%d\n", __func__, hcint, *sub,
 	      *toggle);
 
-	if (hcint & DWC2_HCINT_XFERCOMP)
+	if (hcint & HCINTMSK_XFERCOMPL)
 		return 0;
 
-	if (hcint & (DWC2_HCINT_NAK | DWC2_HCINT_FRMOVRUN))
+	if (hcint & (HCINTMSK_NAK | HCINTMSK_FRMOVRUN))
 		return -EAGAIN;
 
 	debug("%s: Error (HCINT=%08x)\n", __func__, hcint);
@@ -837,10 +782,10 @@ int wait_for_chhltd(struct dwc2_hc_regs *hc_regs, uint32_t *sub, u8 *toggle)
 }
 
 static int dwc2_eptype[] = {
-	DWC2_HCCHAR_EPTYPE_ISOC,
-	DWC2_HCCHAR_EPTYPE_INTR,
-	DWC2_HCCHAR_EPTYPE_CONTROL,
-	DWC2_HCCHAR_EPTYPE_BULK,
+	HCCHAR_EPTYPE_ISOC,
+	HCCHAR_EPTYPE_INTR,
+	HCCHAR_EPTYPE_CONTROL,
+	HCCHAR_EPTYPE_BULK,
 };
 
 static int transfer_chunk(struct dwc2_hc_regs *hc_regs, void *aligned_buffer,
@@ -853,9 +798,9 @@ static int transfer_chunk(struct dwc2_hc_regs *hc_regs, void *aligned_buffer,
 	debug("%s: chunk: pid %d xfer_len %u pkts %u\n", __func__,
 	      *pid, xfer_len, num_packets);
 
-	writel((xfer_len << DWC2_HCTSIZ_XFERSIZE_OFFSET) |
-	       (num_packets << DWC2_HCTSIZ_PKTCNT_OFFSET) |
-	       (*pid << DWC2_HCTSIZ_PID_OFFSET),
+	writel(FIELD_PREP(TSIZ_XFERSIZE_MASK, xfer_len) |
+	       FIELD_PREP(TSIZ_PKTCNT_MASK, num_packets) |
+	       FIELD_PREP(TSIZ_SC_MC_PID_MASK, *pid),
 	       &hc_regs->hctsiz);
 
 	if (xfer_len) {
@@ -879,12 +824,12 @@ static int transfer_chunk(struct dwc2_hc_regs *hc_regs, void *aligned_buffer,
 	writel(0x3fff, &hc_regs->hcint);
 
 	/* Set host channel enable after all other setup is complete. */
-	clrsetbits_le32(&hc_regs->hcchar, DWC2_HCCHAR_MULTICNT_MASK |
-			DWC2_HCCHAR_CHEN | DWC2_HCCHAR_CHDIS |
-			DWC2_HCCHAR_ODDFRM,
-			(1 << DWC2_HCCHAR_MULTICNT_OFFSET) |
-			(odd_frame << DWC2_HCCHAR_ODDFRM_OFFSET) |
-			DWC2_HCCHAR_CHEN);
+	clrsetbits_le32(&hc_regs->hcchar, HCCHAR_MULTICNT_MASK |
+			HCCHAR_CHENA | HCCHAR_CHDIS |
+			HCCHAR_ODDFRM,
+			FIELD_PREP(HCCHAR_MULTICNT_MASK, 1) |
+			FIELD_PREP(HCCHAR_ODDFRM, odd_frame) |
+			HCCHAR_CHENA);
 
 	ret = wait_for_chhltd(hc_regs, &sub, pid);
 	if (ret < 0)
@@ -908,7 +853,7 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 	      unsigned long pipe, u8 *pid, int in, void *buffer, int len)
 {
 	struct dwc2_core_regs *regs = priv->regs;
-	struct dwc2_hc_regs *hc_regs = &regs->hc_regs[DWC2_HC_CHANNEL];
+	struct dwc2_hc_regs *hc_regs = &regs->host_regs.hc[DWC2_HC_CHANNEL];
 	struct dwc2_host_regs *host_regs = &regs->host_regs;
 	int devnum = usb_pipedevice(pipe);
 	int ep = usb_pipeendpoint(pipe);
@@ -945,9 +890,9 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 	if (dev->speed != USB_SPEED_HIGH) {
 		uint8_t hub_addr;
 		uint8_t hub_port;
-		uint32_t hprt0 = readl(&regs->hprt0);
-		if ((hprt0 & DWC2_HPRT0_PRTSPD_MASK) ==
-		     DWC2_HPRT0_PRTSPD_HIGH) {
+		u32 hprt0 = readl(&regs->host_regs.hprt0);
+
+		if (FIELD_GET(HPRT0_SPD_MASK, hprt0) == HPRT0_SPD_HIGH_SPEED) {
 			usb_find_usb2_hub_address_port(dev, &hub_addr,
 						       &hub_port);
 			dwc_otg_hc_init_split(hc_regs, hub_addr, hub_port);
@@ -972,11 +917,11 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 			num_packets = 1;
 
 		if (complete_split)
-			setbits_le32(&hc_regs->hcsplt, DWC2_HCSPLT_COMPSPLT);
+			setbits_le32(&hc_regs->hcsplt, HCSPLT_COMPSPLT);
 		else if (do_split)
-			clrbits_le32(&hc_regs->hcsplt, DWC2_HCSPLT_COMPSPLT);
+			clrbits_le32(&hc_regs->hcsplt, HCSPLT_COMPSPLT);
 
-		if (eptype == DWC2_HCCHAR_EPTYPE_INTR) {
+		if (eptype == HCCHAR_EPTYPE_INTR) {
 			int uframe_num = readl(&host_regs->hfnum);
 			if (!(uframe_num & 0x1))
 				odd_frame = 1;
@@ -989,19 +934,19 @@ int chunk_msg(struct dwc2_priv *priv, struct usb_device *dev,
 		hcint = readl(&hc_regs->hcint);
 		if (complete_split) {
 			stop_transfer = 0;
-			if (hcint & DWC2_HCINT_NYET) {
+			if (hcint & HCINTMSK_NYET) {
 				ret = 0;
-				int frame_num = DWC2_HFNUM_MAX_FRNUM &
-						readl(&host_regs->hfnum);
-				if (((frame_num - ssplit_frame_num) &
-				    DWC2_HFNUM_MAX_FRNUM) > 4)
+				int frame_num = FIELD_GET(HFNUM_FRNUM_MASK,
+							  readl(&host_regs->hfnum));
+
+				if (((frame_num - ssplit_frame_num) & HFNUM_FRNUM_MASK) > 4)
 					ret = -EAGAIN;
 			} else
 				complete_split = 0;
 		} else if (do_split) {
-			if (hcint & DWC2_HCINT_ACK) {
-				ssplit_frame_num = DWC2_HFNUM_MAX_FRNUM &
-						   readl(&host_regs->hfnum);
+			if (hcint & HCINTMSK_ACK) {
+				ssplit_frame_num = FIELD_GET(HFNUM_FRNUM_MASK,
+							     readl(&host_regs->hfnum));
 				ret = 0;
 				complete_split = 1;
 			}
@@ -1175,12 +1120,11 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 	if (ret)
 		return ret;
 
-	snpsid = readl(&regs->gsnpsid);
+	snpsid = readl(&regs->global_regs.gsnpsid);
 	dev_info(dev, "Core Release: %x.%03x\n",
 		 snpsid >> 12 & 0xf, snpsid & 0xfff);
 
-	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
-	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
+	if (FIELD_GET(GSNPSID_ID_MASK, snpsid) != GSNPSID_OTG_ID) {
 		dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x\n",
 			 snpsid);
 		return -ENODEV;
@@ -1201,9 +1145,9 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 		dwc_otg_core_host_init(dev, regs);
 	}
 
-	clrsetbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK, DWC2_HPRT0_PRTRST);
+	clrsetbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK, HPRT0_RST);
 	mdelay(50);
-	clrbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK | DWC2_HPRT0_PRTRST);
+	clrbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK | HPRT0_RST);
 
 	for (i = 0; i < MAX_DEVICE; i++) {
 		for (j = 0; j < MAX_ENDPOINT; j++) {
@@ -1218,7 +1162,7 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 	 * is started (the bus is scanned) and  fixes the USB detection
 	 * problems with some problematic USB keys.
 	 */
-	if (readl(&regs->gintsts) & DWC2_GINTSTS_CURMODE_HOST)
+	if (readl(&regs->global_regs.gintsts) & GINTSTS_CURMODE_HOST)
 		mdelay(1000);
 
 	printf("USB DWC2\n");
@@ -1229,7 +1173,7 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 static void dwc2_uninit_common(struct dwc2_core_regs *regs)
 {
 	/* Put everything in reset. */
-	clrsetbits_le32(&regs->hprt0, DWC2_HPRT0_W1C_MASK, DWC2_HPRT0_PRTRST);
+	clrsetbits_le32(&regs->host_regs.hprt0, HPRT0_W1C_MASK, HPRT0_RST);
 }
 
 #if !CONFIG_IS_ENABLED(DM_USB)
diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
index 6f022e33a1..d802570030 100644
--- a/drivers/usb/host/dwc2.h
+++ b/drivers/usb/host/dwc2.h
@@ -6,742 +6,6 @@
 #ifndef __DWC2_H__
 #define __DWC2_H__
 
-struct dwc2_hc_regs {
-	u32			hcchar;		/* 0x00 */
-	u32			hcsplt;
-	u32			hcint;
-	u32			hcintmsk;
-	u32			hctsiz;		/* 0x10 */
-	u32			hcdma;
-	u32			reserved;
-	u32			hcdmab;
-};
-
-struct dwc2_host_regs {
-	u32			hcfg;		/* 0x00 */
-	u32			hfir;
-	u32			hfnum;
-	u32			_pad_0x40c;
-	u32			hptxsts;	/* 0x10 */
-	u32			haint;
-	u32			haintmsk;
-	u32			hflbaddr;
-};
-
-struct dwc2_core_regs {
-	u32			gotgctl;	/* 0x000 */
-	u32			gotgint;
-	u32			gahbcfg;
-	u32			gusbcfg;
-	u32			grstctl;	/* 0x010 */
-	u32			gintsts;
-	u32			gintmsk;
-	u32			grxstsr;
-	u32			grxstsp;	/* 0x020 */
-	u32			grxfsiz;
-	u32			gnptxfsiz;
-	u32			gnptxsts;
-	u32			gi2cctl;	/* 0x030 */
-	u32			gpvndctl;
-	u32			ggpio;
-	u32			guid;
-	u32			gsnpsid;	/* 0x040 */
-	u32			ghwcfg1;
-	u32			ghwcfg2;
-	u32			ghwcfg3;
-	u32			ghwcfg4;	/* 0x050 */
-	u32			glpmcfg;
-	u32			_pad_0x58_0x9c[42];
-	u32			hptxfsiz;	/* 0x100 */
-	u32			dptxfsiz_dieptxf[15];
-	u32			_pad_0x140_0x3fc[176];
-	struct dwc2_host_regs	host_regs;	/* 0x400 */
-	u32			_pad_0x420_0x43c[8];
-	u32			hprt0;		/* 0x440 */
-	u32			_pad_0x444_0x4fc[47];
-	struct dwc2_hc_regs	hc_regs[16];	/* 0x500 */
-	u32			_pad_0x700_0xe00[448];
-	u32			pcgcctl;	/* 0xe00 */
-};
-
-#define DWC2_GOTGCTL_SESREQSCS				(1 << 0)
-#define DWC2_GOTGCTL_SESREQSCS_OFFSET			0
-#define DWC2_GOTGCTL_SESREQ				(1 << 1)
-#define DWC2_GOTGCTL_SESREQ_OFFSET			1
-#define DWC2_GOTGCTL_HSTNEGSCS				(1 << 8)
-#define DWC2_GOTGCTL_HSTNEGSCS_OFFSET			8
-#define DWC2_GOTGCTL_HNPREQ				(1 << 9)
-#define DWC2_GOTGCTL_HNPREQ_OFFSET			9
-#define DWC2_GOTGCTL_HSTSETHNPEN			(1 << 10)
-#define DWC2_GOTGCTL_HSTSETHNPEN_OFFSET			10
-#define DWC2_GOTGCTL_DEVHNPEN				(1 << 11)
-#define DWC2_GOTGCTL_DEVHNPEN_OFFSET			11
-#define DWC2_GOTGCTL_CONIDSTS				(1 << 16)
-#define DWC2_GOTGCTL_CONIDSTS_OFFSET			16
-#define DWC2_GOTGCTL_DBNCTIME				(1 << 17)
-#define DWC2_GOTGCTL_DBNCTIME_OFFSET			17
-#define DWC2_GOTGCTL_ASESVLD				(1 << 18)
-#define DWC2_GOTGCTL_ASESVLD_OFFSET			18
-#define DWC2_GOTGCTL_BSESVLD				(1 << 19)
-#define DWC2_GOTGCTL_BSESVLD_OFFSET			19
-#define DWC2_GOTGCTL_OTGVER				(1 << 20)
-#define DWC2_GOTGCTL_OTGVER_OFFSET			20
-#define DWC2_GOTGINT_SESENDDET				(1 << 2)
-#define DWC2_GOTGINT_SESENDDET_OFFSET			2
-#define DWC2_GOTGINT_SESREQSUCSTSCHNG			(1 << 8)
-#define DWC2_GOTGINT_SESREQSUCSTSCHNG_OFFSET		8
-#define DWC2_GOTGINT_HSTNEGSUCSTSCHNG			(1 << 9)
-#define DWC2_GOTGINT_HSTNEGSUCSTSCHNG_OFFSET		9
-#define DWC2_GOTGINT_RESERVER10_16_MASK			(0x7F << 10)
-#define DWC2_GOTGINT_RESERVER10_16_OFFSET		10
-#define DWC2_GOTGINT_HSTNEGDET				(1 << 17)
-#define DWC2_GOTGINT_HSTNEGDET_OFFSET			17
-#define DWC2_GOTGINT_ADEVTOUTCHNG			(1 << 18)
-#define DWC2_GOTGINT_ADEVTOUTCHNG_OFFSET		18
-#define DWC2_GOTGINT_DEBDONE				(1 << 19)
-#define DWC2_GOTGINT_DEBDONE_OFFSET			19
-#define DWC2_GAHBCFG_GLBLINTRMSK			(1 << 0)
-#define DWC2_GAHBCFG_GLBLINTRMSK_OFFSET			0
-#define DWC2_GAHBCFG_HBURSTLEN_SINGLE			(0 << 1)
-#define DWC2_GAHBCFG_HBURSTLEN_INCR			(1 << 1)
-#define DWC2_GAHBCFG_HBURSTLEN_INCR4			(3 << 1)
-#define DWC2_GAHBCFG_HBURSTLEN_INCR8			(5 << 1)
-#define DWC2_GAHBCFG_HBURSTLEN_INCR16			(7 << 1)
-#define DWC2_GAHBCFG_HBURSTLEN_MASK			(0xF << 1)
-#define DWC2_GAHBCFG_HBURSTLEN_OFFSET			1
-#define DWC2_GAHBCFG_DMAENABLE				(1 << 5)
-#define DWC2_GAHBCFG_DMAENABLE_OFFSET			5
-#define DWC2_GAHBCFG_NPTXFEMPLVL_TXFEMPLVL		(1 << 7)
-#define DWC2_GAHBCFG_NPTXFEMPLVL_TXFEMPLVL_OFFSET	7
-#define DWC2_GAHBCFG_PTXFEMPLVL				(1 << 8)
-#define DWC2_GAHBCFG_PTXFEMPLVL_OFFSET			8
-#define DWC2_GUSBCFG_TOUTCAL_MASK			(0x7 << 0)
-#define DWC2_GUSBCFG_TOUTCAL_OFFSET			0
-#define DWC2_GUSBCFG_PHYIF				(1 << 3)
-#define DWC2_GUSBCFG_PHYIF_OFFSET			3
-#define DWC2_GUSBCFG_ULPI_UTMI_SEL			(1 << 4)
-#define DWC2_GUSBCFG_ULPI_UTMI_SEL_OFFSET		4
-#define DWC2_GUSBCFG_FSINTF				(1 << 5)
-#define DWC2_GUSBCFG_FSINTF_OFFSET			5
-#define DWC2_GUSBCFG_PHYSEL				(1 << 6)
-#define DWC2_GUSBCFG_PHYSEL_OFFSET			6
-#define DWC2_GUSBCFG_DDRSEL				(1 << 7)
-#define DWC2_GUSBCFG_DDRSEL_OFFSET			7
-#define DWC2_GUSBCFG_SRPCAP				(1 << 8)
-#define DWC2_GUSBCFG_SRPCAP_OFFSET			8
-#define DWC2_GUSBCFG_HNPCAP				(1 << 9)
-#define DWC2_GUSBCFG_HNPCAP_OFFSET			9
-#define DWC2_GUSBCFG_USBTRDTIM_MASK			(0xF << 10)
-#define DWC2_GUSBCFG_USBTRDTIM_OFFSET			10
-#define DWC2_GUSBCFG_NPTXFRWNDEN			(1 << 14)
-#define DWC2_GUSBCFG_NPTXFRWNDEN_OFFSET			14
-#define DWC2_GUSBCFG_PHYLPWRCLKSEL			(1 << 15)
-#define DWC2_GUSBCFG_PHYLPWRCLKSEL_OFFSET		15
-#define DWC2_GUSBCFG_OTGUTMIFSSEL			(1 << 16)
-#define DWC2_GUSBCFG_OTGUTMIFSSEL_OFFSET		16
-#define DWC2_GUSBCFG_ULPI_FSLS				(1 << 17)
-#define DWC2_GUSBCFG_ULPI_FSLS_OFFSET			17
-#define DWC2_GUSBCFG_ULPI_AUTO_RES			(1 << 18)
-#define DWC2_GUSBCFG_ULPI_AUTO_RES_OFFSET		18
-#define DWC2_GUSBCFG_ULPI_CLK_SUS_M			(1 << 19)
-#define DWC2_GUSBCFG_ULPI_CLK_SUS_M_OFFSET		19
-#define DWC2_GUSBCFG_ULPI_EXT_VBUS_DRV			(1 << 20)
-#define DWC2_GUSBCFG_ULPI_EXT_VBUS_DRV_OFFSET		20
-#define DWC2_GUSBCFG_ULPI_INT_VBUS_INDICATOR		(1 << 21)
-#define DWC2_GUSBCFG_ULPI_INT_VBUS_INDICATOR_OFFSET	21
-#define DWC2_GUSBCFG_TERM_SEL_DL_PULSE			(1 << 22)
-#define DWC2_GUSBCFG_TERM_SEL_DL_PULSE_OFFSET		22
-#define DWC2_GUSBCFG_INDICATOR_PASSTHROUGH		(1 << 24)
-#define DWC2_GUSBCFG_INDICATOR_PASSTHROUGH_OFFSET	24
-#define DWC2_GUSBCFG_IC_USB_CAP				(1 << 26)
-#define DWC2_GUSBCFG_IC_USB_CAP_OFFSET			26
-#define DWC2_GUSBCFG_IC_TRAFFIC_PULL_REMOVE		(1 << 27)
-#define DWC2_GUSBCFG_IC_TRAFFIC_PULL_REMOVE_OFFSET	27
-#define DWC2_GUSBCFG_TX_END_DELAY			(1 << 28)
-#define DWC2_GUSBCFG_TX_END_DELAY_OFFSET		28
-#define DWC2_GUSBCFG_FORCEHOSTMODE			(1 << 29)
-#define DWC2_GUSBCFG_FORCEHOSTMODE_OFFSET		29
-#define DWC2_GUSBCFG_FORCEDEVMODE			(1 << 30)
-#define DWC2_GUSBCFG_FORCEDEVMODE_OFFSET		30
-#define DWC2_GLPMCTL_LPM_CAP_EN				(1 << 0)
-#define DWC2_GLPMCTL_LPM_CAP_EN_OFFSET			0
-#define DWC2_GLPMCTL_APPL_RESP				(1 << 1)
-#define DWC2_GLPMCTL_APPL_RESP_OFFSET			1
-#define DWC2_GLPMCTL_HIRD_MASK				(0xF << 2)
-#define DWC2_GLPMCTL_HIRD_OFFSET			2
-#define DWC2_GLPMCTL_REM_WKUP_EN			(1 << 6)
-#define DWC2_GLPMCTL_REM_WKUP_EN_OFFSET			6
-#define DWC2_GLPMCTL_EN_UTMI_SLEEP			(1 << 7)
-#define DWC2_GLPMCTL_EN_UTMI_SLEEP_OFFSET		7
-#define DWC2_GLPMCTL_HIRD_THRES_MASK			(0x1F << 8)
-#define DWC2_GLPMCTL_HIRD_THRES_OFFSET			8
-#define DWC2_GLPMCTL_LPM_RESP_MASK			(0x3 << 13)
-#define DWC2_GLPMCTL_LPM_RESP_OFFSET			13
-#define DWC2_GLPMCTL_PRT_SLEEP_STS			(1 << 15)
-#define DWC2_GLPMCTL_PRT_SLEEP_STS_OFFSET		15
-#define DWC2_GLPMCTL_SLEEP_STATE_RESUMEOK		(1 << 16)
-#define DWC2_GLPMCTL_SLEEP_STATE_RESUMEOK_OFFSET	16
-#define DWC2_GLPMCTL_LPM_CHAN_INDEX_MASK		(0xF << 17)
-#define DWC2_GLPMCTL_LPM_CHAN_INDEX_OFFSET		17
-#define DWC2_GLPMCTL_RETRY_COUNT_MASK			(0x7 << 21)
-#define DWC2_GLPMCTL_RETRY_COUNT_OFFSET			21
-#define DWC2_GLPMCTL_SEND_LPM				(1 << 24)
-#define DWC2_GLPMCTL_SEND_LPM_OFFSET			24
-#define DWC2_GLPMCTL_RETRY_COUNT_STS_MASK		(0x7 << 25)
-#define DWC2_GLPMCTL_RETRY_COUNT_STS_OFFSET		25
-#define DWC2_GLPMCTL_HSIC_CONNECT			(1 << 30)
-#define DWC2_GLPMCTL_HSIC_CONNECT_OFFSET		30
-#define DWC2_GLPMCTL_INV_SEL_HSIC			(1 << 31)
-#define DWC2_GLPMCTL_INV_SEL_HSIC_OFFSET		31
-#define DWC2_GRSTCTL_CSFTRST				(1 << 0)
-#define DWC2_GRSTCTL_CSFTRST_OFFSET			0
-#define DWC2_GRSTCTL_HSFTRST				(1 << 1)
-#define DWC2_GRSTCTL_HSFTRST_OFFSET			1
-#define DWC2_GRSTCTL_HSTFRM				(1 << 2)
-#define DWC2_GRSTCTL_HSTFRM_OFFSET			2
-#define DWC2_GRSTCTL_INTKNQFLSH				(1 << 3)
-#define DWC2_GRSTCTL_INTKNQFLSH_OFFSET			3
-#define DWC2_GRSTCTL_RXFFLSH				(1 << 4)
-#define DWC2_GRSTCTL_RXFFLSH_OFFSET			4
-#define DWC2_GRSTCTL_TXFFLSH				(1 << 5)
-#define DWC2_GRSTCTL_TXFFLSH_OFFSET			5
-#define DWC2_GRSTCTL_TXFNUM_MASK			(0x1F << 6)
-#define DWC2_GRSTCTL_TXFNUM_OFFSET			6
-#define DWC2_GRSTCTL_DMAREQ				(1 << 30)
-#define DWC2_GRSTCTL_DMAREQ_OFFSET			30
-#define DWC2_GRSTCTL_AHBIDLE				(1 << 31)
-#define DWC2_GRSTCTL_AHBIDLE_OFFSET			31
-#define DWC2_GINTMSK_MODEMISMATCH			(1 << 1)
-#define DWC2_GINTMSK_MODEMISMATCH_OFFSET		1
-#define DWC2_GINTMSK_OTGINTR				(1 << 2)
-#define DWC2_GINTMSK_OTGINTR_OFFSET			2
-#define DWC2_GINTMSK_SOFINTR				(1 << 3)
-#define DWC2_GINTMSK_SOFINTR_OFFSET			3
-#define DWC2_GINTMSK_RXSTSQLVL				(1 << 4)
-#define DWC2_GINTMSK_RXSTSQLVL_OFFSET			4
-#define DWC2_GINTMSK_NPTXFEMPTY				(1 << 5)
-#define DWC2_GINTMSK_NPTXFEMPTY_OFFSET			5
-#define DWC2_GINTMSK_GINNAKEFF				(1 << 6)
-#define DWC2_GINTMSK_GINNAKEFF_OFFSET			6
-#define DWC2_GINTMSK_GOUTNAKEFF				(1 << 7)
-#define DWC2_GINTMSK_GOUTNAKEFF_OFFSET			7
-#define DWC2_GINTMSK_I2CINTR				(1 << 9)
-#define DWC2_GINTMSK_I2CINTR_OFFSET			9
-#define DWC2_GINTMSK_ERLYSUSPEND			(1 << 10)
-#define DWC2_GINTMSK_ERLYSUSPEND_OFFSET			10
-#define DWC2_GINTMSK_USBSUSPEND				(1 << 11)
-#define DWC2_GINTMSK_USBSUSPEND_OFFSET			11
-#define DWC2_GINTMSK_USBRESET				(1 << 12)
-#define DWC2_GINTMSK_USBRESET_OFFSET			12
-#define DWC2_GINTMSK_ENUMDONE				(1 << 13)
-#define DWC2_GINTMSK_ENUMDONE_OFFSET			13
-#define DWC2_GINTMSK_ISOOUTDROP				(1 << 14)
-#define DWC2_GINTMSK_ISOOUTDROP_OFFSET			14
-#define DWC2_GINTMSK_EOPFRAME				(1 << 15)
-#define DWC2_GINTMSK_EOPFRAME_OFFSET			15
-#define DWC2_GINTMSK_EPMISMATCH				(1 << 17)
-#define DWC2_GINTMSK_EPMISMATCH_OFFSET			17
-#define DWC2_GINTMSK_INEPINTR				(1 << 18)
-#define DWC2_GINTMSK_INEPINTR_OFFSET			18
-#define DWC2_GINTMSK_OUTEPINTR				(1 << 19)
-#define DWC2_GINTMSK_OUTEPINTR_OFFSET			19
-#define DWC2_GINTMSK_INCOMPLISOIN			(1 << 20)
-#define DWC2_GINTMSK_INCOMPLISOIN_OFFSET		20
-#define DWC2_GINTMSK_INCOMPLISOOUT			(1 << 21)
-#define DWC2_GINTMSK_INCOMPLISOOUT_OFFSET		21
-#define DWC2_GINTMSK_PORTINTR				(1 << 24)
-#define DWC2_GINTMSK_PORTINTR_OFFSET			24
-#define DWC2_GINTMSK_HCINTR				(1 << 25)
-#define DWC2_GINTMSK_HCINTR_OFFSET			25
-#define DWC2_GINTMSK_PTXFEMPTY				(1 << 26)
-#define DWC2_GINTMSK_PTXFEMPTY_OFFSET			26
-#define DWC2_GINTMSK_LPMTRANRCVD			(1 << 27)
-#define DWC2_GINTMSK_LPMTRANRCVD_OFFSET			27
-#define DWC2_GINTMSK_CONIDSTSCHNG			(1 << 28)
-#define DWC2_GINTMSK_CONIDSTSCHNG_OFFSET		28
-#define DWC2_GINTMSK_DISCONNECT				(1 << 29)
-#define DWC2_GINTMSK_DISCONNECT_OFFSET			29
-#define DWC2_GINTMSK_SESSREQINTR			(1 << 30)
-#define DWC2_GINTMSK_SESSREQINTR_OFFSET			30
-#define DWC2_GINTMSK_WKUPINTR				(1 << 31)
-#define DWC2_GINTMSK_WKUPINTR_OFFSET			31
-#define DWC2_GINTSTS_CURMODE_DEVICE			(0 << 0)
-#define DWC2_GINTSTS_CURMODE_HOST			(1 << 0)
-#define DWC2_GINTSTS_CURMODE				(1 << 0)
-#define DWC2_GINTSTS_CURMODE_OFFSET			0
-#define DWC2_GINTSTS_MODEMISMATCH			(1 << 1)
-#define DWC2_GINTSTS_MODEMISMATCH_OFFSET		1
-#define DWC2_GINTSTS_OTGINTR				(1 << 2)
-#define DWC2_GINTSTS_OTGINTR_OFFSET			2
-#define DWC2_GINTSTS_SOFINTR				(1 << 3)
-#define DWC2_GINTSTS_SOFINTR_OFFSET			3
-#define DWC2_GINTSTS_RXSTSQLVL				(1 << 4)
-#define DWC2_GINTSTS_RXSTSQLVL_OFFSET			4
-#define DWC2_GINTSTS_NPTXFEMPTY				(1 << 5)
-#define DWC2_GINTSTS_NPTXFEMPTY_OFFSET			5
-#define DWC2_GINTSTS_GINNAKEFF				(1 << 6)
-#define DWC2_GINTSTS_GINNAKEFF_OFFSET			6
-#define DWC2_GINTSTS_GOUTNAKEFF				(1 << 7)
-#define DWC2_GINTSTS_GOUTNAKEFF_OFFSET			7
-#define DWC2_GINTSTS_I2CINTR				(1 << 9)
-#define DWC2_GINTSTS_I2CINTR_OFFSET			9
-#define DWC2_GINTSTS_ERLYSUSPEND			(1 << 10)
-#define DWC2_GINTSTS_ERLYSUSPEND_OFFSET			10
-#define DWC2_GINTSTS_USBSUSPEND				(1 << 11)
-#define DWC2_GINTSTS_USBSUSPEND_OFFSET			11
-#define DWC2_GINTSTS_USBRESET				(1 << 12)
-#define DWC2_GINTSTS_USBRESET_OFFSET			12
-#define DWC2_GINTSTS_ENUMDONE				(1 << 13)
-#define DWC2_GINTSTS_ENUMDONE_OFFSET			13
-#define DWC2_GINTSTS_ISOOUTDROP				(1 << 14)
-#define DWC2_GINTSTS_ISOOUTDROP_OFFSET			14
-#define DWC2_GINTSTS_EOPFRAME				(1 << 15)
-#define DWC2_GINTSTS_EOPFRAME_OFFSET			15
-#define DWC2_GINTSTS_INTOKENRX				(1 << 16)
-#define DWC2_GINTSTS_INTOKENRX_OFFSET			16
-#define DWC2_GINTSTS_EPMISMATCH				(1 << 17)
-#define DWC2_GINTSTS_EPMISMATCH_OFFSET			17
-#define DWC2_GINTSTS_INEPINT				(1 << 18)
-#define DWC2_GINTSTS_INEPINT_OFFSET			18
-#define DWC2_GINTSTS_OUTEPINTR				(1 << 19)
-#define DWC2_GINTSTS_OUTEPINTR_OFFSET			19
-#define DWC2_GINTSTS_INCOMPLISOIN			(1 << 20)
-#define DWC2_GINTSTS_INCOMPLISOIN_OFFSET		20
-#define DWC2_GINTSTS_INCOMPLISOOUT			(1 << 21)
-#define DWC2_GINTSTS_INCOMPLISOOUT_OFFSET		21
-#define DWC2_GINTSTS_PORTINTR				(1 << 24)
-#define DWC2_GINTSTS_PORTINTR_OFFSET			24
-#define DWC2_GINTSTS_HCINTR				(1 << 25)
-#define DWC2_GINTSTS_HCINTR_OFFSET			25
-#define DWC2_GINTSTS_PTXFEMPTY				(1 << 26)
-#define DWC2_GINTSTS_PTXFEMPTY_OFFSET			26
-#define DWC2_GINTSTS_LPMTRANRCVD			(1 << 27)
-#define DWC2_GINTSTS_LPMTRANRCVD_OFFSET			27
-#define DWC2_GINTSTS_CONIDSTSCHNG			(1 << 28)
-#define DWC2_GINTSTS_CONIDSTSCHNG_OFFSET		28
-#define DWC2_GINTSTS_DISCONNECT				(1 << 29)
-#define DWC2_GINTSTS_DISCONNECT_OFFSET			29
-#define DWC2_GINTSTS_SESSREQINTR			(1 << 30)
-#define DWC2_GINTSTS_SESSREQINTR_OFFSET			30
-#define DWC2_GINTSTS_WKUPINTR				(1 << 31)
-#define DWC2_GINTSTS_WKUPINTR_OFFSET			31
-#define DWC2_GRXSTS_EPNUM_MASK				(0xF << 0)
-#define DWC2_GRXSTS_EPNUM_OFFSET			0
-#define DWC2_GRXSTS_BCNT_MASK				(0x7FF << 4)
-#define DWC2_GRXSTS_BCNT_OFFSET				4
-#define DWC2_GRXSTS_DPID_MASK				(0x3 << 15)
-#define DWC2_GRXSTS_DPID_OFFSET				15
-#define DWC2_GRXSTS_PKTSTS_MASK				(0xF << 17)
-#define DWC2_GRXSTS_PKTSTS_OFFSET			17
-#define DWC2_GRXSTS_FN_MASK				(0xF << 21)
-#define DWC2_GRXSTS_FN_OFFSET				21
-#define DWC2_FIFOSIZE_STARTADDR_MASK			(0xFFFF << 0)
-#define DWC2_FIFOSIZE_STARTADDR_OFFSET			0
-#define DWC2_FIFOSIZE_DEPTH_MASK			(0xFFFF << 16)
-#define DWC2_FIFOSIZE_DEPTH_OFFSET			16
-#define DWC2_GNPTXSTS_NPTXFSPCAVAIL_MASK		(0xFFFF << 0)
-#define DWC2_GNPTXSTS_NPTXFSPCAVAIL_OFFSET		0
-#define DWC2_GNPTXSTS_NPTXQSPCAVAIL_MASK		(0xFF << 16)
-#define DWC2_GNPTXSTS_NPTXQSPCAVAIL_OFFSET		16
-#define DWC2_GNPTXSTS_NPTXQTOP_TERMINATE		(1 << 24)
-#define DWC2_GNPTXSTS_NPTXQTOP_TERMINATE_OFFSET		24
-#define DWC2_GNPTXSTS_NPTXQTOP_TOKEN_MASK		(0x3 << 25)
-#define DWC2_GNPTXSTS_NPTXQTOP_TOKEN_OFFSET		25
-#define DWC2_GNPTXSTS_NPTXQTOP_CHNEP_MASK		(0xF << 27)
-#define DWC2_GNPTXSTS_NPTXQTOP_CHNEP_OFFSET		27
-#define DWC2_DTXFSTS_TXFSPCAVAIL_MASK			(0xFFFF << 0)
-#define DWC2_DTXFSTS_TXFSPCAVAIL_OFFSET			0
-#define DWC2_GI2CCTL_RWDATA_MASK			(0xFF << 0)
-#define DWC2_GI2CCTL_RWDATA_OFFSET			0
-#define DWC2_GI2CCTL_REGADDR_MASK			(0xFF << 8)
-#define DWC2_GI2CCTL_REGADDR_OFFSET			8
-#define DWC2_GI2CCTL_ADDR_MASK				(0x7F << 16)
-#define DWC2_GI2CCTL_ADDR_OFFSET			16
-#define DWC2_GI2CCTL_I2CEN				(1 << 23)
-#define DWC2_GI2CCTL_I2CEN_OFFSET			23
-#define DWC2_GI2CCTL_ACK				(1 << 24)
-#define DWC2_GI2CCTL_ACK_OFFSET				24
-#define DWC2_GI2CCTL_I2CSUSPCTL				(1 << 25)
-#define DWC2_GI2CCTL_I2CSUSPCTL_OFFSET			25
-#define DWC2_GI2CCTL_I2CDEVADDR_MASK			(0x3 << 26)
-#define DWC2_GI2CCTL_I2CDEVADDR_OFFSET			26
-#define DWC2_GI2CCTL_RW					(1 << 30)
-#define DWC2_GI2CCTL_RW_OFFSET				30
-#define DWC2_GI2CCTL_BSYDNE				(1 << 31)
-#define DWC2_GI2CCTL_BSYDNE_OFFSET			31
-#define DWC2_HWCFG1_EP_DIR0_MASK			(0x3 << 0)
-#define DWC2_HWCFG1_EP_DIR0_OFFSET			0
-#define DWC2_HWCFG1_EP_DIR1_MASK			(0x3 << 2)
-#define DWC2_HWCFG1_EP_DIR1_OFFSET			2
-#define DWC2_HWCFG1_EP_DIR2_MASK			(0x3 << 4)
-#define DWC2_HWCFG1_EP_DIR2_OFFSET			4
-#define DWC2_HWCFG1_EP_DIR3_MASK			(0x3 << 6)
-#define DWC2_HWCFG1_EP_DIR3_OFFSET			6
-#define DWC2_HWCFG1_EP_DIR4_MASK			(0x3 << 8)
-#define DWC2_HWCFG1_EP_DIR4_OFFSET			8
-#define DWC2_HWCFG1_EP_DIR5_MASK			(0x3 << 10)
-#define DWC2_HWCFG1_EP_DIR5_OFFSET			10
-#define DWC2_HWCFG1_EP_DIR6_MASK			(0x3 << 12)
-#define DWC2_HWCFG1_EP_DIR6_OFFSET			12
-#define DWC2_HWCFG1_EP_DIR7_MASK			(0x3 << 14)
-#define DWC2_HWCFG1_EP_DIR7_OFFSET			14
-#define DWC2_HWCFG1_EP_DIR8_MASK			(0x3 << 16)
-#define DWC2_HWCFG1_EP_DIR8_OFFSET			16
-#define DWC2_HWCFG1_EP_DIR9_MASK			(0x3 << 18)
-#define DWC2_HWCFG1_EP_DIR9_OFFSET			18
-#define DWC2_HWCFG1_EP_DIR10_MASK			(0x3 << 20)
-#define DWC2_HWCFG1_EP_DIR10_OFFSET			20
-#define DWC2_HWCFG1_EP_DIR11_MASK			(0x3 << 22)
-#define DWC2_HWCFG1_EP_DIR11_OFFSET			22
-#define DWC2_HWCFG1_EP_DIR12_MASK			(0x3 << 24)
-#define DWC2_HWCFG1_EP_DIR12_OFFSET			24
-#define DWC2_HWCFG1_EP_DIR13_MASK			(0x3 << 26)
-#define DWC2_HWCFG1_EP_DIR13_OFFSET			26
-#define DWC2_HWCFG1_EP_DIR14_MASK			(0x3 << 28)
-#define DWC2_HWCFG1_EP_DIR14_OFFSET			28
-#define DWC2_HWCFG1_EP_DIR15_MASK			(0x3 << 30)
-#define DWC2_HWCFG1_EP_DIR15_OFFSET			30
-#define DWC2_HWCFG2_OP_MODE_MASK			(0x7 << 0)
-#define DWC2_HWCFG2_OP_MODE_OFFSET			0
-#define DWC2_HWCFG2_ARCHITECTURE_SLAVE_ONLY		(0x0 << 3)
-#define DWC2_HWCFG2_ARCHITECTURE_EXT_DMA		(0x1 << 3)
-#define DWC2_HWCFG2_ARCHITECTURE_INT_DMA		(0x2 << 3)
-#define DWC2_HWCFG2_ARCHITECTURE_MASK			(0x3 << 3)
-#define DWC2_HWCFG2_ARCHITECTURE_OFFSET			3
-#define DWC2_HWCFG2_POINT2POINT				(1 << 5)
-#define DWC2_HWCFG2_POINT2POINT_OFFSET			5
-#define DWC2_HWCFG2_HS_PHY_TYPE_MASK			(0x3 << 6)
-#define DWC2_HWCFG2_HS_PHY_TYPE_OFFSET			6
-#define DWC2_HWCFG2_FS_PHY_TYPE_MASK			(0x3 << 8)
-#define DWC2_HWCFG2_FS_PHY_TYPE_OFFSET			8
-#define DWC2_HWCFG2_NUM_DEV_EP_MASK			(0xF << 10)
-#define DWC2_HWCFG2_NUM_DEV_EP_OFFSET			10
-#define DWC2_HWCFG2_NUM_HOST_CHAN_MASK			(0xF << 14)
-#define DWC2_HWCFG2_NUM_HOST_CHAN_OFFSET		14
-#define DWC2_HWCFG2_PERIO_EP_SUPPORTED			(1 << 18)
-#define DWC2_HWCFG2_PERIO_EP_SUPPORTED_OFFSET		18
-#define DWC2_HWCFG2_DYNAMIC_FIFO			(1 << 19)
-#define DWC2_HWCFG2_DYNAMIC_FIFO_OFFSET			19
-#define DWC2_HWCFG2_MULTI_PROC_INT			(1 << 20)
-#define DWC2_HWCFG2_MULTI_PROC_INT_OFFSET		20
-#define DWC2_HWCFG2_NONPERIO_TX_Q_DEPTH_MASK		(0x3 << 22)
-#define DWC2_HWCFG2_NONPERIO_TX_Q_DEPTH_OFFSET		22
-#define DWC2_HWCFG2_HOST_PERIO_TX_Q_DEPTH_MASK		(0x3 << 24)
-#define DWC2_HWCFG2_HOST_PERIO_TX_Q_DEPTH_OFFSET	24
-#define DWC2_HWCFG2_DEV_TOKEN_Q_DEPTH_MASK		(0x1F << 26)
-#define DWC2_HWCFG2_DEV_TOKEN_Q_DEPTH_OFFSET		26
-#define DWC2_HWCFG3_XFER_SIZE_CNTR_WIDTH_MASK		(0xF << 0)
-#define DWC2_HWCFG3_XFER_SIZE_CNTR_WIDTH_OFFSET		0
-#define DWC2_HWCFG3_PACKET_SIZE_CNTR_WIDTH_MASK		(0x7 << 4)
-#define DWC2_HWCFG3_PACKET_SIZE_CNTR_WIDTH_OFFSET	4
-#define DWC2_HWCFG3_OTG_FUNC				(1 << 7)
-#define DWC2_HWCFG3_OTG_FUNC_OFFSET			7
-#define DWC2_HWCFG3_I2C					(1 << 8)
-#define DWC2_HWCFG3_I2C_OFFSET				8
-#define DWC2_HWCFG3_VENDOR_CTRL_IF			(1 << 9)
-#define DWC2_HWCFG3_VENDOR_CTRL_IF_OFFSET		9
-#define DWC2_HWCFG3_OPTIONAL_FEATURES			(1 << 10)
-#define DWC2_HWCFG3_OPTIONAL_FEATURES_OFFSET		10
-#define DWC2_HWCFG3_SYNCH_RESET_TYPE			(1 << 11)
-#define DWC2_HWCFG3_SYNCH_RESET_TYPE_OFFSET		11
-#define DWC2_HWCFG3_OTG_ENABLE_IC_USB			(1 << 12)
-#define DWC2_HWCFG3_OTG_ENABLE_IC_USB_OFFSET		12
-#define DWC2_HWCFG3_OTG_ENABLE_HSIC			(1 << 13)
-#define DWC2_HWCFG3_OTG_ENABLE_HSIC_OFFSET		13
-#define DWC2_HWCFG3_OTG_LPM_EN				(1 << 15)
-#define DWC2_HWCFG3_OTG_LPM_EN_OFFSET			15
-#define DWC2_HWCFG3_DFIFO_DEPTH_MASK			(0xFFFF << 16)
-#define DWC2_HWCFG3_DFIFO_DEPTH_OFFSET			16
-#define DWC2_HWCFG4_NUM_DEV_PERIO_IN_EP_MASK		(0xF << 0)
-#define DWC2_HWCFG4_NUM_DEV_PERIO_IN_EP_OFFSET		0
-#define DWC2_HWCFG4_POWER_OPTIMIZ			(1 << 4)
-#define DWC2_HWCFG4_POWER_OPTIMIZ_OFFSET		4
-#define DWC2_HWCFG4_MIN_AHB_FREQ_MASK			(0x1FF << 5)
-#define DWC2_HWCFG4_MIN_AHB_FREQ_OFFSET			5
-#define DWC2_HWCFG4_UTMI_PHY_DATA_WIDTH_MASK		(0x3 << 14)
-#define DWC2_HWCFG4_UTMI_PHY_DATA_WIDTH_OFFSET		14
-#define DWC2_HWCFG4_NUM_DEV_MODE_CTRL_EP_MASK		(0xF << 16)
-#define DWC2_HWCFG4_NUM_DEV_MODE_CTRL_EP_OFFSET		16
-#define DWC2_HWCFG4_IDDIG_FILT_EN			(1 << 20)
-#define DWC2_HWCFG4_IDDIG_FILT_EN_OFFSET		20
-#define DWC2_HWCFG4_VBUS_VALID_FILT_EN			(1 << 21)
-#define DWC2_HWCFG4_VBUS_VALID_FILT_EN_OFFSET		21
-#define DWC2_HWCFG4_A_VALID_FILT_EN			(1 << 22)
-#define DWC2_HWCFG4_A_VALID_FILT_EN_OFFSET		22
-#define DWC2_HWCFG4_B_VALID_FILT_EN			(1 << 23)
-#define DWC2_HWCFG4_B_VALID_FILT_EN_OFFSET		23
-#define DWC2_HWCFG4_SESSION_END_FILT_EN			(1 << 24)
-#define DWC2_HWCFG4_SESSION_END_FILT_EN_OFFSET		24
-#define DWC2_HWCFG4_DED_FIFO_EN				(1 << 25)
-#define DWC2_HWCFG4_DED_FIFO_EN_OFFSET			25
-#define DWC2_HWCFG4_NUM_IN_EPS_MASK			(0xF << 26)
-#define DWC2_HWCFG4_NUM_IN_EPS_OFFSET			26
-#define DWC2_HWCFG4_DESC_DMA				(1 << 30)
-#define DWC2_HWCFG4_DESC_DMA_OFFSET			30
-#define DWC2_HWCFG4_DESC_DMA_DYN			(1 << 31)
-#define DWC2_HWCFG4_DESC_DMA_DYN_OFFSET			31
-#define DWC2_HCFG_FSLSPCLKSEL_30_60_MHZ			0
-#define DWC2_HCFG_FSLSPCLKSEL_48_MHZ			1
-#define DWC2_HCFG_FSLSPCLKSEL_6_MHZ			2
-#define DWC2_HCFG_FSLSPCLKSEL_MASK			(0x3 << 0)
-#define DWC2_HCFG_FSLSPCLKSEL_OFFSET			0
-#define DWC2_HCFG_FSLSSUPP				(1 << 2)
-#define DWC2_HCFG_FSLSSUPP_OFFSET			2
-#define DWC2_HCFG_DESCDMA				(1 << 23)
-#define DWC2_HCFG_DESCDMA_OFFSET			23
-#define DWC2_HCFG_FRLISTEN_MASK				(0x3 << 24)
-#define DWC2_HCFG_FRLISTEN_OFFSET			24
-#define DWC2_HCFG_PERSCHEDENA				(1 << 26)
-#define DWC2_HCFG_PERSCHEDENA_OFFSET			26
-#define DWC2_HCFG_PERSCHEDSTAT				(1 << 27)
-#define DWC2_HCFG_PERSCHEDSTAT_OFFSET			27
-#define DWC2_HFIR_FRINT_MASK				(0xFFFF << 0)
-#define DWC2_HFIR_FRINT_OFFSET				0
-#define DWC2_HFNUM_FRNUM_MASK				(0xFFFF << 0)
-#define DWC2_HFNUM_FRNUM_OFFSET				0
-#define DWC2_HFNUM_FRREM_MASK				(0xFFFF << 16)
-#define DWC2_HFNUM_FRREM_OFFSET				16
-#define DWC2_HFNUM_MAX_FRNUM				0x3FFF
-#define DWC2_HPTXSTS_PTXFSPCAVAIL_MASK			(0xFFFF << 0)
-#define DWC2_HPTXSTS_PTXFSPCAVAIL_OFFSET		0
-#define DWC2_HPTXSTS_PTXQSPCAVAIL_MASK			(0xFF << 16)
-#define DWC2_HPTXSTS_PTXQSPCAVAIL_OFFSET		16
-#define DWC2_HPTXSTS_PTXQTOP_TERMINATE			(1 << 24)
-#define DWC2_HPTXSTS_PTXQTOP_TERMINATE_OFFSET		24
-#define DWC2_HPTXSTS_PTXQTOP_TOKEN_MASK			(0x3 << 25)
-#define DWC2_HPTXSTS_PTXQTOP_TOKEN_OFFSET		25
-#define DWC2_HPTXSTS_PTXQTOP_CHNUM_MASK			(0xF << 27)
-#define DWC2_HPTXSTS_PTXQTOP_CHNUM_OFFSET		27
-#define DWC2_HPTXSTS_PTXQTOP_ODD			(1 << 31)
-#define DWC2_HPTXSTS_PTXQTOP_ODD_OFFSET			31
-#define DWC2_HPRT0_PRTCONNSTS				(1 << 0)
-#define DWC2_HPRT0_PRTCONNSTS_OFFSET			0
-#define DWC2_HPRT0_PRTCONNDET				(1 << 1)
-#define DWC2_HPRT0_PRTCONNDET_OFFSET			1
-#define DWC2_HPRT0_PRTENA				(1 << 2)
-#define DWC2_HPRT0_PRTENA_OFFSET			2
-#define DWC2_HPRT0_PRTENCHNG				(1 << 3)
-#define DWC2_HPRT0_PRTENCHNG_OFFSET			3
-#define DWC2_HPRT0_PRTOVRCURRACT			(1 << 4)
-#define DWC2_HPRT0_PRTOVRCURRACT_OFFSET			4
-#define DWC2_HPRT0_PRTOVRCURRCHNG			(1 << 5)
-#define DWC2_HPRT0_PRTOVRCURRCHNG_OFFSET		5
-#define DWC2_HPRT0_PRTRES				(1 << 6)
-#define DWC2_HPRT0_PRTRES_OFFSET			6
-#define DWC2_HPRT0_PRTSUSP				(1 << 7)
-#define DWC2_HPRT0_PRTSUSP_OFFSET			7
-#define DWC2_HPRT0_PRTRST				(1 << 8)
-#define DWC2_HPRT0_PRTRST_OFFSET			8
-#define DWC2_HPRT0_PRTLNSTS_MASK			(0x3 << 10)
-#define DWC2_HPRT0_PRTLNSTS_OFFSET			10
-#define DWC2_HPRT0_PRTPWR				(1 << 12)
-#define DWC2_HPRT0_PRTPWR_OFFSET			12
-#define DWC2_HPRT0_PRTTSTCTL_MASK			(0xF << 13)
-#define DWC2_HPRT0_PRTTSTCTL_OFFSET			13
-#define DWC2_HPRT0_PRTSPD_HIGH				(0 << 17)
-#define DWC2_HPRT0_PRTSPD_FULL				(1 << 17)
-#define DWC2_HPRT0_PRTSPD_LOW				(2 << 17)
-#define DWC2_HPRT0_PRTSPD_MASK				(0x3 << 17)
-#define DWC2_HPRT0_PRTSPD_OFFSET			17
-#define DWC2_HPRT0_W1C_MASK				(DWC2_HPRT0_PRTCONNDET | \
-							DWC2_HPRT0_PRTENA | \
-							DWC2_HPRT0_PRTENCHNG | \
-							DWC2_HPRT0_PRTOVRCURRCHNG)
-#define DWC2_HAINT_CH0					(1 << 0)
-#define DWC2_HAINT_CH0_OFFSET				0
-#define DWC2_HAINT_CH1					(1 << 1)
-#define DWC2_HAINT_CH1_OFFSET				1
-#define DWC2_HAINT_CH2					(1 << 2)
-#define DWC2_HAINT_CH2_OFFSET				2
-#define DWC2_HAINT_CH3					(1 << 3)
-#define DWC2_HAINT_CH3_OFFSET				3
-#define DWC2_HAINT_CH4					(1 << 4)
-#define DWC2_HAINT_CH4_OFFSET				4
-#define DWC2_HAINT_CH5					(1 << 5)
-#define DWC2_HAINT_CH5_OFFSET				5
-#define DWC2_HAINT_CH6					(1 << 6)
-#define DWC2_HAINT_CH6_OFFSET				6
-#define DWC2_HAINT_CH7					(1 << 7)
-#define DWC2_HAINT_CH7_OFFSET				7
-#define DWC2_HAINT_CH8					(1 << 8)
-#define DWC2_HAINT_CH8_OFFSET				8
-#define DWC2_HAINT_CH9					(1 << 9)
-#define DWC2_HAINT_CH9_OFFSET				9
-#define DWC2_HAINT_CH10					(1 << 10)
-#define DWC2_HAINT_CH10_OFFSET				10
-#define DWC2_HAINT_CH11					(1 << 11)
-#define DWC2_HAINT_CH11_OFFSET				11
-#define DWC2_HAINT_CH12					(1 << 12)
-#define DWC2_HAINT_CH12_OFFSET				12
-#define DWC2_HAINT_CH13					(1 << 13)
-#define DWC2_HAINT_CH13_OFFSET				13
-#define DWC2_HAINT_CH14					(1 << 14)
-#define DWC2_HAINT_CH14_OFFSET				14
-#define DWC2_HAINT_CH15					(1 << 15)
-#define DWC2_HAINT_CH15_OFFSET				15
-#define DWC2_HAINT_CHINT_MASK				0xffff
-#define DWC2_HAINT_CHINT_OFFSET				0
-#define DWC2_HAINTMSK_CH0				(1 << 0)
-#define DWC2_HAINTMSK_CH0_OFFSET			0
-#define DWC2_HAINTMSK_CH1				(1 << 1)
-#define DWC2_HAINTMSK_CH1_OFFSET			1
-#define DWC2_HAINTMSK_CH2				(1 << 2)
-#define DWC2_HAINTMSK_CH2_OFFSET			2
-#define DWC2_HAINTMSK_CH3				(1 << 3)
-#define DWC2_HAINTMSK_CH3_OFFSET			3
-#define DWC2_HAINTMSK_CH4				(1 << 4)
-#define DWC2_HAINTMSK_CH4_OFFSET			4
-#define DWC2_HAINTMSK_CH5				(1 << 5)
-#define DWC2_HAINTMSK_CH5_OFFSET			5
-#define DWC2_HAINTMSK_CH6				(1 << 6)
-#define DWC2_HAINTMSK_CH6_OFFSET			6
-#define DWC2_HAINTMSK_CH7				(1 << 7)
-#define DWC2_HAINTMSK_CH7_OFFSET			7
-#define DWC2_HAINTMSK_CH8				(1 << 8)
-#define DWC2_HAINTMSK_CH8_OFFSET			8
-#define DWC2_HAINTMSK_CH9				(1 << 9)
-#define DWC2_HAINTMSK_CH9_OFFSET			9
-#define DWC2_HAINTMSK_CH10				(1 << 10)
-#define DWC2_HAINTMSK_CH10_OFFSET			10
-#define DWC2_HAINTMSK_CH11				(1 << 11)
-#define DWC2_HAINTMSK_CH11_OFFSET			11
-#define DWC2_HAINTMSK_CH12				(1 << 12)
-#define DWC2_HAINTMSK_CH12_OFFSET			12
-#define DWC2_HAINTMSK_CH13				(1 << 13)
-#define DWC2_HAINTMSK_CH13_OFFSET			13
-#define DWC2_HAINTMSK_CH14				(1 << 14)
-#define DWC2_HAINTMSK_CH14_OFFSET			14
-#define DWC2_HAINTMSK_CH15				(1 << 15)
-#define DWC2_HAINTMSK_CH15_OFFSET			15
-#define DWC2_HAINTMSK_CHINT_MASK			0xffff
-#define DWC2_HAINTMSK_CHINT_OFFSET			0
-#define DWC2_HCCHAR_MPS_MASK				(0x7FF << 0)
-#define DWC2_HCCHAR_MPS_OFFSET				0
-#define DWC2_HCCHAR_EPNUM_MASK				(0xF << 11)
-#define DWC2_HCCHAR_EPNUM_OFFSET			11
-#define DWC2_HCCHAR_EPDIR				(1 << 15)
-#define DWC2_HCCHAR_EPDIR_OFFSET			15
-#define DWC2_HCCHAR_LSPDDEV				(1 << 17)
-#define DWC2_HCCHAR_LSPDDEV_OFFSET			17
-#define DWC2_HCCHAR_EPTYPE_CONTROL			0
-#define DWC2_HCCHAR_EPTYPE_ISOC				1
-#define DWC2_HCCHAR_EPTYPE_BULK				2
-#define DWC2_HCCHAR_EPTYPE_INTR				3
-#define DWC2_HCCHAR_EPTYPE_MASK				(0x3 << 18)
-#define DWC2_HCCHAR_EPTYPE_OFFSET			18
-#define DWC2_HCCHAR_MULTICNT_MASK			(0x3 << 20)
-#define DWC2_HCCHAR_MULTICNT_OFFSET			20
-#define DWC2_HCCHAR_DEVADDR_MASK			(0x7F << 22)
-#define DWC2_HCCHAR_DEVADDR_OFFSET			22
-#define DWC2_HCCHAR_ODDFRM				(1 << 29)
-#define DWC2_HCCHAR_ODDFRM_OFFSET			29
-#define DWC2_HCCHAR_CHDIS				(1 << 30)
-#define DWC2_HCCHAR_CHDIS_OFFSET			30
-#define DWC2_HCCHAR_CHEN				(1 << 31)
-#define DWC2_HCCHAR_CHEN_OFFSET				31
-#define DWC2_HCSPLT_PRTADDR_MASK			(0x7F << 0)
-#define DWC2_HCSPLT_PRTADDR_OFFSET			0
-#define DWC2_HCSPLT_HUBADDR_MASK			(0x7F << 7)
-#define DWC2_HCSPLT_HUBADDR_OFFSET			7
-#define DWC2_HCSPLT_XACTPOS_MASK			(0x3 << 14)
-#define DWC2_HCSPLT_XACTPOS_OFFSET			14
-#define DWC2_HCSPLT_COMPSPLT				(1 << 16)
-#define DWC2_HCSPLT_COMPSPLT_OFFSET			16
-#define DWC2_HCSPLT_SPLTENA				(1 << 31)
-#define DWC2_HCSPLT_SPLTENA_OFFSET			31
-#define DWC2_HCINT_XFERCOMP				(1 << 0)
-#define DWC2_HCINT_XFERCOMP_OFFSET			0
-#define DWC2_HCINT_CHHLTD				(1 << 1)
-#define DWC2_HCINT_CHHLTD_OFFSET			1
-#define DWC2_HCINT_AHBERR				(1 << 2)
-#define DWC2_HCINT_AHBERR_OFFSET			2
-#define DWC2_HCINT_STALL				(1 << 3)
-#define DWC2_HCINT_STALL_OFFSET				3
-#define DWC2_HCINT_NAK					(1 << 4)
-#define DWC2_HCINT_NAK_OFFSET				4
-#define DWC2_HCINT_ACK					(1 << 5)
-#define DWC2_HCINT_ACK_OFFSET				5
-#define DWC2_HCINT_NYET					(1 << 6)
-#define DWC2_HCINT_NYET_OFFSET				6
-#define DWC2_HCINT_XACTERR				(1 << 7)
-#define DWC2_HCINT_XACTERR_OFFSET			7
-#define DWC2_HCINT_BBLERR				(1 << 8)
-#define DWC2_HCINT_BBLERR_OFFSET			8
-#define DWC2_HCINT_FRMOVRUN				(1 << 9)
-#define DWC2_HCINT_FRMOVRUN_OFFSET			9
-#define DWC2_HCINT_DATATGLERR				(1 << 10)
-#define DWC2_HCINT_DATATGLERR_OFFSET			10
-#define DWC2_HCINT_BNA					(1 << 11)
-#define DWC2_HCINT_BNA_OFFSET				11
-#define DWC2_HCINT_XCS_XACT				(1 << 12)
-#define DWC2_HCINT_XCS_XACT_OFFSET			12
-#define DWC2_HCINT_FRM_LIST_ROLL			(1 << 13)
-#define DWC2_HCINT_FRM_LIST_ROLL_OFFSET			13
-#define DWC2_HCINTMSK_XFERCOMPL				(1 << 0)
-#define DWC2_HCINTMSK_XFERCOMPL_OFFSET			0
-#define DWC2_HCINTMSK_CHHLTD				(1 << 1)
-#define DWC2_HCINTMSK_CHHLTD_OFFSET			1
-#define DWC2_HCINTMSK_AHBERR				(1 << 2)
-#define DWC2_HCINTMSK_AHBERR_OFFSET			2
-#define DWC2_HCINTMSK_STALL				(1 << 3)
-#define DWC2_HCINTMSK_STALL_OFFSET			3
-#define DWC2_HCINTMSK_NAK				(1 << 4)
-#define DWC2_HCINTMSK_NAK_OFFSET			4
-#define DWC2_HCINTMSK_ACK				(1 << 5)
-#define DWC2_HCINTMSK_ACK_OFFSET			5
-#define DWC2_HCINTMSK_NYET				(1 << 6)
-#define DWC2_HCINTMSK_NYET_OFFSET			6
-#define DWC2_HCINTMSK_XACTERR				(1 << 7)
-#define DWC2_HCINTMSK_XACTERR_OFFSET			7
-#define DWC2_HCINTMSK_BBLERR				(1 << 8)
-#define DWC2_HCINTMSK_BBLERR_OFFSET			8
-#define DWC2_HCINTMSK_FRMOVRUN				(1 << 9)
-#define DWC2_HCINTMSK_FRMOVRUN_OFFSET			9
-#define DWC2_HCINTMSK_DATATGLERR			(1 << 10)
-#define DWC2_HCINTMSK_DATATGLERR_OFFSET			10
-#define DWC2_HCINTMSK_BNA				(1 << 11)
-#define DWC2_HCINTMSK_BNA_OFFSET			11
-#define DWC2_HCINTMSK_XCS_XACT				(1 << 12)
-#define DWC2_HCINTMSK_XCS_XACT_OFFSET			12
-#define DWC2_HCINTMSK_FRM_LIST_ROLL			(1 << 13)
-#define DWC2_HCINTMSK_FRM_LIST_ROLL_OFFSET		13
-#define DWC2_HCTSIZ_XFERSIZE_MASK			0x7ffff
-#define DWC2_HCTSIZ_XFERSIZE_OFFSET			0
-#define DWC2_HCTSIZ_SCHINFO_MASK			0xff
-#define DWC2_HCTSIZ_SCHINFO_OFFSET			0
-#define DWC2_HCTSIZ_NTD_MASK				(0xff << 8)
-#define DWC2_HCTSIZ_NTD_OFFSET				8
-#define DWC2_HCTSIZ_PKTCNT_MASK				(0x3ff << 19)
-#define DWC2_HCTSIZ_PKTCNT_OFFSET			19
-#define DWC2_HCTSIZ_PID_MASK				(0x3 << 29)
-#define DWC2_HCTSIZ_PID_OFFSET				29
-#define DWC2_HCTSIZ_DOPNG				(1 << 31)
-#define DWC2_HCTSIZ_DOPNG_OFFSET			31
-#define DWC2_HCDMA_CTD_MASK				(0xFF << 3)
-#define DWC2_HCDMA_CTD_OFFSET				3
-#define DWC2_HCDMA_DMA_ADDR_MASK			(0x1FFFFF << 11)
-#define DWC2_HCDMA_DMA_ADDR_OFFSET			11
-#define DWC2_PCGCCTL_STOPPCLK				(1 << 0)
-#define DWC2_PCGCCTL_STOPPCLK_OFFSET			0
-#define DWC2_PCGCCTL_GATEHCLK				(1 << 1)
-#define DWC2_PCGCCTL_GATEHCLK_OFFSET			1
-#define DWC2_PCGCCTL_PWRCLMP				(1 << 2)
-#define DWC2_PCGCCTL_PWRCLMP_OFFSET			2
-#define DWC2_PCGCCTL_RSTPDWNMODULE			(1 << 3)
-#define DWC2_PCGCCTL_RSTPDWNMODULE_OFFSET		3
-#define DWC2_PCGCCTL_PHYSUSPENDED			(1 << 4)
-#define DWC2_PCGCCTL_PHYSUSPENDED_OFFSET		4
-#define DWC2_PCGCCTL_ENBL_SLEEP_GATING			(1 << 5)
-#define DWC2_PCGCCTL_ENBL_SLEEP_GATING_OFFSET		5
-#define DWC2_PCGCCTL_PHY_IN_SLEEP			(1 << 6)
-#define DWC2_PCGCCTL_PHY_IN_SLEEP_OFFSET		6
-#define DWC2_PCGCCTL_DEEP_SLEEP				(1 << 7)
-#define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET			7
-#define DWC2_SNPSID_DEVID_VER_2xx			(0x4f542 << 12)
-#define DWC2_SNPSID_DEVID_VER_3xx			(0x4f543 << 12)
-#define DWC2_SNPSID_DEVID_MASK				(0xfffff << 12)
-#define DWC2_SNPSID_DEVID_OFFSET			12
-
 /* Host controller specific */
 #define DWC2_HC_PID_DATA0		0
 #define DWC2_HC_PID_DATA2		1
-- 
2.41.0

