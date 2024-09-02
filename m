Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E3FCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C407E88498;
	Mon,  2 Sep 2024 18:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iMvcBdAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCC58876E; Mon,  2 Sep 2024 18:10:55 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F183588365
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45693d58a19so14707481cf.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725293452; x=1725898252; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NuTAMq1AO5kdvzcyg/yi07eHF14PaiIdI7LjEhpmUyc=;
 b=iMvcBdAoU8MwVlgyg/q5IypnjtEtrFZsedu1wvRqUyNtKmZKRTNEKMnfMZl7bU2I82
 WRnQhweQREOCbPUVERg9YNEvd6hOiccbKYVbc6n0/gJyP8wCcobqSebmKUU2pRsEYLat
 1H+RGZMP8aPRaSbdsE1tSZ6AJZMKuH58BUSXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725293452; x=1725898252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuTAMq1AO5kdvzcyg/yi07eHF14PaiIdI7LjEhpmUyc=;
 b=s5W4hwmp/oVlWeoJ+dJ647T5mEp7aQAW54hauZr6VySbnCfQ8aPOfZx50dcLZnbv0Q
 lelzR8pnictpenuBcMt7Os09o4VtckRy2P+wIwo090av3NPb4TOI8lpzdYjnFg8F/0E5
 vxKjmeR3XYJ5kjJ24cm8Mv5Sp597mwEgaxDGRYjarSAb1emJnYs5ztMXIeclk2OHNeYr
 WtmH1yMNDgQLPbPXrL1o+klKmlNfewXKAfAkhiB81EEGpzZEZiU6tOeIQtU8pRhyXvL7
 j4jWx3H1wSSJVc/jqSrHhulCrmPEwKXKEZF/ZSejMlgrOyPFgdyAwh8ynz+nQ1yvRboh
 GBYQ==
X-Gm-Message-State: AOJu0YypCXfkzjjdMaPb3j9JHuP8FTV5hZ1pMK3cmjZEDGCDqwyR0eIb
 633HU+XCcT8U2RMpAjIX299+J0JCBkERfw8mtv2HNo3dX/Y5rLzT2V8lxaE9HCE=
X-Google-Smtp-Source: AGHT+IH53GaWU2k9CauvR5afCnUULS6NIF+zLCpWv+jLMVMgkNZ4BZHJvxgq/9PSYiyp8r9DBLP8Zw==
X-Received: by 2002:ac8:6f12:0:b0:446:5aac:ca7f with SMTP id
 d75a77b69052e-4567f522837mr188617641cf.22.1725293451631; 
 Mon, 02 Sep 2024 09:10:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c9d2e5sm40403161cf.25.2024.09.02.09.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 09:10:50 -0700 (PDT)
Date: Mon, 2 Sep 2024 10:10:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 02/23] nvmxip: Avoid probing on boot
Message-ID: <20240902161047.GC2479150@bill-the-cat>
References: <20240901222634.460873-1-sjg@chromium.org>
 <20240901222634.460873-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zUdVFGxnESvwiboM"
Content-Disposition: inline
In-Reply-To: <20240901222634.460873-3-sjg@chromium.org>
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


--zUdVFGxnESvwiboM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 04:26:13PM -0600, Simon Glass wrote:

> Devices should be probed when they are used, not before. Drop this
> boot-time probing.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/mtd/nvmxip/nvmxip-uclass.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmx=
ip-uclass.c
> index 58e8c3fb74b..d18bd0e3d6b 100644
> --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> @@ -53,14 +53,7 @@ int nvmxip_probe(struct udevice *udev)
>  	return 0;
>  }
> =20
> -static int nvmxip_post_bind(struct udevice *udev)
> -{
> -	dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
> -	return 0;
> -}
> -
>  UCLASS_DRIVER(nvmxip) =3D {
>  	.name	   =3D "nvmxip",
>  	.id	   =3D UCLASS_NVMXIP,
> -	.post_bind =3D nvmxip_post_bind,
>  };

Once again, adding in the corstone1000 maintainers as the platform that
actually uses this.

--=20
Tom

--zUdVFGxnESvwiboM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV430ACgkQFHw5/5Y0
tyz1GwwAharZgm5+OEQrZn4Sa+4+iCSlOIiwoDPmIILXBn0Ngoe6OExUiwm9XiFp
RdXay5qcxgptN9i6m9uYBbFQBlNQnw3q1NTgPMrfUKNOxpycFohYOs7nUdy1Vefi
b5o8vZVUxv94kP3nsHffAnmFXz8X8f0ig5FepEGVG8lyZAb70Mc5MK7nLuTjrkhE
YAc8UbwryH6zzg7Ni6cjdRAeD/fd11PX3U7E2pP4f/RM5fvTk/BJKQ5RpkDOUKPv
Ca5slnupKxON7rFiEeP5DsqSktQz9M2LitHqPeHxrsCdJ+qyTe3nv+Uq1DuZO5R4
+i5IoCAZdKffwkAr25goFy3b9M5VuL0N//ZVRVvpNORpMl/r8dwjM3eDqsz1GPzk
3tQ4uyQ2WmA1yMzKtTJS2Xhf8u7e8ew6Ko5vqoktI9Ss4IQCbgmHRTOiaLUmlJ2M
YShkpRRMB5P6jUk7jFoh66wxAk4vrxD6TKGYzaVHDePpzrO4+0jlG4zDDSd4/3e6
46s1trYR
=TtI6
-----END PGP SIGNATURE-----

--zUdVFGxnESvwiboM--
