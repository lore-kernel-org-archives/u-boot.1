Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6B3D58D40
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1537789A1E;
	Mon, 25 Nov 2024 14:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MCyOKs7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A66893AF; Mon, 25 Nov 2024 08:30:10 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BDED89399
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 08:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso7130845e9.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 23:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732519808; x=1733124608; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2TiPe+OhjRmjj1uZo9WneromPfHUY4ud651lrFydDF8=;
 b=MCyOKs7v9YSZh8BOWrHB/80Bw8ZpcCk6fDQ2BftM4YaU8beIJ+4NpHuwZhcv26DRG0
 UyrFp7uMZqAebanW+a5Xg4KdEmIsPJBXrKIFcyXwLQ9306ifoaJjrq8qXsd0XyLCslLK
 nyLSXf/YiPygLA0iYHDDtQM5jRN/jGfRXL+OBhdLiXloF+ceTzCeWGsZIxeVzcLkl0wN
 3/bGShVyl/NUX9DnFifNCi98T1sXJfbAYI7n7aNRXm3crW/QiYUY7VV5WiuWlROEzr5h
 v/r0gLaW9MlFQIt8I/L/MdcdKhtcHdYHo8d7DY2QVSaH9LWutLl4CJe+OQqGAW9cR7B8
 X5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732519808; x=1733124608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2TiPe+OhjRmjj1uZo9WneromPfHUY4ud651lrFydDF8=;
 b=M5JxAOnkC9T53q96jSCD78C1nZ3qvg/cgrtLiE6IuYyKrqMIGmRFSpohKOHIMG75rx
 wWxLo6+qk6OjIsnTIG9CfRSf1WcV14eA3q5OkAlN6xdaTVexpQKz2FRLumMU7uJtY0ww
 PPHGL8C8PHJ6gblGlmpVAWPMxJ+xngzB/amnWuOfqRTZ5Iy2xWDzjDfdEtgnJaZnK16i
 eo0RcD5oHICw9RrcC6gWLhDcqK4zJxjOHxM1WukBTqVd3LBT3K3lKl6EyO3olNqFzQ7q
 QuO5phMKWQIg3NlZ1S8LcobgkLWAafc9JGw/JLTT5RQ8+cew7noP1ByAvPXNMIPDoQsR
 jYJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnjDDi9M0cW5NwyT8qp0m78ouxwU+a9za8/6YXEAGUj0X1etBnBoSky760B03b+z1jbDZAiRg=@lists.denx.de
X-Gm-Message-State: AOJu0YxUI63AiDj5S5qUvt3wSW8RTWj0FOUfRLL9CBJGQK9HAWnqfoFG
 RHY8Fn93wtuim66v8V/aJ+x6A8+Wz2qVnulyDB8jOzhbnM4w5PlQDw0BCezV4bg=
X-Gm-Gg: ASbGncsU95ZnFkHnoir4OyKRN6JRdcC3wchybtnsnpFc5zL/Fegi92qpAh/jMpNp4Ff
 cdjse/5GOXhQaputDjOmlbKR85BHVYfikoNklHmNe+RPa8due5ANGORKqynlwT932W91ZTimpVL
 3zS3B+PJgRC0nnD15ZLM6NIKgSxLW1MUvk7y5FywYIk+W4ZKkkWUAjNuDhOeczoLoRqdF/C3fzK
 rt4nHMh5e/SwZ9tkj0BORb5hSCDeTtfLgNEJ4eJxZ3PEZSA5wJpqnO5bw==
X-Google-Smtp-Source: AGHT+IGhB/FDz3a4jfQh2Hv31rfIB/a3uATMKDpTESLnSvKpndiLwdBiaQpVp0igrzG9AN+PEt6pHw==
X-Received: by 2002:a05:600c:3b25:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-433ce4c20bemr89519595e9.32.1732519807873; 
 Sun, 24 Nov 2024 23:30:07 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349e47f3d1sm38224425e9.17.2024.11.24.23.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 23:30:07 -0800 (PST)
Message-ID: <d762e576-38a9-402a-975c-eedbf92c1dc0@linaro.org>
Date: Mon, 25 Nov 2024 07:30:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for W25Q02NW
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 git@amd.com, Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
References: <20241122094024.1392195-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241122094024.1392195-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 25 Nov 2024 14:06:45 +0100
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



On 11/22/24 9:40 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for Winbond 256MB flash W25Q02NW which supports 4byte
> opcodes and also dual and quad read.
> 
> Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 91ae49c948..d5258a1fc3 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -569,6 +569,11 @@ const struct flash_info spi_nor_ids[] = {
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  	},
> +	{
> +		INFO("w25q02nw", 0xef8022, 0, 64 * 1024, 4096,
> +			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ |
> +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4B_OPCODES)
> +	},

Does this flash support SFDP? If yes, are all these flags needed?
