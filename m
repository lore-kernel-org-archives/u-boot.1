Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAB1EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD1389086;
	Tue, 10 Sep 2024 14:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i+30LxUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C467889EB; Tue, 10 Sep 2024 09:36:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E621287873
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so4136325e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725953812; x=1726558612; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CjKq8xyFN5fe1WX7TKtvrNzu0PXuPdsnyzYNVvpO/B8=;
 b=i+30LxUwcDWyM34wiEdvwjHaD63GgmBLYuF322/N4a/a3iSxUrGgcSB+0VtmvOrH3w
 NF1Zgzj85XRLEwvQj1i1uwbs0DuzzCuILktly4C+WjACHpufgztMcfC6PU9IhWzol4Tp
 DEGCPAN0Fqs6ZkFEPI2kpmBWk5Gx/ssMpf2nOLEhjRaAVwN4OoYJ8p2CPcdkwtlDyopP
 Zq6ZD99cINlc5LpSQlNcza2S1f8b/1O+ZH4vNxLeMXqijfLGvcVlCHEy/Qo/M24ThLx4
 eH73Cgu83eWSEQLsJu9BoSCHqsDBEdNcQWpiybvf+LyCLXkPXgeCWTmqG4R5m8kf4XPZ
 H2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725953812; x=1726558612;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CjKq8xyFN5fe1WX7TKtvrNzu0PXuPdsnyzYNVvpO/B8=;
 b=qCR6Et1wMW7ChZy2PXxV0h8d+6bAYdPrMa1ntVjfg02M1vy9/D1jEOUMo+TKD3sXMM
 EkISYZKrsOCDVYU8r9J0Ah/sElTwv7WRgo6K29lkrCPhfCiu9MODId0OhdF0ZKUDEbSA
 ptdTQhwJwQweFPMKy9keSb3KOI9+L8YDgUFvA83ZGpbKc0ttq1VyPNla7KgOgDhEAKE8
 mZ64h2SCy4n8IGgismPYmTlRohj24fikiHFhUVYunEVK+9ZewUZS6lZ+cNolu7gPsk6j
 BEJjvBlsdiJ2Eo/d1TvXb0PqHB2QTyu7RXi7oWbg9DVlCX/MlF3qFPG4FF3CJUoo41CD
 XikQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUEg+Iq+jm0SHLCdxxv8CEaE+YKKMWER51pKKA/7gvE/foF30SI9OgZdt3ATQbYxtJAj5IJKs=@lists.denx.de
X-Gm-Message-State: AOJu0YyEjtZELBDqNqNA30yauM1bwL/mJb2KY8m6F3YPYrUTtNF+cXYc
 et2OdHrWHgHcAvibUXEs7PbneNSJLmNYFPcFdmOLOTMuGlyER4hEX1YOZAOoJ2c=
X-Google-Smtp-Source: AGHT+IEg4GOY5vet/agNsMABHbsjfD6LXmWU4vWkzEU0tZl+2bUQquXxjygWHvTVg8dJDUueXY5UPA==
X-Received: by 2002:a05:600c:1c13:b0:42c:bd4d:e8dd with SMTP id
 5b1f17b1804b1-42cbd4df73bmr19493175e9.11.1725953811978; 
 Tue, 10 Sep 2024 00:36:51 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01d3d17sm11824365e9.0.2024.09.10.00.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:36:51 -0700 (PDT)
Message-ID: <0a3740c6-9b05-4263-b1bb-21579b85599d@linaro.org>
Date: Tue, 10 Sep 2024 10:36:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mtd: spi-nor: Set the 4-Byte Address Mode method
 based on SFDP data
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, mwalle@kernel.org,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
 <6867284bf369280409cc1792b67ac37388dff9a1.1722917617.git.Takahiro.Kuwano@infineon.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <6867284bf369280409cc1792b67ac37388dff9a1.1722917617.git.Takahiro.Kuwano@infineon.com>
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
> This patch partially ports the Linux commit:
> 4e53ab0c292d ("mtd: spi-nor: Set the 4-Byte Address Mode method based on
>                SFDP data")
> 
> BFPT[DWORD(16)] defines the methods to enter and exit the 4-Byte Address
> Mode. Parse BFPT to determine the method. Will rename the methods with
> generic names in a further patch, to keep things trackable in this one.

aren't the names already generic?
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 40 +++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index d523c045f4..54fd2869a2 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -96,6 +96,7 @@ struct sfdp_header {
>   */
>  #define BFPT_DWORD(i)		((i) - 1)
>  #define BFPT_DWORD_MAX		20
> +#define BFPT_MASK_CHECK(dword, mask)		(((dword) & (mask)) == (mask))

follow linux, what was wrong with SFDP_MASK_CHECK,  why did you rename it?
>  
>  /* The first version of JESB216 defined only 9 DWORDs. */
>  #define BFPT_DWORD_MAX_JESD216			9
> @@ -161,6 +162,32 @@ struct sfdp_header {
>  #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
>  #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
>  
> +#define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
> +#define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
> +#define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
> +#define BFPT_DWORD16_EN4B_16BIT_NV_CR		BIT(28)
> +#define BFPT_DWORD16_EN4B_BRWR			BIT(27)
> +#define BFPT_DWORD16_EN4B_WREAR			BIT(26)
> +#define BFPT_DWORD16_EN4B_WREN_EN4B		BIT(25)
> +#define BFPT_DWORD16_EN4B_EN4B			BIT(24)
> +#define BFPT_DWORD16_EX4B_MASK			GENMASK(18, 14)
> +#define BFPT_DWORD16_EX4B_16BIT_NV_CR		BIT(18)
> +#define BFPT_DWORD16_EX4B_BRWR			BIT(17)
> +#define BFPT_DWORD16_EX4B_WREAR			BIT(16)
> +#define BFPT_DWORD16_EX4B_WREN_EX4B		BIT(15)
> +#define BFPT_DWORD16_EX4B_EX4B			BIT(14)
> +#define BFPT_DWORD16_4B_ADDR_MODE_MASK			\
> +	(BFPT_DWORD16_EN4B_MASK | BFPT_DWORD16_EX4B_MASK)
> +#define BFPT_DWORD16_4B_ADDR_MODE_16BIT_NV_CR		\
> +	(BFPT_DWORD16_EN4B_16BIT_NV_CR | BFPT_DWORD16_EX4B_16BIT_NV_CR)
> +#define BFPT_DWORD16_4B_ADDR_MODE_BRWR			\
> +	(BFPT_DWORD16_EN4B_BRWR | BFPT_DWORD16_EX4B_BRWR)
> +#define BFPT_DWORD16_4B_ADDR_MODE_WREAR			\
> +	(BFPT_DWORD16_EN4B_WREAR | BFPT_DWORD16_EX4B_WREAR)
> +#define BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B	\
> +	(BFPT_DWORD16_EN4B_WREN_EN4B | BFPT_DWORD16_EX4B_WREN_EX4B)
> +#define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
> +	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
>  #define BFPT_DWORD16_SOFT_RST			BIT(12)
>  #define BFPT_DWORD16_EX4B_PWRCYC		BIT(21)
>  
> @@ -2372,7 +2399,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  	struct sfdp_bfpt bfpt;
>  	size_t len;
>  	int i, cmd, err;
> -	u32 addr;
> +	u32 addr, dword;
>  	u16 half;
>  
>  	/* JESD216 Basic Flash Parameter Table length is at least 9 DWORDs. */
> @@ -2510,6 +2537,17 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		break;
>  	}
>  
> +	/* 4-byte address mode entry */
> +	dword = bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK;
> +	if (BFPT_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_BRWR))
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
> +	else if (BFPT_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B))
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
> +	else if (BFPT_MASK_CHECK(dword, BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B))
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
> +	else
> +		dev_dbg(nor->dev, "BFPT: 4-Byte Address Mode method is not recognized or not implemented\n");
> +

you need to specify in the commit message whether SFDP parsing can
change the set_4byte_addr_mode set based on MFR and explain what happens.

>  	/* Soft Reset support. */
>  	if (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_SOFT_RST)
>  		nor->flags |= SNOR_F_SOFT_RESET;
