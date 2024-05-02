Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAB7C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 14:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC3088399;
	Thu,  2 May 2024 16:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OMJvybXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7D98839E; Thu,  2 May 2024 16:42:22 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3D28838E
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 16:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6a073f10e8eso36933356d6.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714660939; x=1715265739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6wnkJjdyuxv/MYDhGKLezhH8c/EONLjeBggxzlg4ELo=;
 b=OMJvybXMwex0iiUsJPl/e8m0haGvtPJyWEUB3REti0Z4Iodffx5nkCaXZLv6dCqRBv
 7K28yfYzDMRr6QL/KTxCVGRN65Mh/H5+LUUqM8Ynl0s1c0nmXQ6Z1zEvoJNNOJpj1AfQ
 8ncgXeezd4CA1HgzEocq3ushmFQ8YePaLF9ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714660939; x=1715265739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wnkJjdyuxv/MYDhGKLezhH8c/EONLjeBggxzlg4ELo=;
 b=TYOcWKp10FUpjssC2pxcMp2wwtNMeVcMs3N7aIkq+v7AIwgQ9CrhlLMtW5IoijAfvN
 h5PzahHdoY/EomWxpAwbMiTAiQlyyUuEqu7zMVDgDc3lV3/uuN68W9jJgQK4r4UuO9hF
 oA46fZJ/dKU0pnNPyV/BIq4VJZ54BPGjEBJMC+IgwwIFUolotQvyt03R/eFUdGyEQ2Pn
 nIVA4U1m/qI9gdq/owY7Z1lZAFV2jfMkpX3rXlR9rFaM604Ht+C6jqCaC0DWPxXnE7Ai
 41c7KuVe7e7jSAkm5CyOC299yWW4MUYkQPWsZ/x4OcjlvugsqXTTRN3sHD6dtITzusPo
 po9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDuvrvGgAeWA2lIHUle9V2FoqQdetk8lLFpqGTaAG6YmkOlxnklyNbKxxUy8y7MO0cK6IM8LpB/yGLfTyhrmDLygQX+A==
X-Gm-Message-State: AOJu0YxCgvrf/2hWWqB+bTIb2lUJPui0wAn92e4JbNbfjOHNSsSt6sAH
 +oth2L/3vEtcP9loDVUg2EvLxizYmS6WKvpJyxdp3pr10GI5IBjXA7N0Eua81pI=
X-Google-Smtp-Source: AGHT+IHdEMQtGHwTfthuLdfrj9fHpH2OMlTihx3ot+Ucg0p3PXiuAhfh4QAZe1D7GyBRNi8A2dFMJw==
X-Received: by 2002:a05:6214:c8d:b0:6a0:d04a:d2de with SMTP id
 r13-20020a0562140c8d00b006a0d04ad2demr6437966qvr.42.1714660939173; 
 Thu, 02 May 2024 07:42:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a0cfbcf000000b006a0f99f884csm401636qvp.54.2024.05.02.07.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:42:18 -0700 (PDT)
Date: Thu, 2 May 2024 08:42:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Pull request efi-2024-07-rc2
Message-ID: <20240502144216.GT1054907@bill-the-cat>
References: <400218f9-d580-42fe-bb61-bc75c4e69cf1@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oud5wGb65Vdt/zxa"
Content-Disposition: inline
In-Reply-To: <400218f9-d580-42fe-bb61-bc75c4e69cf1@gmx.de>
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


--oud5wGb65Vdt/zxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 11:14:27AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit ff0de1f0557ed7d2dab47ba976a37347a1fdc4=
32:
>=20
>   Merge patch series "Update PHYTEC SOM Detection" (2024-04-29 10:56:05
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc2
>=20
> for you to fetch changes up to 8745f13fe102968f58a9e2e5f69ad153a675b59c:
>=20
>   efi_loader: pass GUID by address to efi_dp_from_lo (2024-05-01
> 08:40:42 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20590
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--oud5wGb65Vdt/zxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYzpj4ACgkQFHw5/5Y0
tyxoNgwAkexxvrLO/xXvxqJtBmzcQSVZFT4I0qH5IbFsaEat2V55Uc9tUE/iKuf2
fPwXUY1/XaY3zo0DanLICiUOJZuOqQB6AUbgfeh8yqDbbx5QPPdmydqtKBgwktra
Lpeq2Pm6EHMUIeK+VB9Ao1eRKviVVci6pQ7GflgmZMNflgLgCISMzBBQ0apjqYw2
LU6iSyZ4v+/DwFU/gAe7zZ/N0GCFv60MjLxTgkGs2rym07H2DlrjQJTCtlJTqoqK
GkaCnUJ6pxOinxeXlWhZvLAQFQyBSRHn8gi3PLs0MloaUpzAUbrO1ipCpTNUhri2
xkwtV748vI9q1S6smsTL4Bi9TxCa5NjXhWt3+j5dYpIiyeuF9UwgLBQxTBSICna6
TCQW/+heMRR/UvIIIp2HcYG2i2dD5hw1XKgSEthbk71U/0i5D7BrlgaPdwUgozC1
kT5QRJ+zooeogEOw2EdBvsPeMIuHbl0x8ESggNVPTtZ1RjUaeEuQrF+MmHXNsOp1
HrozqsNY
=Lp8m
-----END PGP SIGNATURE-----

--oud5wGb65Vdt/zxa--
