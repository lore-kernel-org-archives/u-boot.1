Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE1606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0R7paDe9;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gY5K+D3j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A5DD40609;
	Mon, 26 Oct 2026 08:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3O6lxPbaq6F2; Mon, 26 Oct 2026 08:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 59D3B40603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004872;
	b=Ww52/XuaacHmR3wFwlYjcEfDjz6gjoz4+LA7z357YsqISmEsnrkVgpJzG/J2MMqts9jR
	 RrefOmTXrSd3w1dR/lV0xrC2sM8MkHTKHmM9wN6g5tBWXAHnz0h8CPnEWZTKyDSPhXN0j
	 69PsEW6thVs2JAEQwT0VtRhXHNNGxgL+AealySNNL4qCMMKeyeyLdrAV8yLieclJ0if+8
	 SbucEbHtivWNZ1BpR7X1mHrIYfgR7wjQCjo7y0jqNIJvfxHekHz4yyn6rvpWqSyAq3mAs
	 sNlTSwFt43JoYmuNkvF5CvJr2WmcAbPkN0FFo2MyvdgFlMwPmwC/AMTHJKDdCrdqvcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cFEyfQYXX2iAgZMYVZ52+TxtmQcm77SVkxA52B2Malw=;
	b=SNs1ICM+zrnu7X7RZccfD7uxoRypiJf3uRIlP73NKVKWAd2NFqZZYYRwaut2/Jm9VCO8
	 zwovVJTiRGRfRIDDsuERLp5Y5cJ1n7uEHrNUP+ZFbdXhZKWSVBdhD79zwf5z853TuatBy
	 DSAJxofJckWKszFiQI7gnsXSj7wky0GfLCRkngfDs0lnBku//gGBnjZsmJ5735KryuPiU
	 RTimB4aCZoDPD0BUMerpH7JCIQMYjLLeDaCPQMozAdTdXZ61BYsC+JSoXYwN4RGKt4Izn
	 YXlSOzsOlDxPc/KPtPW8oSBsEpp5/5t8qZrFH33WQ7XQXeHGngZp8mhg5iI5FQJ8rEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004872;
	bh=cFEyfQYXX2iAgZMYVZ52+TxtmQcm77SVkxA52B2Malw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0R7paDe9Ki8shcBdqpSLbwF5KCE511M1F68VdTnuOfp0fuq5V2yuBtlB3ldrtBJGA
	 teEopXhTx5gTeSVeCfr0pH7y+EfLDX29Typ8jL5HJEXvFFNQh61+414QKHOhAoFfjS
	 lu4IU7hJC6ytjPY0aAZdemxg312Coyzjj72aCHayEdQRwY3Xoj8Fc847CZhWLz6ph3
	 Z9a8KKLwMltXPmvkYCdyHJ5Oe+Vd6CIYRixDeyDLh8ru6y30GD/wZR1KvDJ/jVraUS
	 sKmxe2KGasoTmexxAz0ujxHKx+sbB+txRUyeQn4FPixEfiz3ye/yjZ3u7gz/bcwLKF
	 W2tl6S6YPquIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59D3B40603;
	Mon, 26 Oct 2026 08:54:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B0544D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D01E4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgI2AlKWBHCv for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CAF1540049
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793003162;
 b=tP2NvW1NqUGfRV032u4PoDaGqMdRyxUtfwOpdxnRliyZbkbJoMrjkEBEer/ySXAvQeiu
 XRQKUFW9WV7/wUFuL2e6lHro4l1TQcGIFmYfuRd2g9rjmUwaOIY/Gjgj0o9rFUsMvIR19
 MuIgGqL8URkc2+qZZMNqejTPDLvvxVmHm4JHGk/VCEFC+xhP8b7V4A6EBUm/qT4jz1f//
 Y4WpaOJJoxgL/ZMKiVv7SgOHl3N4m2P4S0BnE76YBvc8lhwKBN3EBQdQVKEdj+XKTVt8Y
 peCNgSRF8stECQriVC6VUhOb5ua95F/OjmMdcC/w1Sol6o0GZtk6cMfOhfcWONR08oA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793003162;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=cFEyfQYXX2iAgZMYVZ52+TxtmQcm77SVkxA52B2Malw=;
 b=lcUt+p2XhL0lH7v3YDoHyqhRl9/gYuDv2dz5zgnoxJ2JbvCPg695OuVl3VlquIkvpyxQ
 Tj3xS6Q071ECiYE73Flx0mbJgxBwl8aJ3YzCJIDtkf3qMukFEeTMMk5j7ITJY9YHqn61v
 UcVVI6DjJ21JI4+7ue+ld+6FVKMzgPYQ5pm8Qdr7CN7sDuHK/ZyB1JVQobM/Iy/gwn8Cd
 v59dHKIp1uue4v71akXTM0RkRekPy2LmYFIUDjVWquXcAbQwKj3qlw2AAypX7cFjSZiOD
 RpVkg45mBsNEOtXIPWZ9diXBgyuXtXx7ucSzplxAZyrnuMdVtmB1WPQRGAtsVotXZkA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gY5K+D3j; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gY5K+D3j
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CAF1540049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:26:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CA4344E41316;
 Mon, 26 Oct 2026 08:25:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 96FB660740;
 Mon, 26 Oct 2026 08:25:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 612B510328E76; Mon, 26 Oct 2026 09:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793003156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cFEyfQYXX2iAgZMYVZ52+TxtmQcm77SVkxA52B2Malw=;
 b=gY5K+D3jRuLIfcSsdV4hvh4PNsDX9MxyFFxm3fneVBIpt3Mv9suU+5tvITYMNJu/YqvbFb
 6YIM7IrL9/KholFcfXEhFsyo2vv6zZ1e/2B+SB4Viva6u94DYA0MfFmbA46i2mnnP2b9jj
 CehM8iwsX+iPLEk4xgco2IraN58dn3EJTUp6ZobklEHI8v4PmULV2GDbzQZajiNZBlhTVN
 xZrlAsIuZxNbkaIgfuM6UwOF8nP9CboisBVM3Xy0MTXO7XP6oHvzKPwO0AidRewcTXEByh
 Oc9RcXN1zEW7NT4ajNWQZ9R/PaXQVFkOXUWFMrlyCwY4kV84srtruUqXnsY1GQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stefan Monnier <monnier@iro.umontreal.ca>
Cc: E Shattow <e@freeshell.de>,  Marek Vasut <marex@nabladev.com>,
 Alexander Koch <akoch@initse.com>,  David Lechner
 <dlechner@baylibre.com>,  Flaviu Nistor <flaviu.nistor@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,  Tom Rini
 <trini@konsulko.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Vignesh
 R <vigneshr@ti.com>,  u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
In-Reply-To: <jwvqzhdho45.fsf-monnier+Inbox@gnu.org> (Stefan Monnier's message
 of "Sun, 25 Oct 2026 10:10:04 -0400")
References: <20260611224544.210172-1-marex@nabladev.com>
 <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
 <0c4fb416-62e8-4ed1-b7f0-a8021092db59@freeshell.de>
 <jwvqzhdho45.fsf-monnier+Inbox@gnu.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 26 Oct 2026 09:25:51 +0100
Message-ID: <87ik2oj2b4.fsf@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:54:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/10/2026 at 10:10:04 -04, Stefan Monnier <monnier@iro.umontreal.ca> wr=
ote:

> E Shattow [2026-10-25 06:29:43] wrote:
>
>> On 10/24/26 11:05, Marek Vasut wrote:
>>> On 10/24/26 5:14 PM, Stefan Monnier wrote:
>>>>> to the fixed indent:
>>>>>
>>>>> "
>>>>> DRAM:=C2=A0 3.5 GiB
>>>>> Core:=C2=A0 310 devices, 34 uclasses, devicetree: separate
>>>>> SF:=C2=A0=C2=A0=C2=A0 Detected w25q128jw with page size 256 Bytes, er=
ase size
>>>>> 4 KiB, total 16 MiB
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ^^^
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

Except sf is only about SPI NORs, not SPI NANDs. The tool has been here
for ages, it is light, but very limited (single chip, spi nor
only). People may use the mtd tool instead, which is much heavier
(requires the mtd layer which is optional) but flash/bus agnostic. All
this to say, I don't know how to make a better shortcut for it, and yes
this acronym is already sparkled all over the place.

     SPINOR:Detected

would fit, but no more space ;)

