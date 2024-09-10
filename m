Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB54ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5745489098;
	Tue, 10 Sep 2024 14:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HBXs9n3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AACA8891E; Tue, 10 Sep 2024 09:47:04 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722DE8871A
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42ca573fd5aso34366925e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725954422; x=1726559222; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gcQpyKb/MQH69TvSByA4jUhfUXOKNSZIMmEUAdhE1g8=;
 b=HBXs9n3iTql4M4XK2ce10gV33Ufv3MjtqSHpOH+fscxXpLQFvp7Vlzqs/boxKMPbC2
 LQZ/k9Sci1t6q1LurP7hRqiNYaAeYcxjfuDDZGjI/jG5jrkOdNcF06pS63YQjNCH0tAH
 XXlwUq8KpP+z6/WWx9ylq69n3qUabi9TgeE3GKO/QLoA9kXFkI7h3/RFD3MDiO2fjzDq
 BFD/vg2KwEdj7hdqQAf4QR3Xf0BU9I7GdzONK0sCq36V3voRnoJklNWfX1mEA1SgROPJ
 FYaWzjQ1xIt/7gZPadwc6DseLY5aYWoi+s26MYcnKD+74PsuS05CvSzZzoGSf5IQf12k
 pDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725954422; x=1726559222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gcQpyKb/MQH69TvSByA4jUhfUXOKNSZIMmEUAdhE1g8=;
 b=sMndGdNYzXcK8MuXj36xYgCh/15llkMw9co6EP7ToGlFl91dj2Okw6MhLupKesPz42
 /V+8VQhrE8Jh8leTes42pH7LODNvbh7NRxdndpqTKMnCCagHNN/kebX2mez95FvzDSJh
 vOyhCuUd5x15cgJn/3mi9YJRQdfjAtOcffo00KNWabjYf8LxR5meh5t7K25jBNhZ1NJa
 th2G+Uped6XJ6r3Etcy+trRr9ygiUUaHIPyFtEniCf7HO/kATUQpMOcsUZrAj/P8P8bC
 NGBvGjhUUE9qxDeV42EYYrHVsprTtChIFHDAn/sfgGRUgDMqHDIK47prnL9X4+cje1aI
 tBaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpeNXFZMXiTRwNLNA1nd+49nviyMnGTZ0OehAhR7P5368Ho2IKFtsIiyMpAg5FcMrjJ4gZn4A=@lists.denx.de
X-Gm-Message-State: AOJu0YzrJsQXNxW5WsgQpwWKGaPutTlcPn0vfGPL6BiiT3EF/wixUbUu
 ds/CMw7AcTig2YEK2l4crtybNkNZQZuklVGIE/vqDPQHraJhjSyk3/WCL8AjeEJQigDiLyKtE04
 t
X-Google-Smtp-Source: AGHT+IGsPdUmh9GCcsLLMF1hNl2PVY78djqHafLHck5G7aAD1rjuhHTWCbhUOt/bT1Zk4uaU8WbEMQ==
X-Received: by 2002:a05:600c:1d0f:b0:42c:b4f1:f281 with SMTP id
 5b1f17b1804b1-42cb4f1f41amr50560445e9.34.1725954421533; 
 Tue, 10 Sep 2024 00:47:01 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cbc419014sm29634085e9.36.2024.09.10.00.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:47:01 -0700 (PDT)
Message-ID: <480378bc-3659-4eb8-b3ef-db4e030855e1@linaro.org>
Date: Tue, 10 Sep 2024 10:46:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: spi-nor: add generic flash driver
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, mwalle@kernel.org,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
 <51d98b0a7a12d0d89f37e0ceb114d162c3ae6263.1722917617.git.Takahiro.Kuwano@infineon.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <51d98b0a7a12d0d89f37e0ceb114d162c3ae6263.1722917617.git.Takahiro.Kuwano@infineon.com>
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



On 08.08.2024 09:00, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Our SFDP parsing is everything we need to support all basic operations
> of a flash device. If the flash isn't found in our in-kernel flash
> database, gracefully fall back to a driver described solely by its SFDP
> tables.
> 
> This patch ports the commit in Linux:
> 773bbe104497 ("mtd: spi-nor: add generic flash driver")

This info shall be the first info in the commit message.

> 
> A new flag named SPI_NOR_PARSE_SFDP is defined to perform SFDP parse for
> the spi-nor-generic. And spi_nor_read_id() is moved to later part than
> SFDP functions.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/sf_internal.h  |  1 +
>  drivers/mtd/spi/spi-nor-core.c | 95 ++++++++++++++++++++++++----------
>  2 files changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
> index 57608750c9..f7b0cea983 100644
> --- a/drivers/mtd/spi/sf_internal.h
> +++ b/drivers/mtd/spi/sf_internal.h
> @@ -68,6 +68,7 @@ struct flash_info {
>  #define SPI_NOR_HAS_SST26LOCK	BIT(14)	/* Flash supports lock/unlock via BPR */
>  #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
>  #define SPI_NOR_OCTAL_DTR_READ	BIT(16)	/* Flash supports Octal DTR Read */
> +#define SPI_NOR_PARSE_SFDP	BIT(17)	/* Parse SFDP tables */
>  };
>  
>  extern const struct flash_info spi_nor_ids[];
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index feafc48a49..c1186271a4 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1509,31 +1509,6 @@ static int stm_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  #endif /* CONFIG_SPI_FLASH_STMICRO */
>  #endif
>  
> -static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> -{
> -	int			tmp;
> -	u8			id[SPI_NOR_MAX_ID_LEN];
> -	const struct flash_info	*info;
> -
> -	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
> -	if (tmp < 0) {
> -		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
> -		return ERR_PTR(tmp);
> -	}
> -
> -	info = spi_nor_ids;
> -	for (; info->name; info++) {
> -		if (info->id_len) {
> -			if (!memcmp(info->id, id, info->id_len))
> -				return info;
> -		}
> -	}
> -
> -	dev_err(nor->dev, "unrecognized JEDEC id bytes: %02x, %02x, %02x\n",
> -		id[0], id[1], id[2]);
> -	return ERR_PTR(-ENODEV);
> -}
> -

the linux commit didn't move code around, so don't do it here. If needed
specify why and do it in a dedicated commit. If you care about not
mixing sfdp code with core code, let's late on introduce sfdp.c.

>  static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  			size_t *retlen, u_char *buf)
>  {
> @@ -2154,6 +2129,17 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
>  }
>  
>  #if CONFIG_IS_ENABLED(SPI_FLASH_SFDP_SUPPORT)
> +
> +static const struct flash_info spi_nor_generic_flash = {
> +	.name = "spi-nor-generic",
> +	/*
> +	 * JESD216 rev A doesn't specify the page size, therefore we need a
> +	 * sane default.
> +	 */
> +	.page_size = 256,
> +	.flags = SPI_NOR_PARSE_SFDP,

what was wrong with .parse_sfdp = true ?
