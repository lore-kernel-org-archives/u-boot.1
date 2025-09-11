Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F4DCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 15:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F1C83390;
	Thu, 11 Sep 2025 17:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RwmWAptR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93418833C0; Thu, 11 Sep 2025 17:15:55 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732C28334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 17:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-74c1251df00so469884a34.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757603752; x=1758208552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mui1PBsxAT6kHfsVfgmjeWOzA329eSbgt//t/iprP24=;
 b=RwmWAptRRbrXqYk4C9yqkdVXKCHjL1zynGNFpE9SgSHp3zAozbKsYhIMix4RQMf5oK
 mpI6sduDQuTnZywjh2Cfzg+DGPKXrl6FP2GCyJLVq5dbTi+K/PE68rRieWDeJu4xxhEi
 RC0NoXx7jDnO4L4XlwK8osxTJH84mGsjzNxcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757603752; x=1758208552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mui1PBsxAT6kHfsVfgmjeWOzA329eSbgt//t/iprP24=;
 b=Yc26IXmZrobDGZp5lWgoKMtJgmRaniIJMeQZRT8VaTomJ+3JIO3RUHk13bJzu1fObi
 gfwPZUiPSfp8Y2uiYI8TW6gGrLwV9tXymjvZYNFD4ta/3Z6JJg+efcBovTg38Dhr8Icy
 v+bsbDt82uhgP3FVxDEjIEx1cRi7zbJPJR9EqhtpxZgxLNec0tnrvewzr6iZi0Zcy1jU
 nSp4Hcc0AOqfertQu5lKjB6Ru+AzDCS9unPzsqqpsqcVUuaw/nLCL+k1kMApUH1sayBO
 JwGK0uv6Jzr05pmS7YAwFJppS9yd18w9dLpaZQykPlJvSn46YvmiUQyKl6tb4vqJgPNH
 AaJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE5fWgHxkqOXFZkD7nGswi2z1RuLNAYwSdWe5E3gfCp0vQBZJ9c6XHtj8DCOikY4iFeezXd0s=@lists.denx.de
X-Gm-Message-State: AOJu0YxBLmO4XdIo5jxvPhpmZ4s+sSHHuSZ9F1TRb8bxEfWVATNJJ+ZB
 Fvdn/Z0ht+sFbcDQlaj0prAhAOQTHPfFN1OvAepmQKPFACQeCE6+Z6BaduSeku1bj94=
X-Gm-Gg: ASbGncu23P3PiEny+JKhGGvEBBnC9Tt1aD4UyvXyC0gT9+t6V7CSfnGyEPANZwOxpEI
 ZDXsUoEwYngsG6PH7C8jg8pfY5gzV95+uhVfL0k/K9C5gtgUyUG+gyKPIH5iB4xIKuhdPpFYtJ9
 zsuijT4fPXI1Lmpl/cjg5YWkJzvs4drP5MzN8FVxlrTi2/cWbxMEaOEWgIwF3GlfSNMSziFSZmZ
 PF0FwuDf0orMU/V2VQyN2woS+u54G+TxKy78m1rzdZ41BQ2grwl4ID4mxf5Se8j62uJB09vvD31
 jogYAshzIlKnGv80ZLvfw2M5uzVvFV//sHLoKmTaQsmVvyqWh4vtZWg/ygoR6een0LHAipLUE6I
 zFTnunTBn4ulmJFgaU5nqoVVkqHgCNgsxzuo8/8/BrQzWCSub/tDzNzx5dCAatMc4XHY=
X-Google-Smtp-Source: AGHT+IEq5bVf08fyooekHkbjXMET5pPN9fhlExNyRGhDCuRvxrw8kKMss8rcPobHmSbm38XpQ0QUfw==
X-Received: by 2002:a05:6830:730f:b0:743:801d:5215 with SMTP id
 46e09a7af769-74c74fbde35mr10628601a34.17.1757603752141; 
 Thu, 11 Sep 2025 08:15:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524bd83643sm392252a34.34.2025.09.11.08.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 08:15:50 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:15:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] imx93_frdm: Add support for flashing board with UUU
Message-ID: <20250911151548.GN124814@bill-the-cat>
References: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mc9+glU+Mg/a0wiX"
Content-Disposition: inline
In-Reply-To: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
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


--Mc9+glU+Mg/a0wiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 03:34:28PM +0200, Mathieu Dubois-Briand wrote:
> Allow to flash a board using NXP UUU utility:
> - Enable fastboot support on USB.
> - Add fastboot partition aliases with names used by UUU. Also add extra
>   environment variables used by UUU.
> - Set 'dofastboot' environment variable based on boot device
>   configuration, allowing to automatically enter fastboot when booting
>   from USB.
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  board/freescale/imx93_frdm/imx93_frdm.c   |  6 ++++++
>  board/freescale/imx93_frdm/imx93_frdm.env |  8 ++++++++
>  configs/imx93_frdm_defconfig              | 13 +++++++++++++
>  3 files changed, 27 insertions(+)

This needs to update doc/board/nxp/imx93_frdm.rst as well, thanks.

--=20
Tom

--Mc9+glU+Mg/a0wiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMLnoAAKCRAr4qD1Cr/k
CvGzAQCvgUJkUi2qlx2mhi3LyvVOrbajCrMgs1yQpoMmmnrg6wD9G2/fWRSPhk7e
qtSbY6rzHpCYqs447OMMdExXY3lczww=
=ucQu
-----END PGP SIGNATURE-----

--Mc9+glU+Mg/a0wiX--
