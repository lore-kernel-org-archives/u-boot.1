Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6CAFA3750
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 21:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28E384201;
	Fri,  2 Jan 2026 22:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GmfkUe5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B2284203; Fri,  2 Jan 2026 22:37:47 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBC283B49
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 22:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cdae63171aso7068664a34.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767389864; x=1767994664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bv7x/7evdeEHEN6OqKJnpo8n1dk9Vybe5bOKWgLcyy0=;
 b=GmfkUe5MU0y41F6R6vM02BIWndTA1DhXktD7DRCZlCZdmc/MtcCGCMCZVyT1Y6tigO
 tadQne8PpM7JpRCH6I4fOTCcsx6uNQKlKLCQG+s2Y8pU2RLbQpqn4E+Cz1hH2DN5iF/B
 E9zpmw3bScTcaAdvAGq4O0sLAUJ4qy1Q//6kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767389864; x=1767994664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bv7x/7evdeEHEN6OqKJnpo8n1dk9Vybe5bOKWgLcyy0=;
 b=iLD1AyiJwTfxROmwkqNhiN9IYGZob3JmWx3Yd1MRXAo/zk7TYqtvcbPZ6XCm/g2uDF
 fI/OlBdsqrg80VGSf3gzIFVSvT533khItNAka47FbC3l5KSAfl7AzJimOgG+JbCnhWYt
 PV+Zz4osGy573v8QmGaCXtIHmZHTdpAhfXR1M8J3dgfi/CbVAJ/eIejwa3T7u3g+xD0U
 AvdYGDj3CrlUAkW5WWDA1Shx3gQz/YAgu31KMJZObSTMDOWKG2cQf9ZgqUms4HrVeHgJ
 YAEYm6nDwu6yqLZYY0HwgXb8RKeZpL9xKrl+Dve9PnZr14x1w6M61h294DpNuAGR9LjQ
 8PdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1rflnHLffkVf/MhyGhpUymfqhh9SUuZ3ZskDtoIFsDFr50ITLenYh+KhxIbbYg5SlL04UboA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz23u8ybXtASJ9o8qbn7Fmla77vNUlyGw50HVzURk8ND4bqw3rT
 CP8uQdBts/19DyULhEIko0Jl4u0sH5Vo44jHCY66tx6cR8UrOyV+wTxN4ZTnqV7PJfo=
X-Gm-Gg: AY/fxX6g+CbGFUi1oEkBFLSoZnzSpzbeOtG4Zz44xkbJhYIGwGV/rmeBs+zLVh+oi6S
 r2CcLcOwI4GTJLhYysCXlIV8GioANtyUKbIzOzx/n4XIHz2x/02UWa0jqDSsHzuuGrqjlB0f5ec
 9Hk6rYReqi6CSKR/aqYBGHShjZOt2W8jakTWO1OzglWOneWKy70TXw5rdsZ5pMjXLCZMOtRhp9z
 Ik03GOVCnToWyzUzjmStnhrIguVT8XXEIai+qp+hlLcOVpyszvac9erZR/Gw1+R7VsXwFwIOc5F
 v+eSY2afxwU/SEi8AeweeUwYN44QH6LV6ZioaR9/AMY5rhpifhiEw5XaaWXiHbgZFNJJH9FvKPt
 6DmTu+DXoy8EdFdgonbsBKTJy9YQmOibxtU6+X3Ij9aNHx+OzOTiBAyzzFQTcH8pidyW878LRzt
 ErWImalz1cGt6LkGMJ4o2hyKiQQ3Yd3W05cA/10Q290PDtfIM3pwUfZ/JHtgrfWfcRb1ASNAulg
 Y4dTLBrz1e0/6gLCr/Ts1gRHIbsG8BABeMLwW4=
X-Google-Smtp-Source: AGHT+IH0OCTJxzVLw0ajaRV7PZly6arq7euYFdV7mJvI8p2Sty/AiQtuHrebtvkHIpAGy8eFsS2cJA==
X-Received: by 2002:a05:6830:270b:b0:7cb:125d:2a41 with SMTP id
 46e09a7af769-7cc66b1a75amr22605600a34.34.1767389863738; 
 Fri, 02 Jan 2026 13:37:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673b9fcsm29351534a34.7.2026.01.02.13.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:37:43 -0800 (PST)
Date: Fri, 2 Jan 2026 15:37:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, dlechner@baylibre.com
Subject: Re: [PATCH] pinctrl: mediatek: fix compilation issue
Message-ID: <20260102213740.GA285761@bill-the-cat>
References: <20251211-pinctrl-mediatek-fix-compilation-issue-v1-1-c7a52a48e5d1@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GhFmtJcr9UgaoxUF"
Content-Disposition: inline
In-Reply-To: <20251211-pinctrl-mediatek-fix-compilation-issue-v1-1-c7a52a48e5d1@baylibre.com>
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


--GhFmtJcr9UgaoxUF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 10:16:42AM +0100, Julien Stephan wrote:

> When compiling the pinctrl driver for mt7981/mt7986/mt7987/mt7988
> we have the following errors:
>=20
>   error: =E2=80=98const struct mtk_io_type_desc=E2=80=99 has no member na=
med =E2=80=98bias_set=E2=80=99
>   error: =E2=80=98const struct mtk_io_type_desc=E2=80=99 has no member na=
med =E2=80=98drive_set=E2=80=99
>   error: =E2=80=98const struct mtk_io_type_desc=E2=80=99 has no member na=
med =E2=80=98input_enable=E2=80=99
>=20
> Fix this by selecting PINCONF in the appropriate config.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/=
Kconfig
> index 8b9180bd2aaeb56325ba42d08afa42d9317f23a1..026ddbddb2cf1f489e4e22a6e=
f2b407fb96daf11 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -18,18 +18,22 @@ config PINCTRL_MT7629
> =20
>  config PINCTRL_MT7981
>  	bool "MT7981 SoC pinctrl driver"
> +	select PINCONF
>  	select PINCTRL_MTK
> =20
>  config PINCTRL_MT7986
>  	bool "MT7986 SoC pinctrl driver"
> +	select PINCONF
>  	select PINCTRL_MTK
> =20
>  config PINCTRL_MT7987
>  	bool "MT7987 SoC pinctrl driver"
> +	select PINCONF
>  	select PINCTRL_MTK
> =20
>  config PINCTRL_MT7988
>  	bool "MT7988 SoC pinctrl driver"
> +	select PINCONF
>  	select PINCTRL_MTK
> =20
>  config PINCTRL_MT8512

OK, so looking at drivers/pinctrl/mediatek/Kconfig we need to fix that,
as the logic is all wrong. We can't have PINCTRL_MTK depend on
PINCTRL_GENERIC and then all these drivers select it. All these drivers
should depends on PINCTRL_GENERIC, which is how other platforms handle
it. It's debatable if they should also "depends on PINCONF" or "select
PINCONF" but the common case today is "select PINCONF", so do that for
all of the mediatek drivers here which also need it. Thanks!

--=20
Tom

--GhFmtJcr9UgaoxUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVg6oQAKCRAr4qD1Cr/k
Cn2eAP9KOKUnCXOOFRqUxHCW2g2OvrZTGrWY5O6VjkRGMW0/8gEAjCZoA+JiUK6/
L/xeTeFNUJ5qd2RHzHayR7OLbxzfIQY=
=0gBm
-----END PGP SIGNATURE-----

--GhFmtJcr9UgaoxUF--
