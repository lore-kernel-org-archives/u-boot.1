Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF53FCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04F783F9B;
	Fri,  6 Mar 2026 20:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iHc1hRrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBCF383F86; Fri,  6 Mar 2026 20:08:32 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793B183F9B
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cb4acdacb2so1220417885a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824109; x=1773428909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSwqDgvruMMVwrslz6hjPC0X19dr1CJ8DLWIRit1mwM=;
 b=iHc1hRrqMGltvin2btEpnyPSI06+z8j4AWQCnmqWdt1CW56Z4/Z16iIsrpAbsFF/d6
 Yem2cgyAVx2paX9/EpafqoUj+K5K7jMBIHf5TjGgenDobqHMIHaDgHF+bkXgEnoNnwJk
 BZQspQrLwwbWd6QN53mkqoEuRu5xYs3Oh8Spk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824109; x=1773428909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sSwqDgvruMMVwrslz6hjPC0X19dr1CJ8DLWIRit1mwM=;
 b=on8kGd0mMv+2uGZcxGFbrzp0v/rIbv7VP8WQxL/Rmrs2K5/IDxwQ3f3mGzspMrx0Gt
 WvNX3730Yj9i7zsKuq/uM9LKNFmoxBpK97T1q7LCzPtVczPnh5xc1CIEoDUqRk/PIf+4
 m32NqcIbwh2EqJYJPiqnud5b42nLn8uKvb3JI70riRGP63s/Z4GPycyOOgnmsJLIYNQt
 V51qu0q2hFTHyNI7Ql6mABZRV+fy5zVgFazd6kIt3ZtVL5BEvP8xAHa5PHu2cYnuxeUE
 1ZvPnyq6s6iPSqCcQ+/HIE8stj8Qw6qY7s+O1/h3nZe/y2mNlZfBYLNStdiz+3CiI+Hp
 1+UA==
X-Gm-Message-State: AOJu0Yyg327q5GXBpqekFC2hrh5iXQkKWfUrpCkEsUp+c5s7vMk7ydMg
 AueZZaQz5QTM+gliOGWoXfvh7zxwpLNpu64ZVAsxcD/3Q0k2Pl3kATAW6cpZpLyrPI/xRgCjN6Y
 +rRg=
X-Gm-Gg: ATEYQzz3uHca5+5DIlSjZXkS+txOlnAgm8ljopjzIvEzEHzPEPyohL4g/B1sn8rchxL
 79ChV9zZB/z+fNjxTOsdIob2ZZFCddVKhns7QrxkWTP178cpgyUr0FUCQbUje+qRGW9nY/C7L0a
 5jqJ5h2J+5sYkAZ/ESTS0BDs1cTqvqUrqDUPkprjQwT0tCORXJXnaqKH07rocom3IjZQBQZ/riV
 yIOJS2i7Jmj5axh6LdjFLA+NAndAtrBtlU03YTqZqSiNPtcp8Yw519D9lWD/Gp44wC9uQBSRwzb
 3qeUTdTNkBXcOClSRlX+Bx/UwKHSsMBryAk+d1QF+lU4Pt00oYtzuiJXCoc8jfEgISJu6yoMceB
 YV9TqWq115bGKGJiQbRF1pGfp+OH04PeFwc6VxDNL26LVtPDXj5qGaOyG4/Mp+5LAD0fpPVtsCX
 1Rc7ONmAH7kzAC2u5CuQ==
X-Received: by 2002:a05:620a:4688:b0:8ca:d5cb:6839 with SMTP id
 af79cd13be357-8cd6d4eb0b2mr434044685a.65.1772824108680; 
 Fri, 06 Mar 2026 11:08:28 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 1/7] test: fs_helper: Allow passing the image filename
Date: Fri,  6 Mar 2026 12:08:07 -0700
Message-ID: <20260306190818.3586749-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306190818.3586749-1-sjg@chromium.org>
References: <20260306190818.3586749-1-sjg@chromium.org>
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

The mk_fs() function always generates its own image filename from the
prefix and fs_type. Some callers need to specify a custom leaf name
while still keeping the image under the persistent-data directory.

Add an fs_img parameter that accepts a leaf filename. When provided,
it is joined with persistent_data_dir instead of the default name.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

(no changes since v2)

Changes in v2:
- Split the quiet flag into a separate commit
- Fix fs_img to accept only a leaf name, always under persistent_data_dir

 test/py/tests/fs_helper.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index b8a22b22806..bd9169b2a4d 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -9,7 +9,8 @@ import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
+def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
+          fs_img=None):
     """Create a file system volume
 
     Args:
@@ -19,11 +20,15 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         prefix (str): Prefix string of volume's file name
         src_dir (str): Root directory to use, or None for none
         size_gran (int): Size granularity of file system image in bytes
+        fs_img (str or None): Leaf filename for image, or None to use a
+            default name. The image is always placed under
+            persistent_data_dir.
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
-    fs_img = f'{prefix}.{fs_type}.img'
+    if not fs_img:
+        fs_img = f'{prefix}.{fs_type}.img'
     fs_img = os.path.join(config.persistent_data_dir, fs_img)
 
     if fs_type == 'fat12':
-- 
2.43.0

