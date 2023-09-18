Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E62ECD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A61869D1;
	Mon, 18 Sep 2023 16:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nj8icGu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5020869D1; Mon, 18 Sep 2023 16:13:07 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F8486925
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59c00b5c8b2so37421207b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695046380; x=1695651180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N7xDVnj0rDhQVk7ZmKVYitWeeMLmD40fPECCHrhKSmE=;
 b=Nj8icGu9EPCvOkiu6jBwC4Wz8E2ufoMaEO+r5j/NIKMsxocwio+aKTYCBAG/Gr2gix
 BEmIybiHoI+fn8OqQcLh1fYABCgDYYgyD7ezivrkk72zOvZYeGb5yQ9iqXFEdeQtQ1gz
 8f11WLd6Gs0hXtuOomlQ56S07a5e/34rpwvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695046380; x=1695651180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7xDVnj0rDhQVk7ZmKVYitWeeMLmD40fPECCHrhKSmE=;
 b=OnUmnRMshgHhPDjUCJ/eclBr1az2dCWHxo+DcBuP1kpF67lVnlX5WFrMeggXDDQXth
 uBCD/ZS383uWmw8FuSJOz9E3PwWsM3xvX3tlnTrD/sICqBvqoDzugxLjz4yFmcSWhXJY
 emo0opc/tNepV43QcOVl/zwTbdwzghUGFtcoYeMCwmzOWw9Ugm4llzH/e6CZf8eoqu2a
 uCFbEZMrWRDrEjWn4V/Fjhsr7hDCqaElxgrzqsq9MzdiAiHnFBAznJKKxMwapqD0gVGy
 ABi6BBzB5eKM80NYTWCmISmaN9BHQ9+0NzSwMWkqfW9PvU/TWBXZ48FJ9p1PaaSrnRWo
 aUGg==
X-Gm-Message-State: AOJu0YzpiO4zhEBPjaia2ZMvsJycKL7fA5+rPtiQ3/mRSo8Z2+MxuHiG
 XQ85lHfiPcZD3UfDnC/sULPCRw==
X-Google-Smtp-Source: AGHT+IEq1FBIXWDArWxgnqpUOVi4661in3TP2EdihuF7aHoXg9a7o3Z3ScnFBSFCSXSl0TmY4ZN6fA==
X-Received: by 2002:a05:6902:4cf:b0:d7b:a257:adbd with SMTP id
 v15-20020a05690204cf00b00d7ba257adbdmr9177496ybs.35.1695046380644; 
 Mon, 18 Sep 2023 07:13:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a25b082000000b00d20d4ffbbdbsm2310847ybj.0.2023.09.18.07.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:13:00 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:12:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20230918141258.GN305624@bill-the-cat>
References: <20230917125407.378467-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mGutMww/DMfaWpsx"
Content-Disposition: inline
In-Reply-To: <20230917125407.378467-1-marek.vasut+renesas@mailbox.org>
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


--mGutMww/DMfaWpsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 02:54:07PM +0200, Marek Vasut wrote:

> Two ethernet fixes for this release .
>=20
> The following changes since commit 252592214f79d8206c3cf0056a8827a0010214=
e0:
>=20
>   Merge tag 'doc-2023-10-rc5' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2023-09-09 09:33:02 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 075e0b9050e2ec1c6a521c0a1a98be4f7feb797b:
>=20
>   ARM: renesas: Enable DM_ETH_PHY on 64-bit R-Car boards (2023-09-17 13:5=
6:34 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--mGutMww/DMfaWpsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIWuoACgkQFHw5/5Y0
tywJfAv+NXftAF5RP7X/Uyziv69QbVHO8wz9LXq/9yimDs7GNChSVmA092qEOYco
IWzRT/qKIWdnnsf2akUnN3R9apIOjsn4dPdFTRmvKsqDZVZkIxPdHdwbklc00bRl
+fwI2WPktCE4uZsIKCe7j5p+dn93lXs+DG0rpoqyXcVWxzCzPLfv+eZz8oYpszdd
7jyR62GghScNh3DhTvs6IDZTOr2FRr4FPxzWUlY2XtXJG0B8o7iZBpESuYp69/mD
ogDbKRnMj6yS6BTjUY25Jw7IgO7vpGREmMi5LIF65YooeZ58IH6bHtgBtYtxe1zN
AfnXZZsxDAzv3TJhG4XsgXubmqs+5jKMbPSnyLFu2FWSf8zWjgr9mtypeMV2i7fp
FuMRLWpB1Z2qqlZ7znMQqh2cgo1qyB4G4EZ2KmwomqYaFR4DhdE5sDnQ3NnemWCP
YFRyHJk2zhe/fzMZVu4nZUfnwyabfogvvfpPGmhqC7Eba27ZXHoKCjeLavnhzvve
XJ7jwoOg
=a4jD
-----END PGP SIGNATURE-----

--mGutMww/DMfaWpsx--
