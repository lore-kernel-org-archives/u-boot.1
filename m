Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003CC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20665607A7;
	Mon, 17 Aug 2026 15:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j72E948Uvnrt; Mon, 17 Aug 2026 15:33:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C353607C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980796;
	bh=YVrlmusAF5ppOIyIEila1LYXbuZETTqknqtmxSlckg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SQzketSVCQ9y3HAx5HIS92wKAwRnb/5ITwMtJFc783F10p7UrCbOlDifkB7qg6a2+
	 Im4Mzt/HVuJTz2kToOui+J6ipbGn6vwM+M9z7aB5XmFh8io+QZgXOdi1r9uBP74rfJ
	 OfSx869mmtLmu+Ui7syXaxnqBpyde1hKynv6aVKZmscpolfSsKDk4Dage8RJzakYl4
	 7x1Ofewtvx0AXFH+sZh+F0DiHINJPBn1+SHThDBLwUVhqeT4iNn/j3dSx/EU2WWByS
	 Dqbb0RRQqp5rUkivOJXZcFHaUmvSVvqT954jvYvIdzOWkWIn9rphI0KqmZ2g+70Ast
	 bD8am51/nJ6lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C353607C4;
	Mon, 17 Aug 2026 15:33:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A67C337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11121607A8
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0f2dD2nsTCc for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:33:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 052DF6072A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 052DF6072A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=aXUDxYVc
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 052DF6072A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 53D9EB005A2;
 Mon, 17 Aug 2026 17:33:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980792;
 bh=s6ggbkp4C8/fuCi20N4FiYO+aPcCyo9PHOHSDIYbEcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aXUDxYVccKLRaJn3xriTUv8Kzt5F2/zrqQUWe8NhBzilEVVQF9a3Fh+73h5zg6sMd
 73kp1/vJiTmPzeVoSOGkmbE5ywfMAhdYjEQBgUPQf97D9ZNqtGmxrKmQGragM5fSUs
 VMA9Hge0TiTV3sGdRV6WoZWhgLZOjwhOTISoZjBL15+GP235h0NgdZYORo1OPBLRyE
 AQlfQ+XPIaVpdBzlXtUeLyHYJla0MigQ82qV1CS40q0sTdfUF0FF7kkOOdDvu43W3X
 DwI0An29PxX7UT9r036XcJgjJ8VPje63TRT6GSMKgWJdb59kuGKQgB4H8iep614/TD
 2dAAI5/7ZvFJw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 04/23] board: nbxv3: add MPQ8785 PMBus traces + DT regulator
Date: Mon, 17 Aug 2026 17:31:22 +0200
Message-ID: <20260817153144.1951036-5-vjardin@free.fr>
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

Bind through the tree-level PMBus framework and add a board-local
EVT_LAST_STAGE_INIT spy that prints the traces to the serial console.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts  |  17 +++++
 board/nxp/lx2160a/Kconfig           |  11 +++
 board/nxp/lx2160a/nbxv3/Makefile    |   1 +
 board/nxp/lx2160a/nbxv3/mps_pmbus.c | 107 ++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/mps_pmbus.c

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 8caea051bed..8e336a622f3 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -40,3 +40,20 @@
 	phy-connection-type = "rgmii-id";
 	u-boot,nickname = "lanconsole0";
 };
+
+&i2c0 { /* IIC1: on module management bus */
+	status = "okay";
+
+	regulator@10 {
+		compatible = "mps,mpq8785";
+		reg = <0x10>;
+		regulator-name = "+0V8_VDD";
+		regulator-min-microvolt = < 600000>;
+		regulator-max-microvolt = <1100000>;
+		/* MPQ8785 datasheet rating: continuous 40 A output (IOUT). */
+		regulator-min-microamp = <       0>;
+		regulator-max-microamp = <40000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
diff --git a/board/nxp/lx2160a/Kconfig b/board/nxp/lx2160a/Kconfig
index 37e8f7ff717..e46223d1b43 100644
--- a/board/nxp/lx2160a/Kconfig
+++ b/board/nxp/lx2160a/Kconfig
@@ -65,4 +65,15 @@ config NBXV3_DM_EVENT
 	default y
 	select DM_EVENT
 
+config NBXV3_PMBUS
+	bool
+	default y
+	select PMBUS
+	select CMD_PMBUS
+	select DM_REGULATOR
+	select DM_REGULATOR_PMBUS_HELPER
+	select DM_REGULATOR_MPQ8785
+	select DM_REGULATOR_PMBUS_GENERIC
+	select CMD_REGULATOR
+
 endif
diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index 90ef2734eec..e4aa5309804 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y += eth_nbxv3.o
+obj-y += mps_pmbus.o
diff --git a/board/nxp/lx2160a/nbxv3/mps_pmbus.c b/board/nxp/lx2160a/nbxv3/mps_pmbus.c
new file mode 100644
index 00000000000..15c0d0d0bc6
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/mps_pmbus.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * Boot time snapshot of the +0V8_VDD core regulator.
+ *
+ * The MPS MPQ8785 or MPQ8646 chips are bound through DT
+ * thanks to the per chip driver in
+ *   drivers/power/regulator/mpq8785.c.
+ *
+ * The only thing this file still does is the boot time event spy and logs:
+ *  - at `EVT_LAST_STAGE_INIT` it probes the regulator (which triggers
+ *    the chip driver's .probe),
+ *  - it seeds pmbus_active so the `pmbus` command works without the
+ *    operator typing `pmbus dev`,
+ *  - and then it prints a one shot rail snapshot to the serial console.
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <event.h>
+#include <i2c.h>
+#include <log.h>
+#include <pmbus.h>
+#include <vsprintf.h>
+#include <power/regulator.h>
+
+#define NBXV3_VDD_REGULATOR_NAME	"+0V8_VDD"
+
+static void mps_pmbus_print_snapshot(struct udevice *reg)
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	u16 raw, status_word = 0, prot_last = 0;
+	u8 vout_mode = 0;
+	int uV, en;
+
+	uV = regulator_get_value(reg);
+	en = regulator_get_enable(reg);
+
+	act = pmbus_active();
+	if (!act || pmbus_active_get_i2c(&chip)) {
+		printf("MPQ8785 (+0V8_VDD): VOUT=%d uV  enabled=%d  (no PMBus active dev)\n",
+		       uV, en);
+		return;
+	}
+
+	pmbus_read_byte(chip, PMBUS_VOUT_MODE, &vout_mode);
+	pmbus_read_word(chip, PMBUS_STATUS_WORD, &status_word);
+	pmbus_read_word(chip, 0xfb /* MPS_PROTECTION_LAST */, &prot_last);
+
+	{
+		u8 rev_byte = 0;
+
+		(void)pmbus_read_byte(chip, PMBUS_MFR_REVISION, &rev_byte);
+		printf("MPQ8785 @ i2c%d:0x%02x  MFR_ID=\"%s\" MODEL=\"%s\" REV=0x%02x VOUT_MODE=0x%02x\n",
+		       act->bus_seq, act->addr,
+		       act->mfr_id[0] ? act->mfr_id : "?",
+		       act->mfr_model[0] ? act->mfr_model : "?",
+		       rev_byte, vout_mode);
+	}
+	printf("  +0V8_VDD: VOUT=%d uV  enabled=%d\n", uV, en);
+
+	if (pmbus_read_word(chip, PMBUS_READ_VIN, &raw) == 0)
+		printf("            VIN  raw=0x%04x  =%lld uV\n", raw,
+		       (long long)pmbus_reg2data(act->info, PSC_VOLTAGE_IN,
+						 raw, vout_mode));
+	if (pmbus_read_word(chip, PMBUS_READ_IOUT, &raw) == 0)
+		printf("            IOUT raw=0x%04x  =%lld uA\n", raw,
+		       (long long)pmbus_reg2data(act->info, PSC_CURRENT_OUT,
+						 raw, vout_mode));
+	if (pmbus_read_word(chip, PMBUS_READ_TEMPERATURE_1, &raw) == 0)
+		printf("            TEMP raw=0x%04x  =%lld udegC\n", raw,
+		       (long long)pmbus_reg2data(act->info, PSC_TEMPERATURE,
+						 raw & 0x00ff, vout_mode));
+
+	printf("  STATUS_WORD = 0x%04x  [", status_word);
+	pmbus_print_status_bits(PMBUS_STATUS_WORD, status_word,
+				pmbus_status_word_bits,
+				act->info ? act->info->status_overrides : NULL);
+	printf("]\n");
+	printf("  PROTECTION_LAST = 0x%04x (NVM)\n", prot_last);
+	printf("  Use `pmbus telemetry`, `pmbus status`, `pmbus mps last` for details.\n");
+}
+
+static int mps_pmbus_last_stage_init(void)
+{
+	struct udevice *reg = NULL;
+
+	if (regulator_get_by_platname(NBXV3_VDD_REGULATOR_NAME, &reg))
+		return 0;
+	if (!reg)
+		return 0;
+
+	{
+		int bus_seq;
+		u8 addr;
+
+		if (pmbus_resolve_by_name(NBXV3_VDD_REGULATOR_NAME,
+					  &bus_seq, &addr) == 0)
+			pmbus_set_active(bus_seq, addr);
+	}
+
+	mps_pmbus_print_snapshot(reg);
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, mps_pmbus_last_stage_init);
-- 
2.43.0

