Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F851C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86B382A7B;
	Tue, 29 Apr 2025 19:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DPmy0xbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F41B82A65; Tue, 29 Apr 2025 19:12:02 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F92829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6063462098eso3887781eaf.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745946719; x=1746551519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6+FPQNsrLwFwYV0s3FV4RhgUA8SzwvdCGxlYMvOj/yc=;
 b=DPmy0xbLEp9UooMwiUyvCsKUKmKxCXV9txMc4T2i8/J+KCkjLIcwWOdjuvu4TK+aeG
 mrL2tVG9uj03yRqVeKnDiNg3Abt7Fo9jUb4wjjgOKe/vnwxQgopgmbx9i0TLWiC+i27e
 wdc8by8uDEj4en4T9YZJxzUiuqATL07dMOsH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745946719; x=1746551519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+FPQNsrLwFwYV0s3FV4RhgUA8SzwvdCGxlYMvOj/yc=;
 b=ocgo3lHPSvaRbcg43IByA8eUjKchETt5kPU5wI9Ry2RAA0XzZO6yopo2fhtr/7TMzr
 UgJFyTxIHnA2Mbjz4VNUCcT2DAyMhbYdoFkX9WJD+LcLpx75eKaV12btarCcGzgiPwT3
 T8j3BoD/I0atHyXI663IMiYEw85cbUKJX5NzhWfBgp15E2NNUXfnaTHFhAhGCdtX6cTw
 ZXlelhg8ziy1hfkp8HLzP2CtQt+DGQ1ZCjYltYa0X17JUzkSZNQ0BAuT6Drnd8H9UUBL
 hkCz2/JFLtfBR4U/c+OuEo7ROCnuofMTW2nEfRFq4G840XiSNW6O38OjJESefL8Rs8j5
 vWqw==
X-Gm-Message-State: AOJu0YzrdU5X7GoBLtJ8rrTel6nGPrIoWPzMJNBdaxzMnjznjoeq9b34
 rwMuy8lllc9HFZa+DYwlvjvmonsRcDZo6hmKufEY7w9MucokT6mofvNrwUUII5Q=
X-Gm-Gg: ASbGncugvH0NbHgJDcW1+EqtwG4x8RcrWI3SV6Rkn3OVV7tqqxuWMMXdgLzfPYFb/0R
 MY7aJVhpg1ws+0lFYvFbpWjWiBodwGKx5mGHuLXgJqa+FLnOxwn+FF80+AQ0yUsgl/a5VyPBO+o
 goHmzAZ2a2wM/e4VflhDIHN24PMSNG5Nez85LGOWIN6t/dFObbrJNN3t926A5mEI3jmVICaDA5z
 gv+wpgOwkoN1bxHIzEOWUMlnsa6ufWlRB6//SkXf48i0JQ6m5+S/bS+9hko8QY+948sujRjxQcJ
 S1OqTpDske2h5BaoBWqw4OVTMHSarNW7+35aSGz30tk7m2SVlxha+gGDi4/lclMyUfGz10NazgW
 ZiQ==
X-Google-Smtp-Source: AGHT+IEjqBCIBto9jqWAtcc0kc2UlzIALYqaQK5Iq0TvchY4/X7fMxBiD6hJahhDw29C41it4/rtxQ==
X-Received: by 2002:a05:6870:b022:b0:2c2:2d0f:40a3 with SMTP id
 586e51a60fabf-2da401c9004mr2624615fac.31.1745946718785; 
 Tue, 29 Apr 2025 10:11:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973644b1fsm2881961fac.1.2025.04.29.10.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:11:57 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:11:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
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
Message-ID: <20250429171154.GJ1261075@bill-the-cat>
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="21tDikaX+N5fBrNL"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:44:02 +0200
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


--21tDikaX+N5fBrNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> Hi Simon,
>=20
> On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
> >
> >
> > This series adds a standard way of passing information between different
> > firmware phases. This already exists in U-Boot at a very basic level, in
> > the form of a bloblist containing an spl_handoff structure, but the int=
ent
> > here is to define something useful across projects.
> >
> > The need for this is growing as firmware fragments into multiple binari=
es
> > each with its own purpose. Without any run-time connection, we must rely
> > on build-time settings which are brittle and painful to keep in sync.
> >
> > This feature is named 'standard passage' since the name is more unique
> > than many others that could be chosen, it is a passage in the sense that
> > information is flowing from one place to another and it is standard,
> > because that is what we want to create.
> >
> > The implementation is mostly a pointer to a bloblist in a register, with
> > an extra register to point to a devicetree, for more complex data. This
> > should cover all cases (small memory footprint as well as complex data
> > flow) and be easy enough to implement on all architectures.
> >
> > The emphasis is on enabling open communcation between binaries, not
> > enabling passage of secret, undocumented data, although this is possible
> > in a private environment.
> >
> > This series is available at u-boot-dm/pass-working
> >
>=20
> First of all, can you group those patches which are necessary for
> refactoring the "passage" concept into a smaller series for an easy
> review?
>=20
> Actually as I mentioned in our previous discussions, I don't agree to
> add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> patch - I am not sure the reason you prefer to rename it - do we have
> any other passage approaches other than using bloblist? And do you
> have any considerations to allow a fallback or not in case passage
> failures?)"

As preamble, I am actively working to push the changes for
vexpress_fvp_bloblist to be available in CI and so provide an easier
testing path.

At the high level, I don't see what the difference is between "BLOBLIST
+ BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" or "BLOBLIST
+ whatever v4 of this series ends up showing". Everyone seems wildly in
agreement that if the prior stage is supposed to give us information
then it must have done so.

One of the long running "jokes" in computer science about naming being
one of the hardest problems applies here, too.

> Secondly I prefer to keep the register convention code as a xferlist
> library that can be used for arm arches other than split them into
> different low level assemblies. In case of any firmware handoff
> specification update, we just need to maintain this library.

Yes, if things can be written in a C file, they should be in a C file,
not assembler.

--=20
Tom

--21tDikaX+N5fBrNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgRCFUACgkQFHw5/5Y0
tyxepAwAm0Ak2wHRMHe9JGbyAopuv8mNp+Kk3yEgDVqBUoCwJJVGuoDfIS5JpXZc
BGqJYjrM1GmNtIbPwhJIhw34LAkJ4pgnp39eBnW/tRoUv3Nrl+w++Rln3xeZ2gGO
T3qAFhJhOEOvAT4vaZ9BrYpS9XxYGH/jpmombR7d2Ybhxgh8JajwwqOZ5Lg5fmUQ
0loQP5hgrtqCCwbYrwcSpqGEQdBDfJehd8lZ3KU1cghalPax5SxMnXWdXexqHqeH
Mawr14Q6kyEy2lHPG8THpeDXgqO5Jddc6qB/HnQrMH2g8AjtGsJeWDDHLnfpj1uT
jFaU/jnXZxSPkNm3FlAYrWC8xJG/jJ4CB1xkNeGuC+IqWV/nO/iO6EoR3/Nof9Fw
mK0VUYEW5f6Amr5KiZXh28VNrEBTK90wytx2iWPdlAWYFAzfL5eE6s3cRDCVRdJb
/Fg5DmG1u3yLxWMbeFYfDv4iTAtzklc0QYC0x/+WfBNL9bzgtigeC4kPLv+cLI0H
5Krkwjw8
=Tr/I
-----END PGP SIGNATURE-----

--21tDikaX+N5fBrNL--
