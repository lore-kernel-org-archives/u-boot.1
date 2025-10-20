Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A321CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 05:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5328882C84;
	Mon, 20 Oct 2025 07:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gB832kfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFB783043; Mon, 20 Oct 2025 07:19:00 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA341807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso7774673a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 22:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760937537; x=1761542337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=smiiKATT8ts9pNVa9ZpRT9dX5EVhVsWpnUR6nt2Z6A8=;
 b=gB832kfZ9f3IoBwDkFrT41qSAWEuILogZUkge4PntAnr4rIyRcgN7HLV3MvsDG6jmy
 sdwTGz3HIgXP1A5T/JeJ70Fjgfb4oEHQI+Pb8j/20ATqUreZwwiqls6MvFna6umJfbB3
 UUzgD/1VWjjecE41b4r5zdQu0kjuSnD8rQIoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760937537; x=1761542337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smiiKATT8ts9pNVa9ZpRT9dX5EVhVsWpnUR6nt2Z6A8=;
 b=g5qoRkCiqVHWZtesUpHOTJU1Y0fbB+q74UnyQ7TCMu15d8BPZnEJcTgD3Y6RA3FClw
 fcdbLmRz9Ki28wRivr9U924a5gtN3niMWGCRKPbxzuZAeaiqA3oJcCSL49q9Vd5bFmQG
 4YkaqU7Aaxr06Xfga2BcYrTGtzKYEWelytmsoVE7HGakjF5K7aNXkMPvOoU6sEAkhXEy
 lgK6ZRW/tDZgrx7C/zVHDtsrmgHppVCjHxxveNd5GmppkFlFO3PpcnUSjQeetsmu0XQ6
 waYgRkcJgEBQ+Rp7+9fQ+Vst7A5SW6ITqvkt30zP4ka8M2X7TuAHFJRGYnbezZBBMsW9
 yfmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzI9XGCZtXlkzYMqUg8RXRqdVh8YqASojxcu+M+kglEGV9wbT6cfMbMhVcFBftHMqyjwKh0ag=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw+eBh9RuJDx3Unxds8p0WVYbdb+eK+tadO5dDxSDIulq4BC9j
 recH0MxQV6llntyypIqGpALg9QFhk8GI55LCBCFHJvb1Hbl7+++sne4mRO5ckli0sVGDrWxRdGT
 v/sqQC4rRShG8moqtpkHMDHcOpQYyUOs6JlEW6L4D
X-Gm-Gg: ASbGncvtkXw3h6Z4+h3wGuwrzyy4Xd6sdNqyy41nUEwP3wArhM44bWKHO1Z7I6628Ty
 FBjVN6I6oUjpvDRbiJXKMqtZLCINx/OrYrOguJQ3ZcOitAkh47i39o8JsNplZWXOrxIPNkX5QDk
 sqoR+W2YumFTZrWEmtJU4DffbHOF3mmm7ltRhslbwdNg150CLKD6jZ6HKm9aaYU9wKOCwEcGIsG
 JZzvpA0qNy6NlRHHRdngXWOsdlyW9FBvxFfdo03LdgS3MGibzvjka4Elx6DwbOxC9XV
X-Google-Smtp-Source: AGHT+IHt79itob+2PnNBd5ClF+bi8eF10pdFxQt0DOy46LJVUaxQwdb2cbSPPBOx3HF1kApCfXBmz33KnwY92KtkGww=
X-Received: by 2002:a05:6402:42c8:b0:63c:13b9:58b0 with SMTP id
 4fb4d7f45d1cf-63c1e1f1fb8mr12057824a12.5.1760937537213; Sun, 19 Oct 2025
 22:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
 <CAFLszTjXxMaQsC2fzDVjnCqPB286A0wkVcXwnoXt7BJDxESNJg@mail.gmail.com>
 <20251019160136.GO6688@bill-the-cat>
In-Reply-To: <20251019160136.GO6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Oct 2025 06:18:45 +0100
X-Gm-Features: AS18NWCWkGLQUem5LjI-3dMRvv1oWGxmMvFh8Otemmky-ibc7W9ihZtRkEQuSJs
Message-ID: <CAFLszTg7KbiEF8JJBokJt2mbRcWuYFgXmuc8TgxbGiWPo_z4DA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: abootimg: Add test for bootconfig handling
To: Tom Rini <trini@konsulko.com>
Cc: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
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

Hi,

On Sun, 19 Oct 2025 at 17:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 19, 2025 at 02:06:05PM +0100, Simon Glass wrote:
> > Hi Guillaume,
> >
> > On Fri, 17 Oct 2025 at 14:19, Guillaume La Roque (TI.com)
> > <glaroque@baylibre.com> wrote:
> > >
> > > Add test to verify that androidboot.* parameters are correctly extracted
> > > from bootargs and appended to the bootconfig section when using
> > > 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
> > >
> > > The test verifies:
> > > - androidboot.* parameters are removed from bootargs
> > > - They are appended to the bootconfig section in the ramdisk
> > > - Non-androidboot parameters remain in bootargs
> > > - The bootconfig trailer is properly updated
> > >
> > > Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> > > ---
> > >  test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++++++++++++---
> > >  1 file changed, 99 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
> > > index 2aadb692b30..bd5fb992a7d 100644
> > > --- a/test/py/tests/test_android/test_abootimg.py
> > > +++ b/test/py/tests/test_android/test_abootimg.py
> > > @@ -69,15 +69,33 @@ e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
> > >  c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
> > >  d43a000000000000000060c53e7544995700400000"""
> > >
> > > -# vendor boot image v4 hex dump
> > > -vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
> > > -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
> > > -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
> > > -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
> > > -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
> > > -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
> > > -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
> > > -309ffea7010000000040f1dc004129855400400000"""
> > > +# vendor boot image v4 hex dump (contains initial bootconfig: androidboot.hardware=test)
> > > +vboot_img_hex = """1f8b08000000000002ffeddb316a02411806d009a49040606d3d84374823a9a348b095
> > > +915951b2c9caee8690ce237a91406a0b497603e215dcbc577cf3334cf5350303b3787a
> > > +9c4fa6d3e7dbf02b6b63dfc6b01b0180ffe726644d5e37975bb34108c76efa1eb65974
> > > +c7fed691c600e02a64e7ab3e8494afe37bd128050000007ae6707ffad202000000f45b
> > > +155fd3b67e59eee26751c674a711000000e89ff896aa729b5665d98c37b14a1fb1ca1f
> > > +da4f7f5e02000000a0377e0040ab5ba000500000"""
> > > +
> > > +# bootable boot image v4 hex dump (contains actual bootable kernel)
> > > +boot_bootable_img_hex = """1f8b08081663ee6802ff626f6f745f626f6f7461626c655f76342e696d67
> > > +00edd1c14ac3401485e159b80a083ec24dba4f117c81d8140c6dad24ee25
> > > +4da6e9d07452321305dfca37d4d4ec5cb954fe6f37ccb967606ef298e6db
> > > +2c0d3f94526feae25adda81fae140000000000f8ab66e17c67ecdc1d025d
> > > +1d3a89125bf79da9e5beebbc64a7b2d1f27a27cfda7959e9deea369a8263
> > > +a0eaecde34e2c75b375495766e3fb46114cca430a7a12dbd96e3654a7663
> > > +dfb9f4feeb383514beecbdb1cd1489e3380a5cabf5596ea7c4f78b62acf1
> > > +a66ccdbbaea380950100000000f06b79b249b362f5f2b44e16cb87ed3a5d
> > > +e67c0a0000000000ffcc27ba944c7e00300000"""
> > > +
> > > +# bootable vendor boot image v4 hex dump (contains actual bootable ramdisk)
> > > +vendor_boot_bootable_img_hex = """1f8b08081663ee6802ff76656e646f725f626f6f745f626f6f7461626c65
> > > +5f76342e696d6700edd8b10a02310cc6f10c0e7220f8080737b8b93ab9a8
> > > +282e571171959e0d787058a84557f5c96ddd7d80c3ff0f92217c5396408e
> > > +f56abf30e63090649c9b3c53bd050000fcab57d45b3c35de47db749a06bb
> > > +e1eff08c7d0100d00bf6ea826f5dbef0d38b0dee618396f3f27bf69ddedb
> > > +b316558a4d462255fe132c4dbdde6e0a160700000000408f7c0027597569
> > > +00200000"""
> > >
> > >  # Expected response for "abootimg dtb_dump" command
> > >  dtb_dump_resp="""## DTB area contents (concat format):
> > > @@ -179,6 +197,24 @@ def abootimgv4_disk_image_boot(ubman):
> > >          gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
> > >      return gtdi3
> > >
> > > +gtdi4 = None
> > > +@pytest.fixture(scope='function')
> > > +def abootimgv4_bootable_disk_image_boot(ubman):
> > > +    """pytest fixture to provide bootable boot image v4."""
> > > +    global gtdi4
> > > +    if not gtdi4:
> > > +        gtdi4 = AbootimgTestDiskImage(ubman, 'boot_bootable_v4.img', boot_bootable_img_hex)
> > > +    return gtdi4
> > > +
> > > +gtdi5 = None
> > > +@pytest.fixture(scope='function')
> > > +def abootimgv4_bootable_disk_image_vboot(ubman):
> > > +    """pytest fixture to provide bootable vendor boot image v4."""
> > > +    global gtdi5
> > > +    if not gtdi5:
> > > +        gtdi5 = AbootimgTestDiskImage(ubman, 'vendor_boot_bootable_v4.img', vendor_boot_bootable_img_hex)
> > > +    return gtdi5
> > > +
> > >  @pytest.mark.boardspec('sandbox')
> > >  @pytest.mark.buildconfigspec('android_boot_image')
> > >  @pytest.mark.buildconfigspec('cmd_abootimg')
> > > @@ -266,3 +302,57 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
> > >      ubman.run_command('fdt get value v / model')
> > >      response = ubman.run_command('env print v')
> > >      assert response == 'v=x2'
> > > +
> > > +@pytest.mark.boardspec('sandbox')
> > > +@pytest.mark.buildconfigspec('android_boot_image')
> > > +@pytest.mark.buildconfigspec('cmd_abootimg')
> > > +@pytest.mark.requiredtool('xxd')
> > > +@pytest.mark.requiredtool('gunzip')
> > > +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
> > > +                              abootimgv4_disk_image_boot,
> > > +                              ubman):
> > > +    """Test bootconfig handling with boot image v4.
> > > +
> > > +    Verifies that androidboot.* parameters from bootargs are appended to the
> > > +    bootconfig section in vendor_boot image in memory, and that non-androidboot
> > > +    parameters remain in bootargs.
> > > +    """
> > > +
> > > +    # Setup addresses
> > > +    ram_base = utils.find_ram_base(ubman)
> > > +    ramdisk_addr_r = ram_base + 0x4000000
> > > +    ubman.run_command('setenv ramdisk_addr_r 0x%x' % ramdisk_addr_r)
> > > +    ubman.run_command('setenv loadaddr 0x%x' % loadaddr)
> > > +    ubman.run_command('setenv vloadaddr 0x%x' % vloadaddr)
> > > +
> > > +    # Set bootargs with androidboot.* parameters
> > > +    ubman.run_command('setenv bootargs "androidboot.serialno=ABC123 androidboot.mode=recovery console=ttyS0"')
> > > +
> > > +    # Load images
> > > +    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
> > > +        abootimgv4_disk_image_vboot.path))
> > > +    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
> > > +        abootimgv4_disk_image_boot.path))
> > > +    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr))
> > > +
> > > +    # Extract ramdisk (triggers bootconfig append)
> > > +    ubman.run_command('abootimg get ramdisk ramdisk_addr ramdisk_size')
> > > +
> > > +    # Get ramdisk address
> > > +    response = ubman.run_command('env print ramdisk_addr')
> > > +    ramdisk_start = int(response.split('=')[1], 16)
> > > +
> > > +    # Verify androidboot.* parameters were removed from bootargs
> > > +    response = ubman.run_command('env print bootargs')
> > > +    assert 'androidboot.' not in response
> > > +    assert 'console=ttyS0' in response
> > > +
> > > +    # Get ramdisk size and verify BOOTCONFIG magic at the end
> > > +    response = ubman.run_command('env print ramdisk_size')
> > > +    ramdisk_size = int(response.split('=')[1], 16)
> > > +
> > > +    # Dump the end of the ramdisk where BOOTCONFIG trailer should be
> > > +    response = ubman.run_command('md.b 0x%x 96' % (ramdisk_start))
> > > +
> > > +    # Verify BOOTCONFIG magic is present
> > > +    assert 'BOOTCONFIG' in response or 'BOOTCON' in response
> > >
> >
> > It looks like this test could be written in C?
>
> But this is just extending existing tests, and so this is fine. Looking
> at
> https://source.denx.de/u-boot/u-boot/-/pipelines/27943/test_report?job_name=sandbox%20test.py%3A%20%5Bamd64%5D
> we can see these tests are currently under 400ms each, FYI.

Yes, OK. The python tests are ~100x slower though, so we really should
use C where possible. Part of this is being hidden by the overhead of
individually running the C tests from Python. I suppose we could
improve that by running the tests in batches, but I haven't looked at
it.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
