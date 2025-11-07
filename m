Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF7ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DE583CB9;
	Fri,  7 Nov 2025 11:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D4befJhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0D483CEE; Fri,  7 Nov 2025 11:41:28 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A7B83CB9
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b725ead5800so77578966b.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762512085; x=1763116885; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M2xky54kU+ZFOz6t8T948/iLf70tpWxCufdL+Ccw2pc=;
 b=D4befJhvowS6AvuV+eGoLP/TRUHRmC/nuDS3aOisiW4wlFQoh7a1OQ3ntNbhTUtYgg
 Azx+uY5YMIpeg8pwQX8yjnV7R7rFutWAw+ZUi7m60gZV4v27J8pLApdc8RSMsCAMDQoX
 mGE1iuND14Zb6IKLZY9Yq7wDWCDzgg1M8CsEZb0mRBVLnFHzgUAevhuIix6caMOktrYZ
 nXXQIZ9oEBOOabmwiLoClJwA/wmAS8EUf5rI1UFJ3OT9aV+ghO3re/hZ67uEUcOGVpw7
 ltQxtkHybGXrnZ4FYZMFteiL/P4U2xzQ2XXq3qZv3aO2bspV+wo+TIz7LLXYjEOH+5k1
 Krcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512085; x=1763116885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2xky54kU+ZFOz6t8T948/iLf70tpWxCufdL+Ccw2pc=;
 b=PybnPxLzzTi8PcuyIgSaQBjCC9ju+Jf90WaUx/fEjM1wcFjeXzyzsQNznT6qee2PLM
 tb/V/HWAoh/gzjbEQ/0rfwJ12DXveMnaU08wiS6ChuAcJDrL24Zr7ZkF9v/xq+p/tvCx
 k9ypch6V4J9m71ydpO0FGjGxXnuMZmozx1CwNDNWNAapNolCi0dxr1qL/SJyvLOy05xm
 ZNDtJhL2z9Fmd1RSd8sU7n/uYQ68+qAJVN4Zm1bYzZWcXNVYQlutqGV43MPAcMXFduD/
 nEFHCj/4KUxvKkkbov7XOUjxm/rgWWhKY2FA4IPRnAHyGcl9Ve22qVHwPIb6gOtqQHwN
 q71w==
X-Gm-Message-State: AOJu0Yw73/DKB6gg7JFOr3glIQBLygZJ6SO76BHmg8Y/0fC6eVQlxNuB
 G7niCtljre/AWUUeKNxitGv640Ha+4b5lC6fHkwrWp3xpmMZS8xDkBDegupjPD4ukRo=
X-Gm-Gg: ASbGncvUVB78CUE4Tasy0AKAMdqqRknRhM2wAhL+lkVFxySgOVhSFZbn69h265F2RbE
 nlspnpz2Y+aIA7L2Om4Fb9ySy+xKpAkGPNWCmcDGXw1Vclc2MljA3XEFrxO7S1o3CZ+muXcEsCp
 bTOjHgYb6hZlbMwBco/HreXaZiTNk1UdcNPsD7ps+dh0XAaU9oOQJw0nueQDRuWzbOTC1tvQ7xj
 CBpSprNn+monCGAoOZdwanOwBVyOEZnuksOUysWu8EdRXx8KVZnZwkXyZhwfx3DRVUvVc2r03IO
 dzqya08nKY3qh6epRcsOk+j/8Q1XNExa0+0H7CmtbjomoOyPsUOw2lUkLD0wENbKnnJN+OGQrNr
 yYcLZh+Ertd/71mzK+MXGMtB4sWFyRMei5Xu3Az4n/uSAj6w77WBnRAaesEXF+1e8erlELpFB+b
 8QxlVd3nTeTWdU6OQAccHHN6MMoVa+Yco=
X-Google-Smtp-Source: AGHT+IGXAesWuNlQi/rDDCbHKC7+Gz3bncLSmExkt1KAGHOeK44lNzMq3lvjDqQqtCuqrpXpgw3uNQ==
X-Received: by 2002:a17:907:724a:b0:b3f:9b9c:d49e with SMTP id
 a640c23a62f3a-b72c0e9ae41mr281823566b.57.1762512085187; 
 Fri, 07 Nov 2025 02:41:25 -0800 (PST)
Received: from [172.20.148.34] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbc95e4sm211978066b.12.2025.11.07.02.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Nov 2025 02:41:24 -0800 (PST)
Message-ID: <1116a46b-6261-487b-8418-1c638df56e15@linaro.org>
Date: Fri, 7 Nov 2025 12:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mtd: nand: raw: Add ONFI NAND unique id read support.
To: Zixun LI <admin@hifiphile.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251106170124.3992080-1-admin@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251106170124.3992080-1-admin@hifiphile.com>
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



On 11/6/25 19:01, Zixun LI wrote:
> This patch adds support for reading the unique ID from ONFI-compliant NAND
> flash devices.
> 
> The unique ID is a 32 bytes long identifier that is useful for device
> identification and tracking.
> 
> Tested on SAM9G25-EK with Macronix MX60LF8G18AC flash.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 69 ++++++++++++++++++++++++++++++++
>  include/linux/mtd/rawnand.h      |  8 ++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 48e3685d995..30aa578e074 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -991,6 +991,75 @@ static int nand_onfi_set_timings(struct mtd_info *mtd, struct nand_chip *chip)
>  				       tmode_param);
>  }
>  
> +/**
> + * nand_onfi_read_unique_id - read the ONFI unique ID sequence
> + * @chip: NAND chip descriptor
> + * @buf: destination buffer
> + * @len: size of the destination buffer
> + *
> + * Issues the ONFI UNIQUE_ID command sequence, validates the unique ID and
> + * copies it into @buf.
> + *
> + * Return: 0 on success or negative error code otherwise.
> + */
> +int nand_onfi_read_unique_id(struct nand_chip *chip, void *buf,
> +			     unsigned int len)
> +{
> +	struct mtd_info *mtd;
> +	unsigned int copy;
> +	unsigned int byte;
> +	unsigned int copy_len;
> +	u8 raw_id[ONFI_UNIQUE_ID_LEN * 2];
> +	u8 *out = buf;
> +	int ret = -EIO;
> +
> +	if (!chip)
> +		return -EINVAL;
> +
> +	if (len && !buf)
> +		return -EINVAL;
> +
> +	if (len > ONFI_UNIQUE_ID_LEN)
> +		return -EINVAL;
> +
> +	if (!chip->onfi_version)
> +		return -EOPNOTSUPP;
> +
> +	mtd = nand_to_mtd(chip);
> +	nand_get_device(mtd, FL_READING);
> +	chip->select_chip(mtd, 0);
> +
> +	chip->cmdfunc(mtd, NAND_CMD_UNIQUE_ID, 0, -1);
> +
> +	for (copy = 0; copy < ONFI_UNIQUE_ID_COPIES; copy++) {
> +		for (byte = 0; byte < ONFI_UNIQUE_ID_LEN * 2; byte++)
> +			raw_id[byte] = chip->read_byte(mtd);
> +
> +		for (byte = 0; byte < ONFI_UNIQUE_ID_LEN; byte++) {
> +			u8 lo = raw_id[byte];
> +			u8 hi = raw_id[byte + ONFI_UNIQUE_ID_LEN];
> +
> +			if ((lo ^ hi) != 0xff)
> +				break;
> +		}
> +
> +		if (byte == ONFI_UNIQUE_ID_LEN) {
> +			copy_len = min_t(unsigned int, len, ONFI_UNIQUE_ID_LEN);
> +
> +			if (len)
> +				memcpy(out, raw_id, copy_len);
> +
> +			ret = 0;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	nand_release_device(mtd);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nand_onfi_read_unique_id);
> +
>  /**
>   * nand_setup_data_interface - Setup the best data interface and timings
>   * @chip: The NAND chip
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 3e80b134063..87083c34aed 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -88,6 +88,7 @@ void nand_wait_ready(struct mtd_info *mtd);
>  #define NAND_CMD_READID		0x90
>  #define NAND_CMD_ERASE2		0xd0
>  #define NAND_CMD_PARAM		0xec
> +#define NAND_CMD_UNIQUE_ID	0xed
>  #define NAND_CMD_GET_FEATURES	0xee
>  #define NAND_CMD_SET_FEATURES	0xef
>  #define NAND_CMD_RESET		0xff
> @@ -409,6 +410,10 @@ struct onfi_ext_param_page {
>  	 */
>  } __packed;
>  
> +/* ONFI unique ID */
> +#define ONFI_UNIQUE_ID_LEN 16
> +#define ONFI_UNIQUE_ID_COPIES 16
> +
>  struct jedec_ecc_info {
>  	u8 ecc_bits;
>  	u8 codeword_size;
> @@ -1385,4 +1390,7 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
>  /* Default extended ID decoding function */
>  void nand_decode_ext_id(struct nand_chip *chip);
>  
> +int nand_onfi_read_unique_id(struct nand_chip *chip, void *buf,
> +			     unsigned int len);
> +

Something appears to be missing. Where is this function called ?

Eugen>  #endif /* __LINUX_MTD_RAWNAND_H */

