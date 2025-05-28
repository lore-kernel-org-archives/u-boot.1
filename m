Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE58DC5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FAE83971;
	Wed, 28 May 2025 10:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gFCe6lLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC4383970; Wed, 28 May 2025 10:25:52 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D4583956
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3dd898a16bbso4696445ab.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420749; x=1749025549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLkapK2Jl8rIxxTwUp5feMBZHIk55fVKYxstBOA9Yrk=;
 b=gFCe6lLDsA8pthVhk4oGCFO5naEqSvJiWopDcxi3j9soeKvFKXR6pvaqXBU3MRrfbP
 kWtGesMZUqdjh39maFCFz4oqLE6cPv7e+zpIuJvnCznW9PT8fImRxJATdbUC+I19PFnl
 t4Xju/qATHt8p9McazXR8ko6A8Zq0Dmzu9cms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420749; x=1749025549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLkapK2Jl8rIxxTwUp5feMBZHIk55fVKYxstBOA9Yrk=;
 b=Bibq6aBDS4E8bdhv0QUcEmeXp3yFiRKD04BOO4jFpeqFTCBgvLR7z4ogCcS9c/RYIv
 f51YGGqOC+OgDbcuWkNNMgSy++a9b1n0cWSU/UnOMBWFnc3qmMzHEySbMKdYa1KHE4Ct
 VSSzeXsuk0mJsP0V1m1jYBxLhOiqF7bhKzPqzMxhSpRide/xpK0DHQ4SJTmypbHSHJ+6
 nJVj47guvzBxaXy6akR1XpPaXqNJ1ERv2JTJFZvFdaRaPramaoD8VJ2eJm/vM7SC6LuJ
 erCY4zMrAX6MgxofXilfVY9iJbUavLl8vCnNnXZK3282OS3w8lF3HuMrVD/lPMB6FwYh
 C3eQ==
X-Gm-Message-State: AOJu0YxUa6OHLmYcRwYHLus1KFWXiOqRqgBzVMYAiZLq5S0Jkop9S1a0
 xWZSJ59LlNd8vLhDS0adUk2T6jeJ/Hd8t0SY2MpbZSHMUVA03Lfh5kq4D2BQSJGcLLloSCJ4Tia
 8p9XZCwr9
X-Gm-Gg: ASbGnct4HDN3SpW+SGjuRtB25biHu2ZUuxpIcvgX2fWHpKZ/Fq3k+6CX0KglsIA91SS
 yxobkBtnq6sJfJP/yQutX7TG7Q84tG83HOJ4q2O+un9GJA9sfzmRGT+sHBFyP5M9t67dX7F87nV
 ky1sX2euEiJAjb1ftOxRB1bCBXlKUMgqgIybPiAhi6Z1crZp0lm+xuDlUkBTE2a/a2BvTNJprQV
 8ubomIJAV/jUmhAEaQQBDVwGLEvUCpm1b3l5h8U/WopLgTqsSpcS9WzjHRsqJ1SUTlEAIuQuRVe
 faqjG/e1zgex23T2TPJSdMHc7ReTuq/Bvaj42sLO1xHhcGe8A6APMnlcAm4pqwQMCcJVr7p9L+n
 5FuoittOTC4bW
X-Google-Smtp-Source: AGHT+IGaEmZGcJiLW/C1DMLTxQNUkRt1ojgUsYkMBe7/2UkSb/vV3uOPJeCPEMenWNTkOdWpP6NWrg==
X-Received: by 2002:a05:6e02:144d:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3dc9b6aa36dmr127094345ab.10.1748420748766; 
 Wed, 28 May 2025 01:25:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/27] scripts: Update build-efi to support booting an OS
Date: Wed, 28 May 2025 02:24:30 -0600
Message-ID: <20250528082520.152391-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Bring this script into line with build-qemu so an OS and release can be
specified. As with that script, only Ubuntu is supported for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/scripts/build-efi b/scripts/build-efi
index 4f0457e973c..fb6575a89a6 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -17,6 +17,7 @@ Use ~/.build-efi to configure the various paths used by this script.
 
 from argparse import ArgumentParser
 import os
+from pathlib import Path
 import shutil
 
 from build_helper import Helper
@@ -47,12 +48,17 @@ def parse_args():
                         help='Add a kernel')
     parser.add_argument('-O', '--old', action='store_true',
                         help='Use old EFI app build (before 32/64 split)')
+    parser.add_argument('-o', '--os', metavar='NAME', choices=['ubuntu'],
+                        help='Run a specified Operating System')
     parser.add_argument('-p', '--payload', action='store_true',
                         help='Package up the payload')
     parser.add_argument('-P', '--partition', action='store_true',
                         help='Create a partition table')
     parser.add_argument('-r', '--run', action='store_true',
                         help='Run QEMU with the image')
+    parser.add_argument(
+        '-R', '--release', default='24.04.1',
+        help='Select OS release version (e.g, 24.04) Default: 24.04.1')
     parser.add_argument('-s', '--serial', action='store_true',
                         help='Run QEMU with serial only (no display)')
     parser.add_argument('-w', '--word', action='store_true',
@@ -73,6 +79,7 @@ class BuildEfi:
         self.img = self.helper.get_setting('efi_image_file', 'efi.img')
         self.build_dir = self.helper.get_setting("build_dir", '/tmp')
         self.args = args
+        self.imagedir = Path(self.helper.get_setting('image_dir', '~/dev'))
 
     def run_qemu(self, bitness, serial_only):
         """Run QEMU
@@ -84,6 +91,7 @@ class BuildEfi:
         extra = []
         efi_dir = self.helper.get_setting('efi_dir')
         if self.args.arm:
+            os_arch = 'arm64'
             qemu_arch = 'aarch64'
             extra += ['--machine', 'virt', '-cpu', 'max']
             bios = os.path.join(efi_dir, 'OVMF-pure-efi.aarch64.fd.64m')
@@ -99,9 +107,11 @@ class BuildEfi:
             if bitness == 64:
                 qemu_arch = 'x86_64'
                 bios = 'OVMF-pure-efi.x64.fd'
+                os_arch = 'amd64'
             else:
                 qemu_arch = 'i386'
                 bios = 'OVMF-pure-efi.i386.fd'
+                os_arch = 'i386'
             extra += ['-bios', os.path.join(efi_dir, bios)]
             extra += ['-drive', f'id=disk,file={self.img},if=none,format=raw']
             extra += ['-device', 'ahci,id=ahci']
@@ -118,11 +128,28 @@ class BuildEfi:
         if self.args.kvm:
             extra.extend(['-enable-kvm', '-cpu', 'host'])
 
+        os_path = None
+        if self.args.os == 'ubuntu':
+            img_name = f'{self.args.os}-{self.args.release}-desktop-{os_arch}.iso'
+            os_path = self.imagedir / self.args.os / img_name
+            if not os_path.exists():
+                tout.error(f'OS image {os_path} specified but not found')
+            else:
+                extra.extend([
+                    '-drive',
+                    f'if=virtio,file={os_path},format=raw,id=hd0,readonly=on'])
+
         print(f'Running {qemu}{serial_msg}')
 
         # Use 512MB since U-Boot EFI likes to have 256MB to play with
+        if self.args.os:
+            mem = '4G'
+            extra.extend(['-smp', '4'])
+        else:
+            mem = '512'
+
         cmd = [qemu]
-        cmd += '-m', '512'
+        cmd += '-m', mem
         cmd += '-nic', 'none'
         cmd += extra
         command.run(*cmd)
-- 
2.43.0

