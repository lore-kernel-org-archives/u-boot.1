Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5D8CE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C424891BD;
	Tue,  1 Oct 2024 14:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727784809;
	bh=+p8Smg8kSmqXpA/ne0YSD0b2LpP19/xLFg0T0Q+iyDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XXNdkzUFUcbH8K/hf/2N73kzQYCmbssSLGFowAsaejuDJDcvdRc9cLALSo7sTf7Qh
	 bh5qz4l2wdqlefe02L4isyayBMcLtWMO2MjlSETTExLb7qcTpwtu/9uJrLJ3aKWlgh
	 1GxHecJfnx8GJn54NnEKsUuptg9biCVzjaK1roPgBkIcahb5ZLKZfj4kfDrPLzB+ks
	 yXnBewcuFZVO5w6OmlxnrnI+Yn5K/Igh8jIOOnKlF1Ah/hwSd5De6yEP8t+mDyx5WD
	 3gjsYJornnuyxSxg5iG7Jb19mgHcEos4lvdoVTwGvojMHjVCikiGpt2hVvan33BZFG
	 tEcZ7HB/J3fpA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 60D008919D;
 Tue,  1 Oct 2024 14:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727784807;
 bh=+p8Smg8kSmqXpA/ne0YSD0b2LpP19/xLFg0T0Q+iyDA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AcB5Jc4m7hyTWo2m1uLP9siUDlkc+rCGlJdPHBI3RRynSNuY+6qHkhOFj9xngQYJt
 /AcCUwDmjReppTrd26B4OnQaBJX/JhiqbxjCEnjwt22EUIRJXq8VroV9EmCMztNmQT
 M1RQcGkCTKrIFJQo/R4zI81cjxra3GOoRn0pP++lOli3g5SjMtzApaZgyUA6NwmiRu
 5zsbgsIBSrgnXPK6bTglKZTF1IaLdVxVW7+zkar1/Y8Z+IticGLBvVHvvsW2F4OQVI
 3uPPACStcOARpjM/LuqvMZP+f8LB63EsgfFnJDfI+wL7WYVNQABb6HORzNdUhj0lVt
 elWSo8d5LIXCQ==
Message-ID: <ca968c74-16a7-4672-b02b-6f497e719268@denx.de>
Date: Tue, 1 Oct 2024 14:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] usb: onboard-hub: Add i2c initialization for
 usb5744 hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-5-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241001050529.17922-5-venkatesh.abbarapu@amd.com>
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

On 10/1/24 7:05 AM, Venkatesh Yadav Abbarapu wrote:

[...]

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
> +	u8 buf = USB5744_COMMAND_ATTACH;
> +	u8 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;
> +	int ret, slave_addr;
> +	struct dm_i2c_chip *i2c_chip;
> +	struct ofnode_phandle_args phandle;
> +	struct udevice *i2c_bus = NULL, *i2c_dev;

Reverse xmas tree.

> +
> +	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle);
> +	if (ret) {
> +		dev_err(dev, "i2c-bus not specified\n");
> +		return ret;
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

0x%x for hex value.

> +			slave_addr);
> +		return ret;
> +	}
> +
> +	i2c_chip = dev_get_parent_plat(i2c_dev);
> +	if (!i2c_chip) {
> +		dev_err(dev, "parent platform data not found\n");

Why are some of the error message using dev_dbg() and some dev_err() ?

> +		return -EINVAL;
> +	}
> +
> +	i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
> +	/* SMBus write command */
> +	ret = dm_i2c_write(i2c_dev, 0, (uint8_t *)&data_buf, 8);
> +	if (ret) {
> +		dev_err(dev, "data_buf i2c_write failed, err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Configuration register access command */
> +	ret = dm_i2c_write(i2c_dev, USB5744_CONFIG_REG_ACCESS_LSB,
> +			   &config_reg_access_buf, 2);
> +	if (ret) {
> +		dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* USB Attach with SMBus */
> +	ret = dm_i2c_write(i2c_dev, USB5744_COMMAND_ATTACH_LSB, &buf, 2);
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
> @@ -61,7 +148,21 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   		udelay(data->power_on_delay_us);
>   	}
>   
> +	if (data->init) {
> +		ret = data->init(dev);
> +		if (ret) {
> +			dev_err(dev, "onboard i2c init failed: %d\n", ret);
> +			goto err;
> +		}
> +	}
> +
>   	return 0;
> +err:
> +	ret = dm_gpio_set_value(hub->reset_gpio, 0);

dm_gpio_set_value(hub->reset_gpio, 0);
return ret;

If the set_value errors out, we still want the original error returned.

> +	if (ret)
> +		return ret;
> +
> +	return ret;
>   }
