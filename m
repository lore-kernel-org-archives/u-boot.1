Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97F5C54E49
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 15:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CAB880D9;
	Thu, 29 Feb 2024 16:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AlZ+B18q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3DF880DA; Thu, 29 Feb 2024 16:08:41 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F018752B
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 16:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5a05923b689so387635eaf.0
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709219317; x=1709824117; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KKDhKg+MQhRwGrgAYX7P9m9/C7GMI89fPYFN8ajsSZ8=;
 b=AlZ+B18qlnw1W00ppQLLpQPn/yi7Fj7AhQwLsM5JtLbfn6fo3KUO0IhcTeuRFESN2+
 kQv8BS82oK8i87ulzcFwW/zxzLiCbXOOJfflG5b6KEJhpWyf9n+xxnxxCkQejc0Tp65g
 rwpTMcdKVQesK6fQO0S/XHX0cMti/5vlGmgdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709219317; x=1709824117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKDhKg+MQhRwGrgAYX7P9m9/C7GMI89fPYFN8ajsSZ8=;
 b=kwOpmPCCZ/qWQRGEclAkVkUHBv+CWLpLk2GWldCEI8jNhca6tdqeyIUtJmcMQ16xIr
 IgWGr3E+D1f/+SP2n9Bh1JOilgspw12855SZfwFvkgl2FuAkhvj8OyVo8OzwLq60itP7
 Hh+jcCQYY/MO6DeZUNToVxPOnSvEedzAYd/ADRzrxjPgUUkZLba1Tv9El7B8lbL8BDAx
 3+ChR7giZQvRWZRXI8uVOQkkZnelmFEbIi0dgd3KptlXZh0ljejSEr6PKvUz9gvZdmfV
 Kg7GSr9a5EP0igJBz+dyfu/4eyEoJuKLxnmmLxdelXaqCncTaStGLuYCI10XcI5IchN8
 h9IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD0O+EMPcnz6Sqi58vdv/VCzlPp+97JRSslPs59h2eMe/StNsd+vV/334p3okURfVY3bu/PBlQUWVR2YmN0tmcXy3zNQ==
X-Gm-Message-State: AOJu0YzNg5MmIQyG89NZXkCYxCY9pK/pgsjneSNC0/UQFuXylw2ZZZ/r
 69wuJ+cT+3N1hffHYozz+j3OzB9Y+weS5/IB+/M8uWyh6Uxo0uCkJ/sFH81koeQ=
X-Google-Smtp-Source: AGHT+IFOuVv/o0EWl3e469DDjmRxJRAZrBoHZNUGGJyhu/p9bGAGm/HFv49drv9kuJ/EHpUEsS0Uvg==
X-Received: by 2002:a05:6358:d59b:b0:17b:7de:bab6 with SMTP id
 ms27-20020a056358d59b00b0017b07debab6mr3523312rwb.28.1709219316767; 
 Thu, 29 Feb 2024 07:08:36 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 g12-20020a25ef0c000000b00dc74d5e3ff7sm360297ybd.31.2024.02.29.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 07:08:36 -0800 (PST)
Date: Thu, 29 Feb 2024 10:08:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Elon Zhang <zhangzj@rock-chips.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 weizhao.ouyang@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH] board: rockchip: add Rockchip Toybrick TB-RK3588X board
Message-ID: <20240229150834.GU3040305@bill-the-cat>
References: <20240229120416.998975-1-zhangzj@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="npYLmQhVMydENsLd"
Content-Disposition: inline
In-Reply-To: <20240229120416.998975-1-zhangzj@rock-chips.com>
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


--npYLmQhVMydENsLd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 08:04:16PM +0800, Elon Zhang wrote:

> TB-RK3588X board is a Rockchip Toybrick RK3588 based development board.
>=20
> Specification:
> 	Rockchip Rk3588 SoC
> 	4x ARM Cortex-A76, 4x ARM Cortex-A55
> 	8/16GB Memory LPDDR4x
> 	Mali G610MC4 GPU
> 	2=D7 MIPI-CSI0 Connector
> 	1x 2Lanes PCIe3.0 Connector
> 	1x SATA3.0 Connector
> 	32GB eMMC Module
> 	2x USB 2.0, 2x USB 3.0
> 	1x HDMI Output, 1x HDMI Input
> 	2x Ethernet Port
>=20
> Functions work normally:
> 	[1] USB2.0 Host
> 	[2] Ethernet0 with PHY RTL8211F
>=20
> More information can be obtained from the following websites:
> 	[1] https://t.rock-chips.com/en/wiki/EN/tb-rk3588x_en/index.html
> 	[2] http://t.rock-chips.com/
>=20
> Kernel commits:
> 	8ffe365f8dc7 ("arm64: dts: rockchip: Add devicetree support for TB-RK358=
8X board")
> 	7140387ff49d ("dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X")
>=20
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
[snip]
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y

Is this just a copy/paste thing that keeps getting re-used? Ideally,
BOARD_SPECIFIC_OPTIONS shouldn't exist and it's either a select/imply at
the TARGET_... level or something in the defconfig. But having an empty
one is very confusing.

--=20
Tom

--npYLmQhVMydENsLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXgne4ACgkQFHw5/5Y0
tywadAwAtRSFbuFSnPvQ1VZnGdMEH+W25u+LwVpiiPO80oFiYXu9/f2YXUFPXNDK
0HgQz51fLiWaRkhdsVOY+1hncFKOdDcwo3GFR7o+Y7OJt0BrVs9RF11Y/2gAG34R
wJxYBFANq7fu12pFsTZ0n9EzqMLwaHg2VOZwDSd6iX+OGJAKl5TAXwX/zVIsMRRf
M7kSIleFSofZqs2bvXIOLdFargueCeiEHnFpIISfDF7xqKZeTI4TTtLaAI2YZTFB
YPc+Z28yneN9NG7d6lr7eSf/+4IJSWYPgc2AU6IxUN/+Ssw/UQjeOVPxfpS6W/qc
7n+kays3RXRwS88rtL9jFNCHc5dMEIUbhs/ekJRu7ijiLPOGxpnNupaUwctvJ1fW
brFL1SCWnZeNW1HY3ry3cXX4SCYftbuLZNFIr+46FE7f98aKKp9MMgDJxdGCWs6f
XYs1IM2wwjYyIoNUp1aY7eCOOStEGLsJFJ37nK9V4Z4WQqjg/KaTe2SOrdACYJXW
lq6OTZwg
=8uBz
-----END PGP SIGNATURE-----

--npYLmQhVMydENsLd--
