Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A33FCD4F54
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F5584713;
	Sat, 23 May 2026 10:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VVwjou53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81ACA84839; Sat, 23 May 2026 10:55:28 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AF98469F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso8174111a34.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526525; x=1780131325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axJA3XkJwvz8fLGS8pP7u8H6fLVVKfWNUwUizPvjcjA=;
 b=VVwjou53Lz5cUpRcKnr6vyF5XolFv2JJZNLmDGUzaAzqCKi3FuCI2ND8ErhyLDKPNa
 jUWxmJiXBc93q7KtX4IGmb/rLFP4NTJYxLGW8tUUa72tJB3GvHKLlu8ybQHlJg9g2kjT
 I7cGbFYSEm8NOUD7yEFH6FToDfByTnFtZAuuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526525; x=1780131325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axJA3XkJwvz8fLGS8pP7u8H6fLVVKfWNUwUizPvjcjA=;
 b=KaCCaLEdsjnix5JafsMvDo/N7R1tsucl1wlhNMG7E2dzNqNxnQmL3C04tlMvxS3X+f
 n64wJnQnJEoD0IjhvkdKgjTuS7emvcdsqX2WIfzikJ3UXEcmAsVHVtewCqyfAlbZEf+o
 wWh36CGd1eVyQgtvcpaZZi4V6W072BGmsXDNZmHSOD4eexDc5Irgc7S0cPMe0n/tza7h
 QHptv91k9Eqcr3hOSQogrjdjh7wydY9bQpQ071JyHUhvqtnFZRf12T7dScZEbvhLDY/1
 xK0D8S4OZ+UHcs29MgujcZv6f3emMEEo1gbDIHLrgIqT0j+4/l4879zhAW0MOmAChD5q
 guhA==
X-Gm-Message-State: AOJu0YzwUIan2/7dhSgf6Q5hXRKlwBVUueXVdY4B98u21tCulGYLtXui
 t2XFWBxQ21ooWPjs0GusFkYn1miqB0V9pOXv79/CHQt8lhsCS81KjjoeCutqE1Ig4wZACmmc4kw
 dA01mVv2qMJQ=
X-Gm-Gg: Acq92OEqwhV6eFTqbqEVFUNxI9v5Od3NbdQPesjssw6u/zzsQslaC447QzEN7akjnab
 wT0jwagDbI7ajnB/8ko7leolHjDFv0WB4B9wiph2WIg029H8X5RdandblWH4DDAQmhjY1EYhtXW
 Utuvep1YkmHq5EJXnkFwCwroRqtBJ3bP8L91jy3ia3LHve/k/4NLZ7yFWj8xLRVoekIaigbvHn/
 9oQGWdH0P5sQN8SXPqsyjmEpHm/2taEMUkPppLs8AizLYp1gpHBEFkqB7l7X+5AeTtlXaDceBqG
 ZwzPpgApfRegTj/Ee9fPDPpb0kE7ptcU/fTt4/63A42MmK2HNPQE594omip0pGEN2Rz7dAJAZvP
 1Wa4U2GDa06KT9W+4ObF0n1Wozad0qX0r/mxU79BeX/b68L5TJhcoEVUivZNS3zqNrVGyyDgilK
 ADVVZLo+v+T48LlAh1ng==
X-Received: by 2002:a05:6830:6afa:b0:7dc:cbe1:119c with SMTP id
 46e09a7af769-7e6000b023dmr3418500a34.10.1779526525021; 
 Sat, 23 May 2026 01:55:25 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/11] test: Move EFI image-creation to its own file
Date: Sat, 23 May 2026 02:54:42 -0600
Message-ID: <20260523085455.750591-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085455.750591-1-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
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

Move setup_efi_image() to its own module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/img/efi.py       | 33 +++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 25 +------------------------
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 test/py/img/efi.py

diff --git a/test/py/img/efi.py b/test/py/img/efi.py
new file mode 100644
index 00000000000..1327a2be6ce
--- /dev/null
+++ b/test/py/img/efi.py
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create EFI test disk images"""
+
+import os
+
+from fs_helper import DiskHelper, FsHelper
+from img.common import mkdir_cond
+
+
+def setup_efi_image(ubman):
+    """Create a 20MB disk image with an EFI app on it"""
+    devnum = 1
+    fsh = FsHelper(ubman.config, 'vfat', 18, 'flash')
+    fsh.setup()
+    efi_dir = os.path.join(fsh.srcdir, 'EFI')
+    mkdir_cond(efi_dir)
+    bootdir = os.path.join(efi_dir, 'BOOT')
+    mkdir_cond(bootdir)
+    efi_src = os.path.join(ubman.config.build_dir,
+                        'lib/efi_loader/testapp.efi')
+    efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
+    with open(efi_src, 'rb') as inf:
+        with open(efi_dst, 'wb') as outf:
+            outf.write(inf.read())
+
+    fsh.mk_fs()
+
+    img = DiskHelper(ubman.config, devnum, 'flash', True)
+    img.add_fs(fsh, DiskHelper.VFAT)
+    img.create()
+    fsh.cleanup()
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 81269a5e92f..1616afbb975 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -24,6 +24,7 @@ from img.extlinux import setup_extlinux_image
 from img.script import setup_script_image
 from img.chromeos import setup_cros_image
 from img.android import setup_android_image
+from img.efi import setup_efi_image
 
 
 def setup_cedit_file(ubman):
@@ -79,30 +80,6 @@ def test_ut_dm_init(ubman):
         fh.write(data)
 
 
-def setup_efi_image(ubman):
-    """Create a 20MB disk image with an EFI app on it"""
-    devnum = 1
-    fsh = FsHelper(ubman.config, 'vfat', 18, 'flash')
-    fsh.setup()
-    efi_dir = os.path.join(fsh.srcdir, 'EFI')
-    mkdir_cond(efi_dir)
-    bootdir = os.path.join(efi_dir, 'BOOT')
-    mkdir_cond(bootdir)
-    efi_src = os.path.join(ubman.config.build_dir,
-                        'lib/efi_loader/testapp.efi')
-    efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
-    with open(efi_src, 'rb') as inf:
-        with open(efi_dst, 'wb') as outf:
-            outf.write(inf.read())
-
-    fsh.mk_fs()
-
-    img = DiskHelper(ubman.config, devnum, 'flash', True)
-    img.add_fs(fsh, DiskHelper.VFAT)
-    img.create()
-    fsh.cleanup()
-
-
 def setup_rauc_image(ubman):
     """Create a 40MB disk image with an A/B RAUC system on it"""
     mmc_dev = 10
-- 
2.43.0

