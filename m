Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5774CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4494C801DD;
	Mon, 18 Aug 2025 12:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ba5Hoh2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F3F803DF; Mon, 18 Aug 2025 12:44:06 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E627680107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1963so1909826f8f.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513843; x=1756118643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+x7/zWjHZVK7/I0MZauTCu/ZVoTb8KgzuyHUPpLQnA=;
 b=Ba5Hoh2MU989ndYKx1oKJ/uGxzOId5NpS4/1r3QX/DD+F8eIfyiNcTvuBDq2bBaG+X
 +cKEbgXa6TH9ohKSD8EOdOeXiy9xckqUkEdJaO3BHI3HfH7prKLGZy9A9c5QUouKnFH+
 lAYRrcJ9GZa/g300X3OnFN9dz5ZXx7siVdotuF6f59E7zAxsUU1PT6SHdybNXL1DiVjg
 TLZomdPMcRYZphyS6dtLRs7fidF+1fD/LK9gHtoiPLVRzPqBz05Jn2s6JiENmhStdZ3W
 f0811K+iR8m/CTuZNCdiBKNG+G2y0TL08cZ/yGoojirItxZED+AwK1HTm301yLottQKw
 TdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513843; x=1756118643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+x7/zWjHZVK7/I0MZauTCu/ZVoTb8KgzuyHUPpLQnA=;
 b=iCg7Np0uVu5tsK+WSSW2xfpz67Zs2Mw3blePuF/YASPqR+EwpQFTHc6rI7adaiP5eR
 6yYSEIroKKbtzcOFmxIBs+LNKYTxQYwvqADhHfI/ELVZHLh+lIDF3SwGexNa34eqFrcx
 ikRQTYrT2Bpp3pE6YzaRQNU6nK5uF8wVpK6DKsPE+1cYz9NRltgi35nNwg1d7uNvyTMm
 pSQzCvxZOJ8+xgykofWFyM6m3Fx7f6yGhSIlQ1/wL6mGyY+RHLN8c6QHGK313WHlQhYU
 wq3PsZfOAIajOwSzRJWgW/WE9ST6it2S0Lq1nc+gYgGomeZOjU56IRZR4Fcn+OevA6WL
 t1mg==
X-Gm-Message-State: AOJu0Yx3MmIgquDd8cQ4LKj951XwiFVQXzeQT/Ky4FhAsZEjikiOU4uY
 UzWnhoxMb4d2aDksMoKmnpolTuZaYj05BiPMo0bd1QB9QsZIuax86/c9UTN90COPesQ=
X-Gm-Gg: ASbGncsvazNuMx8xxazgCHOCMELmP9JNApUAca7Ebq9DzdLnFhPNv4BkUvQ3mlUb1JD
 EAKHZo3ju3JHLfSFCNoFygNDKbPC6OqbydYzjA74SVgfkhS9qwYITSge44nygdKWPnyMWtDX1Zo
 reOfvBVpdMVu6+jM7d7ClAz92pBoEkOgeWgBwTb4sj7dx9KQoTFULBjJCdC0p8b2tpdSh8tLnOH
 /HWTquUttwabewAok7i+58FlEr1DwBK/kYzRC+1ILgwZPRdonx7kXCvfWmp5RhN4nA3Rds6j31o
 l3SM3tHAreFozkRtqEYVHHr8CWIETI0/TB7wZaNmOjAaZZ9pHUjavl4pNX8y6cCfKsGet9iPTnR
 JADV/AIiR+fREGx+EY3wAxD0nCbTF1QI74c6hS6/QldJbZFHe1vrUI8Gk3xs0nq2mdptRdvuski
 JvYQ==
X-Google-Smtp-Source: AGHT+IFZZlxF8iMl3eHxhZ4KklSBJuJTMhO3xHe20gpxCG1CTPVuTPoDkbQz+5FKHVB+oGv5UIJoHA==
X-Received: by 2002:a05:6000:26c7:b0:3b7:8410:22b5 with SMTP id
 ffacd0b85a97d-3bc68b89b8dmr6153979f8f.13.1755513843197; 
 Mon, 18 Aug 2025 03:44:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8?
 ([2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb64664171sm13038142f8f.10.2025.08.18.03.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 03:44:02 -0700 (PDT)
Message-ID: <2065872d-7019-42b7-aee4-c92b929fd053@linaro.org>
Date: Mon, 18 Aug 2025 11:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: cadence: sierra: Remove variable that is not
 assigned to
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
 <20250806-phy-cadence-sierra-v1-1-2f0830caaacb@linaro.org>
 <9a680f6d-c159-4b88-b4ae-ef187b6d2794@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <9a680f6d-c159-4b88-b4ae-ef187b6d2794@linaro.org>
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

On 18/08/2025 11:22, Jerome Forissier wrote:
> 
> 
> On 8/6/25 17:24, Andrew Goodbody wrote:
>> In cdns_sierra_pll_bind_of_clocks the variable 'i' is declared but never
>> assigned to before its value is used in a dev_err. There is nothing
>> obvious to assign to 'i' so remove its use and just put a default of 0
>> in the dev_err call in its place.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/phy/cadence/phy-cadence-sierra.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
>> index 2c9d5a12127..46a728405cc 100644
>> --- a/drivers/phy/cadence/phy-cadence-sierra.c
>> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
>> @@ -602,7 +602,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
>>   	struct udevice *dev = sp->dev;
>>   	struct driver *cdns_sierra_clk_drv;
>>   	struct cdns_sierra_pll_mux_sel *data = pll_clk_mux_sel;
>> -	int i, rc;
>> +	int rc;
>>   
>>   	cdns_sierra_clk_drv = lists_driver_lookup_name("cdns_sierra_mux_clk");
>>   	if (!cdns_sierra_clk_drv) {
>> @@ -614,7 +614,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
>>   			 data, dev_ofnode(dev), NULL);
>>   	if (rc) {
>>   		dev_err(dev, "cannot bind driver for clock %s\n",
>> -			clk_names[i]);
>> +			clk_names[0]);
> 
> Wouldn't it make more sense to use "pll_mux_clk" as the clock name? Or perhaps
> just "cannot bind driver". And get rid of the unused clk_names[].
> 
>>   	}
>>   
>>   	return 0;
> 
> Thanks,

Thanks, yes. V2 coming.

Andrew
