Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D35E6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EB489454;
	Sat, 23 Nov 2024 17:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380811;
	bh=rlfiYkxbE61NIgg7tooEID9z75iOJNG8OlUFzrS4c5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zZuLPcZ3LORHtZAhJ0r8mzHUFchlsLm9MxGfptKYKKWZnEmZJ6WCwM/tbZSxciLd0
	 TlMdxWxxjk26EcaEEfj0OEDESECPvQJ+HcMAB4CdMWi09gtSbHFW/wYWr48qxOziUV
	 +qEPeOBImvVsVoICsfqowI6KlkeqwD7VAXIDcvfiX5+7VnkYbFDVhCIBWOcdx335x/
	 yoaeONx6WVckT243ornGnWvm09rSrOYvLADpNG/TsTybkxamGn/vIeFkJmQyrZXxCG
	 evbMgLByjnJ8p2TOuBxQ6ARKeBxW4Cxv+rVPP0JCb/u6HNvg89lasluLAa3j3UyI/D
	 RR54KJlXenH+w==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 21A62893DD;
 Sat, 23 Nov 2024 17:53:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380807;
 bh=rlfiYkxbE61NIgg7tooEID9z75iOJNG8OlUFzrS4c5E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r31CqSlmRgrBmZdFau/2AhsCB4cJli1HmT0rU4s55yJMkfuAlNyciAt6XhgQrK9bc
 nvCNegtm3oLIlMmI8owb5dDd4Ccugipv2fErg79kSEeAKGHW++ZcOgC4fiWKBGLWjx
 kLlnUPa7RdyMW1dvDi5Y6wr2LNHTio2rMrgJR4+wCPWGZkLtmAmuC7rHZgS/oDolM5
 H5QFnQHW2TvDDACypwOR5GjSQ8cDeOxaMwT0fy1idUwH7Te6btnlyXtVqF65U6OJK5
 mlLDpin8zGcFydwRmR2MpAd2QwhBGl+orgeeXCStSOfHCPsXmAW7gpM24THb8N1/Ds
 9t3kN0Yws8+OA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 18/20] siemens: add ddr full memory test
Date: Sat, 23 Nov 2024 17:53:02 +0100
Message-Id: <20241123165304.100538-19-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

Add siemens specific memory test. Enable it through Kconfig option
SPL_CMT. The test is required from our HW team. It runs over
temperature during many days:
* must run indefinitively through the *whole* DDR area,
  so we cannot use linux memtest for example.
* must write/read/check all values

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>

---

(no changes since v2)

Changes in v2:
add From tag
reworked the commit message a little bit

 board/siemens/capricorn/Kconfig           |   7 +
 board/siemens/capricorn/Makefile          |   1 +
 board/siemens/capricorn/spl.c             |   5 +
 board/siemens/capricorn/spl_memory_test.c | 158 ++++++++++++++++++++++
 board/siemens/capricorn/spl_memory_test.h |   7 +
 5 files changed, 178 insertions(+)
 create mode 100644 board/siemens/capricorn/spl_memory_test.c
 create mode 100644 board/siemens/capricorn/spl_memory_test.h

diff --git a/board/siemens/capricorn/Kconfig b/board/siemens/capricorn/Kconfig
index 371eca346e0..03a433df2aa 100644
--- a/board/siemens/capricorn/Kconfig
+++ b/board/siemens/capricorn/Kconfig
@@ -14,3 +14,10 @@ config IMX_CONFIG
 	default "board/siemens/capricorn/imximage.cfg"
 
 endif
+
+
+config SPL_CMT
+	bool "Enable Siemens SPL RAM test"
+	depends on SPL
+	help
+	  Enable SIemens SPL RAM test.
diff --git a/board/siemens/capricorn/Makefile b/board/siemens/capricorn/Makefile
index e8a24c448b9..b8350d96d04 100644
--- a/board/siemens/capricorn/Makefile
+++ b/board/siemens/capricorn/Makefile
@@ -8,6 +8,7 @@ obj-y += ../common/eeprom.o
 
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
+obj-$(CONFIG_SPL_CMT) += spl_memory_test.o
 else
 obj-y += ../common/factoryset.o
 endif
diff --git a/board/siemens/capricorn/spl.c b/board/siemens/capricorn/spl.c
index 7ee2895b6d4..5865cde80b4 100644
--- a/board/siemens/capricorn/spl.c
+++ b/board/siemens/capricorn/spl.c
@@ -20,6 +20,7 @@
 #include <asm/arch/iomux.h>
 #include <asm/gpio.h>
 #include <asm/arch/sys_proto.h>
+#include "spl_memory_test.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -58,6 +59,10 @@ void spl_board_init(void)
 	preloader_console_init();
 
 	puts("Normal Boot\n");
+
+#if IS_ENABLED(CONFIG_SPL_CMT)
+	spl_siemens_memory_full_test();
+#endif
 }
 
 void spl_board_prepare_for_boot(void)
diff --git a/board/siemens/capricorn/spl_memory_test.c b/board/siemens/capricorn/spl_memory_test.c
new file mode 100644
index 00000000000..84c97e7853c
--- /dev/null
+++ b/board/siemens/capricorn/spl_memory_test.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright Siemens AG 2020
+ *
+ * SPL Full Memory Test
+ * - memory test through the full DDR area
+ * - refresh over temperature torture (write all, read all)
+ *
+ * Remark:
+ * This test has ran properly with the definition of the RAM sizes in board
+ * headers. Since these headers are removed it's necessary to set the correct
+ * values to PHYS_SDRAM_1_SIZE & PHYS_SDRAM_2_SIZE before to recompile.
+ *
+ * An alternative is to refactor the code to get the size info from system
+ * controller
+ */
+
+#include <init.h>
+#include <log.h>
+
+/* ----- Defines ----- */
+#define CHECK_LOWER_UPPER
+
+#define LEVEL2_PRINT    0x0FFFFFFF
+
+/* use 0x7FFF0000 for shorter loop test */
+#define BASE_OFFSET	0x00000000
+
+/* ----- Types ----- */
+struct ct_t {
+	unsigned long *start;
+	unsigned long *end;
+};
+
+/* ----- Variables ----- */
+static struct ct_t ct;
+static unsigned long error_counter;
+
+static void print_parameters(void)
+{
+	printf("\nstart addr: %p\n", ct.start);
+	printf("end addr  : %p\n", ct.end);
+}
+
+static void run_test(void)
+{
+	/* moved full test in one void */
+	unsigned long *address; /* 512 */
+	unsigned long ebyte1;
+	unsigned long ebyte2;
+	unsigned int i;
+	unsigned long rpattern;
+
+	for (i = 0; i <= 255; i++) {
+		memset(&ebyte1, i, sizeof(ebyte1));
+		ebyte2 = ~ebyte1;
+		printf("LWord: %016lx  #LWord: %016lx\n", ebyte1, ebyte2);
+
+		/* write  all bytes -> duration ~ 150 s */
+		for (address = ct.start; address <= ct.end; address++) {
+#ifdef LEVEL2_PRINT
+			if (((unsigned long)address & LEVEL2_PRINT) == 0)
+				printf("write to %p - %p\n", address,
+				       (void *)((unsigned long)address +
+				       LEVEL2_PRINT));
+#endif
+			*address = ebyte1;
+			address++;
+			*address = ebyte2;
+		}
+
+		/* check all bytes */
+		for (address = ct.start; address <= ct.end; address++) {
+#ifdef LEVEL2_PRINT
+			if (((unsigned long)address & LEVEL2_PRINT) == 0)
+				printf("check from %p - %p\n", address,
+				       (void *)((unsigned long)address +
+				       LEVEL2_PRINT));
+#endif
+
+			rpattern = *address;
+			if (rpattern != ebyte1) {
+				error_counter++;
+				printf("Error! Read: %016lX Wrote: %016lX Address: %p\n",
+				       rpattern, ebyte1, address);
+			}
+
+			address++;
+			rpattern = *address;
+			if (rpattern != ebyte2) {
+				error_counter++;
+				printf("Error! Read: %016lX Wrote: %016lX Address: %p\n",
+				       rpattern, ebyte2, address);
+			}
+		}
+	}
+}
+
+#ifdef CHECK_LOWER_UPPER
+void test_lower_upper(void)
+{
+	/*
+	 * write different values at the same address of both memory areas
+	 * and check them
+	 */
+#define TEST_ADDRESS	 0x12345670UL
+#define LOWER_ADDRESS	(PHYS_SDRAM_1 + TEST_ADDRESS)
+#define UPPER_ADDRESS	(PHYS_SDRAM_2 + TEST_ADDRESS)
+#define LOWER_VALUE	0x0011223344556677
+#define UPPER_VALUE	0x89ab89abffeeddcc
+
+	*(unsigned long *)LOWER_ADDRESS = LOWER_VALUE;
+	*(unsigned long *)UPPER_ADDRESS = UPPER_VALUE;
+
+	puts("\nlower-upper memory area test\n");
+	printf("write %016lx to   lower address %010lx\n", LOWER_VALUE,
+	       LOWER_ADDRESS);
+	printf("write %016lx to   upper address %010lx\n", UPPER_VALUE,
+	       UPPER_ADDRESS);
+	printf("read  %016lx from lower address %010lx\n",
+	       *(unsigned long *)LOWER_ADDRESS, LOWER_ADDRESS);
+	printf("read  %016lx from upper address %010lx\n",
+	       *(unsigned long *)UPPER_ADDRESS, UPPER_ADDRESS);
+}
+#endif
+
+void spl_siemens_memory_full_test(void)
+{
+	unsigned long loopc = 0;
+
+	puts("\nSPL: memory cell test\n");
+
+#ifdef CHECK_LOWER_UPPER
+	if (PHYS_SDRAM_2_SIZE != 0)
+		test_lower_upper();
+#endif
+
+	while (true) {
+		/* imx8x has 2 memory areas up to 2 GB */
+
+		/* 1st memory area @ 0x80000000 */
+		ct.start = (unsigned long *)(PHYS_SDRAM_1 + BASE_OFFSET);
+		ct.end = (unsigned long *)(PHYS_SDRAM_1 + PHYS_SDRAM_1_SIZE - 1);
+		print_parameters();
+		run_test();
+
+		/* 2nd memory area @ 0x880000000 */
+		if (PHYS_SDRAM_2_SIZE != 0) {
+			ct.start = (unsigned long *)(PHYS_SDRAM_2 + BASE_OFFSET);
+			ct.end = (unsigned long *)(PHYS_SDRAM_2 + PHYS_SDRAM_2_SIZE - 1);
+			print_parameters();
+			run_test();
+		}
+
+		loopc++;
+		printf("loop: %ld, errors: %ld\n\n", loopc, error_counter);
+	};
+}
diff --git a/board/siemens/capricorn/spl_memory_test.h b/board/siemens/capricorn/spl_memory_test.h
new file mode 100644
index 00000000000..28df284b6d5
--- /dev/null
+++ b/board/siemens/capricorn/spl_memory_test.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright Siemens AG 2020
+ *
+ */
+
+void spl_siemens_memory_full_test(void);
-- 
2.20.1

