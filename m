Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D78FFCC065
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1508283FE9;
	Fri,  6 Mar 2026 20:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K2jQYclO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D7483FE9; Fri,  6 Mar 2026 20:08:34 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601B283F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8cb3825b0fbso938530085a.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824111; x=1773428911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPRHd1A5vqwXzXB8uCcbDwYf3Q7C2uG4pC/6y2d1Zf0=;
 b=K2jQYclOUlUua4t0O3FTtY3PQ6+2RGA/0g2MhFm/cqSms+EY1Fcttg7cCRAwX4y/Zc
 yIYP1G7kBsjSKmCYbTl7Sm6s+MXzWg/9tR5XuyFKQsXRV0KINdR19Dyh/7D3wcg3pIPO
 eEyT4Ns0vZdvq5M5wG8CQkfkG8yhS1fVqo2YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824111; x=1773428911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kPRHd1A5vqwXzXB8uCcbDwYf3Q7C2uG4pC/6y2d1Zf0=;
 b=JGT6A6jSHUTjF0Zb53GhkoCGjxzBSJY5KaPgPilF4XQ5NxXkWf/wCuQBAi8Q1QQOdL
 j8TZrp3rBp3uQyyOME6SOu/KRsUzAz1ZXOV/ympFzgKy5U73H3KEFotd80kfeVkEbAQm
 oy0gwXe/Nd28F1fKZR9GDuBd5Ct7rxb54c4XlfXqIn+lnWZjIgTPNUtgSH8dPtEFbnBn
 KqLTaFtWKkdy2swwU82iejc1OZfWoSp4PqdnejiGkfEhxTrtaMjuQkjge/2RC+RO1NGm
 Z/8L5r6NwdZJHaRNTpsC6Vi+E5XshOxT8DKaIeScT1fc31p1D5jrEgXFn9seGABpg+WE
 etVA==
X-Gm-Message-State: AOJu0YzvAQj+NmtF+U3E2TsxLwj69ujmuff9TzgLcvQUYf3aSgdHOjEJ
 MQ4HjDPjmacqVST7ifiUywluUDgxpHBSNK4p42U2xPQEr5bPh/Tn+EeTTY8GltA6Mujo6FFftTC
 54zU=
X-Gm-Gg: ATEYQzzsgJRYdoAcVmjyKtwCbkP0IV9QUPE/iwWuUJjN75fQ5wky5iMwfCFqUWtggz7
 LqE38b8UiLJFi5KNx+oRvoWYHYIKfT2otxpW3BT0vv0ai5ShL1D/PZFVeLM6mdCgeLle3Uj4pQn
 OVp4ocqF/Sci9amTbTikS6t5GoRAD9/EgkbCEsCJoemzdTQ4Rxh/tmZvgGWhhCiQ6yw+yWKgiv0
 JWBbhe08XuTANrV8Bn/Tjw0riw/YX7b0QPd+C0KZcGcs1Sfk8YUvA5uV35U1DAz9Rt1u5S5TA+5
 HfT2R8xHAmgjmgaRZit7axDdoX01jm2v+nyk3W06Faua6T+4yA6MRsQxBRNbYl4N4KRRfFanDkz
 CPijEImdxq5qkolUoZg/vaUb/G+ghvr1jQaAvnGh9xeb+S0euhSx7mLHZ/CBWEpSZPhexrva3N0
 WjJ6WnQGl+Lvc9Gp9rcg==
X-Received: by 2002:a05:620a:4505:b0:8c8:753a:7d9 with SMTP id
 af79cd13be357-8cd6d514548mr432798485a.66.1772824110572; 
 Fri, 06 Mar 2026 11:08:30 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 2/7] test: fs_helper: Add a quiet flag to mk_fs()
Date: Fri,  6 Mar 2026 12:08:08 -0700
Message-ID: <20260306190818.3586749-3-sjg@chromium.org>
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

In many cases callers only want to see warnings and errors from the
filesystem-creation tools, not their normal output.

Add a quiet parameter to mk_fs() that suppresses the output of mkfs
and switches mcopy from verbose to quiet mode.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add new patch to split the quiet flag out of the previous patch

 test/py/tests/fs_helper.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index bd9169b2a4d..4b123ab0afd 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -8,9 +8,10 @@
 import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
+from subprocess import DEVNULL
 
 def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
-          fs_img=None):
+          fs_img=None, quiet=False):
     """Create a file system volume
 
     Args:
@@ -23,6 +24,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
         fs_img (str or None): Leaf filename for image, or None to use a
             default name. The image is always placed under
             persistent_data_dir.
+        quiet (bool): Suppress non-error output
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
@@ -63,14 +65,17 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
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

