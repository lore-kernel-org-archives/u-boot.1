Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731ABC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFC4801A0;
	Mon,  3 Feb 2025 18:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jlQ6W5D8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEFF801A0; Mon,  3 Feb 2025 18:43:29 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF37780780
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb8db8ae9aso1976852b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604604; x=1739209404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7MTFF3O3ZQ9meG5rOh8sNaktXh+lgdJCUXHEXx+EtQ=;
 b=jlQ6W5D8YV3Pq42Ml84q0/3M1KMV4wgiOJu7K/+R98j0CLCz2y11gD66m+zV36rXTc
 nL4UXUhVLx0bvUFlgPgQxTGV6A8b4esBd7JFYHNL0Z+127/Eux704veMrooXlt0r7lPf
 S5DDQ038o8jlPZy30FGNNhcAKPAUWT+JxQmo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604604; x=1739209404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7MTFF3O3ZQ9meG5rOh8sNaktXh+lgdJCUXHEXx+EtQ=;
 b=h30Pjj8UCcnIRBiunChe18V2Y1NNlQ27X/0S1gNZNEirV0KFC5qsn3gJ5ZxpjGg4Ee
 nvo+Ju9s1h4nUhWbd3VH0U8XzBB21X62CNsWgEfxx3b4jWbnyF8yLjdb4LZrR3GJ0cqQ
 +uETATdb8CpLYx42Aole166CmKpoFwNBxeipfOcGYhcCfE4GBCYvz7vuXe9gd4fYBih9
 fCQuI2sbW0PoP63HLGnUh1AJkEIFuXM3eP1zDgqI4nO89dkuLo1GliM26m+psDRA4l0s
 f1EPZTZ5QqKZ/X/MFd36M2ba1ggzU3shnMc6Ls3VMe0wptFDOQ9E2HHxEzzcR3zlJqL5
 8bZQ==
X-Gm-Message-State: AOJu0YzpFHpfzGrVo8ZWauKguazq+6EPhn7LB+EJaabBIEfffAmLCbra
 /vhs1jo5g7tXPCGmFWpoEQcQtoJOyhoR/HDokcoTlybWv6II3xrZK2XvdRaf+ooX8cxKte/RX1E
 =
X-Gm-Gg: ASbGncu/lwN71V0NoW0eXBdUrqhabLYMUCUD9Pz+r2QD5UxVSPYHQ4b+K8wWQ7DRpcH
 BMCf1ZCAi+b3B9cznktwJv1rS7+KLdzoPne/3eHRJPdrX3z459iQzJB3ZWUlNewZehDl7rJV6uH
 FsMff1lz6MhhEtOmGv6AwATdgO2Gc89dBwPqEfW9KD+Amr/Jr7DssK9sm82cm0TC2gfmEdqsxQG
 wZPAhmXRNGa7HPf/pQQzX+FUwus2yiEPwfRPgy0zktn+m3yTA0tcE17SDOWvMLzYwQ2UPwISqo4
 aIRq1djyQOEvKEs0GiMzSnLY2y3pZTHXlxetGvajoENuLR7rke9t
X-Google-Smtp-Source: AGHT+IEwjAUBTP9A/BosdtUggn4i4R1rrNi9vZFH/JsnKEzfo6iLknT/5Y9i+uf0xqNdS6jugORHVg==
X-Received: by 2002:a05:6808:1b87:b0:3f0:40f5:fa5 with SMTP id
 5614622812f47-3f323b0f987mr16540061b6e.28.1738604604003; 
 Mon, 03 Feb 2025 09:43:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/32] scripts: Update build-efi to support arm64
Date: Mon,  3 Feb 2025 10:42:00 -0700
Message-ID: <20250203174245.1331464-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Provide a -A flag to select ARM instead of x86. For now, only the app
is supported and only for 64-bit ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi.py | 49 +++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/scripts/build-efi.py b/scripts/build-efi.py
index 3a1bf180ade..1ba37e86e88 100755
--- a/scripts/build-efi.py
+++ b/scripts/build-efi.py
@@ -48,6 +48,8 @@ def parse_args():
         epilog='Script for running U-Boot as an EFI app/payload')
     parser.add_argument('-a', '--app', action='store_true',
                         help='Package up the app')
+    parser.add_argument('-A', '--arm', action='store_true',
+                        help='Run on ARM architecture')
     parser.add_argument('-B', '--no-build', action='store_true',
                         help="Don't build (an existing build must be present")
     parser.add_argument('-k', '--kernel', action='store_true',
@@ -131,26 +133,43 @@ class BuildEfi:
         """
         extra = []
         efi_dir = self.get_setting("efi_dir")
-        if bitness == 64:
-            qemu = 'qemu-system-x86_64'
-            bios = 'OVMF-pure-efi.x64.fd'
-        else:
-            qemu = 'qemu-system-i386'
-            bios = 'OVMF-pure-efi.i386.fd'
+        if self.args.arm:
+            qemu_arch = 'aarch64'
+            extra += ['--machine', 'virt', '-cpu', 'max']
+            bios = os.path.join(efi_dir, 'OVMF-pure-efi.aarch64.fd.64m')
+            var_store = os.path.join(efi_dir, 'varstore.img')
+            extra += [
+                '-drive', f'if=pflash,format=raw,file={bios},readonly=on',
+                '-drive', f'if=pflash,format=raw,file={var_store}'
+                ]
+            extra += ['-drive',
+                      f'id=hd0,file={self.img},if=none,format=raw',
+                      '-device', 'virtio-blk-device,drive=hd0']
+        else:  # x86
+            if bitness == 64:
+                qemu_arch = 'x86_64'
+                bios = 'OVMF-pure-efi.x64.fd'
+            else:
+                qemu_arch = 'i386'
+                bios = 'OVMF-pure-efi.i386.fd'
+            extra += ['-bios', os.path.join(efi_dir, bios)]
+            extra += ['-drive', f'id=disk,file={self.img},if=none,format=raw']
+            extra += ['-device', 'ahci,id=ahci']
+            extra += ['-device', 'ide-hd,drive=disk,bus=ahci.0']
+        qemu = f'qemu-system-{qemu_arch}'
         if serial_only:
-            extra = ['-display', 'none', '-serial', 'mon:stdio']
+            extra += ['-display', 'none', '-serial', 'mon:stdio']
             serial_msg = ' (Ctrl-a x to quit)'
         else:
-            extra = ['-serial', 'mon:stdio']
+            if self.args.arm:
+                extra += ['-device', 'virtio-gpu-pci']
+            extra += ['-serial', 'mon:stdio']
             serial_msg = ''
         print(f'Running {qemu}{serial_msg}')
 
         # Use 512MB since U-Boot EFI likes to have 256MB to play with
-        cmd = [qemu, '-bios', os.path.join(efi_dir), bios)]
+        cmd = [qemu]
         cmd += '-m', '512'
-        cmd += '-drive', f'id=disk,file={self.img},if=none,format=raw'
-        cmd += '-device', 'ahci,id=ahci'
-        cmd += '-device', 'ide-hd,drive=disk,bus=ahci.0'
         cmd += '-nic', 'none'
         cmd += extra
         command.run(*cmd)
@@ -229,6 +248,7 @@ class BuildEfi:
                 command.output(*cmd)
             except command.CommandExc:
                 time.sleep(0.5)
+                cmd = 'sudo', 'kpartx', '-d', self.img
                 command.output(*cmd)
 
     def do_build(self, build):
@@ -244,15 +264,16 @@ class BuildEfi:
         """This does all the work"""
         args = self.args
         bitness = 32 if args.word else 64
+        arch = 'arm' if args.arm else 'x86'
         build_type = 'payload' if args.payload else 'app'
         self.tmp = f'{self.build_dir}/efi{bitness}{build_type}'
-        build = f'efi-x86_{build_type}{bitness}'
+        build = f'efi-{arch}_{build_type}{bitness}'
 
         if not args.no_build:
             self.do_build(build)
 
         if args.old and bitness == 32:
-            build = f'efi-x86_{build_type}'
+            build = f'efi-{arch}_{build_type}'
 
         self.setup_files(build, build_type)
 
-- 
2.43.0

