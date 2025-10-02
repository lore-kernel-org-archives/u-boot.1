Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A1FCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072E8831D3;
	Thu,  2 Oct 2025 13:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kU+/e8l1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B318328F; Thu,  2 Oct 2025 13:03:24 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F1E81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8816A3FE37
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1759403001;
 bh=ocwXhnHfDikYDDBu6w0xFfU+VjMAtBK1Uu2PcHRH2pE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kU+/e8l11AQQmjWyJieYzD+5Uxmmybzg7RtDbvh8G0skPS1MSYQUqzswdmxBdpg+X
 S1KyH5Pbu7jUCvtqm/DgMADsAt4fi3uEYeDL5gqO+Fxrn09HZ7SJ6nqr47R7gqmqOX
 AxaTqlUxfdjQreyp7mAnmMp+1iRrp1ndt9w1TdXpt0YCh5Wc7FUZg6aEwmK0etom4z
 XMRmYxRalV69rWTiZ5oCext+a+aWog3N7w+7qawui7aKak7qxuOgcfJgvbEyJrdgEe
 0oNMTNFIxnBheVNdzhNYgIW8JAk+48ePBertfb+Z3spH2MdFKXBla0nJ6oIdBu29+o
 ahqS9Jpw62Qvg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-41066f050a4so282077f8f.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 04:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759403001; x=1760007801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocwXhnHfDikYDDBu6w0xFfU+VjMAtBK1Uu2PcHRH2pE=;
 b=E32Wi6x94BiqkEoEC9rqPkK25zSQsjPxfyA6U6goRb0oFmuCQHminhPX0Gf0MnAyOl
 DnAZ/PmnnrRNb5bIx4qaIUrUUD5cbuA9zDPev8RDpQaRvxect1021RCtRYtMQBiwr3Hy
 dkkZMnUoqAhF9fXFbF8vEL5SMn8rlEYTQPiIgHLizfv+Wx7nzRXXzQJUlevXSB3q4Wzm
 A3PpQZERRYn2ey5eDGEXWevfhQxct5OUTxi+8OqrPIgmkHWknAxGrWhSze8gVq2a329Z
 CronmJBJe/Fl4Kz+88QlKoiHYRQf0iPwH3/aQEXIdKaAQDMcxNAwryK469XZEsLAJXZD
 2+rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaejFM/VW9J5MfFiI/+iS2CxUnZUyzmkbjBEQicVBGUaUB/PIGax93EtE37a0ppdE6YSxy2Wk=@lists.denx.de
X-Gm-Message-State: AOJu0YwiAewe7MyVLaGxpKUhtsrjsD1OvgLJbKkEeT+zacOhQEA1w5WZ
 wO0cZft6HgSZImG2gQEhBr3T+B0OxhcXp/tRJNYA053dbUu0AZ75ORc5JCDWYPCd5xc1j8y+K+c
 6+7rmUc504J0SnBwkLnROQqg9FeQZrluNNDRjivyhJ38SxlS3cYINp+5OFvnLe085RZclKm0=
X-Gm-Gg: ASbGncuMLBi1nDx42xpE2TRPxRGLKrDSIz9v6ncecknsl0BACJc9rxa8amxrZIWLHHF
 qVvuqPNbddZs7UsheICauU1EbPjG/iIqdYRpSvjKsh2eVaIAVgfpFpidW2l4DcgxdwnVqBHmDFF
 C0YWCiRAQ3uy6zqR9kLkNQk7lodR6wEz+iShWm68p5yVnOtpC7mLn5r4Z4cP+Le0h3RsVBSf5iK
 fjKCr13CYdA6/DiSfovwzqMouO2J/EHgLw5ZzQXOXq+HLSW3dIpPImfOrO13WnzqV9GRQu2IkX7
 Zpg1hPZrvAkDxHU5nJSCjVfSgcrC/4fmQkOSKJMV+iSJ6jQhWGoweUqmdkLXNlfW+rV6WaLnh4c
 ozLZvL94+kdP7TouRGvFxc2L74MQx5MzB2aKXE37HmfA=
X-Received: by 2002:a5d:584d:0:b0:3ce:bf23:3c32 with SMTP id
 ffacd0b85a97d-42557807975mr4735790f8f.22.1759403000949; 
 Thu, 02 Oct 2025 04:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ+5gNocegfs37O97hjJUE3PIMVdhAZjh78JSNm3y8ajf8xZqagXtS8HfmQBkBhY1TdM5Z/w==
X-Received: by 2002:a5d:584d:0:b0:3ce:bf23:3c32 with SMTP id
 ffacd0b85a97d-42557807975mr4735769f8f.22.1759403000478; 
 Thu, 02 Oct 2025 04:03:20 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a8542sm3167877f8f.9.2025.10.02.04.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 04:03:19 -0700 (PDT)
Message-ID: <d8fe4794-118c-4b6e-84ba-c4872221e9c2@canonical.com>
Date: Thu, 2 Oct 2025 13:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <6de97f77-c998-4cf5-8ff4-89a8d4813201@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <6de97f77-c998-4cf5-8ff4-89a8d4813201@linaro.org>
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

On 10/2/25 13:00, Andrew Goodbody wrote:
> On 02/10/2025 10:52, Heinrich Schuchardt wrote:
>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>> After calling a function that can return an error, the test to detect
>>> that error should use the return value not a different variable. Fix it.
>>>
>>> This issue was found by Smatch.
>>>
>>
>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   fs/semihostingfs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>> index 
>>> 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>> --- a/fs/semihostingfs.c
>>> +++ b/fs/semihostingfs.c
>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, 
>>> loff_t pos, void *buffer,
>>>       }
>>>       if (!maxsize) {
>>>           size = smh_flen(fd);
>>> -        if (ret < 0) {
>>> +        if (size < 0) {
>>
>> The ARM specification (https://developer.arm.com/documentation/ 
>> dui0203/ j/semihosting/semihosting-operations/sys-flen--0x0c-) has:
>>
>> SYS_FLEN (0x0C)
>>
>> Returns the length of a specified file.
>> On exit, R0 contains:
>>      the current length of the file object, if the call is successful
>>      -1 if an error occurs.
>>
>> Please, consider that the file length on 32bit systems may exceed 2^31 
>> You must not consider this as an error.

How about changing the smh_flen() interface to:

int smh_flen(int fd, size_t *size)

Best regards

Heinrich

>>
>> %s/if (size < 0)/if (size == -1L)/
> 
> Unfortunately that is not sufficient with the current code. smh_flen() 
> and others will call smh_errno() if the sys call returns -1 so other 
> error codes may possibly be returned. [1]
> This seems to be going well beyond the scope of my patch.
> 
> Andrew
> 
> 1. 80e62ccfa63 arm: smh: Return errno on error
> 
>> Best regards
>>
>> Heinrich
>>
>>>               smh_close(fd);
>>>               return size;
>>>           }
>>>
>>> ---
>>> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
>>> change-id: 20251002-fs_semihosting-85d697fbfcad
>>>
>>> Best regards,
>>
> 

