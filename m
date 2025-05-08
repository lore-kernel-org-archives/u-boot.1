Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC204C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0BF982A5E;
	Thu,  8 May 2025 09:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NzxsDkq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B23482A8C; Thu,  8 May 2025 09:29:42 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF5F82A39
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3a0b646eff7so543339f8f.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689378; x=1747294178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfDdQruzpHD/PdqDcrQaMTKnCfU5lEBPmEgTUWhbaRc=;
 b=NzxsDkq0a39/apC8hwZIx7K1SaeWhijWDcMnl457s4uFDV9y0hPlhgYvGg6pvRH2Ps
 bBlJ2FrltMsZy3BOa3lMpfMl6aOe3pDnWMKG8nrS98+itflGtuC1sflwg8k83LGhW9g4
 wy3v9ZV7yW1fP34CCAqeKTUKWbZ+0cIx4gNCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689378; x=1747294178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfDdQruzpHD/PdqDcrQaMTKnCfU5lEBPmEgTUWhbaRc=;
 b=nIWnPLCO6a8VVLDf/e8SvjwDi5KeMW6FvSyl4vGKEm8SlNZbKdQNfq12QnDpprTfYt
 gLNA2r01bC/fhTPhy5xb5Drb4qIkdaxw4XXXhknqZZ7Etk+XDNtrVV6d1KvAmzsVoYWj
 8b+aAH2oipyEP99YAVDFzMdQMCKMcgaWBnx8ewMEESvF6YRbQJcqWK+B3NXNObOjRnRt
 64Qc8cSKCnk0uWuWsWoCHf/gL/hZFQvQB/KCS36iqNGJkp6UUpsOSbdLiE/FUqnPjMkc
 Mcyb9cnthtlvhMZjOidK4BKYrtqpEOy9Ik2lf7JPnBMrZThLqeEKGtXdTm3I9+I+1xKT
 /EEw==
X-Gm-Message-State: AOJu0YwwS4KoEfJ+vCZE4HxTouy85uWdUN45pU4r1KvKdARsAROBfM5H
 3/1jKLe/fSCAM/AAheHhkAzzduX/ErONmgCuUhLaQ2/me/pv3AsoP7soTpGqY1tWd986wAdFUtM
 uWn1k8lz1AA8x
X-Gm-Gg: ASbGnctfquzJsrby8JHe2JfbJI6LwGO9M5X9Ordv2/fXEwBiMt1aT6gCrvG4kvs+Ulm
 mqlLxD/NDDRqPzLH8kl3tC3a4q/6YYxHmY7DNbZOL+azfMUzIPSFl92naPH439RtUMGZbe3EQZk
 K5evck7m/ddHwARIDCEQSa71LKq2LEMBZe6j90jNV8jL/wBgmhEh2PCu3ds1kwzXMhfCTadc1Pc
 3VNe4CHKP3hBoo0MfZO6qGg1ElYftix2cHbCiwMh8qgkrG9oQPkF4J7ctcB1/tgY9nBRWX0g4vH
 yiM5pyRA40wWoEswYLg5Hyp5upB7GgfQcUYNbA==
X-Google-Smtp-Source: AGHT+IEQ2UKGwtNsD4bdVwimfidKXk2hGq8mzonVhdzQfw7qr9UYi1+uovKE3XgjAuPSqnVPmw+tsg==
X-Received: by 2002:a5d:64c9:0:b0:3a0:831c:e7e5 with SMTP id
 ffacd0b85a97d-3a0b4a188c7mr4631139f8f.20.1746689378191; 
 Thu, 08 May 2025 00:29:38 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/20] patman: Correct some pylint and asyncio issues
Date: Thu,  8 May 2025 09:28:37 +0200
Message-ID: <20250508072907.207175-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Correct some pylint warnings in this file. Make use of the existing
asyncio event loop, instead of creating a new one, since this also
destroys it afterwards, making it unavailable for tests which want to
share an event loop. Use tools.write_file() to avoid a warning about
encoding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 51 ++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index d055a7e5952..9f3ab50fa4e 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -16,6 +16,11 @@ import sys
 import tempfile
 import unittest
 
+import pygit2
+
+from u_boot_pylib import gitutil
+from u_boot_pylib import terminal
+from u_boot_pylib import tools
 
 from patman.commit import Commit
 from patman import control
@@ -24,12 +29,6 @@ from patman.patchstream import PatchStream
 from patman import patchwork
 from patman import send
 from patman.series import Series
-from patman import settings
-from u_boot_pylib import gitutil
-from u_boot_pylib import terminal
-from u_boot_pylib import tools
-
-import pygit2
 from patman import status
 
 PATMAN_DIR = pathlib.Path(__file__).parent
@@ -278,7 +277,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual('', next(itr))
         self.assertIn('Send a total of %d patches' % count, next(itr))
         prev = next(itr)
-        for i, commit in enumerate(series.commits):
+        for i in range(len(series.commits)):
             self.assertEqual('   %s' % args[i], prev)
             while True:
                 prev = next(itr)
@@ -389,7 +388,8 @@ Changes in v2:
     def test_base_commit(self):
         """Test adding a base commit with no cover letter"""
         orig_text = self._get_text('test01.txt')
-        pos = orig_text.index('commit 5ab48490f03051875ab13d288a4bf32b507d76fd')
+        pos = orig_text.index(
+            'commit 5ab48490f03051875ab13d288a4bf32b507d76fd')
         text = orig_text[:pos]
         series = patchstream.get_metadata_for_test(text)
         series.base_commit = Commit('1a44532')
@@ -582,7 +582,7 @@ complicated as possible''')
             # Check that it can detect a different branch
             self.assertEqual(3, gitutil.count_commits_to_branch('second'))
             with terminal.capture() as _:
-                series, cover_fname, patch_files = send.prepare_patches(
+                _, cover_fname, patch_files = send.prepare_patches(
                     col, branch='second', count=-1, start=0, end=0,
                     ignore_binary=False, signoff=True)
             self.assertIsNotNone(cover_fname)
@@ -629,14 +629,13 @@ complicated as possible''')
             tools.run('git', 'branch', '--set-upstream-to=upstream')
 
             # Setup patman configuration.
-            with open('.patman', 'w', buffering=1) as f:
-                f.write('[settings]\n'
-                        'get_maintainer_script: dummy-script.sh\n'
-                        'check_patch: False\n'
-                        'add_maintainers: True\n')
-            with open('dummy-script.sh', 'w', buffering=1) as f:
-                f.write('#!/usr/bin/env python\n'
-                        'print("hello@there.com")\n')
+            tools.write_file('.patman', '[settings]\n'
+                             'get_maintainer_script: dummy-script.sh\n'
+                             'check_patch: False\n'
+                             'add_maintainers: True\n', binary=False)
+            tools.write_file('dummy-script.sh',
+                             '#!/usr/bin/env python\n'
+                             'print("hello@there.com")\n', binary=False)
             os.chmod('dummy-script.sh', 0x555)
             tools.run('git', 'add', '.')
             tools.run('git', 'commit', '-m', 'new commit')
@@ -669,7 +668,7 @@ Tested-by: %s
 Serie-version: 2
 '''
         with self.assertRaises(ValueError) as exc:
-            pstrm = PatchStream.process_text(text)
+            PatchStream.process_text(text)
         self.assertEqual("Line 3: Invalid tag = 'Serie-version: 2'",
                          str(exc.exception))
 
@@ -747,9 +746,9 @@ index c072e54..942244f 100644
 --- a/lib/fdtdec.c
 +++ b/lib/fdtdec.c
 @@ -1200,7 +1200,8 @@ int fdtdec_setup_mem_size_base(void)
- 	}
+ \t}
 
- 	gd->ram_size = (phys_size_t)(res.end - res.start + 1);
+ \tgd->ram_size = (phys_size_t)(res.end - res.start + 1);
 -	debug("%s: Initial DRAM size %llx\n", __func__, (u64)gd->ram_size);
 +	debug("%s: Initial DRAM size %llx\n", __func__,
 +	      (unsigned long long)gd->ram_size);
@@ -807,7 +806,8 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         """Test Patchwork patches not matching the series"""
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
         with terminal.capture() as (_, err):
-            patches = asyncio.run(status.check_status(1234, pwork))
+            loop = asyncio.get_event_loop()
+            patches = loop.run_until_complete(status.check_status(1234, pwork))
             status.check_patch_count(0, len(patches))
         self.assertIn('Warning: Patchwork reports 1 patches, series has 0',
                       err.getvalue())
@@ -815,7 +815,8 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
     def test_status_read_patch(self):
         """Test handling a single patch in Patchwork"""
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
-        patches = asyncio.run(status.check_status(1234, pwork))
+        loop = asyncio.get_event_loop()
+        patches = loop.run_until_complete(status.check_status(1234, pwork))
         self.assertEqual(1, len(patches))
         patch = patches[0]
         self.assertEqual('1', patch.id)
@@ -1015,7 +1016,6 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         # things behaves as expected
         self.commits = [commit1, commit2]
         self.patches = [patch1, patch2]
-        count = 2
 
         # Check that the tags are picked up on the first patch
         new_rtags, _ = status.process_reviews(patch1.content, patch1.comments,
@@ -1280,8 +1280,9 @@ line8
               'And another comment'],
              ['> File: file.c',
               '> Line: 153 / 143: def check_patch(fname, show_types=False):',
-              '>  and more code', '> +Addition here', '> +Another addition here',
-              '>  codey', '>  more codey', 'and another thing in same file'],
+              '>  and more code', '> +Addition here',
+              '> +Another addition here', '>  codey', '>  more codey',
+              'and another thing in same file'],
              ['> File: file.c', '> Line: 253 / 243',
               '>  with no function context', 'one more thing'],
              ['> File: tools/patman/main.py', '> +line of code',
-- 
2.43.0

