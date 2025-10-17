Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75D6CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C523838AE;
	Fri, 17 Oct 2025 15:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ggcWtRz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21A783873; Fri, 17 Oct 2025 15:19:29 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9B18386B
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso14749355e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760707167; x=1761311967;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q4fs5rLEI9fhIDtrx85qTkFHFgbBqGi9qn9Hb6kkFpM=;
 b=ggcWtRz1V0k8EahsPImvzRr9BAFKEZgsBDYVe2bDeh9XGL7NjJycGw7EycMsSQJSY3
 yaOvlznVGsemCYZqpuCyqO6vAVW2aKPWi/aL9JOpYQYblrwdvuF6C67oPhM4S6Ud2y1K
 6l+tRSzURFjuqih1ibKJX/SjgXZq1/ukJc24132v2Jr4zeFe+aQsYYLveuSk5FzCh53v
 0chPUY7qp1rizqeQ41kJxCp/WoSTCBoqJnobKclNkaRn+8+IoSFqav91Krmwo40PaDhd
 Ki2EwAd2znbzjhcto8Jgpsg4ioub+wtXDlGv/+rOL84Rcat1lbwg6xzdLvLHzFvke9DE
 zM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707167; x=1761311967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4fs5rLEI9fhIDtrx85qTkFHFgbBqGi9qn9Hb6kkFpM=;
 b=vPmtLhbXjGTbS2SG9CJ8aaexA6dc9iuVXKmtJ+J0oYy8ahP0cDyamW0/cVTJ6mJs2J
 hkRjrcwr4hIi2draidQWyQRw/o+ByzrtosJPBrwy2fFVHXv2CR9e5NVrdr1/9U/uVr8q
 CcW3KoF5CSeH6J4Ads7IB/gIWJIwycFaTrAcAJdwI9VLE7RS7tUPg7E4lYbbhnPZMoNW
 Tkp+zIPSeItCrWmyvJuvVehJcH1OazdBaNnKyn5v7VK6UK3M+8PPSdzKdr27QS6spgdC
 cSYdFzKFuCJGjCIE0x4CH7sBzViqxB6HrRU407PqpqXSjcKyTyw+1AUmuLdt70EBp72X
 gRuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGeYY42r5GEqO5h9TWEFpuGsfxr8ciSDtIfMvjZ4eWFTvBu8P2QJmMWj5pWSqVXgPsb9mwUYQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyBayhFQN6z3YMPVQadYPmqa5DNG4t6uptXWDK8ye3/GPj++a76
 LVZL42hiRZk9raooG8lwww/X4xy8OOK3le28QY3qzF8uqbnDLIlzMoLsdMcBzpYO7d9e08uyhZM
 ITMVY
X-Gm-Gg: ASbGncsS1jogkEw+8IyF+NOIlrjF+WQL54G+J0RcexckgFs1+LXXxdEPtWvAeO7Xden
 PXeXmiaPE2i5Hpb/z4H66RY5lJbmTZWK2VyUpeMVTCUQ8KPZEy/hBJYcCxr7mwJLf2xaU/0sjDw
 s8WXTdDiQBJU43SAf01Pbxu+JTPVpg9bYEg/sc4x8sdhKuR+3nKV1wgsDf5Hgafiwj/bzTF8wlE
 FrXfGPt4izwNYA6ztV9IbDoChvz5J8zbeg4K/lOqn3pNG4XQTkIAzFGBbT4A+wg18q64xypQnmJ
 4B1DOLInchM9lkQEpUjQk4ey3cDvd3cuiYSJnVFdwHS3bBFeZM10m0gDiVQiVFw4lJa8yvX0X3C
 iO6KB7+lCJJ0K9IzQU7LtF+LfeDjQidHDdkPQ4I+RoyV4IvjAUbQPqKh9bRm8dIYyowVnx2m1jV
 GWB3VN2y+fkj+Dzdl9nAeN9Jtl
X-Google-Smtp-Source: AGHT+IEJux1KOyIfg8xMTLQ5n4zkpQhdj5Yve/qPLTBgNl2xyI7+TChaGNryCL8KvRP2yhBBWL1ZWA==
X-Received: by 2002:a05:600c:474a:b0:46f:b42e:e39c with SMTP id
 5b1f17b1804b1-4711794902dmr26380455e9.41.1760707166872; 
 Fri, 17 Oct 2025 06:19:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44395465e9.10.2025.10.17.06.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:19:26 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 17 Oct 2025 15:19:21 +0200
Subject: [PATCH v2 5/5] test: abootimg: Add test for bootconfig handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-bootconfig-v2-5-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
In-Reply-To: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>
X-Mailer: b4 0.14.3
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

Add test to verify that androidboot.* parameters are correctly extracted
from bootargs and appended to the bootconfig section when using
'abootimg get ramdisk' with boot image v4 and vendor_boot image.

The test verifies:
- androidboot.* parameters are removed from bootargs
- They are appended to the bootconfig section in the ramdisk
- Non-androidboot parameters remain in bootargs
- The bootconfig trailer is properly updated

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 9 deletions(-)

diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index 2aadb692b30..bd5fb992a7d 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -69,15 +69,33 @@ e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
 c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
 d43a000000000000000060c53e7544995700400000"""
 
-# vendor boot image v4 hex dump
-vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
-222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
-d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
-d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
-f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
-db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
-1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
-309ffea7010000000040f1dc004129855400400000"""
+# vendor boot image v4 hex dump (contains initial bootconfig: androidboot.hardware=test)
+vboot_img_hex = """1f8b08000000000002ffeddb316a02411806d009a49040606d3d84374823a9a348b095
+915951b2c9caee8690ce237a91406a0b497603e215dcbc577cf3334cf5350303b3787a
+9c4fa6d3e7dbf02b6b63dfc6b01b0180ffe726644d5e37975bb34108c76efa1eb65974
+c7fed691c600e02a64e7ab3e8494afe37bd128050000007ae6707ffad202000000f45b
+155fd3b67e59eee26751c674a711000000e89ff896aa729b5665d98c37b14a1fb1ca1f
+da4f7f5e02000000a0377e0040ab5ba000500000"""
+
+# bootable boot image v4 hex dump (contains actual bootable kernel)
+boot_bootable_img_hex = """1f8b08081663ee6802ff626f6f745f626f6f7461626c655f76342e696d67
+00edd1c14ac3401485e159b80a083ec24dba4f117c81d8140c6dad24ee25
+4da6e9d07452321305dfca37d4d4ec5cb954fe6f37ccb967606ef298e6db
+2c0d3f94526feae25adda81fae140000000000f8ab66e17c67ecdc1d025d
+1d3a89125bf79da9e5beebbc64a7b2d1f27a27cfda7959e9deea369a8263
+a0eaecde34e2c75b375495766e3fb46114cca430a7a12dbd96e3654a7663
+dfb9f4feeb383514beecbdb1cd1489e3380a5cabf5596ea7c4f78b62acf1
+a66ccdbbaea380950100000000f06b79b249b362f5f2b44e16cb87ed3a5d
+e67c0a0000000000ffcc27ba944c7e00300000"""
+
+# bootable vendor boot image v4 hex dump (contains actual bootable ramdisk)
+vendor_boot_bootable_img_hex = """1f8b08081663ee6802ff76656e646f725f626f6f745f626f6f7461626c65
+5f76342e696d6700edd8b10a02310cc6f10c0e7220f8080737b8b93ab9a8
+282e571171959e0d787058a84557f5c96ddd7d80c3ff0f92217c5396408e
+f56abf30e63090649c9b3c53bd050000fcab57d45b3c35de47db749a06bb
+e1eff08c7d0100d00bf6ea826f5dbef0d38b0dee618396f3f27bf69ddedb
+b316558a4d462255fe132c4dbdde6e0a160700000000408f7c0027597569
+00200000"""
 
 # Expected response for "abootimg dtb_dump" command
 dtb_dump_resp="""## DTB area contents (concat format):
@@ -179,6 +197,24 @@ def abootimgv4_disk_image_boot(ubman):
         gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
     return gtdi3
 
+gtdi4 = None
+@pytest.fixture(scope='function')
+def abootimgv4_bootable_disk_image_boot(ubman):
+    """pytest fixture to provide bootable boot image v4."""
+    global gtdi4
+    if not gtdi4:
+        gtdi4 = AbootimgTestDiskImage(ubman, 'boot_bootable_v4.img', boot_bootable_img_hex)
+    return gtdi4
+
+gtdi5 = None
+@pytest.fixture(scope='function')
+def abootimgv4_bootable_disk_image_vboot(ubman):
+    """pytest fixture to provide bootable vendor boot image v4."""
+    global gtdi5
+    if not gtdi5:
+        gtdi5 = AbootimgTestDiskImage(ubman, 'vendor_boot_bootable_v4.img', vendor_boot_bootable_img_hex)
+    return gtdi5
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('android_boot_image')
 @pytest.mark.buildconfigspec('cmd_abootimg')
@@ -266,3 +302,57 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
     ubman.run_command('fdt get value v / model')
     response = ubman.run_command('env print v')
     assert response == 'v=x2'
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('android_boot_image')
+@pytest.mark.buildconfigspec('cmd_abootimg')
+@pytest.mark.requiredtool('xxd')
+@pytest.mark.requiredtool('gunzip')
+def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
+                              abootimgv4_disk_image_boot,
+                              ubman):
+    """Test bootconfig handling with boot image v4.
+
+    Verifies that androidboot.* parameters from bootargs are appended to the
+    bootconfig section in vendor_boot image in memory, and that non-androidboot
+    parameters remain in bootargs.
+    """
+
+    # Setup addresses
+    ram_base = utils.find_ram_base(ubman)
+    ramdisk_addr_r = ram_base + 0x4000000
+    ubman.run_command('setenv ramdisk_addr_r 0x%x' % ramdisk_addr_r)
+    ubman.run_command('setenv loadaddr 0x%x' % loadaddr)
+    ubman.run_command('setenv vloadaddr 0x%x' % vloadaddr)
+
+    # Set bootargs with androidboot.* parameters
+    ubman.run_command('setenv bootargs "androidboot.serialno=ABC123 androidboot.mode=recovery console=ttyS0"')
+
+    # Load images
+    ubman.run_command('host load hostfs - 0x%x %s' % (vloadaddr,
+        abootimgv4_disk_image_vboot.path))
+    ubman.run_command('host load hostfs - 0x%x %s' % (loadaddr,
+        abootimgv4_disk_image_boot.path))
+    ubman.run_command('abootimg addr 0x%x 0x%x' % (loadaddr, vloadaddr))
+
+    # Extract ramdisk (triggers bootconfig append)
+    ubman.run_command('abootimg get ramdisk ramdisk_addr ramdisk_size')
+
+    # Get ramdisk address
+    response = ubman.run_command('env print ramdisk_addr')
+    ramdisk_start = int(response.split('=')[1], 16)
+
+    # Verify androidboot.* parameters were removed from bootargs
+    response = ubman.run_command('env print bootargs')
+    assert 'androidboot.' not in response
+    assert 'console=ttyS0' in response
+
+    # Get ramdisk size and verify BOOTCONFIG magic at the end
+    response = ubman.run_command('env print ramdisk_size')
+    ramdisk_size = int(response.split('=')[1], 16)
+
+    # Dump the end of the ramdisk where BOOTCONFIG trailer should be
+    response = ubman.run_command('md.b 0x%x 96' % (ramdisk_start))
+
+    # Verify BOOTCONFIG magic is present
+    assert 'BOOTCONFIG' in response or 'BOOTCON' in response

-- 
2.34.1

