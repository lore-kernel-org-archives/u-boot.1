Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F5C02194
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7354D80077;
	Mon,  3 Feb 2025 14:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qSgdPAqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A12801DE; Mon,  3 Feb 2025 08:09:31 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274C180087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 08:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5db689a87cbso7969095a12.3
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 23:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738566568; x=1739171368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rM3ppOBR2nKIzsDMEDItm6Zz1mTWjMv89cCd8AKrm3c=;
 b=qSgdPAqnHEJSh/b3ewuFqK6YaTzIIIlJ/gCt0NuR41SClVE22PDOcOV4/nu358RP2E
 yxukuHSV9UfpK/DfeZcI38f0DZNKeA6dfkzw22UsWJj9WXkZxrLswxem5gcZPrpuJFYT
 +0aQBp8t2lNPyLGIaZ+gMi2zR2rjR1dcq91l/fcWin58rKdoBgapvT/lFGCpDyIRer7i
 2eFQVVs2E67EYS/UowMphIY/6le+VX/LN80T97Krh6pnoQb8Zq57p+pLjQ/K8c7fGbvO
 qvbDx98yjC6CuBA6CFelHvuX4Knt0/9GAFMVGPcBtPpHFpUzWunME8bqlPi7UVpHziex
 eFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738566568; x=1739171368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rM3ppOBR2nKIzsDMEDItm6Zz1mTWjMv89cCd8AKrm3c=;
 b=f7pY22TB3Q9GTFrl+r8Z7WHT/aL0/yc8BHG3WEIwKQVCLaLTF8Qg1P3zgxqYjrTcbr
 kKUCTtV13y9tVcaXp+gvPpv+MkPQVG+i+LGO2MVPsG/nHWDNb3rL0OA6dyeWWWuE+n7G
 jeZyC4izIS+Eg+qr6IuWuTGWQ5KjAIzx/O36A0hSESVMopLMgrFU1eWluRbwYQC/buV8
 UR7NBqZAx17JhJRxzm2HHWoncc3JdPL+0N+1B/oqXyEG6CaxvK6Hiscq6LJjLwgmUygH
 fmZJIl2fOgTbFBta/XxKPcPlG2EL0U8fI99V04Wkfmum8wdTPBlHlCdXLefG/mBiuHFR
 Yo6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA5V5zCKfoaRTPoG5yEDpQ3M5Nb6WCVo7c8AsG12VNOYJ/mntcp47SpCRYqNXSVycINLJUpOE=@lists.denx.de
X-Gm-Message-State: AOJu0YxtNYH06T87qPWng/NMGjYFwTW+/ghj/7sTo8HpxYM+HxbFB0Qw
 FaNoiuUjhKsFB1FZdeEnYeNdLY7aSsvgp7PXeKOi9MXpJc8emKYKxti1IIT/J/g=
X-Gm-Gg: ASbGncui0KQ6wD0xfXi9gdK4AFEEYmUYwaXknZSsB3KzG7JqSFv4GJz34YGP1cUdfmM
 xSr3eM2b34bSzcZ8Ga1d1O95RLVS/aJUN9ZjUuKFPemoSXqK4w+DS34XwrLeI8g62sHBziii0Ol
 MGWMDEPj+AuDNOYPi53TrZgCGmM9BFD9vaQE+Yg5SFLtjakSJSPs5qMgrKXSRY9Ox6T67Jg5aAo
 zXbteOTr4Jdshxsr1bAeqJH38AqFUYcaxW8mCdOTboR9KWcY1cFHFTMlV6lINbjGwEkx1GLllcj
 pr7Bbf4pBaE0UDi/MJswESvV
X-Google-Smtp-Source: AGHT+IEbw6CjRjHbfF5XoYxBIM9Id7TdaSDRik+/OEkh8weSsKFk47TkXNa1RLFfYBwNsu6Cv29Rrw==
X-Received: by 2002:a05:6402:2812:b0:5d3:ba42:e9f4 with SMTP id
 4fb4d7f45d1cf-5dc5f00850fmr22651989a12.23.1738566568558; 
 Sun, 02 Feb 2025 23:09:28 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.251])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc724c9da7sm7188313a12.79.2025.02.02.23.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 23:09:28 -0800 (PST)
Message-ID: <fee16a82-e741-4b16-829c-89d3e24d4363@linaro.org>
Date: Mon, 3 Feb 2025 07:09:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: spi-nor-ids: Add support for S28HL256T
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
 <5f1ab4dadd59ee2a5834afed840be5ca19ff4241.1738559198.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5f1ab4dadd59ee2a5834afed840be5ca19ff4241.1738559198.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 03 Feb 2025 14:10:19 +0100
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



On 2/3/25 5:17 AM, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Infineon S28HL256T is 3.0V, 256Mb Flash device with Octal interface.
> It has the same functionalities with S28HS256T.
> 
> Link:https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 91ae49c9484..a500fff4775 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -414,6 +414,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
>  		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  #ifdef CONFIG_SPI_FLASH_S28HX_T
> +	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
