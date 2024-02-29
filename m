Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE567C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 11:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FC687BCB;
	Thu, 29 Feb 2024 12:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UMRRBhsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F79487B63; Thu, 29 Feb 2024 12:48:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CEB87C0A
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 12:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1c06=KG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709207285;
 bh=Qh+wsLhFTgfCevrpZXjsCxZFLzYPLwavPYLltQL9I7M=;
 b=UMRRBhsh3bqo+EDZ1TgEQ/KkPV0m1V6FS4xYvg1q7uA8sRJTwpIMOCivk3jCSogCyMEDL85cz
 1y6VMJNNuL9lp/syZL+77pDenBIse31+yVBtULoreaW3kYKnGZUcBtI53QFgWsB7NAyeYU3NN2/
 VUaPV274R2eoFO+Lge0N7PQFtJT9B4Xpk5y8PVVa68iDclwMJefU8NX1/U4VMSS37k21Ny8KDfy
 sah7YzHtYPBZuxw7TDBB+lzDW/TPY2IRnJFdwLVCZnl7Y1ub4RvsLq6gfcR/4CBBn6RtSjJlEQr
 +Qzf2uXpb/MqSrP3mKpwOJSJgyYvlTCpZbUbJOr/w/Fg==
Message-ID: <e792f582-3db3-40f2-8e9d-4a4985edf3f6@kwiboo.se>
Date: Thu, 29 Feb 2024 12:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] power: rk8xx: add support for RK806
To: Quentin Schulz <foss+uboot@0leil.net>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
References: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
 <20240223-rk3588-saradc-v2-5-11c046b7e94a@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240223-rk3588-saradc-v2-5-11c046b7e94a@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65e06ef39f4ee32ddddc3e0f
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

On 2024-02-23 10:05, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This adds support for RK806, only the SPI variant has been tested.
> 
> The communication "protocol" over SPI is the following:
>  - write three bytes:
>    - 1 byte: [0:3] length of the payload, [6] Enable CRC, [7] Write
>    - 1 byte: LSB register address
>    - 1 byte: MSB register address
>  - write/read length of payload
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
>  drivers/power/pmic/rk8xx.c      |  85 +++++++
>  drivers/power/regulator/rk8xx.c | 514 +++++++++++++++++++++++++++++++++++++++-
>  include/power/rk8xx_pmic.h      |  19 ++
>  3 files changed, 616 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 4e3a17337ee..15cb82029cc 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -9,8 +9,10 @@
>  #include <dm/lists.h>
>  #include <errno.h>
>  #include <log.h>
> +#include <linux/bitfield.h>
>  #include <power/rk8xx_pmic.h>
>  #include <power/pmic.h>
> +#include <spi.h>
>  #include <sysreset.h>
>  
>  static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
> @@ -32,6 +34,10 @@ static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  		pmic_clrsetbits(dev->parent, RK817_REG_SYS_CFG3, 0,
>  				BIT(0));
>  		break;
> +	case RK806_ID:
> +		pmic_clrsetbits(dev->parent, RK806_REG_SYS_CFG3, 0,
> +				BIT(0));
> +		break;
>  	default:
>  		printf("Unknown PMIC RK%x: Cannot shutdown\n",
>  		       priv->variant);
> @@ -83,6 +89,11 @@ void rk8xx_off_for_plugin(struct udevice *dev)
>  	}
>  }
>  
> +static struct reg_data rk806_init_reg[] = {
> +	/* RST_FUN */
> +	{ RK806_REG_SYS_CFG3, GENMASK(7, 6), BIT(7)},
> +};
> +
>  static struct reg_data rk817_init_reg[] = {
>  /* enable the under-voltage protection,
>   * the under-voltage protection will shutdown the LDO3 and reset the PMIC
> @@ -92,7 +103,10 @@ static struct reg_data rk817_init_reg[] = {
>  
>  static const struct pmic_child_info pmic_children_info[] = {
>  	{ .prefix = "DCDC_REG", .driver = "rk8xx_buck"},
> +	{ .prefix = "dcdc-reg", .driver = "rk8xx_buck"},
>  	{ .prefix = "LDO_REG", .driver = "rk8xx_ldo"},
> +	{ .prefix = "nldo-reg", .driver = "rk8xx_nldo"},
> +	{ .prefix = "pldo-reg", .driver = "rk8xx_pldo"},
>  	{ .prefix = "SWITCH_REG", .driver = "rk8xx_switch"},
>  	{ },
>  };
> @@ -102,11 +116,47 @@ static int rk8xx_reg_count(struct udevice *dev)
>  	return RK808_NUM_OF_REGS;
>  }
>  
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
> +
>  static int rk8xx_write(struct udevice *dev, uint reg, const uint8_t *buff,
>  			  int len)
>  {
>  	int ret;
>  
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

I am getting following build error on PineTab2 [1] with this:

aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.o: in function `rk8xx_write':
drivers/power/pmic/rk8xx.c:144:(.text.rk8xx_write+0x60): undefined reference to `dm_spi_claim_bus'
aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:150:(.text.rk8xx_write+0x84): undefined reference to `spi_write_then_read'
aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:155:(.text.rk8xx_write+0x90): undefined reference to `dm_spi_release_bus'
aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.o: in function `rk8xx_read':
drivers/power/pmic/rk8xx.c:182:(.text.rk8xx_read+0x60): undefined reference to `dm_spi_claim_bus'
aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:188:(.text.rk8xx_read+0x84): undefined reference to `spi_write_then_read'
aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:193:(.text.rk8xx_read+0x90): undefined reference to `dm_spi_release_bus'
make[2]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
make[1]: *** [Makefile:2055: spl/u-boot-spl] Error 2

On PineTab2 this driver is enabled in SPL and this build error happens
because SPL_SPI and/or SPL_DM_SPI is not enabled.

The RK8XX driver is enabled in SPL to be able to quickly power down the
tablet if it was powered on because a power cable was connected.

CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
CONFIG_SPL_I2C=y
CONFIG_SPL_PMIC_RK8XX=y

[1] https://patchwork.ozlabs.org/patch/1895031/

> +
> +		return ret;
> +	}
> +
>  	ret = dm_i2c_write(dev, reg, buff, len);
>  	if (ret) {
>  		debug("write error to device: %p register: %#x!\n", dev, reg);
> @@ -120,6 +170,31 @@ static int rk8xx_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>  {
>  	int ret;
>  
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

Same build error here.

Regards,
Jonas

> +
> +		return ret;
> +	}
> +
>  	ret = dm_i2c_read(dev, reg, buff, len);
>  	if (ret) {
>  		debug("read error from device: %p register: %#x!\n", dev, reg);
> @@ -181,6 +256,9 @@ static int rk8xx_probe(struct udevice *dev)
>  	    device_is_compatible(dev, "rockchip,rk809")) {
>  		id_msb = RK817_ID_MSB;
>  		id_lsb = RK817_ID_LSB;
> +	} else if (device_is_compatible(dev, "rockchip,rk806")) {
> +		id_msb = RK806_ID_MSB;
> +		id_lsb = RK806_ID_LSB;
>  	} else {
>  		id_msb = ID_MSB;
>  		id_lsb = ID_LSB;
> @@ -221,6 +299,12 @@ static int rk8xx_probe(struct udevice *dev)
>  		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
>  		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
>  		break;
> +	case RK806_ID:
> +		on_source = RK806_ON_SOURCE;
> +		off_source = RK806_OFF_SOURCE;
> +		init_data = rk806_init_reg;
> +		init_data_num = ARRAY_SIZE(rk806_init_reg);
> +		break;
>  	default:
>  		printf("Unknown PMIC: RK%x!!\n", priv->variant);
>  		return -EINVAL;
> @@ -263,6 +347,7 @@ static struct dm_pmic_ops rk8xx_ops = {
>  
>  static const struct udevice_id rk8xx_ids[] = {
>  	{ .compatible = "rockchip,rk805" },
> +	{ .compatible = "rockchip,rk806" },
>  	{ .compatible = "rockchip,rk808" },
>  	{ .compatible = "rockchip,rk809" },
>  	{ .compatible = "rockchip,rk816" },

[snip]
