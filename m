Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C06EE4996
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 20:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DCC869CD;
	Sun, 20 Aug 2023 22:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692564485;
	bh=3HHmBxDiW1tqFSiQkA9z0aZSkKxaGzzULjnQg6vL2OE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kd+8Y/G+jJ0z0SIAz2nLH+agpDddqedsG4+VtCeZk4KlUbq2SRsUueJHyCsBxlJPb
	 maw6bsGb0mYQdT2yrx+DoI3LmvreuFT2MNrqrbQGJIw/rzfQF7PIpHUbhwElLIc/sU
	 sJdFkhNghGqgcroVIi6TSNxrrtL3HTL878ezkr1WBMA4wg/J2eW0+eUaiANWK5q71P
	 xSPn89vp927QkTRpdLLPmJFEwY5pY2M7OXQcemKHtcfBEL/UbqrPWDshG4ibwInWXY
	 9PU1WJNfLEbz9BETjUt85VxrX0g1XX/bzao10WmTF8g/kEGC3HERan6iPk4ffQufnA
	 ByupjLc0g8qeg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 49B36869B5;
 Sun, 20 Aug 2023 22:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692564484;
 bh=3HHmBxDiW1tqFSiQkA9z0aZSkKxaGzzULjnQg6vL2OE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jMQSry20lkTP1M9Zss5Y3ZxZLIXX8jwz8K10KexkC7AiBl5iDC0FGN9KbyBq/kGQU
 LI3yTG9SPHf0vyjI0Mv9pvIpdnbJmCDnHRHBshLM+dre0ZCf0Df+nelkm3CAOfIEQx
 A3aRSbJ5qU15O1qZOxPa2H3MfplfhE9ZE9Lzsc2F3xvs2yEi9TECRA5FkYxm4xV1JD
 zC50M/YUnl4+hYjBKvLZb7nLmZI8K6bmybfoDMOE0FRyPEmTRoCfcDBtntyJ9wfIDY
 weMQSvU5d4ew/8JRbSgHO+fR2lLYwZkUSNeuC0G5YPWaLRfYPrbmN0F3rsmBIFXZnM
 vaTU56EcSOoOw==
Message-ID: <f0803234-cf96-631a-9ec3-812267d34690@denx.de>
Date: Sun, 20 Aug 2023 22:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
 <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
 <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de>
 <660BFE60-E330-4DA1-8466-8735BB094CFB@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <660BFE60-E330-4DA1-8466-8735BB094CFB@gmail.com>
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

On 8/20/23 21:23, Svyatoslav Ryhel wrote:
> 
> 
> 20 серпня 2023 р. 22:10:17 GMT+03:00, Marek Vasut <marex@denx.de> написав(-ла):
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
>> The way I read this block of code is, some value is written into the register if config->xcvr_setup_use_fuses is false, another value if config->xcvr_setup_use_fuses is true . Why not do this determination once in probe and then just program the appropriate value instead ?
> 
> You are correct, I will remove those previous stuff.
> 
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
>> The PHY driver implementation is trivial, example is the imx driver above, then just call phy on/off in the right place. Linux also has a PHY driver for tegra, maybe you can reuse it ?
>>
>> Let's not add ad-hoc hacks, those are difficult to maintain in the long run.
> 
> Nope, no intention to do it. Hense I assume this patch can be dropped.

Right, using DM PHY driver for controlling the PHY seems to be the right 
approach.
