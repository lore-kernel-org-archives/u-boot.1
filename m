Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0136CC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E885803CC;
	Thu, 24 Apr 2025 20:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VRIrY6ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E588056A; Thu, 24 Apr 2025 20:52:59 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E3180194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bceb93f2fso1443534a34.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745520776; x=1746125576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LYriWJxTYR+Dc18QvvXVSEZ1S1mPCQeglbdjOHQEmfQ=;
 b=VRIrY6yeAJPNtsRAYpOlVXmE9f1qzSdjY910nTKzsr34ysbJQC+/I+ThIPfxheWx3G
 V3iLhY4epu7yPX2+9W2sORJ+WzliiQc4unMM1JdmWIK3I+7Dq1fs6rvYhpQXpwGIwYER
 ZXDHyGDokVtdYebtuvePOpRJJx9Aqxq2wOVxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520776; x=1746125576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYriWJxTYR+Dc18QvvXVSEZ1S1mPCQeglbdjOHQEmfQ=;
 b=PwSmfNF2QAVw6kLuyT7564kHjdYZx2FsrOcsUJP/QWdSWhPbGffVqZteNCIPYER7XL
 yb+mEZuziWEogPeMm55od3tDh7KFovdz5GvMgdmQrdqzPkM0FLdT4HqGDQzjkqihqb/d
 HMTFl+7tJmuLOeZfB93YDfuEWViA7aJ4XV6XVwnl+/aPldd/3nxaKzyRBTeGWofyF+mx
 TX0nvCHZy9KqCOlGsrk/A0RaQSYfUpv6swfGjiV5mHvCKTq2sOHiP0CItLvndvVZoUUl
 YsFYWnycynOgya7urs4GQu7jI1JNTd5UMTWwtI/rFECAPM7Cu39Cdme6sFx3taio56f6
 aegw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxCMGHTj4yVYj1PD3vwGpa48uLAuOHwVqM9hAOj9fPsX8TlYl/aEo6i66jdIXgnvymZISM3Y8=@lists.denx.de
X-Gm-Message-State: AOJu0YxkZzvs30XoFEmR+ThFIbiWnxLErDDq3XG6KDOvdejfesGhE6lC
 5xvokAqFPyQ3K/C7czL4810KlVJx0dN0N7KPbaSSGsGnMRv4YezQ5hUT9n7pDPM=
X-Gm-Gg: ASbGncv2G2hG+3TscZzdl2Pi9vxP9fFOrH5WQs7QAG0XKE1QhCFWTXiOL8BMTADipY/
 LbcZBmRoXok580CbLWKCScuamrX9ZN10D+8E909w1l98FIqN856rYrQi2RLFjWsbmKaWcy7kqcY
 yXg6LfDJF4zsEuxNln+NO1GPqXR3PT1uDWlQKTCPCToBmYBFDPa888fdQua6Hj9A8vuVyZGpuTk
 ruGV+cKXCIaYNLp5xqA+g6byJVukHKYpix4x6qKen54hJSvWR98AVbXryKdqtoNjrLx29hmnVtM
 2LHwRWzhEevE3uU+fS7K8igITppPsZRfRZxicv9tC2dK7ZiRAK4SabpN2yJJOD34eC0BH7ipYet
 VbA==
X-Google-Smtp-Source: AGHT+IEwhnAXL9235zAuFv04gXbSGaRwmSKm0kiDPvcOQU8Rwjt/pmtX5qXiq/oWbQgWde5R8m/bGw==
X-Received: by 2002:a05:6830:1db1:b0:72c:4023:aa19 with SMTP id
 46e09a7af769-7304fa77244mr2036057a34.7.1745520775998; 
 Thu, 24 Apr 2025 11:52:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f398cdesm336181a34.62.2025.04.24.11.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:52:55 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:52:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide
 more explicit error for key-name-hint with path
Message-ID: <20250424185252.GO5495@bill-the-cat>
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
 <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
 <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
 <CAFLszTgDJsO5UFVhpWfo3zoLmjC_o=GnONjQeeWU=mejfMbNDQ@mail.gmail.com>
 <f2a278ff-ac32-4b12-a3c0-d93709be887e@cherry.de>
 <CAFLszThWCS470MOkkOniCboBdq+pD5o_Fi971ruDDUUtR372iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p6K/cIx32m+iQTz2"
Content-Disposition: inline
In-Reply-To: <CAFLszThWCS470MOkkOniCboBdq+pD5o_Fi971ruDDUUtR372iQ@mail.gmail.com>
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


--p6K/cIx32m+iQTz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:32:30PM -0600, Simon Glass wrote:
> Hi Quentin,
>=20
> On Thu, 24 Apr 2025 at 02:14, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> >
> > Hi Simon,
> >
> > On 4/23/25 2:27 PM, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Tue, 22 Apr 2025 at 02:53, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > >>
> > >> Hi Simon,
> > >>
> > >> On 4/18/25 7:19 PM, Simon Glass wrote:
> > >>> On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net>=
 wrote:
> > >>>>
> > >>>> From: Quentin Schulz <quentin.schulz@cherry.de>
> > >>>>
> > >>>> key-name-hint property in u-boot-spl-pubkey-dtb binman entry may c=
ontain
> > >>>> a path instead of a filename due to user mistake.
> > >>>>
> > >>>> Because we currently assume it is a filename instead of a path, bi=
nman
> > >>>> will find the full path to the key based on that path, and return =
the
> > >>>> dirname of the full path but keeps the path in key-name-hint inste=
ad of
> > >>>> stripping the directories from it.
> > >>>>
> > >>>> This means mkimage will fail with the following error message if w=
e have
> > >>>> key-name-hint set to keys/dev:
> > >>>>
> > >>>> binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home=
/qschulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/u=
pstream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA ce=
rtificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such =
file or directory
> > >>>>
> > >>>> Let's make it a bit more obvious what the error is by erroring out=
 in
> > >>>> binman if a path is provided in key-name-hint (it is named key-nam=
e-hint
> > >>>> and not key-path-hint after all).
> > >>>>
> > >>>> Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb ety=
pe")
> > >>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >>>> ---
> > >>>>    tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
> > >>>>    tools/binman/ftest.py                                    |  7 +=
++++++
> > >>>>    .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 +=
+++++++++++++++
> > >>>>    3 files changed, 25 insertions(+)
> > >>>>
> > >>>
> > >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >>>
> > >>> The change log seems to be missing?
> > >>
> > >> The change log?
> > >>
> > >> Between v1 and v2? It's in the cover letter of the series, this is h=
ow
> > >> b4 handles it, not per-patch change log.
> > >
> > > Oh dear, that's harder to work with. I believe someone is working on
> > > b4 so perhaps that feature could be added?
> > >
> >
> > https://lore.kernel.org/tools/CAOiHx=3Dm8tPANa+5A2dohEdkz48aPgH1g7ZXvF4=
uLmEu+SCo6DA@mail.gmail.com/t/#u
> >
> > seems to indicate it's possible to do this manually within the editor
> > when doing a git commit, by adding stuff after a --- line. I checked,
> > seems to be working fine indeed?
> >
> > The cover letter will still have a new changes entry, so I guess this
> > will somehow duplicate the work, with having to list the changelog in
> > two different places and making sure they keep in sync somehow?
> >
> > Note that you can also do a
> >
> > b4 diff --compare-versions 1 2
> >
> > which will do a range-diff of both versions and you'll see differences
> > for yourself. Note that the same limitations as for the typical
> > range-diff apply, namely that if the changes are too big, it won't
> > attempt at comparing the commit diffs, during rebases the git context
> > may pollute a bit the output.
> >
> > This seems like it's bothering you, but you're the first to complain
> > since I've started to use b4 a while ago. I don't mind doing it, but it
> > would be nice to know for which subsystems/projects I need to do this
> > (and hopefully remember doing it :) ). Should we have some documentation
> > for that maybe? And not specific to a specific tool used for contributi=
ng?
>=20
> It depends on the size of the series, but if the change log is not in
> the patch then I struggle to match it to the patch and in practice I
> don't really take much notice of a change log in the cover letter, or
> perhaps of the patch in general.
>=20
> But I'm not looking for people to do manual work.
>=20
> My question was really whether b4 could add this feature, if people
> are starting to use it more, as I had understood that someone is now
> working full-time on Linux tooling.
>=20
> The feature is in patman, which also keeps the change logs in sync
> between the cover letter and the patches. It isn't that hard to do.

You're welcome to bring this up as a feature request with the b4
maintainer, but it's not a requirement for U-Boot. But I believe what
Quentin was noting was that you could get the information you require
instead via b4 diff.

--=20
Tom

--p6K/cIx32m+iQTz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKiIQACgkQFHw5/5Y0
tyy8/gv/eqQsrKqP0hihmE7Gz0KehNi+9wwHdn/xlkUQ6tTnzGYGkoXFimtM+A+B
o4+BpRIIHP1zYuhG0KLC1mytWpCsOZxUWfl0CPnuzRxXy8zMucrfB6BK3a57N5tJ
J0IPopTfipVau9nBya0b3GNXKft0EZ6gP0Y10MAb/4G7SOy98oVFzUyPVjqDeG65
5t4e41y1yybNTCanzerOuZwaZ3M79ISh4Sc1CjocJHjMpj23NzNSjH+lM0kjfnBU
080yvG/uhzH7vkPltugNZvm6NSzTRCLa9Pk8WuCTR4ORFLycyOdMJFwlZYqOImKK
1g9PGnE2WeOvMkpquxoc+IC6hWCHNDvGLZjOVc6D8dL9nhzokpQdEtOY4ARxvA2/
wRO4v5A1k+ZcqEn2ZmPi4VG8EAAR8DO6wE1hywExLFCb3TpTcHlvKRusnNIE4U56
+2Rn/A1qqdkGIzG+g0AInxPTwKo1f7cTBc3opGCePXNEl0eg/rY/n62zsFgjE3tT
F6KoW7+i
=m9WR
-----END PGP SIGNATURE-----

--p6K/cIx32m+iQTz2--
