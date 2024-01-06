Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F94C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 10:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0DD87756;
	Sat,  6 Jan 2024 11:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227C9878AA; Sat,  6 Jan 2024 11:37:04 +0100 (CET)
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD7387227
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 11:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gszymaszek@short.pl
Received: from [192.168.192.146] (port=52250 helo=nx64de-df6d00)
 by mx01.ayax.eu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gszymaszek@short.pl>)
 id 1rM42x-000gV5-S6; Sat, 06 Jan 2024 11:36:56 +0100
Date: Sat, 6 Jan 2024 11:36:54 +0100
From: Grzegorz Szymaszek <gszymaszek@short.pl>
To: u-boot@lists.denx.de
Cc: Grzegorz Szymaszek <gszymaszek@short.pl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: fix three-dash references in reStructuredText
Message-ID: <ZZktRm3O89FnozlD@nx64de-df6d00>
Mail-Followup-To: u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The "Sending patches" and "Patman patch manager" documents refer to the
three-dash, "---", that separates patch parts. The symbol is written in
the documentation in the same form as it is in actual patches: as three
U+002D HYPHEN-MINUS characters. When building the documentation, Sphinx
converts this symbol to a U+2014 EM DASH, that is invalid in this case.

Make the three-dash symbol a reStructuredText inline literal to prevent
its conversion; that is, enclose it in a pair of double backquotes (`).

Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
 doc/develop/sending_patches.rst | 4 ++--
 tools/patman/patman.rst         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 5a6962f102..3f25b1d046 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -121,7 +121,7 @@ General Patch Submission Rules
    * For new features: a description of the feature and your implementation.
 
 * Additional comments which you don't want included in U-Boot's history can be
-  included below the first "---" in the message body.
+  included below the first "``---``" in the message body.
 
 * If your description gets too long, that's a strong indication that you should
   split up your patch.
@@ -253,7 +253,7 @@ to observe the following rules.
 
 * Please make sure to keep a "change log", i.e. a description of what you have
   changed compared to previous versions of this patch. This change log should
-  be added below the "---" line in the patch, which starts the "comment
+  be added below the "``---``" line in the patch, which starts the "comment
   section", i.e. which contains text that does not get included into the
   actual commit message.
   Note: it is *not* sufficient to provide a change log in some cover letter
diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index a8b317eed6..e01355824c 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -280,7 +280,7 @@ Series-notes:
 
 Commit-notes:
     Similar, but for a single commit (patch). These notes will appear
-    immediately below the --- cut in the patch file::
+    immediately below the ``---`` cut in the patch file::
 
         Commit-notes:
         blah blah
-- 
2.43.0
