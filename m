Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA302E64A8A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA27489666;
	Tue,  3 Dec 2024 14:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QScQRVYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF6389535; Tue,  3 Dec 2024 11:38:09 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A75893CA
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 11:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434aabd688fso34208305e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733222286; x=1733827086; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vut/JX7AVT+BcUg/KB8KIJ2DoT1aGZZJD2+Ae4yhHNo=;
 b=QScQRVYkEvILzogkX4YNLRY9iXMT+BuLcOEY3YvmEUuL7j+TnIPHBBB2KxUbbuCzx0
 T94QayhVE9Q6P4pwTOgxZdfUwUNx6IM8vr83idPCLtPCnR7So1QY4sIvVq72P48VIhdf
 g6r6gLdp3yBYtEGbqoMIUpWISwNY39Wl/D6NxCEGBEdNZpLcZq4OStUXiEAjbg0aXeK8
 a/I7q4lMQhpRrCaKG8kM4eIBQZTUiwQCkDZ7H2uNMfbkjKEUSu3Re2fnLYHm1pgfPcV8
 NYojKyAF/4iX/ndnWyTADamlBQow0EdRHLE3ih5+32CEePkXmuz1cHYD5lUTIKXaG+nh
 8Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733222286; x=1733827086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vut/JX7AVT+BcUg/KB8KIJ2DoT1aGZZJD2+Ae4yhHNo=;
 b=TrCjWoptFqbeWXPCNVvYGeh+KF39J1QP/UNqwsrrNxfFzDMM8p+AcnCqY4+RZ8Mh+6
 H8tzKQMt0DT3uYsDvwQc73al0HbM6hLHovWJOGkoTHdTf0PfGF7MuwhKXMpH0CBnmVJY
 sFUATd1EXWtS5lHNe2TSt++D8fwbCJXfBUae49MptcXT9LNfx/7RRel0NrVVFlKtg3kq
 kCDpOsvtWq6nGAa7v8VkCYgsmW71F6wraJIBl+WucTfheLLz2kOiqqLajN5JWavAl+id
 5I7TjHGo4aAYFZJE8nDx9nHbxrjppg3jL7c7CRy8wpNgQ/MJxhBDLUXplOwh1oRHQb7S
 HXfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9BFoqLjwD5AHMUvJTmdOEnwBbeoA6qbHZEBShRmxHkidyghNFcMqYRERmZfCXJ63kB2AZWX8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9v2FigERv5gKmnlgaz3WcAIYWezHVkkBLTFpsSuIh6ov3UJSD
 zZoZkinkySlngYoD93CBrZ2mJCy4mTyy2YG9GxcblIYb7ORIU0uOU+c9mMhTYOE=
X-Gm-Gg: ASbGncsJLULYhqzcZDRYP/+x6FzYa+JWuYOauIy2kpYZXYnuUI3XL1GePxlS2EcuQml
 rZ6phKrToheJv35m2IewzuNvyikDLQY6a7h65Y2B/GS3dPpR3fo9twNWXlxF+Z7YabgTd+eYoYF
 2XqZwTK95XTdn3C/nSsFg/6sLIhoY2BC1OPlsH42o9M0zEuk/bR28rga3PQxhKxSVV4eoxc2Rdl
 DMoSSdYITWKyJ8xx3O4Gpsa716aVFY4Sr09Zh0RHq0IG4WnJ0ScVTTJCA==
X-Google-Smtp-Source: AGHT+IGkExttFVW1gIGYYOefvnKkJTybpLSlmDmk2UPS2xTIAsMNN/7RzOt6+f74sGtcZWoydAyplQ==
X-Received: by 2002:a05:600c:3b1d:b0:431:5632:4497 with SMTP id
 5b1f17b1804b1-434d0a0552emr15025255e9.26.1733222286439; 
 Tue, 03 Dec 2024 02:38:06 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa78120dsm214814225e9.24.2024.12.03.02.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 02:38:05 -0800 (PST)
Message-ID: <c4a9d8b7-9dfc-4317-b061-e6dd887d7efc@linaro.org>
Date: Tue, 3 Dec 2024 10:38:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 03 Dec 2024 14:04:42 +0100
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



On 11/29/24 10:22 AM, Venkatesh Yadav Abbarapu wrote:
> Enable mt35xu512aba_fixups for all mt35 series flashes to work
> in DTR mode, and return after nor->fixups is updated, otherwise

what DTR mode, 8D-8D-8D you mean?

> it will get overwritten with macronix_octal_fixups.
> This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
> is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Removed the SPI_XFER_SET_DDR flag.
> ---
>  drivers/mtd/spi/spi-nor-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index ec841fb13b..96f749f7a8 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -4404,8 +4404,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>  #endif
>  
>  #ifdef CONFIG_SPI_FLASH_MT35XU
> -	if (!strcmp(nor->info->name, "mt35xu512aba"))
> +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
> +	    !strcmp(nor->info->name, "mt35xl512aba") ||
> +	    !strcmp(nor->info->name, "mt35xu01g") ||
> +	    !strcmp(nor->info->name, "mt35xu02g")) {
>  		nor->fixups = &mt35xu512aba_fixups;
> +		return;
> +	}

this looks buggy. mt35xu512aba supports octal mode and I see that before
your patch nor->fixups was set to either mt35xu512aba_fixups or
macronix_octal_fixups depending on CONFIG_SPI_FLASH_MT35XU and
SPI_FLASH_MACRONIX. Why is it fine to remove macronix_octal_fixups for
mt35xu512aba?
