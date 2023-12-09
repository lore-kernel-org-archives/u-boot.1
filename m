Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7DB8744F;
	Sat,  9 Dec 2023 19:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tQ1MESiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEE687652; Sat,  9 Dec 2023 19:50:40 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E3387215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 156D93F736; 
 Sat,  9 Dec 2023 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702147837;
 bh=GXtvULCI6eA/SnYvOZtt6DSzwa/aMtTkHilQS4/8kv4=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=tQ1MESiDRbF5EnmCevdIaJVtx4VXJxWrf4Rj92sCCiNnyMdvUUwTp1JytTGMnQMKv
 8sJ+Rqw7e+5+nTCabmtKoIORkNbROfNxjB7/tsi41Ev0ohtmDi1akizpnV2088ixrb
 yW6Mn2yYV7e9RsuL5YL4HtZuChRfCQRC/VmxfjkRC0WzlMmE8+PPEb0dYZk5J4lFhb
 fcbVV7UQNqkistsEY2nhb3JL+/0hpw/0zqVJYnw46xQPdsc++you2nrqk5Bme7V28a
 dFMTi7uEmI7HZaqLy1xWpDPWHzWGDpqvyyv+UupffTQYHZ3F83mBiiOyqT7LpuuTAl
 6hgd3NokZqXGw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] binman: elf: Using variable 'old_val' before assignment
Date: Sat,  9 Dec 2023 19:50:31 +0100
Message-Id: <20231209185031.7275-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

old_val can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/binman/elf_test.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
index e3dee79d06..b64134123c 100644
--- a/tools/binman/elf_test.py
+++ b/tools/binman/elf_test.py
@@ -249,8 +249,8 @@ class TestElf(unittest.TestCase):
 
     def testEmbedFail(self):
         """Test calling GetSymbolFileOffset() without elftools"""
+        old_val = elf.ELF_TOOLS
         try:
-            old_val = elf.ELF_TOOLS
             elf.ELF_TOOLS = False
             fname = self.ElfTestFile('embed_data')
             with self.assertRaises(ValueError) as e:
@@ -290,8 +290,8 @@ class TestElf(unittest.TestCase):
 
     def test_read_segments_fail(self):
         """Test for read_loadable_segments() without elftools"""
+        old_val = elf.ELF_TOOLS
         try:
-            old_val = elf.ELF_TOOLS
             elf.ELF_TOOLS = False
             fname = self.ElfTestFile('embed_data')
             with self.assertRaises(ValueError) as e:
@@ -327,8 +327,8 @@ class TestElf(unittest.TestCase):
 
     def test_get_file_offset_fail(self):
         """Test calling GetFileOffset() without elftools"""
+        old_val = elf.ELF_TOOLS
         try:
-            old_val = elf.ELF_TOOLS
             elf.ELF_TOOLS = False
             fname = self.ElfTestFile('embed_data')
             with self.assertRaises(ValueError) as e:
@@ -351,8 +351,8 @@ class TestElf(unittest.TestCase):
 
     def test_get_symbol_from_address_fail(self):
         """Test calling GetSymbolFromAddress() without elftools"""
+        old_val = elf.ELF_TOOLS
         try:
-            old_val = elf.ELF_TOOLS
             elf.ELF_TOOLS = False
             fname = self.ElfTestFile('embed_data')
             with self.assertRaises(ValueError) as e:
-- 
2.40.1

