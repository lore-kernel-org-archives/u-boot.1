Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE52CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61B888BEF;
	Mon,  2 Sep 2024 20:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725303553;
	bh=HpoZupQQpyh0RYfn70bEl6Fw4HcdyLk6gBagdQ6n2ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OD3p0JJFnwwCRc4jeJDdNkAClZWpuPR4btV4+t6VYniESYO07rw+vl1uVi9ItDYqi
	 iGA9F6jRiGTFLnFxRAjOi+EeMtLZn6+cBvd7egR/D6AkjZsmx05O3txhQptm8SopEO
	 ACrzXCfpu58i/H46CGzaGbVzMzXIZWHtBDXqYyiO0eWUeyKdwWI40LkKLOuMpkAtpf
	 KemaKR6KDMJ6jAnWLLzPdh0sweJprGXZQhtaKuCDn0t2QyQ+m2Sy2VWPss475k6HGA
	 gA5vnfpgRqW4Sg+1WnRDjyvwaZ2QZr3pBt8cHsWZqIVc5hNf+8fuZhG7n2qpzVeL2G
	 bqesVpLP3u5sg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BCB3188C55;
 Mon,  2 Sep 2024 20:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725303552;
 bh=HpoZupQQpyh0RYfn70bEl6Fw4HcdyLk6gBagdQ6n2ms=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CSFT8zvdUdsk/k1cMVpeblHZUEuUfFX+7pPYyYDgVpehN4tujoNmL00GDL0lHhsfR
 AQd9T/BobB0g2/0IrkfnCQKpNnscKpOQJKljPDDI+X3j+CLTyW59ErBylTYJwYb/Q3
 fhn6TkpQLrla2pcC1KX+YlNw+OZ6RqT5fGCOJBtpCdkqP4O06sb9YE/6xz/SRiFBOW
 BRTQANNee9m0Ct90QUUbe2SHDTD2yVe2e+rwRnajl3le61u7VFwKmFCVfNuZzpZxnn
 j2YBE5fE34fZx2tSrZg7x56vC2tbKxVTTDX5fbyfmzdMqdAM+AAyzo7qTJHH3gDkFy
 MJFCtdwBlRWrw==
Message-ID: <fa20e7d1-e2e5-4ee1-b053-624091c51a02@denx.de>
Date: Mon, 2 Sep 2024 20:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <20240605100221.3571-5-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240605100221.3571-5-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/5/24 12:02 PM, Venkatesh Yadav Abbarapu wrote:
> Add i2c initialization hook and set usb5744 platform
> data with function having required i2c initialization sequence.
> 
> Apart from the USB command attach, prevent the hub from suspend.
> when the “USB Attach with SMBUS (0xAA56)” command is issued to the hub,
> the hub is getting enumerated and then it puts in a suspend mode.
> This causes the hub to NAK any SMBUS access made by the SMBUS Master
> during this period and not able to see the hub's slave address while
> running the "i2c probe" command.
> 
> Prevent the MCU from the putting the HUB in suspend mode through register
> write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2 register at
> address 0x411D controls this aspect of the hub. The BYPASS_UDC_SUSPEND
> bit in register 0x411Dh must be set to ensure that the MCU is always
> enabled and ready to respond to SMBus runtime commands. This register
> needs to be written before the USB attach command is issued.
> The byte sequence is as follows:
> Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> Slave addr: 0x2d           99 37 00
> Slave addr: 0x2d           AA 56 00
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 86 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 50870285995..09ce452af1b 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -11,9 +11,15 @@
>   #include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> +#include <i2c.h>
>   #include <linux/delay.h>
>   #include <power/regulator.h>
>   
> +#define USB5744_COMMAND_ATTACH        0x0056
> +#define USB5744_COMMAND_ATTACH_LSB    0xAA
> +#define USB5744_CONFIG_REG_ACCESS     0x0037
> +#define USB5744_CONFIG_REG_ACCESS_LSB 0x99
> +
>   struct onboard_hub {
>   	struct udevice *vdd;
>   	struct gpio_desc *reset_gpio;
> @@ -21,8 +27,80 @@ struct onboard_hub {
>   
>   struct onboard_hub_data {
>   	unsigned long reset_us;
> +	int (*onboard_dev_i2c_init)(struct udevice *dev);

Why not call it simply "init" ?

>   };
>   
> +static int usb5744_i2c_init(struct udevice *dev)
> +{
> +	/*
> +	 *  Prevent the MCU from the putting the HUB in suspend mode through register write.
> +	 *  The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2 register at address
> +	 *  0x411D controls this aspect of the hub.
> +	 *  Format to write to hub registers via SMBus- 2D 00 00 05 00 01 41 1D 08
> +	 *  Byte 0: Address of slave 2D
> +	 *  Byte 1: Memory address 00
> +	 *  Byte 2: Memory address 00
> +	 *  Byte 3: Number of bytes to write to memory
> +	 *  Byte 4: Write configuration register (00)
> +	 *  Byte 5: Write the number of data bytes (01- 1 data byte)
> +	 *  Byte 6: LSB of register address 0x41
> +	 *  Byte 7: MSB of register address 0x1D
> +	 *  Byte 8: value to be written to the register
> +	 */
> +	char data_buf[8] = {0x0, 0x5, 0x0, 0x1, 0x41, 0x1D, 0x08};

This should be u8 [] , not an array of signed chars.

> +	int ret, slave_addr;
> +	u32 buf = USB5744_COMMAND_ATTACH;
> +	u32 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;

This should be u8 [] , right ?

> +	struct dm_i2c_chip *i2c_chip;
> +	struct ofnode_phandle_args phandle;
> +	struct udevice *i2c_bus = NULL, *i2c_dev;

Make sure this list of variables is ordered as reverse xmas tree if 
possible.

> +	if (!dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle)) {

Invert the condition and return early to reduce indent, i.e.

if (dev...)
  return 0;

> +		ret = device_get_global_by_ofnode(ofnode_get_parent(phandle.node), &i2c_bus);
> +		if (ret) {
> +			dev_err(dev, "Failed to get i2c node, err: %d\n", ret);
> +			return ret;
> +		}
> +		ret = ofnode_read_u32(phandle.node, "reg", &slave_addr);
> +		if (ret)
> +			return ret;
> +
> +		ret = i2c_get_chip(i2c_bus, slave_addr, 1, &i2c_dev);
> +		if (ret) {
> +			debug("%s: can't find i2c chip device for addr %x\n", __func__,

dev_dbg(dev, ...)

> +			      slave_addr);
> +			return ret;
> +		}
> +
> +		i2c_chip = dev_get_parent_plat(i2c_dev);
> +		if (i2c_chip) {

if (!i2c_chip)
   return ...

> +			i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
> +			/* SMBus write command */
> +			ret = dm_i2c_write(i2c_dev, 0, (uint8_t *)&data_buf, 8);
> +			if (ret) {
> +				dev_err(dev, "data_buf i2c_write failed, err:%d\n", ret);
> +				return ret;
> +			}
> +
> +			/* Configuration register access command */
> +			ret = dm_i2c_write(i2c_dev, USB5744_CONFIG_REG_ACCESS_LSB,
> +					   (uint8_t *)&config_reg_access_buf, 2);
> +			if (ret) {
> +				dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
> +				return ret;
> +			}
> +
> +			/* USB Attach with SMBus */
> +			ret = dm_i2c_write(i2c_dev, USB5744_COMMAND_ATTACH_LSB, (uint8_t *)&buf, 2);
> +			if (ret) {
> +				dev_err(dev, "usb_attach i2c_write failed, err: %d\n", ret);
> +				return ret;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
>   static int usb_onboard_hub_probe(struct udevice *dev)
>   {
>   	struct onboard_hub_data *data =
> @@ -63,6 +141,13 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   		udelay(data->reset_us);
>   	}
>   
> +	if (data->onboard_dev_i2c_init) {
> +		ret = data->onboard_dev_i2c_init(dev);
> +		if (ret) {
> +			dev_err(dev, "onboard i2c init failed: %d\n", ret);
> +			return ret;

This should implement some sort of 'goto err' failpath and put the hub 
back into reset, since the hub was brought out of reset right above here.
