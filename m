Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E517CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 08:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95F8802C1;
	Wed,  1 Oct 2025 10:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HdbT5MGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBE0807C0; Wed,  1 Oct 2025 10:20:54 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E188800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 10:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5918KmVk3041397;
 Wed, 1 Oct 2025 03:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759306848;
 bh=4/zGh2Xn0ZmJPvd7eLNc1Z1QYkSGEc9K0zrb+NRD6Q4=;
 h=From:To:CC:Subject:Date;
 b=HdbT5MGwZE8jok6TUh1E1LpYMYsAnjl6Ym+p8QhUXd1J/PChFW2e8aQn9jOQt1zxk
 0emEVxi4zLUucorRNxLjT+Auxt2QpbGVMbLhTh1HD0uhRAVL3enmPL4dZ1Jkhe/P7K
 ZtMi+xCg+ZtZHYOpqIOPPjRdhn8WgBniaQsXuNVc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5918KmMH2730130
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 1 Oct 2025 03:20:48 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 1
 Oct 2025 03:20:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 03:20:48 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5918KjGs295690;
 Wed, 1 Oct 2025 03:20:46 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <s-k6@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH] cmd: ti: Add DDRSS ECC test command
Date: Wed, 1 Oct 2025 13:50:45 +0530
Message-ID: <20251001082045.3547143-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Georgi Vlaev <g-vlaev@ti.com>

Introduce a new version of the Keystone-II "ddr" command for testing the
inline ECC support in the DDRSS bridge available on K3 devices. The ECC
hardware support in K3's DDRSS and the test method differ substantially
from what we support in the K2 variant of the command. The name of the
new command is "ddrss" and it presently supports only single controller
testing.

The ECC test procedure follows these steps:
1) Flush and disable the data cache.
2) Disable the protected ECC Rx range.
3) Flip a bit in the address.
4) Restore the range to original.
5) Read the modified value (corrected).
6) Re-enable the data cache.

This will cause the 1-bit ECC error count to increase while the read
will return the corrected value.

The K3 version of the command extends the syntax for the "ecc_err"
argument by also introducing an argument for range which specifies which
range (0, 1, 2) the address is located in.

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
[n-francis@ti.com: Add J7 and multiple-region support, simplify logic]
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Test logs on J784S4-EVM (after modifying for single controller with ECC enabled)
https://gist.github.com/nehamalcom/80437234ddd2e22007dec3d1c37dcd6a

 cmd/ti/Kconfig  |   7 ++
 cmd/ti/Makefile |   1 +
 cmd/ti/ddrss.c  | 243 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 cmd/ti/ddrss.c

diff --git a/cmd/ti/Kconfig b/cmd/ti/Kconfig
index 9442c9993c1..0d6c86bad3e 100644
--- a/cmd/ti/Kconfig
+++ b/cmd/ti/Kconfig
@@ -8,6 +8,13 @@ config CMD_DDR3
 	   supports memory verification, memory comapre and ecc
 	   verification if supported.
 
+config CMD_DDRSS
+	bool "command for verifying DDRSS Inline ECC features"
+	help
+	   Support for testing DDRSS on TI platforms. This command supports
+	   memory verification, memory compare and inline ECC verification
+	   if supported.
+
 config CMD_PD
 	bool "command for verifying power domains"
 	depends on TI_POWER_DOMAIN
diff --git a/cmd/ti/Makefile b/cmd/ti/Makefile
index 5f9c64f598a..d0555e7edf6 100644
--- a/cmd/ti/Makefile
+++ b/cmd/ti/Makefile
@@ -2,4 +2,5 @@
 # Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-$(CONFIG_CMD_DDR3) += ddr3.o
+obj-$(CONFIG_CMD_DDRSS) += ddrss.o
 obj-$(CONFIG_CMD_PD) += pd.o
diff --git a/cmd/ti/ddrss.c b/cmd/ti/ddrss.c
new file mode 100644
index 00000000000..d1481547938
--- /dev/null
+++ b/cmd/ti/ddrss.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DDRSS: DDR 1-bit inline ECC test command
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <asm/io.h>
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <command.h>
+#include <cpu_func.h>
+#include <linux/bitops.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define K3_DDRSS_MAX_ECC_REGIONS	3
+
+#if (IS_ENABLED(CONFIG_SOC_K3_J784S4) ||\
+	IS_ENABLED(CONFIG_SOC_K3_J721S2) ||\
+	IS_ENABLED(CONFIG_SOC_K3_J7200) ||\
+	IS_ENABLED(CONFIG_SOC_K3_J721E))
+#define DDRSS_BASE			0x2980000
+#else
+#define DDRSS_BASE			0x0f300000
+#endif
+
+#define DDRSS_V2A_CTL_REG		0x0020
+#define DDRSS_V2A_INT_RAW_REG		0x00a0
+#define DDRSS_V2A_INT_STAT_REG		0x00a4
+#define DDRSS_V2A_INT_ECC1BERR		BIT(3)
+#define DDRSS_V2A_INT_ECC2BERR		BIT(4)
+#define DDRSS_V2A_INT_ECCM1BERR        BIT(5)
+#define DDRSS_ECC_CTRL_REG		0x0120
+#define DDRSS_ECC_CTRL_REG_ECC_EN	BIT(0)
+#define DDRSS_ECC_CTRL_REG_RMW_EN	BIT(1)
+#define DDRSS_ECC_CTRL_REG_ECC_CK	BIT(2)
+#define DDRSS_ECC_CTRL_REG_WR_ALLOC	BIT(4)
+#define DDRSS_ECC_R0_STR_ADDR_REG	0x0130
+#define DDRSS_ECC_Rx_STR_ADDR_REG(x)	(0x0130 + ((x) * 8))
+#define DDRSS_ECC_Rx_END_ADDR_REG(x)	(0x0134 + ((x) * 8))
+#define DDRSS_ECC_1B_ERR_CNT_REG	0x0150
+#define DDRSS_ECC_1B_ERR_THRSH_REG	0x0154
+#define DDRSS_ECC_1B_ERR_ADR_REG	0x0158
+#define DDRSS_ECC_1B_ERR_MSK_LOG_REG	0x015c
+
+static inline u32 ddrss_read(u32 reg)
+{
+	return readl((unsigned long)(DDRSS_BASE + reg));
+}
+
+static inline void ddrss_write(u32 value, u32 reg)
+{
+	writel(value, (unsigned long)(DDRSS_BASE + reg));
+}
+
+/* ddrss_check_ecc_status()
+ * Report the ECC state after test. Check/clear the interrupt
+ * status register, dump the ECC err counters and ECC error offset.
+ */
+static void ddrss_check_ecc_status(void)
+{
+	u32 ecc_1b_err_cnt, v2a_int_raw, ecc_1b_err_msk;
+	phys_addr_t ecc_1b_err_adr;
+
+	v2a_int_raw = ddrss_read(DDRSS_V2A_INT_RAW_REG);
+
+	/* 1-bit correctable */
+	if (v2a_int_raw & DDRSS_V2A_INT_ECC1BERR) {
+		puts("\tECC test: DDR ECC 1-bit error\n");
+
+		/* Dump the 1-bit counter and reset it, as we want a
+		 * new interrupt to be generated when above the error
+		 * threshold
+		 */
+		ecc_1b_err_cnt = ddrss_read(DDRSS_ECC_1B_ERR_CNT_REG);
+		if (ecc_1b_err_cnt) {
+			printf("\tECC test: 1-bit ECC err count: %u\n",
+			       ecc_1b_err_cnt & 0xffff);
+			ddrss_write(1, DDRSS_ECC_1B_ERR_CNT_REG);
+		}
+
+		/* ECC fault addresses are also recorded in a 2-word deep
+		 * FIFO. Calculate and report the 8-byte range of the error
+		 */
+		ecc_1b_err_adr = ddrss_read(DDRSS_ECC_1B_ERR_ADR_REG);
+		ecc_1b_err_msk = ddrss_read(DDRSS_ECC_1B_ERR_MSK_LOG_REG);
+		if (ecc_1b_err_msk) {
+			if ((IS_ENABLED(CONFIG_SOC_K3_AM642)) ||
+			    (IS_ENABLED(CONFIG_SOC_K3_AM625))) {
+				/* AM64/AM62:
+				 * The address of the ecc error is 16-byte aligned.
+				 * Each bit in 4 bit mask represents 8 bytes ECC quanta
+				 * that has the 1-bit error
+				 */
+				ecc_1b_err_msk &= 0xf;
+				ecc_1b_err_adr <<= 4;
+				ecc_1b_err_adr += (fls(ecc_1b_err_msk) - 1) * 8;
+			} else {
+				/* AM62A/AM62P:
+				 * The address of the ecc error is 32-byte aligned.
+				 * Each bit in 8 bit mask represents 8 bytes ECC quanta
+				 * that has the 1-bit error
+				 */
+				ecc_1b_err_msk &= 0xff;
+				ecc_1b_err_adr <<= 5;
+				ecc_1b_err_adr += (fls(ecc_1b_err_msk) - 1) * 8;
+			}
+
+			printf("\tECC test: 1-bit error in [0x%llx:0x%llx]\n",
+			       ecc_1b_err_adr, ecc_1b_err_adr + 8);
+			/* Pop the top of the addr/mask FIFOs */
+			ddrss_write(1, DDRSS_ECC_1B_ERR_ADR_REG);
+			ddrss_write(1, DDRSS_ECC_1B_ERR_MSK_LOG_REG);
+		}
+		ddrss_write(DDRSS_V2A_INT_ECC1BERR, DDRSS_V2A_INT_STAT_REG);
+	}
+
+	/* 2-bit uncorrectable */
+	if (v2a_int_raw & DDRSS_V2A_INT_ECC2BERR) {
+		puts("\tECC test: DDR ECC 2-bit error\n");
+		ddrss_write(DDRSS_V2A_INT_ECC2BERR, DDRSS_V2A_INT_STAT_REG);
+	}
+
+	/* multiple 1-bit errors (uncorrectable) in multiple words */
+	if (v2a_int_raw & DDRSS_V2A_INT_ECCM1BERR) {
+		puts("\tECC test: DDR ECC multi 1-bit errors\n");
+		ddrss_write(DDRSS_V2A_INT_ECCM1BERR, DDRSS_V2A_INT_STAT_REG);
+	}
+}
+
+/* ddrss_memory_ecc_err()
+ * Simulate an ECC error - change a 32b word at address in an ECC enabled
+ * range. This removes the tested address from the ECC checks, changes a
+ * word, and then restores the ECC range as configured by k3_ddrss in R5 SPL.
+ */
+static int ddrss_memory_ecc_err(u64 addr, u64 ecc_err, int range)
+{
+	u64 ecc_start_addr, ecc_end_addr, ecc_temp_addr;
+	u64 val1, val2, val3;
+
+	/* Flush and disable dcache */
+	flush_dcache_all();
+	dcache_disable();
+
+	/* Setup a threshold for 1-bit errors to generate interrupt */
+	ddrss_write(1, DDRSS_ECC_1B_ERR_THRSH_REG);
+
+	puts("Testing DDR ECC:\n");
+	/* Get the Rx range configuration */
+	ecc_start_addr = ddrss_read(DDRSS_ECC_Rx_STR_ADDR_REG(range));
+	ecc_end_addr = ddrss_read(DDRSS_ECC_Rx_END_ADDR_REG(range));
+
+	/* Calculate the end of the Rx ECC region up to the tested address */
+	ecc_temp_addr = (addr - gd->ram_base) >> 16;
+
+	puts("\tECC test: Disabling DDR ECC ...\n");
+	/* Disable entire region */
+	ddrss_write(ecc_start_addr, DDRSS_ECC_Rx_END_ADDR_REG(range));
+	ddrss_write(ecc_end_addr, DDRSS_ECC_Rx_STR_ADDR_REG(range));
+
+	/* Inject error in the address */
+	val1 = readl((unsigned long long)addr);
+	val2 = val1 ^ ecc_err;
+	writel(val2, (unsigned long long)addr);
+	val3 = readl((unsigned long long)addr);
+
+	/* Re-enable the ECC checks for the R0 region */
+	ddrss_write(ecc_end_addr, DDRSS_ECC_Rx_END_ADDR_REG(range));
+	ddrss_write(ecc_start_addr, DDRSS_ECC_Rx_STR_ADDR_REG(range));
+	/* Make sure the ECC range is restored before doing anything else */
+	mb();
+
+	printf("\tECC test: addr 0x%llx, read data 0x%llx, written data 0x%llx, err pattern: 0x%llx, read after write data 0x%llx\n",
+	       addr, val1, val2, ecc_err, val3);
+
+	puts("\tECC test: Enabled DDR ECC ...\n");
+	/* Read again from the address. This creates an ECC 1-bit error
+	 * condition, and returns the corrected value
+	 */
+	val1 = readl((unsigned long long)addr);
+	printf("\tECC test: addr 0x%llx, read data 0x%llx\n", addr, val1);
+
+	/* Set threshold for 1-bit errors to 0 to disable the interrupt */
+	ddrss_write(0, DDRSS_ECC_1B_ERR_THRSH_REG);
+	/* Report the ECC status */
+	ddrss_check_ecc_status();
+
+	dcache_enable();
+
+	return 0;
+}
+
+/* ddrss_is_ecc_enabled()
+ * Report if ECC is enabled.
+ */
+static int ddrss_is_ecc_enabled(void)
+{
+	u32 ecc_ctrl = ddrss_read(DDRSS_ECC_CTRL_REG);
+
+	/* Assume ECC is enabled only if all bits set by k3_ddrss are set */
+	return (ecc_ctrl & (DDRSS_ECC_CTRL_REG_ECC_EN |
+			    DDRSS_ECC_CTRL_REG_RMW_EN |
+			    DDRSS_ECC_CTRL_REG_WR_ALLOC |
+			    DDRSS_ECC_CTRL_REG_ECC_CK));
+}
+
+static int do_ddrss_test(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	u64 start_addr, ecc_err, x;
+
+	if (!(argc == 5 && (strncmp(argv[1], "ecc_err", 8) == 0)))
+		return cmd_usage(cmdtp);
+
+	if (!ddrss_is_ecc_enabled()) {
+		puts("ECC not enabled. Please enable ECC any try again\n");
+		return CMD_RET_FAILURE;
+	}
+
+	start_addr = simple_strtoul(argv[2], NULL, 16);
+	ecc_err = simple_strtoul(argv[3], NULL, 16);
+	x = simple_strtoul(argv[4], NULL, 16);
+
+	if (!((start_addr >= gd->bd->bi_dram[0].start &&
+	       (start_addr <= (gd->bd->bi_dram[0].start + gd->bd->bi_dram[0].size - 1))) ||
+	      (start_addr >= gd->bd->bi_dram[1].start &&
+	       (start_addr <= (gd->bd->bi_dram[1].start + gd->bd->bi_dram[1].size - 1))))) {
+		puts("Address is not in the DDR range\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ddrss_memory_ecc_err(start_addr, ecc_err, x);
+	return 0;
+}
+
+U_BOOT_CMD(ddrss, 5, 1, do_ddrss_test,
+	   "DDRSS test",
+	   "ecc_err <addr in hex> <bit_err in hex> <range 0/1/2> - generate bit errors\n"
+	   "	in DDR data at <addr>, the command will read a 32-bit data\n"
+	   "	from <addr>, and write (data ^ bit_err) back to <addr>\n"
+	   "	in range 0, 1, or 2 (if default full region ECC is enabled, choose 0)\n"
+);
-- 
2.34.1

