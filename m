Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C538FCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DA483F2D;
	Fri,  6 Mar 2026 20:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LaQLqRjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900038401F; Fri,  6 Mar 2026 20:08:38 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED27F83F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cb4acdacb2so1220430885a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824114; x=1773428914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WvjNSoWKwYDtdAnyuw3U1MtS7S9LyaNosylbi9IRtA=;
 b=LaQLqRjBJ5z9ONE7I9dcMXTBU82xx7xEoL7Bv5ivMNHWuYAd5WStmAgHSK9CTeZDJv
 f/WmijhJn8j97moGkI2jVYC+/sP3fj7TUHyCFuarLPVDKSeEVtcziPIBGzZPBYibHkJJ
 dcsyF+8F65NcqSGgepXhyIMYm9DcVLYChoH7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824114; x=1773428914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8WvjNSoWKwYDtdAnyuw3U1MtS7S9LyaNosylbi9IRtA=;
 b=KIBAB8acyHttkReZEvWg+PHNOuadfu12ab6Cz/90kdgoA9I+egaHyD1ghSmRKIn5b/
 mdslc9xvVuO06YpsHQxJREHxU5qjGU3eoJgPM4G8BwnbBvL25osUt2XIiXUY6pH6wOM9
 hf7ylGmkqMZIN3f/B+jAUveqlt8bjLh3kyf6yCrEleRNIrMwhHYjgqOhp28AmP8E3Los
 TeUN6BjNePShJ0jaZkyZ7I+aSmeaWKMNsnNSADFDH78i4HCGJrmA/2+Z6KVWu2bQBMBE
 O72vbKP0SRyieIYYoB7UrhPglznEtIkHFyKZKH6LISmsk+NGoxFkQWke3F31MjjiZSDI
 jSPA==
X-Gm-Message-State: AOJu0YwOji9xPiXU8EL0i5R5mBGFbvfkcG86hoctjkC0nV1H0GloQnxW
 0St/uTB2Z2hcwswRanFaljwwOnvHc5KwJyR6fm3Z4mlTyk5CGaLtc8gdWR2y9PDhlm3ssIWZFY1
 6lV4=
X-Gm-Gg: ATEYQzyrfSbfDW7K7Vvq02A0/QqzinL2UdoJhNM33ws51fhnbh11p9t2qrZuYy1dQIC
 8DwebUePaQvEnBGXtnFgtbUbY0aVuLyK2DQDuGYfDISjZOzpV18/4jOlZczic2bKMGrCMy8lTQ9
 LDNjQaYfS2Jjr1rSThUsMZgW7Y9Hd6A1fr6IMexz0k7L8FxkOfFK4stuVznI0YhIl8A6+VHkVj9
 kURdrcuJz7XpSC+YMPx0StXusvodoCC4FKjACxybxo4UHD8sSQ2FUwFYbw16vV4i+y6Ta36ezEP
 xsWhi+VvS+aJ/KAP3A31mNmBVyudyF2b6XRUoSXceLOSnYitrWy72OWk1d3zkXRxXtmXEy/GP1m
 51uCz8Y6JqZcSFkgEU5WbsoCnujW70zLdkvtfe6Ew4tgC6T0kkFXF8ziN8xappbNMdpBgBYHqP/
 ZB9iupuhzYQBJpVCalNQ==
X-Received: by 2002:a05:620a:f05:b0:8ca:2e37:ad08 with SMTP id
 af79cd13be357-8cd6d4334ccmr404987685a.34.1772824114228; 
 Fri, 06 Mar 2026 11:08:34 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 4/7] test: fs_helper: Drop the size_gran argument
Date: Fri,  6 Mar 2026 12:08:10 -0700
Message-ID: <20260306190818.3586749-5-sjg@chromium.org>
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

Nothing uses this argument, so make it a constant for now.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Christian Taedcke <christian.taedcke@weidmueller.com>

---

(no changes since v2)

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

