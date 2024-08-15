Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D4C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 16:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B5088A76;
	Thu, 15 Aug 2024 18:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QQV+n7U8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00FC88A76; Thu, 15 Aug 2024 18:57:16 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCAA887D4
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 18:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-267b7ef154aso807464fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723741030; x=1724345830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bobuoUzk9Mu3731Efb23nkvX1WWubqJovjfz86vL9AE=;
 b=QQV+n7U8ULivBY6hM/GL9ejDpspiTqYXP6Op9j9Ive04iRgoxtFDSDM5yKYg9DExN6
 XO+2xrtfi9MONsE6KcXtT9GH6+12IpCvSXlx7JxcTvr4EFrgSiLLEWcZ/tUGFbeG+5u0
 11jQKvIrI9fV6Un7XUHghIGP/J3VIvydyVcAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723741030; x=1724345830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bobuoUzk9Mu3731Efb23nkvX1WWubqJovjfz86vL9AE=;
 b=CNdqOg8cwrpQ4MJdaEx/6qKsxA5681DJsXm+k32jiraGlwfKM9ybJtA2tGivJwQIdC
 rEpWyV/DqlVs/Dc1yRqQMSGkTy/m0cHqWG8/5tWWzynyXyQSRROwdqVabu9xSJn4u+Pr
 if5Ug299mNibbkgYxE5VwGDKmVDo/CKbk4YoN//i7HPoJ9tcMQMRrepsI1HX1zcT60bX
 7MjP/aUnC4BnZOedpu1oRePQf5Vh4mzgHgQVph6AHKXxyaLMjq97+5S5DgUc//oZWuiH
 0rCbLG3np9DVPB5Q32kjaR7CMAEy0yvEkeS/SEh9YfeDKARcPlt5kneKwZXui4MV8gLQ
 H8tw==
X-Gm-Message-State: AOJu0YxFta3krchcVlUxUJa4ZDgIY2ciCKKfD7B+TIii3IiTv4dJfpX1
 sJyLuNfF2gfiaCZnIasUJdJXXS3ZAarD6mdbQY8qAhy/72YDi1XslibzhP/wcY8=
X-Google-Smtp-Source: AGHT+IEWh+w65++dzuE/TwAilY6cwQrWI0OwRNKsORFH4u8NX3uCvp0gRj/1vp4cd/xuxu0lXbyxLA==
X-Received: by 2002:a05:6870:d153:b0:268:3afe:54f with SMTP id
 586e51a60fabf-2701c395941mr155874fac.11.1723741029821; 
 Thu, 15 Aug 2024 09:57:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca65af728sm341042a34.37.2024.08.15.09.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 09:57:09 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:57:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 01/40] nvmxip: Drop the message on probe
Message-ID: <20240815165707.GS1626301@bill-the-cat>
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UIWlqqIHP3lB3PeD"
Content-Disposition: inline
In-Reply-To: <20240811145209.4191404-2-sjg@chromium.org>
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


--UIWlqqIHP3lB3PeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 08:51:30AM -0600, Simon Glass wrote:

> We should not need to announce this device. Drop the message.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/mtd/nvmxip/nvmxip-uclass.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmx=
ip-uclass.c
> index 254f04e0b99..58e8c3fb74b 100644
> --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> @@ -47,7 +47,8 @@ int nvmxip_probe(struct udevice *udev)
>  		return ret;
>  	}
> =20
> -	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_=
name);
> +	log_debug("[%s]: the block device %s ready for use\n", udev->name,
> +		  bdev_name);
> =20
>  	return 0;
>  }

Since this is essentially a corstone-1000 driver, adding the
maintainers.

--=20
Tom

--UIWlqqIHP3lB3PeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+M1gACgkQFHw5/5Y0
tywtJwv/ct8UyBWWXj28MYFWXXcgaBvbRBIOq/xNmR5ljf5YlIPJJxKfyOlxXFrd
/SE/fBh5xZs7/RX/PyYULBJrmhHocN32wH/LyZ4eFhh3UcX4GNi+jIx+B4DmVDWq
vXGCd5HN81ymWoGBUTxCnoFBNck0y7MgoMBDTRKXW9btNAOSWTYdgXSWkb1N1h21
2v1rvRjiHS9LrYKo9gtxGxsbaHYPqYeJ4LNKJCU8EuRl+mgf6kmou3yAQCEathdl
LH1vuHO2VEdBT1WpnCGmVRZ+CTcPjHHKwhOEFg1zlvoRiCUK3HVgtzNf5Po7jV0t
yRxvMmRbUOgXo35kRtiqYoY9NX/IseP/2N9et638jLp9PnKEaF9HRvDdZESrHONt
J/hXY2D2w7tctZ7WR8VlaxfFpMBB+TUhHLql05EXwBBp7001ALl5tjYronMRF1ws
2tHhl7kxIuXZDCITrlmeLrw4ge+GMQ/+TfaHuFlql1EVIBkWXni9+vrxE2TMOo3y
ncd3X2aH
=G8wf
-----END PGP SIGNATURE-----

--UIWlqqIHP3lB3PeD--
