Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C90CF2588
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 23:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E754C88C7C;
	Sun, 13 Oct 2024 01:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHefUJWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F6F88DA3; Sun, 13 Oct 2024 01:22:39 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0191888B6D
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 01:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3bd664ebaso2007765ab.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728775355; x=1729380155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qUcSZORqMkgHnK4dIyKtunfQM7FPn4uuLR5cPDv/PCo=;
 b=YHefUJWVD4XktitwjGtS0R0CF1PuP1yFqancBaI4FMa5aHoPXm0SmCH4m/oVQ4V6Qt
 f/op00W/J6sRHhZu0RIVtTtTf63IhrSik2i7eVH2vLSRlgfsXP1XMQJFc+gmHPZ2cPMs
 Ip8DRKZr64E6rPAgTkE8Eu2EX4Ahi5YbWIDB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728775355; x=1729380155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qUcSZORqMkgHnK4dIyKtunfQM7FPn4uuLR5cPDv/PCo=;
 b=vxLoOWk8+JVxCwy28qBtQOfibqpCZzn/bXYrQit7EVOsGVHRMVjl+fr+YAGM1Q26w+
 ov9c5aAoZ4tH0HsvyD5eSM0IYfBWyqVxLdI2WjIukBXb1M+WuHz7hPt+QXfATLGjsdD/
 S7PIeF7OUCy6SLjC5ZNzsSrkUDa/DpZ61ONepyWDOZO7rjLYPW8nB+wsEbRTsnIfBa46
 GWhhYfQQtoDFD32yo/jHv5AfUj7+1Wr/Kkd3q/XSNivTZbf+rbC8ly5fvdswhuMojdWu
 STZo45dqjh5XhaJiGwdMgP0UHx8Y7vfr5t6MLj1Wwj4RUkkiMRoJvnpdun21t0sCdW4B
 O78g==
X-Gm-Message-State: AOJu0YzyhVBJc4QFBabOel+VMGSAvTZjesOnHi0tgDCisK3hcjfYyBsw
 hINhAMRU2hTvnKUafTEooX43NaZ1yt2kJUuav0znJCdnUTCMqDWczylkSxvxGQ0ri75U8GuLgl0
 =
X-Google-Smtp-Source: AGHT+IGK1uWvA/LjWV4T7B3m8MW/QmFjMMA8UQUC6wEYKgPhKOP1zSkbjNljBA1aUY5IrHzdqbaPMw==
X-Received: by 2002:a05:6e02:1c4b:b0:3a3:b3f4:af4c with SMTP id
 e9e14a558f8ab-3a3b5ffd784mr49516235ab.25.1728775355612; 
 Sat, 12 Oct 2024 16:22:35 -0700 (PDT)
Received: from chromium.org ([2607:fb91:7ce:96a:8185:a50b:d0fe:b591])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbada84a35sm1228698173.117.2024.10.12.16.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2024 16:22:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] qconfig: Add an way to select defconfigs without stdin
Date: Sat, 12 Oct 2024 17:22:29 -0600
Message-ID: <20241012232231.5638-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Sometimes it is useful to process just one or two defconfigs and it is
convenient to do this just by listing them in the arguments. Add a -D
option for this.

Update the docs to avoid mentioning boards which have been removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/qconfig.rst |  7 +++++--
 tools/qconfig.py        | 23 +++++++++++++++--------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index a18f32470ca..3b995355967 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -62,10 +62,13 @@ or::
 
    grep -l X86 configs/* | ./tools/qconfig.py -s -d -
 
+or::
+
+   ./tools/qconfig.py -s -D $(grep -l X86 configs/*)
+
 To process CONFIG_CMD_FPGAD only for a subset of configs based on path match::
 
-   ls configs/{hrcon*,iocon*,strider*} | \
-       ./tools/qconfig.py -C CONFIG_CMD_FPGAD -d -
+   ./tools/qconfig.py -C CONFIG_CMD_FPGAD -D configs/{amd_versal2,am68_sk}*
 
 
 Finding boards with particular CONFIG combinations
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 058d72cf4bc..c5a33412c8c 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -125,23 +125,26 @@ def get_matched_defconfig(line):
         pattern = os.path.join('configs', line)
     return glob.glob(pattern) + glob.glob(pattern + '_defconfig')
 
-def get_matched_defconfigs(defconfigs_file):
-    """Get all the defconfig files that match the patterns in a file.
+def get_matched_defconfigs(defconfigs_in):
+    """Get all the defconfig files that match the patterns given.
 
     Args:
-        defconfigs_file (str): File containing a list of defconfigs to process,
-            or '-' to read the list from stdin
+        defconfigs_file (str or list of str): File containing a list of
+            defconfigs to process, or '-' to read the list from stdin, or a
+            list of defconfig names
 
     Returns:
         list of str: A list of paths to defconfig files, with no duplicates
     """
     defconfigs = []
     with ExitStack() as stack:
-        if defconfigs_file == '-':
+        if isinstance(defconfigs_in, list):
+            inf = defconfigs_in
+        elif defconfigs_in == '-':
             inf = sys.stdin
-            defconfigs_file = 'stdin'
+            defconfigs_in = 'stdin'
         else:
-            inf = stack.enter_context(open(defconfigs_file, encoding='utf-8'))
+            inf = stack.enter_context(open(defconfigs_in, encoding='utf-8'))
         for i, line in enumerate(inf):
             line = line.strip()
             if not line:
@@ -150,7 +153,7 @@ def get_matched_defconfigs(defconfigs_file):
                 line = line.split(' ')[0]  # handle 'git log' input
             matched = get_matched_defconfig(line)
             if not matched:
-                print(f"warning: {defconfigs_file}:{i + 1}: no defconfig matched '{line}'",
+                print(f"warning: {defconfigs_in}:{i + 1}: no defconfig matched '{line}'",
                       file=sys.stderr)
 
             defconfigs += matched
@@ -738,6 +741,8 @@ def move_config(args):
 
     if args.defconfigs:
         defconfigs = get_matched_defconfigs(args.defconfigs)
+    elif args.defconfiglist:
+        defconfigs = get_matched_defconfigs(args.defconfiglist)
     else:
         defconfigs = get_all_defconfigs()
 
@@ -1532,6 +1537,8 @@ doc/develop/moveconfig.rst for documentation.'''
                       help='a file containing a list of defconfigs to move, '
                       "one per line (for example 'snow_defconfig') "
                       "or '-' to read from stdin")
+    parser.add_argument('-D', '--defconfiglist', type=str, nargs='*',
+                        help='list of defconfigs to move')
     parser.add_argument('-e', '--exit-on-error', action='store_true',
                       default=False,
                       help='exit immediately on any error')
-- 
2.43.0

