Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1241EC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F59831D7;
	Tue,  5 Aug 2025 11:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mWr8vLve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED5FF832F9; Tue,  5 Aug 2025 11:22:15 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694B181D5D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459e0a249d6so4675065e9.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754385733; x=1754990533; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mSdH22DrQdAfwljSXTN10oSn+kmm8UewKroXzRurAaQ=;
 b=mWr8vLverq4mMKzHLuH/KTkaiexnc+Cq/YCCQTg/LYuqhMQ/mXfIxIlUWipailTqUH
 ZnLfdsA1+dhwoGeOk0scgB3yzpcYCNZol2MneQjFsDYlJO7umDiZwTYEkUskc/yeySM9
 wOUWlTaDvpgC+ClYjSY/UmipO2C4JmtFDQvmA526TLyQoFl7xMkHdv35DyjWvSXCnut/
 nggQ5sdcVHr4arbC+F/u5VxHJbezRdvKMPai464/OS4fGmzanPpVz9FlHHS5G7uEBXDi
 41arDHg3VIvpPghyNhlg1bIlvzg63k56gN4iCK2d+/PEcuhi/eTB3HIcK4Olm8zxx4ju
 Gg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385733; x=1754990533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSdH22DrQdAfwljSXTN10oSn+kmm8UewKroXzRurAaQ=;
 b=QIuy9OOBcRrZzKA0NAYPUfx/osf5BFDTeo3vEp7EA6QhSPgxK+1lmhGFq87HsNQEu3
 JB82ngTVizWdpjgMpI+QhT9u7XAqnAacO0CToqUMyXz8Xilq9aA+a8L1ZUGy0YdjyYvM
 5n/qs6IKnDAQ05G+KnZZuaxLzvgY94XD+zfnvHbRn3ZyeDl6ZyP6HZpJirO0SukJqEHk
 YwmUFRpxrjzxn0MFlewItLACMdIBmpsOn+ol4swVg31nOBUjmn3ZzA4eaiYwzVxx8I/C
 a3m8XmFTxBT++y+l6kYz0sf/U1VwJYovtlXXxsp0N7VN2HFU3e856FfuPOiAUc8V+QK6
 Uk1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvrOF3t+vx9RokJL+zAMB50gZ2jeXMCfqZpmKnhstn+ZKzN5QUzUFAm/p5LynWYTPU3cW0sYY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy8eidZCkIXden5dXSI4ZCHJxAigxzF4qdr/QIsZHVpOBfXKG3
 XSs9+Ea2Tjtp/NeqCcdIuf/B6WOb/goVzR2N9lpHV+avK4c/pMiLevMO38sjg8U4wB8=
X-Gm-Gg: ASbGncs4S+nlLJvVXoViRpYeLjjOWn6ONW/hPj6dHNspxrwUiqSpqvj3bPgmju0YYwd
 TjZM1+9/KijjWWt/x6RfdQN0WYH4SayUkYssBAegnlyHioz/MrzlmG+pk9avozfsPiU+IMv6ra9
 EMyM3/QuuoVXu58c/hroppnc9za93ohJ/TrPJ2SgplyLscYiTkfXhlcDTZ/QsWf9oAFnP09T1Te
 1f+nL8AZlhxRznNxalur+IeVDsnmDC7tCAuEotXWzOogeh/tgEgGu4/7aNVZO3eUS2BwiW8rhEy
 YICLcRJof0D+29aTMk/UjH6jwERCiSMm3W3JQatU2tBeUjYQy5g1OlccwhVIbw3QeJJ8WIchBUO
 mf3/tdQMq5wAspSsMKqAoJySx5Ehza1EiQ1L1Mk4qYAnNNS9Df1dY2Lqvst412NhBSK+wFmOKg9
 tx/8Ggr32xFg/b
X-Google-Smtp-Source: AGHT+IFWsuz9JWJ+ORlH1bXhHF69BQ+ZZGLoBNUo28WDVeMBt9sW91NXYp3lrkl5TZbgI5R8TVwvoA==
X-Received: by 2002:a05:6000:381:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3b8d94d3665mr8520643f8f.52.1754385732715; 
 Tue, 05 Aug 2025 02:22:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35?
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf33sm18560504f8f.7.2025.08.05.02.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 02:22:12 -0700 (PDT)
Message-ID: <ea192ec8-8477-4de7-99cc-2093dbc62273@linaro.org>
Date: Tue, 5 Aug 2025 10:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: owl_mmc: Do not dereference data before NULL check
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
 <20250805040014.GD29103@nxa18884-linux.ap.freescale.net>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250805040014.GD29103@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 05/08/2025 05:00, Peng Fan wrote:
> On Thu, Jul 31, 2025 at 12:11:47PM +0100, Andrew Goodbody wrote:
>> In owl_mmc_prepare_data there is a NULL check for the pointer data but
>> it happens after data has already been dereferenced. Refactor the code
>> so that the NULL check happens before any code dereferences data.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> drivers/mmc/owl_mmc.c | 18 +++++++++---------
>> 1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/owl_mmc.c b/drivers/mmc/owl_mmc.c
>> index bd4906f58e7..c18807b1f49 100644
>> --- a/drivers/mmc/owl_mmc.c
>> +++ b/drivers/mmc/owl_mmc.c
>> @@ -135,19 +135,19 @@ static void owl_mmc_prepare_data(struct owl_mmc_priv *priv,
>>
>> 	setbits_le32(priv->reg_base + OWL_REG_SD_EN, OWL_SD_EN_BSEL);
>>
>> -	writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
>> -	writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
>> -	total = data->blocksize * data->blocks;
>> -
>> -	if (total < 512)
>> -		writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> -	else
>> -		writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> -
>> 	/* DMA STOP */
>> 	writel(0x0, SD_DMA_CHANNEL(priv->dma_channel, 0) + DMA_START);
>>
>> 	if (data) {
>> +		writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
>> +		writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
>> +		total = data->blocksize * data->blocks;
>> +
>> +		if (total < 512)
>> +			writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> +		else
>> +			writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>> +
> 
> This piece code is moved to after 'DMA STOP', so code logic is changed.
> This may not be expected.

Are you familiar with this hardware or is there anyone on the list who 
is that could comment on the preferred order of actions here?

This was changed for two reasons. Firstly and of least importance, it 
makes the code tidier by needing just a single NULL check for 'data'. 
Secondly I wonder about the correctness of the original code. It seems a 
little strange to me to be writing to the device registers while the DMA 
is possibly active. This could potentially lead to undesired effects. I 
would expect that stopping the DMA before changing the registers would 
be a safer order to perform these actions. However I do admit that this 
is just speculation on my part and that this order could be fine or even 
necessary for some reason, but that would be.
Also, of course, in the case that 'data' is NULL, the writes that were 
before the call to stop the DMA cannot be executed as they dereference 
'data'.

So yes this is a bit of a speculative change but I think it would be OK.
But if you would rather I rework it to keep the ordering as before then 
I will do that. Please let me know.

Andrew

> Thanks,
> Peng
> 
>> 		if (data->flags == MMC_DATA_READ) {
>> 			buf = (ulong) (data->dest);
>> 			owl_dma_config(priv, (ulong) priv->reg_base +
>>
>> ---
>> base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
>> change-id: 20250731-owl_mmc-ef16e32b68fd
>>
>> Best regards,
>> -- 
>> Andrew Goodbody <andrew.goodbody@linaro.org>
>>

