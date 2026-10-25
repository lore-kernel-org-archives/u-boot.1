Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BD606A328
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OiKVvXFM;
	dkim=temperror header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=EByZnv2u
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F02640B15;
	Sun, 25 Oct 2026 14:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMgSQd336Swg; Sun, 25 Oct 2026 14:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37AE340A31
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792937942;
	b=M+zj/NtKVLzZe+wYjyMp5Z0f0ZaN1WHdd1CcFX0Pmnf0Dwj0ovoZDoiDceBjC1kN+h3j
	 iOXu4/r5KqM8MnoAHFGMh3lBmLJvR3ZgSao+t8wfrDzyPZ5udkyS5NKt98+thVXyF8ccF
	 0CND1mhDxyYO3p/MgCN8kbRoNRq0hGqK8F5QYUykzyg19GZ0b9+/FazuCvreceaER9Dzy
	 RFmqdadOlIfd+E8eJ3muJx5xlIP28HwbTyzoLYL3pvC/aXguKCFgkXEVVKhnImaFsavIX
	 J+mljx+Mj52A/CWI83pVTQfWFp4ibDwWTyNQQOiEqJYMBypiX/CPAoQTr8ePNcxLorA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792937942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zyQzA4pNuAr4ju911OSTxOihSZLIl4ooqfDl2LFtmao=;
	b=M6veNjcMKxaJMlKRAFz+I8QzYYqQMMIg7FRp02wXu1rw2cCU7kMP6rqQ4jFjlArEXFDw
	 Es5MA85/8izPQtcVTipXuw5tTueRVel7qjUDsipSlXa0TB1GVRbWjLotNooBV2BPXNkd9
	 3Mfy74aiIolWd8hueOZ0ZG7hXbMq2Xr61CJBSZNuAx5aKhcMo4XqUhsUgbFYDRoZkSrzW
	 0CypjNuGMZtKEeSXqvciexjIjASoemqykj1/Y3jaT99dqNqlEeDUjhOYUIXmm97BK1OKP
	 BKFOib5UeMcx2AbSixHOSWrmkbCXD+x28rw0GN8IlygufpH0c3c56jgDjgbhTlwbZKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792937942;
	bh=zyQzA4pNuAr4ju911OSTxOihSZLIl4ooqfDl2LFtmao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OiKVvXFMrfEeR+gHzuCznBt8oge+WHtklnyBcErs/zrCgyPwbZHc4Gl7WlgHbUOOm
	 FpVDJiP3DUkRzx/HHeToxR84FqQH16Jm6xIQB45pkH1eVGQTEfxUYqqnYwtu9lQoFD
	 uN9+nHLGm3anaM1/He1Qk5krhAXItfA1X2pzyNRZqNiJLGgTIdpqxahDOZue1eW94L
	 6rqp7MrZT/Gn0mEHOXd14ijKnk+09MUYcCzVmLQzgk0AUoCzWPoPhEaq5mG+a+qIpK
	 FTImA/X7Y3MAwYQB9B+HkSqbT4/VM8byloO6hQAX9vnmyN2fFWuqiLsFoaxtaQFkpk
	 W4GFTz6OfXUCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37AE340A31;
	Sun, 25 Oct 2026 14:19:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB0BC3AF
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D06D6608B8
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXga5EEP5Lhd for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 14:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DA26608B3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792937938;
 b=mpPTU/93BIG2udPvS4BHC1xc1pFZNIP2+PkyYLmyFQlR9dF4LpIscfLK9maLyrJjW5ZW
 66abIZaic1r0nHNGC/WUAK1ROp8kyahxSfzsU2FIE9wLI2p7vZmqXGlM/9D1K71FQ6I7c
 tWgSozBuTC405QM/cFvJXAymR1j7ZkRzapEKg2utsaTKwfM5tdG8KKTDWub9ob7a0vMX6
 jgBAf/Hb9pVHeGu9m3xlcSeVx8EE3icj578pCJngX9TIC7QZ+THt0YereLMl5i5ZHCmOr
 hiSlj/JvJ9H+XKn/BKU8mB8ucjKP/ldqBDJA27v69M+uNNnv68n90JIf9em+MpiOh8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792937938;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=zyQzA4pNuAr4ju911OSTxOihSZLIl4ooqfDl2LFtmao=;
 b=L8EbLNz5ETFtTwFF8+naovvRczzMSyBPzubsF2O5DNBC1B4DAFKeK5h84cMRCg5iFSna
 Kkj1KUWMykkvN+oaF02LVcWqfQv6iVJ1nolEyPwqdylbirZQnWbr3p75/RX3MkNVwVxKr
 +/nVPN3RNpiKzHBxt32ezdpQX2s+G44OL41cXwbpfeANUlxlG7zwsTV89Rs5abucAq+zP
 32rxuGLFx/bNNhfZQoREgBQJXdt0PeEpn3DTpPz6Zop4bO5uwWPBvMxMt++E0PMBywvtf
 8ZfYRNxFjjxQWnZ014ILwnFydSKPsWwjEMJ7Q1/mDG93CNSwnzXkHDXUYCRIg38wkXA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=EByZnv2u; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=EByZnv2u
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DA26608B3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792937919;
 bh=zyQzA4pNuAr4ju911OSTxOihSZLIl4ooqfDl2LFtmao=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EByZnv2uSofUwg3UDaAlJ2mmrWnum/EzWPc9JDSR+oXj9MJQbFC/4Nq9zF9BZfDuF
 3uC6ZX0HClwOggIRU86CNlCCiSqyr/S6mYq4SG7ps3gFZuKofURUi3k+nX93QPE9qB
 jYrwwTQyNFUKbE7s569VwDyeo9Eqk4xl/WblOnfU1LMQlGioAexpYELA3VZVPl1XcB
 qlcqAH5areJSPIYetkHklDeJs85iNtmilxQpYXOVd8etKvjn1sglNUlucV9RPGOs5F
 H6nDzPkwJPaJ2yF7Sv5qghWYiBr8atPD7WnfPBGIKDhY/rnvOl6B5ig2OPismyf28H
 IgcZ5aD4JnV+g==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B4257B225DCB;
 Sun, 25 Oct 2026 15:18:37 +0100 (CET)
Message-ID: <d38f0eb8-de5c-46ff-a686-5205637c2972@freeshell.de>
Date: Sun, 25 Oct 2026 07:18:35 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
To: Stefan Monnier <monnier@iro.umontreal.ca>
Cc: Marek Vasut <marex@nabladev.com>, Alexander Koch <akoch@initse.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.u-boot-project.org
References: <20260611224544.210172-1-marex@nabladev.com>
 <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
 <0c4fb416-62e8-4ed1-b7f0-a8021092db59@freeshell.de>
 <jwvqzhdho45.fsf-monnier+Inbox@gnu.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <jwvqzhdho45.fsf-monnier+Inbox@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stefan,

On 10/25/26 07:10, Stefan Monnier wrote:
> E Shattow [2026-10-25 06:29:43] wrote:
> 
>> On 10/24/26 11:05, Marek Vasut wrote:
>>> On 10/24/26 5:14 PM, Stefan Monnier wrote:
>>>>> to the fixed indent:
>>>>>
>>>>> "
>>>>> DRAM:  3.5 GiB
>>>>> Core:  310 devices, 34 uclasses, devicetree: separate
>>>>> SF:    Detected w25q128jw with page size 256 Bytes, erase size
>>>>> 4 KiB, total 16 MiB
>>>>>      ^^^
>>>>
>>>> I'm probably not the targeted audience, but FWIW, I find the meaning of
>>>> "SF" non-obvious, so maybe instead of adding spaces, we could use those
>>>> 3 extra characters to come up with a slightly more
>>>> self-explanatory abbreviation?
>>> SF is SPI Flash , it is used all over the code base.
> 
> Yes, that's indeed how I figured what it meant, but it would be better
> if users could figure that out without having to consult the source code.
> 
>> I also find the meaning of "SF" non-obvious, and nothing better comes to
>> mind to abbreviate it. You cannot get to "sf" command from "spi flash"
>> or "flash" commands. If the probe message would say "SPI [NOR|NAND]
>> Flash detected ...." or "SPI: [NOR|NAND] Flash detected ..." it would
> 
> How 'bout
> 
>     SPI:   16MB flash (w25q128jw) with page size 256 Bytes, erase size 4 KiB
> 
> 
> === Stefan
> 

If we can spare the bytes then "SF:  SPI Flash 16MB w25q128jw with page
size 256 Bytes, erase size" answers the context concern for me. The name
of the config is SPI_FLASH so doing anything in a different order or to
be clever is not as good to my eye.

'sf' command is only ever used for NOR? Never NAND?

Also don't take this as changes requested from me, I'd just as soon
leave it alone. I'm acknowledging that it's awkward and if you want to
make it better I'll give an opinion on it, but that's it. ;)

-E
