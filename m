Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B349E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 13:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB3D80104;
	Mon, 16 Dec 2024 14:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7764480141; Mon, 16 Dec 2024 14:40:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D22EC8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 14:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349BC113E;
 Mon, 16 Dec 2024 05:40:34 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B8E3F528;
 Mon, 16 Dec 2024 05:40:05 -0800 (PST)
Date: Mon, 16 Dec 2024 13:40:00 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "Marcin =?UTF-8?B?xZpsdXNhcno=?=" <marcin.slusarz@gmail.com>
Cc: u-boot@lists.denx.de, Marcin =?UTF-8?B?xZpsdXNhcno=?=
 <mslusarz@renau.com>, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] power: axp: sunxi: configure charge current
Message-ID: <20241216134000.1b9ceacd@donnerap.manchester.arm.com>
In-Reply-To: <20241127130419.50489-1-mslusarz@renau.com>
References: <20241127130419.50489-1-mslusarz@renau.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 27 Nov 2024 13:04:19 +0000
"Marcin =C5=9Alusarz" <marcin.slusarz@gmail.com> wrote:

Hi Marcin,

thanks for taking care of sending a mainline patch!

> Allows decreasing initial charge current, e.g. when power
> supply is too weak to support both charging and other operations.

Can you explain a bit more why and where you actually need that?

The problem I have with the code is that it's doing it in the SPL, where I
actually want to decrease any PMIC usage. We really only need the PMIC that
early to set the DRAM and CPU core voltage, everything else should be done
in either U-Boot proper or the kernel.

So how did this work before, and why it is a problem now? AXP221 points to
some older SoC, I guess?
Is it that you find yourself with a somewhat weak power supply, and if the
battery is discharged, there won't be enough power left for the system to
boot reliably?

Do you know of any existing DT property for instance that could limit the
charge current? Or is there a sysfs property only?

Cheers,
Andre

> Signed-off-by: Marcin =C5=9Alusarz <mslusarz@renau.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> ---
>  board/sunxi/board.c    |  4 ++++
>  drivers/power/Kconfig  |  7 +++++++
>  drivers/power/axp221.c | 33 +++++++++++++++++++++++++++++++++
>  include/axp221.h       |  3 +++
>  include/axp_pmic.h     |  1 +
>  5 files changed, 48 insertions(+)
>=20
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 824c322a0d..07fccf972a 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -623,6 +623,10 @@ void sunxi_board_init(void)
>  #if defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER
>  	power_failed |=3D axp_set_sw(IS_ENABLED(CONFIG_AXP_SW_ON));
>  #endif
> +
> +#ifdef CONFIG_AXP221_POWER
> +	power_failed |=3D axp221_set_charge_current(CONFIG_AXP221_CHARGE_CURREN=
T);
> +#endif
>  #endif	/* CONFIG_AXPxxx_POWER */
>  	printf("DRAM:");
>  	gd->ram_size =3D sunxi_dram_init();
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 4b81aeb749..06b509a383 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -142,6 +142,13 @@ config SY8106A_POWER
> =20
>  endchoice
> =20
> +config AXP221_CHARGE_CURRENT
> +	int "axp221 constant charge current in mA"
> +	depends on AXP221_POWER
> +	default 1200
> +	---help---
> +	Any value between 300 and 2100 in 150 increments, or 0 to disable charg=
ing.
> +
>  config AXP_DCDC1_VOLT
>  	int "axp pmic dcdc1 voltage"
>  	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
> diff --git a/drivers/power/axp221.c b/drivers/power/axp221.c
> index c22ca03f46..bf48585da0 100644
> --- a/drivers/power/axp221.c
> +++ b/drivers/power/axp221.c
> @@ -205,6 +205,39 @@ int axp_set_eldo(int eldo_num, unsigned int mvolt)
>  				AXP221_OUTPUT_CTRL2_ELDO1_EN << (eldo_num - 1));
>  }
> =20
> +static u8 axp221_mamp_to_cfg(int mamp, int min, int max, int div)
> +{
> +	if (mamp < min)
> +		mamp =3D min;
> +	else if (mamp > max)
> +		mamp =3D max;
> +
> +	return (mamp - min) / div;
> +}
> +
> +int axp221_set_charge_current(unsigned int mamp)
> +{
> +	int ret;
> +	u8 cfg, chrg_ctrl;
> +
> +	cfg =3D axp221_mamp_to_cfg(mamp, 300, 2100, 150);
> +	if (cfg > 0x0f)
> +		return -EINVAL;
> +
> +	ret =3D pmic_bus_read(AXP221_CHRG_CTRL1, &chrg_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	chrg_ctrl =3D (chrg_ctrl & 0xf0) | cfg;
> +
> +	if (mamp =3D=3D 0)
> +		chrg_ctrl &=3D 0x7f;
> +	else
> +		chrg_ctrl |=3D 0x80;
> +
> +	return pmic_bus_write(AXP221_CHRG_CTRL1, chrg_ctrl);
> +}
> +
>  int axp_init(void)
>  {
>  	u8 axp_chip_id;
> diff --git a/include/axp221.h b/include/axp221.h
> index 32b988f3a9..8eb1792435 100644
> --- a/include/axp221.h
> +++ b/include/axp221.h
> @@ -44,6 +44,9 @@
>  #define AXP221_ALDO3_CTRL	0x2a
>  #define AXP221_SHUTDOWN		0x32
>  #define AXP221_SHUTDOWN_POWEROFF	(1 << 7)
> +#define AXP221_CHRG_CTRL1	0x33
> +#define AXP221_CHRG_CTRL2	0x34
> +#define AXP221_CHRG_CTRL3	0x35
>  #define AXP221_PAGE		0xff
> =20
>  /* Page 1 addresses */
> diff --git a/include/axp_pmic.h b/include/axp_pmic.h
> index ae62ef0d76..3bcd8f9ca9 100644
> --- a/include/axp_pmic.h
> +++ b/include/axp_pmic.h
> @@ -52,6 +52,7 @@ int axp_set_aldo4(unsigned int mvolt);
>  int axp_set_dldo(int dldo_num, unsigned int mvolt);
>  int axp_set_eldo(int eldo_num, unsigned int mvolt);
>  int axp_set_fldo(int fldo_num, unsigned int mvolt);
> +int axp221_set_charge_current(unsigned int mamp);
>  int axp_set_sw(bool on);
>  int axp_init(void);
>  int axp_get_sid(unsigned int *sid);

