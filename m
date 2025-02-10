Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF055C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A86080BAF;
	Mon, 10 Feb 2025 12:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="izrA/qLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6651480C77; Mon, 10 Feb 2025 12:23:30 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2D880BA8
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABNHNd3399021
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 05:23:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186597;
 bh=loY8/0lGyv8CQipP/v8KNcr2ZONJNxzOnCfOPEMd9zQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=izrA/qLmLpxIYhI+yqpzyTxY6c/j+J/P9eTmmretJ9hT0G8boE4EpBORQ6hEpB/Di
 H+LtWps0f7zruGiaZCV0/agdWc3ETUS1xsiGHF9W7SGeSFB1cx3VET0C1zByZ3k5fA
 91YzaDqYZzS5lP1rszJqp1GSWu6jcMsI6W5hzDqA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABNH1K025659
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 05:23:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:23:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:23:17 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMdb7047041; 
 Mon, 10 Feb 2025 05:23:11 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <vaishnav.a@ti.com>, 
 <j-choudhary@ti.com>, <mkorpershoek@baylibre.com>, <rogerq@kernel.org>,
 <hnagalla@ti.com>, <glaroque@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <j-humphreys@ti.com>, <quentin.schulz@cherry.de>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 5/7] board: ti: j722s: env: include environment for DFU
Date: Mon, 10 Feb 2025 16:52:28 +0530
Message-ID: <20250210112239.2639009-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210112239.2639009-1-s-vadapalli@ti.com>
References: <20250210112239.2639009-1-s-vadapalli@ti.com>
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

Include the TI K3 DFU environment to support DFU Boot and DFU Flash.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch has been newly introduced in this series.

Regards,
Siddharth.

 board/ti/j722s/j722s.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/j722s/j722s.env b/board/ti/j722s/j722s.env
index f8b6aff2c2..853526bc66 100644
--- a/board/ti/j722s/j722s.env
+++ b/board/ti/j722s/j722s.env
@@ -1,5 +1,6 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
 
 name_kern=Image
 console=ttyS2,115200n8
-- 
2.43.0

