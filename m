Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF8CE77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 06:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A235893A2;
	Mon,  9 Dec 2024 07:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jR/QtXV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98338893A7; Mon,  9 Dec 2024 07:42:24 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131D08939E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 07:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso1976018a12.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 22:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733726541; x=1734331341; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGSdsbGODy3hHPAQWWzs8+9fz00ZoJdu4T45zOZaAag=;
 b=jR/QtXV5+Q0OMrSWLMxQ/Zwmsdx4qqnKpHtTB+mQHQMTzOsq++8FaMPekt6zXP64L8
 iqh+Id9BZMY8QiWKSFHhbMBLd3s4yD9AVklL/G3Q5U5pqdZ7t0pUdyTFZyBqt/0roNG8
 2UJ8q2qrzxrsJ0l0v2EdbQRW88GsBJ7sqP9Z2+tQNU6AAWiYNAVzJeWoPN3wNhc77zxp
 4a2FuAUqvgcFT29tdev7puSWKAchIGVL9ZsWX2bXiczvlUfuK6NWc22u3pBPUVvgIMyB
 0PqZ+SOKMKP7nvzrI7yI2udGSEMuMIiiQ7Kzi3QTitaafZL6QTkOgI2BfkCTN9FFVT55
 03aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726541; x=1734331341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGSdsbGODy3hHPAQWWzs8+9fz00ZoJdu4T45zOZaAag=;
 b=PR+F04GPcVHAhgLuW9D451ZUWE56YnJKUwulOaMJnt4sblQA6oxHVgG1VDo4nfCYP1
 forBX6vGwR3vqerNkMJVIM2hwV5il3wv7P6IWO/+dcbSM5al8mJ1iDNHFW2efVFg1AwN
 2ZFgy8U52Hm4JwEUrE9Qv//B+KfjlVxi2f+BuHRDhBziTNDqXgCHqK5SK4y/TvscV95X
 //9/n2nrJYw7XSFZJSyVDP0X6J/S8u1N25zhTA7MObw2CvmtDbNdBdSeHKIjuYh5L8Nu
 nxgvR38V1yU7s6tXOklqBZ2ROQhN1faslFFIeUra2VvV/6UUw4rgscMvugHqROcxDs6z
 tzyg==
X-Gm-Message-State: AOJu0Yxs6iloIgY70vpK1mP4z+CgtU15FHe/vpU3FN/wUCNAsbE8wj+F
 Qc4VqEj87Nj6eBHSs7p4aZHvTT9QRSiZEWpPPAI7+7gXEKeTWJHVPq/qK2NWXDX2Z6qVWd4oKop
 JsYQ03ELZxWtgw98PNzeaM7CadClhSG6Wu/oH3A==
X-Gm-Gg: ASbGncvThNCHc/Td9Ig17ZE1vSO0RYSaERqpf1YoYZR4LBzNyRxhHQu+O9fdmKiVOBx
 zvwsnYqIO8gG0SiyRKMk/haPdOUgujhg6
X-Google-Smtp-Source: AGHT+IFyoc4Ca8VWh07RtnHcSEWfdfc481s04GArQcDlRKYy2Mds1wb2tQtYm+zHknW/SPwwG/kChmyhig+XKzn87DI=
X-Received: by 2002:a05:6402:3891:b0:5d0:e2c8:dc8d with SMTP id
 4fb4d7f45d1cf-5d3be6b3ab4mr10957074a12.20.1733726541414; Sun, 08 Dec 2024
 22:42:21 -0800 (PST)
MIME-Version: 1.0
References: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
 <CADg8p95bi5G48xZdT9+gqzKEByN4C3ZxfQHNPEaCX=0_559T9w@mail.gmail.com>
 <CAPLW+4nh2kxgV2ri=kkTD6pLjM2--aewZ4kMO8cjagv5OZCXUg@mail.gmail.com>
In-Reply-To: <CAPLW+4nh2kxgV2ri=kkTD6pLjM2--aewZ4kMO8cjagv5OZCXUg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Dec 2024 12:12:10 +0530
Message-ID: <CADg8p94-8GXxWAOkgd1Y7AhXhxPJazy04PSnMrg687VigOZC+Q@mail.gmail.com>
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

On Sun, 8 Dec 2024 at 06:49, Sam Protsenko <semen.protsenko@linaro.org> wro=
te:
>
> On Thu, Dec 5, 2024 at 11:23=E2=80=AFPM Sughosh Ganu <sughosh.ganu@linaro=
.org> wrote:
> >
>
> [snip]
>
> > >     ERROR: reserving fdt memory region failed (addr=3Dbab00000
> > > size=3D5500000 flags=3D2)
> > >     ERROR: reserving fdt memory region failed (addr=3Df0000000
> > > size=3D200000 flags=3D4)
> > >
> > > It looks like all mentioned error messages are harmless, in a way tha=
t
> > > I'm still able to boot Linux, and U-Boot reserved areas still seem to
> > > exist in 'bdinfo'. But seeing error messages like that is definitely =
a
> > > nuisance by itself, and might be an indicator of some actual issues.
> > > Do you have any remedy for that by chance? Please let me know if you
> > > need more debug input from my side.
> >
> > This seems to be happening because the board is trying to reserve
> > memory above ram_top with no-map or no-overwrite attributes. To
> > confirm, you can print the value of ram_top in setup_dest_addr().
> >
> > -sughosh
> >
>
> Thanks for your input, Sughosh! I did a bit of further analysis, and
> found the mentioned error message is happening on 3 different
> occasions. All 3 of them are caused by the recent LMB patches merged
> in U-Boot/master. They are all probably harmless, but a bit
> misleading. Also, I'm not sure whether they are actually *causing*
> those errors, or just revealing some already existing issues.
> Specifically those 3 occurrences are:

Thanks much for your investigation.

>
> 1. The one reported in this thread. The root cause, like you
> suggested, is the board trying to reserve the memory above ram_top.
> It's actually happening in lmb_init(). Details:
>
>   - The 'memory' node from my dts:
>
>         memory@80000000 {
>             device_type =3D "memory";
>             reg =3D <0x0 0x80000000 0x3ab00000>,
>                   <0x0 0xc0000000 0x40000000>,
>                   <0x8 0x80000000 0x80000000>;
>         };
>
>   - Reserved memory chunk: (addr=3Df0000000 size=3D200000 flags=3D4).
>     That's 'ramoops' chunk from the 'reserved-memory' node in my dts.
>   - ram_top (as seen in lmb_init) =3D 0xbab0_0000.
>     That's because my board's dram_init() calls the
> fdtdec_setup_mem_size_base(), which only takes the first cell from the
> 'memory' node.
>     Which is 0x8000_0000 ... 0xbab0_0000.
>   - So the reserved memory is above ram_top, as you suggested.
>   - Not sure how to properly fix it though. Maybe I need to "teach"
> U-Boot to use all 3 chunks from my 'memory' node somehow?

I think there needs to be a check in the related function to not
reserve memory regions above ram_top. This wasn't showing up earlier
because of the local nature of the lmb memory map, but is not the case
anymore. I have a patch which I am testing currently. Will send it out
in a day or so.

>   - I was able to work-around it by reworking the 'memory' node in my
> device tree as described in my first message in this thread:
>
>         memory@80000000 {
>             device_type =3D "memory";
>             reg =3D <0x0 0x80000000 0x80000000>,
>                   <0x8 0x80000000 0x80000000>;
>         };
>
> 2. When booting Linux with 'booti' command, there happens the repeated
> attempt to reserve all 'reserved-memory' chunks, which were already
> reserved during the board init, which also leads to similar error
> messages. I addressed that one (hopefully properly) in my series [1].
> Please take a look. That one is caused by a combination of these two
> commits:
>
>   - 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas
> with !LMB_NONE")
>   - 827dee587b75 ("fdt: lmb: add reserved regions as no-overwrite")

I will try out your patch series on my side and get back.

>
> 3. I noticed another similar error message when running sandbox U-Boot on=
 my PC:
>
>         $ make sandbox_defconfig
>         $ make -j32
>         $ ./u-boot -D
>         ...
>         ERROR: reserving fdt memory region failed (addr=3Dfffe000
> size=3D2000 flags=3D2)
>
>   Can you please check that one on your U-Boot/master? I was able to
> narrow it down to commit 6534d26ee9a5 ("lmb: do away with
> arch_lmb_reserve()"), if that helps.

This is strange. I have not seen this issue with sandbox earlier.
Might be a regression. Will check. Thanks.

-sughosh

>
> Thanks!
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-December/574308.html
