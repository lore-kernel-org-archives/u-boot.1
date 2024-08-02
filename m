Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69550C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 06:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC99888FA;
	Sat,  3 Aug 2024 08:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGQHF1Zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC8088BF2; Fri,  2 Aug 2024 21:34:46 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DED88BDA
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2689f74963bso600617fac.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722627283; x=1723232083; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vgi15xOo7MQIMXT8TuHBlx8Jnj98FdZTxkNCo+3fHYA=;
 b=SGQHF1ZkXGRNUWW5q5dAGdi7sPHjGfIyJZG0fbTw7Y57qM6UreOqYj0PMrmJr8nN72
 tPeW1l6nVqvIDb0toLEaKJFv42KKLGJg/D4FRJ3Anuzv5+lIxVhu5w/IJa7rN92hoJq9
 ag6H00q+XqGD00fP9XIolBTpNU9zjQDzArpjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722627283; x=1723232083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgi15xOo7MQIMXT8TuHBlx8Jnj98FdZTxkNCo+3fHYA=;
 b=IPd3Jb2734gV9RmEyuEtQiSM+DbtVEHuiT/TwrAR4zZuT4GEWRmvXSl4dOEbL8Gz5e
 gyDXnZbBn6hF6f14MJ5Z/RXQEp4Y2a/Gq8dXX+mUKk5xf+N0QbeIk4yBoONL8pEkshHj
 DeL0dSFEvtv2dJs7OKGhF4nhMaiC4kgTnPxIlZ/NPQJo19vMnMtPbr8spKmU4ufEUWXp
 ejOImQqQCM1iVO7syAgWR6QKZFATbGKDsjlfmEsGLMbZ0iVLcJqtGmBhTLa4hUVWvCB5
 1aQ5vZu8kADRh594eUA8Ew92sm6k0zLgl9+7G72IgjV+3+ChyXy+GZr9hR/WM1FABuFQ
 XGlw==
X-Gm-Message-State: AOJu0Yyfy8obOA19PwmSZXLPoYL7eIsTBcmcHNqcx4HjNcG8xgkhNhxJ
 5f9yTH2H5Yp3cbwvs4+qlByAAUfq35FEJ+fAypGECYkVfmOB8DrxtNmd3P2oTG8=
X-Google-Smtp-Source: AGHT+IGEdYiksSu7UYHuXw1PnIjtJUCiohzKMfTOBu9786aAL2SA7iMlsnNjf9mknRAAXW+kBXr65g==
X-Received: by 2002:a05:6870:a989:b0:261:6bc:9b8e with SMTP id
 586e51a60fabf-26891d40b99mr4961404fac.26.1722627283293; 
 Fri, 02 Aug 2024 12:34:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67fb3bsm496356fac.49.2024.08.02.12.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:34:42 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:33:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Gilles Talis <gilles.talis@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Shiji Yang <yangshiji66@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Artur Rojek <artur@conclusive.pl>,
 Sean Anderson <sean.anderson@seco.com>, Neal Gompa <neal@gompa.dev>,
 Janne Grunau <j@jannau.net>, Yang Xiwen <forbidden405@outlook.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v7 08/20] net-lwip: add DHCP support and dhcp commmand
Message-ID: <20240802193328.GP3794063@bill-the-cat>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <46b1fff7bc5088c1b7dfc75a4faca8b229749c68.1722615735.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/SuePceSzvuf1MoV"
Content-Disposition: inline
In-Reply-To: <46b1fff7bc5088c1b7dfc75a4faca8b229749c68.1722615735.git.jerome.forissier@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 03 Aug 2024 08:01:01 +0200
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


--/SuePceSzvuf1MoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 06:26:35PM +0200, Jerome Forissier wrote:

> Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
> well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
> to this code having an implicit dependency on do_tftpb().
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
[snip]
> diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
> index 9a70c6095b3..c2492b69a13 100644
> --- a/lib/tiny-printf.c
> +++ b/lib/tiny-printf.c
> @@ -269,7 +269,7 @@ static int _vprintf(struct printf_info *info, const c=
har *fmt, va_list va)
>  				}
>  				break;
>  			case 'p':
> -				if (CONFIG_IS_ENABLED(NET) || _DEBUG) {
> +				if (!CONFIG_IS_ENABLED(NO_NET) || _DEBUG) {
>  					pointer(info, fmt, va_arg(va, void *));
>  					/*
>  					 * Skip this because it pulls in _ctype which is

This is subtly wrong, and you can see for example that _vsprintf grows
in TPL in pinephone-pro-rk3399.

--=20
Tom

--/SuePceSzvuf1MoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmatNIUACgkQFHw5/5Y0
tyza/Qv/UENdUaLPo0EPI1Jz6ahodTWkY2CXyJAKrtGRg++RvYHKN7ldDBd9S5tz
uByh2GJJNuJUwWirAwsJ+ajbdGeY9Tqw5wbRIG9jzuBJoekgUm2vG/pn5PbqcYBD
9BCeXTObs0UO9dTAIwSiuFqkhDDII4t38V+hOOzqc1EJUjEaT+Jf9a2UJuenMT0N
yX62J5qyvJeXZpubBaH6AS0IgJdbZi15XvykECDtVrYkwyIlfScfGyHDkLaHyXe0
YVM2Y+Ta4dJ0jDRdQ8mAjAkjZLqVmPt8P371e3UpW5VrwRkpQuk9z9OTVcvcltsB
GsMU6tUZFpPOhKkqhYSWBo/V1P9ojVKdwSl6Mj0rubqkrWslLxcNz4hHy0cjJzJz
4YjHBuq69NK85oSzpYDTYzhLvgRRf4AsHZGBNCAwX9qqvvbxa6PqZPU5HhEBea9P
ap818g4Ks88FwmxjVIwcSnVH9qqYbTPhmgMR0XotUcAk6ELI1rTcn+usuYA0VYKg
ed/XBiM9
=gRmA
-----END PGP SIGNATURE-----

--/SuePceSzvuf1MoV--
