Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993E0C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 12:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9828376C;
	Tue, 22 Jul 2025 14:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zmUSWDeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE63783847; Tue, 22 Jul 2025 13:55:41 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6040A83837
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so11502906a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753185339; x=1753790139; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YfiVRx4UMT12pceZJU2pxYbC3K4GGqUSSQ1k8NpLGMY=;
 b=zmUSWDeWgNrTmAnKEOjOOol4p7p4wG/pzoJ6BaN+GbMtvjICdjUZkSK9cEUKi3y5o3
 ymSFqt6zhdN3Jeaavf/NnD4Ju9EULX5O/d0JbTBa+4nGaEYO6PCcVrol2o/DrlGVX9yW
 uz01CM6JvZQF4RE/S2fwYFENZ6/HRJPqS+Tm3/yf97SB3onmg/252tfkp9eKYZEug2oY
 hlf2pXX2VhSAKqfiD2aZx8+8cSOIPLg+0bUuLQzrH2qAoqAfHyxVozR2JJgs1uCsBtxb
 Nr/lgXuAhdwhPiF1nxay+/UIkkNFrA2EVTQuoW0Pe0M3K5SEvx9zrVn47MwuSKLBN7fa
 Rykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185339; x=1753790139;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfiVRx4UMT12pceZJU2pxYbC3K4GGqUSSQ1k8NpLGMY=;
 b=aFrRYuvW9O5lk3hYo8htyvmr1MxM2s54oaU59uIRlNC5KmEJL4tb68BPuu8RuON73f
 oorPp7ahVgt+Je5nNcXE1a9m41871cD3DU3IutJEB928lO+qF1MILX+bUhDwkw24y3fV
 B9w3Eeq+VVfkzVaQaUj23QnY1My3oH5Vpt5V7amWjS9sQJGgimjm2G1xpMF8ps5ygQgR
 qvdL074GtiLt+9sfgxr2w91wGHOtS3EWmycd+3hpLPKtVjF+ad1oi4h3AYVabyIsnPwy
 xBPwgMe3ocnElMwd+Kb4bDeHlN6Ln9PRGTySdwd5WIuiUGyDgNKmJzSUNbX4mQ8hqWMF
 g21g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQwoQsH5Cgxb6s1m6Xc9uHcvlLQgRew4cs1RNwtyrZsKE/99kH9qPTfdN666vBQsEPjO36pyI=@lists.denx.de
X-Gm-Message-State: AOJu0YzIA6BmOhgfygDNIxMBTjugyoMzegCe/mWoev/6XbSQTfA1yucn
 pV+0rgWsuwDYYN4grCbrqyL01ZsEguhyUMU7Nq1RZZFop58ps5apDD7QQjTv4tyWvUA=
X-Gm-Gg: ASbGncsBSxKaGifFMOAFSwKmzPElivnT9c07c4dOvyo63xBqsQb7N8Am1VzhKX5991Q
 0HN3fjOplY3K0JqCBKkaMgPrYK9YSGO/Mhz2EHMW+aDjkV1dPgvKBFROA/WBA4xUzjNilDZ92OE
 YTO+trxhAmbipIfkqDZaedeYzRGImbUlo8YxKg3i424fKQm8or53/IAvYo2hYErRZkTehZ2Dx6t
 /T4YlvHQgDvleEeftVE/v33KA7xiDcg5S6btysM+/iazEGXAYl7LNSbWqNkg12O/oTyDgsmbMq8
 9hiyOfvoHeWP06Ke2qUSYQsg2Mm21SctiKkd16eG8m/N5u7crCe6b1JiFqfFOidkkyTmJ/62ESc
 kMrX/O8YulspxG2TU6rXD80fM4YV43vs=
X-Google-Smtp-Source: AGHT+IGyBIeNH5wlSjGXsfrQVWM4jHhjpy88KYguHKb5JJmbx9dQMyetJtSxtmvCu136plvMBweqCA==
X-Received: by 2002:a17:907:3c82:b0:af2:31a9:c981 with SMTP id
 a640c23a62f3a-af231b948dfmr106434566b.23.1753185338695; 
 Tue, 22 Jul 2025 04:55:38 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.171.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6ca7a3e1sm850728066b.105.2025.07.22.04.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 04:55:38 -0700 (PDT)
Message-ID: <f05169e9-9220-4058-93dc-1a452d3b5769@linaro.org>
Date: Tue, 22 Jul 2025 12:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77Q51NW
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20250720195901.414083-1-marek.vasut+renesas@mailbox.org>
 <c3c99016-b6ae-443b-ac1e-a6c5144dd815@linaro.org>
Content-Language: en-US
In-Reply-To: <c3c99016-b6ae-443b-ac1e-a6c5144dd815@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Jul 2025 14:43:43 +0200
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



On 7/22/25 10:20 AM, Tudor Ambarus wrote:
> 
> 
> On 7/20/25 8:58 PM, Marek Vasut wrote:
>> Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
>> with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
>> flash part is similar to W25Q512NWM .
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>  drivers/mtd/spi/spi-nor-ids.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index e7e97780d7c..0383175beb5 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -591,6 +591,7 @@ const struct flash_info spi_nor_ids[] = {
>>  	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>  	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>  	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> +	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> 
> 
> The patch is looking fine. 

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> Any idea why SFDP parsing is optional?
> I see a SPI_FLASH_SFDP_SUPPORT that guards it. Having SFDP optional
> introduces headaches as one has to specify all flash parameters statically
> at flash declaration. I assume it's about image size limitation. I also
> see a spi-nor-tiny.c, about which I'm not thrilled. Is there a general
> recommendation on when to split things? Maybe a question for Tom.
> 
> Here it seems that you specify just data that can be discovered by SFDP.
> You won't need a flash entry at all if one adds a "spi-nor-generic"
> flash info that initializes the flash solely on its SFDP data, see
> linux. It would require porting the parsing of the 4bait table from
> linux and other small changes for the rest of parameters.
> 
> Thanks,
> ta

