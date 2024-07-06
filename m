Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E476FC3271E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 00:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FA9889D5;
	Sat,  6 Jul 2024 02:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720227526;
	bh=qR+eZkHKq2lcNtPxYxRnkAJkNM09vWF3Z08q4wEzQ0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u575t6t7Rztec3Fye74GKadgbiw0m9f5rtTmbVFdpRZT803Q2NVi4EX/e/Ls9x71s
	 LjxejZR1TAA4jTzUK0TpdpQqyXu0y8QVmuXt7rc+vbu0I5/Yw7eB+tzUQz2DQQpTzI
	 ba4gNQkkSx6/Bruva+kG8m1LFcc9ftzfMSt26K3MW6MxgYoA7lMctN7JSCYd0B1MdW
	 0tx9oOk+6CTCvu/tDZG7TeyA4Zr12ixrPN2hnWhPSRwQDK0vzolVd2yno5rlCidZoB
	 ba8H6p3wuaVgdcv5GBuYa2doneZR+eNOh8sFszuLkelSmOwC4zf53rIeFGQYxJwjYX
	 EkaH4eBa4ceGg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8A5F388640;
 Sat,  6 Jul 2024 02:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720227525;
 bh=qR+eZkHKq2lcNtPxYxRnkAJkNM09vWF3Z08q4wEzQ0g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uCaOzFXx+Qss5xaKNTv7FphhhaE+JotDVR20+0Svm8eGWdgs5w5bju5AJa3zXOD3F
 qnebM/5vMlakKKSxDdFn/DNhBuiM2MyD5oq4dL9BQu65YM5VgqJ4qs5QNccVYvTgsz
 G3QAj7earAbQqz22s3+U823c8+kfN2ClZB+BcJ5z+xCTcxOBcAVUbByUF9SyWdSg3i
 ySNNQ3o5kqrLdVcVYvpFNJ0g20iZln/m08jOpvqXnlLBD/R9qYstgeCOuieVPPETjd
 +DjAH6Z6BC/Gc8zCuCN4vb6RAH8DEraxPmEhmfsn1aCzqWy0lJ+gJ2UqvbjnSI2EZO
 c2MeNLsra0V6g==
Message-ID: <a3fd51a4-ecbc-47e1-afba-03c9a4fccd2c@denx.de>
Date: Sat, 6 Jul 2024 02:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] usb: tcpm: fusb302: add driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>, Wang Jie <dave.wang@rock-chips.com>
References: <20240604163546.60225-1-sebastian.reichel@collabora.com>
 <20240604163546.60225-3-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604163546.60225-3-sebastian.reichel@collabora.com>
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

On 6/4/24 6:33 PM, Sebastian Reichel wrote:

[...]

> +static int fusb302_i2c_block_write(struct udevice *dev, u8 address,
> +				   u8 length, const u8 *data)
> +{
> +	int ret = 0;

This initialization of ret = 0 is probably unnecessary, see right below.

> +	if (length <= 0)
> +		return ret;

Should this return -EINVAL if length < 0 ?

> +	ret = dm_i2c_write(dev, address, data, length);
> +	if (ret)
> +		dev_err(dev, "cannot block write 0x%02x, len=%d, ret=%d\n",
> +			address, length, ret);
> +
> +	return ret;
> +}
> +
> +static int fusb302_i2c_read(struct udevice *dev, u8 address, u8 *data)
> +{
> +	int ret = 0, retries;

Plain 'int ret;' is enough here , ret is always assigned in the loop below.

> +	for (retries = 0; retries < 3; retries++) {
> +		ret = dm_i2c_read(dev, address, data, 1);
> +		if (ret == 0)
> +			return ret;
> +		dev_err(dev, "cannot read %02x, ret=%d\n", address, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int fusb302_i2c_block_read(struct udevice *dev, u8 address,
> +				  u8 length, u8 *data)
> +{
> +	int ret = 0;

int ret;

> +	if (length <= 0)
> +		return ret;

return -EINVAL;

> +	ret = dm_i2c_read(dev, address, data, length);
> +	if (ret)
> +		dev_err(dev, "cannot block read 0x%02x, len=%d, ret=%d\n",
> +			address, length, ret);
> +	return ret;
> +}
> +
> +static int fusb302_i2c_mask_write(struct udevice *dev, u8 address,
> +				  u8 mask, u8 value)
> +{
> +	int ret = 0;

int ret;

> +	u8 data;
> +
> +	ret = fusb302_i2c_read(dev, address, &data);
> +	if (ret)
> +		return ret;
> +	data &= ~mask;
> +	data |= value;
> +	ret = fusb302_i2c_write(dev, address, data);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static int fusb302_i2c_set_bits(struct udevice *dev, u8 address, u8 set_bits)
> +{
> +	return fusb302_i2c_mask_write(dev, address, 0x00, set_bits);
> +}
> +
> +static int fusb302_i2c_clear_bits(struct udevice *dev, u8 address, u8 clear_bits)
> +{
> +	return fusb302_i2c_mask_write(dev, address, clear_bits, 0x00);
> +}
> +
> +static int fusb302_sw_reset(struct udevice *dev)
> +{
> +	int ret = fusb302_i2c_write(dev, FUSB_REG_RESET, FUSB_REG_RESET_SW_RESET);
> +
> +	if (ret)
> +		dev_err(dev, "cannot sw reset the fusb302: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int fusb302_enable_tx_auto_retries(struct udevice *dev, u8 retry_count)
> +{
> +	int ret = 0;

int ret; , please fix globally

> +	ret = fusb302_i2c_set_bits(dev, FUSB_REG_CONTROL3, retry_count |
> +				   FUSB_REG_CONTROL3_AUTO_RETRY);
> +
> +	return ret;
> +}

[...]

> +static int fusb302_set_cc(struct udevice *dev, enum typec_cc_status cc)
> +{
> +	struct fusb302_chip *chip = dev_get_priv(dev);
> +	u8 switches0_mask = FUSB_REG_SWITCHES0_CC1_PU_EN |
> +			    FUSB_REG_SWITCHES0_CC2_PU_EN |
> +			    FUSB_REG_SWITCHES0_CC1_PD_EN |
> +			    FUSB_REG_SWITCHES0_CC2_PD_EN;
> +	u8 rd_mda, switches0_data = 0x00;

The masks can be const u8 .

> +	int ret = 0;

[...]

> +static int fusb302_set_polarity(struct udevice *dev,
> +				enum typec_cc_polarity polarity)
> +{
> +	return 0;

The uclass should check if callback is available and not call it if it 
is not.

> +}

[...]

> +static int fusb302_pd_send_message(struct udevice *dev,
> +				   const struct pd_message *msg)
> +{
> +	int ret = 0;
> +	u8 buf[40];
> +	u8 pos = 0;
> +	int len;
> +
> +	/* SOP tokens */
> +	buf[pos++] = FUSB302_TKN_SYNC1;
> +	buf[pos++] = FUSB302_TKN_SYNC1;
> +	buf[pos++] = FUSB302_TKN_SYNC1;
> +	buf[pos++] = FUSB302_TKN_SYNC2;

Why not do this ?

u8 buf[40] = { FUSB302_TKN_SYNC1, FUSB302_TKN_SYNC1, FUSB302_TKN_SYNC1, 
FUSB302_TKN_SYNC2 };
u8 pos = 4;

> +	len = pd_header_cnt_le(msg->header) * 4;
> +	/* plug 2 for header */
> +	len += 2;
> +	if (len > 0x1F) {

Magic value should be defined in some macro.

> +		dev_err(dev, "PD message too long %d (incl. header)", len);
> +		return -EINVAL;
> +	}

[...]
