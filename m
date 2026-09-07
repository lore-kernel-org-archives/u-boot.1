Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8715EC79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E7F460675;
	Mon,  7 Sep 2026 15:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ud-UsMSGBmWU; Mon,  7 Sep 2026 15:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AA526066E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795372;
	b=dyi+PmwTqnEVi+U4fu8tUBJQP/HLI3Lf3S+PMDLvF3LhIewDGkR/AgDxgC9+Yhk1PYW4
	 lpn2w9Kxl2P48PWLqUd5LcMCU+RmpK7lEW2rPxc+MB7aMbf/Z3gplgbaZv4DsgkNM+s2D
	 Stp2+w324QfUnMSmn5cLhFzZl44kMbpug39C3YGyx69njpQjQi8sVqlGssFW1w4eJ58o/
	 f3IjZBb9JKaVSDgt8M7NmeARa1uJg2F7bsFR+0iG7GSfsc3cCMfpx/FpXUGxNP/IhGkL1
	 W2NLj8EM6FJ1rCbjqFJUJ0EBz/zvlgaDoEyGVDhyIHmXSXMTSi+EwQejGXL6039dwiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rw7t0eE8YU2xEjJz2QyaUSQM8pik/jv8GtJE1zpaRDY=;
	b=kXcih4nkgxaRHJXt1M3yXMUsx2aKoza11jn2xMPFIo/VGsQOEHRWpWqnTPGncq09ANU7
	 YOPwfx54euz0q7mQlYKHqv9/ZMmXCjerrwLMPfJAh8FltS2XmbgHUYsa6bzj6TUqMX2Vp
	 eJMTjvMPfgulUrrkvGrO6Vg0+TZJX8dQvKdyoY5jgDPTp6AVf9B45mwvBF+zgJhouiw26
	 aMq9ZLmw8z+rocojHfNXxG0/6I394Jx/HwmFBrHT5BZToIPMepFNOCSh3skTlExPOpC69
	 n3HVMv4VEQZ5o/Rd7JvPaTtcxqH0nM9lVocU/Dk8Zw0dhuQXG0pQ5Rm3oNzcxEAdG4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795372;
	bh=Rw7t0eE8YU2xEjJz2QyaUSQM8pik/jv8GtJE1zpaRDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=snnXcNGXHA8OLeTC4Rrba8XG+/EISGJgbEjK2dMtQ2qEQmWqB1itjyRQs6qaRn/VK
	 upwewkgA9VacKVhN/xp2XnMc6HFggkYkA5agz9pp/PPhvRpknvGzbmw46QoCBf7Hav
	 o7lmpmWIkR4eLY9hbxZU20fnCEFOxwQVeVSSs2NE9ut9RBcqYgUjsJEpUkhNCSRTGF
	 JfK0YNKpXjtbuf8MhThK0foeS21KGMANHZgFyXSgPJJsWdOjJcEmyMU0l8JOODw3rr
	 z1RiML2RFuUuIV0x8AYZFNLvJOdoUgfCvRBe75c+aOHGKbEQniQZCJWdOBMAsBcFUS
	 rb38rL8d5oKAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AA526066E;
	Mon,  7 Sep 2026 15:36:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3E039CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94B99404E8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X68DsZKyLak7 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:36:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C6200403F8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795370;
 b=kf/LBtnr5S6I6mXqFOWUMpFCw7xFu3wKeDW0L4OB6+hcCvS93cMJIvhu0rHY2W0tlbiK
 KaW3mJFtsSciw2kWVoZsUPFM58EhRxuy9SMTEIT1nYW1ZPRLGjAPW4eigQnh8tsA9vC0W
 IwtChVWeFnCpRnnNJxhTONo9dXEy9cTVABzrDbV8g12ADXiJRf8an/2yfdw6k0mgVnVj5
 1RULLhG2NhNEGQdtXQpStS3F8ydrS2X4OZj6U/I9cjfG8c83w0polMQKAy6F+92VLAGAN
 zLEZLg7Q4OY45uRktUSJ0OrmbeNrVpoc1i313jm54KtRHMBTV5rcNnYJaKEwsKp15/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795370;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Rw7t0eE8YU2xEjJz2QyaUSQM8pik/jv8GtJE1zpaRDY=;
 b=APKMDkbRI5gW99MLjZKxQsXNTFNHWTW3tZB+DBXrjnuKrkjGR54V6kvC5lGgjxAgENWY
 +sBy71l7QjeneDsApF4lE2PT3C4jW8YVHoF2dM70EmL/aCRZ6w8vEikDbYJzJEHqo78Cf
 b36ICwPmMOVLSpJfi5k+zlPbyJJWbSV9zkMi4OvSVMoLjqRIncN2B8RLoddSPpTBg6WeK
 Fgh4GaNcW1WnQxdh7wpw8SWbXCyYpSdHhqNlsWP+7U1QRHC+ntd2mEOC0G7aa/+YoF0MH
 cw2uk0HJyBJCV7Ge/ud9g7mjx2TDePZ3oBHslmZvtDvhI1K74j3J5xmNp26p1QsaDOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=TLPtU9En; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=TLPtU9En
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6200403F8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 69A89B00579;
 Mon,  7 Sep 2026 17:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795367;
 bh=w5esVZdqF3quiY2PgUKeZL+4jEvhHehliSGTv5A+MoI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TLPtU9En/KY9fBziC2iYcpDgDudYjoPUrE9sYH3Qh0N00w2XLTFHAUYM3Iu3H1fAU
 1YYRLUWJbpVPTyfrGOLoE8u+eftCul2XDPr3P7899Sb+w+Q37qw9/AWJQTvw7GeUAc
 5B8AwIDi40MXFThXC1U99GsBdSrCNULYV2k5yR6yw+F1RJty7fVcVQ7mUFF9UxIfv3
 ktW+srzNGP8L92Opua1OUnIu2fTVjUFYhkBha5meBRH9R9XWry4CNDv68tXX/IOhfH
 2W8hb1RoZlV+bdVR5ZB9+JEloCmlhHAHvyDmP/kBneMYihQjAaMcr7IYiS6NBJc5z8
 XxBSv3A+SZHJA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 5/8] board: nbxv3: add VID-fuse driven core voltage
Date: Mon,  7 Sep 2026 17:34:07 +0200
Message-ID: <20260907153411.2207773-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
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

Read the LX2160A DCFG_FUSESR.ALTVID / VID fuses, look up the
binned target voltage, and command the rail through the
UCLASS_REGULATOR set_value op

The rail is set ONCE to exactly the fused voltage.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/Makefile      |   1 +
 board/nxp/lx2160a/nbxv3/vid_handoff.c | 144 ++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
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
index 00000000000..d3edaa61080
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/vid_handoff.c
@@ -0,0 +1,144 @@
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
+#include <linux/delay.h>
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
+#define NBXV3_VID_LSB_uV		1953	/* VOUT_MODE 0x17: 2^-9 V = one PMBus step */
+
+#define NBXV3_VID_SLEW_SETTLE_US	5000	/* >> slew time for a 30 mV step */
+
+/*
+ * From LX2160ARM
+ * "This is the minimum voltage required to reach the frequency
+ * specified."
+ * Everything not listed is Reserved, it maps to
+ * 0 = "leave the rail untouched" below.
+ */
+static const u16 lx2160a_vid_table[32] = {
+	[0x00] = 8500,	/* default */
+	[0x02] = 7750,
+	[0x10] = 8000,
+	[0x12] = 8250,
+	[0x14] = 8500,
+};
+
+/*
+ * Write VOUT_COMMAND, let the slew finish, read the rail back.
+ * Returns the rail in uV, or a negative errno from the write.
+ */
+static int nbxv3_vid_write_readback(struct udevice *reg, int cmd_uV)
+{
+	int ret = regulator_set_value(reg, cmd_uV);
+
+	if (ret)
+		return ret;
+	udelay(NBXV3_VID_SLEW_SETTLE_US);
+	return regulator_get_value(reg);
+}
+
+static int nbxv3_vid_handoff(void)
+{
+	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
+	struct udevice *reg;
+	u32 fusesr;
+	u8 vid;
+	int target_mv, target_uV, actual_uV, cmd_uV;
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
+	if (abs(actual_uV - target_uV) <= NBXV3_VID_LSB_uV) {
+		printf("MPQ8785 (%s): VID handoff fuse=0x%02x target=%d mV (rail already at %d uV, untouched)\n",
+		       NBXV3_VDD_REGULATOR_NAME, vid, target_mv, actual_uV);
+		return 0;
+	}
+
+	printf("MPQ8785 (%s): VID handoff fuse=0x%02x rail %d uV, target %d mV -> write %d uV\n",
+	       NBXV3_VDD_REGULATOR_NAME, vid, actual_uV, target_mv, target_uV);
+
+	ret = nbxv3_vid_write_readback(reg, target_uV);
+	if (ret < 0) {
+		printf("WARNING: MPQ8785 (%s): VID handoff set_value(%d uV) failed (%d), rail left at %d uV\n",
+		       NBXV3_VDD_REGULATOR_NAME, target_uV, ret, actual_uV);
+		return 0;
+	}
+	actual_uV = ret;
+	if (abs(actual_uV - target_uV) <= NBXV3_VID_LSB_uV) {
+		printf("MPQ8785 (%s): VID handoff verified %d uV (target %d uV, cmd %d uV)\n",
+		       NBXV3_VDD_REGULATOR_NAME, actual_uV, target_uV, target_uV);
+		return 0;
+	}
+
+	cmd_uV = target_uV + (target_uV - actual_uV);
+	ret = nbxv3_vid_write_readback(reg, cmd_uV);
+	if (ret < 0) {
+		printf("WARNING: MPQ8785 (%s): VID handoff correction set_value(%d uV) failed (%d), rail left at %d uV\n",
+		       NBXV3_VDD_REGULATOR_NAME, cmd_uV, ret, actual_uV);
+		return 0;
+	}
+	actual_uV = ret;
+	if (abs(actual_uV - target_uV) <= NBXV3_VID_LSB_uV)
+		printf("MPQ8785 (%s): VID handoff verified %d uV (target %d uV, cmd %d uV after 1 correction)\n",
+		       NBXV3_VDD_REGULATOR_NAME, actual_uV, target_uV, cmd_uV);
+	else
+		printf("WARNING: MPQ8785 (%s): VID handoff rail %d uV %s target %d uV after correction (cmd %d uV) -- VOUT_MAX / non-linear load line, fix on the VR side\n",
+		       NBXV3_VDD_REGULATOR_NAME, actual_uV,
+		       actual_uV < target_uV ? "below" : "above", target_uV,
+		       cmd_uV);
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_vid_handoff);
-- 
2.43.0

