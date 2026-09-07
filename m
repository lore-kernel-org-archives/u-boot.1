Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C96C79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26AF46066E;
	Mon,  7 Sep 2026 15:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uk_-1B1mKc8w; Mon,  7 Sep 2026 15:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 38A276062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795333;
	b=FBgV63wrnjJ9IKts1SDVGxjEzivt4opC2ilsMwP30np7PW5O6vNrSJ+vHh2fJxf5JC3Y
	 dDYGpubu1o/QMZymaoL1KN8c4kKqKxCxgmQD3cLTawQ4ZTUrPCpUV+6phIM4ch4UZbrcK
	 LgoxUFWylhaKZ3ttlwIt5RmDPwYAp+ZHjZHpNAKF+bQrCnwUpcQDq1CZOfzrLDyQe7Oh/
	 GdJZJ69mlw5IwMijGhwwf51xqnX0pIAysloqX1s8NKpgqLXMBGDNRA2zff9IyzkPcG/8m
	 nyaEKllzilciSGvX6ZLXr4ihTrk1xj/P3EZP3Gred32cgELhpyaVu+sNXyK7Fx4455A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TNt8PKoAUlh/NlXnJvluMocZRCH1N49bUS+D3QmK3ls=;
	b=dLYoPtdurd7y1o/kgPlZo/xC9HIg6z5Lx5sPzRuxeBd2431a2cHebtwXTBTtPKGMXMdp
	 VlZqOPNxcTHx9ct8aVldisWxJ88e1paNtUKeoS0mltvsZCQAuK37i4cRB74YCAL4RSikC
	 r3WvXxIj6Ausnis9L/RYhIglAM2fRTi2x0BkxUdGud8DzeQ+saGEw5GEsA6qPDfjoEmsb
	 Xl6/XrXc4u2JIkBXHYQVhgjQEEW+b+dqj/IUuhoWW7SRl64c78E4zzSb+c0FLGVXhiLxq
	 u+pfTtVch7EE7dgzxWJ989rvanvsFp4j0RVcBEGKx8ShSGgbIksHVZXQAKn2px3ssXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795333;
	bh=TNt8PKoAUlh/NlXnJvluMocZRCH1N49bUS+D3QmK3ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AK8jQ4jfqGOAE6DXe5864y+mQPpoSXxiDHMus3cU0VyCJrKMRFRubEiZiHxqfM3Yc
	 7XhcOq5BGavsAbIx1Hu4fER3lZAXdUFNTcU+nuRBX1OXrcVy9Laufl3SwlNJwio3a8
	 3+gksx1g4eWQRXRprEFF3KLw5ozofbVpks4NnT57zLG0OJo14ALp6Vxb9PHuT3wc05
	 6IJHpPuYkbHG0/MdbnVkc2NWrwJdQmwXZp5CIQTOKhQG3EttyX4b1IUrjp82qMUAai
	 7qTxS5+OJURcNZM7P+bZvtF1xhR6yWceqMIYpeuiy/uk8tlk0ZjcZjS+2CPHJIrvaH
	 F57h/OiEpML6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38A276062B;
	Mon,  7 Sep 2026 15:35:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AD9BBA48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F3AD404E8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXflz9gEyza6 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D96A403F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795330;
 b=smo45soo0kFpXd/Rw4KEvUAR7ffXv75h/WUBJSjPu4zoo5LN6vHxwtEJ4UH6hcCVETCT
 979qR+9AlcIxh6+WK6q8metRMrOjCeZgCUqTb9L2Hx0aar3C0cmQo00Jy8xE/S2n77uCb
 2RvvxuzhVTM56Pq+fIBCBW9BL3IJi/WE7LtB02fcHsl3bUnC1QO/GtiC12AenBLdMvpkj
 YAhKCioJB6BiGEsrAVBSyP49L1HT5PwZisuDexLdke4gPkC/U4nYaXfzjsSgMWXyYepwJ
 iG8jxohtAQMxIa6T2V71rXxRHWSlzo2G9gzJyt2vt5H7zQtQtv8Q7V0EDfW2mYma62Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795330;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=TNt8PKoAUlh/NlXnJvluMocZRCH1N49bUS+D3QmK3ls=;
 b=VoYOgeGSpRKbN8mvLQfDoLM/RL0YQaPudt2sbMOcVP3pb5RDBxH5P1UBrq1E4r3VzyJ7
 MUErjEbtKNvo7fVeOvBXxs2vN7Vw7pu2lAJq2f990wZ3UA3ySVDFbp/0zUkNE+MmMQffJ
 flGmbPX7lgY4y+FIh6vEvpyPU4SE4qQdo8DCSOhaZaXDfHN0ReddlTWMpTiQnYDFz5zZJ
 riYhTVjBrE5ufuTU6lK6Xn/qZUQgtdltZ9kGGHmDOBGxPds4bMbG0kTBBx0qST+NoXP9s
 4rYiYBhJVAkys/AEjlXYx6NhdACXyI9D1azH9+iBtdDfiGtmpn3rfWrwrf8PQMGaW/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=PKsPLiQj; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=PKsPLiQj
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D96A403F8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id C3931B00571;
 Mon,  7 Sep 2026 17:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795328;
 bh=u7jGIlTNgYVCs6kXKZp+mw9zYONwrkpLefvDDuhjTeA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PKsPLiQjcxRQhERMr6sYDI/VKBnyj5bP9/S0NoVhgdZMfGZaZSgsT1HLflbBfYBHa
 sD+qTd5sdAaVidJx9fKOFsg6pUMGt/9G9IOCQYNp2zajmQMQfKNYRqmDosNrSx1cmV
 egSw4NJ5QgJi5rQw7ZHPCDGx/A6nFcuyiiscoBNtSioVvby3QMtpnnQcVGV7qA6/P7
 CcjjOB5JoMKtGRe0t7o4tOZWesQioE9rG3viU+Y8NoQKHBcwsrQ97/bszJdOLAA7+1
 wG1dKbDXedyP52H7vB6G9xx5uMgpWZHm1qYCGlqGAb9wafFg+WUoNBo4Dnyjylr8aQ
 zp4iFlDwxG/2w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 3/8] board: nbxv3: add MPQ8785 PMBus core-rail readback
Date: Mon,  7 Sep 2026 17:34:05 +0200
Message-ID: <20260907153411.2207773-4-vjardin@free.fr>
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

Bind the +0V8_VDD core rail (MPS MPQ8646, MPQ8785 core) through the
tree-level PMBus framework and add a board-local EVT_LAST_STAGE_INIT
spy that prints its telemetry to the serial console.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/mps_pmbus.c | 99 +++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/mps_pmbus.c

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
index 00000000000..59898f9270f
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/mps_pmbus.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * The MPS MPQ8785 or MPQ8646 chips are bound through DT
+ *
+ * The only thing this file still does is to provide console traces.
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
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, mps_pmbus_last_stage_init);
-- 
2.43.0

