Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1333CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 08:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE70E86E95;
	Fri, 13 Oct 2023 10:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HZSlLNFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B305286ECB; Fri, 13 Oct 2023 10:32:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5EF868BF
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 266293F231
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697185949;
 bh=FCqCCusu1sU0y1MPEJJ/tlhXlmbq11gv3QYdNrE//wU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=HZSlLNFoAndS9+ykzK/Ns0M+Vgi9s5m5wRDjiuqzLkcBn93q9lgjMKET5mzHhLI7H
 +qiRpFrKt94poVzGWpBOPEBD+3JcnWNja5JaWs99tJXy7Rc+tgXJAH8gxvU5OZ/BT3
 DJDMpiNrI0d6Vkxi4JBV+4fPeb+UtzfIgsn2iZL54zFKaPX2Qi5ZoeOM/rlxibrW1U
 aVaacUlhVjJ8kmZTvKv/2z6nmJMCGom6BCK8PPH+QgTrWHkXmmF9mrliCydNldH/V3
 luP9mB0TMMDOWBrWp9KuKrbB/JEZ6h0sEisC+mNGnReym0XkoDoGpv92pZe+E2yZfg
 lkqwT3Oc5k1Tw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-406710d9a4aso13586705e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697185949; x=1697790749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FCqCCusu1sU0y1MPEJJ/tlhXlmbq11gv3QYdNrE//wU=;
 b=KaDTY3tccnqNP3HEdH4vmKxV7K9rgEc+aMcmoNCtF5JECkkbsDY4IRieJO3nFsWCHz
 MY8bXFnR1BWXq7zbd3Pe0aHCUI66zscYXPjk+WRXF9NxZ0qrNZ3oBpB0IB+VyR1J8xY/
 DaOCMApFoCcP5LD7lg+hRD+7s0TZvSMT6aXOQRsquvTfSFiH2W/0riPr+oHo1lsb1lDq
 ijEgmVnsBqWaJGKifD1+s2Doq0fkDfaDIi1WmMzKs3sZ0sZf9sgs8xMqTZ5sog7Y/hiD
 owvrFAcsqF6Q7X0oAxvMnufe5WWQWXDOiozb+cjf9i5zxi/vOD1lT8/GIZfXUKXNVQq9
 PV+Q==
X-Gm-Message-State: AOJu0YxOxbA/AzbC59ajYCO10qTeyTpkHRLYQ8Ls1f5R/+L8ZeN5Mqd4
 4vwhmenthgFeW7E8tTpTqTGBGQ+RhOXGKflmX6xTA+CEVXHy0n8zvdkZ2JnrjcZTjoBCXzXfB3+
 pvFC5mtHuGzhMszC5JJOt4MIeUGXj+oI=
X-Received: by 2002:a05:600c:21d5:b0:3fe:5501:d284 with SMTP id
 x21-20020a05600c21d500b003fe5501d284mr23955808wmj.11.1697185948784; 
 Fri, 13 Oct 2023 01:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUE+MN/PQNTW/M9Yr7Ygx+R5JGWrK7PiSoEE9Iyeg6j5xNY5w97U8rq93ZTKMUHRr5FTcyhg==
X-Received: by 2002:a05:600c:21d5:b0:3fe:5501:d284 with SMTP id
 x21-20020a05600c21d500b003fe5501d284mr23955787wmj.11.1697185948271; 
 Fri, 13 Oct 2023 01:32:28 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 p5-20020a7bcc85000000b00406447b798bsm1906168wma.37.2023.10.13.01.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 01:32:27 -0700 (PDT)
Message-ID: <84240e10-80ca-45f9-b50c-4e8f6bbd90b6@canonical.com>
Date: Fri, 13 Oct 2023 10:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] i2c: designware_i2c: adjust timing calculation
To: hs@denx.de
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231011044813.122941-1-heinrich.schuchardt@canonical.com>
 <d461a87f-14d6-2b22-f3c6-522a54b7d517@denx.de>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <d461a87f-14d6-2b22-f3c6-522a54b7d517@denx.de>
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

On 10/13/23 06:37, Heiko Schocher wrote:
> Hello Heinrich,
> 
> On 11.10.23 06:48, Heinrich Schuchardt wrote:
>> In SPL probing of the designware_i2c device on the StarFive VisionFive 2
>> board fails with
>>
>>      dw_i2c: mode 0, ic_clk 1000000, speed 100000,
>>      period 10 rise 1 fall 1 tlow 5 thigh 4 spk 0
>>      dw_i2c: bad counts. hcnt = -4 lcnt = 4
>>      device_probe: i2c@12050000 failed to probe -22
>>
>> When changing the offset for the high phase from 7 to 1 the device is
>> probed correctly.
>>
>> Without this fix the memory size of the StarFive VisionFive 2 board cannot
>> be read from EEPROM.
>>
>> Fixes: e71b6f6622d6 ("i2c: designware_i2c: Rewrite timing calculation")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/i2c/designware_i2c.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
>> index e54de42abc..55e582091c 100644
>> --- a/drivers/i2c/designware_i2c.c
>> +++ b/drivers/i2c/designware_i2c.c
>> @@ -155,10 +155,10 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
>>   
>>   	/*
>>   	 * Back-solve for hcnt and lcnt according to the following equations:
>> -	 * SCL_High_time = [(HCNT + IC_*_SPKLEN + 7) * ic_clk] + SCL_Fall_time
>> +	 * SCL_High_time = [(HCNT + IC_*_SPKLEN + 1) * ic_clk] + SCL_Fall_time
>>   	 * SCL_Low_time = [(LCNT + 1) * ic_clk] - SCL_Fall_time + SCL_Rise_time
>>   	 */
>> -	hcnt = min_thigh_cnt - fall_cnt - 7 - spk_cnt;
>> +	hcnt = min_thigh_cnt - fall_cnt - 1 - spk_cnt;
>>   	lcnt = min_tlow_cnt - rise_cnt + fall_cnt - 1;
>>   
>>   	if (hcnt < 0 || lcnt < 0) {
>> @@ -170,13 +170,13 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
>>   	 * Now add things back up to ensure the period is hit. If it is off,
>>   	 * split the difference and bias to lcnt for remainder
>>   	 */
>> -	tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
>> +	tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
>>   
>>   	if (tot < period_cnt) {
>>   		diff = (period_cnt - tot) / 2;
>>   		hcnt += diff;
>>   		lcnt += diff;
>> -		tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
>> +		tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
>>   		lcnt += period_cnt - tot;
>>   	}
> 
> What are this magic constants? Are they somewhere documented in the RM?

I have no access to Designware reference manuals. Do you have?

> 
> Hmm... and does this may break other boards? Should we have this in
> someway configurable?
> 
> Tried to look fast in the linux driver... and it seems to me, this
> constants depend at least on i2c_speed_mode?
> 
> bye,
> Heiko

https://www.nxp.com/docs/en/user-guide/UM10204.pdf has I2C timing 
diagrams in Figure 38 and Figure 39.

Linux has a function i2c_dw_scl_hcnt() where depending on parameter cond 
either a value of 8 or 3 is used. All invocations of i2c_dw_scl_hcnt() 
have cond = 0, offset = 0. Linux' i2c_dw_scl_lcnt() always uses 1.

The Linux comments are:

cond==True
     IC_[FS]S_SCL_HCNT + (1+4+3) >= IC_CLK * tHIGH

cond==False
     IC_[FS]S_SCL_HCNT + 3 >= IC_CLK * (tHD;STA + tf)

The U-Boot comment has:

     SCL_High_time = [(HCNT + IC_*_SPKLEN + 7) * ic_clk] + SCL_Fall_time

This lets me assume that these are the matching pieces of code.

While my patch had %s/ 7 / 1 / we would need %s/ 7 / 3 / to match the 
Linux formula. This should be enough to avoid the observed "bad count" 
error on the VisionFive 2.

Best regards

Heinrich
