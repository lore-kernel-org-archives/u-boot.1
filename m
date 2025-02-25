Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E84C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A418481197;
	Tue, 25 Feb 2025 12:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kac4eIPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9889180F56; Tue, 25 Feb 2025 12:49:36 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D5C810DC
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBnPUV1796195
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Feb 2025 05:49:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740484165;
 bh=cud89Ni69XGxzj5LpR61Prtb+5eMbLZh64tCQPfmeDE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kac4eIPHU/AEGPTkWUaLcLlNUURwn/yPN+WeiS90h3aPPfAi4PZn7+j8N0vJQaoyr
 +a1vw7IvsAFrxKx23EQZMefT3z+73YVAqYZh35Ph5DxSG+GPAE3an0mBPWcg5he3Fy
 ztbIeJeD72x/OS7gLy6OJjbjlDe2+XiF0KnkMWPk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBnPuI091487;
 Tue, 25 Feb 2025 05:49:25 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 05:49:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 05:49:24 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBnNuL026680;
 Tue, 25 Feb 2025 05:49:24 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Andrew Davis <afd@ti.com>,
 "Alexander Sverdlin" <alexander.sverdlin@siemens.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Chintan Vankar" <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Jayesh Choudhary" <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof" <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 13/15] board: ti: j722s: evm: Enable cache for J722s
Date: Tue, 25 Feb 2025 17:19:01 +0530
Message-ID: <20250225114903.2080616-14-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225114903.2080616-1-c-vankar@ti.com>
References: <20250225114903.2080616-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Enable cache for J722s to optimize performance of CPU to access data from
memory.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is newly introduced in this series.

 board/ti/j722s/evm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/ti/j722s/evm.c b/board/ti/j722s/evm.c
index f085ecfd37e..793c028b53c 100644
--- a/board/ti/j722s/evm.c
+++ b/board/ti/j722s/evm.c
@@ -8,6 +8,7 @@
 
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <cpu_func.h>
 #include <dm/uclass.h>
 #include <env.h>
 #include <fdt_support.h>
@@ -20,6 +21,13 @@ int board_init(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+void spl_board_init(void)
+{
+	enable_caches();
+}
+#endif
+
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-- 
2.34.1

