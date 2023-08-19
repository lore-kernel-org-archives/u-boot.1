Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EF2EE49A2
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 02:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9D9868D0;
	Sat, 19 Aug 2023 04:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ye1iKG6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE3586904; Sat, 19 Aug 2023 04:49:07 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B743A868CB
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 04:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 20D2B3F326; 
 Sat, 19 Aug 2023 02:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692413344;
 bh=0Cj7bSu5zAfk9WO61gu5WWWVu/vO6ywTD46SZGwFgSg=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Ye1iKG6pb7jfkA5+ldaTNGy7nPlBIi/s4YEmsJbXBFV+OlVf9jTT4dnXGENORhlJB
 zhvWgxSH82wdz9uGC5c6ucwLblywKy2NjYUFBGpLxdcFp3eM4XJToHbRzkQ3vmJlnt
 4lgOIcvta1J8g4DPWT043uua4wdLowrZ4+EFgQ8RNDDClXUkDCXG7CAzyk37fiu9+u
 XaPjhUrfnXmAZzAH7tctEQqENnJ/XyBqEB5WRjf/kpXiOlVEOTEJ8UutNClB10jYBZ
 WVEm609tQrKpPimSqyeIa/WfdDIdENwD6DEaOdJybOSulEKPiHqeFDWpxAgkcPXmoz
 zlRReELOhPggA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: board: ti: k3: image alt texts
Date: Sat, 19 Aug 2023 04:49:48 +0200
Message-Id: <20230819024948.30103-1-heinrich.schuchardt@canonical.com>
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

Fixes: 6e8fa0611f19 ("board: ti: k3: Convert boot flow ascii flow to svg")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/ti/k3.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index f4576c54cb..8c78e40730 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -47,6 +47,7 @@ including a 32bit U-Boot SPL, (called the wakup SPL) that ROM will jump
 to after it has finished loading everything into internal SRAM.
 
 .. image:: img/boot_flow_01.svg
+  :alt: Boot flow up to WKUP SPL
 
 The wakeup SPL, running on a wakeup domain core, will initialize DDR and
 any peripherals needed load the larger binaries inside the `tispl.bin`
@@ -56,6 +57,7 @@ starting with Trusted Firmware-A (TF-A), before moving on to start
 OP-TEE and the main domain's U-Boot SPL.
 
 .. image:: img/boot_flow_02.svg
+  :alt: Boot flow up to main SPL
 
 The main domain's SPL, running on a 64bit application core, has
 virtually unlimited space (billions of bytes now that DDR is working) to
@@ -64,6 +66,7 @@ which loads more firmware into the micro-controller & wakeup domains and
 finally prepare the main domain to run Linux.
 
 .. image:: img/boot_flow_03.svg
+  :alt: Boot flow up to Linux
 
 This is the typical boot flow for all K3 based SoCs, however this flow
 offers quite a lot in the terms of flexibility, especially on High
-- 
2.40.1

