Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC09EE64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1486089775;
	Thu, 21 Nov 2024 23:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T2OCBYof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12F889768; Thu, 21 Nov 2024 23:32:36 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D998977F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6e5e5c43497so11649917b3.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228352; x=1732833152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfWNW8vxsgi9PD9b4E615ip/pePYQBm1IVPLUvGLFRA=;
 b=T2OCBYofGZKG7DfS5OLZEilNvPrWWB59O1O9cgp8DZFgVGZ03TJac30TPR3d/4V41+
 hmCoNiUTV/EUTNc+MCMQP4hUXSYVcMCaXHe1uayBVdqO79w4oTtjN9WldYt9Eco1hhvt
 5JeCmsOx1e8Q8GuMwG1/yVc415aJbsIWVNKZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228352; x=1732833152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfWNW8vxsgi9PD9b4E615ip/pePYQBm1IVPLUvGLFRA=;
 b=SFsHMM9kzjg31sjdGcXVua5bHyljgJsz4UXvuZn7FCouWTJjGniAsLatghapk28ATg
 qCBL4YXj1o9dhgju4EuauYn/zM59PUlBlcWJp8XVw1MpWRmPk13SfafEbdLxp9G8HHpC
 hP3AvNdb6sIG46N6pMeq8F3ZEyeDg21m0naUAlz1V7oGMh5Ibpl1FCLHuhuZR76OTk8h
 Hb//iifgNpcXf4k9FqsXVhD769oX1oZEeTviyRXhVeHehxHv58lyv2hcpqzj2jqp44yx
 dFJYzMH1f0ogbXUlHvjv6y4LokhK9VXD6i+YbCvY5D0R36mvHb3iSIkpPTwQioLURJBX
 ji/A==
X-Gm-Message-State: AOJu0YwkimHVGUv7uAnkVaNs3H0L3tyazenzwjmDhcgYcKaWDNCvmaVc
 zOM60lOUeO/kC2NcpmSjmCkql44oI1HJRLDGANe22xRKa06qq+J/SQ5q3LsypW6tJ5CYOwTAvr8
 =
X-Gm-Gg: ASbGncvj1OzQkswgSpBbjzm2gsTGMP5jY3r5CyftPuTaJz8TwFTJLfa3PRk/BigvNTp
 B/P2TzdtGipdxZmYvPrER2h34QdJ+PsSvHV/byadOUOWla4AodRo3IEQvlU5yL3wrXLOt18aVDX
 UhXLWzRVwndG9Aq/TBsmO1ow3QaBpwOWUzKNu5DtDi8ImvQMAqf0DfbXZMCQac6+AChoyE39Exz
 dmKDFtnxgqw0ayWO7prByLdMUFpxO6g/v03BYUdGH9iEfI=
X-Google-Smtp-Source: AGHT+IGW1czUz4pWt3r7RkvwH081Ax6YjddZjsV0DlJb2U1h8Ziy5rlYHFJcPSW7bes7CdPfdB/wHA==
X-Received: by 2002:a05:690c:350a:b0:6ee:b03c:8f7c with SMTP id
 00721157ae682-6eee089cd8cmr11440667b3.10.1732228352517; 
 Thu, 21 Nov 2024 14:32:32 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 5/8] test_ut: Drop exeception handling
Date: Thu, 21 Nov 2024 15:32:11 -0700
Message-ID: <20241121223217.330117-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
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

We don't need the fallback anymore. As a first step to removing it,
drop the try...except clauses and unindent the code.

This produces a large diff but there are no other code changes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to drop exception handling

 test/py/tests/test_ut.py | 175 ++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 94 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index d449d0baf5e..82cedbef039 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -79,8 +79,7 @@ def setup_bootmenu_image(cons):
     fname, mnt = setup_image(cons, mmc_dev, 0x83)
 
     complete = False
-    try:
-        script = '''# DO NOT EDIT THIS FILE
+    script = '''# DO NOT EDIT THIS FILE
 #
 # Please edit /boot/armbianEnv.txt to set supported parameters
 #
@@ -154,45 +153,42 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
 # Recompile with:
 # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
 '''
-        bootdir = os.path.join(mnt, 'boot')
-        mkdir_cond(bootdir)
-        cmd_fname = os.path.join(bootdir, 'boot.cmd')
-        scr_fname = os.path.join(bootdir, 'boot.scr')
-        with open(cmd_fname, 'w', encoding='ascii') as outf:
-            print(script, file=outf)
-
-        infname = os.path.join(cons.config.source_dir,
-                               'test/py/tests/bootstd/armbian.bmp.xz')
-        bmp_file = os.path.join(bootdir, 'boot.bmp')
-        u_boot_utils.run_and_log(
-            cons,
-            ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
+    bootdir = os.path.join(mnt, 'boot')
+    mkdir_cond(bootdir)
+    cmd_fname = os.path.join(bootdir, 'boot.cmd')
+    scr_fname = os.path.join(bootdir, 'boot.scr')
+    with open(cmd_fname, 'w', encoding='ascii') as outf:
+        print(script, file=outf)
 
-        u_boot_utils.run_and_log(
-            cons, f'mkimage -C none -A arm -T script -d {cmd_fname} {scr_fname}')
+    infname = os.path.join(cons.config.source_dir,
+                            'test/py/tests/bootstd/armbian.bmp.xz')
+    bmp_file = os.path.join(bootdir, 'boot.bmp')
+    u_boot_utils.run_and_log(
+        cons,
+        ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
 
-        kernel = 'vmlinuz-5.15.63-rockchip64'
-        target = os.path.join(bootdir, kernel)
-        with open(target, 'wb') as outf:
-            print('kernel', outf)
+    u_boot_utils.run_and_log(
+        cons, f'mkimage -C none -A arm -T script -d {cmd_fname} {scr_fname}')
 
-        symlink = os.path.join(bootdir, 'Image')
-        if os.path.exists(symlink):
-            os.remove(symlink)
-        u_boot_utils.run_and_log(
-            cons, f'echo here {kernel} {symlink}')
-        os.symlink(kernel, symlink)
-
-        fsfile = 'ext18M.img'
-        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-        u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
-        u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-        complete = True
-    except ValueError as exc:
-        print(f'Falled to create image, failing back to prepared copy: {exc}')
-    finally:
-        u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-        u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    kernel = 'vmlinuz-5.15.63-rockchip64'
+    target = os.path.join(bootdir, kernel)
+    with open(target, 'wb') as outf:
+        print('kernel', outf)
+
+    symlink = os.path.join(bootdir, 'Image')
+    if os.path.exists(symlink):
+        os.remove(symlink)
+    u_boot_utils.run_and_log(
+        cons, f'echo here {kernel} {symlink}')
+    os.symlink(kernel, symlink)
+
+    fsfile = 'ext18M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
+    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    complete = True
+    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
@@ -203,11 +199,10 @@ def setup_bootflow_image(cons):
     fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
 
     complete = False
-    try:
-        vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
-        initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
-        dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
-        script = '''# extlinux.conf generated by appliance-creator
+    vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
+    initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
+    dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
+    script = '''# extlinux.conf generated by appliance-creator
 ui menu.c32
 menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
 menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
@@ -220,39 +215,36 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
         fdtdir /%s/
         initrd /%s''' % (vmlinux, dtbdir, initrd)
-        ext = os.path.join(mnt, 'extlinux')
-        mkdir_cond(ext)
+    ext = os.path.join(mnt, 'extlinux')
+    mkdir_cond(ext)
 
-        conf = os.path.join(ext, 'extlinux.conf')
-        with open(conf, 'w', encoding='ascii') as fd:
-            print(script, file=fd)
+    conf = os.path.join(ext, 'extlinux.conf')
+    with open(conf, 'w', encoding='ascii') as fd:
+        print(script, file=fd)
 
-        inf = os.path.join(cons.config.persistent_data_dir, 'inf')
-        with open(inf, 'wb') as fd:
-            fd.write(gzip.compress(b'vmlinux'))
-        u_boot_utils.run_and_log(
-            cons, f'mkimage -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
+    inf = os.path.join(cons.config.persistent_data_dir, 'inf')
+    with open(inf, 'wb') as fd:
+        fd.write(gzip.compress(b'vmlinux'))
+    u_boot_utils.run_and_log(
+        cons, f'mkimage -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
 
-        with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
-            print('initrd', file=fd)
+    with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
+        print('initrd', file=fd)
 
-        mkdir_cond(os.path.join(mnt, dtbdir))
+    mkdir_cond(os.path.join(mnt, dtbdir))
 
-        dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
-        u_boot_utils.run_and_log(
-            cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
-
-        fsfile = 'vfat18M.img'
-        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-        u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-        u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
-        u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-        complete = True
-    except ValueError as exc:
-        print(f'Falled to create image, failing back to prepared copy: {exc}')
-    finally:
-        u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-        u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
+    u_boot_utils.run_and_log(
+        cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+
+    fsfile = 'vfat18M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+    u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    complete = True
+    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
 
@@ -527,29 +519,24 @@ def setup_efi_image(cons):
                              basename=basename)
 
     complete = False
-    try:
-        efi_dir = os.path.join(mnt, 'EFI')
-        mkdir_cond(efi_dir)
-        bootdir = os.path.join(efi_dir, 'BOOT')
-        mkdir_cond(bootdir)
-        efi_src = os.path.join(cons.config.build_dir,
-                            'lib/efi_loader/testapp.efi')
-        efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
-        with open(efi_src, 'rb') as inf:
-            with open(efi_dst, 'wb') as outf:
-                outf.write(inf.read())
-        fsfile = 'vfat18M.img'
-        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-        u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-        u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
-        u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-        complete = True
-    except ValueError as exc:
-        print(f'Falled to create image, failing back to prepared copy: {exc}')
-
-    finally:
-        u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-        u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    efi_dir = os.path.join(mnt, 'EFI')
+    mkdir_cond(efi_dir)
+    bootdir = os.path.join(efi_dir, 'BOOT')
+    mkdir_cond(bootdir)
+    efi_src = os.path.join(cons.config.build_dir,
+                        'lib/efi_loader/testapp.efi')
+    efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
+    with open(efi_src, 'rb') as inf:
+        with open(efi_dst, 'wb') as outf:
+            outf.write(inf.read())
+    fsfile = 'vfat18M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+    u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
+    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    complete = True
+    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
     if not complete:
         copy_prepared_image(cons, devnum, fname, basename)
-- 
2.43.0

