Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17FDEE499C
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 02:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BE9869C5;
	Sat, 19 Aug 2023 04:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LcDZC0f4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95587869C8; Sat, 19 Aug 2023 04:58:16 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BAAC868CB
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 04:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 66BA6401C0; 
 Sat, 19 Aug 2023 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692413893;
 bh=05jfv8GJ2J8s9e/m5ZikqBWi/fC6G4n0B+PSUDBITOc=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=LcDZC0f4b6CJY4Bkh0e27FCnUrYHG0RRBr87xCDgfvD+m9kAYK1QYUWkdHJmta3Vv
 8beW6GGpzsYqN1ADmk4KR0j1qwrVIdNKctJ00P8ke3egTcpaP38sOewhwSp2N3am+I
 xXFZYS9c/kmVPvrZvLWH49jcEZ9daT655k9R6C1BDXBHSLMOxsVDHmeEjCNkJhnuyf
 a1CEhGiBvB3Y4gVTVTEb7siPitd3AkitCVXP1Iv2/PI75bcd7dOmGAoNyu7VDH3p8X
 iBibXNbl7he3dUrTKyHTydK29wL/xUeXab1E61eibfFNVXAV9TxDtyGRVnDXvXqlYb
 JsWG8sUy6oMlw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: board: ti: am62x: provide image alt texts
Date: Sat, 19 Aug 2023 04:59:00 +0200
Message-Id: <20230819025900.30500-1-heinrich.schuchardt@canonical.com>
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

Provide alternative texts for images.

Fixes: 34f76921d801 ("doc: board: ti: am62x: Convert the image format to svg")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/ti/am62x_sk.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 5ed17c0a3a..42b37f9c76 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -47,6 +47,7 @@ Boot Flow:
 Below is the pictorial representation of boot flow:
 
 .. image:: img/boot_diagram_k3_current.svg
+  :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
   requests TIFS to get these services done as shown in the above diagram.
@@ -141,10 +142,12 @@ Image formats:
 - tiboot3.bin
 
 .. image:: img/multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
 
 - tispl.bin
 
 .. image:: img/dm_tispl.bin.svg
+  :alt: tispl.bin image format
 
 A53 SPL DDR Memory Layout
 -------------------------
-- 
2.40.1

