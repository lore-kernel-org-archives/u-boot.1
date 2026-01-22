Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3153D3EE66
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B494B83B63;
	Thu, 22 Jan 2026 14:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jZlGN5b0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988C0839DF; Thu, 22 Jan 2026 11:31:24 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1901A80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.ferraris@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1769077881;
 bh=H9RMENPOah7H/Z2kycRsnkBVDnbMJaUxfTix+5/clGA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jZlGN5b0b5Pl+BvDcP+cY7IMAGhvgkCF2ZEX/yEwUuKwiYKPCzlanMw4smg+bgfKE
 he3uZBv+YMRUv3JGCS4/79aK3RKx+YIuNt3bdmaOKHPBUTg2MGWr+kFRSverdmCXAE
 QR6y9+S8GkG/V8nDmigxIk3RsXUopuslyxOfiYeLr0LOufkkx860kjJsYatD7pE9eW
 rVL1A+G32HpJJth8BzUjnO07LT+y+fICmylvBAzj185IwnDKrv254kTBr6R1Oiu8QQ
 e5LhtpKD8ThgsQoYBnLbuGfPrtIeZ1mMLob7ZOTBogTumU4a/kO2ItCPmXP6TYoO+0
 fgsZEDN9l9qSw==
Received: from [IPV6:2a01:e0a:212:79f0:be92:a52a:153f:7a60] (unknown
 [IPv6:2a01:e0a:212:79f0:be92:a52a:153f:7a60])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E50D17E139A;
 Thu, 22 Jan 2026 11:31:20 +0100 (CET)
Message-ID: <4d00b4aa-16bb-4bba-b780-207f8b9d3967@collabora.com>
Date: Thu, 22 Jan 2026 11:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] phy: Add MediaTek UFS PHY Driver
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Minkyu Kang
 <mk7.kang@samsung.com>, Tim Harvey <tharvey@gateworks.com>,
 Roger Quadros <rogerq@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
References: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
 <20251011-mtk-ufs-uboot-v1-1-a05f991ee150@mentallysanemainliners.org>
Content-Language: en-US
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Autocrypt: addr=arnaud.ferraris@collabora.com; keydata=
 xsFNBF6V3oEBEADExzr1s9YngScJ0KNMGen7k3cH1sn0h7tf7AFlXA94jXBgFyzIMT5lqey0
 9LwcO6AIkFF+gRVAKIblkeacsy5W6OQXgdFMitx936oAcU0XYQ2X5NxCQHzEsWYzkLIZnFTB
 Ur3CW9HtAjAircED5KVJzA1GM8BEFfG3LoonWsw0CO9UN2arwT1uLARSPgL6LPpmo1IOSwJh
 D6vtOyzlRrLkw4KHzUobEiIjxzjXttH8TC3I6OSb8kavG08cmA+DMf/nLFxK0QbdOP2wSZ0w
 UTU6RBikuLmDBaT4PphuwtAgVwhO9l0PNRoYzugrXuRF0RCLpmJN05tz/o/w7Y8ieLgQE8Om
 xGKXJyo0T4wlUl9ARM9Y0ZIRhdI1alFspBcF63oyZmOAT+2fPLr6W0fEfmtMBhDaZun2ZdKR
 M1JwTTkh8jVLs3svM3Ch2JjiH0kgYA0oza5fXaB9s4Fa4fxpmacx8fawKR5r/BhmYNK15PPd
 YxIZJqnTJgCDI2G4tQ9K+Eev1rBo6i8n96rDqxTxdyQixMhxMmGtj6/bknpVIN947ABKDHdt
 UsWa4E+qwFrYDXT7RxhL+JGn4VrtIR1kpTJHfmVXnn+RW7JKdDkalvEuXJSOArszcgpDlYRq
 +ZT/ybdcmdtuz8+Ev0fig/9WdPBHwg5oKDlT6+iN0oISAzoFSQARAQABzS9Bcm5hdWQgRmVy
 cmFyaXMgPGFybmF1ZC5mZXJyYXJpc0Bjb2xsYWJvcmEuY29tPsLBlAQTAQgAPgIbAwULCQgH
 AwUVCgkICwUWAgMBAAIeAQIXgBYhBHlts5PcP/QCIrbqItPrtZZruZGWBQJlp4UlBQkMOAKk
 AAoJENPrtZZruZGW/jsP/iY7xHszgSsLpmm/Nei09de28i5+KQgOfOFPEIUwY6e+SJDlc0CN
 5wBEGsiehI+ntDyYXjaQaWzwZbZ+iclSvZpINyekIeYFgfCwfraXMQ2rf0Hl1msu5BGZs7nz
 w9aQyNKRaS7mkMQlUKZAjV/rqmdrYyQX2b05Pznc/tI8Qj+QDnE097smlqwcPsCLMFjvEpdy
 t1iVfqM7rlEjCZR+agb/amAdG9FYDHuUaqhewgB/jVTnA7m19QI1hGDVhZ3pI7DFFQC5+Q7m
 4E7snHk9mdnzQKZO+w6DBjRgnRBtiifzlbb3UqTv6yZgVqrL3ENedco7Y1umVyXoqT4nz5SZ
 2CdWaEJx00JDQP/P1Fc4KBj40DrKScib2ZzIXVpzej4Ab2S0Kq7UuS/8fPA8Z7wUwPs4AXrb
 KZ3pNnh0t5uAWS3sh7IRTvEBquwa9F129EB2HoalJl+fpSJz0qTCTknrPkMY9KhRcXH43CjX
 mvvSaqkFs2R0jO01tZBpWUlyfQoJgrqMw4A+EcmjLg2NeVgRNrPaH2hPtdBegcAdKqc6nuBa
 HZ8m01cVCQw6hC3rceWBx42GeFt8F4we8LzbAbfo67hXASyWBRHfzt84zoPOy25mpNaIJB/u
 7/bO+63d64NxuRlZiLvGZxABTpLI2pBKeZFwnFMkh4aMvS9P4ymdPdGIzsFNBF6V3oEBEAC2
 wPaxEIKrqMR3f58Tj2j/fIaTxzqv5g449HN5+mkMzl05fNtlkWMpxDQhMPKaNDYgayaVBujP
 GSr0x3Na3nf7olOF1MWe396vhhHsOgsCglpdpZnOu6VBfUBjUnwtFr0GldBfGKsFQcC5/lOo
 FFLF6mUJgvXhfBEcaFkqBXjndRSIYI/6Jo3ryTbUZGuorOVlC97RZEZYOS8detm/MPyuoXMN
 Wp+UKXMrHe9b6+GW0r1qtoP9arCS0wVsE6pFsUnAXtjre4tsFf6CZIBZG9+JsQpHuk4ooeac
 hYKnYu+KN4cxbjozheeRQmLCcis6sZ3OnlwEroYKKzH88sAOJRSSlF2DtuyqEHJkzuhZxauR
 Qr1IV1zYQxVTncga7Qv18mOBhvQUoZHMbZUlKMlPgvEofzvim6mKWuMa7wrZEYpmwu4O+hv0
 cJiddomrfqjVJVXYOPL7Wln6B+2MSzx7tlkErGOzRqnaFURh4ozFj5MI/p4aFSjVnwvhm8bW
 ha26I4pEV2uwSiDWPuUN4DBwbic5HRB5/zM5tdKJ1k95NXAMShtdIR5095fc+4RgDYXWlSk4
 GO30TrRq79jWvwZM4Zi1UzdzQoQKx4CerOqKHsr2JgAcYhMZ2iIJeLanxfMhKPXm7gZSMBM9
 RbR+LbURmbUuBltRveD1u+W0u/hYoVk5jwARAQABwsF2BBgBCAAgAhsMFiEEeW2zk9w/9AIi
 tuoi0+u1lmu5kZYFAmWnhAkACgkQ0+u1lmu5kZbj+A//WQWE3YEn1aAXyb89DYEWALeASiWX
 a1PMAZRP5sYtpzBUwL8Ch9VRrb08eipZg8NvYfPoPUCgGOcn+ZCp/4xT+LbmLQ6Bt90i8LPP
 liNlPLpkmBK57CXfD6f/0ntwRbNmEBoJGUpEe4mDVEHlle+RQO4aLxOjLcpTqocMc28vZp6u
 1ZRNP7YDq3OqUmUR5C3KxIGAPuqc8ODktRZaWKUHJBnvqzUEElVdDbKnSXtrQbG6oP84wabX
 Do8NPonMd2AY0ATKX1xVHf1C+xqdzcChd+NaxmJ4uGuMojRQa2y991wM1cep0eWr34W5dN7i
 AKo0yD8kNk73guU43PCFT5SJ20+LtbwLEN13MSvOxfLwf4/wy+OU1cCm1gN617D59Vym7nGo
 H2zdM9IA5dIALuLOksesRqzO8ZV8yD8q1WqpKwWpy32piEmW/2w1eEHsgRbsX68D8qO0ad0d
 67AW3CmTtpLg58/3CpBN7l2yQ55iqqQcHHhxJSAxGgzBQ4wyOau6q/1i17FCYoXfSQI0mJZx
 OSAczP+kGnkQKkgo4xMODyU3aWmCEFfDP1gxZlhPLbd0qR39h3do3bx5D16yF1mjm9r1GhKh
 OnYrUe4QH6N7K+DMJh0j7XIzQmwhEH26f2TUesr7deZEms4GGOyzREbD9y0UBYOIl8YHMdd9
 L9jD4jU=
In-Reply-To: <20251011-mtk-ufs-uboot-v1-1-a05f991ee150@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Jan 2026 14:41:52 +0100
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

Hi,

Le 11/10/2025 à 21:10, Igor Belwon a écrit :
> This UFS M-PHY driver can be used on recent MediaTek SoCs as the
> primary PHY for the UFS controller.
>
> Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
> ---
>   drivers/phy/Kconfig       |  10 +++
>   drivers/phy/Makefile      |   1 +
>   drivers/phy/phy-mtk-ufs.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 201 insertions(+)
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index d36a5f00ef83e3bd6f216181df1a70c848bb11d4..46d02931f3534a1c396e79ab26ed1e03f86398ec 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -281,6 +281,16 @@ config PHY_MTK_TPHY
>   	  multi-ports is first version, otherwise is second veriosn,
>   	  so you can easily distinguish them by banks layout.
>   
> +config PHY_MTK_UFS
> +	tristate "MediaTek UFS M-PHY driver"
> +	depends on ARCH_MEDIATEK
> +	depends on PHY
> +	help
> +	  Support for UFS M-PHY on MediaTek chipsets.
> +	  Enable this to provide vendor-specific probing,
> +	  initialization, power on and power off flow of
> +	  specified M-PHYs.
> +
>   config PHY_NPCM_USB
>   	bool "Nuvoton NPCM USB PHY support"
>   	depends on PHY
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 98c1ef8683b7354ccb43426f32ba4dd2f2fcf6c6..8c1bcf72908135cf840d88caeee72bfd4b9270c5 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_MT76X8_USB_PHY) += mt76x8-usb-phy.o
>   obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
>   obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
>   obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
> +obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
>   obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
>   obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
>   obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
> diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1eda3df858d820fd6f080cac9d58492ce98f19ee
> --- /dev/null
> +++ b/drivers/phy/phy-mtk-ufs.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + * Author: Stanley Chu <stanley.chu@mediatek.com>
> + *
> + * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
> + */
> +
> +#include "dm/ofnode.h"
> +#include "dm/read.h"
> +#include <clk.h>
> +#include <dm.h>
> +#include <generic-phy.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +/* mphy register and offsets */
> +#define MP_GLB_DIG_8C               0x008C
> +#define FRC_PLL_ISO_EN              BIT(8)
> +#define PLL_ISO_EN                  BIT(9)
> +#define FRC_FRC_PWR_ON              BIT(10)
> +#define PLL_PWR_ON                  BIT(11)
> +
> +#define MP_LN_DIG_RX_9C             0xA09C
> +#define FSM_DIFZ_FRC                BIT(18)
> +
> +#define MP_LN_DIG_RX_AC             0xA0AC
> +#define FRC_RX_SQ_EN                BIT(0)
> +#define RX_SQ_EN                    BIT(1)
> +
> +#define MP_LN_RX_44                 0xB044
> +#define FRC_CDR_PWR_ON              BIT(17)
> +#define CDR_PWR_ON                  BIT(18)
> +#define FRC_CDR_ISO_EN              BIT(19)
> +#define CDR_ISO_EN                  BIT(20)
> +
> +#define UFSPHY_CLKS_CNT    2
> +
> +struct mtk_ufs_phy {
> +	struct udevice *dev;
> +	void __iomem *mmio;
> +
> +	struct clk *unipro_clk;
> +	struct clk *mp_clk;
> +};
> +
> +static void ufs_mtk_phy_set_active(struct mtk_ufs_phy *phy)
> +{
> +	/* release DA_MP_PLL_PWR_ON */
> +	setbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
> +	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
> +
> +	/* release DA_MP_PLL_ISO_EN */
> +	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
> +	clrbits_le32(phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
> +
> +	/* release DA_MP_CDR_PWR_ON */
> +	setbits_le32(phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
> +	clrbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
> +
> +	/* release DA_MP_CDR_ISO_EN */
> +	clrbits_le32(phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
> +	clrbits_le32(phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
> +
> +	/* release DA_MP_RX0_SQ_EN */
> +	setbits_le32(phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
> +	clrbits_le32(phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
> +
> +	/* delay 1us to wait DIFZ stable */
> +	udelay(1);
> +
> +	/* release DIFZ */
> +	clrbits_le32(phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
> +}
> +
> +static int mtk_phy_power_on(struct phy *phy)
> +{
> +	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
> +	int ret;
> +
> +	ret = clk_enable(ufs_phy->mp_clk);
> +	if (ret < 0) {
> +		dev_err(phy->dev, "failed to enable mp_clk\n");
> +		return ret;
> +	}
> +
> +	ret = clk_enable(ufs_phy->unipro_clk);
> +	if (ret < 0) {
> +		dev_err(phy->dev, "failed to enable unipro_clk %d\n", ret);
> +		clk_disable(ufs_phy->unipro_clk);
> +		return ret;
> +	}
> +
> +	ufs_mtk_phy_set_active(ufs_phy);
> +
> +	return 0;
> +}
> +
> +static int mtk_phy_power_off(struct phy *phy)
> +{
> +	struct mtk_ufs_phy *ufs_phy = dev_get_priv(phy->dev);
> +
> +	/* Set PHY to Deep Hibernate mode */
> +	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
> +
> +	/* force DA_MP_RX0_SQ_EN */
> +	setbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
> +	clrbits_le32(ufs_phy->mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
> +
> +	/* force DA_MP_CDR_ISO_EN */
> +	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
> +	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_ISO_EN);
> +
> +	/* force DA_MP_CDR_PWR_ON */
> +	setbits_le32(ufs_phy->mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
> +	clrbits_le32(ufs_phy->mmio + MP_LN_RX_44, CDR_PWR_ON);
> +
> +	/* force DA_MP_PLL_ISO_EN */
> +	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
> +	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
> +
> +	/* force DA_MP_PLL_PWR_ON */
> +	setbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
> +	clrbits_le32(ufs_phy->mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops mtk_ufs_phy_ops = {
> +	.power_on	= mtk_phy_power_on,
> +	.power_off	= mtk_phy_power_off,
> +};
> +
> +static int mtk_ufs_phy_probe(struct udevice *dev)
> +{
> +	struct mtk_ufs_phy *phy = dev_get_priv(dev);
> +	fdt_addr_t addr;
> +	int ret;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;

The above devm_kzalloc() should be dropped, as it overwrites "phy", 
which is already allocated by the priv_auto mechanism.
This eventually causes all sorts of error as you then fill in this newly 
allocated structure, but all other functions use the priv pointer, which 
contains only NULL values.

Best regards,
Arnaud

> +
> +	addr = dev_read_addr(dev);
> +	if (addr == FDT_ADDR_T_NONE)
> +		return -ENOMEM;
> +
> +	phy->dev = dev;
> +	phy->mmio = map_sysmem(addr, 0);
> +
> +	phy->mp_clk = devm_clk_get(dev, "mp");
> +	if (IS_ERR(phy->mp_clk)) {
> +		ret = PTR_ERR(phy->mp_clk);
> +		dev_err(dev, "Failed to get mp clock (ret=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	phy->unipro_clk = devm_clk_get(dev, "unipro");
> +	if (IS_ERR(phy->unipro_clk)) {
> +		ret = PTR_ERR(phy->unipro_clk);
> +		dev_err(dev, "Failed to get unipro clock (ret=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id mtk_ufs_phy_id_table[] = {
> +	{.compatible = "mediatek,mt8183-ufsphy"},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(mtk_ufs_phy) = {
> +	.name		= "mtk-ufs_phy",
> +	.id		= UCLASS_PHY,
> +	.of_match	= mtk_ufs_phy_id_table,
> +	.ops		= &mtk_ufs_phy_ops,
> +	.probe		= mtk_ufs_phy_probe,
> +	.priv_auto	= sizeof(struct mtk_ufs_phy),
> +};

