Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79FACC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 11:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A2A180D4A;
	Wed, 14 Oct 2026 11:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xTrnF4FxeM6y; Wed, 14 Oct 2026 11:10:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8956D80D47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791976239;
	b=JMBZBIfQnaE8vHqq0EXdfBJrJJFExazZmLkeirhKPcgyh6qJZJbJT74EDP9xNTAoAqq7
	 MSx/X06h57H95Lw+Ynb2UrztZp0Eijksil8D4YcZCmncHbwRJlxiFb4St9+BDt2cZ20hq
	 10jvEiuL0orEYofMrNTx7O1flALmgtizgYLcUTZwOZYxZ4uOmw/hm5XfCoN5L7/foekm1
	 hiK98+4anVO1DazLFsKieXmESoRZ9oqV8R6Cl1pDdLpSYvFTPAZ4u1ihX3lEWlgeT4hy/
	 v+80cKZMuo7CfwC3QKgCxPqhYTEjD/wij/IvWS4+tdQSbRPmgKXx0mlfezeEfG5kwug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791976239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gXz5kng14Isdg7BYL89b4jcgpXm6OPJaRZchslp6Nvs=;
	b=fdk3XODBCVKH1u2OmLLS7kewJRssd1DG0Std+gAJdMdNgp0hiw0QTg6V28qJNjsq3SOg
	 cYUpCFfJ/E4GpLmB7p3JDvHykjh8hYClb6GnXKWTl18b8XoWTIKj5Y6XSFtxmJbWlFt0F
	 JzlZ89/0No19UW3s+v587PWVVJaeocvWYjnEsCViJrRMl3blXi/BSuUXpJSDXz+SNa3bN
	 KueulebidWYyBTLMLMxNn+he7KWt46mwKAnd/tdwEApT/CKmAsrSyU/uZcYUswDT2FuCb
	 +wAZqXHysNPXTOLPrUUX/Y/RWuynSsQJgZUFLLJmVwRsdJWEYuDcH/ASvNiu1FksLQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791976239;
	bh=gXz5kng14Isdg7BYL89b4jcgpXm6OPJaRZchslp6Nvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=auxHsud2YJDg0B5DDemHa4M2PWXuoRe46S+XnjYopJwD8wmR+hbz+FSSlkJTNVigS
	 9TUs0oBIKNu8w24RFsvV/detR6Q9NX0M0dNjNxzrNz/FehIK6gXrmWwSjxg3osJnEd
	 7uo1yqAubVPPEt1HSxAJdMCwTZrR0eY6ikjcXH5+c8AW31sbyYT/Mza4+kiwXe9AlF
	 UwtC75dDpvhIh724xyT+ENL2iWSrHnICYf3WJQJElee3nygT9h0yJhvTBADFe2IQ6W
	 Blw7+WrfzGs5oGww1y1qMM4UISP8H4+/Be0N5M4yJyVI6eNqKPNEplIHZJZGAuiIGf
	 epqG7x7pc/ZKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8956D80D47;
	Wed, 14 Oct 2026 11:10:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C8E22E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6BD44046D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juoW1dAvete6 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 11:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6A17404A8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791976238;
 b=o2uQ7Hc0ktaViDc101seo4L1RJiOWmFmVDKikUGYFGYexTtVVJhP06TIX+do9HFZLI2x
 8FOg0s7aLEsVKbceWF05UJkXxEGIlSeqVSdB86EKquUq9DmDNErl33uvZYlslBqsLvLHT
 jRUyKwF+Zfk9a+odU5PXG0NptpJhCJ3gMBzn2CNZNh6ZMNVrrqbsK0mj107esgclKigNL
 WbWDq3CsztO8l4/h8L+a7Ti9ZlM/Kxll9MBLp6egyOUGSY5lhfsNmJu/KXwnX8DguQbsy
 cTWyvOsC9uf0PNLesBunHxqs1NMziCWCi0F1S/l2MKvOFB6slyG/cYAreU60nUchAtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791976238;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=gXz5kng14Isdg7BYL89b4jcgpXm6OPJaRZchslp6Nvs=;
 b=WnTM+Wt/as/mSxKq8ad4/2CNlqFk2G5po7dkwhKDQoRBCdNX3RKAsC3+dbZ6nLn5mRBa
 oCzfL3RmNMR3929N2g7u3hZh2OlwYBHrBnV/vK18DZ9Uu7MJw08VFHBy3YiPA/OliouYs
 ksMu2o+ROtDI1H3TEvbl0SeJHLYEIFKNycUroxJaqssjKEFhOLpEVAfPNNWxMNZ3oUhMa
 PxZ4AZRw+2U9gGvawGdVnX38dF6RRMVGtYWbq1DaPVEAipkCaDDJbsjof/u5ooQqKd9fo
 G+mCdMqlDUkR0nuCM3dFWeEHsF6bONzeu3MYDIggnv15GIiuptonGnKbFXY0H81AHUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=kU5kvP34; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=kU5kvP34
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6A17404A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:37 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j4T5M5qgVzMlKd;
 Wed, 14 Oct 2026 13:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791976231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXz5kng14Isdg7BYL89b4jcgpXm6OPJaRZchslp6Nvs=;
 b=kU5kvP34l7Ud37w19zrPH+/yYIbkEkPI9JLYz2vt//Ysq5yHDXD3NmXev8wVG1Yd5MybBL
 SrY9DevDhfT3SZRV2Zyg+YBxVsYO7NMbBcnOewnTt/RwrsbtoXEbdEyYKjbq2sDVr6ejvG
 yKy6G+tZUqdj+rfB3AUUzo4bW3BG3USFzfgXgh76NecLuFk8B3wDN6ank/lFEsJwdSm0pG
 cgAKnflcehV9nFYwMwZXMSJkHlssp5UfuBu1Sg3sgqShrd93qNpdschPpudrRvULvr5jrx
 hLjbN9ax8HzhVZJZY9j7p6SLZ5oP3xKF+HgDYFht0rr9W7k3qqJ7KkP8bWw3PA==
Message-ID: <b922fe62-b62e-4b81-ba78-d9e4e08625f3@mailbox.org>
Date: Wed, 14 Oct 2026 13:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: kbd: Add 2024 Apple Magic Keyboard device IDs
To: Ryoya Tsujita <tsuji.riya@gmail.com>, u-boot@lists.u-boot-project.org,
 Mark Kettenis <kettenis@openbsd.org>, Janne Grunau <j@jannau.net>
Cc: trini@konsulko.com
References: <20261010102431.38936-1-tsuji.riya@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261010102431.38936-1-tsuji.riya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: eftycbtrgbip6baab1z4knuwi3iqgg3r
X-MBO-RS-ID: 8e2fb9ab88518485583
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/10/26 12:24 PM, Ryoya Tsujita wrote:
> The 2024 USB-C Magic Keyboards (05ac:0320, 05ac:0321 and 05ac:0322)
> have a Device Management HID interface as interface 0 and the Boot
> Keyboard as interface 1. U-Boot only looks at interface 0 when matching
> a driver, so these keyboards are bound to the generic USB device driver
> and do not work as a console input device.
> 
> Match them by vendor and product ID so that usb_kbd binds to them.
> probe_usb_keyboard() already looks through all interfaces and uses the
> Boot Keyboard on interface 1.
> 
> Tested with a 05ac:0320 keyboard (US layout, no Touch ID) on qemu_arm64
> with USB passthrough. Without this patch the device is bound to the
> generic driver and no usbkbd console device is registered; with it,
> usb_kbd is bound and keyboard input works.
> 
> 05ac:0321 and 05ac:0322 are untested. The IDs are taken from Linux's
> drivers/hid/hid-ids.h.
> 
> Signed-off-by: Ryoya Tsujita <tsuji.riya@gmail.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

> ---
>   common/usb_kbd.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
> index 36107a3b278..25d8a0dff64 100644
> --- a/common/usb_kbd.c
> +++ b/common/usb_kbd.c
> @@ -30,6 +30,9 @@
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021			0x029c
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021	0x029a
>   #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021		0x029f
> +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024			0x0320
> +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2024	0x0321
> +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2024		0x0322
>   
>   #define USB_VENDOR_ID_KEYCHRON	0x3434
>   
> @@ -724,6 +727,18 @@ static const struct usb_device_id kbd_id_table[] = {
>   		USB_DEVICE(USB_VENDOR_ID_APPLE,
>   			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021),
>   	},
> +	{
> +		USB_DEVICE(USB_VENDOR_ID_APPLE,
> +			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
> +	},
> +	{
> +		USB_DEVICE(USB_VENDOR_ID_APPLE,
> +			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2024),
> +	},
> +	{
> +		USB_DEVICE(USB_VENDOR_ID_APPLE,
> +			   USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2024),
> +	},
>   	{ }		/* Terminating entry */
>   };
>   
