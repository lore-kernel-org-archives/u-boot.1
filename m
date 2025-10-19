Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA9CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 16:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87BC838BF;
	Sun, 19 Oct 2025 18:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="awenl1ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAAE838CC; Sun, 19 Oct 2025 18:01:45 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382EC831D5
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 18:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-651c77805b7so1510028eaf.1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760889702; x=1761494502; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0H6v2ql5GznyxNWZ4OTmwyJPpOia9X7TwULKfjlZlT4=;
 b=awenl1ijSOgD4HAprGzLOkMSCra2HYN/JmCiiqmverQpHXMvdouHglHGVhmUIsXuEG
 +XI7gMOWsCmNXbBVdfg2gKYv2De7HKq4riUf4osYzXpBYDBWCE+2dmVbblN3CWFZsOlv
 p9N+Lz7gmbWmzxwHdRjqgZ/xoCmPyPsBZvlhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760889702; x=1761494502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H6v2ql5GznyxNWZ4OTmwyJPpOia9X7TwULKfjlZlT4=;
 b=jXDtEHLGjqFgH+NkWpa6wt/qa4cawCmoyCD+mHkozn3Rva/F8lAAV93tMy9A3nD/JN
 E+DuJbSZkD6q61Qx22tWHpBVNEhnDre/Ndb6ojyMlDQrAi0+NKc5EyEJGa4ZWTPtQ4nl
 0019hjrbzXV/xdAVj/Q6NYax5GL0aOA5Pp9yoQj8O7tCyJIcnsbm/ErWnHhjoS1N0w1q
 Rr6mXIgqQcTZiEBTChD7thiMJ1fAND8mFFDbtPCJebXw+U6P6qt6QqhViKKiTQC71kE2
 uAUBFgShLAkDxqonXxz1x2ovQaLLaenXwvJpkl3QDO3hnLXWRVGUmLjn0mylTVH8sfDc
 1BhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvWaHebv2gVjvSWoRP0lAlri4Ux9auVm+JJ7PmEqt5hPLwbMqZ1wEAAYaZFsGGhpnsnZr/FP8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw06xfu3pVemlH5fSApzTYLEU/uam91Dgqih8I+0/7Ksjq3IdxR
 DxCi44lBp85GbVFlxkijE7XMYUjq/PzpG2IW4t2osY8WASvDP0rlA6qlMAA/D/jj0oQ=
X-Gm-Gg: ASbGncuUpG9ANnnhy9MIevsA1p+jxzBh20MXvng1fwXvi0RS7yIt874Hs5yN/Z9sjOP
 9S70wBef1DtlcToVxbHbxGg4rdu5+Og1fXmq4Ebohmda93GNzNZ649ZxWp3yNvMb8nDQ2vOFijz
 12cPk2tQ3gZCEIdOX3tt+rbbj14+Q1pbo4lYp2y06sHvVIwgzhI4WcKnp+itHl7LqRaBoTAIduA
 UcjUdXKca0xEQEzV/ys1+BKQHoumkODjXKd4QvKqB6jKwRdKiFMA5w2drveJq5yphZLzexLs6E7
 7iLej4kqaKUH12ApSZ+1+KO5+f5o8S5cyPkQ5gsY1rZHrUScF7ikP1rtU0x00hyxaCuGEm3YONk
 Uo++FaBqv7EfEjKv3tPP7yB9Gv/X76MAAdVGHuXrJ9hpKcIgl/EygGX0JxEoGBtxw3qCoWGV4FK
 1oo68Ko8rJKHHe7D6LrfNmnystD45i+JpGPTEwUOnI0kYSAq4lUA==
X-Google-Smtp-Source: AGHT+IGFudI2BvMf+JGXya3WGfy9XUrR4cj7z/zNcTQkqfeVX4dhIT3fwbpC6nc0q1WLRSTo04YkBA==
X-Received: by 2002:a05:6808:19a7:b0:43b:2829:e643 with SMTP id
 5614622812f47-443a2f411dbmr4472742b6e.25.1760889701627; 
 Sun, 19 Oct 2025 09:01:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df722e5csm1243510b6e.24.2025.10.19.09.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:01:40 -0700 (PDT)
Date: Sun, 19 Oct 2025 10:01:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>,
 George Chan <gchan9527@gmail.com>, Sam Day <me@samcday.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 5/5] test: abootimg: Add test for bootconfig handling
Message-ID: <20251019160136.GO6688@bill-the-cat>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
 <CAFLszTjXxMaQsC2fzDVjnCqPB286A0wkVcXwnoXt7BJDxESNJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4t/LsPgF10VGg1NI"
Content-Disposition: inline
In-Reply-To: <CAFLszTjXxMaQsC2fzDVjnCqPB286A0wkVcXwnoXt7BJDxESNJg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--4t/LsPgF10VGg1NI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 02:06:05PM +0100, Simon Glass wrote:
> Hi Guillaume,
>=20
> On Fri, 17 Oct 2025 at 14:19, Guillaume La Roque (TI.com)
> <glaroque@baylibre.com> wrote:
> >
> > Add test to verify that androidboot.* parameters are correctly extracted
> > from bootargs and appended to the bootconfig section when using
> > 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
> >
> > The test verifies:
> > - androidboot.* parameters are removed from bootargs
> > - They are appended to the bootconfig section in the ramdisk
> > - Non-androidboot parameters remain in bootargs
> > - The bootconfig trailer is properly updated
> >
> > Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> > ---
> >  test/py/tests/test_android/test_abootimg.py | 108 ++++++++++++++++++++=
+++++---
> >  1 file changed, 99 insertions(+), 9 deletions(-)
> >
> > diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/test=
s/test_android/test_abootimg.py
> > index 2aadb692b30..bd5fb992a7d 100644
> > --- a/test/py/tests/test_android/test_abootimg.py
> > +++ b/test/py/tests/test_android/test_abootimg.py
> > @@ -69,15 +69,33 @@ e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543c=
ae734cd01
> >  c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
> >  d43a000000000000000060c53e7544995700400000"""
> >
> > -# vendor boot image v4 hex dump
> > -vboot_img_hex =3D """1f8b0808baaecd63020376626f6f742e696d6700edd8310b8=
24018c6f1b3
> > -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
> > -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
> > -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
> > -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
> > -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
> > -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
> > -309ffea7010000000040f1dc004129855400400000"""
> > +# vendor boot image v4 hex dump (contains initial bootconfig: androidb=
oot.hardware=3Dtest)
> > +vboot_img_hex =3D """1f8b08000000000002ffeddb316a02411806d009a49040606=
d3d84374823a9a348b095
> > +915951b2c9caee8690ce237a91406a0b497603e215dcbc577cf3334cf5350303b3787a
> > +9c4fa6d3e7dbf02b6b63dfc6b01b0180ffe726644d5e37975bb34108c76efa1eb65974
> > +c7fed691c600e02a64e7ab3e8494afe37bd128050000007ae6707ffad202000000f45b
> > +155fd3b67e59eee26751c674a711000000e89ff896aa729b5665d98c37b14a1fb1ca1f
> > +da4f7f5e02000000a0377e0040ab5ba000500000"""
> > +
> > +# bootable boot image v4 hex dump (contains actual bootable kernel)
> > +boot_bootable_img_hex =3D """1f8b08081663ee6802ff626f6f745f626f6f74616=
26c655f76342e696d67
> > +00edd1c14ac3401485e159b80a083ec24dba4f117c81d8140c6dad24ee25
> > +4da6e9d07452321305dfca37d4d4ec5cb954fe6f37ccb967606ef298e6db
> > +2c0d3f94526feae25adda81fae140000000000f8ab66e17c67ecdc1d025d
> > +1d3a89125bf79da9e5beebbc64a7b2d1f27a27cfda7959e9deea369a8263
> > +a0eaecde34e2c75b375495766e3fb46114cca430a7a12dbd96e3654a7663
> > +dfb9f4feeb383514beecbdb1cd1489e3380a5cabf5596ea7c4f78b62acf1
> > +a66ccdbbaea380950100000000f06b79b249b362f5f2b44e16cb87ed3a5d
> > +e67c0a0000000000ffcc27ba944c7e00300000"""
> > +
> > +# bootable vendor boot image v4 hex dump (contains actual bootable ram=
disk)
> > +vendor_boot_bootable_img_hex =3D """1f8b08081663ee6802ff76656e646f725f=
626f6f745f626f6f7461626c65
> > +5f76342e696d6700edd8b10a02310cc6f10c0e7220f8080737b8b93ab9a8
> > +282e571171959e0d787058a84557f5c96ddd7d80c3ff0f92217c5396408e
> > +f56abf30e63090649c9b3c53bd050000fcab57d45b3c35de47db749a06bb
> > +e1eff08c7d0100d00bf6ea826f5dbef0d38b0dee618396f3f27bf69ddedb
> > +b316558a4d462255fe132c4dbdde6e0a160700000000408f7c0027597569
> > +00200000"""
> >
> >  # Expected response for "abootimg dtb_dump" command
> >  dtb_dump_resp=3D"""## DTB area contents (concat format):
> > @@ -179,6 +197,24 @@ def abootimgv4_disk_image_boot(ubman):
> >          gtdi3 =3D AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_=
hex)
> >      return gtdi3
> >
> > +gtdi4 =3D None
> > +@pytest.fixture(scope=3D'function')
> > +def abootimgv4_bootable_disk_image_boot(ubman):
> > +    """pytest fixture to provide bootable boot image v4."""
> > +    global gtdi4
> > +    if not gtdi4:
> > +        gtdi4 =3D AbootimgTestDiskImage(ubman, 'boot_bootable_v4.img',=
 boot_bootable_img_hex)
> > +    return gtdi4
> > +
> > +gtdi5 =3D None
> > +@pytest.fixture(scope=3D'function')
> > +def abootimgv4_bootable_disk_image_vboot(ubman):
> > +    """pytest fixture to provide bootable vendor boot image v4."""
> > +    global gtdi5
> > +    if not gtdi5:
> > +        gtdi5 =3D AbootimgTestDiskImage(ubman, 'vendor_boot_bootable_v=
4.img', vendor_boot_bootable_img_hex)
> > +    return gtdi5
> > +
> >  @pytest.mark.boardspec('sandbox')
> >  @pytest.mark.buildconfigspec('android_boot_image')
> >  @pytest.mark.buildconfigspec('cmd_abootimg')
> > @@ -266,3 +302,57 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, a=
bootimgv4_disk_image_boot, ubm
> >      ubman.run_command('fdt get value v / model')
> >      response =3D ubman.run_command('env print v')
> >      assert response =3D=3D 'v=3Dx2'
> > +
> > +@pytest.mark.boardspec('sandbox')
> > +@pytest.mark.buildconfigspec('android_boot_image')
> > +@pytest.mark.buildconfigspec('cmd_abootimg')
> > +@pytest.mark.requiredtool('xxd')
> > +@pytest.mark.requiredtool('gunzip')
> > +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
> > +                              abootimgv4_disk_image_boot,
> > +                              ubman):
> > +    """Test bootconfig handling with boot image v4.
> > +
> > +    Verifies that androidboot.* parameters from bootargs are appended =
to the
> > +    bootconfig section in vendor_boot image in memory, and that non-an=
droidboot
> > +    parameters remain in bootargs.
> > +    """
> > +
> > +    # Setup addresses
> > +    ram_base =3D utils.find_ram_base(ubman)
> > +    ramdisk_addr_r =3D ram_base + 0x4000000
> > +    ubman.run_command('setenv ramdisk_addr_r 0x%x' % ramdisk_addr_r)
> > +    ubman.run_command('setenv loadaddr 0x%x' % loadaddr)
> > +    ubman.run_command('setenv vloadaddr 0x%x' % vloadaddr)
> > +
> > +    # Set bootargs with androidboot.* parameters
> > +    ubman.run_command('setenv bootargs "androidboot.serialno=3DABC123 =
androidboot.mode=3Drecovery console=3DttyS0"')
> > +
> > +    # Load images
> > +    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
> > +        abootimgv4_disk_image_vboot.path))
> > +    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
> > +        abootimgv4_disk_image_boot.path))
> > +    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr=
))
> > +
> > +    # Extract ramdisk (triggers bootconfig append)
> > +    ubman.run_command('abootimg get ramdisk ramdisk_addr ramdisk_size')
> > +
> > +    # Get ramdisk address
> > +    response =3D ubman.run_command('env print ramdisk_addr')
> > +    ramdisk_start =3D int(response.split('=3D')[1], 16)
> > +
> > +    # Verify androidboot.* parameters were removed from bootargs
> > +    response =3D ubman.run_command('env print bootargs')
> > +    assert 'androidboot.' not in response
> > +    assert 'console=3DttyS0' in response
> > +
> > +    # Get ramdisk size and verify BOOTCONFIG magic at the end
> > +    response =3D ubman.run_command('env print ramdisk_size')
> > +    ramdisk_size =3D int(response.split('=3D')[1], 16)
> > +
> > +    # Dump the end of the ramdisk where BOOTCONFIG trailer should be
> > +    response =3D ubman.run_command('md.b 0x%x 96' % (ramdisk_start))
> > +
> > +    # Verify BOOTCONFIG magic is present
> > +    assert 'BOOTCONFIG' in response or 'BOOTCON' in response
> >
>=20
> It looks like this test could be written in C?

But this is just extending existing tests, and so this is fine. Looking
at
https://source.denx.de/u-boot/u-boot/-/pipelines/27943/test_report?job_name=
=3Dsandbox%20test.py%3A%20%5Bamd64%5D
we can see these tests are currently under 400ms each, FYI.

--=20
Tom

--4t/LsPgF10VGg1NI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPULWAAKCRAr4qD1Cr/k
CvwUAP4iXakGq/rybOhbwtTc8t7Y5XA0lcSrOGN9WHmAzdERdwD/Z+R8BwsRd5s4
/j1xRqRCouLOBkLCWSnnSzzswJW9mQI=
=9764
-----END PGP SIGNATURE-----

--4t/LsPgF10VGg1NI--
