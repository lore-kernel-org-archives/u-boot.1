Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862B6E64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DCC89776;
	Thu, 21 Nov 2024 23:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZUKeY1YS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B468977B; Thu, 21 Nov 2024 23:32:44 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0A7896C2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6eed41d2b12so9789337b3.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228356; x=1732833156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8s/hhlll7S/84z9emFxzlzVay4SAegCsD0VigegC2Rc=;
 b=ZUKeY1YS4UQlfL8L00YHka41YSLMdX1vDPHjBgZFOOxL522n+gc4/4vycPwc5bNQYc
 RL57MqiI2v0EerC3LfYCvOyy079O5lnmo7J4UqzhFk5uSPeqxOhDXo5entGKvfzhP8UQ
 0OgfM3T08Bnm1ZYOzxI95FZfI+5effHiF/WLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228356; x=1732833156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8s/hhlll7S/84z9emFxzlzVay4SAegCsD0VigegC2Rc=;
 b=TLt8fN2IfMce2mgv1Wgo/Oxep3G1Dooj2i6ZMamqbhdaavUV7Tv/H4iZNtEokecU41
 5B72twxVMNMXwbo9Js4aWUiVppvsJ3HCu1xsxSTJLr6Ue6Oj5bvF1ORv3Szqpoxk1AMY
 FyHJUibYIjl+kBS3CK55DLdh+s5K/t/sa5ybjj89CskZoi3B0A0Zb1KYGfqsGPjqYMQ7
 Yzq9+QKSg77LcjpTA2UPa9Y/pRhyusY5GU/Twnq4t9/LHmnWWrVaxIFABSdvdawJ8S1m
 oaKZd7s13HY3QNi/o5I9qyOVfFMG2ApP3LwNJu+s7jHr3ugEbQeou5nNfAgqUtKU4mZJ
 9Hog==
X-Gm-Message-State: AOJu0YxW2wiH5A+3ME+jeKIYHjA8f+hgtgS6jF9ifjL7uf+sz3G9Tsta
 ukJ4NE8qvowXt8QrRHJl5gGhBd4VYpuwAS1JWMwH9iuO3GTMHmg3fGj7RbMBu2MG8rQKDqfBNF0
 =
X-Gm-Gg: ASbGncsCYRiUU+zSb1azOoDIsOVEaDW6tvuQwuCkRPmy2cuPRD7eMgvrqz3EhdI8nSE
 J7eMLMsla2LpfVjgvgKHCU3xCemYpkEKC5cejNRYieMXcZl9cIAO7EnOsIVe9jbEob8O/FwNyWB
 MODxTAs1VuYdoXB0LxrRqiCdksY9o20mOInZlP+zy6nhNgWbySDchxmI9KBtu7VmcOZoSDcuRxL
 XZYot+i126SizgOHB1d8KmVXbwg+UWhfB+CNKilYOeN/uE=
X-Google-Smtp-Source: AGHT+IE5RqYoS8dFMyJNfp1KOZwK9ysaJNUMws+KXj0ZHEkXLsqODAQDjpDkypaj1WNsa1J9I4CSsw==
X-Received: by 2002:a05:690c:4489:b0:6ee:55c7:6128 with SMTP id
 00721157ae682-6eee08c3fecmr9398887b3.5.1732228355982; 
 Thu, 21 Nov 2024 14:32:35 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 7/8] test_ut: Drop support for fallback files
Date: Thu, 21 Nov 2024 15:32:13 -0700
Message-ID: <20241121223217.330117-8-sjg@chromium.org>
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

We don't need the fallback anymore. Remove the code which uses these
files.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---

Changes in v2:
- Separate out patch to drop support for fallback files

 test/py/tests/test_ut.py | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6c3b360d5fd..9b6b6b20c85 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -57,19 +57,6 @@ def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
-def copy_prepared_image(cons, devnum, fname, basename='mmc'):
-    """Use a prepared image since we cannot create one
-
-    Args:
-        cons (ConsoleBase): Console touse
-        devnum (int): device number
-        fname (str): Filename of MMC image
-        basename (str): Base name to use in the filename, e.g. 'mmc'
-    """
-    infname = os.path.join(cons.config.source_dir,
-                           f'test/py/tests/bootstd/{basename}{devnum}.img.xz')
-    u_boot_utils.run_and_log(cons, ['sh', '-c', f'xz -dc {infname} >{fname}'])
-
 def setup_bootmenu_image(cons):
     """Create a 20MB disk image with a single ext4 partition
 
@@ -78,7 +65,6 @@ def setup_bootmenu_image(cons):
     mmc_dev = 4
     fname, mnt = setup_image(cons, mmc_dev, 0x83)
 
-    complete = False
     script = '''# DO NOT EDIT THIS FILE
 #
 # Please edit /boot/armbianEnv.txt to set supported parameters
@@ -187,19 +173,14 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
     u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
     u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    complete = True
     u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
     u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
-    if not complete:
-        copy_prepared_image(cons, mmc_dev, fname)
-
 def setup_bootflow_image(cons):
     """Create a 20MB disk image with a single FAT partition"""
     mmc_dev = 1
     fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
 
-    complete = False
     vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
     initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
     dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
@@ -244,11 +225,8 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
     u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
     u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    complete = True
     u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
     u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
-    if not complete:
-        copy_prepared_image(cons, mmc_dev, fname)
 
 def setup_cros_image(cons):
     """Create a 20MB disk image with ChromiumOS partitions"""
@@ -520,7 +498,6 @@ def setup_efi_image(cons):
     fname, mnt = setup_image(cons, devnum, 0xc, second_part=True,
                              basename=basename)
 
-    complete = False
     efi_dir = os.path.join(mnt, 'EFI')
     mkdir_cond(efi_dir)
     bootdir = os.path.join(efi_dir, 'BOOT')
@@ -536,14 +513,9 @@ def setup_efi_image(cons):
     u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
     u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
     u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    complete = True
     u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
     u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
-    if not complete:
-        copy_prepared_image(cons, devnum, fname, basename)
-
-
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(u_boot_console):
-- 
2.43.0

