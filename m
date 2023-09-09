Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A5EEEB58C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99CD386A0A;
	Sat,  9 Sep 2023 15:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TER41yCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3010B803AE; Sat,  9 Sep 2023 15:30:55 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1D186A2A
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so2191422a34.2
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266248; x=1694871048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EpLBAY9aQx7TFEyh8a0s/UKcrKvn4dTRAXXoFOXtXb4=;
 b=TER41yCOOEOMREBziXlzhvFTjxs0lLTYW6UtoPVSfwc13yU/HqHdE1jd0u7u2hWvfx
 Z+pRG62G63Kz7OS3vBk2HINJNu163fmv8BdlwdETPZbHjkwImWFfVt/1KW+Dh7tEOopX
 uL5gWeU1NHh6OQVC5o7JGCPRsgWVxGSb19Pac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266248; x=1694871048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpLBAY9aQx7TFEyh8a0s/UKcrKvn4dTRAXXoFOXtXb4=;
 b=p6Ef9DK7hix8fIRDOFPKjwQe0KnY6QzYKlu48QE3lQQ9V+TksoOKVmqhli0u7LDRkV
 oDq60bQWlVJjcUoXr9jA4RWRGJKTukshliRisNL4WS74umq1JH23SaT6Pj5Jb0idQtDC
 gOZfykData9EjUmTjf6hEcdp35k8ivPCNpReIZHKetua5/vDxQom1oBHgn7SnyKJs23G
 Ou5F36wS++i05DFkGe+3XQp8qbGbvXSKItbWfnJo5HfRhEMJc4IIf4uMJnpX3Xk9/ULP
 +bnRJ50fiQBthsMGIk6ZCw0206MNg7sUpxPO3ifmxe2y7TPRVy+tEJgr54gIT4N3fqVM
 kBxw==
X-Gm-Message-State: AOJu0YzC83Wk3Co1OJO/raOxm92A3qKGnfUu5uy8nVLMcL+311xqfOQV
 +BSB5dPZUiAAJ/1menTyu8QSDg==
X-Google-Smtp-Source: AGHT+IF5l5XrecWYVyFR0ZTxzhalJBYaE9Vsp4vkosge6Sqk3ZqnJh4lz9i6CeKUcN5oJ3Cffw630w==
X-Received: by 2002:a05:6358:9490:b0:139:d5f0:c027 with SMTP id
 i16-20020a056358949000b00139d5f0c027mr3969460rwb.30.1694266248592; 
 Sat, 09 Sep 2023 06:30:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a0dd905000000b0058461c9524fsm946868ywe.12.2023.09.09.06.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:30:47 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:30:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: u-boot@lists.denx.de, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 1/2] verdin-am62: add u-boot update wrappers
Message-ID: <20230909133046.GM305624@bill-the-cat>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-2-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RJU8sR7lDDYDhQTH"
Content-Disposition: inline
In-Reply-To: <20230824080850.1755724-2-ghidoliemanuele@gmail.com>
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


--RJU8sR7lDDYDhQTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 10:08:49AM +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> Add update_tiboot3, update_tispl and update_uboot wrappers to update
> R5 SPL, A53 SPL and A53 U-boot respectively.
>=20
> Usage example:
> > tftpboot ${loadaddr} tiboot3-am62x-gp-verdin.bin
> > run update_tiboot3
>=20
> > tftpboot ${loadaddr} tispl.bin
> > run update_tispl
>=20
> > tftpboot ${loadaddr} u-boot.img
> > run update_uboot
>=20
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--RJU8sR7lDDYDhQTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c4YACgkQFHw5/5Y0
tyz/fAv/Zo0E6zH72Yc8EAuGU5rSTjwfnZVpIXQFduMw+TVPiogPaK+dzgBoKD2Y
n+w6DdutoSI/BAhmivUEJKFel/FSMZH/wYE4dbFpY0lKXwE6TsyqFEpW9+iPvLjY
iH4vMPbeTWUmVDnq2keACakBIgpxcQpk/Y0C/Bykmo3zyVa/2V2HLXxtrCF5uB/V
z1fwNuSXQYwJhjzr38TkorQr4GdUNYlBXQvRFUNRbMWuc7wN7mbh0qdaHG4ZiWDi
l7PL7xQK0DBSzZwjDZcqrpDGTjm2wPWS93kYFnF68grbITf0+9ZmDYKdPR52OH8K
YqhAPMXzyFlFwjn6VIzexzLJ6mVGVAHtvtu6Q4KVXHquWBCi7qrsT+AMqJgXhVW2
etD/o+1KNmTRloPagKLqpTZxIVY2mjvtFGBQULucSNWDxk0Gsyj9tTQZJGJJKaby
6VeDrMRZUt39EbShV0Exmt/Jjfjsjb+Nx5jUCUYOZVpFP3/SGFmRA1PqtqxpZIpg
tSZKUuZk
=/6Wn
-----END PGP SIGNATURE-----

--RJU8sR7lDDYDhQTH--
