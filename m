Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2169FC83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 16:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E9283087;
	Tue, 15 Jul 2025 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="lAK8lJxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F0678309D; Tue, 15 Jul 2025 18:48:26 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E97883071
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 18:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752598098; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KqmC2BaYDf92E1K/3x02nEsgPu19MfzbibVtTQjKl/GKd3yEVnHkycaYBReIwkFJRckknrJLK/8ZInUl7MZUgNzto+Nd0u7DpZn2mgnbSezwBomnyfyEQ0RLy24ndHpExLVOVx609eMwS+cbF9lerEq51Nd8w4IbDDDMwgbabrE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752598098;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hoFXaIPMaSclN5rGVMZkudPRN8p+OBnlE8mleWchub8=; 
 b=YxdjFiEedGI504/PRyW9+5bbsON/j5FF+AMjRMBHqC8dTRisUPPb0s0+5FwGgxYo/Ps3Y2KsEaeP5zE/MF9YhSJPMHy3ypp2zHrSEezrYW2OpTN6ErrRuHxVU/Fs6MZdm7iKHAxc3VuvLpHP1/CPQSXaLDG/Uz2goTWlnjVBGZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752598098; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=hoFXaIPMaSclN5rGVMZkudPRN8p+OBnlE8mleWchub8=;
 b=lAK8lJxkr3QCc3DBaXOrblrJ0DTHPDXn7OTEbR19y6S2aaXJ6DzB4CRsVGKvqp7Z
 ayWFukDNEXQmPizO0sNJjiUBFVqqHqUOZBfFrVI6XiAp3etq5nh1ds+PW7MWO45BpsP
 brNdpVsGpH6fq/BDC/BdKtSQIQjL35sfpal533hY=
Received: by mx.zohomail.com with SMTPS id 175259809407333.57852283545719;
 Tue, 15 Jul 2025 09:48:14 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 8E642180753; Tue, 15 Jul 2025 18:48:10 +0200 (CEST)
Date: Tue, 15 Jul 2025 18:48:10 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] rockchip: rock5b-rk3588: Add support for ROCK 5B+
Message-ID: <e46mypj2zn7ggff7ivef3k7ejqnc6swng6tfi2cymlipcak6fc@6n43szvkzzvf>
References: <20250714223410.1836893-1-jonas@kwiboo.se>
 <20250714223410.1836893-5-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fsmcoqawoulo7k6m"
Content-Disposition: inline
In-Reply-To: <20250714223410.1836893-5-jonas@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/252.589.14
X-ZohoMailClient: External
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


--fsmcoqawoulo7k6m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] rockchip: rock5b-rk3588: Add support for ROCK 5B+
MIME-Version: 1.0

Hello Jonas,

On Mon, Jul 14, 2025 at 10:34:01PM +0000, Jonas Karlman wrote:
> Include FDTs for both ROCK 5B and 5B+ in the FIT and add board
> selection code to load the 5B+ FDT when the ADC channel 5 value is
> close to 4095.

The Rock 5B uses the same channel and starts with 0V for revision A
and jumps in 0.3V steps for newer revisions. So technically a Rock
5B revision H would be detected as Rock 5B+ with this code. IDK if
Radxa will ever release such a board. But I have an alternative
implementation, which does the board detection via the DDR memory
type (Rock 5B =3D LPDDR4, Rock 5B+ =3D LPDDR5):

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot/-/com=
mit/9803234dbb014a8fa4b495aa8f95bdc710d88380

Considering that the different memory is something Radxa explicitly
promotes as board difference between 5B and 5B+ it seems like a
better approach to me. Note I only haven't send this yet, since I
was waiting for the Rock 5B+ DT to land in the upstream kernel. But
I'm totally happy for you to take care of this :)

Greetings,

-- Sebastian

>=20
>   U-Boot 2025.07 (Jul 14 2025 - 21:28:20 +0000)
>=20
>   Model: Radxa ROCK 5B+
>   SoC:   RK3588
>   DRAM:  8 GiB
>=20
> Features tested on a ROCK 5B+ v1.2:
> - SD-card boot
> - eMMC boot
> - SPI flash boot
> - PCIe/NVMe
> - Ethernet
> - USB/TCPM
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 ++
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
>  board/radxa/rock5b-rk3588/Kconfig            |  5 ++
>  board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
>  board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 55 ++++++++++++++++++++
>  configs/rock5b-rk3588_defconfig              |  1 +
>  doc/board/rockchip/rockchip.rst              |  2 +-
>  7 files changed, 71 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>=20
> diff --git a/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi b/arch/arm/dts/=
rk3588-rock-5b-plus-u-boot.dtsi
> new file mode 100644
> index 000000000000..c07696c83913
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-rock-5b-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk358=
8-rock-5b-u-boot.dtsi
> index d51fbf51cb88..e07b549c767f 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -46,6 +46,11 @@
>  	};
>  };
> =20
> +&saradc {
> +	bootph-pre-ram;
> +	vdd-microvolts =3D <1800000>;
> +};
> +
>  &sdhci {
>  	cap-mmc-highspeed;
>  	mmc-hs200-1_8v;
> diff --git a/board/radxa/rock5b-rk3588/Kconfig b/board/radxa/rock5b-rk358=
8/Kconfig
> index 41dfe2402b12..98d630117836 100644
> --- a/board/radxa/rock5b-rk3588/Kconfig
> +++ b/board/radxa/rock5b-rk3588/Kconfig
> @@ -9,4 +9,9 @@ config SYS_VENDOR
>  config SYS_CONFIG_NAME
>  	default "rock5b-rk3588"
> =20
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +	select ADC
> +	select SPL_ADC
> +
>  endif
> diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-r=
k3588/MAINTAINERS
> index 4460c9971a96..c8a43769105e 100644
> --- a/board/radxa/rock5b-rk3588/MAINTAINERS
> +++ b/board/radxa/rock5b-rk3588/MAINTAINERS
> @@ -5,5 +5,4 @@ S:	Maintained
>  F:	board/radxa/rock5b-rk3588
>  F:	include/configs/rock5b-rk3588.h
>  F:	configs/rock5b-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-rock-5b.dts
> -F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-rock-5b*
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock=
5b-rk3588/rock5b-rk3588.c
> index fc2f69db2241..1443c2c828a1 100644
> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -3,8 +3,63 @@
>   * Copyright (c) 2023-2024 Collabora Ltd.
>   */
> =20
> +#include <adc.h>
> +#include <env.h>
>  #include <fdtdec.h>
>  #include <fdt_support.h>
> +#include <linux/errno.h>
> +
> +#define HW_ID_CHANNEL	5
> +
> +struct board_model {
> +	unsigned int low;
> +	unsigned int high;
> +	const char *fdtfile;
> +};
> +
> +static const struct board_model board_models[] =3D {
> +	{ 4050, 4130, "rockchip/rk3588-rock-5b-plus.dtb" },
> +};
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	unsigned int val;
> +	int i, ret;
> +
> +	ret =3D adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
> +	if (ret)
> +		return NULL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(board_models); i++) {
> +		unsigned int min =3D board_models[i].low;
> +		unsigned int max =3D board_models[i].high;
> +
> +		if (min <=3D val && val <=3D max)
> +			return &board_models[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +int rk_board_late_init(void)
> +{
> +	const struct board_model *model =3D get_board_model();
> +
> +	if (model)
> +		env_set("fdtfile", model->fdtfile);
> +
> +	return 0;
> +}
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	const struct board_model *model =3D get_board_model();
> +
> +	if (model && !strcmp(name, model->fdtfile))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> =20
>  #ifdef CONFIG_OF_BOARD_SETUP
>  int ft_board_setup(void *blob, struct bd_info *bd)
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defc=
onfig
> index 6349e8791456..967cebc2054f 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=3Dy
>  # CONFIG_SPL_DOS_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_OF_LIVE=3Dy
> +CONFIG_OF_LIST=3D"rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus"
>  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cloc=
ks assigned-clock-rates assigned-clock-parents"
>  CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_SPL_REGMAP=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchi=
p.rst
> index b88299cbba23..7a1385789c20 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -152,7 +152,7 @@ List of mainline supported Rockchip boards:
>       - Pine64 QuartzPro64 (quartzpro64-rk3588)
>       - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>       - Radxa ROCK 5A (rock5a-rk3588s)
> -     - Radxa ROCK 5B (rock5b-rk3588)
> +     - Radxa ROCK 5B/5B+ (rock5b-rk3588)
>       - Radxa ROCK 5C (rock-5c-rk3588s)
>       - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>       - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
> --=20
> 2.49.0
>=20

--fsmcoqawoulo7k6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmh2hkYACgkQ2O7X88g7
+pqMtA/+PGO2zMZntERFF6IrLSZCeOqpIIExioXnhTCgqcWCNCLURT23L2IGG5TW
WYXMxjY3D4EaAbk5VDBMtFjSqRyYm69pYFXnMVLlKkLQlCSXe7vCjW+C3sX6i0Mu
+/g/d+GiFSe8ywfRR0M53P7mKAn0MV6VQAcQX/gR2weq+ipefNCT0ATFNoaQj5c/
IiglOiZ9YT+ftCqHiN0QgCjtclc8bNkJSEeppMQ3inqL8KaX1dFiWNDEh5K9cf9i
Cxf08LfUpPoOwOk+6RF1VW0yQdZacHK3xX86CZ0VMQDup19M9j6215aDXu5ETbgd
hFBYzOVC30uEDKwy9pMSnX3CzNGemeM+txiifOXrG81GG4Kr8KIUyI4hASjyCAjL
C7+wi7Rqwre33dlIBm1j311jvNNstDnDgQ9M2hB69UaqkR8G+JYCOns6El2zVlvC
OZTXta/hp95wlaWe+R2oDvlq13uW/YxeUuEJrei7lv/uo/BBPt2Zt0X59FXFyLgu
4ak4iKkiRIN0Y6C60bfKyVnwOyZtFMayXrBmX/aU4g0a1R5KvhdLbwjTenRf8Vvr
ofx32t5U/vQAoNOqkG/SXlBMI7o9EWwWCdyeZf+WQX0Yv4oYMMOmOVGDt31Q6ZF2
TV/ym+lI8yByhITFsz6aN/Sa1mR/tL+aDS60SnaQqMN2KQ9PE+8=
=gppS
-----END PGP SIGNATURE-----

--fsmcoqawoulo7k6m--
