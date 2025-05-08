Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457F1C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69AF682A7B;
	Thu,  8 May 2025 09:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kHDOw30b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A576282A71; Thu,  8 May 2025 09:29:44 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5AF82A39
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so344028f8f.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689382; x=1747294182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkmBFnfiLsT19AyuC0Jz1jpTqWcGdhLs4Ozih0vGFtE=;
 b=kHDOw30bzIwJEhfYFzgvkMDb5PB/KScbUHpl1/hhvxu6QcX11oK6fHe55cZ9sDj0Qa
 YnPvnGXDPmdYvHD/Nqxo/gqPY0JJ6oKFLLv5IqKUfrEidt0w8fKGQfvoksGQ1p9yhS3M
 rZYv9EkEBZFxNWyJWi1o1hC4NGQOFRUHARCoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689382; x=1747294182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkmBFnfiLsT19AyuC0Jz1jpTqWcGdhLs4Ozih0vGFtE=;
 b=aiWfmZCwC8BoERCdIeDRmOdYxlHm898/mU6yN5DZbUX5eCsEV1EN7vCmPkQdFiqS2/
 weqlX3ARv/u+JGvRoDXDKoNERBi3pK6ESNd0w204hIwwsiFngZV/jqNGgiwWpws7F5+X
 FRSLbztm3XJl6d1ny7X47K+oOIZutPGNJtRuN5XM5Uh2XpJHWEw7qIcgEIhxXwSl/dQ/
 nNIvxJmUp1xX5Vrc7nwZHAG3JSbacsqEr0DQV6CogQvpgBS8GhBRktkLC29AIzn7CaM1
 69UHszeE8az7gNdGuYsOfENF9ey0USyEF11ZDgRFTu7IANijCeLGO1DcjQitbQTrzGQ8
 zW9w==
X-Gm-Message-State: AOJu0YwPRFN/A8WcijPbuB3pCav0lSW9x/bpzyk6IJDb7S48Nv+q0MdH
 mtURAXy/5DGoC5acN0yWLkPwtvThkNpzlaZu8SgbS4hZBKUtSF2Oc4gXPr6qYRSqmJ9rS3mgLvw
 RjOqXihoJ1g==
X-Gm-Gg: ASbGncsODQFiHEf0sZs+BVTukQ4XzaS2YkbkF+pVxpUB4zWBW2gLCxDkiw3GOkJNI2/
 wBV4E00M8eJkUV/kSPTCexjKd+AhR0TO7aOTQCODN1E3gkprrvjnShFRUFzThd1WvnjokdRjdYX
 zB+BhgAsOqpPd+1ZDGZSLkRaeGnasGFW9I+1otIr38u6d++XIsbgylQh74zwOsWyKTYJmrhjjf3
 KI+cEhozdnbWSXRNg/G0oAwwQYO+HRuoOgDKSk7mwHj1yS/ZHuDrr0FUPXzgwA0Dw7b/QxPyjMb
 jtiQGx5a9Iy37wbwnFVFXFp9KKoQ9RDdRbNXrNIQkz5zxBCh
X-Google-Smtp-Source: AGHT+IGbNnsOsrYlhRqIsQxDkI5H4fzUZElu9hql1pKtJMjCDFYIhLPgf/fTkqWbwywBw8rYcs3Jxg==
X-Received: by 2002:a5d:5c84:0:b0:3a0:8834:214c with SMTP id
 ffacd0b85a97d-3a0ba0b0471mr1165277f8f.20.1746689381420; 
 Thu, 08 May 2025 00:29:41 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/20] patman: Add tests for help
Date: Thu,  8 May 2025 09:28:39 +0200
Message-ID: <20250508072907.207175-16-sjg@chromium.org>
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

Add a few tests to make sure that help is provided when requested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 9f3ab50fa4e..00aed8786e8 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -18,6 +18,7 @@ import unittest
 
 import pygit2
 
+from u_boot_pylib import command
 from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
@@ -83,6 +84,8 @@ class TestFunctional(unittest.TestCase):
         self.tmpdir = tempfile.mkdtemp(prefix='patman.')
         self.gitdir = os.path.join(self.tmpdir, '.git')
         self.repo = None
+        self._patman_pathname = sys.argv[0]
+        self._patman_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
 
     def tearDown(self):
         if self.preserve_outdirs:
@@ -784,6 +787,28 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         finally:
             os.chdir(orig_dir)
 
+    def _RunPatman(self, *args):
+        all_args = [self._patman_pathname] + list(args)
+        return command.run_one(*all_args, capture=True, capture_stderr=True)
+
+    def testFullHelp(self):
+        command.TEST_RESULT = None
+        result = self._RunPatman('-H')
+        help_file = os.path.join(self._patman_dir, 'README.rst')
+        # Remove possible extraneous strings
+        extra = '::::::::::::::\n' + help_file + '\n::::::::::::::\n'
+        gothelp = result.stdout.replace(extra, '')
+        self.assertEqual(len(gothelp), os.path.getsize(help_file))
+        self.assertEqual(0, len(result.stderr))
+        self.assertEqual(0, result.return_code)
+
+    def testHelp(self):
+        command.TEST_RESULT = None
+        result = self._RunPatman('-h')
+        self.assertTrue(len(result.stdout) > 1000)
+        self.assertEqual(0, len(result.stderr))
+        self.assertEqual(0, result.return_code)
+
     @staticmethod
     def _fake_patchwork(subpath):
         """Fake Patchwork server for the function below
-- 
2.43.0

