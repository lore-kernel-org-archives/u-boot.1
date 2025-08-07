Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B697CC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A63D845C5;
	Thu,  7 Aug 2025 17:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IGKw+TdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3296845C0; Thu,  7 Aug 2025 17:09:48 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D59B845D3
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso7781115e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579386; x=1755184186; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yrg90hnHDiWZZZg83Ra4wCTIaplXu5dMwSvKiPdlVgw=;
 b=IGKw+TdNA9hWfb385OuXO4GgUmh7P31Jz6Cuqu4r+DEf6GyDsiPVD2yPSS4tS8ffYS
 J1nKgymR8IbbnK2WCiPPAMvICr3ospuc2b9lvjUZr3944Q2aLWdAhEfHXzLXIcYbLIOH
 UTZyUF3gwyITm/jeU1w0AGuES8KApxLa+imNTdbo/Jv2M/KglpPlDMB722WDMd3UOEYO
 P940MeTxUgUoIMijj4b5Q3JO5b/IR5JiMmmBVZdK1j3jebQ5KQ98dlmuyGieQnJwbflE
 S6nKB4RbGBcN5PJT5/ZCJ9rD0dxgF/ZlkIaOGLmd58D7bGBCOc9aMm++mQhTNrC7PKQI
 bqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579386; x=1755184186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yrg90hnHDiWZZZg83Ra4wCTIaplXu5dMwSvKiPdlVgw=;
 b=bnj8CdC9lv5Fw1z9itrq5m87nVevHbqpOfXq2tyGp6Siqr/vKbt/53qcN9X2QvqeIL
 ex6rd6EfRSbgFs7fL7+cZpv9Cu6RLtnWNcEO/F9UgdFZFvkfGEKl+3PYEBHpkUOjn7bL
 PMXSuRGi38hQHhWScjbvDfzLdLFtxqzQOaC4Ee/wG8+LTuN00FSnrW3ISFVAcs0P6dhp
 IMkLX5OY3dCVtyCMF10SOWf8dkL8J54SEg6grr0yBpobOwfodyo/zYEQuiAm78R+rJOy
 Apy86g7Z6Vx9/jxJ7qBCZY8nQV1VA0kMKU8lM9b7MMnEKpEj5M4ElfSeUy/vIibzh7iv
 Zs1Q==
X-Gm-Message-State: AOJu0YxSaM35vDwSGuMDYSk8rIoa5TWPmpMk3OES2taEyvGtAcYm6uAl
 RbELd0/y1fRBkx6nDMobp9xOZjY5C0NAO3qThFiUppiug0RnnoO/4ft86QhlP84dFwY=
X-Gm-Gg: ASbGncuo+MXkEN5twelzB2VGaZDKzhd8DwC+mN0cjRbs7potSOU6X8U/dB/jjzlXIT8
 qQispL2526AQFoi0UKHWifvJenW6EPdqcIIpiheWdHcuiQ4RhkW4hb8yap5tudqwwAb1U1fPJb8
 SRurylNp461z/sAG3dN2DRlHa/JUqYDlQcwA7zIyHagnr/Pefyy8UQYl3Ej/FMHNqQJJ6QtCx0Q
 cbJ0C0DRnoAS5siIanudTFl6BOHaw5zHkOEVlN+6EQwzFHMDvUBEUCqYBmsK4LAU2divvKFTRk5
 vWF6L1S7lCm2q1tDK4f8bpdzKPLVkiIis/FP6U8aeLR1rD7gd5NF/CnqAnQGWn0Dqmag8ppgPyk
 B06uwBO6GkOH4VrFKxOdfYA6o/myErxbe6r68tNisfana/OVvPrM31CEnUpMzanA6M1UaTT0wcT
 RhaA==
X-Google-Smtp-Source: AGHT+IEhknnPbHRGP7M4haFfuwUKNtLzMa0WDZ3Lr/8shBaWamBbcyOlbihgODQgtFtAlrwqUL57eA==
X-Received: by 2002:a05:600c:310b:b0:459:dde3:1a27 with SMTP id
 5b1f17b1804b1-459e7103893mr61764465e9.26.1754579385960; 
 Thu, 07 Aug 2025 08:09:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm12860396f8f.19.2025.08.07.08.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:09:45 -0700 (PDT)
Message-ID: <f7b3bf62-5255-496b-840f-ecb935991d0b@linaro.org>
Date: Thu, 7 Aug 2025 16:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sata: sata_mv: Remove always true test
To: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20250722-sata_mv-v1-1-ad4f3589a67b@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250722-sata_mv-v1-1-ad4f3589a67b@linaro.org>
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

On 22/07/2025 17:42, Andrew Goodbody wrote:
> Smatch reported an issue with a test that was always true in that an
> unsigned variable will always be >= to zero. This led to a closer look
> at the code which showed that some static functions returned values that
> were always discarded so make those functions return void. Also make
> the passing of block counts in those functions always use lbaint_t.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/ata/sata_mv.c | 43 ++++++++++++++++---------------------------
>   1 file changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ac78760a33e..82dc5304dde 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -363,7 +363,7 @@ static int mv_start_edma_engine(struct udevice *dev, int port)
>   	return 0;
>   }
>   
> -static int mv_reset_channel(struct udevice *dev, int port)
> +static void mv_reset_channel(struct udevice *dev, int port)
>   {
>   	struct mv_priv *priv = dev_get_plat(dev);
>   
> @@ -374,8 +374,6 @@ static int mv_reset_channel(struct udevice *dev, int port)
>   	udelay(25);		/* allow reset propagation */
>   	out_le32(priv->regbase + EDMA_CMD, 0);
>   	mdelay(10);
> -
> -	return 0;
>   }
>   
>   static void mv_reset_port(struct udevice *dev, int port)
> @@ -578,9 +576,9 @@ static void process_responses(struct udevice *dev, int port)
>   	}
>   }
>   
> -static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
> -			       struct sata_fis_h2d *cfis,
> -			       u8 *buffer, u32 len, u32 iswrite)
> +static void mv_ata_exec_ata_cmd(struct udevice *dev, int port,
> +				struct sata_fis_h2d *cfis,
> +				u8 *buffer, labint_t len, u32 iswrite)
>   {
>   	struct mv_priv *priv = dev_get_plat(dev);
>   	struct crqb *req;
> @@ -589,7 +587,7 @@ static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
>   
>   	if (len >= 64 * 1024) {
>   		printf("We only support <64K transfers for now\n");
> -		return -1;
> +		return;
>   	}
>   
>   	/* Initialize request */
> @@ -653,7 +651,7 @@ static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
>   	/* Wait for completion */
>   	if (wait_dma_completion(dev, port, slot, 10000)) {
>   		printf("ATA operation timed out\n");
> -		return -1;
> +		return;
>   	}
>   
>   	process_responses(dev, port);
> @@ -664,16 +662,13 @@ static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
>   		invalidate_dcache_range(start,
>   					start + ALIGN(len, ARCH_DMA_MINALIGN));
>   	}
> -
> -	return len;
>   }
>   
> -static u32 mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t start,
> -			      u32 blkcnt,
> -			      u8 *buffer, int is_write)
> +static void mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t start,
> +			       labint_t blkcnt,
> +			       u8 *buffer, int is_write)
>   {
>   	struct sata_fis_h2d cfis;
> -	u32 res;
>   	u64 block;
>   
>   	block = (u64)start;
> @@ -693,18 +688,15 @@ static u32 mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t start,
>   	cfis.sector_count_exp = (blkcnt >> 8) & 0xff;
>   	cfis.sector_count = blkcnt & 0xff;
>   
> -	res = mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
> -				  ATA_SECT_SIZE * blkcnt, is_write);
> -
> -	return res >= 0 ? blkcnt : res;
> +	mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
> +			    ATA_SECT_SIZE * blkcnt, is_write);
>   }
>   
> -static u32 mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
> -			  u32 blkcnt, u8 *buffer, int is_write)
> +static void mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
> +			   lbaint_t blkcnt, u8 *buffer, int is_write)
>   {
>   	struct sata_fis_h2d cfis;
>   	lbaint_t block;
> -	u32 res;
>   
>   	block = start;
>   
> @@ -720,19 +712,16 @@ static u32 mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
>   	cfis.lba_low = block & 0xff;
>   	cfis.sector_count = (u8)(blkcnt & 0xff);
>   
> -	res = mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
> -				  ATA_SECT_SIZE * blkcnt, is_write);
> -
> -	return res >= 0 ? blkcnt : res;
> +	mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
> +			    ATA_SECT_SIZE * blkcnt, is_write);
>   }
>   
>   static u32 ata_low_level_rw(struct udevice *dev, int port, lbaint_t blknr,
>   			    lbaint_t blkcnt, void *buffer, int is_write)
>   {
>   	struct blk_desc *desc = dev_get_uclass_plat(dev);
> -	lbaint_t start, blks;
> +	lbaint_t start, blks, max_blks;
>   	u8 *addr;
> -	int max_blks;
>   
>   	debug("%s: " LBAFU " " LBAFU "\n", __func__, blknr, blkcnt);
>   
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250722-sata_mv-40e704eb9b2b
> 
> Best regards,

Are there any comments for thsi patch please?

Thanks,
Andrew

