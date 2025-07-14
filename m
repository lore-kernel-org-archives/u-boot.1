Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E137C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F1582F49;
	Mon, 14 Jul 2025 16:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FO1DSZET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B9483020; Mon, 14 Jul 2025 16:52:19 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3743B82BA7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73e55e829fdso89989a34.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752504736; x=1753109536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MK6neEpgMMIR7NtvDi6pSUoiLjw4gLVGZOd/lcEn2ic=;
 b=FO1DSZETNF7nB34BjCcbbhNHe9YVCd5ITk5rtKVggFTBrys4u3xBWIOqJuD0VhR/5b
 gMzkck0tmKPB6cwN8LUgiO7pUBBILN0AJ2O5WhT1bBIUOwJK7ilsY6ze4Lv0zERkCz27
 Ly36b0ZJqIhHAAiUC83xDtZgbp13n7+9DGtKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752504736; x=1753109536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MK6neEpgMMIR7NtvDi6pSUoiLjw4gLVGZOd/lcEn2ic=;
 b=an37WxGanptmFUBI/iS9XWB1pxfHs5FmJyc7BZzB0zGQeB2ec9X6mRImDmXET51xz0
 b41aj76jdUV1RuYW6SJzvTT2BnwcWpkiaf4I5Sc4Jw5pt08f61yCXMDSBKVNo1MFjZ3W
 Ob5CXFbrTuJce9KD4r33WP3pSYXJjUJUnFI+w26honS7H5FcesNJj5CmkNl9O9pBHyeN
 BhnK6PPMrb63R5uHCIOrhOiFhTJEDtjM/FbhIlnKUB3UKGBYeS8XOkpTCvdjPd3IR1O/
 MauX3eCTl1h/WIO8sYaeJ7HQuOKLc51PYU97AjHLmz4r9JdPEVrGT7Y+VVysn5LqWkii
 RwVA==
X-Gm-Message-State: AOJu0YzkdYCXXabsgBNlTZE/OBu91XZRDGLuEzXCv5/9EFLutUz8hbKK
 bg1PtAcyhRHSgiWWPVToH1OZpCtdcrm4qlZu3Gg2MgZlc1CbdkUrdr4OtAszPDwk1CU=
X-Gm-Gg: ASbGncv+jBnFesok4IOkwrPiXsawK0kBlOToQciiSxfY+paDw789RIwf1C8jaJhA8i9
 C7/4PAut5doPTzaLfdMAgF3sGY/UDDWeZomCBzAGwygOrKal0FZQhVa2G8DerTPQrEitpBsDoEw
 mq7X82KzclCwnU+gAyePCOg1GVubCqbk8tH8Ursls25uyHFVjWfw2BERsyfFZw+Sqxo2E3TJbkm
 6WbF0+M/IkTcyeNhyMJTzXXWiFvvdFseEuHJpTxcKc0C9M7r4jmLAScrNDpuOs/Er4Z1wHYhB9M
 xTt0QoXS3hOLWp9ITx7GPRTCGFepTLxQTWhmxFGVmxybyRDClBw9gRBVqHvfyis9+YuFxPiJqc4
 T9uK6r5vE34artaGG9v5/qMExjlcqloRtvh8aQ8d0YpWujiLlUDw6AU0enbR5UFPo8JY=
X-Google-Smtp-Source: AGHT+IGYqrS9OdVQmKTr8r+nLMdbZor4taM7TAxSg3LHXrX2AaDNJoBkbnTsY2twjgwtbv+WZHvEBg==
X-Received: by 2002:a05:6830:4d95:b0:73c:c494:a30e with SMTP id
 46e09a7af769-73cfb23247fmr8385662a34.27.1752504735886; 
 Mon, 14 Jul 2025 07:52:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73d50da23e4sm702666a34.40.2025.07.14.07.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:52:15 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:52:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: u-boot@lists.denx.de,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Message-ID: <20250714145212.GF13084@bill-the-cat>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
 <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mbe68SMBm5zz5vpc"
Content-Disposition: inline
In-Reply-To: <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
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


--Mbe68SMBm5zz5vpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 03:22:17PM +0200, Holger Brunck wrote:

> This area was used for special purposes on kirkwood. On the current
> designs we don't need this anymore.
>=20
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>  board/keymile/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
> index 41458813858..3a66b2915ac 100644
> --- a/board/keymile/Kconfig
> +++ b/board/keymile/Kconfig
> @@ -31,8 +31,7 @@ config KM_PHRAM
> =20
>  config KM_RESERVED_PRAM
>  	hex "Reserved RAM"
> -	default 0x0 if MPC83xx
> -	default 0x1000 if MPC85xx || ARCH_LS1021A
> +	default 0x0
>  	depends on !ARCH_SOCFPGA
>  	help
>  	  Reserved physical RAM area at the end of memory for special purposes.

Can the whole thing be removed then? Thanks.

--=20
Tom

--Mbe68SMBm5zz5vpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1GZEACgkQFHw5/5Y0
tyyjkQv8C1a2dG0wW6MTeYrTcUpfxppX9Xh7wJQY4O8SEoKxR5GHdy19DWCdWcLe
HV/f0SL4o9K3VA0VtVauhO4ect8ERiKm5o3FmDwmj/atdkMf0zFq16q2SJmZHZyC
shpe1zEDKI2NjoH6sxikTqgSOe/EBlAYmOch06RD/TNFTMj7AWJt/Bdl+0pRPf1p
qqFaQpRysmez4JRshnwpW7Qh4IpDrVxwzhPpsAhYSfcgYr3SWdnQQgD6gC4B4jy4
xtm2cwciJxO83jBwIywwK3FNz3alhP5pqQCqewUxT7IXH7m9ujeaAKYDEznUko64
dGOE8LmEWhKn0TeuApNzjzisqTpugBEdHB75FlzDomFKhlSAp2g9OlOx6ptuhNFa
D6cL8R+PeDORMHu/PDw5qHlLXyTdA/t5uQImQi7oLcEYlL+hVgMOcb7FiIo6ss6k
ZA6+DnIBkLspt4BP9N47ktZUOAZkXnU76w7joB9/Jw5MdmitfUHkkbnQXk02Fn41
WxHzDJIx
=zJZs
-----END PGP SIGNATURE-----

--Mbe68SMBm5zz5vpc--
