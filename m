Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71D0C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE3B87835;
	Tue, 19 Dec 2023 12:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bw9El5GL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482BB871C7; Tue, 19 Dec 2023 11:34:50 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD2A86C68
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAYTHm005550;
 Tue, 19 Dec 2023 04:34:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702982069;
 bh=fBreZmf/hIAKOi+L6jlv7d1IFT7IKQMj/yQ6UDotVQ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Bw9El5GLtC6OpTw54MhkEE4afGwoiIDL3WuqTi2fR7BDHHkDgNdEHH58dyRzTPpLa
 5RjykHGFWXRRoqzs8o9c8uKPolBQc8veGuHkz8L2R4yyEAHWjIAUZ+J4hJFePPw9nu
 927dMqNJKYsd6KqBIfqxlm7u1rUZDd9MLnUPBmKc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJAYTuC057438
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:34:29 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:34:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:34:29 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAYThi070989;
 Tue, 19 Dec 2023 04:34:29 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJAYSBm022781;
 Tue, 19 Dec 2023 04:34:28 -0600
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
Subject: [RFC PATCH 04/16] net: ti: icssg: Add icssg queues APIs and macros
Date: Tue, 19 Dec 2023 16:04:06 +0530
Message-ID: <20231219103418.3445886-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219103418.3445886-1-danishanwar@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
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

Add icssg_queue.c file. This file introduces macros and APIs related to
ICSSG queues. These will be used by ICSSG Ethernet driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ti/icssg_prueth.h |  5 ++++
 drivers/net/ti/icssg_queues.c | 51 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 drivers/net/ti/icssg_queues.c

diff --git a/drivers/net/ti/icssg_prueth.h b/drivers/net/ti/icssg_prueth.h
index 26b77dd8f3..f34ab5d6d4 100644
--- a/drivers/net/ti/icssg_prueth.h
+++ b/drivers/net/ti/icssg_prueth.h
@@ -75,4 +75,9 @@ void icssg_config_ipg(struct prueth *prueth, int speed, int mii);
 int icssg_config(struct prueth *prueth);
 int emac_set_port_state(struct prueth *prueth, enum icssg_port_state_cmd cmd);
 
+/* Buffer queue helpers */
+int icssg_queue_pop(struct prueth *prueth, u8 queue);
+void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
+u32 icssg_queue_level(struct prueth *prueth, int queue);
+
 #endif /* __NET_TI_ICSSG_PRUETH_H */
diff --git a/drivers/net/ti/icssg_queues.c b/drivers/net/ti/icssg_queues.c
new file mode 100644
index 0000000000..6a95ef5d58
--- /dev/null
+++ b/drivers/net/ti/icssg_queues.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* ICSSG Buffer queue helpers
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <dm/ofnode.h>
+#include <regmap.h>
+#include "icssg_prueth.h"
+
+#define ICSSG_QUEUES_MAX		64
+#define ICSSG_QUEUE_OFFSET		0xd00
+#define ICSSG_QUEUE_PEEK_OFFSET		0xe00
+#define ICSSG_QUEUE_CNT_OFFSET		0xe40
+#define	ICSSG_QUEUE_RESET_OFFSET	0xf40
+
+int icssg_queue_pop(struct prueth *prueth, u8 queue)
+{
+	u32 val, cnt;
+
+	if (queue >= ICSSG_QUEUES_MAX)
+		return -EINVAL;
+
+	regmap_read(prueth->miig_rt, ICSSG_QUEUE_CNT_OFFSET + 4 * queue, &cnt);
+	if (!cnt)
+		return -EINVAL;
+
+	regmap_read(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, &val);
+
+	return val;
+}
+
+void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
+{
+	if (queue >= ICSSG_QUEUES_MAX)
+		return;
+
+	regmap_write(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, addr);
+}
+
+u32 icssg_queue_level(struct prueth *prueth, int queue)
+{
+	u32 reg;
+
+	if (queue >= ICSSG_QUEUES_MAX)
+		return 0;
+
+	regmap_read(prueth->miig_rt, ICSSG_QUEUE_CNT_OFFSET + 4 * queue, &reg);
+
+	return reg;
+}
-- 
2.34.1

