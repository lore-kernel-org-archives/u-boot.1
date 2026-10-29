Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE72606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sDM6taK7;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=HIhujteT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8737606A0;
	Thu, 29 Oct 2026 06:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZ6QqnGLqXH1; Thu, 29 Oct 2026 06:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26E676068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793256524;
	b=UkTZHC5CXRYRnVg0hyHfd4pKi94Ruh2MNlzy3h/GnpYLm7RZtfUYbJLc7LxDhz1h+XYn
	 I9+g+rEf1H5xWHZ1aHG4lCvFa1Mub1RDvaiUA9v0ow0vneFaNly5c8YcML6CBf4ATCKli
	 OqNJSKO6XVD/WoiwTFbcIxi2luMK9ioqVITjFhNirbZs3tIJsvfbXicF8ZCtYBuyBrWVp
	 sgR61ej04GALvmBf3QwLijzUpcGX2+n1FtLhzZjfrADecIXm7CdZubuiOXFlsfwejqByV
	 mdx2HnIKVFC8D3BhQZPB8JNpjBfJmL0Y+WeA0OWtyXNfYWDUHiQ0EywwqcBwZU2ZSiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793256524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a7QZoqFgJPChDyKN/wGnL+VIVD+YZt6yxyXqWGa7apA=;
	b=HONIzjfn7fSGM+D1ZnTru2RzFBHtaFrnFACw8LCXBbH1QbvquI7lafeUDByiQETeLIHY
	 Tt85kiIS46l6ALu0U/anpThycsWkCVwOZEvTjjBY0WVBR/T6rQ9bm7heaKcPDQI5E1a+x
	 bTbrfmBaBYJ8ljpEDp1kug6UdieXXyGvtP4lPvGXhxTDKwLQwrRP8AV6wsWgLath91Jox
	 ZVHfHgNTx8/uyKtS73wC19pka1Vx33BjfGNa8scXIFcR4eAL4BFlGcJD1XY5ppmjqDbkD
	 vZxRSqLGH9gaGaZhrqvMmeM4DSqjIZ3rUlMowaOLGxF9S1HsL9nEBqnhXEvwyWKzjRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793256524;
	bh=a7QZoqFgJPChDyKN/wGnL+VIVD+YZt6yxyXqWGa7apA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDM6taK7fUXDSIy310DsB3Pxh7OOKKkVh6rZnfS/SforU7RXwHPcVuNM8WhwmAYZs
	 OjLiovsgC1osruaxWddy6Sck3puwC6KD6F8XGWl3PLIN73x+iI7NWeYtf8+AClPcYS
	 vnBFO5kU1e30WWnlQfNH6A9ueLGa49BhgXip2bA0YvlAkK0wV6Ott7X8Ap7V0RwlJK
	 V0QAG/Ql49qcMDk7VVGADeNlbsEgR09nk5fSyfDrpFBttikkpWPuBNM69pw+J1ACGU
	 yCof3KyEHMmHEv/LgbWB7eDBvvZcrzLoY1/9OLb5AqBBemIgCdnFjDWfnnAGQCR+ye
	 sT6Ln93iBFy0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E676068D;
	Thu, 29 Oct 2026 06:48:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D30472
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49FC380F52
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zI3cf3NYFjDO for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55D8480F46
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793256522;
 b=Th4XdxN8u0Omm3TUzyhBmP54rRATlabm722fr8J1hNwGj+qYTahotKG6cZOD7QDuwvQ6
 LxwWIpd3VOshEx05pZRGUcLZ4BkLlCDRy8/+x/gkoXT05O2NW/IbQHO5B8UZ8XxnyxSRp
 AzWZ0Vuxi3FNskIAg5LLea0QW2F32c0vc/y8Vsd+Lf7y9jsdzEmDaAYRs/vpQMWzmsvra
 NWB/toHVb6xSOZo6q/jtvJg0hIy5oLcbR4KLc319oUhkatUpjl17hkL1g1LTD7XDu9fhh
 OaD+FSEZwPcteLwnhF0+HYUR2755uthMdazS7KQEQ5JdIJZvcnUJ/aT+bTiStx1suEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793256522;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=a7QZoqFgJPChDyKN/wGnL+VIVD+YZt6yxyXqWGa7apA=;
 b=S4ARE7zExKRbkVc7fX/0q2fOTT8CgHjCU2obCR/v+raE3hNP9/FKbx1fVhSSZBk/0m0n
 5Epju+lB2vpqA1/GvxpYhb1as+FdUG4PFoDaR0JD0pIKxX6Ifb6Qk3TBJS6Tt8P9Eb2Hs
 y7ypfVmmiEYJEPnF/8O/N9qb6H6RJ42TRQ4TcNw0rAHMgDBsItKTlnQVY23b7HhnBdvHD
 0dyKGKoRwCPehnDztDUTVlkg0ZpynowYpWw1TgssHLCukR5ZkfnZHO7Pv0lFjicUOgcsL
 KqBflQvAereLf8HSljvtTksBdlNpKsW4svDVw8SRdg+kCs9kVPrd0dlSmgoRE0EsGzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HIhujteT; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=HIhujteT
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55D8480F46
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:48:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C61810946F; Thu, 29 Oct 2026 07:48:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793256514;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=a7QZoqFgJPChDyKN/wGnL+VIVD+YZt6yxyXqWGa7apA=;
 b=HIhujteT4JQIzmHTdulUzqNqNSVKJ4z5A6/wkDONOawb8EmOF6CZpUZ5t58UNMBkrGDZuH
 yfAG4Gok6I8jZAFWsUVkuak60vJ1UO2Uo9IX9h6T5YR6wwsmzehOp9aaatVAPfe0GI9e4s
 msoYXryqGHNbgCtjlQQIL4Gz6OW7k6WLR4eUG4Ajj1p6j91P/X1hxLExGQOLBjBBV72IbC
 k4HOZd4/RNLhNl6MCHa0bGVb5fnwE1s4GB4BMoaI9WplSv345Of6ZU2HmH9MwkkOCLSH7l
 Zzrdt9bKkvSXy2wgXai699mntrrXD1ORUWtuDxn2T0lGaMgqZ7Xjvu/VIHskFw==
Message-ID: <0cfc380a-2ba0-dfb7-11ff-f16a7945a155@nabladev.com>
Date: Thu, 29 Oct 2026 07:47:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
Content-Language: en-US
To: Swamil Jain <s-jain1@ti.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
 <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
 <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
 <4eec69a0-a2b3-417e-9cf9-2dbcfbdc8ffd@ti.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <4eec69a0-a2b3-417e-9cf9-2dbcfbdc8ffd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Swamil,

On 29.10.26 07:05, Swamil Jain wrote:
> 
> 
> On 27-10-2026 13:15, Heiko Schocher wrote:
>> Hello Swamil,
>>
>> On 27.10.26 08:04, Swamil Jain wrote:
>>> Hi Simon,
>>>
>>> On 10/26/26 21:40, Simon Glass wrote:
>>>> Hi Swamil,
>>>>
>>>> On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
>>>>
>>>>> Some i2c peripherals do not require or wait for i2c ACK, so the series
>>>>> adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
>>>>> (NAK).
>>>>
>>>>>
>>>>> Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
>>>>> the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 22).
>>>>
>>>> Thanks for looking at this. Are you plannning to send a SII9022A driver?
>>>
>>> Working on the sii9022a driver.
>>>
>>>>
>>>> I've commented on the design on patch 1. It would also be worth
>>>> checking how Linux handles this for sii902x, since that driver reads
>>>> EDID through the bridge too.
>>>>
>>>
>>> Tried following the programmer's guide but will check how linux handles
>>> the EDID read for sii902x.
>>>
>>>> If the generic flag does stay, please can you add a sandbox test in
>>>> test/dm/i2c.c, like the existing tests for the DM_I2C_CHIP_RD_ADDRESS
>>>> and DM_I2C_CHIP_WR_ADDRESS flags.
>>>
>>> As per your feedback on the patches will try not to use the generic flag and handle the case 
>>> within the driver itself. Will re-spin the series
>>> with sii902x driver as well.
>>
>> @Simon: Thanks for the review!
>>
>> please try to not drop me from cc, thanks!
> 
> Sorry Heiko, will keep you in loop for future discussions.
> 

No problem, thanks!

bye,
Heiko
> Regards,
> Swamil.
> 
>>
>> bye,
>> Heiko
>>>
>>> Regards,
>>> Swamil.
>>>>
>>>> Regards,
>>>> Simon
>>>
>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
