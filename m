Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB9E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 01:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC7A801FE;
	Wed, 11 Dec 2024 02:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QquiEIYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158968020B; Wed, 11 Dec 2024 02:38:52 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635EA801EA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ef66fd2183so56780727b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733881128; x=1734485928; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycT5dT9quP1jyJZovxUeJMo8G9HTRaiuYRe/qL7vur4=;
 b=QquiEIYvYbFIQH4p+ZUmvUJ+X8mCpZkTPLTTMkU2Cp/NDmGLR/rk2286oGHsAXtXOY
 LDFmcb3wi0y2mleeeXnWT3yX+AC9rFdt4qkGeq9Ek5pTBCx1vx+F5easFDaf8w+C+wcM
 n0qR99q/oyGjyOqBqEUdMXd4YPhpcnSIjVH11F8KgTQ9H4eSLy6/KtAeqFiHFiPKyZrz
 MaKemtdSkS2JMoJpzWswUcInQ3noR1AncIGbiec6/NDD28v6Kn7IK8juZZKlPGbEeEP3
 Z5kGWxX8Uv2nPwsBbLvAmJqdO8Km0PJuWjJhsn0cPq8ec4QjUlZ77zf+ISPUc7V1vgPO
 lBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733881128; x=1734485928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycT5dT9quP1jyJZovxUeJMo8G9HTRaiuYRe/qL7vur4=;
 b=ZGdvc2yTqzP9nbFYidaX7lI/DvrqZUk0PFzwHuDKVmlHETh2mhe8j3L1Y0vwRwWZ5e
 Q8OnUF9N2pDrPzcSnMHM/GkJWtGcTpubVa9Vz2uPI0XEI/dLJD65/7VhzqM0gRbONFhm
 0dZeBYNsDbUoVVgbjiMUqHAP+rFUf30hHjIHYuFRuwXUapd6jGS3tViLGJH6s34j3LFi
 ut4kh+dIq4tOpe+6n4XfrVWgF5RL24TXuCRouiVVT8B+LMhy0BFNidG5Oi6MC5+D4sa2
 1FWTRQL2a7cTEhXnpR95JySPqtmMTD5sp3D2F/bjKkN+1t6oUSVgPLoI5aZJslQrIk0I
 f9jQ==
X-Gm-Message-State: AOJu0YyEaa6hx8OTJBvch+TE73WDvTx7y+SvTFq7EaxGN6P95rUgGkvy
 r/0o1e6KkhQknCCG9bLnkefcTrPdb0lKt1NenHEh3SsVFiGElGFzpPLBZo4n1xu4a8zseDVg61Q
 0gdzw4nJZl7m2jlOd2w56ifHnY8odNd3LA0jQOQ==
X-Gm-Gg: ASbGnctxZu25awb6rjkL07nE3nq5mFBqd0pLjJIGpDDH6siLSuqfKmkenMifDxdQ7cZ
 S7tOdSPB4Ynu5RR+Vy96AayjN7is7QJxXTlQ=
X-Google-Smtp-Source: AGHT+IExztQmewKNLt6mEji74l/n0DnpmwpSEDe2THNQhVx6whABSwS1rfgymqk1M184f6kiKFtU7cntHcFMitxoZWY=
X-Received: by 2002:a05:690c:c14:b0:6ee:7012:d72 with SMTP id
 00721157ae682-6f148044433mr15803297b3.38.1733881128190; Tue, 10 Dec 2024
 17:38:48 -0800 (PST)
MIME-Version: 1.0
References: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
 <CADg8p95bi5G48xZdT9+gqzKEByN4C3ZxfQHNPEaCX=0_559T9w@mail.gmail.com>
 <CAPLW+4nh2kxgV2ri=kkTD6pLjM2--aewZ4kMO8cjagv5OZCXUg@mail.gmail.com>
 <CADg8p94-8GXxWAOkgd1Y7AhXhxPJazy04PSnMrg687VigOZC+Q@mail.gmail.com>
 <CADg8p97K3jX7-37tLNVb4K208eqnN8agBzhEMEnp2Nn3BqvKuw@mail.gmail.com>
In-Reply-To: <CADg8p97K3jX7-37tLNVb4K208eqnN8agBzhEMEnp2Nn3BqvKuw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 10 Dec 2024 19:38:34 -0600
Message-ID: <CAPLW+4knkV21yYKP0nbgW_GF7-aUMdTwtL7D-4-2XJfM+AfCGQ@mail.gmail.com>
Subject: Re: [REGRESSION] lmb: add and reserve memory above ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, Dec 9, 2024 at 5:43=E2=80=AFAM Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
>
> On Mon, 9 Dec 2024 at 12:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote=
:
> >
> > On Sun, 8 Dec 2024 at 06:49, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
> > >
> > > On Thu, Dec 5, 2024 at 11:23=E2=80=AFPM Sughosh Ganu <sughosh.ganu@li=
naro.org> wrote:
> > > >
> > >
> > > [snip]
> > >
> > > > >     ERROR: reserving fdt memory region failed (addr=3Dbab00000
> > > > > size=3D5500000 flags=3D2)
> > > > >     ERROR: reserving fdt memory region failed (addr=3Df0000000
> > > > > size=3D200000 flags=3D4)
> > > > >
> > > > > It looks like all mentioned error messages are harmless, in a way=
 that
> > > > > I'm still able to boot Linux, and U-Boot reserved areas still see=
m to
> > > > > exist in 'bdinfo'. But seeing error messages like that is definit=
ely a
> > > > > nuisance by itself, and might be an indicator of some actual issu=
es.
> > > > > Do you have any remedy for that by chance? Please let me know if =
you
> > > > > need more debug input from my side.
> > > >
> > > > This seems to be happening because the board is trying to reserve
> > > > memory above ram_top with no-map or no-overwrite attributes. To
> > > > confirm, you can print the value of ram_top in setup_dest_addr().
> > > >
> > > > -sughosh
> > > >
> > >
> > > Thanks for your input, Sughosh! I did a bit of further analysis, and
> > > found the mentioned error message is happening on 3 different
> > > occasions. All 3 of them are caused by the recent LMB patches merged
> > > in U-Boot/master. They are all probably harmless, but a bit
> > > misleading. Also, I'm not sure whether they are actually *causing*
> > > those errors, or just revealing some already existing issues.
> > > Specifically those 3 occurrences are:
> >
> > Thanks much for your investigation.
> >
> > >
> > > 1. The one reported in this thread. The root cause, like you
> > > suggested, is the board trying to reserve the memory above ram_top.
> > > It's actually happening in lmb_init(). Details:
> > >
> > >   - The 'memory' node from my dts:
> > >
> > >         memory@80000000 {
> > >             device_type =3D "memory";
> > >             reg =3D <0x0 0x80000000 0x3ab00000>,
> > >                   <0x0 0xc0000000 0x40000000>,
> > >                   <0x8 0x80000000 0x80000000>;
> > >         };
> > >
> > >   - Reserved memory chunk: (addr=3Df0000000 size=3D200000 flags=3D4).
> > >     That's 'ramoops' chunk from the 'reserved-memory' node in my dts.
> > >   - ram_top (as seen in lmb_init) =3D 0xbab0_0000.
> > >     That's because my board's dram_init() calls the
> > > fdtdec_setup_mem_size_base(), which only takes the first cell from th=
e
> > > 'memory' node.
> > >     Which is 0x8000_0000 ... 0xbab0_0000.
> > >   - So the reserved memory is above ram_top, as you suggested.
> > >   - Not sure how to properly fix it though. Maybe I need to "teach"
> > > U-Boot to use all 3 chunks from my 'memory' node somehow?
> >
> > I think there needs to be a check in the related function to not
> > reserve memory regions above ram_top. This wasn't showing up earlier
> > because of the local nature of the lmb memory map, but is not the case
> > anymore. I have a patch which I am testing currently. Will send it out
> > in a day or so.
>
> This change should not be needed after your series gets applied.
>
> >
> > >   - I was able to work-around it by reworking the 'memory' node in my
> > > device tree as described in my first message in this thread:
> > >
> > >         memory@80000000 {
> > >             device_type =3D "memory";
> > >             reg =3D <0x0 0x80000000 0x80000000>,
> > >                   <0x8 0x80000000 0x80000000>;
> > >         };
> > >
> > > 2. When booting Linux with 'booti' command, there happens the repeate=
d
> > > attempt to reserve all 'reserved-memory' chunks, which were already
> > > reserved during the board init, which also leads to similar error
> > > messages. I addressed that one (hopefully properly) in my series [1].
> > > Please take a look. That one is caused by a combination of these two
> > > commits:
> > >
> > >   - 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory area=
s
> > > with !LMB_NONE")
> > >   - 827dee587b75 ("fdt: lmb: add reserved regions as no-overwrite")
> >
> > I will try out your patch series on my side and get back.
> >
> > >
> > > 3. I noticed another similar error message when running sandbox U-Boo=
t on my PC:
> > >
> > >         $ make sandbox_defconfig
> > >         $ make -j32
> > >         $ ./u-boot -D
> > >         ...
> > >         ERROR: reserving fdt memory region failed (addr=3Dfffe000
> > > size=3D2000 flags=3D2)
> > >
> > >   Can you please check that one on your U-Boot/master? I was able to
> > > narrow it down to commit 6534d26ee9a5 ("lmb: do away with
> > > arch_lmb_reserve()"), if that helps.
> >
> > This is strange. I have not seen this issue with sandbox earlier.
> > Might be a regression. Will check. Thanks.
>
> Same here. The issue goes away after this series.
>

You are right, I just confirmed it on my end. With Ilias's suggestion,
all 3 error messages are gone. I'll send v2 soon. Thanks for noticing
that!

> -sughosh
>
> >
> > -sughosh
> >
> > >
> > > Thanks!
> > >
> > > [1] https://lists.denx.de/pipermail/u-boot/2024-December/574308.html
