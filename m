Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D28BC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6264607AE;
	Mon, 17 Aug 2026 15:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvl4xEXrepJe; Mon, 17 Aug 2026 15:33:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C91F6078F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980832;
	bh=44vBU2BF9TtdVyxnix/79xep8LUYoxfU2YJhGNq2rUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b8MxAvon+eKMwXW2mL+hPofs4wMVLTrNL9SBTqfVsrlFxkTaS0UQvniDmYVLFOBqe
	 i3j4oNrgnd+ZhwHX22FlfUdwzrJ+n9A0zU7FtIdrutO5qti0C6WCo4/ltHdjdEV0ZQ
	 XwgZCSUeBgSQ4ussk/Oh9MEpfaqp8v9HqIzbRnSWO79OoRBzBmywIGBXTbk0SpAcvB
	 URMzILJeT2oVwCYK6jq0E2wGbDkbNKg91naY7tTTZQ/36XtVQaGAMVcnCDz7+WBHIV
	 dw6+ZvxIUqNddCg64RubM3ukct5vErtBDdLEyF3xExM77+HTG8iu7tWWYI5yb8QnbG
	 4Amx81uLTi0Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C91F6078F;
	Mon, 17 Aug 2026 15:33:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D343282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7760E80EB1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_mPspYwkgzN for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:33:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6B63580EC5
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B63580EC5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=VJjaCJ/D
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B63580EC5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id C1FB5B0057C;
 Mon, 17 Aug 2026 17:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980827;
 bh=qZdYPuSJkmtlGogS7wRP6fs4N1Vzf9FZZQ76fV8Kgdk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VJjaCJ/D1KQ7JQGMdpQ88wa8T02lt/0s3PybV9L9ygOEWBqbDKbEVWLDz7jYj9n2a
 evI20sSe81CUAm330KH4lOra9WL3UN/j8QCpAl+MDzdcX9i3Zd3AGlcoK2r3NEy6rI
 tRT2uJEeCw8MzqauvMuXUlFHTsI29rW+OYRONRK1aRechvkrReg+h5a/RpU47K0F8B
 Pnel3tPqsSInqxmdCaPKZ51sJPd8d++0uGt+KtqRlotJILgunIDoohgfeS1VtRhkIG
 j8v7XcsiUIExEYZ2wk+4y+UYW6le3cur75/FYKtAyx/20oixlu27SIPCO3Rjid96Kz
 tl2hMhgs1rvYA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 06/23] board: nbxv3: add VID-fuse driven core voltage
Date: Mon, 17 Aug 2026 17:31:24 +0200
Message-ID: <20260817153144.1951036-7-vjardin@free.fr>
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

Read the LX2160A DCFG_FUSESR.ALTVID / VID fuses, look up the
binned target voltage, and command the rail through the
UCLASS_REGULATOR set_value op

Hooked at EVT_LAST_STAGE_INIT so the rail is at the VID-correct
voltage before the kernel regulator framework probes the chip.

Set nbxv3_vdd_mv to a millivolt integer in [600, 1100] to bypass
the VID fuse and pin the rail at the wanted voltage. Useful for
bench characterisation.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/nbxv3/Makefile      |   1 +
 board/nxp/lx2160a/nbxv3/vid_handoff.c | 146 ++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/vid_handoff.c

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index 24874138833..68fab9bf18f 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -5,3 +5,4 @@
 obj-y += eth_nbxv3.o
 obj-y += mps_pmbus.o
 obj-y += psu_pmbus.o
+obj-y += vid_handoff.o
diff --git a/board/nxp/lx2160a/nbxv3/vid_handoff.c b/board/nxp/lx2160a/nbxv3/vid_handoff.c
new file mode 100644
index 00000000000..4131bd96023
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/vid_handoff.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * Per die core voltage trim for the Nodebox v3 +0V8_VDD rail
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <event.h>
+#include <log.h>
+#include <vsprintf.h>
+#include <asm/io.h>
+#include <asm/arch/immap_lsch3.h>
+#include <power/regulator.h>
+
+#define NBXV3_VDD_REGULATOR_NAME	"+0V8_VDD"
+#define NBXV3_VDD_OVERRIDE_ENV		"nbxv3_vdd_mv"
+#define NBXV3_VDD_MIN_MV		600
+#define NBXV3_VDD_MAX_MV		1100
+
+#define NBXV3_VID_LSB_uV		1953
+#define NBXV3_VID_TOLERANCE_uV		1953
+#define NBXV3_VID_STEP_uV		1953
+#define NBXV3_VID_MAX_ITER		50
+#define NBXV3_VID_PLATEAU_LIMIT		3
+
+static const u16 lx2160a_vid_table[32] = {
+	[0]  = 8250,
+	[1]  = 7875,
+	[2]  = 7750,
+	[16] = 8000,
+	[17] = 8125,
+	[18] = 8250,
+	[20] = 8500,
+};
+
+static int nbxv3_vid_handoff(void)
+{
+	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
+	struct udevice *reg;
+	u32 fusesr;
+	u8 vid;
+	int target_mv, target_uV, actual_uV;
+	char *override_str;
+	unsigned long override_mv;
+	int ret;
+
+	if (regulator_get_by_platname(NBXV3_VDD_REGULATOR_NAME, &reg) || !reg)
+		return 0;
+
+	fusesr = in_le32(&gur->dcfg_fusesr);
+	vid = (fusesr >> FSL_CHASSIS3_DCFG_FUSESR_ALTVID_SHIFT) &
+	       FSL_CHASSIS3_DCFG_FUSESR_ALTVID_MASK;
+	if (vid == 0 || vid == FSL_CHASSIS3_DCFG_FUSESR_ALTVID_MASK)
+		vid = (fusesr >> FSL_CHASSIS3_DCFG_FUSESR_VID_SHIFT) &
+		       FSL_CHASSIS3_DCFG_FUSESR_VID_MASK;
+
+	target_mv = (lx2160a_vid_table[vid] + 5) / 10;
+	if (target_mv == 0) {
+		printf("MPQ8785 (%s): VID handoff fuse=0x%02x reserved/unknown, leaving rail untouched\n",
+		       NBXV3_VDD_REGULATOR_NAME, vid);
+		return 0;
+	}
+
+	/* Env override */
+	override_str = env_get(NBXV3_VDD_OVERRIDE_ENV);
+	if (override_str && !strict_strtoul(override_str, 10, &override_mv) &&
+	    override_mv >= NBXV3_VDD_MIN_MV &&
+	    override_mv <= NBXV3_VDD_MAX_MV) {
+		printf("MPQ8785 (%s): VID handoff override %s=%lu mV (fuse VID=0x%02x would have been %d mV)\n",
+		       NBXV3_VDD_REGULATOR_NAME, NBXV3_VDD_OVERRIDE_ENV,
+		       override_mv, vid, target_mv);
+		target_mv = (int)override_mv;
+	} else if (override_str) {
+		printf("MPQ8785 (%s): VID handoff %s=\"%s\" out of range [%d, %d] mV, ignored\n",
+		       NBXV3_VDD_REGULATOR_NAME, NBXV3_VDD_OVERRIDE_ENV,
+		       override_str, NBXV3_VDD_MIN_MV, NBXV3_VDD_MAX_MV);
+	}
+
+	target_uV = target_mv * 1000;
+	actual_uV = regulator_get_value(reg);
+
+	if (actual_uV >= target_uV - NBXV3_VID_TOLERANCE_uV) {
+		printf("MPQ8785 (%s): VID handoff fuse=0x%02x target=%d mV (already within tolerance, rail at %d uV)\n",
+		       NBXV3_VDD_REGULATOR_NAME, vid, target_mv, actual_uV);
+		return 0;
+	}
+
+	printf("MPQ8785 (%s): VID handoff fuse=0x%02x %d uV -> target %d mV (closed-loop adjust)\n",
+	       NBXV3_VDD_REGULATOR_NAME, vid, actual_uV, target_mv);
+
+	/*
+	 * Plateau detection: if the rail stops moving while we are
+	 * still bumping VOUT_COMMAND, the chip is clamping at VOUT_MAX
+	 * (or refusing to slew higher for some other reason). Bail
+	 * with a WARNING and leave the rail at whatever it settled at.
+	 */
+	{
+		int cmd_uV = target_uV;
+		int last_actual_uV = -1;
+		int plateau = 0;
+		int iter;
+
+		for (iter = 0; iter < NBXV3_VID_MAX_ITER; iter++) {
+			ret = regulator_set_value(reg, cmd_uV);
+			if (ret) {
+				printf("WARNING: MPQ8785 (%s): VID handoff set_value failed at iter %d (cmd %d uV, ret %d), rail at %d uV\n",
+				       NBXV3_VDD_REGULATOR_NAME, iter, cmd_uV,
+				       ret, actual_uV);
+				return 0;
+			}
+
+			actual_uV = regulator_get_value(reg);
+			if (actual_uV >= target_uV - NBXV3_VID_TOLERANCE_uV) {
+				printf("MPQ8785 (%s): VID handoff settled at %d uV after %d iter (cmd %d uV, target %d uV)\n",
+				       NBXV3_VDD_REGULATOR_NAME, actual_uV,
+				       iter + 1, cmd_uV, target_uV);
+				return 0;
+			}
+
+			if (last_actual_uV >= 0 &&
+			    actual_uV - last_actual_uV < NBXV3_VID_LSB_uV) {
+				plateau++;
+				if (plateau >= NBXV3_VID_PLATEAU_LIMIT) {
+					printf("WARNING: MPQ8785 (%s): VID handoff stalled at %d uV after %d iter (target %d uV, cmd %d uV) -- VOUT_MAX clamp or chip refused\n",
+					       NBXV3_VDD_REGULATOR_NAME,
+					       actual_uV, iter + 1,
+					       target_uV, cmd_uV);
+					return 0;
+				}
+			} else {
+				plateau = 0;
+			}
+			last_actual_uV = actual_uV;
+			cmd_uV += NBXV3_VID_STEP_uV;
+		}
+
+		printf("WARNING: MPQ8785 (%s): VID handoff did not converge after %d iter (rail %d uV, target %d uV, cmd %d uV)\n",
+		       NBXV3_VDD_REGULATOR_NAME, iter, actual_uV, target_uV,
+		       cmd_uV);
+		return 0;
+	}
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_vid_handoff);
-- 
2.43.0

