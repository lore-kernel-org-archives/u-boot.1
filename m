Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9BCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F122084ACD;
	Thu,  7 May 2026 11:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j2+T7Hgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6574984AC0; Thu,  7 May 2026 11:30:16 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D51184AA0
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a746f9c092so983531e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146213; x=1778751013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPd81dLvg0tJSL/kE8LOMRt89vlXqVMpzX9rIrE72wU=;
 b=j2+T7Hgb/l6RDULKWx25gTdD0vBizh6xe6ij6GdeNWWRHPGCyManNPd3wHs7/FyY7v
 TQTql/LBJTHrXBzTT1628jwRCYhPnwFVovwu2wkacFw6WjNqZ+SyejiPwXK7ECupXAtd
 P0WEKYDT+Naj1vrVh3MXfBWTghDTi5asTaVxp98HK0jPQai2iPgOk0BD+tMo4yXzC0w7
 9YEUDQ9EXsVGak+R0+g0Pt0qSpQD6nS9C6AA3K9e1u8NBViLOT7s6yMMHnj7Hq6377+e
 5s1t8dXWolvilXZj1tRHXRDaGwVtzYbeJ75uW8L7QAsX3R8tXAvUnKP5/D1oMbjG2B9x
 d3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146213; x=1778751013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WPd81dLvg0tJSL/kE8LOMRt89vlXqVMpzX9rIrE72wU=;
 b=cnz9oyGX67N/45AmL2BKm6y3q0OPpcPGmPo8SPLVHOCf18mqK6J3oahMzjiltvFHLg
 6/wJgmteC3kijdsspQMWX5DsnQkBNejDrdnAriiT4qzzT+q8s4+aV5USAO/ws4Y7g193
 OLJXpNMqvHCpd6baVfloL6111jM/B+V3dmydUKao2y4I1mdeCQQgOyms9U5cXoB1qu7C
 lvCBFQNNgmisNV+p8Ia7N4KtTevMcY7pYi6pDzyGJKRNJ0c95OFWnrw8tgaowXiFD3ZC
 6QNj/rLBxVEX+/XTUfqA7o0Kp3XilDdgzliJmW9kZjk1ti4EhPAgt0OhrTiXQu9jj5w1
 mD3g==
X-Gm-Message-State: AOJu0YyqDH24Fg4bvoN8aMhE/gWcYGmz2L8x5+PuwlmaRkcWpx2eFQBK
 tri4A1PZ20WEv5e0WzzSt6gr1TpTSlK7l6uyDvxux+/suqsvaDpZF9j3valS+lcsMJ2Ig2DIqyK
 Lc1tDfqEwzQ==
X-Gm-Gg: AeBDiesL6EhjPFDChos2YQBBCL+G1NqJGJmevSDtLeuN1EtCOY9DGoGrZ605JtFQmg8
 d+5Tsoo2H3L+kLvszK2O+jDoyDqZOm2hX4KUSLj3E0vYWCDWApNxUWLAp+1AFMtNi3czKUWccke
 2VkbkEcji+nmEmwxM9QGrUEqWK8GSL8mX+1WAWxtpURx6Q2JQxbtcLlNYpeTxOEAfQr7314Jrde
 8D2hYt015TwxMwD7ZG4cY6r9cqvqVjxjrg9AxJsPnQcKpKX6wM1idGKHm83U0dj62b/QYbrJPCt
 9lJO//Rgz8QCQRX94pWYKsTOOCNmL1zuAOd0gQdosuDLrxd4sgKD1gYbh5pQNR7wTky82jffoyK
 bTlvZ/GlfvWdquTpuVQ+MrIj2IfyZhBDfrAFB13ro++2rskIFFPvvLork5KaHCbl5AveJ9MB99G
 b0H1pEOT/8iSt1Sl3QQmXZJ48aiGJRij/mpcGKhDtrPvIfJBMOnYqWqqKX+CwNw3ifOz6OxjLC8
 tldUEnnwkx3e2u/C8DAVWyPXV1CTTG70yLD9kx9v7v2CoLhSYzZb30jZf+9VvM=
X-Received: by 2002:a05:6512:108a:b0:5a3:ff48:f7d6 with SMTP id
 2adb3069b0e04-5a899bb4d73mr620387e87.13.1778146212686; 
 Thu, 07 May 2026 02:30:12 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:30:11 -0700 (PDT)
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
Subject: [RFC PATCH v2 29/64] usb: dwc3: import from kernel v5.5
Date: Thu,  7 May 2026 11:27:36 +0200
Message-ID: <20260507092843.358908-30-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.4 to v5.5.

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

List of commits: git log --oneline v5.4..v5.5
Commits imported:
ea0d762775e2 usb: dwc3: gadget: Fix request complete check
3c3caae4cd6e usb: dwc3: pci: add ID for the Intel Comet Lake -H variant
2d7b78f59e02 usb: dwc3: ep0: Clear started flag on completion
d3abda5a98a1 usb: dwc3: gadget: Clear started flag for non-IOC
8c7d4b7b3d43 usb: dwc3: gadget: Fix logical condition
c3afa2224345 usb: dwc3: Fix Kconfig indentation
7170d1a4cc4d Merge tag 'usb-for-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
dcf5a2c390a3 usb: dwc3: create debugfs directory under usb root
16c8373ecf7b Merge 5.4-rc6 into usb-next
726b4fba94be usb: dwc3: of-simple: add a shutdown
038761ce68c2 usb: dwc3: debug: Remove newline printout
9ba3aca8fe82 usb: dwc3: Disable phy suspend after power-on reset
bf7c1d95af67 Merge 5.4-rc3 into usb-next
c2c1c66b5d43 usb: Fix Kconfig indentation

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 37 +++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/debug.h  |  4 ++--
 drivers/usb/dwc3/ep0.c    |  8 ++++++++
 drivers/usb/dwc3/gadget.c | 12 +++++++++++-
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 97d6ae3c4df2..f561c6c9e8a9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -566,8 +566,11 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
 	/*
@@ -585,6 +588,14 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->revision > DWC3_REVISION_194A)
 		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
 
+	/*
+	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
+	 * power-on reset, and it can be set after core initialization, which is
+	 * after device soft-reset during initialization.
+	 */
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
+		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
@@ -668,6 +679,14 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->revision > DWC3_REVISION_194A)
 		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
 
+	/*
+	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
+	 * power-on reset, and it can be set after core initialization, which is
+	 * after device soft-reset during initialization.
+	 */
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
 	if (dwc->dis_u2_susphy_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
@@ -902,9 +921,12 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
+	unsigned int		hw_mode;
 	u32			reg;
 	int			ret;
 
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
 	 * out which kernel version a bug was found.
@@ -940,6 +962,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err0a;
 
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
+	    dwc->revision > DWC3_REVISION_194A) {
+		if (!dwc->dis_u3_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+		}
+
+		if (!dwc->dis_u2_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
+	}
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 9baabed87d61..e56beb9d1e36 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -112,7 +112,7 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
 	case DWC3_LINK_STATE_RESUME:
 		return "Resume";
 	default:
-		return "UNKNOWN link state\n";
+		return "UNKNOWN link state";
 	}
 }
 
@@ -141,7 +141,7 @@ dwc3_gadget_hs_link_string(enum dwc3_link_state link_state)
 	case DWC3_LINK_STATE_RESUME:
 		return "Resume";
 	default:
-		return "UNKNOWN link state\n";
+		return "UNKNOWN link state";
 	}
 }
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3996b9c4ff8d..fd1b100d2927 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1117,6 +1117,9 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
+	struct dwc3_ep	*dep = dwc->eps[event->endpoint_number];
+	u8		cmd;
+
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		dwc3_ep0_xfer_complete(dwc, event);
@@ -1129,7 +1132,12 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 	case DWC3_DEPEVT_XFERINPROGRESS:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 	case DWC3_DEPEVT_STREAMEVT:
+		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
+		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
+
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER)
+			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 		break;
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a9aba716bf80..154f3f3e8cff 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2467,6 +2467,13 @@ static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
+	/*
+	 * For OUT direction, host may send less than the setup
+	 * length. Return true for all OUT requests.
+	 */
+	if (!req->direction)
+		return true;
+
 	return req->request.actual == req->request.length;
 }
 
@@ -2491,7 +2498,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req) &&
+	if (!dwc3_gadget_ep_request_completed(req) ||
 			req->num_pending_sgs) {
 		__dwc3_gadget_kick_transfer(dep);
 		goto out;
@@ -2719,6 +2726,9 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+
 	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
 		udelay(100);
 }
-- 
2.43.0

