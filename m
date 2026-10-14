Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A4ACC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 043E880E42;
	Wed, 14 Oct 2026 14:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SE3oP3FGc8GQ; Wed, 14 Oct 2026 14:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21F6F80E27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987481;
	b=avPEEB0AlbDKmhCOvlqmT5pcE+JZF8RjuXdIj8KaU1vY9fnOUeMH1/aZ20di25TG1G+r
	 uNiQeWL05Q9DQ+M4TpR/ixkKMbZ5VEcIBao1hHfKGrRe8kH13CVpf/FsJvPlOot4JkN47
	 EuBKm6+P1hjvPUr53B+1pblmlOs0NBNU+hPe+376tCxmR2xtMpDovfc5nRAKmnxnMtcCf
	 nwRFf6gDE2dAUzh4ffvaOFQY0LjyZaCm2ybgnpEYwFWUl970yS5BHEyzlU0KPlzu0p7N8
	 OKx37rd0/kZdrpYtsMjS5sADSSvm+9H7CFXDLbiYfcns0PGlXUexqrBMO34CnjdEkJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P06+UzAJ4U/IdHs2Jpcn9KYxTo9KS9e/LFAjWXSdkJY=;
	b=tMy4JPrs6kAFUUkWzpoEx6R4fhnPQD0sUQJj5ZE6FVHYLL4NzIRSIhs2WVDxTP64mgbY
	 qeGx1QcdBktXNTlbryAr5eZ7b6iNm9pm1c2t+Nva4h65MCdXD8RTkLdOF7dXP+r/9t1RP
	 fOYMs4yau0U8TWddWtY8eMCYszVU5BfZqTpg5W1OMKgG/vpwuUpSXT2iO8no9qKm9vNX/
	 G8YYiTy5Uk8e/Qutx/8euKCbuJT1kDpqPX+H7TPIACndT5zSzTebCTvFJjej01rsMcf4d
	 tc3G8eZSqf00o7kY304n5GWV2mo+DriMYZRnQiaAhOFPfHV0ze0dwssGC5VEArBG+eQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=0PU6OgAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987481;
	bh=P06+UzAJ4U/IdHs2Jpcn9KYxTo9KS9e/LFAjWXSdkJY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LfEBfq5+C5I3tdaTDHumzcr+J9qpQ9bWB2BrGoT9EWeyy1RP7eXgwCJPulp+DooiB
	 qqXZbBgOQ9D6lr2m3iH0OnS43Zahuc+auWARqhKRK2QLjPL88RoE06mnQrgn08LJXS
	 Jl5z9BQ2+QN08/PLfE5zEgKqInqGP+VIajzOCAOfPoEX4xJozX4Fc3zu6Lhlvg9vHM
	 2aG/DLoPRwDLPbW/VCrOmsr9uWHairaQNslMLACJoC5CSu5YilwsatpO1JtX8Lo8AP
	 oQeKPpV/NE5GVEJj3n1bngZ7pdusc+EGpbS31ZJHnbP93xcMPbTDeLbxh1TGlJqZcL
	 4WLvhjU0clz+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21F6F80E27;
	Wed, 14 Oct 2026 14:18:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A6632A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BF5380E37
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3pXlNOXJCQY for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 953F180E15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987478;
 b=JiyoGUFGzgdWjsaM30b5BK826lKdU758goa3VdeOdsdGugdg3UEbfYkm3edr+kQP/wtH
 Ter1R9/lBasfDS6PLwQQC3b8hCqTeSASPY8+ojwgSBwfu19VXH/o+a7YQ3s/s4iyznL2c
 zW/cZZ9gChcVaoVHPoZKXmff1NtM/IRThZ+ux2bKYUr5/ERe9PPOfrsTnVPhowK8SdvBo
 0KhckAkjL3xvZtT0EVdvFCcKdXfviUPk6f2BG7mXnUGjqELywvjwT2CVjiA/XVvKeeC9y
 4IGy1Q2j/svFd2HLCTrTV69anqU43zx+7jhI4Mqlf6jf1EgjM+M02+jGtwT5XfSl/Wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987478;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=P06+UzAJ4U/IdHs2Jpcn9KYxTo9KS9e/LFAjWXSdkJY=;
 b=QjkygoKqW5UX44a/EgYIZnO/4t5U+ZeZO28XDTyyTb0XoeAcapYp+oW+w4UFfjNI3hN/
 R9D4QC+PG1b/dkM2iu2lf5y3MPwa1zwPdnA+S8g/l4bZKFGNGl847BDl1bgZwhcLxKHKX
 o+F/CDBCmLF7Wtu1fpRLtty/BdI7duu3eTsirthw98706xN5T4COzBqtW5axT15T3Nfgz
 zoX16AslburRNhxIoTWCKCfEQwKxjNsM9x9Om0MyN0DSsK7BI5+PkNEhl9PzpUBxGqjfr
 GxCfMhJuA+OHsaNbUlg9bIHpOs5dqIZSS7a415cye2t+RGxeZEwFoER1EX+By8DoMDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=0PU6OgAw; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=0PU6OgAw
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 953F180E15
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987478; x=1823523478;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=p+tl5m/4lmyZkdmbM0PgvfTXyWAg6mtlyp47noRX9jk=;
 b=0PU6OgAwX1I83mJlf8g4XWQsGT/n3Sht+6GcM+E266koR4ObiAFnDNmH
 5b74933fM04r0Lfl9CG3YrvOt9KMoZtEwCaZvGCEi3xmsysGYLjoVQvcy
 swfXRqwg+NzlAmEh1UAdKMUxS+ShQz04Io87j+Sw9+0f+H0J7D2WopWmT
 ebIhSSPlS9phCm6EaXg42IjISCUqqUmV2IMJ/Sen36+yQJJgrgVXUyj9F
 AeRPGGlDkw2vW7LdGkVOXZ9W9EZ4/BS7o1xo2JRwV8b/c0VVYjRK7Nifv
 plcA5AX4F278R0MQs5d49KGXCaI7juklP0FVWl+kIzHA2I7t1FEC+g+U/ Q==;
X-CSE-ConnectionGUID: YATsbOvlTvK1G0S0ZHq0LA==
X-CSE-MsgGUID: fuJfYLBORBqK9f7j4L9YTA==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; d="scan'208";a="232123159"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 07:17:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 07:17:36 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:31 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:09 -0400
Subject: [PATCH v4 5/8] firmware: rpmi: add a test and a sandbox driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-5-d53d34a49780@microchip.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.3
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

Create a new transport layer that sends the messages to a simulated RPMI
firmware.

For now, this only contains a simulation of the clock service group
which is implemented using code from librpmi [1] and adapted.

Also add a test in test/dm that makes use of the RPMI clock driver.

[1]:
https://github.com/riscv-software-src/librpmi/blob/3f3c4ca47339a8795432e260f17e1fc5091c9a3a/lib/rpmi_service_group_clock.c

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v4: None
Changes in v3: None

Changes in v2:
 - Reorder headers
---
 MAINTAINERS                                |   1 +
 arch/sandbox/dts/test.dts                  |  12 +
 configs/sandbox_defconfig                  |   2 +
 drivers/firmware/rpmi/Kconfig              |   3 +-
 drivers/firmware/rpmi/Makefile             |   1 +
 drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 +++++++++++++++++++++++++++++
 drivers/firmware/rpmi/rpmi-sandbox.c       | 156 ++++++++++
 drivers/firmware/rpmi/rpmi-sandbox.h       |  47 +++
 test/dm/Makefile                           |   1 +
 test/dm/rpmi.c                             |  48 ++++
 10 files changed, 716 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf45df9a027a..6ca7709c64b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1564,6 +1564,7 @@ S:	Maintained
 F:	drivers/clk/clk_rpmi.c
 F:	drivers/firmware/rpmi/
 F:	include/rpmi*
+F:	test/dm/rpmi.c
 
 SANDBOX
 M:	Simon Glass <sjg@chromium.org>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef81472..d7998fa0da4a 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -882,6 +882,18 @@
 		sm: secure-monitor {
 			compatible = "sandbox,sm";
 		};
+
+		rpmi: rpmi {
+			compatible = "sandbox,rpmi-transport";
+			#mbox-cells = <1>;
+		};
+
+		rpmi_clock: rpmi-clock {
+			compatible = "riscv,rpmi-clock";
+			mboxes = <&rpmi 0x8>;
+			#clock-cells = <1>;
+			clocks = <&rpmi_clock 0>, <&rpmi_clock 1>, <&rpmi_clock 2>, <&rpmi_clock 3>;
+		};
 	};
 
 	fpga {
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a2708e6fb333..52df7cc08b14 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -198,6 +198,7 @@ CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_CLK_K210=y
 CONFIG_CLK_K210_SET_RATE=y
+CONFIG_CLK_RPMI=y
 CONFIG_SANDBOX_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CPU=y
@@ -214,6 +215,7 @@ CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_SCMI_FIRMWARE=y
+CONFIG_RPMI_FIRMWARE=y
 CONFIG_FPGA_ALTERA=y
 CONFIG_FPGA_STRATIX_II=y
 CONFIG_FPGA_STRATIX_V=y
diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
index 421a1fa9deba..b462d3693987 100644
--- a/drivers/firmware/rpmi/Kconfig
+++ b/drivers/firmware/rpmi/Kconfig
@@ -1,6 +1,7 @@
 config RPMI_FIRMWARE
 	bool "Enable RPMI support"
-	depends on RISCV && DM && OF_CONTROL
+	depends on RISCV || SANDBOX
+	depends on DM && OF_CONTROL
 	select FIRMWARE
 	help
 	  RISC-V Platform Management Interface (RPMI) defines an OS-agnostic
diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
index 4f4bcb929db4..150e98a72df9 100644
--- a/drivers/firmware/rpmi/Makefile
+++ b/drivers/firmware/rpmi/Makefile
@@ -1,3 +1,4 @@
 obj-y	+= rpmi-uclass.o
 obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
 obj-$(CONFIG_RPMI_SHMEM) += rpmi-shmem.o
+obj-$(CONFIG_SANDBOX)	+= rpmi-sandbox.o rpmi-sandbox-clock.o
diff --git a/drivers/firmware/rpmi/rpmi-sandbox-clock.c b/drivers/firmware/rpmi/rpmi-sandbox-clock.c
new file mode 100644
index 000000000000..fa205d067b24
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sandbox-clock.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <asm/types.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <rpmi.h>
+#include "rpmi-sandbox.h"
+
+struct rpmi_clock {
+	enum rpmi_clock_type type;
+	const char *name;
+	u32 rate_count;
+	const u64 *rate_array;
+	u32 transition_latency;
+	enum rpmi_clock_state state;
+	u64 rate;
+};
+
+const u64 discrete_rates[] = { 20000000, 333333333, 500000000, 1000000000 };
+
+const u64 linear_rates[] = { 50000000, 100000000, 1000000 };
+
+#define DISCRETE_CLOCK(name, current_state, current_rate) \
+	{ RPMI_CLK_TYPE_DISCRETE,                         \
+	  name,                                           \
+	  ARRAY_SIZE(discrete_rates),                     \
+	  discrete_rates,                                 \
+	  0,                                              \
+	  current_state,                                  \
+	  current_rate }
+
+#define LINEAR_CLOCK(name, current_state, current_rate)         \
+	{ RPMI_CLK_TYPE_LINEAR, name, ARRAY_SIZE(linear_rates), \
+	  linear_rates,		0,    current_state,            \
+	  current_rate }
+
+struct rpmi_clock clock_simulation[] = {
+	DISCRETE_CLOCK("CLK0", RPMI_CLK_STATE_DISABLED, discrete_rates[0]),
+	DISCRETE_CLOCK("CLK1", RPMI_CLK_STATE_DISABLED, discrete_rates[1]),
+	DISCRETE_CLOCK("CLK2", RPMI_CLK_STATE_ENABLED, discrete_rates[2]),
+	LINEAR_CLOCK("CLK3", RPMI_CLK_STATE_ENABLED, linear_rates[0]),
+};
+
+static u32 clock_count = ARRAY_SIZE(clock_simulation);
+
+static struct rpmi_clock *rpmi_get_clock(u32 clkid)
+{
+	if (clkid >= clock_count)
+		return NULL;
+
+	return &clock_simulation[clkid];
+}
+
+static enum rpmi_error_codes
+rpmi_clock_set_rate(u32 clkid, enum rpmi_clock_rate_match match, u64 rate)
+{
+	struct rpmi_clock *clk = rpmi_get_clock(clkid);
+
+	if (!clk)
+		return RPMI_ERR_INVALID_PARAM;
+
+	clk->rate = rate;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes rpmi_clock_set_state(u32 clkid,
+						  enum rpmi_clock_state state)
+{
+	struct rpmi_clock *clk = rpmi_get_clock(clkid);
+
+	if (!clk)
+		return RPMI_ERR_INVALID_PARAM;
+
+	clk->state = state;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes rpmi_clock_get_state(u32 clkid,
+						  enum rpmi_clock_state *state)
+{
+	struct rpmi_clock *clk = rpmi_get_clock(clkid);
+
+	if (!clk || !state)
+		return RPMI_ERR_INVALID_PARAM;
+
+	*state = clk->state;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes rpmi_clock_get_rate(u32 clkid, u64 *rate)
+{
+	struct rpmi_clock *clk = rpmi_get_clock(clkid);
+
+	if (!clk || !rate)
+		return RPMI_ERR_INVALID_PARAM;
+
+	*rate = clk->rate;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_get_num_clocks(struct rpmi_transport *trans, u16 request_datalen,
+			     const u8 *request_data, u16 *response_datalen,
+			     u8 *response_data)
+{
+	u32 *resp = (void *)response_data;
+
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+	resp[1] = cpu_to_le32(clock_count);
+
+	*response_datalen = 2 * sizeof(*resp);
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_get_attributes(struct rpmi_transport *trans, u16 request_datalen,
+			     const u8 *request_data, u16 *response_datalen,
+			     u8 *response_data)
+{
+	struct rpmi_clock *clk;
+	u16 resp_dlen;
+	u32 flags = 0;
+
+	u32 *resp = (void *)response_data;
+
+	u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	clk = rpmi_get_clock(clkid);
+	if (!clk) {
+		resp_dlen = sizeof(*resp);
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	/* encode CLOCK_FORMAT */
+	if (clk->type == RPMI_CLK_TYPE_LINEAR)
+		flags |= 1;
+
+	resp[3] = cpu_to_le32(clk->transition_latency);
+	resp[2] = cpu_to_le32(clk->rate_count);
+	resp[1] = cpu_to_le32(flags);
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	if (clk->name)
+		strlcpy((char *)&resp[4], clk->name, RPMI_CLK_NAME_LEN);
+
+	resp_dlen = 8 * sizeof(*resp);
+
+done:
+	*response_datalen = resp_dlen;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_get_supp_rates(struct rpmi_transport *trans, u16 request_datalen,
+			     const u8 *request_data, u16 *response_datalen,
+			     u8 *response_data)
+{
+	u32 i = 0, j = 0;
+	u32 rate_count;
+	u32 resp_dlen = 0, clk_rate_idx = 0;
+	u32 max_rates, remaining = 0, returned = 0;
+	const u64 *rate_array;
+	struct rpmi_clock *clk;
+
+	u32 *resp = (void *)response_data;
+
+	u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	clk = rpmi_get_clock(clkid);
+	if (clk) {
+		resp_dlen = sizeof(*resp);
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	rate_count = clk->rate_count;
+	rate_array = clk->rate_array;
+	if (!rate_count || !rate_array) {
+		resp_dlen = sizeof(*resp);
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_NOTSUPP);
+		goto done;
+	}
+
+	clk_rate_idx = cpu_to_le32(((const u32 *)request_data)[1]);
+
+	if (clk->type == RPMI_CLK_TYPE_LINEAR) {
+		/* max, min and step */
+		for (i = 0; i < 3; i++) {
+			resp[4 + 2 * i] = cpu_to_le32((u32)(rate_array[i]));
+			resp[5 + 2 * i] =
+				cpu_to_le32((u32)(rate_array[i] >> 32));
+		}
+		remaining = 0;
+		returned = 3;
+	} else if (clk->type == RPMI_CLK_TYPE_DISCRETE) {
+		if (clk_rate_idx > rate_count) {
+			resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+			resp_dlen = sizeof(*resp);
+			goto done;
+		}
+
+		/* max rates a rpmi message can accommodate */
+		max_rates = (trans->msg_data_size - (4 * sizeof(*resp))) /
+			    sizeof(u64);
+		remaining = rate_count - clk_rate_idx;
+		if (remaining > max_rates)
+			returned = max_rates;
+		else
+			returned = remaining;
+
+		for (i = clk_rate_idx, j = 0;
+		     i <= (clk_rate_idx + returned - 1); i++, j++) {
+			resp[4 + 2 * j] = cpu_to_le32((u32)(rate_array[i]));
+			resp[5 + 2 * j] =
+				cpu_to_le32((u32)(rate_array[i] >> 32));
+		}
+
+		remaining = rate_count - (clk_rate_idx + returned);
+	} else {
+		return RPMI_ERR_FAILED;
+	}
+
+	resp[3] = cpu_to_le32((u32)returned);
+	resp[2] = cpu_to_le32((u32)remaining);
+	/* No flags currently supported */
+	resp[1] = cpu_to_le32(0);
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	resp_dlen = (4 * sizeof(*resp)) + (returned * sizeof(u64));
+
+done:
+	*response_datalen = resp_dlen;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_set_config(struct rpmi_transport *trans, u16 request_datalen,
+			 const u8 *request_data, u16 *response_datalen,
+			 u8 *response_data)
+{
+	enum rpmi_error_codes status;
+	u32 cfg, new_state;
+	u32 *resp = (void *)response_data;
+
+	u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	if (clkid >= clock_count) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	cfg = cpu_to_le32(((const u32 *)request_data)[1]);
+
+	/* get command from 0th index bit in config field */
+	new_state = (cfg & 0b1) ? RPMI_CLK_STATE_ENABLED :
+				  RPMI_CLK_STATE_DISABLED;
+
+	/* change clock config synchronously */
+	status = rpmi_clock_set_state(clkid, new_state);
+	resp[0] = cpu_to_le32((u32)status);
+
+done:
+	*response_datalen = sizeof(*resp);
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_get_config(struct rpmi_transport *trans, u16 request_datalen,
+			 const u8 *request_data, u16 *response_datalen,
+			 u8 *response_data)
+{
+	u16 resp_dlen;
+	enum rpmi_error_codes status;
+	enum rpmi_clock_state state;
+	u32 *resp = (void *)response_data;
+
+	u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	if (clkid >= clock_count) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		resp_dlen = sizeof(*resp);
+		goto done;
+	}
+
+	status = rpmi_clock_get_state(clkid, &state);
+	if (status) {
+		resp[0] = cpu_to_le32((u32)status);
+		resp_dlen = sizeof(*resp);
+		goto done;
+	}
+
+	/** RPMI config field only return enabled or disabled state */
+	state = (state == RPMI_CLK_STATE_ENABLED) ? 1 : 0;
+
+	resp[1] = cpu_to_le32((u32)state);
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	resp_dlen = 2 * sizeof(*resp);
+
+done:
+	*response_datalen = resp_dlen;
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_set_rate(struct rpmi_transport *trans, u16 request_datalen,
+		       const u8 *request_data, u16 *response_datalen,
+		       u8 *response_data)
+{
+	enum rpmi_error_codes status;
+	enum rpmi_clock_rate_match rate_match;
+	u32 flags;
+	u32 rate_low, rate_hi;
+	u64 rate_u64;
+	u32 *resp = (void *)response_data;
+
+	u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	if (clkid >= clock_count) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	flags = cpu_to_le32(((const u32 *)request_data)[1]);
+
+	/* get rate match mode from flags */
+	rate_match = flags & 0b11;
+	if (rate_match >= RPMI_CLK_RATE_MATCH_MAX) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	rate_low = cpu_to_le32(((const u32 *)request_data)[2]);
+	rate_hi = cpu_to_le32(((const u32 *)request_data)[3]);
+
+	rate_u64 = ((u64)rate_hi << 32) | rate_low;
+	if (rate_u64 == RPMI_CLOCK_RATE_INVALID || rate_u64 == 0) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	status = rpmi_clock_set_rate(clkid, rate_match, rate_u64);
+	resp[0] = cpu_to_le32((u32)status);
+
+done:
+	*response_datalen = sizeof(*resp);
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_clock_sg_get_rate(struct rpmi_transport *trans, u16 request_datalen,
+		       const u8 *request_data, u16 *response_datalen,
+		       u8 *response_data)
+{
+	u16 resp_dlen;
+	enum rpmi_error_codes status;
+	u64 rate_u64;
+	u32 *resp = (void *)response_data;
+
+	u32 clkid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	if (clkid >= clock_count) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		resp_dlen = sizeof(*resp);
+		goto done;
+	}
+
+	status = rpmi_clock_get_rate(clkid, &rate_u64);
+	if (status) {
+		resp[0] = cpu_to_le32((u32)status);
+		resp_dlen = sizeof(*resp);
+		goto done;
+	}
+
+	resp[2] = cpu_to_le32((u32)(rate_u64 >> 32));
+	resp[1] = cpu_to_le32((u32)(rate_u64));
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	resp_dlen = 3 * sizeof(*resp);
+
+done:
+	*response_datalen = resp_dlen;
+	return RPMI_SUCCESS;
+}
+
+static const struct rpmi_service rpmi_clock_services[RPMI_CLK_SRV_ID_MAX_COUNT] = {
+	[RPMI_CLK_SRV_GET_NUM_CLOCKS] = {
+		.service_id = RPMI_CLK_SRV_GET_NUM_CLOCKS,
+		.min_a2p_request_datalen = 0,
+		.process_a2p_request = rpmi_clock_sg_get_num_clocks,
+	},
+	[RPMI_CLK_SRV_GET_ATTRIBUTES] = {
+		.service_id = RPMI_CLK_SRV_GET_ATTRIBUTES,
+		.min_a2p_request_datalen = 4,
+		.process_a2p_request = rpmi_clock_sg_get_attributes,
+	},
+	[RPMI_CLK_SRV_GET_SUPPORTED_RATES] = {
+		.service_id = RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+		.min_a2p_request_datalen = 8,
+		.process_a2p_request = rpmi_clock_sg_get_supp_rates,
+	},
+	[RPMI_CLK_SRV_SET_CONFIG] = {
+		.service_id = RPMI_CLK_SRV_SET_CONFIG,
+		.min_a2p_request_datalen = 8,
+		.process_a2p_request = rpmi_clock_sg_set_config,
+	},
+	[RPMI_CLK_SRV_GET_CONFIG] = {
+		.service_id = RPMI_CLK_SRV_GET_CONFIG,
+		.min_a2p_request_datalen = 4,
+		.process_a2p_request = rpmi_clock_sg_get_config,
+	},
+	[RPMI_CLK_SRV_SET_RATE] = {
+		.service_id = RPMI_CLK_SRV_SET_RATE,
+		.min_a2p_request_datalen = 16,
+		.process_a2p_request = rpmi_clock_sg_set_rate,
+	},
+	[RPMI_CLK_SRV_GET_RATE] = {
+		.service_id = RPMI_CLK_SRV_GET_RATE,
+		.min_a2p_request_datalen = 4,
+		.process_a2p_request = rpmi_clock_sg_get_rate,
+	},
+};
+
+const struct rpmi_service_group rpmi_sandbox_clock_sg = {
+	.name = "clk",
+	.max_service_id = RPMI_CLK_SRV_GET_RATE,
+	.servicegroup_version = RPMI_MKVER(1, 0),
+	.services = rpmi_clock_services,
+};
diff --git a/drivers/firmware/rpmi/rpmi-sandbox.c b/drivers/firmware/rpmi/rpmi-sandbox.c
new file mode 100644
index 000000000000..5597c27067eb
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sandbox.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <dm.h>
+#include <log.h>
+#include <rpmi-uclass.h>
+#include <dm/device_compat.h>
+
+#include "rpmi-sandbox.h"
+
+#define RPMI_SANDBOX_MIN_SLOT_SIZE 64
+#define RPMI_SANDBOX_SHMEM_HEADER_SIZE 8
+#define RPMI_SANDBOX_MAX_MSG_SIZE \
+	(RPMI_SANDBOX_MIN_SLOT_SIZE - RPMI_SANDBOX_SHMEM_HEADER_SIZE)
+
+#define DRIVER_NAME "rpmi-sandbox"
+#define DRIVER_NAME_LEN (sizeof(DRIVER_NAME))
+
+struct rpmi_sandbox {
+	struct udevice *dev;
+};
+
+const struct rpmi_service_group *rpmi_sandbox_sg(u32 servicegroup_id)
+{
+	switch (servicegroup_id) {
+	case RPMI_SRVGRP_CLOCK:
+		return &rpmi_sandbox_clock_sg;
+	default:
+		return NULL;
+	}
+}
+
+static int rpmi_sandbox_get_attr(struct rpmi_chan *chan,
+				 enum rpmi_attribute_id id, u32 *data)
+{
+	const struct rpmi_service_group *sg = rpmi_sandbox_sg(chan->id);
+
+	if (!sg)
+		return -EOPNOTSUPP;
+
+	switch (id) {
+	case RPMI_ATTR_SPEC_VERSION:
+		*data = RPMI_MKVER(1, 0);
+		break;
+	case RPMI_ATTR_MAX_MSG_DATA_SIZE:
+		*data = RPMI_SANDBOX_MAX_MSG_SIZE;
+		break;
+	case RPMI_ATTR_SERVICEGROUP_ID:
+		*data = chan->id;
+		break;
+	case RPMI_ATTR_SERVICEGROUP_VERSION:
+		*data = sg->servicegroup_version;
+		break;
+	case RPMI_ATTR_IMPL_ID:
+		*data = 0;
+		break;
+	case RPMI_ATTR_IMPL_VERSION:
+		*data = RPMI_MKVER(1, 0);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int rpmi_sandbox_request(struct rpmi_chan *chan, u32 service_id,
+				const void *request, unsigned long request_len,
+				void *response, unsigned long max_response_len,
+				unsigned long *out_response_len)
+{
+	const struct rpmi_service_group *sg = rpmi_sandbox_sg(chan->id);
+	const struct rpmi_service *service;
+	u8 slot[RPMI_SANDBOX_MAX_MSG_SIZE];
+	struct rpmi_transport trans = {
+		.msg_data_size = sizeof(slot),
+	};
+	u16 response_data_len = 0;
+	enum rpmi_error_codes err;
+
+	if (!sg)
+		return -EOPNOTSUPP;
+
+	if (service_id > sg->max_service_id)
+		return -EOPNOTSUPP;
+
+	service = &sg->services[service_id];
+
+	if (!service)
+		return -EOPNOTSUPP;
+
+	if (request_len < service->min_a2p_request_datalen)
+		return -EINVAL;
+
+	if (!service->process_a2p_request)
+		return -ENOSYS;
+
+	err = service->process_a2p_request(&trans, request_len, request,
+					   &response_data_len, slot);
+
+	if (err)
+		return rpmi_to_linux_error(err);
+
+	if (out_response_len)
+		*out_response_len = response_data_len;
+
+	if (response)
+		memcpy(response, slot,
+		       min(max_response_len, (unsigned long)response_data_len));
+
+	return 0;
+}
+
+static int rpmi_sandbox_of_xlate(struct rpmi_chan *chan,
+				 struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	chan->id = args->args[0];
+
+	return 0;
+}
+
+static int rpmi_sandbox_probe(struct udevice *dev)
+{
+	struct rpmi_sandbox *priv = dev_get_priv(dev);
+
+	priv->dev = dev;
+
+	return 0;
+}
+
+static const struct udevice_id rpmi_sandbox_ids[] = {
+	{ .compatible = "sandbox,rpmi-transport" },
+	{}
+};
+
+static const struct rpmi_transport_ops rpmi_sandbox_ops = {
+	.of_xlate = rpmi_sandbox_of_xlate,
+	.get_attr = rpmi_sandbox_get_attr,
+	.request = rpmi_sandbox_request,
+};
+
+U_BOOT_DRIVER(rpmi_sandbox) = {
+	.name = "rpmi-sandbox",
+	.id = UCLASS_RPMI,
+	.of_match = rpmi_sandbox_ids,
+	.probe = rpmi_sandbox_probe,
+	.priv_auto = sizeof(struct rpmi_sandbox),
+	.ops = &rpmi_sandbox_ops,
+};
diff --git a/drivers/firmware/rpmi/rpmi-sandbox.h b/drivers/firmware/rpmi/rpmi-sandbox.h
new file mode 100644
index 000000000000..132d1e9e8be6
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sandbox.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#ifndef _RPMI_SANDBOX_H
+#define _RPMI_SANDBOX_H
+
+#include <stdbool.h>
+#include <asm/types.h>
+#include <rpmi.h>
+
+struct rpmi_transport {
+	int msg_data_size;
+};
+
+struct rpmi_service {
+	/** ID of the service */
+	u8 service_id;
+
+	/** Minimum data length for handling request */
+	u16 min_a2p_request_datalen;
+
+	/** Callback to process a2p request */
+	enum rpmi_error_codes (*process_a2p_request)(
+		struct rpmi_transport *trans, u16 request_data_len,
+		const u8 *request_data, u16 *response_data_len,
+		u8 *response_data);
+};
+
+struct rpmi_service_group {
+	/** Name of the service group */
+	const char *name;
+
+	/** Maximum service ID of the service group */
+	int max_service_id;
+
+	/** Service group version */
+	u32 servicegroup_version;
+
+	/** Array of services indexed by service ID */
+	const struct rpmi_service *services;
+};
+
+extern const struct rpmi_service_group rpmi_sandbox_clock_sg;
+
+#endif
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 5dd6b57bbe84..c6372fa40583 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
 obj-$(CONFIG_$(PHASE_)DM_RNG) += rng.o
 obj-$(CONFIG_DM_RTC) += rtc.o
 obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
+obj-$(CONFIG_RPMI_FIRMWARE) += rpmi.o
 obj-$(CONFIG_SCSI) += scsi.o
 obj-$(CONFIG_DM_SERIAL) += serial.o
 obj-$(CONFIG_DM_SPI_FLASH) += sf.o
diff --git a/test/dm/rpmi.c b/test/dm/rpmi.c
new file mode 100644
index 000000000000..7cb4fd11a46d
--- /dev/null
+++ b/test/dm/rpmi.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <rpmi.h>
+#include <stdio.h>
+#include <test/ut.h>
+
+static int dm_test_rpmi_clock(struct unit_test_state *uts)
+{
+	struct udevice *rpmi_dev, *clk_dev;
+	struct clk clk0, clk1, clk2, clk3;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_RPMI, "rpmi", &rpmi_dev));
+
+	ut_assertok(
+		uclass_get_device_by_name(UCLASS_CLK, "rpmi-clock", &clk_dev));
+
+	// Grab clock 0 and retrieve the rate
+	ut_assertok(clk_get_by_index(clk_dev, 0, &clk0));
+	ut_asserteq_64(20000000, clk_get_rate(&clk0));
+
+	// Change to 1GHz
+	ut_asserteq(1000000000, clk_set_rate(&clk0, 1000000000));
+
+	// Revert back to 200MHz
+	ut_asserteq(20000000, clk_set_rate(&clk0, 20000000));
+
+	// Grab clock 1
+	ut_assertok(clk_get_by_index(clk_dev, 1, &clk1));
+	ut_asserteq_64(333333333, clk_get_rate(&clk1));
+
+	// Grab clock 2
+	ut_assertok(clk_get_by_index(clk_dev, 2, &clk2));
+	ut_asserteq_64(500000000, clk_get_rate(&clk2));
+
+	// Grab clock 3
+	ut_assertok(clk_get_by_index(clk_dev, 3, &clk3));
+	ut_asserteq_64(50000000, clk_get_rate(&clk3));
+
+	return 0;
+}
+DM_TEST(dm_test_rpmi_clock, UTF_SCAN_FDT);

-- 
2.53.0

