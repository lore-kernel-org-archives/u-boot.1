Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752A1C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3743640807;
	Mon, 17 Aug 2026 15:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EErpFryH0QA8; Mon, 17 Aug 2026 15:33:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB4D540715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980814;
	bh=3ph/3TrvWKm3OMr1POI0pEDlVCt7Paj/JnfXnjN9NAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D33kiOOaXqg01cQPY6AnxmNXeoq5F0KUYv83ppNTdd09FahrY+7+WtCuWdeurhrOR
	 LSTN5viavE2Tw7oyIVpB4bRDf2IOkk+Zr0DOPaDVAx/MfSgjk1G8WK9I6yIQwPEFZu
	 iOdoC1X1xTkbRUPdrChbzbCgbZS40vWsTZhN9lUKx8ZVZfz26ArOVWr91Q4OC7Dswe
	 R/uGUSbQa/W9OxSezzpQDM42V/09GTc0+5IrLxRAPytEMsWSeZYh12FfjhqDsCM299
	 nOeInJBkJx+DaRU0h4jC8dT2RQYUJLLsxc4BBXi68ST/Xdpx5fKvt44HieC+mPPg5T
	 MJ6E7yWhaljdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB4D540715;
	Mon, 17 Aug 2026 15:33:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A18C194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8017A80EAB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDtECyye1oJW for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:33:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7B4F280EC5
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B4F280EC5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=gUeVkGZ0
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B4F280EC5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D4420B005A9;
 Mon, 17 Aug 2026 17:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980809;
 bh=xBqItaw8mRmA/+1vE8gu8O3/brqaj4id6pU7LqUoYR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gUeVkGZ0snrf5JZzbYn4QQY9GEnmBmOynFimiiyAto5KuNYS3D6JVu3seY8bdzC62
 vnvOQKO/yVz64HEmzDULDo8PsYzpPvRHIyhjFaiPVvvgV6Qf9jo40m0Py1DZbEnpQl
 mjy4cn816aOBs3r1jffhFu6VWhbuCajNbeoK5yyzjzMdjOFV1t56Y+KG2b8dc1TyV8
 6dR9rYtZhMWR+sco6QpuVT6O+SoGZbR7xUm55U6yMzfxUJKnqEhlmukjfWFuo1cZUM
 fzwsNdClg6WBZYN1zTFiZ3z2iC0vdc4sGJVFC6DzhTMseJ4qLZuuVUFDGAGwRzX7I3
 ZeNCJwRETlY/Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 05/23] board: nbxv3: add boot-time PMBus PSU traces
Date: Mon, 17 Aug 2026 17:31:23 +0200
Message-ID: <20260817153144.1951036-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Reuses the shared
  pmbus_print_telemetry() / pmbus_print_status_word() helpers,
for the 48V->12V Flex PSU reports.

The PSU is a carrier device: its DT node
  compatible = "pmbus",
  regulator-name = "psu-48v",
  pmbus,num-pages = <2>

sits behind the carrier SMBus mux tree, described with the I2C buses
later in this series. Until then no generic PMBus regulator is bound
and the hook prints nothing.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/psu_pmbus.c | 80 +++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/psu_pmbus.c

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index e4aa5309804..24874138833 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -4,3 +4,4 @@
 
 obj-y += eth_nbxv3.o
 obj-y += mps_pmbus.o
+obj-y += psu_pmbus.o
diff --git a/board/nxp/lx2160a/nbxv3/psu_pmbus.c b/board/nxp/lx2160a/nbxv3/psu_pmbus.c
new file mode 100644
index 00000000000..33cd0b1f5ed
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/psu_pmbus.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 boot-time snapshot of the carrier PMBus PSU(s).
+ *
+ * Companion to mps_pmbus.c, which snapshots the on-module MPS MPQ8646
+ * core regulator (+0V8_VDD) at boot.
+ *
+ * This file covers the other class of PMBus device the board carries:
+ * spec-compliant PSU bricks with no per-chip driver, bound to the generic
+ * `pmbus_generic_regulator` (compatible = "pmbus").
+ *
+ * On nbxv3 that is the Flex 48 V -> 12 V PSU.
+ */
+
+#include <dm.h>
+#include <event.h>
+#include <i2c.h>
+#include <pmbus.h>
+#include <dm/uclass.h>
+#include <power/regulator.h>
+
+#define NBXV3_GENERIC_PMBUS_DRIVER	"pmbus_generic_regulator"
+
+static void nbxv3_psu_snapshot_one(struct udevice *reg)
+{
+	struct udevice *parent = dev_get_parent(reg);
+	struct udevice *chip;
+	int bus_seq, addr;
+	const struct pmbus_active_dev *act;
+
+	if (!parent || device_get_uclass_id(parent) != UCLASS_I2C)
+		return;
+	bus_seq = dev_seq(parent);
+	addr = dev_read_addr(reg);
+	if (addr < 0 || addr > 0x7f)
+		return;
+
+	/* Select the device: caches MFR_* + reuses the generic info. */
+	if (pmbus_set_active(bus_seq, (u8)addr))
+		return;
+	act = pmbus_active();
+	if (!act)
+		return;
+	if (pmbus_active_get_i2c(&chip))
+		return;
+
+	printf("PMBus PSU @ i2c%d:0x%02x", act->bus_seq, act->addr);
+	if (act->name[0])
+		printf("  rail=\"%s\"", act->name);
+	if (act->mfr_id[0])
+		printf("  MFR_ID=\"%s\"", act->mfr_id);
+	if (act->mfr_model[0])
+		printf("  MODEL=\"%s\"", act->mfr_model);
+	printf("\n");
+
+	pmbus_print_telemetry(chip);
+
+	pmbus_print_status_word(chip);
+}
+
+static int nbxv3_psu_pmbus_last_stage_init(void)
+{
+	struct udevice *reg;
+	struct uclass *uc;
+
+	if (uclass_get(UCLASS_REGULATOR, &uc))
+		return 0;
+
+	uclass_foreach_dev(reg, uc) {
+		if (!reg->driver || !reg->driver->name)
+			continue;
+		if (strcmp(reg->driver->name, NBXV3_GENERIC_PMBUS_DRIVER))
+			continue;
+		nbxv3_psu_snapshot_one(reg);
+	}
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_psu_pmbus_last_stage_init);
-- 
2.43.0

