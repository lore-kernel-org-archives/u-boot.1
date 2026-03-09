Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71568F41808
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F322B83FDE;
	Mon,  9 Mar 2026 16:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mK6v/rgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A96783BC7; Mon,  9 Mar 2026 16:13:50 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BCA83F9B
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50905b779dfso24672741cf.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773069207; x=1773674007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WvjNSoWKwYDtdAnyuw3U1MtS7S9LyaNosylbi9IRtA=;
 b=mK6v/rgW7gk58tJ3EQM6SCtTvMtnzG+EVtBNcr2fCQQbdT+AbU4cvI0DKxKxXk6STs
 TKEtcZaJPh9npipAlyMyeDiNLp7zzGU87G42R+Sj5dn/nY0PI0S0hOPULovd0novWq/c
 gE/m1FmWE3FoZIKecTlY2Nh/NHVt3k0T5oaJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069207; x=1773674007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8WvjNSoWKwYDtdAnyuw3U1MtS7S9LyaNosylbi9IRtA=;
 b=S9zgdJ+0s+mgh1V1PUmrcsdtz2egA5WgO9cd/o++2UX6KKhwCGUC00oWXCvZczrrTH
 wJsc+YtB1FOaM5WG4MEaZrOun+3tNigTCgEmDVFc4N3A8/S/ukxrjkfq/QC2xtl4LdTK
 QIZmXnq2IkSSKeLc6WIvL4Wd7Q+brkdpI50IKpYpIvcFKW1+jv5TTWFLDoeQh72bUcwS
 hB/1mqyBEwr7xOilxUslBQVAdBgTjf89v+X3s3oU67Bz310K1H83jWDSMA4SK2J9Ee1x
 vsWryGlh6HPsyzpvVkZhw5wSfPUeKwzDUHt/Zse+bvMmMEYZNb6E9lM01P4jPP1FU+U3
 3Eyw==
X-Gm-Message-State: AOJu0YwRjEdCVUqNG2FFm/ZNoYFahYDP6+eBgbZZJ02ecr4ttGGeovHJ
 rHxPGFwP616g3zhJo0Czc8rMpsg6B8Gvx2Ly+IR2HSBc7N4rxaW9+9PWFcu9fGG9lQH8Q0KLys0
 n6Dg=
X-Gm-Gg: ATEYQzwTkJvNWnkiOMd/6MzsTpLgl0zvJ4DK8iPujw3BM5qJ+Vt8ZrqqNTZKHum9Yst
 kP2mHbgQp2RP6TmW9/8QWmSR15Ibtvxcv6Z7g9vLycHgAp4KrR1Yl4M+5VgU2aYRcahXcbWb0dN
 lewXIS+QXYDFSuHP8iG5B5s1REOzHyFi0FkXbWbT8Lm1zBFs+AzErURm8gJztCNDbXFjwX3pbs6
 Pd2fDefebfbmEb7uIxEboTkU0QKamhE6nByNYQUSdAKpqoLNsjGPXJDYJi5iufRKMMoWTUCkbl3
 YJeWC7ECaxCyMzKM3RLpkx/mlHDJhZRPscAsKhl8cbaS7Fxw4QzczZ7dRcbkmUZ5QWU0rQMnjdm
 cllkVSk3HN3GIK81EijsWy/1LtR2Y+RzHqHnoe7HMksqwSvOaLx/SD+O/vLlORTXakCus/6oxFv
 YCqqUdjPuJw0koC6O5ag==
X-Received: by 2002:a05:622a:10d:b0:4f3:565b:c52c with SMTP id
 d75a77b69052e-508f493b52cmr159847321cf.39.1773069207438; 
 Mon, 09 Mar 2026 08:13:27 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a7dec85sm19337291cf.32.2026.03.09.08.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:13:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 4/5] test: fs_helper: Drop the size_gran argument
Date: Mon,  9 Mar 2026 09:13:03 -0600
Message-ID: <20260309151307.831537-5-sjg@chromium.org>
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

