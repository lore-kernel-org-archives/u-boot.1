Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D271D29FEE
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD43A80081;
	Wed, 14 Jan 2026 12:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QJXw2hm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57ED380325; Wed, 14 Jan 2026 12:16:03 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12A88003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E676343CD9;
 Wed, 14 Jan 2026 11:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAF4C4CEF7;
 Wed, 14 Jan 2026 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768389358;
 bh=rpiLFCUUJFNoBGDme8KZT5PJBrhaDnhiKrvZIPTVJ4Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QJXw2hm5XC6ww4ECnQnLMN0ieZ+JlXOOAfeKUNdw8cZPEYvIlCzqkXiMULLphqNA2
 HlI9AlPvolRWdVivmVxujGLRRzrLmHnijQ3ztdpr7dpuDJxC0bneK6oGI+ZMk8lbM4
 wBCIiAtwPZPpqajIuW1CUJhgyvpzdSo9qqy0TQFB6UlY7HdbztWe1wNgULWh0xY2Fa
 5NpYof4Saiqysu9+iod3QuoxmOcvkw6hm50wvKGeYJI4fxmIOHdP8peUtX9WtOo5to
 BdziDjqywDLyslkYLlXxAJU9VNJ86fIXHC14R4a9ESee9USKci7tMON3Fsk4y5Bdx/
 Khy4j6K7lNsmQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, Chris Morgan <macromorgan@hotmail.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: Re: [PATCH 2/2] usb: dwc3: core: improve reset sequence
In-Reply-To: <20251223231311.1983423-3-macroalpha82@gmail.com>
References: <20251223231311.1983423-1-macroalpha82@gmail.com>
 <20251223231311.1983423-3-macroalpha82@gmail.com>
Date: Wed, 14 Jan 2026 12:15:56 +0100
Message-ID: <87h5sofnrn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Chris,

Thank you for the patch and sorry for the review delay.

On Tue, Dec 23, 2025 at 17:13, Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>
> According to Synopsys Databook, we shouldn't be
> relying on GCTL.CORESOFTRESET bit as that's only for
> debugging purposes. Instead, let's use DCTL.CSFTRST
> if we're OTG or PERIPHERAL mode.
>
> Host side block will be reset by XHCI driver if
> necessary. Note that this reduces amount of time
> spent on dwc3_probe() by a long margin.
>
> We're still gonna wait for reset to finish for a
> long time (default to 1ms max), but tests show that
> the reset polling loop executed at most 19 times
> (modprobe dwc3 && modprobe -r dwc3 executed 1000
> times in a row).
>
> Note that this patch was submitted to Linux in 2016 [1], however I can
> confirm it is needed to support gadget mode in U-Boot on my device.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
>
> Suggested-by: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/usb/dwc3/core.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 847fa1f82c3..b4de2e95a0d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -59,11 +59,20 @@ static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>  static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  {
>  	u32		reg;
> +	int		retries = 1000;
>  
> -	/* Before Resetting PHY, put Core in Reset */
> -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> -	reg |= DWC3_GCTL_CORESOFTRESET;
> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +	/*
> +	 * We're resetting only the device side because, if we're in host mode,
> +	 * XHCI driver will reset the host block. If dwc3 was configured for
> +	 * host-only mode, then we can return early.
> +	 */
> +	if (dwc->dr_mode == USB_DR_MODE_HOST)
> +		return 0;
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> +	reg |= DWC3_DCTL_CSFTRST;
> +	reg &= ~DWC3_DCTL_RUN_STOP;
> +	dwc3_gadget_dctl_write_safe(dwc, reg);
>  
>  	/* Assert USB3 PHY reset */
>  	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));

Looking more closely at [1], I can see that /* Assert USB3 PHY reset */
and  /* Assert USB2 PHY reset */  have also been removed in that patch
(in linux)

Can you please explain why it has not been removed in the U-Boot
version?
Please add details of that in the commit message.

> @@ -87,12 +96,14 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
>  	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>  
> -	mdelay(100);
> +	do {
> +		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> +		if (!(reg & DWC3_DCTL_CSFTRST))
> +			return 0;
> +		udelay(1);
> +	} while (--retries);
>  
> -	/* After PHYs are stable we can take Core out of reset state */
> -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> -	reg &= ~DWC3_GCTL_CORESOFTRESET;
> -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +	return -ETIMEDOUT;
>  
>  	return 0;
>  }
> @@ -137,7 +148,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>  
>  	if (dwc->ref_clk) {
>  		rate = clk_get_rate(dwc->ref_clk);
> -		if (!rate)
> +		if (!rate || (long)rate < 0)

Is this a spurious change? it does not appear in the linux version of
the patch and also seems unrelated to soft reset.

>  			return;
>  		period = NSEC_PER_SEC / rate;
>  	} else {
> -- 
> 2.43.0
