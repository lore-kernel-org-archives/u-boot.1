Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A032287B5D;
	Tue, 31 Oct 2023 14:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xpUXPDyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782D687B53; Tue, 31 Oct 2023 14:28:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3740487C9E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSI7f063417;
 Tue, 31 Oct 2023 08:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698758898;
 bh=4yDXctINbHO8Be3KLaH4gBu2UT3S2ubpYzxSnEDA+zY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xpUXPDyuEg1Y3LtfeyqRNlRwo0xC35osee3aLL0dPPYbmZ/zFoEa9TztZzXKpU58D
 BfOHCXB8MTuNlbAZrdUX1BU4ZyPqnZDHe4YqA+Z5ZuMIVry1UMjgrpcVbBsCFb9I5U
 EXQ7Z8WCSdmwKbL6DJzxs1+dkqLLUfQXCJlyRk6A=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDSI5S111311
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:28:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:28:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:28:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSHEV030443;
 Tue, 31 Oct 2023 08:28:17 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 5/6] board: ti: am62x: Add am62xsip_sk_r5.config defconfig
 fragment
Date: Tue, 31 Oct 2023 18:58:08 +0530
Message-ID: <20231031132809.1524341-6-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031132809.1524341-1-n-yadav@ti.com>
References: <20231031132809.1524341-1-n-yadav@ti.com>
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

Add config fragments am62xsip_sk_r5.config for R5 configuration.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 board/ti/am62x/am62xsip_sk_r5.config | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 board/ti/am62x/am62xsip_sk_r5.config

diff --git a/board/ti/am62x/am62xsip_sk_r5.config b/board/ti/am62x/am62xsip_sk_r5.config
new file mode 100644
index 0000000000..75acc4cedc
--- /dev/null
+++ b/board/ti/am62x/am62xsip_sk_r5.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of am62x_evm_r5_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62sip-r5-sk"
+CONFIG_SPL_OF_LIST="k3-am62sip-r5-sk"
+CONFIG_OF_LIST="k3-am62sip-r5-sk"
-- 
2.25.1

