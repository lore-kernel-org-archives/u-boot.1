Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBB4CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19CB84A04;
	Wed,  6 May 2026 17:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ayTxbOD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC30849EF; Wed,  6 May 2026 17:58:07 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08D1849D8
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d1872504cbso967748a34.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083082; x=1778687882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76LMGvx5lD2NmKcq+ZnuBIewfY4ZiFav5aR7pjl1/RQ=;
 b=ayTxbOD6pNZ8n1HcKCuS8bAZ1l1F2XI6uNWeNiLaat4z89qJU/la0ZT1Cwxphm/rw7
 tG2FTqrXVgGrGEcpqEi7MnQFPfptz/qIRpgjC8HvZESqOLhZHb2z+z7NZpyMjHtJH9q0
 PVAMyupBJpLAehv5SU2vlOB7ges1ktJcGcQe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083082; x=1778687882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=76LMGvx5lD2NmKcq+ZnuBIewfY4ZiFav5aR7pjl1/RQ=;
 b=TlYju4/6ACND+ndaEnE/xCxdmV0hT/ann5hMEFtryIClfXp4tFGE2pJG1sjPf4+RkX
 Niq+X1VKfAOlf00WOfhdwdDEu/eOp/XPpQ+YFiNdMUNR+yk9vv7nM9vWMa3lOFElxO1D
 nPSxK1kgU86kY0aHModnDLUuyMhNbw4RTzd9lftGK0Pc7TTDCUL23gwv54N0PQfkOMdd
 /Qh8hEGWUmSarrUlxIFKpaYq+/gwiZqc+IaEosFoqBFA/SwiKpQaOl9H+b+XFdsrSa1W
 gJ6ZftEyT26wYCNaq687S3VfdwRNOtTqw4xJALqXS1c2wcdhHEcTBcffwuZQY+Y+e/dI
 pfMw==
X-Gm-Message-State: AOJu0YwfpFkuIB0V0wjd8Yc5KPeL6hN1pshkTb1b96H6FKcVwAVfyNhg
 iErRtd7WoyXQ0+p5CuvGNe+c9ZmRN/LLjYgRTmTOld9B8I5MF6k8rIHwPzWPAw+SS5iKXcI+VrH
 Pz3glWMzT
X-Gm-Gg: AeBDieuJJoz5HgSBXdX3hj8OIAiwk5MrH/ao1vHkWX9xHtm4nB7QVJQ2RIA0d1B7S0o
 x0CUQT0yPCfFNbObCxU6hxKWVS3IR+1aX9O+HewroAwMJllWNY+qO3xcpPqICBgQJSKKGL+VgRv
 gE170jLTiD8vj7QcPs4me6Ck8NTdr/s7T/QUn46OWENRADGbPYTKl0Foo+a3c887a/+CoCek5em
 PULKXGIpECYgU8bYTCL6wyIiu09HrNRnqqL1tgU9n5vsSojtjrxuKdRShPk5Im3AYtojB4jqYko
 LAp/pLWWqtlWBhs6mQJqbN84Q9ae/fGDdYbGJrnXqfBZxXZa5kFPbldnmWdP7q7axEn35FhWCbX
 GUruAqVnrHhGtDIgNPEmm+5bnQeugQZY+ZnEOsaSkniDonShYuGeBEnvJDMxkUg0kRF+f49nY18
 h7BrYTvAd1/WZz/8h/9JoJsAk+5EZl
X-Received: by 2002:a05:6830:4187:b0:7de:c870:46d4 with SMTP id
 46e09a7af769-7e0b0647e2emr4216043a34.1.1778083081941; 
 Wed, 06 May 2026 08:58:01 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:58:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/10] test: Inline mk_fs() into FsHelper.mk_fs()
Date: Wed,  6 May 2026 09:56:19 -0600
Message-ID: <20260506155639.1191640-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506155639.1191640-1-sjg@chromium.org>
References: <20260506155639.1191640-1-sjg@chromium.org>
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

The module-level mk_fs() function is now only called from
FsHelper.mk_fs() and from the __main__() smoke-test.

Move its body into the method so there is a single entry point for
creating a filesystem image, and update the smoke-test block to use
FsHelper

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 143 +++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 76 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 04cb01fa074..179fbf04dfb 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -63,12 +63,72 @@ class FsHelper:
         self._do_cleanup = False
 
     def mk_fs(self):
-        """Make a new filesystem and copy in the files"""
+        """Make a new filesystem and copy in the files
+
+        Raises:
+            CalledProcessError: if any error occurs when creating the
+                filesystem
+        """
         self.setup()
         self._do_cleanup = True
         src_dir = self.srcdir if os.listdir(self.srcdir) else None
-        self.fs_img = mk_fs(self.config, self.fs_type, self.size_mb << 20,
-                            self.prefix, src_dir, quiet=self.quiet)
+
+        fs_img = os.path.join(self.config.persistent_data_dir,
+                              f'{self.prefix}.{self.fs_type}.img')
+
+        if self.fs_type == 'fat12':
+            mkfs_opt = '-F 12'
+        elif self.fs_type == 'fat16':
+            mkfs_opt = '-F 16'
+        elif self.fs_type == 'fat32':
+            mkfs_opt = '-F 32'
+        else:
+            mkfs_opt = ''
+
+        if self.fs_type == 'exfat':
+            fs_lnxtype = 'exfat'
+        elif re.match('fat', self.fs_type) or self.fs_type == 'fs_generic':
+            fs_lnxtype = 'vfat'
+        else:
+            fs_lnxtype = self.fs_type
+
+        if src_dir:
+            if fs_lnxtype == 'ext4':
+                mkfs_opt = mkfs_opt + ' -d ' + src_dir
+            elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
+                raise ValueError(
+                    f'src_dir not implemented for fs {fs_lnxtype}')
+
+        size = self.size_mb << 20
+        count = (size + SIZE_GRAN - 1) // SIZE_GRAN
+
+        # Some distributions do not add /sbin to the default PATH, where
+        # mkfs lives
+        if '/sbin' not in os.environ['PATH'].split(os.pathsep):
+            os.environ['PATH'] += os.pathsep + '/sbin'
+
+        try:
+            check_call(f'rm -f {fs_img}', shell=True)
+            check_call(f'truncate -s $(( {SIZE_GRAN} * {count} )) {fs_img}',
+                       shell=True)
+            check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
+                       stdout=DEVNULL if self.quiet else None)
+            if self.fs_type == 'ext4':
+                sb_content = check_output(f'tune2fs -l {fs_img}',
+                                          shell=True).decode()
+                if 'metadata_csum' in sb_content:
+                    check_call(f'tune2fs -O ^metadata_csum {fs_img}',
+                               shell=True)
+            elif fs_lnxtype == 'vfat' and src_dir:
+                flags = f"-smpQ{'' if self.quiet else 'v'}"
+                check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
+                           shell=True)
+            elif fs_lnxtype == 'exfat' and src_dir:
+                check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
+            self.fs_img = fs_img
+        except CalledProcessError:
+            call(f'rm -f {fs_img}', shell=True)
+            raise
 
     def setup(self):
         """Set up the srcdir ready to receive files"""
@@ -190,81 +250,12 @@ class DiskHelper:
         self.cleanup()
 
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False):
-    """Create a file system volume
-
-    Args:
-        config (u_boot_config): U-Boot configuration
-        fs_type (str): File system type, e.g. 'ext4'
-        size (int): Size of file system in bytes
-        prefix (str): Prefix string of volume's file name
-        src_dir (str): Root directory to use, or None for none
-        fs_img (str or None): Leaf filename for image, or None to use a
-            default name. The image is always placed under
-            persistent_data_dir.
-        quiet (bool): Suppress non-error output
-
-    Raises:
-        CalledProcessError: if any error occurs when creating the filesystem
-    """
-    if not fs_img:
-        fs_img = f'{prefix}.{fs_type}.img'
-    fs_img = os.path.join(config.persistent_data_dir, fs_img)
-
-    if fs_type == 'fat12':
-        mkfs_opt = '-F 12'
-    elif fs_type == 'fat16':
-        mkfs_opt = '-F 16'
-    elif fs_type == 'fat32':
-        mkfs_opt = '-F 32'
-    else:
-        mkfs_opt = ''
-
-    if fs_type == 'exfat':
-        fs_lnxtype = 'exfat'
-    elif re.match('fat', fs_type) or fs_type == 'fs_generic':
-        fs_lnxtype = 'vfat'
-    else:
-        fs_lnxtype = fs_type
-
-    if src_dir:
-        if fs_lnxtype == 'ext4':
-            mkfs_opt = mkfs_opt + ' -d ' + src_dir
-        elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
-            raise ValueError(f'src_dir not implemented for fs {fs_lnxtype}')
-
-    count = (size + SIZE_GRAN - 1) // SIZE_GRAN
-
-    # Some distributions do not add /sbin to the default PATH, where mkfs lives
-    if '/sbin' not in os.environ["PATH"].split(os.pathsep):
-        os.environ["PATH"] += os.pathsep + '/sbin'
-
-    try:
-        check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'truncate -s $(( {SIZE_GRAN} * {count} )) {fs_img}',
-                   shell=True)
-        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
-                   stdout=DEVNULL if quiet else None)
-        if fs_type == 'ext4':
-            sb_content = check_output(f'tune2fs -l {fs_img}',
-                                      shell=True).decode()
-            if 'metadata_csum' in sb_content:
-                check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
-        elif fs_lnxtype == 'vfat' and src_dir:
-            flags = f"-smpQ{'' if quiet else 'v'}"
-            check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
-                       shell=True)
-        elif fs_lnxtype == 'exfat' and src_dir:
-            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
-        return fs_img
-    except CalledProcessError:
-        call(f'rm -f {fs_img}', shell=True)
-        raise
-
 # Just for trying out
 if __name__ == "__main__":
     import collections
 
-    CNF= collections.namedtuple('config', 'persistent_data_dir')
+    CNF = collections.namedtuple('config', 'persistent_data_dir')
 
-    mk_fs(CNF('.'), 'ext4', 0x1000000, 'pref')
+    fsh = FsHelper(CNF('.'), 'ext4', 16, 'pref')
+    fsh.setup()
+    fsh.mk_fs()
-- 
2.43.0

