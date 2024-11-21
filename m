Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC23AD6E2CA
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 10:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79F48967B;
	Thu, 21 Nov 2024 11:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Arb+EfB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664C18971B; Thu, 21 Nov 2024 11:12:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD8389321
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 11:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1732183954; x=1732788754; i=wahrenst@gmx.net;
 bh=e+9eZa9k7K0vnsPGC/pQi/2MVmuqhtTj8flSwcvqV4E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Arb+EfB4oPHcs8ANYuVRaS8mhQ7ecyuXRjIzB4okfp+FYKimpoYu1nT5QLO1wqex
 k4BIoQ7C/MDsNRRWd/zvg7QwWePM/5x8yp0BvR045UwcXMa2oMhG4RO70h45ziyBG
 ahWmrfuAy8UIe40g+reBZ1FJp/N9LWBZdVrJPSV3/vAytYkeq7F/mOXyjsgcIvNMr
 R45o0GZ2SIH72/DafoHxZP6mDziJru5tWj6dUrYuO2LLOSQdSYSb6Gu96/EJqEXzC
 HDUS51n43lsZfQ3SHBTEhKWEf63KC0tEgmfb5lUMO1F5Jfz09pzQ7AwmcqKj2dOOw
 Jpx9YUJNKV8TfoPUYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1tgpLe132O-00kmRC; Thu, 21
 Nov 2024 11:12:34 +0100
Message-ID: <371c6302-438b-45b6-944b-d513f74f38a5@gmx.net>
Date: Thu, 21 Nov 2024 11:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
To: Christoph Stoidner <c.stoidner@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Cc: Wadim Egorov <w.egorov@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>
References: <20241120163143.127862-1-c.stoidner@phytec.de>
 <20241120163143.127862-3-c.stoidner@phytec.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241120163143.127862-3-c.stoidner@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XNZ1eAtwzhUXVeNnpnSdVwu780pJklPl79PFgG13cimarXD5XYf
 uXOj3KyPG4JACiL0htj+8AfZ0Jg5xZ525VNZ6YwdnzugQW3qb/MCu0SNCrTuzmhT+YpHWCD
 eya7UDjB5NB1pSqaHv2NNML4Hk8U40334SENlDTdiU2wNgNsSDErCO0sRIXBOZRtSrXuiRg
 dxZ9Cs7XzZgscrJ5ytgSQ==
UI-OutboundReport: notjunk:1;M01:P0:XrIhspT7+n0=;KTJA2R8g1afvPP289mBOG+SoRT3
 hVce7T1aI+uN9opD6vaf/a10l2+Ub/KhCkxKe9joyqmxNNOztVCoEdCCnmS8U0EtxpTjHu6eH
 N2wOAfZ/YelvntyPGsSYhaT8P3eT1ufsgU3D8+q6OdykAz7xUtGzT1Ql33qQDy1NW6zfWR/yE
 ypOlbb1fHYbTZiV+K3vHNR2qTnT8KvktJZHNTP9MBF9GdrV6zxGLou9/dZgZWuA0iivvHCf/I
 7zeRI+B2VtlGFtpRn2xN455EwkWuC7Ep1cil8LZRh0EvHo6shuZOv05TZMGG8hORp3cQprGxR
 kgJXdjw8tBbGI2WFuQcVzNTZZKmY/mD3R8KM+r6zLwsTSSb4A7g21Z4BlIANUkRKnSJBUa2IF
 77R6ivxJizlpwrddYqr+FjR14BWjpZKKsSl6S66kzXiT4XvlzgT9o+PGY4CQ702tkWFpGDi79
 uygXUmlp0uN7MFagyqiqmFFHgXS99umHJVbQYx00hHvXZXYSckZKAx1cTe0ZzfUMDyyE+/bUa
 rIKc3wF7ZwH9nt04TeOXfq0UaNJb0E0/1KKRmlfZfhQTepSVb38VTu9YlbJzTvcHea37avBsM
 nfH2bKxNXuMHPadZqk6PIcTXyL1jbMRbgV07YPiCacs9ctsmhOO3V670KuCwCC+f/8rhqLdhu
 wp+cgWP5ypSrTj5r7daNe8BZl8ekupmVF1EmPWLQ+WKeNQ6Gfajpx2q7+lnFCK8GrLOJNtFMx
 oyV3AwVem+qhuD8YJvRKiJVImA2Oy53lNIddPOsQ+LqGnGoYw0uLIudHiTT+q3DiWSWCWb/Cn
 T3rSvMAK4774G5M3Q7JiEIM76jSFMMQod642WDloBdZKejnhusF7SdLM+S+ctIhLQisX4bxrl
 hXmLERIat4x9H1m3Om32n2f0gkePBsKc/mrDLZZ9jetnejkRKptVXEZmU
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

Hi Christoph,

Am 20.11.24 um 17:31 schrieb Christoph Stoidner:
> The phyCORE-i.MX 93 is available in various variants. Relevant variant
> options for the spl/u-boot are:
> - with or without HS400 support for the eMMC
> - with 1GB ram chip, or 2GB ram chip
>
> The phyCORE's eeprom contains all information about the existing variant
> options. Add evaluation of the eeprom data to the spl/u-boot to
> enable/disable HS400 and to select the appropriate ram configuration at
> startup.
>
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> Reviewed-by: Yannic Moog <y.moog@phytec.de>
> ---
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> Cc: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> Cc: Primoz Fiser <primoz.fiser@norik.com>
> Cc: Andrej Picej <andrej.picej@norik.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> ---
> Changes in v4:
> - add missing pinctrls for eMMC 100mhz and 200mhz
>
> Changes in v3:
> - remove unwanted dts node eepromid
> - correct typo in doc (PHYTEC_IMX93_VOLTAGE_3V3)
> - improve enum code-style (phytec_imx93_option_index)
>
> Changes in v2:
> - encapsulate handling of feature flag VOLTAGE into own function
> - move definition of enum phytec_imx93_ddr_eeprom_code into header file
>
>   arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  58 +++++++++
>   arch/arm/mach-imx/imx9/Kconfig                |   2 +
>   arch/arm/mach-imx/imx9/soc.c                  |   2 +-
>   board/phytec/common/Kconfig                   |   8 ++
>   board/phytec/common/Makefile                  |   1 +
>   board/phytec/common/imx93_som_detection.c     | 111 ++++++++++++++++++
>   board/phytec/common/imx93_som_detection.h     |  51 ++++++++
>   board/phytec/phycore_imx93/Kconfig            |  28 +++++
>   board/phytec/phycore_imx93/MAINTAINERS        |   5 +-
>   board/phytec/phycore_imx93/phycore-imx93.c    |  51 ++++++++
>   board/phytec/phycore_imx93/spl.c              |  48 ++++++++
>   11 files changed, 363 insertions(+), 2 deletions(-)
>   create mode 100644 board/phytec/common/imx93_som_detection.c
>   create mode 100644 board/phytec/common/imx93_som_detection.h
>
> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dt=
s/imx93-phyboard-segin-u-boot.dtsi
> index 6897c91f4d..702d86f4e0 100644
> --- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -139,6 +139,13 @@
>   &usdhc1 {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> +	/*
> +	 * Remove pinctrl assignments once they are added to imx93-phycore-som=
.dtsi
> +	 */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> +	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
>   };
>
>   &usdhc2 {
> @@ -215,6 +222,48 @@
>   			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x31e
>   		>;
>   	};
> +
> +	/*
> +	 * Remove pinctrl_usdhc1_100mhz and pinctrl_usdhc1_200mhz once they
> +	 * are added to imx93-phycore-som.dtsi
> +	 */
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		fsl,pins =3D <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000139e
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013be
Could you please explain why the pin configuration for 100 MHz of DATA0
& DATA2 is different from the other data pins?
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000139e
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000139e
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000139e
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000139e
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000139e
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		fsl,pins =3D <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x17be
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000139e
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013be
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013be
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013be
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013be
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013be
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013be
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013be
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
> +		>;
> +	};
>   };
>
