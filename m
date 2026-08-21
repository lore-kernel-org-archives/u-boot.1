Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB33C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4479409CE;
	Fri, 21 Aug 2026 13:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGX8Y5ApSfCe; Fri, 21 Aug 2026 13:13:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317985;
	bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=suIQ5wvwCXXJzxoN7we/kJv7TlO6qIKxZlzziVnXLfBeV+r76fI5psMAyeyHV/lqA
	 1ZXdcnG5o8JcLTBXMZgeMhwO51pL1wZCccenm0nAVba7fdmE9PPh4RsnkOi9AJyZPo
	 cC6TVHgurw1qnlp068KAI7U0ueveGO98h0uFTB2Qg2MeSiBB61c73FqWXMdhswuy4N
	 gFyvfnKXkoqcAP+t+Wib96yCOxRYBQjvOp9cAiQGeKgZ97xCc3jSLugpEVboH9Ku/H
	 uBfxinE4ndLO4fLSm0E+VRvqljp5cwVeWzYLrv1FLmzAPworm7nnFDq36n6FezS5Lk
	 r6a9mG/HXUP/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E26140C2C;
	Fri, 21 Aug 2026 13:13:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8470E2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767E060661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXsOtI1wwlvC for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=V0qdQhk7
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C5256067F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:35 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a18d89e4d9so168356a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302293; x=1787907093;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=V0qdQhk7amJt9jUsj6EZrvqZIeGtAb68CC2deTnxqZmbPCy1kj55i/+zuum0JKG84L
 tHOFh43eJUp2XT/ATsswC13kx/5kBWBpBcPHrNIxMLsStW7zlAUZjLiy1qQwrPXaICJJ
 yUg/R0arWI3QHeRFeKeehcgYLSEyzPVkJc0zPhm5LZRc6zlQnNYxWhBwC4xQyoPOLBuC
 12F4RwsNbmdu/DJGt/3RN66WB+oC2yd6hhcno0rdvp+DxSh/1iPOsb31E4zQQ4sHn121
 CPv8Bd33vYN5V0P16cSV7xAtwgqpb2hLfYnOI5lV4DCGmeZ6326v5/AEUCxktjzObl7x
 yFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302293; x=1787907093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=kXHmAtC/R/0m9+dvB+KAmyXjNGLiQjXYz9aDaT7a85dMMopUF9H8mJ7yLzpOD22E5x
 gk8TmjwL06H40Rak6vY1hHIIe6P6IEffjYEde5WZI7XF7DCpCaytLjSDVba/vs8gvc4b
 e4mJesqvtuZSNpyuMxcVyw6A3piILFqwjvMDPqrmTdc76uGb1YVSn/EZQ03dITO6BM8B
 JH7mu/lsjnxXUrx0W07EGdeSPSnp9GXTOBADoHeSs+JvDvo7/63EfvFjH8L/ZNn+cPyS
 +7219fzfgH85XD3p7SMxCD61C8GsGqPy5MjrA2n/Zyo2Iz5WCCRttpC8MqMkykU3aVHf
 AA3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqb7k8gRNxnuXQH7/gWAVI2PLM3Wx7D0lY6JL6zYFu7kiwUyX7WCLfS99d+m1zbTG7IkISnPG4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kz+NOewPO5U5mMY4hZDXV7kvDcANm4E+SLF5VF+HIh6l7+Pkd8
 w/JwGqfu4ejbSxkoVzYFiZE5v2abM71PGzIQI52n2dV/w4D50bbmLKttu+iwjzxXhE0=
X-Gm-Gg: AR+sD10qYJe2RTCauAnIHx/hd3BJhcChWSXidI6ou58svIDJ/Rjqy0u4hDEY3eG+M/L
 DwYB7oUP1QdKp17U96c9WmUIqn91S8nqTNBh7V17kFErTN6Kvl4FYfNHeUL3ivmJFCobngOJb6g
 clNqCrkuuowzNK4C4IFmrnlZcXrD/G2gR0qGBf6pWTr1SCcBTEg4YQkb5F1QG410pYIBOzpCkm6
 mJ9YV0lQ5Vdx17u0Z4cNm3SZqeRBIKqNNaOfnMhcD7jXct2usdpyRb6nVTa4tVHYlnw2RMR+ARl
 /8GNM89gM9A5ElntbDtvpxKnC77Q+CK9FZWn6u6XZRSkG6ws+wDBnEAVCCWBq9WqrFC5XQGnzeR
 5yTRI2qhpaBfYAtTAoLBlz4w22WGxr3izHpSfBOADfiuQ6jZ40SLy/eNm/pklvP8GBQAjp3gJqK
 1pCpsOQFbFQBbjk+byIyd/PnWBqzs7ZrzTaWAHNbtdZlXLxelpZrFCsNdZBjlj4FZ/OjqcfAw3w
 DD05OuseYmw1zngulI4vHEAOqqwJHIjCgTU
X-Received: by 2002:a17:906:4790:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2469f9902fmr269205766b.0.1787302293242; 
 Fri, 21 Aug 2026 01:51:33 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591e0397sm362555766b.53.2026.08.21.01.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:32 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 30/87] usb: dwc3: import from kernel v5.5
Date: Fri, 21 Aug 2026 10:47:06 +0200
Message-ID: <20260821084829.2070426-31-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

