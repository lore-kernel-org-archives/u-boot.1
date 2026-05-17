Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BE0CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80338469D;
	Mon, 18 May 2026 00:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gHFRfK44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87C4846C7; Mon, 18 May 2026 00:51:59 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E4BC845E3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dca4debedaso1876680a34.2
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058310; x=1779663110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r9O9S2PbbcsZ1qngh0VSfZXtSdk98LS6559M7R6gTI=;
 b=gHFRfK44EZJK5rb2qrc46xQ0Iu6Ekjl+3amHgcrwClaPYqecnU0vpsc6dS+4CfFB2h
 YIadgLusIqNK+RZ0ZugW/jEAILOqgH1MvMtCdWt6MiNXW8h4SNX7FXfhzc0tL/Vc7gJh
 Rm31+Cjikgeg4NvTOoRwnfkfl/IUIGldk5BT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058310; x=1779663110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0r9O9S2PbbcsZ1qngh0VSfZXtSdk98LS6559M7R6gTI=;
 b=QHqokF1Gexx06jeUKcu8fOu/BSj0wFOBtSQIhWBi6Z6OCeMuCODLwU7VMRIb4/X9f0
 9SIhD7YpC8ivDPBWrCvW9bA3avSg+iK3dckzZ7EjUaTIZsHfiYyFg51aj28vcaoBsJxc
 pDeHRRpVKQwsKRkLU+zEzMizpLxQjQgIGQHRZBHYtNa05lz7vcFbUdJsN6NfNT0rex6N
 CAOWeZVyVeiQxuHMfWXhxOGeYREJ4OdiQSTksg6PH06EBYqCok+a3BV4N3lGIp+LarWY
 GAvntMcmuXxfpT8OpuqgYDPumJITGc5AjpyCOFbCQOmNyc40KVh3xyiU7QXou3y14/NF
 kuhg==
X-Gm-Message-State: AOJu0YwuPnwlwQ6zHBeCUgMWDhpfEkmPMYTQX0pWrcD7fhbEtwyw4AOd
 k80si/mKC4nCBsEEJ6d1Pu52nztBuGj+PWzxXgFLNXlNvuHawGF2nZwuJrQJZp1eBgEGvNFQCnS
 4yWLICCAv
X-Gm-Gg: Acq92OHNjI2XzoRir6OHPHhsgEP32OZpnbUpN6l64/RP56OzUnyvQK6gwssHDO05Xum
 xMgIlPFTtedaNUbWfiXLaQkPi/GNxqvS5pyGCosh3zfk24KVOh+WoyzJgR/fxYGJE6C3d3KaznQ
 k/e7k3X80bx9G0WEkkcnshURVuZ7ieYv/AJIvQh+LRksnYZVj5lSH96MU/FQWAkt7YSBq2Z/uKh
 gud7JA6GFAc6nZsl/1SaGDtTJ51O93zPhvZ9DU0/0xAkm2/i9Ndwco8z7GaYqbGN6YeITjW66lB
 dhaERVRdcHiZxNRrQQ/wobyLeqjkBLqUhVqcxZkSe/m358VRs0xKb/tzHDQPdjLdgs2vDMjmPFu
 ay4yRyLaURfdLSnZ4AlyGZ4o/HtrMYA5QED9YWT0DXGCOw+fgUn8n3K9B+B3eZYuwZhRSdyP0Ba
 4pJ+7afs346ZpllS84Bg==
X-Received: by 2002:a05:6830:608b:b0:7e3:7dcf:9d3f with SMTP id
 46e09a7af769-7e4f2b80758mr8967025a34.16.1779058310111; 
 Sun, 17 May 2026 15:51:50 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] test: Add Args docstrings to img setup functions
Date: Sun, 17 May 2026 16:51:06 -0600
Message-ID: <20260517225122.2966807-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517225122.2966807-1-sjg@chromium.org>
References: <20260517225122.2966807-1-sjg@chromium.org>
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

The image-setup functions in test/py/img/ have terse docstrings from
their original location in test_ut.py

Add an Args block describing the ubman parameter so each function is
self-documenting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/android.py  | 6 +++++-
 test/py/img/armbian.py  | 3 +++
 test/py/img/cedit.py    | 6 +++++-
 test/py/img/chromeos.py | 6 +++++-
 test/py/img/efi.py      | 6 +++++-
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/test/py/img/android.py b/test/py/img/android.py
index 2ea964f5520..77c5d33c8f0 100644
--- a/test/py/img/android.py
+++ b/test/py/img/android.py
@@ -11,7 +11,11 @@ from test_android import test_abootimg
 
 
 def setup_android_image(ubman):
-    """Create a 20MB disk image with Android partitions"""
+    """Create a 20MB disk image with Android partitions
+
+    Args:
+        ubman (ConsoleBase): Console to use
+    """
     Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
     disk_data = None
diff --git a/test/py/img/armbian.py b/test/py/img/armbian.py
index 40a890d57f6..1bcba3fae63 100644
--- a/test/py/img/armbian.py
+++ b/test/py/img/armbian.py
@@ -14,6 +14,9 @@ def setup_bootmenu_image(ubman):
     """Create a 20MB disk image with a single ext4 partition
 
     This is modelled on Armbian 22.08 Jammy
+
+    Args:
+        ubman (ConsoleBase): Console to use
     """
     mmc_dev = 4
 
diff --git a/test/py/img/cedit.py b/test/py/img/cedit.py
index 4b53275d259..1a995bc9768 100644
--- a/test/py/img/cedit.py
+++ b/test/py/img/cedit.py
@@ -9,7 +9,11 @@ import utils
 
 
 def setup_cedit_file(ubman):
-    """Set up a .dtb file for use with testing expo and configuration editor"""
+    """Set up a .dtb file for use with testing expo and configuration editor
+
+    Args:
+        ubman (ConsoleBase): Console to use
+    """
     infname = os.path.join(ubman.config.source_dir,
                            'test/boot/files/expo_layout.dts')
     inhname = os.path.join(ubman.config.source_dir,
diff --git a/test/py/img/chromeos.py b/test/py/img/chromeos.py
index a533fd5ae33..6e7cd562c0e 100644
--- a/test/py/img/chromeos.py
+++ b/test/py/img/chromeos.py
@@ -10,7 +10,11 @@ import utils
 
 
 def setup_cros_image(ubman):
-    """Create a 20MB disk image with ChromiumOS partitions"""
+    """Create a 20MB disk image with ChromiumOS partitions
+
+    Args:
+        ubman (ConsoleBase): Console to use
+    """
     Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
     disk_data = None
diff --git a/test/py/img/efi.py b/test/py/img/efi.py
index 1327a2be6ce..4cb0bb95a59 100644
--- a/test/py/img/efi.py
+++ b/test/py/img/efi.py
@@ -10,7 +10,11 @@ from img.common import mkdir_cond
 
 
 def setup_efi_image(ubman):
-    """Create a 20MB disk image with an EFI app on it"""
+    """Create a 20MB disk image with an EFI app on it
+
+    Args:
+        ubman (ConsoleBase): Console to use
+    """
     devnum = 1
     fsh = FsHelper(ubman.config, 'vfat', 18, 'flash')
     fsh.setup()
-- 
2.43.0

