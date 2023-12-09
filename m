Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71721C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B160D876A7;
	Sat,  9 Dec 2023 19:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hP2T/7om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C236787215; Sat,  9 Dec 2023 19:54:21 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0FA8769A
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D260F4347F; 
 Sat,  9 Dec 2023 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702148055;
 bh=O9VwaOLVUrEEVCoXjHluhDFi7U4c/S8z6qdRm2jzUnE=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=hP2T/7om2WEwCgR36J+amjgjgI7nZYN/q3BMfAaIH6PTiRy04CgPbNHcwveZiGUxI
 cqjr98kArQfd8io2YSXu0J8x5mkvigjAsZuguv0/6o0zySMViOpylEsfTOyZ9FG62m
 6GgkVaEhJJboPu1QEJL/1kabB/bASLyXkl3R1jci6PsPuQXlO7ZVzNnmbn05jAVl0U
 0MBsMWYlbsz5WwO1fi8cYTpfY3p/MquAEaz9PVWtUj8XBEX56SHG49bwWwNSuFHYwj
 +pKIGWGys+DQexkzxWCpQKRgLjDWHv4jK0stfKFu/QbohYPK2FbcpTfyhirgg+MzDp
 2ixo1tm/Om2uw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] test: vboot: Using variable 'old_dtb' before assignment
Date: Sat,  9 Dec 2023 19:54:11 +0100
Message-Id: <20231209185411.8212-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
References: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
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

old_dtb can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_vboot.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 04fa59f98b..7e0e8e4475 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -533,10 +533,10 @@ def test_vboot(u_boot_console, name, sha_algo, padding, sign_options, required,
     with open(evil_kernel, 'wb') as fd:
         fd.write(500 * b'\x01')
 
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = cons.config.dtb
     try:
-        # We need to use our own device tree file. Remember to restore it
-        # afterwards.
-        old_dtb = cons.config.dtb
         cons.config.dtb = dtb
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
-- 
2.40.1

