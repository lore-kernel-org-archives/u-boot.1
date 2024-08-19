Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF195C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4351188AFA;
	Mon, 19 Aug 2024 13:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724066674;
	bh=6EiuDZBYpMBOb0E5zqHZhoNEy93vdqp3l7bDf7hYh2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWJprX1Iff+UVPkrF82WQN31u3khWvaBOP9QDtmsJZ3bst6gRcuUOjzcv58LVnIsy
	 Tx7fzbRH1OIr4RSmfUtu3yLhiWglEsOEKTqy/dDJyPP1GR++/U8PDIpi+d/42/YzMj
	 AnbZ82jgEXqKSJ/WWMSgcjp/rNYZ/Tv2fCNUx2xmPl6AfExMU9Ze7ts4herGyp5dJV
	 anWc7ce0HE3kmDqf3O2tF6POJOfBucfAo5HawmARq0wDW0jnxeAn/7nTFA7m8NQWkj
	 FbDMEm127uH8sisNwEJkVz1eZTfobKcTaA2xb7MvyR1iY5eLDMp4GHRZhojqCjyV92
	 Rn2LyIt9+smxA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3FF9F88A21;
 Mon, 19 Aug 2024 13:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724066672;
 bh=6EiuDZBYpMBOb0E5zqHZhoNEy93vdqp3l7bDf7hYh2s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WAbAY0R3hU1Jzee5xGY9rdWNzoVvDRL4m2qmaO5U/A6jiKXV5B7AYltHgnrRWJLfq
 gGFJ7jz8aQbxj9DpwT5xeJjqUz+Pm6Yta5gZ3kIT6Wo0jneC4k3nQUQtZAUG+VK2fU
 4+BnvW5St7zdTtRM9f3ZnMMpIFYx2ucaM6zwUS5Cmlj9DqQJiQXwvaHMZb2QZ+xeZv
 o+lrQtFc5MY/08iw+XeAtwe6YfRLfeMQ2NVi3KrsFAOwgS6Q0kbc8OLrd0h4yNDV6M
 XRWVtDy9l/PGMR+tu1R3pxNsKOJhPGlQ8jSylxXZ61OVe+Vb0rpVJrLnpT+2omZJT1
 ZuXwUqGOr7+5g==
Message-ID: <6d338e52-2817-4612-8592-f67cbf942b48@denx.de>
Date: Mon, 19 Aug 2024 13:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb: ehci: Fix db410c usb reset not working
To: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>,
 "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <OSQPR04MB77401D18913B397B768EC042908C2@OSQPR04MB7740.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <OSQPR04MB77401D18913B397B768EC042908C2@OSQPR04MB7740.apcprd04.prod.outlook.com>
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

On 8/19/24 4:05 AM, JianfengA.Zhu@sony.com wrote:
> usb reset not working error log
> ====================================================================
> dragonboard410c => usb reset
> resetting USB...
> Bus usb@78d9000: Port not available.
> dragonboard410c =>
> ====================================================================
> 
> After commit ed8fbd2889fc ("dts: msm8916: replace with upstream DTS")
> msm8916_usbphy will be defined as a child device of usb@78d9000. usb reset
> will first call usb_stop, and msm8916_usbphy as child dev will be unbind
> in usb_stop, and there is no bind operation in do_usb_start afterwards, so
> the msm8916_usbphy uclass cannot be found. This causes ehci_msm probe to
> fail.
> 
> Detailed calling process
> ====================================================================
> usb reset:
> |-> usb_stop (drivers/usb/host/usb-uclass.c)
> .|-> device_find_first_child
> . |-> device_unbind(rh); <== (unbind msm8916_usbphy)
> |-> do_usb_start
>   |-> usb_init (drivers/usb/host/usb-uclass.c)
>    |-> device_probe(bus);
>     |-> ehci_usb_probe
>      |-> generic_setup_phy <== err couldn't find msm8916_usbphy
> ====================================================================
> 
> Fix: rebind the msm8916_usbphy driver during ehci_usb_probe if the
> msm8916_usbphy uclass has been removed.
> 
> Signed-off-by: Jianfeng Zhu <JianfengA.Zhu@sony.com>
> Reviewed-by: Jacky Cao <Jacky.Cao@sony.com>
> Reviewed-by: Toyama, Yoshihiro <Yoshihiro.Toyama@sony.com>
> ---
>   drivers/usb/host/ehci-msm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index ff336082e3..7cb3ae0849 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -47,6 +47,8 @@ static const struct ehci_ops msm_ehci_ops = {
>   	.init_after_reset = msm_init_after_reset
>   };
>   
> +static int ehci_usb_of_bind(struct udevice *dev);
> +
>   static int ehci_usb_probe(struct udevice *dev)
>   {
>   	struct msm_ehci_priv *p = dev_get_priv(dev);
> @@ -54,6 +56,7 @@ static int ehci_usb_probe(struct udevice *dev)
>   	struct usb_plat *plat = dev_get_plat(dev);
>   	struct ehci_hccr *hccr;
>   	struct ehci_hcor *hcor;
> +	struct udevice *phydev;
>   	int ret;
>   
>   	ret = clk_get_by_name(dev, "core", &p->core_clk);
> @@ -80,6 +83,10 @@ static int ehci_usb_probe(struct udevice *dev)
>   	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
>   			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
>   
> +	ret = uclass_get_device_by_name(UCLASS_PHY, "msm8916_usbphy", &phydev);

Thanks for looking into this.

Caleb, do you know why generic_setup_phy() started failing now ? Can it 
be fixed to handle this platform instead ?
