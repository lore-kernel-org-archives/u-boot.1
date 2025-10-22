Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A8ECCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA2D8334F;
	Wed, 22 Oct 2025 15:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c5zK6hNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1278835B0; Wed, 22 Oct 2025 15:51:50 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2578323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3c9975a3d6eso1447839fac.2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761141107; x=1761745907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9s1jrLvPBoufDwG6PKqZ2okT7JXoyFLfqQghoIsyiPs=;
 b=c5zK6hNBC/ktkOGseMSjqUHy+to+0+hD7mX3PAL1oFpEams/X6wuBJkL5+zVr9P7ae
 vdL8P8TvTxjPnJ3SoWFQm71KFIsUtR+vY8S4N7oBqDCodypeEVrv3Rtx/uyFT1vTzdhz
 n3D7jtYOWTKxun8F6kTPlEcbtGF/OhbolQOOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141107; x=1761745907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9s1jrLvPBoufDwG6PKqZ2okT7JXoyFLfqQghoIsyiPs=;
 b=KPabwfpyO4X5yCr3FFb/Z3H7WC3sTOCm+B5nOPv5wDF2RVeFgSQ4hRFz2z5z7YLUEb
 vyDrQlJG6I32qPACU579ujDY3ZNmA+QzbmWJKwwzQieBW3faQmdMxsXnXQ0YUqmp4h9I
 LARy4GN4AssVaZ8ys/Zv8KKkfsHDyhZiycfyhEIQp/a38lUWgYVPvldDpjCBlovJnOMV
 tXOmXOSj/mRAvnFPdh6qNeZpJ0Zk+Jq3HcqVsm7VXL3JQdTBh3+ZKfhLL6yD4tEdWszy
 vprQwnaAKVIOya5Qmv78Ec3aB8ORXMtHfMJKrdmwRtS0siUb+IiHIo2DXL3IYhcF/q/Y
 3Htg==
X-Gm-Message-State: AOJu0Yw5L+mWPhogyyZ1DvRdnxxSjHdZJd1DWRNrqgNBX/FlsKiHDyli
 GAeYFI+fhOBUMZqhCXYnCcWWiNjeVdxyNiFHayJTuiXO32pHXa0rAJDnMKbGHP2pbsW1UFV54/g
 yMlCJpjAysg==
X-Gm-Gg: ASbGncsPPQKqnNc4xtunuCYlUQS01ZO7wccuTLocoE7D7ri5BQDtAGhxhl2gUvWI7OO
 rDGhPDFg/i7o5wOVD1Y9hpyT7DJ6fs2/J3WO0AakeVyCbZJfZaRYBFX0Rzea6p8TeXPUPyIVZZ7
 RY+F7GqcEXMnbPDyY/jmGXEYHMJuBtzx27Q3KtJGl0bBF4vT1GmqoZn8GqOuuvmamDsKcDWHzY8
 5UlskwB5qEpDCGCuS+8TAZgRPgpMuWyA4hNiyOuESmGscI0iUar3fPWsQLhOnpnbJNkbpnLGDkb
 J/JwRXNP+syALCKmN09Zs8Y0HJe7G7THwXt8qtE2l6jOjKL0kfwFLv/Zjo7JqG2weM/dM4YjZq6
 r/oLjA8HAdjpCplzRfQh/YQ7Txs0x9tYsphOVk4gAOq8d5Pht6vohfkIcNHS75yQHuaI/BUj1BW
 h7b18PNnk8LB/NnfK/EAB3Mrk6I7dvBS8dMxIja+yO8SXDQXkfjg==
X-Google-Smtp-Source: AGHT+IFYQjFTtdN0YSKzjHc2eKWXRbaRObOGFPm98o3bn1DQIGnxLUIQHnFlo3nF2i9ijblp4/f1Tw==
X-Received: by 2002:a05:6870:a990:b0:395:3a47:e813 with SMTP id
 586e51a60fabf-3c98cff2372mr7765543fac.22.1761141107528; 
 Wed, 22 Oct 2025 06:51:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9aefbc585sm3914633fac.6.2025.10.22.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 06:51:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:51:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/3] doc: seama: Reword return value section
Message-ID: <20251022135144.GI6688@bill-the-cat>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-4-trini@konsulko.com>
 <40cc7900-f225-4d4c-b3e4-286b1ac4b954@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7rJXrsq2qyuhdkws"
Content-Disposition: inline
In-Reply-To: <40cc7900-f225-4d4c-b3e4-286b1ac4b954@cherry.de>
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


--7rJXrsq2qyuhdkws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:33:30AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 10/21/25 10:25 PM, Tom Rini wrote:
> > With the addition of general text about how the return value is handled,
> > reference that while retaining the additional information about setting
> > $seama_image_size
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   doc/usage/cmd/seama.rst | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
> > index 17fd559f4856..a6b00f32902e 100644
> > --- a/doc/usage/cmd/seama.rst
> > +++ b/doc/usage/cmd/seama.rst
> > @@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=3Dy.
> >   Return value
> >   ------------
> > -The return value $? is set 0 (true) if the loading is succefull, and
> > -is set to 1 (false) in case of error.
> > -
> > -The environment variable $seama_image_size is set to the size of the
> > -loaded SEAMA image.
> > +Along with the general rules for setting $?, the environment variable
> > +$seama_image_size is set to the size of the loaded SEAMA image.
>=20
> Maybe add "as reported by the SEAMA image header" as that seems to be what
> is reported in this variable reading cmd/seama.c?
>=20
> Also wondering if this shouldn't be in a separate section like "Side
> effects" since it isn't really the return value. I'm thinking
> doc/usage/cmd/fatload.rst (and a few others) could benefit from something
> like that to explain filesize env variable is set automatically.

Perhaps, but I would see all of that as future clean-ups, I'm just
trying to get (most) everything consistent first.

I say most because on reflection, I think a number of commands that say
they only return 0 are just not mentioning invalid syntax, but
verifying that is a more involved process (I did check a few commands
that say the only ever return 0 and saw the normal CMD_RET_USAGE checks,
so removed their incorrect text).

--=20
Tom

--7rJXrsq2qyuhdkws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPjhcAAKCRAr4qD1Cr/k
Co5ZAQD5mcKCCkQs4UwcPgCe9osddmkU10iWlhvm+BqnXo4R4wEAsTgP80ANN/Qv
1JnD11mr1OpdBAiJynU+FGQz+C6srQk=
=IXLQ
-----END PGP SIGNATURE-----

--7rJXrsq2qyuhdkws--
