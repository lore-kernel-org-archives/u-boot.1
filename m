Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F44D1715C
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 03:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA9E88F2A;
	Tue, 22 Oct 2024 05:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i0TFrhae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6894188F2A; Tue, 22 Oct 2024 05:35:23 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C7888F4F
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460ad98b031so28042011cf.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729568120; x=1730172920; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CdnSaLc5hq5HJP9b20IxzO/SIQBSNd5W32pgt1ZO644=;
 b=i0TFrhaeQesLyMk2LAaW7xE1gSiZ55CJYPEJ5PFIcT3ccQdzwr7wAMIJxkncWyawUB
 etnWaYJlsEIvH2LRIECtTDBKUHKjhWW8PIqyzgIHgIXY5c2XIOf+V7Bdpbb/vNT3Ks6V
 +oZ9ypCMpecSqVkNnTazV06c01SGWiSff6+6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729568120; x=1730172920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdnSaLc5hq5HJP9b20IxzO/SIQBSNd5W32pgt1ZO644=;
 b=YDsPQ6loyUcHWZwVYdIYbz9vTdHOHnBnQAsjRkbz+dAhaLQ2N/THMDHL3idB1xzjk2
 +Vnxc4BZflxPOPwxGR2SfJsy8L1NIAPX3WzGMjQ7/ceLXtYmz7t3mIY60gC3aIGGFtpV
 U/VLMYKjLmgijHD1+MEFGwWFurNPlbeXL0c8CUJwWxOkk9gB7XtIPx+PgaKgBVOrNiPa
 jI6giDaeBdUdKFAJN8cZ2ZjBzUP2n/I6aBjDMtab/QkVg5PgkFXju9I8ClagC7wltZyu
 l/CmefbW+Bf/2VBktBWtBcHaT0AzPhtOYKOo3Elk9zZkXfOhf2lY+68sxXcFgmKMpqLG
 9OGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXENjTC6vGHWXxaznYN42uaiUqHxYnzi7CdGaYwg0D39qX6UKFkGpaTtP0l9VA/Ga1rpBjFDec=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7o+U7kLeq6SvhrkO4KzxiRvL31DPTMEsEJZGRLgThTyXGrl3G
 vWJxBa+JYH79ID6cMkV2E5QPp71pTxclUDxnjF8BY+YoKsEfvip3RWzX1WgYNbk=
X-Google-Smtp-Source: AGHT+IE5ZtWiLbDFHl/RfSKIZPxK4q0AWR3stAutsXdJ5uqWDbX5oiB0IzKPjnI/bbcESGHwjF1N+A==
X-Received: by 2002:a05:622a:2a05:b0:460:8ede:cf48 with SMTP id
 d75a77b69052e-460aece75famr184871931cf.10.1729568119706; 
 Mon, 21 Oct 2024 20:35:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3d7410esm24929001cf.61.2024.10.21.20.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 20:35:18 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:35:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Julius Lehmann <lehmanju@devpi.de>, Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] scsi: fix disk capacity too small by one sector
Message-ID: <20241022033515.GA3053232@bill-the-cat>
References: <20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LGKw3yva/crETYx3"
Content-Disposition: inline
In-Reply-To: <20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de>
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


--LGKw3yva/crETYx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 06:06:35PM +0200, Julius Lehmann wrote:

> SCSI READ CAPACITY reports the address of the last
> block and the block size. The total number of blocks
> is thus last block address plus one.
>=20
> ---
> This patch fixes the disk size reported by scsi. Up until now, the report=
ed disk size is too small by one sector. Read/Write operations on other sec=
tors have not been affected. Trying to partition scsi backed storage via um=
s has resulted in "storage too small" errors.
>=20
> doc: https://linux.die.net/man/8/sg_readcap
>=20
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>  drivers/scsi/scsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 51cacf3479236be6c6ea3e7d15b87e03f10e7f3a..bcdeda95ed1514119057cc679=
74fec465cf5672c 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -309,6 +309,7 @@ static int scsi_read_capacity(struct udevice *dev, st=
ruct scsi_cmd *pccb,
>  			 ((unsigned long)pccb->pdata[5] << 16) |
>  			 ((unsigned long)pccb->pdata[6] << 8)  |
>  			 ((unsigned long)pccb->pdata[7]);
> +		*capacity +=3D 1;
>  		return 0;
>  	}
> =20
> @@ -332,6 +333,7 @@ static int scsi_read_capacity(struct udevice *dev, st=
ruct scsi_cmd *pccb,
>  		    ((uint64_t)pccb->pdata[5] << 16) |
>  		    ((uint64_t)pccb->pdata[6] << 8)  |
>  		    ((uint64_t)pccb->pdata[7]);
> +	*capacity +=3D 1;
> =20
>  	*blksz =3D ((uint64_t)pccb->pdata[8]  << 56) |
>  		 ((uint64_t)pccb->pdata[9]  << 48) |
>=20

This leads to this failure in CI:
https://source.denx.de/u-boot/u-boot/-/jobs/926468#L288

--=20
Tom

--LGKw3yva/crETYx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXHWwACgkQFHw5/5Y0
tywwtwv/RjPnQujbWI0JntBJW+7VZMCaK6MfzEs584F5bvxkhJzAsdV/lnxms/UN
EzGVyJXTC0hqBvZdLKebQ8kxfDhaJtfo01QGlNnejQ8rcTDy/Y55+LToNcG9vPAx
6C4Blxcb48zVAuRigy1qPhTK+ycOwltmtrDliicuUZUuwM1YaRDRvpADnKwfcY+F
1yWLy2/hA/0eea/7nB85kKx2Je/g+bFM1SuiaJrSrqATrRa3+BOTkAaDjSAXwhUA
A77AOaIALiEl7jVsOO/pz66A3pa92gJehU3XjDayGF2m6xk6ebTAwy4+2JourU9u
Z7okH7aVMbDl+lsDEwWCMQ7wfhLVQqhlQP49wPGb48c9LjfrZVgN335r7H0CEIgR
DwqElgpUG8nyZzYDoU/7zp7gtCJtul8fygu8FT1/u4x7f1L//bwRtEEP+neKQtsh
U/z/nKEqQl8ZKwuqzJNc3aOwrF/Y5q+8ASP1kbNGrmNYsqFA3Sf6bvPhP6RM9+/i
SJVgQJuE
=bmtC
-----END PGP SIGNATURE-----

--LGKw3yva/crETYx3--
