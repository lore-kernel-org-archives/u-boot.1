Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C869EE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 23:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5028664A;
	Tue, 22 Aug 2023 01:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692662051;
	bh=c/X25XDZapxEfKeSB7V3eS1T87H8Wk/bHM8BmDmZSoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0qf6cj/t6YUVFc9tYS0gVy+Oa2Cfrszl/VYeYwmwfqMF9TA0pPW6H2IHWEBmLS1X
	 XI7hVJaQU6uPmZYIJrO/9xoXXSJTJkVcne7gprcsNShhjWffgkun2LKGUU4jeqjTYy
	 X97JbO94BkALPN3O69BSdNsBiR1VzvHF6Y9hDynHQ6nY4JxiAC7oY3CxcbAGETG2qW
	 aDN37RZdmbgv8kmyrFdRJKmQI1iI7xq88p/9RV8/VwNGPnV5FuadHosvRDVaM0Zm2I
	 2ydnibkVTcG3kaKooZWcxoPyvTXLzR3Vw3ItFyxe2Dx1K77Kn350x5sQtZtwKe8gTm
	 bJj9+PrFbPRig==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8E16F86386;
 Tue, 22 Aug 2023 01:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692662050;
 bh=c/X25XDZapxEfKeSB7V3eS1T87H8Wk/bHM8BmDmZSoo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JCcprbASmvFnoYR54derL9SyjXV1qSHUu3YY6/EycLGbwVAgYkkFu5tCJNwn02pR8
 bNoEnAeRWaWleJUefNd66nnyd3tY36A49SzDNf01dwZd5nw7CRYeFpkJsK97aZ8j0h
 t3sukzmW3WqBLJSKXv1nys0F8U1xurbVB8PyZnsTyqzg3OyAs8NT7YPMB3OV5xfW5V
 8V3L4iK14gbAQf/r1r59cqIZ69P7k0DT6ysdrK5xzRqH3qO8wzC/80C9jxq1yijfNr
 bF5Ja8knla1lx0bTdhTUBSQPDFbZOhVVCpmesh+sCOWBLsH5YPwzon02OIjj7erv/r
 FJoxzdFUIY1Lg==
Message-ID: <7fd6fd14-666d-27d5-f79c-dc2c2f1b1b95@denx.de>
Date: Tue, 22 Aug 2023 01:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/1] usb: host: tegra: implement dts based xcvr setup
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20230821111953.5919-1-clamor95@gmail.com>
 <20230821111953.5919-2-clamor95@gmail.com>
 <8864abd1-58c9-d529-9084-4707077f4f21@denx.de>
 <9FA3D118-5D1A-4293-A37A-8D280D62A805@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9FA3D118-5D1A-4293-A37A-8D280D62A805@gmail.com>
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

On 8/21/23 16:06, Svyatoslav Ryhel wrote:
> 21 серпня 2023 р. 16:41:51 GMT+03:00, Marek Vasut <marex@denx.de> написав(-ла):
>> On 8/21/23 13:19, Svyatoslav Ryhel wrote:
>>> Some devices (like ASUS TF201) may not use fuse based xcvr setup
>>> which will result in not working USB line. To fix this situation
>>> allow xcvr setup to be performed from device tree values if
>>> nvidia,xcvr-setup-use-fuses is not defined.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    drivers/usb/host/ehci-tegra.c | 48 +++++++++++++++++++++++++++++++----
>>>    1 file changed, 43 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
>>> index 2cf1625670..a9aee908f3 100644
>>> --- a/drivers/usb/host/ehci-tegra.c
>>> +++ b/drivers/usb/host/ehci-tegra.c
>>> @@ -81,6 +81,8 @@ struct fdt_usb {
>>>    	enum periph_id periph_id;/* peripheral id */
>>>    	struct gpio_desc vbus_gpio;	/* GPIO for vbus enable */
>>>    	struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
>>> +	bool xcvr_setup_use_fuses; /* Indicates that the value is read from the on-chip fuses */
>>> +	u32 xcvr_setup;	/* Input of XCVR cell, HS driver output control */
>>>    };
>>>      /*
>>> @@ -464,10 +466,16 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
>>>      		/* Recommended PHY settings for EYE diagram */
>>>    		val = readl(&usbctlr->utmip_xcvr_cfg0);
>>> -		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>> -				0x4 << UTMIP_XCVR_SETUP_SHIFT);
>>> -		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>> -				0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>>> +
>>> +		if (!config->xcvr_setup_use_fuses) {
>>> +			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>> +					config->xcvr_setup <<
>>> +					UTMIP_XCVR_SETUP_SHIFT);
>>> +			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>> +					config->xcvr_setup <<
>>> +					UTMIP_XCVR_SETUP_MSB_SHIFT);
>>> +		}
>>> +
>>>    		clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>>>    				0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>>>    		writel(val, &usbctlr->utmip_xcvr_cfg0);
>>> @@ -522,7 +530,9 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
>>>    	setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>>>      	clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
>>> -	setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>> +
>>> +	if (config->xcvr_setup_use_fuses)
>>> +		setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>>      	/*
>>>    	 * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
>>> @@ -843,6 +853,8 @@ static const struct ehci_ops tegra_ehci_ops = {
>>>    static int ehci_usb_of_to_plat(struct udevice *dev)
>>>    {
>>>    	struct fdt_usb *priv = dev_get_priv(dev);
>>> +	u32 usb_phy_phandle;
>>> +	ofnode usb_phy_node;
>>>    	int ret;
>>>      	ret = fdt_decode_usb(dev, priv);
>>> @@ -851,6 +863,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
>>>      	priv->type = dev_get_driver_data(dev);
>>>    +	ret = ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy_phandle);
>>> +	if (ret) {
>>> +		log_debug("%s: required usb phy node isn't provided\n", __func__);
>>> +		priv->xcvr_setup_use_fuses = true;
>>> +		return 0;
>>> +	}
>>> +
>>> +	usb_phy_node = ofnode_get_by_phandle(usb_phy_phandle);
>>> +	if (!ofnode_valid(usb_phy_node)) {
>>> +		log_err("%s: failed to find usb phy node\n", __func__);
>>> +		return -EINVAL;
>>> +	}
>>
>> Can we get a simple PHY driver instead of this hackage please ?
>>
>> See the generic PHY stuff in other ehci drivers for example of how to interact with PHY drivers, and drivers/phy/ for PHY driver examples.
> 
> No we can't. As I said, I will not start a split of tegra-echi to chipidea controller and phy because of this small tweak. It seems that you don't understand what your are requesting. Sorry for bothering.

Since the i.MX EHCI controller is also ChipIdea HDRC and already uses a 
PHY driver, I think the split is perfectly doable.
