Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546D5CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 15:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC94833ED;
	Mon, 22 Sep 2025 17:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ITRrPfbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DBB8341C; Mon, 22 Sep 2025 17:55:28 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E71783211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 17:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-34207c1bdaeso426622fac.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758556525; x=1759161325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RsC1fB3MV4e7g0CU2rEKBerwEkwATRePrze5d/4oeT0=;
 b=ITRrPfbYOzNxd6WydFNCfxArXRgC0VLXjBrVpqdX7hAAHcn7dzYSMRTlYMTRVaGyJb
 MpqAgm9GmEs3/QvjTYFio/hPDV1sId2nsxx3HiOuwytHww2rjPiKdgjIIqH1ujXkLlsG
 NSKLKdvynY9ZSlPwNgNzPbl1KIoBIHP6nXnuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556525; x=1759161325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsC1fB3MV4e7g0CU2rEKBerwEkwATRePrze5d/4oeT0=;
 b=X6QhT1ajVLfYIveCH4OLxNsfbdtRnZ6mUE6qQr56ofGp7CuOjH0n6NFHAaBhmZwbp6
 F7O4crg2IUrC2N0X8mp/mAirOW2/6h/3LG/dJIY4vGowLXJDU1/TFrpHMzjsrMssk7Iz
 AV2hwcT9VqphUBlvZNMglFTzFxXJrYQTOp+qUNcCAYczJY1VXKFSB4Z62JLTPtTw67o1
 JPrrPRM7lIhR+SbzAHY+zhkGPcUSy2s6XVAwWPTLqI7iZ5a4hFJJPEAA3Rh0vMieykNb
 b5qwtXe+09aASwvuc5eGXUX2+OnHfUXhuwFJP5Md9RcVdlrp6+wswh7DTFNh3eaBlQrY
 s63Q==
X-Gm-Message-State: AOJu0Yx9RIoaDpickX/cw3lElWHyRMH01Z7h8G+TXK0yV3NMCVO9JXBp
 5GtcaPvHCgQpdOTqTm+qQJkPdJV4b8vrvXJ8kiSbgQxjwq0Q8kCurvsBmVL5C4Her/s=
X-Gm-Gg: ASbGncsQ60sL0F/ZFVi/VB7b2l/Dhq+6HUilFdkIdtKpeOcUl9EZ0f1g3WG1jXb7R+t
 GQdN37EXsN+1fivdpIgENVyrS2dmpaYiY5yufkMIIWj8ms9SRiF6YYJOb+X24YEIbVGu6YHB8l5
 o9qE2jTKRrTrLgkQKjsqFYC6WKAAMI/h9yS5N/X4pa5kO8DZsCp9aMD96yDASiuHt/jvrvInyu4
 VZEHHCer0VBZPO4sWO1aYP46s4wO6muuQ1cpieud6o+LY/YJ4q0mTtai5STpTS+EJDBCwiuSPcv
 uZdJOBXSlhqrkpOpNoegsmGOLSYYS/sfe9SVhMDvTd0PXOu1drmbbZlg+1WYJegj9n/Tthe0fJO
 EPzYQq+ubPPgfqjjGnp+R80weXeB6EpZTMsiWl8dWdgsH+CXKkACs7YNF
X-Google-Smtp-Source: AGHT+IHIEbeVDceiock1SdzFwlsf+M5PpdMqPeYyWitotx3dKELB6w54cw80eqVWFhN/rzEZfYrUwg==
X-Received: by 2002:a05:6870:148c:b0:322:5c2d:58c9 with SMTP id
 586e51a60fabf-33bb5b6c0e2mr6426657fac.24.1758556524927; 
 Mon, 22 Sep 2025 08:55:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-341ec028f4fsm1361194fac.14.2025.09.22.08.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:55:24 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:55:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250922
Message-ID: <20250922155522.GC124814@bill-the-cat>
References: <20250922141915.208136-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gSdOwfBi4dtI+gRi"
Content-Disposition: inline
In-Reply-To: <20250922141915.208136-1-festevam@gmail.com>
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


--gSdOwfBi4dtI+gRi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:19:15AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 464800d91b036cfd2df26598d8df2ac72d4569=
dd:
>=20
>   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-=
riscv into next (2025-09-20 10:02:00 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20250922
>=20
> for you to fetch changes up to 424103865662603d821028734ecddda8802e43b3:
>=20
>   doc: phytec: imx8m: Style and firmware update (2025-09-20 17:48:20 -030=
0)
>=20
> u-boot-imx-next-20250922
> ------------------------
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27684
>=20
> - Add i.MX8 ahab-commit command.
> - Add support for flashing board with UUU on imx93_frdm.
> - Fix the acces of PFUZE100 regulator desc.
> - Add more i.MX6 PWM clock definitions.
> - Enable OP-TEE on phytec-imx8m and update documentation.
> - Enable PCI host controller on iMX95 19x19 EVK.
> ----------------------------------------------------------------
> John Ripple (1):
>       imx8: Add ahab_commit command
>=20
> Mathieu Dubois-Briand (1):
>       imx93_frdm: Add support for flashing board with UUU
>=20
> Peng Fan (1):
>       power: regulator: pfuze100: Fix accessing the regulator desc
>=20
> Ricardo Simoes (1):
>       clk: imx6q: Add definition for missing PWM clocks
>=20
> Yannic Moog (3):
>       phytec-imx8m boards: enable OP-TEE for KASLR
>       doc: phytec: update imx8m docs for optee builds
>       doc: phytec: imx8m: Style and firmware update
>=20
> Ye Li (8):
>       pci: dw: Fix wrong register used for PCI_COMMAND
>       pci: pcie_dw_imx: Add iMX9 support to the driver
>       clk: imx: Add imx95 blkctrl clock driver
>       power: regulator: Add vin-supply for GPIO and Fixed regulators
>       clk: clk-uclass: Fix clk_set_default_rates issue
>       arm: dts: imx95: Assign HSIOPLL_VCO as HSIOPLL parent clock
>       arm: dts: imx95-evk: set alias for enetc PCI buses
>       imx95_evk: Enable PCI host controller on iMX95 19x19 EVK

Looking at checkpatch.pl output, there's a lot of spacing warnings on
both drivers/clk/imx/clk-imx95-blkctrl.c and drivers/pci/pcie_dw_imx.c
and I've gone and fixed them up in the merge commit. But, to the
authors, please try and fix these before posting, thanks.

--=20
Tom

--gSdOwfBi4dtI+gRi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNFxZgAKCRAr4qD1Cr/k
CgONAQC8q4XpezRdBfNlvco/x8Rwo6mVfpYJj7ezXXmyI9WsGwD+Kr/4/Ast0TOf
gFob9VQ9sTMwhgkzfa0duGsTT2rFWwg=
=lTC4
-----END PGP SIGNATURE-----

--gSdOwfBi4dtI+gRi--
