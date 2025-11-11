Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D4ECCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE38283EC9;
	Tue, 11 Nov 2025 11:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yjtXSdoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B1D83F24; Tue, 11 Nov 2025 11:27:07 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD6D83734
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso2070689f8f.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762856824; x=1763461624; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pLUyCPfI0XGvQumvdt9iWo2xBVDRec1lzgBKeHLD9y8=;
 b=yjtXSdooY4RPgqLPsd2beK2cY8b18hqi/nKHEXkyQbqa5TJscdvzDU66ieF8LaekAB
 Lffb7o5bISOD1JmLSZXKzQ4YWif8/KP7sucPbyoSYI3m1TzjYj8ZlcwwdKbePcjHb9BP
 lueOVgP9BH75mBMrsR5VN7PJm7M+dZCVAFMpjztLoPFJF3wA7tvCcsnBdIQduePt+WHX
 zFPJhX7NVcgEFpeNTSnHfmw4+g0ksZgDGuzvq5jJgaLEEsqGK+xhquGwc8UyBZAY56ik
 2y7dSVzzvdXKs7OEXgxvFtSOnW/t/zfurNo8bCv4HPq8gr0ImeaU8Q2+bzShtW71tdMO
 5xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856824; x=1763461624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pLUyCPfI0XGvQumvdt9iWo2xBVDRec1lzgBKeHLD9y8=;
 b=BXTc8MBIlPuzGlYRS/ZXnOL3ci35p+FsU189l21q1JU3IEDkK5R9W4fhkj6T+oOxBm
 Vro38feDMSPLz/v2O9yaVkX7bDdDyZbCDiCnMAE8VnCfy1ah8avErxdb34K6G1fZSYGP
 d59xuSiKjpUm+wntpbhCceYx5TFX5mf8guTvw4h8gDtH3Is/Pf73JFrhHzAo81s3YdGe
 55Pr5Df1zA10/TWCRGknwmEdTu3P0nudJixN0Dd0Hp54TKBQYherAgZsT2u/B5I8+7PM
 AgVs3r6QBiBKYebIxEY8qH9EndnXkbkSuI/ZfyTE8hZnyOZoapUHUgZIQwK5Djgg1l7a
 4MKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+65zhRkjYCCDCu7Wc6bAeIZXR8mbh7yEa8kwXnH+OTPjccVePPnkwC03kIBbXR+/NNiGrO+w=@lists.denx.de
X-Gm-Message-State: AOJu0YxRb57WaS3f1lRIxEWCf0rCNBuGRzerWRJYLysmCeNK+0uK8bTH
 jb9IQdJQLXxrOyIf+95anhJLHQbITIt2TQ+wKm5s2Kbm3hPl+LNsvFyOp4JmYuhPMYsOaIYaudY
 NiUMW1CA=
X-Gm-Gg: ASbGnctrplR8LQOo9+V8pUyG+UtCRCirkIide/DAyHbVV/FzdiEEaMGEXc6W5zgXCbN
 d4+wvzsy5923bKhCik6VsI6pfg7bp1I7jbSNQ15J/En9mTeCyQOb/oTAOGhPuAyPSMLEI4hRbM3
 wZxThH2fSOznNduIoMCQrKjXXVf9cygybQlPH1ezt4MRlAop/YpkKelpmMiPZkJl+3ZxT06WocR
 1jv2Jsa6bqxyE3VR7JuSzPu9xMaPotA6inUkdgusd55pCtFnfqFRP5Se40/fij/gqOjH29cdO6q
 inahKDySC73n64bdTPhh5S0TRXQ3A4b/r7/JgIhGsrwGWV9jXqnkgUkQEuZ7RUKn/xXovmOBnCx
 t7uKH+FVNlcWhWV5aHJMIZWR2OQp04BXBnjb9WlHxMk3VzRuV+cTDKyAuUUyH57Jl0Kd+dUruue
 iCvDUq/A8=
X-Google-Smtp-Source: AGHT+IGLN6ZtPVgGLWcZslElnwbQbS1nO1a9ZO5oWcwp84Z9KfHAf2xlV6mqMJB3STKSIlxb6undUw==
X-Received: by 2002:a05:6000:4182:b0:42b:3ae2:bd18 with SMTP id
 ffacd0b85a97d-42b3ae2c0a8mr6984200f8f.63.1762856824013; 
 Tue, 11 Nov 2025 02:27:04 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bfa0sm28122242f8f.5.2025.11.11.02.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 02:27:03 -0800 (PST)
Message-ID: <27d093af-285d-4c9c-af8d-9e27c0607eb8@linaro.org>
Date: Tue, 11 Nov 2025 12:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mtd: rawnand: atmel: atmel_pmecc_create: Remove
 unused code
To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
 <20251107-pmecc-v2-2-271e6aea3231@hifiphile.com>
 <20251110-crouch-motor-2a2bdfbd6486@thorsis.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251110-crouch-motor-2a2bdfbd6486@thorsis.com>
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



On 11/10/25 17:25, Alexander Dahl wrote:
> Hello,
> 
> Am Fri, Nov 07, 2025 at 04:02:24PM +0100 schrieb Zixun LI:
>> "timing" and "timing_res_idx" are unused and not exist in Linux driver,
>> let's remove them.
>>
>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>> ---
>>  drivers/mtd/nand/raw/atmel/pmecc.c | 7 ++-----
>>  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
>> index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..1acaa5d0e0783f11be8236ad12b42540ca530a5b 100644
>> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
>> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
>> @@ -820,8 +820,7 @@ EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
>>  static struct atmel_pmecc *
>>  atmel_pmecc_create(struct udevice *dev,
>>  		   const struct atmel_pmecc_caps *caps,
>> -		   int pmecc_res_idx, int errloc_res_idx,
>> -		   int timing_res_idx)
>> +		   int pmecc_res_idx, int errloc_res_idx)
>>  {
>>  	struct atmel_pmecc *pmecc;
>>  	struct resource res;
>> @@ -839,8 +838,6 @@ atmel_pmecc_create(struct udevice *dev,
>>  	ofnode_read_resource(dev->node_, 1, &res);
>>  	pmecc->regs.errloc = (void *)res.start;
>>  
>> -	pmecc->regs.timing = 0;
>> -
>>  	/* pmecc data setup time */
>>  	if (caps->clk_ctrl)
>>  		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
>> @@ -952,7 +949,7 @@ static int atmel_pmecc_probe(struct udevice *dev)
>>  		return -EINVAL;
>>  	}
>>  
>> -	pmecc = atmel_pmecc_create(dev, caps, 0, 1, 2);
>> +	pmecc = atmel_pmecc_create(dev, caps, 0, 1);
>>  	if (IS_ERR(pmecc))
>>  		return PTR_ERR(pmecc);
>>  
>> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
>> index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
>> --- a/drivers/mtd/nand/raw/atmel/pmecc.h
>> +++ b/drivers/mtd/nand/raw/atmel/pmecc.h
>> @@ -65,7 +65,6 @@ struct atmel_pmecc {
>>  	struct {
>>  		void __iomem *base;
>>  		void __iomem *errloc;
>> -		void __iomem *timing;
>>  	} regs;
>>  
>>  	/* Mutex used for pmecc enable/disable */
> 
> Acked-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> 
> Greets
> Alex
> 

