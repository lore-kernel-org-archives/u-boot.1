Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C907E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69E889616;
	Fri,  6 Dec 2024 15:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U/14k9Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393BE89627; Fri,  6 Dec 2024 15:20:59 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B8089616
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46684744070so19827481cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733494856; x=1734099656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lB5BfI5UxoymgGW3UhWGsvWOGWiYriA94+VvQ3kTl+4=;
 b=U/14k9FthPBd7B2CkjHDJvHiMgJ+75INq7z7RU6dnaYotP9e36qofhAywzfm37PyYl
 65NzMNSrOCWvPDap35keY3DiaJHRpdbgVAjrSrKusv8DKWwNbnh2uW9V+bD+7bOrv/xm
 SDqeZ2IQlxr0oTnfbFoOB/n4SKCvffXBWXgB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733494856; x=1734099656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB5BfI5UxoymgGW3UhWGsvWOGWiYriA94+VvQ3kTl+4=;
 b=hAldcZvRDR8hpX1E/Kkvp3kwYGLqVhoAJHsDWwPxvPvNQa+4graJ3ehb2UeurfEVgI
 wgzgEwGAJ7HOdTyPEOgaU/2DumEAvoNpVduBRFjfzmmWIv+w0BNgaafvzNU9KBQ1XtNL
 5laMbH/iMQbKcuhglwqY/KbGT/QSQkPalhe8Jp3qp7u2DrMAPr5K1uc7ng2a9NlElqY7
 2Iv2JVbHgV5Go+yre8X5JNsV2s1NylmgUWxoDovw35i8snQj8wfMWWLHB4ExADh53zD0
 PwiYFBBj7kN8lDA/LHmW9LROAYiCS7q+i8yrxO3y1gYWlrBnfFyA1CzmcSLd+xkEEeac
 G+Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKeHPEXnHQMrGxHAnZhegNEYaafMlT4oQdnw5q+t7eboFKiDJhdgk5cLMxfnvxmt6uvCTsAE4=@lists.denx.de
X-Gm-Message-State: AOJu0YyTZ8r3T4imQMVM23+BBXEoiVlauQpOiXo+m5Z3VAsuS1o9id2y
 2+vpGHLIbbqUXZFhj9mD79C6GYwOsDH5up91miPS2p6i7bHU33MRfde8WWqJdrA=
X-Gm-Gg: ASbGncsomCEHlh3Bg8+1ZfGCVHqPsUU9TU4GGOOvAB1pzZH/P3CalIZd4pQ6CXj8bR2
 veirNyV9JObzSNPNloRdiYIb96TeDtEnawPytHw5TksniMsJpLYP2qb+hF19GrRwxb2qd0/4Mao
 FtUjVzhU8hQ6akSjpDQbc3haHCa7aYefp6hMpVefOoTaIdgTRsw4w13pIFQuZGplATjMYmyueHZ
 nOTF1tKzdQVgfwcC8VJsTwwd/ddNZzfj5UmtpvIrdKO9SI7sQ==
X-Google-Smtp-Source: AGHT+IFaJdwuntNImHq+Jq6nVHtyC6jkat1GEeJDhhe3xpUX0ONvKYxPcyn6kYPo68PXt4gXQEl9zQ==
X-Received: by 2002:ac8:57c8:0:b0:460:ad8e:f5ae with SMTP id
 d75a77b69052e-46734cac040mr69930201cf.19.1733494855889; 
 Fri, 06 Dec 2024 06:20:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297c239dsm21193851cf.77.2024.12.06.06.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 06:20:55 -0800 (PST)
Date: Fri, 6 Dec 2024 08:20:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] driver: clk: tegra: init basic clocks on probe
Message-ID: <20241206142052.GQ2457179@bill-the-cat>
References: <20241206060115.4346-1-clamor95@gmail.com>
 <20241206060115.4346-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="adpNmvmc/+i34C5q"
Content-Disposition: inline
In-Reply-To: <20241206060115.4346-2-clamor95@gmail.com>
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


--adpNmvmc/+i34C5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 08:01:15AM +0200, Svyatoslav Ryhel wrote:

> In case DM drivers probe earlier than board clock setup is done
> init of basic clocks should be done in CAR driver probe as well.
> Add it to avoid possible clock related problems.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/tegra-car-clk.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-=
car-clk.c
> index 9078253d100..4f8405328a3 100644
> --- a/drivers/clk/tegra/tegra-car-clk.c
> +++ b/drivers/clk/tegra/tegra-car-clk.c
> @@ -111,6 +111,9 @@ static int tegra_car_clk_probe(struct udevice *dev)
>  {
>  	debug("%s(dev=3D%p)\n", __func__, dev);
> =20
> +	clock_init();
> +	clock_verify();
> +
>  	return 0;
>  }
> =20

Is this called before arch/arm/mach-tegra/board2.c::board_init()?
Thanks.

--=20
Tom

--adpNmvmc/+i34C5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTCEQACgkQFHw5/5Y0
tyzhwQv/VeoMu/0BmvFvIuG8irZDrEB8PsywE93wxioLhCvt7ucAukd0INLb/MT+
a4+V+atmmsNMo6OWpX/BeHzPBJRjWSVJUB5+nWNAYu10MD5o4k3sqXmxqAHT0/fj
g5VZGMFMkTv91XUqOXqAsubmpAvLMF18+Bj3ZMK4vTrcf3wKbOH1vC9KDLxW7L9E
kJ7GsJFx7x9IOsYLY3VKOPCw0xP8ayUY6NKyM/oO8Ou6PTEhdAGn8jidYLfZSZ0v
BGFPplGBsdzREGKkKSMX6WNXe2IaV6/UqiTIscm7IeS6YKHsCvfEdX/Fc+mhXAGf
JuQQ1lbQmOfIdaQoBZzfOMn6iAEd+BzHX0edoahJhCKTgzQOcVT9cms+rtlYeAIx
F8CXZZBvVfjvUgjRFo0PFZhvG6Nkaxc9vfHXw768D9ZbjkxMUk8EdG907WhN3+9Y
wQylaPVMYVlU7cf58yy6OOLzaijg51LgE66v89YMpfKYiu/E7p87zUDQBvUu27Bw
AE5Ml2cx
=a3vt
-----END PGP SIGNATURE-----

--adpNmvmc/+i34C5q--
