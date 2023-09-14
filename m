Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F43DEEAA57
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D0187071;
	Thu, 14 Sep 2023 18:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cXOrxeSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA0E86AB3; Thu, 14 Sep 2023 18:29:36 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E03D86AA5
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d8165e3b209so2471754276.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694708973; x=1695313773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=isgCKD4fnnA9qFbqVQdcst2wYwjvuGhzlrDzRCE8tlE=;
 b=cXOrxeSVvJxJS9fLKrR71b1qwhdBTun4jeIEO2WCBc4nMS4a6WHyxzoRTjVoDUnZ3H
 dbT+KjmWgUWk8uSPd7mRZn8mItJxuY6r7prcSvaxhYvuQ5rDNIGDZeJXAjel9fY3Sl/f
 20LUUWhh4PmOZWNkauMbok/wzvwiL+8qNfivo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708973; x=1695313773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isgCKD4fnnA9qFbqVQdcst2wYwjvuGhzlrDzRCE8tlE=;
 b=ruGfZipux4svxCC5p0YcX7csdVSujGBIWqspje3V9hFUg6MFjohl48/g2be4PChhzH
 uoA9Upqp9Md31sO4Sk42mZU/45Vs8VPRfcfs6Vv9gmBpUzpsSayDfhFwntJFaAlJCTTa
 MUkX1ISRaVXKXWR0KyOzOpiaJKaiDa92ywfSmpCf60loYW/mBLP1Ddskec3PnTtxKLEb
 0J0yA6PW7KIp4/TEjNdbbzCrOPl3tN9HZ2SyNuosXn44GiiwH3gm3QvmJMK9m+rEVxOU
 XieWfAUJysBkM7IqvvWsXTOBWqyVK5PCaVpe+E9WoSm2KoRDiJH8EMsJpiv4ncKB/A+I
 ofXw==
X-Gm-Message-State: AOJu0Ywqa2XSLotRE+F54Ork99+pav6amGfWc7SIyEmBJE6z81juKWZU
 sih6TLPrvFCgYZhyWFQvCUmu4SLE9XVzyODjWOmd9Q==
X-Google-Smtp-Source: AGHT+IGo53ggeQh+CzqX5FPWAKHwY/ztjl8Ea7IYNVxxVePiSlQYY7xTLUj2aEGGLDr7Aw5L8sFUjg==
X-Received: by 2002:a25:f61f:0:b0:d81:41e9:6cf5 with SMTP id
 t31-20020a25f61f000000b00d8141e96cf5mr1936981ybd.27.1694708973242; 
 Thu, 14 Sep 2023 09:29:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a25ad93000000b00d72176bdc5csm402325ybi.40.2023.09.14.09.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:29:32 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:29:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v1 1/2] part: Add a function to find ESP partition
Message-ID: <20230914162930.GB305624@bill-the-cat>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
 <20230914100821.755904-2-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bpLXMdhjiVFkQD/H"
Content-Disposition: inline
In-Reply-To: <20230914100821.755904-2-mchitale@ventanamicro.com>
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


--bpLXMdhjiVFkQD/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 03:38:20PM +0530, Mayuresh Chitale wrote:
> If a disk has an EFI system partition (ESP) then it can be used to
> locate the boot files. Add a function to find the ESP.
>=20
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  disk/part.c    | 16 ++++++++++++++++
>  include/part.h | 10 ++++++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/disk/part.c b/disk/part.c
> index 72241b7b23..2be0866671 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -841,3 +841,19 @@ int part_get_bootable(struct blk_desc *desc)
> =20
>  	return 0;
>  }
> +
> +int part_get_esp(struct blk_desc *desc)
> +{
> +	struct disk_partition info;
> +	int p;
> +
> +	for (p =3D 1; p <=3D MAX_SEARCH_PARTITIONS; p++) {
> +		int ret;
> +
> +		ret =3D part_get_info(desc, p, &info);
> +		if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
> +			return p;
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/part.h b/include/part.h
> index db34bc6bb7..036f9fd762 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -689,6 +689,13 @@ int part_get_type_by_name(const char *name);
>   * @return first bootable partition, or 0 if there is none
>   */
>  int part_get_bootable(struct blk_desc *desc);
> +/**

Missing blank line?

--=20
Tom

--bpLXMdhjiVFkQD/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDNOoACgkQFHw5/5Y0
tyxaIgv+Nj0jnk7vcR3TUs1Cv9VapZS9aZmp4rDzWKkwlIxSEKRdCa80BA4sPG/8
Hm7WaRECCVCGBjBZDaC/x6H+b2ObkMP2x/kyl3gjHlgCglx9tVMg+PSJAd1BM1hc
vTndzT+js2XA+eASSe9pz0bTXdsj5CsEC8YtZsg+gdiddr780PY3BUgvb0CVFV4I
l5P8LYZUu5pPn2wdSfO9MQFr9WBN51mHZpDKPQptmfPxamJB/o1W0Ze5TKSUPPnH
5pSPgt/OGFzTCj81XJ9p19G73dWVKl2NXneGNI8AQCcO3xrIr/1MculkHgJLSOOT
9qcUh/mTLs+hLCxrMyaR6t317SWAyBVANHRJghCpr/CsjaDQd5CpFjUISxNB3Swq
hg7C9a5v8R08ifM6NpXx47bTeizUwM9LHC51zumxkthdIbc/S6DeZwyH1U9tcS6c
xP0OPeZW5l4OdlcXp86D4qJRs7J78v1koiJACNtTC+TupNnBAU84c9Ok1yWPsbES
iJgZ7J8y
=oW00
-----END PGP SIGNATURE-----

--bpLXMdhjiVFkQD/H--
