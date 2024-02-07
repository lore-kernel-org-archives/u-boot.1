Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED67C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 14:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB6187C4C;
	Wed,  7 Feb 2024 15:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l5xvcf9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6281287CE8; Wed,  7 Feb 2024 15:13:12 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BE88789B
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 15:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-783f3d27bfbso28238485a.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707315188; x=1707919988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i1DULXHSQJEBZ9HVEa/DBdbpiQM3zkqr1JW8n8FR0vA=;
 b=l5xvcf9dgsLSsBbvZXVl3Eelt52k2wB2m+ZUTOkUoGFGKEp2ShFR1zOzm3B6A5DMbx
 7WYTQ+VgfcGF+tW5KcEIxsnGhzsN8mnujiUPRjiiMlZciZsPFvHQeYi4qALDtJKxxB8M
 GvXsl+ndAXfutE/c22cKJ0LMUS4llswEiS6/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707315188; x=1707919988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1DULXHSQJEBZ9HVEa/DBdbpiQM3zkqr1JW8n8FR0vA=;
 b=fGKhk+nPYXZY8TG2Tonnqk7IiGVD806ASIsgOyAB2Exwb8OKD9Ry16DQ9jFjq8UBw+
 a5a/I+0AQPJSr6DyCJCrioOBXnrJFxNaGvTXWWbSOG1emPZjprfur0Ov7/gGEPAXNnyi
 0jHtSvDqQfDQ2vgpoYGbKBMjMOesL1xs/Fvr+ZZ+385+LjWuYWZH7/orEz/W3YLMKfEC
 FtAz2/Ac6I/Jn1XUo/9HFg1cT0dkF+KNgAcAwUmPCWAbwQ12Hs8SwFABMyaDkleQDuDk
 xnvcediSWLpvT/ZMePVZU0imwQMNLbQ2d1/y/sdYUOpmnKXEfhHFYQjGTG602JVJQ5GV
 YiuQ==
X-Gm-Message-State: AOJu0YwKz8biujiFiGnuw79gEudXB3AszeHYYGODBSKS2eE2jZAXkG2c
 b6JIBSYciLWg5qwB7lLoVK5M/zinD1xgQJwp6QhM/Q9kLjrXIbsc82R7UroE3Ok=
X-Google-Smtp-Source: AGHT+IE54m2FXISSXFD+P8jmwHPnNrsNMmYADWJQoFlwCqi4OSkJkpAJCm7K3bDYuj33rU1Idd3Ytw==
X-Received: by 2002:a05:620a:39d:b0:783:d13c:cfa7 with SMTP id
 q29-20020a05620a039d00b00783d13ccfa7mr5773147qkm.22.1707315188659; 
 Wed, 07 Feb 2024 06:13:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 bp18-20020a05620a459200b007854de874a2sm542898qkb.103.2024.02.07.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 06:13:08 -0800 (PST)
Date: Wed, 7 Feb 2024 09:13:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [RFC] Drop md5sum, crc32 and sha1 cmds in favor of hash cmd
Message-ID: <20240207141306.GX1152441@bill-the-cat>
References: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
 <20240207134813.GV1152441@bill-the-cat>
 <CAByghJbnL=W0p=yu5S_6NChAqobOF6rK92m=Dh_rY5e_=1JvGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGJSM2tWXjh1BKwA"
Content-Disposition: inline
In-Reply-To: <CAByghJbnL=W0p=yu5S_6NChAqobOF6rK92m=Dh_rY5e_=1JvGA@mail.gmail.com>
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


--pGJSM2tWXjh1BKwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 03:10:01PM +0100, Igor Opaniuk wrote:
> Hi Tom,
>=20
> On Wed, Feb 7, 2024 at 2:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Wed, Feb 07, 2024 at 02:00:16PM +0100, Igor Opaniuk wrote:
> > > Hello,
> > >
> > > I was playing a bit with different hash functions recently, and
> > > it turned out that md5sum, crc32, sha1 cmds just duplicate
> > > what is already covered by generic `hash` cmd.
> > >
> > > =3D> sha1 0x60000000 0x200
> > > sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2=
483d0e1437
> > > =3D> hash sha1 0x60000000 0x200
> > > sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2=
483d0e1437
> > >
> > > =3D> crc32 0x60000000 0x200
> > > crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> > > =3D> hash crc32 0x60000000 0x200
> > > crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> > >
> > > =3D> md5sum 0x60000000 0x200
> > > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
> > > =3D> hash md5 0x60000000 0x200
> > > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
> > >
> > > Considering that most of them (besides md5sum) are using the same
> > > int hash_command() function under the hood, but have a lot of duplica=
ted
> > > code for handling params, does it make sense to do some cleanup and
> > > drop all them in favour  `hash`?
> > >
> > > I also plan to extend usage info for `hash` by adding a list
> > > compiled-in algos based on hash related compiled flags
> > > (CONFIG_SHA1, CONFIG_CRC32 etc), so it's clear what algos
> > > are available for hash calculation.
> > >
> > > Comments/objections are welcome!
> >
> > It would be good, implementation wise, if each of those commands was
> > just a redirect to hash ..., similar to how "load ...." will call the
> > right filesystem calls. Does that make sense? Thanks.
>=20
> Sure. You mean something like this?:
>=20
> /* cmd/crc32.c */
> int do_crc32(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
])
> {
>         return do_hash(cmdtp, flag, argc, argv);
> }
>=20
> /* cmd/hash.c */
> static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
>                              char *const argv[]) {
> ...
>         /* if not true, we are called from crc32/sha1/etc alias */
>         if (!strcmp(argv[0], "hash")) {
>                 /*
>                  * Hash cmd is used directly,
>                  * Move forward to 'algorithm' parameter
>                  */
>                 argc--;
>                 argv++;
>         }
> ...
> }

So right, sorry, I didn't quite follow what you said before. If there's
further cleanup we can do with how hash_command is abstracting things,
yes, lets.

--=20
Tom

--pGJSM2tWXjh1BKwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDj+sACgkQFHw5/5Y0
tyzAUgwAiA9cWHJBX1fUfCltvDegs2H6S6glg6i4L/oJynPIOeMzOtixxyRWnbmQ
XwJad6mugTk/1h615298zKERMEzosU4udajSMff/Ni859xfP66u8CJB+wBX8w5tZ
GHBaKsv/BZZ2RaLi4vxMm8eJqPUBFCDtmmQZHJU9yWStuWGT+qUTC4USQ9KFw2WP
wLt4qlWOW+t7MWPdZD4zz0PHQ3lZFqbLB55VG7R49cpDiSgFR4IOCgszF33zlipS
BZ3S28WwybDQCPTADLJ4UDk/llMDjcPFNST8xYgYoD1c3bcEUCf6d3+PLUIv5vgP
GkgwnJHkm8nR0/8jx3zsyfsb0wJSxM96z6/cFYAUZIS7ORkM+//xv6MP1AlZ+zHq
o47zueoPOkRamwXGJ1IbnKPC8Al01VMCPw3AwzI0Udv3+zTQs6BymdYngrn7xo+/
GqlJg7tQQCtys8Lp9uhZ09nYjcaBPzxJmIq04MVMwdPYS6MFBCunLrvErhQFc2fF
W2BDMlM4
=vLbv
-----END PGP SIGNATURE-----

--pGJSM2tWXjh1BKwA--
