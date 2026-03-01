Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E5FFD006E
	for <u-boot@archiver.kernel.org>; Sun,  1 Mar 2026 17:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A55B83E76;
	Sun,  1 Mar 2026 18:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8dc3cQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3840083EC6; Sun,  1 Mar 2026 18:51:06 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D553E83E63
 for <u-boot@lists.denx.de>; Sun,  1 Mar 2026 18:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c1d2123dso4616485a34.2
 for <u-boot@lists.denx.de>; Sun, 01 Mar 2026 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772387460; x=1772992260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qhfA0t212P+3PL/YBUUgLF2elEqFty/+jAPa9jWqVJM=;
 b=p8dc3cQef/LJCPxh/a/ekr7wACvDKtgvlJ1TP906O6jrDJh9D4ZQYNb05aXMxM5FRY
 etzad9/NhSlfaNf1sSAdi+UJlYI4GlNFrJwvhabBFjybYxJ1IR4mCv3XDrv2RWJGbJi0
 /FxgDZhda8pH9/gOkGD3mBorAY8OZIvzCZ2Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772387460; x=1772992260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhfA0t212P+3PL/YBUUgLF2elEqFty/+jAPa9jWqVJM=;
 b=Ug0aRsOPDm+z0fmX5fPIxv1Ie1h7r4T6YGKE59Dq0uAasfaibjyjNlusp69uxe3rhi
 QcMMmKH0vCmXiTxAVjCF9NXN6oGFgHxZBzkzd+g19TwGpWkPUYJy4hr+w2YCwB2jM227
 x7zh0urrm/bJaaN9WRGSFIJtTvSRdJcU/W2Hw/7LcitbdJwNzzWDZteKGfgpRhtCj+h0
 HdxhmArk27mwb/ppxYWbrT+294kNGn6AnA4mUiGToEoz7nRYRRYdq0om+Fhak4JkSQRS
 YP0FQTTVi4nZJsMnx7Wd12FuC97m4nuvMfhdaAdtgK/eXyEP4qcvnmOBTDUAb6cooHv4
 HH4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhTaa7Hbe7Uv5s+yOfpVpMXrQs47Se0Q36DW2kUNMO8mEt2tS2a3EAxFnMPChnsVm2fHAHm/w=@lists.denx.de
X-Gm-Message-State: AOJu0YzTbUNi79qm/3Fek6hJHbxjdedRzQY6dbi5wL7NNw189+yoVDbX
 hdmF7YpqxEdkQLeDtyuYza7sx1MGQKlGYq28mq6WkHWR0nLKWVkDvpKKPlSKqp9FCyQ=
X-Gm-Gg: ATEYQzy9ViLbudiWSgrXJQTAPUBvgp8qdzfXii7w1HYHbswQFjAF7AS8K1VW3OOEX4b
 2gruQaRGhUGqfpC9w8QXpr/yQb8qvy3ssZTfX+BNCuruR7AixXaIGlw6g3jC68DNQeMdaFn014I
 0mteeqcB7Rt+/vGUiFqO7Xs7tV6EIUbD2UUqGm0oXOGUC8KuOzD3jJnJG1Ujx6KoppfpwhohEFZ
 KYScvYmNLtl10JyxlXnRpGoPabuSGZBBM8/zGs3XaKp8j0wWhixHw8kVTVRBZe2cZwoUpOQ/YsS
 aLiwRuE1BYhbjnzbZrzlEjVn7pJkIdKZGkIWs1sj45IaI/FkLd3N8kxxzdWw49vXfXOmNLG2JOD
 TF7av9ECGE5KU2WsyxObntm0pInmxA9IaPOLOgZnUBqCm7HBFQtJ0OV9dn6FKFDQLrTr01LIv4q
 LqvESe8ZR3pmJUBuk5RXGITkENGXym6ZFfwLSvVIwwL4uxlfGm1VfXAriUAs6Lrd+hvo031494f
 mkpqyrx+HoEmvXUDDSLS9+XTNhBbfwpZz2926hw4Bol3zWzxb0=
X-Received: by 2002:a05:6870:f626:b0:409:4a88:aa53 with SMTP id
 586e51a60fabf-41626dd13cfmr5473163fac.13.1772387459787; 
 Sun, 01 Mar 2026 09:50:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cff1aacsm9442684fac.9.2026.03.01.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 09:50:58 -0800 (PST)
Date: Sun, 1 Mar 2026 11:50:56 -0600
From: Tom Rini <trini@konsulko.com>
To: dennis@ausil.us
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] board: rockchip: Add Xunlong Orange Pi 5 Pro board support
Message-ID: <20260301175056.GA1388590@bill-the-cat>
References: <20260228211552.2948556-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LqOxc5VLwMUJvaS9"
Content-Disposition: inline
In-Reply-To: <20260228211552.2948556-1-dennis@ausil.us>
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


--LqOxc5VLwMUJvaS9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 03:15:50PM -0600, dennis@ausil.us wrote:

> From: Dennis Gilmore <dennis@ausil.us>
>=20
> The Xunlong Orange Pi 5 Pro is a single-board computer based on the
> rockchip RK3588S SoC. The board provides many interfaces including two
> HDMI output ports, PCI attached GbE network port, M.2 M-Key Slot, One
> USB 3.0, four USB 2.0
>=20
> Features tested on a Orange Pi 5 Plus 4GB v1.2:
>     - SD-card boot
>     - eMMC boot
>     - PCIe/NVMe
>=20
> Device tree has been submitted to the linux kernel
> https://lore.kernel.org/linux-devicetree/20260228205418.2944620-1-dennis@=
ausil.us/T/#t
>=20
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>

Until the device tree is found in the devicetree-rebasing tree it cannot
be under dts/upstream. For rockhip platforms the general path has been
to wait for that to happen, rather than cherry-pick those commits.
Furthermore:

> ---
>  .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    |  13 +
>  configs/orangepi-5-pro-rk3588s_defconfig      |  91 +++++
>  .../arm64/rockchip/rk3588s-orangepi-5-pro.dts | 376 ++++++++++++++++++
>  3 files changed, 480 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
>  create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig
>  create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pr=
o.dts
>=20
> diff --git a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi b/arch/arm/d=
ts/rk3588s-orangepi-5-pro-u-boot.dtsi
> new file mode 100644
> index 00000000000..f0d8c4e09e1
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&fspim0_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

This can be upstreamed to Linux.

> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};

And it should be explained why this isn't included upstream too.

--=20
Tom

--LqOxc5VLwMUJvaS9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaR8fQAKCRAr4qD1Cr/k
Cm3YAP9LMYAxjxjxAfBrDKa4+PfINfCqDdZOATY1nGsbgQhdPAD+IW/ascgs2CCL
6RmnaozeB2Z3fx6faGih0X/lJvVogQM=
=ZidD
-----END PGP SIGNATURE-----

--LqOxc5VLwMUJvaS9--
