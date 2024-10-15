Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04274D1D88B
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B639188A9D;
	Tue, 15 Oct 2024 18:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729011341;
	bh=7B623/ecYjvDu+epUDG/Me/48bzBiiqPK46Mbw1MX9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vfX5vde+A6eC8wWnPWXzXHv1bJ3y7eDz8nful/5xnAlnUyY1eAoFQg8adbyFmwXZp
	 yK/QZl+McgrRR4VXS4r2UdIyegojW2cKsohzChwP1toe9ogkOJ80+KFU+wspMpVP3/
	 EbEcX37e0xB2bOXMtkRe83N6k6ZG0ofQBpzPXp+PSs71vO4teLHoWf9t+B3O0zJhrp
	 6Iy0CDD4JCRZij1kcEvE5A75ykajtdhqNUBBs/cZ0OfE8FGscpmq1WIJjsycjkXer0
	 9LKJZZ9PpBGGTmKozJcYxzefckxAOPU//wg/JiP3wgBhvSf9U2vCFW0V+sQNaEciAO
	 642r5LOFtwfaA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F234E88703;
 Tue, 15 Oct 2024 18:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729011340;
 bh=7B623/ecYjvDu+epUDG/Me/48bzBiiqPK46Mbw1MX9E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kFya77P4xszkWM8deVIWahqLTHcbkatPq8K5JL5kJZffmEqnVamuUMjhQ1EO0uQ/l
 ZBxkU5aqJ4sV/Wj8wSZXnHrP0s6zOhKBwX01T/uo6rlzrUVdfXg2O5fie1KQo2RwCg
 /WZSLylx9R2M/ybqd7Q43rlEeRn4qXbjgDInpUMCRUZx5eFnPKiIxa/zs8iM2MrupQ
 Ii8U5Bb0vIj1i8slmxGHz0I8yvb8w3mADAyF755tPTAQUZ96SAwknrq9JAD9+N1CbJ
 80N3MFxgpmNiem/9H+BgHyN9qVsdoQvcl5X9P1uFYqWi6ysoiVux5lIFwSY2fKNunP
 RMm21U5VUF/4g==
Message-ID: <c62f454f-b512-44d3-91e1-c53340d3b0c0@denx.de>
Date: Tue, 15 Oct 2024 17:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: Fix test failure with multiple partitions
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Cc: Love Kumar <love.kumar@amd.com>, Tom Rini <trini@konsulko.com>
References: <20241015121916.1155120-1-andrew.goodbody@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241015121916.1155120-1-andrew.goodbody@linaro.org>
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

On 10/15/24 2:19 PM, Andrew Goodbody wrote:
> When test_usb_load finds multiple partitions of the same type then
> it will cause a test failure. The call to write the test file will
> write a different test file to each partition but only return the
> name and size of the last one written. So the test then fails to
> load the test file from the first partition as it uses the name of
> a file on a different partition.
> 
> Refactor the code so that only one test file is written at a time
> and is written to only the partition being tested at that time. This
> allows the correct file name to always be available to the code that
> runs the load command. This reduces the number of files written and
> also the number of calls to crc32 needed.
> 
> Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> 
>   test/py/tests/test_usb.py | 166 +++++++++++++++++++-------------------
>   1 file changed, 82 insertions(+), 84 deletions(-)
> 
> diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
> index fb3d20f082..e7966cad2b 100644
> --- a/test/py/tests/test_usb.py
> +++ b/test/py/tests/test_usb.py
> @@ -288,6 +288,47 @@ def test_usb_fatls_fatinfo(u_boot_console):
>       if not part_detect:
>           pytest.skip('No %s partition detected' % fs.upper())
>   
> +def usb_fatload_fatwrite(u_boot_console, fs, x, part):
> +    addr = u_boot_utils.find_ram_base(u_boot_console)
> +    size = random.randint(4, 1 * 1024 * 1024)
> +    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
> +    m = re.search('==> (.+?)', output)
> +    if not m:
> +        pytest.fail('CRC32 failed')
> +    expected_crc32 = m.group(1)
> +
> +    file = '%s_%d' % ('uboot_test', size)
> +    output = u_boot_console.run_command(
> +        '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
> +    )
> +    assert 'Unable to write' not in output
> +    assert 'Error' not in output
> +    assert 'overflow' not in output
> +    expected_text = '%d bytes written' % size
> +    assert expected_text in output
> +
> +    alignment = int(
> +        u_boot_console.config.buildconfig.get(
> +            'config_sys_cacheline_size', 128
> +        )
> +    )
> +    offset = random.randrange(alignment, 1024, alignment)
> +    output = u_boot_console.run_command(
> +        '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
> +    )
> +    assert 'Invalid FAT entry' not in output
> +    assert 'Unable to read file' not in output
> +    assert 'Misaligned buffer address' not in output
> +    expected_text = '%d bytes read' % size
> +    assert expected_text in output
> +
> +    output = u_boot_console.run_command(
> +        'crc32 %x $filesize' % (addr + offset)
> +    )
> +    assert expected_crc32 in output
> +
> +    return file, size, expected_crc32
> +
>   @pytest.mark.buildconfigspec('cmd_usb')
>   @pytest.mark.buildconfigspec('cmd_fat')
>   @pytest.mark.buildconfigspec('cmd_memory')
> @@ -309,49 +350,11 @@ def test_usb_fatload_fatwrite(u_boot_console):
>   
>               for part in partitions:
>                   part_detect = 1
> -                addr = u_boot_utils.find_ram_base(u_boot_console)
> -                size = random.randint(4, 1 * 1024 * 1024)
> -                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
> -                m = re.search('==> (.+?)', output)
> -                if not m:
> -                    pytest.fail('CRC32 failed')
> -                expected_crc32 = m.group(1)
> -
> -                file = '%s_%d' % ('uboot_test', size)
> -                output = u_boot_console.run_command(
> -                    '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
> -                )
> -                assert 'Unable to write' not in output
> -                assert 'Error' not in output
> -                assert 'overflow' not in output
> -                expected_text = '%d bytes written' % size
> -                assert expected_text in output
> -
> -                alignment = int(
> -                    u_boot_console.config.buildconfig.get(
> -                        'config_sys_cacheline_size', 128
> -                    )
> -                )
> -                offset = random.randrange(alignment, 1024, alignment)
> -                output = u_boot_console.run_command(
> -                    '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
> -                )
> -                assert 'Invalid FAT entry' not in output
> -                assert 'Unable to read file' not in output
> -                assert 'Misaligned buffer address' not in output
> -                expected_text = '%d bytes read' % size
> -                assert expected_text in output
> -
> -                output = u_boot_console.run_command(
> -                    'crc32 %x $filesize' % (addr + offset)
> -                )
> -                assert expected_crc32 in output
> +                usb_fatload_fatwrite(u_boot_console, fs, x, part)
>   
>       if not part_detect:
>           pytest.skip('No %s partition detected' % fs.upper())
>   
> -    return file, size
> -
>   @pytest.mark.buildconfigspec('cmd_usb')
>   @pytest.mark.buildconfigspec('cmd_ext4')
>   def test_usb_ext4ls(u_boot_console):
> @@ -380,6 +383,39 @@ def test_usb_ext4ls(u_boot_console):
>       if not part_detect:
>           pytest.skip('No %s partition detected' % fs.upper())
>   
> +def usb_ext4load_ext4write(u_boot_console, fs, x, part):
> +    addr = u_boot_utils.find_ram_base(u_boot_console)
> +    size = random.randint(4, 1 * 1024 * 1024)
> +    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
> +    m = re.search('==> (.+?)', output)
> +    if not m:
> +        pytest.fail('CRC32 failed')
> +    expected_crc32 = m.group(1)
> +    file = '%s_%d' % ('uboot_test', size)
> +
> +    output = u_boot_console.run_command(
> +        '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
> +    )
> +    assert 'Unable to write' not in output
> +    assert 'Error' not in output
> +    assert 'overflow' not in output
> +    expected_text = '%d bytes written' % size
> +    assert expected_text in output
> +
> +    offset = random.randrange(128, 1024, 128)
> +    output = u_boot_console.run_command(
> +        '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
> +    )
> +    expected_text = '%d bytes read' % size
> +    assert expected_text in output
> +
> +    output = u_boot_console.run_command(
> +        'crc32 %x $filesize' % (addr + offset)
> +    )
> +    assert expected_crc32 in output
> +
> +    return file, size, expected_crc32
> +
>   @pytest.mark.buildconfigspec('cmd_usb')
>   @pytest.mark.buildconfigspec('cmd_ext4')
>   @pytest.mark.buildconfigspec('ext4_write')
> @@ -402,41 +438,11 @@ def test_usb_ext4load_ext4write(u_boot_console):
>   
>               for part in partitions:
>                   part_detect = 1
> -                addr = u_boot_utils.find_ram_base(u_boot_console)
> -                size = random.randint(4, 1 * 1024 * 1024)
> -                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
> -                m = re.search('==> (.+?)', output)
> -                if not m:
> -                    pytest.fail('CRC32 failed')
> -                expected_crc32 = m.group(1)
> -                file = '%s_%d' % ('uboot_test', size)
> -
> -                output = u_boot_console.run_command(
> -                    '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
> -                )
> -                assert 'Unable to write' not in output
> -                assert 'Error' not in output
> -                assert 'overflow' not in output
> -                expected_text = '%d bytes written' % size
> -                assert expected_text in output
> -
> -                offset = random.randrange(128, 1024, 128)
> -                output = u_boot_console.run_command(
> -                    '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
> -                )
> -                expected_text = '%d bytes read' % size
> -                assert expected_text in output
> -
> -                output = u_boot_console.run_command(
> -                    'crc32 %x $filesize' % (addr + offset)
> -                )
> -                assert expected_crc32 in output
> +                usb_ext4load_ext4write(u_boot_console, fs, x, part)
>   
>       if not part_detect:
>           pytest.skip('No %s partition detected' % fs.upper())
>   
> -    return file, size
> -
>   @pytest.mark.buildconfigspec('cmd_usb')
>   @pytest.mark.buildconfigspec('cmd_ext2')
>   def test_usb_ext2ls(u_boot_console):
> @@ -473,7 +479,6 @@ def test_usb_ext2ls(u_boot_console):
>   @pytest.mark.buildconfigspec('cmd_memory')
>   def test_usb_ext2load(u_boot_console):
>       devices, controllers, storage_device = test_usb_part(u_boot_console)
> -    file, size = test_usb_ext4load_ext4write(u_boot_console)
>   
>       if not devices:
>           pytest.skip('No devices detected')
> @@ -491,12 +496,9 @@ def test_usb_ext2load(u_boot_console):
>   
>               for part in partitions:
>                   part_detect = 1
> +                file, size, expected_crc32 = \
> +                    usb_ext4load_ext4write(u_boot_console, 'ext4', x, part)
>                   addr = u_boot_utils.find_ram_base(u_boot_console)
> -                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
> -                m = re.search('==> (.+?)', output)
> -                if not m:
> -                    pytest.fail('CRC32 failed')
> -                expected_crc32 = m.group(1)
>   
>                   offset = random.randrange(128, 1024, 128)
>                   output = u_boot_console.run_command(
> @@ -565,15 +567,11 @@ def test_usb_load(u_boot_console):
>                       addr = u_boot_utils.find_ram_base(u_boot_console)
>   
>                       if fs == 'fat':
> -                        file, size = test_usb_fatload_fatwrite(u_boot_console)
> +                        file, size, expected_crc32 = \
> +                            usb_fatload_fatwrite(u_boot_console, fs, x, part)
>                       elif fs == 'ext4':
> -                        file, size = test_usb_ext4load_ext4write(u_boot_console)
> -
> -                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
> -                    m = re.search('==> (.+?)', output)
> -                    if not m:
> -                        pytest.fail('CRC32 failed')
> -                    expected_crc32 = m.group(1)
> +                        file, size, expected_crc32 = \
> +                            usb_ext4load_ext4write(u_boot_console, fs, x, part)
>   
>                       offset = random.randrange(128, 1024, 128)
>                       output = u_boot_console.run_command(

+CC Simon the test expert
