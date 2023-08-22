Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDE5EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB1F864DB;
	Tue, 22 Aug 2023 18:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kHCxWxKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745B2864B6; Tue, 22 Aug 2023 18:41:25 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2692E864D4
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDPf022216;
 Tue, 22 Aug 2023 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722473;
 bh=l4COvh00F+440nURzDcnj8GiPJopnsHxPrg1N+Hk0mM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kHCxWxKTQOm3C9UGluna/+LcgP4s810lPdWrUOgyuzbsVG8ENJkNrhs3wxWjpjD33
 ngd5mynbgVL8uI/PzgwJipOz7HSCdQ+apXhDcCvOTmZ7pas+4slCCT3uOGnT3SIbHL
 m8araXGR+JN7QGUgUaDCum6fTYtR1AI/1diTo2kU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfDSB007453
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:13 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDGZ028380;
 Tue, 22 Aug 2023 11:41:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 12/13] doc: board: ti: j721e: Fix build step numbering
Date: Tue, 22 Aug 2023 11:41:06 -0500
Message-ID: <20230822164107.2272231-13-nm@ti.com>
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
 doc/board/ti/j721e_evm.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index a4c464707c6a..cadaac017811 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -97,13 +97,13 @@ Set the variables corresponding to this platform:
 
 3. U-Boot:
 
-* 4.1 R5:
+* 3.1 R5:
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_build_steps_spl_r5
     :end-before: .. k3_rst_include_end_build_steps_spl_r5
 
-* 4.2 A72:
+* 3.2 A72:
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_build_steps_uboot
@@ -118,18 +118,18 @@ files.
 
  - GP
 
-        * tiboot3-j721e-gp-evm.bin, sysfw-j721e-gp-evm.itb from step 4.1
-        * tispl.bin_unsigned, u-boot.img_unsigned from step 4.2
+        * tiboot3-j721e-gp-evm.bin, sysfw-j721e-gp-evm.itb from step 3.1
+        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
 
  - HS-FS
 
-        * tiboot3-j721e_sr2-hs-fs-evm.bin, sysfw-j721e_sr2-hs-fs-evm.itb from step 4.1
-        * tispl.bin, u-boot.img from step 4.2
+        * tiboot3-j721e_sr2-hs-fs-evm.bin, sysfw-j721e_sr2-hs-fs-evm.itb from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
 
  - HS-SE
 
-        * tiboot3-j721e_sr2-hs-evm.bin, sysfw-j721e_sr2-hs-evm.itb from step 4.1
-        * tispl.bin, u-boot.img from step 4.2
+        * tiboot3-j721e_sr2-hs-evm.bin, sysfw-j721e_sr2-hs-evm.itb from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
 
 Image formats:
 --------------
-- 
2.40.0

