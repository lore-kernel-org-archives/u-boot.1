Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4547C02194
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E7780137;
	Mon,  3 Feb 2025 14:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkhSdNxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFC9801DE; Mon,  3 Feb 2025 08:09:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020BD80087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 08:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so45951165e9.2
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738566588; x=1739171388; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xwha4QUozh1fXVaH2DTheS25IqZg0mYpj5SHLidPSXM=;
 b=TkhSdNxEglXJquLaPV1TQpX+/3Ggos82lC+Viu9q40GXyDPiNer4mBq5ZrODPcAs3q
 w/RZscTAT+/TZ55OQJPpcsMtglhJA830RxDjKPipurC+dwXFkhfjT25B0wHI0bxKch58
 G3HaSBjtWNWEX4oiGPPoITLd0WgaxHT/I73mMPrObMuh26tgH5yV7dTKwddibwzNEsLJ
 Fp5gDUHBJUo0F3n94zlMB7LePnTMPYqm/nKaoQKMoHEcZnFHD1H01fx72+YWEEbFBbWR
 ZkJSp5LVbUqwBpmmEkGDd8EXC+K+vClLE2fcElzO+BtNL/zuvxaX6kjGRBOFvx/H4H4G
 7VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738566588; x=1739171388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xwha4QUozh1fXVaH2DTheS25IqZg0mYpj5SHLidPSXM=;
 b=Jk/xI2dSyrlEwNnICisT06A/oY/qO6F5SMPfNu4nPpiRkL+bjBhA4Vs39jqcNEBtnY
 YSse3m57mv0vg3hf5sf4xJHG+ot4TqwRsp10UyjONDJaV6UJcVm262wI/e8bwAJ8zg4c
 bjxau9U69yFasnBMi+9V0ZmtULdHqW7ZYoelvjrBYIdn17GaxExcTpLQwxrncxD/7jo3
 aapNLbD7H5TKbEt/Crr7y3l7Ez4laQZcoOa12V5wCnba/hOnwVUkfu3PHg+b4vX2UX8m
 ukLwBpJQOh+0Rp+cEyDzja2k6do0rLRiipM8TEnJHNXQ1MKoeD8nJlqVOtDdHdRVlqzD
 UJxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxV0jQdxQBMtk9XN/CZM89Pdc4L0OPcC/SojbNfVQJyKg82d/HZTCGOTq/WN7lKP19cP/HeHk=@lists.denx.de
X-Gm-Message-State: AOJu0YwWFdoRCS6jctrckNHnuhrr5Pyd4R5H4DK1eVle8rnc8oDA7Bxj
 8fZ8UJgedmKQTcPUBH2JQocpMimqa+QiKf/AKhUtyfQrzhptnfwv7T33P1a+7HQ=
X-Gm-Gg: ASbGnctrqZc9c9qJOv2jccEZBqW0SxUbN4TuJlcqVwU3TDTABYQOLSy8XTbee2BPHgR
 vgT8LN13Tjamu89XDcNFbSUxWAFmnFsPsgTJPcQiTtZFQlLilD7rRO3phsOeE8VypAjNMqdfSKx
 qjvc068rXOwbGoRu7vXhe/IOCHkE7aNCbDnhYYdsiidn6miXWHo1Ippos/Trav/qivnDNNJZLyL
 g05pBlIiLigdY4bHr3uat1+izbJrns3VhmRdKaYmhi5wfv8utdkZbFoUeaPU4zCu9ffYz1++hko
 vEp8ziz46Kr/M/y+KG7WUmb2
X-Google-Smtp-Source: AGHT+IEp4bxpMeKZy2VNonROYB83OtuLZhyEwpwVreMQWeCDc9Y5p7kKEAX+/3pcIr1wcIYE0VSYRA==
X-Received: by 2002:a5d:64e4:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38c519378b7mr18995228f8f.5.1738566588435; 
 Sun, 02 Feb 2025 23:09:48 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7be3sm696688866b.20.2025.02.02.23.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 23:09:48 -0800 (PST)
Message-ID: <3d37d3e5-9735-4acd-9ec2-38a1706b86fa@linaro.org>
Date: Mon, 3 Feb 2025 07:09:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: spi-nor-ids: Add support for S28HL02GT
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
 <417e036a8ba6df0b793efd95e80553436ffbafd3.1738559198.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <417e036a8ba6df0b793efd95e80553436ffbafd3.1738559198.git.Takahiro.Kuwano@infineon.com>
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
> Infineon S28HL02GT is 3.0V, 2Gb Flash device with Octal interface.
> It has the same functionalities with S28HS02GT.
> 
> Link: https://www.infineon.com/dgdl/Infineon-S28HS02GT_S28HS04GT_S28HL02GT_S28HL04GT_2Gb_4Gb_SEMPER_Flash_Octal_interface_1.8V_3.0V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7e7124d1017f0631e33714d9
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index a500fff4775..503dca28b89 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -417,6 +417,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
> +	{ INFO("s28hl02gt",  0x345a1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
>  	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
