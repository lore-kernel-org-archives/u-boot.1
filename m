Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01635CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 20:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3614384206;
	Thu,  9 Oct 2025 22:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rmB853TN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AAB8419E; Thu,  9 Oct 2025 22:14:29 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD8684206
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 22:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3b3ce7277b3so497289fac.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760040866; x=1760645666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+f5+P6fQziCJL6gGQ3XHMh/xaH1DpDeUFHcxyB9Vas=;
 b=rmB853TNP2T2bmD7saNpfRg1rDwzOTxJTqYdSLfVZ1pw29D8v0prYm6mLIHp018FTH
 6ARiI49wGOhUYbCInffXTXcHBxQUSEIRBACiZBtRMPi7dooVRsvPs6NgF/PbDxhSj2Z5
 G6lXYb3rJRZ3YzvLH0sCzpekIBWPo0UXxR3oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760040866; x=1760645666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+f5+P6fQziCJL6gGQ3XHMh/xaH1DpDeUFHcxyB9Vas=;
 b=R8hHjrzDxCnKPoTdY4dlcGrbmdsZVFQSaKUV/PAyMkc/+kIbXjB9R7XwqAdjsTiufv
 CRzV2ymFmOVMyqf1SxuOtrpMO9oWWDhukA7stm6pGy541wwAmxW70hqfKnri3cH3y2UU
 71Xc5AZNyikwUP0IWx+H2QDKKgIi3euRVeSnJM2Ea+NPq2d2eILv791xyhDFBV0Q8NAE
 zVKsBKx2LZFV+kiARjjdD5T+SMRGfB1wMSuYcDq5U3YFxDYiSuJw6wOGgEHnFDtF5fGB
 Vh0cU3C5UzIMUCtgstacvEdE252n5Lil6XvKeBA/uHY8fw14UBPuGkQ0s8wn0i/rzg9h
 /hiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqvTbauFPImE6eerpmJtzLqv9jL0T+GWIOBJFjxle2Ubb8npCRqU9VIoQBS+pN5px7KDVuKZY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw97zRJQsfsVGGUb6muBAQrfpaf44mE/+/pw0ajAPcQu/hXVt4w
 U2JzYjRmGbMrrhVMSPeIWYM8Cme6WaBwvXluf/TNx65exV14CnR8LqhnMeuwfOBiUmI=
X-Gm-Gg: ASbGncu98OFsSwcf2fV+SIwZtN4HefumZwAx8mVLKeAfCrforqBUxmQIgx744DwxErf
 Sw7OzRg2NmaQ5oCncibWTRbBaAFLSMyJfnRUuB7f1fOt57iYKClDDEICKq4ZCxAz6ZB8bNuNJze
 xjNZd3Mt/6KwZJXGAQXAhggkWBt357KqiPgFhoEgwSuYI7v2t0SKPNQBYTIGES3ygkwccB7AsxI
 J8BWxqjRbpwc94uab9JjJkcJQgkVt4UbEGVZ2q4uZFVdQpynHvG6o2Soxqq4/qLLqwakmLUiWDP
 OQdmUy2YWuvFo8EmJGvATLa19VRTzkcSP8IYJSo29X3osV1Oi6svJQNVHGSSr2PclYkHjHU/Xhq
 2hiMvX8ZRWkebc8/IvOF2fY8iOZBBEpfaGtPU6ELdg2wxgo4J32auAeAlmbCsHqAXUoPl3gzaKs
 FzHIHXtsy8NaWwRxaSIr4g
X-Google-Smtp-Source: AGHT+IGtzYtDj4UnkMm7sLv9yoiZnSSmeYVrReYBYJ4VwzU0ZTKXxAU/RD7myZAjG0rddwUK0+pWAg==
X-Received: by 2002:a05:6870:e12b:b0:31d:718f:a09d with SMTP id
 586e51a60fabf-3c0f80edcbfmr4107554fac.25.1760040865921; 
 Thu, 09 Oct 2025 13:14:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f2e7a9sm178678fac.24.2025.10.09.13.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 13:14:25 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:14:22 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 07/10] firmware: scmi: mailbox: Support
 arm,max_rx_timeout_ms
Message-ID: <20251009201422.GA226328@bill-the-cat>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
 <20250927-scmi-v1-7-5e9354fb3bff@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="az8CqqP23Y0MiHwH"
Content-Disposition: inline
In-Reply-To: <20250927-scmi-v1-7-5e9354fb3bff@nxp.com>
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


--az8CqqP23Y0MiHwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 12:06:20AM +0800, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Per devicetree bindings:
> arm,max-rx-timeout-ms indicates an optional time value, expressed in
> milliseconds, representing the transport maximum timeout value for the
> receive channel. The value should be a non-zero value if set.

This is what dts/upstream/Bindings/firmware/arm,scmi.yaml says, along
with a minimum value of 1, implying that yes, number of milliseconds and
not value in milliseconds.

>=20
> Support this property if platform set it to a non-default value. This
> property is a per SCMI property, so all channels share same value.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/scmi/mailbox_agent.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scm=
i/mailbox_agent.c
> index 32b0fd9f589a30c2bb8bdbe8d655c3d47d0abd5a..16a82f55ab7f7550e7744066c=
d640b0c439f75eb 100644
> --- a/drivers/firmware/scmi/mailbox_agent.c
> +++ b/drivers/firmware/scmi/mailbox_agent.c
> @@ -16,7 +16,7 @@
> =20
>  #include "smt.h"
> =20
> -#define TIMEOUT_US_30MS			30000
> +#define TIMEOUT_30MS			30
> =20
>  /**
>   * struct scmi_mbox_channel - Description of an SCMI mailbox transport
> @@ -73,6 +73,7 @@ out:
> =20
>  static int setup_channel(struct udevice *dev, struct scmi_mbox_channel *=
chan)
>  {
> +	struct scmi_mbox_channel *base_chan =3D dev_get_plat(dev);
>  	int ret;
> =20
>  	ret =3D mbox_get_by_index(dev, 0, &chan->mbox);
> @@ -87,7 +88,7 @@ static int setup_channel(struct udevice *dev, struct sc=
mi_mbox_channel *chan)
>  		return ret;
>  	}
> =20
> -	chan->timeout_us =3D TIMEOUT_US_30MS;
> +	chan->timeout_us =3D base_chan->timeout_us;
> =20
>  	return 0;
>  }
> @@ -127,6 +128,9 @@ int scmi_mbox_of_to_plat(struct udevice *dev)
>  {
>  	struct scmi_mbox_channel *chan =3D dev_get_plat(dev);
> =20
> +	chan->timeout_us =3D dev_read_u32_default(dev, "arm,max-rx-timeout-ms",
> +						TIMEOUT_30MS) * 1000;
> +
>  	return setup_channel(dev, chan);
>  }

So the rest of this makes sense.

Reviewed-by: Tom Rini <trini@konsulko.com>

However:
$ rg -g *.dtsi arm,max-rx-timeout-ms
dts/upstream/src/arm64/freescale/imx95.dtsi:			arm,max-rx-timeout-ms =3D <5=
000>;
dts/upstream/src/arm64/freescale/imx94.dtsi:			arm,max-rx-timeout-ms =3D <5=
000>;

Is the timeout really 5 seconds on these platforms?

--=20
Tom

--az8CqqP23Y0MiHwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOgXmgAKCRAr4qD1Cr/k
CnFZAP9d0GnkBVfXdPInF+FvKuDlmbCbTIJ7eCh5ldRF5dbWHgD9HJcCbewPRbKx
PjzzcQoStznQhInpUbx3McnPQXQBRAw=
=cyJm
-----END PGP SIGNATURE-----

--az8CqqP23Y0MiHwH--
