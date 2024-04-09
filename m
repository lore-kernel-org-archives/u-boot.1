Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0260FCD1292
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 02:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9C28818F;
	Tue,  9 Apr 2024 04:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m7UvOZl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7468088190; Tue,  9 Apr 2024 04:38:24 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 132258818C
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 04:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-22a96054726so4622058fac.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 19:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712630301; x=1713235101; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XfhTkfbxdihfw+SvgahrT1OAOZ7RvDAwbquX09esiw=;
 b=m7UvOZl6PFzzSrTrRNAthVDgzxTgNh/RTnqQ8MMgX8POxJD8r97SdFWbcdj0ZmU/LV
 QL7Dgzad603auzmjXNCC8khtCEyKy4aZVE/dQtXCn0E7Uy4BNcqeT4HQSPjFwMLmrOm1
 7f5N+uu3Pu0siA6IbM3jrGQBVxHSNWC7ktotYc5eGEzEFCGkRaUSWt0LZh6arU4N3D7f
 PxwvA0TqORzpIeYdp3q8jqXDIE69uiTMqrHE+nfi2gKI9i9kvN17pNHin/uezcVXgHRT
 TwgLZL8gGHvk757r0mUD6ZroZ2Z2m6x5V/PJcHy2zaWNAEBwIA/x1MXyvdg4B9InifU/
 W80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712630301; x=1713235101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XfhTkfbxdihfw+SvgahrT1OAOZ7RvDAwbquX09esiw=;
 b=bBEQYIY5mZnaRl4BhAoXbUjiL77uavBH8zgeRIIl11y5hh2PeMiat51zxR/dYfCR3D
 DBRsaSkrANTXejf4qM3grp1SiUKQl7FmY7ls3Ul6pziunH4qi7HKW0y1ywFH1BW1baki
 vxwVziaSgneNDDrBQfNWvmgFyFd28EtSgjE26Jz8Al/sUyW12izSfrX2+TYKQtiFu1YX
 WwejxYlBsHH2jLWXvHVnflejgqxhzkdONhPMNaGY2v67bXfIHIWXgQafXzNAWMFn2LBx
 jwwFTJMjnJHLerskVwbNCvRrnenAWLhuvq+20q0VbdoTKhY27ntkPKbEO6Lly4HVPy/2
 P0gA==
X-Gm-Message-State: AOJu0YxwjuJUzAt3Mjn5sn3mtgJalTaG9QZq5lPZseyf9fUBwO1KPaiM
 fBEr/usFv6JZYo98Dr3tzgPnK7TWPvyBSdZaiSctw21wuloGAlve
X-Google-Smtp-Source: AGHT+IEIdyfwcIl0EbW1zPFX1I/HkygWCRWCo3QB/jytw/ihOMI6wM7xgLxt2BYfASppcuHcN3bo0Q==
X-Received: by 2002:a05:6870:d286:b0:22a:7c81:1e2e with SMTP id
 d6-20020a056870d28600b0022a7c811e2emr11819139oae.16.1712630300718; 
 Mon, 08 Apr 2024 19:38:20 -0700 (PDT)
Received: from [192.168.0.8] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 hq8-20020a056a00680800b006eaafcb0ba4sm7293351pfb.185.2024.04.08.19.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 19:38:19 -0700 (PDT)
Message-ID: <d5fc24ee-c1b6-4b18-a23b-f456854ee5b6@gmail.com>
Date: Tue, 9 Apr 2024 11:38:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add support for Infineon S25FS-S family
To: Pratyush Yadav <pratyush@kernel.org>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20240405064746.1600-1-Takahiro.Kuwano@infineon.com>
 <mafs0il0w15om.fsf@kernel.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <mafs0il0w15om.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 4/5/2024 7:10 PM, Pratyush Yadav wrote:
> Hi,
> 
> Just a couple small comments. Looks good otherwise.
> 
> On Fri, Apr 05 2024, tkuw584924@gmail.com wrote:
> 
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
>> Flash devices with S25FS512S. Some difference depending on the device
>> densities are taken care in fixup hooks.
>>
>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> ---
>> Datasheets:
>> https://www.infineon.com/dgdl/Infineon-S25FS064S_64_Mb_8_MB_FS-S_Flash_SPI_Multi-I_O_1-DataSheet-v10_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed526b25412
>> https://www.infineon.com/dgdl/Infineon-S25FS128S_S25FS256S_1.8_V_Serial_Peripheral_Interface_with_Multi-I_O_MirrorBit(R)_Non-Volatile_Flash-DataSheet-v15_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed6b5ab5758
>> ---
>>  drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++++-------
>>  drivers/mtd/spi/spi-nor-ids.c  |  7 +++++--
>>  2 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
>> index f86003ca8c..9b81b31e8e 100644
>> --- a/drivers/mtd/spi/spi-nor-core.c
>> +++ b/drivers/mtd/spi/spi-nor-core.c
>> @@ -3299,8 +3299,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
>>
>>  static int s25fs_s_erase_non_uniform(struct spi_nor *nor, loff_t addr)
>>  {
>> +	u8 opcode = nor->addr_width == 4 ? SPINOR_OP_BE_4K_4B : SPINOR_OP_BE_4K;
>> +
>>  	/* Support 8 x 4KB sectors at bottom */
>> -	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0, SZ_32K);
>> +	return spansion_erase_non_uniform(nor, addr, opcode, 0, SZ_32K);
> 
> Looks like an unrelated bugfix. Should this be a separate patch?
> 
The existing S25FS512S uses 4-byte address so it's OK with 4B opcode.
But, yes, this is a bugfix and should be separated.

>>  }
>>
>>  static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
>> @@ -3354,12 +3356,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
>>  static void s25fs_s_post_sfdp_fixup(struct spi_nor *nor,
>>  				    struct spi_nor_flash_parameter *params)
>>  {
>> -	/* READ_1_1_2 is not supported */
>> -	params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>> -	/* READ_1_1_4 is not supported */
>> -	params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>> -	/* PP_1_1_4 is not supported */
>> -	params->hwcaps.mask &= ~SNOR_HWCAPS_PP_1_1_4;
>> +	/*
>> +	 * The S25FS064S(8MB) supports 1-1-2 and 1-1-4 commands, but params for
>> +	 * read ops in SFDP are wrong. The other density parts do not support
>> +	 * 1-1-2 and 1-1-4 commands.
>> +	 */
>> +	if (params->size == SZ_8M) {
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
>> +					  0, 8, SPINOR_OP_READ_1_1_2,
>> +					  SNOR_PROTO_1_1_2);
>> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
>> +					  0, 8, SPINOR_OP_READ_1_1_4,
>> +					  SNOR_PROTO_1_1_4);
>> +	} else {
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_2;
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_1_1_4;
>> +		params->hwcaps.mask &= ~SNOR_HWCAPS_PP_1_1_4;
>> +	}
>> +
>>  	/* Use volatile register to enable quad */
>>  	params->quad_enable = s25fs_s_quad_enable;
>>  }
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index 4e83b8c94c..9ca1f244f0 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -338,9 +338,12 @@ const struct flash_info spi_nor_ids[] = {
>>  	 */
>>  	{ INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>  	{ INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> -	{ INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>> -	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>> +	{ INFO6("s25fl256s0", 0x010219, 0x4d0080, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>> +	{ INFO6("s25fl256s1", 0x010219, 0x4d0180,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> 
> Unrelated change. Is this intentional? If so, please make it a separate
> patch.
> 
Yes, it's intentional. The 6th byte is needed to distinguish S25FL-S and
S25FS-S. Will make it separate patch in next version.

>>  	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>> +	{ INFO6("s25fs064s",  0x010217, 0x4d0181,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>> +	{ INFO6("s25fs128s",  0x012018, 0x4d0181,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>> +	{ INFO6("s25fs256s",  0x010219, 0x4d0181,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>>  	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>>  	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
>>  	{ INFO("s25fl512s_64k",  0x010220, 0x4d01, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
> 
