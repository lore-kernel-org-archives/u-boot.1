Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38214CCFA1E
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEF783A43;
	Mon, 10 Nov 2025 18:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U8O1FEUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD13A83A71; Mon, 10 Nov 2025 18:48:29 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919D583959
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44fe4c3c19cso1048449b6e.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762796906; x=1763401706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rlYRwN1KNm1iyiyqLb365+gHTnb1yblbsy4c4VLDZmM=;
 b=U8O1FEUaSOI6yySCspSDuEMHXvW0y3dLVKvHzQgMSTpOPmg7Ab+JdVJL456nUF6ryS
 DbydOapeUa0bUgdyzeVU0rV8Vim71s+TdsZN9cIVwvf9cAewk7fMYzlnlAPLNRPWZi+e
 FUZdgkYmadMT60sqR5+lmk7mS22ltXGFUjW7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762796906; x=1763401706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlYRwN1KNm1iyiyqLb365+gHTnb1yblbsy4c4VLDZmM=;
 b=osOzbyTg9cxTaugAfqI4hDvo/BTkmsjaKnt4YR/5vrTlHfnLWnmpr61WRXL/LrO+JT
 7AoeetyI2nEcyr9a9XnMmr+5n7vMt5SQf1ZQHG3/nZdJv2g3fY0Pnbuw0cHiZGQEPGLz
 FWNsKnPPywrL5AHwng7N1TBqOP+T5hnR2E/lT1tufIbwEbZYgsy2CcoQL5HxRiuO4Ohy
 R21zEuTfp2x+LwnPiO920mCTJqW+acdwdSnaFZxgFa+wVG3zNU11fmSGS7LlaayoTEBp
 mKGDN+DvdEYyUYdkj8COHsADvq/0hAoO7eB4+Up6nnYs7Nv5VO9WtSmEI5JVBAHvxPom
 BLOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpaCeQ1jHVBlJy2HheFZHOA6umz3iHcACrXUtXDEw+7l1G6j735UnoXldfqy1RtrW21k0pg98=@lists.denx.de
X-Gm-Message-State: AOJu0YwK5OqYZgCo7uzJaw0oR0X2e/VVsr9ec7Pi/2bqBA23Gt/DZeKk
 NovF25AidBv5TOy5ovOIGZ5quSkzHcfCzywt3ieH02mhdarh+9sWBaxPKw6p32rwKzY=
X-Gm-Gg: ASbGncsuhCU3ZqzcMyGNb5nw9kGkAiZB9Ou2ZRbD+/4O/7xYEwqEE1ucdY1h97naCf3
 0QDOpCHuPA2ZQDvnhn7AOQA/QcIjuiBUS5Me1ZnmnEGrAHWbsHH+DWlTE2ty0mFp3R0eUN9RQwz
 r0JIoDK++0aZbCqhOyCVDuB9dzGFPC3ns8B93/bOkUY7yAxR2QLCBuqHQ7sBWA9VIZ+27+HLl+e
 3eUPMNdbWJdIXi/kOdMwgnapQ1Tciy7xtZEwL7rhTd/xrllV8Ldddfq6UoRGb9rPwC8mkgRX55B
 C4d1V4iTeD7hpKnACddUj3/ScfLQd7ZRrXmSkMy8z36ZBxreK53iegZA/TtSx2EszVeeSkEo/iO
 ohUQNfHLYtjvhCQLWXUz0DCJt1cUXjmGQzfuEP1Xg8AKcaygCRILA6i+BectIS8ynFGhd9rVRlz
 0qPzcMJUbvGtgvUCTpw0LA4603f+d7a7gpEenZ5FD1X3rYOfBt/qQvJXXVjbY8
X-Google-Smtp-Source: AGHT+IFql5J1LtVekKHXttFoh2B2/yjhfaUqd0A/uGc5DF+iYvHjpEoYcUfh3hqBk6yfg0UO7yAz/w==
X-Received: by 2002:a05:6808:bc2:b0:450:5f:7951 with SMTP id
 5614622812f47-4502a1aed38mr4434327b6e.19.1762796906283; 
 Mon, 10 Nov 2025 09:48:26 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ca847a9asm5352367eaf.12.2025.11.10.09.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 09:48:25 -0800 (PST)
Date: Mon, 10 Nov 2025 11:48:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: a-nandan@ti.com, c-vankar@ti.com, u-kumar1@ti.com,
 marek.vasut+renesas@mailbox.org, n-francis@ti.com, peng.fan@nxp.com,
 semen.protsenko@linaro.org, s-vadapalli@ti.com, jm@ti.com,
 m-chawdhry@ti.com, ahalaney@redhat.com, u-boot@lists.denx.de,
 danishanwar@ti.com
Subject: Re: [PATCH 2/5] phy: cadence: Add config to enable Cadence Torrent
 PHY at SPL stage
Message-ID: <20251110174823.GN6688@bill-the-cat>
References: <20251110094144.886956-1-h-salunke@ti.com>
 <20251110094144.886956-3-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W5D4+CxjKnhMdpn5"
Content-Disposition: inline
In-Reply-To: <20251110094144.886956-3-h-salunke@ti.com>
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


--W5D4+CxjKnhMdpn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 03:11:41PM +0530, Hrushikesh Salunke wrote:

> Add SPL_PHY_CADENCE_TORRENT configuration option to enable the Cadence
> Torrent PHY driver in SPL stage. This is required for PCIe boot support
> where SERDES configuration must be done early in the boot sequence
> before loading bootloader image over PCIe.
>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>  drivers/phy/cadence/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index 549ddbf5046..f5b1f7a30db 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -9,3 +9,10 @@ config PHY_CADENCE_TORRENT
>  	depends on DM_RESET
>  	help
>  	  Enable this to support the Cadence Torrent PHY driver
> +
> +config SPL_PHY_CADENCE_TORRENT
> +	tristate "Cadence Torrent PHY Driver"

The tristate keyword isn't valid in U-Boot, we don't have modules.

--=20
Tom

--W5D4+CxjKnhMdpn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRIlZwAKCRAr4qD1Cr/k
ChVbAQCKJ32jmAUPdz8DXI3ZOPO1iUa9SfIDc7Ndaff5Pl44rQEA7xUL3Wqrb/GL
WehUXG8e6rE8jz/nZlqGjXbKYJp1TAQ=
=y/4t
-----END PGP SIGNATURE-----

--W5D4+CxjKnhMdpn5--
