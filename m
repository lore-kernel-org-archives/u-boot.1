Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC9FE69E8E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 20:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF5789535;
	Mon,  2 Dec 2024 21:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LIVhRW6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE53389492; Mon,  2 Dec 2024 21:16:48 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E968951D
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 21:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b667d2fb9dso288080385a.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733170605; x=1733775405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fCBQCxJPxQwJPKZYd1RGng+svUCCedZTpIG/RYbe0YA=;
 b=LIVhRW6pBgQuFR0ifqHcrnWpzQ+FcEt3ANi5QJYzV/UaRjbFAxuGGAZeGX/xnuDMve
 zFoXcR00cE5JL318WyU+lxwAwxDiryg7U3jM1xk+PwhHF2G7+uf/VluyfIo/EJ2KD5Eg
 SpuX2x5aSMLoQpT2o8fts52OAtzgvcJqRztJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733170605; x=1733775405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCBQCxJPxQwJPKZYd1RGng+svUCCedZTpIG/RYbe0YA=;
 b=KsYqYXirQn4W081XAm6yFG6VuE9H1ecqIulJ0fmoostwofoZJGN8UGU47z3Zn5bfui
 8xGT8e6E1zhdF7cEIKPpWVWFxyFLNqHbAddT9DymsdbT86LGhBTgPTozuR7RFfA9i4Gv
 nHcAFGphld5YRND8cMFuQIgip67ih5cnBLb/rcuL4vy23FaWqrTseF5fMk907Y38LzxV
 +G2dNq56D9QUIPRaHekgwfre6tsAkyw2CeDAJJPZOY6IVRsDLR/Y5XV9o4oALk+EeNv8
 rQ9ctnYV9b8g4u5GmEJ38gMrm3gxqBchNGSyNMTTkUlt58A5fkZcb6GWC6i0DaND6/L+
 d7eQ==
X-Gm-Message-State: AOJu0YzzQchcYF34zjxAUpSwxF97jGw8KqYEkgN5zxQSebIexGApByTP
 iZrkcPHKGpjWGm3psZACFfPZLaAO+tKix7KiYEHRc4UkG4hdnXEOlLrNOLWUGWI=
X-Gm-Gg: ASbGncuHGn1kBDSzpo4WmxG6UIRVrnpDjv95bmDZFWJOmIxlkv0n5/7jTDzMyf/SJM5
 7sa6YzTS7YH8h6y3TahDaQykdGD4hCIfiTajDikXkREFtaiKPqe+4HzXHJNZkinuNJrVTRmC4bX
 cDDACmY5Rpnby3WAK/FBd32TUTYZi/ZqQB8ASBbhVbOQ5uZJBiFJ4l7RJ2ZvN1jLlZuPA+wwlD/
 3ShRRy+DciTIYSuhORXKsmOkpHOUuJ5sD/MdGzekrCZAS8zpg==
X-Google-Smtp-Source: AGHT+IEqQMOe3EXIjoIINZYOhadxw+f6KVQsogQnN/UdWv7BouEZcIbNZBriYxgQZXNG0CHl6rvGog==
X-Received: by 2002:ad4:4eea:0:b0:6d4:180e:e7a with SMTP id
 6a1803df08f44-6d864d3c4f8mr355729796d6.24.1733170604825; 
 Mon, 02 Dec 2024 12:16:44 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8aa61a156sm12067016d6.7.2024.12.02.12.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 12:16:44 -0800 (PST)
Date: Mon, 2 Dec 2024 14:16:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 03/25] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Message-ID: <20241202201641.GF2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PNLGCeLBjCWaV4xx"
Content-Disposition: inline
In-Reply-To: <20241201152505.1666789-4-sjg@chromium.org>
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


--PNLGCeLBjCWaV4xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> Simplify a few expressions in this function.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  lib/efi_loader/efi_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index f1154f73e05..3b1c7528e92 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *m=
ap,
>  			     (carve_desc->num_pages << EFI_PAGE_SHIFT);
> =20
>  	/* check whether we're overlapping */
> -	if ((carve_end <=3D map_start) || (carve_start >=3D map_end))
> +	if (carve_end <=3D map_start || carve_start >=3D map_end)
>  		return EFI_CARVE_NO_OVERLAP;
> =20
>  	/* We're overlapping with non-RAM, warn the caller if desired */
> -	if (overlap_conventional && (map_desc->type !=3D EFI_CONVENTIONAL_MEMOR=
Y))
> +	if (overlap_conventional && map_desc->type !=3D EFI_CONVENTIONAL_MEMORY)
>  		return EFI_CARVE_OVERLAPS_NONRAM;
> =20
>  	/* Sanitize carve_start and carve_end to lie within our bounds */

As I believe was mentioned in a previous iteration, please drop this as
they aren't excessive generates a compiler warning, merely for
clarification and should be kept.

--=20
Tom

--PNLGCeLBjCWaV4xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOFaEACgkQFHw5/5Y0
tyxU3gv/VXeZNXLNumfdHRZXZqAUD9IbSCMmPmtJV2GRu/VrKM3UvxnOv7UuCaWu
LdQNaTjk616umIo9BEcAy076RslAjlqnCvG1ylXLRfiunYfUjdAQuLSP/5v5rGsk
Zu4q4oo6rZSwcKogbWllffY5yuBpXKhZjlvT+TBfzYhp6hxQUvpllwm6oP8mI4bN
3xMerp8FahBb2BrzeCXiPVPPOfpUPCSTpQGCSSoFDqci0bjfSpu7ZASvQkNyjwD0
z7yBstjsrm37sYX5jiSUmGo3IS/foW/BtOI8R8ITCNvKEdkZsuJqrEM7ISWO8Ad+
QvGIUN4SfkvZ5/Dk75jlwy1E6+3YPYwZ5iO9loSRQSDdGETn9enKcXJZqLh7DXSw
/I6IAPkHkPaL0A3pnaO4vDxzbNfiJsCb+GNOfL/yl9R/aokuBpr76/cd7UYnVsOq
1oJDF6br+QkRG8UtvIt5J1U4GEtZZTQtsKFqWxzGZxZHeJQZXbshxVW7nVS7HV7q
3nfNHj3Q
=M2C3
-----END PGP SIGNATURE-----

--PNLGCeLBjCWaV4xx--
