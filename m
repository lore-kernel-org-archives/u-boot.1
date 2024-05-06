Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93863C25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F361B88345;
	Mon,  6 May 2024 16:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LVzGl2s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E403885AE; Mon,  6 May 2024 16:52:37 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F397A87F68
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43ad4097aefso4916501cf.2
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715007154; x=1715611954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1nhiXoPDLOYJVFGVArKKO2CHts24Aq2EHukB8xzuWCU=;
 b=LVzGl2s3OaWH3D4EJ6oxKinoMMLypqHnjsfl7A0tSjMMCNLZKH77Hmbe0WzUpdLCxp
 ZxAk/KV0bAD5ypUw/uD2D68xNKHeQHh3CLEG5sZHT2vHVMkX/n1xQATBTFIwTMVlC0HA
 oalRVVq5LtnX6fhLfXJ7uj4oH/7Ws9EeJeh68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715007154; x=1715611954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nhiXoPDLOYJVFGVArKKO2CHts24Aq2EHukB8xzuWCU=;
 b=L2maQKtiTjzHsVcLByoSZ+KJuVPX3LtBuKOxHJhq0HP/sX1/K7bChFCRPpK0rHbCaw
 BSGG1kiP+TonkGP7ohPYOnoxc7zZmXtpIlhMA9pF0DI/GJVLnhaX/73a5aV1xM8Ek42Z
 O+JYKugFo5atWIpDWYu526Ar8MrPLcJURBU11ug67h44XILEVe9X120SuxUA+MN2mfdb
 c84C22S4KJpIN65pDXgZuRPkrMq5T0ctmMIHf56rHy4lpOu0YRqbr7ptks+wuIzgC9er
 1j5gqwe/Onlwevqfk5OVD63TH1/7aDMoCiw0i/pknL8g0cRbgMQNnU0qqCJYe1LrAO1C
 sm2w==
X-Gm-Message-State: AOJu0YzdHtWXwdffdNmy8o6DurZL3XTSUM3McpT8JQpx5heWn4dTlDxU
 fyrgrV0IICkW7NRu+Dm00qvWQjp1P3Jn6obuDaEKAqJYwfFVQxyGTOjfU8/E1qOM+qCBVhmghkp
 yXCA=
X-Google-Smtp-Source: AGHT+IEd4aJoUWxU7IltomA4yv8nVDLu0IdUujtQ/vh2QjUkC0ilH4VzJZ7+VwRKyaoeivKA2+BbSw==
X-Received: by 2002:a05:622a:2b4d:b0:436:5f58:84d5 with SMTP id
 hb13-20020a05622a2b4d00b004365f5884d5mr13858155qtb.21.1715007153596; 
 Mon, 06 May 2024 07:52:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 ci22-20020a05622a261600b0043476c7f668sm5214257qtb.5.2024.05.06.07.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 07:52:33 -0700 (PDT)
Date: Mon, 6 May 2024 08:52:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240505
Message-ID: <20240506145230.GM2568172@bill-the-cat>
References: <20240505191139.3024264-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EsjLiCJ7dlfRwrm9"
Content-Disposition: inline
In-Reply-To: <20240505191139.3024264-1-festevam@gmail.com>
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


--EsjLiCJ7dlfRwrm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2024 at 04:11:39PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
> The following changes since commit 2f1e76bcfee75b9f99ade63002c05ffaaec86a=
fb:
>=20
>   Merge branch '2024-05-02-assorted-updates' (2024-05-03 16:18:51 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240505
>=20
> for you to fetch changes up to cecb5fbb42c8b3de3d5a7df40bc01d1fdf4731d3:
>=20
>   crypto/fsl: Differentiate between CAAM and DCP in Kconfig entry (2024-0=
5-05 11:21:39 -0300)
>=20
> u-boot-imx-master-20240505

Applied to u-boot/master, thanks!

--=20
Tom

--EsjLiCJ7dlfRwrm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY47qsACgkQFHw5/5Y0
tyz3fQv5AcORLZQczqwH5gTH7qjyxPCXJ32dWECP6EQQCUHLbawHV0NCOuKPhLqO
VUTKmt2/qrLKhBhRbEDZjt3ET4ZQ2+30WyAawfV1CfSPXjMgYv7tYtAiq17V4UAA
AZMhwI92OwQPkqBUajwY1u2zLLEv+HHHd7iiIs61Tj2qTb1lWjPf3a70BudDdNIM
SN17ps4aBa3GIK61v+4wXx7rEBtSzQf73gZbu8O3Gg0p7gl5JpwlGOp/MieFxNC8
89AeLrsLtddu4EocgyNqVneHfFYk9+cAi0+KuhTc7H7oCV2jfeS1ZQV1orw6CzWR
sBuTkJBB/LZz0E3uyjCtOss2/Hv8uMKSAcALAGuadFq6uUTIUwfI1nwcYsbJosXs
lAROWzOd8NlqtQMMGKPx5K9ALFrEt3c4nzIHgftVNLpBqhJR4nSk6cm+pJp32Jcp
usRB2iWc6ToDNvUql8L/lQoQtXopuZaG9voXEZf+fRiWLTS/tvSJpZ+K44GV6qbA
7QCW4aQr
=4ZWZ
-----END PGP SIGNATURE-----

--EsjLiCJ7dlfRwrm9--
