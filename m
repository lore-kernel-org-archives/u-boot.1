Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ABFEED60F
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 14:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1F383966;
	Thu,  1 Jan 2026 15:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BIJWJcVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF1883979; Thu,  1 Jan 2026 15:29:05 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECE883935
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 15:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BB88B40038; 
 Thu,  1 Jan 2026 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767277737;
 bh=4ov2MyBPaMuIXAjkAOzwWc5khsuYm9izsYz/8XVGL+w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BIJWJcVBrUZctKFifot44l6e668m0i38N207k+T7bLpsxBD+WXPrJ8H+8YFZukSRH
 WRE5fvG5faw6JnUDiLbomOpfcjtl8sH/DZYjBegMATnjG4f4awNu8UHspg0XmiqPtK
 sM5faEY/aTdZ762I0Tdk58QQV89T7AK1vkz/HsNqgCAb6q2pSNFOUKwIXb6D8C0Fjz
 ZluQDwDnyZtlDxDtI0tddMDjSTe0WEA8PBu6xBUISDxh1axwZBDRWOtWpfpkx4maGY
 eQsKy8OPOImZyVyuwYIUwb0f09oM1VJq40ZZq9g/YuChwAVptr+d0lUxH/C/Lxu+zy
 DnNP/LcVx1spmOQOWv2FrtRsNdpLlmMKqqcq5aIXhDS5o9o5o0w3wIJLiepOfggRBk
 Sc8+Lt4kzFhzgPx4AIADr+DonP/BiGxo6pkdZ63WDZMsGiJwF7fSljF6eB/KdaZBpO
 3hcLTMPM6upJl6aT8wMF5UAk33AVNq3sZtgZtCqKxcv/P9AAFP4ii16eVGD1vaxfi1
 S7D+iTURKoO0hurKC6CL4BzpZzSINolH8lym6Eytk15YMEUZiPrDgs0Oslm/VoXJ+A
 KrCT+j03na04Q0467MsTeCJUYOhLGddJHbdhf/hKNQvkwWtzZ9YV60OMjHaNTawrtW
 WOfrz16DYJBP3IUQXszGcZNA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: replace docutils.utils.error_reporting
Date: Thu,  1 Jan 2026 15:28:53 +0100
Message-ID: <20260101142853.19083-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Docutils has dropped reprunicode(), ErrorString() and SafeString() in newer
revisions. This stops us from using a current docutils, e.g. 0.22.4.

Use the same definition of ErrorString() as Linux v6.18.
Drop reprunicode() conversion.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/kernel_abi.py          | 4 +++-
 doc/sphinx/kernel_feat.py         | 4 +++-
 doc/sphinx/kernel_include.py      | 8 ++++----
 doc/sphinx/maintainers_include.py | 4 +++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/doc/sphinx/kernel_abi.py b/doc/sphinx/kernel_abi.py
index 32c50e496b5..9a33eb35f46 100644
--- a/doc/sphinx/kernel_abi.py
+++ b/doc/sphinx/kernel_abi.py
@@ -44,7 +44,9 @@ from os import path
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
+
+def ErrorString(exc):
+    return f'{exc.__class__.__name}: {exc}'
 
 #
 # AutodocReporter is only good up to Sphinx 1.7
diff --git a/doc/sphinx/kernel_feat.py b/doc/sphinx/kernel_feat.py
index 2fee04f1ded..2c47513f7ec 100644
--- a/doc/sphinx/kernel_feat.py
+++ b/doc/sphinx/kernel_feat.py
@@ -41,7 +41,9 @@ from os import path
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
+
+def ErrorString(exc):
+    return f'{exc.__class__.__name}: {exc}'
 
 #
 # AutodocReporter is only good up to Sphinx 1.7
diff --git a/doc/sphinx/kernel_include.py b/doc/sphinx/kernel_include.py
index f523aa68a36..10ff8e60a91 100755
--- a/doc/sphinx/kernel_include.py
+++ b/doc/sphinx/kernel_include.py
@@ -34,11 +34,13 @@ u"""
 import os.path
 
 from docutils import io, nodes, statemachine
-from docutils.utils.error_reporting import SafeString, ErrorString
 from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
+def ErrorString(exc):
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 # ==============================================================================
@@ -94,7 +96,6 @@ class KernelInclude(Include):
         # HINT: this is the only line I had to change / commented out:
         #path = utils.relative_path(None, path)
 
-        path = nodes.reprunicode(path)
         encoding = self.options.get(
             'encoding', self.state.document.settings.input_encoding)
         e_handler=self.state.document.settings.input_encoding_error_handler
@@ -108,8 +109,7 @@ class KernelInclude(Include):
         except UnicodeEncodeError as error:
             raise self.severe('Problems with "%s" directive path:\n'
                               'Cannot encode input file path "%s" '
-                              '(wrong locale?).' %
-                              (self.name, SafeString(path)))
+                              '(wrong locale?).' % (self.name, path))
         except IOError as error:
             raise self.severe('Problems with "%s" directive path:\n%s.' %
                       (self.name, ErrorString(error)))
diff --git a/doc/sphinx/maintainers_include.py b/doc/sphinx/maintainers_include.py
index 13557d3d3c2..38c974ae4f9 100755
--- a/doc/sphinx/maintainers_include.py
+++ b/doc/sphinx/maintainers_include.py
@@ -22,10 +22,12 @@ import re
 import os.path
 
 from docutils import statemachine
-from docutils.utils.error_reporting import ErrorString
 from docutils.parsers.rst import Directive
 from docutils.parsers.rst.directives.misc import Include
 
+def ErrorString(exc):
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):
-- 
2.51.0

