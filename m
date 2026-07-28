Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06C5C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B50760866;
	Tue, 28 Jul 2026 12:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3Lk7lowUNyM; Tue, 28 Jul 2026 12:04:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16BD960817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240255;
	bh=7S6u1ZTsPC1IVkP3UIvq+WsRCFrkOtg0m6ms4pWEMvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f0esVhdDVgbTi+e8JkUNd26FPTlN3DTloVCpNNVsf7DkcJY8Kyj7KeTBQsK7fEIuZ
	 YJ1rE+zv0RfInHAbSof+JNMMN3nxuVLlLEBvsFBj2DNvntBt0jv4KqhoCPte6ggNus
	 N4aEwIPVAsGViK6DsKTDMzOWdXVk7KVI6tXyap0Gtg6Xi//5nAbKfC2cYJuJmkcwDy
	 AjglKlDA1CO/8gcad6ti4x/AWNtRckPNaN8TrPcUkxEyJCaFeyvz8R477Efe9CrNqg
	 EJsLF/JnqcepduJfMW/GZMy4djvyS/TwVA0sn6EcIQDsBtVcfmkzhO2ZSJeBLN2Szf
	 Zor3tEqvvKzRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16BD960817;
	Tue, 28 Jul 2026 12:04:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 336262E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24DB440944
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rgsU6NJLNO7L for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:04:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EFB1D40935
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFB1D40935
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFB1D40935
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:04:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6331F8494B; Tue, 28 Jul 2026 14:04:10 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A748E82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:04:07 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CC1360DB8;
 Tue, 28 Jul 2026 12:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A452D1F000E9;
 Tue, 28 Jul 2026 12:04:05 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 46/75] usb: dwc3: import from kernel v6.2
In-Reply-To: <20260716134305.614278-47-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-47-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 14:04:03 +0200
Message-ID: <87bjbr1ft8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785240246;
 bh=7S6u1ZTsPC1IVkP3UIvq+WsRCFrkOtg0m6ms4pWEMvY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=EAtR15u7ug+uqgJ+elueXQHGMTEev4yYBlvpXTJkPeeBc6wUd0niSuxKdexNbOTpe
 ndJWDkTG+1C1fctXv8AvyGkGm2xcU9Pr6gxg6zEndg6w2BMcLa3aqcIUy3Ii/sYsCb
 iTxsRJ3lOUtgmc2LeHlcDOngi6OH1GcuYJifolwnn6zYy1IyIoG/QH+yNeR+MbpRlR
 B3PTVb/VdGEpqP49MJSE+RhBT9kpdqQTxa4+dgx74TWIgxoCs9ZD937Wcg3RY5d7XU
 dvENKjqGWpQXy5svNrH7OGhmPDLP/Cw5+uFTXvFXnjiucVv6XbjFs9E6jYObcQ0NIm
 tP1FF6CWX/vjg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EAtR15u7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="EAtR15u7"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v6.1 to v6.2.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v6.1..v6.2
> Commits imported:
> eb320f76e31d usb: dwc3: qcom: enable vbus override when in OTG dr-mode
> 7d80dbd708c1 usb: dwc3: fix extcon dependency
> c4e3ef568539 usb: dwc3: gadget: Ignore End Transfer delay on teardown
> e498a0444324 usb: dwc3: xilinx: include linux/gpio/consumer.h
> 63130462c919 usb: dwc3: core: defer probe on ulpi_read_id timeout
> 97a48da1619b usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init
> 62c73bfea048 usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
> f05f80f217bf usb: dwc3: pci: Update PCIe device ID for USB3 controller on CPU sub-system for Raptor Lake
> 3205054dc6fe usb: dwc3: improve the config dependency of USB_DWC3_XILINX
> 049142335613 usb: dwc3: gadget: Reduce TRB IOC settings

Please drop the irrelevant lines from the changelog (for example qcom,
xilinx)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  drivers/usb/dwc3/core.c   | 23 ++++++++++++++++-------
>  drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
>  2 files changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1f348bc867c2..476b63618511 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -122,21 +122,25 @@ static void __dwc3_set_mode(struct work_struct *work)
>  	unsigned long flags;
>  	int ret;
>  	u32 reg;
> +	u32 desired_dr_role;
>  
>  	mutex_lock(&dwc->mutex);
> +	spin_lock_irqsave(&dwc->lock, flags);
> +	desired_dr_role = dwc->desired_dr_role;
> +	spin_unlock_irqrestore(&dwc->lock, flags);
>  
>  	pm_runtime_get_sync(dwc->dev);
>  
>  	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
>  		dwc3_otg_update(dwc, 0);
>  
> -	if (!dwc->desired_dr_role)
> +	if (!desired_dr_role)
>  		goto out;
>  
> -	if (dwc->desired_dr_role == dwc->current_dr_role)
> +	if (desired_dr_role == dwc->current_dr_role)
>  		goto out;
>  
> -	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
> +	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
>  		goto out;
>  
>  	switch (dwc->current_dr_role) {
> @@ -164,7 +168,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  	 */
>  	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
>  			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
> -			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
> +			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
>  		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>  		reg |= DWC3_GCTL_CORESOFTRESET;
>  		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> @@ -184,11 +188,11 @@ static void __dwc3_set_mode(struct work_struct *work)
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
>  
> -	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
> +	dwc3_set_prtcap(dwc, desired_dr_role);
>  
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  
> -	switch (dwc->desired_dr_role) {
> +	switch (desired_dr_role) {
>  	case DWC3_GCTL_PRTCAP_HOST:
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
> @@ -1096,8 +1100,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  
>  	if (!dwc->ulpi_ready) {
>  		ret = dwc3_core_ulpi_init(dwc);
> -		if (ret)
> +		if (ret) {
> +			if (ret == -ETIMEDOUT) {
> +				dwc3_core_soft_reset(dwc);
> +				ret = -EPROBE_DEFER;
> +			}
>  			goto err0;
> +		}
>  		dwc->ulpi_ready = true;
>  	}
>  
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 6d524fa76443..89dcfac01235 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1464,8 +1464,18 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
>  			 */
>  			if (num_trbs_left == 1 || (needs_extra_trb &&
>  					num_trbs_left <= 2 &&
> -					sg_dma_len(sg_next(s)) >= length))
> -				must_interrupt = true;
> +					sg_dma_len(sg_next(s)) >= length)) {
> +				struct dwc3_request *r;
> +
> +				/* Check if previous requests already set IOC */
> +				list_for_each_entry(r, &dep->started_list, list) {
> +					if (r != req && !r->request.no_interrupt)
> +						break;
> +
> +					if (r == req)
> +						must_interrupt = true;
> +				}
> +			}
>  
>  			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
>  					must_interrupt);
> @@ -1717,6 +1727,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>  	else if (!ret)
>  		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
>  
> +	dep->flags &= ~DWC3_EP_DELAY_STOP;
>  	return ret;
>  }
>  
> @@ -3722,8 +3733,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>  	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
>  		return;
>  
> +	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
> +		return;
> +
>  	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
> -	    (dep->flags & DWC3_EP_DELAY_STOP) ||
>  	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>  		return;
>  
> -- 
> 2.53.0
