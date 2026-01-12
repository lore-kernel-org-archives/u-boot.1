Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02A8C9EC6D
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A1383D9F;
	Mon, 12 Jan 2026 11:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sSjzcPTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C0583DEB; Mon, 12 Jan 2026 11:55:48 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF49183D8B
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so45480145e9.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768215346; x=1768820146;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HSZpZmFFugb+IG9W+6hFwNON2Np2YwWlP0C3UaENoa0=;
 b=sSjzcPTuln6kcgak+FRH4rnclriEy3nuWkzxSzN24E5R81k4ruyuHyOgo3/65M7Q2v
 7uzrf0o6yD1fuOkVKIL0oesqbwSuAqkw9Mj16EKayyAOJFJbekHl3yMwAC5+fV9LtoJ6
 PzjtbynQpUoyIFIkXo2xl17NJyZwc9SZCBZEAZCjYHyYnpoVi2NmgzACNJUc1UP/Tn+3
 ZPiiWDK3K2WLizNuu3S/qI56tQVT+LmCHXvLZnNvIjQzMrPeeXRHvd+9L8bmWaM3QKTC
 QP5lBFoD/LT0om+bhBj+4JYbPIkqPiQ5bmHbsMicqqGLQpTvgdkISOtdJnq5l0m4j4zz
 fqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215346; x=1768820146;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HSZpZmFFugb+IG9W+6hFwNON2Np2YwWlP0C3UaENoa0=;
 b=F7T6aoBGtCi8DzVpdS6SKsbAtN9MJTm4Dvnnxi8M/rt4YsUQMa1pGAiYaJrHZhsOju
 JyMe2EpnrGTsAcbl8XY3yu20B/6t85SBcxPbvraDyrMn6dkJE7yd9PAOXz1vwFRmKWGi
 GA7LJdAhEj2ZHCss5ez2jC6bwqAPU8EVDJLbT0Fx4lw1/dGcEm7NeXQVRPZW5NYPk6WT
 mzpWOJSZ5OHcsMMeKbfS3GeifzMR73D31KYNMUaXx/T9OFtCpMs9GXIR635EHqTE1uZW
 nYR3aIMZYWS/fdV+h7frZBql8fIoiRhbI8Fo+47m5AZmjp+etf7c9lxt0evK8W/wfdbE
 kCtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVds8+FRf3L6Ty/0a/7QcUpOsG3hxnifcI5o/fhtQD4ClbF28HVxBhzFba5C78ecB3bZYI28mw=@lists.denx.de
X-Gm-Message-State: AOJu0YztFTGoQHL/N4VYXew9+B/Ur3uy53nUyrMTYNt8jJ+0YSZeeSSe
 9+WQ8scgAPs2E9n06m/aIpEjb6kzFL+GmHcrAYUD2hCgrFsjsetkS4wa0r+auRIypwM=
X-Gm-Gg: AY/fxX4j/4GM0yM1S3WrQ6RlAZMrWsxOWxKUyOGI8mCFNN3uq3+M38ps3B100I7h8NY
 OcbC5GvAJjekJ9FcffdLD9mj0s48zYMeSdUZe/0NIHSB5EGdvxgmGWyPOd936EZ1yEpEV7fSrCZ
 UqJw1FmxikJuY4nUm9K2LUSJKmjvTcxnRdAa9vJijfJrcnj7E8kBVS56Ii5ETbajapAWeVQM98M
 86Fz69Wcpv+WpSPws9GvcTztfBPiKUFXhIgzgGRAv+qUcAn92kA1wuOldyfCzkxwWYqKlVQDAA4
 sSy1xpzjdixY0E48GEHmLc8kunu3Fy4mLulSPfsXS4mAKDAloAIn6FAgYJ0J8ovIKkhDKjuzKpY
 BnSMEdP0bg4mWMVallbXXiDPWLezejDOkasKX4A/8ZuMIjNJ4Su9FXlkew1GoTFU1jB1jRneNxC
 ioLPmlqdoH/9mBaqbH7rX8sjc+
X-Google-Smtp-Source: AGHT+IEQMWYv0DvrHrYy11a1Y59+Go7USFvXe3o49HSGNF9mRuQzW3us4yxoCG9lmWGtLsYfyXEAjg==
X-Received: by 2002:a05:600c:8b58:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-47d84b369a2mr170377265e9.22.1768215346202; 
 Mon, 12 Jan 2026 02:55:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:ad8e:46f0:bbfb:2e18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36145393f8f.26.2026.01.12.02.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:55:45 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 12 Jan 2026 11:55:41 +0100
Subject: [PATCH v5 5/5] test: abootimg: Add test for bootconfig handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-bootconfig-v5-5-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
In-Reply-To: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 test/py/tests/test_android/test_abootimg.py | 91 +++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 18 deletions(-)

diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index daa87643e93..760f8e385ba 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -62,22 +62,24 @@ b7762ffff07d345446c1281805e8a0868d81e117a45e111c0d8dc101b253
 d4a9820881a70f3873f35352731892f3730b124b32937252a96bb9119ae5
 463a5546f82c1f05a360148c8251300a462e000085bf67f200200000"""
 
-# boot img v4 hex dump
-boot_img_hex = """1f8b080827b0cd630203626f6f742e696d6700edd8bd0d82601885d1d7c4
-58d8c808b88195bd098d8d246e40e42b083f1aa0717be99d003d277916b8
-e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
-c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
-d43a000000000000000060c53e7544995700400000"""
-
-# vendor boot image v4 hex dump
-vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
-222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
-d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
-d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
-f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
-db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
-1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
-309ffea7010000000040f1dc004129855400400000"""
+# bootable boot image v4 hex dump (with DTBs)
+boot_img_hex = """1f8b0808e2dd60690203626f6f745f6e65772e696d6700edd8ab0d836018
+40d14f900a0c8c5036e80a24180c24dde04f4034d04740b13d02d90920e7
+8c70e5adbbe6d9b74d5544441987c72dfe64010000009cd5342e9f71beff
+d2367fd3900b0200000017b4a4f7f05a2703000000002e6c0765d9bd6000
+300000"""
+
+# bootable vendor boot image v4 hex dump (with DTBs + bootconfig)
+vboot_img_hex = """1f8b0808e2dd6069020376656e646f725f626f6f745f6e65772e696d6700
+eddb316bc24014c0f14b2dd20a425c3b393a48c1d0c1a54be9aca588fbc5
+0b3434e9c979d04628f811fd22426787d2bbc43a68e9d4a5f1ff83f7de25
+5c787053f220d3d1fde3dd783c39174ee86255e68e4f0000e00405e2e835
+e0e142886db9fae8f89c95dbaa7ac5890100f02f1899ab74f1dc9dcb22d3
+52b538110000000000ea67ddfedcb8f2ee6228aa317ecf859fed7fcffefd
+fae68747835d6dec42bc0df6d74d1fc5a0bfac6e89331797b9564926663a
+9f4b9bc659f2b7cda383e6517f19fdd61c0000000080d3111e7c4f030000
+000080fa912fcae854c55adbeb2769d4ab34c9ad4d16963f010000000000
+a88d2fb468951800500000"""
 
 # Expected response for "abootimg dtb_dump" command
 dtb_dump_resp="""## DTB area contents (concat format):
@@ -166,7 +168,6 @@ def abootimgv4_disk_image_vboot(ubman):
     This is function-scoped because it uses ubman, which is also
     function-scoped. However, we don't need to actually do any function-scope
     work, so this simply returns the same object over and over each time."""
-
     global gtdi2
     if not gtdi2:
         gtdi2 = AbootimgTestDiskImage(ubman, 'vendor_boot.img', vboot_img_hex)
@@ -179,7 +180,6 @@ def abootimgv4_disk_image_boot(ubman):
     This is function-scoped because it uses ubman, which is also
     function-scoped. However, we don't need to actually do any function-scope
     work, so this simply returns the same object over and over each time."""
-
     global gtdi3
     if not gtdi3:
         gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
@@ -282,3 +282,58 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
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
+    # The trailer is at the end, so dump the last 48 bytes
+    response = ubman.run_command('md.b 0x%x 48' % (ramdisk_start + ramdisk_size - 48))
+
+    # Verify BOOTCONFIG magic is present
+    assert 'BOOTCONFIG' in response

-- 
2.34.1

