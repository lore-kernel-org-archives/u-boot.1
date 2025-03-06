Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1A4C282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC00F81433;
	Fri,  7 Mar 2025 00:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dpf1Y13j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39301810F5; Fri,  7 Mar 2025 00:23:16 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D460081298
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6febbd3b75cso7272657b3.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303387; x=1741908187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuBEzrO1qBO+jHE5XEK9Sg15drYcElsv0D3qDLvCuds=;
 b=dpf1Y13jmKPmuv9U01pznweCNYtQ93k3dzRSz/xe++Mx4RnIKRi3tujdqNlmuXpye4
 N80gn4tCQCjbHMgGvoKd5F/W4KcfVYVh0zMzoUixT+ZCylrRnSVyHrdmeWvVpiTy7BA8
 SHoAyMb/7hVhuiJc+bMwbDcjIXcA5YcMlqda0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303387; x=1741908187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuBEzrO1qBO+jHE5XEK9Sg15drYcElsv0D3qDLvCuds=;
 b=McIenx1f796pvlvljTcAPlZ80jNUUsqbYfaC8Ddro8JOD8Okfm9O+O1nMAeS4cxS3k
 bGs70LF6EMVJw2QrVS84rsEY3LSr9aM+Ovb41JOkH0yLUjbTtaDGn3MX2Lv3rPxSxbXQ
 so9sWOoszjJbYtYRICmWN/cgD/NxyZNCZH7ncmNgwJTi+JXfUfAXGA1MJrZSumHeVrZI
 y39slzbS4A2LhCfRozwdvxid4im17hsI+l7GlW91Yf6y7j6uaLAYjx1CngShS8ZG41IT
 ZsqNaR18O0zzD8xsodIzUnEUnAmKaoiuNv8PC14pyy/xEjWs/2jCG6K56jhwYPDwexcG
 9SGA==
X-Gm-Message-State: AOJu0YxWiiKlqimf0f08Wo9g2tMP3IZ1AipmQNRo1Q/seI7e2XZRgXbj
 Bl0ftHDk30aWiyAF3OffEclkcIJDC6BxPrN2EsyLQjRs39OQsnyqcDSo9Z/gKJ/7RT0iV9f2QnP
 h
X-Gm-Gg: ASbGncvUNNx9Kh8V2AmPtl4gUfW4arbgY49sjxDoGFLINQ5SkQFXdIEsfrGRIcN4G5w
 1KjxNxb77px5W0nF/nSvBbRL+IymEHGZ60WhrIaX128Q4arhfGkiyVeTxEGEu7kU3hA9gWAznKE
 ZYxaT6GjqLQduWDv0I6rsIP7Rnc3k+9ibXp3srEqfwCS4InvWGVUnNZB+1OOM7jMdAKirrT3SvW
 K14qElrd2j3ZdtQyPOGPhc0nPyiI/rrIfwMXLjPAjqfUq5RWZU1X9A4tNkBaLX9EiTEyzFj4s8F
 cl0sdnOuUItQS3OtRrJxhriYbysIOAJH5VZGvw1ZiTDgKhYy
X-Google-Smtp-Source: AGHT+IG6JwZPLjWuYx1SEyHPRtJD3/j6pJusHxBqyVTLeMiXwN6NpLRuacXsoUNibxkAvcJcmpWqpg==
X-Received: by 2002:a05:690c:25c4:b0:6fb:9429:83c5 with SMTP id
 00721157ae682-6febf307356mr20508447b3.19.1741303387713; 
 Thu, 06 Mar 2025 15:23:07 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/10] test/py: Fix two problems with setup_image
Date: Thu,  6 Mar 2025 17:17:06 -0600
Message-ID: <20250306232256.4150882-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
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

There are two issues with this function currently. One is that while we
can be passed an image size to use, we always called qemu-img with 20M
as the size. Fix this by using the size parameter. The second issue is
that reserving 2MiB at the end is not enough room to add a GPT (and the
backup GPT that goes on the end) so reserve 4MiB off the end and make
all of the existing callers use 16M rather than 18M.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 test/py/tests/fs_helper.py |  4 ++--
 test/py/tests/test_ut.py   | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 512ec9c04b06..7ed8af47aa4a 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -89,13 +89,13 @@ def setup_image(config, devnum, part_type, img_size=20, second_part=False,
     fname = os.path.join(config.source_dir, f'{basename}{devnum}.img')
     mnt = os.path.join(config.persistent_data_dir, 'scratch')
 
-    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
+    spec = f'type={part_type:x}, size={img_size - 4}M, start=1M, bootable'
     if second_part:
         spec += '\ntype=c'
 
     try:
         check_call(f'mkdir -p {mnt}', shell=True)
-        check_call(f'qemu-img create {fname} 20M', shell=True)
+        check_call(f'qemu-img create {fname} {img_size}M', shell=True)
         check_call(f'printf "{spec}" | sfdisk {fname}', shell=True)
     except CalledProcessError:
         call(f'rm -f {fname}', shell=True)
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cec894a7b9e3..1e7ed09cebb6 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -139,8 +139,8 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
         cons, f'echo here {kernel} {symlink}')
     os.symlink(kernel, symlink)
 
-    fsfile = 'ext18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    fsfile = 'ext16M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 16M {fsfile}')
     u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
     u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
     u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
@@ -191,8 +191,8 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     u_boot_utils.run_and_log(
         cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
 
-    fsfile = 'vfat18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    fsfile = 'vfat16M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 16M {fsfile}')
     u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
     u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
     u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
@@ -529,8 +529,8 @@ def setup_efi_image(cons):
     with open(efi_src, 'rb') as inf:
         with open(efi_dst, 'wb') as outf:
             outf.write(inf.read())
-    fsfile = 'vfat18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    fsfile = 'vfat16M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 16M {fsfile}')
     u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
     u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
     u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-- 
2.43.0

