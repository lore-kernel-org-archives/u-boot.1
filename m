Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18489E7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F41E86DC7;
	Wed, 27 Sep 2023 04:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GaXB/8x/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D3486DC6; Wed, 27 Sep 2023 04:50:15 +0200 (CEST)
Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com
 [45.254.49.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C159680282
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GaXB/8x/WKLmLVmsGOmUc4j3tPWNheWDw0iABA2UhUUw8/rfKgkRmaIIzITcQXkq798sc5qwzf/SJnjKtW9mzaJUTAMox9b9/b3buFdm/Vlna0irm6ZIk5pIRgP/JGca6jFB3g13DpaPT6cSzGON/HpQrLP3BI8ox54MnunOXXI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=7qcxn42pJb6zLA4yLfKYmrM8VXITbJ18bubNGp5dE7E=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 2F4D0400284;
 Wed, 27 Sep 2023 10:50:01 +0800 (CST)
Message-ID: <21669b38-b757-5522-7885-8ea898eaebf8@rock-chips.com>
Date: Wed, 27 Sep 2023 10:50:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] rockchip: Port IO-domain driver for RK3568 from
 linux
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jianqun Xu <jay.xu@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
 <20230821223020.3918620-5-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230821223020.3918620-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh8aS1ZDTExPGkkdTUweSRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad48b1d362eb3kusn2f4d0400284
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6KQw*LTw0MjZRFT08C0M2
 Ak4wCyJVSlVKTUJOTENIS0tKQkxLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDQk9CNwY+
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


On 2023/8/22 06:30, Jonas Karlman wrote:
> Port the Rockchip IO-domain driver for RK3568 from linux.
>
> The driver auto probe after bind to configure IO-domain based on the
> regulator voltage. Compared to the linux driver this driver is not
> notified about regulator voltage changes and only configure IO-domain
> based on the initial voltage autoset by the regulator.
>
> It is not recommended to enable MMC_IO_VOLTAGE or the mmc signal voltage
> and IO-domain may end up out of sync.
>
> Based on the linux commit 28b05a64e47c ("soc: rockchip: io-domain: add
> rk3568 support").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Cc: Jianqun Xu <jay.xu@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Doug Anderson <dianders@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Add probe after bind comment
> - Drop parenthesis
> - Collect r-b tag
>
>   drivers/misc/Kconfig              |   9 ++
>   drivers/misc/Makefile             |   1 +
>   drivers/misc/rockchip-io-domain.c | 167 ++++++++++++++++++++++++++++++
>   3 files changed, 177 insertions(+)
>   create mode 100644 drivers/misc/rockchip-io-domain.c
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b9f5c7a37aed..d160ce693939 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -101,6 +101,15 @@ config ROCKCHIP_OTP
>   	  addressing and a length or through child-nodes that are generated
>   	  based on the e-fuse map retrieved from the DTS.
>   
> +config ROCKCHIP_IODOMAIN
> +	bool "Rockchip IO-domain driver support"
> +	depends on DM_REGULATOR && ARCH_ROCKCHIP
> +	default y if ROCKCHIP_RK3568
> +	help
> +	  Enable support for IO-domains in Rockchip SoCs. It is necessary
> +	  for the IO-domain setting of the SoC to match the voltage supplied
> +	  by the regulators.
> +
>   config SIFIVE_OTP
>   	bool "SiFive eMemory OTP driver"
>   	depends on MISC
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index fd8805f34bd9..b67b82358a6c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
>   endif
>   obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
>   obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o
> +obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
>   obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
>   obj-$(CONFIG_SIFIVE_OTP) += sifive-otp.o
>   obj-$(CONFIG_SMSC_LPC47M) += smsc_lpc47m.o
> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
> new file mode 100644
> index 000000000000..3f6227f993f9
> --- /dev/null
> +++ b/drivers/misc/rockchip-io-domain.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip IO Voltage Domain driver
> + *
> + * Ported from linux drivers/soc/rockchip/io-domain.c
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <power/regulator.h>
> +
> +#define MAX_SUPPLIES		16
> +
> +/*
> + * The max voltage for 1.8V and 3.3V come from the Rockchip datasheet under
> + * "Recommended Operating Conditions" for "Digital GPIO".   When the typical
> + * is 3.3V the max is 3.6V.  When the typical is 1.8V the max is 1.98V.
> + *
> + * They are used like this:
> + * - If the voltage on a rail is above the "1.8" voltage (1.98V) we'll tell the
> + *   SoC we're at 3.3.
> + * - If the voltage on a rail is above the "3.3" voltage (3.6V) we'll consider
> + *   that to be an error.
> + */
> +#define MAX_VOLTAGE_1_8		1980000
> +#define MAX_VOLTAGE_3_3		3600000
> +
> +#define RK3568_PMU_GRF_IO_VSEL0		0x0140
> +#define RK3568_PMU_GRF_IO_VSEL1		0x0144
> +#define RK3568_PMU_GRF_IO_VSEL2		0x0148
> +
> +struct rockchip_iodomain_soc_data {
> +	int grf_offset;
> +	const char *supply_names[MAX_SUPPLIES];
> +	int (*write)(struct regmap *grf, int idx, int uV);
> +};
> +
> +static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
> +{
> +	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
> +	u32 val0, val1;
> +	int b;
> +
> +	switch (idx) {
> +	case 0: /* pmuio1 */
> +		break;
> +	case 1: /* pmuio2 */
> +		b = idx;
> +		val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
> +		b = idx + 4;
> +		val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
> +
> +		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL2, val0);
> +		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL2, val1);
> +		break;
> +	case 3: /* vccio2 */
> +		break;
> +	case 2: /* vccio1 */
> +	case 4: /* vccio3 */
> +	case 5: /* vccio4 */
> +	case 6: /* vccio5 */
> +	case 7: /* vccio6 */
> +	case 8: /* vccio7 */
> +		b = idx - 1;
> +		val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
> +		val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
> +
> +		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL0, val0);
> +		regmap_write(grf, RK3568_PMU_GRF_IO_VSEL1, val1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
> +	.grf_offset = 0x140,
> +	.supply_names = {
> +		NULL,
> +		"pmuio2-supply",
> +		"vccio1-supply",
> +		NULL,
> +		"vccio3-supply",
> +		"vccio4-supply",
> +		"vccio5-supply",
> +		"vccio6-supply",
> +		"vccio7-supply",
> +	},
> +	.write = rk3568_iodomain_write,
> +};
> +
> +static const struct udevice_id rockchip_iodomain_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3568-pmu-io-voltage-domain",
> +		.data = (ulong)&soc_data_rk3568_pmu,
> +	},
> +	{ }
> +};
> +
> +static int rockchip_iodomain_bind(struct udevice *dev)
> +{
> +	/*
> +	 * According to the Hardware Design Guide, IO-domain configuration must
> +	 * be consistent with the power supply voltage (1.8V or 3.3V).
> +	 * Probe after bind to configure IO-domain voltage early during boot.
> +	 */
> +	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
> +	return 0;
> +}
> +
> +static int rockchip_iodomain_probe(struct udevice *dev)
> +{
> +	struct rockchip_iodomain_soc_data *soc_data =
> +		(struct rockchip_iodomain_soc_data *)dev_get_driver_data(dev);
> +	struct regmap *grf;
> +	int ret;
> +
> +	grf = syscon_get_regmap(dev_get_parent(dev));
> +	if (IS_ERR(grf))
> +		return PTR_ERR(grf);
> +
> +	for (int i = 0; i < MAX_SUPPLIES; i++) {
> +		const char *supply_name = soc_data->supply_names[i];
> +		struct udevice *reg;
> +		int uV;
> +
> +		if (!supply_name)
> +			continue;
> +
> +		ret = device_get_supply_regulator(dev, supply_name, &reg);
> +		if (ret)
> +			continue;
> +
> +		ret = regulator_autoset(reg);
> +		if (ret && ret != -EALREADY && ret != -EMEDIUMTYPE &&
> +		    ret != -ENOSYS)
> +			continue;
> +
> +		uV = regulator_get_value(reg);
> +		if (uV <= 0)
> +			continue;
> +
> +		if (uV > MAX_VOLTAGE_3_3) {
> +			dev_crit(dev, "%s: %d uV is too high. May damage SoC!\n",
> +				 supply_name, uV);
> +			continue;
> +		}
> +
> +		soc_data->write(grf, i, uV);
> +	}
> +
> +	return 0;
> +}
> +
> +U_BOOT_DRIVER(rockchip_iodomain) = {
> +	.name = "rockchip_iodomain",
> +	.id = UCLASS_NOP,
> +	.of_match = rockchip_iodomain_ids,
> +	.bind = rockchip_iodomain_bind,
> +	.probe = rockchip_iodomain_probe,
> +};
