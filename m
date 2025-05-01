Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7637BC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8490281F7E;
	Thu,  1 May 2025 15:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iDzPnvhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCB182153; Thu,  1 May 2025 15:37:50 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 324098219D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8616b7ad03bso18886739f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106666; x=1746711466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79OO0wG127KR0IJRZbVb+33QFbI/WNfv0T+VPOvianc=;
 b=iDzPnvhDJ8Sh1YumY+WdK3RSW0fAuw/64pp5sof9TuUm6kbHPutFJulbGTilOg4Z25
 u1gKEvfX0foDlaXIB1qU7cDIC+FcghENV7uprWKq9qoYqRVu0iyPePk0nTeJy41HtSAR
 vXZ6cyQ04emMHwB8gAiKdcyCFXJOxqSg3Zn0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106666; x=1746711466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79OO0wG127KR0IJRZbVb+33QFbI/WNfv0T+VPOvianc=;
 b=l5fLeATRJnP/rtlC0BlsGCEU3zksr9CM9ztcHg2zb0LgSco6ZPTXFPgOPbe/DS0qv6
 bcsAQdw+zYw1FR7N8ROqz0EYOQpYsIbWJc6mq+5RltniI3wuGgFaR8jVzdYehFQhafF0
 gn09yo51pyagY3nc4B43yBzM63H4ekHiDPei6HDcJQD2EJiZi8JZA68E034t99MDWh0I
 nU2mFbkSIDcFR8Ahc0IkEJ9pjkehvtRKkgYIEdw7QkHDWnDmUM0hKo7gZbTSSYKZW9Bn
 hGLNilgBONKc4GLtimkYFo/h8VVMeAvND+Mc862LV2W+7wOVnzv9GEtWP/FZsaLeOhTa
 AVXw==
X-Gm-Message-State: AOJu0YwO2lDJpmEws9ui4piEoPC+pCuYiiD9uTs6M7M6KwRCDDSNpMTT
 rYspl4ktAoPG+jAUhxir7W9WTS+vpE0ryCQw0Ql8G4S44OFbN2cxd8RnidJ3tVPY8sBvabQPwRQ
 =
X-Gm-Gg: ASbGnctYSi8rr05oIGfEFBTAnlnGrb6pnFcjPo26yf0xkHwR39MwLnEHh02PdHR5k8k
 /qbBtjVPDpAuR5AAhvFoFJQ0NydEx+re2jHYD9gkWm9bKOuVTVEqljgU4UCWyl/FrpFQkjZAWDj
 5qa+qOqc8WQS/1EtL2JFYORwQuArgC/CUFd+fTbS58QUCIPySggTQ7bTZS7bTxHSSJNRHEKCZOU
 r37n5aiCh4eEx5/Qpmt+lVRgvKDmxgmwBuForehvb5Ndq2Y7/5oQYrJCe/JokoCRDnWd2IgoFKB
 StdFCO7FSOl5TGqlO5y3zZIP9cxxzQVPOCgsHSs6l8WB7+whqi9onTg98HqsGoctX9oaEBaFore
 tzA==
X-Google-Smtp-Source: AGHT+IGKj8QYlFiO7R7MsA5CUbknbJY7/v4tXUdq8J/3plZZLcmJVUoefzWomEmV+tcxdIX1aZd/AA==
X-Received: by 2002:a05:6602:4749:b0:85e:2e8b:602 with SMTP id
 ca18e2360f4ac-86497f41679mr816147239f.2.1746106666354; 
 Thu, 01 May 2025 06:37:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/18] test/py: Split out core of Fedora image into a new
 function
Date: Thu,  1 May 2025 07:37:09 -0600
Message-ID: <20250501133726.2627373-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
MIME-Version: 1.0
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

To permit easier adding of other images, move the Fedora-specific
portions of setup_bootflow_image() into a separate function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_ut.py | 71 ++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cdf54adc600..fc72496ba46 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -157,27 +157,22 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
-def setup_bootflow_image(ubman):
-    """Create a 20MB disk image with a single FAT partition"""
-    mmc_dev = 1
-    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0xc, second_part=True)
+def setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                         script):
+    """Create a 20MB disk image with a single FAT partition
 
-    vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
-    initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
-    dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
-    script = '''# extlinux.conf generated by appliance-creator
-ui menu.c32
-menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
-menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
-menu hidden
-timeout 20
-totaltimeout 600
+    Args:
+        ubman (ConsoleBase): Console to use
+        devnum (int): Device number to use, e.g. 1
+        basename (str): Base name to use in the filename, e.g. 'mmc'
+        vmlinux (str): Kernel filename
+        initrd (str): Ramdisk filename
+        dtbdir (str or None): Devicetree filename
+        script (str): Script to place in the extlinux.conf file
+    """
+    fname, mnt = fs_helper.setup_image(ubman, devnum, 0xc, second_part=True,
+                                       basename=basename)
 
-label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
-        kernel /%s
-        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
-        fdtdir /%s/
-        initrd /%s''' % (vmlinux, dtbdir, initrd)
     ext = os.path.join(mnt, 'extlinux')
     mkdir_cond(ext)
 
@@ -195,11 +190,12 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
         print('initrd', file=fd)
 
-    mkdir_cond(os.path.join(mnt, dtbdir))
+    if dtbdir:
+        mkdir_cond(os.path.join(mnt, dtbdir))
 
-    dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
-    utils.run_and_log(
-        ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+        dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
+        utils.run_and_log(
+            ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
 
     fsfile = 'vfat18M.img'
     utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
@@ -209,6 +205,33 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
+def setup_fedora_image(ubman, devnum, basename):
+    """Create a 20MB Fedora disk image with a single FAT partition
+
+    Args:
+        ubman (ConsoleBase): Console to use
+        devnum (int): Device number to use, e.g. 1
+        basename (str): Base name to use in the filename, e.g. 'mmc'
+    """
+    vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
+    initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
+    dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
+    script = '''# extlinux.conf generated by appliance-creator
+ui menu.c32
+menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
+menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
+menu hidden
+timeout 20
+totaltimeout 600
+
+label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+        kernel /%s
+        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
+        fdtdir /%s/
+        initrd /%s''' % (vmlinux, dtbdir, initrd)
+    setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                         script)
+
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
@@ -552,7 +575,7 @@ def setup_efi_image(ubman):
 def test_ut_dm_init_bootstd(ubman):
     """Initialise data for bootflow tests"""
 
-    setup_bootflow_image(ubman)
+    setup_fedora_image(ubman, 1, 'mmc')
     setup_bootmenu_image(ubman)
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
-- 
2.43.0

