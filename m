Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73427EA7943
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 22:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9981283A47;
	Wed,  4 Feb 2026 23:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YlQMg5Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A1D838FA; Wed,  4 Feb 2026 23:11:15 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A43D839DF
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 23:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f5vgy5Bjdz9spW;
 Wed,  4 Feb 2026 23:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770243070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrMKce+0SFGK1+VTSjFJPHSmype9HeoS8rnhVWmdAC8=;
 b=YlQMg5Ca+/k2P5Ro7+tfLB93JGs7UglaJGcxZjiWY6/T8zT8JC6CD8mHHOP/lcbxiabixV
 dzCF+nhRnLcuz62lr9i1r7AItGigqoG7YGCrY5CUu7dW0DfOAO5fcSM+3fJp0hWJMS9Kak
 adF2VEtCnZeJfqVCX8d9+HMPbnZvUeVOZ/7pf068nt0gosbgKdy10VRtlHm/8rgL+sVmh/
 keEtoO2Wzk55cevx8tuAO+L0C21SAw1NGBLNd9LWJpYNVnwhSAZP3ddqURGgv386SsOzhx
 oYFXMwtlIvNiECDSCkMsgSKyDgIUPiwZxsyQrmSgU6flo8vv+INlFJOkSVHVKw==
Message-ID: <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
Date: Wed, 4 Feb 2026 15:09:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 minda.chen@starfivetech.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20260204121245.2105523-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260204121245.2105523-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ffa3d0836efd22d5ed6
X-MBO-RS-META: 8x3opwbpnrqsea3qzd6fq76ax9n87mb4
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

On 2/4/26 1:12 PM, Siddharth Vadapalli wrote:
> The cdns3_bind() function is responsible for identifying the appropriate
> driver to bind to the USB Controller's device-tree node. If the device-tree
> node has the 'dr_mode' property set to 'otg', the existing approach fails
> to bind a driver, leading to loss of functionality.
> 
> To address this, use the VBUS Valid field of the OTG Status register to
> determine the role as follows:
> - If VBUS Valid field is set, it indicates that a USB Host is supplying
>    power and the Controller should assume the Peripheral role.
> - If VBUS Valid field is clear, it indicates the absence of a USB Host and
>    the Controller should assume the Host role.
> 
> Additionally, when 'dr_mode' happens to be 'otg' and the STRAP settings
> are not specified, use VBUS Valid to determine the role in cdns3_drd_init()
> and assign it to cdns->dr_mode.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
> of the master branch of U-Boot.
> 
> Patch has been tested in the context of USB DFU boot on the J784S4 SoC
> with a Cadence USB 3.0 Controller. Since the Linux device-tree for the
> J784S4-EVM specifies the 'dr_mode' as OTG, due to reuse of Linux
> device-tree by U-Boot, the 'dr_mode' of 'otg' causes USB DFU Boot to fail.
> While one approach to fix it is to update 'dr_mode' to 'peripheral' in
> the 'k3-j784s4-u-boot.dtsi' file as a HACK, it doesn't scale to other
> SoCs and all of their 'u-boot.dtsi' files will have to be udpated as well.
> While I am providing Texas Instruments SoCs as an example, I presume that
> SoCs from other vendors are also affected by the 'dr_mode' being 'otg'.
> This patch addresses the issue by using the VBUS Valid bit of the OTG
> status register to override 'dr_mode' from 'otg' to a deterministic role
> to enable functionality.
> 
> The USB DFU Boot Logs for the R5 SPL stage on J784S4 SoC with the current
> U-Boot master as of commit
> a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
> are:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/b910f326b6c9fad760190bd299ae3ff3
> and the logs indicate that USB DFU Boot fails. The failure is specifically
> due to 'dr_mode' being 'otg' and the cdns3_bind() function failing to bind
> the device-tree node to the peripheral driver required for DFU Boot.
> 
> The USB DFU Boot Logs for the R5 SPL stage with just this patch applied
> while leaving 'dr_mode' at its existing value of 'otg' are:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/033b9772b6ab105b96806adf890848fe
> 
> Regards,
> Siddharth.
> 
>   drivers/usb/cdns3/core.c | 53 ++++++++++++++++++++++++++++++++++++++++
>   drivers/usb/cdns3/drd.c  | 11 +++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 4434dc15bec..b7be5c48fc9 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -392,6 +392,55 @@ static const struct udevice_id cdns3_ids[] = {
>   	{ },
>   };
>   
> +/*
> + * The VBUS Valid Bit in the OTG Status register can be used to determine
> + * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
> + * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
> + * it indicates the absence of a USB Host, so the Controller should assume the
> + * HOST role. If the OTG Status register is inaccessible, return OTG role.
> + */
> +static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
> +{
> +	struct cdns3 cdns, *cdnsp;
> +	void __iomem *otg_regs;
> +	fdt_addr_t otg_addr;
> +	int otg_reg_index;
> +	int vbus;
> +
> +	otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
> +	if (otg_reg_index < 0)
> +		return USB_DR_MODE_OTG;
This is wrong, the function should return error and possibly mode via 
function parameter , do not conflate return value and mode please .
