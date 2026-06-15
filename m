Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFDDCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 23:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2E1848C5;
	Tue, 16 Jun 2026 01:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uug+Z1yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6AB846B0; Mon, 15 Jun 2026 18:33:17 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFFE84105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-43fc82b52afso2268109fac.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781541194; x=1782145994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Di2mfL3gqBgkn0KxjG+WZFQHHddhIAZIyucGoqdMz94=;
 b=Uug+Z1yigB1DJS78vXyK8dzHBPbtartN8rbZtSp9yaltKU+EdPwQJm5Vx0sR42uAFA
 MsBGwYvwPQf0jfokTHsQ4EffKP6ciAIHaOQPaibfBhiqUZux0pdZ3CtuRXFGudkmfUZa
 oE/KerYBGx+Q1rHJgeVSjzyVuPy3x0GXwOdzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541194; x=1782145994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Di2mfL3gqBgkn0KxjG+WZFQHHddhIAZIyucGoqdMz94=;
 b=nYREhycFLbPYUVPARuYiD9QnbpA+WIaSzcWH64T6CqoYGOHJPzZSGoi8O+UGJurwlm
 fvRggDqsIi3Y5QEY7UVSrQXH7e9TiHOCabTj1dHCj5yZW+8EZhGlj7yS4maq05vR+9ta
 LJ4N7zbgBp4Kp1eAtDd+RmFnKv1LgCjtp+Of7MFqBSn3ohtbVat7GptrlDPeTCIpNyL7
 Z2XN+9wGRGaP7sMGX++N8JSy2dd2qIWF4qF/pHGtXxTiBPIj4SgBs+O3m6waiNjHtTrW
 egxAbTNZ1d9S7wNjW9QZyCNgPDYCDulmbJj2H4acCaoohEMwx2duDlyLUiYEsxPM6mon
 ZuQw==
X-Gm-Message-State: AOJu0Yz0Rnx++jdvOaH42/JrflL0eweJIbxCrFvgzY4mKm7zNhqcAYqf
 tXdCChMX40mHyvIbyKcr7yIZ12dxNOjn9azrc0Zl0jOVD+sf18ptlo56oo/kBS9IQKY=
X-Gm-Gg: Acq92OFsIdblmu+buHjINdagJvhAdR4Q2Z8yWlsMMSCYKMmS6YNtUptofLibYHCQu9X
 Myv0SLazMmYW70lQHJkkDQMVE1tXq2izkG5jmvWD4MmWbuIJoPxKz+QuoNMMB+eMMh0FMqXbXrG
 P8JpnWN3ALlFvz7GDBjxnGYb9qrc/6pew8FDMMNZ5N+joSfvnY8VU1nD+3PBDjLMrZbSBALnE8d
 QdQGy0nql+IvVtc7uLia3E6kS53BGueyT4XZbRWZ9vbkRJPTEL5CIPE+vq07CIqyXBgsdu3mH52
 jSJyg1NKscy15w1gSwwsuF9lXHwiPNBbJ7LUWUmA/0MgYL/GiBlX/vZV56k/FiNfDchu64xtYf8
 nti1mRY5OvRT9+4gyNYx5SQENyaoM4flhyrNvHcQYJjl1iVj7fisZZM/bWPj2KCBKXdOZQJcN52
 CZjUL13J3zi2zbQreREmxP3rGCXn3J7USEy26DAxCycfQ3XmM2CbZC6EAvIP3LiNSgRuQPKmItB
 oSH/FUq6Em/NxBAhYUoL/jIkIiopmbAYTOXffH/Zp+Yoq0GTTXRAgNJm8dOCw==
X-Received: by 2002:a05:6871:8916:b0:434:2c00:fd84 with SMTP id
 586e51a60fabf-4428c3d57f1mr7605174fac.10.1781541193865; 
 Mon, 15 Jun 2026 09:33:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430900e368sm206600fac.16.2026.06.15.09.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:33:13 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:33:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 07/14] ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL
 build support
Message-ID: <20260615163308.GB382693@bill-the-cat>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
 <20260615-spl_ufs-v3-7-360bceb29596@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SAdB+/wZRgNj0Zyi"
Content-Disposition: inline
In-Reply-To: <20260615-spl_ufs-v3-7-360bceb29596@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 16 Jun 2026 01:14:20 +0200
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


--SAdB+/wZRgNj0Zyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:30:03PM +0530, Balaji Selvanathan wrote:
> Add a new SPL_UFS_QCOM Kconfig option to allow the Qualcomm UFS
> host controller driver to be built for SPL on Snapdragon platforms.
>=20
> Switch the ufs-uclass.o and ufs-qcom.o Makefile rules to use the
> $(PHASE_) prefix macro so that the correct config symbol
> (UFS/SPL_UFS and UFS_QCOM/SPL_UFS_QCOM) is selected automatically
> depending on whether SPL or U-Boot proper is being compiled.
>=20
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.co=
m>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - No changes in v3
> ---
>  drivers/ufs/Kconfig  | 8 ++++++++
>  drivers/ufs/Makefile | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 64172454bc6..2fe9346dbf3 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -55,6 +55,14 @@ config UFS_QCOM
>  	  This selects the platform driver for the UFS host
>  	  controller present on Qualcomm Snapdragon SoCs.
> =20
> +config SPL_UFS_QCOM
> +	bool "Qualcomm Host Controller driver for UFS in SPL"
> +	depends on SPL_UFS && ARCH_SNAPDRAGON
> +	help
> +	  This selects the platform driver for the UFS host controller
> +	  present on Qualcomm Snapdragon SoCs for use in SPL. Enable this
> +	  to use UFS as a boot device in SPL on Qualcomm platforms.
> +
>  config UFS_RENESAS
>  	bool "Renesas R-Car S4 UFS Controller support"
>  	depends on UFS
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..c15635c01bc 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -3,13 +3,14 @@
>  # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
>  #
> =20
> -obj-$(CONFIG_UFS) +=3D ufs-uclass.o
> +obj-$(CONFIG_$(PHASE_)UFS) +=3D ufs-uclass.o
>  obj-$(CONFIG_UFS_AMD_VERSAL2) +=3D ufs-amd-versal2.o ufshcd-dwc.o
>  obj-$(CONFIG_UFS_CADENCE) +=3D cdns-platform.o
>  obj-$(CONFIG_UFS_MEDIATEK) +=3D ufs-mediatek.o
>  obj-$(CONFIG_UFS_PCI) +=3D ufs-pci.o
> -obj-$(CONFIG_UFS_QCOM) +=3D ufs-qcom.o
> +obj-$(CONFIG_$(PHASE_)UFS_QCOM) +=3D ufs-qcom.o
>  obj-$(CONFIG_UFS_RENESAS) +=3D ufs-renesas.o
>  obj-$(CONFIG_UFS_RENESAS_GEN5) +=3D ufs-renesas-rcar-gen5.o
>  obj-$(CONFIG_UFS_ROCKCHIP) +=3D ufs-rockchip.o
>  obj-$(CONFIG_UFS_TI_J721E) +=3D ti-j721e-ufs.o
> +

Aside from the stray newline, OK, so I shouldn't have reviewed and sent
emails patch-at-a-time. This is taking things in the right direction,
but later in the series than we should, and the Makefile comment I made
earlier is still important.

--=20
Tom

--SAdB+/wZRgNj0Zyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajApRAAKCRAr4qD1Cr/k
ClsXAQC1W7jcvKUPRKHQhCz8aU8bjYPjTOnM4ApKmbT9zr5KFwD9HqkEKki6g76f
NfNcbH1Jt9AbXEn25zVQ6G0b3lykegk=
=xjLP
-----END PGP SIGNATURE-----

--SAdB+/wZRgNj0Zyi--
