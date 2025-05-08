Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA6C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604FF8297E;
	Thu,  8 May 2025 09:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YEnQHwWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8C682A36; Thu,  8 May 2025 09:29:31 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D428283E
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso702398f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689368; x=1747294168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zTHxlGqk6JG3EY6i66qnVt8VWDmfsuI/rGwKvbvAgw=;
 b=YEnQHwWQS/yRikrmlk8SFQJqTOR0TQ2OGoNGSQ3YYY2ww51pdZ3Pi+SCVJkRzqVybZ
 aknGt9EP4IXmEYOV09v+eHOYlWkJSar61Nt9fWJqJONJ7Acpl7EwCmeXCgqyg7pWELj6
 V+RbMnXdT5jtyIU2cTAjXV6G2sTKyTZjL01SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689368; x=1747294168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zTHxlGqk6JG3EY6i66qnVt8VWDmfsuI/rGwKvbvAgw=;
 b=ZEt6gbh5+1NU4TdQ37foSOobkVlLscE2+WCz/qK/rqagYWSIBG/UAuxsfxwzGx/Gjy
 MFhsISLpfG923gvs20piK+/EmD3a8cj15uKqrIooXa2f4DKkpTt8meGnzmHjmJvezYTq
 cE0jSKF/kK6A00oiK0z1qxgLb3YQC9SlI3QpGg37TiRDEk83ArdFoGx7ypPjXpDUZZA2
 aIhE+A4wGSgddm+9K3D/l0eSQnGR2Uj1oYplKj/e38fCllqVkGhjVffaZX/WMTF1X80c
 /4/VZ1ccxVKwKbnLXMYUlH+4Hxr6R8qOKM+Qe3oaDgPUrxSC5DA8Hzq1GH/0aO4QPIUq
 mK1Q==
X-Gm-Message-State: AOJu0Yy5tK8H5c015gU64F4I0AibwhU59B9H65ONA466KABoJiA99awF
 2XZDS5/wmxUAH/Ao/DXm9iQrxKlvmdeErnAASkxHNxC0SOEV9oYrHwHJAfzTYxjqDdp7V8sF5PD
 3aBUGzZXPCw==
X-Gm-Gg: ASbGncujWjMqKVhGMYt13ZpDBTQi1Nk8Kpy2VrhDW9H7BJwP3L/JqZ9D/gLZQ1F9Gmo
 RaYBn4sNjutcFySDC3fukgLDxLBzpM/DahdWlzmZ3Bka/xoT27jZ+JwehD8UNe5+qV2DeJH+gJ2
 mbMd2vfkYQKeoXsrUjOxVlqlSOrQFl2nX9bSEZhIe4oH/x3lJVy/TEdwab3qSTS+5xhDemiUabi
 hiGV7X3MeVfni90ua+TnShk5NyEhY3KBoglBS5rdeVsULW60FOxA2jzYGaIF9XMXxo+gVKuTn8W
 w7PIaMLvLdKVN/bNDrJg/MKi+o6hItaPfnBJbQ==
X-Google-Smtp-Source: AGHT+IGGVOq4GjACW6Lqm0M4gjL7eGIXhnHbJa4uOfDed9KQPSVtvzKsxbM/p07vRHcX58F/LY1oKg==
X-Received: by 2002:a05:6000:4020:b0:39c:266c:12a5 with SMTP id
 ffacd0b85a97d-3a0ba09c701mr1575489f8f.13.1746689368506; 
 Thu, 08 May 2025 00:29:28 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/20] patman: Use itr instead of lines for iterator
Date: Thu,  8 May 2025 09:28:32 +0200
Message-ID: <20250508072907.207175-9-sjg@chromium.org>
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

The variables 'lines' is used to hold a list of output lines within a
test, but also to hold an iterator through those lines. Use 'itr' for
the latter, to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 161 +++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 79 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 7f9175ea44f..624f388966e 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -223,7 +223,8 @@ class TestFunctional(unittest.TestCase):
         """
         process_tags = True
         ignore_bad_tags = False
-        stefan = b'Stefan Br\xc3\xbcns <stefan.bruens@rwth-aachen.de>'.decode('utf-8')
+        stefan = (b'Stefan Br\xc3\xbcns <stefan.bruens@rwth-aachen.de>'
+                  .decode('utf-8'))
         rick = 'Richard III <richard@palace.gov>'
         mel = b'Lord M\xc3\xablchett <clergy@palace.gov>'.decode('utf-8')
         add_maintainers = [stefan, rick]
@@ -260,43 +261,43 @@ class TestFunctional(unittest.TestCase):
         cc_lines = open(cc_file, encoding='utf-8').read().splitlines()
         os.remove(cc_file)
 
-        lines = iter(out[0].getvalue().splitlines())
+        itr = iter(out[0].getvalue().splitlines())
         self.assertEqual('Cleaned %s patches' % len(series.commits),
-                         next(lines))
-        self.assertEqual('Change log missing for v2', next(lines))
-        self.assertEqual('Change log missing for v3', next(lines))
-        self.assertEqual('Change log for unknown version v4', next(lines))
-        self.assertEqual("Alias 'pci' not found", next(lines))
-        while next(lines) != 'Cc processing complete':
+                         next(itr))
+        self.assertEqual('Change log missing for v2', next(itr))
+        self.assertEqual('Change log missing for v3', next(itr))
+        self.assertEqual('Change log for unknown version v4', next(itr))
+        self.assertEqual("Alias 'pci' not found", next(itr))
+        while next(itr) != 'Cc processing complete':
             pass
-        self.assertIn('Dry run', next(lines))
-        self.assertEqual('', next(lines))
-        self.assertIn('Send a total of %d patches' % count, next(lines))
-        prev = next(lines)
+        self.assertIn('Dry run', next(itr))
+        self.assertEqual('', next(itr))
+        self.assertIn('Send a total of %d patches' % count, next(itr))
+        prev = next(itr)
         for i, commit in enumerate(series.commits):
             self.assertEqual('   %s' % args[i], prev)
             while True:
-                prev = next(lines)
+                prev = next(itr)
                 if 'Cc:' not in prev:
                     break
         self.assertEqual('To:	  u-boot@lists.denx.de', prev)
-        self.assertEqual('Cc:	  %s' % stefan, next(lines))
-        self.assertEqual('Version:  3', next(lines))
-        self.assertEqual('Prefix:\t  RFC', next(lines))
-        self.assertEqual('Postfix:\t  some-branch', next(lines))
-        self.assertEqual('Cover: 4 lines', next(lines))
-        self.assertEqual('      Cc:  %s' % self.fred, next(lines))
-        self.assertEqual('      Cc:  %s' % self.joe, next(lines))
+        self.assertEqual('Cc:	  %s' % stefan, next(itr))
+        self.assertEqual('Version:  3', next(itr))
+        self.assertEqual('Prefix:\t  RFC', next(itr))
+        self.assertEqual('Postfix:\t  some-branch', next(itr))
+        self.assertEqual('Cover: 4 lines', next(itr))
+        self.assertEqual('      Cc:  %s' % self.fred, next(itr))
+        self.assertEqual('      Cc:  %s' % self.joe, next(itr))
         self.assertEqual('      Cc:  %s' % self.leb,
-                         next(lines))
-        self.assertEqual('      Cc:  %s' % mel, next(lines))
-        self.assertEqual('      Cc:  %s' % rick, next(lines))
+                         next(itr))
+        self.assertEqual('      Cc:  %s' % mel, next(itr))
+        self.assertEqual('      Cc:  %s' % rick, next(itr))
         expected = ('Git command: git send-email --annotate '
                     '--in-reply-to="%s" --to u-boot@lists.denx.de '
                     '--cc "%s" --cc-cmd "%s send --cc-cmd %s" %s %s'
                     % (in_reply_to, stefan, sys.argv[0], cc_file, cover_fname,
                        ' '.join(args)))
-        self.assertEqual(expected, next(lines))
+        self.assertEqual(expected, next(itr))
 
         self.assertEqual(('%s %s\0%s' % (args[0], rick, stefan)), cc_lines[0])
         self.assertEqual(
@@ -1041,39 +1042,39 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
         status.check_and_show_status(series, '1234', None, None, False, False,
                                      pwork)
-        lines = iter(terminal.get_print_test_lines())
+        itr = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('    Reviewed-by: ', col.GREEN, newline=False,
                                bright=False),
-            next(lines))
+            next(itr))
         self.assertEqual(terminal.PrintLine(self.joe, col.WHITE, bright=False),
-                         next(lines))
+                         next(itr))
 
         self.assertEqual(terminal.PrintLine('  2 Subject 2', col.YELLOW),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('    Reviewed-by: ', col.GREEN, newline=False,
                                bright=False),
-            next(lines))
-        self.assertEqual(terminal.PrintLine(self.fred, col.WHITE, bright=False),
-                         next(lines))
+            next(itr))
+        self.assertEqual(terminal.PrintLine(self.fred, col.WHITE,
+                                            bright=False), next(itr))
         self.assertEqual(
             terminal.PrintLine('    Tested-by: ', col.GREEN, newline=False,
                                bright=False),
-            next(lines))
+            next(itr))
         self.assertEqual(terminal.PrintLine(self.leb, col.WHITE, bright=False),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
-            next(lines))
+            next(itr))
         self.assertEqual(terminal.PrintLine(self.mary, col.WHITE),
-                         next(lines))
+                         next(itr))
         self.assertEqual(terminal.PrintLine(
             '1 new response available in patchwork (use -d to write them to a new branch)',
-            None), next(lines))
+            None), next(itr))
 
     def _fake_patchwork3(self, subpath):
         """Fake Patchwork server for the function below
@@ -1175,18 +1176,18 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         # Now check the actual test of the first commit message. We expect to
         # see the new tags immediately below the old ones.
         stdout = patchstream.get_list(dest_branch, count=count, git_dir=gitdir)
-        lines = iter([line.strip() for line in stdout.splitlines()
-                      if '-by:' in line])
+        itr = iter([line.strip() for line in stdout.splitlines()
+                    if '-by:' in line])
 
         # First patch should have the review tag
-        self.assertEqual('Reviewed-by: %s' % self.joe, next(lines))
+        self.assertEqual('Reviewed-by: %s' % self.joe, next(itr))
 
         # Second patch should have the sign-off then the tested-by and two
         # reviewed-by tags
-        self.assertEqual('Signed-off-by: %s' % self.leb, next(lines))
-        self.assertEqual('Reviewed-by: %s' % self.fred, next(lines))
-        self.assertEqual('Reviewed-by: %s' % self.mary, next(lines))
-        self.assertEqual('Tested-by: %s' % self.leb, next(lines))
+        self.assertEqual('Signed-off-by: %s' % self.leb, next(itr))
+        self.assertEqual('Reviewed-by: %s' % self.fred, next(itr))
+        self.assertEqual('Reviewed-by: %s' % self.mary, next(itr))
+        self.assertEqual('Tested-by: %s' % self.leb, next(itr))
 
     def test_parse_snippets(self):
         """Test parsing of review snippets"""
@@ -1357,75 +1358,77 @@ Reviewed-by: %s
         pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
         status.check_and_show_status(series, '1234', None, None, False, True,
                                      pwork)
-        lines = iter(terminal.get_print_test_lines())
+        itr = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.YELLOW),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
-            next(lines))
-        self.assertEqual(terminal.PrintLine(self.joe, col.WHITE), next(lines))
+            next(itr))
+        self.assertEqual(terminal.PrintLine(self.joe, col.WHITE), next(itr))
 
         self.assertEqual(terminal.PrintLine('Review: %s' % self.joe, col.RED),
-                         next(lines))
-        self.assertEqual(terminal.PrintLine('    Hi Fred,', None), next(lines))
-        self.assertEqual(terminal.PrintLine('', None), next(lines))
+                         next(itr))
+        self.assertEqual(terminal.PrintLine('    Hi Fred,', None), next(itr))
+        self.assertEqual(terminal.PrintLine('', None), next(itr))
         self.assertEqual(terminal.PrintLine('    > File: file.c', col.MAGENTA),
-                         next(lines))
+                         next(itr))
         self.assertEqual(terminal.PrintLine('    > Some code', col.MAGENTA),
-                         next(lines))
-        self.assertEqual(terminal.PrintLine('    > and more code', col.MAGENTA),
-                         next(lines))
+                         next(itr))
+        self.assertEqual(terminal.PrintLine('    > and more code',
+                                            col.MAGENTA),
+                         next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    Here is my comment above the above...', None), next(lines))
-        self.assertEqual(terminal.PrintLine('', None), next(lines))
+            '    Here is my comment above the above...', None), next(itr))
+        self.assertEqual(terminal.PrintLine('', None), next(itr))
 
         self.assertEqual(terminal.PrintLine('  2 Subject 2', col.YELLOW),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
-            next(lines))
+            next(itr))
         self.assertEqual(terminal.PrintLine(self.fred, col.WHITE),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('  + Reviewed-by: ', col.GREEN, newline=False),
-            next(lines))
+            next(itr))
         self.assertEqual(terminal.PrintLine(self.mary, col.WHITE),
-                         next(lines))
+                         next(itr))
         self.assertEqual(
             terminal.PrintLine('  + Tested-by: ', col.GREEN, newline=False),
-            next(lines))
+            next(itr))
         self.assertEqual(terminal.PrintLine(self.leb, col.WHITE),
-                         next(lines))
+                         next(itr))
 
         self.assertEqual(terminal.PrintLine('Review: %s' % self.fred, col.RED),
-                         next(lines))
-        self.assertEqual(terminal.PrintLine('    Hi Fred,', None), next(lines))
-        self.assertEqual(terminal.PrintLine('', None), next(lines))
+                         next(itr))
+        self.assertEqual(terminal.PrintLine('    Hi Fred,', None), next(itr))
+        self.assertEqual(terminal.PrintLine('', None), next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    > File: tools/patman/commit.py', col.MAGENTA), next(lines))
+            '    > File: tools/patman/commit.py', col.MAGENTA), next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    > Line: 41 / 41: class Commit:', col.MAGENTA), next(lines))
+            '    > Line: 41 / 41: class Commit:', col.MAGENTA), next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    > +        return self.subject', col.MAGENTA), next(lines))
+            '    > +        return self.subject', col.MAGENTA), next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    > +', col.MAGENTA), next(lines))
+            '    > +', col.MAGENTA), next(itr))
         self.assertEqual(
-            terminal.PrintLine('    >      def add_change(self, version, info):',
-                               col.MAGENTA),
-            next(lines))
+            terminal.PrintLine(
+                '    >      def add_change(self, version, info):',
+                col.MAGENTA),
+            next(itr))
         self.assertEqual(terminal.PrintLine(
             '    >          """Add a new change line to the change list for a version.',
-            col.MAGENTA), next(lines))
+            col.MAGENTA), next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    >', col.MAGENTA), next(lines))
+            '    >', col.MAGENTA), next(itr))
         self.assertEqual(terminal.PrintLine(
-            '    A comment', None), next(lines))
-        self.assertEqual(terminal.PrintLine('', None), next(lines))
+            '    A comment', None), next(itr))
+        self.assertEqual(terminal.PrintLine('', None), next(itr))
 
         self.assertEqual(terminal.PrintLine(
             '4 new responses available in patchwork (use -d to write them to a new branch)',
-            None), next(lines))
+            None), next(itr))
 
     def test_insert_tags(self):
         """Test inserting of review tags"""
-- 
2.43.0

