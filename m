Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E2C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477B386FB8;
	Wed, 22 Nov 2023 21:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JmGy4Scj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B542486FB5; Wed, 22 Nov 2023 21:48:59 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF7586FB8
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db048181cd3so215288276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686136; x=1701290936; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CQOQzeUMcoIknsKwwTo0uYh/jHje8mbdTVW8SnZ8Gc4=;
 b=JmGy4ScjYZdNYRVSelf5ZsBV6Lw282WK3jQbyDGTNQ97S427YWQY7/5Fng5GnRn8A7
 M7W3mJeM3AT1X8MHsaaPwqwG9dHD5AK2is+9TTjrCjxV3O08onQgB8OfaNojg55oNGIJ
 odA6aLjI0pdAJg6HOao8v1K1fKxxRr2XTpzII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686136; x=1701290936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQOQzeUMcoIknsKwwTo0uYh/jHje8mbdTVW8SnZ8Gc4=;
 b=lilt7iRFR0f1ghctasl5DKSqlUo7P2hgy9IkX1mzJr5BxPDkvMXiouk5ufAwTJI4aT
 wOD6DJdsvJtOjqzFzmm2/xcEz8NNcwfzsbITZDOrNL1wgQlCV2T++fFf02hjLad25v2m
 YGl/5QHAoxwm6i0brlW9ynI+fMJb+j5wfWNbYDwgegmBxhZGCQd0mbgpvJ6SpxAePin/
 Q/EkRQppHzrhFqhjo0GxoWNJBZ7R4S20d0V7yd4lWqLd9iU5ieFODAQgLygCqOau50rB
 xklBHmvrSoCZd/H+ALXOq7Ri92Nyo5XJJ3788i2VRaLqdu9UvW4NwqdTwBV4HaWjngMt
 NB1Q==
X-Gm-Message-State: AOJu0YwLoM6EucvllwUgnmPEe5T3Mn3oHjUL6CwYNMmpxdu5qagKlsYM
 PVir4lGwfsb4OtKwAdQLSyvAJg==
X-Google-Smtp-Source: AGHT+IGVzXqj+/dNqYceYzjD+rwwyFGSKZyYGfJuO3tijUpMxKsJbYv/qjVshVIGhRpFoqxKTBNz5Q==
X-Received: by 2002:a25:42d1:0:b0:db2:72ff:2f5f with SMTP id
 p200-20020a2542d1000000b00db272ff2f5fmr3137909yba.21.1700686135954; 
 Wed, 22 Nov 2023 12:48:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a25ab06000000b00da076458395sm1566382ybi.43.2023.11.22.12.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:48:55 -0800 (PST)
Date: Wed, 22 Nov 2023 15:48:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de
Subject: Re: Pull request for tpm-next-22112023
Message-ID: <20231122204853.GW2513409@bill-the-cat>
References: <20231122102127.14866-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eeRhRUZkPin+jZHu"
Content-Disposition: inline
In-Reply-To: <20231122102127.14866-1-ilias.apalodimas@linaro.org>
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


--eeRhRUZkPin+jZHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 12:21:27PM +0200, Ilias Apalodimas wrote:

> Hi Tom,
>=20
> The following changes since commit dca7a8958f8d0dbd53072caa4353353e062d80=
ca:
>=20
>   Merge tag 'v2024.01-rc3' into next (2023-11-20 09:19:50 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-2211=
2023
>=20
> for you to fetch changes up to 9086e8f04d268a989193470de7cc14e4a577e6f5:
>=20
>   tpm: remove superfluous check in tpm_tis_send() (2023-11-22 10:03:55 +0=
200)
>=20
> Minor changes from Heinrich removing a ptr check that is not needed, since
> by the time we get to that function the device is up and running. Since w=
e are
> late in the cycle for 2024.01 release I prefer this going into -next sinc=
e it
> doesn't fix any bugs.
>=20
> As expected the CI had no issues
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18689
>=20
> Please consider pulling
> Thanks
> /Ilias
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--eeRhRUZkPin+jZHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaTIACgkQFHw5/5Y0
tyznMQv/ST4+fJxAuuR2OGbpv51pKx1o8ZgjTYC2zZaQBd5cYYGvPViOAOy8Xz1P
8Z5EEDBg+Xeq9D7ZrwRUgnYgfv+ijl7PEGMZXAPM4seLYJxj26S2HdZMgI/p/gP8
V0qjnjaLHHeRuFn98Pcn24yR3Vl90phpWFslzSx+HyCq9+QOV+azTtjHkpR7aKZc
jAYapasJrqXMw/SpuWnAkwyY592aUKbNxR/ZCSkdA5tY/4Vmwa7i5CJAskRdseMs
s3rESyjJs0BaDgLiVmy8vcpu8AAEVF5qUFXg+TRd75Vbtudzq4J/63rX94dZ60gg
jtp7UzPZbqZ8AopfblaJDKLaDZZ2mYtBvrCqNo7KVuJJiObMVo4kqXExEQNdx3Uk
0r2lqaKhG5MLvJksmMWm0Ec3TRkUrVsxbTq3RuAMYtM8MDiof/oyrRYyk9DeFxg6
+eZicc5K54XgvpOSB+IiUnQAVQOlSRAZeXSqj0qi4erFhEmpMRR/lVecqu0+J5wg
zdMauke7
=IG+t
-----END PGP SIGNATURE-----

--eeRhRUZkPin+jZHu--
