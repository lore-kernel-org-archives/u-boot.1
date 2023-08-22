Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78627EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C362885CB5;
	Tue, 22 Aug 2023 20:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rF11UH/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0DB86488; Tue, 22 Aug 2023 20:49:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C23855CE
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MInAuI051473;
 Tue, 22 Aug 2023 13:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692730150;
 bh=5uBDv9PjETgWHDyDJ19BCVIYKPGfrDyz4CPVDWfngug=;
 h=From:To:CC:Subject:Date;
 b=rF11UH/hLx4bd4sxeAPFd4qcSEuaZBaR3xxUL3GoqGFGVgnyNzJf7Bn+mtmyb3R+0
 /N4vqCvlxt97fYzhzKXYbc6b9+gGLb9lzhs7mv7aBZ+97sE+lvnNrqK/ZKjNKx41UZ
 EjlTzXQZ/bUXZn2y9oJ5uVuY5naY0iBchY8HFBRA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MInApR108823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 13:49:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 13:49:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 13:49:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MIn9b6009069;
 Tue, 22 Aug 2023 13:49:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>, Nishanth
 Menon <nm@ti.com>, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] doc: board: ti: k3: Fix up OpenOCD references and debug info
Date: Tue, 22 Aug 2023 13:49:03 -0500
Message-ID: <20230822184903.2331330-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Jonathan Humphreys <j-humphreys@ti.com>

Fix minor path and config macro name updates to sync with latest
OpenOCD and U-Boot configurations.

Fixes: effe50854a69 ("doc: board: ti: k3: Add a guide to debugging with OpenOCD")
Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

 doc/board/ti/k3.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 83fb0f121bb9..f9336b3a3622 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -601,7 +601,7 @@ correctly to ensure a sane system.
   $ cd openocd
   # Copy the udev rules to the correct system location
   $ sudo cp ./contrib/60-openocd.rules \
-      ./src/JTAG/drivers/libjaylink/contrib/99-libjaylink.rules \
+      ./src/jtag/drivers/libjaylink/contrib/99-libjaylink.rules \
       /etc/udev/rules.d/
   # Get Udev to load the new rules up
   $ sudo udevadm control --reload-rules
@@ -792,7 +792,7 @@ Code modification
   In this example, we will debug ``board_init_f`` inside
   ``arch/arm/mach-k3/{soc}_init.c``. Since some sections of U-Boot
   will be executed multiple times during the bootup process of K3
-  devices, we will need to include either ``CONFIG_CPU_ARM64`` or
+  devices, we will need to include either ``CONFIG_ARM64`` or
   ``CONFIG_CPU_V7R`` to catch the CPU at the desired place during the
   bootup process (Main or Wakeup domains). For example, modify the
   file as follows (depending on need):
@@ -810,7 +810,7 @@ Code modification
       }
       ...
       /* Code to run on the ARMV8 (Main Domain) */
-      if (IS_ENABLED(CONFIG_CPU_ARM64)) {
+      if (IS_ENABLED(CONFIG_ARM64)) {
           volatile int x = 1;
           while(x) {};
       }
-- 
2.40.0

