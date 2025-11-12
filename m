Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A34CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 01:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD5E483C01;
	Wed, 12 Nov 2025 02:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GyugqJ+7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o2RfYCWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C4283A94; Wed, 12 Nov 2025 02:17:30 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BEB783B22
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 02:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d5lr760XNz9sqF;
 Wed, 12 Nov 2025 02:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762910247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgfYK3uh9Ak4VWeACsKqaZeewygJcAzyxqiIfnqfR34=;
 b=GyugqJ+7R2QgUDlyDzChW/ANtu4XSbhp8TVmlDzCUG7V6Y8TGWUshfb20WHKDDL2AcEo2U
 WofAiboNGr/tvIcVjtOuaoZYpSSXMzcL2FNL5pdK+gh1O2uiToy2imKo1DseqkKT98eGmn
 yvG+LYJiU3FUPqLOU5CFoVSuVTSlqlBEzYTQqAExVK7kdU+B9T7D4v3rJei5h5dbe1uL+H
 cusfpOhMdlUcCldmDYteWBCePQzJ+mJEpUU9LuqdlCPXmt1Z6MZ7VuH/67OWlmfSuQpC4m
 Ne9tBnmMiW/BWTI//YzDqdq3Ntt6sCGWI9B/yje/sZFe8PM3mqWVg7nbPen4oQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762910245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgfYK3uh9Ak4VWeACsKqaZeewygJcAzyxqiIfnqfR34=;
 b=o2RfYCWHMOCIBHhXMafyglaCe9q/ZwB1uefinamwb0AoTFJzkfFo2zNnmF6a7rMxmUCvsU
 HvhAxWSZGKjNDOWe+sEelTNWRlLoBEa7nrtT5NGxCUup9DAdlon3BGrMjgeUzzo0ChGu1e
 WjxgYwVsyePTeqOZX6PdywuUqE3MCN7BIZayuC9vihUV/wBn+o5zmAhBocz0CoNWXwQGGQ
 2IRAUJXxZpztHs9rCD1QHVni+yaNEvVU2jyDVCvEJyG7oj208mCZzGyMVZ5jzj6vxQ03EN
 byJICvrU/PKb/t+R2LxSptzo3ZYS/QD9kVqSa/yD7BUmKKXyMBn2+fHfpIniuQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] test/py: android: Point fdt command to aligned addresses
Date: Wed, 12 Nov 2025 02:16:21 +0100
Message-ID: <20251112011717.360045-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 47b55830b050c171f9f
X-MBO-RS-META: guj361y5no4o7xjp51mq7niry74suy8w
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

Newer versions of libfdt strictly check whether the FDT blob
passed to them is at 8-byte aligned offset, if it is not, then
the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
'abootimg get dtb --index=1 addr size' may return non 8-byte
aligned FDT address which points directly into the abootimg.
Copy the result into temporary location before validation to
avoid FDT alignment check failure.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Kling <webgeek1234@gmail.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>
Cc: George Chan <gchan9527@gmail.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nicolas Belin <nbelin@baylibre.com>
Cc: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/py/tests/test_android/test_abootimg.py | 28 ++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index 2aadb692b30..daa87643e93 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -93,10 +93,16 @@ dtb_dump_resp="""## DTB area contents (concat format):
 loadaddr = 0x1000
 # Address in RAM where to load the vendor boot image ('abootimg' looks in $vloadaddr)
 vloadaddr= 0x10000
+# Expected DTB #1 size
+dtb1_size = 0x7d
+# Expected DTB #2 size
+dtb2_size = 0x7d
 # Expected DTB #1 offset from the boot image start address
-dtb1_offset = 0x187d
+dtb1_offset = 0x1800 + dtb1_size
 # Expected DTB offset from the vendor boot image start address
-dtb2_offset = 0x207d
+dtb2_offset = 0x2000 + dtb2_size
+# Expected DTB aligned offset
+dtba_offset = 0x4000
 # DTB #1 start address in RAM
 dtb1_addr = loadaddr + dtb1_offset
 # DTB #2 start address in RAM
@@ -214,11 +220,16 @@ def test_abootimg(abootimg_disk_image, ubman):
     assert response == 'a=11f00000'
 
     ubman.log.action('Testing \'abootimg get dtb --index\'...')
-    ubman.run_command('abootimg get dtb --index=1 dtb1_start')
+    ubman.run_command('abootimg get dtb --index=1 dtb1_start dtb1_size')
     response = ubman.run_command('env print dtb1_start')
     correct_str = "dtb1_start=%x" % (dtb1_addr)
     assert response == correct_str
-    ubman.run_command('fdt addr $dtb1_start')
+    response = ubman.run_command('env print dtb1_size')
+    correct_str = "dtb1_size=%x" % (dtb1_size)
+    assert response == correct_str
+    ubman.run_command('setenv dtbaaddr 0x%x' % (dtba_offset))
+    ubman.run_command('cp.b $dtb1_start $dtbaaddr $dtb1_size')
+    ubman.run_command('fdt addr $dtbaaddr')
     ubman.run_command('fdt get value v / model')
     response = ubman.run_command('env print v')
     assert response == 'v=x2'
@@ -257,12 +268,17 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
     assert response == 'a=11f00000'
 
     ubman.log.action('Testing \'abootimg get dtb --index\'...')
-    ubman.run_command('abootimg get dtb --index=1 dtb2_start')
+    ubman.run_command('abootimg get dtb --index=1 dtb2_start dtb2_size')
     response = ubman.run_command('env print dtb2_start')
     correct_str = "dtb2_start=%x" % (dtb2_addr)
     assert response == correct_str
+    response = ubman.run_command('env print dtb2_size')
+    correct_str = "dtb2_size=%x" % (dtb2_size)
+    assert response == correct_str
 
-    ubman.run_command('fdt addr $dtb2_start')
+    ubman.run_command('setenv dtbaaddr 0x%x' % (dtba_offset))
+    ubman.run_command('cp.b $dtb2_start $dtbaaddr $dtb2_size')
+    ubman.run_command('fdt addr $dtbaaddr')
     ubman.run_command('fdt get value v / model')
     response = ubman.run_command('env print v')
     assert response == 'v=x2'
-- 
2.51.0

