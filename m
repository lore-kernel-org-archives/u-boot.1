Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3208DC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AED680107;
	Mon, 10 Mar 2025 22:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BcP+BxT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B2DC80FB9; Mon, 10 Mar 2025 22:38:05 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E46F800C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so7280310a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741642678; x=1742247478; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ut2imbayUda6V3B9u8VBUf1EMk1kWUtNqWdHh6PjE/Y=;
 b=BcP+BxT1BXdNDIRHi7GhzmEkqAB3WJnRQ38ASzpbwVYI3Gyp64ba8ZcuqKswZc3tZY
 pp3v7dqwJxHGZFiv5oLOXxazN+IlyzWc+Fq7VgFYtdmmPcF2gigMay8eTc4Z/YECtQGX
 0RmeaNKCthwxmAcXrWJccX8DNczRcgCgKod0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741642678; x=1742247478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut2imbayUda6V3B9u8VBUf1EMk1kWUtNqWdHh6PjE/Y=;
 b=otQVug835uG6XAqDmxpj01EX1Pzsj0nl8GiiGp+ygxNWeNObssz6UH8TyLe8wSp8Wn
 /C+FHjn79QZVOSAOuouHPxRPBnNPefY8GTsMANRhTp7YRmDifBm6P8CU6gjalhm31h78
 r7AJA8FmMoQGIdI9i4QhPTsf3h18rBYCbO+/pJ2RWn1mymlLr8be3K5xMVLZE2LPZ/Uk
 yrxfO5Hu96+KITUeLG6H4drwaSnY1BqvuxeO+chDVgCPKo+pleEuxZxibRmfZX/el6FS
 n9j/gp7O57Wkp5Y1nrnApTollbGqtB3n2zr/FOmW++iwzzV+K/sgv5IXNCHuN0nvRq9x
 SjgQ==
X-Gm-Message-State: AOJu0YwfjqP/wHe3ybbIuXqdztJtplPVMygtRaFN8oMKlj9dvvEtjnnA
 tfeL9C4Sts02+2zQ+/4fIuLyUfLspQU7pJRBZ4eGU3wnHpMoLUzZqwi3JcfhS1M=
X-Gm-Gg: ASbGncvzQjPptj8x0AXQ/tFdBtF+678PF7GgNW5CbsMl8wyZnoYCx1Vr1gg9eg8cUfa
 Y9YF4IJJersMwcWxBWYgW/y9ohDvo+ZB+VlDhY9KabTAdhICnhyviBpZ6/9yVx1TQ8Lf9BSxv3+
 w6SkuuBWnLdXJitnLvg5ERjU1yvNPwM9+6dnEmPvHbtsroYJMQ2rOBdW0z6V1KSyN4kRQuGfG4Z
 Ot30jWcCCX16vuXsSEO1H+lvCreDey9UUz124y1GFMv7qpOX3QDpw7HPZ6E4ewRKtiNiwt/jFYd
 GM4L5B43ry1rytPi15hNNy+Kx5DjcalKfUVKwju+p4sKnw==
X-Google-Smtp-Source: AGHT+IFRm6B8PccFHn8NwiaIMDBnorq1GbK3UcTF6YfFspdxMtzO8OKJfrtQUIG2ND+vUv5mQx8+7w==
X-Received: by 2002:a17:90b:5110:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2ff7ce7b375mr22230198a91.5.1741642678512; 
 Mon, 10 Mar 2025 14:37:58 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91be9sm83216905ad.179.2025.03.10.14.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:37:57 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:37:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 12/12] test_fs: Add exfat tests
Message-ID: <20250310213754.GN2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-13-marex@denx.de>
 <20250310153055.GI2640854@bill-the-cat>
 <6d68d2f0-c969-43f1-86c6-1ccbf039291a@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uWfO+eW6Cyfwbs3P"
Content-Disposition: inline
In-Reply-To: <6d68d2f0-c969-43f1-86c6-1ccbf039291a@denx.de>
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


--uWfO+eW6Cyfwbs3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 09:37:36PM +0100, Marek Vasut wrote:
> On 3/10/25 4:30 PM, Tom Rini wrote:
> > On Sat, Mar 08, 2025 at 09:12:16PM +0100, Marek Vasut wrote:
> > > Add tests for the exfat filesystem. These tests are largely an
> > > extension of the FS_GENERIC tests with the following notable
> > > exceptions.
> > >=20
> > > The filesystem image for exfat tests is generated using combination
> > > of exfatutils mkfs.exfat and python fattools. The fattols are capable
> >=20
> > Did you mean "exfatprogs" and not "exfatutils" ? But we need to update
> > tools/docker/Dockerfile to list the tool there.
>=20
> It seems the CI container already has the tools in it ?

Implicitly and not explicitly then.

> Where do I update the docker container, is that tools/docker/Dockerfile ?

Yes, thanks.

> > > of generating exfat filesystem images too, but this is not used, the
> >=20
> > Presumably because "fattools mkfat" seems to have further external
> > dependencies and so would be more of a pain to use.
>=20
> I don't think it does, but I think we should stick to tools which will be=
 in
> production systems as much as possible, and that is mkfs.exfat from
> exfatprogs . The fattools is only used here because mkfs.exfat cannot cre=
ate
> an image from list of files.

Well, I tried "fattools mkfs.exfat" and it wanted tkinter to be
installed, so that's why I'd not bother with it.

> [...]
>=20
> > >   test/py/requirements.txt          |  1 +
> > >   test/py/tests/fs_helper.py        |  8 ++++++--
> > >   test/py/tests/test_fs/conftest.py | 20 +++++++++++---------
> > >   test/py/tests/test_fs/test_ext.py | 20 ++++++++++++++------
> > >   4 files changed, 32 insertions(+), 17 deletions(-)
> >=20
> > We also need to update test/py/tests/test_fs/fstest_helpers.py to know
> > to call fsck.exfat.
>=20
> Fixed in V2, thanks.
>=20
> > [snip]
> > > @@ -64,6 +66,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=3D=
None, size_gran =3D 0x100000):
> > >                   check_call(f'tune2fs -O ^metadata_csum {fs_img}', s=
hell=3DTrue)
> > >           elif fs_lnxtype =3D=3D 'vfat' and src_dir:
> > >               check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/',=
 shell=3DTrue)
> > > +        elif fs_lnxtype =3D=3D 'exfat' and src_dir:
> > > +            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=3D=
True)
> > >           return fs_img
> > >       except CalledProcessError:
> > >           call(f'rm -f {fs_img}', shell=3DTrue)
> >=20
> > A cleanup to use fattools in both cases would be nice, as a follow-up.
> See above, I am not convinced we should go for fattools all across the
> board. Do you think we should ?

In that we can't drop dosfsutils entirely, it's not a big deal either
way.

--=20
Tom

--uWfO+eW6Cyfwbs3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPW7IACgkQFHw5/5Y0
tyyIdwwAlwK54TAC/hLPEycwb0ivCvVeu4Q1Sib+UX2c7NvacsC6X79eR+5PL+5W
NNuVjoU5Wum/EqHST1PxmN/QgQfvWmTTb3veLDuJU+WKOp125b7j5SLRu1/Aq/lm
MTnUseVDikkUKZZ9pbwENEk1WXlOhILuWx2TylcAD+9kxR+5Dgiw3e33xRthEMcv
aUJh/ktXFtjtKCzqr4RIGFgOprclq2LVc7t5tRtc+L/VNFjEypU+dvscT646qLCX
eZJgHiBkxt44e3uBKLhyDR04iGnqe6u3u7qbIN8QqoTt4KSCWF8x5LuYrcL+b3GA
2Vyql1mzb2/f7hf3DFMauzYLCY1tvBHjuLaPHiOYAXM1EQM+JyJC4QmfoZYE73aS
aTbICftc37FtDGvUkOcsTQxtylfRiNJoeppLz5K1iBeVU8yQD8JNmj/qQcPsi9GE
88ZxuiUjHXyTlsRZohR5f0ZfHj3R4WqQjgLFHzDcFj3YB2Vv8P6YbTx/DDE3edj6
60jgr+N3
=6DzM
-----END PGP SIGNATURE-----

--uWfO+eW6Cyfwbs3P--
