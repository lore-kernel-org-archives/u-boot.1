Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077CEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFCA864FF;
	Tue, 22 Aug 2023 18:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FD1S/3iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63568646D; Tue, 22 Aug 2023 18:41:23 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D507864D2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDcW048842;
 Tue, 22 Aug 2023 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722473;
 bh=VZko7r9QAiqEnEnBqLG2TJpvEGSyKMmIS7hfTelkzJI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FD1S/3iGRnDpOFugl0bNW96V5FMbBV9czAvk0bNvtF1k72YlLDSColKRYk6dnODB2
 U3Jnbhag3JcLNevkCIa7QwId94vbQxg+Dw5oktWYVWFG4u+PiLH7KrBrQ6+ajqMWKK
 bnlgvUA+Ha0ltrq5L0hO4B3Z+WN1/uj3G6AAEuAo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfDIA071252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfDdo121077;
 Tue, 22 Aug 2023 11:41:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 11/13] doc: board: ti: j7200: Fix build step numbering
Date: Tue, 22 Aug 2023 11:41:05 -0500
Message-ID: <20230822164107.2272231-12-nm@ti.com>
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
 doc/board/ti/j7200_evm.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 2bf680cda2c7..bcf8dc1c5f0d 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -92,13 +92,13 @@ Set the variables corresponding to this platform:
 
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
@@ -112,18 +112,18 @@ variant (GP, HS-FS, HS-SE) requires a different source for these files.
 
  - GP
 
-        * tiboot3-j7200-gp-evm.bin from step 4.1
-        * tispl.bin_unsigned, u-boot.img_unsigned from step 4.2
+        * tiboot3-j7200-gp-evm.bin from step 3.1
+        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
 
  - HS-FS
 
-        * tiboot3-j7200_sr2-hs-fs-evm.bin from step 4.1
-        * tispl.bin, u-boot.img from step 4.2
+        * tiboot3-j7200_sr2-hs-fs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
 
  - HS-SE
 
-        * tiboot3-j7200_sr2-hs-evm.bin from step 4.1
-        * tispl.bin, u-boot.img from step 4.2
+        * tiboot3-j7200_sr2-hs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
 
 Image formats:
 --------------
-- 
2.40.0

