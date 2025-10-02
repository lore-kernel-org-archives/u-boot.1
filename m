Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A74BCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 15:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6D9828A2;
	Thu,  2 Oct 2025 17:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s5DwjtCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109E4831D3; Thu,  2 Oct 2025 17:07:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9019380107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 17:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5509A3F28B
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1759417674;
 bh=qMDKgH8i/UFF5StGCiGF4L2FEpudwDfIxKqob4emvk8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=s5DwjtCqgfPupoxjgDp9OIYEN8ZX6ZM1jUe/JJx6NHK5M5ryM7IjeTTdoxioUuqq4
 W+NhLkyIvTZUaKaTTF1sL25VvpERgyziOTv3c0h7XUeUS3v4CuECa1ZY0W0wqgHGG6
 IEYpOR/32tNF+YzbaBoRKctHsmln6tcg1uDhovmudtZGku+V6gLvQuaDb7p7jPBLRc
 g2BKI8enXkukysoqSZEYxLtItGvHjZFFUEcKGyqw1GEpxpYUEOeirdvzi1d6H9t/Xz
 AchsFRaxKgOM11jrjDQsP+z6O9MEmTR7DORi4ABMQQBzWGtPVpQX65lj3mmWhrTTE0
 ai2zW3lQE/xxQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so5016695e9.0
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 08:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417674; x=1760022474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qMDKgH8i/UFF5StGCiGF4L2FEpudwDfIxKqob4emvk8=;
 b=Ra3RgFS7Mw1JiLozekG5ajmE8TDpcYXUfP8GpbBfK8jYwjjPxnaf910x9Ttz1fcClX
 gqLo0G2mwdsC1JwbTE+6SDJdL93KLYOkJ9xQXUrbDWiB6E46ZFKyYjExUw1lDMBwTPgJ
 SAeLXxoXwMeITfwuhZUIDrZ90al16TcEDzdbu3xOrwtnbJTwmxExH/9NpRiq3V3s/yxK
 Bbh4ePkHalK8q42uerHb67yjUX17E+H1E1k6RpnwIZDfvJKjS3QqnKWzl+SkTI3+pRTS
 CVGljwPuci4VnZKrUTgMi/oEbIo07m0A3jAtyXQL+oPLx8a/ex095SxekIjLN+hQNeAk
 z90g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlg9KUmx+F6UH858St1k6YkUAe/pZQg8cVXPmwR3OPcxCU1NDdEqrwIc1yxqwNX2m2RogodGQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzJAXTVf5Ss+mMAwGvJPl1E2garNx6plffA//ijjjsXUKGo01Q0
 Sq4yau/1t4MZX8OcGQAzAvcdQDoYKqDO+Bva5iaYADJ9ue661RI2yeMMa5T67shlJgyORbDCw5o
 VwrpCGbYM7BvHXgGYwOwUbWzhT0+J8PIzQ53hjNAJZI/oSQbQhPoL57ghFbjYRqcnCHTaw6s=
X-Gm-Gg: ASbGncvhsoMbTwBsblTR8VyIET/jW4DAhLlJYKVLSVnkAVHitBfRRjk15qSsF68DyDY
 Hex3OTkLd2SSnJTyQQ4dVQoLg1g721Z//hUfLMafqQWtr784A6/5OeJEOP3DK8am2xI9NC2aFAh
 5HPDeK3/pKOmQkFS0yANpkIrRBsuGeX4Gz9PtTrBPP8Lj4IMETO/rJRXingOP2LJra4ZfBpjxN+
 IlkV0uNTRU8JCgGPHqu/4+l0zOgz+xZqxHT9YsyTpydjg1dsOT8wiedzRHdG/8fZ/wWSv3BszC3
 dtgLpVBe9KBdjZSI3AOU5I75ildN4s1IOXerc5scdCeOkIgaKx4um/Q+ftdCHrxQx0t63jSDlZw
 o4huzjSbZ2Zq+4XT37NZJMg9ygXaNtuK/98NAcw1KgME=
X-Received: by 2002:a05:600c:4f91:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46e612e7b19mr62844295e9.37.1759417673705; 
 Thu, 02 Oct 2025 08:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4jbkTZTV4qQJMHhMQGteRVByDd7x5MgzBJ42NWKIlvZ4Gb2bxYNEeJ1lAH62peWZkEwrGYw==
X-Received: by 2002:a05:600c:4f91:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46e612e7b19mr62844015e9.37.1759417673230; 
 Thu, 02 Oct 2025 08:07:53 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6111c1f4sm47875905e9.0.2025.10.02.08.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 08:07:52 -0700 (PDT)
Message-ID: <c0aad39a-a72b-4f1c-b10b-ae922ae4039b@canonical.com>
Date: Thu, 2 Oct 2025 17:07:51 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
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

On 10/2/25 16:36, Sean Anderson wrote:
> On 10/2/25 05:52, Heinrich Schuchardt wrote:
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
>>>    fs/semihostingfs.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>> --- a/fs/semihostingfs.c
>>> +++ b/fs/semihostingfs.c
>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>        }
>>>        if (!maxsize) {
>>>            size = smh_flen(fd);
>>> -        if (ret < 0) {
>>> +        if (size < 0) {
>>
>> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>>
>> SYS_FLEN (0x0C)
>>
>> Returns the length of a specified file.
>> On exit, R0 contains:
>>      the current length of the file object, if the call is successful
>>      -1 if an error occurs.
>>
>> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>>
>> %s/if (size < 0)/if (size == -1L)/
> 
> This cannot occur because on a 32-bit system SYS_FLEN only returns
> 32-bits of information. The host must detect files that exceed 2 GiB in
> size and return -1 (simulating EOVERFLOW).

I don't think so.

QEMU will read into the st_size field of a struct stat and copy that 
value to the return value. The st_size field will have at least 64 bits 
on a 64 bit system. And copying to the 32 bit target will simply 
truncate it.

Expect overruns for files that are larger than 0xffffffff.

Best let's test the real behavior on QEMU with such a large file.

Best regards

Heinrich
