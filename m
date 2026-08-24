Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17062C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A184880E27;
	Mon, 24 Aug 2026 16:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFhURAe4umqx; Mon, 24 Aug 2026 16:45:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589882;
	bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IaTE/B2gi/IOBTGxCZ6Auwy6mI3KCxaLEZhuK672+vzgDO3kuFwHTkFLAwt7AoXJR
	 TqTKP/rxLmmcjiOL41lmZLrgKIKpbS3C6h1N8BDRndkbm+5SxXuMb3KvRVr+wOeMmm
	 essDDs5Xeix56yorV2RHorF78AQueRVnt9E3QIKw1LUJGQWsrnrGehnwmPAueK+kfs
	 O3U7PEVYYtZHLBPkUOhrrIHtS8Z3ASB1ufK5UamKY6jbqGX+NlQ0vtRpeMOuu5eS/q
	 Ee6cvHZu8fd/QJQkxWiAZboQT7hcuPJM8KZflEruvYFgLp/LtFUEojuZ+lbVfXWv6f
	 jHPDEP/LZWhrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00BD680E35;
	Mon, 24 Aug 2026 16:44:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 38343396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A15660627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XGAzJ5MCNyXt for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:30:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=NJP0RVaV
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC749605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:23 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a10d6f455dso582309a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585422; x=1788190222;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=NJP0RVaVhbFxnpaNeaYO4f8vW0rLWQCi/YgLOQ+fDVFLfJRhVc5mnujMivPtpYOvnD
 CS4tr3nw3Ba9NUT6ezq3Ty9dKlDZXYYxK6eqSdnDEbdlBGR+9DlhRxlIxufJZhVDHtYd
 8HeKZ8cVRfqsl44MJGXnFQSXFWWXIIVB35of5zP9zn9QioR6ZSu6tcf/R7ZpEGLEItBU
 t2+5UgZuhGnsHv9Z4l4KcCmUQyUc4s0RuchteA/5Xc+7IbBPgntz05z8u//dGvX6HeY1
 cawBq4XGJf7Oq1QCYCrexTcKWWWKOsgjgucdsi0BeKrX5iJHsWn9TuVUU5992uNo1Z86
 KTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585422; x=1788190222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=CiBgZIkJ3kkOuEkp1e0c6y00cfgk29HYYzqFkZdCAgEe/zyvpjqDP3W6fD9sTs8T49
 8wylJx6UCJmGGNAKOjw8C6yF1Z/QsQX3m6Vn/k0Dl5E76Tb56APj6Sa4Coc9HYzEcrhX
 QZ8zGrMDQuJmmYcIbrls+T8rb8gLIiHBoOvJL/WMWHJBmrtYELDAiwni4p/ZquMeV1UT
 3aBkTqmUEXeJ5PiJkPiEK60bWN7bwnoC9PRHY2IWI7RADN/4+jsFvxFa7k6pbLZACuVf
 k70xCq4GcLVXdD1o1WFLNPLv/5mmjFk3wctLjYSU8gfVSpaPQmIR5ZeQT3B0pT08KDHz
 /ieg==
X-Gm-Message-State: AFuF++lNeDVZdhMjllGuM5gv537bbZxE0xuPN+sA8tE0hBwXIozu6JXb
 2IUdqjwP3x7xeKTpu7IJljHnxDSX8fmyWokhAEWmGhLpPOYh6FtRxgKJ/LzzIB2vCBhmryZTZ+O
 jLinu
X-Gm-Gg: AR+sD10/x77NUIfgugEE4N5RqS7HyNl4WxL/Td7WjeWUfVrrBINoTRRAB2I91+SkOGi
 tyKIHV0y5QwV+RC3874VOxrHI1Sn+par/gfEFBbDN6dxbi1pOgCNrzbaA8nCzNRPN7bBUVJW0wZ
 tW4c3qqC6MC2qYytGQhWyb2zlWIv7gcvHkxEqJG1GoFAIg0HGyihhpmJ7jFz6/5LR+muy0kvG1x
 v3i3rCy8tC9RS/8lC0q6bfpO9xelKV9QCwqr97lLOvUS2MZfLdWNiCUdN2yBzUIcZlhPjnZxzuI
 LjAIK8FjX872+6cMYba8kPfB89RTt50D97Q/eOkktbetomVkuEKroA9NuXjEolL85khLUzYBwU4
 ZCNnmJb+reNc1l/CGJf4pfntsK1R+MuFYmMWqwzjGcZhwwp/huA79OcoUv7pxK6q1cwUq32T/w/
 Vny/bHVLshTIscn4DS3b6D4qMvi+IWVdH67oFUYGYX/qMNpaaBg7DOzLcFeGjtzL3NN2i6yPe6z
 Z/mXyoIM3+FJ5sfSsPU2CmqF+FoNiTs
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr1684015666b.4.1787585421396; 
 Mon, 24 Aug 2026 08:30:21 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479473666b.18.2026.08.24.08.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:30:19 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 30/63] usb: dwc3: import from kernel v5.5
Date: Mon, 24 Aug 2026 17:27:01 +0200
Message-ID: <20260824152734.159794-31-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.4 to v5.5.

The following files are preserved across the import:
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
2d7b78f59e02 usb: dwc3: ep0: Clear started flag on completion
d3abda5a98a1 usb: dwc3: gadget: Clear started flag for non-IOC
8c7d4b7b3d43 usb: dwc3: gadget: Fix logical condition
038761ce68c2 usb: dwc3: debug: Remove newline printout
9ba3aca8fe82 usb: dwc3: Disable phy suspend after power-on reset

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

