Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413DEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B19864B6;
	Wed, 23 Aug 2023 13:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692791183;
	bh=jXrOtlGRhFgWxp86ZyMwMKrb7eLxB2aQOzdJDoOwbRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yXHaSMr5jeF+VLZJ/H7zr7SW0J6xDXD/OO25nKHv20Kl9gzQLjkAP+3AKisSpcJyV
	 DC8O+Q3Xv8cYuJGC6yA2303Br7DTnHd46A+ZVciMqzgeIUsSXeoGsSB+8WHKRM6RS0
	 9F7H4BLsWFZMFUIQUraqwSJA4Xk80QLLyLAXJrTzc74/C7P6eEF2HNyzZPfhrgDEps
	 9ci0yu9K7S61mbemTpJk9rLm1UScsaA1EFzIJv3bOl3ti+GtsL2tqEFr0DTNXCXQRl
	 9RvvuMXFB8DjIlAVxoSqi6Rx+oSzla4s4ke3ilPRVDuLtCxkQbMv3oGIeILbWedgVM
	 /WVnYWJ8L7pcg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7BC46864A6;
 Wed, 23 Aug 2023 13:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692791182;
 bh=jXrOtlGRhFgWxp86ZyMwMKrb7eLxB2aQOzdJDoOwbRw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gxMlvkzKiLekF+WAW8FVdFYTPpcDzT6Xcf/zIAbJnq07UDKkiCF4I3/DEEUdyq5dL
 ByPEAWKS2Zdvzdia7i+HHl/qRcEXJ4wk241/QBy8O+d0N7mmKFS6cIOq9L1yFN678i
 FkZcz72lTS80J6fbMrJYxW7GiWlWYNdb2/nAszbLElkWPHaImE2/94EU6/Oh8jmmKg
 TpL7ytK0rPECc/0eQH0erlUrCix4hb94byRMBwde0E7pYEXIfYeTd6JbgKbeUuuLwo
 4aXgkH+qgED1gbD/9flidxqp2za9zWF53dC/6IvB8fF7YRogi6zROmJxqxLn+SCxN1
 pMEZRIZ4EHIVg==
Message-ID: <d396324b-9ba7-b791-51e4-668cf82233b9@denx.de>
Date: Wed, 23 Aug 2023 13:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
Content-Language: en-US
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
 <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
 <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de> <ZOXkLmctTCKWx84G@orome>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZOXkLmctTCKWx84G@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/23/23 12:49, Thierry Reding wrote:
> On Sun, Aug 20, 2023 at 09:10:17PM +0200, Marek Vasut wrote:
>> On 8/20/23 20:32, Svyatoslav Ryhel wrote:
>>> 20 серпня 2023 р. 21:14:15 GMT+03:00, Marek Vasut <marex@denx.de> написав(-ла):
>>>> On 8/20/23 09:13, Svyatoslav Ryhel wrote:
>>>>> 20 серпня 2023 р. 05:23:14 GMT+03:00, Marek Vasut <marex@denx.de> написав(-ла):
>>>>>> On 8/19/23 17:06, Svyatoslav Ryhel wrote:
>>>>>>> Some devices (like ASUS TF201) may not have fuse based xcvr setup
>>>>>>> which will result in not working USB line. To fix this situation
>>>>>>> allow xcvr setup to be performed from device tree values if
>>>>>>> nvidia,xcvr-setup-use-fuses is not defined.
>>>>>>>
>>>>>>> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
>>>>>>
>>>>>> I would hope so. Usually T-B tags are not added by the patch author, but that's a detail, and here it has the added model value, so keep it.
>>>>>>
>>>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>>>>> ---
>>>>>>>      drivers/usb/host/ehci-tegra.c | 53 +++++++++++++++++++++++++++++++----
>>>>>>>      1 file changed, 48 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
>>>>>>> index 2cf1625670..f24baf8f0c 100644
>>>>>>> --- a/drivers/usb/host/ehci-tegra.c
>>>>>>> +++ b/drivers/usb/host/ehci-tegra.c
>>>>>>> @@ -81,6 +81,8 @@ struct fdt_usb {
>>>>>>>         enum periph_id periph_id;/* peripheral id */
>>>>>>>         struct gpio_desc vbus_gpio;     /* GPIO for vbus enable */
>>>>>>>         struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
>>>>>>> +    bool xcvr_setup_use_fuses; /* Indicates that the value is read from the on-chip fuses */
>>>>>>> +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output control */
>>>>>>>      };
>>>>>>>        /*
>>>>>>> @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
>>>>>>>                 /* Recommended PHY settings for EYE diagram */
>>>>>>>                 val = readl(&usbctlr->utmip_xcvr_cfg0);
>>>>>>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>>>>> -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
>>>>>>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>>>>> -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>>>>> +
>>>>>>> +            if (!config->xcvr_setup_use_fuses) {
>>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>>>>> +                                    config->xcvr_setup <<
>>>>>>> +                                    UTMIP_XCVR_SETUP_SHIFT);
>>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>>>>> +                                    config->xcvr_setup <<
>>>>>>> +                                    UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>>>>> +            } else {
>>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>>>>> +                                    0x4 << UTMIP_XCVR_SETUP_SHIFT);
>>>>>>
>>>>>> What is this hard-coded value ?
>>>>>>
>>>>>
>>>>> 0x4 and 0x3 (not same) but those are not in the device tree. Mainline linux
>>>>> driver seems not set this at all if use_fuses is enabled but I decided to keep
>>>>> original setup just to not cause regressions.
>>>>>
>>>>> https://github.com/clamor-s/linux/blob/transformer/drivers/usb/phy/phy-tegra-usb.c#L587-L590
>>>>>
>>>>>> Why not place this value into config->xcvr_setup in e.g. probe() and drop this if/else statement ?
>>>>>>
>>>>>
>>>>> Because config->xcvr_setup should matter only if use_fuses is disabled
>>>>
>>>> Can it matter always instead ?
>>>>
>>>
>>> No, it cannot. You are inversing hw design. Xcvr_setup matters only if use_fuses is disabled. If use_fuses is on (which is default state) xcvr values are taken from chip fuse.
>>
>> The way I read this block of code is, some value is written into the
>> register if config->xcvr_setup_use_fuses is false, another value if
>> config->xcvr_setup_use_fuses is true . Why not do this determination once in
>> probe and then just program the appropriate value instead ?
>>
>>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>>>>> +                                    0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>>>>> +            }
>>>>>>> +
>>>>>>>                 clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>>>>>>>                                 0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>>>>>>>                 writel(val, &usbctlr->utmip_xcvr_cfg0);
>>>>>>> @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
>>>>>>>         setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>>>>>>>         clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
>>>>>>> -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>>>>>> +
>>>>>>> +    if (config->xcvr_setup_use_fuses)
>>>>>>> +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>>>>>>         /*
>>>>>>>          * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
>>>>>>> @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_ops = {
>>>>>>>      static int ehci_usb_of_to_plat(struct udevice *dev)
>>>>>>>      {
>>>>>>>         struct fdt_usb *priv = dev_get_priv(dev);
>>>>>>> +    u32 usb_phy_phandle;
>>>>>>> +    ofnode usb_phy_node;
>>>>>>>         int ret;
>>>>>>>         ret = fdt_decode_usb(dev, priv);
>>>>>>> @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
>>>>>>>         priv->type = dev_get_driver_data(dev);
>>>>>>>      +  ret = ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy_phandle);
>>>>>>> +    if (ret) {
>>>>>>> +            log_debug("%s: required usb phy node isn't provided\n", __func__);
>>>>>>> +            priv->xcvr_setup_use_fuses = true;
>>>>>>> +            return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    usb_phy_node = ofnode_get_by_phandle(usb_phy_phandle);
>>>>>>> +    if (!ofnode_valid(usb_phy_node)) {
>>>>>>> +            log_err("%s: failed to find usb phy node\n", __func__);
>>>>>>> +            return -EINVAL;
>>>>>>> +    }
>>>>>>
>>>>>> dev_read_phandle() should replace the above
>>>>>>
>>>>>
>>>>> Goal of this piece is to get phy of_node by the phandle provided in the
>>>>> controller node. Controller node has not only single nvidia,phy phandle
>>>>> reference but also clock and reset reference. How will dev_read_phandle
>>>>> return me a phandle of "nvidia,phy"?
>>>>>
>>>>> https://github.com/clamor-s/u-boot/blob/master/arch/arm/dts/tegra30.dtsi#L798-L834
>>>>>
>>>>>>> +    priv->xcvr_setup_use_fuses = ofnode_read_bool(
>>>>>>> +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
>>>>>>
>>>>>> dev_read_bool()
>>>>>>
>>>>>
>>>>> This value is set in phy node, not controllers unfortunately.
>>>>
>>>> The question that comes to mind is, would it make sense to implement a PHY driver similar to what e.g. imx does -- drivers/phy/phy-imx8mq-usb.c -- for the tegra PHY ?
>>>
>>> Yes, but not by me or at least not now. I have already invested too much of my time and effort in this and I will not invest even more into refactoring all this code into 2 separate drivers. Existing code satisfies me apart from this small tweak.
>>
>> The PHY driver implementation is trivial, example is the imx driver above,
>> then just call phy on/off in the right place. Linux also has a PHY driver
>> for tegra, maybe you can reuse it ?
> 
> The Linux USB PHY driver is something that in retrospect I would've done
> differently. The problem is that it shares resources (registers and
> clock/reset lines) with the USB controller and it's caused a lot of
> headaches to support it in Linux.

Clock and reset are not a problem, since they are abstracted by clock 
and reset subsystems respectively. Shared registers can be handled by 
syscon too. As far as I can tell, the chipidea HDRC core should be well 
isolated, wherever I came in contact with it, it was. Which shared 
registers are you talking about ?

> Maybe within U-Boot this isn't such a big deal, but for Linux I would've
> preferred a single driver that is both a USB controller and a USB PHY. I
> suppose it could expose some sort of PHY object for abstraction, but
> that would probably be a bit of overkill since this is really only used
> within the USB controller driver.

This isn't about providing a PHY abstraction to the outside, but about 
keeping the CI HDRC control code (which is basically EHCI-HCD) separate 
from multiple disparate PHYs which are separate IPs.
