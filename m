Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A6EC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 09:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B55F80E9A;
	Wed,  2 Jul 2025 11:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yeclyedi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DD382103; Wed,  2 Jul 2025 11:58:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22768800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 11:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so46518285e9.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751450302; x=1752055102; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aG1FPc8SgwmkOHYJxojVRE0/xTHFpqKCyZhRM6ivE4g=;
 b=yeclyediW9YCz0JujtNs5eQgDR25Fp8yUArhuraf9T5464Z/odl7qBseTmYW7DJTn9
 EBxizZJWHSjvxgOagpDm4Mc2qqB19TlZCPQ4zTlfDv8uQewpDuWgudG0lMhgbEiuHibm
 8wbStvnCzm/Bc8W4Xfz2ebRzCygKw9SX+xh8QSpjszJahcBt88LWQguAj18ORt83pXSv
 C5MxiieSVP/4UlzPpDnqz5kpV4hJLbbixNoZF8NF6kgO5Nn89Uk06bQ+5Ke+qw5NADjZ
 RCTvDnubWTkwAxhn5bXu7ZS3hVfBawjniDd1AifhqZxyqXljAsVr+oRiya3oBMn6aKYp
 CfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751450302; x=1752055102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aG1FPc8SgwmkOHYJxojVRE0/xTHFpqKCyZhRM6ivE4g=;
 b=F8YlgN+qKDnWy+B8T/hlnDnuTfdU8tPgw24PqlkDWeow1i508O11vBr1J2MXjWbK/i
 hDI25A6G9SLc6qjhFHC4t4MAaOqiaQu88bs53PC/V865nF91NfYbD5845Xv/WqZvMyg6
 oV1Xgy5goNFOqx785UUQPwRmN6Cq9X9LsGgVU1bmW3YDuVuynGZ15rPKuPtRjKbaG6AS
 /FNP9HWUL+wbg1gDgEGmwf3pP6C2L3dJczZIBe0O9lNXEs1z0R9ZGgB5OCOTfgoOjW3N
 kRboMUA0iAiLHIZaaRC/WyATZcYVuBDYyjEH4XxcL2bQon+8mo5VBSqj/hEqeX4RcEkX
 WPwQ==
X-Gm-Message-State: AOJu0Yyp9+0DSoFgEtqzt9eYsrWiDQLF4CS2yY54O0C1a4/jlir7CSMC
 cw5DR3sHZuwTsjDylTBE9v2muCWY1mRqN4+8ex52BlE5g+R5vEqPMg5/yLF4fSg/tWg=
X-Gm-Gg: ASbGncvBBR17IKWB5sKUsHe65hq20ndYVFulhq+6kUNPsBoC0UFHfHJunO5ivmXtXs0
 UkQjjNO7M2f5XD7wNRHyHRn4uPzOwnNYT43enI5GX1mX8ZzLk2TgYrUVySpEqYbGnmTgkZ0NxG1
 n1iCYAewITvCdHkx0nmRHkjuJuJ7KTZJ3APAVhKycNLK1UKVW1Yykga+cOJcb0UZTL2jK3nfJiv
 MX/sJFfU/bqlWD6hzXevjOCWz+36ZNnmXpuFB8WIpV22z7BysH8E2mAEvIIYd1NVkP8nh7WKw1h
 XubW2jQcVOORDjSWk4d3z22n8iuw+cwOV7Hred7wMD8mxOisSsx9TujlUcld4zxzmMGxKvFFf+s
 rJLfskJfQUR17CB3t+zznIVVCJf81oeKzinGg524=
X-Google-Smtp-Source: AGHT+IEXF9Bnjy+CDEygWspMvlOCgLiPdACUR7K94WRl1iapG5jhPkbMWw8e2Tpz9zid052PynEs6A==
X-Received: by 2002:a05:600c:609a:b0:453:92e:a459 with SMTP id
 5b1f17b1804b1-454a3c724ffmr18915485e9.16.1751450301672; 
 Wed, 02 Jul 2025 02:58:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30?
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c463asm222619465e9.39.2025.07.02.02.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:58:21 -0700 (PDT)
Message-ID: <0a0eb8f8-1688-417f-8a03-81e48e86ac92@linaro.org>
Date: Wed, 2 Jul 2025 10:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi_loader: Prevent free of uninitialised pointer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Adriano_C=C3=B3rdova?=
 <adrianox@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-3-f3c6e0b0ae43@linaro.org>
 <70773eab-e2ca-4d40-8c9b-947a63fffe7d@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <70773eab-e2ca-4d40-8c9b-947a63fffe7d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 02/07/2025 08:13, Heinrich Schuchardt wrote:
> On 01.07.25 15:38, Andrew Goodbody wrote:
>> Taking a goto to out_of_resources before receive_lengths is assigned
>> will result in an attempt to free an unitialised pointer. Instead
>> initialise receive_lengths to NULL on declaration to prevent this from
>> occurring.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   lib/efi_loader/efi_net.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
>> index 8e708d8d350..3d092523dd5 100644
>> --- a/lib/efi_loader/efi_net.c
>> +++ b/lib/efi_loader/efi_net.c
>> @@ -1130,7 +1130,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>>       struct efi_net_obj *netobj;
>>       void *transmit_buffer = NULL;
>>       uchar **receive_buffer = NULL;
>> -    size_t *receive_lengths;
>> +    size_t *receive_lengths = NULL;
> 
> CCing Adriano as author of the code.
> Did scripts/get_maintainer.pl not show him?

I used 'b4 prep --auto-to-cc' which I thought was enough, but apparently 
not, sorry.

Andrew

> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
>>       int i, j;
>>       if (!dev) {
>>
> 

