Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDA8FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A1283F39;
	Sat, 28 Feb 2026 19:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B7YaYnHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C1283CDF; Sat, 28 Feb 2026 19:23:32 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC4683F2D
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-899ee491af3so1967376d6.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303008; x=1772907808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqRBRhuTrQNzxSNFkExxNBJqVl5SIf0PVIBQrpckXic=;
 b=B7YaYnHcqLNCNaUzZBx845ksG8RlkJfEUUo7csnOJaQnJzPBB1TDi9at+34EralmDv
 /WAA9CUh7BrZSnfoofMCh0hs7ebU9MPrJ+J4049VK0MIi0fZ4qlYrxeMfL3wN8nvAvLW
 fsMY/mjGGJOqV9rCGE8/SV7t6xHZxqtVgmEQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303008; x=1772907808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aqRBRhuTrQNzxSNFkExxNBJqVl5SIf0PVIBQrpckXic=;
 b=BYp+S1lToEQd3ZPqoyf7R7r08Q/WsT5oU6sCnz63re+UC9oR4XfsjtZqy8a6G4O+Xq
 Qr+Orjj5OjJevIfJvKoCYVaQCgkPW8+URiJGo6t96sOOysEZwzadTrUU2V+y3oVhdoXL
 lYE6XMP1f+nGHhMM7xWpKtSfs6wiXO8ZnWj5X60jidj4yK8lyetrP56hw5s1O6fXiLEo
 sWSF1SWb+XpMWVzJRnjrLontanulI4lfC3TM0fBcdkMovKb6rdFL4X2doGXaw5QWlhoy
 6d7FW3O1aC4SYL7+eAAlrAnOSFrTQjbetTb0ANxj7Y/6DkZVjnsq5n1xlxg7ap7ifCcA
 +y1Q==
X-Gm-Message-State: AOJu0YwlWsPGzDO7H+AvX3TTo/dbZrL4G7iVBs1Hp0iIhkJQ866fTkpj
 996gFiNd9IYOW9G5hLRVZGwNZS+LwzY/0flXgtqTCUR03BZdNPMlJzd6A2COTLqIYe1aRPGfnFZ
 Ar8I=
X-Gm-Gg: ATEYQzy1WzsB+nC3pi4+XIIHooq0FWAIAeHROB6icKmRJn8IMwYo8JTvwNUkb3cEY3Z
 X324oPLX3z9LVbo3grPUFAKMfKTRMh5E6KoTLxY9BhT6s3OAyiZKIa4Vfn7yJowXUdQe07E2ZpW
 FKyvH6sxEHUUOXlsF9rubIxfz7HT29OKy7MFOhRGCUK4C41No+CszDxJiAmO1hp4UnGBv+2MpSV
 ka8HAN0jywiQxqGLYzJ1vIMpN+MuvDPrOM/yT7c0vAnMcgmk3FXflRYCPqQKmSuvxO4sxWqs9w7
 bnBw/Laga3H9HDGwQHxPM5yb61eEovttFM5CccGKQF17I9fiA6EbCpKueJc+Fzth2TGGawmnatq
 9pgAPW9f9IcYweUUeN2IB/930vwf4vaxljzxJoHtXuK9Crj3u0wUn3iH3x8NCAsTwZH41IxM78+
 zRORsbUGG0i78Cj7yy5w==
X-Received: by 2002:ac8:5d10:0:b0:506:bb47:cd0a with SMTP id
 d75a77b69052e-507529dc2f9mr83196881cf.57.1772303008070; 
 Sat, 28 Feb 2026 10:23:28 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 4/7] test: fs_helper: Drop the size_gran argument
Date: Sat, 28 Feb 2026 11:22:44 -0700
Message-ID: <20260228182304.3728735-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228182304.3728735-1-sjg@chromium.org>
References: <20260228182304.3728735-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Christian Taedcke <christian.taedcke@weidmueller.com>

---

Changes in v2:
- Split the pylint fix into a separate commit

 test/py/tests/fs_helper.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 47340295fbb..72e18588288 100644
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
         fs_img (str or None): Leaf filename for image, or None to use a
             default name. The image is always placed under
             persistent_data_dir.
@@ -55,7 +57,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
         elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
             raise ValueError(f'src_dir not implemented for fs {fs_lnxtype}')
 
-    count = (size + size_gran - 1) // size_gran
+    count = (size + SIZE_GRAN - 1) // SIZE_GRAN
 
     # Some distributions do not add /sbin to the default PATH, where mkfs lives
     if '/sbin' not in os.environ["PATH"].split(os.pathsep):
@@ -63,7 +65,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
 
     try:
         check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'truncate -s $(( {size_gran} * {count} )) {fs_img}',
+        check_call(f'truncate -s $(( {SIZE_GRAN} * {count} )) {fs_img}',
                    shell=True)
         check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
                    stdout=DEVNULL if quiet else None)
-- 
2.43.0

