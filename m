Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E4CC5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D1F640A16;
	Fri, 21 Aug 2026 13:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwchmY7qJZTx; Fri, 21 Aug 2026 13:13:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318032;
	bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QMRqwPmimiblji4a2Sh5s7RJOC+IosYMuGnJkzAHhmSRiAAjMFtnY8NZAMO4RXHJa
	 N/c+onYDMvrqzu2E+eq68VU5hO0BZ2ZMAu9SfpAYMCL4ivGe8Lw3PvRdnz89am9vU+
	 IDD7pE4KsqY/sBijTeDywmLg/s0qs5S+uYvqN88nbIXEEdKq9bKa0UTW+Ae7HDU/3r
	 q4EFu21lJPx/HrBW3oeUsAWL+F8sfF5bpqOUQ9SmIgjDdYh0ZAyEAJ5goOyTzhErGM
	 /CH2gFWOQFipVXpNyXFBIzJ75m5lLUS9OhMqcBqFEsaYSYlbTPTmdoG4CiFJWFJtz9
	 cdSjT6HEUPJuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC92140C88;
	Fri, 21 Aug 2026 13:13:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8EC01B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B850080FF9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZUjON9XijDB0 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=z7KVuFGs
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24563810B4
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F59584A1A; Fri, 21 Aug 2026 10:51:59 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A74180117
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 10:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="z7KVuFGs"; 
 dkim-atps=neutral
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c16111a9b8dso8229166b.1
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302317; x=1787907117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=z7KVuFGsRZYjPwNs1pb4iD/UHkSnxSH047ZsuJtuYhm/MIp7ssQA6lSic9Vfyj9idR
 nc0hFjPcVTxTS9Wo584/Dq82QkNplG/hf4PHB5NTJ6O38U5D3XfpWMvuhVwP3bLKaZln
 VQHEDsLv5HYyqBEkbJf0kn65GxPcyrEuWLIc0dsi4pstJznKWQM1f24QuWYuVYnnPXEd
 SJGellM9mw3i6LsPIWK8oLSrJexlP3md7n14Vsnq8brbnfF1KdMVzLeoVvGrUQQqx5nm
 KcfsaYxM2FJbYHCDY7B9BcmyKfQ4XC8ZjcATXx/6k9VfyC4Rln7G5b0rnJL8EVikoT4l
 xqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302317; x=1787907117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=VdNOo5yaAtgXUN9274EFL01foXGwWoWH83DJYZGwZ7i2HAL3FDjxMjkEq3tACXdfj4
 xztcVDZn+VItwEjwQKpH9PJaEHBoen1Mm0Vil1tASh5jJC6WfsIFVUUaNM3ezlMTqbC7
 Wzw04wqC8P3zyzGRwn3tT+KgbZbyYwtkllLQIzmKagNv13fFYjqiV5dQ5ggEczEZtD3X
 5xbNgFkIaPAYQ0lzr5oIe09mL7C+v16LtnTMWjXPKwOJbstaD0Ko6MhdqtdGH8FiJjlZ
 g5rPOFlMwzv7QE1TaBJcnWjW5/GO0qrEM0meFtZ7qcJXSw2Pn31/IkLG7ACVEDeAXuoU
 dhmA==
X-Gm-Message-State: AFuF++lAkAxVN2uGmoIo3GK1cBCQR4Ocl+DAD5o6p7PwQMHjZD8/ZIUl
 VbYOLcYjPMnnliM+IrqTvSq83VIam3orSLO7gPlMfiikhUWgmlTO5ARi/uEKji7JuxW/zxot2nr
 Jyoc7
X-Gm-Gg: AR+sD10hrVKHfJictG5e8ZYv+9H5vzFmO6Xxorl8aGDipT3vjNolYZOq2nr8WTvPoK9
 j4WKiXyw2Miggi/hnIITj70jRd52OwGqykj2q68v+qF2RkC0c9k/A/eWstIZX6Pede17C9itBYl
 2Q4fUAnJWLbgIY3HiMqTSmLMXtPN0Lb63Hx3s/8KY/XXtytdVQfhPPX5cVHkVaUjWwyANQSzYK+
 HWizzzMTG6tMQNQgm2F275MP77DZd2BzEwUq5gkeOwI6lnqMfxApQ0xhlzjTzawFWaK9QnBiTKm
 vQ1Sict+BCawET9kaR7iz30xqGJa/EdmfSTh8vEvvC4z6iUwoe4j84ltX79ovMIVPx06x2GGDW4
 7XBuFEXSHdo9i0bGoHdIvqfp5+CuuKmXIox2HyDCngwKrIJ/0m4iX9g50GZm9mfZvrQHrLNR74Y
 MCyyWWXClNnpg8/u3bMkOfvxd8ch+28et28GwVa6d8l0OdToBkG1CAe84pPwFXsFJm60cWh0M9G
 RS4e85o4sH1QQ1o4iuOptcT
X-Received: by 2002:a17:906:c144:b0:c1f:e0fd:1140 with SMTP id
 a640c23a62f3a-c2469f92425mr244377966b.0.1787302316701; 
 Fri, 21 Aug 2026 01:51:56 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1b0csm348109266b.8.2026.08.21.01.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 47/87] usb: dwc3: import from kernel v6.2
Date: Fri, 21 Aug 2026 10:47:23 +0200
Message-ID: <20260821084829.2070426-48-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

