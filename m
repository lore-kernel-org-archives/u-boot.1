Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5A5C54799
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 21:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754BE828F8;
	Mon, 19 May 2025 23:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SuIo6opS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D742F828F8; Mon, 19 May 2025 23:06:14 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC11782012
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 23:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso1793965b6e.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747688771; x=1748293571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MZaOjL9BM1LVz7CyW1OXFrfa3YAoKpyYaOjmPxQxnl0=;
 b=SuIo6opSDE+S2dNzDB/ZvdMLfLt1J7+NjlpvRlfFEq2rO1ZICMKCAqfUln2Gc9H3Et
 c6vfTDCyPiZuq4dB8RD5opjVu2xUY71NAbzbyauNVz3/DOss4wnn/1yuH2Qx+5gq1h/V
 gHCHAmEuEEgn9YoUellEKg9QoEiJEYbWZeF0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747688771; x=1748293571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZaOjL9BM1LVz7CyW1OXFrfa3YAoKpyYaOjmPxQxnl0=;
 b=vA5amdS4LjRjPUs2NbYouIFGl5OUEqAkMU8j1qe1x4vq1ChoJzgsxykbL8jqvj+i5S
 soqHr6QgG/DH5GkPQ3Epq8xoN6tzjmdC1prhuKnxurqvlKnmMInNuq1sHpqOKbOc0EWY
 QHp+sNZBuyVqrfxyzUIPlDNoVLQoYw2v+u0UcXdFYrBLrD+krh1xlcuKpgLvzcA2CSML
 6hLIaSuFwdHD4ns3jbMMYjWYqVweghqv9etT9t6EXDJosXtcVhCUPRu3AB2iFKmuLdUY
 yu8CLzWQEHGi0iq23ekUjEqywvKY7S1325pfAsF0+RX/rAjXLVMLgfbabvDnQ3CCvXqD
 MzBg==
X-Gm-Message-State: AOJu0YxDiTeghMEwnyrJ1NZjoEYmEyo6HqfDMp0guyTohs7jdDmc4Fng
 V5FULteNAhvoSOUm4g1VeSop+YrJfbhfT3oAXO9hsQ283visukMmDomhHjTrj7C+8uA=
X-Gm-Gg: ASbGncsZWqbfh33gSRWc001C3U86vhwOHZA7lQPyH/nAzq5lnNzwu6R+Cyn/4PgJCYr
 lVd0c2c4xhL/VnFAfOyKjD1TIciU4vOXIiCAwZAX+LnxJPFZ1jm0g/v6fAZ+hLElohsuTtErNPX
 cKWw++qsEh0OFkHDUmdXuTo4yY8pGGDaQhtSCrF+P2jhJ2ElKoS9C6bZWRUV8FHAYOO7qcSsEtJ
 W4CsZudWmvnrDXRPEmxcbQyS0afj4w0S3C7kURI+tbjQ5AFzKakuIOBe+5vhVxMHJda4A2Bq+Cb
 wlZ2H3ZuAiSFZgR2fM/Bj9y3ub9cU5hGgB8JbUR/e/viUqOQQQBRtl0IybeRNQeoKETX6IvyUoj
 iPGyUTHYOj8UC
X-Google-Smtp-Source: AGHT+IHsm0fjJsHHOpEtqG4pEjsQURytx6Xb+6HvyCz1yWjFR55N+sEinmwJWuBasAYnnzCPH5aBDw==
X-Received: by 2002:a05:6808:229f:b0:403:34b3:c987 with SMTP id
 5614622812f47-404d87b8b34mr7760556b6e.28.1747688771273; 
 Mon, 19 May 2025 14:06:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f43884sm1726539eaf.15.2025.05.19.14.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 14:06:10 -0700 (PDT)
Date: Mon, 19 May 2025 15:06:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin ROBIN <dev@benjarobin.fr>
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH] bootm: Fix bootz, bmi->images pointer was uninitialized
Message-ID: <20250519210608.GU100073@bill-the-cat>
References: <20250519194800.5550-1-dev@benjarobin.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qp0V/UtNTUg0Lsif"
Content-Disposition: inline
In-Reply-To: <20250519194800.5550-1-dev@benjarobin.fr>
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


--Qp0V/UtNTUg0Lsif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 09:48:00PM +0200, Benjamin ROBIN wrote:

> When building with only bootz command, without bootm, images pointer
> inside bootm_info structure is not initialized. And since this structure
> is stored in stack the generated error is kind of random, but most of
> the time this will generate: "ramdisk - allocation error"
>=20
> Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
> ---
>  boot/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/boot/bootm.c b/boot/bootm.c
> index f6aa32746b7e..f6fddc151809 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1169,7 +1169,7 @@ void bootm_init(struct bootm_info *bmi)
>  {
>  	memset(bmi, '\0', sizeof(struct bootm_info));
>  	bmi->boot_progress =3D true;
> -	if (IS_ENABLED(CONFIG_CMD_BOOTM))
> +	if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ))
>  		bmi->images =3D &images;
>  }

Good catch. This should also get a:
Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")

And after reading the code and grepping around more, I think we should
be doing the assignment unconditionally in the function. It's what we
practically do today as only colibri_vf disables CMD_BOOTM but then also
enables any other OS boot command.

--=20
Tom

--Qp0V/UtNTUg0Lsif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrnTgACgkQFHw5/5Y0
tyyp6wv/caajuJHz0zqFf8Gb5RKm2O2LJeeBwvI91gslhxPV1LLesddq9n4vIz6c
XFLldzKpkv2V8j1jEDspmtY2A3epZNYvYB/61zjtSODdqF5IhwFAEbYTbsVHhyPk
qxdPuRr7dqbit9qnoAzV1oehbbNuB5q0u25WfAxj856P3ZXHZUEEwor3qB5JsGIC
jru+Qh4lhqPUXZNWhYyJfqKSleLg0rRUngCTuBTeBQ84VJQYyE4HBbFNQffpQZlB
4YXzyWtO2dRjKIZZIQDdg+l3ojkBVoFAohZHuTxlwy4Wdvz0wWxQL9BVPa/rZ1wk
za15HlU6Z9Lrj9wMnKg1hLhsIt82IIZOD1DSAxstRc0x+h0zJX/paX1B80FdcxsA
Nb5OelSuwQxFyuNZVhMQl2X3cKjr2AlzW2jtzEjHWvaMHyINYNZSffiGKTs62IeM
tv1xelyiSSnCUjCF3f1+vny1YFh2OP9foO3+Irg/E4+gycAxDdBU1leoljaWOZIE
H/BPvVkd
=wDp1
-----END PGP SIGNATURE-----

--Qp0V/UtNTUg0Lsif--
