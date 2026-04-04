Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ECBD7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1B284148;
	Sat,  4 Apr 2026 16:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IqhRo3YA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE9480325; Sat,  4 Apr 2026 16:04:12 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923C38416F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40427db1300so2043755fac.0
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311448; x=1775916248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqwz1cwEmGOV/l/Yqgr12oKJNpxiUUnhBJ2Dz2GVEtM=;
 b=IqhRo3YAbH/Lp/OVjo5dDUViubJZwqpUouzc6BVcdX+VJsUPpH3oj3YqXiLONnE1l6
 sdqM7D9kSDUd5SW80ZLqk7cTw9aTRY3xcuy7l7MchuD3FJjFnwRBq0wH4/gGyHjplFJv
 iOy8o0yh0vJa+1ghttl0GSAvxm8FTYFNMGAeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311448; x=1775916248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dqwz1cwEmGOV/l/Yqgr12oKJNpxiUUnhBJ2Dz2GVEtM=;
 b=ZZ72x84wQpUNHr7jmQfRrlvdaq8LgB/eb+V/MDwOwARU2s/+UAQ8WP/h89B4ByMZ1F
 ruFYomMZ4FFaAEzL/pViiEi4dbF3BueNQwdu79Tqy1NIFogIQI0+F+tlxZC/URMrSXDB
 1lKgS0/pAsUkeJ2xPD10U/swbEea20GrpZ2iaMjKH7TbSzsDbO1AS+beIuDf6VqZaCip
 FdBqlFjleNZbJlzZop7j/Dn6x1may7H367s1h1+9TpD+DWqkRRYrKL1uJgKSIKenCHWh
 ZVrcovex1bvQHii/mvkljuCSLve6VcvMqe2trp7pprPav0ZLZuyhkPhpjPxMO0LNZTzl
 D54w==
X-Gm-Message-State: AOJu0YwOhgBArJAmYwTAkzRyXnl/d6NPigcNQijgfdxV6j5xujL0pVO9
 PIzyxNU2exK02L1LGfc0W8dmtdayPZY4JXxqDN/cvYVp7vwadVvqGbbEJ0xYjIdKaijvhjc3XY8
 thtg=
X-Gm-Gg: AeBDievatO3MP3jaGKg7wxCgmauSZKNeXw13LploIFkf0AFLyHygxVqKRFVcYgsbYZs
 7lYxBM9kNvk7oSOei0IHlQsMcOIExdFh47FQS7O1FrpK72B/qR+8ksHvRGUX6s6w2NRXoWD2y7o
 QpCWpPPp5NwTC6oq7tahjft0mBcgRHd8ViXGZbpnpjBmEJhXAK/yoPAddsSjVw6otoay7RCEFmv
 drHESEugfa4yeosUDFlhpfSf3yUJqDFfiuLisSZYV0p8XvhH64SLH2XL9opogRgh2JssFkz4dDr
 H3lJ+JvLdZ9boZ8nDvYE1bc81juBiKfwv6XqmZMHE0sEEfudkokPMGxMSEVPsajkn0O+b+te1nj
 ypMUA71ASyse6GxFsTYw8QefKRgeL0lrFXZrZt+pd6UZKRTZDfkjgT8mP90GZoJJqdc1JBTVnyY
 gbPSNUzpOLqk49JkCuZA==
X-Received: by 2002:a05:6870:fb88:b0:422:fb29:8248 with SMTP id
 586e51a60fabf-4231022965cmr3420668fac.43.1775311448477; 
 Sat, 04 Apr 2026 07:04:08 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/14] test: Split out core of Fedora image into a new function
Date: Sat,  4 Apr 2026 08:03:12 -0600
Message-ID: <20260404140328.3724864-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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
index a1c4af1b096..758f99cbfce 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -159,27 +159,22 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     fsh.cleanup()
 
 
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
 
@@ -197,11 +192,12 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
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
@@ -211,6 +207,33 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
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
@@ -606,7 +629,7 @@ def setup_rauc_image(ubman):
 def test_ut_dm_init_bootstd(ubman):
     """Initialise data for bootflow tests"""
 
-    setup_bootflow_image(ubman)
+    setup_fedora_image(ubman, 1, 'mmc')
     setup_bootmenu_image(ubman)
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
-- 
2.43.0

