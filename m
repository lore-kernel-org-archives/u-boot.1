Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A66606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hdsiUqCW;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=nUrPvd8C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 800C76060D;
	Mon, 26 Oct 2026 11:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pg_XPI9q08Js; Mon, 26 Oct 2026 11:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33F8760619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793012886;
	b=hHohtawK1QSkfXUKh4JZhJSQ2oYZag0pNAJqJUumihu1xXzPivm7yFki9Q24MEhdw611
	 fpN/63elN33HdAmcak1DnJmPjhcDp9cmt2MydWS4wIurUXsnYPc8ojtWQdog2emDzH4p2
	 tqhXfZrUGMhindPJzVi3oKaAsL1H4U3JnmjLtg1bzvH5Es2NFM3iZ4JWvMcAZmUd/Ss/J
	 TCKDpsHziFquadMkVBaEf9G+Xdk0mnxz5PJLAcfGf41xjejOFjPnChJQlF9i7Me445P2w
	 3iVm7tT/IFY0N+exNCiJnLVBoI7d0ShnII8fqy5id3qoK+ppGw90Ce0iaV+CSN2XaTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793012886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BzInhMtp9KH5fxgap85BZYbgRZ7XKwhq4eIIelvdfHU=;
	b=paA3oFrRAgLDv5/8HOP4hDpp4Pa8OkC2CrmJYK9UV9OYjgsoZ++YK+Urk1j1bCp7CHdI
	 DWCTIctuP7Zm3poI6OzdSbgvELHWls6aF4l1zqKN3/vd61BNk3was8QHFNI+XJcPlQzbe
	 S5v4aBEelfO3rwYP1FraMV0XtaN7D4250otZBTEQi9zkKS1od/S3KZ63NAvCFu2NO9V4W
	 uhGb/wCaBvepEqR1fGUkolnlRmNMpfuCFwrALKAU6n6LDJfCSpN+sU5qGkuM+vWLbcxaC
	 gQArpo4wnDzRIK1x5eER2wFpPfxqPrPuuba/C0OZo+2gmSbw9ubRjpQ8RiORNPQeblg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793012886;
	bh=BzInhMtp9KH5fxgap85BZYbgRZ7XKwhq4eIIelvdfHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hdsiUqCWvJUwSh44tAsWn7ICuhU3JaObXKAFIzrOauLVPGiUD1vcSeZSTa42LnfLo
	 bx6FNCPqswB/uFAC1ZBz3/kjj86Z3sA1fSzC4uC95h4K0T+yb48ZpwyMQVlvI+9vEd
	 qWmZFPDg/3eIZiwR6fy3hRmuXPrZm2Td/9279zcLCKxPXMNuOXxfzcSNxjs90b9VAe
	 ArRWyRGbS0UqFycp3u4XsUFZb6HQsbjq2CXiDN0IdTUP/TpIG9cK8sZaklvxDUve9X
	 AyrXgWXp9gIegSI3ASi/jQUnkobBIOwwxgTWjPPRSa5f6c2MoIrRcKgma7cu4LHc6+
	 FitVMK7uvutsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33F8760619;
	Mon, 26 Oct 2026 11:08:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16A5643
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F182F80E27
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 90LiQ6jLXpVv for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 11:08:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99F3F80E26
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793012882;
 b=GRV+LQu8aYUqvraSfxfESSVbIYYzt761KBTv/cB17hnXlnE1cpAr4uXqbUEUY8JtO+ZY
 MpjEJYHV78DZBp0qVOXLBMrzvfCU+a0x02xgbjPvWpT4EslUB/r/pmSkknRRVT/A8KMm3
 F4JLk+FmVx8dh8Da9aB7JwIrMW/4iqb4C/ailLww42K8sPzK7VLecHvAhwgJSkVc4oCCL
 3lxAbP4GRAGzZBzgTsJyiqVc3/Ok/kskmxlb++mc2Jdrlj48OCOEBJnOqxNWWHYw9x3AQ
 wtK6R7A0kf3LcQdzx78qS3H+QWz+WZU31UeKaT3t3Hv/5Tj3RkXY/VbOv4TvtVv4BKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793012882;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=BzInhMtp9KH5fxgap85BZYbgRZ7XKwhq4eIIelvdfHU=;
 b=Irj2dzOnGs7jiy18/DBAYGGDL/X1we28ZVT/fZHVVgRFKO/DUe/TzaF/0a62YYXJhcXs
 6mTa0R5IZi48oUlXMCQFPwNVDVlF6inkHZlVRqVA9dGuNkMD+kwwzGsj/Jng/p33Fbt1r
 tjNCJGkd8BC+ckNoiTsm0k08QKQRnqzyVoF67JOPYsupwOtr84PMTtaL6PETQivUs/1E6
 jalLst9aWTsbrfaviOzMQzVIfV4nrKmpU+SA9DUpbB5PWO0Dm2MOZJRgD2t22NuZw/YhF
 BA6O/1Hj0NV4YCjMjGF7LCoR2+OWsJrJIhceM0MAlb/AzeiTczbKtCYSIBqGRbOimIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=nUrPvd8C; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=nUrPvd8C
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99F3F80E26
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793012859;
 bh=BzInhMtp9KH5fxgap85BZYbgRZ7XKwhq4eIIelvdfHU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nUrPvd8CKwM+ds3OPbZBAy4mQc/SUxSTlasc24kKvg/hPsO9qGwd4GI7NWFJzzLnL
 ZmnHm0/S865vCs3Y13YCSda3MY3wMxKyDH7Um1dOfnEdF+ZAZzBF6HOdd4aJPf/1Di
 Bkf+BBAtSv5yNcp5R+2jL+MobqJAcZd03v6va20szAUAs4Mp6yNPMBF01EnA9SkvYI
 in7LGKwrieVoIaBmVyNMtCu9Gy+dHhmmusE6EJM8tp0QKpSZYKjeAH5eaXLJhAzzVD
 RNDk9r0BLadac9W+0hKqOFGiVhsjLEfXlKmEKZcuGAgRdBB3W+iSGykMQhnxZn4Fou
 ArwCbal8FntOA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F1C9AB22C775;
 Mon, 26 Oct 2026 12:07:36 +0100 (CET)
Message-ID: <837d78ed-dc9c-4f1a-91a1-df5944c89adc@freeshell.de>
Date: Mon, 26 Oct 2026 04:07:29 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Stefan Monnier <monnier@iro.umontreal.ca>
Cc: Marek Vasut <marex@nabladev.com>, Alexander Koch <akoch@initse.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.u-boot-project.org
References: <20260611224544.210172-1-marex@nabladev.com>
 <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
 <0c4fb416-62e8-4ed1-b7f0-a8021092db59@freeshell.de>
 <jwvqzhdho45.fsf-monnier+Inbox@gnu.org> <87ik2oj2b4.fsf@bootlin.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <87ik2oj2b4.fsf@bootlin.com>
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



On 10/26/26 01:25, Miquel Raynal wrote:
> On 25/10/2026 at 10:10:04 -04, Stefan Monnier <monnier@iro.umontreal.ca> wrote:
> 
>> E Shattow [2026-10-25 06:29:43] wrote:
>>
>>> On 10/24/26 11:05, Marek Vasut wrote:
>>>> On 10/24/26 5:14 PM, Stefan Monnier wrote:
>>>>>> to the fixed indent:
>>>>>>
>>>>>> "
>>>>>> DRAM:  3.5 GiB
>>>>>> Core:  310 devices, 34 uclasses, devicetree: separate
>>>>>> SF:    Detected w25q128jw with page size 256 Bytes, erase size
>>>>>> 4 KiB, total 16 MiB
>>>>>>      ^^^
>>>>>
>>>>> I'm probably not the targeted audience, but FWIW, I find the meaning of
>>>>> "SF" non-obvious, so maybe instead of adding spaces, we could use those
>>>>> 3 extra characters to come up with a slightly more
>>>>> self-explanatory abbreviation?
>>>> SF is SPI Flash , it is used all over the code base.
>>
>> Yes, that's indeed how I figured what it meant, but it would be better
>> if users could figure that out without having to consult the source code.
>>
>>> I also find the meaning of "SF" non-obvious, and nothing better comes to
>>> mind to abbreviate it. You cannot get to "sf" command from "spi flash"
>>> or "flash" commands. If the probe message would say "SPI [NOR|NAND]
>>> Flash detected ...." or "SPI: [NOR|NAND] Flash detected ..." it would
> 
> Except sf is only about SPI NORs, not SPI NANDs. The tool has been here
> for ages, it is light, but very limited (single chip, spi nor
> only). People may use the mtd tool instead, which is much heavier
> (requires the mtd layer which is optional) but flash/bus agnostic. All
> this to say, I don't know how to make a better shortcut for it, and yes
> this acronym is already sparkled all over the place.
> 
>      SPINOR:Detected
> 
> would fit, but no more space ;)
> 

The word choice of "Detected" is informative, but not very useful when
missing the contextual clue of "what is 'S' in 'SF:' ?"

SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total
16 MiB

SF:    SPI flash w25q128jw page size 256 Bytes, erase size 4 KiB, total
16 MiB
SF:    w25q128jw SPI flash page size 256 Bytes, erase size 4 KiB, total
16 MiB

SF:    SPI NOR w25q128jw page size 256 Bytes, erase size 4 KiB, total 16 MiB
SF:    SPI NAND w25q128jw page size 256 Bytes, erase size 4 KiB, total
16 MiB

SF:    w25q128jw SPI NOR page size 256 Bytes, erase size 4 KiB, total 16 MiB
SF:    w25q128jw SPI NAND page size 256 Bytes, erase size 4 KiB, total
16 MiB

SF:    w25q128jw page size 256 Bytes, erase size 4 KiB, total 16 MiB SPI NOR
SF:    w25q128jw page size 256 Bytes, erase size 4 KiB, total 16 MiB SPI
NAND

Save a byte and add the context along with the indent you are
suggesting. Leave headroom for dropping "flash" and substituted with
[NOR|NAND] if the command does grow to beyond a single type. Guessing
that "F" in "SF" means something is easier if we are shown what the
meaning of "S" in "SF" is.

-E
