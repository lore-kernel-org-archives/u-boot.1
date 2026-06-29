Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B62C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5E484ADF;
	Mon, 29 Jun 2026 10:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XDzy1W+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A67DF84AD7; Mon, 29 Jun 2026 10:47:27 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8916F84105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39ae3c76e24so15034391fa.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722845; x=1783327645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yI1vdqNO4iOtafSHuT/lj2vuTtyWpiM9Y8AToFImy+Q=;
 b=XDzy1W+Tj8tFn6C+vCyNj3wtHNhStcyPiuczmQga4mMNsBCt6SQbe2c4Rwj9yMdPIx
 ZYQuJRBhNwKsH15Vs82f8GslBjJTPxu7cUG0zRGFBNq2fhnG7ZTewhemVskoGo4HzA1F
 HRSF3oYwvJAVcBDYVQJQncvEEQP6LjwgVRi2JMx8qjOIf4xlNORJaFe7IPsk2P7g+NdR
 itkDEh44KaSi1OkCrHOg/3OjcX2QsLImDEuncy43j3gUbAKniJSydvJlSwQwJCY2rKPj
 LfTqIBK3Pep4YJA0oVqzWebgyXhfiNjMMjJGJUIXx/wJX2/zpnlFpkfEFTXxiuTiN5dX
 2x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722845; x=1783327645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yI1vdqNO4iOtafSHuT/lj2vuTtyWpiM9Y8AToFImy+Q=;
 b=TgNIW0RL/W64B+/e4D1v6WgmyKhoP149QIU7uf51eTQTvbol686zkUj88aGBLrV1zw
 rRpFMY7QJU8e9Tpx47fSsyq429Owlhtiussxusycs1SfZGa8WUpMcNkP6niOyCxltwNM
 9qJR2JmHOuI1okOGmjvRL7QFSblFZCG5FXpcidpu+yClUubfJF8oalHsNbEpP+Du5BsE
 cFMrwZX/DU0zwDAE8DiArGTS+5ksDLauclYB+IBl5x9KO6IY6n5OIZN4a0DuKtorfOca
 ER+JdbX8fb5Vklfkw15DvNn5dSUGWyYMNTUDEi27ttXUiuzt5lToejYftOA3xYa7HriR
 W/rw==
X-Gm-Message-State: AOJu0YybEePjNlR8s1FEBEljyyDAPHrgEAre8Kwgbzd6o5SDaQuCPCTD
 HoaEkh45dThfAknXSrOCgf4XhxkCqvFTKreuYhDcHXVYi1qU9X1oUK70/yfSlL+SzMJExeCgu9+
 NSq9PU8c=
X-Gm-Gg: AfdE7cm6Y40x9h7LovdKwmW5kbUOmwEWxJFZgMKg8UWBZrhLyKzNF65XTuuF/gDND8h
 AVNdV3odmKdGYx7xnZc/2Liqi0z6xlkImyAxiyirWo+9sJc/7TRGbC09CMq/WubBQi5XPjbpWSO
 PhyJMH6pmCKMuL/gUHDOj1y8FXh8KTlVHQE9i0royMfOI5hNuyEhsRekuU4i43F+ZMK/6SPIThs
 jKY/jswLnlfWpX88k+Y/DFVUZtuY03LR1ZHunDreKmTrwSZfpfTg4n818rRQAj1HbrwwakzB/rc
 CoBt3iS5PKy3Ov4o969qwbSteFUkKcUYlM1f7z8ptP6rjte/RE75k2kVNMo8e5JTtImrQ7Z8md6
 Bh2c0FlTxifGqB6H6P9xfNoVsc5bNkHC3YLHLbOURY7cwFWwRb96a894xOnS5lzk3NuPTpA9P+3
 cDHDGomxEB8prR1Gxr1HwNJY8qy5VBWD4YVmBDkoukpx4OvuvEucAw5INNX19YAlR7Bk7a927An
 RDrpmqk8En33F8v/U9u
X-Received: by 2002:a05:651c:1594:b0:39a:f5f7:2e0d with SMTP id
 38308e7fff4ca-39af5f7369fmr11264961fa.16.1782722844686; 
 Mon, 29 Jun 2026 01:47:24 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:47:23 -0700 (PDT)
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
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 46/64] usb: dwc3: import from kernel v6.2
Date: Mon, 29 Jun 2026 10:44:22 +0200
Message-ID: <20260629084507.3254232-47-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.1 to v6.2.

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

List of commits: git log --oneline v6.1..v6.2
Commits imported:
eb320f76e31d usb: dwc3: qcom: enable vbus override when in OTG dr-mode
7d80dbd708c1 usb: dwc3: fix extcon dependency
c4e3ef568539 usb: dwc3: gadget: Ignore End Transfer delay on teardown
e498a0444324 usb: dwc3: xilinx: include linux/gpio/consumer.h
63130462c919 usb: dwc3: core: defer probe on ulpi_read_id timeout
97a48da1619b usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init
62c73bfea048 usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
f05f80f217bf usb: dwc3: pci: Update PCIe device ID for USB3 controller on CPU sub-system for Raptor Lake
9d1566e1f36b Merge 6.1-rc7 into usb-next
3205054dc6fe usb: dwc3: improve the config dependency of USB_DWC3_XILINX
d9c3b34d3b3a Merge 6.1-rc6 into usb-next
049142335613 usb: dwc3: gadget: Reduce TRB IOC settings
8527e9421690 Merge 6.1-rc3 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/core.c   | 23 ++++++++++++++++-------
 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1f348bc867c2..476b63618511 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -122,21 +122,25 @@ static void __dwc3_set_mode(struct work_struct *work)
 	unsigned long flags;
 	int ret;
 	u32 reg;
+	u32 desired_dr_role;
 
 	mutex_lock(&dwc->mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	desired_dr_role = dwc->desired_dr_role;
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	pm_runtime_get_sync(dwc->dev);
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
-	if (!dwc->desired_dr_role)
+	if (!desired_dr_role)
 		goto out;
 
-	if (dwc->desired_dr_role == dwc->current_dr_role)
+	if (desired_dr_role == dwc->current_dr_role)
 		goto out;
 
-	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
+	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
 		goto out;
 
 	switch (dwc->current_dr_role) {
@@ -164,7 +168,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	 */
 	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
 			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
+			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 		reg |= DWC3_GCTL_CORESOFTRESET;
 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -184,11 +188,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	switch (dwc->desired_dr_role) {
+	switch (desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		ret = dwc3_host_init(dwc);
 		if (ret) {
@@ -1096,8 +1100,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	if (!dwc->ulpi_ready) {
 		ret = dwc3_core_ulpi_init(dwc);
-		if (ret)
+		if (ret) {
+			if (ret == -ETIMEDOUT) {
+				dwc3_core_soft_reset(dwc);
+				ret = -EPROBE_DEFER;
+			}
 			goto err0;
+		}
 		dwc->ulpi_ready = true;
 	}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6d524fa76443..89dcfac01235 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1464,8 +1464,18 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 			 */
 			if (num_trbs_left == 1 || (needs_extra_trb &&
 					num_trbs_left <= 2 &&
-					sg_dma_len(sg_next(s)) >= length))
-				must_interrupt = true;
+					sg_dma_len(sg_next(s)) >= length)) {
+				struct dwc3_request *r;
+
+				/* Check if previous requests already set IOC */
+				list_for_each_entry(r, &dep->started_list, list) {
+					if (r != req && !r->request.no_interrupt)
+						break;
+
+					if (r == req)
+						must_interrupt = true;
+				}
+			}
 
 			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
 					must_interrupt);
@@ -1717,6 +1727,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
+	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
 }
 
@@ -3722,8 +3733,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
 		return;
 
+	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
+		return;
+
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
-	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
-- 
2.43.0

