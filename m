Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EC2D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A99896A8;
	Thu, 21 Nov 2024 06:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166793;
	bh=oSpK8WFQCLViKkSyLR/XdA6BlhZzSpTI1Cz+5AQ184o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y7ckf6Mivu2Fn6fnD+JER4vGuz4LwUH0JwGlsWlxOJzYo3hwwt26ooA9PigAIVfaS
	 gTdmKjlKHD/JT4o9Mf6gWAzE8UHrhq1/8jcPRU03QqAA6Redu2G0GqDm21suUb41Dq
	 aSzyqGbSZ8QRR73mRKVbeaGD/rZIOH0cWf2rsv39Ilr22mF6wYr78F6RNdMi2/f4qB
	 oRRICGmDqoEJjjPTxEIk95fFMQTnVgdXmvw+Fi1SAy2WfSiFzAZ8s6lUtRpfGuBfye
	 PHaqJnAQN71DrZVZer7w0z9DOgJbhiNILjELbaRORxGswcji0pIquHWEYzMROwemDy
	 NK0AXtSNvS5hA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 448F5896C1;
 Thu, 21 Nov 2024 06:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166785;
 bh=oSpK8WFQCLViKkSyLR/XdA6BlhZzSpTI1Cz+5AQ184o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C4n/P2BakllOZbvHpZi7jyrpLFoHDEDRYc632iTeozY60Ws+BgQ89Sfa8is7TOFXc
 Qxv1GnPJJcayzgpVRDc00+QCDpKfO+1uS+lIjD+17BdplmXxWZuI7gvoLW7qRWe2Jz
 4KjsuFl5jcgOUWXI6COnwpNLcn056/1vupLTDonrV3cnphoJCHtpdjwvNgQwGszHpD
 uTijSEeCswV299oitdXLnRsuAtXQRGymALdXrypNzYYFcQAWTZs+DFpvin/Wd6lCLu
 blS/ph9xS8Yqt0QCjgJ6a1GjoCdTsSntcWCmTZ0tyK5KuPFMTccCiwPb/3jqBQySdC
 h9QjdRX1xJyBg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 19/20] siemens: add ddr signal integrity test
Date: Thu, 21 Nov 2024 06:26:00 +0100
Message-Id: <20241121052601.72880-20-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Enrico Leto <enrico.leto@siemens.com>

The signal integrity test generates pattern on DDR lines
for certification. The signals must be as fast as possible
and unidirectional.

The test is required from our HW team. The available
u-boot memory test doesn't full fill the our requirements.

The test is planed to be used in all new siemens boards.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v2)

Changes in v2:
Add From tag

 board/siemens/capricorn/Kconfig    |   2 +
 board/siemens/capricorn/Makefile   |   1 +
 board/siemens/common/Kconfig       |   4 +
 board/siemens/common/ddr_si_test.c | 348 +++++++++++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 board/siemens/common/ddr_si_test.c

diff --git a/board/siemens/capricorn/Kconfig b/board/siemens/capricorn/Kconfig
index 03a433df2aa..fe230971e97 100644
--- a/board/siemens/capricorn/Kconfig
+++ b/board/siemens/capricorn/Kconfig
@@ -21,3 +21,5 @@ config SPL_CMT
 	depends on SPL
 	help
 	  Enable SIemens SPL RAM test.
+
+source "board/siemens/common/Kconfig"
diff --git a/board/siemens/capricorn/Makefile b/board/siemens/capricorn/Makefile
index b8350d96d04..a03d54ef3b3 100644
--- a/board/siemens/capricorn/Makefile
+++ b/board/siemens/capricorn/Makefile
@@ -11,4 +11,5 @@ obj-y += spl.o
 obj-$(CONFIG_SPL_CMT) += spl_memory_test.o
 else
 obj-y += ../common/factoryset.o
+obj-$(CONFIG_DDR_SI_TEST) += ../common/ddr_si_test.o
 endif
diff --git a/board/siemens/common/Kconfig b/board/siemens/common/Kconfig
index 131439fcfea..4ae12b1c973 100644
--- a/board/siemens/common/Kconfig
+++ b/board/siemens/common/Kconfig
@@ -1,2 +1,6 @@
 config FACTORYSET
 	bool
+
+config DDR_SI_TEST
+	bool "DDR signal integrity test implementations"
+	default y
diff --git a/board/siemens/common/ddr_si_test.c b/board/siemens/common/ddr_si_test.c
new file mode 100644
index 00000000000..c1f523eb3f4
--- /dev/null
+++ b/board/siemens/common/ddr_si_test.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright Siemens AG 2023
+ *
+ * DDR signal integrity test
+ *   Check signals on DDR lines
+ *   - signals must be as fast as possible and generate long burst
+ *   - signals must be unidirectional (to DDR or from DDR only)
+ *
+ *   Set pattern: define 2^n 32-bit patterns (up to 4)
+ *   Addresses: must be multiple of 16 to avoid checks in loops
+ *   Test functions
+ *   - write: write pattern to memory area for iteration times
+ *   - read: write pattern once to memory area, read for iteration times
+ */
+
+#include <command.h>
+#include <exports.h>
+#include <time.h>
+#if CONFIG_IS_ENABLED(AM33XX)
+#include <asm/arch-am33xx/hardware_am33xx.h>
+#include <asm/arch-am33xx/cpu.h>
+#include <asm/io.h>
+#endif
+
+/* enable some print for debugging */
+#ifdef PR_DEBUG
+	#define PDEBUG(fmt, args...) printf(fmt, ## args)
+#else
+	#define PDEBUG(fmt, args...)
+#endif
+
+/* define 4 32-bit patterns */
+#define MAX_PTN_SIZE (128)
+#define PTN_ARRAY_SIZE (MAX_PTN_SIZE / (8 * sizeof(u32)))
+
+/* define test direction */
+#define DIR_READ	0
+#define DIR_WRITE	1
+
+static union {
+	u64 l[2];
+	u32 s[4];
+	} test_pattern;
+static int num_ptn32;
+
+#if CONFIG_IS_ENABLED(AM33XX)
+static inline void wdt_disable(void)
+{
+	struct wd_timer *wdtimer = (struct wd_timer *)WDT_BASE;
+
+	writel(0xAAAA, &wdtimer->wdtwspr);
+	while (readl(&wdtimer->wdtwwps) != 0x0)
+		;
+	writel(0x5555, &wdtimer->wdtwspr);
+	while (readl(&wdtimer->wdtwwps) != 0x0)
+		;
+}
+
+static inline void wdt_enable(void)
+{
+	struct wd_timer *wdtimer = (struct wd_timer *)WDT_BASE;
+
+	writel(0xBBBB, &wdtimer->wdtwspr);
+	while (readl(&wdtimer->wdtwwps) != 0x0)
+		;
+	writel(0x4444, &wdtimer->wdtwspr);
+	while (readl(&wdtimer->wdtwwps) != 0x0)
+		;
+}
+#else /* ! */
+static inline void wdt_disable(void) {}
+
+static inline void wdt_enable(void) {}
+#endif /* CONFIG_IS_ENABLED(AM33XX) */
+
+static int do_ddr_set_ptn(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	int i, n;
+
+	if (argc < 1)
+		return CMD_RET_USAGE;
+
+	/* number of patterns: 2 exponent */
+	n = argc - 1;
+	if (n > PTN_ARRAY_SIZE || (n & (n - 1)))
+		return CMD_RET_USAGE;
+	num_ptn32 = n;
+
+	/* get patterns */
+	for (i = 0; i < n; i++)
+		test_pattern.s[i] = simple_strtoul(argv[i + 1], NULL, 0);
+
+	printf("Test pattern set\n");
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_ddr_show_ptn(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	if (!num_ptn32) {
+		printf("No pattern available\n");
+	} else {
+		u32 *buf = test_pattern.s;
+		int len = num_ptn32;
+		int i;
+
+		printf("Pattern: ");
+		for (i = 0 ; i < len; i++)
+			printf("0x%08X ", *buf++);
+
+		printf("\n");
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static void ddr_read32(u64 start_addr, u64 n_word, unsigned long iter)
+{
+	while (iter--) {
+		register volatile u32 *addr = (u32 *)start_addr;
+		register u64 count = n_word;
+
+		while (count) {
+			(void)*addr++;
+			PDEBUG("Read 0x%08X from 0x%p\n", val, addr - 1);
+			count--;
+		}
+	}
+}
+
+static void ddr_read64(u64 start_addr, u64 n_word, unsigned long iter)
+{
+	while (iter--) {
+		register volatile u64 *addr = (u64 *)start_addr;
+		register u64 count = n_word;
+
+		if (num_ptn32 == 4)
+			count *= 2;
+
+		/*
+		 * 64 & 128 bit pattern. Increase the nummber of read
+		 * commands in the loop to generate longer burst signal
+		 */
+		while (count) {
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			(void)*addr++;
+			PDEBUG("Read 0x%016llX from 0x%p\n", val, addr - 1);
+			/*
+			 * underflow cannot happen since n_word = end -
+			 * start, end & start addresses are checked to be
+			 * multiple of 16
+			 */
+			count -= 8;
+		}
+	}
+}
+
+static void ddr_write32(u64 start_addr, u64 n_word, unsigned long iter)
+{
+	while (iter--) {
+		register u32 *addr = (u32 *)start_addr;
+		register u32 ptn = *test_pattern.s;
+		register u64 count = n_word;
+
+		while (count) {
+			PDEBUG("Write 0x%08X to 0x%p\n", ptn, addr);
+			*addr++ = ptn;
+			count--;
+		}
+	}
+}
+
+static void ddr_write64(u64 start_addr, u64 n_word, unsigned long iter)
+{
+	while (iter--) {
+		register u64 *addr = (u64 *)start_addr;
+		register u64 ptnA = test_pattern.l[0];
+		register u64 ptnB = test_pattern.l[1];
+		register u64 count = n_word;
+
+		if (num_ptn32 == 2)
+			ptnB = ptnA;
+		else
+			count *= 2;
+
+		/*
+		 * 64 & 128 bit pattern. Increase the nummber of write
+		 * commands in the loop to generate longer burst signal
+		 */
+		while (count) {
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnA, addr);
+			*addr++ = ptnA;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnB, addr);
+			*addr++ = ptnB;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnA, addr);
+			*addr++ = ptnA;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnB, addr);
+			*addr++ = ptnB;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnA, addr);
+			*addr++ = ptnA;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnB, addr);
+			*addr++ = ptnB;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnA, addr);
+			*addr++ = ptnA;
+			PDEBUG("Write 0x%016llX to 0x%p\n", ptnB, addr);
+			*addr++ = ptnB;
+			/*
+			 * underflow cannot happen since n_word = end -
+			 * start, end & start addresses are checked to be
+			 * multiple of 16
+			 */
+			count -= 8;
+		}
+	}
+}
+
+static int do_ddr_si_test(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	u64 start_addr, end_addr, n_word;
+	u64 ts_start, ts_end;
+	unsigned long iteration, wr_iter;
+	int direction, i;
+
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	/* get arguments */
+	direction = strcmp(argv[0], "read") ? DIR_WRITE : DIR_READ;
+	start_addr = simple_strtoul(argv[1], NULL, 0);
+	end_addr = simple_strtoul(argv[2], NULL, 0);
+	iteration = simple_strtoul(argv[3], NULL, 10);
+
+	n_word = (end_addr - start_addr) / (num_ptn32 * 4);
+	printf("\nDDR signal integrity %s test: start\n", argv[0]);
+	/* checks */
+	if (start_addr & 0xF) {
+		printf("ERROR: start_address should be 16 bytes aligned\n\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (end_addr & 0xF) {
+		printf("ERROR: end_address should be 16 bytes aligned\n\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (start_addr >= end_addr) {
+		printf("ERROR: end_address is not bigger than start_address\n\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (!iteration) {
+		printf("ERROR: no iteration specified\n\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (!num_ptn32) {
+		printf("ERROR: no test pattern specified\n\n");
+		return CMD_RET_USAGE;
+	}
+
+	/* print parameters */
+	printf("start_address = 0x%016llX\n", start_addr);
+	printf("end_address   = 0x%016llX\n", end_addr);
+	printf("iterations = %lu\n", iteration);
+
+	/* print pattern */
+	printf("test pattern 0x");
+	for (i = 0; i < num_ptn32; i++)
+		printf("%08X", test_pattern.s[i]);
+
+	printf("\n");
+
+	wdt_disable();
+
+	/* writing */
+	printf("Writing..\n");
+	ts_start = get_timer_us(0);
+
+	if (direction == DIR_READ)
+		wr_iter = 1;
+	else
+		wr_iter = iteration;
+
+	if (num_ptn32 == 1)
+		ddr_write32(start_addr, n_word, wr_iter);
+	else
+		ddr_write64(start_addr, n_word, wr_iter);
+
+	ts_end = get_timer_us(0);
+
+	/* reading */
+	if (direction == DIR_READ) {
+		printf("Reading..\n");
+		/* we need read time, just overwrite */
+		ts_start = get_timer_us(0);
+
+		if (num_ptn32 == 1)
+			ddr_read32(start_addr, n_word, iteration);
+		else
+			ddr_read64(start_addr, n_word, iteration);
+
+		ts_end = get_timer_us(0);
+	}
+
+	wdt_enable();
+
+	/* print stats */
+	printf("DONE.");
+	printf(" Bytes=%llu ", n_word * num_ptn32 * 4 * iteration);
+	printf(" Time=%llu us ", ts_end - ts_start);
+	printf("\nDDR signal integrity %s test: end\n", argv[0]);
+
+	return CMD_RET_SUCCESS;
+}
+
+static char ddr_si_help_text[] =
+	"- DDR signal integrity test\n\n"
+	"ddr_si setptn <pattern> [<pattern>] : set [1,2,4] 32-bit patterns\n"
+	"ddr_si showptn : show patterns\n"
+	"ddr_si read <start> <end> <iterations> : run test for reading\n"
+	"ddr_si write <start> <end> <iterations> : run test for writing\n"
+	"\nWith\n"
+	"\t<pattern>: 32-bit pattern in hex format\n"
+	"\t<start>: test start address in hex format\n"
+	"\t<end>: test end address in hex format\n"
+	"\t<iterations>: number of iterations\n";
+
+U_BOOT_CMD_WITH_SUBCMDS(ddr_si, "DDR si test", ddr_si_help_text,
+			U_BOOT_SUBCMD_MKENT(setptn, 5, 0, do_ddr_set_ptn),
+			U_BOOT_SUBCMD_MKENT(showptn, 1, 0, do_ddr_show_ptn),
+			U_BOOT_SUBCMD_MKENT(read, 4, 0, do_ddr_si_test),
+			U_BOOT_SUBCMD_MKENT(write, 4, 0, do_ddr_si_test));
-- 
2.20.1

