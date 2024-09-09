Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AFEEDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B27888F24;
	Tue, 10 Sep 2024 05:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JDuUW0Ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B33388D08; Mon,  9 Sep 2024 18:52:34 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDCDE889F8
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 18:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cae6bb895so22092855e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725900751; x=1726505551; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2jto4RGk/VqSYfy9SFPtFBu9f2f9IanpIFzKDpeMJ8=;
 b=JDuUW0TsHh+X1BIziT3iNEKPdjqTQINSuzGqm1eMpvjiEA80WrRITmNY8KLwL/hxP0
 Wk0Pk3iE+/y/244ueHbGS+r8yHuKAoFiEX8RLT30N5THlQQVcvXrROfxjA0pTr3xvaW8
 ZshxzwXNQaS5Hbf7TR044dV5L+qnZFtIBU0tZ9Z8AzcQ3WM+XhP55+t4nx8fRBZkZIJK
 NPjx4cQ3PDKJoUck4pqqtKXjBcN6E+m8kU2uwY9LBtsX4Xg0DV0ukIsy0j36UPCPnq1v
 m2gJYJ5HhrksE/bMZWnMFzdB6TpvEbgkAbhuiAtOQGjwENjvQm4eDNlAWThigROvc9/h
 KcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725900751; x=1726505551;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2jto4RGk/VqSYfy9SFPtFBu9f2f9IanpIFzKDpeMJ8=;
 b=gG5LVFk7k6s2PtwLAT2Ho96F3XZAUyE+0lhz1T6CybyNeOJkC8lMle2On7hr04l9qq
 yabQUH9QxIfpTvtLOGh1K+d7hGELEB4AEm87ZECIsGrInGfl2y/ckb3W9+rl7YVRCLh8
 5jbYUYrfioAENhvMqigEkgm8nrAYmbvfoYYRowH8spwTu0/CjYuNC6MOevZQClNinA+0
 1RsXW9ilY03JbUkRi2B9cqUJONsElXBQobRVWnXTW7bEYoVPzi0sHWvKYim9r0wCRHn+
 QBof/dG/oaxWLPBibQUetJmNgUOKWwgcYEC/AxDhg+vnQQpiVS678eJWbfdrafCpVHSV
 l9Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNAIuBqesQU1H8qWGpj/eMl8QgR9XQ8++jGNwc5BHnsGkKA1SuEzD0Hlpn3EtQTjmL5RGHObc=@lists.denx.de
X-Gm-Message-State: AOJu0YzyUcRviwMkzKeieczpcIdq9UdHJG/trliPhpAklBhIaTgYREF+
 plEbpIR/SuPNzsjnQ2l5wWoTNXX0EtFz6iQI2GeG9IWzq909ZWPAA2fWSXgYvSE=
X-Google-Smtp-Source: AGHT+IGVszc8rTfcTphC7ywgzL2npnyqYHp4W0BgL4WPmra4q4Neg1gH405AGKhxvGgey/gA3Zm2kw==
X-Received: by 2002:a05:600c:3ca1:b0:42b:8a35:1acf with SMTP id
 5b1f17b1804b1-42c9f9ca788mr90098305e9.25.1725900750287; 
 Mon, 09 Sep 2024 09:52:30 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05c2845sm114389955e9.3.2024.09.09.09.52.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 09:52:29 -0700 (PDT)
Message-ID: <59b8c0b7-61d7-4a51-9b44-e63e5de51399@linaro.org>
Date: Mon, 9 Sep 2024 19:52:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for S28HS256T
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20240830050012.28870-1-Takahiro.Kuwano@infineon.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240830050012.28870-1-Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 05:19:45 +0200
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



On 30.08.2024 08:00, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Infineon S28HS256T is 256Mb Octal SPI device which has same
> functionalities with 512Mb and 1Gb parts.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
> Datasheet can be found:
> https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
> 
> Tested on Xilinx Zynq-7000 board and Infineon internal SPI controller.
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 457965dad1..5769e662e0 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -383,6 +383,7 @@ const struct flash_info spi_nor_ids[] = {
>  #ifdef CONFIG_SPI_FLASH_S28HX_T
>  	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
> +	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
