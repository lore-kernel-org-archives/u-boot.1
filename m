Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D7FD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868C884180;
	Wed, 25 Feb 2026 17:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JKc7K5Jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCA18419A; Wed, 25 Feb 2026 17:25:24 +0100 (CET)
Received: from mail-ot1-x32c.google.com (unknown [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A3584179
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso6441360a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772036668; x=1772641468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JP873GWmBvsqEQrgR6VU9gl7X7BolhunxjNnlLfh6i8=;
 b=JKc7K5JbSqWSDHpsTakgog7MRZgFOfoTB9PvA1/XDdgJYcdJZuICUZcICLpvmhhyQT
 YNapJP7pBojjkYqjEbntnJVSM9cQx2VNthSzmotOE3AqbVPhlUHX6R0gItzkcCfir8J8
 jCKQsoecPVP2MEtboG8VNOGnjkPYkvAPA5NIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036668; x=1772641468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JP873GWmBvsqEQrgR6VU9gl7X7BolhunxjNnlLfh6i8=;
 b=ThCK/ZrioqgGCuGdmcPDHA8HCYvsXmfAeNCVK8OB/r71fPqjZIBm2uyOFWJhwnB4ov
 nJ+kqHrJ4gg1OXaRDl/eVtSsyjHtNopBMihjxgmHkJfW0JLjSCdqu63j7KhPPz6CwaqM
 cExwdZDHFXb80D7JjC8N4AjA5p+mURGmLshhlAFM7tb4qqvMKzVLwoLKztdQPFYVsO2z
 InW9dnUtm2uKtuuGO1sPLNniZtrjqJwSjAGSq8HYj2qLScnUTtxJNy0JMWCPuRboqwJw
 ySuFUTFUpGPOJLu36J8rO5FCJrvviFkZ+ij0I3WxtkELl3+jkKKAeR+VVC36nVBlolWP
 Y/Jg==
X-Gm-Message-State: AOJu0YxhVXV5mi5SAY3U3lqobO73agCM4s4MOdjmvuJ3fbMrRDL/h7kA
 NRNeIY4b7EDQqqH4WRV5/aoFuLl1/CqksdHWs99BEhJYxHmD6TTRIeGLOSxnUk0cuZteiOp+Bc+
 rNTc=
X-Gm-Gg: ATEYQzwJATFhBwQ7HMSeOAxPmZSwrTB+LI02erUgvxpDhsL00NPE9ZSZvVp7tke93A9
 1HQuIWdSKfpy+pUjoGYE1nulPe53fFMkKv0StysjQ8fH6eeG/+VDjmCvosr/Jt+PsSRjLJcSbZV
 G9zfP5rR/Z3wUCcsVjxuem9zfxj52mdD9pkQMrcuCZScI5nuDdvJHw44XqjRjgRe57i8AmL3JCR
 qGdMk/PxGbsZjHorRLCjWE9KvUFeRg6pmJLPb6Vc/23WzPQVrFoCKqMDZo72GnsTKCju2XXOT5M
 cxK5+40Tz2KGLWB2YCihcoyieu6p9u6iN3pkCyg0Bs+KaU50n9RJEInxWYeEhWS8oVxxVoqnJTS
 GynyczBeVSLqidtOvKAAxmDgob9hrdvHnDsEj1VrDZB3ZURonCv7Tpyx8TS1ovPUT1b2HNdAp1i
 ppHWLj3t2Jrichp2j7qrgoqOjqxxfd
X-Received: by 2002:a05:6830:6d09:b0:7d1:9217:94e with SMTP id
 46e09a7af769-7d582a8a148mr473441a34.26.1772036667786; 
 Wed, 25 Feb 2026 08:24:27 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH 3/6] test: fs_helper: Drop the size_gran argument
Date: Wed, 25 Feb 2026 09:23:47 -0700
Message-ID: <20260225162357.3449937-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225162357.3449937-1-sjg@chromium.org>
References: <20260225162357.3449937-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Nothing uses this argument, so make it a constant for now.

Also fix a pylint warning when checking for vfat/exfat.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 test/py/tests/fs_helper.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index aedf6af0aeb..6649aa7bc47 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -10,8 +10,11 @@ import os
 from subprocess import call, check_call, check_output, CalledProcessError
 from subprocess import DEVNULL
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
-          fs_img=None, quiet=False):
+# size_gran (int): Size granularity of file system image in bytes
+SIZE_GRAN = 1 << 20
+
+
+def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False):
     """Create a file system volume
 
     Args:
@@ -20,7 +23,6 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
         size (int): Size of file system in bytes
         prefix (str): Prefix string of volume's file name
         src_dir (str): Root directory to use, or None for none
-        size_gran (int): Size granularity of file system image in bytes
         fs_img (str or None): Filename for image, or None to invent one
         quiet (bool): Suppress non-error output
 
@@ -50,10 +52,10 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
     if src_dir:
         if fs_lnxtype == 'ext4':
             mkfs_opt = mkfs_opt + ' -d ' + src_dir
-        elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
+        elif fs_lnxtype not in ('vfat', 'exfat'):
             raise ValueError(f'src_dir not implemented for fs {fs_lnxtype}')
 
-    count = (size + size_gran - 1) // size_gran
+    count = (size + SIZE_GRAN - 1) // SIZE_GRAN
 
     # Some distributions do not add /sbin to the default PATH, where mkfs lives
     if '/sbin' not in os.environ["PATH"].split(os.pathsep):
@@ -61,7 +63,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
 
     try:
         check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'truncate -s $(( {size_gran} * {count} )) {fs_img}',
+        check_call(f'truncate -s $(( {SIZE_GRAN} * {count} )) {fs_img}',
                    shell=True)
         check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
                    stdout=DEVNULL if quiet else None)
-- 
2.43.0

