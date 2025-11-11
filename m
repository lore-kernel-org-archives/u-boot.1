Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA503CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FE583EC9;
	Tue, 11 Nov 2025 11:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UePcUTjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C672B83F62; Tue, 11 Nov 2025 11:27:40 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D230283734
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710022571cso38454775e9.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762856858; x=1763461658; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zDNFefGrr74eoI/ccBQC0X6A3tJiixL5oJiGlfU6NYI=;
 b=UePcUTjIjzoGcQIQCWllSG+cq5RO8mYY7iLBUzjykaZUqPXQGCf0ywyxfMtw41rZZU
 21EhCfSRM1AwdG4/4pxDNmB0SM8yYazO+d+yCH/p628cmDpLqAdZQzYEBJmClN28QQKU
 2FrxhiTNxKpes2pDpQIbbfbvPuBcWcYQkkBSZq9DeDG/ZZFloEqNkAQZlRMmRhhsC1gt
 pcuErahCQ0WXM+GJPgrJPuA2phmOLIKc7P6lIiWsodv5naF9UKhj1VeVYFGZWKAnpr1i
 fPZeZoddyrMRYn26VJv00MJD69bY6OiQ/6ne3Jn0PxvkmN0vWp8Cm65sYnnuYbmcSwSy
 /h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856858; x=1763461658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zDNFefGrr74eoI/ccBQC0X6A3tJiixL5oJiGlfU6NYI=;
 b=UdCbKq6fOi57aam3f5/GsF+TX8kKtv4HTwnReQggDYn57ebRD4zwxzomTaCEM3Yx9K
 UsW5F0lU0DywtF8P5M9lH5Y83B82NqztLznedz7zIIQFdzCajD13zYUHmrNRAB31Lgq8
 wGnqI/nO6OGSiVOMZ76bD56DSSRLFN60/m0bG9b/db1UBaOAnfdan8yt2+VD8ey9Uf0S
 1UbG+ICYPw/rgmpl+5+xiK7GRR2KM05ft6hzycXfLyvFUixNijLjpQElVtY3BdM46h4U
 tj8Hou6A066UoXnI5SQmGhPCrwsQK+7tndx+HkTlVnrcZa/NnzpMj8EylczK6gju0yzk
 cdVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ3VxVM5VUIiCbsjwGaggRgFyLqadx8AqwAUkJC9Ant4QohMmHgjdbIjOLX0KCDJ7RKUD600s=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt/4EahJNHlb2KmgTJomurGo+q8ZAOhYizkaQvz3zu2gs99jzC
 Gy5oHDddSSQkgz/Ht8VecrZXhDYXxB6cPodXO9kvlKIzaJhQgzrpJI1/ZIwNYbnvP3/Z662eI84
 JRiSgA64=
X-Gm-Gg: ASbGncsO/2517S1C9nrtRrR05agB3vBmTMTLzjI+X30hhyjXgjgWMy9LcDtV2AEDG16
 oZhDpHf/PFgvkkGqMZXtXR0PqyZUXAywE9ooIGVWCb129Sab7TqbBZ5E8MdsPYIb0QzhBjm052w
 kL72d28mup+SDagTWhXunS8D6vO1sWOu4uRh1dxUogyaa7R+v3vzJ+4mNe+XbmS8xSHTVGsEJ+4
 D9NtFiodReQYkKXu5Gp3nwBIeK/Qtz5ImZqCz1CeFig2cJRfoCnzLAAJAsKmP+KU4kTSOU3ffSQ
 7fAtHUYHLsltS9N/JEpnzvhtdYLZn44ZeH5If6ZjrDtrfYErCiwaytHw3TkF6HREcmswaaB3EFb
 PS9EPTye9+Ctyi+6kwJyH4D0aBHHNrDEpSH16B++cA19v+pNS3w10gH4VuoS4wtv0c42DG4UGGA
 Ds+rYnsNmokr3Qv4Kc1w==
X-Google-Smtp-Source: AGHT+IFpx8Ak1CTX3WQik44O4zxwWF49Tik4DPz6FQXiA8mSczvzW0CnJ7/aGUeXW+eSI3CI0Tb5Aw==
X-Received: by 2002:a05:600c:45d3:b0:46e:4783:1a7a with SMTP id
 5b1f17b1804b1-47773228b39mr93443605e9.3.1762856858238; 
 Tue, 11 Nov 2025 02:27:38 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4777f1b61acsm70473275e9.3.2025.11.11.02.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 02:27:37 -0800 (PST)
Message-ID: <bafe383a-1d79-42c7-8b35-8ec5b207868b@linaro.org>
Date: Tue, 11 Nov 2025 12:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: rawnand: atmel: set pmecc data setup time
To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
 <20251107-pmecc-v2-1-271e6aea3231@hifiphile.com>
 <20251111-partner-ouch-d24d292eec72@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251111-partner-ouch-d24d292eec72@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 11/11/25 11:47, Alexander Dahl wrote:
> Hei hei,
> 
> Am Fri, Nov 07, 2025 at 04:02:23PM +0100 schrieb Zixun LI:
>> Setup the pmecc data setup time as 3 clock cycles for 133MHz as
>> recommended by the datasheet.
>>
>> Backported from Linux: f55f552a7c7e0a1 ("mtd: rawnand: atmel: set pmecc
>> data setup time")
>>
>> Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")
>>
>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>> ---
>>  drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
>> index e500a0fe3f8671ff08195c94c3383696a7731eb3..7c4e9bd5f9967b119239adf2b39e683ea62b71fd 100644
>> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
>> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
>> @@ -142,6 +142,7 @@ struct atmel_pmecc_caps {
>>  	int nstrengths;
>>  	int el_offset;
>>  	bool correct_erased_chunks;
>> +	bool clk_ctrl;
>>  };
>>  
>>  struct atmel_pmecc_user_conf_cache {
>> @@ -840,6 +841,10 @@ atmel_pmecc_create(struct udevice *dev,
>>  
>>  	pmecc->regs.timing = 0;
>>  
>> +	/* pmecc data setup time */
>> +	if (caps->clk_ctrl)
>> +		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
>> +
>>  	/* Disable all interrupts before registering the PMECC handler. */
>>  	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
>>  	atmel_pmecc_reset(pmecc);
>> @@ -884,6 +889,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
>>  	.strengths = atmel_pmecc_strengths,
>>  	.nstrengths = 5,
>>  	.el_offset = 0x8c,
>> +	.clk_ctrl = true,
>>  };
>>  
>>  static struct atmel_pmecc_caps sama5d4_caps = {
> 
> Tested this with sam9x60 d5m SiP and Spansion® SLC NAND Flash
> S34ML02G1 on a custom board:
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> 
> Greets
> Alex
> 

