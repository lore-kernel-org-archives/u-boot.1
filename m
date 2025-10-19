Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4471FCCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 13:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E18838AB;
	Sun, 19 Oct 2025 15:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GGQk9xft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7621D838B7; Sun, 19 Oct 2025 15:06:47 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A1983438
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 15:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-33c4252c3c5so1916113a91.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760879203; x=1761484003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PBjpLalxbB6f+xj3QWKySveTsHyU1veN10GNNoYc4k8=;
 b=GGQk9xftXPZetsppWVXDIn80t6XC2VRdG4ZNM7HeZKMhmhvnyrfEr/byCjHUogojKF
 0lknUq0ZNN2qPjGXoeh8Mg+boInhx0JwQo8unauFxoWzTzQc9hIZSlr+kfeD3tmmLgfC
 71oHICa1vHpc8tP5QqU1tTQ7aaHoznwJ6v72k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760879204; x=1761484004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBjpLalxbB6f+xj3QWKySveTsHyU1veN10GNNoYc4k8=;
 b=Hk62DaJZUAnBzSTsnYllEsBNByhZSsm5nAuTPvLn0hiXxawxujsdSoFDUwYbINZHAG
 GZgoTe3PH/JDorYR/XNFNTuvHDHi20eX0F1i/6FvXO2IZ6dpWkRly7ZBcwvOX6/Vh+NU
 37Xj5hlk7Soi/JMycdnCpTH6LTnMBhCUWvqx2KgKyNSlkRCLwVuOGBVhfcxXs3JwYp1e
 fE3eJJQJ4oWf8Kzzx78962PW5gIaGVM+2HzS/3QlBxGHxor7SyoBkgWxE9uGcj4GOHC5
 f9QoHA9rmoLojp3KonZwPuShhuvJsTh20xN4kmnq3il6a4Y/AP/JIXImUVx3eG9wNwyZ
 J9Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7pcbR+JZYGJGL2RCQO0PoRMctk412/Nak7VpzRxyc5rb+w3Yu4Fy4H4cp2I0Esv1mpeWirKw=@lists.denx.de
X-Gm-Message-State: AOJu0YyCVzRRQNItU6S3x7/sdNZ4ieS0nqwqKtGellS5weiP3EhqGmCu
 CjJoqXBRId0yeRveCHHkvqO2KNBm6P/UZeoxwWGC37ElRsKLa7K/AI2rQXXL8exFfYKc4qD8QEz
 IwYZ+21JcLeo3wgd8JAImkgr1oXsKeaLI7ydP7HLU
X-Gm-Gg: ASbGncstcwFy1TCThhNR2mYNVifLb+qjGTR+4U/iSfNFBxDYi8/iu4ks2FQGt+4wOJy
 XKOb4v1pUuRHI40L7gnJEFajXH26YMiV/b4p4FQhC5Vks1+2jj3J8NXd7xFa8AUbP90SWJB0Fux
 T0KZWQwV8fUC8jxcZzJnbThUl9UvRK8wHmFNzgUxGV3kbCi+tP+iMcY14psbq5olAM+Jg2NFq19
 8QSyB/IkKO1dKdMZGcW2rQotvRKusVrOJOOugrAHqrJwTMXiWR3YUqYaeuWTEbcE0P/Pg==
X-Google-Smtp-Source: AGHT+IEad+rVKEhsnKHz4qyUytsxkYnvAEkkNerMuMqD6o7DW6pdT77AQA1ZO+Pk/D+AJU8HpOMecbbDaE/kTtG6zgQ=
X-Received: by 2002:a17:90b:270a:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-33bcf862518mr11180159a91.3.1760879203589; Sun, 19 Oct 2025
 06:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
In-Reply-To: <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 14:06:05 +0100
X-Gm-Features: AS18NWA0HdJ-Pc0bzAc8CbYJTK8BJNe4JSX4gacOuX8RVn-ue8p4Lez-0d-Tpc4
Message-ID: <CAFLszTjXxMaQsC2fzDVjnCqPB286A0wkVcXwnoXt7BJDxESNJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: abootimg: Add test for bootconfig handling
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, 
 George Chan <gchan9527@gmail.com>, Sam Day <me@samcday.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Guillaume,

On Fri, 17 Oct 2025 at 14:19, Guillaume La Roque (TI.com)
<glaroque@baylibre.com> wrote:
>
> Add test to verify that androidboot.* parameters are correctly extracted
> from bootargs and appended to the bootconfig section when using
> 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
>
> The test verifies:
> - androidboot.* parameters are removed from bootargs
> - They are appended to the bootconfig section in the ramdisk
> - Non-androidboot parameters remain in bootargs
> - The bootconfig trailer is properly updated
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++++++++++++---
>  1 file changed, 99 insertions(+), 9 deletions(-)
>
> diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
> index 2aadb692b30..bd5fb992a7d 100644
> --- a/test/py/tests/test_android/test_abootimg.py
> +++ b/test/py/tests/test_android/test_abootimg.py
> @@ -69,15 +69,33 @@ e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
>  c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
>  d43a000000000000000060c53e7544995700400000"""
>
> -# vendor boot image v4 hex dump
> -vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
> -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
> -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
> -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
> -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
> -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
> -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
> -309ffea7010000000040f1dc004129855400400000"""
> +# vendor boot image v4 hex dump (contains initial bootconfig: androidboot.hardware=test)
> +vboot_img_hex = """1f8b08000000000002ffeddb316a02411806d009a49040606d3d84374823a9a348b095
> +915951b2c9caee8690ce237a91406a0b497603e215dcbc577cf3334cf5350303b3787a
> +9c4fa6d3e7dbf02b6b63dfc6b01b0180ffe726644d5e37975bb34108c76efa1eb65974
> +c7fed691c600e02a64e7ab3e8494afe37bd128050000007ae6707ffad202000000f45b
> +155fd3b67e59eee26751c674a711000000e89ff896aa729b5665d98c37b14a1fb1ca1f
> +da4f7f5e02000000a0377e0040ab5ba000500000"""
> +
> +# bootable boot image v4 hex dump (contains actual bootable kernel)
> +boot_bootable_img_hex = """1f8b08081663ee6802ff626f6f745f626f6f7461626c655f76342e696d67
> +00edd1c14ac3401485e159b80a083ec24dba4f117c81d8140c6dad24ee25
> +4da6e9d07452321305dfca37d4d4ec5cb954fe6f37ccb967606ef298e6db
> +2c0d3f94526feae25adda81fae140000000000f8ab66e17c67ecdc1d025d
> +1d3a89125bf79da9e5beebbc64a7b2d1f27a27cfda7959e9deea369a8263
> +a0eaecde34e2c75b375495766e3fb46114cca430a7a12dbd96e3654a7663
> +dfb9f4feeb383514beecbdb1cd1489e3380a5cabf5596ea7c4f78b62acf1
> +a66ccdbbaea380950100000000f06b79b249b362f5f2b44e16cb87ed3a5d
> +e67c0a0000000000ffcc27ba944c7e00300000"""
> +
> +# bootable vendor boot image v4 hex dump (contains actual bootable ramdisk)
> +vendor_boot_bootable_img_hex = """1f8b08081663ee6802ff76656e646f725f626f6f745f626f6f7461626c65
> +5f76342e696d6700edd8b10a02310cc6f10c0e7220f8080737b8b93ab9a8
> +282e571171959e0d787058a84557f5c96ddd7d80c3ff0f92217c5396408e
> +f56abf30e63090649c9b3c53bd050000fcab57d45b3c35de47db749a06bb
> +e1eff08c7d0100d00bf6ea826f5dbef0d38b0dee618396f3f27bf69ddedb
> +b316558a4d462255fe132c4dbdde6e0a160700000000408f7c0027597569
> +00200000"""
>
>  # Expected response for "abootimg dtb_dump" command
>  dtb_dump_resp="""## DTB area contents (concat format):
> @@ -179,6 +197,24 @@ def abootimgv4_disk_image_boot(ubman):
>          gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
>      return gtdi3
>
> +gtdi4 = None
> +@pytest.fixture(scope='function')
> +def abootimgv4_bootable_disk_image_boot(ubman):
> +    """pytest fixture to provide bootable boot image v4."""
> +    global gtdi4
> +    if not gtdi4:
> +        gtdi4 = AbootimgTestDiskImage(ubman, 'boot_bootable_v4.img', boot_bootable_img_hex)
> +    return gtdi4
> +
> +gtdi5 = None
> +@pytest.fixture(scope='function')
> +def abootimgv4_bootable_disk_image_vboot(ubman):
> +    """pytest fixture to provide bootable vendor boot image v4."""
> +    global gtdi5
> +    if not gtdi5:
> +        gtdi5 = AbootimgTestDiskImage(ubman, 'vendor_boot_bootable_v4.img', vendor_boot_bootable_img_hex)
> +    return gtdi5
> +
>  @pytest.mark.boardspec('sandbox')
>  @pytest.mark.buildconfigspec('android_boot_image')
>  @pytest.mark.buildconfigspec('cmd_abootimg')
> @@ -266,3 +302,57 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
>      ubman.run_command('fdt get value v / model')
>      response = ubman.run_command('env print v')
>      assert response == 'v=x2'
> +
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('android_boot_image')
> +@pytest.mark.buildconfigspec('cmd_abootimg')
> +@pytest.mark.requiredtool('xxd')
> +@pytest.mark.requiredtool('gunzip')
> +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
> +                              abootimgv4_disk_image_boot,
> +                              ubman):
> +    """Test bootconfig handling with boot image v4.
> +
> +    Verifies that androidboot.* parameters from bootargs are appended to the
> +    bootconfig section in vendor_boot image in memory, and that non-androidboot
> +    parameters remain in bootargs.
> +    """
> +
> +    # Setup addresses
> +    ram_base = utils.find_ram_base(ubman)
> +    ramdisk_addr_r = ram_base + 0x4000000
> +    ubman.run_command('setenv ramdisk_addr_r 0x%x' % ramdisk_addr_r)
> +    ubman.run_command('setenv loadaddr 0x%x' % loadaddr)
> +    ubman.run_command('setenv vloadaddr 0x%x' % vloadaddr)
> +
> +    # Set bootargs with androidboot.* parameters
> +    ubman.run_command('setenv bootargs "androidboot.serialno=ABC123 androidboot.mode=recovery console=ttyS0"')
> +
> +    # Load images
> +    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
> +        abootimgv4_disk_image_vboot.path))
> +    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
> +        abootimgv4_disk_image_boot.path))
> +    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr))
> +
> +    # Extract ramdisk (triggers bootconfig append)
> +    ubman.run_command('abootimg get ramdisk ramdisk_addr ramdisk_size')
> +
> +    # Get ramdisk address
> +    response = ubman.run_command('env print ramdisk_addr')
> +    ramdisk_start = int(response.split('=')[1], 16)
> +
> +    # Verify androidboot.* parameters were removed from bootargs
> +    response = ubman.run_command('env print bootargs')
> +    assert 'androidboot.' not in response
> +    assert 'console=ttyS0' in response
> +
> +    # Get ramdisk size and verify BOOTCONFIG magic at the end
> +    response = ubman.run_command('env print ramdisk_size')
> +    ramdisk_size = int(response.split('=')[1], 16)
> +
> +    # Dump the end of the ramdisk where BOOTCONFIG trailer should be
> +    response = ubman.run_command('md.b 0x%x 96' % (ramdisk_start))
> +
> +    # Verify BOOTCONFIG magic is present
> +    assert 'BOOTCONFIG' in response or 'BOOTCON' in response
>

It looks like this test could be written in C?

Regards,
Simon
