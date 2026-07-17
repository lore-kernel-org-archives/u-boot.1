Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7E1C44515
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 17:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1056584E43;
	Fri, 17 Jul 2026 19:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sPeFLYQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E620984E4E; Fri, 17 Jul 2026 19:34:45 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41B384E1F
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 19:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a397db52c1so4423811eaf.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784309682; x=1784914482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=txpTlidiPbEe1ABVBRy6Wvxr9IInVJyHmJc/hGqN1ns=;
 b=sPeFLYQJ7mgarU6hoiXWH9t5VOPUjclbhUZ1KJ1erdjsEmUiCo+7rlr9UFOB6qmkXa
 Iy3kppbkc2G4QgnznC71BWPCM5PQPkPNMWW7r46684FUVSlaENVmzGBd4MYI5Cd4KgGw
 5NK+iKfKKk1mxtpfXCxhqBF4DpXYui38rZWZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784309682; x=1784914482;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txpTlidiPbEe1ABVBRy6Wvxr9IInVJyHmJc/hGqN1ns=;
 b=Kpm1FI+UZGbLOHgdFeSqeHjQQrlGNnDTiFHsrqySSmbnWHsgk2dxgbAG1cbg+Q4/ur
 agUEQNcn9nQp8uULM0azNmD18YmJgrnAssLe5c/mCQ0T/vpcs8rUtFmT7nCRfxbGucVH
 lRpMA+z5PHV+cVY0xMG5Syjmxt2ImIJSK+6+jAra94oTMvl31+OirvKYkM7QwI/mK3/q
 61018ZvR008w+QbRa4GoHbiAx9pN8+e8XF6mSlw9Ls/pSnpWDMUXYb80Zfybhj9PPCEy
 wXtZeUcEmNaBuzdMuLpS8cSUYVNvG9nIaYcblSJ6YPjeqFLRos12OnGEixehiRjaAmTJ
 zrpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWG0mbf+1eQv3gc6AtqWCiRvrp2xUtGb431fe08FBC+ceUiModPoqp2+kSJTKSwlJAeDK0QgE=@lists.denx.de
X-Gm-Message-State: AOJu0YzxGvZJmrVLg/vRTyNZQf1VlMEzsWw7xaYFOO62wLWxDs+Xfkbh
 +rlJkCpVgOtJi7XgTaLlNicGLuq/MGhXcacRE3aAVloReWLCiz/a9z7+gwue1+Rikfs=
X-Gm-Gg: AfdE7cnsyznoHDWhFpIowlaCWYx1sWD2FNHgd4C33JZNEGsl9TMDnxyBVcdrfzmDGRC
 IQ72pBfvn6V4kmE9ieyMk+Ap7gYtTyKpaqlHSgWmxQm3wMkrKDDsgAm7QMWwBph53NFcR78WzpI
 jg4iKURBK1DBDf4qWgP9U4Vx7lqFA0jWqKdx+37pL9e4meiImXKM7m6Wmbwg83btf3A3FEIOaMw
 exuM4L4ADqT/S+zq8vRKZCFRWiHGyTlTbyJYYzi9X6TulzTS2RPynClNncz7t9mDTAXZYCmF6eO
 e33JI1cmaLcoVUUz1G8RDEe5FJIIRcwkuLl9ZBJqnNaCvQdiR5a6tS2VhR9POeA+KLlcZ/C8mhe
 ftctkwpsXlZHT+9G3mYxkk02r3nQvEHrLnhcNx+fhjWtCs189Ep4XaLDrxWJMt9PkKLpZ/0GpEL
 PSpr8PPlo9cOhCKtH8VOLjKqT/cD75vOAxd0hk72RKmQXJqw++NGI08dd/ybTkR3a9jDXgjawQX
 NSYMX1Xlqm8WOmk6VQZCJrS5TskDGUAPJj7Sg==
X-Received: by 2002:a05:6820:198c:b0:6a3:97c6:f80f with SMTP id
 006d021491bc7-6a53684a5aemr1517050eaf.44.1784309682431; 
 Fri, 17 Jul 2026 10:34:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e15fc64sm1956213fac.8.2026.07.17.10.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 10:34:41 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:34:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: liulhong617@163.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Makefile: depend on OF_LIST dts sources for
 fit-dtb.blob
Message-ID: <20260717173438.GT749385@bill-the-cat>
References: <20260713074539.32875-1-liulhong617@163.com>
 <CAFLszTjMJq2C02Xc0YTX0+5Q-DOPK+zrKn62PwU1qE+vPBASCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GsX/r1+oWjCD+lFx"
Content-Disposition: inline
In-Reply-To: <CAFLszTjMJq2C02Xc0YTX0+5Q-DOPK+zrKn62PwU1qE+vPBASCw@mail.gmail.com>
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


--GsX/r1+oWjCD+lFx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 08:11:42AM -0600, Simon Glass wrote:
> Hi Lianghong,
>=20
> On 2026-07-13T07:45:39, lianghong617 <liulhong617@163.com> wrote:
> > Makefile: depend on OF_LIST dts sources for fit-dtb.blob
> >
> > When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
> > mkimage with one "-b <dtb>" argument for every entry in
> > CONFIG_OF_LIST.  The make rule, however, only listed dts/dt.dtb
> > (i.e. the CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:
> >
> >   fit-dtb.blob: dts/dt.dtb FORCE
> >       $(call if_changed,mkimage)
> >
> > Because FORCE is PHONY, if_changed ignores it and rebuilds only when
> > any-prereq or arg-check is non-empty.  Editing a non-default dts in
> > OF_LIST rebuilds its .dtb (tracked correctly via fixdep), but that
> > .dtb was not a prerequisite of fit-dtb.blob, so $? stayed empty; the
> > mkimage command line was unchanged too, so arg-check was empty as
> > well.  if_changed therefore skipped mkimage and fit-dtb.blob kept the
> > stale dtbs.  u-boot.bin, which appends fit-dtb.blob, then shipped the
> > old device tree and the dts change did not take effect.
> >
> > A previous attempt to fix this added every OF_LIST .dtb *output* as a
> > [...]
> >
> > Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> > Signed-off-by: lianghong617 <liulhong617@163.com>
>=20
> Please can you use your real name in the Signed-off-by tag? Also we
> don't normally use bullet points in a commit message.

We don't (nor does the linux kernel) have a "real name" policy.

--=20
Tom

--GsX/r1+oWjCD+lFx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalpnqgAKCRAr4qD1Cr/k
CkK6AP4poGgNaa9tibKb1w0i4weEjmMa+sgeCypwtMH7vMW8NwD/ZbUY8pLEBJ+o
DIKMBSTTKl0TcCmbtH7SShwnDITTLQM=
=KbU7
-----END PGP SIGNATURE-----

--GsX/r1+oWjCD+lFx--
