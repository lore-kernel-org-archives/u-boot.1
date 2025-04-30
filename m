Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B3CC3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB60082C15;
	Wed, 30 Apr 2025 18:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8YkjGw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0ADB82B9D; Wed, 30 Apr 2025 17:21:05 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA9D8210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3f6a92f234dso4897b6e.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746026462; x=1746631262; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UvG2b4fqvCXocDSdoy3NZqZDM2Um0tb++SzJwvLoYyk=;
 b=n8YkjGw7X1FT24307ILlpFWSWDWMln6wTEFRzFIEdp4CzK2TZESyLLxf1o9NrGK0dk
 mGTGdrKAgWhyLBhON20XBbytj7oXn8dCjFqwpn6Mf4ibawH+FfXqNALsDyGOVAXtVY+X
 0lqmWrn3qTJKwYaRFiZAlPPrB1nUYVxbuxPbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746026462; x=1746631262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvG2b4fqvCXocDSdoy3NZqZDM2Um0tb++SzJwvLoYyk=;
 b=lg88KC470v7xW7xjHdgd0/enV4yTi4u/cWwnxNs9mIAdDL649z9li51NmO328oIjCV
 /ph9iI5t19RhxvWf6dTy85pbCRocGqG6+Egf3L8pq6RXsqv9gb85AkfWTNNTDB+hsWLT
 uj5ozsJ8gZkSXdm6FJNZz4R9oD/f/umTwva/HAyq/lUoWggrWtd2Irit/JGLRhJ5I5mR
 UYdVK9qx5/kAxuPAxdrS6VsFogX4GIFObB/TL6aZYpWzy7Lx5y/teunHpAwzrtBnldkN
 lSFIVphSqx1Q6H6qYeJwDHZEVsUn1GlFNZujxb/RYsYZbQ8LmasF6sSjbdZgvQJZeJP0
 Iz7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwQDrhry4ROcBhzhK3f7HC9uYRbFxN2IHviXbsxZW5AF/4eK8cm+BJUJuQrKYgfrtIwqnQ2+c=@lists.denx.de
X-Gm-Message-State: AOJu0YzTyWilNyDQdkHnz/3FLaBrwNHL+8zeMQ4Y3Wkk2tGiCRUNHJzq
 W2Mc1jwRZCS1YNdf5p8JZVb258dHN4S0Q26WGewvuGBIYkoRoYqZdYsKz+An2pk=
X-Gm-Gg: ASbGncvbQrbKbMuGAM8L1F8LYmdLEs0QCfsQwsP1QiNHick96qbjWSAKGko0fD0vlcE
 DIV1qiAd0k4EwfK9WeU4W+fhlyWITY6PRkIaRF1KKXRyZZuvc3G5TPlRLfRPQ702DDGqniXESOx
 NlHgPKErxML8qyk4u4zSBmVZqsbPpvJE8Ot0FAVY42BG/fFsF+IVlMzuGDntp3qlEamjhyYPDSY
 ldXWJ4Sk0KzNjx5wDbiodUMHuSC9exa7n5Gmf7iPb0EYlh4TQ44nA+71WEV20QprTMUFMKNeSnM
 L9lsjNspIqQXid/BX8yDWsyr+Ib9+7ph+BIrTTzgWJX6fPYsjn0yp5TZH+Zlw+UI5Icnb6M7VTA
 sgA==
X-Google-Smtp-Source: AGHT+IE0X0/r9Dsm6JRphV6tFxVs1+/O3ZwWPOPCUfhXgpctYHWoPWjmKWpy/22nG/b6XjHo63R6nw==
X-Received: by 2002:a05:6808:22a1:b0:3fc:1f7b:c3b3 with SMTP id
 5614622812f47-402d24f8bfbmr1755257b6e.33.1746026461985; 
 Wed, 30 Apr 2025 08:21:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4021292d759sm848382b6e.27.2025.04.30.08.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 08:21:00 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:20:56 -0600
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
Message-ID: <20250430152056.GS1261075@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
 <20250429171154.GJ1261075@bill-the-cat>
 <CAFLszTjfq1TVjYSiCQmtSOZK7MoVUOFU5ycOzeBK4-5-zCKxFQ@mail.gmail.com>
 <20250430142931.GQ1261075@bill-the-cat>
 <CAFLszTh0Z_wWj_zdpopphbtzj0qCiTviZsxT9T+M9oaOn70R0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pa5yPOwDD09bhXSj"
Content-Disposition: inline
In-Reply-To: <CAFLszTh0Z_wWj_zdpopphbtzj0qCiTviZsxT9T+M9oaOn70R0g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 30 Apr 2025 18:36:59 +0200
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


--pa5yPOwDD09bhXSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 08:51:53AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Apr 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 07:55:01AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 29 Apr 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > >
> > > > > > This series adds a standard way of passing information between =
different
> > > > > > firmware phases. This already exists in U-Boot at a very basic =
level, in
> > > > > > the form of a bloblist containing an spl_handoff structure, but=
 the intent
> > > > > > here is to define something useful across projects.
> > > > > >
> > > > > > The need for this is growing as firmware fragments into multipl=
e binaries
> > > > > > each with its own purpose. Without any run-time connection, we =
must rely
> > > > > > on build-time settings which are brittle and painful to keep in=
 sync.
> > > > > >
> > > > > > This feature is named 'standard passage' since the name is more=
 unique
> > > > > > than many others that could be chosen, it is a passage in the s=
ense that
> > > > > > information is flowing from one place to another and it is stan=
dard,
> > > > > > because that is what we want to create.
> > > > > >
> > > > > > The implementation is mostly a pointer to a bloblist in a regis=
ter, with
> > > > > > an extra register to point to a devicetree, for more complex da=
ta. This
> > > > > > should cover all cases (small memory footprint as well as compl=
ex data
> > > > > > flow) and be easy enough to implement on all architectures.
> > > > > >
> > > > > > The emphasis is on enabling open communcation between binaries,=
 not
> > > > > > enabling passage of secret, undocumented data, although this is=
 possible
> > > > > > in a private environment.
> > > > > >
> > > > > > This series is available at u-boot-dm/pass-working
> > > > > >
> > > > >
> > > > > First of all, can you group those patches which are necessary for
> > > > > refactoring the "passage" concept into a smaller series for an ea=
sy
> > > > > review?
> > > > >
> > > > > Actually as I mentioned in our previous discussions, I don't agre=
e to
> > > > > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > > > > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> > > > > patch - I am not sure the reason you prefer to rename it - do we =
have
> > > > > any other passage approaches other than using bloblist? And do you
> > > > > have any considerations to allow a fallback or not in case passage
> > > > > failures?)"
> > > >
> > > > As preamble, I am actively working to push the changes for
> > > > vexpress_fvp_bloblist to be available in CI and so provide an easier
> > > > testing path.
> > > >
> > > > At the high level, I don't see what the difference is between "BLOB=
LIST
> > > > + BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" or "BLOB=
LIST
> > > > + whatever v4 of this series ends up showing". Everyone seems wildl=
y in
> > > > agreement that if the prior stage is supposed to give us information
> > > > then it must have done so.
> > > >
> > > > One of the long running "jokes" in computer science about naming be=
ing
> > > > one of the hardest problems applies here, too.
> > >
> > > I want to use OF_BLOBLIST as it clearly indicates that the devicetree
> > > comes from a bloblist. The BLOBLIST_PASSAGE_MANDATORY thing is a
> > > work-around to try to avoid having OF_BLOBLIST.
> >
> > Or:
> > Other people want to use BLOBLIST_PASSAGE_MANDATORY as it clearly
> > indicates that the standard passage will be present and so include the
> > devicetree and any other required logs/blobs/content. The OF_BLOBLIST
> > thing is a work-around to try and avoid having
> > BLOBLIST_PASSAGE_MANDATORY.
> >
> > It's a naming problem and I don't care as long as we end up with an
> > implementation that's useful. And *that* is where my list of what
> > bloblist needs to have, in the end, comes from.
>=20
> My approach does the same thing, but allows my x86 boards to work
> without all the confusion. It shows fdt coming from 'standard passage'
> when it is.

It does not matter. Really. Whatever you're doing with OF_BLOBLIST can
also be done with BLOBLIST_PASSAGE_MANDATORY as it's just a naming
thing. There's nothing confusing here unless you insist on confusing it.
Which gets back to what I was saying before about what changes need to
happen to bloblist.

> > > > > Secondly I prefer to keep the register convention code as a xferl=
ist
> > > > > library that can be used for arm arches other than split them into
> > > > > different low level assemblies. In case of any firmware handoff
> > > > > specification update, we just need to maintain this library.
> > > >
> > > > Yes, if things can be written in a C file, they should be in a C fi=
le,
> > > > not assembler.
> > >
> > > In this case I disagree and if you look at the x86 code, this kind of
> > > approach is just not sensible. Please take a look at the contortions
> > > of xferlist_from_boot_arg(). It was written for one architecture only,
> > > yet purports to be a general API. My approach is simpler. Also, if
> > > save_boot_args() is implemented by the board, then standard passage
> > > will be broken for that board. It's a weak function!
> >
> > I don't see why this has to be in assembly and not C, no. And it's a
> > weak function because it doesn't yet exist on other architectures and
> > everyone hates #if.
>=20
> We just don't need it, though. If you would like this to work on x86,
> it needs to go.
>=20
> >
> > > More generally, please decide if you are willing to let me maintain b=
loblist.
> >
> > Can you be given substantive feedback? Or is only trivial feedback
> > allowed?
>=20
> I'm happy to discuss it on a call, but if you insist on
> BLOBLIST_PASSAGE_MANDATORY, then it is going to be tricky. The
> OF_BLOBLIST thing has consumed far too much time. If you want Linaro
> to maintain bloblist, please just say so. I had thought you were OK
> with my taking that on again.

As I've said numerous times now, BLOBLIST_PASSAGE_MANDATORY and
OF_BLOBLIS are just names. Names are one of the hardest problems in
computer science. As I've also said numerous times now, you need to
show ME that you have a good design. That means you need to implement
register passing rather than BLOBLIST_FIXED. You then also likely need
to untie "Is there a bloblist?" from "Make a bloblist" as that's what
complicates things.

--=20
Tom

--pa5yPOwDD09bhXSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSP9QACgkQFHw5/5Y0
tywH9AwApKmloyFLDEThEQjgzIZsNDvuWbDGXBa1eg5YlDXRcLo8++FpBSEfo4TS
cNVRPF19tY4I2XqsyYaNI9qVOnU46/Rush6Fi/90eqeqHzbdY/przrJz68xLxS4Z
xnZZNTXEMmBZ+MZ/aEGCl6e/u+gAH/N6HFplEcTRwiEpnb8rOsJKJt7BOpa0ZlhJ
VOOSdfjoxrF+QmF2hW4FgKIUzXIJ/LTLnDMAV9lWVmt6skHGr+xFNTEiOw/WcAnF
zEntcq+MyjrTDNzE2Lgj5Y6v1xehD6p3OJD0snyzGp5HxEIA/Nwm3VqhdkHB7ir5
509v4UzbFgWAuz640XDv3u8b637ZavpsGDQ+Qj4QvafBqf1aUfoR0yGMr0UCBO/p
iQXbJjN01GLBDw2odJQvY7w9joa9uDM3KkanOZAWXTmgTANkjjxftaq5liB5uQC+
4dQCAiCtmeclDmkEmEMjzqlpg1kYO+xvOooarBNpMPTV0iaOQbwUouOFtRJehXw4
6eJTCPk5
=cmp7
-----END PGP SIGNATURE-----

--pa5yPOwDD09bhXSj--
