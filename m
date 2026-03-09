Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7B2F41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC81683FB2;
	Mon,  9 Mar 2026 16:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oRNeE7lX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6377B83F9A; Mon,  9 Mar 2026 16:13:25 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447B583F53
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso103004341cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773069201; x=1773674001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSwqDgvruMMVwrslz6hjPC0X19dr1CJ8DLWIRit1mwM=;
 b=oRNeE7lXCi9erxzagZdYjOlV5tbMd3i6ZMFU2Ko0E7eF2IqFzXttxvyKuLKOZn4IN8
 HeK5iPiqkAw1B+ABGI05zQM4xjUyF925RUgcvPx30SlujRmphWCsCTUUhqzYxGGE1H9L
 CWxQCSmW42l/wp7GknIFotcb53EoOHSHZCHtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069201; x=1773674001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sSwqDgvruMMVwrslz6hjPC0X19dr1CJ8DLWIRit1mwM=;
 b=qLpG04Y+QuMiEims420JDqc74YWa/HF3QB21Aqa/D8DLog33C4bdDksGnTPuTI5bJq
 El3183lOBOMoqSLz+T4FScKOi0XrQT+ZvgT3XpTtpa5ZrjoaesTDBnBv+g8a5oy6a3Ve
 HysyVObW6lBdHI2o9eGO8Dwgodsj9JNdKx50sPyY+8wrgdsntvDv7EG1QC1eloTlINGH
 akwF+4r/owMuIaKWl5hyS37jwwHxi4kw+bBOdEbDVXQO68pFakt66fppVlQtZBIbKDF/
 IDMEtsidp8e7Hl6qPOLGkQnVrGyyYFog5YbhF/v4fGduDC5gLVgw1B+2tPiGW2n0NSPP
 O3gA==
X-Gm-Message-State: AOJu0Yyp+367nOHENw5YOE6rHwIluxG2h8HSEfM2wp5giHePZjRcPllM
 Bdrhvwa3qpCTs7gSrW8o0JkjD7CqnHy8nif5wQOIOuHioLnfY5tBv8ucN3qZqrzVNubH57N1FPQ
 D5OM=
X-Gm-Gg: ATEYQzy3sy/N3K3PSXlfQeK4VT4LZ8FGuZxUvXLSALQluUGCy5JiNNDtWxo/gT2VHVy
 1Vaghdlnzrxhbq0afu39dmM5VmiqhTL/QlXmRzImcNChrgc2njI+4FKpAPyD4XTzfA1/v0b7/f2
 UmDZMgNk2hKdm0exph5rjIyul1XONht4bSl2r7cIhqH7PTHk90TZOTtQ46KMV5raMKOR/a0Sbg5
 M6ADeJBI15W1HuFD/Ht4AUKFmIvtey/d5tjRsL+hc2+NuTzLX1/Qjy/h9yYhVosnQf8V9TRaK7c
 hE09OG6+B8OQCObraEyoDjqz1BP6+K6LUIQgX7f3R8M6dcKPPzYMaXzwmAnV1UlyJFi9sHDRucb
 rIYO1Uu5tYVVhCG+GbA3aYmpfsYIHnQPJax0FpC6S+RMzPl6C3ZDKhyOigQsC+4aZWHKRge0PP2
 1cMlAeDVkcMKFO8wIhLQ==
X-Received: by 2002:ac8:5ac6:0:b0:509:1cf9:ea15 with SMTP id
 d75a77b69052e-5091cf9f029mr32791191cf.56.1773069201422; 
 Mon, 09 Mar 2026 08:13:21 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a7dec85sm19337291cf.32.2026.03.09.08.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:13:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 1/5] test: fs_helper: Allow passing the image filename
Date: Mon,  9 Mar 2026 09:13:00 -0600
Message-ID: <20260309151307.831537-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151307.831537-1-sjg@chromium.org>
References: <20260309151307.831537-1-sjg@chromium.org>
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

