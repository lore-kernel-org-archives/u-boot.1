Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0413E748F8
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 16:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB8E870DE;
	Mon,  2 Oct 2023 18:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oeyj+pC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2927587138; Mon,  2 Oct 2023 18:22:10 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9C386B71
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a1f00b75aaso86913887b3.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696263726; x=1696868526; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DG32DpV5oHYowxmuBtrUy3SbMM4H73bSrJ7NRWzwxSM=;
 b=oeyj+pC7QSqqHJ8Z0rTEDta3rNb1y2/Lo4oQ2tJL3eidX8W/K75Xg+KRIZx/HizOLc
 /2md6WO7e7XAVWEjuqoPrNvdD8tTUpruPxjCd8PuQKG9P31VoDZORAlxD4NLYzREMc/5
 OqpSjzP4uBxr1KoOSXnTVxUVEwvK2ilyVSrWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696263726; x=1696868526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DG32DpV5oHYowxmuBtrUy3SbMM4H73bSrJ7NRWzwxSM=;
 b=JgvsngL9HxYiqYVwYJRcRqvYylivhqPERE1epU2/Uxuvu5eLv3wL/p3/ClIIX2GFuT
 RFwJXp2bggVwAGdGiPcxiYGyrnPEqyVgh+VLAXCwjTy7XtUh3Du4JOdTrPLFMYCvOrrG
 +EUsDqg/ddbZaFIl9PCVY3Ctnp/gnIGdGS4gN+c3jKmgzw2bvrUiSgWMQp/z+5nGIt71
 TfPf51ccHqyjVNA6KA0okw5YHtsr0BOYfrpGorcmX0l+gVyhpPVmlk75F2u9KmcO0VRZ
 4Bvewo1xKYYG4BInI0q75Yhtni7yAerHu8F5BE5JprwjQzs7jHu9A45EjkpKH7TrP3Fz
 g3zw==
X-Gm-Message-State: AOJu0YxblCNYQzb+7mhxjcp/npkRpwCr4aWdPSrh9pq1prozPP/zopno
 uPpKcJiFMJjur/q9P/GYLIvxmg==
X-Google-Smtp-Source: AGHT+IGWJjs3xFQcht7MC2YdAgywV3DqgjYnD4/q/S9SkaOjN//iFgrCUZRey6PKLUWOOXI+4JV0Zw==
X-Received: by 2002:a81:df11:0:b0:59b:dbb7:5c74 with SMTP id
 c17-20020a81df11000000b0059bdbb75c74mr10531475ywn.32.1696263726267; 
 Mon, 02 Oct 2023 09:22:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 v134-20020a81488c000000b00570253fc3e5sm7758124ywa.105.2023.10.02.09.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 09:22:05 -0700 (PDT)
Date: Mon, 2 Oct 2023 12:22:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Message-ID: <20231002162203.GZ305624@bill-the-cat>
References: <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
 <20231002140854.GU305624@bill-the-cat>
 <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
 <20231002151212.GY305624@bill-the-cat>
 <CAPnjgZ1fZjxTi8ryiVZC=Js1MDfP+PdGbJK87BA_kJe52d038w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UNgvQx8Ld3LqhcgK"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1fZjxTi8ryiVZC=Js1MDfP+PdGbJK87BA_kJe52d038w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--UNgvQx8Ld3LqhcgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 09:39:18AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Oct 2023 at 09:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 02, 2023 at 08:43:41AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 2 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Oct 01, 2023 at 07:17:27PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > > > > > > Hi Rasmus,
> > > > > > >
> > > > > > > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > > > > > > <rasmus.villemoes@prevas.dk> wrote:
> > > > > > > >
> > > > > > > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > > > > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoe=
s wrote:
> > > > > > > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > > > > > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > > > > > > >>
> > > > > > > > >>>> The one last problem now is on stm32mp15_dhcor_basic w=
hich is a
> > > > > > > > >>>> defconfig missing one from OF_LIST but including it in=
 the its file, so
> > > > > > > > >>>> the above is the patch we need.
> > > > > > > > >>>>
> > > > > > > > >>
> > > > > > > > >> Hi Tom
> > > > > > > > >>
> > > > > > > > >> Can I persuade you to try something like
> > > > > > > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b=
9103542a1076f9cab0005f400fa072
> > > > > > > > >> again, but leaving the .dtbo targets in there?
> > > > > > > > >>
> > > > > > > > >> I could send a patch, but it's entirely mechanical, and =
not really meant
> > > > > > > > >> for being applied until we know if there's more to be cl=
eaned up.
> > > > > > > > >
> > > > > > > > > So what ended up being the problem I think is the case Si=
mon pointed out
> > > > > > > > > where we do take the output from "make all" and concatena=
te one of the
> > > > > > > > > dtbs that was generated with u-boot.img or so, and it wor=
ks.  But maybe
> > > > > > > > > that should just list all of the valid DTBs that it needs=
 in the
> > > > > > > > > defconfig to start with? I don't quite know, it was a cas=
e I hadn't
> > > > > > > > > considered at the time.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Re-reading the thread, I can't see where that was mentioned.
> > > > > > > >
> > > > > > > > But yes, if some boards (still) need that, and have more th=
an one
> > > > > > > > possible .dtb, the board can't set an OF_LIST different fro=
m the default
> > > > > > > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST =
requires
> > > > > > > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > > > > > > >
> > > > > > > > How do we figure out if such boards even exist?
> > > > > > >
> > > > > > > Honestly at this point I've forgotten what this is all about.
> > > > > > >
> > > > > > > Perhaps the easiest approach is to create a new Kconfig to co=
ntrol
> > > > > > > whether a board-level .dtsi is included in the list of wildca=
rd
> > > > > > > searches. Then you can enable it for your board without affec=
ting
> > > > > > > others.
> > > > > >
> > > > > > That's getting things backwards, from what this cleanup does.  =
Today we
> > > > > > have messy lists of "build these device trees" and then don't u=
se most
> > > > > > of them, and some of the list is just Wrong (listing dts files =
as an
> > > > > > output).  With the series to handle dtbo files, we could remove
> > > > > > virtually all of that, and the only use cases that don't Just W=
ork still
> > > > > > are the ones I forget which board you mentioned (I think it was=
 Samsung
> > > > > > tho?) where the defconfig doesn't list all of the device trees,=
 just one
> > > > > > of them, and the other 5 that we build can also be easily used.=
  Does
> > > > > > that ring a bell?
> > > > >
> > > > > Yes it does...but what is the problem here?
> > > >
> > > > Messy and unused and incorrect Makefile content.
> > >
> > > The problem I see there is people using TARGET in
> > > arch/arm/dts/Makefile for example. There are 80 instances of that. The
> > > rules should depend on SoC (e.g. use ARCH_EXYNOS5), as Linux does it.
> >
> > It shouldn't be there at all since there's almost no cases where we
> > "just" take an arbitrary dtb file and u-boot.img and then the system
> > boot.  That's what this series is about fixing.
>=20
> I'm really not sure that replacing build rules with a board CONFIG is
> a good idea. I suppose part of my confusion is why the Makefile is
> considered a problem?

Because it's duplicative and as Rasmus points out, often wrong.

> > > > > The DT files for an SoC are supposed to be buildable without need=
ing
> > > > > to have the context of a particular board.
> > > >
> > > > They're still buildable, without an explicit rule, they just need to
> > > > (like they can now) be built explicitly.
> > >
> > > But isn't that creating dead code? It will rot.
> >
> > No, that's the problem we have today, people list something in the
> > Makefile, since they think they need to list something, and then put the
> > device trees they use in the defconfig.
>=20
> If they don't list something, it won't build, right?

No, everyone builds fine since CONFIG_DEFAULT_DEVICE_TREE is pretty much
always set.  And for run time, if we need more, *OF_LIST gets set.

> > [snip]
> > > > > I am find with making the boards list the DTs that they can run w=
ith,
> > > > > if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just=
 for
> > > > > SPL, I think.
> > > >
> > > > Yes, every board except for some use case you've described before a=
s far
> > > > as I know lists the device trees that they use in the defconfig.  W=
hich
> > > > is why there's an impetus to clean up arch/*/dts/Makefile as 95% of
> > > > those lines can just be removed.
> > >
> > > It seems like you are wanting a board-level CONFIG which lists the DTs
> > > which need to be built for that board. Is that right? You are
> > > suggesting that this already exists, but I am not aware of it. Do you
> > > mean SPL_OF_LIST, perhaps?
> >
> > I mean today CONFIG_DEFAULT_DEVICE_TREE + CONFIG_OF_LIST +
> > CONFIG_SPL_OF_LIST is set and correct for everyone board except some use
> > case you have, which I think is something about exynos?  And so we only
> > need scripts/Makefile.dts in arch/*/dts/Makefile
>=20
> Yes exynos5 boards (the original reason for DT) have / had the same
> u-boot-nodtb.bin and you can add the DT you want to boot it on
> particular hardware. That is one of the goals of DT.

Yes, but "and you concat the two files" isn't common.  We _can_ keep the
EXYNOS list, if that's actually being used.  But most of that list is
not, as far as I can tell, because the flow is "U-Boot binarie(s) + DTB
files + stuff" to get the correctly formatted blob for the firmware.

> The OF_LIST option is a little vague but I think it means that the DTs
> are packaged into a FIT in u-boot.img - is that right? But they
> presumably have to be built first.

No, they don't have to be built first because scripts/Makefile.dts
ensures that we build everything in *OF_LIST.

--=20
Tom

--UNgvQx8Ld3LqhcgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUa7iUACgkQFHw5/5Y0
tyzEuwwAtN5pr9oTYOKjBTnLimFcMhj3h0Rb4j4+eoX/t9r2zLp5/DEJ4VpoM+fO
HTQgT/tp1SZp7YCN9lgiWGe+gNOyDDeNX9/z8jokfK/LlG28FSdSVWt8ndpEkk/0
ODrmkuWBQ5aOeYuGGc360SOFW2M1XYT1CXaY1qiKjuA8sfnBvjs9Tgde6nCbWt43
vFaIQsYYr9yS/QyAQP8dzWg8mgal6CnqNWutDqGZl0envTv2OPmpMdKRoPYzsJCL
nhrVzpBcpx1JDJXhFotW4jvvJYYyyy79VzL1hpqSzWAZfqeeJZtlEbMJ1YoP+S10
CsCM9YeEgo6gt8PgGGHWfJ11F6SOnZc4RZqERdVoh/tv7J06v75/5vO64o5OgXmF
qmAV8FFQdzbVKnDB2gpzDBUr8BfGias5Z6+tDekiPpaUJcqcg74G88f2nZC5oftN
gTvayvQhkhsq3kgARKmo/+UvQ/YCGhqkXkmYr19cSwzh7USGmZ4leHulV7s8kxtp
1J9Awk/5
=CM9D
-----END PGP SIGNATURE-----

--UNgvQx8Ld3LqhcgK--
