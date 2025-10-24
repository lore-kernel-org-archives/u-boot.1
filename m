Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0052CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 15:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1205C83678;
	Fri, 24 Oct 2025 17:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IMV47Ge/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496F9836A3; Fri, 24 Oct 2025 17:20:47 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C8583655
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 17:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-443aa90f025so1229196b6e.0
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761319243; x=1761924043; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c+rIVvRnzorUmYD94I8K8SMrZQ9opVZahy+W4qn+aWI=;
 b=IMV47Ge/93pARfLhS133vbjcaPezOIFectsROIM7hJ/nvQBk34WZpSFCfdujgAaG1u
 yz9BS21oBZuK7T+2G/yN7aERYCkpaE3ZC5vEI9gCB9aKfBtVMo4KRJdaPCsfVoyZnqAo
 ugthWMtQif1G9/FZVGd4mqokw9WeJ8Mszq35I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761319243; x=1761924043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+rIVvRnzorUmYD94I8K8SMrZQ9opVZahy+W4qn+aWI=;
 b=gWrdtOWUFCtnqLRYffRTc0ub4A7qYYDE+MmyOs6ZobXSUwZx1QS541aDL7AeftzYtN
 tn3X6fKbmO2ghuid7Z4Q2Vk384S0XVq/rk8yUS74PuSIClcmbhGqf6Czyadfxs5md67R
 lsoARA7FNaS0c0lZbYI6ii2l1+Q9SpaUgz8iarEsAVcwIuv9CL91/8vaEkjot5jfkmqK
 f1X7o96Br1BWIC9ZKNNUc7znuxmcuxrzE7o5pNe1QqJtxUshQHvaW2Vtyrbg2CaZLa/r
 QkuFBbB+8zdvEmgOw+xKe4LWbB53EtcuqymnU8rhUjsFmwjVGa99VoszGgyigB92g/2t
 POYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRyjqcCCgYLR/gVROlO6hGqBUhanH7Dra5XHENru98N9LyZh7fpfUWHBgcYOHq7z+xxtMXfm4=@lists.denx.de
X-Gm-Message-State: AOJu0YxViGSIbIbgKIvcOxzEJmmHeWtwrvj8mUgAF4PPvwU+u+7JtR+p
 97jJanhjyeiDSIyPkgP9BT9gR5exZFf1GcauCDfztGhPWj2cMJjXQwu3bt+cnfmGhAs=
X-Gm-Gg: ASbGncv+wHwN2xPWd19kzptEyZKclCG94TuY2U12sKHVWGuep5kJAQL3n+VeqT6oTHP
 a/CJaYe0TyqHUI0rSTywjFDZnb11XgOsEaY4rUDRSKVgPhrg7sxtucLCyMLh+qLLTraDhlvCGxW
 UWiGz5jIriclfadFaP497qGSzMOIfqffNHeGURkUXhuaouqw5/rXPmvmF6nXH1V24LgpXnyiQ5b
 iZFHk0NQvGiilgo+MWenA3rPzcKoamMi9gBNi9K8i0awi1j8h5NWsG8P9bXCLMag3wZU0eCrgZK
 f5Zfp6zETPTN2vK4drjTfqr7LlxWJkcBL1PVmV0g1kD9RrN7cbS1dJ4y6pOLOKq7pRAbCpkpKI/
 WT4jQBtS76JZNmr89XuvAqrwklvoG++tkjIh7IQB6int+yF9TvWiVgTAqjk6ZuaezQwXn6uhOsc
 SuiDkZylrwGzmPxAPzWR7T2Rj5iQOTj6IvyW0iB9sqhppn/pNRlQ==
X-Google-Smtp-Source: AGHT+IEOX6UZprWS0DZE6Y9UM9ZAfXMXsGkP1J50LGYaf9n8hElmrjf1HbBOopCo1XxqgyZWh0vppA==
X-Received: by 2002:a05:6808:4d06:b0:44d:9e0a:eef2 with SMTP id
 5614622812f47-44d9e0af560mr212473b6e.65.1761319242977; 
 Fri, 24 Oct 2025 08:20:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44bd44bfad2sm1198735b6e.18.2025.10.24.08.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 08:20:42 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:20:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>,
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
Message-ID: <20251024152039.GP6688@bill-the-cat>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
 <CAFLszTjXxMaQsC2fzDVjnCqPB286A0wkVcXwnoXt7BJDxESNJg@mail.gmail.com>
 <20251019160136.GO6688@bill-the-cat>
 <CAFLszTg7KbiEF8JJBokJt2mbRcWuYFgXmuc8TgxbGiWPo_z4DA@mail.gmail.com>
 <bac88430-cadc-4306-92e1-d83ff5937f25@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9BoPv0cYuGAo+dzX"
Content-Disposition: inline
In-Reply-To: <bac88430-cadc-4306-92e1-d83ff5937f25@baylibre.com>
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


--9BoPv0cYuGAo+dzX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 05:09:07PM +0200, Guillaume La Roque wrote:
> Le 20/10/2025 =E0 07:18, Simon Glass a =E9crit=A0:
> > Hi,
> >=20
> > On Sun, 19 Oct 2025 at 17:01, Tom Rini <trini@konsulko.com> wrote:
> > > On Sun, Oct 19, 2025 at 02:06:05PM +0100, Simon Glass wrote:
> > > > Hi Guillaume,
> > > >=20
> > > > On Fri, 17 Oct 2025 at 14:19, Guillaume La Roque (TI.com)
> > > > <glaroque@baylibre.com> wrote:
> > > > > Add test to verify that androidboot.* parameters are correctly ex=
tracted
> > > > > from bootargs and appended to the bootconfig section when using
> > > > > 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
> > > > >=20
> > > > > The test verifies:
> > > > > - androidboot.* parameters are removed from bootargs
> > > > > - They are appended to the bootconfig section in the ramdisk
> > > > > - Non-androidboot parameters remain in bootargs
> > > > > - The bootconfig trailer is properly updated
> > > > >=20
> > > > > Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> > > > > ---
> > > > >   test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++=
++++++++++++---
> > > > >   1 file changed, 99 insertions(+), 9 deletions(-)
> > > > >=20
> > > > > diff --git a/test/py/tests/test_android/test_abootimg.py b/test/p=
y/tests/test_android/test_abootimg.py
> > > > > index 2aadb692b30..bd5fb992a7d 100644
> > > > > --- a/test/py/tests/test_android/test_abootimg.py
> > > > > +++ b/test/py/tests/test_android/test_abootimg.py
> > > > > @@ -69,15 +69,33 @@ e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7dd=
d3543cae734cd01
> > > > >   c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
> > > > >   d43a000000000000000060c53e7544995700400000"""
> > > > >=20
> > > > > -# vendor boot image v4 hex dump
> > > > > -vboot_img_hex =3D """1f8b0808baaecd63020376626f6f742e696d6700edd=
8310b824018c6f1b3
> > > > > -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
> > > > > -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
> > > > > -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
> > > > > -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
> > > > > -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
> > > > > -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
> > > > > -309ffea7010000000040f1dc004129855400400000"""
> > > > > +# vendor boot image v4 hex dump (contains initial bootconfig: an=
droidboot.hardware=3Dtest)
> > > > > +vboot_img_hex =3D """1f8b08000000000002ffeddb316a02411806d009a49=
040606d3d84374823a9a348b095
> > > > > +915951b2c9caee8690ce237a91406a0b497603e215dcbc577cf3334cf5350303=
b3787a
> > > > > +9c4fa6d3e7dbf02b6b63dfc6b01b0180ffe726644d5e37975bb34108c76efa1e=
b65974
> > > > > +c7fed691c600e02a64e7ab3e8494afe37bd128050000007ae6707ffad2020000=
00f45b
> > > > > +155fd3b67e59eee26751c674a711000000e89ff896aa729b5665d98c37b14a1f=
b1ca1f
> > > > > +da4f7f5e02000000a0377e0040ab5ba000500000"""
> > > > > +
> > > > > +# bootable boot image v4 hex dump (contains actual bootable kern=
el)
> > > > > +boot_bootable_img_hex =3D """1f8b08081663ee6802ff626f6f745f626f6=
f7461626c655f76342e696d67
> > > > > +00edd1c14ac3401485e159b80a083ec24dba4f117c81d8140c6dad24ee25
> > > > > +4da6e9d07452321305dfca37d4d4ec5cb954fe6f37ccb967606ef298e6db
> > > > > +2c0d3f94526feae25adda81fae140000000000f8ab66e17c67ecdc1d025d
> > > > > +1d3a89125bf79da9e5beebbc64a7b2d1f27a27cfda7959e9deea369a8263
> > > > > +a0eaecde34e2c75b375495766e3fb46114cca430a7a12dbd96e3654a7663
> > > > > +dfb9f4feeb383514beecbdb1cd1489e3380a5cabf5596ea7c4f78b62acf1
> > > > > +a66ccdbbaea380950100000000f06b79b249b362f5f2b44e16cb87ed3a5d
> > > > > +e67c0a0000000000ffcc27ba944c7e00300000"""
> > > > > +
> > > > > +# bootable vendor boot image v4 hex dump (contains actual bootab=
le ramdisk)
> > > > > +vendor_boot_bootable_img_hex =3D """1f8b08081663ee6802ff76656e64=
6f725f626f6f745f626f6f7461626c65
> > > > > +5f76342e696d6700edd8b10a02310cc6f10c0e7220f8080737b8b93ab9a8
> > > > > +282e571171959e0d787058a84557f5c96ddd7d80c3ff0f92217c5396408e
> > > > > +f56abf30e63090649c9b3c53bd050000fcab57d45b3c35de47db749a06bb
> > > > > +e1eff08c7d0100d00bf6ea826f5dbef0d38b0dee618396f3f27bf69ddedb
> > > > > +b316558a4d462255fe132c4dbdde6e0a160700000000408f7c0027597569
> > > > > +00200000"""
> > > > >=20
> > > > >   # Expected response for "abootimg dtb_dump" command
> > > > >   dtb_dump_resp=3D"""## DTB area contents (concat format):
> > > > > @@ -179,6 +197,24 @@ def abootimgv4_disk_image_boot(ubman):
> > > > >           gtdi3 =3D AbootimgTestDiskImage(ubman, 'bootv4.img', bo=
ot_img_hex)
> > > > >       return gtdi3
> > > > >=20
> > > > > +gtdi4 =3D None
> > > > > +@pytest.fixture(scope=3D'function')
> > > > > +def abootimgv4_bootable_disk_image_boot(ubman):
> > > > > +    """pytest fixture to provide bootable boot image v4."""
> > > > > +    global gtdi4
> > > > > +    if not gtdi4:
> > > > > +        gtdi4 =3D AbootimgTestDiskImage(ubman, 'boot_bootable_v4=
=2Eimg', boot_bootable_img_hex)
> > > > > +    return gtdi4
> > > > > +
> > > > > +gtdi5 =3D None
> > > > > +@pytest.fixture(scope=3D'function')
> > > > > +def abootimgv4_bootable_disk_image_vboot(ubman):
> > > > > +    """pytest fixture to provide bootable vendor boot image v4."=
""
> > > > > +    global gtdi5
> > > > > +    if not gtdi5:
> > > > > +        gtdi5 =3D AbootimgTestDiskImage(ubman, 'vendor_boot_boot=
able_v4.img', vendor_boot_bootable_img_hex)
> > > > > +    return gtdi5
> > > > > +
> > > > >   @pytest.mark.boardspec('sandbox')
> > > > >   @pytest.mark.buildconfigspec('android_boot_image')
> > > > >   @pytest.mark.buildconfigspec('cmd_abootimg')
> > > > > @@ -266,3 +302,57 @@ def test_abootimgv4(abootimgv4_disk_image_vb=
oot, abootimgv4_disk_image_boot, ubm
> > > > >       ubman.run_command('fdt get value v / model')
> > > > >       response =3D ubman.run_command('env print v')
> > > > >       assert response =3D=3D 'v=3Dx2'
> > > > > +
> > > > > +@pytest.mark.boardspec('sandbox')
> > > > > +@pytest.mark.buildconfigspec('android_boot_image')
> > > > > +@pytest.mark.buildconfigspec('cmd_abootimg')
> > > > > +@pytest.mark.requiredtool('xxd')
> > > > > +@pytest.mark.requiredtool('gunzip')
> > > > > +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
> > > > > +                              abootimgv4_disk_image_boot,
> > > > > +                              ubman):
> > > > > +    """Test bootconfig handling with boot image v4.
> > > > > +
> > > > > +    Verifies that androidboot.* parameters from bootargs are app=
ended to the
> > > > > +    bootconfig section in vendor_boot image in memory, and that =
non-androidboot
> > > > > +    parameters remain in bootargs.
> > > > > +    """
> > > > > +
> > > > > +    # Setup addresses
> > > > > +    ram_base =3D utils.find_ram_base(ubman)
> > > > > +    ramdisk_addr_r =3D ram_base + 0x4000000
> > > > > +    ubman.run_command('setenv ramdisk_addr_r 0x%x' % ramdisk_add=
r_r)
> > > > > +    ubman.run_command('setenv loadaddr 0x%x' % loadaddr)
> > > > > +    ubman.run_command('setenv vloadaddr 0x%x' % vloadaddr)
> > > > > +
> > > > > +    # Set bootargs with androidboot.* parameters
> > > > > +    ubman.run_command('setenv bootargs "androidboot.serialno=3DA=
BC123 androidboot.mode=3Drecovery console=3DttyS0"')
> > > > > +
> > > > > +    # Load images
> > > > > +    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
> > > > > +        abootimgv4_disk_image_vboot.path))
> > > > > +    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
> > > > > +        abootimgv4_disk_image_boot.path))
> > > > > +    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vlo=
adaddr))
> > > > > +
> > > > > +    # Extract ramdisk (triggers bootconfig append)
> > > > > +    ubman.run_command('abootimg get ramdisk ramdisk_addr ramdisk=
_size')
> > > > > +
> > > > > +    # Get ramdisk address
> > > > > +    response =3D ubman.run_command('env print ramdisk_addr')
> > > > > +    ramdisk_start =3D int(response.split('=3D')[1], 16)
> > > > > +
> > > > > +    # Verify androidboot.* parameters were removed from bootargs
> > > > > +    response =3D ubman.run_command('env print bootargs')
> > > > > +    assert 'androidboot.' not in response
> > > > > +    assert 'console=3DttyS0' in response
> > > > > +
> > > > > +    # Get ramdisk size and verify BOOTCONFIG magic at the end
> > > > > +    response =3D ubman.run_command('env print ramdisk_size')
> > > > > +    ramdisk_size =3D int(response.split('=3D')[1], 16)
> > > > > +
> > > > > +    # Dump the end of the ramdisk where BOOTCONFIG trailer shoul=
d be
> > > > > +    response =3D ubman.run_command('md.b 0x%x 96' % (ramdisk_sta=
rt))
> > > > > +
> > > > > +    # Verify BOOTCONFIG magic is present
> > > > > +    assert 'BOOTCONFIG' in response or 'BOOTCON' in response
> > > > >=20
> > > > It looks like this test could be written in C?
> > > But this is just extending existing tests, and so this is fine. Looki=
ng
> > > at
> > > https://source.denx.de/u-boot/u-boot/-/pipelines/27943/test_report?jo=
b_name=3Dsandbox%20test.py%3A%20%5Bamd64%5D
> > > we can see these tests are currently under 400ms each, FYI.
> > Yes, OK. The python tests are ~100x slower though, so we really should
> > use C where possible. Part of this is being hidden by the overhead of
> > individually running the C tests from Python. I suppose we could
> > improve that by running the tests in batches, but I haven't looked at
> > it.
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Hi simon,
>=20
> I will plan to migrate all tests link to android in C after this series.

As we've been talking recently in other threads, running tests reliably
outside of the python framework itself is also difficult to have be
reliable. Please don't worry about converting these tests as a priority.
I pointed out the time they take currently as a reminder that even if
they're "100x slower" it's very much a micro-optimization.

--=20
Tom

--9BoPv0cYuGAo+dzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPuZRAAKCRAr4qD1Cr/k
CvVEAP9CYYst6l0J7NwlZ1kEYLbfMyFWXYGqCaRnFKhxkv8wZAEAqB2dL9F1SRv0
cqWKpI5OSlb3gQnmucHgsiHPRDmSfAM=
=0LNY
-----END PGP SIGNATURE-----

--9BoPv0cYuGAo+dzX--
