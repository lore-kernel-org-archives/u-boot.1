Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A7ACF6483
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 21:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35AE8914F;
	Fri, 27 Sep 2024 23:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727474156;
	bh=EtTsB600uo+BXcIYGZRTCRffXf3o9eSmDDW1m9B1VYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWz3ahW7M+sDgEdl2DVPRuMZssQtY1lZPlChdkOIH9GwZWYJVTRklRHxbKnmTEE0g
	 Q/P6pUWdQcppH/STGZPL0sv0WEMZwupY5uXhh5fvsEvkPHZaI/WYadsS7hN9gt0u0g
	 Nyl13VqTvH2mSVL4mc2x4/LmbWzBOjxKSZJ2sY4HlYpM2h67TAJeeBfgnfAVLR8JO+
	 Mz06PD4v4EfxAVkfbai9Qf8qnm/9ADaNgf7rZHsvppYS2W8OiMUR6EO04nPtr++c1H
	 VM4zEF+ADEXzmoPhtWKGPE2Qz4ITXefbq6U69oRywuuBhWG/BAZhn9HudhNJPD7XEN
	 PHuel1nwRoHPw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 21D8489146;
 Fri, 27 Sep 2024 23:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727474153;
 bh=EtTsB600uo+BXcIYGZRTCRffXf3o9eSmDDW1m9B1VYE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=E8rjCYPNnHQZOMEtZ6GewzPmVWPF5x3r8x+L98w6AcwFE5GunqXZSTrnOkB5WtuAm
 oFvxJXN4q8Onw4RdjeI9BPW83yOFIhxrWX/Aq4bVx9Bzmz3/BLSaxKzWOtEaub1ie7
 3ncISM/1eQBgNAjHRm3IPVyRfdKy1gm0RZPwA69avqCKMeCqB8+sEyZc9vLTORda60
 qi6quJrcsiwI7eFgLdniKeATDs5Tky35x5mPaNITex7ex57WAi0cNLUa0UrjqLDkWN
 dvuf/6gbC5Y+yf/ghwU8FaRTbY+yzNuNXhdZJ17fwxuSlSHBq27ZxGOF/PkfTZNvYF
 X50rQ7PuSqzFw==
Message-ID: <c8cf0683-36f7-4163-9a72-8abb74139e73@denx.de>
Date: Fri, 27 Sep 2024 22:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] usb: onboard-hub: Add i2c initialization for
 usb5744 hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
 <20240927070137.21816-5-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240927070137.21816-5-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/27/24 9:01 AM, Venkatesh Yadav Abbarapu wrote:

[...]

>   struct onboard_hub {
>   	struct udevice *vdd;
>   	struct gpio_desc *reset_gpio;
> @@ -21,8 +27,86 @@ struct onboard_hub {
>   struct onboard_hub_data {
>   	unsigned long reset_us;
>   	unsigned long power_on_delay_us;
> +	int (*i2c_init)(struct udevice *dev);

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
> +	u8 data_buf[8] = {0x0, 0x5, 0x0, 0x1, 0x41, 0x1D, 0x08};
> +	int ret, slave_addr;
> +	u8 buf = USB5744_COMMAND_ATTACH;
> +	u8 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;
> +	struct dm_i2c_chip *i2c_chip;
> +	struct ofnode_phandle_args phandle;
> +	struct udevice *i2c_bus = NULL, *i2c_dev;

Make sure this list of variables is ordered as reverse xmas tree if 
possible.

> +	if (dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle)) {

Return the error code:

ret = dev_read_phandle_with_args()
if (ret) {
...
return ret;
}

> +		dev_err(dev, "i2c-bus not specified\n");
> +		return -ENOENT;
> +	}
> +
> +	ret = device_get_global_by_ofnode(ofnode_get_parent(phandle.node), &i2c_bus);
> +	if (ret) {
> +		dev_err(dev, "Failed to get i2c node, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ofnode_read_u32(phandle.node, "reg", &slave_addr);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_get_chip(i2c_bus, slave_addr, 1, &i2c_dev);
> +	if (ret) {
> +		dev_dbg(dev, "%s: can't find i2c chip device for addr %x\n", __func__,
> +			slave_addr);
> +		return ret;
> +	}
> +
> +	i2c_chip = dev_get_parent_plat(i2c_dev);

Can this fail ? If so, is return 0 really the correct thing to do ?

> +	if (!i2c_chip)
> +		return 0;
> +
> +	i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
> +	/* SMBus write command */
> +	ret = dm_i2c_write(i2c_dev, 0, (uint8_t *)&data_buf, 8);

Is the uint8_t * cast necessary ?

> +	if (ret) {
> +		dev_err(dev, "data_buf i2c_write failed, err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Configuration register access command */
> +	ret = dm_i2c_write(i2c_dev, USB5744_CONFIG_REG_ACCESS_LSB,
> +			   (uint8_t *)&config_reg_access_buf, 2);

Is the uint8_t * cast necessary ?

> +	if (ret) {
> +		dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* USB Attach with SMBus */
> +	ret = dm_i2c_write(i2c_dev, USB5744_COMMAND_ATTACH_LSB, (uint8_t *)&buf, 2);

Is the uint8_t * cast necessary ?

> +	if (ret) {
> +		dev_err(dev, "usb_attach i2c_write failed, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int usb_onboard_hub_probe(struct udevice *dev)
>   {
>   	struct onboard_hub_data *data =
> @@ -61,7 +145,21 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   		udelay(data->power_on_delay_us);
>   	}
[...]
