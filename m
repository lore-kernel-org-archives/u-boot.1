Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02483C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F724807C0;
	Wed,  5 Feb 2025 14:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IczA3/zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D617B807D9; Wed,  5 Feb 2025 14:52:40 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8236180711
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21ddab8800bso96610305ad.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738763557; x=1739368357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QWHENkX/IMaexJjahYUy0i3eZMgOYJIysiZP7bL5aoU=;
 b=IczA3/zp3nUHPnx7VLiPK303XzegbzqrNtmUhtSzrx/SsoqEOex1Qe8Z3AqF1eWFia
 vGHuUm8ed1vpQMKMfR0fLb+X6IzGKTziqa1sp8DtkbZC+PzoaD1rF0wb8HKU3kOSJlWH
 CNzFglgv4gnjRLeEhVPYNZixO4uMDMUSOKuV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738763557; x=1739368357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWHENkX/IMaexJjahYUy0i3eZMgOYJIysiZP7bL5aoU=;
 b=byOlvq6caDQlEk7xLtIRdTQTYNd9ZKklc/UP2ccWuTG+RFfFx8BjCQJIZJnaMa6XdN
 N1Wu4NEWhah4viwwvVWgoNCMO+YemRsIN6FTJdJo0tPmnopFPUlcVEcwldqHjwWKozO7
 2KJCpgEvJOeOeGrHXwBlagNuCmfCtQ1ZfKWDOBGsRF3lplHzcRp5v+JLAVZqTqPVy7OQ
 e07Jx6RsAqNOPwLBbOy7mD0Pk5j3+XBj544t+u5xvRZGDMSNGGBcoDQ0hSSeD7lIOTj4
 7NhbrdPbdcXyxlfGMAI8aLHHNe+58mnWsTqMBewZgT/GreONUy24onhB7svaTwMuJteU
 6IQg==
X-Gm-Message-State: AOJu0YxLHz2z58KA0uJWnIK6P9dF5cFpy2aKKdk/xZd0fDL3/k5XtDob
 8POnCVgjhkf2jsvfapPVC2DiEFME7YgN38ng6qUH49pEuR0q69jERX0QlH00ccc=
X-Gm-Gg: ASbGncvx58v8wJ2dG5Wt8vt35zRggwmioKAqAmUZJpp0yKy4PTN41jc6qCWg69vAvc/
 3vQ0QSVJUsjIw0JcaJpkp1JTSUUIjOQ6rUz77YkvyU5JQHDtORUQWP+KlU0htcoOlSs3T228+0u
 tVZgBnYCL8zMY6vfOPtAw/GtofyPnFGApd3ysOeb9l8o4MDwPsxq/rSHTdDoLTGQ3A/of3g6MJc
 uiJq1UZqKf+dLcH6tUntXdkCf885oqLKvgCwzNNwnBw0wyqCP9pT5XOv3JzBIrGWiVh+pb5uz5s
 yWVJCm4edGmJWbw=
X-Google-Smtp-Source: AGHT+IGvjfb/jrUPcBTLhX67WWVJkTZHzR3N9v7tWgH2ouIVwpmrg746adFr2UZLZNT32He1mWcWMA==
X-Received: by 2002:a05:6a21:4a4a:b0:1ea:e93d:7574 with SMTP id
 adf61e73a8af0-1ede88364e7mr5277597637.18.1738763556906; 
 Wed, 05 Feb 2025 05:52:36 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69cf147sm12749155b3a.143.2025.02.05.05.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 05:52:36 -0800 (PST)
Date: Wed, 5 Feb 2025 07:52:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
Message-ID: <20250205135232.GO1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hIs5gmKwe27Ixnzp"
Content-Disposition: inline
In-Reply-To: <20250205015606.2686149-30-sjg@chromium.org>
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


--hIs5gmKwe27Ixnzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 06:55:19PM -0700, Simon Glass wrote:

> Where the bloblist is located in internal memory and TF-A's BL31 blob
> removes access to this memory, the best option seems to be to relocate
> the bloblist just before running TF-A.
>=20
> Add an option to select this behaviour and provide a relocation address.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/Kconfig    | 20 ++++++++++++++++++++
>  common/bloblist.c | 15 ++++++++++++++-
>  common/spl/spl.c  |  9 +++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/Kconfig b/common/Kconfig
> index 0e8c44f3f74..962e7fd76eb 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
> =20
>  endchoice
> =20
> +config SPL_BLOBLIST_RELOC
> +	bool "Relocate the bloblist before existing SPL"
> +	depends on BLOBLIST_FIXED
> +	help
> +	  Some platforms locate the bloblist in SRAM in SPL. In some cases,
> +	  the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
> +
> +	  Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
> +	  before leaving SPL.

Isn't this because TF-A is (re?-)initializing SDRAM? I'll let one of the
Rockchip people chime in here, thanks.

--=20
Tom

--hIs5gmKwe27Ixnzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejbSAACgkQFHw5/5Y0
tyzJIwv+LinQQI2yn/bgeCzHGKwPyNoCW02V/nI9mB2uO5R6P0+jEyHz9PZguPp3
1yw1CSdklmmkirrcInCpWsU+3ELEx7+AKT5hJl6zVWenHroXd07NdlpPIM4QNAAh
Q5aNc5yqibWUZ3LMuJt/UO/DKNDFsZwKxHh0RNoqiwT5Qp0gtcLNq4e0ikSfEhQ2
SWdTCxPPyFkUx7m4l4zbqAJObQESjMBFSf3gE7W1mVjSBdbWiNjTopoDZumn6YJF
rK95BnCSwpZWCO2FegwVynQavADBtKnOaFVnOZwjnKSCz9TR5BSdYhzKlvfs6Oba
oBrVr25xqVKMbhcjlFgcu/x9+2QP+pCWGihoGeqb/FMklOlIPdR4T5j3vVfwECjV
3+4Oi81ZZz+GLH+3KLw54Unj8+GFiBt6SlXJghe4rJEkyJN2rSHrBCypsoFg0c77
ZEs7eyCsYGFQ9MBnNOBZIRlVeKIiXFRlntdl8JRuJ2gHaJ9yIQzYAhJZyLPV3S2c
p0mJFNPO
=0SPr
-----END PGP SIGNATURE-----

--hIs5gmKwe27Ixnzp--
