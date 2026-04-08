Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0715FD5F6A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 09:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C5283693;
	Wed,  8 Apr 2026 11:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQ2STR0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDA2838BB; Wed,  8 Apr 2026 11:16:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0333380433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso46654945e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775639785; x=1776244585; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUgqDLOSJ3s3ofSBPmLIILm83cMwASSifllmLsmzfcA=;
 b=cQ2STR0aUhbKURRoytqhu9lpYOeuAbp/1wwAoRCVpgZh/E5i7sq0p7Bs9/5FYO2Z89
 IMScHXN3sRyNLYS1oeObCDuKF6HGX/qjKgZaOC3Ebj8Yh6l9kGy5Z78lf5Se0+2Exk4D
 72jHJfyX083h79JGSrO+0wF5WH2n/WJywGHJsNGR0R/O4V/WObp+Bt+SSV+fuzkFQmVC
 awiNF+GNJSyPJHeT6M5dccNX3kltlLWOXlAUMHn8MEmn005G/nZr/rZj8SvmTVXs+noP
 C9libAT9S81ZolrBwiZfXevsK/+/DdLfLEhVAWnGQuSlCcZsSOfLwks3s+tftquywts7
 4vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639785; x=1776244585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LUgqDLOSJ3s3ofSBPmLIILm83cMwASSifllmLsmzfcA=;
 b=XK1UEy0GBbmJ5YqZdbmaC7EPczYfHuXtyAK22QgvD/L2rD4j31/GRIJK4QyWHqQdSc
 P4kSwzTywhQJLIBzRh/2m/WaCkzrvZLz3dUGBU5r/V9bXi2yClk+hhA6gNBzezvv9QhZ
 LqJla1aooeTpJGTjTa88+oD41ArilztGiUuIsS5A/3Y1Ri8qGQezhHYpga3PmWbtQI19
 a6FlyIfsRU+rsw3x1JukQ+/SsSXYLEPfLeqTesaB9KI8bqshWVnMZDMHXJWcinlMaN4C
 XvtSIjleRa3egsMXtyNzY1/5J9XJTrPJYM/SUzXY9jbs2H4udv3vcYOy3nGWLs2KLXYi
 p+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxl299WpfKemg/kjfeqr/1djTtu3RD5bi/Bb36Tx1s7pDD3yTO3RCcS/hzzk2t4v8zVo1hbeM=@lists.denx.de
X-Gm-Message-State: AOJu0YwnGDSzlcJHewhbuCNSm6L9GKgVSAQ7Nd6nFY1tKceYl0ztL4e/
 afeAGSIvjglCJc+FcL0RZrrd6qLK5CjrjuWTK+S/eMe9UL9UF4F/1qa6z/Ly30BFSIU=
X-Gm-Gg: AeBDietkfvzzKqglyu6YNGy0lhyIUyhd2qAi0Xzv/s8gI1dZuXwFUdlwbcQ3CvjbJ65
 LS0V1OZtmJWWMp1CCyjUmlBQt9q8Go/onN9ww5N2VyufSk16HvL5vnSsBjBm7VEwWxS+N2GHNjA
 eb490nt7GupHEjXn2qLRLnlfLRmdWQlwgxZFeI3qNJL2jnQW10jLpwA8y8+xcyZaZg+rpH4obDV
 2c5NCikOcgh+41PudtS9LReZhBBp4G0dMI9OhNvFYF9ei3R3OJM6R2A7jdaWUJx6HoJ1Cnyb5SQ
 2ydUGBIhcn+28KXc7fEOIVnPrs20TA9a/6t0XlYjpRETDjg1ea7i6xxchDNlA8u0SWWWVPmLI60
 XYuv0s/iLMToJRx47DSSaCuKbjm3jXUvSYrXLBMmfl7mwdqHBIDqyYHrunXCGFP7fxxyk08VI+g
 V3lQrAS1zBGHobhdKlCgusvyZRn5CboghgOoxf5baePXh2m9N4iJTAXAfXj/qVLpCSFoPduEfmB
 hbB
X-Received: by 2002:a05:600c:c08b:b0:488:caed:5cc7 with SMTP id
 5b1f17b1804b1-488caed5eb0mr5769235e9.15.1775639785341; 
 Wed, 08 Apr 2026 02:16:25 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488b739e00bsm221493565e9.10.2026.04.08.02.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 02:16:24 -0700 (PDT)
Message-ID: <ac78f01b-7aee-4658-b682-67d4f53cd40f@linaro.org>
Date: Wed, 8 Apr 2026 11:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: msm-geni: allow invalid clock
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
 <20260320-casey-qcom-rpmh-serial-fixes-v1-1-b81d05832eec@linaro.org>
 <adTs0aMJmGrIPKeR@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <adTs0aMJmGrIPKeR@sumit-xelite>
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

Hi Sumit,

On 07/04/2026 13:38, Sumit Garg wrote:
> On Fri, Mar 20, 2026 at 04:45:40PM +0100, Casey Connolly via B4 Relay wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> Pre-relocation we probably won't have a clock but it's usually
>> been enabled for us already, or worst case we will enable it after
>> relocation.
>>
> 
> Not sure if this is the right approach, since the UART driver might just
> hang without clock being enabled. What's the motivation for this change?

Hmm, I didn't consider that. The motivation here is to handle CCF, since
we don't want to support clock pre-relocation. In pretty much all cases
today the serial clocks are already configured but you're right that we
ought not to depend on that.

I can't really think of another good solution than hardcoding this clock
configuration somewhere :/

Any ideas?

> 
> -Sumit
> 
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  drivers/serial/serial_msm_geni.c | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
>> index bb5a2cb4d2cd..c37255f57d05 100644
>> --- a/drivers/serial/serial_msm_geni.c
>> +++ b/drivers/serial/serial_msm_geni.c
>> @@ -211,9 +211,9 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
>>  	}
>>  	ret = clk_set_rate(priv->se, clk_rate);
>>  	if (ret < 0) {
>>  		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
>> -		return ret;
>> +		return 0;
>>  	}
>>  	geni_serial_baud(priv->base, clk_div, baud);
>>  
>>  	return 0;
>> @@ -516,15 +516,14 @@ static int msm_serial_probe(struct udevice *dev)
>>  	int ret;
>>  	u32 proto;
>>  	struct clk *clk;
>>  
>> -	clk = devm_clk_get(dev, NULL);
>> -	if (IS_ERR(clk))
>> -		return PTR_ERR(clk);
>> -	priv->se = clk;
>> +	clk = devm_clk_get_optional(dev, NULL);
>> +	if (!IS_ERR(clk))
>> +		priv->se = clk;
>>  
>>  	/* Try enable clock */
>> -	ret = clk_enable(clk);
>> +	clk_enable(clk);
>>  
>>  	/* Check if firmware loading is needed (BT UART) */
>>  	proto = readl(priv->base + GENI_FW_REVISION_RO);
>>  	proto &= FW_REV_PROTOCOL_MSK;
>> @@ -546,12 +545,8 @@ static int msm_serial_probe(struct udevice *dev)
>>  	/* Don't actually probe non-debug UARTs */
>>  	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,geni-uart"))
>>  		return -ENOENT;
>>  
>> -	/* Now handle clock enable return value */
>> -	if (ret)
>> -		return ret;
>> -
>>  	ret = geni_set_oversampling(dev);
>>  	if (ret < 0)
>>  		return ret;
>>  
>>
>> -- 
>> 2.51.0
>>
>>

-- 
// Casey (she/her)

