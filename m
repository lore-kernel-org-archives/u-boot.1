Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E393D16279
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86FB89063;
	Mon, 14 Oct 2024 16:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728917284;
	bh=nA0X4XX1Xu83Ti9yfYVfZJ9w957TI3yel8a/lnatRSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kRay82UksOdK19QCgLOuXBIjBjlQHO9nv16P9ZOW5b/htFmZoECBpAoSZIM0os2mC
	 l1HBdl7R5WmoMUX/ISDdN7+yBHHjcAJgg5dD7dZWy+7QOQkjmfaccespbV185UXe6o
	 s+jiv1rgJU3XFI9K8uKpvfec24rTotrWjzkeV505JwkRVkv6ZhAxDXhje8qxZlImMP
	 9XH3UtHv6l50KSkbDhdXTCZUeU+8pxZkKuzicbjxsKSoJZ8uxRy3/Sra2Cb0QMpB3A
	 e5o21qawd4ux8avvYLjs3bZVEJsJp+Q1001bkgqAlQ6xsIzWZ7FJNO7NSyBh+JNLrY
	 RwF5YXZ0WUv9g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6519088DFD;
 Mon, 14 Oct 2024 16:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728917283;
 bh=nA0X4XX1Xu83Ti9yfYVfZJ9w957TI3yel8a/lnatRSM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dy6bPiMUopba0NSblflweaiJXburIPodE7FA2VauX4uihCdshmHb/PH/asofjLjej
 EclPWlKzvOsQysflg10H0CP+eDeWW6xH5C3B3ZoVjFg9ZSOv8yCl55OZCJLtskayuu
 ixqd9G1O+V3uDU5KCA6duJ/vsxuiocQ6NrSOJYJA6vGpbqubwa/1MSP0Co07X+0uYb
 s9dihFfTcgjJc3D0ZR1yf+hFtphZbgnizPEbxRB7jvcgbPpDCWg/tAEBAJ+8kl7x4m
 fizpDTHSU6XUotFcIHU/uplTlQPr6BLIbdk6S0Mg67919W5tTs579lGyty/WPFK5H9
 dMzO0MGYJ7gug==
Message-ID: <6e6aaa2e-5e49-4f2b-a0e8-66ad23be3c80@denx.de>
Date: Mon, 14 Oct 2024 12:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: phy: Fix db410c crash issue during usb_stop
To: "JianfengA.Zhu@sony.com" <JianfengA.Zhu@sony.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <OSQPR04MB774067EBEEADD714EFE18C2A90882@OSQPR04MB7740.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <OSQPR04MB774067EBEEADD714EFE18C2A90882@OSQPR04MB7740.apcprd04.prod.outlook.com>
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

On 8/23/24 6:59 AM, JianfengA.Zhu@sony.com wrote:
> usb stop crash log
> ====================================================================
> dragonboard410c => usb start
> starting USB...
> Bus usb@78d9000: USB EHCI 1.00
> scanning bus usb@78d9000 for devices... 4 USB Device(s) found
>         scanning usb for storage devices... 0 Storage Device(s) found
> dragonboard410c => usb stop
> stopping USB..
> "Synchronous Abort" handler, esr 0x96000007, far 0x0
> elr: 000000008f636a28 lr : 000000008f636a24 (reloc)
> elr: 00000000bd97ea28 lr : 00000000bd97ea24
> x0 : 0000000000000000 x1 : 00000000bd1494d0
> x2 : 0000000000000000 x3 : 0000000000001f40
> x4 : 00000000bd131990 x5 : 00000000bd157b70
> x6 : 0000000000000041 x7 : 00000000bd163b80
> x8 : 00000000bd131db0 x9 : 000000000000b65c
> x10: 00000000bd13183c x11: 0000000000000006
> x12: 000000000001869f x13: 0000000000000061
> x14: 00000000ffffffff x15: 00000000bd1317b8
> x16: 00000000bd9b78ac x17: 0000000000000000
> x18: 00000000bd143d90 x19: 00000000bd1575d8
> x20: 00000000bd1575d8 x21: 00000000bd157440
> x22: 00000000bd1493b0 x23: 0000000000000002
> x24: 00000000bd9eb910 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 00000000bd158540 x29: 00000000bd131980
> 
> Code: f9400000 b4000120 97ffdd1e aa0003e2 (f9400001)
> Resetting CPU ...
> 
> resetting ...
> ====================================================================
> 
> After commit ed8fbd2889fc ("dts: msm8916: replace with upstream DTS")
> msm8916_usbphy will be defined as a child device of usb@78d9000. When
> calling usb stop, usb@78d9000 will be removed. During the removal process,
> the sub-device msm8916_usbphy will be removed first. In the subsequent
> remove process, the uclass_priv_ of msm8916_usbphy will be accessed again.
> Because uclass_priv_ is NULL at this time, it will cause a crash.
> 
> Detailed calling process
> ====================================================================
> usb_stop (drivers/usb/host/usb-uclass.c)
> |-> device_remove(bus, DM_REMOVE_NORMAL); <== remove ehci_msm
> .|-> device_chld_remove <== remove msm8916_usbphy
> . |-> device_remove
> .  |-> device_free(dev);
> .   |-> dev_set_uclass_priv(dev, NULL);
> .    |-> dev->uclass_priv_ = uclass_priv; <== uclass_priv is NULL
> |-> drv->remove(dev);
>   |-> ehci_usb_remove
>    |-> generic_shutdown_phy
>     |-> generic_shutdown_phy
>      |-> phy_get_counts
>       |-> dev_get_uclass_priv
>        |-> dm_priv_to_rw(dev->uclass_priv_); <== NULL pointer access
> ====================================================================
> 
> Fix: move usb phy power off into msm8916_usbphy remove.
> 
> Signed-off-by: Jianfeng Zhu <JianfengA.Zhu@sony.com>
> Reviewed-by: Jacky Cao <Jacky.Cao@sony.com>
> Reviewed-by: Toyama, Yoshihiro <Yoshihiro.Toyama@sony.com>
> ---
>   drivers/phy/qcom/msm8916-usbh-phy.c | 20 ++++++++++++++++++++
>   drivers/usb/host/ehci-msm.c         |  4 ----
>   2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qcom/msm8916-usbh-phy.c b/drivers/phy/qcom/msm8916-usbh-phy.c
> index 4b435aa2a6..0ba520c93d 100644
> --- a/drivers/phy/qcom/msm8916-usbh-phy.c
> +++ b/drivers/phy/qcom/msm8916-usbh-phy.c
> @@ -46,6 +46,25 @@ static int msm_phy_power_off(struct phy *phy)
>   	return 0;
>   }
>   
> +static int msm_phy_remove(struct udevice *dev)
> +{
> +	struct phy phy;
> +	int ret;
> +
> +	ret = generic_phy_get_by_index(dev->parent, 0, &phy);
> +	if (ret)
> +		return ret;
> +
> +	/* To avoid NULL pointer access exception issue, move
> +	 * generic_shutdown_phy from ehci_usb_remove to here
> +	 */
> +	ret = generic_shutdown_phy(&phy);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int msm_phy_reset(struct phy *phy)
>   {
>   	struct msm_phy_priv *p = dev_get_priv(phy->dev);
> @@ -105,5 +124,6 @@ U_BOOT_DRIVER(msm8916_usbphy) = {
>   	.of_match	= msm_phy_ids,
>   	.ops		= &msm_phy_ops,
>   	.probe		= msm_phy_probe,
> +	.remove		= msm_phy_remove,
>   	.priv_auto	= sizeof(struct msm_phy_priv),
>   };
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index ff336082e3..565859e806 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -114,10 +114,6 @@ static int ehci_usb_remove(struct udevice *dev)
>   	clk_disable_unprepare(&p->iface_clk);
>   	clk_disable_unprepare(&p->core_clk);
>   
> -	ret = generic_shutdown_phy(&p->phy);
> -	if (ret)
> -		return ret;
> -
>   	ret = board_usb_init(0, USB_INIT_DEVICE); /* Board specific hook */
>   	if (ret < 0)
>   		return ret;

The PHY management (=shutdown) should be done by the consumer (=the USB 
controller driver), so this patch is not correct. The issue is valid.

Caleb, any suggestion ?
