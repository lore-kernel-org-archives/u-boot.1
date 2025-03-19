Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B83EC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF3481E92;
	Wed, 19 Mar 2025 15:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S0sVrr5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8252381E60; Wed, 19 Mar 2025 15:39:00 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6606E81E67
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso34566495e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395137; x=1742999937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhjFYf/Q2XS3ceRVQnr7TwHDyPPHBZSqzW70A9Omzww=;
 b=S0sVrr5x+vnnSL4h+OXRga1e0g4Y9uvdz3C1+Xq+RLSYUfRHoF1NS2QZIIWa+JJ1PZ
 3ZqNayMQdXXBGPWk9lOSD91kuwAEUEXWG3ORD+5YMUoce9oGHcnrTX1YXBwt6hvJ3x1r
 S8i+chUs5CFmjSeBkHGPrHmbEukhVDu5ksNK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395137; x=1742999937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhjFYf/Q2XS3ceRVQnr7TwHDyPPHBZSqzW70A9Omzww=;
 b=gjJ7CCIwa9Xzn3WZFTNWKVyBAf3kZOJ4dstYtHfFHNxYSjzMjI2FpF/AMmZV1D0ovr
 kTJmbRbH//MtOGF3vaeeTSjiUjnt1gICAAMRO3WBVI0ElWpUoytpXDmBQpTHTTUB/uVq
 F6X1eOrr3V5+KRft9UZ5kCcG9AwRxYiEvCarloQILe6fUkFvvEULDNg7vNuSIk6k7zYO
 AHTgTWU762aWlKE2B98X+5yPxGMREkByt6huw8v+//1hEhbpwSPbsKP15b3fiKawkoHU
 5chiWYiG6DUhhaeOnDgkovHVTZcbgrqvD3gPwXA83mGB0IiKsSl9ihU9BV/FUtSkJcBk
 Ottg==
X-Gm-Message-State: AOJu0YwDx77vSZCBSQlgJghUo0v2/N+/QHbtAu+m/q90dHgNVCSAlf6/
 E3/y6Dj7L97OOxzR1RXCV56bY1h+gAinf200l8CEdkgpNfC5BdlsWQJW5t+/EmuscNanF8TmF5I
 =
X-Gm-Gg: ASbGncsS5LSBYd3Kh6nK+G66y6X5uDj2sy/49qR0wsIh/AtkEZTAx5wQN+Zg+6u6EVa
 wAmxn9HV5EEKOPUFZsAARUtwmtPFbQxkLcomz+B5ITp61swMojSh5vq9B6nVGIdc5lZRazZhucF
 saYUq916DcwFMpMo/PffFgQ2sKWN/Xy4JZmZwTAEgcHT7kXFsoJr7+bBPihWt+KoiK/wtunwWYX
 /sBSkflygWQux+V+lyUeFruP+FOjUsHN8f4j33CUFgtjy3GYGK9rgDRS3D3e+6lBiVJ8s7EG/Ma
 FPY9/LEOvFRC2Y/skmT8IRi4FmbxtuzHLJxRU4JCog==
X-Google-Smtp-Source: AGHT+IGV7T5hs9vC8v28Xw1r29A1faTwvya3LGEPzTH2NxoW4fDF6MBKzxUJ3Lu8dApGysujg3ng7g==
X-Received: by 2002:a05:600c:4ec6:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-43d4382fe6fmr22857885e9.26.1742395136986; 
 Wed, 19 Mar 2025 07:38:56 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/17] test/py: Split out core of Fedora image into a new
 function
Date: Wed, 19 Mar 2025 15:38:02 +0100
Message-ID: <20250319143820.2385092-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

 test/py/tests/test_ut.py | 71 ++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index b8adb597e11..aad5f36dcb5 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -187,27 +187,22 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     utils.run_and_log(ubman, f'rm -rf {mnt}')
     utils.run_and_log(ubman, f'rm -f {fsfile}')
 
-def setup_bootflow_image(ubman):
-    """Create a 20MB disk image with a single FAT partition"""
-    mmc_dev = 1
-    fname, mnt = setup_image(ubman, mmc_dev, 0xc, second_part=True)
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
+    fname, mnt = setup_image(ubman, devnum, 0xc, second_part=True,
+                             basename=basename)
 
-label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
-        kernel /%s
-        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
-        fdtdir /%s/
-        initrd /%s''' % (vmlinux, dtbdir, initrd)
     ext = os.path.join(mnt, 'extlinux')
     mkdir_cond(ext)
 
@@ -225,11 +220,12 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
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
@@ -239,6 +235,33 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
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
@@ -582,7 +605,7 @@ def setup_efi_image(ubman):
 def test_ut_dm_init_bootstd(ubman):
     """Initialise data for bootflow tests"""
 
-    setup_bootflow_image(ubman)
+    setup_fedora_image(ubman, 1, 'mmc')
     setup_bootmenu_image(ubman)
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
-- 
2.43.0

