Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B8FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE3A841F2;
	Sun, 26 Apr 2026 17:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PXrWgBPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DB384314; Sun, 26 Apr 2026 17:47:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EAD283FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso73076685e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218453; x=1777823253;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4MKtAW7WUF1UijbrIXVqwjoMi3T7GY9a2EZQvpWa84=;
 b=PXrWgBPgWGU1m8+6qaKMZXEpfnaTQuNZFjxYU23qkHRB+Gdum4+XciFmxVfJZ1Z5qM
 1SIyu6loNgsKpMSogD3fcm4C/HHUjTZhBW9MtYv2/al7HGKSobIbCs9QRazYG+UZIjgi
 fqHGmYvYKvRPgRcF+ZnQGq3yQZsNv2spZ/EyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218453; x=1777823253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f4MKtAW7WUF1UijbrIXVqwjoMi3T7GY9a2EZQvpWa84=;
 b=WTvfFhpTY4XkhF3ZRxySxfRGk6dmnDWjymkKgYwOjLHiprkBnC0qMmL1ymJdpTj6LM
 uuFr4umu6N/oVr037bQad06oaSY3rINnlU4pruUqT5Ssd8QuLTxDdToPDxXZg6u1nIWD
 tmeRzp26UDvycaFBT6yzA6lPGp91JTvszp2NpsUiQpgcA2ZyQxCl7Bdt+9Bil0P2epnI
 D1E1ft5MYTTfbrlzEWPPk+85LDaeWZ0eD8eJuqTCB0i1fHE4HxS8CYPAIZrmma73S8og
 DODvDMcdY6Uoj+0raIpkaTOwYNKvgSWxG3a8oV1u6COQGpVMwbL9ObBWjrBvmPP+I7jW
 n/0g==
X-Gm-Message-State: AOJu0Yz2NOswayIaAar30DS7MaRbUw6rGmTEhxk3QSCZD6cUZiX1NbcV
 Gn0aE5j+tODOqvGO9216J22Ciwg+j0ONtuAxasBW9BO2++8K81Tu/HClAHQhgmfd481EvE5lE1T
 bGCeS
X-Gm-Gg: AeBDievPn44KJDdGrv5+hdPYtnRtUu0D/aUPXHljXVkqP2riZntKSvQjhyr6mHEnbK9
 Iq/W7HO/BrO0Ws42V2b5tomloaWfNY5WUbQN9/t0hGYCLu2kprgEHkJUBoJdPURS7QnEP2aYHIO
 r4LfTsLZAhLVdpLs/D/ElfzbmmKVU7N0mMPz/duPDedwnfhYLpBACOlk6O9jgxf1WQv7Uw/Q4Lh
 YqjnLSUd5Y+y1B9flX90wws4GpuhT+mzPzlKB9MtHMNju/ZDcxcLape8b3WWoQwp7H2aCCvRRhi
 hjuF2AM6Cy/MDCKfw/A/QXbFGOceQhse2J43OLWCqIkarkGJ8jog3cFfJsqaD15dPiVN9CX+MwF
 Yz02V5Uz4IoMFbHmYV10BE+pl+yJiKwUoFGGXUsqDyhkU2qYnxBOVd6g3BMHXOqkDO4hhG22wVB
 oSeWeGmHL0GbHdEpl/BskObcfUE1al95b35d/SlCT1nRvmJsoaWe0FAoUG/jB2hYuiPOQpWgvbx
 RkAUy8ye8jDC6PlIKqBo32WQe+V5ByJ02Vt3GbQB+EYLJFemqyQPbEfpOJS+GK0BSVGp/XssESx
 VTGlqZ6m7MWobMWXVqCOjkOlhNUqVg==
X-Received: by 2002:a05:600c:450a:b0:48a:72ab:f88c with SMTP id
 5b1f17b1804b1-48a72abf8admr1792735e9.17.1777218453239; 
 Sun, 26 Apr 2026 08:47:33 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:32 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 3/8] test: cmd: add unit tests for part command
Date: Sun, 26 Apr 2026 17:46:56 +0200
Message-ID: <20260426154724.2042569-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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

Add unit tests for the 'part' command, specifically for the 'number',
'start', and 'size' subcommands.

These tests establish a baseline for the current partition lookup
functionality by name. This foundation will be used by subsequent
patches to extend the command, ensuring consistent behavior as new
features are introduced.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v6)

Changes in v6:
- Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
  tests for part command"

Changes in v4:
- Place the part command tests in the cmd suite rather than the dm
  suite.
- Order the include files according the U-Boot coding style.

Changes in v3:
- Wrap the lines exceeding 80 columns
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(

 test/cmd/Makefile |   1 +
 test/cmd/part.c   | 165 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 test/cmd/part.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8c9f112782d0..41fe21a4541e 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CMD_LOADM) += loadm.o
 obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
 obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
 obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
+obj-$(CONFIG_CMD_PART) += part.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
diff --git a/test/cmd/part.c b/test/cmd/part.c
new file mode 100644
index 000000000000..5751dd315dd8
--- /dev/null
+++ b/test/cmd/part.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for part command
+ *
+ * Copyright (C) 2026 Amarula Solutions
+ * Written by Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <env.h>
+#include <part.h>
+#include <vsprintf.h>
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static struct disk_partition gpt_parts[] = {
+	{
+		.start = 48,
+		.size = 1,
+		.name = "test1",
+		.uuid = "c5bce7a2-03f0-4d03-9048-01ff23b9d527",
+	},
+	{
+		.start = 49,
+		.size = 2,
+		.name = "test2",
+		.uuid = "9df346e8-2c53-4cd8-b9ac-3af83f9a9b74",
+	},
+};
+
+static char disk_guid[UUID_STR_LEN + 1] =
+	"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+
+static int setup_gpt_partitions(struct unit_test_state *uts,
+				unsigned int mmc_dev_num)
+{
+	struct blk_desc *mmc_dev_desc;
+	char dev_str[10];
+	int i;
+
+	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
+
+	ut_asserteq(mmc_dev_num, blk_get_device_by_str("mmc", dev_str,
+						       &mmc_dev_desc));
+
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		for (i = 0; i < ARRAY_SIZE(gpt_parts); i++)
+			gen_rand_uuid_str(gpt_parts[i].uuid,
+					  UUID_STR_FORMAT_STD);
+
+		gen_rand_uuid_str(disk_guid, UUID_STR_FORMAT_STD);
+	}
+
+	ut_assertok(gpt_restore(mmc_dev_desc, disk_guid, gpt_parts,
+				ARRAY_SIZE(gpt_parts)));
+	return 0;
+}
+
+static int cmd_test_part_number(struct unit_test_state *uts)
+{
+	unsigned int mmc_dev_num = 2;
+	char expected[10];
+	int i;
+
+	ut_assertok(setup_gpt_partitions(uts, mmc_dev_num));
+
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partnum", NULL);
+		ut_assertok(run_commandf("part number mmc %u %s partnum",
+					 mmc_dev_num, gpt_parts[i].name));
+		snprintf(expected, sizeof(expected), "0x%x", i + 1);
+		ut_asserteq_str(expected, env_get("partnum"));
+	}
+
+	env_set("partnum", NULL);
+	ut_asserteq(1, run_commandf("part number mmc %u bogus partnum",
+				    mmc_dev_num));
+	ut_assertnull(env_get("partnum"));
+
+	return 0;
+}
+CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
+
+static int cmd_test_part_start(struct unit_test_state *uts)
+{
+	unsigned int mmc_dev_num = 2;
+	char expected[32];
+	int i;
+
+	ut_assertok(setup_gpt_partitions(uts, mmc_dev_num));
+
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partstart", NULL);
+		ut_assertok(run_commandf("part start mmc %u %d partstart",
+					 mmc_dev_num, i + 1));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].start);
+		ut_asserteq_str(expected, env_get("partstart"));
+	}
+
+	env_set("partstart", NULL);
+	ut_asserteq(1, run_commandf("part start mmc %u 3 partstart",
+				    mmc_dev_num));
+	ut_assertnull(env_get("partstart"));
+
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partstart", NULL);
+		ut_assertok(run_commandf("part start mmc %u %s partstart",
+					 mmc_dev_num, gpt_parts[i].name));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].start);
+		ut_asserteq_str(expected, env_get("partstart"));
+	}
+
+	env_set("partstart", NULL);
+	ut_asserteq(1, run_commandf("part start mmc %u bogus partstart",
+				    mmc_dev_num));
+	ut_assertnull(env_get("partstart"));
+
+	return 0;
+}
+CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
+
+static int cmd_test_part_size(struct unit_test_state *uts)
+{
+	unsigned int mmc_dev_num = 2;
+	char expected[32];
+	int i;
+
+	ut_assertok(setup_gpt_partitions(uts, mmc_dev_num));
+
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partsize", NULL);
+		ut_assertok(run_commandf("part size mmc %u %d partsize",
+					 mmc_dev_num, i + 1));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].size);
+		ut_asserteq_str(expected, env_get("partsize"));
+	}
+
+	env_set("partsize", NULL);
+	ut_asserteq(1, run_commandf("part size mmc %u 3 partsize",
+				    mmc_dev_num));
+	ut_assertnull(env_get("partsize"));
+
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partsize", NULL);
+		ut_assertok(run_commandf("part size mmc %u %s partsize",
+					 mmc_dev_num, gpt_parts[i].name));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].size);
+		ut_asserteq_str(expected, env_get("partsize"));
+	}
+
+	env_set("partsize", NULL);
+	ut_asserteq(1, run_commandf("part size mmc %u bogus partsize",
+				    mmc_dev_num));
+	ut_assertnull(env_get("partsize"));
+
+	return 0;
+}
+CMD_TEST(cmd_test_part_size, UTF_CONSOLE);
-- 
2.43.0

