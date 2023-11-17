Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85C2C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713C886EC9;
	Fri, 17 Nov 2023 20:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZOTV8vvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01E986EC9; Fri, 17 Nov 2023 20:42:05 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51EA686F6C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-778925998cbso143102085a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250118; x=1700854918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=znLiuTm80zAh3M+hMK+UN7ZOL1GnMoVLo8se/WR/tGA=;
 b=ZOTV8vvHN0yAEjLSBEE4p6nnxGHZ2u47oH7sEpE7k/YBFQ9Te7YU352Yb+utL+E46o
 RjYf+jUxADSQ8QjTIoDI39k7Cv3ybqlyiKtSW/wdDgJuulp8WHOgxO0kQwuKj8rjQ+4V
 epl4JLOP7OrQh+89Xxwzx4Kv0Q4jcy93pYN6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250118; x=1700854918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znLiuTm80zAh3M+hMK+UN7ZOL1GnMoVLo8se/WR/tGA=;
 b=syMT6aIDQakDgc1M3lGsVYMj3T1lsDrQef1VrYI8d1G7BMrddv0nCjL2hTuqLFUgr9
 u1lN0z/nHG+BUTRMVpvmN/cOMXaptqTa/s1jMn97r/VZ4f4bm1qMTtVGmWEe6yUaPhs0
 EUfcUhjv6UNX2zerzn23631Ivy1anLQqVVfwDHoqxndVd5heD0Kb2UUxMTw1SxdUpW5n
 bvIzjwwai0swbHBvdT2FEN6/8wU5GT4isRT41ACbS3jQAopmnalAJPFYuik+jpRNZmmM
 V0EsmD38s3dkTb3x+8oev1fhAOtZaGp39t+6+qyFzfrZOnUYvK4AoudU60ZwQZo+SyyV
 4P1A==
X-Gm-Message-State: AOJu0YwE0iMmIPfQma/EknN6I6HwpnaFoKfhlDjEAetU5nvLR6IVLsji
 CzJcHpgPa1kvfxFNLX+LpIDEUw==
X-Google-Smtp-Source: AGHT+IGpj0oR6fMPzEd216UgkcniogafdcA4uMqZWuVGLGgtfelIW/jfPN4RIZSPGhRg0wTOuTmU9Q==
X-Received: by 2002:a05:620a:15af:b0:779:e118:a025 with SMTP id
 f15-20020a05620a15af00b00779e118a025mr537844qkk.34.1700250118090; 
 Fri, 17 Nov 2023 11:41:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 tl11-20020a05620a3b0b00b007789072e445sm839112qkn.31.2023.11.17.11.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:41:57 -0800 (PST)
Date: Fri, 17 Nov 2023 14:41:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 u-boot <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Will Deacon <willdeacon@google.com>,
 Ye Li <ye.li@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>, Alistair Delva <adelva@google.com>
Subject: Re: [PATCH 0/3] Revert HAFDBS changes
Message-ID: <20231117194155.GR170968@bill-the-cat>
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027094947.bhtwngq26e3loya5@google.com>
 <20231027172237.GB496310@bill-the-cat>
 <20231109213348.GP6601@bill-the-cat>
 <CAFOYHZAbkKLuC9KiH0KNz7hj31QsYohmJRCgu-Pk_yr4yXtEDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4J65dpR1ZI22kJKl"
Content-Disposition: inline
In-Reply-To: <CAFOYHZAbkKLuC9KiH0KNz7hj31QsYohmJRCgu-Pk_yr4yXtEDw@mail.gmail.com>
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


--4J65dpR1ZI22kJKl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 06:38:40PM +1300, Chris Packham wrote:
> On Fri, 10 Nov 2023, 10:33 am Tom Rini, <trini@konsulko.com> wrote:
>=20
> > On Fri, Oct 27, 2023 at 01:22:37PM -0400, Tom Rini wrote:
> > > On Fri, Oct 27, 2023 at 10:49:47AM +0100, Pierre-Cl=E9ment Tosi wrote:
> > > > Hi Chris,
> > > >
> > > > On Fri, Oct 27, 2023 at 01:23:51PM +1300, Chris Packham wrote:
> > > > > As discussed this series reverts the HAFDBS changes that caused an
> > issue
> > > > > on AC5/AC5X. I think there are some improvements that can be made=
 to
> > the
> > > > > initial memory map for the AC5/AC5X but so far nothing I've found
> > makes
> > > > > it compatible with the HAFDBS changes.
> > > >
> > > > Would you mind briefly explaining what those issues are and/or point
> > me to the
> > > > discussion where it was decided to revert these patches?
> > > >
> > > > The feature is quite useful for users of CONFIG_CMO_BY_VA_ONLY, to
> > speed up the
> > > > boot sequence: instead of reverting these patches altogether, would=
 a
> > reasonable
> > > > alternative be to put them behind a build option?
> > > >
> > > > Also, could you confirm that the "initial memory map" you are
> > referring to above
> > > > only describes actual memory as, IIRC, some boards were using mappi=
ngs
> > **much**
> > > > larger than their DRAM address space?
> > >
> > > The most details are in this thread:
> > >
> > https://lore.kernel.org/u-boot/CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=3DJ0=
oHyvN75bTaCUw@mail.gmail.com/
> > > with some follow-up in:
> > >
> > https://lore.kernel.org/u-boot/CAFOYHZB7jJWwD24oWzx6u55w2whHYjK56f=3DQy=
N0LWU4Z8dSP+Q@mail.gmail.com/
> >
> > Checking to see if you have any feedback for these platforms? I would
> > like to have them working again one way or another in v2024.01, thanks.
> >
>=20
> Either this series or
> https://lore.kernel.org/u-boot/20231018205358.1557234-1-judge.packham@gma=
il.com/
> will get the AC5X boards back working. I'm out of other ideas but happy to
> test patches.

Following up here on the cover letter as well that I've applied the
revert for now. I'm happy to revert the revert if we can get the AC5X
platforms fixed, and perhaps a little documentation about what was going
wrong as I believe the other thread at least hinted that other platforms
might be doing a workaround as well but didn't spell out why.

--=20
Tom

--4J65dpR1ZI22kJKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwgAACgkQFHw5/5Y0
tyxhBwwAiz9AtttYVOg7C5j+NeB/LinF7bY8bcODqEETbqUL+9rZyLyAT+sZlOQm
qWOcDxVVdCFkea8mkl5NAWYCNCpyGxT9+6A3E3G6G4Idn9vXvlZBgTYJyNBYk4zU
JBlDoyVrBEHMOWVbe9H6bSyyefQhtUm/PjEdCCrR2ov4CVYx2SuQvXYJLU7QH80a
gry90BHIxnjoVFU//M1EM9+Y05vYdVfbe6f3J9sah7YlezOSpdh7ZJInMPyu7po+
E7tK1elyfIEX1HHiu0vKw8KhgR4mtYyvxtIQhcJGiIrh7n412ui2Xy1p0jYS8KyN
iE/1ECUUltjRj2KIE8m2G3E3UZwbCMxsPlN5lGRLxjV7mD9S7YsNrg8vAGb1cXUB
B21dNjzdC6nTHbJtU/HPJ1EjCXLO60IjkDMac9Zws8oBrZCVFV8dU8Jl/gjiO6cm
POgiliRPcCiAtukwX65ZJuQQ/OQ1O0IwZP12aTFAiTGfOCb7gkiXJv98nJCRlOSD
P4I1IEQP
=j0UJ
-----END PGP SIGNATURE-----

--4J65dpR1ZI22kJKl--
