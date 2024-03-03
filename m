Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC02C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA4F87F00;
	Sun,  3 Mar 2024 14:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oFoVZKws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B5587F01; Sun,  3 Mar 2024 14:40:26 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6A987842
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4B6333F201; 
 Sun,  3 Mar 2024 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709473223;
 bh=VEdLl1L9FF5APU+fsdSv+nAwcE5B5ugJE9HKJxwVxcA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=oFoVZKwsyNi8UxXEHnN4fTnq7Z5uGTUSmGubazX8WTiCf155CgH3URtUTZpQ2TX8p
 PsMh9W9QSQv+6xOWK66sPKbcy4teQcSsCyhEKckQdcr/RNk2IPInNzVTmGkYD+3BlZ
 X/vP56uHEWNzznjqnqzR1Fl7RCrbnNTQajUnOPscOIVzgM+HysAAqULgnVj/2Jojvz
 jq94ZP+f1qjUyCsmVrm98TYK9PubEEdnbfCTpxVOtFLqPrkE+Pvy/eTFMGD3rwmNvs
 0v7Zay9sgUGYfHQZUSDZAXkFMyS9f8AxErGeWC5z7rfQx8DcMkBRtwTfFfZaivAmMm
 mWkOnT8IAYd/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: invalid escape sequences in maintainers_include.py
Date: Sun,  3 Mar 2024 14:40:22 +0100
Message-ID: <20240303134022.33062-1-heinrich.schuchardt@canonical.com>
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

Update maintainers_include.py from Linux next-20240202.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/maintainers_include.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/doc/sphinx/maintainers_include.py b/doc/sphinx/maintainers_include.py
index dc8fed48d3c..dcad0fff472 100755
--- a/doc/sphinx/maintainers_include.py
+++ b/doc/sphinx/maintainers_include.py
@@ -61,8 +61,6 @@ class MaintainersInclude(Include):
         field_content = ""
 
         for line in open(path):
-            if sys.version_info.major == 2:
-                line = unicode(line, 'utf-8')
             # Have we reached the end of the preformatted Descriptions text?
             if descriptions and line.startswith('Maintainers'):
                 descriptions = False
@@ -79,7 +77,7 @@ class MaintainersInclude(Include):
             line = line.rstrip()
 
             # Linkify all non-wildcard refs to ReST files in Documentation/.
-            pat = '(Documentation/([^\s\?\*]*)\.rst)'
+            pat = r'(Documentation/([^\s\?\*]*)\.rst)'
             m = re.search(pat, line)
             if m:
                 # maintainers.rst is in a subdirectory, so include "../".
@@ -92,11 +90,11 @@ class MaintainersInclude(Include):
                 output = "| %s" % (line.replace("\\", "\\\\"))
                 # Look for and record field letter to field name mappings:
                 #   R: Designated *reviewer*: FullName <address@domain>
-                m = re.search("\s(\S):\s", line)
+                m = re.search(r"\s(\S):\s", line)
                 if m:
                     field_letter = m.group(1)
                 if field_letter and not field_letter in fields:
-                    m = re.search("\*([^\*]+)\*", line)
+                    m = re.search(r"\*([^\*]+)\*", line)
                     if m:
                         fields[field_letter] = m.group(1)
             elif subsystems:
@@ -114,7 +112,7 @@ class MaintainersInclude(Include):
                     field_content = ""
 
                     # Collapse whitespace in subsystem name.
-                    heading = re.sub("\s+", " ", line)
+                    heading = re.sub(r"\s+", " ", line)
                     output = output + "%s\n%s" % (heading, "~" * len(heading))
                     field_prev = ""
                 else:
-- 
2.43.0

