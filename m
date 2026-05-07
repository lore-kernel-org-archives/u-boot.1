Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A77CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639DB84B59;
	Thu,  7 May 2026 11:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x7nkeuR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F3E84B52; Thu,  7 May 2026 11:31:36 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15AF584B43
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-393c93a01abso5058271fa.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146290; x=1778751090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOShavlW6NiHeQRh90iLZnyQ8tvKQApeHH70KNDox5c=;
 b=x7nkeuR7QLwudDFqeAgYyWdfmcHEj4/nxBkMIHdmB15hmtrNRbkltqXGaunfvTQpy1
 Pl1WPXic6J/uhWdIlWOSdFxfUY8cDWtbO34bAgf3lMPIMeXklgUamQOWSlXJydRL/6NQ
 hzO2egXKcDU3K6XMqWAK/d72sv5q4Udd9fMLvyhEEahNnSL2Vgj5/6SHfDOfGeH6rqCO
 rqTaaN2sQWLnpdU8zf8JoFjMQRnOdQkNPDGWYUOsdEwJsC6Yu46M1W1syimpb0ApomPK
 idXV319NNd8Ux1H/fXCYT5Qn2uwfSNY6bil0ppOeq8vAgiXYBoSiFBJmFAXO9YdjIap/
 Uoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146290; x=1778751090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HOShavlW6NiHeQRh90iLZnyQ8tvKQApeHH70KNDox5c=;
 b=Ix8cS9Kw5XxmO2l71oaaSVUM8SLXRlDpXnN536BDu9e7RXwxTR/cKYYbl9590td59/
 dJqivWyEyg06YCc7/OFaOQc5QpOP0EQxQPNE/I1XRDVHaTLP+rlNQH2GmDn73Y5yQdZR
 Fpsc4cLR+uYwWfGDK1dfyq4QHSUrsIWWaUEVH0/+px/M36pPD8/EP0tkp2gsszzm+nnK
 tyqvwd2xje0S31TCOFrP5WPnbEG4zoRuts8dNmIMaczY2ClmRipfepmvhaKr1cAqKW9B
 oqQhRNER6CTnUkMgH1VQrQ3xSTTCEUdD+/Sa8MYUNu8SSj/VJnyTrR888kH542wJrfXg
 nYJg==
X-Gm-Message-State: AOJu0YxdeUxXF7G0gsyGH+HxBUJuZJngnSo7rUmk4ahK1aT/ppvU/ocS
 8Z3r29XooQOrRlGGEojRoRIkpEQL/CF5McugGLr99pa6n+Y+nEea2sKNJNlsRT6zI7ruzdWKe4+
 Vx7WI1neXcQ==
X-Gm-Gg: AeBDievkniS18cA3F7KQUu5xbSt5XFs/4hp4N6I8y9Hx9vrprmWJwNJtG7TdRW96+Pz
 yZ995cF2YFmwGVKGikb6hYVt1bnokhdtwISaImhhF+/UjmwdPZo0tU+lPOl4hpRaZSfM3qjJ1aQ
 JRV4wY6KhidmK3YUAaqfekQ64pbCAW4/WJdbpBVfCQopUNXZavoIU3Yg26SrGQaXabyrRy9IBha
 lu9hYi9Wpt4+XLUL6n1H8bS0448OVEPiJdBJ0hUz7VTHOynnwnRG/jyN3As2mEpIn7ulJdeqLvH
 sezlbT9FYqXH7AzrgQmyExhuWKj4nFDwVoPCf3aulxlHyBLwe7QA0BvEUytFvTK/K24LmuoosCn
 FxFS3Zxthq/1GAHm4kceHoeAUOWI7Uo5vHQ+9CdoM43uzag8MUJ6P1lW0rQjE1CI44bzhhsbVGz
 QBW39ueaHx4j5Cp1yBbwt0YWOQ4rGpobV3/ux6HLa0PmbLr9JyKDyyeZZFlm3U8j9RhCfvFVwVM
 IdXa6oX0Q4sBIIV7F2yTCri/wBbnLdyR1RtzQWH1Q==
X-Received: by 2002:a05:6512:234f:b0:5a3:d375:f587 with SMTP id
 2adb3069b0e04-5a887ceb2e9mr2854581e87.35.1778146289281; 
 Thu, 07 May 2026 02:31:29 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:28 -0700 (PDT)
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
Subject: [RFC PATCH v2 57/64] usb: dwc3: import from kernel v6.13
Date: Thu,  7 May 2026 11:28:04 +0200
Message-ID: <20260507092843.358908-58-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.12 to v6.13.

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

List of commits: git log --oneline v6.12..v6.13
Commits imported:
625e70ccb7bb usb: dwc3-am62: Disable autosuspend during remove
01ea6bf5cb58 usb: dwc3: gadget: fix writing NYET threshold
a48f744bef9e usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode
a4faee01179a usb: dwc3: imx8mp: fix software node kernel dump
6a34dfa15d6e Merge tag 'kbuild-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
e33a6d83e178 Merge tag 'usb-6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
f5313c8b418c usb: dwc3: gadget: Remove dwc3_request->needs_extra_trb
61440628a4ff usb: dwc3: gadget: Cleanup SG handling
b7fc65f5141c usb: dwc3: gadget: Fix looping of queued SG entries
02a6982b0ccf usb: dwc3: gadget: Fix checking for number of TRBs left
5d2fb074dea2 usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
ce25e2a8d82d usb: dwc3: core: Set force_gen1 bit for all applicable SuperSpeed ports
61eb055cd304 usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic
6ff78df5b3d0 usb: Use (of|device)_property_present() for non-boolean properties
b95d0899c8bf usb: use "prompt" instead of "bool" for choice prompts
fad16c823e66 usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
c6d9e43954bf Merge 6.12-rc4 into usb-next
64f3b5a6bc49 Merge 6.12-rc3 into usb-next
9a0749d61a9a usb: Switch back to struct platform_driver::remove()
57d7a6b93822 usb: dwc3: Correct some typos in comments

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c      |  16 ++--
 drivers/usb/dwc3/core.h      |  15 ++--
 drivers/usb/dwc3/dwc3-am62.c |   3 +-
 drivers/usb/dwc3/ep0.c       |   4 +-
 drivers/usb/dwc3/gadget.c    | 156 +++++++++++++++++++++--------------
 5 files changed, 114 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 98114c2827c0..f219c82e9619 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1409,7 +1409,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
-	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * fails to send proper CRC checksum in CRC5 field. Because of this
 	 * behaviour Transaction Error is generated, resulting in reset and
 	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
 	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
@@ -1470,9 +1470,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
 	    (DWC3_IP_IS(DWC31)) &&
 	    dwc->maximum_speed == USB_SPEED_SUPER) {
-		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
-		reg |= DWC3_LLUCTL_FORCE_GEN1;
-		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+		int i;
+
+		for (i = 0; i < dwc->num_usb3_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_LLUCTL(i));
+			reg |= DWC3_LLUCTL_FORCE_GEN1;
+			dwc3_writel(dwc->regs, DWC3_LLUCTL(i), reg);
+		}
 	}
 
 	return 0;
@@ -1941,7 +1945,7 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	struct extcon_dev *edev = NULL;
 	const char *name;
 
-	if (device_property_read_bool(dev, "extcon"))
+	if (device_property_present(dev, "extcon"))
 		return extcon_get_edev_by_phandle(dev, 0);
 
 	/*
@@ -2651,7 +2655,7 @@ MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
-	.remove_new	= dwc3_remove,
+	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eab81dfdcc35..f11570c8ffd0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -81,7 +81,7 @@
 #define DWC3_GSNPSREV_MASK	0xffff
 #define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
-/* DWC3 registers memory space boundries */
+/* DWC3 registers memory space boundaries */
 #define DWC3_XHCI_REGS_START		0x0
 #define DWC3_XHCI_REGS_END		0x7fff
 #define DWC3_GLOBALS_REGS_START		0xc100
@@ -179,7 +179,7 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
-#define DWC3_LLUCTL		0xd024
+#define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
 
 /* Bit fields */
 
@@ -464,6 +464,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
@@ -915,6 +916,7 @@ struct dwc3_hwparams {
 #define DWC3_MODE(n)		((n) & 0x7)
 
 /* HWPARAMS1 */
+#define DWC3_SPRAM_TYPE(n)	(((n) >> 23) & 1)
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
 /* HWPARAMS3 */
@@ -925,6 +927,9 @@ struct dwc3_hwparams {
 #define DWC3_NUM_IN_EPS(p)	(((p)->hwparams3 &		\
 			(DWC3_NUM_IN_EPS_MASK)) >> 18)
 
+/* HWPARAMS6 */
+#define DWC3_RAM0_DEPTH(n)	(((n) & (0xffff0000)) >> 16)
+
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
@@ -937,18 +942,14 @@ struct dwc3_hwparams {
  * @request: struct usb_request to be transferred
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
- * @sg: pointer to first incomplete sg
  * @start_sg: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
- * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
  * @status: internal dwc3 request status tracking
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
  * @num_trbs: number of TRBs used by this request
- * @needs_extra_trb: true when request needs one extra TRB (either due to ZLP
- *	or unaligned OUT)
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  */
@@ -960,7 +961,6 @@ struct dwc3_request {
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
-	unsigned int		num_queued_sgs;
 	unsigned int		remaining;
 
 	unsigned int		status;
@@ -978,7 +978,6 @@ struct dwc3_request {
 
 	unsigned int		num_trbs;
 
-	unsigned int		needs_extra_trb:1;
 	unsigned int		direction:1;
 	unsigned int		mapped:1;
 };
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index fad151e78fd6..7d43da5f2897 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -309,6 +309,7 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 }
 
@@ -377,7 +378,7 @@ MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
 static struct platform_driver dwc3_ti_driver = {
 	.probe		= dwc3_ti_probe,
-	.remove_new	= dwc3_ti_remove,
+	.remove		= dwc3_ti_remove,
 	.driver		= {
 		.name	= "dwc3-am62",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c9533a99e47c..666ac432f52d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -145,7 +145,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * Unfortunately we have uncovered a limitation wrt the Data Phase.
 	 *
 	 * Section 9.4 says we can wait for the XferNotReady(DATA) event to
-	 * come before issueing Start Transfer command, but if we do, we will
+	 * come before issuing Start Transfer command, but if we do, we will
 	 * miss situations where the host starts another SETUP phase instead of
 	 * the DATA phase.  Such cases happen at least on TD.7.6 of the Link
 	 * Layer Compliance Suite.
@@ -232,7 +232,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED | DWC3_EP_TRANSFER_STARTED;
 	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4959c26d3b71..31a654c6f15b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -197,7 +197,6 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 
 	list_del(&req->list);
 	req->remaining = 0;
-	req->needs_extra_trb = false;
 	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
@@ -687,6 +686,44 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
 	return fifo_size;
 }
 
+/**
+ * dwc3_gadget_calc_ram_depth - calculates the ram depth for txfifo
+ * @dwc: pointer to the DWC3 context
+ */
+static int dwc3_gadget_calc_ram_depth(struct dwc3 *dwc)
+{
+	int ram_depth;
+	int fifo_0_start;
+	bool is_single_port_ram;
+
+	/* Check supporting RAM type by HW */
+	is_single_port_ram = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
+
+	/*
+	 * If a single port RAM is utilized, then allocate TxFIFOs from
+	 * RAM0. otherwise, allocate them from RAM1.
+	 */
+	ram_depth = is_single_port_ram ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
+			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	/*
+	 * In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (is_single_port_ram) {
+		u32 reg;
+
+		/* Check if TXFIFOs start at non-zero addr */
+		reg = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(reg);
+
+		ram_depth -= (fifo_0_start >> 16);
+	}
+
+	return ram_depth;
+}
+
 /**
  * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
  * @dwc: pointer to the DWC3 context
@@ -753,7 +790,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int fifo_0_start;
-	int ram1_depth;
+	int ram_depth;
 	int fifo_size;
 	int min_depth;
 	int num_in_ep;
@@ -773,17 +810,32 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
 		return 0;
 
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
-
-	if (dep->endpoint.maxburst > 6 &&
-	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
-	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
-		num_fifos = dwc->tx_fifo_resize_max_num;
+	switch (dwc->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			num_fifos = min_t(unsigned int,
+					  dep->endpoint.maxburst,
+					  dwc->tx_fifo_resize_max_num);
+		break;
+	case USB_SPEED_HIGH:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			num_fifos = min_t(unsigned int,
+					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+					  dwc->tx_fifo_resize_max_num);
+			break;
+		}
+		fallthrough;
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+			num_fifos = 2;
+		break;
+	default:
+		break;
+	}
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
@@ -794,7 +846,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	/* Reserve at least one FIFO for the number of IN EPs */
 	min_depth = num_in_ep * (fifo + 1);
-	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
 	remaining = max_t(int, 0, remaining);
 	/*
 	 * We've already reserved 1 FIFO per EP, so check what we can fit in
@@ -820,9 +872,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
 
 	/* Check fifo size allocation doesn't exceed available RAM size. */
-	if (dwc->last_fifo_depth >= ram1_depth) {
+	if (dwc->last_fifo_depth >= ram_depth) {
 		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
-			dwc->last_fifo_depth, ram1_depth,
+			dwc->last_fifo_depth, ram_depth,
 			dep->endpoint.name, fifo_size);
 		if (DWC3_IP_IS(DWC3))
 			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
@@ -1177,11 +1229,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
+		struct dwc3_request *req;
+
 		/*
-		 * If there is any request remained in the started_list at
-		 * this point, that means there is no TRB available.
+		 * If there is any request remained in the started_list with
+		 * active TRBs at this point, then there is no TRB available.
 		 */
-		if (!list_empty(&dep->started_list))
+		req = next_request(&dep->started_list);
+		if (req && req->num_trbs)
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -1384,6 +1439,7 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 	unsigned int rem = req->request.length % maxp;
 	unsigned int num_trbs = 1;
+	bool needs_extra_trb;
 
 	if (dwc3_needs_extra_trb(dep, req))
 		num_trbs++;
@@ -1391,15 +1447,15 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	if (dwc3_calc_trbs_left(dep) < num_trbs)
 		return 0;
 
-	req->needs_extra_trb = num_trbs > 1;
+	needs_extra_trb = num_trbs > 1;
 
 	/* Prepare a normal TRB */
 	if (req->direction || req->request.length)
 		dwc3_prepare_one_trb(dep, req, entry_length,
-				req->needs_extra_trb, node, false, false);
+				needs_extra_trb, node, false, false);
 
 	/* Prepare extra TRBs for ZLP and MPS OUT transfer alignment */
-	if ((!req->direction && !req->request.length) || req->needs_extra_trb)
+	if ((!req->direction && !req->request.length) || needs_extra_trb)
 		dwc3_prepare_one_trb(dep, req,
 				req->direction ? 0 : maxp - rem,
 				false, 1, true, false);
@@ -1414,8 +1470,8 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	struct scatterlist *s;
 	int		i;
 	unsigned int length = req->request.length;
-	unsigned int remaining = req->request.num_mapped_sgs
-		- req->num_queued_sgs;
+	unsigned int remaining = req->num_pending_sgs;
+	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
 	unsigned int num_trbs = req->num_trbs;
 	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
 
@@ -1423,7 +1479,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	 * If we resume preparing the request, then get the remaining length of
 	 * the request and resume where we left off.
 	 */
-	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+	for_each_sg(req->request.sg, s, num_queued_sgs, i)
 		length -= sg_dma_len(s);
 
 	for_each_sg(sg, s, remaining, i) {
@@ -1488,7 +1544,6 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 		if (!last_sg)
 			req->start_sg = sg_next(s);
 
-		req->num_queued_sgs++;
 		req->num_pending_sgs--;
 
 		/*
@@ -1569,9 +1624,7 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		if (ret)
 			return ret;
 
-		req->sg			= req->request.sg;
-		req->start_sg		= req->sg;
-		req->num_queued_sgs	= 0;
+		req->start_sg		= req->request.sg;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
 		if (req->num_pending_sgs > 0) {
@@ -3075,7 +3128,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	struct dwc3 *dwc = gadget_to_dwc(g);
 	struct usb_ep *ep;
 	int fifo_size = 0;
-	int ram1_depth;
+	int ram_depth;
 	int ep_num = 0;
 
 	if (!dwc->do_fifo_resize)
@@ -3098,8 +3151,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	fifo_size += dwc->max_cfg_eps;
 
 	/* Check if we can fit a single fifo per endpoint */
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
-	if (fifo_size > ram1_depth)
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
+	if (fifo_size > ram_depth)
 		return -ENOMEM;
 
 	return 0;
@@ -3416,20 +3469,16 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		int status)
 {
 	struct dwc3_trb *trb;
-	struct scatterlist *sg = req->sg;
-	struct scatterlist *s;
-	unsigned int num_queued = req->num_queued_sgs;
+	unsigned int num_completed_trbs = req->num_trbs;
 	unsigned int i;
 	int ret = 0;
 
-	for_each_sg(sg, s, num_queued, i) {
+	for (i = 0; i < num_completed_trbs; i++) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		req->sg = sg_next(s);
-		req->num_queued_sgs--;
-
 		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
-				trb, event, status, true);
+				trb, event, status,
+				!!(trb->ctrl & DWC3_TRB_CTRL_CHN));
 		if (ret)
 			break;
 	}
@@ -3437,19 +3486,9 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	return ret;
 }
 
-static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
-		struct dwc3_request *req, const struct dwc3_event_depevt *event,
-		int status)
-{
-	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
-
-	return dwc3_gadget_ep_reclaim_completed_trb(dep, req, trb,
-			event, status, false);
-}
-
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	return req->num_pending_sgs == 0 && req->num_queued_sgs == 0;
+	return req->num_pending_sgs == 0 && req->num_trbs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -3459,24 +3498,13 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 	int request_status;
 	int ret;
 
-	if (req->request.num_mapped_sgs)
-		ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event,
-				status);
-	else
-		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
-				status);
+	ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event, status);
 
 	req->request.actual = req->request.length - req->remaining;
 
 	if (!dwc3_gadget_ep_request_completed(req))
 		goto out;
 
-	if (req->needs_extra_trb) {
-		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
-				status);
-		req->needs_extra_trb = false;
-	}
-
 	/*
 	 * The event status only reflects the status of the TRB with IOC set.
 	 * For the requests that don't set interrupt on completion, the driver
@@ -4167,8 +4195,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
-- 
2.43.0

