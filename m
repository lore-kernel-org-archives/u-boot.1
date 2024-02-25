Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654CEC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 13:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7783687DDD;
	Sun, 25 Feb 2024 14:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tSWx2oLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C6587DD8; Sun, 25 Feb 2024 14:10:20 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C56D87D83
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 14:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6087192b092so25109147b3.0
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708866617; x=1709471417; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/dvCSBF/XiLgSWcA1r3BZ1+BhdASOLJH2qMOdtuQxoQ=;
 b=tSWx2oLUghh1loSjQAQ8H+TjJmXFqK68LWGh5gj8KcEXDTQMYOlh35DnuM44IOGEWV
 0CZDyVbViKxa3uFcs6HJH+sgyuohRuuzVsZGTr27APzdW0KdI/HN35tpiaR7efSHXihr
 wKojGQWNHj4LX5tJgsApssVWPlky5WnPgNJMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708866617; x=1709471417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dvCSBF/XiLgSWcA1r3BZ1+BhdASOLJH2qMOdtuQxoQ=;
 b=VdCeLKNP2YFO1EstSnS5nV9X42ZffrVYUR17hnrmgrbNd8kZbMwWUEELwfPPztFx8t
 hw6bswt1oz+uyjb4SC3iSK9MLiXQzieAzIiXhLkFLvSSvJnPX1a9kYfbxa+GrvtjEPSq
 F+nWJufev2hUS3WVHsbAIR7DUdYsqZ4MkW8P2zQkMlh74tFnCirI9W35qSpoAA+xZOgJ
 agjxBDUSNgUZzNy+M4CFUKvjyKpAAL+cyjbfx9SBUew7vPjj93f/4GIkXlGs/YjoBo3V
 6Hk5bJPmbmsma3R0CL9Qr9cfw+eofhzthP/XivtsPAiQWi5nC0ELJ74+Q2o0WJE4jWgy
 FsJg==
X-Gm-Message-State: AOJu0YxNYPY3S6fuWA8aDGUV4lmOsVYaHrtdG0WoljytpPIF74EJ0s+9
 wBHlVTJmWwZa9de3wY3JAhsXHtCRknetRRp/++42NGfXjqvMTLpyqkGYzN9uTH4LhNAQleP9T6s
 y
X-Google-Smtp-Source: AGHT+IGAzz52VMAgvv8SUht31qlwK4mQjkPjZrfgTUT07bK0C0nQ+9ScyWKdX8KUKLJ7+MipjJDckQ==
X-Received: by 2002:a0d:d812:0:b0:608:5136:bd7d with SMTP id
 a18-20020a0dd812000000b006085136bd7dmr3753750ywe.51.1708866617303; 
 Sun, 25 Feb 2024 05:10:17 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d194-20020a0ddbcb000000b00607afedd0f0sm714812ywe.64.2024.02.25.05.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 05:10:16 -0800 (PST)
Date: Sun, 25 Feb 2024 08:10:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240224
Message-ID: <20240225131015.GE3040305@bill-the-cat>
References: <20240224222117.1504690-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XejB8Zw2Yx0qURdz"
Content-Disposition: inline
In-Reply-To: <20240224222117.1504690-1-festevam@gmail.com>
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


--XejB8Zw2Yx0qURdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 07:21:17PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit bb9d6c7f4f6a598e8856b2e19e58c7de078a0d=
6e:
>=20
>   Merge tag 'u-boot-amlogic-fixes-20240223' of https://source.denx.de/u-b=
oot/custodians/u-boot-amlogic (2024-02-23 12:54:03 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240224
>=20
> for you to fetch changes up to 7c76b1b91bf67cd09fdf5dbd71590f9e580590fa:
>=20
>   opos6uldev: Convert to watchdog driver model (2024-02-24 16:29:24 -0300)
>=20
> u-boot-imx-master-20240224

Applied to u-boot/master, thanks!

--=20
Tom

--XejB8Zw2Yx0qURdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXbPDcACgkQFHw5/5Y0
tyzP7wv/dvrbeHzxTnSM3yKBFZED8VtFAylw5+NicsAx/jKDBHxs08iqaFjRu0s3
Qj8TrHQGFbkOoqHioOyCrkL40meKR7DcJ+C1XsEUnxqvEGVyuEtWjwrfMt/LuDPB
mKawzV1lEguEkydj89/L7qzGxXK210PKOdGzj6Z854Q4RKtUHT6nVyZlCVMSnuZg
/L8iMGpnlBFAR2pp/BccUI2mNTDSVYbnVtsXJPQNoMHg+5ULtfX+VYsKrFxvIihH
YEzwQ/cyL4WaVsX5QQ9sfkYNJ0YoQX5sXXWa17iKZH+ROtjWhLQrmQihTU1hbEdO
hOEQ414xY6aqvZXv8XzM8/b2whKAaQfh+0OAOCcZYpT/9w3gWGudf8q28QU0gcXu
R7x76sKPQsFMuiukOmF3v9eFwNuW6j70PJWMqPAYfWp8/gLRHpp7rLe5YS+SSM2r
mqtgw1q5tYE9E0pdwLDnYlmsx17is7Ds7HwrbOD8q7MkJd/z8ffQZoZlnmnvrjc7
1Uh9C6+T
=6EXc
-----END PGP SIGNATURE-----

--XejB8Zw2Yx0qURdz--
