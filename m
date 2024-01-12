Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809A5C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BF7879A0;
	Fri, 12 Jan 2024 09:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="E08jr47b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9AB86D38; Fri, 12 Jan 2024 09:53:23 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2258798D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705049598;
 bh=+q4xvRMWsNFlurQKmYW9TulEiEIQLEucIpX+mdDYG4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E08jr47bCKNMDUUw38gmnTl9tCPNfnKz+9M6d8N451z3ld5gVgfpw8DYyyzRSJibx
 Sbh5xhF/YntJb9v/YwKwPqB26y7UnPlAckRn3+1Q8QKx7pieVighLgwAjP2vCALVgB
 hPvHsU42/prnZahuW037gGsMS21qTaVufVdjFaRXgcpI5qair3wtEHVMSAcO7uc4z2
 t3U/PN3lI5IoTiDjc7AnRLWyZq/WKhX+N+b4Gf/+BQOOYWQKY1+7DdYjr/8OkC/8oA
 zp93BcvSuy9ZGHOQboleHfiUT4yMtNLSfNpoHquciCxJK0GzOCSel/LuKKlQ1qMMpQ
 9gp1GXBeYZgog==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3875E3782021;
 Fri, 12 Jan 2024 08:53:18 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id C4D789ED7CCC; Fri, 12 Jan 2024 09:53:17 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
Date: Fri, 12 Jan 2024 09:52:17 +0100
Message-ID: <20240112085317.1866449-3-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112085317.1866449-1-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
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

When dr_mode is "otg" the dwc3 is initially configured in _OTG mode;
However in this mode the gadget functionality doesn't work without
further configuration. To resolve that on gadget start switch to _DEVICE
mode globally and go back to _OTG on stop again.

For this the dwc3_set_mode is renamed to dwc3_core_set_mode to avoid a
conflict with the same function exposed by xhci-dwc3

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v4:
- New patch

 drivers/usb/dwc3/core.c   | 10 +++++-----
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c |  6 ++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4b4fcd8a22e..d22d4c4bb6a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -42,7 +42,7 @@
 static LIST_HEAD(dwc3_list);
 /* -------------------------------------------------------------------------- */
 
-static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
+void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
 
@@ -736,7 +736,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize gadget\n");
@@ -744,7 +744,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
@@ -752,7 +752,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
@@ -810,7 +810,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	 * switch back to peripheral mode
 	 * This enables the phy to enter idle and then, if enabled, suspend.
 	 */
-	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 	dwc3_gadget_run(dwc);
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4162a682298..1e7eda89a34 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1057,6 +1057,7 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
 void dwc3_of_parse(struct dwc3 *dwc);
 int dwc3_init(struct dwc3 *dwc);
 void dwc3_remove(struct dwc3 *dwc);
+void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode);
 
 static inline int dwc3_host_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 406d36ceafe..69d9fe40e2f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1468,6 +1468,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	dwc->gadget_driver	= driver;
 
+	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
+		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~(DWC3_DCFG_SPEED_MASK);
 
@@ -1559,6 +1562,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	__dwc3_gadget_ep_disable(dwc->eps[0]);
 	__dwc3_gadget_ep_disable(dwc->eps[1]);
 
+	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
+		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+
 	dwc->gadget_driver	= NULL;
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
-- 
2.43.0

