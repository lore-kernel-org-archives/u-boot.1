Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C5C48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4A187B8E;
	Fri,  2 Feb 2024 17:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mmzII7Mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15ED887186; Fri,  2 Feb 2024 17:07:11 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8CD87BF2
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42a4516ec5dso16187071cf.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706890025; x=1707494825; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N85CpsPcgW85Z8WkuNS+Ym2AxcL55TgmnWvR49Wi2bA=;
 b=mmzII7Mx1uhGzSC/iVn6ERig0dBmesyN5pNRTiGkh+JHnaqrwSoXNSzzdzQ+yLRmlb
 054yS/a4n6FHNWe5tqqqWCob08oElVRiI/DiVZZTcxCAwEf7ITlCZI2cqtB1oiufwtwl
 5JHalrGof1dzGeQLPLLPKS5LkHW703onRfFyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706890025; x=1707494825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N85CpsPcgW85Z8WkuNS+Ym2AxcL55TgmnWvR49Wi2bA=;
 b=sWRjLZQY+ZxygVOMRtMhl/AEi0gyDTrh9HoDldgeoHu5KXrp1SmXp2BC5EyhxxaBaN
 3zH4kkkKTyqw+2XLVu07VclbX9KMAaBWFnqpA0lLLrs9/irIVOUNxPTO0x5E78d/46Gd
 k29EenfPsldt+IGmx0cs0VgPT3bjm6RxVaP0VLMu9QZPshvNQFrM2VDPiP6nnA/nMCUX
 B+B2rkFRf/OB9AnWK853ASZtLjWCProaJfBRV6Ww8fLLDV2Vex7mxAOXyOVY2Opxiqog
 xHcQ9teRXdnnkOklHKC76/MGJAC43mqYeB5EtXvlSRzSC/MaN0PFu4i72XLdR1Tt6r7x
 TJsg==
X-Gm-Message-State: AOJu0YxqVLonBjvxa3Ib2hEX0lm1xd8nJvUeOtzbh0ZC2LGS3RVW3kHd
 ivWhyBAxXyb1IpfoxoO/TQW5Loj95OUhgmSp/eF7RE9lruHimG4J2U/haLkEbrs=
X-Google-Smtp-Source: AGHT+IEOw824xNbjdRsWPb4wyyNM7C9lq63vHI33zSmurf83WFyY+pmb4xCas0jE9Bokg5MKRFuIWQ==
X-Received: by 2002:a05:622a:552:b0:42a:8a40:e33c with SMTP id
 m18-20020a05622a055200b0042a8a40e33cmr6149769qtx.57.1706890025539; 
 Fri, 02 Feb 2024 08:07:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXZOoipV8jI284fxH2t5CDAXMiHdfWwM6N77M35zPYwQf3Ui4o3vy0Ns0HnAG1qcHKYnx4xYfeP6A5K/21NWKlB0OzKMPveFWPPT2BkTqFkIetRFW7YqZ1681SJjaE2PqFgF3rMxqv9KdE=
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 ga23-20020a05622a591700b0042bf1cef27bsm953774qtb.8.2024.02.02.08.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 08:07:05 -0800 (PST)
Date: Fri, 2 Feb 2024 11:07:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 2/3] mx6sabresd: Convert to watchdog driver model
Message-ID: <20240202160702.GD1152441@bill-the-cat>
References: <20240202160405.4126192-1-festevam@gmail.com>
 <20240202160405.4126192-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w2chKfImybnZh/tR"
Content-Disposition: inline
In-Reply-To: <20240202160405.4126192-2-festevam@gmail.com>
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


--w2chKfImybnZh/tR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:04:04PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>=20
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - None.
>=20
>  arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi | 9 +++++++++
>  configs/mx6sabresd_defconfig             | 3 +++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi b/arch/arm/dts/imx6=
qdl-sabresd-u-boot.dtsi
> index 5c4101b76da2..9e9c4422f00e 100644
> --- a/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi
> +++ b/arch/arm/dts/imx6qdl-sabresd-u-boot.dtsi
> @@ -9,6 +9,11 @@
>  	aliases {
>  		mmc1 =3D &usdhc3;
>  	};
> +	wdt-reboot {
> +		compatible =3D "wdt-reboot";
> +		wdt =3D <&wdog2>;
> +		bootph-pre-ram;
> +	};
>  };
> =20
>  &usdhc3 {
> @@ -18,3 +23,7 @@
>  &pinctrl_usdhc3 {
>  	bootph-pre-ram;
>  };
> +
> +&wdog2 {
> +	bootph-pre-ram;
> +};

Can all of this be upstreamed as well?

--=20
Tom

--w2chKfImybnZh/tR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW9EyYACgkQFHw5/5Y0
tyyTOwv/Q/JhMNO2S13Vq+nkw/6LKCp7rG5+oY2zu9V7GETuNP/X5wfNYDZi39cb
0ZGX/eYEgD1qLwYLHKzn6Z59PXSHF32dqeIHy08bt7vrPCbyRtQQwtFsIzDprXBv
Liyt2M2o5UY04gU4J+H16cC2w/qzXfnE433clImsNSgY8p2I5XtOedjfTA4uSIEs
TPuBD9B054TnuSOqOBIaaiGahA79RyGiD0XC6x912jOoCZD0hPgoQriSoDQu/m2x
yuvCCvyGAoZoiG3sezXmYqUH3E/0rPEDbcEHO0sV1cEiUqCllOs3uMoVf2vKvr6h
OwYzoNTcA72uc6EWFz0LMaTcVAOkgqS8R6rc1boHTJnlYa6Uqdi7dlN+LelarKv9
A/CZY0XNSnCBvpEoml09VNIDWgmx3VHawAhz5WmHrvp2m+EcluksiQLekqwBYOxp
ZmIgc23Nymw4ukhZbKLoUwgG4y/blelzGdo09rVBsCqP5K9IKo6PWMVGaZ+HvD+C
ydmeiZF/
=J5El
-----END PGP SIGNATURE-----

--w2chKfImybnZh/tR--
