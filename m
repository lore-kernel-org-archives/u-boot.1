Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC4CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 21:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A1A849DF;
	Wed,  6 May 2026 23:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="zIXZH7Q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A494849E0; Wed,  6 May 2026 23:44:37 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4C7849C9
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 23:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-678a16429c6so245335a12.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778103874; x=1778708674;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xi1Cpq3dt4or5zsTgLefyBxEr2qPj3SGUwq/sKR43eo=;
 b=zIXZH7Q9HE1EpByu6TDByWuDl1efAswpx8OlDeD766KJOXN+aIyGiAKtW53YDkTigy
 SoLvUhQu3AweJ5JW/7hLzFd38BsBe+BnrJM6jUrtLwSVBMR7LcO/bmc6rsFiPP/XyjO+
 HXBDO0bB4KgLefzS7S3+pjvTGUY0w+ZcNg+I9non66Ctj0P00Mf4mlbzpYrYSIf3hUDh
 QrngMxtSfgofQ1LfkyDRCgviboljZndHn06vdrrzS26JO9P8RAtC6hJ/TQWxKALkmcKU
 zr3PwtL2Sxfx4W6LtQaAsiCecUJPhHkku3U2k9agx9zIqyKoJjTpyqH8Ap5VxReB5hIg
 lZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778103874; x=1778708674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xi1Cpq3dt4or5zsTgLefyBxEr2qPj3SGUwq/sKR43eo=;
 b=bsyjOP95eEqzPm4CEzTXn1EsPfjH+EUy6UQYgItjqPYqe/2AFFPKoKV/9wTK0Qxea/
 x2Uvz+zeCyVbM6zy2pashJeIg1GivhAbwbvCxv1aTZrPkBR350TU/lA3WuBnQ6+Dwx6M
 axDPmwVTy2soOF1UScrSp+tHtSIhQ7GUFXckix0q8h5d3bSTak5+2hGL2Tji5S9ycbPy
 NH/WzA+dcF9qU+EHKKhb6NzzZVb6vDmpOF788C6SpLCqZbc8Gg66iHja+/ejyJXxL8ad
 Lgu5bf1YR0kMHkiexUsDWmN6BTsZVQOJiXO0b2SHuU2YnnKDn3EnBOp02y8X6HsnSqAP
 uirw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CciYqcDNCEyJW+P7BomOq2ndSF/Akas405IAOFE9nji3OsO3sVermUxCvHODe0G8mQhhlUuE=@lists.denx.de
X-Gm-Message-State: AOJu0YzSzRoUmJC1nlHGtu0XMTvrbmRkPiuvFTkY+P2wopnmKbNFhVDW
 gUK5d05NVPZdq4VM/AunzDUVdgweBs1qMuf3/Oap9HX2aDHPUEB6FVl9JqIXqOxGhR4=
X-Gm-Gg: AeBDiev2t1riZAuQClxGoZhLRK55wnPsx6ZE345uB+IzychN/oDjF0xSzz2v2zlgCpc
 DGnCH3QWmnSj1pcaF4BcQjSGjMoWYV9UUVSHcNaJKympP8u7j3ii958j2AfB+QQlfQdkenjxim1
 6nfFSpkZITj3/uP9ZXdbHlyH2TN/t2SajhuB4YCxLMlAk1vPnV1/lZQq68TLKNsH94ifwo+h9X2
 gfEcZCG0pw2OEWvDlZhIU7mbHaSVejPtV/yPr3rnpIRa8yu+/gTIHJDOWkDoxeFDLTUTKDqN269
 9kja9i7fasANP2TGjFYyU0XDvG6UwwQCm77k2G/J3aNc24LwW2iapdbTgYxUwofXl5TsUJfwNBo
 iLD1Exbpl+EjSlPynVcnlenan1pH9bjvhf0h6EPY/iOQx7vITFRAMlaMmBdIz46QhRghFOwI/WK
 WIrBub/Te2sJo1F47iLCiKkJJwqtmtZaTp/CSXSX6RXAWzbjK0dzhz/ZgmuRJYP8FOfiF0EzaO8
 Ikp36eHvHqX
X-Received: by 2002:a05:6402:35d1:b0:67c:800c:d6a5 with SMTP id
 4fb4d7f45d1cf-67e0ddf045amr150126a12.1.1778103873966; 
 Wed, 06 May 2026 14:44:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7374:f02e:e8be:88a5?
 ([2600:8803:e7e4:500:7374:f02e:e8be:88a5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67cd91bc3d2sm1611744a12.22.2026.05.06.14.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 14:44:33 -0700 (PDT)
Message-ID: <63eb62e7-f301-470f-9524-c261c85dfbd9@baylibre.com>
Date: Wed, 6 May 2026 16:44:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Sean Anderson <sean.anderson@linux.dev>,
 Yao Zi <me@ziyao.cc>, Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
 <20260504130306.2764862-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260504130306.2764862-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/4/26 8:03 AM, Mikhail Kshevetskiy wrote:
> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/pinctrl/airoha/Kconfig          |    5 +
>  drivers/pinctrl/airoha/Makefile         |    2 +
>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1074 +++++++++++++++++++++++
>  3 files changed, 1081 insertions(+)
>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
> 
> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
> index eb87afbb374..986d23c2e3d 100644
> --- a/drivers/pinctrl/airoha/Kconfig
> +++ b/drivers/pinctrl/airoha/Kconfig
> @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
>  	select REGMAP
>  	select SYSCON
>  	bool
> +
> +config PINCTRL_AIROHA_AN7581
> +	tristate "AN7581 pin controller and gpio driver"
> +	depends on TARGET_AN7581
> +	select PINCTRL_AIROHA
> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
> index a25b744dd7a..909bd9a04d9 100644
> --- a/drivers/pinctrl/airoha/Makefile
> +++ b/drivers/pinctrl/airoha/Makefile
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
> +
> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
> new file mode 100644
> index 00000000000..2505818251c
> --- /dev/null
> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
> @@ -0,0 +1,1074 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> + * Author: Markus Gothe <markus.gothe@genexis.eu>
> + */
> +#include "airoha-common.h"
> +

The en7581_ prefix doesn't match the file name or Kconfig. Did you
mean to use an7581_ everywhere?

> +static const int en7581_pon_pins[] = { 49, 50, 51, 52, 53, 54 };
> +static const int en7581_pon_tod_1pps_pins[] = { 46 };
> +static const int en7581_gsw_tod_1pps_pins[] = { 46 };
> +static const int en7581_sipo_pins[] = { 16, 17 };
> +static const int en7581_sipo_rclk_pins[] = { 16, 17, 43 };
> +static const int en7581_mdio_pins[] = { 14, 15 };
> +static const int en7581_uart2_pins[] = { 48, 55 };
> +static const int en7581_uart2_cts_rts_pins[] = { 46, 47 };
> +static const int en7581_hsuart_pins[] = { 28, 29 };
> +static const int en7581_hsuart_cts_rts_pins[] = { 26, 27 };
> +static const int en7581_uart4_pins[] = { 38, 39 };
> +static const int en7581_uart5_pins[] = { 18, 19 };
> +static const int en7581_i2c0_pins[] = { 2, 3 };
> +static const int en7581_i2c1_pins[] = { 14, 15 };
> +static const int en7581_jtag_udi_pins[] = { 16, 17, 18, 19, 20 };
> +static const int en7581_jtag_dfd_pins[] = { 16, 17, 18, 19, 20 };
> +static const int en7581_i2s_pins[] = { 26, 27, 28, 29 };
> +static const int en7581_pcm1_pins[] = { 22, 23, 24, 25 };
> +static const int en7581_pcm2_pins[] = { 18, 19, 20, 21 };
> +static const int en7581_spi_quad_pins[] = { 32, 33 };
> +static const int en7581_spi_pins[] = { 4, 5, 6, 7 };
> +static const int en7581_spi_cs1_pins[] = { 34 };
> +static const int en7581_pcm_spi_pins[] = { 18, 19, 20, 21, 22, 23, 24, 25 };
> +static const int en7581_pcm_spi_int_pins[] = { 14 };
> +static const int en7581_pcm_spi_rst_pins[] = { 15 };
> +static const int en7581_pcm_spi_cs1_pins[] = { 43 };
> +static const int en7581_pcm_spi_cs2_pins[] = { 40 };
> +static const int en7581_pcm_spi_cs2_p128_pins[] = { 40 };
> +static const int en7581_pcm_spi_cs2_p156_pins[] = { 40 };
> +static const int en7581_pcm_spi_cs3_pins[] = { 41 };
> +static const int en7581_pcm_spi_cs4_pins[] = { 42 };
> +static const int en7581_emmc_pins[] = {
> +	4, 5, 6, 30, 31, 32, 33, 34, 35, 36, 37
> +};
> +static const int en7581_pnand_pins[] = {
> +	4, 5, 6, 7, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42
> +};
> +static const int en7581_gpio0_pins[] = { 13 };
> +static const int en7581_gpio1_pins[] = { 14 };
> +static const int en7581_gpio2_pins[] = { 15 };
> +static const int en7581_gpio3_pins[] = { 16 };
> +static const int en7581_gpio4_pins[] = { 17 };
> +static const int en7581_gpio5_pins[] = { 18 };
> +static const int en7581_gpio6_pins[] = { 19 };
> +static const int en7581_gpio7_pins[] = { 20 };
> +static const int en7581_gpio8_pins[] = { 21 };
> +static const int en7581_gpio9_pins[] = { 22 };
> +static const int en7581_gpio10_pins[] = { 23 };
> +static const int en7581_gpio11_pins[] = { 24 };
> +static const int en7581_gpio12_pins[] = { 25 };
> +static const int en7581_gpio13_pins[] = { 26 };
> +static const int en7581_gpio14_pins[] = { 27 };
> +static const int en7581_gpio15_pins[] = { 28 };
> +static const int en7581_gpio16_pins[] = { 29 };
> +static const int en7581_gpio17_pins[] = { 30 };
> +static const int en7581_gpio18_pins[] = { 31 };
> +static const int en7581_gpio19_pins[] = { 32 };
> +static const int en7581_gpio20_pins[] = { 33 };
> +static const int en7581_gpio21_pins[] = { 34 };
> +static const int en7581_gpio22_pins[] = { 35 };
> +static const int en7581_gpio23_pins[] = { 36 };
> +static const int en7581_gpio24_pins[] = { 37 };
> +static const int en7581_gpio25_pins[] = { 38 };
> +static const int en7581_gpio26_pins[] = { 39 };
> +static const int en7581_gpio27_pins[] = { 40 };
> +static const int en7581_gpio28_pins[] = { 41 };
> +static const int en7581_gpio29_pins[] = { 42 };
> +static const int en7581_gpio30_pins[] = { 43 };
> +static const int en7581_gpio31_pins[] = { 44 };

No gpio32?

> +static const int en7581_gpio33_pins[] = { 46 };
> +static const int en7581_gpio34_pins[] = { 47 };
> +static const int en7581_gpio35_pins[] = { 48 };
> +static const int en7581_gpio36_pins[] = { 49 };
> +static const int en7581_gpio37_pins[] = { 50 };
> +static const int en7581_gpio38_pins[] = { 51 };
> +static const int en7581_gpio39_pins[] = { 52 };
> +static const int en7581_gpio40_pins[] = { 53 };
> +static const int en7581_gpio41_pins[] = { 54 };
> +static const int en7581_gpio42_pins[] = { 55 };
> +static const int en7581_gpio43_pins[] = { 56 };
> +static const int en7581_gpio44_pins[] = { 57 };
> +static const int en7581_gpio45_pins[] = { 58 };
> +static const int en7581_gpio46_pins[] = { 59 };
> +static const int en7581_pcie_reset0_pins[] = { 61 };
> +static const int en7581_pcie_reset1_pins[] = { 62 };
> +static const int en7581_pcie_reset2_pins[] = { 63 };
> +
