Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154E8F44868
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E42984120;
	Fri, 10 Apr 2026 15:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wLikssBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7FD38412A; Fri, 10 Apr 2026 15:56:14 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155D084105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-463f00cda04so1115303b6e.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775829371; x=1776434171;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D2FpkKssos63dFnnoIfaToyxcEvWFqBw+DW2EAd2bQY=;
 b=wLikssBQeW9xm5tkITCGflJKV0Qe10CKXHNoNkRQfgWnv+UXyBdNm0H0Fk+2wR/tIr
 YVacNexqnDJ8ln2BPPAl/vx+7rPEJwcLlHc+sEA+g9DGjS3znyIZ10tSuqkgcVywxX7/
 M6NkVmTnoIAvnPOjgkvz6xDI5MzlPx8WnjTJVO1Mz0qpfQ/AiYIcd6o/BHpsc8NPTsJg
 64UazzZBioXc4ZeULxSNTKS6yBkg+sWvcWpgfx38Ch8ngIjxoxR98M311ZYWq8ujK3F5
 WTbvFVa76plzMQXk/sdvO8+/y4sg3hHCWQosyR5vMsD/zim7KxEU72pgZY8aQ4cmiwf4
 i1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829371; x=1776434171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2FpkKssos63dFnnoIfaToyxcEvWFqBw+DW2EAd2bQY=;
 b=HB++kJeJAulw05Ub6ty7JjAahJybE4riw04q9TOB0IudL6/GKZ/4wx8WM1h4gnQyvW
 7qWQ6y59zTfLiHnw2CGTne9H0E2F3P9efFFeUVdcMgRvI0tYKoRsXUVWDMcx7prRdmMK
 5hGY5SvJKJ88H0NBmkTfMW7pPhqnmOFj1J5971np+NT4sK6RQJq9dbCWMtMU11wNBFQk
 Pbq/YHLOhnMyM2G9LCyfhPoirDTYFG2GDDh1Pardn9pYlHCB6AYBLKZceQT/Q+8om/Ku
 WWBFkgedbzL8c2dPOCT3DFcSxSpbNpmWAGzwayoJsEEsxk7/AP/gKLBK7KYTQRY7dcu/
 idNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjyfujcMRJ0xbVUcTPAGfPy3edoKyj9BEsyx/aUaI4Gg8zz70xuquOSA7Pe0hMzfvRrPC9AlQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yys3DtLeGtevc6qzAkwH1vCGM2Kkmbv90/BdDEikSwwsgU+SXpN
 ew1PseHYl/Lrw0KtqAru9JV3TNA4xQsmy7TKvCKLYTwLQ1tSgFlFMKKrx1f9MLQZ0I8=
X-Gm-Gg: AeBDiesRsglSZ3SGCqVd5OF0RWUJRyzbfd+57cLqEbwqLZfFZo6HPskLE9yglmtfysq
 uWE8VrixQbnFWg6qWCQaf0KSRNMCkp/2t2s/sufKcbjiI4oZ6oYhxZZsyCnjx9FBropa8qoWl3+
 EB5lIilhOFMlE7O8CL0Ax4+MA/MUOrAUJBfCSm8k7/gtHBKo2OHh3Woq2HvGkRx429lA1+tHyNB
 XnzPhEkHOb4pjAZ5OGB5oTk0tRQUS9pgxVKsk+jF3oyDL0kcCI3FWOuDlGsIB10YyE09Pxi1vil
 vASahpXhunEYUcreNIPLzBTmm3DH0dFjavjilN0hOgRPWtQPOAj1bWn2z3X8WdWcjqey5SNYlAH
 YixRxNoIkaK3tpRPsDhUUliJmuLnpTQkSuF0+gCwkAqkQJOg0wA0cyQqLMoCnJaSDGjIMaEz1Ow
 JlQG4SH/VE9q12nogg8qrjF/XFbU9NHClPWjDEUpsI+wgVlVbLfYI/pjCKynfgX+xmaHvWKgcgC
 ygDXjr49gZ0
X-Received: by 2002:a05:6808:6788:b0:467:155f:8c34 with SMTP id
 5614622812f47-4789f902cfcmr1576778b6e.48.1775829370688; 
 Fri, 10 Apr 2026 06:56:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b?
 ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddb26220sm2260899fac.9.2026.04.10.06.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 06:56:09 -0700 (PDT)
Message-ID: <10992c90-1065-425d-8967-ee5cb8433ae0@baylibre.com>
Date: Fri, 10 Apr 2026 08:56:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: add flags for mx25u12835f
To: Takahiro.Kuwano@infineon.com, vigneshr@ti.com, trini@konsulko.com
Cc: jstephan@baylibre.com, u-boot@lists.denx.de
References: <20260403-spi-nor-mx25u12835f-v1-1-c9ffdae25d8d@baylibre.com>
 <683be5a32ef345229d54a68ea67fe64c@infineon.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <683be5a32ef345229d54a68ea67fe64c@infineon.com>
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

On 4/10/26 3:42 AM, Takahiro.Kuwano@infineon.com wrote:
> Hi,
> 
>>
>> Add some capability flags for mx25u12835f.
>>
>> In particular, we are interested in using the lock feature. According to
>> the datasheet, dual/quad read is also supported.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/mtd/spi/spi-nor-ids.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index e7fea375706..4930fa84685 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -272,7 +272,8 @@ const struct flash_info spi_nor_ids[] = {
>>         { INFO("mx25u3235f",  0xc22536, 0, 4 * 1024,  1024, SECT_4K) },
>>         { INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
>>         { INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
>> -       { INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
>> +       { INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K |
>> +              SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> Did you test with controller that supports quad ops?

No, the controller I have is only dual so I can't test quad.

Should we just drop the SPI_NOR_QUAD_READ flag for now?

> 
> In spi-nor-core.c: spi_nor_init_params():
> ...
> 	if (info->flags & SPI_NOR_QUAD_READ) {
> 		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
> 		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
> 					SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
> 	}
> ...
> SPINOR_OP_PP_1_1_4 (0x32) is set as candidate of page program opcode, but
> according to mx25u12835f datasheet, that opcode is not supported.
> 
> This is a problem in core side and we need to fix it.
> In Linux, a dedicated flag named SPI_NOR_QUAD_PP is checked.
> https://lore.kernel.org/all/20220920184808.44876-2-sudip.mukherjee@sifive.com/
> 
> Thanks,
> Takahiro
> 
>>         { INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
>>                SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>         { INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
>>
>> ---
>> base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
>> change-id: 20260403-spi-nor-mx25u12835f-f7328a631436
>>
>> Best regards,
>> --
>> David Lechner <dlechner@baylibre.com>
> 

