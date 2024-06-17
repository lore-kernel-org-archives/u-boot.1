Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49706C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F95B88365;
	Mon, 17 Jun 2024 16:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZc69e/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1484D88349; Mon, 17 Jun 2024 16:40:19 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DD888208
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5bdbbc37664so1852174eaf.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718635215; x=1719240015; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/DxtTYOw9GcJD97o97SCNtvhbKAScviwDaQWoEZq74c=;
 b=IZc69e/x81rHKb7+fsdgi2oLYLqBWvjc9YUSbIYOucJIF314hMC0H9WmsiKJctqumq
 Y7Mma0gLuURUs9xS2pB2+xan0uVG1fdbhFBIS+QIK5tqRep+q7b2rfrJPxY6nukzjYnD
 txyV8rPHY9bKpdO8AHAPCSVRylxy/XIMURHTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635215; x=1719240015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DxtTYOw9GcJD97o97SCNtvhbKAScviwDaQWoEZq74c=;
 b=CY+BSLiSfYI229Tm6Seq7ejT3Qv2fBuvdESn3siTbX6z5Uyd5uwWU91bDZRhJVnM4w
 uKyz07P5vjwwf+eVSHq/OzUIx/R54iVAcLxARTQRXO5OClri2tubaYJxefJ4WuYy+nsy
 +YEuarbT+Y5BYEBiAbvnegCCCrUu81odBb/6RlCbRWC8MzAyXHa6+CTh8jI0qWW/ILY0
 OZn6VWjkCdEAUS/u/MYarkk5ytXu1ByZas4CZ/E5oiqt4ljHxoJ0svDM8T4+6wBoFshT
 jdLAvxb9NwK1BrL8jQUopmz8wfeckxySZrb9FhLf3aIlnci7Gox7kpL+d4TfgeBl+jqe
 gbIA==
X-Gm-Message-State: AOJu0Yw2GCD4MDTJqjEqAeatz9qGOD2ucAE+Zy+yEcGdqhltvX0iLzbW
 0hAr3pZUuWNLab/A5tsVsMJEsNS1MxVoD+Hr7LbvWAQXDqKzUxFEZRFA5UxaiNk=
X-Google-Smtp-Source: AGHT+IGaJCZZbp3wtaSlhf9Rh9Mmy1+35OkSXw8X/mAmMAyKC+n0TRD81ZIOmFNA4POU/8Q1JExLjg==
X-Received: by 2002:a4a:3107:0:b0:5bd:c3a0:cbff with SMTP id
 006d021491bc7-5bdc3a0cc38mr4665221eaf.7.1718635215432; 
 Mon, 17 Jun 2024 07:40:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5de7132csm1081180eaf.4.2024.06.17.07.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:40:15 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:40:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: Pull request efi-2024-07-rc5-2
Message-ID: <20240617144013.GX68077@bill-the-cat>
References: <b7a5261b-f94f-4d72-a046-09b0e181ce4d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zE6+pW8H5LoGl5XH"
Content-Disposition: inline
In-Reply-To: <b7a5261b-f94f-4d72-a046-09b0e181ce4d@gmx.de>
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


--zE6+pW8H5LoGl5XH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 12:22:32PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 2248c96ea1cf0b65377040d9f87ce7d8cf534c=
63:
>=20
>   Merge tag 'u-boot-stm32-20240614' of
> https://source.denx.de/u-boot/custodians/u-boot-stm (2024-06-14 08:13:54
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc5-2
>=20
> for you to fetch changes up to d1499a8b3fa30e4d835a139e958fc7bec96af412:
>=20
>   doc: Fix link reference to general verified boot docs (2024-06-16
> 10:37:10 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21141
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--zE6+pW8H5LoGl5XH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwSs0ACgkQFHw5/5Y0
tyxv5wv/RlNqosS/9aB9jQr5trHnxb5G1ZwyqbGaXEN/gYaSP707zy+sPUniVrIm
5G4EPXnshOjgCDTpnFsjvzVJS8S7JX7qYrg+GwbXdxbdlRQ+o8kbgqT5bewvsJo6
aEClRk3lfzELTxQKThNJzfuCODH8dU7LvGlnNJCVj5gVtvnD4P/WjvZliriOqM2S
Qz3JXaoQ3K4eNUFDnhK/gXxhfOc4xySpsHchTDfUSglJW3htWx4c+Shxa3TWCKmm
QpZ47lv3q7m24H9zOoHGWZ0wpxj4Y6mpr1LkWk6JomEeAZhyWViT16hOjkmknIwG
FKeaO4TjZzNcJIhDSQ1g8bGrQrpcqbG7wh58hY4GlljswJ6SY/MZpnbx1X8vnsrk
UAA7hFoqy9/ZV1QBzkadKknj6m13hTchkVan1tIkneypuOqLxH6vQ4tGR1ag1G7B
xn/g2JjJ7yXhS/6Tifyj+Q/HfwPaVR41AxWiNgEp5ecAi0sQ6XcLAmEGOAj0yvML
HcZqmExL
=MMBG
-----END PGP SIGNATURE-----

--zE6+pW8H5LoGl5XH--
