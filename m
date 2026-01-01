Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB75EED610
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 14:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA11783AC5;
	Thu,  1 Jan 2026 15:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kySmrbGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775C383B5E; Thu,  1 Jan 2026 15:31:23 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B2C83935
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 15:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E43FF60008;
 Thu,  1 Jan 2026 14:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A7F4C4CEF7;
 Thu,  1 Jan 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767277879;
 bh=mz/toqHBgZgooYGz7BetAiKqiGAa5qz9iK+Y3224c8o=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=kySmrbGjsIKGaeJRyOuxOHGCDAhBjJTb8lmkUgnSSIf9RKMVPJomUdUC6lfoIgj8C
 N/8myJrJJuBA+EJ6BN0WQMeTs6SC8+G2HtdNIoJaoWGOo37Ac5yjZb+mcfgJSEVF1U
 zK4DDPyvLlWp0IFTZuU7yCk4NTdowLCS6btkTR4PAhQaC+jthAGyASEvfLYJNUOdjU
 0qiWSB7lVVrZbpInjXjM7D4IOhNoxEE0sPaeLU1UoVGALYf+miyA6mAjuhIyHmd6ZQ
 5XSCNxQbiuq6RP4g7ek8S/Z8NMIwenB98A8IDNH1fC3bc1UqEy1QN7asQPIwbo/lZT
 03VD6MHoebatg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE3EED610;
 Thu,  1 Jan 2026 14:31:19 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 01 Jan 2026 15:31:06 +0100
Subject: [PATCH u-boot] docs: kdoc: handle the obsolescensce of
 docutils.ErrorString()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260101-docutils-v1-1-81391910aca3@posteo.net>
X-B4-Tracking: v=1; b=H4sIACmFVmkC/x3MWwqAIBBA0a3EfCdo9LKtRB9mYw2Eho8IpL0nf
 R643AwBPWGAqcrg8aZAzhaIugJ9KLsjo60YGt70XHDBNqdTpDOwbpRSGa700K5Q8sujoedfzZD
 Y6lyE5X0/wNZtTWIAAAA=
X-Change-ID: 20260101-docutils-5899af0ac74b
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jonathan Corbet <corbet@lwn.net>, 
 Zhixu Liu <zhixu.liu@gmail.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767277878; l=4083;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=X+ud5m4tMvl7KK+Kta/xOUP34NyNCr/0wkt3Cx3VRSU=;
 b=ELZSwuto/iuklWehD7d86Xx9KlyxfFxrnB1UWPtZMIEbNv1imllimJGYf+3Bq8TlDVaaecH8c
 Cm0Cy+k8T6zAtpmJEgL5lZC+3Xm7mcki1uJ7TO3LefKGpgLT62XU/Np
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

The ErrorString() and SafeString() docutils functions were helpers meant to
ease the handling of encodings during the Python 3 transition.  There is no
real need for them after Python 3.6, and docutils 0.22 removes them,
breaking the docs build

Handle this by just injecting our own one-liner version of ErrorString(),
and removing the sole SafeString() call entirely.

Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Upstream: https://git.kernel.org/linus/00d95fcc4dee66dfb6980de6f2973b32f973a1eb
[j.ne: Adapted from Linux to U-Boot]
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 doc/sphinx/kernel_abi.py          | 4 +++-
 doc/sphinx/kernel_feat.py         | 4 +++-
 doc/sphinx/kernel_include.py      | 6 ++++--
 doc/sphinx/maintainers_include.py | 4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/sphinx/kernel_abi.py b/doc/sphinx/kernel_abi.py
index 32c50e496b5..930e9273b16 100644
--- a/doc/sphinx/kernel_abi.py
+++ b/doc/sphinx/kernel_abi.py
@@ -44,7 +44,9 @@ from os import path
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
+
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
 
 #
 # AutodocReporter is only good up to Sphinx 1.7
diff --git a/doc/sphinx/kernel_feat.py b/doc/sphinx/kernel_feat.py
index 2fee04f1ded..cca48f6f1a4 100644
--- a/doc/sphinx/kernel_feat.py
+++ b/doc/sphinx/kernel_feat.py
@@ -41,7 +41,9 @@ from os import path
 from docutils import nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
-from docutils.utils.error_reporting import ErrorString
+
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
 
 #
 # AutodocReporter is only good up to Sphinx 1.7
diff --git a/doc/sphinx/kernel_include.py b/doc/sphinx/kernel_include.py
index f523aa68a36..6522de9dd69 100755
--- a/doc/sphinx/kernel_include.py
+++ b/doc/sphinx/kernel_include.py
@@ -34,11 +34,13 @@ u"""
 import os.path
 
 from docutils import io, nodes, statemachine
-from docutils.utils.error_reporting import SafeString, ErrorString
 from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 # ==============================================================================
@@ -109,7 +111,7 @@ class KernelInclude(Include):
             raise self.severe('Problems with "%s" directive path:\n'
                               'Cannot encode input file path "%s" '
                               '(wrong locale?).' %
-                              (self.name, SafeString(path)))
+                              (self.name, path))
         except IOError as error:
             raise self.severe('Problems with "%s" directive path:\n%s.' %
                       (self.name, ErrorString(error)))
diff --git a/doc/sphinx/maintainers_include.py b/doc/sphinx/maintainers_include.py
index 13557d3d3c2..ab79a74dc0c 100755
--- a/doc/sphinx/maintainers_include.py
+++ b/doc/sphinx/maintainers_include.py
@@ -22,10 +22,12 @@ import re
 import os.path
 
 from docutils import statemachine
-from docutils.utils.error_reporting import ErrorString
 from docutils.parsers.rst import Directive
 from docutils.parsers.rst.directives.misc import Include
 
+def ErrorString(exc):  # Shamelessly stolen from docutils
+    return f'{exc.__class__.__name}: {exc}'
+
 __version__  = '1.0'
 
 def setup(app):

---
base-commit: bb28daf51301546fc2b6882e51f39f5d12952375
change-id: 20260101-docutils-5899af0ac74b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


