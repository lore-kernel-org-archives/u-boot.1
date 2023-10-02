Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28BAE784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E78886DFD;
	Mon,  2 Oct 2023 17:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e0aF/jQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4887786E03; Mon,  2 Oct 2023 17:12:19 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFAD86DF0
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a2478862dbso31739707b3.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696259535; x=1696864335; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KroatL7qSFbbRJefbD6amTI3Dul1CXnNTQdMfLFGNnU=;
 b=e0aF/jQyBtSXlFtfxybVJFQGExsYDgJaxoCj63ODoWtf5TuejiohmYBmZ1AMD2oexx
 smd5tbaQYVY+UOYp9P6j90YbqRrRdrULU702f3NSW8rsOSmVLUV/Jq6PVi+n0NHNVgpR
 dAS/lPz+T0ojJJv9+OGHoOJOjH6+deBK7LpTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696259535; x=1696864335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KroatL7qSFbbRJefbD6amTI3Dul1CXnNTQdMfLFGNnU=;
 b=IQM0vm4P7uFPEJIGPVd8DGCHKxFYMX8tMw5bpZhCXoimkWPcMDpaa3Wfzz4Qt2npQC
 8UHFCUsFqiWeVbCkq3DEG2mP25zpAqj8vdW/S3qNaGAz6NIge4OM2Jt4ZcshYLVNy7Jg
 aATHHIcZZtM5QQw1Ig5E5atL8V4Ktr0In6KzoqEUvryYtu7n9Pjd6Wj4oZrLPOs38kr1
 yrqmPAsIsWTC6lEdd4B4ADB9cogcgiJxUSonBnw1UM4Y6T3+X2uKxZ6EKmm7mxxdhqUq
 I3w0Vax2R2+r8uRKfki43E4taRYEbzRDkjHO1S+mg8VApWbN7Q0eiXoQRumAdxP1Js+5
 4rBA==
X-Gm-Message-State: AOJu0YyhRa/nJUqd0AeTUzcrFB3b9rgP+uQ8D/BPPe7PO+9TGXlL9OwX
 PqH11BrUEUV3T7g3XX3E1pmq/g==
X-Google-Smtp-Source: AGHT+IEvilG07cWfhf1vxrm3FPnhA6NuhP4F6dy8O48OcMyxAHBkmZRn+Td6KbNuLOZKJVYC8UXTpA==
X-Received: by 2002:a81:6006:0:b0:59b:ec10:915e with SMTP id
 u6-20020a816006000000b0059bec10915emr11542298ywb.30.1696259535390; 
 Mon, 02 Oct 2023 08:12:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 j128-20020a0dc786000000b00592a065e2a3sm7814718ywd.87.2023.10.02.08.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 08:12:14 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:12:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Message-ID: <20231002151212.GY305624@bill-the-cat>
References: <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
 <20231002140854.GU305624@bill-the-cat>
 <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pJ8bPbEsMN4Hxm+a"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0TTNCEUHfHDr7tALx+Po9PDoD-R7zYeN2gc4wnkWqSzw@mail.gmail.com>
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


--pJ8bPbEsMN4Hxm+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 08:43:41AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 01, 2023 at 07:17:27PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > > > > Hi Rasmus,
> > > > >
> > > > > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > > > > <rasmus.villemoes@prevas.dk> wrote:
> > > > > >
> > > > > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wr=
ote:
> > > > > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > > > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > > > > >>
> > > > > > >>>> The one last problem now is on stm32mp15_dhcor_basic which=
 is a
> > > > > > >>>> defconfig missing one from OF_LIST but including it in the=
 its file, so
> > > > > > >>>> the above is the patch we need.
> > > > > > >>>>
> > > > > > >>
> > > > > > >> Hi Tom
> > > > > > >>
> > > > > > >> Can I persuade you to try something like
> > > > > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103=
542a1076f9cab0005f400fa072
> > > > > > >> again, but leaving the .dtbo targets in there?
> > > > > > >>
> > > > > > >> I could send a patch, but it's entirely mechanical, and not =
really meant
> > > > > > >> for being applied until we know if there's more to be cleane=
d up.
> > > > > > >
> > > > > > > So what ended up being the problem I think is the case Simon =
pointed out
> > > > > > > where we do take the output from "make all" and concatenate o=
ne of the
> > > > > > > dtbs that was generated with u-boot.img or so, and it works. =
 But maybe
> > > > > > > that should just list all of the valid DTBs that it needs in =
the
> > > > > > > defconfig to start with? I don't quite know, it was a case I =
hadn't
> > > > > > > considered at the time.
> > > > > > >
> > > > > >
> > > > > > Re-reading the thread, I can't see where that was mentioned.
> > > > > >
> > > > > > But yes, if some boards (still) need that, and have more than o=
ne
> > > > > > possible .dtb, the board can't set an OF_LIST different from th=
e default
> > > > > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requ=
ires
> > > > > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > > > > >
> > > > > > How do we figure out if such boards even exist?
> > > > >
> > > > > Honestly at this point I've forgotten what this is all about.
> > > > >
> > > > > Perhaps the easiest approach is to create a new Kconfig to control
> > > > > whether a board-level .dtsi is included in the list of wildcard
> > > > > searches. Then you can enable it for your board without affecting
> > > > > others.
> > > >
> > > > That's getting things backwards, from what this cleanup does.  Toda=
y we
> > > > have messy lists of "build these device trees" and then don't use m=
ost
> > > > of them, and some of the list is just Wrong (listing dts files as an
> > > > output).  With the series to handle dtbo files, we could remove
> > > > virtually all of that, and the only use cases that don't Just Work =
still
> > > > are the ones I forget which board you mentioned (I think it was Sam=
sung
> > > > tho?) where the defconfig doesn't list all of the device trees, jus=
t one
> > > > of them, and the other 5 that we build can also be easily used.  Do=
es
> > > > that ring a bell?
> > >
> > > Yes it does...but what is the problem here?
> >
> > Messy and unused and incorrect Makefile content.
>=20
> The problem I see there is people using TARGET in
> arch/arm/dts/Makefile for example. There are 80 instances of that. The
> rules should depend on SoC (e.g. use ARCH_EXYNOS5), as Linux does it.

It shouldn't be there at all since there's almost no cases where we
"just" take an arbitrary dtb file and u-boot.img and then the system
boot.  That's what this series is about fixing.

> > > The DT files for an SoC are supposed to be buildable without needing
> > > to have the context of a particular board.
> >
> > They're still buildable, without an explicit rule, they just need to
> > (like they can now) be built explicitly.
>=20
> But isn't that creating dead code? It will rot.

No, that's the problem we have today, people list something in the
Makefile, since they think they need to list something, and then put the
device trees they use in the defconfig.

[snip]
> > > I am find with making the boards list the DTs that they can run with,
> > > if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just for
> > > SPL, I think.
> >
> > Yes, every board except for some use case you've described before as far
> > as I know lists the device trees that they use in the defconfig.  Which
> > is why there's an impetus to clean up arch/*/dts/Makefile as 95% of
> > those lines can just be removed.
>=20
> It seems like you are wanting a board-level CONFIG which lists the DTs
> which need to be built for that board. Is that right? You are
> suggesting that this already exists, but I am not aware of it. Do you
> mean SPL_OF_LIST, perhaps?

I mean today CONFIG_DEFAULT_DEVICE_TREE + CONFIG_OF_LIST +
CONFIG_SPL_OF_LIST is set and correct for everyone board except some use
case you have, which I think is something about exynos?  And so we only
need scripts/Makefile.dts in arch/*/dts/Makefile

--=20
Tom

--pJ8bPbEsMN4Hxm+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUa3cYACgkQFHw5/5Y0
tyzwHQv+LQWlpfubOi30C3CkS+BbiGNUp6JE9ryaAvL8PQ8EeGJE1H27EULVFsyk
dexzTl5Ej3Pm++jJoSC2hQ1Q1i1N+jwyY7vuHTleCoV9AuiwXbIJJZXhmt3fNj/b
Rzv+kFQC67eZXJzryMmvLfhK5xBu68JNOIHcCtBwa2g1ioFNGEYlkliY+gUwPZH1
o337ovwv22jSPgNHECfZ4GqEjyb0GqLMEvt1wYf+1zmAOqnY0j85Np1V1L5j0UMN
hpNjbVmawLdeOCFPZb/OP8ynVnQ8yTxQ//nPZjw03ou1O9/g8iCDR99Shs730OYq
fs/Ki2PUsUED+KQVlwHiu9zu/EtE5EzQszDF/ZTF55hHN5m3ftNVX9wh9g2OA2Xt
tn/N0Xkq7GDHuKbCGSV8mG/B3ZYibIU+6YYTRHfIkCpaAa9DllntvtXy2Ymmk2+I
mAX7tr/Exz9MKCJvmozKgTbeWlK1E7koj/KaebOirurFn3vJ209FdQ+GAkpZW9lN
DitzNo9Z
=cnko
-----END PGP SIGNATURE-----

--pJ8bPbEsMN4Hxm+a--
