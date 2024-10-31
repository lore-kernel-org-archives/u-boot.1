Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0D9E68975
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 11:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0457689262;
	Thu, 31 Oct 2024 12:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l7ZY2Aex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C498929B; Thu, 31 Oct 2024 12:20:27 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF27B89262
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 12:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so496391f8f.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730373625; x=1730978425; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2v56F3V+5xdqS+Aasu/SoaLk4TMNmebI9V9jwIJk77g=;
 b=l7ZY2Aex2xdon6TJvc57KUVjc0ou19ttWXAnGw4sCGZVxILrMZbdlRP7GvoJUrvhiH
 joOi+xaN/di7/V5ozRlXGAf4fEm8vFPYFJLQsnYnXwWcQFzgTSfm6W9gPltoCzPChA8j
 DvUpfLtJYVkbN98E+obdQOVOJh/vpfB19Wjs95rop5YheMJ4kbzLC5OaUm8fUzrqluQG
 qI0l0j8uuWA4SrgMOU3QqRLtF9WGnvXK1Fl6zN8ph0KuzB2PULy7OYKqf52XJG8G9Bst
 EXimTs9dMCIN7tsLjL4Qw0oj0H6HwqLShSibgGnPtCmUjKUbt0KaObxhRXTH+A1ABGEA
 i8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730373625; x=1730978425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2v56F3V+5xdqS+Aasu/SoaLk4TMNmebI9V9jwIJk77g=;
 b=Mep7iqcDYEZQC+TLWnakD4RGfb1UtuYHTWJQdMJYzEwgpKGUp4NcbK6cU6pUMjRxne
 oEUxWlWU43focpuG2tYwvKB2jfV+JG4CfsOCy+DBQvJgKL7I6yZp57K+31MtZzuaTVel
 lpjBYts0t33DLK3dJFBqRd7DP96TflLA1ECL786APpXX4u2awmQKDklb4jyAOrLUVk5C
 vjH5U1q1q4g2PoPysXdjqvlVrBH2zT6LI3T/ZpprC4aCBqLMMw4nZoBx7NDCl2Xn2D1x
 pQBnuOZWHekx+BvuYasCvXX/lQFMQaIXKdSrjycuH6uJvIsAcXn45jLeBHDE8zQVQ4tq
 vLvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv1qH5zvvj4oTDnZfg4OSG4c7LkTR/zR0p0joSIfDqPMBhCcBZt7aHqvXMUaT5uyTm0vj6lt8=@lists.denx.de
X-Gm-Message-State: AOJu0YyNxqzBniysad78nmiZtNTVimicnPCAvNfvq++gwKt5n2mP8EIM
 ubwVO5ZMN7F0DU2S29cSchtKHvo8ZRPPeVQM229XogwF5Zq+ZqZXBYf9fkP6UMs=
X-Google-Smtp-Source: AGHT+IHcXev7CL2sF6sBxM8LMFQ+ZiLwEU6h9EJQTP3+T1oprcwSj+RIxJmKG7ELvmL3FnJUaEef5A==
X-Received: by 2002:a05:6000:1549:b0:37d:46ad:127f with SMTP id
 ffacd0b85a97d-381c14cd98dmr1539174f8f.26.1730373625221; 
 Thu, 31 Oct 2024 04:20:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:edb:fc01:903b:912f:d8eb:af64?
 ([2a0a:ef40:edb:fc01:903b:912f:d8eb:af64])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd74f132sm54873785e9.0.2024.10.31.04.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 04:20:24 -0700 (PDT)
Message-ID: <895194e8-ca21-44d8-a1b4-e31fb1d8b132@linaro.org>
Date: Thu, 31 Oct 2024 11:20:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Fix test dependency on ext4write command
To: "Kumar, Love" <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
References: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
 <f2859286-0e58-4373-b5ff-7121da452ddb@denx.de>
 <PH7PR12MB65388EF5AFC0FC77B30DDCDE83462@PH7PR12MB6538.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <PH7PR12MB65388EF5AFC0FC77B30DDCDE83462@PH7PR12MB6538.namprd12.prod.outlook.com>
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

On 16/10/2024 07:33, Kumar, Love wrote:
> Reviewed-by: Love Kumar <love.kumar@amd.com>
> 
> On 15/10/24, 10:25 PM, Marek Vasut <marex@denx.de> wrote:
> 
> On 10/15/24 4:17 PM, Andrew Goodbody wrote:
>> The tests test_usb_ext4load_ext4write, test_usb_ext2load and
>> test_usb_load depend on the command ext4write being present not just
>> the feature of being able to write to an ext4 file system. So update
>> their dependencies to include the ext4write command itself. This will
>> prevent spurious test failures when running the USB tests against USB
>> storage with an ext2/ext4 partition but no ext4write command available.
>> 
>> Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> 
>>   test/py/tests/test_usb.py | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
>> index fb3d20f082..b86fc290c7 100644
>> --- a/test/py/tests/test_usb.py
>> +++ b/test/py/tests/test_usb.py
>> @@ -382,7 +382,7 @@ def test_usb_ext4ls(u_boot_console):
>>   
>>   @pytest.mark.buildconfigspec('cmd_usb')
>>   @pytest.mark.buildconfigspec('cmd_ext4')
>> -@pytest.mark.buildconfigspec('ext4_write')
>> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>>   @pytest.mark.buildconfigspec('cmd_memory')
>>   def test_usb_ext4load_ext4write(u_boot_console):
>>       devices, controllers, storage_device = test_usb_part(u_boot_console)
>> @@ -469,7 +469,7 @@ def test_usb_ext2ls(u_boot_console):
>>   @pytest.mark.buildconfigspec('cmd_usb')
>>   @pytest.mark.buildconfigspec('cmd_ext2')
>>   @pytest.mark.buildconfigspec('cmd_ext4')
>> -@pytest.mark.buildconfigspec('ext4_write')
>> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>>   @pytest.mark.buildconfigspec('cmd_memory')
>>   def test_usb_ext2load(u_boot_console):
>>       devices, controllers, storage_device = test_usb_part(u_boot_console)
>> @@ -543,6 +543,7 @@ def test_usb_ls(u_boot_console):
>>           pytest.skip('No partition detected')
>>   
>>   @pytest.mark.buildconfigspec('cmd_usb')
>> +@pytest.mark.buildconfigspec('cmd_ext4_write')
>>   @pytest.mark.buildconfigspec('cmd_fs_generic')
>>   def test_usb_load(u_boot_console):
>>       devices, controllers, storage_device = test_usb_part(u_boot_console)
> 
> +CC test expert Simon
> 

Ping
