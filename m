Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E4CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 19:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546DF83AD1;
	Wed,  5 Nov 2025 20:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aGZAbMWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C838183AEE; Wed,  5 Nov 2025 20:26:07 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CA683A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 20:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-654eb2b1146so55789eaf.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 11:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762370764; x=1762975564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/CGJ0Y88BwN85XNhYXRj+CgSXrBApDBm6o/cd890mJg=;
 b=aGZAbMWHGNwD4ZWL9HEI1PZgIeIEEOF/AP+ei8lBl7MPVm627ftZedTEGfkLkvbRGJ
 8XxvkfWxqTMkM7NIGAYyevslwxBmB2NmsrQHBrz9ARs+/OqLVNo/a5q6D29KxaS5yEU0
 di68xwwwkBDEM0OnDYFyWln5bWRkLmweWLUe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762370764; x=1762975564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CGJ0Y88BwN85XNhYXRj+CgSXrBApDBm6o/cd890mJg=;
 b=In/9k8pWBCMEC9lzf1v09KiC70g+KL4WTqCqzlNxEsNPRsF5T4d4c7eBKN5AwmEwgq
 gqxOg2OQGwLMHL6DRAXIlMkDCGQA6iL06k/O3lej9IcJ2yyX8JU4iQM9gVt8mMG/c2bS
 QzVuwKILsQ4bDlohacyWrmbpJDJyL8hPfWb3VLeeGBAmcE2PsIBu5eWxumx99tbOD8vt
 sMpCpJyzyyXbwEoE9VcHHGY3ePsoe3JmNP2HNn50N8w8qkt8h/2AtdQAd58AeReDymPj
 JTG+M/arKoR88OJD39PH99LwrTzm+B3frcvBtOfaknjyiXLQFeSPzkWTr5hKYkfEJEDC
 bndg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCmdYYVeQSGxl2mCnmXWvkDoDuZ534lTNONS5Jvk5/Opd7iq/iK1N4ThbBS1q6NPL6TNWYPCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl5h7pSlSdvHZIDr+8MOG+GfwH0DTDT1+kEjTAINpPna8Dud+Z
 8d024x4NZIRbEb1LEIB6z5Wh3Gzwnq48Sb9sgxpkt9TT+vgf7MDqYqRUMkEjA2M7/qI=
X-Gm-Gg: ASbGncvbLrb+xnaIx2DvxL8BcHLuMcw+VZg/++KvX/zsB8y2CLDFQgB55gNvx3cVCKx
 0tTIGDC1IUBW9HZWEUGwYwoNokOK2oM+7iZC+LN8HGjxHoLeXUvCEaPsZh9mQySXpx7G2uSqVnd
 Ym+kFHdAitFYrFuq0fjRUekfgtSncAbJaR22xNXp84q7SmQkTFncSEb6/tnNpOdBxm4vRbjXLK0
 O9iT5y1mu5r6YeJbC6cT8bjiL0RYVnOyQLCm22sL5dpn+ZlIvPE6ip9TCrNTG936MvOVIiidrQ1
 VnQuhJGjxONFgSZfJAdwintPwBjOTcQ5GDZmRQj306LgeIxTuNFI555LkDMHyUrQwSTFpBhjmpb
 jHlILjXR/s6ScUmWY6x3YRTNC6LUbB14aOnnNkYG/o6fIsct0X+oLU2dubJIJYaQYNMiJsKKptQ
 n5RpkpYaJtl4TauyzY/p+yWPhMwPrHuDdKCQkMQRw=
X-Google-Smtp-Source: AGHT+IFV1XGP4qUIMaH702ytCiBTjiI6F9hwXNsVpJA4mf+g6omA0EWr51+b0VNJ6pp9+QghK60vsQ==
X-Received: by 2002:a4a:ee08:0:b0:651:deaa:ded5 with SMTP id
 006d021491bc7-656bb636d28mr1818838eaf.7.1762370764366; 
 Wed, 05 Nov 2025 11:26:04 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c5715d66sm58931eaf.7.2025.11.05.11.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:26:03 -0800 (PST)
Date: Wed, 5 Nov 2025 13:26:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
Message-ID: <20251105192601.GT6688@bill-the-cat>
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fb/6ubAmH2tk8VyS"
Content-Disposition: inline
In-Reply-To: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
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


--fb/6ubAmH2tk8VyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:
> ARM and RISC-V do not have memory at 0x0.
> On X86 interrupt vectors are stored at 0x0.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/fdt.c      | 4 ++++
>  test/common/print.c | 8 ++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index 96a8488e172..6b07999c88f 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *uts)
>  	uint32_t ts;
>  	void *buf;
> =20
> +	/* This test requires low writable memory */
> +	if (!IS_ENABLED(CONFIG_SANDBOX))
> +		return -EAGAIN;
> +
>  	/* Original source DT */
>  	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
>  	ts =3D fdt_totalsize(fdt);

In one of those "what is even going on?" moments, just out of context we
set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loooking at
my logs for am62x_beagleplay_a53 where memory is not at 0x0, this test
is currently running and passing. I'm going to fire the platform up and
poke now.

> diff --git a/test/common/print.c b/test/common/print.c
> index 76ee851fe6a..389d6bf4069 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c

These tests are also running and passing on am62x_beagleplay_a53 I see
in that same log.

--=20
Tom

--fb/6ubAmH2tk8VyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQukyQAKCRAr4qD1Cr/k
ClvMAP9yb48z0Y6dC8K1kCA3hhA2NmFMQzVKlOFRotIdazEJGAEAioAbusw7mfbL
LBGARguw7PPNW4cS1C/DeVQy6GaMSQM=
=ikDv
-----END PGP SIGNATURE-----

--fb/6ubAmH2tk8VyS--
