Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB9BCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 21:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B386C848BF;
	Tue, 16 Jun 2026 23:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oaNOQL9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBC4848DF; Tue, 16 Jun 2026 23:52:14 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A385848BA
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 23:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso3239171fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781646731; x=1782251531; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DPGmWtbfCdjDJ0kVcfbgmRRfdoa75B9vXR0XQPeubxA=;
 b=oaNOQL9TJtCtWLyi1XTbhucurX6rk4SrNlQLxa7R+bqmFVjMxcYjyOilyDRBvOvLmA
 rjCa0k/oL1dCfkTOPFVGvVcuryfyNJk9tjt1Q5FhZYpP5MFVedEt6+y11DXhTiB71NIh
 7MrbHJXzOIAgCt+VKZjBPZ3HkhevQBqYeaJJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646731; x=1782251531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPGmWtbfCdjDJ0kVcfbgmRRfdoa75B9vXR0XQPeubxA=;
 b=kXhAa1wTslUy9e3DXXhXXcowfXJrxDOKh3f9LiYfL+q44jHVBQFlA/3+wjw2NUJUu2
 RNcZtFXrzbJoHVXHELNWeuiZjr924hiEykz+FTmP15YjR3Qzwh+DJvM4wnb+8f95Bd7s
 AvBf7+0aiDRUDBOxMgtJgI0O5qFHl/lxSMcDoi6HN6q6tNd8Cq9RwIwSwsC7W2FCNtEQ
 37K94kc7hR1gVTMv3Uw1NCBDtpO47VrTTRmMkzRKUI4UxcrZ/wtCYRs7FU+anMMAqhDc
 xAQaVfwbFFb2qzjHSbOeCB2haclOH7jIvUnzUwmg1Uuam66AHI0YClottjeNP8xU3ibQ
 soew==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nKTbwMDoBs0OAW0x9NTHj3bzN/M8OQfA9LduUWeyLuZ553XAo9xXmsdkb8rhUbRtl6LcbKXA=@lists.denx.de
X-Gm-Message-State: AOJu0YyGCoC+2A7Lt2T3U7cxHRBJNYKHtwyjHSJmTefuKebVfqGd9Fas
 WaWDyc2G197R/NDtJwFeaiVq5qdzpqHrb+mqQ3nnnoOZFTU/AJQtreMIJ5cXIT850QODbu2YwyV
 Jqnn6e00=
X-Gm-Gg: Acq92OFeU1ZVkO38Vc/iCUt/SJ2WPua1weuvA1eROGpECDva1BXFuVSOj2dK8utzMTC
 AehOykNwknCzxBFoQBxZ4qJ6f7ebJZ8oDfp3TgNrs37VjVefQsQI1t3YN7Kv9ZuUvMXNEPOmAPE
 BARm+I7Ze592oWLWBPXMtNJOeBJttPmY1eicNWJtI9+MWjO1IHzkGN8PsdtkhlyuIz/55Eh/RVL
 HldUoKSQqsOqcSMBPmM0nhk8QBNKfjdSWMcSe+Bh6p8DF/HaAoreVupKEc8sx4DS1rAkVEZbAyC
 7Nw6MD3zMwDkbRQWqdp1pav1pK0wUEcXGkIIrdDMIKqOs2MuPEbsphUDpji+oup0oMXDrvWITQH
 PT4eWVwCXI7vRjwaesDuu9wf+AkPDs29MSK3DGWrXZL2Cc99XRAnNxcjI9ED+OHG7a0gsSj3CTU
 llE+3rWuJM8Bj2WvKR35DQvSieYxo/xVAWpXjoAJabyFixzlL4Gyn2+wzGC++jeEA18GQNaWY4x
 dvVvshFWZd/9xNPc1obfIOXK6uvnhlold8s8WTwf6xPD98Fa4g=
X-Received: by 2002:a05:6870:3d8a:b0:43b:bb18:affd with SMTP id
 586e51a60fabf-446901f8e5emr750249fac.8.1781646730846; 
 Tue, 16 Jun 2026 14:52:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308f09405sm2966348fac.12.2026.06.16.14.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:52:10 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:52:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tobias Olausson <tobias@eub.se>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
Message-ID: <20260616215208.GO382693@bill-the-cat>
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
 <20260615194632.ACNju1Qi@breakpoint.cc>
 <b25761d2-594a-429e-a3cf-3f0cca996f1d@cherry.de>
 <20260616184805.OM9ccIkV@breakpoint.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3KZL9YPAUSKB/pFQ"
Content-Disposition: inline
In-Reply-To: <20260616184805.OM9ccIkV@breakpoint.cc>
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


--3KZL9YPAUSKB/pFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:48:05PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-16 10:35:19 [+0200], Quentin Schulz wrote:
> > Hi Sebastian,
> Hi Quentin,
>=20
> > > removing it since the "provider interface" is available since the 3.0
> >=20
> > We could migrate for OpenSSL 3+ to the provider interface while maintai=
ning
> > support for OpenSSL engines (via the org.openssl.engine: prefix). OpenS=
SL
> > engines are supported in OpenSSL 3.x. As a matter of fact, **I** am usi=
ng an
> > OpenSSL engine on OpenSSL 3.
>=20
> Sure. And this is gone with OpenSSL 4.0. Debian Forky wise I am aiming
> at OpenSSL 4.0 so the engine variant becomes less of an option. Should
> you aim at keeping the functionality provided by the engine you should
> poke its upstream to migrate/ provide an provider alternative.
>=20
> > OpenSSL 1.x can still receive updates provided you pay support for it.
> > Bullseye still ships OpenSSL 1 (and is in its LTS phase for a few more
> > months). According to pkgs.org, RockyLinux/AlmaLinux 8 and Slackware 15=
 are
> > also on that ancient OpenSSL. The former are supported for three more y=
ears
> > according to endoflife.date. So I think it may be a bit premature to re=
move
> > support for OpenSSL engines via the engine API.
>=20
> Sure. If there are people using stone age OpenSSL and brand new u-boot,
> sure why not.

An occasional frustrating reality if U-Boot is that yes, we do have
users on stuck in odd situations like the above.

> > > series. And since 1.1 receives no FOSS support it might not hurt anyo=
ne
> > > to drop it and keep only the provider interface around.
> > > If the engine support was introduced due to $HW then there should be
> > > matching provider support.
> > >=20
> >=20
> > Not necessarily. You can have custom engines and not have migrated to c=
ustom
> > providers. The interface is entirely different and the migration is not
> > straightforward as far as I've been told (a colleague of mine did the
> > migration for our custom engine).
>=20
> Sure, you have the option to not migrate. But if you end up with OpenSSL
> 4.0 you have no engine support.

As Quentin has made clear in other parts of this thread, he and the
company he works for are aware, but it's not just "rewrite an interface
or 5" when you're dealing with true HSMs. And as a project that caters
to users in many situations, we need something that works for everyone.
I believe Quentin outlined in the other thread he linked how this should
proceed in order to both fix the issues with OpenSSL3 and now 4 and also
not break the HSM use case. So lets go there, get on the same page, and
move forward. Thanks.

--=20
Tom

--3KZL9YPAUSKB/pFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajHFiAAKCRAr4qD1Cr/k
Cn8OAP9tbVU0YrGutdq3f/VQheDc1dOmGs2fqg+HOC2IZzAdDwD9EAfruaP9Qg7H
WxJRzarznEfYqU+TlYLirCWeRbs2rgk=
=1yuJ
-----END PGP SIGNATURE-----

--3KZL9YPAUSKB/pFQ--
