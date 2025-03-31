Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA69C36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 882CC81E6C;
	Mon, 31 Mar 2025 19:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EO0LR/xD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7362B81EC0; Mon, 31 Mar 2025 19:45:34 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA2E81DE3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2c6f27599abso1387407fac.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743443131; x=1744047931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qKrlCG+orUh6jCgjzSxLf163WJ4hQ3yAo7DVxgW59Ow=;
 b=EO0LR/xDdpWPmHrjhY7LuIXhKSr2srThaAm4Qqe6VasKEDdZOuRAYcHLW6GUqxm+9b
 AZ2BTn5wTfowD4VqNlw+0h44GHfMY4q+NVcm20yegwAtAGsRlcbgnETSJbqvEsCCXHTg
 Pf8sv97pitEM1e/CSz1II7mzfgc1q2gRLOGl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743443131; x=1744047931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKrlCG+orUh6jCgjzSxLf163WJ4hQ3yAo7DVxgW59Ow=;
 b=JxSYm7ea5SUfauHm/oJ0ekVaOZOwQRkTLX6YRaFEOVVX4/gj4C7ZUdc0j6z8t7tIbk
 12oA74Dp5d3EaUykFd5a6x1TJh/DUIQKydWmkD77dbsObfmCilURml02UdOkuLhz6hr9
 i14axmuEhAcTZ9f1tvZkh9xedSKG5MwPZ3ruS6tJCHSg+LU4tsNf/a7M/mxHIcVJA51f
 yPRrk4N2nItgbZuXXJzTqb/xmoLR2w6Bm8HYHWlDrVfSVko8he86pB6+YaVm11D4ua+u
 S9aqhVMsBQ6qM+s7uziJ5zSZFp82bFS1sUKNxV4DQcf1MYEJxXDMB3CdOyY8rqD3trzm
 SrVw==
X-Gm-Message-State: AOJu0YxLD488mb9tPVgSNCkWYWRR5ZhAT5C9XRgNI1DINmRQS2MphlYL
 l91LRKrLFXoiZO0UIeYgWPnR5aw5t/xbpeI3XSbGNWLHUGCIvS8ocflve0Mctsk=
X-Gm-Gg: ASbGncsMw+EdlGfgIXhbfV0r4iyqocLTYHvgianDN6cryO4OhNlo5tZZWEIWfhQzh2W
 lC8QWCNEkamn6CYi1yCEX9f3cJlu51pvD+M5mb3YaSGNBV8r6E7JUW+7HOXUmYfA1STqrc8iDkl
 ioNOeJr5DwYzU2vGeQjSdOEHCKwK/hqPFApiNtfx3LpX5VavGaUzH5fe/8zjwMvV5gECui7ntzt
 obLnIqSJzV2wNuyo8YUgJB3wtBDFvAkeok9IZ/+dsWazRwKrMjIi5oNTDW/93yWsUsT8CadOM9e
 DZL5ZWFYKKYUXabdcZbvq9SIHuM2SZ9nit/RF0cxfb3nbhYcDjHEdsNZyM0ZY73LHcRfwtBz/Jk
 deT7DYw==
X-Google-Smtp-Source: AGHT+IEbSjIO++gCdD495GW6UOapHi+3JPV4yHROS4mjeySF2wNM2vBMWuu5W4IVyqzfDScGPrXCyg==
X-Received: by 2002:a05:6870:498c:b0:2c1:b39c:c43a with SMTP id
 586e51a60fabf-2cbcf5a6770mr6249739fac.22.1743443130818; 
 Mon, 31 Mar 2025 10:45:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a8ffb5bsm1935455fac.43.2025.03.31.10.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:45:30 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:45:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH] docker: add ADI build-related tools to docker image
Message-ID: <20250331174528.GK93000@bill-the-cat>
References: <20250321053854.12959-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t/1FkvF9DQ7ng7e3"
Content-Disposition: inline
In-Reply-To: <20250321053854.12959-1-malysagreg@gmail.com>
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


--t/1FkvF9DQ7ng7e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 01:37:42AM -0400, Greg Malysa wrote:

> ADI processors require packaging with the ldr utility for bootrom
> compatibility. Normally this is available as part of our yocto-derived
> toolchain but it is not a part of any other premade toolchain, so it is
> otherwise unavailable in the docker image for CI. This patch adds a
> source build from the ADI maintained github repository. The same ldr
> tool is used for arm and arm64 for all of our boards with names adjusted
> to match the expected $(CROSS_COMPILE) for these boards.
>=20
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
>=20
> ---
> Hi Tom, I'm not sure exactly how changes to the docker image for uboot
> testing work so I wanted to get feedback on my approach here before
> including it in a larger series that will include the ADI boards. I
> think that maybe 10 years ago the ldr tool was available as part of some
> toolchain tarballs at least, but it is gone from everywhere except the
> ADI forks now. So in order to build the sc5xx boards in CI, we need to
> add the ldr tool. I've built an image based on the resulting docker file
> and -next and then hooked it up to my gitlab runner to test things out
> and this is compatible with our upcoming patches as well for a full
> clean CI run. Please let me know if I've made some mistakes or if this
> isn't the right way to submit changes for the docker image.

Since these are new platforms, we should really be using binman for
manipulating the output images, and then also fetching / building any of
the custom vendor tooling that's also required. I'm not sure off-hand of
a good example however.

--=20
Tom

--t/1FkvF9DQ7ng7e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfq1LgACgkQFHw5/5Y0
tyyanwv/TAbRlsfPdr3gdPY+czZj0XBDZ9e1yzmdsvT85xCkZKSIflw0H8Gf/MyC
YF/z3iinJkvtHfD9JlYbkUYEKwQI1XZyc08Jnb5xOyeiIuDM/z3RPpWjIRmAVtF0
NnUEYUkbAcF+9X3cV0HsotQVfTMaAh5ib9K0QezahSdz/j7vePOh5M2++xrtC5B4
vHCUnK4v0gjGLFoVGkAR6CBArpuylwP2jUJn0eMJ4l0nF1gdptpUzmvjdQEvg9Zz
5sdS+KrVCJVp8+9c7ssPvmyNDyDILQzvXu//h9MFHN93W+05v9i81+ZkK4eQYYlS
Hu4l0EhnZvlRHrRQErre57bBNTkoMSBJT09Oh0/SnCWS/+vC+jloixYnRwO4LU6D
vUaKyD8EtesWdPYlqWPWyWpQJIZd/MyBL0e/zZ8S9+Nxz8OnrOT0Tn7UWCXVeRVX
UR162yse8zetUP7sqWFLR6g76Fn6H5UNmtwPCMgETV0CogMO8AJRAfVqioEfgCow
sIpzql5C
=ykPh
-----END PGP SIGNATURE-----

--t/1FkvF9DQ7ng7e3--
