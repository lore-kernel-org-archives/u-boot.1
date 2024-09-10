Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D65EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B518902F;
	Tue, 10 Sep 2024 14:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pxzwHNy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FB888EBC; Tue, 10 Sep 2024 09:28:05 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2461A88F22
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42ca573fd5aso34206995e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725953281; x=1726558081; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFA8VrHcDrHU7wcR6cwIEGXIFjGRu+fK1oLPXAPRFKM=;
 b=pxzwHNy2Gw78jJ9LiB2GHz18OfdVk6Pph599msOYbLSHSBt311K0zq3KCvoKdNsNZx
 IotXOpftnyc/4JirK3rtNukbU/Dnb3jBvC7jUB6c8HxSySX003q1W+caTQosqfqZHnGs
 oh4AWZCljbETkU1RxbJeo3LZsi9xzebyDxqA/KEGDJRrGZpcI2kHks0wdfRJW979waiL
 qnrPMjCChSsb6rpSiNS9bd6zEFH7Cwmm9Rg4XPBomz6o7Rs79xXBIwxew18H2H/FG5w5
 yzRAJhaaRxj1UhZEPbpdf5CUUVgFRfG/+g0agpqXtvgi8WCFrO35WplB2qa27U7w2i0f
 fdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725953281; x=1726558081;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFA8VrHcDrHU7wcR6cwIEGXIFjGRu+fK1oLPXAPRFKM=;
 b=Mir4Zin7jUm1JKv+pTeHEKKKcAOk88vlvyQR0i3drf5YG0BA7wfj8/4+Tqoo2ISIkW
 OuKAqVxS9A8knfGPFr2HVYnAiVFDEabjtj1GMeIiKDvw8s368KoIt9hafY/30LveQYqy
 pUN9VwxEVx35/liBR7S8ejynEGln4FHM1CmWwyVpGCxdzfRYaenUaOSDRl2SN432ptxb
 iXQZZQ7zjIYZhi3ohwbsMD0mdFc6KPpEYdKHOYfA6sHuzpkhxiAtuhekxaAug59EWi+5
 Y87pH5HlQ2UUnla/w9FBbSsCKQbwsxP+W0utB6mPHr2CtYNaZxp3QtVuzumnPzfH7LFr
 AxSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpYt/GqpdpHWvBPfpup2c+MAB/4b1pqRuA4Umext34E5yALVajsLV1uDvKyPqRqzHGIKb4+LQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzsHedNlcINYdUTdhyf6IfaRclGeGVf06GYgbVVPsZZq7e5iBje
 0LeHvOj1F1PbglOJGajPJCT7OkVkhFaU2E1Qo1ijqewi0hA+U2OHJb7ZyMmzfAI=
X-Google-Smtp-Source: AGHT+IHRPr7p/2O2S++uNKtzdLb1wWQxl4IHx0/c3d2ZJza9VcNwqTIb8l8JN+8cpK229xF2rDdCoA==
X-Received: by 2002:a05:600c:3b29:b0:42c:bae0:f059 with SMTP id
 5b1f17b1804b1-42cbae0f243mr28818025e9.5.1725953280680; 
 Tue, 10 Sep 2024 00:28:00 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb8182dsm101967355e9.36.2024.09.10.00.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:28:00 -0700 (PDT)
Message-ID: <20601751-0b93-46e3-997a-00491b43985d@linaro.org>
Date: Tue, 10 Sep 2024 10:27:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mtd: spi-nor: Rework set_4byte()
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, mwalle@kernel.org,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
 <8f058fc34c7a5e7baa2a7cb10e92a67518717e04.1722917617.git.Takahiro.Kuwano@infineon.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <8f058fc34c7a5e7baa2a7cb10e92a67518717e04.1722917617.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 14:56:36 +0200
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



On 08.08.2024 09:00, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Synchronize set_4byte() with Linux v6.10 as much as possible.

Let's aim for spi-nor/for-v6.12.

> 
> Introduce {nor, params}->set_4byte_addr_mode().
> The params->set_4byte_addr_mode is initialized with one of the
> manufacturer specific methods, copied to nor->set_4byte_addr_mode,
> then it is called from spi_nor_set_4byte_addr_mode() renamed from
> set_4byte().

this happens indeed. We need to explain why: we aim to split the
manufacturer specific code out of the core, thus introduce
set_4byte_addr_mode hook so that the manufacturers/SFDP be empowered to
pin point a specific  4byte addr mode method.

> 
> There are still manufacturer checks here and there.

unfortunately.

> And The set_4byte_addr_mode() method in both nor-> and params-> looks
> redundant. Those should be cleaned up separately in another patch set.
> 

then don't introduce it in the first place :)

> The following commits in Linux are related to this patch.
> 64c160f32235 ("mtd: spi-nor: Create a ->set_4byte() method")
> 81924dae5194 ("mtd: spi-nor: Emphasise which is the
>                genericset_4byte_addr_mode() method")
> 076aa4eac8b3 ("mtd: spi-nor: core: Move generic method to core -
>                micron_st_nor_set_4byte_addr_mode")
> 288df4378319 ("mtd: spi-nor: core: Update name and description of
>                micron_st_nor_set_4byte_addr_mode")
> f1f1976224f3 ("mtd: spi-nor: core: Update name and description of
>                spansion_set_4byte_addr_mode")
> b6094ac83dd4 ("mtd: spi-nor: core: Introduce
>                spi_nor_set_4byte_addr_mode()")

yeah, these are good for reference.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 179 +++++++++++++++++++++++++--------
>  include/linux/mtd/spi-nor.h    |   3 +
>  2 files changed, 138 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 8d2afaa0e2..d523c045f4 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -680,54 +680,123 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>  }
>  #endif /* !CONFIG_SPI_FLASH_BAR */
>  
> -/* Enable/disable 4-byte addressing mode. */
> -static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
> -		     int enable)
> +/**
> + * spi_nor_set_4byte_addr_mode_en4b_ex4b() - Enter/Exit 4-byte address mode
> + *			using SPINOR_OP_EN4B/SPINOR_OP_EX4B. Typically used by
> + *			Winbond and Macronix. Cypress also uses SPINOR_OP_EN4B
> + *			to enter, but not SPINOR_OP_EX4B to exit.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor,
> +						 bool enable)
>  {
> -	int status;
> -	bool need_wren = false;
> -	u8 cmd;
> +	u8 opcode;
> +	int ret;
>  
> -	switch (JEDEC_MFR(info)) {
> -	case SNOR_MFR_ST:
> -	case SNOR_MFR_MICRON:
> -		/* Some Micron need WREN command; all will accept it */
> -		need_wren = true;
> -		fallthrough;
> -	case SNOR_MFR_ISSI:
> -	case SNOR_MFR_MACRONIX:
> -	case SNOR_MFR_WINBOND:
> -		if (need_wren)
> -			write_enable(nor);
> +	if (enable)
> +		opcode = SPINOR_OP_EN4B;
> +	else if (JEDEC_MFR(nor->info) == SNOR_MFR_CYPRESS)
> +		opcode = SPINOR_OP_EX4B_CYPRESS;
> +	else
> +		opcode = SPINOR_OP_EX4B;
>  
> -		cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B;
> -		status = nor->write_reg(nor, cmd, NULL, 0);
> -		if (need_wren)
> -			write_disable(nor);
> +	ret = nor->write_reg(nor, opcode, NULL, 0);
> +	if (ret)
> +		return ret;
>  
> -		if (!status && !enable &&
> -		    JEDEC_MFR(info) == SNOR_MFR_WINBOND) {
> -			/*
> -			 * On Winbond W25Q256FV, leaving 4byte mode causes
> -			 * the Extended Address Register to be set to 1, so all
> -			 * 3-byte-address reads come from the second 16M.
> -			 * We must clear the register to enable normal behavior.
> -			 */
> -			write_enable(nor);
> -			nor->cmd_buf[0] = 0;
> -			nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
> -			write_disable(nor);
> -		}
> +	/*
> +	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended

please follow linux, and introduce winbond_nor_set_4byte_addr_mode() for
the chunk below.

> +	 * Address Register to be set to 1, so all 3-byte-address reads
> +	 * come from the second 16M. We must clear the register to
> +	 * enable normal behavior.
> +	 */
> +	if (!enable && JEDEC_MFR(nor->info) == SNOR_MFR_WINBOND) {
> +		ret = write_enable(nor);
> +		if (ret)
> +			return ret;
>  
> -		return status;
> -	case SNOR_MFR_CYPRESS:
> -		cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B_CYPRESS;
> -		return nor->write_reg(nor, cmd, NULL, 0);
> -	default:
> -		/* Spansion style */
> -		nor->cmd_buf[0] = enable << 7;
> -		return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
> +		nor->cmd_buf[0] = 0;
> +		ret = nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf,
> +					1);
> +		if (ret)
> +			return ret;
> +
> +		ret = write_disable(nor);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * spi_nor_set_4byte_addr_mode_wren_en4b_ex4b() - Set 4-byte address mode using
> + *			SPINOR_OP_WREN followed by SPINOR_OP_EN4B or
> + *			SPINOR_OP_EX4B. Typically used by ST and Micron flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
> +						      bool enable)
> +{
> +	int ret;
> +
> +	ret = write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
> +	if (ret)
> +		return ret;
> +
> +	return write_disable(nor);
> +}
> +
> +/**
> + * spi_nor_set_4byte_addr_mode_brwr() - Set 4-byte address mode using
> + *			SPINOR_OP_BRWR. Typically used by Spansion flashes.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
> + *		address mode.
> + *
> + * 8-bit volatile bank register used to define A[30:A24] bits. MSB (bit[7]) is
> + * used to enable/disable 4-byte address mode. When MSB is set to ‘1’, 4-byte
> + * address mode is active and A[30:24] bits are don’t care. Write instruction is
> + * SPINOR_OP_BRWR(17h) with 1 byte of data.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
> +{
> +	nor->cmd_buf[0] = enable ? BIT(7) : 0;

what's wrong with enable << 7? Keep the code as it was, don't update it
on the fly.

> +	return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
> +}
> +
> +/* Enable/disable 4-byte addressing mode. */
> +static int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
> +{
> +	int ret;

follow linux and do the if (nor->flags & SNOR_F_BROKEN_RESET) check
here. You'll have a good debug message for your flashes too ...
> +
> +	ret = nor->set_4byte_addr_mode(nor, enable);
> +	if (ret)
> +		return ret;
> +
> +	if (enable) {
> +		nor->addr_width = 4;
> +		nor->addr_mode_nbytes = 4;
> +	} else {
> +		nor->addr_width = 3;
> +		nor->addr_mode_nbytes = 3;
>  	}

I don't see where were these done previously. Thus don't introduce new
code. If needed, make a dedicated patch and explain why you need these.

> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_SPI_FLASH_SPANSION
> @@ -2884,6 +2953,25 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		}
>  	}
>  
> +	/* Select the procedure to enter/exit 4-byte address mode. */
> +	switch (JEDEC_MFR(info)) {
> +	case SNOR_MFR_ST:
> +	case SNOR_MFR_MICRON:
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
> +		break;
> +
> +	case SNOR_MFR_ISSI:
> +	case SNOR_MFR_MACRONIX:
> +	case SNOR_MFR_WINBOND:
> +	case SNOR_MFR_CYPRESS:
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
> +		break;
> +
> +	default:
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
> +		break;
> +	}
> +

follow linux, you need to set these after parsing SFDP

>  	/* Override the parameters with data read from SFDP tables. */
>  	nor->addr_width = 0;
>  	nor->mtd.erasesize = 0;
> @@ -3272,6 +3360,9 @@ static int spi_nor_default_setup(struct spi_nor *nor,
>  	else
>  		nor->quad_enable = NULL;
>  
> +	/* Enter/Exit 4-byte address mode */
> +	nor->set_4byte_addr_mode = params->set_4byte_addr_mode;

you won't need nor->set_4byte_addr_mode, don't introduce it.

As a general comment, follow linux, just move code, don't introduce new
code. No changes in functionality shall be expected with this rework.

Looking good, thanks for working on this.
Cheers,
ta
