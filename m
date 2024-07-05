Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BCBC38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09CB884A9;
	Fri,  5 Jul 2024 17:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YEapNHUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCB488395; Fri,  5 Jul 2024 17:37:55 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86FB8899E
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5c229aa4d35so802318eaf.3
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720193870; x=1720798670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jt0UH92IEppY1eGxukI8KXz8Qb2Mthp2J2qFlfDakIc=;
 b=YEapNHUYSOOFAMipukIcFd/U8ef5nDE6WoNAG3Wr1nZj+3FnLI5tXWIDslcUY8QWn/
 wFZvJv59uLUtrzMYpNLDquSCuRLo0ot6kYsqs75tFCcthg6uM74pZkTzusQRbXnc/73S
 PrFQySWc6ixNW2TYm2e0mNEv8thBYaQRgt1p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193870; x=1720798670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt0UH92IEppY1eGxukI8KXz8Qb2Mthp2J2qFlfDakIc=;
 b=vCHPuUkzMHrO8zmWw4TpQiXEXEocphzW0Fm5hdOXmZiIM6JSdOKVOupp7JvWFO6lUA
 3nWGP4uYle1N+gaJPSQG6P1hvOdNNO7oLliUaej6w8DHR0/h8KfltnSZIBTakmRfcwu6
 GKPg6r9dw65v7F8Ula5xQDtedFzSKXKSSUOka+ZwJjfYgnvNDag/INfHvKHlzYXkbs8+
 5qgNN8B4SP1yeNMH32C1GwEdyFWkuIkto3KVqW+C6Rp+bCotONu0NhRTma8/Ya55uKyD
 Jr/5I5dLZR6Ulxg8I5amR+QcSg3FUSSjRAOT2XLDZOpGKWSZgGKMpgl7A7/6dcYWfEK8
 TNtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl2yZsyezTDfD/IKfBT7nXKgQ/NwwIKl7SYOp8O3tnRWdRIbbx3fMEylUfUllHrQaBZCQ1zEoq9IjQOQeJEtzmOkPR0w==
X-Gm-Message-State: AOJu0YyCOPA6zQaKMJ/7J/AyGX7jJB8clPif/N5U60kx24SmmB7HogDE
 CEgRaKdqvB1pDTgjxys6PE8nwjzQXHG3OKIFITdN2bSHQvuQ9x3YRzcAMDoq6BI=
X-Google-Smtp-Source: AGHT+IHa6iUmmsgxAMlJu+NGNXYer3tyxG90WUrN6NjpUI9oa8jozBd1qLwwJr+mvQFY+vTH/oq7Pw==
X-Received: by 2002:a05:6870:9690:b0:25e:56b:484f with SMTP id
 586e51a60fabf-25e2ba183c2mr3960466fac.16.1720193870459; 
 Fri, 05 Jul 2024 08:37:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e036fd73csm1604953fac.26.2024.07.05.08.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:50 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:37:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: ian.ray@gehealthcare.com, sbabic@denx.de, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2] msc_sm2s_imx8mp: Adjust the initrd_addr location
Message-ID: <20240705153748.GG38804@bill-the-cat>
References: <20240704120337.673211-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S3FI/oLPyHqDgIJ5"
Content-Disposition: inline
In-Reply-To: <20240704120337.673211-1-festevam@gmail.com>
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


--S3FI/oLPyHqDgIJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 09:03:37AM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> Booting an initramfs with the current initrd_addr address may lead to
> initramfs corruption and boot failure.
>=20
> Fix the initramfs problem by applying the following layout
> suggested by Tom Rini:
>=20
> loadaddr=3D0x40480000 --> Gets moved to 0x40600000 in run-time:
>=20
>    Uncompressing Kernel Image
> Moving Image from 0x40480000 to 0x40600000, end=3D41e80000
>=20
> fdt_addr_r=3D moved loadaddr + 128 MiB =3D 0x48600000
>=20
> initrd_addr=3Dfdt_addr_r + 512 KiB =3D 0x48680000
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Tested-by: Stefano Babic <sbabic@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--S3FI/oLPyHqDgIJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIE0wACgkQFHw5/5Y0
tyxfVAv/dO4kIbHQz7RnstZSeq79LM7AFGwywEemzJHO0o/WRvJo5i1oMPUAtT/K
hu1tL9f+ys+LWai95pcNAukoHB6GlwA8Yg1e6sYK7Ox9H3PSGZ2ye9q7wOEXbP/2
56BnGbasv3jIxXtu6IdZcUNMqoXJ5Pa6ndV250OrUWx9Tk1MLuAzIGynmhVviQZ4
iITfRcHCaXqvWdFyFA9l2E9h/6hjTot1ldX4ZVn4DvGHD1QTLA5wDcnFlIF4RF+A
kiiXQnOoQYUZwJwgr6fY4CRjhycHEX2GQQb4JkV89Im4mybpLzeulg0FJH7L10Az
chRb94hAw+6+mY2507ULfmwiUxvNyxBbmhQLTbH+2oFBUWwgIOwlY+qVTevUfS/N
WJalcRa+RS2O/psUTM1c3hk/mm3vvC9Cnb2Sfl8ljELGUCfCbSWhfte3S40XwMak
9aIatLLlVPM9zjF6ggO/FawCzh4pv4WsVP3i/+bWGhHD0t1oJ1IYoU8fdZAj+e5t
bI8yvXvG
=U5PD
-----END PGP SIGNATURE-----

--S3FI/oLPyHqDgIJ5--
