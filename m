Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18664CF34AC
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 19:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6389883F26;
	Wed, 19 Nov 2025 20:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Jdzg9NPn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="giUOoJGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E5783F9B; Wed, 19 Nov 2025 20:33:23 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6974F83D3C
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 20:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dBWqP1LGBz9v0r;
 Wed, 19 Nov 2025 20:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763580801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9mu1xcIW6+WiGgEpVR7P6kPnmCr4oip4qgF+8ouAk8=;
 b=Jdzg9NPnWygWVy0wf8N4Sr3t3zqgmMOwK3JCdcJcaWfAO8b1w5iNRy9Cnw9/EH+V8tAPFy
 oQKscQ6wqGAYhfIktem38BzlE+qIePpMzGa+/2q58R7YtGIHpd/3J1Itj28dAAKYmOSRBw
 WRzk/AWvOXX+5PWfY9AxoK4miMayfc0/Y6uFc5ahYlS733fmNp0vjRotijGyAz7BcTpj8e
 B870t/mfjr7bvQcTPW+Ew28RdrurVdK+7kc0QSk0pZUiClxMohhBieHFW36Wp/+X1onGPa
 GPOdCYQASyCsQV6NjwkvGAPzghPCXkGjT6wl3nl6n1DRWFyCHxdIf3VTIBB4ZA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=giUOoJGS;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763580799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9mu1xcIW6+WiGgEpVR7P6kPnmCr4oip4qgF+8ouAk8=;
 b=giUOoJGS6UOJ/JRVWh9oxqh4K3KMUoGI4C713ekwtqVoauThH8yF8fqg/uWOS24Faj0SZs
 BV7ZOepXmdfUOSxImjL/P2ewMzc53/NK/A0WTET+2fDnWdhkbTpp+ElzQS5OoNCTMyiYag
 ONjiJi4mnOV+2Bcuma5Tr/JaruUvWKDCBV7//4p+/GzwmbF/nGi/3GQSjUs01ZHK8O+/r3
 Vc9oQrqfQPCt9Cu4bGP0GWtL8w5YWCPyAalijl2zZpvQfMOtHu9l9XRvrx1x4uVb00PnKg
 15B1qUB66DNIROz4oq+poUrFysyeofewR0dDIcvkp7bGqxXmVSza1AAVAIvucw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] test/py: android: Point fdt command to aligned
 addresses
Date: Wed, 19 Nov 2025 20:32:52 +0100
Message-ID: <20251119193311.127633-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
References: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 872c20368ee39b061ff
X-MBO-RS-META: mw3z1d915s73hmoq9gcyye4xk4u3bzed
X-Rspamd-Queue-Id: 4dBWqP1LGBz9v0r
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
V2: No change
V3: No change
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

