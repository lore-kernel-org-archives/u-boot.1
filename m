Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FB4C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 17:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EC281CA8;
	Tue, 25 Mar 2025 18:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bGdrMuJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0484581CAF; Tue, 25 Mar 2025 18:02:18 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9994681C84
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 18:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso8153449a91.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742922134; x=1743526934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JUgju+bGJWjPpR099pPAMhAoIEEUWZp2cWfgmlRVvGg=;
 b=bGdrMuJEvy/NZJzCWuM7zVaWkIp47vwaTe/THlZY8eEX2Ztd5t11No5H5DuUyvyTIa
 GwrapL9xXXBXcsW0EPwojKjvTrQToCP/MedyZHYJMl9caxjO6WJAAteG2UFcJb9JgUfi
 g7E9p7QXdmEqHvmkfchiCyALXu1VE1o8LOfD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742922134; x=1743526934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUgju+bGJWjPpR099pPAMhAoIEEUWZp2cWfgmlRVvGg=;
 b=gpciwEmDzCKrxVt02bD3KOdeS2V7Rj+kDQ7d1GO2zNiR/MehIx7Z4xkWrT/LPiaYHY
 biDt+8UxKXSPBxDXibuEALWcx2ny4QVBZwHq29IAf3YkLMjqmjJFLpOMCHZgkvatKXLl
 4rTBYJLKMaOEzvuxXowkCeA6mrPmMfmWk0Hxv5Pe77OyQAuFG4ypx37xejBbo2l07Ol6
 +Y/UyJrbAhTOa+vZ85C6SYgGxYQfGNRcd1Esmhr2Dz7g9etoyzKAHeHl804GrATahvh2
 upQAnw+lWpwsODkBGro2JjO1FZLevtIIOvud4xLS2vBkCSTquqjJaKUDfnTm0NdBi4Dr
 F8NA==
X-Gm-Message-State: AOJu0YwYN7Dztmfmb+DRc1tF8zJXVg0SzQ6L2Dtsgnh5JkprG/RFw/cs
 09wxS4KkJgFeu0S7Nj975asZVBQ5P2aS5RJTfZDTU/nDyXa0wD4/1EG/pdMYGC8=
X-Gm-Gg: ASbGncsVCh554uMwNQi9f1Dv/kKgSwhBMn00V2E7ghHKyphGNFgqU2Y/k4nUqdcldl6
 G1P5JIuRJveHaA57lyOkve/YM6OM87NyS5DrY0HCXCewYodgQ20c9NJLDHebV5fsoDpwT1HUnVp
 YfKAVydCvVS6/0QTIttTkfAlWNzuRPdW3hKABI1vNSWUyKDFQBvGyxA0oY7nV01K2scpS68i8ZU
 jHflXaddp8sMBw12hOtkFKQ7ucQbQVz5vIwA0u4F63m6Rx62CiKU2653FBY/JyUuBUFtVbrpdnh
 Gz/Jkghw0PqEFMwcMFroaMIfobU8ofwyiRM4cP40rrU=
X-Google-Smtp-Source: AGHT+IH8++ok+nNrBMheEtlJ9G3EoYUVIrP7cWHOyPKtJ4QU6+jDxPEc0Rkt1f3Mqkw3zwkVSjJ9/w==
X-Received: by 2002:a17:90b:5407:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-3030fb219f6mr33459637a91.0.1742922133813; 
 Tue, 25 Mar 2025 10:02:13 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf589bccsm14731168a91.11.2025.03.25.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 10:02:13 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:02:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/8] env: Rename SYS_RELOC_GD_ENV_ADDR to
 ENV_RELOC_GD_ENV_ADDR
Message-ID: <20250325170210.GL93000@bill-the-cat>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-3-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IZHPrcQJH90T+0ze"
Content-Disposition: inline
In-Reply-To: <20250322215624.18994-3-marek.vasut+renesas@mailbox.org>
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


--IZHPrcQJH90T+0ze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 10:55:23PM +0100, Marek Vasut wrote:

> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--IZHPrcQJH90T+0ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfi4ZIACgkQFHw5/5Y0
tyykogv/fvxyY5QVUhYoM2bV83EcOIuyrI1q685627XfiBRcusjSewHxHB7grCDr
W99/f8jTMjpjKD/xfxJPKMCYN29AW1w+p6p9Qvaz70yivPdx3Tr3223TxtqFPV4x
K6R+ipKYy0uiRBcuLUy+Vilveqa+GEMejxz81wJLar8PbkMtGGwm+GfeWyI0uXaj
OKzK8Rc+o1EuD7FhKgjcwniHZsu4jctJfRmeQcPzTNKCskKvvu8oo1ogc0emyf3v
yO/iNVVnx9VTl/50rezqh2dpLC2mKW3Th/8MLEIN6znx1Gl16IRkPJHrtEO19WFX
iGLfLPFu+3MqWcnfjbNOB42KlCLhfWwmh3ae1TQkYx3S4UAU+oGPisBgFClPAyL+
1oJOfN8QSwP6pdvCUg58GI7xlqdbWO2id9l/LOP2OW+Kt1iTX2LtThKXIP0EBfr9
YOSQIvsVvCbMThuSAzKnR/OSrKBpkrRnnN8Fs5W1C+e41JQdqMJiUapHB4d73bT/
nEGCUURY
=oWXw
-----END PGP SIGNATURE-----

--IZHPrcQJH90T+0ze--
