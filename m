Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60872CDB481
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0575386EDE;
	Wed, 11 Oct 2023 21:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eV4x5EUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9141086D12; Wed, 11 Oct 2023 20:38:49 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D9C86D5E
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d8a000f6a51so130072276.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049427; x=1697654227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RS1Wu9PThAqkQj/tiCZxL48p6Svg8tJHLa4pA2DX8vg=;
 b=eV4x5EUkBUDetdgQslQ1QT/0zrYf0y+tzuWg/kL4bc23Xt0N9+oG6W9TFNtcD99zLs
 wtBQux58fBd7ZlB8W+1URh2qPml6bTUTkJr9J2zf7UavdP3VOVrgTPrc8qhAbizlG2AV
 4jbbIfKeIox41cjV6Lb0cgI6yTx6Vluo7zdD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049427; x=1697654227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RS1Wu9PThAqkQj/tiCZxL48p6Svg8tJHLa4pA2DX8vg=;
 b=Ym9uEEGOpr2owVQeiTltelioLIQgeb2Dke7C1YmmQcQqrQKBAKgwNwWEgkSdt9FyEN
 4hZ5GMTknve2UFkL6kk7x5DeYKWMfJPpm7drdCu54Iulp7BmI3NSorpu6uG4mXp+uIuk
 DMeTmNozNs84fRW8RV0I7BOFYlNIEpe+0+y/mFqxre7oMDL+pcVLbJ/XJORL0Ql8Qn4K
 /98zpGihNN1/UfT1p2bxv5A7Yut8e7xptNgJEnqkPtlGyJ2gK3oKqNv0lvsj3gMIcdFT
 ki08lLNCLwkyv24Xymowb+jQD9vXtSoqKyndxcHi27EA7YsOdknYBSSYmdVwCj7/BqxS
 Icdw==
X-Gm-Message-State: AOJu0YxpV5KbEHngH38vn0ss1WVtQ2ozVrsiRtaBqXp8aKsuIHDoXCP0
 XKkWcefs8jeAzVE8qw1EXJl6mg==
X-Google-Smtp-Source: AGHT+IEA1gDidbA+3nhLjeKrX+mzg3ro4u3fs4kwKPEyonpFZzfx5uc4V+QhjkzMvN7btPksNHTD5w==
X-Received: by 2002:a25:b082:0:b0:d9a:39a3:176a with SMTP id
 f2-20020a25b082000000b00d9a39a3176amr7247610ybj.6.1697049427291; 
 Wed, 11 Oct 2023 11:37:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 85-20020a250d58000000b00d9a54e9b742sm1394834ybn.55.2023.10.11.11.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:06 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 4/5] sandbox: rename overlay sources to .dtso
Message-ID: <20231011183704.GP3119521@bill-the-cat>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-5-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3sH2gjW/GqFQZ7Qi"
Content-Disposition: inline
In-Reply-To: <20230925080909.365098-5-rasmus.villemoes@prevas.dk>
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


--3sH2gjW/GqFQZ7Qi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:09:08AM +0200, Rasmus Villemoes wrote:

> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
>=20
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--3sH2gjW/GqFQZ7Qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm61AACgkQFHw5/5Y0
tyxXhAwAopzGoHLLhEIXhytR+JSDByJ2IWsAFV0XiMQCuFVm+rB+5eFZdqY6pnrs
N9fnE9lmlW23eO7icATJXYyCtDtfgvslvXPk0dvUKmtjAbew6NdFVCm7T7mcJYC1
tZnX8uFfIXNhySw9ZHsjpCaOv4T5SUkQp99S5i0c+luvcklrQYULSembmYRaOmJf
UkNDuSz4T291OiJlzg6L1OxN5gC0qCaYSAo2yYULzV7MEjYHh5tCvs71rxykS9zZ
xRFtklZ7w3Ld2pm0wDUAUwPo0KbAEAdXtWzkrVR1IueAuLYbhT5k1J3mQJxKE5pW
ox4PVaJiATt4A1thmeTe+59QhZOsR0YWp33K4yUe4J62c9YSFwNcshN/joJ8mN+F
avxZXPN8CXZ4NPhNJyxzkDg/tvvpN/yL8TS9rDYrQSCPgCXL49KyUnBPp9hl01lS
Z6mlnFPxtcRsVAoIJ/OAxQOMjgB54q5LQQUykqh5a2tXvORQSFpdC1BYtz5+jBAY
rMxF5Q3x
=oRoO
-----END PGP SIGNATURE-----

--3sH2gjW/GqFQZ7Qi--
