Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB45C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 12:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB2588431;
	Fri,  7 Jun 2024 14:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717764904;
	bh=GRKgWIUi5vX5b2ALQbp0TxBk0tP/PSbuabhZJyKlUVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VkPvLF845aeXLRj5bKohtWAcbdFg8U9a6u7qR+4Rlct5lY2xsWd01pG2yXYvOLZUV
	 vE+der8QSuJUh6DHcMw6iY+FPfPW4G892Q4cwnin4Z3pl7bnmYSe0L2QbSU0OX5anV
	 9RKs+t1SWwk+XgozYlaB7oHI3AVpgZZOwHjJehkP8257RBmjCDvzTrPGXX3JiYfc6a
	 0VQxJxZRNiL/Fw96cx5Of7LADr+4KB/Nb2ntPfL25XS6NmAs80m1hwVcXySsj5+neG
	 P+epY5EIThl58ehxyOqxZl6aq1gYjqRMzxJFFi5blIvOvr/4YyZdY2fyzuvjv/MEcY
	 GUMfeHDCUzS1g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 90DFD88444;
 Fri,  7 Jun 2024 14:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717764903;
 bh=GRKgWIUi5vX5b2ALQbp0TxBk0tP/PSbuabhZJyKlUVE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OdVn6+Ric1cGv3lus9An+/DArezyLK0+GClg1zrJ1bdHrl0diOqWu2wlDuI05u9ph
 q6iT7TeddLfAh7WD6O3tlXsxesFCRiOyJ2eM+8rPFw+M+ymHbghiAPsKEHn9t/rlHJ
 FewAetbPXFOOX8E0RCiFMWF3HQV1Ca+ef9KQ4Ni6X1mDAwDswbXYCseHrOE2sK/Fhe
 1CB9eBdv0LX+wSp7iqRTTn6+ohmaxEVI47iRtCIwiVo9phmvw5bdC100SCBJm2Q9oj
 bY62Ek7PmRltMxvEgJkG73+5b0WXEV5fJWj0g5v5HQD6MPaTJqrbub89ThULBb7FSI
 VQsP9FZbWpesg==
Message-ID: <dbe5ac5a-e510-42a2-a32e-4f06e50d22dc@denx.de>
Date: Fri, 7 Jun 2024 14:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: kbd: Add probe quirk for some generic USB mini
 keyboard
To: Dang Huynh <danct12@riseup.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240607-generic-minikbd-probe-v1-1-6a0e2646adfb@riseup.net>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240607-generic-minikbd-probe-v1-1-6a0e2646adfb@riseup.net>
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

On 6/7/24 11:19 AM, Dang Huynh wrote:
> This adds a probe quirk to some generic USB mini keyboard, those uses
> Elan's USB vendor ID and 0x1213 as product ID.
> 
> Those keyboards does not report current device state and would fail to
> initialize under U-Boot with the following error:
> 
> "Failed to get keyboard state from device 04f3:1213"
> 
> It's not known if those generic USB mini keyboard has the same VID/PID.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>   common/usb_kbd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
> index 820f591fc5..d6451ba7c2 100644
> --- a/common/usb_kbd.c
> +++ b/common/usb_kbd.c
> @@ -31,6 +31,8 @@
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
>   
> +#define USB_VENDOR_ID_ELAN	0x04f3
> +
>   #define USB_VENDOR_ID_KEYCHRON	0x3434
>   
>   #define USB_HID_QUIRK_POLL_NO_REPORT_IDLE	BIT(0)
> @@ -513,6 +515,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>   
>   	switch (dev->descriptor.idVendor) {
>   	case USB_VENDOR_ID_APPLE:
> +	case USB_VENDOR_ID_ELAN:
>   	case USB_VENDOR_ID_KEYCHRON:
>   		quirks |= USB_HID_QUIRK_POLL_NO_REPORT_IDLE;
>   		break;

Is it all keyboards from this vendor that are affected, or should this 
quirk be applied only to a specific VID/PID of this device ?
