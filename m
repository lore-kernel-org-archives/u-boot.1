Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F51BC7115B
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F3482AA4;
	Thu, 26 Jun 2025 10:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MGKEgbLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD82D82C4C; Thu, 26 Jun 2025 10:21:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37D28006D
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so380399f8f.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750926068; x=1751530868; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dJ78q6ru3yinEkr9G3R69hA6R63WgRQnhoqWnCwGIOs=;
 b=MGKEgbLjkS/VIULz2kf7qi7DUbNsJ0hTTl12kZDjSYRdLIYOAIUBcJnFEbXkBdFHfs
 SC8HMkmnmRaAjdpNJhIFMnoabD/JtQAf/+XPGVKQVwpoPmMyZFVGKTB3DlCkzVGrodwK
 zpUqTbPAzdNLmnUpQjGdmYLnNiOyseyhUDTUd+C1c4hjRnTFV2Lflj97EqIGZe1V+f3O
 mEodySF7JpHH1/ft90pVeOM8LF8UOOporb9yKxm8OIBWLqu2IZcQ448ZQ/MeqBTAFMz5
 d8q/e3eUzD3FuHjKt6xxl4YWXceXD/Qq9buBXu1S02Dt9lP7VxQkORSo7u82vK09GP7j
 CKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750926068; x=1751530868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dJ78q6ru3yinEkr9G3R69hA6R63WgRQnhoqWnCwGIOs=;
 b=Kjrd1o+gdl9dw+W4jQQMbhAejH98RfkJWkaRMM6BfsJMWMxNGDHeGRYVsPmxvTjM58
 81SDAdRFzEz5EcocZTiFdEEXpLlgcWVUNMYk453ygTof6Ax1Rp4yyHNGN7gRsIeDLj+I
 rnoIavNiwo80G/LLJtHSVMDhrXzx6ddjjVoPJ5BLVWsIrTQ1HvTwS9DZ6wVgs3c1EQ7H
 GsyQyhzZsqbqyGVP1TWS0n681TZsZ30ojunIuZ11Rcri6yYOV0XXJUi4GrjOhaTZS7MW
 bT6dexari2wM2OoiMKxmInR5lfnPfqNw66g5v+Ed1lg2LXBQyb6mEPlWQENIcIu/uENc
 N9ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwC8Qoh42W7pvztsA/fr5GP1IrpnoCMT8WPagdH1RV5EawPPstf9m9W2aWmfT/jEncwtlGpfY=@lists.denx.de
X-Gm-Message-State: AOJu0YwRh7mTzMxEF/qkYFB3hKq/wrZ3EA9Bw1EFxfO5Nku/UpGk03ZI
 qv28SVqIA9tH+lqACftm3Lxegh6yn+CkNuD/ahwyQ5DhDLpBh1EecWD6Q2XxyWNcxys=
X-Gm-Gg: ASbGncuNs9mV0BVCAvppAc4GlXEkhffwHD7P3LAOL/xZvfvWif1AYjI6V8TjvQrJTBn
 4iDQCJ/IMfARI432T+MzGZqBT7AvhrBEhmZfegjIStNPGP2ogIoFD9BcWMT0+1TiL1yRCcN+ykL
 xy3tkqCm7ZW48cxV2y3ybf9MKfUOMS5twd3LHcywgt0oQx7AaLjs/rEZ8dmWiL52id7FOaPGml5
 AdAMAU1FcB9TDYlOt9zlPmIwkM23aju+hnx61OQnB9j2L7Ge+KcIwbOYGSClgFZLaHjq/9DPYLp
 RxHvoL+Mz7mLGpWOsBGgRluBeG1jwYFiDG2metHQbE3h+S+NE6v7IfSrSE4qzWxtiYl3hybSaWH
 nfAI/IQg0DPaihNJNwcbGftZAhck6NAeM8aBRFwo=
X-Google-Smtp-Source: AGHT+IErh7lSWip5l8lcVgEZ9H5/XAqoLOvyTISyy/wwUrfuH0Kro6jYJyv2U5qgh5ZI1pPYVFsUmQ==
X-Received: by 2002:a05:6000:178f:b0:3a6:d93e:5282 with SMTP id
 ffacd0b85a97d-3a6ed6690e4mr5197591f8f.59.1750926068250; 
 Thu, 26 Jun 2025 01:21:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:12b:81c6:a008:45a3?
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e805ed03sm6869204f8f.33.2025.06.26.01.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 01:21:07 -0700 (PDT)
Message-ID: <084b0092-68eb-4af7-8288-1f61bf4d0559@linaro.org>
Date: Thu, 26 Jun 2025 09:21:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: initialize 'total' variable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
References: <20250625171528.1062540-1-ilias.apalodimas@linaro.org>
 <688f0e0c-7acd-452a-b941-188b76aa9c2f@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <688f0e0c-7acd-452a-b941-188b76aa9c2f@gmx.de>
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

On 26/06/2025 09:05, Heinrich Schuchardt wrote:
> On 25.06.25 19:15, Ilias Apalodimas wrote:
>> This variable might end up being uninitialized if we exit early.

This commit message could maybe do with expanding a little to make it 
clearer, see below.

>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>   lib/efi_loader/efi_bootmgr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
>> index b9437a81c642..662993fb8095 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -1134,7 +1134,7 @@ efi_status_t 
>> efi_bootmgr_update_media_device_boot_option(void)
>>   {
>>       u32 i;
>>       efi_status_t ret;
>> -    efi_uintn_t count, num, total;
>> +    efi_uintn_t count, num, total = 0;
> 
> 'total' is a non-static local variable.
> The first line using it in origin/next initializes the variable:
> 
>      total = num;
> 
> If we exit early, local variables are discarded.
> Could you, please, explain your concern.

The issue is taking a 'goto out' before total is initialised. 'out:' 
uses the value of total so you can execute that code without having 
initialised total.

FWIW this was also found by Smatch and is in my list to address.

Andrew

> Best regards
> 
> Heinrich
> 
>>       efi_handle_t *handles = NULL;
>>       struct eficonfig_media_boot_option *opt = NULL;
>>
>> -- 
>> 2.49.0
>>
> 

