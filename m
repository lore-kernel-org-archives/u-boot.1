Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEB8CE7A9B
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 16:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C5986B58;
	Mon, 25 Sep 2023 18:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oaKt/O/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0A186B3A; Mon, 25 Sep 2023 18:08:43 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07A486BCF
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 18:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so4493732a12.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695658120; x=1696262920; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nORrwcFZlLLoALoQ9jSYBln7sXRv177RGL5wU1AwEIw=;
 b=oaKt/O/RZqx1efmQaeFF9MtGAREiMhB3fbbH243fN4W6NOfH8VE5+wVrSB4GGW2jbO
 AE65xKWrsz56+7kDNiUAcEvFdD0UVwoMcRcLdj/4fUf1eRmeq3xqMR4xvqkSMcz3LPhS
 lqqqo0N1FRIMcNHxkbJyaKMaln6gNbtj7n22I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695658120; x=1696262920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nORrwcFZlLLoALoQ9jSYBln7sXRv177RGL5wU1AwEIw=;
 b=TFWGL2rmZCbDh3G6fzBpSDUASMgDp6Khzt0/oUwoLMpd0s56qU8ga5WTKUUORTQbkn
 sWKqhs/5MTdG3TtpgS0K3K6kpr31NXyQ9i0hIYUWUn7tOGa36eWZJ3Ruvi/UQvo7vYve
 GAY3zy7kRZsTSJOkCptFRtuhYQuF1D7xpgn/bXmGWeuQuGebJCQ1jEgM0cpCTMwPgn/m
 04g/UjFte6IeaXr0JRipdbY9NaULB7onEi5jBcyb5eV1LLaGbpCnGQt1sIf5ELBn+UhQ
 P0AbX4sInkppbIUDzwLJjZMb2bURGkxRZp+9gTNggrjze/72Up15WQA5X0Z1prWL3ji9
 Qwbg==
X-Gm-Message-State: AOJu0YyoZqyomXSxLcjxxCQarr2nXU/u3PY0K34PgtoJvMefTM02m9Ym
 44sIw/PRmqfMIyIsTgasYhDBNo5vQkITIw7Ivmn/bVWByV+JiT/qWDj1Jw==
X-Google-Smtp-Source: AGHT+IF64fg+z3qdGyPGNA5JDJIwT0GV+18ho9cujM+kW1xV07Rr++qE8YhOJh6cGbwb8wtjQjmc08YrI4Uw2AaNc5U=
X-Received: by 2002:a05:6402:5148:b0:532:e24d:34f4 with SMTP id
 n8-20020a056402514800b00532e24d34f4mr5952774edd.39.1695658119943; Mon, 25 Sep
 2023 09:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <20230823155558.GM3953269@bill-the-cat>
 <C098A4DC-CE20-4516-8971-B52041120BCD@gmail.com>
 <20230925150534.GA305624@bill-the-cat>
 <CAPVz0n1F7c7m0=CfLTF8n1Qx2B83nv73VJrUWNHoZJeoeAe_eQ@mail.gmail.com>
In-Reply-To: <CAPVz0n1F7c7m0=CfLTF8n1Qx2B83nv73VJrUWNHoZJeoeAe_eQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 10:08:23 -0600
Message-ID: <CAPnjgZ14Rusf5J0VUvcXpiT=i8wpk8_o2ZqamwQhbtsw4vNJNQ@mail.gmail.com>
Subject: Re: Config fragments
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi,

On Mon, 25 Sept 2023 at 09:12, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D0=BF=D0=BD, 25 =D0=B2=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 18:05 To=
m Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Sep 25, 2023 at 04:18:45PM +0300, Svyatoslav Ryhel wrote:
> > >
> > >
> > > 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 18:55:58 GMT+03:=
00, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> > > >On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:
> > > >
> > > >> Hi,
> > > >>
> > > >> Up until 2023.04 it has been possible to build all the defconfigs =
but
> > > >> with 2023.07 that changed. Tom mentioned this to me recently.
> > > >
> > > >I'm adding Svyatoslav who is the person that brought in all of the
> > > >config fragments that are going to be in v2023.07.
> > > >
> > > >> Up until 2023.04 we can enumerate all the board configs that can b=
e
> > > >> built. We can build any of them using a single name and a single
> > > >> defconfig. The boards.cfg file which buildman creates contains a f=
ull
> > > >> list of things that can be built.
> > > >>
> > > >> From 2023.07 this changes and we now have random .config files
> > > >> sprinkled about the place. I say random because they are not conne=
cted
> > > >> to anything. For example, here is
> > > >
> > > >They aren't random.  They're, just for v2023.07, in configs/ and the=
n
> > > >moving forward, they're in the board directory.  I would like to see
> > > >them in more places possibly, but that's not something I'm sure enou=
gh
> > > >on right now.
> > > >
> > > >> board/ti/am62x/MAINTAINERS:
> > > >>
> > > >> AM62x BOARD
> > > >> M: Dave Gerlach <d-gerlach@ti.com>
> > > >> M: Tom Rini <trini@konsulko.com>
> > > >> S: Maintained
> > > >> F: board/ti/am62x/
> > > >> F: include/configs/am62x_evm.h
> > > >> F: configs/am62x_evm_r5_defconfig
> > > >> F: configs/am62x_evm_a53_defconfig
> > > >>
> > > >> BEAGLEPLAY BOARD
> > > >> M:     Nishanth Menon <nm@ti.com>
> > > >> M:     Robert Nelson <robertcnelson@gmail.com>
> > > >> M:     Tom Rini <trini@konsulko.com>
> > > >> S:     Maintained
> > > >> N:     beagleplay
> > > >>
> > > >> In most cases the MAINTAINERS file tells us about each board and u=
ntil
> > > >> [1] I had assumed that was the case. With that patch reverted, the=
se
> > > >> are the only 'orphaned' MAINTAINERS entries (buildman
> > > >> --maintainer-check):
> > > >>
> > > >> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> > > >> ending at line 8
> > > >> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS end=
ing at line 44
> > > >> WARNING: orphaned defconfig in
> > > >> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> > > >> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending =
at line 6
> > > >> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending a=
t line 15
> > > >>
> > > >> But Tom advised me that MAINTAINERS is not intended for this purpo=
se,
> > > >> so the check has been dropped. I am not suggesting we bring it bac=
k,
> > > >> necessarily, but if we did, we could use it to specify the .config=
 and
> > > >> defconfig files which are used by each board.
> > > >
> > > >Note that the "N" syntax has been in use, for defconfigs for a lot
> > > >longer, and is why the CI check for unmaintained / orphaned boards
> > > >stopped working.
> > > >
> > > >> *Failing that*, I suggest a new 'name.brd' file in the board direc=
tory
> > > >> to contain this information, e.g.
> > > >>
> > > >> # Contents of board/ti/am62x/beagleplay.brd:
> > > >> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> > > >> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> > > >>
> > > >> This could be parsed by buildman and other tools, to produce a lis=
t of
> > > >> available boards and to build each using a single name (e.g. make
> > > >> beagleplay-r5_defconfig)
> > > >>
> > > >> What do people think?
> > > >
> > > >I'm not sure I like this direction honestly.  Do we want CI to cover
> > > >these configurations?  Maybe.  But it's just for CI.  Using the TI
> > > >examples, I don't know that you can use buildman today to generate a
> > > >functional binary (and if you can, if --keep will retain the right
> > > >files).
> > > >
> > > >Maybe we just need to make it clear that if you use config fragments
> > > >then you're opting out of CI for that specific platform.  That shoul=
d be
> > > >fine for example for the TI ones that will be built in OE a bunch
> > > >anyhow so accidental failure to builds will be caught.  I don't know
> > > >about the Tegra platforms.
> > > >
> > >
> > > Greetings! Are there any progress regards fragments move or this will
> > > hang in mailing list indefinitely?
> >
> > I don't follow, sorry.  Yes, please send a patch on top of next to move
> > the fragments for Tegra platforms to match how they're done for TI
> > platforms now.
> >
> > --
> > Tom
>
> Oh, so it was merged already into next, sorry did not check the next bran=
ch.
> Tegra fragments move patch was already sent a month ago alongside
> other board improvements, waiting for Thierry now. Thanks!

Re dealing with fragments, we have a proposal as above, but I have not
seen any other comments.

I believe this needs to be figured out soon.

Regards,
Simon
