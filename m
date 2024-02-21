Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4398C48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 15:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDF088050;
	Wed, 21 Feb 2024 16:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708531115;
	bh=kqBX0JzVkB7wJ5qR0R42KTFV9YGAgPUEFw9oFwILHiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMNGMk4NMdyqkgcAVo+477vqdjOu136fKgWJTatVxSrmeQe+oj7npRyMPKJqypgl5
	 oii6WAR1iShLrzH/FMscNHG3y2pkehueT1ImsDUtQNHOmYwE4JHIHwzzCXHezjP9iM
	 CTbMNPoeuIieyhfEOmU0HUqYGYMOeNQ8nOoWgXRILgQrncLCjXmJHvRnnlcrJlBTry
	 h8y98Rgo4XdYZi3iHTbX7HY5g2pcfaLL9UM/eVeNIrLQICKf0bDyT3KHOZlo9qif8x
	 f7gyxKlIm1J0GAI1F4jTeM0HsXrJJxwHSQgSa0+yzdZyOQ4hveEQb4q807O7CdcO/q
	 fQRWkoKZFYbSA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D21F988022;
 Wed, 21 Feb 2024 16:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708531108;
 bh=kqBX0JzVkB7wJ5qR0R42KTFV9YGAgPUEFw9oFwILHiE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z34EDWu0OM+rg4YPB9SuwrgWtuw/HWMgaMXq9RkJvNDD7vEsX7VK424J37n6gMejy
 eVkP1qgOE5367mtVtvzhy8yGDfUnJKSFXuMxZOImsK9Bxah36D9oa2Pl+hHMlWw3uV
 gng7rgfW/ZgCuwu8rgHfB7eg1X7NlrHdVsgaSZCn6RSAMnTXUFvYeCFp0VChjpTEzU
 kW1+Pfir1gHWgE+gyj8blqsh2udUYPYTduAe/mh2hIn9dY8PIdJ+ODiyI/gYvahdUQ
 orkld9CVJOvtJ45ITxvUgKj2y0YYALDIIAPW9suIdbpSqvTmwGAW/aov2ZAxGnZG9g
 yNOhS1RPmWCpw==
Message-ID: <2acb9976-a40e-4977-b7ca-2462e84251ed@denx.de>
Date: Wed, 21 Feb 2024 13:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] usb: kbd: Ignore Yubikeys
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
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

On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> We currently only support one USB keyboard device, but some devices
> emulate keyboards for other purposes. Most commonly, people run into
> this with Yubikeys, so let's ignore those.
> 
> Even if we end up supporting multiple keyboards in the future, it's
> safer to ignore known non-keyboard devices.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   common/usb_kbd.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
> index 4cbc9acb73..774d3555d9 100644
> --- a/common/usb_kbd.c
> +++ b/common/usb_kbd.c
> @@ -120,6 +120,15 @@ struct usb_kbd_pdata {
>   
>   extern int __maybe_unused net_busy_flag;
>   
> +/*
> + * Since we only support one usbkbd device in the iomux,
> + * ignore common keyboard-emulating devices that aren't
> + * real keyboards.
> + */
> +const uint16_t vid_blocklist[] = {
> +	0x1050, /* Yubico */
> +};
> +
>   /* The period of time between two calls of usb_kbd_testc(). */
>   static unsigned long kbd_testc_tms;
>   
> @@ -465,6 +474,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>   	struct usb_endpoint_descriptor *ep;
>   	struct usb_kbd_pdata *data;
>   	int epNum;
> +	int i;
>   
>   	if (dev->descriptor.bNumConfigurations != 1)
>   		return 0;
> @@ -480,6 +490,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>   	if (iface->desc.bInterfaceProtocol != USB_PROT_HID_KEYBOARD)
>   		return 0;
>   
> +	for (i = 0; i < ARRAY_SIZE(vid_blocklist); i++) {
> +		if (dev->descriptor.idVendor == vid_blocklist[i]) {
> +			printf("Ignoring keyboard device 0x%x:0x%x\n",
> +			       dev->descriptor.idVendor,
> +			       dev->descriptor.idProduct);
> +			return 0;
> +		}
> +	}

I vaguely recall a discussion about previous version of this, I think 
the suggestion was to make the list of ignored devices configurable via 
environment variable, so users can add to that list from U-Boot shell. 
Would it be possible to make it work this way ?
