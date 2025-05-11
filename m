Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DC7C3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6F582A0A;
	Sun, 11 May 2025 16:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Icm3Tckf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF5FF828BC; Sun, 11 May 2025 16:18:38 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26C782977
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad24b7e0331so83458566b.0
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973116; x=1747577916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkHn3qzuKgEknpnCcwfWQMORiuWUSxqk9HAYlcvI74s=;
 b=Icm3TckfWlD2hrS6kbfAGfDZ8AWB8DgRdIi/kJZyPEo8HanTB7W0Vh7/RoyTA5w2bz
 7vthZf7BAh+B1EBQYSVpM3kBOuluupuvIQx+S5XPqm3rCJGkQMDsLPMdlN36JDka2JZ0
 wpotWtHr+3QCp+E9kkuqq9XJ9VBHrUmcVdlWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973116; x=1747577916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkHn3qzuKgEknpnCcwfWQMORiuWUSxqk9HAYlcvI74s=;
 b=jUW93PxWch98f7UzZXu+FJjPiy02bSJZjyMHoeFI0ClK40i0t8f1NkZENzBu9v6/AD
 HguGINmbuN6F2xyK3yjJvFkqewLhNnu+qYfi+NFC1zZoaWp0MzHL5XpefqVd5QJ/QWWP
 +IcX4jF45sTo9UKN1e6hRNq4HKqSYTpAB4nujMNZvGjyW1JTbNy4mPYTxkVnEsZBLuwh
 aa4pFLWl/kF60dpnvFIHhVfdqijbyVCV2LUJZNpGVTPfHaGONdBKGZoTuZD6+Qcc7PFq
 YxVUBj9F0lE2GkJdVgK3uBLq4TiFVaxNQRao0X1s9n3VTcBsY3JraUXDtPdBTdpwodyQ
 DyLw==
X-Gm-Message-State: AOJu0YzqWHg6xbN9VSY0dWYFRFEy3ZEbIKA9VNtws6kbKuP7au/RriME
 5VAjSPCbXQp0oiRR6Oo+k+AdVa7fHUon9rkXcE28YP35PxUCW+apXpF5BzQW5CMa8kvWTkSFKP/
 g3lB/YKZMog==
X-Gm-Gg: ASbGncu3jQbtTscSEM/OBM48tdnYaJjcZWLoISnzGMVLQEqWh9yk4xv3c0Qgvy/cc4V
 yoEB5gLmEjU6qZ7HM4auFnOKTTSwZFSY6TE0+0z+QjcXwVzD/U/zVz2lvYyrTb5ehG5BhwRdKfQ
 G4IqNSvV4wffJK5l0aCIYLuW23ubPMyFA9EWE05sBKn/mqP+edd1NhpVJmf3ClflFC+rHoDdvEv
 vsi7fZXEjhZdsUWC31RLeowwnNF9fqoq452vQMtaK+k53bCipwB/nZN+ffcMY9fL9ypPZfQFm4s
 7M53kwDuK6xTqv0uftbW5+ONrnibXnD4O81JX6/sOsfIAGA=
X-Google-Smtp-Source: AGHT+IGE8cbAsQbM2I0Cy3G+Mr/N5G8rvcxLTfwKyG9QNSKNhpHWQXzQ/SkjUrt0DQQqSB5TLnDtHw==
X-Received: by 2002:a17:907:60ca:b0:ad2:4fb6:3b93 with SMTP id
 a640c23a62f3a-ad24fb63e30mr171774566b.28.1746973115732; 
 Sun, 11 May 2025 07:18:35 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Richard Weinberger <richard@nod.at>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] test: Update fs_helper to support passing in the image
Date: Sun, 11 May 2025 16:18:16 +0200
Message-ID: <20250511141828.2367318-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141828.2367318-1-sjg@chromium.org>
References: <20250511141828.2367318-1-sjg@chromium.org>
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

This function is useful for other scripts, so add a parameter to specify
the image name, if desired.

Also add a flag to quieten the output of some of the tools, since in
many cases we only want to see warnings / errors.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/fs_helper.py | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index b8a22b22806..d124f03a7dc 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,8 +8,10 @@
 import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import DEVNULL
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
+def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
+          fs_img=None, quiet=False):
     """Create a file system volume
 
     Args:
@@ -19,12 +21,15 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         prefix (str): Prefix string of volume's file name
         src_dir (str): Root directory to use, or None for none
         size_gran (int): Size granularity of file system image in bytes
+        fs_img (str or None): Filename for image, or None to invent one
+        quiet (bool): Suppress non-error output
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
-    fs_img = f'{prefix}.{fs_type}.img'
-    fs_img = os.path.join(config.persistent_data_dir, fs_img)
+    if not fs_img:
+        leaf = f'{prefix}.{fs_type}.img'
+        fs_img = os.path.join(config.persistent_data_dir, leaf)
 
     if fs_type == 'fat12':
         mkfs_opt = '-F 12'
@@ -58,14 +63,17 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         check_call(f'rm -f {fs_img}', shell=True)
         check_call(f'truncate -s $(( {size_gran} * {count} )) {fs_img}',
                    shell=True)
-        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True)
+        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
+                   stdout=DEVNULL if quiet else None)
         if fs_type == 'ext4':
             sb_content = check_output(f'tune2fs -l {fs_img}',
                                       shell=True).decode()
             if 'metadata_csum' in sb_content:
                 check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
         elif fs_lnxtype == 'vfat' and src_dir:
-            check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shell=True)
+            flags = f"-smpQ{'' if quiet else 'v'}"
+            check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
+                       shell=True)
         elif fs_lnxtype == 'exfat' and src_dir:
             check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
         return fs_img
-- 
2.43.0

