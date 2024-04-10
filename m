Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAFEC67861
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 02:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF7787E1B;
	Wed, 10 Apr 2024 04:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JXkyhXis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7144587E86; Wed, 10 Apr 2024 04:22:48 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B91B87A4B
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 04:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-229d01e81f1so3477870fac.2
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712715764; x=1713320564; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PzzHOn5+JY5avA2w9i/AF3UcvGcNq/5f2bLvOR9Yyg8=;
 b=JXkyhXisfHws561gH43T/IkVuA8k9pt4CkfTKfS7RYAZ5ZQJ/JL8/GXYCL42Ph7UZG
 Yo0jUYOl0610B40Tft4+LT7bNEE548AcsJ46thP66O7uD48y5+/OkJNSGCwJBYC1BAcZ
 U6kV6TZed1o8/Cu/AgO0N+DlMqehUAOybT8Q/vuKo3lbHSk9f6OE8NVtsVofFzzKE27P
 sbkJFszGc1aPrLdYpKAFYCSz0sW1wVVMAg09nPbR5gzmxgreKZbDBKnBxTJZPxdsqe3N
 3cWWjvvWcLXxFOtuSXoSDIvQeiGeuneBN6pid9eraEdYR8Nf1T2cD1//VbumKaszuZ1e
 yV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712715764; x=1713320564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzzHOn5+JY5avA2w9i/AF3UcvGcNq/5f2bLvOR9Yyg8=;
 b=Zej0ffTXQx58gUTCcEsx0WPAjUtFLC5VkZRWdoP/KP+2OOWVpCvuuIIBAB0PvAXau1
 p6IVD/ePXYditydMliX9I+tfoL2Ono4Jfo5uz42aHKq0qtH4PKhk0d9ge6a+yLDjGCiO
 Two44NFjvFdF0qZXG0ObU68W2vOBd0dW8WbfSlRqHjV7MDVorTMQd2/QGEl6jRBnAHBX
 x1LD2P/HcqximXkG9RM+mEGB7fplSP1daXQ8l+IC1bz/Ib+oydswdJZJg0Oy7whNC+pp
 AanOIZrWr9TR6IwuBbn95cPAfYy7Svq00oDt3D9Dix+QkzT9JUfKu9dMepM+iV9CXwbD
 ZGnw==
X-Gm-Message-State: AOJu0YwlczplLvbZyi02AveBuJaUbdVGIUIB817FosU5dwYzY32deLto
 UvbKK99hQEDkOOMN0A10mIUnlf3izBOzIyDxjBjCiGieevZENyH7
X-Google-Smtp-Source: AGHT+IHwDVqxKAaDBxZcAg2au34KTwfpbbGGwKtjXFMCOmuRMUok+P6QEdnjLXMTEl1MZxLBzrXHGw==
X-Received: by 2002:a05:6870:2009:b0:22e:9c5a:233e with SMTP id
 o9-20020a056870200900b0022e9c5a233emr1477628oab.43.1712715763724; 
 Tue, 09 Apr 2024 19:22:43 -0700 (PDT)
Received: from [192.168.0.8] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 o4-20020a056a001b4400b006e623639a80sm9408531pfv.19.2024.04.09.19.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 19:22:43 -0700 (PDT)
Message-ID: <2d6d938d-0ba7-4ea8-b325-a698d30e8dea@gmail.com>
Date: Wed, 10 Apr 2024 11:22:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mtd: spi-nor-id: Add S25FS064S, S25FS128S,
 S25FS256S IDs
To: Pratyush Yadav <pratyush@kernel.org>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
 <37d92e2931b646f97f73650c0306adb736bd0efc.1712638210.git.Takahiro.Kuwano@infineon.com>
 <mafs0edbe92fo.fsf@kernel.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <mafs0edbe92fo.fsf@kernel.org>
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

On 4/9/2024 8:54 PM, Pratyush Yadav wrote:
> On Tue, Apr 09 2024, tkuw584924@gmail.com wrote:
> 
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
>> Flash devices with S25FS512S. Some difference depending on the device
>> densities are taken care in post SFDP fixup.
>>
>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> ---
>>  drivers/mtd/spi/spi-nor-core.c | 24 ++++++++++++++++++------
>>  drivers/mtd/spi/spi-nor-ids.c  |  3 +++
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
>> index 9620852817..9b81b31e8e 100644
>> --- a/drivers/mtd/spi/spi-nor-core.c
>> +++ b/drivers/mtd/spi/spi-nor-core.c
>> @@ -3356,12 +3356,24 @@ static int s25fs_s_post_bfpt_fixup(struct spi_nor *nor,
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
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> 
> BTW (not directly related to this patch), I looked at the datasheet you
> provided in the cover letter and it says dual and quad I/O is supported
> for the 16 MB and 32 MB parts as well. Why do you mask them out here
> then?
>
In the datasheet,
1-2-2 and 1-4-4 read are named as dual and quad I/O read.
1-1-2 and 1-1-4 read are named as dual and quad output read.
 
Dual and quad I/O read (1-2-2 and 1-4-4) is supported in all S25FS-S parts.
Dual and quad output read (1-1-2 and 1-1-4) is only supported in S25FS064S.

Thank you for reviewing!
Takahiro
