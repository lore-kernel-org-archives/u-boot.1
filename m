Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A54FC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 21:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E0781FAB;
	Thu,  1 May 2025 23:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkoC490U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24A68070C; Thu,  1 May 2025 23:11:16 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD8F8081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 23:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2d4cefac09dso816177fac.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746133872; x=1746738672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9hnvyFpYx5+Jzcyz6mLgYqzzHPvk79gF/oxUXnq8ikc=;
 b=kkoC490US1kPn2OZt8SStt4X+6XRVB7u8HnS1VhKjnQP9F3MRe3XGwsn+mTUYmbxfp
 Vx2aJnWX/MDyKv5izbZfwchb+obSqeizaUaOTyQRvnWtfRiGzUqrNChr5VZG7yOZ+OSN
 g/yuE/hH4ZwmWmHDI+o0ReV+NnB9JYl8yet3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133872; x=1746738672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hnvyFpYx5+Jzcyz6mLgYqzzHPvk79gF/oxUXnq8ikc=;
 b=PDOdK6V4zVqky8NWpZ3D5l8DfVkHpsAyGyuhfCIkoh2CKnZ5ubZV3wVjOneoj/4Hgo
 2Frc5L7t+SclaKWbd+CEwllZeLUutP3gSPaxKUIkp24XcFy09dH8YW3yQCSFURmmJVdm
 97zFfZKwDqYsD+RE2nJ2kHqzPCC8eJkCgN9m2x6kiKtDJ1DK2qAi9NdzJw3ckddly1Es
 kGvTCA9gBe+TKC8c3Cx35TNyxAhUxkY03d5Av20X/lsDFuDEVuK5mIq8y2PBe7gW9YHc
 ZUcTwHU3aPyDfORvK2QklfPiQ+3p4wONADK1eNGHgWFXhSURK1/Vn1xjNJGEbwScKdL4
 TpTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs3VD6O/dP01TTEQSNFq6ZSSAif2SSyC7opH9UKDpZbzfg9uH02iZvt6tZkNCLR/4BvvGPhp8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0iyD1d2RFmmnM/IG/EM79gH12JpN2iYAnrvMR3cQk8dV7aDPd
 3uStjDxIW577gqw7y72t49fC0FUbmqMndFbl+NvR3mSJVtEoRBZ0dJy3MS4z2+U=
X-Gm-Gg: ASbGncvx2NpV8RBUpaiEUB5gsXIP9ethznbvsQw1gvoyuMeXqcHlwkcd/ckFFNd7+X+
 HSTZoMftL6oNHRSPBgo0j2LsQoWeJ6VmPkLEUQTPhOYT7LQSxuyG4SL4aKKlv8GWIn/9jRNtaDN
 uDqaIoWLp/8xFWo9wB9K6J2xOl0VL4podYvs/ps6EFLFi801E9+Jvlm0x0I2che2nJzWwe52roC
 VJDQyOs2rX85vq84m1wvd7s1tleeVMi+9oaZyd8+DL/DQQxsMie3yS72odPU9z4FL327Jtn8gFN
 IyG3h75GOXwCa3vmbbfBe9EgP9M95A2CU/6Yyr/wBasw/vqlEcHUzT7M5FUEoCVbnhVXQXgxoA+
 rVqzkVQu8vKnm
X-Google-Smtp-Source: AGHT+IE2xlU2slEfRLRp2F0dKMGm0ZT8t4kaIQoT4enb9NvIIjbmF5ryAJePWcbUZWpmCkg+iyO8cQ==
X-Received: by 2002:a05:6870:e415:b0:2c8:340d:1076 with SMTP id
 586e51a60fabf-2dab340a176mr179179fac.32.1746133872438; 
 Thu, 01 May 2025 14:11:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d34daae1sm258533a34.44.2025.05.01.14.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:11:11 -0700 (PDT)
Date: Thu, 1 May 2025 15:11:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>,
 Alexander Dahl <ada@thorsis.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jason Liu <jason.hui.liu@nxp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Mario Six <mario.six@gdsys.cc>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
Message-ID: <20250501211107.GK1261075@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
 <20250429171154.GJ1261075@bill-the-cat>
 <CAFLszTjfq1TVjYSiCQmtSOZK7MoVUOFU5ycOzeBK4-5-zCKxFQ@mail.gmail.com>
 <20250430142931.GQ1261075@bill-the-cat>
 <CAFLszTh0Z_wWj_zdpopphbtzj0qCiTviZsxT9T+M9oaOn70R0g@mail.gmail.com>
 <20250430152056.GS1261075@bill-the-cat>
 <CAFLszTjDMBORfC1bLXFyTEUuKCA7bU53VURO+Jykkb8BRL3d5g@mail.gmail.com>
 <20250501160435.GJ1261075@bill-the-cat>
 <CAFLszTjZDG-1aqpHv6-LqnFgwU2ZQwuXnaekwsYhABSvN3=yhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+CkUCrJTLf4tsJ+H"
Content-Disposition: inline
In-Reply-To: <CAFLszTjZDG-1aqpHv6-LqnFgwU2ZQwuXnaekwsYhABSvN3=yhQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 01 May 2025 23:56:58 +0200
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


--+CkUCrJTLf4tsJ+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 02:57:00PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 1 May 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 07:39:29PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 30 Apr 2025 at 09:21, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 08:51:53AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 30 Apr 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 30, 2025 at 07:55:01AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 29 Apr 2025 at 11:11, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This series adds a standard way of passing information =
between different
> > > > > > > > > > firmware phases. This already exists in U-Boot at a ver=
y basic level, in
> > > > > > > > > > the form of a bloblist containing an spl_handoff struct=
ure, but the intent
> > > > > > > > > > here is to define something useful across projects.
> > > > > > > > > >
> > > > > > > > > > The need for this is growing as firmware fragments into=
 multiple binaries
> > > > > > > > > > each with its own purpose. Without any run-time connect=
ion, we must rely
> > > > > > > > > > on build-time settings which are brittle and painful to=
 keep in sync.
> > > > > > > > > >
> > > > > > > > > > This feature is named 'standard passage' since the name=
 is more unique
> > > > > > > > > > than many others that could be chosen, it is a passage =
in the sense that
> > > > > > > > > > information is flowing from one place to another and it=
 is standard,
> > > > > > > > > > because that is what we want to create.
> > > > > > > > > >
> > > > > > > > > > The implementation is mostly a pointer to a bloblist in=
 a register, with
> > > > > > > > > > an extra register to point to a devicetree, for more co=
mplex data. This
> > > > > > > > > > should cover all cases (small memory footprint as well =
as complex data
> > > > > > > > > > flow) and be easy enough to implement on all architectu=
res.
> > > > > > > > > >
> > > > > > > > > > The emphasis is on enabling open communcation between b=
inaries, not
> > > > > > > > > > enabling passage of secret, undocumented data, although=
 this is possible
> > > > > > > > > > in a private environment.
> > > > > > > > > >
> > > > > > > > > > This series is available at u-boot-dm/pass-working
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > First of all, can you group those patches which are neces=
sary for
> > > > > > > > > refactoring the "passage" concept into a smaller series f=
or an easy
> > > > > > > > > review?
> > > > > > > > >
> > > > > > > > > Actually as I mentioned in our previous discussions, I do=
n't agree to
> > > > > > > > > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > > > > > > > > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context=
 of your
> > > > > > > > > patch - I am not sure the reason you prefer to rename it =
- do we have
> > > > > > > > > any other passage approaches other than using bloblist? A=
nd do you
> > > > > > > > > have any considerations to allow a fallback or not in cas=
e passage
> > > > > > > > > failures?)"
> > > > > > > >
> > > > > > > > As preamble, I am actively working to push the changes for
> > > > > > > > vexpress_fvp_bloblist to be available in CI and so provide =
an easier
> > > > > > > > testing path.
> > > > > > > >
> > > > > > > > At the high level, I don't see what the difference is betwe=
en "BLOBLIST
> > > > > > > > + BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" =
or "BLOBLIST
> > > > > > > > + whatever v4 of this series ends up showing". Everyone see=
ms wildly in
> > > > > > > > agreement that if the prior stage is supposed to give us in=
formation
> > > > > > > > then it must have done so.
> > > > > > > >
> > > > > > > > One of the long running "jokes" in computer science about n=
aming being
> > > > > > > > one of the hardest problems applies here, too.
> > > > > > >
> > > > > > > I want to use OF_BLOBLIST as it clearly indicates that the de=
vicetree
> > > > > > > comes from a bloblist. The BLOBLIST_PASSAGE_MANDATORY thing i=
s a
> > > > > > > work-around to try to avoid having OF_BLOBLIST.
> > > > > >
> > > > > > Or:
> > > > > > Other people want to use BLOBLIST_PASSAGE_MANDATORY as it clear=
ly
> > > > > > indicates that the standard passage will be present and so incl=
ude the
> > > > > > devicetree and any other required logs/blobs/content. The OF_BL=
OBLIST
> > > > > > thing is a work-around to try and avoid having
> > > > > > BLOBLIST_PASSAGE_MANDATORY.
> > > > > >
> > > > > > It's a naming problem and I don't care as long as we end up wit=
h an
> > > > > > implementation that's useful. And *that* is where my list of wh=
at
> > > > > > bloblist needs to have, in the end, comes from.
> > > > >
> > > > > My approach does the same thing, but allows my x86 boards to work
> > > > > without all the confusion. It shows fdt coming from 'standard pas=
sage'
> > > > > when it is.
> > > >
> > > > It does not matter. Really. Whatever you're doing with OF_BLOBLIST =
can
> > > > also be done with BLOBLIST_PASSAGE_MANDATORY as it's just a naming
> > > > thing. There's nothing confusing here unless you insist on confusin=
g it.
> > > > Which gets back to what I was saying before about what changes need=
 to
> > > > happen to bloblist.
> > > >
> > > > > > > > > Secondly I prefer to keep the register convention code as=
 a xferlist
> > > > > > > > > library that can be used for arm arches other than split =
them into
> > > > > > > > > different low level assemblies. In case of any firmware h=
andoff
> > > > > > > > > specification update, we just need to maintain this libra=
ry.
> > > > > > > >
> > > > > > > > Yes, if things can be written in a C file, they should be i=
n a C file,
> > > > > > > > not assembler.
> > > > > > >
> > > > > > > In this case I disagree and if you look at the x86 code, this=
 kind of
> > > > > > > approach is just not sensible. Please take a look at the cont=
ortions
> > > > > > > of xferlist_from_boot_arg(). It was written for one architect=
ure only,
> > > > > > > yet purports to be a general API. My approach is simpler. Als=
o, if
> > > > > > > save_boot_args() is implemented by the board, then standard p=
assage
> > > > > > > will be broken for that board. It's a weak function!
> > > > > >
> > > > > > I don't see why this has to be in assembly and not C, no. And i=
t's a
> > > > > > weak function because it doesn't yet exist on other architectur=
es and
> > > > > > everyone hates #if.
> > > > >
> > > > > We just don't need it, though. If you would like this to work on =
x86,
> > > > > it needs to go.
> > > > >
> > > > > >
> > > > > > > More generally, please decide if you are willing to let me ma=
intain bloblist.
> > > > > >
> > > > > > Can you be given substantive feedback? Or is only trivial feedb=
ack
> > > > > > allowed?
> > > > >
> > > > > I'm happy to discuss it on a call, but if you insist on
> > > > > BLOBLIST_PASSAGE_MANDATORY, then it is going to be tricky. The
> > > > > OF_BLOBLIST thing has consumed far too much time. If you want Lin=
aro
> > > > > to maintain bloblist, please just say so. I had thought you were =
OK
> > > > > with my taking that on again.
> > > >
> > > > As I've said numerous times now, BLOBLIST_PASSAGE_MANDATORY and
> > > > OF_BLOBLIS are just names. Names are one of the hardest problems in
> > > > computer science. As I've also said numerous times now, you need to
> > > > show ME that you have a good design. That means you need to impleme=
nt
> > > > register passing rather than BLOBLIST_FIXED. You then also likely n=
eed
> > > > to untie "Is there a bloblist?" from "Make a bloblist" as that's wh=
at
> > > > complicates things.
> > >
> > > They are not names, actually. The logic is different. Please look
> > > through it carefully. Perhaps we can discuss this on a call?
> >
> > I don't know how a call would help. They really are just names for the
> > same goal. Whatever the symbol is for "board must use standard passage"
> > can select OF_BLOBLIST, it does not matter. Especially if you do what I
> > asked in the email you link to later.
> >
> > > As to BLOBLIST_FIXED, I have a path to do that, and convert x86 also.
> > > I even have boards in the lab to make sure it all works. I see that
> > > you have got the bloblist board into CI as well, so that will make
> > > things easier.
> >
> > Good, lets get rid of BLOBLIST_FIXED as soon as we can. That'll help
> > remove some of the overall confusion.
> >
> > > But that path I'm talking about doesn't run through the xferlist
> >
> > I cannot understand why:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250417121601.v3.10.I=
56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid/
> > is good
> > and:
> > https://source.denx.de/u-boot/u-boot/-/commit/5103e69344d60eb8c8d2cf804=
ec00d0ef3975124
> > is bad.
> >
> > And then what you want will enable x86 to be handled, but what we have
> > in tree cannot.
> >
> > > stuff, nor BLOBLIST_PASSAGE_MANDATORY for that matter, so am I not
> > > willing to do it before this series is in. I do want to focus my
> > > efforts on things which will bear fruit. For whatever reason, this one
> > > seems to have generated a lot more heat than light, over a period of
> > > 18 months.
> > >
> > > Another option you have is to take this series and then the following
> > > ones for the migration and *then* decide if you want something
> > > tweaked. That would be more likely to result in a successful
> > > collaboration.
> > >
> > > The reason I keep asking you about just letting me maintain it is that
> > > I thought you agreed to this a few months back:
> > >
> > > https://lore.kernel.org/u-boot/20250216154801.GZ1233568@bill-the-cat/
> > >
> > > Please, consider the option of just sending me a 'yes' and I'll sort
> > > all this out.
> >
> > So are you, or are you not doing what I outlined in what you linked
> > above? Because looking briefly, again, at v3, and setting aside the
> > unintentional breakage, it's not doing much of what I asked. We're
> > finally (good!) adding a way to pass between U-Boot phases on ARM. We're
> > also not making use of the existing mechanism for doing so, for unclear
> > reasons. So yes, before you make a v4 you should explain what's wrong
> > with the method we have today.
>=20
> Can I please first check whether you might be open to an alternative
> approach to BLOBLIST_PASSAGE_MANDATORY and using C code for the
> register saving?

I mean, when it's possible, yes? That you remove that code in v3 is part
of my problem with it. We still have to save the registers in assembly
since we haven't setup the stack and so forth. But if you can improve
upon the ratio of assembly to C that's being used today, great!

--=20
Tom

--+CkUCrJTLf4tsJ+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgT42cACgkQFHw5/5Y0
tyzIuAwAkrARekWII6CFR7PhCX33lbuRSDUAAWySgKiI/Enc3sqGHaRRw5SfS6FO
CfGtqJvYLxPrrQUdkQLBLeSBk/BHRKFH7sb8iOEAJ9z1mF2Q81Xxd8b4TXymJCma
xLYOd/8Acf9GguOkjl2KxViNYcrQFWNke+RfLYRnixVGRKh+unvel6h60fw61YqZ
FyP0kotJRVcvJsyyheL53dLqXosXIyhsr+4yw57fHR3ZfPfie3m9Baoi2lztGt1B
x0SwyNm7/n7fvxGSq+b/BW4A5HrmaULN2ZVKw4rTX5bwCeX1BdbaO7ZyMXjjWnhd
9sDt1aansTeA/Z7o25qdWW0ehNWOdLDnFYnd3XJRQymY5cf+q0vD4Mumx1ZjYKEq
uPJ3Qrd7h4ayontaig4ay1iii40SogYks66zedciXSLDpWHuXe66G0R47lVxH4b6
GQYxL0teHmbtzlCNa6Vfj14y2sUdNETZ+9AM2FWoo8lcQefZM+lesUGXoWV+MGL8
iogg825u
=YLEb
-----END PGP SIGNATURE-----

--+CkUCrJTLf4tsJ+H--
