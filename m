Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7733C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 16:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB27B82D83;
	Wed, 25 Jun 2025 18:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RY+wFT07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C3382D88; Wed, 25 Jun 2025 18:31:29 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0463082D21
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 18:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so55194435e9.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750869082; x=1751473882; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PBth7QNjRqQXRZKkXVWPTYQU+CyN5dPfZsTOtw2aW5E=;
 b=RY+wFT07J1OdZXhLSDTdej8OiL+lgSwg0a9NjPDfRvzMBt81oN6f/cr/tUuJcGWx6G
 T9n094pv0YigZeXI1ImKCxfeOXNHt8wNrYkq4WlAU4Ni2YgXP4xy3VEXxiksM/OHW1JD
 tLRJLtHBWJeXNpcSdncp8BqGq/XJByNYWfrOWqsA/Hy/JMkeLmJoc/oNXbK4mm9x+Iy1
 69ia3uKuhrbeodGZXrX+9sFL4nYWuOhvAiN35aFt8Ps6Y7avjVjSaj/2blD8FPT8tgaW
 edd4a/Iuf6sPBucVUcKuaeM6B2UIUwgF9zCX7nswQzSxoXzC8G21hXoNIRlJYpxviFPS
 bimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750869082; x=1751473882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PBth7QNjRqQXRZKkXVWPTYQU+CyN5dPfZsTOtw2aW5E=;
 b=njNqruzIX5xEgdsTK3YUC7QjKARi1s75SO1966NXdl/06VJPvNQycWFTJzQU3eXRoe
 6usv7PkIs75SziLFYN6TRF2p50fElUMfyX9kMFoSE2LH0Wo+liHIuYoWnTxhbcErZafd
 iatUKGtTKx+CkZQ8iDcq8x4DoEwIrpi8dYiPKgMfV0NwC9QNuZ/hBhb0SZ72nlUT/qRU
 GWdNIcBTxtKg9uhD4yyyiMjTR3+guUpSrxy/VCdT6g8bRCJajvSqIiLd5QSOQG13l25M
 gq3fB7ccUS+rnv9la49eWOMW+/F7POkbEV9lIWqWSCuVMgoMGOZuJppfdFBtt1o1ecIm
 KKDQ==
X-Gm-Message-State: AOJu0YzuiF2hsIV2Z0peHfX//QLO10PM1TP/JMEKjBWE/j6IU/47QhJ1
 2Nm12bWZMLeGXdIcu/CvaJA+4ugNW3mRuO9XMZJ1gnVUkK7pHNxh4lWNSP+WAFrFynDh5Lyo0Hn
 jHe0D2Hg=
X-Gm-Gg: ASbGncuXfNhDaTpGGWQpHY6DIHw5w+NdvLSmDBmZLIJT4xyvXiGCazudJeWh7FBX+8S
 S9vhBD9PUzVbAtUgQlX4rPeB2d1v8TBr0XtcZ512AuD3q5GNLCAIcg44dTmmPgpZiLsJefBm5II
 T+oR0v8vIGVc3rycG5+1/w4/MfCYD3iWxETuEowW+QfED14nyUd59NXT4Z5j6qX+FusUDLRUAhF
 ypk3T+7fP34nsrjF5+SfQ1PYMhfT3zn1OBzqTgIiy7yltyOXHRkahlSRY6UUU/Xvz4vnsXcc75M
 heKAbMr7/rPLh9oBSaA/7ulH4zcCzdqQJMUuaSW98TiP9y1ArwzqX27rLjHvkTWKz3xjDoWZ874
 L89X92VTwhfQ0gSlEzVe31EsheqyNYSYnhmH5osE=
X-Google-Smtp-Source: AGHT+IGrEjjlmj3boQuZ3WJ7QTbkWfjZ1cdo8QpUHSAMYLq7kT1hRpsL7DqXn+CpES11b6FkCFMIyQ==
X-Received: by 2002:a05:600c:1d04:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-45381ab853fmr36698165e9.11.1750869082084; 
 Wed, 25 Jun 2025 09:31:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5?
 ([2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b75cdsm23933275e9.32.2025.06.25.09.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 09:31:21 -0700 (PDT)
Message-ID: <c5a4f007-0846-42a8-a153-d95cb070dc66@linaro.org>
Date: Wed, 25 Jun 2025 17:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: abootimg: Prevent use of unintialised variable
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
 <87wm8zx0mr.fsf@kernel.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <87wm8zx0mr.fsf@kernel.org>
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

On 25/06/2025 17:10, Mattijs Korpershoek wrote:
> Hi Andrew,
> 
> Thank you for the patch.
> 
> On Wed, Jun 25, 2025 at 16:52, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
> 
>> vhdr can be used when not initialised so detect this condition
>> and exit early to prevent the problem.
>>
>> This issue was found with Smatch.
>>
>> Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> Changes in v2:
>> - Add unmap_sysmem(hdr) in the new exit path
>> - Link to v1: https://lore.kernel.org/r/20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org
>> ---
>>   cmd/abootimg.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
>> index ae7a1a7c83b..31620aa3cfa 100644
>> --- a/cmd/abootimg.c
>> +++ b/cmd/abootimg.c
>> @@ -98,18 +98,20 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
>>   	const struct andr_vnd_boot_img_hdr *vhdr;
>>   
>>   	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
>> -	if (get_avendor_bootimg_addr() != -1)
>> +	if (get_avendor_bootimg_addr() != -1) {
>>   		vhdr = map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
>> +	} else {
>> +		unmap_sysmem(hdr);
>> +		return CMD_RET_FAILURE;
>> +	}
> 
> It's valid for avendor_bootimg_adr() to be -1.
> This is the case for boot image v2 and lower, where there is no
> boot_vendor partition. (so there is no valid vhdr).
> 
> Per my understanding vhdr* is NULL if left unintialised. (I might be
> wrong, please let me know).

A local uninitialised variable is just allocated space on the stack so 
its value is undefined AFAIK.

> android_image_get_data() handles the case where vendor_boot_hdr is NULL:
> """
> 	if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > 2) {
> 		if (!vendor_boot_hdr) {
> 			printf("For boot header v3+ vendor boot image has to be provided\n");
> 			return false;
> 		}
> """
> 
> So I don't think we should early return here.
> If we do, we will probably break boot image v2 support.

Well I guess the alternate fix is to just init vhdr to be NULL?

Andrew

>>   
>>   	if (!android_image_get_data(hdr, vhdr, &img_data)) {
>> -		if (get_avendor_bootimg_addr() != -1)
>> -			unmap_sysmem(vhdr);
>> +		unmap_sysmem(vhdr);
>>   		unmap_sysmem(hdr);
>>   		return CMD_RET_FAILURE;
>>   	}
>>   
>> -	if (get_avendor_bootimg_addr() != -1)
>> -		unmap_sysmem(vhdr);
>> +	unmap_sysmem(vhdr);
>>   	unmap_sysmem(hdr);
>>   
>>   	if (img_data.header_version < 2) {
>>
>> ---
>> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
>> change-id: 20250625-abootimg_fix-51600dc8356a
>>
>> Best regards,
>> -- 
>> Andrew Goodbody <andrew.goodbody@linaro.org>

