Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92DDC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 10:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C12833C6;
	Tue, 22 Jul 2025 12:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eiOZE+os";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604CB833C6; Tue, 22 Jul 2025 11:20:35 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BABD8329B
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so911809666b.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753176033; x=1753780833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qIPOpSlU17Kuk9Ixf7sfA960JtkiTNh6NieoRhPEdxc=;
 b=eiOZE+osuzKdVvfaV/eblmTgzAlcYX6n68Xeui7pOzhJMWtu+w6WO4EoDnvnZ8d6Dy
 BRuCRL1/F7CgNmfMYX/dHNaPAoE3KDY17jfElu/4/iD2e+rL0EhbHt2NkM/vZKMVZKqv
 nQied7oxK4WuVGY7vRbVfVVOoXZxYmpUzAkk9xOzkK+Srfh86QCihjgomSA9ieDaWaKi
 gbfIlwmrA8uEx+1Z6hmio+TvOGmiF4s+WCR0um6xLnJj+DB7Lam3q44BLWuIyU0iDR7u
 kFr6V5P9YhiIruxmh7VPxGUvUStCMaDJK+yVWNgk3xFLyAXcT743p+dujiM4Xx8rbUfM
 dHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753176033; x=1753780833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qIPOpSlU17Kuk9Ixf7sfA960JtkiTNh6NieoRhPEdxc=;
 b=g5tutIYiC633tl0cLz0PeO6WOZJ8AxlXh9cNQGpYfTSp7sKZoHV4DEd6peei8IKW2Y
 j0SivpGi27azvPd33QO4NC6O/0lQVM1zL0TBaiFi4RveTjq/U+SfRvD1qJhvN9yDb0cd
 NrLdXO4j0cs6UNXeHcuCMjpUweFnbYK1cbvKAPrh+8ak2QDtrPf2srcSuz/maDpFhdum
 T86rFo3w9fwlhEKUbpgAw41OQNIMTdg9/DzJuipBzpewSnRfotBQtKdQKETZwR4jMHv4
 STARSfM0qZZ1ODlonICiDezXTKgUVmZMYhG6s6WhGgS3QVUdax1haGOVef//92a2n3Ha
 uPWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfp9Vhzht0qRW74XtdkHFWk4d0L7zBai/hKC6xbME3qliDMvEJOPpdJWkafKJyXeVO5nCNcWw=@lists.denx.de
X-Gm-Message-State: AOJu0YxslssvHiYA5GjovYVxcqpWmUsOOtcZGjmOXUXWES4efqbweFqG
 FGf4jyMIxNPYBaWwtp+jOjLD/Kgosdn0GASbEMfZ31DoRC8RwqlFxqdTddJ6ahVfKQs=
X-Gm-Gg: ASbGnctcLrFvpsFVs+MSt99936uTZlccoZER+cDuoYp+rVvh3dKM2xMyW2WRYy9n5Ho
 uPA1UXRQiBvBmohUgfhJJyog3AxqQjDBp9EU+aUBK1vHNvkKh3a1t0fBZpuHXUdIxbJzR1C/+ek
 rdmRQYIEedbxMBB3AqaglVSKyZNu95t5ZEYY/hzJYqKNxXuT1r9Vhir5G74B977wgaPn7Vf5QoU
 7x1flr+gj0EKU/eLJizBl9/9MR7lY6d21Gtkd45WOBl6qblizJvYIFjrPpWIirGXwSCu+XQW5WA
 E7CwIBKjGqQWg+FPP+yT9pqDZYmzUqxx2iHwy8dwyBGfViB0Y6O6HffqHysbtQo9fErTN/IxRRW
 HEBpkUMp0BeE/LROo1rFsbUq5QjdcWSME8Y3fHaxVzg==
X-Google-Smtp-Source: AGHT+IFP4mobpEaFgc/f6U0wArWrq63uF/egcveLWwFA8km+aqJtwM8qVbrKgvrTb4N7lKmx4RTx0Q==
X-Received: by 2002:a17:906:b212:b0:ae0:b7c8:d735 with SMTP id
 a640c23a62f3a-ae9c9b6c4dfmr2091728466b.42.1753176032619; 
 Tue, 22 Jul 2025 02:20:32 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.171.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6ca7a3e1sm828627266b.105.2025.07.22.02.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 02:20:32 -0700 (PDT)
Message-ID: <c3c99016-b6ae-443b-ac1e-a6c5144dd815@linaro.org>
Date: Tue, 22 Jul 2025 10:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Jul 2025 12:09:24 +0200
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



On 7/20/25 8:58 PM, Marek Vasut wrote:
> Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
> with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
> flash part is similar to W25Q512NWM .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index e7e97780d7c..0383175beb5 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },


The patch is looking fine. Any idea why SFDP parsing is optional?
I see a SPI_FLASH_SFDP_SUPPORT that guards it. Having SFDP optional
introduces headaches as one has to specify all flash parameters statically
at flash declaration. I assume it's about image size limitation. I also
see a spi-nor-tiny.c, about which I'm not thrilled. Is there a general
recommendation on when to split things? Maybe a question for Tom.

Here it seems that you specify just data that can be discovered by SFDP.
You won't need a flash entry at all if one adds a "spi-nor-generic"
flash info that initializes the flash solely on its SFDP data, see
linux. It would require porting the parsing of the 4bait table from
linux and other small changes for the rest of parameters.

Thanks,
ta
