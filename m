Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7717FC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F124380C85;
	Thu, 30 Jan 2025 10:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TH49ZAL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A024881F69; Thu, 30 Jan 2025 10:49:34 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A8780AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so3809475e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738230572; x=1738835372; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibhv3jNUCmNKyopK2qaNYJztZlkOHMtg9kaYxeKQjdA=;
 b=TH49ZAL91ppkR/F0sMAfwx8IcvpCCxJOlw95/omWVb19k8vO1Qn+GthCiAoJpNT9G8
 xcJf0bwTnjMP7rogr/eRlwW3CcUkQ3lu/vjKo1802ibT30oB35M+MsikWQWzj5MzdkDe
 ZXssVKb8cKGkY/1eG+C0jRHTcksejnVfdY5ilxiwA3FXNRN3PhlZd4/i2YpppM7TWcLD
 t9TbRbkUjWsz2zv3xvTuLl4p/91f7Sfbg50emZUfzQ7Qm11F8sZg3ZMbVlAj2ChoSmOS
 NfrzyCjsxn2Rbreg1/QPZyiCg18WjFhmrdte7xP+7z6kW8Vf3KXOJ9yfKUiWArrdFWr2
 56PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738230572; x=1738835372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibhv3jNUCmNKyopK2qaNYJztZlkOHMtg9kaYxeKQjdA=;
 b=Z3UTNDPRmkDU+X7buxQ4BAFvsCKWhtB/CMP7CdSA/NU3+lODUBuBzYasykNNMMzSLI
 hVDfdiTQWeCF+4jeUMs7aL9fMEb7P6+EoLtlw3ZonKDX9ZYAR7H8C0t1xFqvPrmbjWBp
 FumVmpqMGkf5x3Q6d64VbL1G7x6RPMjg8qdDn5IX4XfPQKc5erdx4TEJig7OA7a8NWCN
 Eg+NhOu9vohlKMTzVcK92r1GhwOwItjoFW2lygR/TaOwHrHRN+PYRewraX4fHs0+qEcG
 tScMZPPpd6FKhMm5X2GvJTjwITEmKRmSEIXj7e/VxfHp8VG309xZGtUz5/ipkrcrNkeR
 CQxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnyJ/ravWsgS3hQwsW9sAeRdBtMhXJHCbQbz+v9gE+9ilfULRDlQDifOKe2T7p+CRigY4+RAg=@lists.denx.de
X-Gm-Message-State: AOJu0YyFI2Wpu90Dypbq2M0fmI23qcADUdeh0NZM8mhVhgRUqHcgDjwH
 G2/0ycbWswFzJg/S1qhiV0NIUxAujOo5K0VzmNuRCB3YvsSkNLoCyAv3VA7UTMs=
X-Gm-Gg: ASbGncshTD5yDj/3rWOCtWNiKbWCBtiBfv1DnhahVHgYXFjCv5UF7RM7m1H4zstdNbs
 K/4p21W5IUY3NdmJWAXftgPeGfoFMQQxqRelYxWXjaDV4N5sDmmWuUw0hiazkKw52asM7g4MCUd
 5IYeZroVIv80Ub8DTkfVSdRecRX+qarY2LNyTET9GSlHobZ4ZJkOmRmEmeCpJU2NwgmproayHyW
 hE3HjLtLY0c23rcnbdeWQbyApQC8ymzxoiQUTuAZjwXl+mrNUuXAkcIQryH5zotvf1mqKiQ9pYC
 R0tB4MHZDtvGuSoTy4Z3YMw=
X-Google-Smtp-Source: AGHT+IG+1yZVyD9fOXFWiocS3EgtcX4XHZeoedtnLcMlIVcZ4IczMece94c9bYDGypZoDBMT2487Tw==
X-Received: by 2002:a05:6000:1acc:b0:38c:2745:2dfd with SMTP id
 ffacd0b85a97d-38c52095a72mr4970219f8f.42.1738230571889; 
 Thu, 30 Jan 2025 01:49:31 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm1435011f8f.23.2025.01.30.01.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:49:31 -0800 (PST)
Message-ID: <8e563112-38d6-4f27-910f-331c04294465@linaro.org>
Date: Thu, 30 Jan 2025 11:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] spi: atmel-quadspi: Add support for classic SPI mode
To: Alexander Dahl <ada@thorsis.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?=
 <csokas.bence@prolan.hu>, u-boot@lists.denx.de
References: <20250123121215.21001-1-ada@thorsis.com>
 <20250123121215.21001-7-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250123121215.21001-7-ada@thorsis.com>
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

Hello Alex,

On 1/23/25 14:12, Alexander Dahl wrote:
> The qspi controller on sama5d2 and sam9x60 supports "classic" SPI mode
> without spi-mem enhancements and accelerations, very similar to the old
> SPI controller on sam9g20 or the modern flexcom controllers of the same
> SoC family.
> 
> Register interface differs somewhat, especially because only one
> hardware controlled CS line is supported.  Some fields are missing, some
> are in different registers, but in principal it works similar.  So code
> is very much inspired by the old atmel-spi driver.
> 
> Tested on sam9x60 with a non-mainline driver to configure an FPGA.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/spi/atmel-quadspi.c | 155 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index d29b5ab96e9..a2faac5a505 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -10,11 +10,13 @@
>   */
>  
>  #include <malloc.h>
> +#include <asm/gpio.h>
>  #include <asm/io.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <fdtdec.h>
> +#include <log.h>
>  #include <dm/device_compat.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> @@ -258,6 +260,7 @@ struct atmel_qspi_caps {
>  
>  struct atmel_qspi_priv_ops;
>  
> +#define MAX_CS_COUNT	2
>  struct atmel_qspi {
>  	void __iomem *regs;
>  	void __iomem *mem;
> @@ -267,6 +270,7 @@ struct atmel_qspi {
>  	struct udevice *dev;
>  	ulong bus_clk_rate;
>  	u32 mr;
> +	struct gpio_desc cs_gpios[MAX_CS_COUNT];
>  };
>  
>  struct atmel_qspi_priv_ops {
> @@ -940,6 +944,135 @@ static int atmel_qspi_sama7g5_set_speed(struct udevice *bus, uint hz)
>  	return ret;
>  }
>  
> +static int atmel_qspi_claim_bus(struct udevice *dev)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct atmel_qspi *aq = dev_get_priv(bus);
> +	int ret;
> +
> +	aq->mr &= ~QSPI_MR_CSMODE_MASK;
> +	aq->mr |= QSPI_MR_CSMODE_LASTXFER | QSPI_MR_WDRBT;
> +	atmel_qspi_write(aq->mr, aq, QSPI_MR);
> +
> +	ret = atmel_qspi_set_serial_memory_mode(aq, false);
> +	if (ret)
> +		return log_ret(ret);
> +
> +	/* de-assert all chip selects */
> +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
> +		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
> +			if (dm_gpio_is_valid(&aq->cs_gpios[i]))
> +				dm_gpio_set_value(&aq->cs_gpios[i], 0);
> +		}
> +	}
> +
> +	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
> +
> +	return 0;
> +}
> +
> +static int atmel_qspi_release_bus(struct udevice *dev)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct atmel_qspi *aq = dev_get_priv(bus);
> +
> +	/* de-assert all chip selects */
> +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
> +		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
> +			if (dm_gpio_is_valid(&aq->cs_gpios[i]))
> +				dm_gpio_set_value(&aq->cs_gpios[i], 0);
> +		}
> +	}
> +
> +	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
> +
> +	return 0;
> +}
> +
> +static int atmel_qspi_set_cs(struct udevice *dev, int value)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct atmel_qspi *aq = dev_get_priv(bus);
> +	int cs = spi_chip_select(dev);
> +
> +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
> +		if (!dm_gpio_is_valid(&aq->cs_gpios[cs]))
> +			return log_ret(-ENOENT);
> +
> +		return dm_gpio_set_value(&aq->cs_gpios[cs], value);
> +	} else {
> +		return -ENOENT;
> +	}
> +}
> +
> +static int atmel_qspi_xfer(struct udevice *dev, unsigned int bitlen,
> +			   const void *dout, void *din, unsigned long flags)
> +{
> +	struct udevice *bus = dev_get_parent(dev);
> +	struct atmel_qspi *aq = dev_get_priv(bus);
> +	unsigned int len, len_rx, len_tx;
> +	const u8 *txp = dout;
> +	u8 *rxp = din;
> +	u32 reg;
> +	int ret;
> +
> +	if (bitlen == 0)
> +		goto out;
> +
> +	if (bitlen % 8) {
> +		flags |= SPI_XFER_END;
> +		goto out;
> +	}
> +
> +	len = bitlen / 8;
> +
> +	if (flags & SPI_XFER_BEGIN) {
> +		ret = atmel_qspi_set_cs(dev, 1);
> +		if (ret)
> +			return log_ret(ret);
> +		reg = atmel_qspi_read(aq, QSPI_RD);
> +	}
> +
> +	for (len_tx = 0, len_rx = 0; len_rx < len; ) {
> +		u32 status = atmel_qspi_read(aq, QSPI_SR);
> +		u8 value;
> +
> +		if (status & QSPI_SR_OVRES)
> +			return log_ret(-1);

Any specific meaning for '-1' ?

> +
> +		if (len_tx < len && (status & QSPI_SR_TDRE)) {
> +			if (txp)
> +				value = *txp++;
> +			else
> +				value = 0;
> +			atmel_qspi_write(value, aq, QSPI_TD);
> +			len_tx++;
> +		}
> +
> +		if (status & QSPI_SR_RDRF) {
> +			value = atmel_qspi_read(aq, QSPI_RD);
> +			if (rxp)
> +				*rxp++ = value;
> +			len_rx++;

As this loop is finished only when len_rx == len, can it happen that
this increment is always skipped thus forever looping ?

> +		}
> +	}
> +
> +out:
> +	if (flags & SPI_XFER_END) {
> +		readl_poll_timeout(aq->regs + QSPI_SR, reg,
> +				   reg & QSPI_SR_TXEMPTY,
> +				   ATMEL_QSPI_TIMEOUT);
> +
> +		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
> +
> +		ret = atmel_qspi_set_cs(dev, 0);
> +		if (ret)
> +			return log_ret(ret);
> +	}
> +
> +	return 0;
> +}
> +
>  static int atmel_qspi_set_speed(struct udevice *bus, uint hz)
>  {
>  	struct atmel_qspi *aq = dev_get_priv(bus);
> @@ -1089,6 +1222,23 @@ static int atmel_qspi_probe(struct udevice *dev)
>  	else
>  		aq->ops = &atmel_qspi_priv_ops;
>  
> +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
> +		ret = gpio_request_list_by_name(dev, "cs-gpios", aq->cs_gpios,
> +						ARRAY_SIZE(aq->cs_gpios), 0);
> +		if (ret < 0) {
> +			pr_err("Can't get %s gpios! Error: %d", dev->name, ret);

Is cs-gpios mandatory ? Apparently binding does not enforce it

> +			return ret;
> +		}
> +
> +		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
> +			if (!dm_gpio_is_valid(&aq->cs_gpios[i]))
> +				continue;
in here you just skip if gpio isn't valid apparently.
> +
> +			dm_gpio_set_dir_flags(&aq->cs_gpios[i],
> +					      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +		}
> +	}
> +
>  	/* Map the registers */
>  	ret = dev_read_resource_byname(dev, "qspi_base", &res);
>  	if (ret) {
> @@ -1127,9 +1277,12 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
>  };
>  
>  static const struct dm_spi_ops atmel_qspi_ops = {
> +	.claim_bus = atmel_qspi_claim_bus,
> +	.release_bus = atmel_qspi_release_bus,
> +	.xfer = atmel_qspi_xfer,
> +	.mem_ops = &atmel_qspi_mem_ops,
>  	.set_speed = atmel_qspi_set_speed,
>  	.set_mode = atmel_qspi_set_mode,
> -	.mem_ops = &atmel_qspi_mem_ops,
>  };
>  
>  static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {};

