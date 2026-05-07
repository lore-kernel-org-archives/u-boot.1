Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBF0CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D50C84AC2;
	Thu,  7 May 2026 11:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SHGu9Hup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C462A84AC9; Thu,  7 May 2026 11:30:08 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B5484A97
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a86bfa2a4eso758342e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146187; x=1778750987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5BKQGK1hnPnytx5Jv5MuEFIvgT28Y8sGQ9uvVkL+o0=;
 b=SHGu9HupDgtOI3cYHmyjFJb/rOKoLUutNN60ebTOlZokub3RLq3G425q9WF+dUR3VV
 6W1VY/HSPKILkh5Ie8vpzp771wRUVz9lNP12TpIebPnPzHIyqUDkhtaNNvW9msGTeAC9
 FELPwB1D9HJljjfUqL6/iiT0eXeUDj3EzAJudLyflm4BQbvjBtE79RHwC1F7K4brzHX6
 g9X7HUANEGiSm/tIQps2Hpnek27+0l/umSajYdTvXUKOkg5ZjPp/1k7ACe1JYZb7nl35
 PaHFJZjbO/US0vFRBTbevevltX2Te40XWxJyqJZrMvsxJ9WkCn8/gbQALcXwoFwi0UXY
 irgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146187; x=1778750987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l5BKQGK1hnPnytx5Jv5MuEFIvgT28Y8sGQ9uvVkL+o0=;
 b=T5xvucDjnokQw7D/6GGZHWCBv9a7PxYzyzvTSk7sG/rY2Kx/UoogYV0fgLnDZm959n
 N7U8nv0xkqj49icjC/QkhC4bAzoo9JQ1fZTKbqwCiJwb4SQSUEbzgo+e2/NbJn4QlVIO
 zdQE3At6ODZBxgeukhdaWqRMhNyt7gjUg+OQb5Lzv2N2ZVzQWBM29ex16f10kH/veiMc
 eAzjCoGyhjQZOTMRftC/rYQ5km0rqNzNuxZ/Ab62Oqhxy+NFUv9l4Ug5Vj8sl+73KlC4
 DOtxf4+DR3JptDI5QuMsazuccURlmJwoQAOJhUURDMvWI5pS4/HtnhfIOuBVyQVCA/E7
 MdCw==
X-Gm-Message-State: AOJu0YwhqvGaG4v0PaLNshTZB8YPnWAmiWqE4k3F2QscgtmlVPX8ibVN
 dVqwVAKapB/8w02a5kx/530ZikhtxPdA2V/yhFkhkYclIANsyaKmyqqOyvr2/rhLAnd/lh7X+Y7
 QcaC9XBwF2Q==
X-Gm-Gg: AeBDievE5jhw7cAC9JdQZLUCDD9qZ9VxJzoT+70mNpT73NjvBPROHYSR/IXtvUfhYBN
 zNRWCJgenksZxtkPR3VhLxyoh9eWKQZIXdxH0U4G8C6NhGxhDAqYEfl+OexL4anTvAlWxKyBLBv
 uWcDvQUDVHx2rkM+j+Hr+vx4qdahaeNr+9C29sCOqC75+NLmDmfZvTvCkGrlDrmlwH+OjhRqJCd
 2vaX2ss43+gy+Le4ZNTJ2rDrAZ7jYdUM+BAvYrsIY0xUWecTcWvtG6yMf++S1n64NIJmz5pwpiu
 jrBwES00SFRZgfEC5M8gGqQCyjqt9vdsEHZBp+Oi4rvwCLhwNbPXnUtts4VZzwUNaj7xuRl4kUE
 lYeYfvpC4ubmzpXZln5/TpCpmnvL4Dsu3doBei9BIcHhwEes/qF7gFwwR/FGTVTkwkePgB7gE5m
 xSz/5L6s9AZqXca3bjmXfTQuAURfpTyA5CFVqB7+TTBy+L25KOL2k+Y+JNnCIEwS9zrfJrXLMyd
 DL2lhtJk/fbwV/UAdSoUMoMcLoMOi2dJeUjF+iX7A==
X-Received: by 2002:a05:6512:1388:b0:5a8:9c2f:56fe with SMTP id
 2adb3069b0e04-5a89c2f5830mr572895e87.35.1778146186587; 
 Thu, 07 May 2026 02:29:46 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:44 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 20/64] usb: dwc3: import from kernel v4.17
Date: Thu,  7 May 2026 11:27:27 +0200
Message-ID: <20260507092843.358908-21-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.16 to v4.17.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v4.16..v4.17
Commits imported:
96bd39df29c2 usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
9cffd15de0c3 usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static
c91815b59624 usb: dwc3: gadget: never call ->complete() from ->ep_queue()
6d23ee9caa67 Merge tag 'usb-for-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing
7d11c3ac6669 usb: dwc3: core: Fix broken system suspend/resume on AM437x
2f3090c6a8f2 usb: dwc3: Check controller type before setting speed
80b776340c78 usb: dwc3: Dump LSP and BMU debug info
938a5ad1d305 usb: dwc3: Check for ESS TX/RX threshold config
6743e817a4de usb: dwc3: Add DWC_usb31 GTXTHRCFG reg fields
01b0e2cc7d89 usb: dwc3: gadget: Check IP revision for GRXTHRCFG
2fbc5bdc8fd1 usb: dwc3: Add DWC_usb31 GRXTHRCFG bit fields
d548a61767fa usb: dwc3: Check IP revision for GTXFIFOSIZ
0cab8d26d6e5 usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
fab383333877 usb: dwc3: Add SoftReset PHY synchonization delay
cabdf83dadfb usb: dwc3: pci: Properly cleanup resource
de948a74ad6f usb: dwc3: Makefile: fix link error on randconfig
a8f25c36f732 Merge branch 4.16-rc6 into usb-next
7642d8386ac7 usb: dwc3: ep0: remove redundant assignment
498f0478aba4 usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
f09cc79b4b33 usb: dwc3: add dual role support using OTG block
daaecc6541d0 usb: dwc3: prevent setting PRTCAP to OTG from debugfs
4cff75c7fe3d usb: dwc3: core.h: add some register definitions
e8284db48f1f usb: dwc3: of-simple: add support for the Amlogic Meson GXL and AXG SoCs
ff0a632f0875 usb: dwc3: of-simple: add support for shared and pulsed reset lines
6d5b53c1fd5c usb: dwc3: debugfs: Re-use DEFINE_SHOW_ATTRIBUTE() macro
134d1fd44221 Merge 4.16-rc3 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 134 +++++++++++++++++++++++++++++++---
 drivers/usb/dwc3/core.h   | 146 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/ep0.c    |   2 +-
 drivers/usb/dwc3/gadget.c |  84 +++++++++++++++-------
 4 files changed, 332 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e94bf91cc58a..a15648d25e30 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -89,10 +89,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
 
-static void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
-static int dwc3_event_buffers_setup(struct dwc3 *dwc);
-
-static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
 
@@ -110,13 +107,19 @@ static void __dwc3_set_mode(struct work_struct *work)
 	unsigned long flags;
 	int ret;
 
+	if (dwc->dr_mode != USB_DR_MODE_OTG)
+		return;
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
+		dwc3_otg_update(dwc, 0);
+
 	if (!dwc->desired_dr_role)
 		return;
 
 	if (dwc->desired_dr_role == dwc->current_dr_role)
 		return;
 
-	if (dwc->dr_mode != USB_DR_MODE_OTG)
+	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
 		return;
 
 	switch (dwc->current_dr_role) {
@@ -127,6 +130,13 @@ static void __dwc3_set_mode(struct work_struct *work)
 		dwc3_gadget_exit(dwc);
 		dwc3_event_buffers_cleanup(dwc);
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_exit(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_otg_update(dwc, 1);
+		break;
 	default:
 		break;
 	}
@@ -162,9 +172,14 @@ static void __dwc3_set_mode(struct work_struct *work)
 		if (ret)
 			dev_err(dwc->dev, "failed to initialize peripheral\n");
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		dwc3_otg_init(dwc);
+		dwc3_otg_update(dwc, 0);
+		break;
 	default:
 		break;
 	}
+
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
@@ -229,7 +244,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
-			return 0;
+			goto done;
 
 		udelay(1);
 	} while (--retries);
@@ -238,6 +253,17 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	phy_exit(dwc->usb2_generic_phy);
 
 	return -ETIMEDOUT;
+
+done:
+	/*
+	 * For DWC_usb31 controller, once DWC3_DCTL_CSFTRST bit is cleared,
+	 * we must wait at least 50ms before accessing the PHY domain
+	 * (synchronization delay). DWC_usb31 programming guide section 1.3.2.
+	 */
+	if (dwc3_is_usb31(dwc))
+		msleep(50);
+
+	return 0;
 }
 
 /*
@@ -348,7 +374,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
  *
  * Returns 0 on success otherwise negative errno.
  */
-static int dwc3_event_buffers_setup(struct dwc3 *dwc)
+int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -365,7 +391,7 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 	return 0;
 }
 
-static void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
+void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
 
@@ -846,6 +872,43 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	/*
+	 * Must config both number of packets and max burst settings to enable
+	 * RX and/or TX threshold.
+	 */
+	if (dwc3_is_usb31(dwc) && dwc->dr_mode == USB_DR_MODE_HOST) {
+		u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
+		u8 rx_maxburst = dwc->rx_max_burst_prd;
+		u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
+		u8 tx_maxburst = dwc->tx_max_burst_prd;
+
+		if (rx_thr_num && rx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
+			reg |= DWC31_RXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
+
+			reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
+		}
+
+		if (tx_thr_num && tx_maxburst) {
+			reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
+			reg |= DWC31_TXTHRNUMPKTSEL_PRD;
+
+			reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
+			reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
+
+			reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
+			reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
+
+			dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
+		}
+	}
+
 	return 0;
 
 err4:
@@ -1016,6 +1079,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt_prd;
+	u8			rx_max_burst_prd;
+	u8			tx_thr_num_pkt_prd;
+	u8			tx_max_burst_prd;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xff;
@@ -1050,6 +1117,14 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				&hird_threshold);
 	dwc->usb3_lpm_capable = device_property_read_bool(dev,
 				"snps,usb3_lpm_capable");
+	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
+				&rx_thr_num_pkt_prd);
+	device_property_read_u8(dev, "snps,rx-max-burst-prd",
+				&rx_max_burst_prd);
+	device_property_read_u8(dev, "snps,tx-thr-num-pkt-prd",
+				&tx_thr_num_pkt_prd);
+	device_property_read_u8(dev, "snps,tx-max-burst-prd",
+				&tx_max_burst_prd);
 
 	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
@@ -1100,6 +1175,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->hird_threshold = hird_threshold
 		| (dwc->is_utmi_l1_suspend << 4);
 
+	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
+	dwc->rx_max_burst_prd = rx_max_burst_prd;
+
+	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
+	dwc->tx_max_burst_prd = tx_max_burst_prd;
+
 	dwc->imod_interval = 0;
 }
 
@@ -1326,6 +1407,20 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		if (!PMSG_IS_AUTO(msg))
 			dwc3_core_exit(dwc);
 		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		/* do nothing during runtime_suspend */
+		if (PMSG_IS_AUTO(msg))
+			break;
+
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_gadget_suspend(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
+		}
+
+		dwc3_otg_exit(dwc);
+		dwc3_core_exit(dwc);
+		break;
 	default:
 		/* do nothing */
 		break;
@@ -1345,6 +1440,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1355,7 +1451,29 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			ret = dwc3_core_init(dwc);
 			if (ret)
 				return ret;
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		}
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		/* nothing to do on runtime_resume */
+		if (PMSG_IS_AUTO(msg))
+			break;
+
+		ret = dwc3_core_init(dwc);
+		if (ret)
+			return ret;
+
+		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+
+		dwc3_otg_init(dwc);
+		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
+			dwc3_otg_host_init(dwc);
+		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
+			spin_lock_irqsave(&dwc->lock, flags);
+			dwc3_gadget_resume(dwc);
+			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
+
 		break;
 	default:
 		/* do nothing */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 860d2bc184d1..4f3b43809917 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -58,6 +58,11 @@
 #define DWC3_DEVICE_EVENT_CMD_CMPL		10
 #define DWC3_DEVICE_EVENT_OVERFLOW		11
 
+/* Controller's role while using the OTG block */
+#define DWC3_OTG_ROLE_IDLE	0
+#define DWC3_OTG_ROLE_HOST	1
+#define DWC3_OTG_ROLE_DEVICE	2
+
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
 #define DWC3_GEVNTCOUNT_EHB	BIT(31)
 #define DWC3_GSNPSID_MASK	0xffff0000
@@ -100,6 +105,11 @@
 #define DWC3_GHWPARAMS7		0xc15c
 #define DWC3_GDBGFIFOSPACE	0xc160
 #define DWC3_GDBGLTSSM		0xc164
+#define DWC3_GDBGBMU		0xc16c
+#define DWC3_GDBGLSPMUX		0xc170
+#define DWC3_GDBGLSP		0xc174
+#define DWC3_GDBGEPINFO0	0xc178
+#define DWC3_GDBGEPINFO1	0xc17c
 #define DWC3_GPRTBIMAP_HS0	0xc180
 #define DWC3_GPRTBIMAP_HS1	0xc184
 #define DWC3_GPRTBIMAP_FS0	0xc188
@@ -173,6 +183,26 @@
 #define DWC3_GRXTHRCFG_RXPKTCNT(n) (((n) & 0xf) << 24)
 #define DWC3_GRXTHRCFG_PKTCNTSEL BIT(29)
 
+/* Global RX Threshold Configuration Register for DWC_usb31 only */
+#define DWC31_GRXTHRCFG_MAXRXBURSTSIZE(n)	(((n) & 0x1f) << 16)
+#define DWC31_GRXTHRCFG_RXPKTCNT(n)		(((n) & 0x1f) << 21)
+#define DWC31_GRXTHRCFG_PKTCNTSEL		BIT(26)
+#define DWC31_RXTHRNUMPKTSEL_HS_PRD		BIT(15)
+#define DWC31_RXTHRNUMPKT_HS_PRD(n)		(((n) & 0x3) << 13)
+#define DWC31_RXTHRNUMPKTSEL_PRD		BIT(10)
+#define DWC31_RXTHRNUMPKT_PRD(n)		(((n) & 0x1f) << 5)
+#define DWC31_MAXRXBURSTSIZE_PRD(n)		((n) & 0x1f)
+
+/* Global TX Threshold Configuration Register for DWC_usb31 only */
+#define DWC31_GTXTHRCFG_MAXTXBURSTSIZE(n)	(((n) & 0x1f) << 16)
+#define DWC31_GTXTHRCFG_TXPKTCNT(n)		(((n) & 0x1f) << 21)
+#define DWC31_GTXTHRCFG_PKTCNTSEL		BIT(26)
+#define DWC31_TXTHRNUMPKTSEL_HS_PRD		BIT(15)
+#define DWC31_TXTHRNUMPKT_HS_PRD(n)		(((n) & 0x3) << 13)
+#define DWC31_TXTHRNUMPKTSEL_PRD		BIT(10)
+#define DWC31_TXTHRNUMPKT_PRD(n)		(((n) & 0x1f) << 5)
+#define DWC31_MAXTXBURSTSIZE_PRD(n)		((n) & 0x1f)
+
 /* Global Configuration Register */
 #define DWC3_GCTL_PWRDNSCALE(n)	((n) << 19)
 #define DWC3_GCTL_U2RSTECN	BIT(16)
@@ -201,6 +231,15 @@
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
+/* Global Status Register */
+#define DWC3_GSTS_OTG_IP	BIT(10)
+#define DWC3_GSTS_BC_IP		BIT(9)
+#define DWC3_GSTS_ADP_IP	BIT(8)
+#define DWC3_GSTS_HOST_IP	BIT(7)
+#define DWC3_GSTS_DEVICE_IP	BIT(6)
+#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
+#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
+
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
@@ -241,6 +280,8 @@
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
 /* Global TX Fifo Size Register */
+#define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
+#define DWC31_GTXFIFOSIZ_TXFDEF(n)	((n) & 0x7fff)	/* DWC_usb31 only */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
@@ -286,6 +327,11 @@
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
 
 /* Global HWPARAMS6 Register */
+#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
+#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
+#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
+#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
+#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
 #define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
 
 /* Global HWPARAMS7 Register */
@@ -467,6 +513,74 @@
 #define DWC3_DEV_IMOD_INTERVAL_SHIFT	0
 #define DWC3_DEV_IMOD_INTERVAL_MASK	(0xffff << 0)
 
+/* OTG Configuration Register */
+#define DWC3_OCFG_DISPWRCUTTOFF		BIT(5)
+#define DWC3_OCFG_HIBDISMASK		BIT(4)
+#define DWC3_OCFG_SFTRSTMASK		BIT(3)
+#define DWC3_OCFG_OTGVERSION		BIT(2)
+#define DWC3_OCFG_HNPCAP		BIT(1)
+#define DWC3_OCFG_SRPCAP		BIT(0)
+
+/* OTG CTL Register */
+#define DWC3_OCTL_OTG3GOERR		BIT(7)
+#define DWC3_OCTL_PERIMODE		BIT(6)
+#define DWC3_OCTL_PRTPWRCTL		BIT(5)
+#define DWC3_OCTL_HNPREQ		BIT(4)
+#define DWC3_OCTL_SESREQ		BIT(3)
+#define DWC3_OCTL_TERMSELIDPULSE	BIT(2)
+#define DWC3_OCTL_DEVSETHNPEN		BIT(1)
+#define DWC3_OCTL_HSTSETHNPEN		BIT(0)
+
+/* OTG Event Register */
+#define DWC3_OEVT_DEVICEMODE		BIT(31)
+#define DWC3_OEVT_XHCIRUNSTPSET		BIT(27)
+#define DWC3_OEVT_DEVRUNSTPSET		BIT(26)
+#define DWC3_OEVT_HIBENTRY		BIT(25)
+#define DWC3_OEVT_CONIDSTSCHNG		BIT(24)
+#define DWC3_OEVT_HRRCONFNOTIF		BIT(23)
+#define DWC3_OEVT_HRRINITNOTIF		BIT(22)
+#define DWC3_OEVT_ADEVIDLE		BIT(21)
+#define DWC3_OEVT_ADEVBHOSTEND		BIT(20)
+#define DWC3_OEVT_ADEVHOST		BIT(19)
+#define DWC3_OEVT_ADEVHNPCHNG		BIT(18)
+#define DWC3_OEVT_ADEVSRPDET		BIT(17)
+#define DWC3_OEVT_ADEVSESSENDDET	BIT(16)
+#define DWC3_OEVT_BDEVBHOSTEND		BIT(11)
+#define DWC3_OEVT_BDEVHNPCHNG		BIT(10)
+#define DWC3_OEVT_BDEVSESSVLDDET	BIT(9)
+#define DWC3_OEVT_BDEVVBUSCHNG		BIT(8)
+#define DWC3_OEVT_BSESSVLD		BIT(3)
+#define DWC3_OEVT_HSTNEGSTS		BIT(2)
+#define DWC3_OEVT_SESREQSTS		BIT(1)
+#define DWC3_OEVT_ERROR			BIT(0)
+
+/* OTG Event Enable Register */
+#define DWC3_OEVTEN_XHCIRUNSTPSETEN	BIT(27)
+#define DWC3_OEVTEN_DEVRUNSTPSETEN	BIT(26)
+#define DWC3_OEVTEN_HIBENTRYEN		BIT(25)
+#define DWC3_OEVTEN_CONIDSTSCHNGEN	BIT(24)
+#define DWC3_OEVTEN_HRRCONFNOTIFEN	BIT(23)
+#define DWC3_OEVTEN_HRRINITNOTIFEN	BIT(22)
+#define DWC3_OEVTEN_ADEVIDLEEN		BIT(21)
+#define DWC3_OEVTEN_ADEVBHOSTENDEN	BIT(20)
+#define DWC3_OEVTEN_ADEVHOSTEN		BIT(19)
+#define DWC3_OEVTEN_ADEVHNPCHNGEN	BIT(18)
+#define DWC3_OEVTEN_ADEVSRPDETEN	BIT(17)
+#define DWC3_OEVTEN_ADEVSESSENDDETEN	BIT(16)
+#define DWC3_OEVTEN_BDEVBHOSTENDEN	BIT(11)
+#define DWC3_OEVTEN_BDEVHNPCHNGEN	BIT(10)
+#define DWC3_OEVTEN_BDEVSESSVLDDETEN	BIT(9)
+#define DWC3_OEVTEN_BDEVVBUSCHNGEN	BIT(8)
+
+/* OTG Status Register */
+#define DWC3_OSTS_DEVRUNSTP		BIT(13)
+#define DWC3_OSTS_XHCIRUNSTP		BIT(12)
+#define DWC3_OSTS_PERIPHERALSTATE	BIT(4)
+#define DWC3_OSTS_XHCIPRTPOWER		BIT(3)
+#define DWC3_OSTS_BSESVLD		BIT(2)
+#define DWC3_OSTS_VBUSVLD		BIT(1)
+#define DWC3_OSTS_CONIDSTS		BIT(0)
+
 /* Structures */
 
 struct dwc3_trb;
@@ -781,6 +895,10 @@ struct dwc3_scratchpad_array {
  * @regs_size: address space size
  * @fladj: frame length adjustment
  * @irq_gadget: peripheral controller's IRQ number
+ * @otg_irq: IRQ number for OTG IRQs
+ * @current_otg_role: current role of operation while using the OTG block
+ * @desired_otg_role: desired role of operation while using the OTG block
+ * @otg_restart_host: flag that OTG controller needs to restart host
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
@@ -816,6 +934,10 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @rx_thr_num_pkt_prd: periodic ESS receive packet count
+ * @rx_max_burst_prd: max periodic ESS receive burst size
+ * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
+ * @tx_max_burst_prd: max periodic ESS transmit burst size
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
  * @delayed_status: true when gadget driver asks for delayed status
@@ -914,6 +1036,10 @@ struct dwc3 {
 
 	u32			fladj;
 	u32			irq_gadget;
+	u32			otg_irq;
+	u32			current_otg_role;
+	u32			desired_otg_role;
+	bool			otg_restart_host;
 	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
@@ -979,6 +1105,10 @@ struct dwc3 {
 	u8			test_mode_nr;
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
+	u8			rx_thr_num_pkt_prd;
+	u8			rx_max_burst_prd;
+	u8			tx_thr_num_pkt_prd;
+	u8			tx_max_burst_prd;
 
 	const char		*hsphy_interface;
 
@@ -1175,6 +1305,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
@@ -1192,6 +1323,9 @@ static inline bool dwc3_is_usb31(struct dwc3 *dwc)
 
 bool dwc3_has_imod(struct dwc3 *dwc);
 
+int dwc3_event_buffers_setup(struct dwc3 *dwc);
+void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
@@ -1235,11 +1369,23 @@ static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_drd_init(struct dwc3 *dwc);
 void dwc3_drd_exit(struct dwc3 *dwc);
+void dwc3_otg_init(struct dwc3 *dwc);
+void dwc3_otg_exit(struct dwc3 *dwc);
+void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus);
+void dwc3_otg_host_init(struct dwc3 *dwc);
 #else
 static inline int dwc3_drd_init(struct dwc3 *dwc)
 { return 0; }
 static inline void dwc3_drd_exit(struct dwc3 *dwc)
 { }
+static inline void dwc3_otg_init(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_exit(struct dwc3 *dwc)
+{ }
+static inline void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
+{ }
+static inline void dwc3_otg_host_init(struct dwc3 *dwc)
+{ }
 #endif
 
 /* power management interface */
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 18be31d5743a..5a991bca8ed7 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -814,7 +814,7 @@ out:
 static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	struct dwc3_request	*r = NULL;
+	struct dwc3_request	*r;
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2bda4eb1e9ac..0dedf8a799f4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -166,18 +166,8 @@ static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
 	dwc3_ep_inc_trb(&dep->trb_dequeue);
 }
 
-/**
- * dwc3_gadget_giveback - call struct usb_request's ->complete callback
- * @dep: The endpoint to whom the request belongs to
- * @req: The request we're giving back
- * @status: completion code for the request
- *
- * Must be called with controller's lock held and interrupts disabled. This
- * function will unmap @req and call its ->complete() callback to notify upper
- * layers that it has completed.
- */
-void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
-		int status)
+static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
+		struct dwc3_request *req, int status)
 {
 	struct dwc3			*dwc = dep->dwc;
 
@@ -190,18 +180,35 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 
 	if (req->trb)
 		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-						&req->request, req->direction);
+				&req->request, req->direction);
 
 	req->trb = NULL;
-
 	trace_dwc3_gadget_giveback(req);
 
+	if (dep->number > 1)
+		pm_runtime_put(dwc->dev);
+}
+
+/**
+ * dwc3_gadget_giveback - call struct usb_request's ->complete callback
+ * @dep: The endpoint to whom the request belongs to
+ * @req: The request we're giving back
+ * @status: completion code for the request
+ *
+ * Must be called with controller's lock held and interrupts disabled. This
+ * function will unmap @req and call its ->complete() callback to notify upper
+ * layers that it has completed.
+ */
+void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
+		int status)
+{
+	struct dwc3			*dwc = dep->dwc;
+
+	dwc3_gadget_del_and_unmap_request(dep, req, status);
+
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
-
-	if (dep->number > 1)
-		pm_runtime_put(dwc->dev);
 }
 
 /**
@@ -1227,7 +1234,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (req->trb)
 			memset(req->trb, 0, sizeof(struct dwc3_trb));
 		dep->queued_requests--;
-		dwc3_gadget_giveback(dep, req, ret);
+		dwc3_gadget_del_and_unmap_request(dep, req, ret);
 		return ret;
 	}
 
@@ -1417,7 +1424,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 					dwc->lock);
 
 			if (!r->trb)
-				goto out1;
+				goto out0;
 
 			if (r->num_pending_sgs) {
 				struct dwc3_trb *trb;
@@ -1858,7 +1865,11 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	 * bursts of data without going through any sort of endpoint throttling.
 	 */
 	reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
-	reg &= ~DWC3_GRXTHRCFG_PKTCNTSEL;
+	if (dwc3_is_usb31(dwc))
+		reg &= ~DWC31_GRXTHRCFG_PKTCNTSEL;
+	else
+		reg &= ~DWC3_GRXTHRCFG_PKTCNTSEL;
+
 	dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
 
 	dwc3_gadget_setup_nump(dwc);
@@ -1950,6 +1961,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
 	int			epnum;
+	u32			tmo_eps = 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -1960,6 +1972,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
 		struct dwc3_ep  *dep = dwc->eps[epnum];
+		int ret;
 
 		if (!dep)
 			continue;
@@ -1967,9 +1980,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 			continue;
 
-		wait_event_lock_irq(dep->wait_end_transfer,
-				    !(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
-				    dwc->lock);
+		ret = wait_event_interruptible_lock_irq_timeout(dep->wait_end_transfer,
+			    !(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
+			    dwc->lock, msecs_to_jiffies(5));
+
+		if (ret <= 0) {
+			/* Timed out or interrupted! There's nothing much
+			 * we can do so we just log here and print which
+			 * endpoints timed out at the end.
+			 */
+			tmo_eps |= 1 << epnum;
+			dep->flags &= DWC3_EP_END_TRANSFER_PENDING;
+		}
+	}
+
+	if (tmo_eps) {
+		dev_err(dwc->dev,
+			"end transfer timed out on endpoints 0x%x [bitmap]\n",
+			tmo_eps);
 	}
 
 out:
@@ -2023,7 +2051,10 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 			reg |= DWC3_DCFG_SUPERSPEED;
 			break;
 		case USB_SPEED_SUPER_PLUS:
-			reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+			if (dwc3_is_usb31(dwc))
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED;
 			break;
 		default:
 			dev_err(dwc->dev, "invalid speed (%d)\n", speed);
@@ -2101,7 +2132,10 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 			mdwidth /= 8;
 
 			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num));
-			size = DWC3_GTXFIFOSIZ_TXFDEF(size);
+			if (dwc3_is_usb31(dwc))
+				size = DWC31_GTXFIFOSIZ_TXFDEF(size);
+			else
+				size = DWC3_GTXFIFOSIZ_TXFDEF(size);
 
 			/* FIFO Depth is in MDWDITH bytes. Multiply */
 			size *= mdwidth;
-- 
2.43.0

