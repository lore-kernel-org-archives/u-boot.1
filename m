Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F025CC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 15:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B0388042;
	Wed, 21 Feb 2024 16:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708531114;
	bh=nEaZiWrG18X6j43qoNpjy45qjkJI8xvN9p+TB4DjtW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbns3f0Aq1WkoZB8jAB4c7igNqSijvSGPXC/HVeygyM6AIGtWy4Q/lpcEEIbmt5sO
	 lk57JasajCvjplM4rfO82g8a0MHn3feyRqHEeyRnswbQ9hBq6V1ROp/Rh0DKHg8U4f
	 kDzeXXwuI1s0AFJuEDW37X+L3sz/6uKDFn4CLKMQxZWJ1sz24quhqG4KUPD4B9mcTk
	 mGp9OrFbkjBZ80a5MaA4YlVKtP7t0MXTTnfGM1sscZP5vpHI3gK2HCBVrRZGFNSzZC
	 KQmw6XC6rBfn4EmKKudDRniSRGyIHr6y0JlIaheaqUjGWi9zcuN1WVKaikuv9CxSOE
	 dyo0bemmpgs3w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 441C687E25;
 Wed, 21 Feb 2024 16:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708531107;
 bh=nEaZiWrG18X6j43qoNpjy45qjkJI8xvN9p+TB4DjtW0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y5m7SwqOCPEF5Vs61sHbvOATwEl5xSZH9TQmx16ywE7vaSDPhsySpmlTIqUMYyqkQ
 K5FyCoyF5u3cAJzxBYKuxVxCNtp2Amnx4CohRpSSBC6biG1YVScgrv3zHPgRCRNdQW
 PXE3d213f5RghACaQv8DyzqGaJ7sIZJ1KwPuOHxu/Nc5Yy312zdkda9CtVLw49M0qO
 iTNUWM6lIpPYF3S8WBLX0llxeCja8MuCXq8q8+KqnFqfFMwzEx63oRry5/8Igpku3v
 imjMSZypX2tnyQJN7S6M9M0IvNZzZ/rzOL61uPaXL8KHseZIRsmsZuQ/NqsasR4VlX
 Y1heVawHF1tGw==
Message-ID: <161786f2-cec2-44f3-b8d6-14e78c243e85@denx.de>
Date: Wed, 21 Feb 2024 13:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] usb: xhci: Abort transfers with unallocated rings
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-3-814b2e741790@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240221-asahi-keyboards-v1-3-814b2e741790@jannau.net>
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
> From: Janne Grunau <j@jannau.net>
> 
> Discovered while trying to use the second interface in the USB keyboard
> driver necessary on Apple USB keyboards.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   drivers/usb/host/xhci-ring.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index b60661fe05..4446f5f098 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -685,6 +685,9 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
>   		reset_ep(udev, ep_index);
>   
>   	ring = virt_dev->eps[ep_index].ring;
> +	if (!ring)
> +		return -1;

Would it make sense to return e.g. -EINVAL or some other errno ?
