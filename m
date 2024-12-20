Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8224E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8CA8037B;
	Fri, 20 Dec 2024 05:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WoGjiFEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09AFB8034E; Fri, 20 Dec 2024 05:01:38 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9124980087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e6d1283aso90194039f.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667294; x=1735272094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhjbeRl7kWJpyaadszQ8jtOssIRJ1iZ+Dw0LKIGOvBA=;
 b=WoGjiFEU5XfREfegb4m7jpf9q9J9YS+brHG7Nj25cmygip2dR4uTLRNpTuRv345y8G
 LRr1tGqqem4DN621O6/59YqaitpfZfY2xA1HElyWMZbaWWTBpFbyEuxIYI3r4K2uFy/3
 oCOY6CshNw+hRWEIfEmNojcYw0QpJFkx8X1z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667294; x=1735272094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhjbeRl7kWJpyaadszQ8jtOssIRJ1iZ+Dw0LKIGOvBA=;
 b=nXe0YlnFGWelKQ59Z31fY+egGjSDqOhJZooiKwmHBwC68oMR6kcVHLqTk5+Th0G+qg
 j28wNdZpkZDEvHikYhI8h5aU3osbhoSGQLFqIob9wnt7FVlAUVmabv8WDuFT+7Z12h3f
 J72KdcM7J5v7TJSxt/w/JpTRDjqOtR05TKlcMlProlYQfHkQhlc1146szAYvBaO6K8Le
 oyaF5sDS0yCrZPLl0GNiRpuvH1R+waGjADis4WSZQVtdJhQSh4ZJV6jBJXjtkoysQVMA
 VOhzwzo+sP179eTMfmA0TcdHm60FQn3fSLBd0wzH7qJCSGa5pxpmnO1IvaW3sG9y+VAS
 AC1w==
X-Gm-Message-State: AOJu0YxR1QXy9ExXgQHVYELZssNmtAlusie/d3JXIWVzpBxgfZMfmAaK
 sC24veVqFGSQh0ajjMy+Ck0NUPtYlIFuc85AV28HB2WwtBk8GdFDp6N85w80cQ1K+qmJfHEs79c
 =
X-Gm-Gg: ASbGncuHVFwTh7XlUD0JiW9FlEk/+xjZKtRujjVW5qRvB0xDUf50xptF3gONsMc9CCV
 A6QMDBLen0eVALiwK0jYxJRYIliSj4qAxLE1OnkzIm/DPfjygmSWtLAIYZT0+PlQl33qQBCyAKG
 ouLPgmjKVQtRm+FygeCkGMxszD4xCXhsNStNh+skr3woc8Izfcuhge3ZBJRf5ldGFHr8YxLNTqx
 lHeFP62wH6bFQMcvTh+/M9ZGCcru2XQ2IRF1dVuAGQpP22T2WmZk7E68Bop3FWHqF96j0nsAf/3
 6irnIEjTckHmAF8I8A==
X-Google-Smtp-Source: AGHT+IH9xOGSYxtw+pHNcFnZmDBfAdA9mXXLTe3x1+Qx1RnSv3N+AbBZTPDZDwKw+YwQIElN5eyVdw==
X-Received: by 2002:a05:6e02:3c86:b0:3a9:d32c:d312 with SMTP id
 e9e14a558f8ab-3c02f9e9555mr54344405ab.9.1734667293806; 
 Thu, 19 Dec 2024 20:01:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c22213asm594723173.155.2024.12.19.20.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:01:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] test/py: Refactor extlinux-image creation into a function
Date: Thu, 19 Dec 2024 21:01:16 -0700
Message-Id: <20241220040120.3245610-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220040120.3245610-1-sjg@chromium.org>
References: <20241220040120.3245610-1-sjg@chromium.org>
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

We would like to make another image which is very similar, so create a
function to produce an extlinux image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 67 +++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cacf11f7c0a..e3b988efe23 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -57,6 +57,43 @@ def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
+def setup_extlinux_image(cons, mmc_dev, vmlinux, initrd, dtbdir, script):
+    """Create a 20MB disk image with a single FAT partition"""
+    fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
+
+    ext = os.path.join(mnt, 'extlinux')
+    mkdir_cond(ext)
+
+    conf = os.path.join(ext, 'extlinux.conf')
+    with open(conf, 'w', encoding='ascii') as fd:
+        print(script, file=fd)
+
+    inf = os.path.join(cons.config.persistent_data_dir, 'inf')
+    with open(inf, 'wb') as fd:
+        fd.write(gzip.compress(b'vmlinux'))
+    mkimage = cons.config.build_dir + '/tools/mkimage'
+    u_boot_utils.run_and_log(
+        cons, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
+
+    with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
+        print('initrd', file=fd)
+
+    if dtbdir:
+        mkdir_cond(os.path.join(mnt, dtbdir))
+
+        dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
+        u_boot_utils.run_and_log(
+            cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+
+    fsfile = 'vfat18M.img'
+    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+    u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+
+
 def setup_bootmenu_image(cons):
     """Create a 20MB disk image with a single ext4 partition
 
@@ -197,36 +234,8 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
         fdtdir /%s/
         initrd /%s''' % (vmlinux, dtbdir, initrd)
-    ext = os.path.join(mnt, 'extlinux')
-    mkdir_cond(ext)
 
-    conf = os.path.join(ext, 'extlinux.conf')
-    with open(conf, 'w', encoding='ascii') as fd:
-        print(script, file=fd)
-
-    inf = os.path.join(cons.config.persistent_data_dir, 'inf')
-    with open(inf, 'wb') as fd:
-        fd.write(gzip.compress(b'vmlinux'))
-    mkimage = cons.config.build_dir + '/tools/mkimage'
-    u_boot_utils.run_and_log(
-        cons, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
-
-    with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
-        print('initrd', file=fd)
-
-    mkdir_cond(os.path.join(mnt, dtbdir))
-
-    dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
-    u_boot_utils.run_and_log(
-        cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
-
-    fsfile = 'vfat18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-    u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
-    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    setup_extlinux_image(cons, mmc_dev, vmlinux, initrd, dtbdir, script)
 
 def setup_cros_image(cons):
     """Create a 20MB disk image with ChromiumOS partitions"""
-- 
2.34.1

