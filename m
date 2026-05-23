Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79064CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44C68482F;
	Sat, 23 May 2026 10:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OGj5t42Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD378485F; Sat, 23 May 2026 10:55:31 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72FD847AF
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e61e25199bso68126a34.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526528; x=1780131328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXyQAQh/9SQlUhQYwCgqb1MxJzH3e/3IZGDtu58/zTU=;
 b=OGj5t42QlkqL4ekQnFORjXMvMdtyV93MUL1HjjBjJJPCwxVw7/d/FT7bAAvI0yPySY
 iLwpRjqkUkT31x3Vwzdxl2i/z5wXlV8zs1WiqDndeiK4CSGMAOduCrh+nHqGUeaIZtNx
 sYGHBff0Zodc9B0EFOBYWhYhA3DZ7QQn313xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526528; x=1780131328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXyQAQh/9SQlUhQYwCgqb1MxJzH3e/3IZGDtu58/zTU=;
 b=NIU1PKUURerr6NUFxF9Qv085d+37EDegEy9dVZ5hNoVBq+8RiheLetFlGmo17Y5/y9
 S3IjNx+np+ZKtLbQ09hxQ29KQBiyv6Xn813xvsZJxa7MuF5+iOCaFBWZByUwpXm96stG
 azbqFGg2IPGcovIr1p/ZjioYmI8DxvcEx88Rd97lQDTXjbyqRnHnsyiQzOYsdKsbr9WP
 Msn3HnunGb8b3hLz0zw4epuonRzmyP0tGITsB56Sm3vsgYpn4WribGSFtqeKk0LRcKD6
 aA2grLQgm8tGOpzHR7NMmXXCLyizkr4QddgdXeWdN+tq6ft4iiZMzoKBppctNeBY2/L8
 264Q==
X-Gm-Message-State: AOJu0YyzxOjok2YzY5IStRZVY08F1c8e+mOvBrtVLRb4QMXSP79MxPDF
 LS2E0Ymnnz1PeRW8EgBuoE3AdvDfgeOlN/mIMZjnjYJ7p0gSh8B+upx8DTHlX4hjZdFgILD8zho
 XObyqJOIz
X-Gm-Gg: Acq92OFarMVcCS/mNjaj2JA7oNGJXkacYhpSMd9f/3ojpw8ARAsJr+n+u57/C2XD2ee
 N1IChl9Xhals2Nz+xSd6CYe+HTk1THA2rEKWRAvqJZa5sZdsJ7cJ/iVZpn52IWYI4XCD18UDzgJ
 8lsZyuE6/zbz6EJQDKY5BvzomSATRgSd4rHFWJbqZ2WOH1jmXHr8fHbyIzRt+MigLqYROS6ro41
 DYD0EmNJcz2GMB3WTzCdL70tmiwjP8Mo/GEjN1/HOX98VeGWLhM4JIA3O1i3+yHBjjJFwBNLtob
 ab2G+pE3FRiJS0v3IEvW0JS6+cWmwiQmbGjRKZNiM1N8hStBAN672eprj7ZB15krwIiY7bxXY2D
 7S3ULDDbSaMyjurX2F/SrBzRhN6RP8pvsesxLxYr5sbN1hvRMOSmPfeojQ3jPYwsLS1AJmRon2F
 WO5GkccCBsk/4bHDIMeWoW8sVautdk
X-Received: by 2002:a05:6830:82e2:b0:7dc:c620:aa12 with SMTP id
 46e09a7af769-7e5fee9b2dbmr4606048a34.20.1779526528554; 
 Sat, 23 May 2026 01:55:28 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] test: Add Args docstrings to img setup functions
Date: Sat, 23 May 2026 02:54:44 -0600
Message-ID: <20260523085455.750591-9-sjg@chromium.org>
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

The image-setup functions in test/py/img/ have terse docstrings from
their original location in test_ut.py

Add an Args block describing the ubman parameter so each function is
self-documenting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/img/android.py  | 6 +++++-
 test/py/img/cedit.py    | 6 +++++-
 test/py/img/chromeos.py | 6 +++++-
 test/py/img/efi.py      | 6 +++++-
 test/py/img/script.py   | 3 +++
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
diff --git a/test/py/img/script.py b/test/py/img/script.py
index 3e36686ee5a..e6072bf5bd9 100644
--- a/test/py/img/script.py
+++ b/test/py/img/script.py
@@ -14,6 +14,9 @@ def setup_script_image(ubman):
     """Create a 20MB disk image for the script bootmeth
 
     This is modelled on Armbian 22.08 Jammy
+
+    Args:
+        ubman (ConsoleBase): Console to use
     """
     mmc_dev = 4
 
-- 
2.43.0

