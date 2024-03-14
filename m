Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7584AC54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8593A87E1C;
	Thu, 14 Mar 2024 01:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E1+T0WG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71ECA87ED1; Thu, 14 Mar 2024 01:37:31 +0100 (CET)
Received: from mail-m24125.xmail.ntesmail.com (mail-m24125.xmail.ntesmail.com
 [45.195.24.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82B887E1C
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=E1+T0WG5RT/hbfHFrt4+10RCyvowfv0IMH1xgRj1OjjrHraE+bBJKU8+TUhTZLMuqnjn9/WaS+iSG5Lj8XDi6T/udEpwetnSoIYKNsM6Qj2evP4+8e2jVzi84GuyFBC6s1XmLnsYlykfbeiv56nu15MwX66syTE/kuJ3dq/NwLs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=SO9vxBLKny1U/HdQTgkxlwo2193D8zIFH0m0T+8H4Bs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 19AA8900154;
 Thu, 14 Mar 2024 08:37:11 +0800 (CST)
Message-ID: <483a4f0c-84d0-41e3-90fe-69c5c718530c@rock-chips.com>
Date: Thu, 14 Mar 2024 08:37:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] power: rk8xx: add support for RK806
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-5-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-5-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgZSFYYTh9CTENIHk1ITEtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3a643d3703a9kunm19aa8900154
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6HCo4GTMOEig0LjA*CzNK
 IipPCjxVSlVKTEpLSExNTUhJSUpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkhOQzcG
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

Hi Quentin,

     This patch build fail in CI:

Building current source for 1 boards (1 thread, 32 jobs per thread)
    sandbox:  +   sandbox64
+drivers/power/pmic/rk8xx.c:141:10: error: implicit truncation from 
'int' to a one-bit wide bit-field changes value from 1 to -1 
[-Werror,-Wsingle-bit-bitfield-constant-conversion]
+                        .op = 1,
+                              ^
+1 error generated.
+make[4]: *** [scripts/Makefile.build:256: drivers/power/pmic/rk8xx.o] 
Error 1
+make[3]: *** [scripts/Makefile.build:397: drivers/power/pmic] Error 2
+make[2]: *** [scripts/Makefile.build:397: drivers/power] Error 2
+make[1]: *** [Makefile:1887: drivers] Error 2
+make: *** [Makefile:177: sub-make] Error 2
     0    0    1 /1              sandbox64

Thanks,

- Kever

On 2024/3/4 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> This adds support for RK806, only the SPI variant has been tested.
>
> The communication "protocol" over SPI is the following:
>   - write three bytes:
>     - 1 byte: [0:3] length of the payload, [6] Enable CRC, [7] Write
>     - 1 byte: LSB register address
>     - 1 byte: MSB register address
>   - write/read length of payload
>
> The CRC is always disabled for now.
>
> The RK806 technically supports I2C as well, and this should be able to
> support it without any change, but it wasn't tested.
>
> The DT node name prefix for the buck converters has changed in the
> Device Tree and is now dcdc-reg. The logic for buck converters is
> however manageable within the current logic inside the rk8xx regulator
> driver. The same cannot be said for the NLDO and PLDO.
>
> Because pmic_bind_children() parses the DT nodes and extracts the LDO
> index from the DT node name, NLDO and PLDO will have overlapping
> indices. Therefore, we need a separate logic from the already-existing
> ldo callbacks. Let's reuse as much as possible though.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>   drivers/power/pmic/rk8xx.c      |  91 +++++++
>   drivers/power/regulator/rk8xx.c | 514 +++++++++++++++++++++++++++++++++++++++-
>   include/power/rk8xx_pmic.h      |  19 ++
>   3 files changed, 622 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 4e3a17337ee..82b5e0cbe32 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -9,8 +9,10 @@
>   #include <dm/lists.h>
>   #include <errno.h>
>   #include <log.h>
> +#include <linux/bitfield.h>
>   #include <power/rk8xx_pmic.h>
>   #include <power/pmic.h>
> +#include <spi.h>
>   #include <sysreset.h>
>   
>   static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
> @@ -32,6 +34,10 @@ static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
>   		pmic_clrsetbits(dev->parent, RK817_REG_SYS_CFG3, 0,
>   				BIT(0));
>   		break;
> +	case RK806_ID:
> +		pmic_clrsetbits(dev->parent, RK806_REG_SYS_CFG3, 0,
> +				BIT(0));
> +		break;
>   	default:
>   		printf("Unknown PMIC RK%x: Cannot shutdown\n",
>   		       priv->variant);
> @@ -83,6 +89,11 @@ void rk8xx_off_for_plugin(struct udevice *dev)
>   	}
>   }
>   
> +static struct reg_data rk806_init_reg[] = {
> +	/* RST_FUN */
> +	{ RK806_REG_SYS_CFG3, GENMASK(7, 6), BIT(7)},
> +};
> +
>   static struct reg_data rk817_init_reg[] = {
>   /* enable the under-voltage protection,
>    * the under-voltage protection will shutdown the LDO3 and reset the PMIC
> @@ -92,7 +103,10 @@ static struct reg_data rk817_init_reg[] = {
>   
>   static const struct pmic_child_info pmic_children_info[] = {
>   	{ .prefix = "DCDC_REG", .driver = "rk8xx_buck"},
> +	{ .prefix = "dcdc-reg", .driver = "rk8xx_buck"},
>   	{ .prefix = "LDO_REG", .driver = "rk8xx_ldo"},
> +	{ .prefix = "nldo-reg", .driver = "rk8xx_nldo"},
> +	{ .prefix = "pldo-reg", .driver = "rk8xx_pldo"},
>   	{ .prefix = "SWITCH_REG", .driver = "rk8xx_switch"},
>   	{ },
>   };
> @@ -102,11 +116,51 @@ static int rk8xx_reg_count(struct udevice *dev)
>   	return RK808_NUM_OF_REGS;
>   }
>   
> +#if CONFIG_IS_ENABLED(SPI) && CONFIG_IS_ENABLED(DM_SPI)
> +struct rk806_cmd {
> +	char	len: 4; /* Payload size in bytes - 1 */
> +	char	reserved: 2;
> +	char	crc_en: 1;
> +	char	op: 1; /* READ=0; WRITE=1; */
> +	char	reg_l;
> +#define REG_L_MASK	GENMASK(7, 0)
> +	char	reg_h;
> +#define REG_H_MASK	GENMASK(15, 8)
> +};
> +#endif
> +
>   static int rk8xx_write(struct udevice *dev, uint reg, const uint8_t *buff,
>   			  int len)
>   {
>   	int ret;
>   
> +#if CONFIG_IS_ENABLED(SPI) && CONFIG_IS_ENABLED(DM_SPI)
> +	if (device_get_uclass_id(dev->parent) == UCLASS_SPI) {
> +		struct spi_slave *spi = dev_get_parent_priv(dev);
> +		struct rk806_cmd cmd = {
> +			.op = 1,
> +			.len = len - 1,
> +			.reg_l = FIELD_GET(REG_L_MASK, reg),
> +			.reg_h = FIELD_GET(REG_H_MASK, reg),
> +		};
> +
> +		ret = dm_spi_claim_bus(dev);
> +		if (ret) {
> +			debug("Couldn't claim bus for device: %p!\n", dev);
> +			return ret;
> +		}
> +
> +		ret = spi_write_then_read(spi, (u8 *)&cmd, sizeof(cmd), buff, NULL, len);
> +		if (ret)
> +			debug("write error to device: %p register: %#x!\n",
> +			      dev, reg);
> +
> +		dm_spi_release_bus(dev);
> +
> +		return ret;
> +	}
> +#endif
> +
>   	ret = dm_i2c_write(dev, reg, buff, len);
>   	if (ret) {
>   		debug("write error to device: %p register: %#x!\n", dev, reg);
> @@ -120,6 +174,33 @@ static int rk8xx_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>   {
>   	int ret;
>   
> +#if CONFIG_IS_ENABLED(SPI) && CONFIG_IS_ENABLED(DM_SPI)
> +	if (device_get_uclass_id(dev->parent) == UCLASS_SPI) {
> +		struct spi_slave *spi = dev_get_parent_priv(dev);
> +		struct rk806_cmd cmd = {
> +			.op = 0,
> +			.len = len - 1,
> +			.reg_l = FIELD_GET(REG_L_MASK, reg),
> +			.reg_h = FIELD_GET(REG_H_MASK, reg),
> +		};
> +
> +		ret = dm_spi_claim_bus(dev);
> +		if (ret) {
> +			debug("Couldn't claim bus for device: %p!\n", dev);
> +			return ret;
> +		}
> +
> +		ret = spi_write_then_read(spi, (u8 *)&cmd, sizeof(cmd), NULL, buff, len);
> +		if (ret)
> +			debug("read error to device: %p register: %#x!\n",
> +			      dev, reg);
> +
> +		dm_spi_release_bus(dev);
> +
> +		return ret;
> +	}
> +#endif
> +
>   	ret = dm_i2c_read(dev, reg, buff, len);
>   	if (ret) {
>   		debug("read error from device: %p register: %#x!\n", dev, reg);
> @@ -181,6 +262,9 @@ static int rk8xx_probe(struct udevice *dev)
>   	    device_is_compatible(dev, "rockchip,rk809")) {
>   		id_msb = RK817_ID_MSB;
>   		id_lsb = RK817_ID_LSB;
> +	} else if (device_is_compatible(dev, "rockchip,rk806")) {
> +		id_msb = RK806_ID_MSB;
> +		id_lsb = RK806_ID_LSB;
>   	} else {
>   		id_msb = ID_MSB;
>   		id_lsb = ID_LSB;
> @@ -221,6 +305,12 @@ static int rk8xx_probe(struct udevice *dev)
>   		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
>   		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
>   		break;
> +	case RK806_ID:
> +		on_source = RK806_ON_SOURCE;
> +		off_source = RK806_OFF_SOURCE;
> +		init_data = rk806_init_reg;
> +		init_data_num = ARRAY_SIZE(rk806_init_reg);
> +		break;
>   	default:
>   		printf("Unknown PMIC: RK%x!!\n", priv->variant);
>   		return -EINVAL;
> @@ -263,6 +353,7 @@ static struct dm_pmic_ops rk8xx_ops = {
>   
>   static const struct udevice_id rk8xx_ids[] = {
>   	{ .compatible = "rockchip,rk805" },
> +	{ .compatible = "rockchip,rk806" },
>   	{ .compatible = "rockchip,rk808" },
>   	{ .compatible = "rockchip,rk809" },
>   	{ .compatible = "rockchip,rk816" },
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 212bb752a76..1bd4605d43a 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -25,6 +25,19 @@
>   #define NA			0xff
>   
>   /* Field Definitions */
> +#define RK806_BUCK_CONFIG(n)	(0x10 + (n) - 1)
> +#define RK806_BUCK_ON_VSEL(n)	(0x1a + (n) - 1)
> +#define RK806_BUCK_SLP_VSEL(n)	(0x24 + (n) - 1)
> +#define RK806_BUCK_VSEL_MASK	0xff
> +
> +#define RK806_NLDO_ON_VSEL(n)	(0x43 + (n) - 1)
> +#define RK806_NLDO_SLP_VSEL(n)	(0x48 + (n) - 1)
> +#define RK806_NLDO_VSEL_MASK	0xff
> +
> +#define RK806_PLDO_ON_VSEL(n)	(0x4e + (n) - 1)
> +#define RK806_PLDO_SLP_VSEL(n)	(0x54 + (n) - 1)
> +#define RK806_PLDO_VSEL_MASK	0xff
> +
>   #define RK808_BUCK_VSEL_MASK	0x3f
>   #define RK808_BUCK4_VSEL_MASK	0xf
>   #define RK808_LDO_VSEL_MASK	0x1f
> @@ -91,6 +104,49 @@ struct rk8xx_reg_info {
>   	u8 max_sel;
>   };
>   
> +static const struct rk8xx_reg_info rk806_buck[] = {
> +	/* buck 1 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(1), RK806_BUCK_SLP_VSEL(1), RK806_BUCK_CONFIG(1), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(1), RK806_BUCK_SLP_VSEL(1), RK806_BUCK_CONFIG(1), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(1), RK806_BUCK_SLP_VSEL(1), RK806_BUCK_CONFIG(1), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 2 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(2), RK806_BUCK_SLP_VSEL(2), RK806_BUCK_CONFIG(2), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(2), RK806_BUCK_SLP_VSEL(2), RK806_BUCK_CONFIG(2), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(2), RK806_BUCK_SLP_VSEL(2), RK806_BUCK_CONFIG(2), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 3 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(3), RK806_BUCK_SLP_VSEL(3), RK806_BUCK_CONFIG(3), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(3), RK806_BUCK_SLP_VSEL(3), RK806_BUCK_CONFIG(3), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(3), RK806_BUCK_SLP_VSEL(3), RK806_BUCK_CONFIG(3), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 4 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(4), RK806_BUCK_SLP_VSEL(4), RK806_BUCK_CONFIG(4), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(4), RK806_BUCK_SLP_VSEL(4), RK806_BUCK_CONFIG(4), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(4), RK806_BUCK_SLP_VSEL(4), RK806_BUCK_CONFIG(4), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 5 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(5), RK806_BUCK_SLP_VSEL(5), RK806_BUCK_CONFIG(5), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(5), RK806_BUCK_SLP_VSEL(5), RK806_BUCK_CONFIG(5), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(5), RK806_BUCK_SLP_VSEL(5), RK806_BUCK_CONFIG(5), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 6 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(6), RK806_BUCK_SLP_VSEL(6), RK806_BUCK_CONFIG(6), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(6), RK806_BUCK_SLP_VSEL(6), RK806_BUCK_CONFIG(6), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(6), RK806_BUCK_SLP_VSEL(6), RK806_BUCK_CONFIG(6), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 7 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(7), RK806_BUCK_SLP_VSEL(7), RK806_BUCK_CONFIG(7), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(7), RK806_BUCK_SLP_VSEL(7), RK806_BUCK_CONFIG(7), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(7), RK806_BUCK_SLP_VSEL(7), RK806_BUCK_CONFIG(7), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 8 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(8), RK806_BUCK_SLP_VSEL(8), RK806_BUCK_CONFIG(8), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(8), RK806_BUCK_SLP_VSEL(8), RK806_BUCK_CONFIG(8), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(8), RK806_BUCK_SLP_VSEL(8), RK806_BUCK_CONFIG(8), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 9 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(9), RK806_BUCK_SLP_VSEL(9), RK806_BUCK_CONFIG(9), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(9), RK806_BUCK_SLP_VSEL(9), RK806_BUCK_CONFIG(9), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(9), RK806_BUCK_SLP_VSEL(9), RK806_BUCK_CONFIG(9), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +	/* buck 10 */
> +	{  500000,   6250, RK806_BUCK_ON_VSEL(10), RK806_BUCK_SLP_VSEL(10), RK806_BUCK_CONFIG(10), RK806_BUCK_VSEL_MASK, 0x00, 0x9f },
> +	{ 1500000,  25000, RK806_BUCK_ON_VSEL(10), RK806_BUCK_SLP_VSEL(10), RK806_BUCK_CONFIG(10), RK806_BUCK_VSEL_MASK, 0xa0, 0xeb },
> +	{ 3400000,	0, RK806_BUCK_ON_VSEL(10), RK806_BUCK_SLP_VSEL(10), RK806_BUCK_CONFIG(10), RK806_BUCK_VSEL_MASK, 0xec, 0xff },
> +};
> +
>   static const struct rk8xx_reg_info rk808_buck[] = {
>   	{  712500,  12500, REG_BUCK1_ON_VSEL, REG_BUCK1_SLP_VSEL, REG_BUCK1_CONFIG,  RK808_BUCK_VSEL_MASK, 0x00, 0x3f },
>   	{  712500,  12500, REG_BUCK2_ON_VSEL, REG_BUCK2_SLP_VSEL, REG_BUCK2_CONFIG,  RK808_BUCK_VSEL_MASK, 0x00, 0x3f },
> @@ -148,6 +204,45 @@ static const struct rk8xx_reg_info rk818_buck[] = {
>   };
>   
>   #ifdef ENABLE_DRIVER
> +static const struct rk8xx_reg_info rk806_nldo[] = {
> +	/* nldo 1 */
> +	{  500000, 12500, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA, RK806_NLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* nldo 2 */
> +	{  500000, 12500, RK806_NLDO_ON_VSEL(2), RK806_NLDO_SLP_VSEL(2), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_NLDO_ON_VSEL(2), RK806_NLDO_SLP_VSEL(2), NA, RK806_NLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* nldo 3 */
> +	{  500000, 12500, RK806_NLDO_ON_VSEL(3), RK806_NLDO_SLP_VSEL(3), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_NLDO_ON_VSEL(3), RK806_NLDO_SLP_VSEL(3), NA, RK806_NLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* nldo 4 */
> +	{  500000, 12500, RK806_NLDO_ON_VSEL(4), RK806_NLDO_SLP_VSEL(4), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_NLDO_ON_VSEL(4), RK806_NLDO_SLP_VSEL(4), NA, RK806_NLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* nldo 5 */
> +	{  500000, 12500, RK806_NLDO_ON_VSEL(5), RK806_NLDO_SLP_VSEL(5), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_NLDO_ON_VSEL(5), RK806_NLDO_SLP_VSEL(5), NA, RK806_NLDO_VSEL_MASK, 0xe8, 0xff},
> +};
> +
> +static const struct rk8xx_reg_info rk806_pldo[] = {
> +	/* pldo 1 */
> +	{  500000, 12500, RK806_PLDO_ON_VSEL(1), RK806_PLDO_SLP_VSEL(1), NA, RK806_PLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_PLDO_ON_VSEL(1), RK806_PLDO_SLP_VSEL(1), NA, RK806_PLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* pldo 2 */
> +	{  500000, 12500, RK806_PLDO_ON_VSEL(2), RK806_PLDO_SLP_VSEL(2), NA, RK806_PLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_PLDO_ON_VSEL(2), RK806_PLDO_SLP_VSEL(2), NA, RK806_PLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* pldo 3 */
> +	{  500000, 12500, RK806_PLDO_ON_VSEL(3), RK806_PLDO_SLP_VSEL(3), NA, RK806_PLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_PLDO_ON_VSEL(3), RK806_PLDO_SLP_VSEL(3), NA, RK806_PLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* pldo 4 */
> +	{  500000, 12500, RK806_PLDO_ON_VSEL(4), RK806_PLDO_SLP_VSEL(4), NA, RK806_PLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_PLDO_ON_VSEL(4), RK806_PLDO_SLP_VSEL(4), NA, RK806_PLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* pldo 5 */
> +	{  500000, 12500, RK806_PLDO_ON_VSEL(5), RK806_PLDO_SLP_VSEL(5), NA, RK806_PLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_PLDO_ON_VSEL(5), RK806_PLDO_SLP_VSEL(5), NA, RK806_PLDO_VSEL_MASK, 0xe8, 0xff},
> +	/* pldo 6 */
> +	{  500000, 12500, RK806_PLDO_ON_VSEL(6), RK806_PLDO_SLP_VSEL(6), NA, RK806_PLDO_VSEL_MASK, 0x00, 0xe7},
> +	{ 3400000,     0, RK806_PLDO_ON_VSEL(6), RK806_PLDO_SLP_VSEL(6), NA, RK806_PLDO_VSEL_MASK, 0xe8, 0xff},
> +};
> +
>   static const struct rk8xx_reg_info rk808_ldo[] = {
>   	{ 1800000, 100000, REG_LDO1_ON_VSEL, REG_LDO1_SLP_VSEL, NA, RK808_LDO_VSEL_MASK, },
>   	{ 1800000, 100000, REG_LDO2_ON_VSEL, REG_LDO2_SLP_VSEL, NA, RK808_LDO_VSEL_MASK, },
> @@ -230,7 +325,12 @@ static const struct rk8xx_reg_info *get_buck_reg(struct udevice *pmic,
>   		default:
>   			return &rk816_buck[num + 4];
>   		}
> -
> +	case RK806_ID:
> +		if (uvolt < 1500000)
> +			return &rk806_buck[num * 3 + 0];
> +		else if (uvolt < 3400000)
> +			return &rk806_buck[num * 3 + 1];
> +		return &rk806_buck[num * 3 + 2];
>   	case RK809_ID:
>   	case RK817_ID:
>   		switch (num) {
> @@ -314,7 +414,11 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>   			value = ((0 << buck) | (1 << (buck + 4)));
>   		ret = pmic_reg_write(pmic, en_reg, value);
>   		break;
> -
> +	case RK806_ID:
> +		value = RK806_POWER_EN_CLRSETBITS(buck % 4, enable);
> +		en_reg = RK806_POWER_EN((buck + 1) / 4);
> +		ret = pmic_reg_write(pmic, en_reg, value);
> +		break;
>   	case RK808_ID:
>   	case RK818_ID:
>   		mask = 1 << buck;
> @@ -389,6 +493,10 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>   			ret = pmic_reg_read(pmic, RK816_REG_DCDC_EN1);
>   		}
>   		break;
> +	case RK806_ID:
> +		mask = BIT(buck % 4);
> +		ret = pmic_reg_read(pmic, RK806_POWER_EN((buck + 1) / 4));
> +		break;
>   	case RK808_ID:
>   	case RK818_ID:
>   		mask = 1 << buck;
> @@ -428,6 +536,20 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
>   		ret = pmic_clrsetbits(pmic, RK816_REG_DCDC_SLP_EN, mask,
>   				      enable ? mask : 0);
>   		break;
> +	case RK806_ID:
> +		{
> +			u8 reg;
> +
> +			if (buck + 1 >= 9) {
> +				reg = RK806_POWER_SLP_EN1;
> +				mask = BIT(buck + 1 - 3);
> +			} else {
> +				reg = RK806_POWER_SLP_EN0;
> +				mask = BIT(buck + 1);
> +			}
> +			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
> +		}
> +		break;
>   	case RK808_ID:
>   	case RK818_ID:
>   		mask = 1 << buck;
> @@ -465,6 +587,21 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   			return val;
>   		ret = val & mask ? 1 : 0;
>   		break;
> +	case RK806_ID:
> +		{
> +			u8 reg;
> +
> +			if (buck + 1 >= 9) {
> +				reg = RK806_POWER_SLP_EN1;
> +				mask = BIT(buck + 1 - 3);
> +			} else {
> +				reg = RK806_POWER_SLP_EN0;
> +				mask = BIT(buck + 1);
> +			}
> +			val = pmic_reg_read(pmic, reg);
> +		}
> +		ret = (val & mask) ? 1 : 0;
> +		break;
>   	case RK808_ID:
>   	case RK818_ID:
>   		mask = 1 << buck;
> @@ -514,6 +651,34 @@ static const struct rk8xx_reg_info *get_ldo_reg(struct udevice *pmic,
>   	}
>   }
>   
> +static const struct rk8xx_reg_info *get_nldo_reg(struct udevice *pmic,
> +						 int num, int uvolt)
> +{
> +	const struct rk8xx_priv *priv = dev_get_priv(pmic);
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (uvolt < 3400000)
> +			return &rk806_nldo[num * 2 + 0];
> +		return &rk806_nldo[num * 2 + 1];
> +	}
> +}
> +
> +static const struct rk8xx_reg_info *get_pldo_reg(struct udevice *pmic,
> +						 int num, int uvolt)
> +{
> +	const struct rk8xx_priv *priv = dev_get_priv(pmic);
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (uvolt < 3400000)
> +			return &rk806_pldo[num * 2 + 0];
> +		return &rk806_pldo[num * 2 + 1];
> +	}
> +}
> +
>   static int _ldo_get_enable(struct udevice *pmic, int ldo)
>   {
>   	struct rk8xx_priv *priv = dev_get_priv(pmic);
> @@ -561,6 +726,63 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
>   	return ret & mask ? true : false;
>   }
>   
> +static int _nldo_get_enable(struct udevice *pmic, int nldo)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	uint mask = 0;
> +	int ret = 0;
> +	u8 en_reg = 0;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (nldo + 1 >= 5) {
> +			mask = BIT(2);
> +			en_reg = RK806_POWER_EN(5);
> +		} else {
> +			mask = BIT(nldo);
> +			en_reg = RK806_POWER_EN(3);
> +		}
> +		ret = pmic_reg_read(pmic, en_reg);
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return (ret & mask) ? 1 : 0;
> +}
> +
> +static int _pldo_get_enable(struct udevice *pmic, int pldo)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	uint mask = 0;
> +	int ret = 0;
> +	u8 en_reg = 0;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (pldo + 1 <= 3) {
> +			mask = BIT(pldo + 1);
> +			en_reg = RK806_POWER_EN(4);
> +		} else if (pldo + 1 == 6) {
> +			mask = BIT(0);
> +			en_reg = RK806_POWER_EN(4);
> +		} else {
> +			mask = BIT((pldo + 1) % 4);
> +			en_reg = RK806_POWER_EN(5);
> +		}
> +		ret = pmic_reg_read(pmic, en_reg);
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return (ret & mask) ? 1 : 0;
> +}
> +
>   static int _ldo_set_enable(struct udevice *pmic, int ldo, bool enable)
>   {
>   	struct rk8xx_priv *priv = dev_get_priv(pmic);
> @@ -616,6 +838,62 @@ static int _ldo_set_enable(struct udevice *pmic, int ldo, bool enable)
>   	return ret;
>   }
>   
> +static int _nldo_set_enable(struct udevice *pmic, int nldo, bool enable)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	uint value, en_reg;
> +	int ret = 0;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (nldo + 1 >= 5) {
> +			value = RK806_POWER_EN_CLRSETBITS(2, enable);
> +			en_reg = RK806_POWER_EN(5);
> +		} else {
> +			value = RK806_POWER_EN_CLRSETBITS(nldo, enable);
> +			en_reg = RK806_POWER_EN(3);
> +		}
> +		ret = pmic_reg_write(pmic, en_reg, value);
> +		break;
> +	}
> +
> +	if (enable)
> +		udelay(500);
> +
> +	return ret;
> +}
> +
> +static int _pldo_set_enable(struct udevice *pmic, int pldo, bool enable)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	uint value, en_reg;
> +	int ret = 0;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		/* PLDO */
> +		if (pldo + 1 <= 3) {
> +			value = RK806_POWER_EN_CLRSETBITS(pldo + 1, enable);
> +			en_reg = RK806_POWER_EN(4);
> +		} else if (pldo + 1 == 6) {
> +			value = RK806_POWER_EN_CLRSETBITS(0, enable);
> +			en_reg = RK806_POWER_EN(4);
> +		} else {
> +			value = RK806_POWER_EN_CLRSETBITS((pldo + 1) % 4, enable);
> +			en_reg = RK806_POWER_EN(5);
> +		}
> +		ret = pmic_reg_write(pmic, en_reg, value);
> +		break;
> +	}
> +
> +	if (enable)
> +		udelay(500);
> +
> +	return ret;
> +}
> +
>   static int _ldo_set_suspend_enable(struct udevice *pmic, int ldo, bool enable)
>   {
>   	struct rk8xx_priv *priv = dev_get_priv(pmic);
> @@ -652,6 +930,43 @@ static int _ldo_set_suspend_enable(struct udevice *pmic, int ldo, bool enable)
>   	return ret;
>   }
>   
> +static int _nldo_set_suspend_enable(struct udevice *pmic, int nldo, bool enable)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	uint mask;
> +	int ret = 0;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		mask = BIT(nldo);
> +		ret = pmic_clrsetbits(pmic, RK806_POWER_SLP_EN1, mask, enable ? mask : 0);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int _pldo_set_suspend_enable(struct udevice *pmic, int pldo, bool enable)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	uint mask;
> +	int ret = 0;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (pldo + 1 >= 6)
> +			mask = BIT(0);
> +		else
> +			mask = BIT(pldo + 1);
> +		ret = pmic_clrsetbits(pmic, RK806_POWER_SLP_EN2, mask, enable ? mask : 0);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>   static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>   {
>   	struct rk8xx_priv *priv = dev_get_priv(pmic);
> @@ -696,6 +1011,45 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
>   	return ret;
>   }
>   
> +static int _nldo_get_suspend_enable(struct udevice *pmic, int nldo)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	int val, ret = 0;
> +	uint mask;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		mask = BIT(nldo);
> +		val = pmic_reg_read(pmic, RK806_POWER_SLP_EN1);
> +		ret = (val & mask) ? 1 : 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int _pldo_get_suspend_enable(struct udevice *pmic, int pldo)
> +{
> +	struct rk8xx_priv *priv = dev_get_priv(pmic);
> +	int val, ret = 0;
> +	uint mask;
> +
> +	switch (priv->variant) {
> +	case RK806_ID:
> +	default:
> +		if (pldo + 1 >= 6)
> +			mask = BIT(0);
> +		else
> +			mask = BIT(pldo + 1);
> +		val = pmic_reg_read(pmic, RK806_POWER_SLP_EN2);
> +		ret = (val & mask) ? 1 : 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>   static int buck_get_value(struct udevice *dev)
>   {
>   	int buck = dev->driver_data - 1;
> @@ -803,6 +1157,22 @@ static int ldo_get_value(struct udevice *dev)
>   	return _ldo_get_value(dev, info);
>   }
>   
> +static int nldo_get_value(struct udevice *dev)
> +{
> +	int nldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, 0);
> +
> +	return _ldo_get_value(dev, info);
> +}
> +
> +static int pldo_get_value(struct udevice *dev)
> +{
> +	int pldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, 0);
> +
> +	return _ldo_get_value(dev, info);
> +}
> +
>   static int _ldo_set_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
>   {
>   	int mask = info->vsel_mask;
> @@ -830,6 +1200,22 @@ static int ldo_set_value(struct udevice *dev, int uvolt)
>   	return _ldo_set_value(dev, info, uvolt);
>   }
>   
> +static int nldo_set_value(struct udevice *dev, int uvolt)
> +{
> +	int nldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, uvolt);
> +
> +	return _ldo_set_value(dev, info, uvolt);
> +}
> +
> +static int pldo_set_value(struct udevice *dev, int uvolt)
> +{
> +	int pldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, uvolt);
> +
> +	return _ldo_set_value(dev, info, uvolt);
> +}
> +
>   static int _ldo_set_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info, int uvolt)
>   {
>   	int mask = info->vsel_mask;
> @@ -857,6 +1243,22 @@ static int ldo_set_suspend_value(struct udevice *dev, int uvolt)
>   	return _ldo_set_suspend_value(dev->parent, info, uvolt);
>   }
>   
> +static int nldo_set_suspend_value(struct udevice *dev, int uvolt)
> +{
> +	int nldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, uvolt);
> +
> +	return _ldo_set_suspend_value(dev->parent, info, uvolt);
> +}
> +
> +static int pldo_set_suspend_value(struct udevice *dev, int uvolt)
> +{
> +	int pldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, uvolt);
> +
> +	return _ldo_set_suspend_value(dev->parent, info, uvolt);
> +}
> +
>   static int _ldo_get_suspend_value(struct udevice *dev, const struct rk8xx_reg_info *info)
>   {
>   	int mask = info->vsel_mask;
> @@ -882,6 +1284,22 @@ static int ldo_get_suspend_value(struct udevice *dev)
>   	return _ldo_get_suspend_value(dev->parent, info);
>   }
>   
> +static int nldo_get_suspend_value(struct udevice *dev)
> +{
> +	int nldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_nldo_reg(dev->parent, nldo, 0);
> +
> +	return _ldo_get_suspend_value(dev->parent, info);
> +}
> +
> +static int pldo_get_suspend_value(struct udevice *dev)
> +{
> +	int pldo = dev->driver_data - 1;
> +	const struct rk8xx_reg_info *info = get_pldo_reg(dev->parent, pldo, 0);
> +
> +	return _ldo_get_suspend_value(dev->parent, info);
> +}
> +
>   static int ldo_set_enable(struct udevice *dev, bool enable)
>   {
>   	int ldo = dev->driver_data - 1;
> @@ -889,6 +1307,20 @@ static int ldo_set_enable(struct udevice *dev, bool enable)
>   	return _ldo_set_enable(dev->parent, ldo, enable);
>   }
>   
> +static int nldo_set_enable(struct udevice *dev, bool enable)
> +{
> +	int nldo = dev->driver_data - 1;
> +
> +	return _nldo_set_enable(dev->parent, nldo, enable);
> +}
> +
> +static int pldo_set_enable(struct udevice *dev, bool enable)
> +{
> +	int pldo = dev->driver_data - 1;
> +
> +	return _pldo_set_enable(dev->parent, pldo, enable);
> +}
> +
>   static int ldo_set_suspend_enable(struct udevice *dev, bool enable)
>   {
>   	int ldo = dev->driver_data - 1;
> @@ -896,6 +1328,20 @@ static int ldo_set_suspend_enable(struct udevice *dev, bool enable)
>   	return _ldo_set_suspend_enable(dev->parent, ldo, enable);
>   }
>   
> +static int nldo_set_suspend_enable(struct udevice *dev, bool enable)
> +{
> +	int nldo = dev->driver_data - 1;
> +
> +	return _nldo_set_suspend_enable(dev->parent, nldo, enable);
> +}
> +
> +static int pldo_set_suspend_enable(struct udevice *dev, bool enable)
> +{
> +	int pldo = dev->driver_data - 1;
> +
> +	return _pldo_set_suspend_enable(dev->parent, pldo, enable);
> +}
> +
>   static int ldo_get_suspend_enable(struct udevice *dev)
>   {
>   	int ldo = dev->driver_data - 1;
> @@ -903,6 +1349,20 @@ static int ldo_get_suspend_enable(struct udevice *dev)
>   	return _ldo_get_suspend_enable(dev->parent, ldo);
>   }
>   
> +static int nldo_get_suspend_enable(struct udevice *dev)
> +{
> +	int nldo = dev->driver_data - 1;
> +
> +	return _nldo_get_suspend_enable(dev->parent, nldo);
> +}
> +
> +static int pldo_get_suspend_enable(struct udevice *dev)
> +{
> +	int pldo = dev->driver_data - 1;
> +
> +	return _pldo_get_suspend_enable(dev->parent, pldo);
> +}
> +
>   static int ldo_get_enable(struct udevice *dev)
>   {
>   	int ldo = dev->driver_data - 1;
> @@ -910,6 +1370,20 @@ static int ldo_get_enable(struct udevice *dev)
>   	return _ldo_get_enable(dev->parent, ldo);
>   }
>   
> +static int nldo_get_enable(struct udevice *dev)
> +{
> +	int nldo = dev->driver_data - 1;
> +
> +	return _nldo_get_enable(dev->parent, nldo);
> +}
> +
> +static int pldo_get_enable(struct udevice *dev)
> +{
> +	int pldo = dev->driver_data - 1;
> +
> +	return _pldo_get_enable(dev->parent, pldo);
> +}
> +
>   static int switch_set_enable(struct udevice *dev, bool enable)
>   {
>   	struct rk8xx_priv *priv = dev_get_priv(dev->parent);
> @@ -1133,6 +1607,28 @@ static const struct dm_regulator_ops rk8xx_ldo_ops = {
>   	.get_suspend_enable = ldo_get_suspend_enable,
>   };
>   
> +static const struct dm_regulator_ops rk8xx_nldo_ops = {
> +	.get_value  = nldo_get_value,
> +	.set_value  = nldo_set_value,
> +	.set_suspend_value = nldo_set_suspend_value,
> +	.get_suspend_value = nldo_get_suspend_value,
> +	.get_enable = nldo_get_enable,
> +	.set_enable = nldo_set_enable,
> +	.set_suspend_enable = nldo_set_suspend_enable,
> +	.get_suspend_enable = nldo_get_suspend_enable,
> +};
> +
> +static const struct dm_regulator_ops rk8xx_pldo_ops = {
> +	.get_value  = pldo_get_value,
> +	.set_value  = pldo_set_value,
> +	.set_suspend_value = pldo_set_suspend_value,
> +	.get_suspend_value = pldo_get_suspend_value,
> +	.get_enable = pldo_get_enable,
> +	.set_enable = pldo_set_enable,
> +	.set_suspend_enable = pldo_set_suspend_enable,
> +	.get_suspend_enable = pldo_get_suspend_enable,
> +};
> +
>   static const struct dm_regulator_ops rk8xx_switch_ops = {
>   	.get_value  = switch_get_value,
>   	.set_value  = switch_set_value,
> @@ -1158,6 +1654,20 @@ U_BOOT_DRIVER(rk8xx_ldo) = {
>   	.probe = rk8xx_ldo_probe,
>   };
>   
> +U_BOOT_DRIVER(rk8xx_nldo) = {
> +	.name = "rk8xx_nldo",
> +	.id = UCLASS_REGULATOR,
> +	.ops = &rk8xx_nldo_ops,
> +	.probe = rk8xx_ldo_probe,
> +};
> +
> +U_BOOT_DRIVER(rk8xx_pldo) = {
> +	.name = "rk8xx_pldo",
> +	.id = UCLASS_REGULATOR,
> +	.ops = &rk8xx_pldo_ops,
> +	.probe = rk8xx_ldo_probe,
> +};
> +
>   U_BOOT_DRIVER(rk8xx_switch) = {
>   	.name = "rk8xx_switch",
>   	.id = UCLASS_REGULATOR,
> diff --git a/include/power/rk8xx_pmic.h b/include/power/rk8xx_pmic.h
> index 0db82419d4f..31221aa46b6 100644
> --- a/include/power/rk8xx_pmic.h
> +++ b/include/power/rk8xx_pmic.h
> @@ -182,8 +182,19 @@ enum {
>   	RK816_REG_LDO_EN2,
>   };
>   
> +enum {
> +	RK806_POWER_SLP_EN0 = 0x06,
> +	RK806_POWER_SLP_EN1,
> +	RK806_POWER_SLP_EN2,
> +	RK806_REG_SYS_CFG3 = 0x72,
> +	RK806_WDT_REG,
> +	RK806_ON_SOURCE,
> +	RK806_OFF_SOURCE
> +};
> +
>   enum {
>   	RK805_ID = 0x8050,
> +	RK806_ID = 0x8060,
>   	RK808_ID = 0x0000,
>   	RK809_ID = 0x8090,
>   	RK816_ID = 0x8160,
> @@ -201,6 +212,14 @@ enum {
>   #define RK817_POWER_EN_SAVE0	0x99
>   #define RK817_POWER_EN_SAVE1	0xa4
>   
> +#define RK806_POWER_EN(x)			(0x00 + (x))
> +/* POWER_ENx register lower 4 bits are write-protected unless the associated top bit is set */
> +#define RK806_POWER_EN_CLRSETBITS(bit, val)	(((val) << (bit)) | (1 << ((bit) + 4)))
> +
> +#define RK806_POWER_SLP_EN(x)			(0x06 + (x))
> +
> +#define RK806_ID_MSB	0x5a
> +#define RK806_ID_LSB	0x5b
>   #define RK817_ID_MSB	0xed
>   #define RK817_ID_LSB	0xee
>   #define RK8XX_ID_MSK	0xfff0
>
