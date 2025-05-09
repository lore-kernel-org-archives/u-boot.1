Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BFBC3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 17:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E98982162;
	Fri,  9 May 2025 19:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BwN8QTlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355D28283E; Fri,  9 May 2025 19:39:01 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB3E8211F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 19:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso838830b6e.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746812338; x=1747417138; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CFgPEYBfaQqWgtD0suLGiIwMiTH3yo5E9Io8rCObw3A=;
 b=BwN8QTlwerTUwr6/L+o3OBWT80L8tVc6MupE2uLSPyfV965A3nasqW9a4amRUYMPwd
 GZYRTCv70SoEsNzIMpBFkBsmsKGIRy1QJXKhcMuYC0SVmw19yX9xa3Jti9Rew4wDxx6G
 N6WbQfu+fg/m/9QBJSEtOVJNWh+mdz83ArvhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746812338; x=1747417138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFgPEYBfaQqWgtD0suLGiIwMiTH3yo5E9Io8rCObw3A=;
 b=LW+8zIKjnpBu+0gbXujtKlab0qK52xbPi1Yf6Ssn12pO/JwFHiYRXyJaoC/JLDXQTP
 k1Rf71O9Rl7aHnkBEoOjJYVt6JdRDSaXtEQdzR+TtL5U+b9UyOkCloubfgC8JBnO4QYU
 9xlVewZR5vDbCO1wD7dxAJzjSInECzW2LVBXYVZBGY8zogBMRxqZ5Fw98LKXwNcR/dO3
 Ws0OVW5sLf1IYVO6XRFghhRr2TJEZAimmC37sQBfIQhXu+UmHT3ytimeXwDW3OJOEM4w
 DTITSJDcMIQv9Pgxbo3ZKY6lNnr0kejLg9GAISXHqMxLFV6Wkm0Ibm9EQI36Tye6zDN4
 ItgQ==
X-Gm-Message-State: AOJu0YxCfDs3UyjgJ2Twzwp4C7hctIkb0kUP4HrS3L+P6O0L90Zd99Il
 TS15+8A9spjYzDXyXhk8OLj3Tl9Qmb42LTsGPNlu28TLBElIsq6fZkzhiO/eiZY=
X-Gm-Gg: ASbGnctT8Dvrx1fhVwdeYomhj5AYCb1XJszB2j8ifXTXn5WamQZZurWVZ2Ctk2iGBcj
 BBmbiMwIr2ESKF16eSYG6CsrcdclVYhTTZ/5S9rmlFNAE0oL0gFr3OhrpP/OPbJl417JCDds/j8
 SQsTrzO/8cg0SG3YY8DU6Uw+UQFzIeczoe2hbo2bbiF4XGbUGwRT191N7rhrUdclse49y86g2ud
 5Cgzovnxc1IiVcGM2LhxGJrXEGXGl5lONF3ovoBy3n7YoLGqVP+HLpmD6bYfBYAEZFhCJrTKONu
 MGBlYh0pUTx26eIOqVXNcn1Xh94jjd9fDT179b/ZQAT5aYjOzacKjKon2nNJh9LEQhS6RbFjGIn
 uZGUCLMot023K
X-Google-Smtp-Source: AGHT+IEutkepIHpF5ktNREq6oCOuzfKy6Y0C2d45qUc4o5gMysTWV55im6QPljy0WiKVqTTYTHxXvQ==
X-Received: by 2002:a05:6808:2209:b0:3f9:8b5b:294c with SMTP id
 5614622812f47-4037fe8e569mr2899235b6e.31.1746812337725; 
 Fri, 09 May 2025 10:38:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-403802bd4adsm530695b6e.7.2025.05.09.10.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 10:38:56 -0700 (PDT)
Date: Fri, 9 May 2025 11:38:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 0/3] test/py: enable HTTP testing
Message-ID: <20250509173854.GJ603748@bill-the-cat>
References: <20250509154352.3483523-1-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3GqNxdmuh1U4rZsd"
Content-Disposition: inline
In-Reply-To: <20250509154352.3483523-1-adriano.cordova@canonical.com>
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


--3GqNxdmuh1U4rZsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 11:43:49AM -0400, Adriano Cordova wrote:

> Enable HTTP server in CI to support HTTP tests in pytest
>=20
> QEMU does not emulate an HTTP server, unlike other services like DHCP or =
TFTP.
> To enable HTTP  tests during CI runs, start a simple Python HTTP server
> on port 80. This allows tests that require HTTP access to run.
>=20
> The pytest framework is informed of the server's presence setting --https=
erver
> to a non-empty value, and pytest enables HTTP test cases. The actual stri=
ng
> value passed on --httpserver (e.g., "localhost:80") does not affect behav=
ior,
> it is only checked for non-emptiness. In the future, if the `wget` comman=
d in
> U-Boot adds support for specifying ports, the value of --httpserver may b=
ecome
> meaningful and can be updated accordingly.

I'm not 100% sure on this part. I've been doing this locally with the
python http server running on the dhcp server. This should also just
work in CI, and not need further argument passing?

--=20
Tom

--3GqNxdmuh1U4rZsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgePaoACgkQFHw5/5Y0
tyxyugwAi5Bi9uQmgmYm+vet06GzyJJ+qRBRBNCtUmhOJ/Kcl4akngCtrTIxN4FM
dRjG5dP/QJEuiK6J+roH9StIO3uon1Z3Cnio6B+nw5MhEgLBw14b4mp8DwRIxCO4
NVvmEs/NRFE+/855NEASZFvDLt+x70FqcMyqC1iTwrHlUz0ve32pymv8OHicCdj8
QVC6QpF7tvQ58/wBO2WVVau+BGmBgiutYy3t9omgbA58JS1UlGn23TSx37I2n/oO
TP68iwHX9a9DFb429ogZRqiTDUZ4HyAupQNalXSWZXOICxMrKkiWUQxVzNBIdHBd
4jNsinP8U1bbAUK5g9Uh+ikhT/VuFY8AwOd5im7vh1SFbTbWI1cyA7yi0K+HnD6b
TgL3ouId2H28yF/qgZWBJlLKi00Wj3xUMCoVqCxk4SV7yX+c1ekyRSJYxJoWzu4h
BemiH6JNgDDILNazQjerxa9Gjss316D8w/fcwkHXsLBEuDpiO4qO4M6gzRNrWt1J
WBP8X/c/
=2F0t
-----END PGP SIGNATURE-----

--3GqNxdmuh1U4rZsd--
