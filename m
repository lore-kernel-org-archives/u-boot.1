Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6630FC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DE58798C;
	Fri, 12 Jan 2024 11:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L76CAaTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 308A28764D; Fri, 12 Jan 2024 11:39:59 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44238798C
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4204161D61;
 Fri, 12 Jan 2024 10:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78462C433F1;
 Fri, 12 Jan 2024 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705055992;
 bh=MrEwlkw8q53sqjfLAxF+g3pOLHf9YSJqymGTgokTdSY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=L76CAaTzTpzcdlszpf5M3C5LFvFj0WPj9SImqLD/emzU4lCLjWAyv/3SUt6EFE4Y8
 YGRAP2zesAtng9QBa36mj0/Jwc4PWsAZzZ1lmfpLBn2yPmCowIYIqinKV7iMQI6dmV
 D+kaiV9RYTqxD2d/CkKKNWOMxVRhAE9ei9MtQhXKNiyBzDurgcNlxuLzIZSeBCpCvA
 jikXJug436ZPB8iVmEMcWpc7KFWo3Dd7KpL7iajBGvcjBGFQ1KH7XlAkdxuAGMX495
 T6LbyF5h2zBcp4LdoL/+uBFWs/H+nAHwUxeC4kLKM4Ob4JnI4m/Wd0v47wa/LFMUNl
 f6NWMV/W6Lt3Q==
Message-ID: <5444e6d5-f928-4f46-9af9-2c07c8b49f4f@kernel.org>
Date: Fri, 12 Jan 2024 12:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240112085317.1866449-3-sjoerd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 12/01/2024 10:52, Sjoerd Simons wrote:
> When dr_mode is "otg" the dwc3 is initially configured in _OTG mode;
> However in this mode the gadget functionality doesn't work without
> further configuration. To resolve that on gadget start switch to _DEVICE
> mode globally and go back to _OTG on stop again.
> 
> For this the dwc3_set_mode is renamed to dwc3_core_set_mode to avoid a
> conflict with the same function exposed by xhci-dwc3

Aren't they both doing the same thing? I'd rather define them at one place
i.e. dwc3/core.c.

The driver model design for dwc3 looks really broken in u-boot.

"snps,dwc3" is claimed by xhci-dwc3.c instead of being claimed by dwc3/core.c.
This is probably because at the time USB host was the more needed use
case at u-boot.

Ideally dwc3/core.c should claim "snps,dwc3" device and instantiate
the respective Host/Device/OTG device based on the provided otg mode.

For Host/Device mode it is straight forward.
dwc3/core.c does dwc3_set_mode() depending on the mode and:
for host mode -> register xhci-usb driver.
for device mode -> register UDC device driver.

For dual-role mode, the solution is not very clear as I don't think
there is a role switch framework present.

To begin with, we could probably restrict it to just device mode
as most platforms were forcing it to device mode in any case as they
usually have a 2nd USB port that is host only.

A better solution would be to introduce a role switch mechanism 
like it exists in Linux so user can choose what mode he wants to
operate. That could wait till someone really wants such a feature.

> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v4:
> - New patch
> 
>  drivers/usb/dwc3/core.c   | 10 +++++-----
>  drivers/usb/dwc3/core.h   |  1 +
>  drivers/usb/dwc3/gadget.c |  6 ++++++
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 4b4fcd8a22e..d22d4c4bb6a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -42,7 +42,7 @@
>  static LIST_HEAD(dwc3_list);
>  /* -------------------------------------------------------------------------- */
>  
> -static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> +void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode)
>  {
>  	u32 reg;
>  
> @@ -736,7 +736,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  		ret = dwc3_gadget_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize gadget\n");
> @@ -744,7 +744,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_HOST:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
> @@ -752,7 +752,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
> @@ -810,7 +810,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  	 * switch back to peripheral mode
>  	 * This enables the phy to enter idle and then, if enabled, suspend.
>  	 */
> -	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +	dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  	dwc3_gadget_run(dwc);
>  }
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 4162a682298..1e7eda89a34 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1057,6 +1057,7 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
>  void dwc3_of_parse(struct dwc3 *dwc);
>  int dwc3_init(struct dwc3 *dwc);
>  void dwc3_remove(struct dwc3 *dwc);
> +void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode);
>  
>  static inline int dwc3_host_init(struct dwc3 *dwc)
>  { return 0; }
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 406d36ceafe..69d9fe40e2f 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1468,6 +1468,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  
>  	dwc->gadget_driver	= driver;
>  
> +	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +
>  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
>  	reg &= ~(DWC3_DCFG_SPEED_MASK);
>  
> @@ -1559,6 +1562,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  	__dwc3_gadget_ep_disable(dwc->eps[0]);
>  	__dwc3_gadget_ep_disable(dwc->eps[1]);
>  
> +	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +
>  	dwc->gadget_driver	= NULL;
>  
>  	spin_unlock_irqrestore(&dwc->lock, flags);

-- 
cheers,
-roger
