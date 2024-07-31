Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AA4C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487128751B;
	Wed, 31 Jul 2024 19:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rVSrmjxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3BB28861A; Wed, 31 Jul 2024 19:17:20 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351DF86DBD
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db1bc36bc2so596443b6e.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722446237; x=1723051037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G1jQCRx0rT4JRqYkjf2wXLR54l/GbJlGHEAtmLf/ScM=;
 b=rVSrmjxFQqXyJy7WnlR3+IEWPzPExy7u09AZx6ez5x0ypR1WB2Q37TO6bfTWLKFeHe
 jjtxXg77gbPUcJo9HHHMBtKieiCfXEHrH4donupEWuzqng9Sih+6YE3SsZyMiLWKJ6wf
 jQ2Enq2ndBDOTRXTWcAyArTMdbRf8wMb29488=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446237; x=1723051037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1jQCRx0rT4JRqYkjf2wXLR54l/GbJlGHEAtmLf/ScM=;
 b=rXeFsy87189gIZN3qyyb80iEyr04LNpfosv/KPY95P5WweVE6WGVGWM/y+nLdd73jq
 OlfNwt/6jH+sqks2rLyLvPBQu7lNG8cFTvuKIsybbr6QIYZGf6dfOKemh/+vrNgb+tY0
 1OW1KbEOYrlp+0saTN9gf3fYhtN5uJut6hXY6HLKGm6yk9tkDMx/xfGkPmHsYEIvZvwp
 VKNU2fAzL/14+Qxb81rVnTcJOgb0sIKvuEQXdgsIiVfm7UHz9u/YD3gWzC7Kr40cRER8
 wNGKF5/8jn1jKwwne7SRAkF+sQWWCBrD+DQNq25NAzS6tUKs0jAkpoQvFEy7yb23PyAC
 g6UQ==
X-Gm-Message-State: AOJu0Yyetu9/e0Ww8oC/rppe4mjASVlJvkeqPQuNwzejzvKeMEqZ4gkx
 BWCtBq4NnhRMpadGKyLeq9xdBdAmpWPx3aUf2zLZZrH17k3NGG/YEJbhVmgud8k=
X-Google-Smtp-Source: AGHT+IHTbE2+2OEwj6cOovL4qOo9fxq2j5kiOIGoddH55CjNcIoTRWca6cGETbmCx7y7sZA9wb6Hvg==
X-Received: by 2002:aca:1106:0:b0:3d2:95f:da8c with SMTP id
 5614622812f47-3db42d37fdfmr2293588b6e.18.1722446236902; 
 Wed, 31 Jul 2024 10:17:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db420f9bd5sm757664b6e.55.2024.07.31.10.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:17:16 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:17:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: Pull request efi-2024-10-rc2
Message-ID: <20240731171713.GD3794063@bill-the-cat>
References: <bfbc4bba-ec7c-40af-a149-097b9bcaaf60@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pk7ITOXjHQKsf/6+"
Content-Disposition: inline
In-Reply-To: <bfbc4bba-ec7c-40af-a149-097b9bcaaf60@gmx.de>
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


--pk7ITOXjHQKsf/6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:42:27AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 8877bc51a8a4d921ba2f163208b8b1a57ba47c=
18:
>=20
>   Merge patch series "led: implement software blinking" (2024-07-30
> 14:31:24 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-10-rc2
>=20
> for you to fetch changes up to 939afc80b6b5de23d70789f3cb3a391dd31319b1:
>=20
>   dm: use list_count_nodes() for counting list nodes (2024-07-31
> 09:54:53 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--pk7ITOXjHQKsf/6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaqcZYACgkQFHw5/5Y0
tyw2DQwApEYTO0krtV3lwRGloEmH7HB4TJrRomS1qFZbMCtD3Q186pVCH7aiRQhc
qexgh4KmzsgbtNMEX5PqIDP6aUmG5BMDn+vYQsJELbLZsrjsGnLGcMP3kSwsdFTc
7kw1J70O9JKe/rzG5q5CzeUBRZ2JcTHT6XkbUktGmjTaz8C4FVJCNujg5cvYVm4u
w2DEjIzntpaySfuXUKlpgpQcVc0K6VVmSNcLE5DxL94YoARr2xSak4un8Qgj9xel
UJ+uLRGeYVQGxVhEiyN8CJy5GV7WEyaYvuxNps1a4PWom1ZY38vqQ4Mt+U1qzMJt
5TnClOxm+WGqMI91PIf9zzti+lWOUr+fZrYUc+UtrB4X5Ee1IgLCRtJD+pBqPz8h
85OYEVrMONCBTtjc+ApdRi/NrWxi+pRNcLLWesGr4i/W1oyU+KNGQsHn1YoPVoBl
7gXLdHkZfyxzbdWItHgoGfmqUQJPlq3FajYyFmH+YF00tsWtT4zW91Ir3ad7afmd
ivwl2STY
=x6zg
-----END PGP SIGNATURE-----

--pk7ITOXjHQKsf/6+--
