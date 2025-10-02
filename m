Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB8CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 15:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E167F828A2;
	Thu,  2 Oct 2025 17:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jmBMDfsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D153B831D3; Thu,  2 Oct 2025 17:23:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4552F81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 17:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 37AEC46636
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1759418631;
 bh=ohIbsjqS8Zb6qVXhBDc8fRW+DlaDy8sNAoGWlSNLl+4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jmBMDfsxXnpq81zdNpxiQWeyhcYoHlEZskYRx/fzds58QfLo8PY4IO9kGa+whBG1h
 2xjqYJ8yLZV5NAGZ3E6u6s0lHm7zX3RJqN6+WXUqe5N7vuQzt/lhp8NzOdE10bD7VH
 FlmceE2zVmD9cxrJ0seEBJorsKMxBBalY7O4WOYtYm4QV8JaTqZkhObZ2b/nbSn8CO
 OiDe2JGkzt3A9Fko2PVKg3IoW590FsGecB95x4JhWmnErOjlyMsU8DCWqFcCyaJXBt
 Fd4fzDl3b38igZ+aWRFvgOEaxXrqYsM7tAkjQ9jrZpnm9GuWdb1VrCz/oqDF3SKmm8
 bXU7sLgLW480A==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3d73e1ed87so151233766b.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 08:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759418631; x=1760023431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohIbsjqS8Zb6qVXhBDc8fRW+DlaDy8sNAoGWlSNLl+4=;
 b=nhty/Xf/cWgdrznT6pXqaS9TyPhwMnSViiUa2Fsrl0+MJjbk4rUooq+rFe0yTQbzml
 mRD9ByicNQFJfCKWnSTPACbKdSYs6c4KbVOhcou76qF7Gi8kX2raKZQNrykR4Mb83MM+
 TchOjuH6zOiF0S3d4c4Qoz9MNZ3f4yZQxAC8cU70uzzCMU5tzeJywmnJIJg0tpg6F4Q+
 yo46UW5iQIiRGeTnkvVYyQilWGsJW5Y+uyi59vwJ6w3z/W/EM2Rvfq8Epo6b1riDd+qg
 2Wm5EDStS+DnNirh/b7EE4T93XkmG+rgKU6gPk9vAHdLyhCK6Ch/G3oqyT0E18IDpK/s
 LQRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQJSU+6kDNBanaPkEM+VDfyXnDqCcOErFfjYvO3ewdLVtT7UDqybRoNCSXOoOIJ7ZYHibO8U8=@lists.denx.de
X-Gm-Message-State: AOJu0YxpTD8Hub8kl3u/aj2wlnYLRqT91FhmTDxri4HGpGwe5zCoTlJX
 sZMyeLdKL8YghnSMta1+rI3q3T1bVHvaT0Rt1CtUlXWgmfQALvHhTPypRoBjg0tVfdtOvdEhEaW
 D81dNEsprYP8bh3RSHAkqpvAjYBzT5W60XoEbKSDs2X6SHexokZOAm2Pp1EZ69RhdRxzqfv8=
X-Gm-Gg: ASbGncvwpKdZuU5FEttzKsIb4dAlzodozdK+pxMbxhI2+OW+6mb7zNEEJDUR41OwFqr
 japPymPglbQtL7XUP81yP2iRkyaJhc5gi1+BLqOP1lpFPp+9f1yA5jKhjhHt8VaeYzhtiVAbzaM
 7gE+HWgoWGiWlkGTy6Dw9hSulGGIv8dFwkXlhHRFiDsPvgqPOnYChqEskzrzfzag2WBpUAfjcoK
 e4rV/G/Pbj4CwHHyfI1OJBw8ohrc0A6ywsPnY1pRQrFq5fs+/mPkRvg8egZ6dmtJZirG3rHw02Z
 kwd+eG74Ks8ezOwesdmrAnZZEWwmVGiZpTXYmTTorjKSUmpzpHBMfXNA+Hb60Cr1e/9uELcslJZ
 bDv58iw262ILSTuL5JbINNTLVMa/zo1XSUJwofQoTRlY=
X-Received: by 2002:a17:907:94ce:b0:b07:dd5e:16be with SMTP id
 a640c23a62f3a-b4859594206mr514006166b.4.1759418630590; 
 Thu, 02 Oct 2025 08:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeiF+oQ6YGzwFCcYz25o/vkrP7VeHRjyl5e69i20IKzxtOdev9IZxbY+KLD6tD0hQKjZFRXA==
X-Received: by 2002:a17:907:94ce:b0:b07:dd5e:16be with SMTP id
 a640c23a62f3a-b4859594206mr514003366b.4.1759418630174; 
 Thu, 02 Oct 2025 08:23:50 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48652aa040sm220214866b.20.2025.10.02.08.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 08:23:49 -0700 (PDT)
Message-ID: <24b8d055-d90d-4390-8cd7-1541ef989a41@canonical.com>
Date: Thu, 2 Oct 2025 17:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Sean Anderson <sean.anderson@seco.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <c0aad39a-a72b-4f1c-b10b-ae922ae4039b@canonical.com>
 <25dcea70-da3e-499d-90ae-732ebd253a57@seco.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <25dcea70-da3e-499d-90ae-732ebd253a57@seco.com>
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

On 10/2/25 17:15, Sean Anderson wrote:
> On 10/2/25 11:07, Heinrich Schuchardt wrote:
>> On 10/2/25 16:36, Sean Anderson wrote:
>>> On 10/2/25 05:52, Heinrich Schuchardt wrote:
>>>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>>>> After calling a function that can return an error, the test to detect
>>>>> that error should use the return value not a different variable. Fix it.
>>>>>
>>>>> This issue was found by Smatch.
>>>>>
>>>>
>>>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>>>
>>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>> ---
>>>>>     fs/semihostingfs.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>>>> --- a/fs/semihostingfs.c
>>>>> +++ b/fs/semihostingfs.c
>>>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>>         }
>>>>>         if (!maxsize) {
>>>>>             size = smh_flen(fd);
>>>>> -        if (ret < 0) {
>>>>> +        if (size < 0) {
>>>>
>>>> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>>>>
>>>> SYS_FLEN (0x0C)
>>>>
>>>> Returns the length of a specified file.
>>>> On exit, R0 contains:
>>>>       the current length of the file object, if the call is successful
>>>>       -1 if an error occurs.
>>>>
>>>> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>>>>
>>>> %s/if (size < 0)/if (size == -1L)/
>>>
>>> This cannot occur because on a 32-bit system SYS_FLEN only returns
>>> 32-bits of information. The host must detect files that exceed 2 GiB in
>>> size and return -1 (simulating EOVERFLOW).
>>
>> I don't think so.
>>
>> QEMU will read into the st_size field of a struct stat and copy that value to the return value. The st_size field will have at least 64 bits on a 64 bit system. And copying to the 32 bit target will simply truncate it.
>>
>> Expect overruns for files that are larger than 0xffffffff.
> 
> Yes. And there's nothing we can do about this. If there is a 9 GiB file,
> SYS_FLEN will report it as a 1 GiB file. This is a bug in QEMU (and
> OpenOCD too) that we shouldn't attempt to work around in U-Boot.
> 
> --Sean

We should handle a 2.5 GiB file correctly and not treat is an an error.

Such a large file could be an installation ISO that the EFI subsystem 
passes to Linux as memory block device (pmem).

Best regards

Heinrich
