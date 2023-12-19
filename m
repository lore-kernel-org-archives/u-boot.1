Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A72C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD3D87729;
	Tue, 19 Dec 2023 12:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TU8j57/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D7DD86FBD; Tue, 19 Dec 2023 11:13:42 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE1D86F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADXqv041171;
 Tue, 19 Dec 2023 04:13:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980813;
 bh=CEnohX8xGs14x5U1ZrsEIMr/2vD4MHXzt8TcUjXwKtE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TU8j57/Dw3tF/Es1dp6peNriqp7buZkxXWqion6f0/fXt4B9/lt9z981xFwyqoXrF
 2B2QDV3+kzor8WfCJ3q3PTkeo04orBBQI3g1jWgWrGsKntfwBq+YXkcuj65dp643VP
 t0jMfpNW24DO/+k5tbQdoWDD8CW1ZEymYhvATIgc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJADX56005384
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:13:33 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:13:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:13:32 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADWJI045563;
 Tue, 19 Dec 2023 04:13:32 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJADVZt010621;
 Tue, 19 Dec 2023 04:13:32 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 16/16] Revert "dm: core: Report bootph-pre-ram/sram node
 as pre-reloc after relocation"
Date: Tue, 19 Dec 2023 15:42:25 +0530
Message-ID: <20231219101225.3443978-33-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

This reverts commit 9e644284ab812f2db23f6185af77c0e771b0be73.
---
 drivers/core/ofnode.c | 2 +-
 include/dm/ofnode.h   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 21a233f90f..cc2029e62d 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1485,7 +1485,7 @@ bool ofnode_pre_reloc(ofnode node)
 	 */
 	if (ofnode_read_bool(node, "bootph-pre-ram") ||
 	    ofnode_read_bool(node, "bootph-pre-sram"))
-		return gd->flags & GD_FLG_RELOC;
+		return true;
 
 	if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
 		/* detect and handle old tags */
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 5795115c49..5f1c8c2787 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1254,15 +1254,15 @@ int ofnode_read_simple_size_cells(ofnode node);
  * determine if a node was bound in one of SPL/TPL stages.
  *
  * There are 4 settings currently in use
- * - bootph-some-ram: U-Boot proper pre-relocation phase
+ * - bootph-some-ram: U-Boot proper pre-relocation only
  * - bootph-all: all phases
  * Existing platforms only use it to indicate nodes needed in
  * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
- * - bootph-pre-ram: SPL phase
- * - bootph-pre-sram: TPL phase
+ * - bootph-pre-ram: SPL and U-Boot pre-relocation
+ * - bootph-pre-sram: TPL and U-Boot pre-relocation
  *
  * @node: node to check
- * Return: true if node should be or was bound, false otherwise
+ * Return: true if node is needed in SPL/TL, false otherwise
  */
 bool ofnode_pre_reloc(ofnode node);
 
-- 
2.34.1

