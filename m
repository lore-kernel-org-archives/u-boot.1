Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E8BC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B71A0606E8;
	Mon, 24 Aug 2026 16:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJaKSX44QTbm; Mon, 24 Aug 2026 16:44:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589884;
	bh=KIN/XnsxwIzwg6XVbpWnahXG+uDa/x6O0NG5+8sOIkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mloeJjxT5I5wRLfSYERmC063S/KuAWEaf9OOZD+XREjed4Fq96PlDH2OkMoNCOpny
	 Rl4NPV4nu5Xy7Tkd59j1Vj+sYTlRiZe2F2mb4oh0j0o40P3A0MrmduAQUEQhIqgbd1
	 Lpx9FiN7blpFKAKVJjJcE5jOkrLTZ/4e16DpH5pVH+339tMuz/+7DgpLtHm3uJNr0h
	 LweOGo5O+aSA9wzEy4byOx3i2vJ9hrVS/5GDEUgs3WYRqnG758KbLzDxvLLV9T5nl0
	 sn1DsdRF5viNhDL9LeOlqCBN1rpEoGs+26wIY0o8UB/KNtFFgB/rzd0LqwPLjbO489
	 ue71pYNwE2OGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E63C60703;
	Mon, 24 Aug 2026 16:44:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59609396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B5C4403F6
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B3emPMvbBVOA for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=K3bC7WQ+
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E294B403EB
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:30:26 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso737793a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585424; x=1788190224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KIN/XnsxwIzwg6XVbpWnahXG+uDa/x6O0NG5+8sOIkM=;
 b=K3bC7WQ+p53loKVw68Ok4tPa+ibHykuEFSn2L3+ZuiAGxMHqe7grILloGKh9XllwGK
 MK6sfwPVvujdDXGeuD+B2OFzwkKT6GfwSprTqvIJMnjKDJS/CnyHJXwVEvs38AHn51+Z
 ts5RjzjxollR82bm/3B6F5a5OjRx5hTJBeGoEG+MPbkiRD1HHXXn6LTHoh3ryrgt2BsE
 xCFMWyugKqL2qDVrBlWzWnyT0QIixboxBjwUnww5YzFhZmH9ypT7DvK1uIK52BgxWFwF
 lLuZo6w9u/6G160CZqSta9JlfNhEb021YEVFCadSEtxZ+uClptofKA5Az2JenlKRsQZE
 c0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585424; x=1788190224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KIN/XnsxwIzwg6XVbpWnahXG+uDa/x6O0NG5+8sOIkM=;
 b=ZsvBK+pn4aeIZwarZhBK2rKAuDw0h2lsUUPhDgV6J5hB28DFV2skCJel0RPa1/qk9g
 y7JlGI/6h/bi1x1/nEEgHHguVRE/hkcXjcPhZaaBzN4EPpxy6PfRbk6fCDAlfM/8rRIN
 G2NESEiDEIz47RvPuFL6IUsrZDp64fJ1wNKjPx7hhWfKTihQwrbyGMcM8MWmUOTt+rZe
 1s1TQ3qyEcbsMshl8n0SOpieQAOrSdIlOZLVUdj/6JQO4Xss+vunhqwJQsDmOEX/83in
 cRkqvvywjpRFDejjNV2fI6x1RVTURwQR/DYo61fkZfIhvLLYz/8dJqSLPJNKIXP/6nX/
 yEDA==
X-Gm-Message-State: AFuF++mijKINsUjSw4araRoGb3KgePrxwlp8IP9NVt7NuNqFZUH5bf4H
 yZ5b900aKlCjq0+FcZzdDgpy3tAPa6gUr38Y1XViNJNP/Xrw/bGKpDDagQqaSvuPYrQdV714XWE
 DC5x3
X-Gm-Gg: AR+sD1071Xm8kRzkOOAb7yQa3GisL//nW9U54QkzpPsxei0uEzRxrbgrArkjmyVRlUu
 LBgArGJvor2yfj0otaS+R9cLXdhQv5I55rYqwG02jfP4ZUUuA9xBgppdyq6z+W+plDrzkf1B6W6
 8gs3B3OQ+LGCB1KD40zEufPSuLVHPesT5o3OJ0pv41Sjw0qXD+HkpfMpYfc4wnMIgalLGxUheAM
 5Pp+gY08cg7ct5qLoZwtWOSMqpDDk2lb10sP/7URu4b/EMfP7JTHM71jrlJvZeTPihGE+gnig95
 X6V4gyo+tauhbs7JVtEpWCv/PCZbAfDiu4Tflomf7VJucJoSGpXwBCFcAku2ysiTRCsNPG2jyiF
 WMtjYp/eT8kc9880oir9U1RftaYyu/bdnX4IQHPYyQT9pD1Lzb1pvMUDe28uFdYvo+Dmnn1KJSz
 wBE6tbjSqODWJXFG7kvdR/ZDAnMQoUIZgbGu7j+GytIoYAo0dP8atPXt+MUU9ZKOx07cWJdcf4W
 yp8dxTKh2pVMl6noXwMmA==
X-Received: by 2002:a17:907:97c1:b0:c21:764c:9417 with SMTP id
 a640c23a62f3a-c246a2eb944mr1669173266b.1.1787585422790; 
 Mon, 24 Aug 2026 08:30:22 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479473666b.18.2026.08.24.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:30:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 31/63] usb: dwc3: import from kernel v5.6
Date: Mon, 24 Aug 2026 17:27:02 +0200
Message-ID: <20260824152734.159794-32-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.5 to v5.6.

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

List of commits: git log --oneline v5.5..v5.6
Commits imported:
dad2aff3e827 usb: dwc3: gadget: Update chain bit correctly when using sg list
42cd5ffe46c1 usb: dwc3: debug: fix string position formatting mixup with ret and len
5ee858975b13 usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields
cf2f8b63f7f1 usb: dwc3: gadget: Remove END_TRANSFER delay
da10bcdd6f70 usb: dwc3: gadget: Delay starting transfer
c58d8bfc77a2 usb: dwc3: gadget: Check END_TRANSFER completion
09ed259fac62 usb: dwc3: turn off VBUS when leaving host mode
2e708fa3b898 usb: dwc3: gadget: Clear DCTL.ULSTCHNGREQ before set
1b6009ea88ec usb: dwc3: gadget: Set link state to RX_Detect on disconnect
5b738211fb59 usb: dwc3: gadget: Don't send unintended link state change

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  3 ++
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/debug.h  | 39 +++++++++-------------
 drivers/usb/dwc3/ep0.c    |  4 ++-
 drivers/usb/dwc3/gadget.c | 68 +++++++++++++++++++++++++--------------
 drivers/usb/dwc3/gadget.h | 14 ++++++++
 6 files changed, 80 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f561c6c9e8a9..1d85c42b9c67 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1246,6 +1246,9 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		/* do nothing */
 		break;
 	}
+
+	/* de-assert DRVVBUS for HOST and OTG mode */
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 }
 
 static void dwc3_get_properties(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1c8b349379af..77c4a9abe365 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -688,7 +688,9 @@ struct dwc3_ep {
 #define DWC3_EP_STALL		BIT(1)
 #define DWC3_EP_WEDGE		BIT(2)
 #define DWC3_EP_TRANSFER_STARTED BIT(3)
+#define DWC3_EP_END_TRANSFER_PENDING BIT(4)
 #define DWC3_EP_PENDING_REQUEST	BIT(5)
+#define DWC3_EP_DELAY_START	BIT(6)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		BIT(31)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index e56beb9d1e36..4a13ceaf4093 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -256,86 +256,77 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
 	u8 epnum = event->endpoint_number;
 	size_t len;
 	int status;
-	int ret;
 
-	ret = snprintf(str, size, "ep%d%s: ", epnum >> 1,
+	len = scnprintf(str, size, "ep%d%s: ", epnum >> 1,
 			(epnum & 1) ? "in" : "out");
-	if (ret < 0)
-		return "UNKNOWN";
 
 	status = event->status;
 
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
-		len = strlen(str);
-		snprintf(str + len, size - len, "Transfer Complete (%c%c%c)",
+		len += scnprintf(str + len, size - len,
+				"Transfer Complete (%c%c%c)",
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
 				status & DEPEVT_STATUS_LST ? 'L' : 'l');
 
-		len = strlen(str);
-
 		if (epnum <= 1)
-			snprintf(str + len, size - len, " [%s]",
+			scnprintf(str + len, size - len, " [%s]",
 					dwc3_ep0_state_string(ep0state));
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
-		len = strlen(str);
-
-		snprintf(str + len, size - len, "Transfer In Progress [%d] (%c%c%c)",
+		scnprintf(str + len, size - len,
+				"Transfer In Progress [%d] (%c%c%c)",
 				event->parameters,
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
 				status & DEPEVT_STATUS_LST ? 'M' : 'm');
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		len = strlen(str);
-
-		snprintf(str + len, size - len, "Transfer Not Ready [%d]%s",
+		len += scnprintf(str + len, size - len,
+				"Transfer Not Ready [%d]%s",
 				event->parameters,
 				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
 				" (Active)" : " (Not Active)");
 
-		len = strlen(str);
-
 		/* Control Endpoints */
 		if (epnum <= 1) {
 			int phase = DEPEVT_STATUS_CONTROL_PHASE(event->status);
 
 			switch (phase) {
 			case DEPEVT_STATUS_CONTROL_DATA:
-				snprintf(str + ret, size - ret,
+				scnprintf(str + len, size - len,
 						" [Data Phase]");
 				break;
 			case DEPEVT_STATUS_CONTROL_STATUS:
-				snprintf(str + ret, size - ret,
+				scnprintf(str + len, size - len,
 						" [Status Phase]");
 			}
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		snprintf(str + ret, size - ret, "FIFO");
+		scnprintf(str + len, size - len, "FIFO");
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
 		status = event->status;
 
 		switch (status) {
 		case DEPEVT_STREAMEVT_FOUND:
-			snprintf(str + ret, size - ret, " Stream %d Found",
+			scnprintf(str + len, size - len, " Stream %d Found",
 					event->parameters);
 			break;
 		case DEPEVT_STREAMEVT_NOTFOUND:
 		default:
-			snprintf(str + ret, size - ret, " Stream Not Found");
+			scnprintf(str + len, size - len, " Stream Not Found");
 			break;
 		}
 
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
-		snprintf(str + ret, size - ret, "Endpoint Command Complete");
+		scnprintf(str + len, size - len, "Endpoint Command Complete");
 		break;
 	default:
-		snprintf(str, size, "UNKNOWN");
+		scnprintf(str + len, size - len, "UNKNOWN");
 	}
 
 	return str;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index fd1b100d2927..6dee4dabc0a4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1136,8 +1136,10 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 	case DWC3_DEPEVT_EPCMDCMPLT:
 		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
 
-		if (cmd == DWC3_DEPCMD_ENDTRANSFER)
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
+			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		}
 		break;
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 154f3f3e8cff..1e00bf2d65a2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -57,7 +57,7 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 		return -EINVAL;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	return 0;
 }
@@ -111,6 +111,9 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
 
+	/* set no action before sending new link state change */
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+
 	/* set requested state */
 	reg |= DWC3_DCTL_ULSTCHNGREQ(state);
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
@@ -1068,7 +1071,14 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		unsigned int rem = length % maxp;
 		unsigned chain = true;
 
-		if (sg_is_last(s))
+		/*
+		 * IOMMU driver is coalescing the list of sgs which shares a
+		 * page boundary into one and giving it to USB driver. With
+		 * this the number of sgs mapped is not equal to the number of
+		 * sgs passed. So mark the chain bit to false if it isthe last
+		 * mapped sg.
+		 */
+		if (i == remaining - 1)
 			chain = false;
 
 		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
@@ -1447,6 +1457,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	list_add_tail(&req->list, &dep->pending_list);
 	req->status = DWC3_REQUEST_STATUS_QUEUED;
 
+	/* Start the transfer only after the END_TRANSFER is completed */
+	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+		dep->flags |= DWC3_EP_DELAY_START;
+		return 0;
+	}
+
 	/*
 	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
 	 * wait for a XferNotReady event so we will know what's the current
@@ -1828,7 +1844,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		dwc->pullups_connected = false;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
@@ -2420,7 +2436,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
@@ -2625,8 +2642,14 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
 
 		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
+			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+			if ((dep->flags & DWC3_EP_DELAY_START) &&
+			    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+				__dwc3_gadget_kick_transfer(dep);
+
+			dep->flags &= ~DWC3_EP_DELAY_START;
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
@@ -2678,12 +2701,12 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
-	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
 
-	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
+	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
 	/*
@@ -2693,16 +2716,13 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * much trouble synchronizing between us and gadget driver.
 	 *
 	 * We have discussed this with the IP Provider and it was
-	 * suggested to giveback all requests here, but give HW some
-	 * extra time to synchronize with the interconnect. We're using
-	 * an arbitrary 100us delay for that.
+	 * suggested to giveback all requests here.
 	 *
 	 * Note also that a similar handling was tested by Synopsys
 	 * (thanks a lot Paul) and nothing bad has come out of it.
-	 * In short, what we're doing is:
-	 *
-	 * - Issue EndTransfer WITH CMDIOC bit set
-	 * - Wait 100us
+	 * In short, what we're doing is issuing EndTransfer with
+	 * CMDIOC bit set and delay kicking transfer until the
+	 * EndTransfer command had completed.
 	 *
 	 * As of IP version 3.10a of the DWC_usb3 IP, the controller
 	 * supports a mode to work around the above limitation. The
@@ -2711,8 +2731,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * by writing GUCTL2[14]. This polling is already done in the
 	 * dwc3_send_gadget_ep_cmd() function so if the mode is
 	 * enabled, the EndTransfer command will have completed upon
-	 * returning from this function and we don't need to delay for
-	 * 100us.
+	 * returning from this function.
 	 *
 	 * This mode is NOT available on the DWC_usb31 IP.
 	 */
@@ -2728,9 +2747,8 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 
 	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-
-	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
-		udelay(100);
+	else
+		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
@@ -2759,12 +2777,12 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 {
 	int			reg;
 
+	dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RX_DET);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_INITU1ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-
 	reg &= ~DWC3_DCTL_INITU2ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	dwc3_disconnect_gadget(dwc);
 
@@ -2816,7 +2834,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
 	dwc3_clear_stall_all_ep(dwc);
 
@@ -2920,11 +2938,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
 
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	}
 
 	dep = dwc->eps[0];
@@ -3033,7 +3051,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 				reg &= ~u1u2;
 
-				dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+				dwc3_gadget_dctl_write_safe(dwc, reg);
 				break;
 			default:
 				/* do nothing */
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 5faf4d1249e0..fbc7d8013f0b 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -127,4 +127,18 @@ static inline void dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
 	dep->resource_index = DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
 
+/**
+ * dwc3_gadget_dctl_write_safe - write to DCTL safe from link state change
+ * @dwc: pointer to our context structure
+ * @value: value to write to DCTL
+ *
+ * Use this function when doing read-modify-write to DCTL. It will not
+ * send link state change request.
+ */
+static inline void dwc3_gadget_dctl_write_safe(struct dwc3 *dwc, u32 value)
+{
+	value &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
+	dwc3_writel(dwc->regs, DWC3_DCTL, value);
+}
+
 #endif /* __DRIVERS_USB_DWC3_GADGET_H */
-- 
2.53.0

