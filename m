Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611DFEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B340886506;
	Tue, 22 Aug 2023 18:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PdaqOXVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DEA8646D; Tue, 22 Aug 2023 18:41:25 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0598864D3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDaA022220;
 Tue, 22 Aug 2023 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722474;
 bh=sReR1ZeSldscgPjL0dMigaXta3IpgzB9vguqWNXnHFE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PdaqOXVKhYV84vMmEqQMCQTv036oPfnca9pOQE+ENC1A6cgR3jxswN0xwIDdWR178
 ZGNPI/EaN99kngG4kR2ecJQnc/KjCJ5oet6FY2IQHs+fRe7COsxjHwisGsGxY1HKEg
 AZFdgoJSv5TCHclASSWGJ/qRSIGHvCfyRP8efCSc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfD1r020577
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:13 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDJf022072;
 Tue, 22 Aug 2023 11:41:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 13/13] doc: board: ti: k3: Elaborate on various firmware
Date: Tue, 22 Aug 2023 11:41:07 -0500
Message-ID: <20230822164107.2272231-14-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822164107.2272231-1-nm@ti.com>
References: <20230822164107.2272231-1-nm@ti.com>
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

Add elaboration text for the various firmware involved for system
management.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/k3.rst | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index e7c8d37dd269..83fb0f121bb9 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -124,11 +124,30 @@ online
   | **source:** https://github.com/OP-TEE/optee_os.git
   | **branch:** master
 
-* **TI Firmware (TIFS, DM, DSMC)**
+* **TI Firmware (TIFS, DM, SYSFW)**
 
   | **source:** https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
   | **branch:** ti-linux-firmware
 
+.. note::
+
+  The TI Firmware required for functionality of the system can be
+  one of the following combination (see platform specific boot diagram for
+  further information as to which component runs on which processor):
+
+  * **TIFS** - TI Foundational Security Firmware - Consists of purely firmware
+    meant to run on the security enclave.
+  * **DM** - Device Management firmware also called TI System Control Interface
+    server (TISCI Server) - This component purely plays the role of managing
+    device resources such as power, clock, interrupts, dma etc. This firmware
+    runs on a dedicated or multi-use microcontroller outside the security
+    enclave.
+
+ OR
+
+  * **SYSFW** - System firmware - consists of both TIFS and DM both running on
+    the security enclave.
+
 .. k3_rst_include_end_boot_sources
 
 Build Procedure
-- 
2.40.0

