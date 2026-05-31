Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE4ECD6E57
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1FD98039B;
	Sun, 31 May 2026 23:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SECoMmsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A8EE838D7; Sun, 31 May 2026 23:43:34 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73E780077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gT9ZV1hp7z9tg2;
 Sun, 31 May 2026 23:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780263810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQ6MalWGUBiIb+LP4Fjr1sRsJc1bQ+/gbT6Ocx2jzpo=;
 b=SECoMmsTK5kKE1JJrDKbSA1dTx/74oCKOqFib9PR7aF/i1bloMIeuMxRFvT88QCF+ERzKX
 YKjIHUgjnMcECr3gv4TA4znPC1q9F6VLTZU4JXIIIEZbWRj/ZVqo92dZPXv8X+9yt8amPj
 LKAaAf+rTIcItpXMvsetCEM0XPBXXD7KSDiOdLgPPZZkG58wNLpslnW9/6lPbY/QLknYnp
 XS0p0bBAL9PepHWeJACADyBOLpeDrnaT7PQ5Va/Wg54jqnEVhYGJqMsQMCQvX0TJTcJORO
 v9QB+VWlkdJTMkSa2a11DxGIEutHRzd6113AqvKhCbjEUN7YD+JcICZZcigBQA==
Message-ID: <c7b7d0fc-bbf3-4c2a-832c-eb8eae70e3b5@mailbox.org>
Date: Sun, 31 May 2026 15:22:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: fastboot: avoid stale IN dequeue
To: Sam Day <me@samcday.com>, u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
References: <20260531-dwc3-fastboot-fix-v1-1-1e4fbfd476e8@samcday.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260531-dwc3-fastboot-fix-v1-1-1e4fbfd476e8@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: e1kymtdtnw87q3bxkj6us7zegt4iuth6
X-MBO-RS-ID: 19a287067ea47df62f4
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

On 5/31/26 9:01 AM, Sam Day wrote:
> This usb_ep_dequeue line was originally added as a fix specifically for
> MUSB UDCs.
> 
> On dwc3, it causes an error like this to be logged:
> 
> ```
> dwc3-generic-peripheral usb@a600000: request 000000016e0862
> c0 was not queued to ep1in-bulk
> ```
> 
> The trouble is, this causes an infinite loop in `fastboot oem console`.
> Every time it flushes out a response with a chunk of the console, it
> triggers another instance of this error, which means another response
> must be written, which generates the error, and so on.
> 
> I'm not sure if the MUSB gadget code still needs this workaround, so to
> be safe I opted not to remove it, but guard it with
> CONFIG_USB_MUSB_GADGET instead.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/usb/gadget/f_fastboot.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
> index 8df0e3f331d..fb7e47401ca 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -406,7 +406,8 @@ static int fastboot_tx_write(const char *buffer, unsigned int buffer_size)
>   	memcpy(in_req->buf, buffer, buffer_size);
>   	in_req->length = buffer_size;
>   
> -	usb_ep_dequeue(fastboot_func->in_ep, in_req);
> +	if (IS_ENABLED(CONFIG_USB_MUSB_GADGET))
> +		usb_ep_dequeue(fastboot_func->in_ep, in_req);
This won't work on systems that have multiple disparate USB controllers.

Why was the workaround added in the first place ?
