Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A5606A331
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=saxZfbOA;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UVDdwAcW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A23C80D99;
	Mon,  2 Nov 2026 04:32:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7TlpUVLO-eE; Mon,  2 Nov 2026 04:32:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F2EC80D92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793593954;
	b=bfEKO+jgPE9rZ+KY0+P0zygXPscKKCtC1AFWDmvEHC2B1zs9QjTzCaWoP2Eff2l4prZN
	 7STohHNrDy3VVimdv9DhPpHVXLlYnHAKNmuXCyY/yhW92UHfs1duiEGHYWBaVOmSIh/9Q
	 jTbW/tp8qA1T0fadxXgDc1C406ROpS4+SYC0JCX1JSWyWaTvmn8Pefwh3PX9dqS4iAKLT
	 eWn7Yc1oqhhC5aBizQ/hCZpGkbU1PFYSMniJcSFUL349nZPk+NwAE8tZu8vVv2mAujiyC
	 4Fh0KZjIYDjZBaSJnzn34eN4BtLaAb/6aYA9/wCbXb1fVhI3Vtcxoczb67tXri0g3Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793593954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D34Q5w5pJ1kdbjbWSvqE0sBBpR38YHc5Vcbqu6fjevc=;
	b=nVfJnLFYFdp9r8J75OtnCU3xiBQoau5IACbypjkvly4rk8lw72IK+T5ciPzdyxpbm1lE
	 FcDNWyqMT+8xim1yMnFSRFbGRt2okvYr9W92JWDdlkoKcoyX7D/SmeXohx41taWUNrluD
	 ijHK+17vLMWofUwG3oqLZjsMaCMsCL9IbYhrFgKWqHkf9dXLVjqIPIuRZvYpIySfiD3ZF
	 wxI/edr67WjS+h4VJCIdc9Qs+yWKY4lc48jFdv3ZXS0D766eZjacaivPbGn5pwTsUhnk4
	 M2wCKB+50LKUJVH7HxNwyqQeTr7il5ZvpGU9jKG1ry7FdXcGoejfGq5wBG+JhYQVqiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UVDdwAcW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793593954;
	bh=D34Q5w5pJ1kdbjbWSvqE0sBBpR38YHc5Vcbqu6fjevc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=saxZfbOAFsNOTCBlkzmaj2vUOpprIGexW0PFIjG1xq0NiK1T/0MkEWbtWZDtm896B
	 JndwaOkqBsU/ZgddueRfc1V4XV4486uOFqx6WQs4wpGA9PEDns5q9x/YEFGMLc5mV0
	 Fm/Ssxi83UW4VyzsLSuBvAQDgiH9KkHvo4NvIMNSWHCG8bpedgR3nf621hIfgqkdkA
	 U5bXntYzn8czTTc71qcaGCECbdDj4aUujKLYe88Z1jrBkBwFnUn3VIOvIhDJZdoxu3
	 DQsHrgiyNb4i1v/xVOamDs9trgRORbYlSOSKWH0oXxxAkg6EXANofkgf9sw1UIy6ha
	 NOc540E6DEMXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F2EC80D92;
	Mon,  2 Nov 2026 04:32:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 350E2156
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 266F380D92
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2U27L5-Fl3E9 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 04:32:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E97AC80D74
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793593952;
 b=ZcijD2xs6e9vDfkwvcsySRHY9Rqn2LNo92YwYDoHYPrDQpC8O6tiqJSfsrLqWBlfpXH2
 zn+0v7gwTHDrTVaT8u36QVcI+E9GfCYBC4hiz0xSnrCBw6zubjZ+Ri9gzNl6fyl1wml/f
 TraSVIZiZwLzEoLafirPpO9pzzcOIavQ+TIN5UJ4T3hOqQIeSW0AsmGqXBNOV7eswrtFu
 LRpRmOL1TfWQ88FvIul8r/LPxfxPZWXEGj40rex45KsYC8Jvx6NSEwKucTZzOjQPTGp8W
 y704PqktPas3t99HpyrFCcPDDDi5oDiy9xvTzZrJtOIxc7AXHTAeFyMp8EojQ355/eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793593952;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=D34Q5w5pJ1kdbjbWSvqE0sBBpR38YHc5Vcbqu6fjevc=;
 b=iJqHZqqEdux72/k9HRUaliIMriA0YeQ+XERj2C89nnNBDs9heF72YG/nGTG5V6GTml4Y
 vfB+kzU/0C+sRwnWwKaKJJRroFUhJo9iJlmKVIGx9Wd4ujNlWSmW17HWXsI+UAtR1+dc/
 6uIxaLwmS00j1Er2PJHrMfDcXYzr9dqFbAB8W5ed2XR5Y+W+aDFZn341wxwDVI/2zOtdt
 QXA+kpbwd+xmGooKA0ktqfB7TuopnWWa99qQFLM33q4aNUGE7/fA0Reft5wnbh8Hf7tDE
 +AcIYoPR9PYmxhgCYD+Ti6fEIz84AWTQFMaAHfWrC2J5x6d6KAohAuH0YkFyZPLWakg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UVDdwAcW; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UVDdwAcW
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E97AC80D74
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:32:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CCC8E10C335; Mon, 02 Nov 2026 05:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793593945;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=D34Q5w5pJ1kdbjbWSvqE0sBBpR38YHc5Vcbqu6fjevc=;
 b=UVDdwAcW82t4pzf42deYD0KCAT0ArLF28G1W2ZbnRl8xHbpyKMelYUYOmVZxA+L1CxZ5rX
 G5UHjGe2UpIo6/htQ2hR+hHVuTiPWtF2bq44baYZvNdYSWHodGyPBl6lh9f3d3ufcDiPwx
 lsbhrGF2JGVEG41qed59hiKTY991tYdWqhlAKjwgdueFl91Zy/uiTzaBb7oAEhn5Pec2AI
 GrozKDcpet1RZG9sUdKh3N3ha+10SOCgiYhYZWWmXQ7cvVcU7zZs7u4vrjN3jPTEpIw0Sl
 Yit943SqTaxDpRaRWFEV8s07W5TmayXPHG01HOvf8xobwwCDHpAQbQD+kWmGMw==
Message-ID: <8200f6ac-ffb0-7645-a205-f55e93bdd53b@nabladev.com>
Date: Mon, 2 Nov 2026 05:32:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Swamil Jain <s-jain1@ti.com>, u-boot@lists.u-boot-project.org
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
 <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
 <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
 <CAFLszThBeJy7wHdQRZO_tXw7_2=szSyCK=9LJ9TB-_sZX2OzEA@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAFLszThBeJy7wHdQRZO_tXw7_2=szSyCK=9LJ9TB-_sZX2OzEA@mail.gmail.com>
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 01.11.26 14:11, Simon Glass wrote:
> Hi Heiko,
> 
> On Tue, 27 Oct 2026 at 07:46, Heiko Schocher <hs@nabladev.com> wrote:
>>
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
>>> As per your feedback on the patches will try not to use the generic flag and handle the case within
>>> the driver itself. Will re-spin the series
>>> with sii902x driver as well.
>>
>> @Simon: Thanks for the review!
>>
>> please try to not drop me from cc, thanks!
> 
> Oddly this patch had CC: instead of Cc: so it didn't work. Apparently
> this rewrite is somthing that Microsoft does? But looking at the spec
> it has been allowed for a long time.

Oh!

> Anyway I have updated patman to support CC in
> https://github.com/deinde-dev/patman/pull/226 so it should not happen
> again.

Many thanks!

bye,
Heiko
> 
> Regards,
> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
