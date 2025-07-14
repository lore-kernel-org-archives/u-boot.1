Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDD9C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1871782F14;
	Mon, 14 Jul 2025 19:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wo/rbVSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48558309A; Mon, 14 Jul 2025 19:12:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AAF82E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so32641635e9.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752513126; x=1753117926; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFEABrz09PRVJtSwGR7XZVcPkDQ31BL1yexOwg/pAxM=;
 b=Wo/rbVSC7Xr+AQaTfHVRulzV5/dXGj8Mg34Wz3H3tT15RTRk9YUVg3FEjZlbp20J0R
 W0pzWeb7DmNxLDDJ6NYlM7gX4CDk1VACmMy3DnTNY0PHkWg7z+yyiuMtRgPltIMoXZ0c
 KNX9Era6dpMTVpVfXdXFGz7zLxJUVs28K94GtoVqxHiyXF1CCV6XyTxlJWoPn/me/bh4
 foQMv2HYQhm92mxsCDX+jbqIT9Q1y9LSU8U93tFPIwypC91mSIO6va7taONF7OlqdZoV
 jhaGk47RW9L/O+xah4/dbdCNTUZGGiBl3BI/ST24ORi/z8zdlIcnpC5vBJ8dIPQhnHV4
 wMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752513126; x=1753117926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFEABrz09PRVJtSwGR7XZVcPkDQ31BL1yexOwg/pAxM=;
 b=HbdzIxAKGvHbMTrgnMiTlUi3Y0ltX2+E3lgrCMJmsv3B4blnISpER1BiaSJERPCYil
 v2F/oD3qmt0A6OxLqLGMwJmu0rkzoTdDaALskOp2Wt7W6CU3MyiszkPSnjgsP2/c3eEf
 N3KsGezWiKGdbgkNdW5d6EXC4ACGCRZH2wa1QFDwt3JoiuX2TY1/GypvxfhMKZUVhoac
 D8vGC3b8BgaRVSVhCjKe6BUNyu8LVpk26yzs0Bcw40W0qtyt7RQpYHQ8C26LjK1qUXpZ
 VC7vfEsJTQVVmRaaWIf9eoinGRgzexF7StvUlIh9Fo7GjKMJix0t6dYs1L9oQ+ClpVL7
 r7Qw==
X-Gm-Message-State: AOJu0Yy03kOBVPwRLQtJsUuvLDsXcPp69I8Di+TH1QLn5Grc4u7atIjy
 sI9/kIKPIeuVaw5gU7JjhrqoDEzQ+oLnky8tyMuXa9RDXYdGchGVyLQC1+2EN8UU+Xtu+R6hmfl
 eJgDv
X-Gm-Gg: ASbGncvKliMHq0gfaaBAq9b6Yrc/AOBcB3s3eR9HFehI/49IeEGQ12XBPt9rWgr/+xL
 M8w58Vv4srrSiEHM0A3ouGnw4iHDKh0Zu7iBl1XtShc0JhY5dj9/cIwf3cNgXAmvA6uRwjypcU+
 LJYbVTpQEW3QccTqZTTe7XGWmRV8t2Ta0l4ArJts+tYgEjdke6xSeiFDTQLf+L6m8LAZ2mSX+RN
 6TL6JtXvn1mOmUm+S5qIfdisR44oIB2fBdSprE0u79lPYrk2bhDF8pJgbjxlDSUZ/69Qs4hkZfU
 Nw2itnmDMnieygATXJJ/yh66kGncVbnxAeAmyr/ZFMIAVM0KgVJ4FR4E+AyXJQmnnQv8tgXG3jk
 3ReFhNYi3H05EaWsglo5Kq9VmqotWuudYUAHkYhqhbXuVEKe19+7+HBcdV03J2tYh6DVm1KsWeC
 qme1k+zNvLwg==
X-Google-Smtp-Source: AGHT+IHhgBJqVeJRtHxA1+FqIpnQTX1xLhz8u5g9CSjHkWlf110di7PKUlmx+a52b1CDwo+2ecKVqw==
X-Received: by 2002:a05:600c:c176:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-454ec263d7cmr101920495e9.20.1752513126072; 
 Mon, 14 Jul 2025 10:12:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:3743:80cb:93ed:a9a8?
 ([2a0a:ef40:e07:801:3743:80cb:93ed:a9a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd181bsm12601759f8f.7.2025.07.14.10.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 10:12:05 -0700 (PDT)
Message-ID: <04953cfc-0475-4560-bd7c-fee27739e351@linaro.org>
Date: Mon, 14 Jul 2025 18:12:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unreachable code
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
 <20250714162951.GI13084@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250714162951.GI13084@bill-the-cat>
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

On 14/07/2025 17:29, Tom Rini wrote:
> On Mon, Jul 14, 2025 at 04:38:53PM +0100, Andrew Goodbody wrote:
>> The two functions blk_find_first and blk_find_next use a for loop with
>> the content being a 'return 0' which means that the 'increment' code is
>> unreachable so remove it and also remove the variable ret which is
>> assigned to but its value is never used.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/block/blk-uclass.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
>> index f3ac8db9464..b38c21ffbe2 100644
>> --- a/drivers/block/blk-uclass.c
>> +++ b/drivers/block/blk-uclass.c
>> @@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
>>   
>>   int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
>>   {
>> -	int ret;
>> -
>> -	for (ret = uclass_find_first_device(UCLASS_BLK, devp);
>> -	     *devp && !blk_flags_check(*devp, flags);
>> -	     ret = uclass_find_next_device(devp))
>> +	for (uclass_find_first_device(UCLASS_BLK, devp);
>> +	     *devp && !blk_flags_check(*devp, flags);)
>>   		return 0;
>>   
>>   	return -ENODEV;
>> @@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
>>   
>>   int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
>>   {
>> -	int ret;
>> -
>> -	for (ret = uclass_find_next_device(devp);
>> -	     *devp && !blk_flags_check(*devp, flags);
>> -	     ret = uclass_find_next_device(devp))
>> +	for (uclass_find_next_device(devp);
>> +	     *devp && !blk_flags_check(*devp, flags);)
>>   		return 0;
>>   
>>   	return -ENODEV;
> 
> Should we clean up uclass_find_next_device(...) to not return int? The
> function comments don't quite make sense (include/dm/uclass-internal.h)
> and it always returns 0.

OK, that should not be too bad.

Andrew
