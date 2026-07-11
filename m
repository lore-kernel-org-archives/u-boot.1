Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BC7C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 02:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2142D84A29;
	Sun, 12 Jul 2026 04:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xYouVW5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DC9848A1; Sun, 12 Jul 2026 04:15:11 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3148497A
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 04:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gyTfz5wCCzMlFS;
 Sun, 12 Jul 2026 04:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783822507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAYDzQZPr633pmwus/YUaF8lwK0Amg0/kKh6Sd9MX/0=;
 b=xYouVW5F91PAlu8mYGbiK0GDhFZwlLITPMaBNMB01A+QKGW+vYkvXqsAgXRrFWDhXSdgB+
 9G0s7t0dP+igpbmY/tAUGSw6trYg+sZfL8fJEXWDnTXWGjQcptPpDEt6Vce6WeKZHp0H1y
 SMk3n7sySgYAoZpZ/JVDXCMxxSxf3+zkG/s7l0+3WgqrLyHUOXLW9wxWglAWWyv5LAfW9m
 u1O1wz50ttAlxcKGs9pV0FsTGntoRHPvxDvjhvIDNOS3zWRg1fAKmjOnmAGSPReqNmk38E
 o18f4wxtiu5QiRljmob3U7D6Lmx589GBLZGEn2mZXwhMZ6u7CCyJIaZ1U02EfA==
Message-ID: <b7fbc3f5-bbd2-4c43-8b70-9a436028f04d@mailbox.org>
Date: Sat, 11 Jul 2026 21:58:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] usb: eth: Bind ASIX AX88179A/AX88772D/AX88279 to CDC
 ECM/NCM driver
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-8-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260711160808.2022242-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 89f93987fc450c1580d
X-MBO-RS-META: aybrj764oqixnrtcn4tbecoojzhu9wjm
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

On 7/11/26 6:08 PM, Jonas Karlman wrote:
> The ASIX AX88179A, AX88772D and AX88279 USB Ethernet controller
> revisions has both CDC ECM and CDC NCM support.
> 
>    AX88179:  0b95:1790 1.00
>    AX88179A: 0b95:1790 2.00
>    AX88772D: 0b95:1790 3.00
>    AX88279:  0b95:1790 4.00
> 
> Prefer using the CDC NCM or CDC ECM driver for the 2.00-4.00 version
> range of the 0b95:1790 ASIX USB Ethernet controllers.

Why this specific range ?

[...]

> +++ b/drivers/usb/eth/asix88179.c
> @@ -691,7 +691,12 @@ U_BOOT_DRIVER(ax88179_eth) = {
>   };
>   
>   static const struct usb_device_id ax88179_eth_id_table[] = {
> +#if IS_ENABLED(CONFIG_USB_ETHER_CDC_ECM) || IS_ENABLED(CONFIG_USB_ETHER_CDC_NCM)

This is USB, this should be auto-detected without any need for ifdeffery.

> +	{ USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0100),
> +		.driver_info = FLAG_TYPE_AX88179 },
> +#else
>   	{ USB_DEVICE(0x0b95, 0x1790), .driver_info = FLAG_TYPE_AX88179 },
> +#endif
>   	{ USB_DEVICE(0x0b95, 0x178a), .driver_info = FLAG_TYPE_AX88178a },
[...]

I recall there was some USB URB size limit on this ASIX USB MAC, was 
that ever sorted out ?
