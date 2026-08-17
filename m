Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D86C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CD8A407F0;
	Mon, 17 Aug 2026 15:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id psZRewJmsD2D; Mon, 17 Aug 2026 15:34:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB52B40706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980884;
	bh=gMA32XkmRzsRZtZg0wlo/eBbExsgUpQwy6av0JrtBNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vk/Ys5ZqL6qlKRn+ocQ9wY/62bZUhHNUQkpN9ehw56OnlMex82m3WZEDTma8GHyYB
	 WUTjYE+CSQe7ggTnycDTTLvsQs7l/LMZsz0flWIjfdKUFhsvLIsNdTMvx0B7Is/lX6
	 TG2WWBx9W5uBXkCfSzL0Wm6+fs6odqUlOiwNqiZtwRtcbby45EN/+Lmtc+Gb9IxcP/
	 U4iWF6OXYCKKnF3yQ6aQW/yZNP/dMpiqLT36FzJsODyXlHS1FZK6uk77RxU0HO2Jc+
	 nYz9FZ0BGL4ONWYezvnIY6eUOU6xGl8bHqb15OgnREGg+CCiH63Rz+EKRGJeOWFqob
	 BkKHFapraQJtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB52B40706;
	Mon, 17 Aug 2026 15:34:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41DBD194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27A8640706
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dHuwLA23jI2q for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:34:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 13D8B406E5
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13D8B406E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=aAJ+IMvX
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13D8B406E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 6D84EB00565;
 Mon, 17 Aug 2026 17:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980880;
 bh=gT+Sj/69FDUVEy2w/WZcVmRH717187WFvEGArK4pIZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aAJ+IMvX9mxzn7BjU/L/L0NDjgPJ3I4EqRDk52AjWvskI2CNjbsclpMu0dI1lXt/R
 kMpZORqsaF8PqqvahKlPr514gFvZCqM8lnadSRn8jPCo/ousAU+kenjzjWqqGBz9Wz
 zKbGA/s/sBGXRaGSqTrdZaMl0xI8z1VV8rDpEVlRfG+6qcSsNyTctlHp9tzxMyvXgG
 00VNiX8fkpXFszXziBDcwhUWwx8u041RuMN1UekoA8S+IIhgiFDWf/CCAN2SsuK+9P
 eCYtnkOSHAUtDh2RLGE/nAhs9oHhqJox4WRi5nBxcqsuV1kyn9225UT+PPmBucGgLT
 0nG77pFzjczkw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 09/23] board: nbxv3: enable +3V3_FAN rail fixed regulator
Date: Mon, 17 Aug 2026 17:31:27 +0200
Message-ID: <20260817153144.1951036-10-vjardin@free.fr>
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

Probes the +3V3_FAN fixed regulator

The rail is regulator-always-on, so the probe drives it on and the FAN
daughterboard's EMC2305 / TMP411 / EEPROM become visible to
  i2c probe

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/Kconfig           |  6 ++++++
 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/fan_power.c | 32 +++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/fan_power.c

diff --git a/board/nxp/lx2160a/Kconfig b/board/nxp/lx2160a/Kconfig
index 12d2e418aa5..efd245bb68a 100644
--- a/board/nxp/lx2160a/Kconfig
+++ b/board/nxp/lx2160a/Kconfig
@@ -83,4 +83,10 @@ config NBXV3_DPLL
 	select DM_SPI
 	select FSL_DSPI
 
+config NBXV3_FAN
+	bool
+	default y
+	select DM_REGULATOR
+	select DM_REGULATOR_FIXED
+
 endif
diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index c8a676fb708..82063017432 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -8,3 +8,4 @@ obj-y += dpll_zl30733.o
 obj-y += mps_pmbus.o
 obj-y += psu_pmbus.o
 obj-y += vid_handoff.o
+obj-y += fan_power.o
diff --git a/board/nxp/lx2160a/nbxv3/fan_power.c b/board/nxp/lx2160a/nbxv3/fan_power.c
new file mode 100644
index 00000000000..faa882b8bf8
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/fan_power.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Enforce Nodebox v3 FAN-daughterboard enable.
+ *
+ * Note: it tequires CONFIG_DM_REGULATOR_FIXED
+ */
+
+#include <dm.h>
+#include <event.h>
+#include <power/regulator.h>
+
+/* `regulator-name = "+3V3_FAN"` in the nbxv3 DTS. */
+#define NBXV3_FAN_REGULATOR_NAME	"+3V3_FAN"
+
+static int nbxv3_fan_power_last_stage_init(void)
+{
+	struct udevice *reg = NULL;
+	int ret;
+
+	if (regulator_get_by_platname(NBXV3_FAN_REGULATOR_NAME, &reg) || !reg)
+		return 0;
+
+	ret = regulator_set_enable_if_allowed(reg, true);
+	if (ret)
+		printf("nbxv3: %s enable failed (%d)\n",
+		       NBXV3_FAN_REGULATOR_NAME, ret);
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_fan_power_last_stage_init);
-- 
2.43.0

