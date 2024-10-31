Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F045E68975
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 11:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948478929F;
	Thu, 31 Oct 2024 12:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gx9hEUZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FC0892A9; Thu, 31 Oct 2024 12:21:00 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F44B8929F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 12:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539e59dadebso1031047e87.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730373658; x=1730978458; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+KfiFC0P8Islwn7xrvu7PI8uTi8OjdxzZOm5y5h/lvI=;
 b=gx9hEUZuS3QLQiXPpsaGBnvwaf7H/NBq8hKVl0Y+cx6rI2JxE9EGakySssDJc35T3R
 pcOpy3Hs85fqh5B0pLb6YUzYG2Xzd31hU0xTJxsSmgqi1bDuBYy52uNmQ36umHvtC7tN
 I6HmpQjaA3UKWLDQTJ39ka/4MdC7xx2YlfLZmoNvl3eR79BgIs1/elP7/wTpIZjz3M4u
 9MmmHd8t7AFVeI20Qbaj00BKqKkH2jUmMAcsHYa5D7ZfgXYdEt+Axi6U/cY2abrXPGZY
 xttS1qjL/IueR3B2urXcjjWYGoKNMg89i3yNsctRZIQ0SvwhInfw1XQ1Kyjjm4s+rsy1
 giUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730373658; x=1730978458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+KfiFC0P8Islwn7xrvu7PI8uTi8OjdxzZOm5y5h/lvI=;
 b=eSnMXq/m1sVFfQSv1b902M+0i1opXzGh5MBGnZhRVtm1t1RQeOYcnNU/WxrXFGf/0A
 496+y5v0rXmv5iifvj38htQczKis7Y2aSd5qnZcua39A8QJjToZ85lX3WjXwJR1bayFg
 RvOB51ciEup5I9MEyxz7Hg/bwfdri9vkqP4GYRT2OLhx973OSezLhzmtXk2pVo3ozxnf
 fuiZ/Ok82Kj+4b8q3g6mMzwsAwp6YHqOiWv9jf+g9BGDSEzIAa4nkVwvfvmMc7li/VfZ
 Wtf/C+eI58T12PJFsiUVOrNIwT1EUJgPQNVujXIOalLAYupbSDKV3qfX6ZTWdX46gF6U
 8q4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWwjQ95AtpyHKwANHcP6abtnM9m4RS/DaMV6Y9IhG0Sa6NSSPtezqVIbBI3RCZTd9VcHmpgmM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu3jOpxofQgWxfqCdTqVXSLyDQzs+wuZVfvNfSFZG753pVgfKf
 5vANmv2j6WwgOUQIt3T6tOYugfySvpp+zMZ4pJb04cPf6PxMTKUGpCkukTidQNQ=
X-Google-Smtp-Source: AGHT+IHrZI0SgbMJHMB9uRjGKrXrQfXwhC5jk0Xr/I2TDBXg7frSlqpN++1QEmGgfAt0G0ScFGUAkg==
X-Received: by 2002:a05:6512:12c2:b0:53a:16b:f14f with SMTP id
 2adb3069b0e04-53b348f98b5mr10249131e87.19.1730373657688; 
 Thu, 31 Oct 2024 04:20:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:edb:fc01:903b:912f:d8eb:af64?
 ([2a0a:ef40:edb:fc01:903b:912f:d8eb:af64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7bf7sm1857459f8f.9.2024.10.31.04.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 04:20:57 -0700 (PDT)
Message-ID: <bde3217a-0769-4e93-bc7d-d482d3991a19@linaro.org>
Date: Thu, 31 Oct 2024 11:20:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Fix test failure with multiple partitions
To: "Kumar, Love" <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, "Simek, Michal" <michal.simek@amd.com>
References: <20241015121916.1155120-1-andrew.goodbody@linaro.org>
 <c62f454f-b512-44d3-91e1-c53340d3b0c0@denx.de>
 <PH7PR12MB653899B2F46DE801B1D6E10C83462@PH7PR12MB6538.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <PH7PR12MB653899B2F46DE801B1D6E10C83462@PH7PR12MB6538.namprd12.prod.outlook.com>
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

On 16/10/2024 11:14, Kumar, Love wrote:
> On 15/10/24, 10:25 PM, Marek Vasut <marex@denx.de> wrote:
> 
> On 10/15/24 2:19 PM, Andrew Goodbody wrote:
>> When test_usb_load finds multiple partitions of the same type then
>> it will cause a test failure. The call to write the test file will
>> write a different test file to each partition but only return the
>> name and size of the last one written. So the test then fails to
>> load the test file from the first partition as it uses the name of
>> a file on a different partition.
>> 
>> Refactor the code so that only one test file is written at a time
>> and is written to only the partition being tested at that time. This
>> allows the correct file name to always be available to the code that
>> runs the load command. This reduces the number of files written and
>> also the number of calls to crc32 needed.
>> 
>> Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> 
>>   test/py/tests/test_usb.py | 166 +++++++++++++++++++-------------------
>>   1 file changed, 82 insertions(+), 84 deletions(-)
>> 
>> diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
>> index fb3d20f082..e7966cad2b 100644
>> --- a/test/py/tests/test_usb.py
>> +++ b/test/py/tests/test_usb.py
>> @@ -288,6 +288,47 @@ def test_usb_fatls_fatinfo(u_boot_console):
>>       if not part_detect:
>>           pytest.skip('No %s partition detected' % fs.upper())
>>   
>> +def usb_fatload_fatwrite(u_boot_console, fs, x, part):
>> +    addr = u_boot_utils.find_ram_base(u_boot_console)
>> +    size = random.randint(4, 1 * 1024 * 1024)
>> +    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
>> +    m = re.search('==> (.+?)', output)
>> +    if not m:
>> +        pytest.fail('CRC32 failed')
>> +    expected_crc32 = m.group(1)
>> +
>> +    file = '%s_%d' % ('uboot_test', size)
>> +    output = u_boot_console.run_command(
>> +        '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
>> +    )
>> +    assert 'Unable to write' not in output
>> +    assert 'Error' not in output
>> +    assert 'overflow' not in output
>> +    expected_text = '%d bytes written' % size
>> +    assert expected_text in output
>> +
>> +    alignment = int(
>> +        u_boot_console.config.buildconfig.get(
>> +            'config_sys_cacheline_size', 128
>> +        )
>> +    )
>> +    offset = random.randrange(alignment, 1024, alignment)
>> +    output = u_boot_console.run_command(
>> +        '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
>> +    )
>> +    assert 'Invalid FAT entry' not in output
>> +    assert 'Unable to read file' not in output
>> +    assert 'Misaligned buffer address' not in output
>> +    expected_text = '%d bytes read' % size
>> +    assert expected_text in output
>> +
>> +    output = u_boot_console.run_command(
>> +        'crc32 %x $filesize' % (addr + offset)
>> +    )
>> +    assert expected_crc32 in output
>> +
>> +    return file, size, expected_crc32
>> +
>>   @pytest.mark.buildconfigspec('cmd_usb')
>>   @pytest.mark.buildconfigspec('cmd_fat')
>>   @pytest.mark.buildconfigspec('cmd_memory')
>> @@ -309,49 +350,11 @@ def test_usb_fatload_fatwrite(u_boot_console):
>>   
>>               for part in partitions:
>>                   part_detect = 1
>> -                addr = u_boot_utils.find_ram_base(u_boot_console)
>> -                size = random.randint(4, 1 * 1024 * 1024)
>> -                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
>> -                m = re.search('==> (.+?)', output)
>> -                if not m:
>> -                    pytest.fail('CRC32 failed')
>> -                expected_crc32 = m.group(1)
>> -
>> -                file = '%s_%d' % ('uboot_test', size)
>> -                output = u_boot_console.run_command(
>> -                    '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
>> -                )
>> -                assert 'Unable to write' not in output
>> -                assert 'Error' not in output
>> -                assert 'overflow' not in output
>> -                expected_text = '%d bytes written' % size
>> -                assert expected_text in output
>> -
>> -                alignment = int(
>> -                    u_boot_console.config.buildconfig.get(
>> -                        'config_sys_cacheline_size', 128
>> -                    )
>> -                )
>> -                offset = random.randrange(alignment, 1024, alignment)
>> -                output = u_boot_console.run_command(
>> -                    '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
>> -                )
>> -                assert 'Invalid FAT entry' not in output
>> -                assert 'Unable to read file' not in output
>> -                assert 'Misaligned buffer address' not in output
>> -                expected_text = '%d bytes read' % size
>> -                assert expected_text in output
>> -
>> -                output = u_boot_console.run_command(
>> -                    'crc32 %x $filesize' % (addr + offset)
>> -                )
>> -                assert expected_crc32 in output
>> +                usb_fatload_fatwrite(u_boot_console, fs, x, part)
>>   
>>       if not part_detect:
>>           pytest.skip('No %s partition detected' % fs.upper())
>>   
>> -    return file, size
>> -
>>   @pytest.mark.buildconfigspec('cmd_usb')
>>   @pytest.mark.buildconfigspec('cmd_ext4')
>>   def test_usb_ext4ls(u_boot_console):
>> @@ -380,6 +383,39 @@ def test_usb_ext4ls(u_boot_console):
>>       if not part_detect:
>>           pytest.skip('No %s partition detected' % fs.upper())
>>   
>> +def usb_ext4load_ext4write(u_boot_console, fs, x, part):
>> +    addr = u_boot_utils.find_ram_base(u_boot_console)
>> +    size = random.randint(4, 1 * 1024 * 1024)
>> +    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
>> +    m = re.search('==> (.+?)', output)
>> +    if not m:
>> +        pytest.fail('CRC32 failed')
>> +    expected_crc32 = m.group(1)
>> +    file = '%s_%d' % ('uboot_test', size)
>> +
>> +    output = u_boot_console.run_command(
>> +        '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
>> +    )
>> +    assert 'Unable to write' not in output
>> +    assert 'Error' not in output
>> +    assert 'overflow' not in output
>> +    expected_text = '%d bytes written' % size
>> +    assert expected_text in output
>> +
>> +    offset = random.randrange(128, 1024, 128)
>> +    output = u_boot_console.run_command(
>> +        '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
>> +    )
>> +    expected_text = '%d bytes read' % size
>> +    assert expected_text in output
>> +
>> +    output = u_boot_console.run_command(
>> +        'crc32 %x $filesize' % (addr + offset)
>> +    )
>> +    assert expected_crc32 in output
>> +
>> +    return file, size, expected_crc32
>> +
>>   @pytest.mark.buildconfigspec('cmd_usb')
>>   @pytest.mark.buildconfigspec('cmd_ext4')
>>   @pytest.mark.buildconfigspec('ext4_write')
>> @@ -402,41 +438,11 @@ def test_usb_ext4load_ext4write(u_boot_console):
>>   
>>               for part in partitions:
>>                   part_detect = 1
>> -                addr = u_boot_utils.find_ram_base(u_boot_console)
>> -                size = random.randint(4, 1 * 1024 * 1024)
>> -                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
>> -                m = re.search('==> (.+?)', output)
>> -                if not m:
>> -                    pytest.fail('CRC32 failed')
>> -                expected_crc32 = m.group(1)
>> -                file = '%s_%d' % ('uboot_test', size)
>> -
>> -                output = u_boot_console.run_command(
>> -                    '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
>> -                )
>> -                assert 'Unable to write' not in output
>> -                assert 'Error' not in output
>> -                assert 'overflow' not in output
>> -                expected_text = '%d bytes written' % size
>> -                assert expected_text in output
>> -
>> -                offset = random.randrange(128, 1024, 128)
>> -                output = u_boot_console.run_command(
>> -                    '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
>> -                )
>> -                expected_text = '%d bytes read' % size
>> -                assert expected_text in output
>> -
>> -                output = u_boot_console.run_command(
>> -                    'crc32 %x $filesize' % (addr + offset)
>> -                )
>> -                assert expected_crc32 in output
>> +                usb_ext4load_ext4write(u_boot_console, fs, x, part)
>>   
>>       if not part_detect:
>>           pytest.skip('No %s partition detected' % fs.upper())
>>   
>> -    return file, size
>> -
>>   @pytest.mark.buildconfigspec('cmd_usb')
>>   @pytest.mark.buildconfigspec('cmd_ext2')
>>   def test_usb_ext2ls(u_boot_console):
>> @@ -473,7 +479,6 @@ def test_usb_ext2ls(u_boot_console):
>>   @pytest.mark.buildconfigspec('cmd_memory')
>>   def test_usb_ext2load(u_boot_console):
>>       devices, controllers, storage_device = test_usb_part(u_boot_console)
>> -    file, size = test_usb_ext4load_ext4write(u_boot_console)
>>   
>>       if not devices:
>>           pytest.skip('No devices detected')
>> @@ -491,12 +496,9 @@ def test_usb_ext2load(u_boot_console):
>>   
>>               for part in partitions:
>>                   part_detect = 1
>> +                file, size, expected_crc32 = \
>> +                    usb_ext4load_ext4write(u_boot_console, 'ext4', x, part)
>>                   addr = u_boot_utils.find_ram_base(u_boot_console)
>> -                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
>> -                m = re.search('==> (.+?)', output)
>> -                if not m:
>> -                    pytest.fail('CRC32 failed')
>> -                expected_crc32 = m.group(1)
>>   
>>                   offset = random.randrange(128, 1024, 128)
>>                   output = u_boot_console.run_command(
>> @@ -565,15 +567,11 @@ def test_usb_load(u_boot_console):
>>                       addr = u_boot_utils.find_ram_base(u_boot_console)
>>   
>>                       if fs == 'fat':
>> -                        file, size = test_usb_fatload_fatwrite(u_boot_console)
>> +                        file, size, expected_crc32 = \
>> +                            usb_fatload_fatwrite(u_boot_console, fs, x, part)
>>                       elif fs == 'ext4':
>> -                        file, size = test_usb_ext4load_ext4write(u_boot_console)
>> -
>> -                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
>> -                    m = re.search('==> (.+?)', output)
>> -                    if not m:
>> -                        pytest.fail('CRC32 failed')
>> -                    expected_crc32 = m.group(1)
>> +                        file, size, expected_crc32 = \
>> +                            usb_ext4load_ext4write(u_boot_console, fs, x, part)
>>   
>>                       offset = random.randrange(128, 1024, 128)
>>                       output = u_boot_console.run_command(
> 
> +CC Simon the test expert
> 
> Looks good for me.
> 
> Reviewed-by: Love Kumar <love.kumar@amd.com <mailto:love.kumar@amd.com>>
> 
> 
> Regards,
> Love Kumar
> 

Ping
