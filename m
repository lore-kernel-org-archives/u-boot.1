Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF6C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD2A82BC8;
	Thu, 15 May 2025 15:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r6PY8mcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 005FB82BCD; Thu, 15 May 2025 15:55:53 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF4CD82958
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f94b7bd964so1050262b6e.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747317349; x=1747922149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yis+Cp2P46+8GKMDGRQiQeEEGU0VxOHMLQbfzy9fIpM=;
 b=r6PY8mcxFlay8idjbhUEwmhuoAj+/PC0casGpaC5a7vhUK4cdyxJ/6cJUfdddcZwxU
 ikHoJ/0riCgR8WesIPKb6uWvR5du4OidCunHRnQw7jUpIdtzcuUnrcO3j9w4wUZIj1dl
 HH68SkPvaSV71xCwvsY7IeItYOrvlDewKlLR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747317349; x=1747922149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yis+Cp2P46+8GKMDGRQiQeEEGU0VxOHMLQbfzy9fIpM=;
 b=q6lWdjMGM9Rd0exCuo5i2cx6ro6t2r+AhU81k8J20fUcRdPb1nFW1TtOTyl9obOlZ+
 LK8DOT/5b7xwk91hfO8sIZoyVVJIoCMxjFAHobUyCxopvVOEMLzQ/4A7WNZfjrd+nLS3
 fp8K826Bc28QdVcXAXUMbJcTSuj3SluSwRlfdessg6tjo0tcKyHoC/sWY5m1GrsCJ0i8
 ZdZba+1bcYMOPlsWEIZ+JSjycmXNszIShJY3vO0ljEwmsbftUAHhLMHsPBYdzyBNkJqc
 Taa4fJe1aS8bVMR2YmwPPmvY3u/kLNLHFztPomRNvkumSiA/g6ZTm+LfFc0aLydfT6Sn
 sCmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW4eGFNd/TidtkMXnDBif4yTIdK7mmm5Sc0JEjs2N94EG8lP4syX75vj6h1ruP+RX2d4cXCic=@lists.denx.de
X-Gm-Message-State: AOJu0YyqZ5dVomT6TR2DMNrzmvlAAExxmqMoMRq+XwAnhrHM66Njwvkb
 S6II6/VPS8XsGUOFZIiPNairbNYso9zyI5Hqsau55OTcl3EmhWt/EkXmp0fNh70=
X-Gm-Gg: ASbGncsqaGYcts2GV5wnNnKog/JHfIs8kE8U3Ck74XCZAF2VmAT4eEzo2FSpUa6LcHn
 HxfbD2WZbJiCpyS2LwaRXlT4LPIMeU/toHKltukXrRRw/orOo0Y4uLjiYvpx/b24iiOewTUlEsy
 OH1gIOItu9uOeOmcLk+gJwljS2wUZwOJEj/pj5Aah5CvGpOIIlw9Se22wpRbZv60HG0eO4v0pU9
 id9k8W3Pp/VAhppcjRYnfDflItdDPOoW8A15EBtEuL+oV7pbWxvhgYc6Mk9TBFHz+I+I6Rx62D8
 pnmjbVFllhvVCGBpI6tTVhDkALX4r2BMbDWKWHUq8ZtVWrEtvUsPScLv0VDdTySjN4KigRALPBX
 eZqmGv6v4sSB3
X-Google-Smtp-Source: AGHT+IHFuA/J2mcabm3iVL/AeoxZ5nFQUBIteimA3IBO7LCGo8RbLK4jxoy8CBL90zj6bF3gGJOJoQ==
X-Received: by 2002:a05:6870:8303:b0:2c2:544d:e140 with SMTP id
 586e51a60fabf-2e32b13590dmr3960599fac.11.1747317349488; 
 Thu, 15 May 2025 06:55:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b6bfe6sm3153101fac.41.2025.05.15.06.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:55:48 -0700 (PDT)
Date: Thu, 15 May 2025 07:55:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Richard Weinberger <richard@nod.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/6] test: Update fs_helper to support passing in the image
Message-ID: <20250515135546.GF603748@bill-the-cat>
References: <20250511141828.2367318-2-sjg@chromium.org>
 <20250511141828.2367318-1-sjg@chromium.org>
 <CAFLszTjf_4E+spiD3FBFvXQbXtrnBxgoF1hCjNsauySom2SgFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aBu6pG24/widtNDn"
Content-Disposition: inline
In-Reply-To: <CAFLszTjf_4E+spiD3FBFvXQbXtrnBxgoF1hCjNsauySom2SgFA@mail.gmail.com>
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


--aBu6pG24/widtNDn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 06:51:17AM -0700, Simon Glass wrote:
> This function is useful for other scripts, so add a parameter to specify
> the image name, if desired.
>=20
> Also add a flag to quieten the output of some of the tools, since in
> many cases we only want to see warnings / errors.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/py/tests/fs_helper.py | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> Applied to sjg/master, thanks!

You have been repeatedly asked to not send messages about your personal
tree to the list. Please stop sending these messages (and I hope you
didn't change the patchwork status too, again).

--=20
Tom

--aBu6pG24/widtNDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgl8l4ACgkQFHw5/5Y0
tywhiQv5AXzVQEuJvca2k8/89pwZRihHpx08kXw4dCoxDM0VEaUaju1l9aq1wof1
glO8pl+R9nCaQsJtQHO/WtkWL/2mKWksGaKyioGgFowVczk6hVW16JtOgSErGEKs
kcxoHJkUMusrNHh0L+iFVCd2RBw3tieuE+y/i+3tzvNiNpL0WkS1lDbLR52/bRuU
J7A5ji5QLyQSCICSc1G3IHPlz9shitqUWx2uGy7M1LgoezXLAYjzJbicdh5hoMfQ
0mrLLgqdbSqcUHVLcniZtfYstknox9+C0FmEuxrCIYOxtXK6jx55j8sfUcTuBd3a
9ibOQWVGZz65IU32K6GORMbhWZ0jzvYwLKmqrvRlucMfZ/s4sG+LV7/Bjvm//ZD4
SMLJpKVtqDTzERF06d8N8WRUgEdN7tYs1HJqQbOG1CL5M16UwXh1JYtxhDL5mp2m
9EQAXqkRzuWeXr9f4ew62PP66H2iDbC4/zQbGb/2eIEwRRxPRPMHfj8ak/MN9OpC
TSsDkjiR
=+alM
-----END PGP SIGNATURE-----

--aBu6pG24/widtNDn--
