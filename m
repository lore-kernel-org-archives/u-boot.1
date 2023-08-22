Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD986EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26BD4864E3;
	Tue, 22 Aug 2023 18:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OX9ghtzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFA7864CB; Tue, 22 Aug 2023 18:41:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6782864B6
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBwt078804;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=ERo7dV0tfPTLTNIBuiD5FLjq8FvAlbvGmekWqkpImcA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OX9ghtzCZWZu7OBDclL0NQnbfbQgN2J6u5sVPJBr6qrgDoc+1r6a7bhC2vG6V/SnS
 Nc+Ug6hpy7durTtp1g4hrBiagFpBT4R8wTV2l//H9QIpnHjQtf7eu8ovHOCVlndb58
 djPIAS2O7GSu7OwVUYGhzlj54/Qg7g6erF1vwfRI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfB9G007421
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfAQh020725;
 Tue, 22 Aug 2023 11:41:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 02/13] doc: board: ti: k3: Fixup alt text for openocd sequence
Date: Tue, 22 Aug 2023 11:40:56 -0500
Message-ID: <20230822164107.2272231-3-nm@ti.com>
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

Fix up OpenOCD setup sequence

Fixes: effe50854a69 ("doc: board: ti: k3: Add a guide to debugging with OpenOCD")
Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
New in the series.
 doc/board/ti/k3.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 843e66eb2e60..e7c8d37dd269 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -489,6 +489,7 @@ generation device.
 The overall structure of this setup is in the following figure.
 
 .. image:: img/openocd-overview.svg
+  :alt: Overview of OpenOCD setup.
 
 .. note::
 
-- 
2.40.0

