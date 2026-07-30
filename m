Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C1C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 11:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA6D4607B2;
	Thu, 30 Jul 2026 11:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6kYjAXzyFTGZ; Thu, 30 Jul 2026 11:59:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F486607E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785412764;
	bh=VKpjltAc8uZRtX1yf/Wlv5MvJH0mxxo54E/D5tioMKI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VT7VrGp7gG1Bm6symsb5hUxknvXo9YXruwmi7/eIIb0zc/JZ/YbyVzjc8jwNN83R5
	 tfXS6A4VjqzN6a7UioIa//bzZ+Pmkd6IdPw/q6vbk0QJLW5j9O4NNqW1AQfeJjSVT8
	 ynlh2Q0qraqI4P4SmmYqelhGWGm98rhOXGGuwvrRD4PXFzcRXExpbwOq5HRKZ9ih1h
	 glo78+XFdqhieBuzSg266q7wXdHFzL9TtTbEIP+k6zgOjM2tK/VddvHCpvrK838Kx7
	 GXUSDzWvexxogFaBWsxCVse2CR7obXOszjAWTnbCysOxBLRGqgx4HD2k8KMH6ryhFq
	 0fe2jZ2O+MaHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F486607E5;
	Thu, 30 Jul 2026 11:59:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D81A136E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA0BC607E5
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2x7k5ZKLwDQg for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 11:59:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 604A6607B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 604A6607B2
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 604A6607B2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:59:22 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495437bb891so5734445e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 04:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785412760; x=1786017560;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VKpjltAc8uZRtX1yf/Wlv5MvJH0mxxo54E/D5tioMKI=;
 b=NqadmtgZBOTGNwnv+VIVk7Hgx8JBKIqC0d386sAxIPcQkfSohjPqXgpmL1KnqE8KEK
 8FtiQawWuxR1nXV1yQ0p4d/xGAIoytIMcylv1dhXQeHRLb8kaFf6P9+rz4cH76lIF2Mr
 qe2u5P6i7Q2kqXldZSDmcABhxTUDjPkaHhQMWjteBSLePQRksg5m/1h1FuXE2KUFOoCR
 RiawubIzwhROjo0waqueH/dhWBoIHq5MdUkbD0rnza8YACy/DIjPAQwK5aWUPJj2EXK+
 Y83iS/xu15N7+039UX8BC3PVFQXnHcgLsqlMmQBVPz4NrsdEJMWNXrq0TOxZ3qTyOOuP
 Ne6w==
X-Gm-Message-State: AOJu0YzTaUN3OEid4DQEsVfSku4nf8oK5Wio5wVfxXNbAqIES4/QeNdW
 Fcnzly0QlPbE/qJsxodsuQy5ggS/SeXfrGj7YzHrd1eh77Vl68YcIqLtFhgPdpd4RIE=
X-Gm-Gg: AR+sD139IbeFSNgy8DdrUY49Foy6a8EyLWIfBvzVAsTlqBz8P2KbMpnbRsTM08QTgbU
 3chrRSD0HsoHTVelgJR+WfycaMdVgcQPoahoqIFp1UWL1MPOSjrZWvUbn7V2cR65r52tQlNwBzl
 Yrd//HSdXk6PbHEsEd0gBVzBlrrqcP4EYpAJTNvGh/xJPlH77xsZJORwoq4NuRnX9VjCbTMmFif
 yKLaBZ3s82+ZaWK7WWPsYhGCOVd9rtVwsBYlZ58EMvDtsPmQ09alfEbEFksxQ6OgDpdDBZ35M7m
 4IR1sSDpqKTJgQzxtMC/LQKWCbbKVCQBblJtFUSp5ZwIXR0MnMTDmfyKQWWoTM+TB+075RzMNH7
 ODuSrfbfGEZ8bM32yGZf/9WS6POwVMsYINUhD9Z+QBQrxMGVCLi75n33PeAEFKPx22ftLw/9rD2
 3IYR8/d/Tfj2Jf0jVm64dlzP+2Z3zVV0UalorKjHWJ52vuv5TytFl8oi0eIt9Mr7Pvs4l0UsebT
 ObjC1zRW1k4Lyo4K14UFvl+uFwApfH3JS8JlJxzIg==
X-Received: by 2002:a05:600c:4915:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-49804c62b9bmr317645e9.17.1785412760169; 
 Thu, 30 Jul 2026 04:59:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89342f7sm5970597f8f.26.2026.07.30.04.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:59:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 15:59:04 +0400
Subject: [PATCH] binman: Do not dedent docstrings twice on Python 3.13+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-binman-docstring-dedent-v1-1-3ca69d1c97f3@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAwA0F8ZORvo5rDir4iHNokzgpk0nQhj/
 27V47u8FVyKisOpW6HIS11na+h3HdAt2SSo3AxDGA4h7gPmEbPaIxnyTF6L2oQsLFbxOBLF1Ic
 QiaEFzyJXff/y8+VvX/JdqH5H2LYPyOw0Sn4AAAA=
X-Change-ID: 20260730-b4-binman-docstring-dedent-84cc7a1007cd
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5323; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MVVW2wgeZZDxGeyGqETX2GSo0j3Y7QsbaYNlVYAtYBQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRl20yws8y0To/5qLB159nI9SLHEjL4/F8f35z0OVT5R
 urKQhbujoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKbaWI2R4efcwMMrgg9tkFXn+fq7/F+anQ9/p4jh9H+yFacTAwQupzL8lU14ePm
 A8Im0uc2ul2yWb39W3zJjx6sLTDM5Ehr33dqqywIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785412760; x=1786017560;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VKpjltAc8uZRtX1yf/Wlv5MvJH0mxxo54E/D5tioMKI=;
 b=f4a+iqSb+wgux1d82dOVhOiGEgJgUlg23ZU7M0H8kC8Kqp3w2wENqwcIAxwESDhorB
 txl/oV2JBGvmSoqtt6uHpFkXdEFQy97AQ6OzJXqNP1f2ZDryEAvy0BOyeEIKXYWYcUTi
 8a2bkjo85Tqq5xXlI7Ds/M4grlPICDx6K1uwkIgEqcrC2VCnRsWD8LhlQ8r1ip+xP+we
 xH28s782X5lV9Xq7SvfXXzkHwIM4vuhSzL5QPjtFrx5+qYYYgzukJJ4b3+FSi28K+22d
 i2xmWeqABHcGQQHeyHxePWlzUHNLIm//hWX09ss2VtKoDKVVAVKyzab+Vau2Zd7wkEFB
 TdJg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=f4a+iqSb
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

WriteDocs() and write_bintool_docs() strip four characters from the start
of every docstring line but the first, to undo the indentation the source
file gives them. Since Python 3.13 the compiler already removes the common
indentation from docstrings [1], so this removes four characters of actual
text from every line of every entry and bintool description:

  $ binman entry-docs | head
  ...
   that an image node whose only content is an optional entry which was
   is an example showing ATF, TEE and a device tree all combined::

Use inspect.cleandoc() instead, which produces the same result on both
older and newer interpreters.

The existing tests only checked that some output was produced, so they
missed this entirely; make them also confirm that a known line of a known
description survives intact.

Link: https://github.com/python/cpython/issues/81283 [1]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/binman/bintool.py |  6 ++++--
 tools/binman/entry.py   |  9 +++++++--
 tools/binman/ftest.py   | 19 +++++++++++++++++--
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 9c76c8881a46..4cf8d5b165bf 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -12,6 +12,7 @@ the tool, checking its version and fetching it if needed.
 import collections
 import glob
 import importlib
+import inspect
 import multiprocessing
 import os
 import shutil
@@ -463,9 +464,10 @@ binaries. It is fairly easy to create new bintools. Just add a new file to the
             if test_missing == name:
                 docs = None
             if docs:
-                lines = docs.splitlines()
+                # See the note in Entry.WriteDocs() about cleandoc()
+                lines = inspect.cleandoc(docs).splitlines()
                 first_line = lines[0]
-                rest = [line[4:] for line in lines[1:]]
+                rest = lines[1:]
                 hdr = 'Bintool: %s: %s' % (name, first_line)
                 print(hdr)
                 print('-' * len(hdr))
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index ce7ef28e94b1..9b39c7118892 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -6,6 +6,7 @@
 
 from collections import namedtuple
 import importlib
+import inspect
 import os
 import pathlib
 import sys
@@ -858,9 +859,13 @@ features to produce new behaviours.
             if test_missing == name:
                 docs = None
             if docs:
-                lines = docs.splitlines()
+                # Use cleandoc() rather than removing a fixed four characters
+                # of indent: since Python 3.13 the compiler already strips the
+                # common indent from docstrings, so doing it again here would
+                # eat the first four characters of every line
+                lines = inspect.cleandoc(docs).splitlines()
                 first_line = lines[0]
-                rest = [line[4:] for line in lines[1:]]
+                rest = lines[1:]
                 hdr = 'Entry: %s: %s' % (name.replace('_', '-'), first_line)
 
                 # Create a reference for use by rST docs
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9553eb6b7366..c5c67c7e68b1 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1805,7 +1805,15 @@ class TestFunctional(unittest.TestCase):
         """Test for creation of entry documentation"""
         with terminal.capture() as (stdout, stderr):
             control.WriteEntryDocs(control.GetEntryModules())
-        self.assertTrue(len(stdout.getvalue()) > 0)
+        out = stdout.getvalue()
+        self.assertTrue(len(out) > 0)
+
+        # The body of each docstring must come out dedented but otherwise
+        # intact. Check a heading which several etypes use, since truncating
+        # the indent by too much would silently eat the start of every line.
+        self.assertIn('\nProperties / Entry arguments:\n', out)
+        self.assertIn('\nEntry: atf-bl31: ARM Trusted Firmware (ATF) BL31 blob\n',
+                      out)
 
     def testEntryDocsMissing(self):
         """Test handling of missing entry documentation"""
@@ -5491,7 +5499,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test for creation of bintool documentation"""
         with terminal.capture() as (stdout, stderr):
             control.write_bintool_docs(control.bintool.Bintool.get_tool_list())
-        self.assertTrue(len(stdout.getvalue()) > 0)
+        out = stdout.getvalue()
+        self.assertTrue(len(out) > 0)
+
+        # As in testEntryDocs(), check that the body is dedented but intact
+        self.assertIn('\nBintool: mkimage: Image generation for U-Boot\n', out)
+        self.assertIn(
+            '\nThis bintool supports running `mkimage` with some basic parameters as\n',
+            out)
 
     def testBintoolDocsMissing(self):
         """Test handling of missing bintool documentation"""

---
base-commit: 44f0dcf476140c1077ee3dbe16a80fdb6f8265c4
change-id: 20260730-b4-binman-docstring-dedent-84cc7a1007cd

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

