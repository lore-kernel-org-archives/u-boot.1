Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF9C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B0784E00;
	Thu, 16 Jul 2026 18:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aexvCjJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A807D84CF1; Thu, 16 Jul 2026 15:43:55 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916FA84C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698a99b1c37so1161878a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209433; x=1784814233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPdNFtOtWcUtqsd81GOqmdPg0CGwwxpeRVOgwObAQrQ=;
 b=aexvCjJ9EngxY3DSRskIarDHTPMKWVIf6wSsTlM20tfu/imG0A9rtrVEtCDcrncpph
 WaoXLG1D/SRX5r5mCK03cArMK/nSns50F1I/LJwCJ21w7De1EuQv4wyAXWcpi5oGEAfF
 iFhIAtW4HKWAXcHWF8EiXEq9Bcuyfxd/l1Y19Z+4VeT3wubbE1xkt7E4e74cMYLa2Kn7
 qnhV/0UqY3STXhZH4rWVNsPeF/K/Q3S9B+dt2K7gNrOSTMWD7We+I+XB8LsXs9ynftlE
 r+y7kGUIhOZVwIbLPLslOOh2LApJ9OL3IJyWJBs4O/JSe9f1Q6dy52Pup8LYASzqPs/n
 UGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209433; x=1784814233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uPdNFtOtWcUtqsd81GOqmdPg0CGwwxpeRVOgwObAQrQ=;
 b=sKZuc7nNNlP3oIBBvV6wWwIpGApKZS47foK1v/YzYd/QVxXcYhtmRcsGFoZpR6izci
 IPUbEBksIMJqvsSAOQWa6HUak6Fr2UkQOvM9+TYVVScK9qd3Z6UPilhgvjd68aaa5jBg
 oqH7wmqyrQGwFbgoxtyu53EwqQcdZ9XCz//Q19huayAa1oaKLGfQqQVoMSqBl7emRp2I
 HVgtd51IgJPXJ+nNvGFSTmVf10xGwOP350oOolkWtamK0TqvQdWpvIuw+aT10qeEDWhf
 NZG69tUJwmBfbPruOxritnD8ddJOR+lMM9Wyjm9NYX6th0I2hyioQXCiacsf2bnD4Uys
 ko5w==
X-Gm-Message-State: AOJu0Yz8Q30GuWUzTxpmmaCLYPn8MvrY5hu6A+eaU6BgikbVsA/+YTNO
 KMBk8ogbyIFk5HaZemdseElQMn03aH6x03z7SQDjrInWEmMlcLzlJ+B21YIF8U4dy13Lv5xjazf
 TpycR
X-Gm-Gg: AfdE7clIso+7dhXYcLsZ/m75+fPOBE09poxCJUnrHVFBNa0FatIAceVN56U8Ppg34+B
 kLyhFT6gTBjjsvExHfxN+YCv+F/taQTIH+5lcndn4rd14HTlnnIY4W2Ufey30rzUNrSVgbiP4QS
 OqICRnOs2qaUA25KCCavuQIySzkivYi3NmY22a94hq3KeOq2Mgx+PELktdaFhXy3sFtNIbydG25
 jSSl9NHw4FgJ1KiN4RIfuporKfJGQU9vGWqwbYPC7zmCce9b2txh9XIARgCj7Ln4QUiQpAgXyxe
 VY942KzqadlxITEyR6boFz+mgRlU4mpAyS4poSxIg0Nx/yBo9Hz+/DmuSEssiIvNkuh6+AaWbul
 RcJIeplCvZltKatxF6HHfNx2yum7YFTUrpyvtwH+APO2JGID4vH+NeEzIZ1JJjtWyiHkpUie1+J
 FcHJ5WhzBlWjuAbBNjipmY/jJgIdhAuy9NtFhTHw==
X-Received: by 2002:a05:6402:4516:b0:697:d51c:d956 with SMTP id
 4fb4d7f45d1cf-69c5edb8ce4mr6584789a12.0.1784209432882; 
 Thu, 16 Jul 2026 06:43:52 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd288c114sm4980453a12.7.2026.07.16.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:51 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 29/75] usb: dwc3: import from kernel v5.5
Date: Thu, 16 Jul 2026 15:41:59 +0200
Message-ID: <20260716134305.614278-30-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

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
dcf5a2c390a3 usb: dwc3: create debugfs directory under usb root
726b4fba94be usb: dwc3: of-simple: add a shutdown
038761ce68c2 usb: dwc3: debug: Remove newline printout
9ba3aca8fe82 usb: dwc3: Disable phy suspend after power-on reset
c2c1c66b5d43 usb: Fix Kconfig indentation

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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
2.53.0

