Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CB4C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FD088386;
	Tue,  7 May 2024 19:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FofUSnb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716D988388; Tue,  7 May 2024 19:24:08 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80B188379
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-43d2b4d4d3eso11988481cf.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715102644; x=1715707444; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m2pKX9YjPIwEgT2+aUfe7IBTTAiaBAh1+BUptssnsyA=;
 b=FofUSnb5ssgFahD4XxScIP7z9ZyDQ14MwsMRxD4eIO9ib7QIwrGkAfRWiQp3CIqJY6
 NhXVHmWlIJ/JsHNIcKqvMBx222jUy8P3V7uRkUuUv8GL4ka2mOoreXiVr+5sItr/zncS
 DKATdlJn4Quv6cvXLzrA5x+vV1h4FGXTfMi3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715102644; x=1715707444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2pKX9YjPIwEgT2+aUfe7IBTTAiaBAh1+BUptssnsyA=;
 b=v1Ek8aDaZR/proYDHrGnTd26KebttWBFeF3iH4GSOOcp4UDxF1TkmBju6c7HMb0Du+
 /dALBscc3dr9nao6FHYuTpyLPmEF3SglHqK3kN+nFr0WSlg4Rqq3u3FsLk1Djusvmo0s
 4Ec30KMV4M/8WrI7hsDARvbcR0CdKom9Ujs7jtGptkbIw5wxigiTBzazUE9Ksj+ezu13
 B+QKUtE4UCCA38VjByBNmRDxQvEiHCICyAHhz9/yu3w4+xS3JaLaUT5OPZtenMpLLNWR
 tYUCrm5mJ2Lys+3Adiu8DPsaZLCLi0tgM7kDYGEteaLbnNUQBq5OhCzJmHY1rLg41Jqw
 47aw==
X-Gm-Message-State: AOJu0Yzh4E3lgf3hyvLNfcU09ObrhOWanGvdghmjYmK+wR7+EaRvtYaB
 0VcBO31vDcJrRpC4yMB1yf7X2dWvkSJeyQjgzE/uKK/O7NIRrxxu+A6OxeOXCn4=
X-Google-Smtp-Source: AGHT+IH5h7iwxV6fmMRz/vVoZEz3zgkm1ocK6A00dk7qaW+LsQzlCNVmxEVoAwXJXLEYQxigAKznNg==
X-Received: by 2002:ac8:5f85:0:b0:439:a719:702e with SMTP id
 d75a77b69052e-43dbf84e5ebmr3600381cf.54.1715102644523; 
 Tue, 07 May 2024 10:24:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 bx9-20020a05622a090900b0043490cc5254sm6634963qtb.32.2024.05.07.10.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:24:01 -0700 (PDT)
Date: Tue, 7 May 2024 11:23:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
Message-ID: <20240507172359.GX2568172@bill-the-cat>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
 <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IHgQEVnYOaZ2xwZH"
Content-Disposition: inline
In-Reply-To: <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
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


--IHgQEVnYOaZ2xwZH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 09:17:46AM +0200, Yoann Congal wrote:
> Le 06/05/2024 =E0 19:43, Tom Rini a =E9crit=A0:
> > On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:
> >=20
> >> From: Masahiro Yamada <masahiroy@kernel.org>
> >>
> >> This is a cherry-pick from the kernel commit:
> >> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks defaul=
t property, 2023-11-26)
> >>
> >> When a default property is missing in an int or hex symbol, it defaults
> >> to an empty string, which is not a valid symbol value.
> >>
> >> It results in an incorrect .config, and can also lead to an infinite
> >> loop in scripting.
> >>
> >> Use "0" for int and "0x0" for hex as a default value.
> >>
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
> >>
> >> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> >> ---
> >> Added context that was not in the upstream commit:
> >> The infinite loop case happens with a configuration defined like this
> >> (a hex config without a valid default value):
> >>   config HEX_TEST
> >>   	hex "Hex config without default"
> >>
> >> And using:
> >>   $ make oldconfig < /dev/null
> >>   scripts/kconfig/conf  --oldconfig Kconfig
> >>   *
> >>   * General setup
> >>   *
> >>
> >>   Error in reading or end of file.
> >>
> >>   Error in reading or end of file.
> >>   Hex config without default (HEX_TEST) [] (NEW)
> >>
> >>   Error in reading or end of file.
> >>   Hex config without default (HEX_TEST) [] (NEW)
> >>   # This loops forever
> >>
> >> NB: Scripted config manipulation often call make with /dev/null as
> >> stdin (Yocto recipe, CI build, ...)
> >>
> >> This was discovered when working on Yocto bug:
> >> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14136
>=20
> Hi Tom,
>=20
> > I'm surprised this was accepted. In the past I've wanted to avoid this
> > kind of change in Kconfig because while the empty string can be easily
> > be checked in the code as "user didn't really configure this, do
> > nothing" a value of zero is a valid option in these cases and so then in
> > the code we need a bool symbol to decide if the hex/int symbol is set or
> > not.
>=20
> For context (and what it's worth), before this patch was merged, I've tri=
ed to fix this problem with a patch of my own which only exited the config =
process when the infinite loop would start:
> "[PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig" [0]
> ... the v5 version was a bit more severe and exited as soon as an error w=
as hit, it was then removed from -next because it triggered a build failure=
 [1].
>=20
> > Today this is less of an issue than it used to be in U-Boot with
> > everything CONFIG-related migrated to Kconfig and so there's no longer
> > the question of if we missed migrating a file that defined the value but
> > there's still places we have in the code where hex symbol is undefined
> > is not the same thing as hex symbol is 0x0.
> >=20
> > Is there a specific use case you have for this in U-Boot? It's been a
> > while, but it's also been cases of newly introduced symbols in Kconfig
> > files with incorrect dependencies, where the infinite loop in kconfig
> > happened, CI failed and we caught the problem.
>=20
> For a specific example, one can trigger this with CMD_PSTORE_MEM_ADDR lik=
e this (tested on today's master):
>   make qemu_arm64_defconfig
>   make menuconfig
>    # activate CONFIG_CMD_PSTORE=3Dy but forget to fill CMD_PSTORE_MEM_ADDR
>   make < /dev/null # This emulates a Yocto/scripted/CI build and loops in=
finitely
>=20
> But, my more general use case is the Yocto dev trying to change the U-Boo=
t (or any kconfig based software) config and accidentally trigger this.
> In Yocto, what they will see is a do_configure task taking a very long ti=
me but they won't see the looping logs the detect the problem (This is caug=
ht later by filing the RAM and the build process is killed by OOM, or the d=
isk run out of space filed multi-GB log files).
>=20
> I'm sadly aware that defining a default value for this kind of config (fi=
xed addresses) is not really sensible but the build time infinite loop is n=
ot good either.

Exactly, but to me it's worse to cover up the build issue and introduce
a runtime issue instead. Something builds but then crashes at run time
is worse to me than builds fail / get stuck. Using your example,
CMD_PSTORE_MEM_ADDR depends on CMD_PSTORE and so if someone enables
CMD_PSTORE in a config fragment but doesn't define the address, the
build should not complete. Using 0x0 means that oops, now it fails to
work and might not be obvious why either.

I won't revert this change when in the future we're able to sync up with
the kernel again, but I'm not eager to bring this in by itself as it
feels like the wrong way to deal with the problem. Thanks for explaining
the history here.

--=20
Tom

--IHgQEVnYOaZ2xwZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6Y6wACgkQFHw5/5Y0
tyzojwv+PxD4nTc1QgLszcZxfnJ5GJGdqP7YqAopeAy5/lfPGSkujoK8J2XD5o20
ROxByoBfk+nnb3nXphS6cM8Y0l79Vm40w+ieQTAWseOYwgGQwKDJYZzDP93akxN2
YiOyt+H0W/8dv7LRAgE77LEEMi+GGoifqgAzpl51ooa3UzzZ5ZeTKwlYbzu+0V+W
MVHnzXBESmni37xH2Xirvwvke/F+0IUIIZX2eWz9YTiXXF1cT75Nqf7ugP4bnETQ
jhf6BUxMTL02Y0e/i5AU79xdhJi5IEv5ehkLkC//8hwDCK1IzCykn5wsZN34ukSr
/AzAcOZ7VQHUB4pmgHTZ3qkvY5knLkg68pzPdXES74q5A3BQ5sShCbINWi4SaZhG
VpNVDOolIej3dDTq3F6Y54c0JPLngoFdf9EIIb7WTZINN/Ae9IS+oda/1y8tXZIl
X1O1mXMR6tTLjGyIBQ4ud16ygYNrrWpxdSUj884p9cz0XWzIk/CoF5QLlGEsBjQA
mJSju9I2
=Vwjv
-----END PGP SIGNATURE-----

--IHgQEVnYOaZ2xwZH--
