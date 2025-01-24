Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D09C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 19:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33FC80BA6;
	Fri, 24 Jan 2025 20:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q1WIzcVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CECC80BA6; Fri, 24 Jan 2025 20:21:03 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663AC80A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 20:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd1b895541so48764336d6.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737746460; x=1738351260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Viw2MgaAoNqtL53N1rI+dS0tF4yaA3QAAQ+uuzheWZg=;
 b=q1WIzcVC593XgEojHgl0NcWLTYy/fk5Mk27QCerKTYcDDJwKFcJwEsknVe1Gtrc7k8
 P8QFeCCWgaptUkfGHwgpZNFkmuMr1vUKXBwTk+dpdnTt4qXGMyBWtp2x9pJO3PeTnOhd
 FzCJ66+tCq7C9cPqqfUfv0jJ8+ltmVf0/HrhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737746460; x=1738351260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Viw2MgaAoNqtL53N1rI+dS0tF4yaA3QAAQ+uuzheWZg=;
 b=GSJbBBk6MoM4zh+SOw0aR9TPwKQJrF4TLEOWy6St+xLpLaFOXONHD8tHWBflIyrXkl
 10+k1+NPU9kx67QRSArZ3+54SjHnt0Qowjib9U6K/zjQ1VEgRMqBepI2OlxLUeT0ujM5
 WoGH/REeroOeLEgeeB2dkmKUxKfYLuWVv+fnPqXjm2WnWjFAVKyoNkvQEamzWwrTg+xf
 o24G4D9paXiYVQ+WLbtQgqjDCdfUnS9COyIreOf3A/3k4RT2JKc9cKrkPIDFs2R1Omce
 P9+FrygoUyuRPgKjQ6DHAdk0VMlUpaN9+TJ3VUYZ1ListMryryjqTVBcH0bviBqqD/ZJ
 aSmQ==
X-Gm-Message-State: AOJu0YzGQ8gmdziCwbh/U6x7PJVAYisxLqdIeEnh4z1BvuLLRzEEkCBm
 LiKeSqlkEq8RZUD01V08JggsfkpZUAtdo13yInXtsfxElYB+aHI/dAJfMZhTxStwlrQmPtoYyIm
 Z
X-Gm-Gg: ASbGncvqAxUl1Uy1CJ4XsxfY0j02151kMYs4Qg3GUMS8+ASL73/UddKtQYKyEh/Q1qq
 Vq/6fRGDeGjxl8e3GnKOThO7rFX8mzghs384wVqgmXgBuptPPsjBnCBVLwQr1RbAKmfj+ECZG/S
 pmM2UZV0l2T9axKhaly9rRXdXh/8B+ZltRox0NxoK3lL6RPlVxearE9/xsv69frztwg9ETT7ijW
 wyY7D+QnHzFgLFdMO+IEvxVq7PbARl6AYCVtqhJsjSNfpo3iQRAzvpOZbpa8Y2fkuhYQtZLzdn7
 QW7F
X-Google-Smtp-Source: AGHT+IFew2/M1t98KAN9Js0kJ8E5iuvgDhcQ8KNqS5hlWzvw+4TJbC2X88ib7wRkWe2NKnPxWXTOhQ==
X-Received: by 2002:a05:6214:1c4a:b0:6dd:d513:6124 with SMTP id
 6a1803df08f44-6e1b220a540mr469608576d6.35.1737746459818; 
 Fri, 24 Jan 2025 11:20:59 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2057a8fc9sm11256926d6.76.2025.01.24.11.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:20:59 -0800 (PST)
Date: Fri, 24 Jan 2025 13:20:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] test/py: Add a report show test durations
Message-ID: <20250124192056.GU60249@bill-the-cat>
References: <20250124185605.372347-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/ESv1knHy4XvKaaH"
Content-Disposition: inline
In-Reply-To: <20250124185605.372347-1-sjg@chromium.org>
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


--/ESv1knHy4XvKaaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:

> Execution time varies widely with the existing tests. Provides a summary
> of the time taken for each test, along with a histogram.
>=20
> Example:
>=20
>    Duration : Number of tests
>    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>        <1ms :  1
>        <8ms :  1
>       <20ms : # 20
>       <30ms : ######## 127
>       <50ms : ######################################## 582
>       <75ms : ####### 102
>      <100ms : ## 39
>      <200ms : ##### 86
>      <300ms : # 29
>      <500ms : ## 42
>      <750ms : # 16
>       <1.0s : # 15
>       <2.0s : # 23
>       <3.0s :  13
>       <5.0s :  9
>       <7.5s :  1
>      <10.0s :  6
>      <20.0s :  12
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)

Whitespace issues aside, we should probably not do this every time, just
when requested.

--=20
Tom

--/ESv1knHy4XvKaaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT6BgACgkQFHw5/5Y0
tyzJhgv+LDtnnlCAxBZMGmenbUSEmsugWelfdSZ566B8bFM+zA0mbK5Oj5XvUPoo
hcw1+SKjrIVuuwGsT3IIkUOPJl72UYXPzoygIjgnlZM0EsbBH5bSvZhgPZ+pyuI7
hDQ/Iph16Hqz27NOQfYLFyUmLUif6o5f6ishWAIAmF44NxXgK6sbV98cBjhdgkwG
pWqUS+g9GYSXdSM2wQRYAuSm0n4vy7fe9F0IUV3AIO2L3/aMr5/80csWiI/6VI50
PKvIU5ahqTCUR2Ocnpm49+uyhNPVtixd9AGwZqV57Hkq0oVeBeQtz6TcI8248hot
tRNKsqnYVE1vrpXE6rq08n4hYhd0hdDGzNj1Z8Yuk8+slQGeGW/YAuYYg7FXHdnH
SWS/hXEHcMhcg6Z+OwxbAkcvoNJNzHi8gQj098Hbqb6X5dOMBsYSQpx2ySPbYBJH
qGDbcdcdys6PvBffsWUXlkZZKDomPRP6xpVMokx/N40KsNT/Cu6EBm9bl4fAFEfq
I9DqqNJA
=do0U
-----END PGP SIGNATURE-----

--/ESv1knHy4XvKaaH--
