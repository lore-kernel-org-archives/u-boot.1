Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F53D73094
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3249983C5E;
	Sat,  4 Apr 2026 17:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XjGdkYTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B75284132; Sat,  4 Apr 2026 17:27:01 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1F383A8C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso1600674f8f.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316418; x=1775921218;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZA2KY1EY7GX5UI1pCYq6qTpwdC5ojsUStcxpGpQAkw=;
 b=XjGdkYTxdmOqhc+mccIOH6oBetYDtsd67t59vHto7mFCtoGlTxIS/I1nHr6Z/AxE1t
 ujhw7ehR3bsTOeaTiEPZFNBbOUdL1s74t2VUxLlcyesg9EZ2nhQL779Ka154pmVC5Gqg
 vgXKDEMxA40v4TSJHOtsmKJ2ehqaXZSHSM6RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316418; x=1775921218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DZA2KY1EY7GX5UI1pCYq6qTpwdC5ojsUStcxpGpQAkw=;
 b=rICVxB4I8qHdaplD/o12Vw5E0m5EZQ56ssm4zrzx38YXzT0dfQYVeI06488ek45qA4
 HKIkhGYb2eHDn2M9DebQylRR+Q6JqeDX8qtf49iQE/6BOPRzL9tnQ+pjIFJvVQdEwuqz
 xfMz/8OlCQ5e/35zeInKe4XY4P2uBe4EBlXfzPb+8CSCxEb6NSxIJYrjlpdg3+kGXEtS
 SL8iYX2/T22r7fqPbH3oUa5IN1z/hqUrTvz+j31up8FSLv2KUJijOiNCT0JXkjeU7t7y
 bz8EXeRRpuUPbSk/eI2WGY9xn4MiZLXf90BbfJKDdXsLESfF7mOqacoMUdrozIFmh6uC
 Cl5A==
X-Gm-Message-State: AOJu0Yx4Ezu8zN+DxvAV6/U7CigyXrLuiUgQ2LJW3ebEXx9FcskjWhDJ
 bTKDvf14qMi4z+vq9wEa2JTMAJBopQfOw47RUZiNzJgjW8fGdu+pRg6PVu94NNKafCbXG4t9G6D
 1STGx
X-Gm-Gg: AeBDiethF6H+69pIQjtARzsq6LDp9HHBgnssdZlcXOQ0CGxco4SQQf3jvITLmtzt6fU
 jCzJul7RPjo/A90Kyc9PWyjt7ETooFH4sNE3aHhqgTuWaMM36OhH3Zsf8SHIdOe8G8JbzXy1Yob
 xeuv21JsHbxHlrUNem/GyAwDvVngEJixPIq7ltc7CywM+erH0rvr1sku7aIZyaJUrBlkoCTcLsO
 SHZPPcG5Ks5PuIyvOjjlOtUQ0J2aiTEj4Z3Nq+Mb8wtvyvJfbxDKMk2MTddDV+FClI7Solju+PK
 fSZX3CsYqOpMxBLN6B8cA0s6FRULGxA0V7vRhC8nRHqAW/ywvcawMTERf0Esfm5WBCo35B9V85P
 a9UqbPm0xG8bf81MfAWnP1UNbFE95nJb36BmfdQTZRvcS5vxMYWn6sz/99auY1d5U350VUMsSN9
 kaZc6Wn1KEF99iCdwXFH8ahVXAasdozLbSx6C8xBlN5pDRugbcvdSZ1aBd4/y7yy2+DrFWqj6Vn
 4ItT9uKCXPEm5YYGYV2D2mm94RJo8oyf64DvD1VnuwbsoSHVd8kNBPDCVS3ogxChE79T1JIDX7z
 Bat0xTamYMPvs7J+npLEPDnB
X-Received: by 2002:a05:6000:2313:b0:43c:f583:126a with SMTP id
 ffacd0b85a97d-43d2927b9c6mr11204605f8f.14.1775316418295; 
 Sat, 04 Apr 2026 08:26:58 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:26:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/7] test: cmd: add unit tests for part command
Date: Sat,  4 Apr 2026 17:23:30 +0200
Message-ID: <20260404152640.3297713-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

 test/cmd/Makefile |   1 +
 test/cmd/part.c   | 157 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
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
index 000000000000..e60e0226b64b
--- /dev/null
+++ b/test/cmd/part.c
@@ -0,0 +1,157 @@
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
+static char disk_guid[UUID_STR_LEN + 1] = "8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+
+static int setup_gpt_partitions(struct unit_test_state *uts, unsigned int mmc_dev_num)
+{
+	struct blk_desc *mmc_dev_desc;
+	char dev_str[10];
+	int i;
+
+	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
+
+	ut_asserteq(mmc_dev_num, blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc));
+
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		for (i = 0; i < ARRAY_SIZE(gpt_parts); i++)
+			gen_rand_uuid_str(gpt_parts[i].uuid, UUID_STR_FORMAT_STD);
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
+	int i, ret;
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
+	ret = run_commandf("part number mmc %u bogus partnum", mmc_dev_num);
+	ut_assert(ret != 0);
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
+	int i, ret;
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
+	ret = run_commandf("part start mmc %u 3 partstart", mmc_dev_num);
+	ut_assert(ret != 0);
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
+	ret = run_commandf("part start mmc %u bogus partstart", mmc_dev_num);
+	ut_assert(ret != 0);
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
+	int i, ret;
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
+	ret = run_commandf("part size mmc %u 3 partsize", mmc_dev_num);
+	ut_assert(ret != 0);
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
+	ret = run_commandf("part size mmc %u bogus partsize", mmc_dev_num);
+	ut_assert(ret != 0);
+	ut_assertnull(env_get("partsize"));
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_part_size, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

