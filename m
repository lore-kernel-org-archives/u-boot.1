Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5892EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9734B864D0;
	Tue, 22 Aug 2023 18:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QTNGzZof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85AD8648C; Tue, 22 Aug 2023 18:41:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F61E864D1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDcj078822;
 Tue, 22 Aug 2023 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722473;
 bh=Q8siplntwS3wpi8nUjSB6JJZAEAJhAyAn/FJKG036bM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QTNGzZofCbz3hRsupUFtwRRqLynBA0j7QXF+U0He2UNOQ4X/yV6HtfU2xU2TB1RXY
 aB/U75Oagcflsaut4jRxnc+erbf/TV/Sgxni+CA1gKTMpKQITWnor8CGU6xJ9iNSj9
 ZEWjCSqBRsMtXpDvlK/0wDEIHO3QXsaw7JHMHTiw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfD0S020571
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDjP022069;
 Tue, 22 Aug 2023 11:41:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/13] doc: board: ti: am65x: Fix build step numbering
Date: Tue, 22 Aug 2023 11:41:04 -0500
Message-ID: <20230822164107.2272231-11-nm@ti.com>
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

Fix up build step numbering.

Fixes: c727b81d6530 ("doc: board: ti: k3: Reuse build instructions")
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/am65x_evm.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 10e30f45cfd9..7cebb1ca62d3 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -103,13 +103,13 @@ Set the variables corresponding to this platform:
 
 3. U-Boot:
 
-* 4.1 R5:
+* 3.1 R5:
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_build_steps_spl_r5
     :end-before: .. k3_rst_include_end_build_steps_spl_r5
 
-* 4.2 A53:
+* 3.2 A53:
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_build_steps_uboot
@@ -123,13 +123,13 @@ Each SoC variant (GP and HS) requires a different source for these files.
 
 - GP
 
-        * tiboot3-am65x_sr2-gp-evm.bin, sysfw-am65x_sr2-gp-evm.itb from step 4.1
-        * tispl.bin_unsigned, u-boot.img_unsigned from step 4.2
+        * tiboot3-am65x_sr2-gp-evm.bin, sysfw-am65x_sr2-gp-evm.itb from step 3.1
+        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
 
 - HS
 
-        * tiboot3-am65x_sr2-hs-evm.bin, sysfw-am65x_sr2-hs-evm.itb from step 4.1
-        * tispl.bin, u-boot.img from step 4.2
+        * tiboot3-am65x_sr2-hs-evm.bin, sysfw-am65x_sr2-hs-evm.itb from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
 
 Image formats:
 --------------
-- 
2.40.0

