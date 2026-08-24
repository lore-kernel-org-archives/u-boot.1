Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B20C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F5D580E75;
	Mon, 24 Aug 2026 16:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIaYbEcRYfOP; Mon, 24 Aug 2026 16:46:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589901;
	bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vtww8pTJCIoYeyjYspsQ5YdRyGFiAF5OeJnbDmzXM+P0lzYyfZu6cKHuDJ9YgRjKw
	 H9R3z+IrqxJpBjUefd3M5iqoUNo11i0rVRV4f/3ygrXqFH7pre9/X0/pUE/VT5Rpg+
	 FtwAKaGVWHVBmaDPg2CGB57rHe2vGSB+EjQefJxENTtqnrcw/CbdpUY1e5DxaaLrP0
	 fM+HEsZHpdFUx83d3MKszwUVtnhpzpZMmDs3gVy13C23c9QigyahwogwUQ51q30/8X
	 zXxF7VA51nY19A3d35+htRNvgyMtxlqlotgOCcq02cFgd1myCS44qDGnQ2b4vRSj35
	 Z+YsulLSGL9hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8229780E89;
	Mon, 24 Aug 2026 16:45:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 287172FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A89460665
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F30jr7jt7mJk for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:31:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=dQIxZEM0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCF8D605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:19 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso28065266b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585478; x=1788190278;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=dQIxZEM0ZE43gfU04RO94XESf6s9zlvkyFLJHlXkKQPeV5Up6MFX5RKM6/cAfqgNFo
 3BygVvU9BUJb0kKlH96LlpWV9W5Pw6D7aN1P3ZSzAlIGs6Mv1aE7MX+NVhTkCM9N52qm
 zBKa2jakm/G6WuvTBiqPMXpDws9pQq4s+qzanwFG4ty2MDgr6y+dhgU4WXnKpljbL3td
 qPJkYPyNpnSNLr/eBTPw35D/HKeBaV+Y7g/FIIKwe+gY0c+Qkc9lrMtOSRvO8i9HOTtk
 i1T5AQ7l8HOZ1HSjAs9ma4Z8zjoaPdmEUYznghR7zIdBKTBko+4/Z9IkwcB8IpRTNwJD
 a4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585478; x=1788190278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=ZHfzDuB+d+l3C1AC23ivKJkQ0sLyu+aG+XDvuPXnm8imuLCQYBo0EhUYY0FBye9t39
 HWbYtszAVAlgv0gt/79/bmCr0e8GIp74uIGIOWTvix1O/frhtzDfQ8kNUJ1OGbWHP/Qz
 3n9oP25x20W4ELPWj34rT6ISOOcp8UMlMRBhGFz0LUDZarJBfiCaPID5IhIRApCtvbvo
 Ez+v4TLzljVnP99aOHJ9lH1xPZPcQHgFZ0xMu9PXSaCQQrekfD7iChj2rop/W040LnZS
 WxPbFENjQqN4A7vuncNz1019Y1WBZtOyBawcMBqYyaFRcdPfmZXt5BKi2zeIO/qde9YF
 6SZA==
X-Gm-Message-State: AFuF++lS4MrZcDPDbCliHw0PjTr52Wgh7fUB+wZZ1S5EPpb2/Rp+wyU0
 iDn40VcfQNPpRSm1Z1Lo6misoGva1y4ynbNjAU0Zm0SbeQirEdPD2xbj96Rm6Ym4DWukdQDriPu
 g0WY2
X-Gm-Gg: AR+sD13ZcufCqvh9p2Rdx3ca2+59LQrkG+HwbiecyxQu1lFc+SScNp0JYVy0cjkXaAz
 VieMoLK1iSpznnPD5To9MRd5xOkSg9LPd7JyIiOuTDVQCflfOTwNEEQrTy+DcTtzpRDlsKJazPa
 DuwN0qIOxxyMRxNZNk8UD/zhBDRTs8xsaEXnFLGO8M64LLyY9TnTkC2P/Ij0cIhgtgPNtENo9Me
 qBC0frG7WE9JLaHCn+EkPY6PMtI+QZu2r/CnDUukaUVtS55ZJ3SQ1b7mG2aKDziwmWMxf1MA75j
 8t0ympzurdiOv9I8itQGmDbiRnhuHEejtuP9EshPMHdTXOLS5UQcX/ys3Br4jbsiM2jho0ElNg9
 a9gc4DaT0SjVWYdPDf7GYebzh9tBExb/hBNsdmG4riz8uqSq8IYBzzjJdk9slGfLEZ8X8nq3lZk
 nLPmK/+WgI3ydHHvTcedtBRDRoCIodhG4ySeZPnsr+u5J4vBjaN4hfvi5wosc2hGlExUu+CXzDU
 KWShMz1buJQsPC49Y53+g==
X-Received: by 2002:a17:906:4790:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2469f9902fmr1687924266b.0.1787585477749; 
 Mon, 24 Aug 2026 08:31:17 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1479917366b.18.2026.08.24.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 47/63] usb: dwc3: import from kernel v6.2
Date: Mon, 24 Aug 2026 17:27:18 +0200
Message-ID: <20260824152734.159794-48-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.1 to v6.2.

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

List of commits: git log --oneline v6.1..v6.2
Commits imported:
c4e3ef568539 usb: dwc3: gadget: Ignore End Transfer delay on teardown
63130462c919 usb: dwc3: core: defer probe on ulpi_read_id timeout
62c73bfea048 usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
049142335613 usb: dwc3: gadget: Reduce TRB IOC settings

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

