Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D12CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 02:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40FA7846D3;
	Mon,  1 Jun 2026 04:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BFcn9lvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11469846DF; Mon,  1 Jun 2026 04:54:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD80846A7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 04:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gTJT93XJdz9t0f;
 Mon,  1 Jun 2026 04:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780282461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnOWI2Cral8tFvSIyn2T/5NGiOZ7k4vviI3ZkuBLs2w=;
 b=BFcn9lvceL6hCGbSo/toydkryliL3fi+krlou8DnjXLhuPi64SoAyd6iky2ksXnBGHEUJV
 kz3gnD49CmWTS4Gs3b+flEnWSV38FZPwx/Ke4XUiB90BL8i0uH/c4NATBrV9JHTHt8PKJz
 UogjMxcJB+i5P2CP6QxXxcHUNEikEBwY5ZdqN6pkG4HdqaP4NeMmlCMvti0c32wx01Ue23
 KDF31g/fQta82Jddwbm5v+tUDIwkoHdTTAalu1uvce5bmrbhFcl4NnKUWkilEkfwn3WbEH
 YQQP7zBHSZNpiDW3tiIOx/5eqqZM9pcWvqD+hQx7qMSTuQsMbCqD5asFhLsJSQ==
Message-ID: <d98ec03a-2636-4a68-8724-875eec450e04@mailbox.org>
Date: Mon, 1 Jun 2026 02:05:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: fastboot: avoid stale IN dequeue
To: Sam Day <me@samcday.com>, Paul Kocialkowski <contact@paulk.fr>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
References: <20260531-dwc3-fastboot-fix-v1-1-1e4fbfd476e8@samcday.com>
 <c7b7d0fc-bbf3-4c2a-832c-eb8eae70e3b5@mailbox.org>
 <yRfZvho0XzQ_6hzUJBFDPN7XN7k1eiIwbrqX5DoxELAJryntUnmmSBywdbrLIzKyOVjatkJi28J9Tn1KSkKyW0NRYHdUUr6RSaZdBL93eSc=@samcday.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <yRfZvho0XzQ_6hzUJBFDPN7XN7k1eiIwbrqX5DoxELAJryntUnmmSBywdbrLIzKyOVjatkJi28J9Tn1KSkKyW0NRYHdUUr6RSaZdBL93eSc=@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m1tz57xrfoqerjdfu7rt8bdst6umgxnk
X-MBO-RS-ID: a7121a6568f076be097
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

On 6/1/26 12:55 AM, Sam Day wrote:

Hi,

>>> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
>>> index 8df0e3f331d..fb7e47401ca 100644
>>> --- a/drivers/usb/gadget/f_fastboot.c
>>> +++ b/drivers/usb/gadget/f_fastboot.c
>>> @@ -406,7 +406,8 @@ static int fastboot_tx_write(const char *buffer, unsigned int buffer_size)
>>>    	memcpy(in_req->buf, buffer, buffer_size);
>>>    	in_req->length = buffer_size;
>>>
>>> -	usb_ep_dequeue(fastboot_func->in_ep, in_req);
>>> +	if (IS_ENABLED(CONFIG_USB_MUSB_GADGET))
>>> +		usb_ep_dequeue(fastboot_func->in_ep, in_req);
>> This won't work on systems that have multiple disparate USB controllers.
> 
> I think I follow you, but could you please expand on this a little so I'm
> not guessing as to what you mean?
> 
> My understanding is you're saying this won't work if one builds with two
> different UDC drivers enabled, one being MUSB.

Right, if your system contains e.g. MUSB and DWC3 controllers, this will 
break on one or the other.

> That's true, and in that case fastboot might continue to cause issues. As I
> noted in the original patch, I have no idea if MUSB still needs this workaround
> introduced 10+ years ago, I don't have any MUSB hardware to test on.
> 
> Or are you suggesting that introducing this gating on Kconfig symbol is broken?
> 
>>
>> Why was the workaround added in the first place ?
>>
> It was introduced by bc9071c9f318, which specifically spoke about MUSB issues.
+CC Paul
