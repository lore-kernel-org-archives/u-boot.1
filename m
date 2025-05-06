Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D09C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 19:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A1381FAB;
	Tue,  6 May 2025 21:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rl1j2VtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20183820EB; Tue,  6 May 2025 21:25:01 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2DD81F66
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 21:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3fea67e64caso4403249b6e.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746559497; x=1747164297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aKHLVCw1qGB/9CpRCkRj6OrVYO30u0dmxz18fqG7bqs=;
 b=Rl1j2VtY/21Oa4uLeCLaUWMxTRzOZQ5Vz8yL+wh5Lb9mrc4hpyN3DhmM2JLdjMS7Ro
 gcHeMzXf8SXum/s9qHiajTfKaPRXB+Ok101gpfJc1e/OTiWYheH93jJ08bboDm83lyaW
 TwFF9p/YqLYED/r8te/4mOIT3PJPx65t9nc2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746559497; x=1747164297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKHLVCw1qGB/9CpRCkRj6OrVYO30u0dmxz18fqG7bqs=;
 b=JHXiA2jeqBoljoVO+pTBKi979kWY8HtF0/HCnQvWvMVU091b8JPtWO7V/Gk28oquBB
 5JhJg73zERXn/rTIRVbpMOb4XIv5Jn7LuxB4WIQ8WK/7FneD7RtXyqHekWLwSNDMy5vX
 ZDV6ESepL0BbHMfiX/x38iX+qwEkXnp3FKbh59yrnXjCE15SEwDO1Kc9pUUHjmChhXq/
 Ozvjo0knjpJTI86mnEmWotD7qcYbdidwZGE35+kjrB8jMI1axG3bVAq8xdI02YoVSed6
 F5Bs3L/96bGxQuKFRiqI+6JsZXfers+d/4t8b6u644qhNvaHsOSTTFMWz3WUlv3Pocq7
 KGvg==
X-Gm-Message-State: AOJu0Yx7sFrjofjuYEcTSaI3uTgCvxqljWs8C6+0Ug8W9/C2Zv7oRlB+
 fwsm8TuBNPDQ24xT0jHKlNO9Vso/p4CjNzMbQKr/kWF6ZW6wwGZYP3ILc9GK7StmJGy7NbicHfM
 N
X-Gm-Gg: ASbGncuoHtuIQIMOKIAPUZwF/MS87erLxsqUChiMGyR6MQXRt/LQgYl7l4stJLB1UnU
 EtdTRKO6GA3ppaZAgUKrFhfeB0iDGU8H/g3BDNvdOb9acL4Z69fAq2h7t5Yjh13177j/lIK1Z0Q
 DTi1QSQt8bFEO/NFSXX2QrJnjFMrm8yC2IhKV2fl2LuheS9DXsa+Aut4Dy0AscSjqPtckEHwZhw
 ScNEQR4koHjjafurW37pQDN6D4T5prQ+rWKjkYMHBrQuX1pI1Ntc+sn4o4d9GNt6WHq6bVt7onL
 ajenTBdz0A5L7MPyhPOsJ1WCNdn4tpQ7NmSTorGbBGukQXQZZhNw6f5D1UKf+EZ73BWrw1kl1Es
 nCg==
X-Google-Smtp-Source: AGHT+IGiimz8+g3YloP1aRYw62UbEgbyQSUEX/Lybho3atyhbdGm+jFJ1OO/9Rr8ZwuoFbVEGRLP5g==
X-Received: by 2002:a05:6808:318e:b0:3f9:d5a2:899b with SMTP id
 5614622812f47-4036f0db55dmr425652b6e.38.1746559497595; 
 Tue, 06 May 2025 12:24:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f32fcdcsm56245b6e.17.2025.05.06.12.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 12:24:56 -0700 (PDT)
Date: Tue, 6 May 2025 13:24:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/11] cmd: test: add support for =~ operator
Message-ID: <20250506192454.GF5430@bill-the-cat>
References: <20250506141035.385756-1-ravi@prevas.dk>
 <20250506141035.385756-2-ravi@prevas.dk>
 <20250506164931.GA5430@bill-the-cat>
 <20250506165221.GB5430@bill-the-cat> <874ixx5zja.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uBfokrJq0LClqggA"
Content-Disposition: inline
In-Reply-To: <874ixx5zja.fsf@prevas.dk>
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


--uBfokrJq0LClqggA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 09:07:05PM +0200, Rasmus Villemoes wrote:
> On Tue, May 06 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, May 06, 2025 at 10:49:31AM -0600, Tom Rini wrote:
> >> On Tue, May 06, 2025 at 04:10:25PM +0200, Rasmus Villemoes wrote:
> >>=20
> >> > Currently, the only way to make use of regex matching in the shell is
> >> > by using "setexpr [g]sub" command. That's rather awkward for asking
> >> > whether a string matches a regex. At the very least, it requires
> >> > providing setexpr with a dummy target variable, but also, the return
> >> > value of setexpr doesn't say whether any substitutions were done, so
> >> > one would have to do some roundabout thing like
> >> >=20
> >> >   env set dummy "${string_to_test}"
> >> >   setexpr sub dummy '<some regex>' ''
> >> >   if test "${dummy}" !=3D "${string_to_test}" ; then ...
> >> >=20
> >> > When CONFIG_REGEX is set, teach the test command a new operator, =3D=
~,
> >> > which will allow one to more naturally write
> >> >=20
> >> >   if test "${string_to_test}" =3D~ '<some regex>' ; then ...
> >> >=20
> >> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >>=20
> >> We should also mention here (and then in docs) that this the same as t=
he
> >> =3D~ operator in bash, which I only learned about now as part of answe=
ring
> >> my own question of "Are people going to expect =3D~ to do something
> >> else?".
> >>=20
> >> With that,
> >>=20
> >> Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > Oh, and we should update doc/usage/cmd/setexpr.rst at least and we
> > should have one for test as well, but don't, yet.
>=20
> Yes, if test.rst had already existed I would have updated it, but I
> didn't feel like writing the whole thing from scratch until I had a
> sense of whether these were going anywhere. I'll take a stab at it,
> including the bash ref, but I'm not sure what you want to put in
> setexpr.rst? Perhaps a reference to test.rst for an overview of what
> regex features are available so they don't need to be repeated?

Yeah, for setexpr.rst I would go for (a) making sure it's correct and
without subtle bugs (as you just fixed a number of them) and then (b)
noting that the =3D~ operator exists and link to the new test.rst

> Another thing I considered was to have the 'test foo =3D~ ...' thing
> populate shell variables $1, $2, ... with the capture groups, if any;
> and possibly even $0 with "what matched the whole thing", as U-Boot
> doesn't really have anything sensible for that.

I would ask what bash does here first (are things saved anywhere?) as I
assume you use this feature there. And then a second of how useful the
captured output is likely to be outside of debugging a script you're
writing.

--=20
Tom

--uBfokrJq0LClqggA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaYgIACgkQFHw5/5Y0
tyyvjwwAndW/waF76DPJgtmArX4fTCKh/yFc/ixRDdsfMeAfdQZL2PZH7Th26s60
bfbz4E8ypKJ7Xhr8PuYP2K/+r8+VXme8lVui5MavlvVQ5S0z/AtqHrh8QWB97wdT
HRqgzMJ18JEmt5btoGlJG5oXeSNidZZiPRisy/AjPjrOArMOlJJ1wdlklMjbALsA
+lMr4JR6lqUo42vusiYF0K4hGDfMC2utuiFATeVMuL0SOc+jm0VI7U0M7gVNpDu2
2jKwFWNKLLnzU1nrlltWKxUp9UtEsmAyfSSHV3Z60CiPgqb3P+TJhk7JLI3tMSoL
WCWZ0NBRRy9C1d2bbGxYYCTqatWiT3nq3BvXalDyub60bomzH1E06+nD1MHxcWpI
0VmmS7zt9/C9rWF1pmU770YJlZZLct1zEWpTYsCKcirXKnq1edoriuw3c14TnL/L
2Kto+/Kl0CKYJzqkzoGkuaPcoYypvfkbHFuAwvrV1+O/WSZfD16xNclRT2BFwpBd
g7adP9R4
=mZtO
-----END PGP SIGNATURE-----

--uBfokrJq0LClqggA--
