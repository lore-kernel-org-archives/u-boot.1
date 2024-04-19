Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A05C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 02:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BDB885CD;
	Fri, 19 Apr 2024 04:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E95PvCh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E098869D; Fri, 19 Apr 2024 04:36:41 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0566588688
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78f056f928eso95199185a.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713494197; x=1714098997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi6ppjiFpl3vcYL8s7MnGkQuFDSP/ugnJNMIGY71bxk=;
 b=E95PvCh0VoPHrtUow5K7jKG2DUq4wF6GSOCARq9Ahq08C7zZiNUhC+mT7keg3hJ/z6
 FW7jbrqSyEpVbp9CDiSQrjelJnBzeGoFCdv2xqmc1MCiu6kCjcQ8EgCKYNH6Q/xZMoDm
 vxlVdcB0q5pZKGB76u2z+NGpW2y0fhl3t+o8LO40bnEhfmeLAdkIWeMjhgtgM4z8gucA
 ZuDkFkdsZioi7xtUxZ8LIsBpc5+6QAnIxlDzO97wfCC0+gO37ZrD9Qb7bSr2hrIk3U6p
 9p2MlzUan1GYBG38RDrLaBAOk8eE9z2rA3lzi9xXj21oyCFfEb3YAxjpShFgUobdkBVD
 sDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713494197; x=1714098997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bi6ppjiFpl3vcYL8s7MnGkQuFDSP/ugnJNMIGY71bxk=;
 b=qoZ1pK5wLF5Br1cgxkHzlpkaBEFZ9qJPDSNMQGAm7iywsJexxmJgCDqpcMAlHZNDtR
 FJPCujKom3WEgD2F78k3yGCP4YsPSLdG2AkU69ED5bzJG74AUXmN/FQXDE9UUC0hcDrg
 9yixkmi+B0UJEYazCie/d6cEJSRBttcS2zoNGpYCzAvu6h9JB0EgaH+1B0nPQrA+md0h
 gkIXVNQLO/hNrU6/WZyXcJSXp2vxXJHXOjY3iddrcqmDXptwZPSpYBoCdQMb49cJTkGr
 22K+Mfe2VqqU0UtMWsUkww2OOmA0AEkO0z/oKkRSe0q+LcBA5+MHE2RiLLQLt6HUGaYt
 jrpA==
X-Gm-Message-State: AOJu0Ywr35qtU8dAvZNjZaJ5DYchORSDyhHaL8YGb62DL6bgafWQnWlk
 mge7BrW/TcLv438sP47zA3d5gMJ52d28QOG65had0eNi06hglFz2y51W9w==
X-Google-Smtp-Source: AGHT+IHH4DtdP0GD9Z7nKLiK6leEOHHuHJq5Q2HzSO1S80aFVIWfTor7PcAz+GQ+lW+CCr8WOs3XfQ==
X-Received: by 2002:a05:620a:268f:b0:78d:73f4:d100 with SMTP id
 c15-20020a05620a268f00b0078d73f4d100mr1043606qkp.27.1713494196943; 
 Thu, 18 Apr 2024 19:36:36 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 yf20-20020a05620a3bd400b0078eeea25dd6sm1198478qkn.116.2024.04.18.19.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 19:36:36 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/3] patman: Add Commit-cc as an alias for Patch-cc
Date: Thu, 18 Apr 2024 22:36:31 -0400
Message-Id: <20240419023632.29078-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240419023632.29078-1-seanga2@gmail.com>
References: <20240419023632.29078-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Most tags referring to commits (or patches) are named Commit-something. The
exception is Patch-cc. Add a Commit-cc alias so we can use whichever one is
convenient.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tools/patman/func_test.py                                    | 5 ++++-
 tools/patman/patchstream.py                                  | 2 ++
 tools/patman/patman.rst                                      | 2 +-
 ...dt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch | 1 +
 tools/patman/test/test01.txt                                 | 1 +
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 9c016fb5e9a..3b4c9448882 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -211,6 +211,7 @@ class TestFunctional(unittest.TestCase):
             'u-boot': ['u-boot@lists.denx.de'],
             'simon': [self.leb],
             'fred': [self.fred],
+            'joe': [self.joe],
         }
 
         text = self._get_text('test01.txt')
@@ -259,6 +260,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual('Postfix:\t  some-branch', next(lines))
         self.assertEqual('Cover: 4 lines', next(lines))
         self.assertEqual('      Cc:  %s' % self.fred, next(lines))
+        self.assertEqual('      Cc:  %s' % self.joe, next(lines))
         self.assertEqual('      Cc:  %s' % self.leb,
                          next(lines))
         self.assertEqual('      Cc:  %s' % mel, next(lines))
@@ -272,7 +274,8 @@ class TestFunctional(unittest.TestCase):
 
         self.assertEqual(('%s %s\0%s' % (args[0], rick, stefan)), cc_lines[0])
         self.assertEqual(
-            '%s %s\0%s\0%s\0%s' % (args[1], self.fred, self.leb, rick, stefan),
+            '%s %s\0%s\0%s\0%s\0%s' % (args[1], self.fred, self.joe, self.leb,
+                                       rick, stefan),
             cc_lines[1])
 
         expected = '''
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index e2e2a83e677..ec1ca874fb2 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -475,6 +475,8 @@ class PatchStream:
             elif name == 'changes':
                 self.in_change = 'Commit'
                 self.change_version = self._parse_version(value, line)
+            elif name == 'cc':
+                self.commit.add_cc(value.split(','))
             else:
                 self._add_warn('Line %d: Ignoring Commit-%s' %
                                (self.linenum, name))
diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index f4588c00fc1..9971fa8c0fd 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -350,7 +350,7 @@ Cover-changes: n
         - This line will only appear in the cover letter
         <blank line>
 
-Patch-cc: Their Name <email>
+Patch-cc / Commit-cc: Their Name <email>
     This copies a single patch to another email address. Note that the
     Cc: used by git send-email is ignored by patman, but will be
     interpreted by git send-email if you use it.
diff --git a/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch b/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
index 56278a6ce9b..55a0d6756aa 100644
--- a/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
+++ b/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
@@ -21,6 +21,7 @@ Series-cc: Stefan Brüns <stefan.bruens@rwth-aachen.de>
 Cover-letter-cc: Lord Mëlchett <clergy@palace.gov>
 Series-version: 3
 Patch-cc: fred
+Commit-cc: joe
 Series-process-log: sort, uniq
 Series-changes: 4
 - Some changes
diff --git a/tools/patman/test/test01.txt b/tools/patman/test/test01.txt
index fc3066e50b4..271d9bf043f 100644
--- a/tools/patman/test/test01.txt
+++ b/tools/patman/test/test01.txt
@@ -49,6 +49,7 @@ Date:   Sat Apr 15 15:39:08 2017 -0600
     Cover-letter-cc: Lord Mëlchett <clergy@palace.gov>
     Series-version: 3
     Patch-cc: fred
+    Commit-cc: joe
     Series-process-log: sort, uniq
     Series-changes: 4
     - Some changes
-- 
2.37.1

