Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E6606A33E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JKtXM99b;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJgyIZXI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7496660760;
	Mon, 23 Nov 2026 14:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Upr9kvVi0V1; Mon, 23 Nov 2026 14:12:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48C5A605CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443157;
	b=Z9AfI9tSsxZs04EXo4Pu71rD9CAjElvs1C3ypWGkVee1EvCZmwyibdVL4t3MjAnrJ09C
	 X3uUw+SGa/0Q8oSWUrwIu4sP6fXkfUErPKgTuYeTjVPIioHyuni7TebwFyBPH6qDWj2NB
	 vhVaRbwX6QaQeN54kX+FzmnU3vKPetBsEut9Y8wFLrdtniaPKZCQIDCOmSlrFfIvH5xK8
	 5K5C+PNKZ9pQyx7x8hLHm86oCc8cHuWi/AL09rJYxYeMjbeCvdoK4VqjECpjFuRoHhx7N
	 LVYzD0KkNd1aSfQMX5dnWjqTzKNHTk4m/A0CQew965FZkV1m4Co8nRIJTGlMrqKNnQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4MHlyHVItVtlzhIHLyBRkkE26ccRvN9EoXk53YTA/ww=;
	b=cenVu3/0uuBVFHySkT12tIG+dRiBr82GXt8qcjWEHf7mQWQbkYwSWDp1ash1EqCmJTTV
	 UmeH3fsEdLxTOmQEoKAdDjKmNhNzuM2yxWnQvIEktupRCTThtIQSDTyDqOgCWugrfZHAF
	 fqjFUNUzUg0pwjw/3rM8lufn3X3FyOsDTobr7+wIQwi/GV/Z80Vm1e1OzextDQEHLHqgv
	 /q6BEHsC9Yp5m9/cx42zL49n7uKlblySIqk4YM4C49GVOGcbBvkaPFVEmF0C8OsVdrjly
	 y+1LiOjFFWqCBEf7pld7/bg54+LFt918RwkyIbsNQu+xGPqo+iKTMICXK5o1tEGSBHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443157;
	bh=4MHlyHVItVtlzhIHLyBRkkE26ccRvN9EoXk53YTA/ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JKtXM99beIMwMjDXjwbg7IFYv9NPTingtyoMoMCBdzgDKgrqlhO58B81tVCxb99pw
	 fTBZLj3xxiTf8n6eivjQhmvfK52vGlcbVbthmMrN4WrZChC42I4mk7//aWIbKqSqAT
	 yw4RsA1n0KyXEd1q2Av0SWwer/khe/tX94gnD9Giwg1a4ApGRjCLDAiPDACIhk/rxk
	 0zg42GZWtkCr2o4zjDJYR2HYnhRHAFlsGLpWsQLMEeE2btQ/wJdTDsFfkMz1vehdUT
	 lvWIIoABK/wJ64mOz9naSjdHpovlfsUoTYWkLUXAypRijJ5M40fkXFS9ni1SpeTSSC
	 n3X0RYcA+Q8zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48C5A605CF;
	Mon, 23 Nov 2026 14:12:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB539260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1AD280CE0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGsKG0BaY52g for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DD1780CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UJgyIZXI
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DD1780CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:12:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3272841F2; Mon, 23 Nov 2026 15:12:31 +0100 (CET)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135F683108
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 15:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36a315ed211so4255641eec.0
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 06:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795443142; x=1796047942; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4MHlyHVItVtlzhIHLyBRkkE26ccRvN9EoXk53YTA/ww=;
 b=UJgyIZXIeGgXj7VFihag2eGlEmF6Xa55zXIhuolThX2omS384lp2x2IOh/AkWZioK6
 MUkHrOf+45onKz2Kw3L+IBAC0HEr42+O5zcj3Bifqzo1LhrwY/7RntsOBvcmYYJqdy6t
 NFMhh3lp8Lql3LPtAGv/4TADScaDB9X743z+Js+2UZm6Evgyne3QQ/sh4J9Bn4b6zIr4
 iotYnT7HK+3dMXe0IQ0PmwNmfhS3fCnrAQ1wTDMKzA0YdX08balSwrRyISYJVw+3s2Yr
 eaZmLs8sKgqIKm9s6jMEXeda+jnmtDuz8X6PAZPOSW6VSVIUk1Q61qnc41gj9kpTQgaz
 0K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795443142; x=1796047942;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4MHlyHVItVtlzhIHLyBRkkE26ccRvN9EoXk53YTA/ww=;
 b=PkyWbtq/SgS7hOATN6C4z80qkyBkvE3zGCvTeUTX/UtvO7GK6VOKchz9F9tI0wUWxW
 QWxbOPomr6zBU6I8oi9Soy/5Pr6GBG3izEIn3hvRq7eJiQPeXu8i4Y+29oubHnWTptMs
 Xbw+lspv7snMk1mmFYmpgujFpPGFHsTHzLmXJmPgZd2X8Lvu8LknHLluG+znssAYQi4A
 iDIOjzYoozYphcfSgK7EG9wO7u3TG/j+9RX/0zQe7X2g5eHzTrmRJqjQz8ZN7aMTp/wJ
 KCjss6TuQdL4AGJsn1/IibgdNTEE7EHeCBkSrXuF1omHDZtybVSdJ/vVS0j0TIHSsMwT
 u/oQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFwDfxLg7w4x9cQSPE2JCbBYBvKkoDCX6l+QBgB0qx2xm2a1M8Ix9n/0Bm5qUeODJK+dNYxE9s=@lists.denx.de
X-Gm-Message-State: APuU4Z/JRhx6uLALfHMk+Q41DINE439Zkmb2KJZH5EZv+NKe7aFao7j3
 I7BoJWNCrwsc/jcP2sxeuBEK8zgyqreKL9xadAdNyimghKq8WcA2eFfPxXUZnj4QUIIi3wujb4t
 aoeGT5K93TX/p47JTwnuodbo2WnChCmk=
X-Gm-Gg: AZFdTZdZeq0qDre6oiyDVOzBHJUAKyS+LSxXfL4Dv1uxL5s04eZTrxcbOqm7k5FrAlB
 vVljugEJUCOI8Lrw//3yxMQXs8if9pyxNZPgpY5HsjethttpQKC1LFQs5psttv/Zz/1nMXmUvKe
 IaIb14dWD/WcdXCO4enA3AqMCUt/ffihW993/xfgkpUCTBGGbA5YQT3vouJVMa+GKLmIDEAopJ8
 Xqyql2aUHHWD9E8Bs1GhukE66voFbtZLm9l/ERppNgmioKChlLb4Eo9JSFxgAXnLJC5g1Ahu590
 IIGlceKIii4l4oY/W0GXsCCARoMjrYWCbBoJljdkyZ1s36StAs03KiSA9ayVjnoqCakNm8dp/Jn
 Tf4hQ0sW9LaeQA0rpdkHLyn/DlDhS3ek8iUC+UGEYts5OMExPiDAiX/g1wh0JuINvV9y9jAJg69
 gobEj6UTFbwCDRMjxS7AHnYvvi8Z4XOQ==
X-Received: by 2002:a05:693c:2181:b0:385:5ea7:73f with SMTP id
 5a478bee46e88-3856f94ed95mr13225012eec.7.1795443142190; Mon, 23 Nov 2026
 06:12:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
 <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
 <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
 <xhkdbse0rslbw.fsf@mkorpers-koolstof.csb>
 <CAPVz0n0yxcNWZEyZJUX6aeXYU3FX-9i2u=U=rbFFvZ9a-+xcLw@mail.gmail.com>
In-Reply-To: <CAPVz0n0yxcNWZEyZJUX6aeXYU3FX-9i2u=U=rbFFvZ9a-+xcLw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 23 Nov 2026 16:12:10 +0200
X-Gm-Features: Aa3M54p6-ANS5iCbaAAV6kkkXyVLuzkyA0j3HxBAKSZ-9tnXhQEMkzxmJpc7iPM
Message-ID: <CAPVz0n2WZH8XJ-snTcztvfG-eRcL0-D9=NNqFz1ptSAaneaVFg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:0=
5 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15=
:56 Mattijs Korpershoek <mkorpershoek@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Mon, Nov 23, 2026 at 14:37, Guillaume La Roque <glaroque@baylibre.co=
m> wrote:
> >
> > > Hi,
> > >
> > > Le 18/11/2026 =C3=A0 11:45, Svyatoslav Ryhel a =C3=A9crit :
> > >> =D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 12:44 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >>>>> You are mixing up. This patch does not add any vendor commands. I=
t
> > >>>>> allows using native commands with vendor quirks seamlessly.
> > >>>> I know it's not exactly the same thing. I'm just worried these ext=
ra
> > >>>> hooks will make stuff less maintainable in the long run.
> > >>>>
> > >>>>> For example. Tegra devices require bootloader and bct to be encry=
pted
> > >>>>> and bct to be updated every time bootloader is flashed.
> > >>>>>
> > >>>>> $ fastboot stage bootloader.img
> > >>>>> $ fastboot oem board:write_bootloader
> > >>>>>
> > >>>>> Used has to stage bootloader, then write is with some custom vend=
or
> > >>>>> bootloader flashing command which we have to make, document etc e=
tc.
> > >>>>>
> > >>>>> This series allows intercept native fastboot commands of flashing=
 some
> > >>>>> partitions and apply vendor specific adjustments directly. So I c=
an
> > >>>>> flash bootloader, boot and system with native command `fastboot f=
lash`
> > >>>>> but bootloader flashing will be performed with encryption and doe=
s not
> > >>>>> require from user any additional movements.
> > >>>> I understand, that it might be easier from a user experience point=
 of
> > >>>> view (just fastboot flash <whatever partition>)
> > >>>>
> > >>>> But adding extra vendor hooks also means having a specification of=
 what vendors
> > >>>> should do in these hooks: adding docstrings, adding documentation =
in the
> > >>>> fastboot.rst page and such.
> > >>>>
> > >>>> I'm not NACKING this series, I just wish to discuss in more detail=
 why
> > >>>> 'oem board' is a wrong idea.
> > >>>>
> > >>>> For example, do you have a closed-source userspace that forces you=
 to
> > >>>> use 'fastboot flash' on tegra devices?
> > >>>>
> > >>> On production tegra20 and tegra30 devices bootloader must be encryp=
ted
> > >>> with aes engine before flashing, and bct must be decrypted, updated
> > >>> and re-encrypted before flashing. We decided to use hardware boot
> > >>> partitions to store bct and bootloader, so we do not have tradition=
al
> > >>> boot partition. Hence we are using fastboot flash to intercept
> > >> boot > bootloader (typo)
> > >>
> > >>> "bootloader" or "ebt" and "bct" commands to flash partition and use
> > >>> our own implementations for them (for emmc and spi). All other
> > >>> partitions can be flashed by default and need no special handling.
> >
> > Ok, let's go ahead with this. It is indeed a more elegant solution on
> > the user side (just using fastboot flash <partition> and let U-Boot
> > handle complex cases (like bootloader/ebt/bct).
> >
>
> Perfect.
>
> > >
> > >    I'm rather ok with the patch and with intercepting the native flas=
h
> > >    command through hooks, it's already done this way elsewhere in fas=
tboot
> > >    (fb_nand.c, fb_spi_flash.c).
> >
> > Please also look at how it's done in fb_nand and fb_spi_flash to see if
> > we can have similar return codes (if that makes sense)
> >
>
> They return 0 while you asked for -ENOTSUPP
>
> > >
> > >    Some small comments for v2:
> > >
> > >    - board_fastboot_flash() returns 0 when not handled and
> > >      board_fastboot_get_part_info() returns 1, it would be nice to ha=
ve
> > >      the same value for both .
> > >
> > >    - When you rebase: flash() now starts with flashing_refuse_if_lock=
ed(),
> > >      please call the board hook after it, otherwise a locked device c=
an
> > >      still be flashed.
> > >
> > >    - A small update of the fastboot doc would be nice too.
> >
> > Please address Guillaume's feedback (as well as mine I posted
> > previously) for v2.
> >
> > Thanks for your patience
> >
> > Regards
> > Mattijs
> >
> > > Regards
> > > Guillaume

Oh, btw, Mattijs, Guillaume, you can check preliminary v2 in here [1]
if you like. It is not final yet though.

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-tegra/-/commits=
/staging?ref_type=3Dheads
