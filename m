Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB33D167F3
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 09:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA6A83CDF;
	Fri,  9 Jan 2026 10:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e82m/R3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A2384119; Fri,  9 Jan 2026 10:57:53 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B0683CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 10:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso24381095e9.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 01:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767952665; x=1768557465;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8RQ60Ap5dd0Gs1ZjiZjtF0ig85WREbhiuivnEvZH/U=;
 b=e82m/R3tXRVl5u/lIr0pcpZyP5ta+vplRMBq4end1OU5ZzSYtqtHXhlSdQsogKUJ5Z
 Rm8dToLAs6grWfMk7jbvgvppEPJ/WIcRAjTEu6wKWjM+DzEhBpNdrazTDm07O9ESP0nk
 CxMlhwXrxh7KY6+Ys5Qg+khD7F2D6ADEuq5QTNbYlvsftWSookMAg6sAk1G+0qmUnzI3
 NNdcb7y7viwF46n0mClkPrEoY48PGkzxFN3KToyfPIh4FS4WGG6+I5Ud1P486hU4Sj+A
 0ZqZXloxD0dQN7o/jjU44x3TIKrz6b5tBTkV556gxuvZzdn4Ly7pcZ9953ix/B0pLxR3
 Hc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767952665; x=1768557465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l8RQ60Ap5dd0Gs1ZjiZjtF0ig85WREbhiuivnEvZH/U=;
 b=EsqqEafvZ6meg6AMUlBMCFk2p155nfUCt8r7tf+7bA22YLGchDDGMZn6FOOupoQiVz
 mxtVWk+WBBpqf0OpxhJrc6zc60kPCk2fun4/EPfThch/5SemV0mlekvXC9B8wumq+HvF
 sL2ZbZljB33QeDgKJ8VfQiBl38vGu0F5aLhsnjZ/k3lsujbYdQCXTDWu/Eh7+BYALTJb
 cVYpvfQU3a/W1jnnCrBMjcyrBLdSPtOxweG9Y2geGa/cC+UntS+07ZHzZBMpZcKHHpXR
 S/HXbqPyoDJwIfi2liA5nEn+hR99aUM/OQ0cKEcCmu3BRM9gkgjPjcxTVnzn3vqbLoSU
 +S/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0CzjlV2ea2VB67isxPxHsI5M4B7+dzSIznvFtOocV357dd3VvzNndDyEp0P6yO1LOVMBcu00=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2fUGfO83zTOGqHO+KEU8fH9rc1b3rohHqq3364rKD5Uo7iQIL
 xZIGyOaph6fya0GSMrdk/6sEolegE+/7J6AdMJ1EslETDuUuLW1OvLnvVy+n9TkZtIc=
X-Gm-Gg: AY/fxX7Y+mH9GQZOn+5XrjarXiBV3jE7jil72ovYHGweLkKz5DU+Xp0G5ymgpHXGkTF
 Xq+ob98WFVOPu+gqj85efYTm1NkURnFkcWMdifAwjp/5/Li59vO61qvgI1XiH0P+38NBXsEewTK
 QznH8xpvD+p/7GZgOo5W8cxNyqhkrMR5Jkrm8kq4t1cLyTtR5QjVudfyq6QTYmE8+FC227oWJo9
 9JSIceGo6iP8Mzw53hd/tOCu+IrwSMnzXxbKGJQxXHN/HVzCPIag5Fw0TqGbE77ai1B/1F9xfcC
 yYQi2AHDZvziLa1Bolc+fAx921kNxXWlO9lPGGDtD0JCWzYX/IPBOiFw8VARU1nDFozNgAvv6Xj
 9f7jaZTm3LfR/lKDUCguQZoovfw5Nf2G/EGSjzCuw3J7rcpFbxGgfxbk8CY25a8sywgyABHojRc
 z2IFkEwescj9xpFQl30JUSIBtpGb95jsiIY28U2kSz5ryuxS+sC8Rr6CLxoA==
X-Google-Smtp-Source: AGHT+IHj9NmH1MCWBu8aJv80sifG3XZJxESKaH/BoEklSCfUHTr1omXLKHaxmohbmjlZji5Z/PfVCw==
X-Received: by 2002:a05:600c:4694:b0:479:3a88:de5f with SMTP id
 5b1f17b1804b1-47d84b3fa0fmr93427845e9.36.1767952664523; 
 Fri, 09 Jan 2026 01:57:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:679e:49b9:8ae6:8c08?
 ([2a01:e0a:e50:3860:679e:49b9:8ae6:8c08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d870e80bbsm63744155e9.5.2026.01.09.01.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 01:57:44 -0800 (PST)
Message-ID: <2f9bc62b-0fca-498b-ae02-4840e5480b68@baylibre.com>
Date: Fri, 9 Jan 2026 10:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] test: abootimg: Add test for bootconfig handling
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
References: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
 <20251218-bootconfig-v4-5-5bbbdb0be1dc@baylibre.com>
 <87ecnzyx1m.fsf@kernel.org>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <87ecnzyx1m.fsf@kernel.org>
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

Hi Mattijs,

Le 09/01/2026 à 10:07, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.
>
> On Thu, Dec 18, 2025 at 12:17, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:
>
>> Add test to verify that androidboot.* parameters are correctly extracted
>> from bootargs and appended to the bootconfig section when using
>> 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
>>
>> The test verifies:
>> - androidboot.* parameters are removed from bootargs
>> - They are appended to the bootconfig section in the ramdisk
>> - Non-androidboot parameters remain in bootargs
>> - The bootconfig trailer is properly updated
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> I've tested this on top of master
> commit c05dba22f1f2 ("Merge branch 'master' of git://source.denx.de/u-boot-usb")
>
> with:
> $ ./test/py/test.py --bd sandbox --build -k ut
> $ ./test/py/test.py --bd sandbox --build -k android
>
> And I see:
> FAILED test/py/tests/test_android/test_abootimg.py::test_abootimg - ValueError: U-Boot exited with signal 6 (SIGABRT)
> FAILED test/py/tests/test_android/test_abootimg.py::test_abootimgv4 - ValueError: U-Boot exited with signal 6 (SIGABRT)
thanks for testing i will check, in december i don't see this issue i 
investigate and fix it.
>
> Also, see below for some review comments
>
>> ---
>>   test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++++++++++++---
>>   1 file changed, 99 insertions(+), 9 deletions(-)
>>
>> diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
>> index 2aadb692b30..bd5fb992a7d 100644
>> --- a/test/py/tests/test_android/test_abootimg.py
>> +++ b/test/py/tests/test_android/test_abootimg.py
>> @@ -69,15 +69,33 @@ e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
>>   c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
>>   d43a000000000000000060c53e7544995700400000"""
>>   
>> -# vendor boot image v4 hex dump
>> -vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
>> -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
>> -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
>> -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
>> -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
>> -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
>> -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
>> -309ffea7010000000040f1dc004129855400400000"""
>> +# vendor boot image v4 hex dump (contains initial bootconfig: androidboot.hardware=test)
>> +vboot_img_hex = """1f8b08000000000002ffeddb316a02411806d009a49040606d3d84374823a9a348b095
>> +915951b2c9caee8690ce237a91406a0b497603e215dcbc577cf3334cf5350303b3787a
>> +9c4fa6d3e7dbf02b6b63dfc6b01b0180ffe726644d5e37975bb34108c76efa1eb65974
>> +c7fed691c600e02a64e7ab3e8494afe37bd128050000007ae6707ffad202000000f45b
>> +155fd3b67e59eee26751c674a711000000e89ff896aa729b5665d98c37b14a1fb1ca1f
>> +da4f7f5e02000000a0377e0040ab5ba000500000"""
>> +
>> +# bootable boot image v4 hex dump (contains actual bootable kernel)
>> +boot_bootable_img_hex = """1f8b08081663ee6802ff626f6f745f626f6f7461626c655f76342e696d67
>> +00edd1c14ac3401485e159b80a083ec24dba4f117c81d8140c6dad24ee25
>> +4da6e9d07452321305dfca37d4d4ec5cb954fe6f37ccb967606ef298e6db
>> +2c0d3f94526feae25adda81fae140000000000f8ab66e17c67ecdc1d025d
>> +1d3a89125bf79da9e5beebbc64a7b2d1f27a27cfda7959e9deea369a8263
>> +a0eaecde34e2c75b375495766e3fb46114cca430a7a12dbd96e3654a7663
>> +dfb9f4feeb383514beecbdb1cd1489e3380a5cabf5596ea7c4f78b62acf1
>> +a66ccdbbaea380950100000000f06b79b249b362f5f2b44e16cb87ed3a5d
>> +e67c0a0000000000ffcc27ba944c7e00300000"""
>> +
>> +# bootable vendor boot image v4 hex dump (contains actual bootable ramdisk)
>> +vendor_boot_bootable_img_hex = """1f8b08081663ee6802ff76656e646f725f626f6f745f626f6f7461626c65
>> +5f76342e696d6700edd8b10a02310cc6f10c0e7220f8080737b8b93ab9a8
>> +282e571171959e0d787058a84557f5c96ddd7d80c3ff0f92217c5396408e
>> +f56abf30e63090649c9b3c53bd050000fcab57d45b3c35de47db749a06bb
>> +e1eff08c7d0100d00bf6ea826f5dbef0d38b0dee618396f3f27bf69ddedb
>> +b316558a4d462255fe132c4dbdde6e0a160700000000408f7c0027597569
>> +00200000"""
> Can we use boot_bootable and vendor_boot_bootable images for the other tests
> as well? (for example for testing bootmeth_android)
>
> This would reduce the amount of images we need.
image image was not complete so i recreate new one to have possibility 
to load ramdisk without issue.
i will probably need to move bootmeth android test on this new image and 
remove initial . i will check
>
>>   
>>   # Expected response for "abootimg dtb_dump" command
>>   dtb_dump_resp="""## DTB area contents (concat format):
>> @@ -179,6 +197,24 @@ def abootimgv4_disk_image_boot(ubman):
>>           gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
>>       return gtdi3
>>   
>> +gtdi4 = None
>> +@pytest.fixture(scope='function')
>> +def abootimgv4_bootable_disk_image_boot(ubman):
>> +    """pytest fixture to provide bootable boot image v4."""
>> +    global gtdi4
>> +    if not gtdi4:
>> +        gtdi4 = AbootimgTestDiskImage(ubman, 'boot_bootable_v4.img', boot_bootable_img_hex)
>> +    return gtdi4
>> +
>> +gtdi5 = None
>> +@pytest.fixture(scope='function')
>> +def abootimgv4_bootable_disk_image_vboot(ubman):
>> +    """pytest fixture to provide bootable vendor boot image v4."""
>> +    global gtdi5
>> +    if not gtdi5:
>> +        gtdi5 = AbootimgTestDiskImage(ubman, 'vendor_boot_bootable_v4.img', vendor_boot_bootable_img_hex)
>> +    return gtdi5
>> +
>>   @pytest.mark.boardspec('sandbox')
>>   @pytest.mark.buildconfigspec('android_boot_image')
>>   @pytest.mark.buildconfigspec('cmd_abootimg')
>> @@ -266,3 +302,57 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
>>       ubman.run_command('fdt get value v / model')
>>       response = ubman.run_command('env print v')
>>       assert response == 'v=x2'
>> +
>> +@pytest.mark.boardspec('sandbox')
>> +@pytest.mark.buildconfigspec('android_boot_image')
>> +@pytest.mark.buildconfigspec('cmd_abootimg')
>> +@pytest.mark.requiredtool('xxd')
>> +@pytest.mark.requiredtool('gunzip')
>> +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
>> +                              abootimgv4_disk_image_boot,
>> +                              ubman):
>> +    """Test bootconfig handling with boot image v4.
>> +
>> +    Verifies that androidboot.* parameters from bootargs are appended to the
>> +    bootconfig section in vendor_boot image in memory, and that non-androidboot
>> +    parameters remain in bootargs.
>> +    """
>> +
>> +    # Setup addresses
>> +    ram_base = utils.find_ram_base(ubman)
>> +    ramdisk_addr_r = ram_base + 0x4000000
>> +    ubman.run_command('setenv ramdisk_addr_r 0x%x' % ramdisk_addr_r)
>> +    ubman.run_command('setenv loadaddr 0x%x' % loadaddr)
>> +    ubman.run_command('setenv vloadaddr 0x%x' % vloadaddr)
>> +
>> +    # Set bootargs with androidboot.* parameters
>> +    ubman.run_command('setenv bootargs "androidboot.serialno=ABC123 androidboot.mode=recovery console=ttyS0"')
>> +
>> +    # Load images
>> +    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
>> +        abootimgv4_disk_image_vboot.path))
>> +    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
>> +        abootimgv4_disk_image_boot.path))
>> +    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr))
>> +
>> +    # Extract ramdisk (triggers bootconfig append)
>> +    ubman.run_command('abootimg get ramdisk ramdisk_addr ramdisk_size')
>> +
>> +    # Get ramdisk address
>> +    response = ubman.run_command('env print ramdisk_addr')
>> +    ramdisk_start = int(response.split('=')[1], 16)
>> +
>> +    # Verify androidboot.* parameters were removed from bootargs
>> +    response = ubman.run_command('env print bootargs')
>> +    assert 'androidboot.' not in response
>> +    assert 'console=ttyS0' in response
>> +
>> +    # Get ramdisk size and verify BOOTCONFIG magic at the end
>> +    response = ubman.run_command('env print ramdisk_size')
>> +    ramdisk_size = int(response.split('=')[1], 16)
>> +
>> +    # Dump the end of the ramdisk where BOOTCONFIG trailer should be
>> +    response = ubman.run_command('md.b 0x%x 96' % (ramdisk_start))
>> +
>> +    # Verify BOOTCONFIG magic is present
>> +    assert 'BOOTCONFIG' in response or 'BOOTCON' in response
> Why verifying both BOOTCONFIG and BOOTCON ?
> According to [1], the magic is BOOTCONFIG. So this makes checking for
> BOOTCON irrelevant.
error from me i will fix
>
> [1] https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig#bootloader-changes
>
>> -- 
>> 2.34.1


