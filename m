Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEBEEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA0A864DC;
	Tue, 22 Aug 2023 18:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s8JyDn5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BE6864D5; Tue, 22 Aug 2023 18:41:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43E5864AB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBGn078808;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=H87oeZfRVdv3hafNvEYJa99fLRk3TXNevRaBqVxsgM8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=s8JyDn5YCdzeJk/uNQnH0/koIPPRGbJvydmHAcBkKzyXdZJ1J4QPjqD1XqWPb30NB
 fBC5IYUHLmDF3IYj8DwkFCNY8yJ12230z+pzB9a1DG+DYWrXK0rebenKuYnvf/6aPn
 CCVboawcTISaGiD2mq1qE8M/l+f9l8ZV14aB1wKY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfB9H007421
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfA9u022031;
 Tue, 22 Aug 2023 11:41:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 03/13] doc: board: ti: am62x: provide image alt texts
Date: Tue, 22 Aug 2023 11:40:57 -0500
Message-ID: <20230822164107.2272231-4-nm@ti.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Provide alternative texts for images.

Fixes: 34f76921d801 ("doc: board: ti: am62x: Convert the image format to svg")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change.

V1: https://lore.kernel.org/r/20230819025900.30500-1-heinrich.schuchardt@canonical.com

 doc/board/ti/am62x_sk.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 5ed17c0a3a51..42b37f9c76fd 100644
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
2.40.0

