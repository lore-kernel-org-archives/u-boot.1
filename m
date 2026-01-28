Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7577ED3F08E
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 16:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE60184034;
	Wed, 28 Jan 2026 17:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gvEftpIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4824884057; Wed, 28 Jan 2026 17:35:13 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414378401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 17:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1SYR3Vd2z9t6Z;
 Wed, 28 Jan 2026 17:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769618107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiiXeBX3jPPipGtahI1bV6+0oJL5c/bEvFYgoneKSPI=;
 b=gvEftpIeuBHSdLZGVJ37rCoWZu1OvC50wufvgjCmRsK82W1FG/8UuZbhhV0fAONLm1B1OQ
 UoHCf2jfmnDrv6W61qK3mkBwLdc2K3DCAkK8hF7C7oCb198RcH9zYpydubgunNYcGbof+3
 koNYxwm6UdgS0U+qyHhyAD3AxekgAYMOGhnS9+5HjYzznHnrgwaSaig9bNllpdR/ugOTWY
 sTMv7TazZMZ19+S5Pdpeww4HIsu/guI6hSReSeQzz5pew15phI207Ib5sHbBr3nruaqNe7
 75G41RJPmgArtVb+/inZJqULkrjyY3tY2yiHYwPOcvY07vPTlF2DA6ir0XxMOw==
Message-ID: <e454a157-24df-425a-a230-4e4a28bbbc88@mailbox.org>
Date: Wed, 28 Jan 2026 17:35:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
To: Tom Rini <trini@konsulko.com>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, sean.anderson@seco.com,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
 <139a01e9-c395-47f0-a09d-1c591c178bf9@ti.com>
 <3be6cbf5-9a54-424a-9a8e-f43867cb5a3a@mailbox.org>
 <20260128155028.GK3416603@bill-the-cat>
 <43843495-aca4-4556-a1c1-bdfb22a06b92@mailbox.org>
 <20260128161115.GL3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260128161115.GL3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a351a6b4b4d6f4aac3c
X-MBO-RS-META: y8b8c4npqbawo8ym1fkw7nd6cnb8wriy
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

On 1/28/26 5:11 PM, Tom Rini wrote:

[...]

>>>> Maybe simply call round_up(8) on the align_size , to align to the next
>>>> 8-byte aligned offset , but somewhat respect user wishes ?
>>>>
>>>> But looking at this code one more time , look at the calloc() in this
>>>> function, I think you might also have to allocate a bit more memory to
>>>> really hold all the newly aligned DTs, right ?
>>>>
>>>> Also, don't you need to align the buf_ptr as well ? Consider a scenario
>>>> where the fitImage contains two images, one ends at 4-byte aligned address,
>>>> followed by a DT. The users passes -B 4 to mkimage, and I think buf_ptr
>>>> would then be 4-byte aligned, so will the DT, no ?
>>>
>>> I'm confused. Where did we go from "default should be 8 not 4, for
>>> device trees" to "take what the user passed, make sure is 8b aligned" ?
>>> If the user tells us to do something, we should do it, and they can
>>> suffer the potential consequences. If the user doesn't tell us to do
>>> something, we should pick a reasonable default.
>> You can remove the "the user passes -B 4" part from my example, keep the
>> rest, the DT will likely end up 4-byte aligned, no ?
> 
> And 4-byte aligned is not a reasonable default.
4 is the default, unless specified otherwise:

  617         align_size = params->bl_len ? params->bl_len : 4;

Which is fine for most images, not for DTs, so DTs should be aligned to 
increments of 8 ... or fixed 8 ?
