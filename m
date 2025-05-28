Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D6DC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3658983951;
	Wed, 28 May 2025 10:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IeK5ICRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0332F82FE7; Wed, 28 May 2025 10:25:46 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C237183956
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3dd898a16bbso4695495ab.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420742; x=1749025542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RFWos1qxwj7uzrFnP6NwbLK/2nuC5gnNEC7pTXNpN4=;
 b=IeK5ICRgXbexyZ1wN2wxGwjVfD3FZG0MCHo54LoKxwJFXzveF4KFHBXaZMcZxACF3i
 OF+7Ht14lJXyP5MDBtlJCnXT3b0PV94cBekqJ5N5YDS7IgThPNHT6djzzwYvEqMr8n/7
 NCf5V64wmlTph/pVG+0Hd5lxTddb2/Mv93qO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420742; x=1749025542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RFWos1qxwj7uzrFnP6NwbLK/2nuC5gnNEC7pTXNpN4=;
 b=HhM4dHnYSUJ668rjRUcNeJuw0kd0JWIyLj8c4m87TF1ib6GxUtfCj1BDL0N1rRPndo
 yQh2waKXCpPGW5iiBAJK/h/0xXrnlnfLxaF4NTmeJDgvBNoed19CGeJE6muhXNnzMUm4
 u61cgGfz3OrzXMkT3YZiLh5mui53CEKEjgG1y+qDQGq6pzWYooG4ESHwEdF6+NneLdtz
 i7MiKXhIU25HzDiKLlt4eWjeLan+4uG6gB/gbsM6zsitvZJzkwROKhn3cmvD0bVDtglw
 abe8qZcYibYCMoZH6hx4o++gTdSTrw6nV/5+tTWp6uc6SaaL9xvQ6Ji2vd8B5gNN3DI5
 6jwg==
X-Gm-Message-State: AOJu0YwFMuXzAXm0+eQQIr7ye/0Afd/dNdHBs7OKRd0N/bQNQKIbNo1Y
 sLeMUwxbJj5meg3GF8j4b/9PZqtM0IRJb/mFMNPWqZcniTe3DRTlIlR/tF7BkioY/g+bpPfVK57
 +LnBJPjGu
X-Gm-Gg: ASbGncsycdQ0Pc88XgNOy7ezRKMu86g8EA3tfDIgHvB1M2D/CnYRxRS6kDdUIx+zWMN
 Rrg7DBn4OclGI/1UsBSk01sI5nhMJhzfxYmxL16atsU/zFmYrkX/1o9yXpM1MVEaU1v4hzhe8CP
 7VBWh2PPXlI2eQz34hY/sATFwmTgxIMcberlt5OuccVP3GMdXuM8UNkkpyzZWmi2zIkgyZjtxyO
 KM+my+f+lomrqZU9Lfj5nod6aImuzeCM4nVA3nhzNr7eYVxmeGe/jL9d8XcLE4ypAewv2SFU36L
 pFG+ggJDDlUkp8cNwtlLOYqKxTXM0Ciuy2KmwQexl2F4GdzeE4V8NBqFezzREW4geYlSMgJi8wU
 rfwQWqhWoeAhZ
X-Google-Smtp-Source: AGHT+IGO/O1BQvQ5hNXAgBvGYclUPOYG4HWYFDlchg0X8QjHHm/hEdQ4jDGYgy/IDkVrAxVYwNUaKg==
X-Received: by 2002:a05:6e02:2701:b0:3d9:6485:39f0 with SMTP id
 e9e14a558f8ab-3dc9b6a9e4emr142133815ab.9.1748420741917; 
 Wed, 28 May 2025 01:25:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/27] scripts: Tidy up build-qemu a little
Date: Wed, 28 May 2025 02:24:27 -0600
Message-ID: <20250528082520.152391-2-sjg@chromium.org>
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

This provides a few clean-ups:

- sort the imports correctly
- sort the arguments (-v is in the wrong place)
- use os_arch for the OS architecture, to match build-efi

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-qemu | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/build-qemu b/scripts/build-qemu
index 5798da3775c..74dc3bb915e 100755
--- a/scripts/build-qemu
+++ b/scripts/build-qemu
@@ -12,13 +12,13 @@ It assumes that
 So far the script supports only ARM and x86
 """
 
-import sys
-import os
 import argparse
+import os
+from pathlib import Path
 import subprocess
+import sys
 import shlex
 import time
-from pathlib import Path
 
 from build_helper import Helper
 
@@ -57,8 +57,6 @@ def parse_args():
         help='Use KVM (Kernel-based Virtual Machine) for acceleration')
     parser.add_argument('-o', '--os', metavar='NAME', choices=['ubuntu'],
                         help='Run a specified Operating System')
-    parser.add_argument('-v', '--verbose', action='store_true',
-                        help='Show executed commands')
     parser.add_argument('-r', '--run', action='store_true',
                         help='Run QEMU with the built/specified image')
     parser.add_argument(
@@ -70,6 +68,8 @@ def parse_args():
     parser.add_argument(
         '-S', '--sct-seq',
         help='SCT sequence-file to be written into the SCT image if -e')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Show executed commands')
     parser.add_argument('-w', '--word-32bit', action='store_true',
                         help='Use 32-bit version for the build/architecture')
 
@@ -148,27 +148,27 @@ class BuildQemu:
             self.qemu_extra.extend(['-machine', 'virt'])
             if not args.kvm:
                 self.qemu_extra.extend(['-accel', 'tcg'])
-            qemu_arch = 'arm'
+            os_arch = 'arm'
             if self.bitness == 64:
                 self.board = 'qemu_arm64'
                 self.qemu = 'qemu-system-aarch64'
                 self.qemu_extra.extend(['-cpu', 'cortex-a57'])
-                qemu_arch = 'arm64'
+                os_arch = 'arm64'
         elif args.arch == 'x86':
             self.board = 'qemu-x86'
             default_bios = 'u-boot.rom'
             self.qemu = 'qemu-system-i386'
-            qemu_arch = 'i386'  # For OS image naming
+            os_arch = 'i386'  # For OS image naming
             if self.bitness == 64:
                 self.board = 'qemu-x86_64'
                 self.qemu = 'qemu-system-x86_64'
-                qemu_arch = 'amd64'
+                os_arch = 'amd64'
         else:
             raise ValueError(f"Invalid arch '{args.arch}'")
 
         self.os_path = None
         if args.os == 'ubuntu':
-            img_name = (f'{args.os}-{args.release}-desktop-{qemu_arch}.iso')
+            img_name = (f'{args.os}-{args.release}-desktop-{os_arch}.iso')
             self.os_path = self.imagedir / args.os / img_name
 
         self.build_dir = self.ubdir / self.board
-- 
2.43.0

