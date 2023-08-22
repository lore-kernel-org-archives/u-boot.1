Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED50EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B190864EB;
	Tue, 22 Aug 2023 18:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yXbADBzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A78864E2; Tue, 22 Aug 2023 18:41:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C59864B3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfB5i078812;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=tp9VeiEe96NtYTfhEfapsd4T0nessE46eCrUOXzf7IM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yXbADBzEe/P1h/Yppd7wEuRlwDF2RKrzPKjof+piSvswiXMBTw3TcWw+fARgA8hXf
 7maQHNXysA4FSrMVXgUUF+ytDCXZRKcEF9ku8eRaGS6oGh0T9prKUiDKMhPZghOI6O
 4vHYMNAJZ0jthis5SgX6+RWbMK698wdlkBjCB7wI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfBKH105302
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfA05028360;
 Tue, 22 Aug 2023 11:41:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/13] doc: board: ti: j7200: provide image alt text
Date: Tue, 22 Aug 2023 11:41:00 -0500
Message-ID: <20230822164107.2272231-7-nm@ti.com>
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

Provide alternative text for image.

Fixes: f4ade09a1e76 ("doc: board: ti: j7200: Convert the image format to svg")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
new

 doc/board/ti/j7200_evm.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 2e60e22ba151..2bf680cda2c7 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -35,6 +35,7 @@ Boot Flow:
 Below is the pictorial representation of boot flow:
 
 .. image:: img/boot_diagram_k3_current.svg
+  :alt: Boot flow diagram
 
 - Here DMSC acts as master and provides all the critical services. R5/A72
   requests DMSC to get these services done as shown in the above diagram.
@@ -130,12 +131,12 @@ Image formats:
 - tiboot3.bin
 
 .. image:: img/j7200_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
 
 - tispl.bin
 
 .. image:: img/dm_tispl.bin.svg
-
-
+  :alt: tispl.bin image format
 
 Switch Setting for Boot Mode
 ----------------------------
@@ -191,6 +192,7 @@ Size of u-boot.img is taken 4MB for refernece,
 But this is subject to change depending upon atf, optee size
 
 .. image:: img/emmc_j7200_evm_boot01.svg
+  :alt: Traditional eMMC boot partition layout
 
 In case of UDA FS mode booting, following is layout.
 
@@ -198,6 +200,7 @@ All boot images tiboot3.bin, tispl and u-boot should be written to
 fat formatted UDA FS as file.
 
 .. image:: img/emmc_j7200_evm_udafs.svg
+  :alt: eMMC UDA boot partition layout
 
 In case of booting from eMMC, write above images into raw or UDA FS.
 and set mmc partconf accordingly.
-- 
2.40.0

