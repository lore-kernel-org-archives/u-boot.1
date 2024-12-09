Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E047E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 11:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA49896B2;
	Mon,  9 Dec 2024 12:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DSxRrXYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE5E896B3; Mon,  9 Dec 2024 12:43:13 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFB489534
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 12:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3d74363cbso3674842a12.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733744590; x=1734349390; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoDxHTvDAss3rfELk7p6q0Sx0mARo9tbI+NPvJd54xY=;
 b=DSxRrXYkccE0803v5WTsE48WIwzUJROkZsY928xvMIMCJyA8MKU+teWEIohnHxjBiQ
 hmReNLaJX3a/sBTSBuSq8Zp6J+fowV0RTVC0dr3xTgZDlkI+xkodaAinur0KLZCC2J4d
 gHQJulHbsnbE36A0adjnnR1YvsowkLyC0J1QQjJuWRxVnvT0s9KYJmZyVzygpNq/om5I
 M3Ob36iwMu2k1CJMHwXBbwdw5xArdXWu7HAZrPXDpQFZaocH9KlDV+z+ikwU2br/VXjg
 PQ80b2SWXxCdpcHj0ppadC4CO8nkrxaadj0ZZnSgeQzoabuJ8+1lE8UzU1HbxPdKyL6M
 i2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733744590; x=1734349390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoDxHTvDAss3rfELk7p6q0Sx0mARo9tbI+NPvJd54xY=;
 b=lZlNNJEJWeb4GhWV4sFgWR6LtiyzgcFRTkoVhSm1nlQmw6e60u1PRIOn6Ncem8EBwI
 zb8n6JTimUq+QFZWDmEN97CLAgRjsj8YOHXz5OhbM8yALMKllXkmuyDx1gE1sxCcgywu
 J5684G2tix6qbuIWJAYeKNBGh8SER1m39K3TNayYJ7vK7jMhS96zvh6Lhv1phCPhZrx0
 lKguUswP1I5WBMT1P+HEMzJU74F/SQYFimpLHEcKPXkc9jsKTQpZ+PF6BCp7q1uAEgNf
 A5vF5fZtH5R/uj6JR9FeMSRcoO4Q0wrGIS/nAcE/cEchN9GK4GX80N/r+vsANuU2bOwL
 k6Ng==
X-Gm-Message-State: AOJu0Yxrstm8Cxlc6wz3Vio9MurOW9DLI2Q/DW1+LnMfEIUc6sz1gq40
 x+jKOWFsxLeC7ZQoOJJugahVGDX3MnFIUNG7OU2dDVowyxwjN7H3hzlu/FG66chMPCh8FBeK7g1
 WTklqV3/hcNCudfPy3XC9Jh5G1RVX3LdmKQMNhw==
X-Gm-Gg: ASbGnctyuURYf2tBBC/CElTpOjTQJ+lisN0iGUeEf09PAWxzY59mEUz+gmE1QGXkL4c
 5Gs+kxr9bS4nCfWwnGn9fkd4Jdsyd1iIx
X-Google-Smtp-Source: AGHT+IFolKwzEFfdxeZaS3K+1lI9jlnAXaQyb5GlBlBV6Q1jjHkmOtRHDMqq90knIcWvSDarh2Eb/5rQ3QARxjTxHEQ=
X-Received: by 2002:a05:6402:2689:b0:5cf:e894:8de9 with SMTP id
 4fb4d7f45d1cf-5d4184f7b02mr345474a12.3.1733744590568; Mon, 09 Dec 2024
 03:43:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
 <CADg8p95bi5G48xZdT9+gqzKEByN4C3ZxfQHNPEaCX=0_559T9w@mail.gmail.com>
 <CAPLW+4nh2kxgV2ri=kkTD6pLjM2--aewZ4kMO8cjagv5OZCXUg@mail.gmail.com>
 <CADg8p94-8GXxWAOkgd1Y7AhXhxPJazy04PSnMrg687VigOZC+Q@mail.gmail.com>
In-Reply-To: <CADg8p94-8GXxWAOkgd1Y7AhXhxPJazy04PSnMrg687VigOZC+Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Dec 2024 17:12:59 +0530
Message-ID: <CADg8p97K3jX7-37tLNVb4K208eqnN8agBzhEMEnp2Nn3BqvKuw@mail.gmail.com>
Subject: Re: [REGRESSION] lmb: add and reserve memory above ram_top
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 9 Dec 2024 at 12:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sun, 8 Dec 2024 at 06:49, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > On Thu, Dec 5, 2024 at 11:23=E2=80=AFPM Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> > >
> >
> > [snip]
> >
> > > >     ERROR: reserving fdt memory region failed (addr=3Dbab00000
> > > > size=3D5500000 flags=3D2)
> > > >     ERROR: reserving fdt memory region failed (addr=3Df0000000
> > > > size=3D200000 flags=3D4)
> > > >
> > > > It looks like all mentioned error messages are harmless, in a way t=
hat
> > > > I'm still able to boot Linux, and U-Boot reserved areas still seem =
to
> > > > exist in 'bdinfo'. But seeing error messages like that is definitel=
y a
> > > > nuisance by itself, and might be an indicator of some actual issues=
.
> > > > Do you have any remedy for that by chance? Please let me know if yo=
u
> > > > need more debug input from my side.
> > >
> > > This seems to be happening because the board is trying to reserve
> > > memory above ram_top with no-map or no-overwrite attributes. To
> > > confirm, you can print the value of ram_top in setup_dest_addr().
> > >
> > > -sughosh
> > >
> >
> > Thanks for your input, Sughosh! I did a bit of further analysis, and
> > found the mentioned error message is happening on 3 different
> > occasions. All 3 of them are caused by the recent LMB patches merged
> > in U-Boot/master. They are all probably harmless, but a bit
> > misleading. Also, I'm not sure whether they are actually *causing*
> > those errors, or just revealing some already existing issues.
> > Specifically those 3 occurrences are:
>
> Thanks much for your investigation.
>
> >
> > 1. The one reported in this thread. The root cause, like you
> > suggested, is the board trying to reserve the memory above ram_top.
> > It's actually happening in lmb_init(). Details:
> >
> >   - The 'memory' node from my dts:
> >
> >         memory@80000000 {
> >             device_type =3D "memory";
> >             reg =3D <0x0 0x80000000 0x3ab00000>,
> >                   <0x0 0xc0000000 0x40000000>,
> >                   <0x8 0x80000000 0x80000000>;
> >         };
> >
> >   - Reserved memory chunk: (addr=3Df0000000 size=3D200000 flags=3D4).
> >     That's 'ramoops' chunk from the 'reserved-memory' node in my dts.
> >   - ram_top (as seen in lmb_init) =3D 0xbab0_0000.
> >     That's because my board's dram_init() calls the
> > fdtdec_setup_mem_size_base(), which only takes the first cell from the
> > 'memory' node.
> >     Which is 0x8000_0000 ... 0xbab0_0000.
> >   - So the reserved memory is above ram_top, as you suggested.
> >   - Not sure how to properly fix it though. Maybe I need to "teach"
> > U-Boot to use all 3 chunks from my 'memory' node somehow?
>
> I think there needs to be a check in the related function to not
> reserve memory regions above ram_top. This wasn't showing up earlier
> because of the local nature of the lmb memory map, but is not the case
> anymore. I have a patch which I am testing currently. Will send it out
> in a day or so.

This change should not be needed after your series gets applied.

>
> >   - I was able to work-around it by reworking the 'memory' node in my
> > device tree as described in my first message in this thread:
> >
> >         memory@80000000 {
> >             device_type =3D "memory";
> >             reg =3D <0x0 0x80000000 0x80000000>,
> >                   <0x8 0x80000000 0x80000000>;
> >         };
> >
> > 2. When booting Linux with 'booti' command, there happens the repeated
> > attempt to reserve all 'reserved-memory' chunks, which were already
> > reserved during the board init, which also leads to similar error
> > messages. I addressed that one (hopefully properly) in my series [1].
> > Please take a look. That one is caused by a combination of these two
> > commits:
> >
> >   - 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas
> > with !LMB_NONE")
> >   - 827dee587b75 ("fdt: lmb: add reserved regions as no-overwrite")
>
> I will try out your patch series on my side and get back.
>
> >
> > 3. I noticed another similar error message when running sandbox U-Boot =
on my PC:
> >
> >         $ make sandbox_defconfig
> >         $ make -j32
> >         $ ./u-boot -D
> >         ...
> >         ERROR: reserving fdt memory region failed (addr=3Dfffe000
> > size=3D2000 flags=3D2)
> >
> >   Can you please check that one on your U-Boot/master? I was able to
> > narrow it down to commit 6534d26ee9a5 ("lmb: do away with
> > arch_lmb_reserve()"), if that helps.
>
> This is strange. I have not seen this issue with sandbox earlier.
> Might be a regression. Will check. Thanks.

Same here. The issue goes away after this series.

-sughosh

>
> -sughosh
>
> >
> > Thanks!
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2024-December/574308.html
