Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C2FCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 22:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FDA8319C;
	Wed, 10 Sep 2025 00:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sv8SXw9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5246831B4; Wed, 10 Sep 2025 00:04:33 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86A783192
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3ffe6666f8dso15295265ab.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757455470; x=1758060270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=skUor5zEWk+x0731dUMRrCMN1aYD3jOgXLzV2yA38kw=;
 b=Sv8SXw9cZGmSLiYp5dKMV3vxg/dtB+V5ErRy9I36j+3peSqGaJ3sM68wODvqST5ASw
 DBh0s/C5vI54tIVL0q0n6DrlJmWhxqEqTtya0NN1qXhXwim97S0pEpPkU03Et65Dw3WI
 XecdzbFY1IEvShg/CUjfz6eV0WeG3tKcMqzXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455470; x=1758060270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skUor5zEWk+x0731dUMRrCMN1aYD3jOgXLzV2yA38kw=;
 b=sdAL8t6DDTVjwX+s/oqRyxUUPQR94AUu+2QJEkrpgEHPV0DApi4AzyoCcp1fKWIXJu
 hsAdgBpnX58byy1zlV9Ss4dAJqSW/SyhfAvW0YAjlhS26vgIGCc7uxoVX+b8e4I76k92
 ZK3t8X5PU+TQNI168gvpjtNcNPLsCDsItbIX7VNO750wemg4GT0eJzoydyPemuxLPLDv
 9DXJADcRNHdz+Pr1nJfLHbggI1PZQrpmkVx8zfoZ4mBdv8nJJbEb3aDCjFI/N2lQh1vG
 P+oWIEZwVuvCOZhvGfnWQcsnN5bwtqjezTElQBnB0HrrBsnppnsh/AG9fduMBxgSqAgy
 1zXA==
X-Gm-Message-State: AOJu0YzEuw3zQzjESwgxsr2zc763exagr65RYsWEwFT8FoGTeM+1sbT/
 Df1zG6XslA/SuxTxZqE8LMcpLFZZt1q3TUkDkpp2kzAp5+qLHpJrz1qqw9LMVobO628=
X-Gm-Gg: ASbGncslHgmbk+oAqDqozF4anXIUO0rkErf4hSqCLLZbp6YhoqKpUAjYJURuHPFZWzv
 PzkGd3UWJWEgQkvyDFh8kOm2Mskc41VOlZYURUq0a9xVeTrPGK1C22f1gVAAzrI+4SDCN1mxedR
 GZC9yl9+oumqz/Ts6C3/tRixJ77EV3lnv5y1CeRBLqgaihWPxBekGwYYsl37im/5Ox5GFhu0jXW
 XTCaS8sCwaEsZMoCyu4Hs1JtyDafNzI47e/wUIREZUXjbiHLHi0lbTwtkeUQOZMkg63n254PW+N
 CULeu0eGW+iIWPLMTS9Yj0K1rgu1eLGpBBabytrxwlTfkKWwAosdXKZ8ZOOxnWsiWWzSQUv+9EI
 aNJpO+b+FBoGgL986CIMYuDjUUgM6liKndFxzlo5fxqMAcs1JVlbLjZihBqzqwFFSaQw=
X-Google-Smtp-Source: AGHT+IHv+U+aVOHIVbsZUziL5szn46qkbet2PmIuGOrtTVhUM0X7WokrJTUObs8A28//cZCAzypdKw==
X-Received: by 2002:a05:6e02:1054:b0:401:7e07:a5d9 with SMTP id
 e9e14a558f8ab-4017e07a974mr124175575ab.2.1757455470453; 
 Tue, 09 Sep 2025 15:04:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50d8f10a1e1sm10102654173.35.2025.09.09.15.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:04:29 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:04:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] binman: blob_dtb: improve error message when SPL is not
 found
Message-ID: <20250909220427.GE124814@bill-the-cat>
References: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
 <175744269837.1809471.4162834140070687038.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ngWrn3nVq7taw7Nx"
Content-Disposition: inline
In-Reply-To: <175744269837.1809471.4162834140070687038.b4-ty@konsulko.com>
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


--ngWrn3nVq7taw7Nx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 12:31:38PM -0600, Tom Rini wrote:
> On Wed, 20 Aug 2025 17:06:54 +0200, J=E9r=E9mie Dautheribes wrote:
>=20
> > When using binman with the '-a spl-dtb=3Dy' flag, if the SPL blob is not
> > found, binman throws a cryptic error message:
> > binman: 'NoneType' object has no attribute 'startswith'
> >=20
> > Let's improve the error message to explicitly state which SPL blob is
> > missing.
> > This is particularly useful when binman is used as a standalone tool
> > outside the U-Boot source tree.
> >=20
> > [...]
>=20
> Applied to u-boot/next, thanks!
>=20
> [1/1] binman: blob_dtb: improve error message when SPL is not found
>       (no commit info)

Sigh, no, I thought I did a 'b4 ty -d ..' on this patch. I did not apply
it after saying it needed changes, sorry for the confusion.

--=20
Tom

--ngWrn3nVq7taw7Nx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMCkawAKCRAr4qD1Cr/k
CqxAAP9A7TMnF+FOax3RlFmWJLGG2K6PxnavXUCl2W7X0cuAKQEA0rg/AvaipeeB
MnqoniaMgGKPE+4FMN7412Z69NgcxAA=
=/XzD
-----END PGP SIGNATURE-----

--ngWrn3nVq7taw7Nx--
