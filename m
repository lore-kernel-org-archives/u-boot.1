Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D1FCD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 16:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B05C83FEC;
	Fri, 12 Jun 2026 18:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HEeIOd1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC29D83FF5; Fri, 12 Jun 2026 18:35:11 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5F8839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 18:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69e1eba21a6so894541eaf.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781282108; x=1781886908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=18GZ755pj1NRO+6qxbzVcJ3a4wu6fsMcuOvrlRLFamU=;
 b=HEeIOd1cNL8vvT8o+BccgEYP5Am8Pbrc53mHfjcUpntwTTv9Jy88NkRW24PFrOF9j6
 BWDrCv9Wm1G2DReU/R83eR2DB7hM9stm6/JWARmcRSNoP7e5jP2Tvl5dI5OMtWznHdrI
 5IoGFgahJkBDoJd+yow1avyhqjYDkZZ2NBvm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282108; x=1781886908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18GZ755pj1NRO+6qxbzVcJ3a4wu6fsMcuOvrlRLFamU=;
 b=mjLl9GTjULUnKyCYC65Q/FLqhNrNP+BK24d4jaFz6ahQwWsnFjMPq3t6dg6czOjuQa
 RxTA9uhrIsE23xzqX53q9geFgqEgk3LixQICnh0QwYe21YZaBRG0q+Lx0gZW+wsyhIra
 oNjWHnGN66lQVe2rsRXS/PS1NODdXHWFTDx27b2Yhr/qPFV8yI5A26KjED+MozHTs08p
 wIQWJyWB1YpmPrTVoDCG3D4a7IgE0M3MvNGYSCtyKpVY//tZx4r6vPRNAxIMKWQ7u5GQ
 HRJpYdRperNvBmsc0SK2mE8+E3f/MdVAwrEStaH1FNnMGZYkaLtxEYqeoIpMSWq2WyGU
 w4vw==
X-Gm-Message-State: AOJu0YxpvY273ZxXU+Q2Ybc4n8Wn2bIJKmgIkXvhXJfc7cUhIX4Frxnr
 98+tVwPRiWJV8/UeAAaqowvhFH1At1FcPcVNgaBGtcey++rE7f5faBlPPT58KoaiBLo=
X-Gm-Gg: Acq92OFmA2LZ/GH+FI6WyZR3deCJy7xCQb8yY7KfbaiUe2JsQeHLGf+ZdY4x7QvsyZH
 CO/9LMQpMPpbfqE7gv0vMb0x9Rhw9s3XKeZc20GVRPvIWVWM2gxac+aD4WPwN66KCc7SS0bIwtn
 Dh2wL83XUWdW2jo06jdlzJFV/WQIjLREAxw3k98FMv6RZhREQQb8HqRyjfVk6/mzt4l2ONVjf75
 qQMO/EMGqKmxiW7W6n8ukparLgvTxlRcFb566Xr9cqLQNM8VVf4EJ7Gzwchd7yq+c+uZWCcH7eu
 zmu35CtXwT22YJoEgJ4wsD5SM55R0QAiFFofVJWSc/VnRc03hJRBcl6eqQl9z1d/JDGVCT5+RyE
 FFjBXYsf2gRQu1eNPMN8qW1G5WhV+sYy75rlW8MwPHVqtc1PjIFPOOs3949Tg4GRXMj4iE3MpuW
 9pPGvaGtASNBIQ7d4g4DnjB5UyY1Ly+vzdhT7a9++v3LnaJ8dEsr9xzLcvl98mtclwe3yPnEInV
 vWyPsYZjjuqkiGa0qU0tUtYZAWGtFWn7pqtzAtUczQxVebd
X-Received: by 2002:a05:6820:205:b0:696:8ccc:55a0 with SMTP id
 006d021491bc7-69edc75ec91mr2212513eaf.42.1781282107781; 
 Fri, 12 Jun 2026 09:35:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426ab0ebcfsm2242036fac.2.2026.06.12.09.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:35:07 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:35:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>
Subject: Re: [PATCH v4 2/4] ufs: Expose selected UFS functions
Message-ID: <20260612163505.GM382693@bill-the-cat>
References: <20260611-ufs_tool2-v4-0-a4de78bc2409@mobileye.com>
 <20260611-ufs_tool2-v4-2-a4de78bc2409@mobileye.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7OMj8EHGPR8siqwO"
Content-Disposition: inline
In-Reply-To: <20260611-ufs_tool2-v4-2-a4de78bc2409@mobileye.com>
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


--7OMj8EHGPR8siqwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:49:36AM +0300, Raz Ben Yehuda wrote:
>=20
>     Remove the static qualifier from selected functions to allow
>     future reuse. Add flags according to UFS 3.1.
>=20
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>  drivers/ufs/ufs-uclass.c |  18 +-
>  drivers/ufs/ufs.h        |  52 ----
>  include/ufs.h            | 603 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 610 insertions(+), 63 deletions(-)
>=20
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6a51f337e47..78f6064ddea 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hb=
a)
>   *
>   * Flush cache in aligned address..address+size range.
>   */
> -static void ufshcd_cache_flush(void *addr, unsigned long size)
> +void ufshcd_cache_flush(void *addr, unsigned long size)
>  {
>  	uintptr_t start_addr =3D (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>  	uintptr_t end_addr =3D ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);

We should be removing the comments here as well, when making these
functions public, so that we don't end up with conflicting descriptions
in the future.

[snip]
> diff --git a/include/ufs.h b/include/ufs.h
> index f6e27d90e43..b8af475661a 100644
> --- a/include/ufs.h
> +++ b/include/ufs.h
> @@ -1,6 +1,64 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> -#ifndef _UFS_H
> -#define _UFS_H
> +#ifndef _UFS_CMD_H
> +#define _UFS_CMD_H

Why did you do that?

--=20
Tom

--7OMj8EHGPR8siqwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiw1NgAKCRAr4qD1Cr/k
CqeqAP41Ir4WmyMF0AgXtH2qJG94lRxSEJB6JKc1r1l+1ztFkQEA3XnQlo7u4vjd
4ghGlLZZTfKALMVnHnlTomDfDxpHsgw=
=2MCq
-----END PGP SIGNATURE-----

--7OMj8EHGPR8siqwO--
