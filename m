Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535F0C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C66880CD;
	Tue,  5 Mar 2024 19:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KghkiavE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B8F880E4; Tue,  5 Mar 2024 19:52:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC575880CD
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 19:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (ip-109-42-176-242.web.vodafone.de [109.42.176.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7BF3F41BEE; 
 Tue,  5 Mar 2024 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709664743;
 bh=cbw9mFHRFaaXDSX8tgtXYzwOfoEttx7Nmncer4AKSxs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KghkiavEmXXf+MUZLfAo1ZfG/SfQ6Q7bBW1/+KyVrn3KAZXGgEHXxbwpGCfCetoag
 mQCp6CTcxVvNqrPvakni2PMg/tfBOpCRn9NaK8PmGiljyaUO0ZC53kvm94sO522oE7
 XSK9tjlql6myXl4A1JrvgLbreZ6ULVHWSvxTlAdHE88+BkHVMvZbFLGVAKnCPpbtcI
 IGpU0iHyeU5bEJ4Hn8FQ6c658Z13+9SufHW6ZcvYxhDfmUp0Lqgnb+vWPnxfFpX9ti
 7X7H4cbMLRB5mmVFW1MdQiFilYcbMT4f8pAKC0VD03KBJ2qlkpFCh5moXfulb3RKg/
 pdcOQr45GUlpw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] doc: fix incorrect path Documentation
Date: Tue,  5 Mar 2024 19:52:04 +0100
Message-ID: <20240305185204.12108-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305185204.12108-1-heinrich.schuchardt@canonical.com>
References: <20240305185204.12108-1-heinrich.schuchardt@canonical.com>
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

When copying the build system for Linux we missed to replace some
instances of 'Documentation' by 'doc'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/maintainers_include.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/sphinx/maintainers_include.py b/doc/sphinx/maintainers_include.py
index 6cee52cbb39..13557d3d3c2 100755
--- a/doc/sphinx/maintainers_include.py
+++ b/doc/sphinx/maintainers_include.py
@@ -78,8 +78,8 @@ class MaintainersInclude(Include):
             # Drop needless input whitespace.
             line = line.rstrip()
 
-            # Linkify all non-wildcard refs to ReST files in Documentation/.
-            pat = r'(Documentation/([^\s\?\*]*)\.rst)'
+            # Linkify all non-wildcard refs to ReST files in doc/.
+            pat = r'(doc/([^\s\?\*]*)\.rst)'
             m = re.search(pat, line)
             if m:
                 # maintainers.rst is in a subdirectory, so include "../".
@@ -177,11 +177,11 @@ class MaintainersInclude(Include):
         if not self.state.document.settings.file_insertion_enabled:
             raise self.warning('"%s" directive disabled.' % self.name)
 
-        # Walk up source path directories to find Documentation/../
+        # Walk up source path directories to find doc/../
         path = self.state_machine.document.attributes['source']
         path = os.path.realpath(path)
         tail = path
-        while tail != "Documentation" and tail != "":
+        while tail != "doc" and tail != "":
             (path, tail) = os.path.split(path)
 
         # Append "MAINTAINERS"
-- 
2.43.0

