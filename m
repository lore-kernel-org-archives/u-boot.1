Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB6EC369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 13:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69998056A;
	Thu, 24 Apr 2025 15:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qCsyEXMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB352806FC; Thu, 24 Apr 2025 15:49:03 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D81480194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 15:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c40235c34so359914a34.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745502539; x=1746107339; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o4SwBGUzxcA9Yz9SaPZfTd4NqW9yG3itGhEWrv1GcPo=;
 b=qCsyEXMm4JwgRxeQnwn0B6IhUMT5UTUBM8Q0Q+G9GM9Hs3gLqVnj7WYc9bqTBlRphm
 qzcS+w1q55YM5C3BGJYMi7GrXhSWv1ggbsqRziSanKNbslOCfcLUuJJeYEsHT8zfgGHo
 nfTiD+AlQbU1HszUOAc/i+HGXqf0hDZ3DXrHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745502539; x=1746107339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4SwBGUzxcA9Yz9SaPZfTd4NqW9yG3itGhEWrv1GcPo=;
 b=XP/W7iJISsud2SSrFIcYgmNRKfWTwE2D5Kng6ykgicNW8fmFxUZXj4GbODxFp9gq3H
 TzrD+xFDXjx1zTCplINa0UWCEU60nXUs9ZgJE5zh9L2XW9Mik9yxNBT3H/sJEdg7BIRI
 +9EHOhoJMKwPu5ZYfIVvGeq6nd2wCtBZ0l4fswoFVX5ysLg+bEWB/BmuUjJ4Agp9JBXL
 R7DfgCG/J0JDRGPP/qyNX2cbfutiXo/eU3/x8KXgZcB2i4ob3j1RFAbJjNhkAEJOwBKr
 VwdRKgW/1gO8z2vYuK+pzqQEDa4LIGs4Pwam9hwpes39MtzjoCpnPb7/Yv3fbjeXpJ3A
 FmCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdZnp98lGh1tbdW3tkZ7VVbd5ptNWBY6gJ/nhw3X3MP1Ze3SWusc/OMo8VPucVREJ1ckk1I+s=@lists.denx.de
X-Gm-Message-State: AOJu0YyUmwk9W0I7hikQ1bCHNBu0mmFaEKLnIk/oiEgToFISyhh3X0Aa
 o61fugIVxedi7x+jvNwHmLW1Qv6cXaZcQGbY2/iA7Os2ZKWRBpZEWdKZhj5xjC0=
X-Gm-Gg: ASbGnctmuD8UMZyXfgjIP+lAy99LDFe+3QvPDfez20sg0yqhfbvu71cIXX8CG9cZu50
 ZJPOROhewvu9ZfLp5X5Sqbq45NRIxkH/RdMosJvr8F5OY0BmGWUAiUEtIUNTmTs9kWCP41mD5Ov
 ITZVuk3mgeRasDYzOwjohHIhBKmDeX4nf223oEI5r/dnjwl+AmBa+g/2+azOmd+fvS4JTSDzFk8
 COH169+NAtVPpDDfXff02e6oIm7eBjryAdF5Fgi2+KJ7OgUN/f/o1DSWDsllY6HsrcOohhAi1gO
 PuPXYMWPKLI0rteoQ1AiJ4UXyunVxLYsVJszXijUcGPJ3/JrGEamaiGqMhkLBdeenKOKhND+Qmx
 lXg==
X-Google-Smtp-Source: AGHT+IGqMH1pWlqW1sA8CSWqi96nxn/Q/3bbwytOgLmiBaCChOqn53CpS64iE0OeAOqWe9MG4XGFoQ==
X-Received: by 2002:a05:6830:3c8e:b0:72a:11aa:6ebd with SMTP id
 46e09a7af769-7304dc14832mr1654188a34.23.1745502539111; 
 Thu, 24 Apr 2025 06:48:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973c8c9a7sm285169fac.50.2025.04.24.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 06:48:58 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:48:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide
 more explicit error for key-name-hint with path
Message-ID: <20250424134856.GH5495@bill-the-cat>
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
 <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
 <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
 <CAFLszTgDJsO5UFVhpWfo3zoLmjC_o=GnONjQeeWU=mejfMbNDQ@mail.gmail.com>
 <f2a278ff-ac32-4b12-a3c0-d93709be887e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UczpW/TtkokV0b0H"
Content-Disposition: inline
In-Reply-To: <f2a278ff-ac32-4b12-a3c0-d93709be887e@cherry.de>
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


--UczpW/TtkokV0b0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 10:14:19AM +0200, Quentin Schulz wrote:
> Hi Simon,
>=20
> On 4/23/25 2:27 PM, Simon Glass wrote:
> > Hi Quentin,
> >=20
> > On Tue, 22 Apr 2025 at 02:53, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
> > >=20
> > > Hi Simon,
> > >=20
> > > On 4/18/25 7:19 PM, Simon Glass wrote:
> > > > On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net>=
 wrote:
> > > > >=20
> > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > >=20
> > > > > key-name-hint property in u-boot-spl-pubkey-dtb binman entry may =
contain
> > > > > a path instead of a filename due to user mistake.
> > > > >=20
> > > > > Because we currently assume it is a filename instead of a path, b=
inman
> > > > > will find the full path to the key based on that path, and return=
 the
> > > > > dirname of the full path but keeps the path in key-name-hint inst=
ead of
> > > > > stripping the directories from it.
> > > > >=20
> > > > > This means mkimage will fail with the following error message if =
we have
> > > > > key-name-hint set to keys/dev:
> > > > >=20
> > > > > binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /hom=
e/qschulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/=
upstream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA c=
ertificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such=
 file or directory
> > > > >=20
> > > > > Let's make it a bit more obvious what the error is by erroring ou=
t in
> > > > > binman if a path is provided in key-name-hint (it is named key-na=
me-hint
> > > > > and not key-path-hint after all).
> > > > >=20
> > > > > Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb et=
ype")
> > > > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > ---
> > > > >    tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 =
++
> > > > >    tools/binman/ftest.py                                    |  7 =
+++++++
> > > > >    .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 =
++++++++++++++++
> > > > >    3 files changed, 25 insertions(+)
> > > > >=20
> > > >=20
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >=20
> > > > The change log seems to be missing?
> > >=20
> > > The change log?
> > >=20
> > > Between v1 and v2? It's in the cover letter of the series, this is how
> > > b4 handles it, not per-patch change log.
> >=20
> > Oh dear, that's harder to work with. I believe someone is working on
> > b4 so perhaps that feature could be added?
> >=20
>=20
> https://lore.kernel.org/tools/CAOiHx=3Dm8tPANa+5A2dohEdkz48aPgH1g7ZXvF4uL=
mEu+SCo6DA@mail.gmail.com/t/#u
>=20
> seems to indicate it's possible to do this manually within the editor when
> doing a git commit, by adding stuff after a --- line. I checked, seems to=
 be
> working fine indeed?
>=20
> The cover letter will still have a new changes entry, so I guess this will
> somehow duplicate the work, with having to list the changelog in two
> different places and making sure they keep in sync somehow?
>=20
> Note that you can also do a
>=20
> b4 diff --compare-versions 1 2
>=20
> which will do a range-diff of both versions and you'll see differences for
> yourself. Note that the same limitations as for the typical range-diff
> apply, namely that if the changes are too big, it won't attempt at compar=
ing
> the commit diffs, during rebases the git context may pollute a bit the
> output.
>=20
> This seems like it's bothering you, but you're the first to complain since
> I've started to use b4 a while ago. I don't mind doing it, but it would be
> nice to know for which subsystems/projects I need to do this (and hopeful=
ly
> remember doing it :) ). Should we have some documentation for that maybe?
> And not specific to a specific tool used for contributing?

It would be good to update the U-Boot documentation to reflect using b4
for most cases, and then how to use things like "b4 diff" as above for
reviewers. I personally do not care where the changelog is, as long as
it exists.

--=20
Tom

--UczpW/TtkokV0b0H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKQT8ACgkQFHw5/5Y0
tyzI4gv/REdhDXkDmCKC2EnM9ZnR9kXcVPm0RLLyZmRLwXCS15SZ8bpZ2SzPyQ41
61/TcDmVj2mGElB7qhR1H5M8c1pOFIPxkBcp79z+2lA7wFTWmKTyTajIg6Jjrerh
wL6ho3jNFSq6tDKuWOiIe/8NLrOGsf1gu2FWmYzWhF2cI6CDl4r6qqB++I1f9QC3
737+KE+iU4lsIGAbvoNqr8lPMNkzC5LlqHl2T2y/YvdTEqwnQY4UQSdIA6Y9VKN+
MhZYbuDjUcDjJNcOzo4fRhPQ0lXOHEYOfo85VZNMsmZwwgZcX3v9Dc6jE9nFV5KU
PcsVA4jQb3xwCGRVWRHyjmcLhz5fgDSErAyhVpj797gx31loTooVfwTLET1HI17b
ak34QqniXPYpx6ZXkbhbk7+cIX6RTNR7rwDwlv1Gae19LJFWdbTrz8q5bftL956V
1Lfn0GFAo2MPteoqimE2hX2uQq2yYzyAD22t+lT91mU+XgAcBdVh/ZP+l3iUPzz/
MxB8WKcB
=i0iq
-----END PGP SIGNATURE-----

--UczpW/TtkokV0b0H--
