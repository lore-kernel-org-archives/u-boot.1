Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E4CF428C0
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7055B84206;
	Wed, 15 Apr 2026 20:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZxpoQs4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF1884201; Wed, 15 Apr 2026 20:33:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A97841CD
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so86721375e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277988; x=1776882788;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=605kfiPAmyyhG0L5m4NA62wmfJrRDN9SrX8UGlTD18M=;
 b=ZxpoQs4X/UGp3/RX25uZpISeBdu1S6CfiJ0ijmjOEgDAYnwfbJXghkWDJYO/qwjOwD
 thxlhB5Hn6eKZJcHRrDn+5npv5PLB+0qYQjY8EO/VquQ2c0U4/tBpKDrzu5Q0tilXv7M
 PsP1FmjHzUAx04JHfr+G7KddUuk3hrrhbEWG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277988; x=1776882788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=605kfiPAmyyhG0L5m4NA62wmfJrRDN9SrX8UGlTD18M=;
 b=leiZBd0F3L/RBE/WZiDqv45nYI50srur/2lutX9yaZCAKA31lcO1hmR9n0xLGWiImP
 iw5I2CsNFnn1nw+GW3AqIjqw256V6Yy8FMVBDAdKdGuvDESQMXAGRsYMJbEgZKZ5ksBv
 tMIgwyfhcDSZK+P9r4fl+x1XgKKZ4oS3cw/kKcl9Ze3/QfXuiPH4TCseAHp0tf6vgzPW
 xQ32ShERv8Z37OMtjbc0Tv7b9wcFx3HUY6WYYMALQQJ1khl5tkyZkC9+3Z/+kiKsXoTA
 jGioKVVzB40c/EATKPXg9VFwTDhBC0C/P2dymn00jgsqYaI4DaNY0AkEdMzTDeRRbbz7
 /FrQ==
X-Gm-Message-State: AOJu0YwhcURraim7u2p5SBhQ+T2V8j6NxT/cWEUd3P7uUJ+9zsFYy4Xl
 z0OyOgRW3yT6q0fzFomZg9IsaIhgkkvuVa1z62iUwB3tocRwWGCH1tvNxUGHINJyJSPyBWc/cdU
 ZkUdH
X-Gm-Gg: AeBDiet98icB1FFbWmgm3fqVy+OTNU7Yrmk+4tCbIHslfDstX7S6krgHCgFJ4WH5dTl
 ZpdwBxN2nGXwVIX+MlzeYrZXDlDJ6pJzLqanzyiDzow7SPDyoLWZKsT92QkG1cK5bn7F7pPaTEw
 kIUWTQIWhcGCVc10/i51bx9nBhUFiPb3PbAcajPBWC2ZDC0spH8yi5XRAyguz1mIASote5Wh+ts
 92ccJSPHSIz4celMnBTZ5ZqoXPHqkfIUSPFEAA0PeifnoSFtgqQlSP5GCeRfWPCK90XvMtgXJPW
 vLL851hVVfxJf3QsyNJ5MuJdl4YPBik2yhNgp+JcJ0VZmMou511wYVDuX5FnaGy2ICuD2evhlxQ
 Ad3qfghk3g0JXhteeoEM61qWlF2KsGvbJ9tkuABJ9rH0TwaZ8RP2M2tWm8czx3BAv1HRVP4PS+f
 PBr8C71cqdBlevThFq4G8E4wkXx73LHfk5qZrthHq8leLJFQtDCcrkwqaVj4hQ+axDquia2aLnl
 ph34JIzB7RvIDn7gDHaSXOf+H+ta5COdyNh+sLOcep6dNUgfc0X4OPi0g==
X-Received: by 2002:a05:600c:4e45:b0:488:9439:881a with SMTP id
 5b1f17b1804b1-488d67bf6f6mr336739085e9.2.1776277987902; 
 Wed, 15 Apr 2026 11:33:07 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:07 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/7] test: cmd: add unit tests for part command
Date: Wed, 15 Apr 2026 20:31:30 +0200
Message-ID: <20260415183250.3031030-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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

---

Changes in v3:
- Wrap the lines exceeding 80 columns
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(

 test/cmd/Makefile |   1 +
 test/cmd/part.c   | 161 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
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
index 000000000000..f808ddbc87eb
--- /dev/null
+++ b/test/cmd/part.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for part command
+ *
+ * Copyright (C) 2026 Amarula Solutions
+ * Written by Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <dm/test.h>
+#include <env.h>
+#include <part.h>
+#include <test/ut.h>
+#include <vsprintf.h>
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
+static int dm_test_cmd_part_number(struct unit_test_state *uts)
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
+DM_TEST(dm_test_cmd_part_number, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_cmd_part_start(struct unit_test_state *uts)
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
+DM_TEST(dm_test_cmd_part_start, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_cmd_part_size(struct unit_test_state *uts)
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
+DM_TEST(dm_test_cmd_part_size, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

