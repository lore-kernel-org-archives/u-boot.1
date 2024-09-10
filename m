Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A294EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6CF890A8;
	Tue, 10 Sep 2024 14:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUjsjfs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECD788EFB; Tue, 10 Sep 2024 10:05:07 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9914588B6D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so12108175e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725955504; x=1726560304; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UhV6s06m/SjlpRKJs4hQcDnOnGc2seOFqm2hvSl8+Ps=;
 b=jUjsjfs9iAaKR95XwD3CJlolI1e6vZyQ39IKdTr19gy5ZW6NCxgUh2HLq0NkgzBf/B
 6Fnx/mzDrzpE6TymD0kyLrUXgc6voQp/mdXe93smNc990GCK2n5tOze872apOoDD6T3m
 xzzqMakNL0rb2VoyNjaNh2OIz1VfQwHqs2uDZ6PGuZCjAqt3mwDMwu8j2gPk+ngX3rrI
 UQ3miGqfJGM2qxoUIFKfiQEVQbH/8IJIo4Ygw/BqIziwFODWI0pCAUSDpAmOwDSgErUR
 L8n5iPILC8LooswT81QjdGDhe80TxWVas2re4wcMY+6KlgdkhqqL9lOCUZfK1pmsj52F
 pmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725955504; x=1726560304;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhV6s06m/SjlpRKJs4hQcDnOnGc2seOFqm2hvSl8+Ps=;
 b=vF+E6z2JW4O1bdkbzdxImW16Q2X1QI0xM3JNv/KhecfMGy72JMI/7RVHHEDZIFD7ww
 jCiDQwkVEwKgWtWJZgXIBTUZ6dDZUedqdZRVWwutrOgotu8GrTu2sb3S+WwZ6Q5TdsSM
 W94cTP6MIAP+Iv/A+knpjCRhnJB2/q+CwgKseHDOP35UpyoNTdmfv+MXjnXsKQQK5A04
 IGkal1nTqYNFKzeTbfiFINx/+ZjWXgGzVwHqHIvqpGI75sjVfL6LIEfmmzaLxamZGEYi
 TEZ3aioDboEF2rZBBxGe5VbypKZFvaHiFe944yImyYwE/2PHn+0qCMrULVbGvtmhUx5H
 g5+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV17oGsgwS+ocJj769E4L7BjTM/Ha+3UEblxK9iSLCtu9ATyRMYbWK0WYCQ5fRBacOQnw373mM=@lists.denx.de
X-Gm-Message-State: AOJu0YwlCVfhxNSMuGWcnpCGS6AB2hMZckWnHXdhNT+d498wDCUgOR6A
 3PEStjq1w1L6RM26xHv4QnHQVVZGT+LoLsJcSpvs/AeAiucMD6NN
X-Google-Smtp-Source: AGHT+IEh9hJNO0RO9mo/hI5S+4Axi6PJ1hqV7BsP80xuC6357ZfN8KUxvp9FSzGGXXK48LlG8D32mA==
X-Received: by 2002:a05:600c:3b24:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-42cad769e61mr71258065e9.17.1725955503658; 
 Tue, 10 Sep 2024 01:05:03 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665108sm8100493f8f.28.2024.09.10.01.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 01:05:03 -0700 (PDT)
Message-ID: <e1f0deab-57c8-49b5-99eb-0c4547894c98@gmail.com>
Date: Tue, 10 Sep 2024 11:05:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: spi-nor-core: add 4-byte OPCODE support for
 Winbond W25Q256JV
To: Robert Marko <robert.marko@sartura.hr>, jagan@amarulasolutions.com,
 vigneshr@ti.com, trini@konsulko.com, u-boot@lists.denx.de,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20240425143627.54648-1-robert.marko@sartura.hr>
 <20240425143627.54648-2-robert.marko@sartura.hr>
From: Tudor Ambarus <tudor.ambarus@gmail.com>
Content-Language: en-US
In-Reply-To: <20240425143627.54648-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 25.04.2024 17:36, Robert Marko wrote:
> Winbond W25Q256FV and W25Q256JV share the same JEDEC ID, but only
> W25Q256JV fully supports 4-byte OPCODE-s.
> 
> In order to differentiate between them we can use the SFDP header version
> and apply a fixup post BFPT.
> 
> Based on upstream Linux commit ("mtd: spi-nor: winbond: Fix 4-byte opcode
> support for w25q256").

Linux commit info shall be the first info in the commit message. And
please give the sha1 of the commit, it spares me of grepping the log.

How about something along the lines:

Backport linux upstream commit e8aec15dd5842b5b11b0e621a2293348d3574a61 [1].

The copy the upstream commit message here.

Introduce a new paragraph if you need to add your comments.

And then add a link to the commit in torvalds's git:

Link:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8aec15dd5842b5b11b0e621a2293348d3574a61
[1]
	("mtd: spi-nor: winbond: Fix 4-byte opcode support for w25q256")

Looking good otherwise.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 7615ba602f..8882b045ce 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3816,6 +3816,32 @@ static struct spi_nor_fixups macronix_octal_fixups = {
>  };
>  #endif /* CONFIG_SPI_FLASH_MACRONIX */
>  
> +#if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
> +static int w25q256_post_bfpt_fixup(struct spi_nor *nor,
> +				   const struct sfdp_parameter_header *header,
> +				   const struct sfdp_bfpt *bfpt,
> +				   struct spi_nor_flash_parameter *params)
> +{
> +	/*
> +	 * W25Q256JV supports 4B opcodes but W25Q256FV does not.
> +	 * Unfortunately, Winbond has re-used the same JEDEC ID for both
> +	 * variants which prevents us from defining a new entry in the parts
> +	 * table.
> +	 * To differentiate between W25Q256JV and W25Q256FV check SFDP header
> +	 * version: only JV has JESD216A compliant structure (version 5).
> +	 */
> +	if(header->major == SFDP_JESD216_MAJOR &&
> +	   header->minor == SFDP_JESD216A_MINOR)
> +		nor->flags |= SNOR_F_4B_OPCODES;
> +
> +	return 0;
> +}
> +
> +static struct spi_nor_fixups w25q256_fixups = {
> +	.post_bfpt = w25q256_post_bfpt_fixup,
> +};
> +#endif /* CONFIG_SPI_FLASH_WINBOND */
> +
>  /** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
>   * @nor:                 pointer to a 'struct spi_nor'
>   *
> @@ -4004,6 +4030,11 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
>  	nor->fixups = &macronix_octal_fixups;
>  #endif /* SPI_FLASH_MACRONIX */
> +
> +#if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
> +	if (!strcmp(nor->info->name, "w25q256"))
> +		nor->fixups = &w25q256_fixups;
> +#endif /* SPI_FLASH_WINBOND */
>  }
>  
>  int spi_nor_scan(struct spi_nor *nor)
