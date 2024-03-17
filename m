Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CF0C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 16:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6897387F5E;
	Sun, 17 Mar 2024 17:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710692565;
	bh=VX8PrgA42H/wZxrC9/cU5lnUXetaOn5vNszku7VLD1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkyg6RFJhecZl2UnMqBKmJSAHgWMjDgQrOKXChje1HdIVfH/+yHeEDr1bZeZlvG9w
	 d+MmCamEqlOfvpD9VNzTLzF0vgqtvtWnysP8owvb378su/Hd8G6t7dvXQl7pSUwEyc
	 rj+xUnTRMbXw8VeVO0d6iRITwoltcnuHMW8mH4wJZo/72YJFBa+9asoDoq0yVWaUm2
	 lf5fu6Wa8YLtLfu/Qb/tsc9+1F00EYS5WQSjSlqfvinC8VnC9fy/uZrOJchPkJhYxz
	 GBOWGk4V2aTvFS9gLO9+YvzDc9EbL9WbSbE2fgRT/LitDp3aUq7Undq1/EJeJYWiPM
	 +X4h4nQE8pemQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 059A687E87;
 Sun, 17 Mar 2024 17:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710692562;
 bh=VX8PrgA42H/wZxrC9/cU5lnUXetaOn5vNszku7VLD1s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P8JSR6uU/mGvNsYDGgb5/Osq+hhIwZZueAphCS+MTLGNKKQcEmn4jeOLSVu3Y+PxN
 E4MPuAoEXuaTAg55cwsOdNwJJFsPVbJ2Fk9g5LNO44nOQttGoduvf3x2/KJeU2siWK
 mlhk8dnJPcY+p6GjgXuCsLfUL451Ga1tmaN7JKngRhdlqp+0T1I35Dafv4l7OOoO3D
 Nt0D8uoxahUMxkvf+QjdkCvHgGlOuq18XJYuQdwqLpxMj1P2LscnbDKbV5AYTFilsa
 GL8qtjuQ9mFchMrcPlTreMpYn169eOMeQYjSzyjfbKqWLjGju0rw0lhcL8E8z713KI
 JuPZ99U/iKi3w==
Message-ID: <2f9109ef-c638-49fb-8c4c-bb32dfddfbc5@denx.de>
Date: Sun, 17 Mar 2024 17:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] usb: kbd: Add probe quirk for Apple and Keychron
 keyboards
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-6-d3f4b8384f68@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240317-asahi-keyboards-v2-6-d3f4b8384f68@jannau.net>
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

On 3/17/24 12:07 PM, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Those keyboards do not return the current device state. Polling will
> timeout unless there are key presses. This is not a problem during
> operation but the inital device state query during probing will fail.
> Skip this step in usb_kbd_probe_dev() to make these devices useable.
> Not all Apple keyboards behave like this. A keyboard with USB
> vendor/product ID 05ac:0221 is reported to work with the current code.
> Unfortunately some Keychron keyboards "re-use" Apple's vendor ID and
> show the same behavior (Keychron C2, 05ac:024f for example).
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   common/usb_kbd.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
> index 8cc3345075..43c7668671 100644
> --- a/common/usb_kbd.c
> +++ b/common/usb_kbd.c
> @@ -31,6 +31,10 @@
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
>   
> +#define USB_VENDOR_ID_KEYCHRON	0x3434
> +
> +#define USB_HID_QUIRK_POLL_NO_REPORT_IDLE	(1 << 0)

Use BIT(0) instead of (1 << 0)

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
