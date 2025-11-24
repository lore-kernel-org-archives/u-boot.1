Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C9CFD352
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 19:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297DE83E8E;
	Mon, 24 Nov 2025 20:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DufI/4G2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C16C83EDF; Mon, 24 Nov 2025 20:51:21 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0232483E62
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 20:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45066bee74aso701561b6e.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764013872; x=1764618672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=45J4I+gro8YYvFgypICx1l63gYK791AnG0ozIXYXCgU=;
 b=DufI/4G2e1MHd2wR1zIBdxcA3ChpZQMGZ45B57n4EjgIQxLPJGKxX9wQXq/TKTISP0
 /SZqCi6EKTwOrMDUOE3J3dhXo+p3Y7Z0c9VN8uLJ64M7RaLbUscM3lAy7rAY6nW9zpaf
 WqrMmvAi2lR5moAtxAnbpTleNw3ZdRpfU8JyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764013872; x=1764618672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45J4I+gro8YYvFgypICx1l63gYK791AnG0ozIXYXCgU=;
 b=jG6MuFnIyB/gbSf/zYsNrTFgZGR7tFziya3+I/EhXKrlTcbrVYvKZqeSNVJ5mfHbaR
 5lnSDa8eGkK+gWHpjt3RtrfoDsVukSwQGQLOzVXWw5oG3SBLQN71y+0qyssZrGtRespc
 r1lBdoSyTzzipZkN868c1fdiQOXG0uGoz3WbG21juyS5sOtjnCTVHUMHBoBZfpmPHV5U
 EI6LjQRGPtPxnGixEh7T8JKV1drW1pDOKU0CWFiUX1Ly0F3XXZuK0pCOmme08I+or2od
 8PCwYDjdP5b/OCADAfXSZOTBWtXLQxtHSGIRAyt03qnCI32hWcUdQfW7BrhXlLtO6cI/
 FB4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkXmnAz9L0HOUnawgZyXWaztbU15svWXYrdHig7X+R5JW+KsQ9QaZZ7cSAvgC7Zr/M5akKXWo=@lists.denx.de
X-Gm-Message-State: AOJu0YxbFP2xZgwNNbxUdtIcExQXkC0SRcIsJe65WNZSqahVD8IZx9Bf
 64H73wex5RxKc+XKXi9HoC6PnM6ZdZzmEeoQaehY+fV13rLlcM7H+0ClXvuMmDqMkgM=
X-Gm-Gg: ASbGncugrLlAmamouLc55n/ndM9TCsBtWi4M6rMDSoNBR5eFAs1bSFLBSwv1lU588ll
 wB8wgTQ6COkB3kdwYmh1imIFvYnyMVSMtMj/q5K/lLOQoZghQ906uRN2ySsMhMeOdg338h5glxu
 TcQE9LjxWI4TsqDPbGE7Ff8RoBksuR0qjzwxkdJEoSidqbpQ6guSep5Mhxs2fEmAANYclS9VmWT
 wuXT86COvg5ibPASLzDBBIiXrnjDV0t9zUkS8JZzhmWXwyC735INLZdGWbGQrsSE3+UZOKFYvfd
 OXSa3OV5AlDEVlwkCwrOoL0jIXO9RT7l9z+Lk2eCgkmKCN4PGTJG3qPEZcYOm6d44n8gMBm4U1V
 VznNlmfIO6AiC1lQhLbq2Z3OQKwnU5Gu5wGX870BPOaWr5eKi0pW++89SrYCLioSAgQbY1EN+WM
 0EKG7RYjrMVm3Jvxd+JBFYekM29jVA019fPb742gbd+mCAouwk7g==
X-Google-Smtp-Source: AGHT+IHt1lBh/gKbGm8PcRhS9/61xPDDktTdT1d7htXlOczqtp66Vk2c8E6TvruJz6YHDtwUSZ/ZuA==
X-Received: by 2002:a05:6808:678b:b0:44d:aa6b:a58b with SMTP id
 5614622812f47-4511598072bmr5431753b6e.23.1764013872535; 
 Mon, 24 Nov 2025 11:51:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc8e0e1sm6644634fac.18.2025.11.24.11.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 11:51:11 -0800 (PST)
Date: Mon, 24 Nov 2025 13:51:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 peng.fan@nxp.com, alif.zakuan.yuslaimi@altera.com,
 kory.maincent@bootlin.com, sjg@chromium.org,
 jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 3/7] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
Message-ID: <20251124195108.GN2125796@bill-the-cat>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zu6JZ9zma91bDiuS"
Content-Disposition: inline
In-Reply-To: <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
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


--Zu6JZ9zma91bDiuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 09:24:59PM +0530, Balaji Selvanathan wrote:

> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
> SC7280 and QCM6490 platforms. This driver currently implements
> USB3 super-speed functionality of the combo PHY.
>=20
> The QMP Combo PHY is a dual-mode PHY
> that can operate in either USB3 mode or DisplayPort mode. This
> initial implementation focuses on USB3 mode to enable Super-Speed
> USB support.
>=20
> This is a port of the upstream Linux files to U-Boot:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3D3d25d46a255a83f94d7d4d421=
6f38aafc8e116b0
>=20
> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
[snip]
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 0dd69f7ffd0..49f830abf01 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -12,6 +12,14 @@ config PHY_QCOM_IPQ4019_USB
>  	help
>  	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
> =20
> +config PHY_QCOM_QMP_COMBO
> +	bool "Qualcomm QMP USB3-DP Combo PHY driver"
> +	depends on PHY && ARCH_SNAPDRAGON
> +	help
> +	  Enable this to support the USB3-DP Combo QMP PHY on various Qualcomm
> +	  chipsets. This driver supports the USB3 PHY functionality of the combo
> +	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
> +
>  config PHY_QCOM_QMP_PCIE
>  	tristate "Qualcomm QMP PCIe PHY driver"

Can you please do a follow-up to fix this tristate (and any other in
qualcomm specific Kconfig files) ? Thanks!

--=20
Tom

--Zu6JZ9zma91bDiuS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSS3LAAKCRAr4qD1Cr/k
CpD5AQD1QNF+tX/dKC1SVIEOdtaEUslvmJ9Xnv6KDfzjCvEBUwD+KtVIK1Rt5dd4
gbBoFkjVheIHhR/8jX1dnzEbxSjK0ws=
=bN3/
-----END PGP SIGNATURE-----

--Zu6JZ9zma91bDiuS--
