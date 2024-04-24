Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B41C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABEE88DEC;
	Wed, 24 Apr 2024 14:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713961481;
	bh=Bp/P9FVTU7D07mrWDNE3xOmOH4Bhr7g/dzp0Ld4Szcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMEx43hU8pFnTU6966qvxvHWIq55BOx+EvmiyG2voI8IM2mYDRNNs84sbnIcnoYqD
	 Zl6cXeAl6TTB+2dmojT6hC3ZwSuGz5RpqdE9e7HUJI/Wyh1hnOeCBPo8QtY6Is0lJU
	 X9MApxDxl6wlzmqP74ITpeno74k3uUpu4jfeqRMT05PY5xrBzYLtFNeWdGkB4NB5sS
	 2jhHioUUaBrOY4vm6U0FoGJprjTDn5N//skdUpNOraTXZpedJwQyjKGdRD2HVFqqbA
	 Ur7lzRZfgeTlVsZILqN434UxZejTHdHGSm8Tr5FeLQ3VEV8xwAbTbfvdea8uOcJWHq
	 mvzTzTfe7WYZQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4EF6B88CA6;
 Wed, 24 Apr 2024 14:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713961480;
 bh=Bp/P9FVTU7D07mrWDNE3xOmOH4Bhr7g/dzp0Ld4Szcg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J2xQyKxuWMAXKmKFBgaOC9syFY3C5RIJt/eIwQr9+WjWY+EEDMRNr3cXP95GVAEWX
 JYf+U/SkaagDitIWdF5bQWQgqMsoNIh08F1UloAO21vPqHer+z0qZRkaW9EyfQh7a9
 XWgKJW2eow54XaUJgoISqVCnZT2Pf07WfW7QmwfX86mC1XbrOSSseosWpFA9qF7+9s
 tcgthOgbgkHWN/KlWYT+egvqRG2WLCogRtPe3FcYt29kbSLQJYGqGqOgia3VkMBANm
 5dYhzUj37/7m+17jQNAmm+X7E8bjEKEo0S28xYh1kJ4zRxYBjQgeZ1uJYG/Kr2pryM
 piienIMZPES4w==
Message-ID: <62b2703f-13e4-4609-9fd6-552caa5bef91@denx.de>
Date: Wed, 24 Apr 2024 14:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: cdns3: gadget.c: Set fast access bit
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, trini@konsulko.com,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: rogerq@kernel.org, u-boot@lists.denx.de, pawell@cadence.com,
 peter.chen@kernel.org, srk@ti.com
References: <20240424073911.1943-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240424073911.1943-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/24/24 9:39 AM, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> When the device port is in a low power state [U3/L2/Not Connected],
> accesses to usb device registers may take a long time. This could lead to
> potential core hang when the controller registers are accessed after the
> port is disabled by setting DEVDS field. Setting the fast register access
> bit ensures that the PHY clock is keeping up in active state.
> 
> Therefore, set fast access bit to ensure the accesses to device registers
> are quick even in low power states.
> 
> commit b5148d946f45 ("usb: cdns3: gadget: set fast access bit") in the
> upstream kernel is taken as reference.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
> Changes since v2:
> ----------------
> * Updated the commit description with reference to upstream kernel commit
> * Picked up Marek's Reviewed-by tag from v2
> 
> Changes since v1:
> -----------------
> * Rebased to tip of -next
> * Added Reviewed-by tag
> 
> v2: https://lore.kernel.org/all/20240423082420.32336-1-r-gunasekaran@ti.com/
> v1: https://lore.kernel.org/u-boot/20230505121353.23486-1-r-gunasekaran@ti.com/
> 
>   drivers/usb/cdns3/gadget.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 7aa0c6b2be..d11175dc5b 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2325,6 +2325,9 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
>   	writel(USB_IEN_INIT, &regs->usb_ien);
>   	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
>   
> +	/* Set the Fast access bit */
> +	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
> +
>   	cdns3_configure_dmult(priv_dev, NULL);
>   
>   	cdns3_gadget_pullup(&priv_dev->gadget, 1);
> @@ -2383,6 +2386,7 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>   
>   	/* disable interrupt for device */
>   	writel(0, &priv_dev->regs->usb_ien);
> +	writel(0, &priv_dev->regs->usb_pwr);
>   	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
>   
>   	return ret;
> 
> base-commit: bc39e06778168a34bb4e0a34fbee4edbde4414d8

Since this is gadget stuff, +CC Mattijs , that should go through their tree.

Thanks!
