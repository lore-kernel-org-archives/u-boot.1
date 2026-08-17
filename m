Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0115FC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B86B1607B5;
	Mon, 17 Aug 2026 15:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M75RFvAc1W9j; Mon, 17 Aug 2026 15:34:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E492607A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980867;
	bh=XMvbXPyKKO4/J1amitWr8Wfg8Rs4XqA3dr0C1sNfliM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gy6cN5UqZMTzGh/yyYOdfWYmFCoxhcw1GfjCA/tthAQTwkKIWfcB4V41ottY+bzd6
	 +KoKbtrgmXfkWE2RGxW3P0x4qzemtn68ReMUA0CV9ZRKRQN9L+ez/jFJpLcReyNVog
	 +v/mok1YDpxdng7iebo09TKXuv3fTYi0Q5GaNe+rz7rmF2HPj3hJezHhETWKOazXxc
	 Q1uCl9vz5kwZw/GvIanBEtBK7JsMfytODxssEKHhtOpVI8tBV/ZH9F9jvqMNdfnZQJ
	 BHY6+vBuw3+zh6yTaOPbxWE/Z5YMRfEiBxRbLtPONJFCCrajE5rW9BTNVS4uxRh2uk
	 vZt6h1ZlS2S3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E492607A2;
	Mon, 17 Aug 2026 15:34:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E538194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 905F780C53
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYvPlAC_5tYx for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:34:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8884B80C06
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8884B80C06
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oauWh6J5
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8884B80C06
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id C68CAB00573;
 Mon, 17 Aug 2026 17:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980862;
 bh=J+wiF779UcKSM9Qvq2f59plu1BV48fzqS+BnUHt5fsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oauWh6J5FlefgcmgFGbalI0Be7C5W9o7IgpF4KgntnEZ+FpL/WzzciA16EJjYbfym
 umVHC+hfT32Knt2Cd4pqhvYMmxWgTBTlgY2CoHI+FEcnElOaQjnfyXE8EVjKoBrJze
 3KuvcArcHXniiWIlyBuVhLy9V8YQWVKB2m/H4pgWwjNSNtSaN/4/ZqLlZ9ml+UXk2T
 rFpGi0MmU0CunkVC4pb4Ib6peNWnSs8M30H+dH7F2xB+TgUkfL2pl+RP9QLXd/9AOs
 Dg/m6M6wcFAUQ+J/LVOAwlrcXphGfdJ0OxHfsngsWL+mCNErY4DRylilVweZuG6Y7v
 k8wYSy5r5Ps/g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 08/23] board: nbxv3: add DPLL status (ZL30733, ZL30643)
Date: Mon, 17 Aug 2026 17:31:26 +0200
Message-ID: <20260817153144.1951036-9-vjardin@free.fr>
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

Add a boot time probe for each Microsemi/Microchip DPLL on the
board:
 - ZL30733
 - ZL30643

Linux: full DPLL configuration (clock tree programming, output enables,
holdover policy, line side rates) is the job of the Linux DPLL driver
at runtime. U-Boot only verifies presence and identity, it does not
program any output.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts     |   8 ++
 board/nxp/lx2160a/Kconfig              |   7 +
 board/nxp/lx2160a/nbxv3/Makefile       |   1 +
 board/nxp/lx2160a/nbxv3/dpll_zl30733.c | 183 +++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/dpll_zl30733.c

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 8e336a622f3..9dcc1bf1d5e 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -57,3 +57,11 @@
 		regulator-always-on;
 	};
 };
+
+&dspi0 { /* DSPI1: on module management SPI */
+	dpll@0 {
+		compatible = "microchip,zl30733";
+		reg = <0>;
+		spi-max-frequency = <12500000>;
+	};
+};
diff --git a/board/nxp/lx2160a/Kconfig b/board/nxp/lx2160a/Kconfig
index e46223d1b43..12d2e418aa5 100644
--- a/board/nxp/lx2160a/Kconfig
+++ b/board/nxp/lx2160a/Kconfig
@@ -76,4 +76,11 @@ config NBXV3_PMBUS
 	select DM_REGULATOR_PMBUS_GENERIC
 	select CMD_REGULATOR
 
+config NBXV3_DPLL
+	bool
+	default y
+	select SPI
+	select DM_SPI
+	select FSL_DSPI
+
 endif
diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index 4ce2508249d..c8a676fb708 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -4,6 +4,7 @@
 
 obj-y += eth_nbxv3.o
 obj-y += carrier.o
+obj-y += dpll_zl30733.o
 obj-y += mps_pmbus.o
 obj-y += psu_pmbus.o
 obj-y += vid_handoff.o
diff --git a/board/nxp/lx2160a/nbxv3/dpll_zl30733.c b/board/nxp/lx2160a/nbxv3/dpll_zl30733.c
new file mode 100644
index 00000000000..4dfa4579cce
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/dpll_zl30733.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 - DPLL identification probe (both DPLLs).
+ *
+ * It reads a small set of read-only descriptor registers from each
+ * Microsemi/Microchip DPLL on the board and prints the result on the
+ * console at EVT_LAST_STAGE_INIT time, just before the prompt.
+ * It is purely a basic power on test diagnostic: no configuration
+ * register is written, the DPLL register profile loaded at power-on
+ * is left untouched.
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <event.h>
+#include <log.h>
+#include <spi.h>
+#include <vsprintf.h>
+#include <linux/delay.h>
+
+#define ZL30733_SPI_HZ		12500000
+#define ZL30733_SPI_MODE	SPI_MODE_0
+
+/* The two DPLLs sharing the ZL3073x register protocol on this board */
+static const struct nbxv3_dpll {
+	const char *label;	/* expected part at this location */
+	const char *devname;	/* DM device name for the ad-hoc slave */
+	int bus;		/* U-Boot SPI bus number */
+	int cs;			/* chip select on that bus */
+	u32 hz;			/* SCK ceiling */
+	const char *hint;	/* what to check when reads are implausible */
+} nbxv3_dplls[] = {
+	{
+		.label = "ZL30733", .devname = "zl30733_dpll",
+		.bus = 0, .cs = 0, .hz = ZL30733_SPI_HZ,
+		.hint = "check PROG_DPLL_EN mux",
+	},
+	{
+		.label = "ZL30643", .devname = "zl30643_dpll",
+		.bus = 2, .cs = 1, .hz = 10000000,
+		.hint = "check CS1 rework / RST_B",
+	},
+};
+
+#define ZL30733_REG_INFO	0x00
+#define ZL30733_REG_ID_HI	0x01
+#define ZL30733_REG_ID_LO	0x02
+#define ZL30733_REG_REVISION	0x03
+#define ZL30733_REG_FW_VER	0x05	/* 6 bytes 0x05..0x0A   */
+#define ZL30733_REG_FW_VER_LEN	6
+#define ZL30733_REG_RST_STATUS	0x18
+#define ZL30733_REG_PAGE_SEL	0x7F
+
+#define ZL30733_CMD_READ	0x80	/* OR'd into the 7-bit address */
+
+#define ZL30733_INFO_DEFAULT		0x21
+#define ZL30733_INFO_ID_MASK		0x7f
+#define ZL30733_INFO_EEPROM_BOOTED	0x80
+#define ZL30733_REV_DEFAULT		0x03
+
+static int zl30733_read_block(struct spi_slave *slave, u8 addr, u8 *buf,
+			      size_t len)
+{
+	u8 cmd = ZL30733_CMD_READ | (addr & 0x7F);
+	int ret;
+
+	ret = spi_xfer(slave, 8, &cmd, NULL, SPI_XFER_BEGIN);
+	if (ret)
+		return ret;
+
+	return spi_xfer(slave, len * 8, NULL, buf, SPI_XFER_END);
+}
+
+static int zl30733_select_page0(struct spi_slave *slave)
+{
+	u8 cmd[2] = { ZL30733_REG_PAGE_SEL & 0x7F, 0x00 };
+
+	return spi_xfer(slave, sizeof(cmd) * 8, cmd, NULL,
+			SPI_XFER_BEGIN | SPI_XFER_END);
+}
+
+static int zl30733_dump(struct spi_slave *slave, const struct nbxv3_dpll *d)
+{
+	u8 info, rev, rst;
+	u8 fw[ZL30733_REG_FW_VER_LEN];
+	u8 idbuf[2];
+	u16 id;
+	int ret;
+	bool plausible;
+
+	ret = zl30733_select_page0(slave);
+	if (ret) {
+		printf("DPLL: %s page select failed (%d)\n", d->label, ret);
+		return ret;
+	}
+
+	ret = zl30733_read_block(slave, ZL30733_REG_INFO, &info, 1);
+	if (ret)
+		return ret;
+	ret = zl30733_read_block(slave, ZL30733_REG_ID_HI, idbuf, sizeof(idbuf));
+	if (ret)
+		return ret;
+	id = ((u16)idbuf[0] << 8) | idbuf[1];
+	ret = zl30733_read_block(slave, ZL30733_REG_REVISION, &rev, 1);
+	if (ret)
+		return ret;
+	ret = zl30733_read_block(slave, ZL30733_REG_FW_VER, fw, sizeof(fw));
+	if (ret)
+		return ret;
+	ret = zl30733_read_block(slave, ZL30733_REG_RST_STATUS, &rst, 1);
+	if (ret)
+		return ret;
+
+	plausible = (info & ZL30733_INFO_ID_MASK) == ZL30733_INFO_DEFAULT &&
+		    id != 0x0000 && id != 0xFFFF;
+
+	printf("DPLL: %s @ spi%d:%d  info=0x%02x (%s) id=0x%04x rev=0x%02x\n",
+	       d->label, d->bus, d->cs, info,
+	       (info & ZL30733_INFO_EEPROM_BOOTED) ? "EEPROM boot" : "MCU default boot",
+	       id, rev);
+	printf("      fw_ver=%02x:%02x:%02x:%02x:%02x:%02x  reset_status=0x%02x",
+	       fw[0], fw[1], fw[2], fw[3], fw[4], fw[5], rst);
+	if (!plausible)
+		printf("  [implausible; %s]", d->hint);
+	printf("\n");
+
+	return plausible ? 0 : 1;
+}
+
+static int zl30733_probe_print(void)
+{
+	struct udevice *bus;
+	struct spi_slave *slave;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(nbxv3_dplls); i++) {
+		const struct nbxv3_dpll *d = &nbxv3_dplls[i];
+
+		ret = _spi_get_bus_and_cs(d->bus, d->cs, d->hz,
+					  ZL30733_SPI_MODE,
+					  "spi_generic_drv", d->devname,
+					  &bus, &slave);
+		if (ret) {
+			printf("DPLL: %s spi%d:%d not reachable (%d)\n",
+			       d->label, d->bus, d->cs, ret);
+			continue;
+		}
+
+		ret = spi_claim_bus(slave);
+		if (ret) {
+			printf("DPLL: %s spi_claim_bus failed (%d)\n",
+			       d->label, ret);
+			continue;
+		}
+
+		zl30733_dump(slave, d);
+
+		spi_release_bus(slave);
+	}
+
+	return 0;
+}
+
+static int nbxv3_dpll_last_stage_init(void)
+{
+	zl30733_probe_print();
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_dpll_last_stage_init);
+
+static int do_dpll_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	return zl30733_probe_print() < 0 ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(
+	dpll_info, 1, 0, do_dpll_info,
+	"display ZL30733 + ZL30643 DPLL identification + reset status",
+	""
+);
-- 
2.43.0

