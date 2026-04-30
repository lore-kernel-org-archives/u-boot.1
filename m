Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBFCFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D618465A;
	Thu, 30 Apr 2026 10:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lZ6xkDo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F10584656; Thu, 30 Apr 2026 10:06:45 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747BD8465A
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba60d78aff3so90105666b.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536402; x=1778141202;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ww/f9aAS1MjQvIGRcDgGP8JqUvShvBL+WVU2d+FjAR4=;
 b=lZ6xkDo601IQKrNXxgsvoTrxuykUT3vGiPPVBPmYzGCRScjqplPG2FavSH9m63ESGt
 1hh4HW8VpgB15fWmTp4C9yas86Gu1Dez739ZS1sHcWOqd5Xarq6mog+QxUKgBT6/t7dD
 BkI8pnYwzetgxxO15mqg50MD6+jQpgWvky/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536402; x=1778141202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ww/f9aAS1MjQvIGRcDgGP8JqUvShvBL+WVU2d+FjAR4=;
 b=TFprUue8VVYfrIum/aiNl/9jLbaUeEMIfXDMYvMFIVXnlgAGP1E9HCPgwF48wqnIQ1
 kd+ECHYiIY72chI7zug+vYA1BJxdyZTtJ7FTrECGEUUs8HKlNgiacPBNtQ6nk3PazIYn
 ZzzLrxKR4svluHJWmzdBqBlDEGel4LYlXENMXV3fel3OZzePB9RldJjuOJ0RepCAeNnB
 JhTKp9PcSOUYbmxJzx+0IJ6juCGU0P8jWMhvtOcF+HWLUeL9RVDXwQmCPypRXYDEDa5i
 4T+0pvMYqUmuLDAY2mwV8iOKvN4O2ei/NQEdoUKdX2aoSCmS/evCbwr0bHEmRGyGiPnX
 30dA==
X-Gm-Message-State: AOJu0YxgjcXYK+kQT8QqWahNei9asboxPnRPyNe0MQkyZB7m8FhZMPGj
 8udvJe8X86zbafl0rFt/77KRLOHEOdtrh6A2M/5cDABXWcB1l5AJpd+7uLgE2CFVDdkpcfCQGgc
 znKH6
X-Gm-Gg: AeBDieuM3O7Gvt1Qkq1uTc2TX9hlhDnL68iLVgJQAhbK/pZ2azqp8WUnumsTPLsBE+J
 xufI6onfEqI/3ij8ARhyQsucU/vsnWtMFmu+P8Nlm1tzi3Qhr0aGQZ+MAIMtkXXaNPMpQi1sQDr
 0EHJ3SHRJRyX3oIL/qPILBgmzPVk80SIASHURFM/UnGgtJ76M7ddSXByrCatpG1p0tnHrh37xq+
 2xCVXZjazLcyww2tEtNlgGvGqg4OgkzcwAGv4ZQEwwxSAdJawgMUinhNfP09rFT2ToHinYWA3NO
 dN7WpTxkPLaVsy3H4VekwJHLuF4/B/KHiFeUrIbW+7lo1i/jONxADiTEquM37hgSL7mtUovoJsO
 tOnkwpVGHpf/PZlSLfdl4ofRiEdkgigR5zI4y0xc4p3Bu1A3L3T3Udmag1T/i5g73PfLXAjei6q
 Wi8DC+O/4Xg/iHgWi10W7LnTZlXO0cQn7N8CPBrpS5U2LT4YfPCXR+cbbBNcOSDypYq8GXYqLs9
 zkhaQqGeGVVZPTWDS2SA1RMcsRhb+ALqKoYbbGr6jpFx1VprSnJsfFAfH+Y8pwfpU+j97j+/FJz
 ODk4Z35VFBsA+hVZvcfMSsIlUOcY+uD4zIE=
X-Received: by 2002:a17:907:1c19:b0:bb8:c3d9:3a33 with SMTP id
 a640c23a62f3a-bbac52dcf9cmr107066766b.12.1777536401339; 
 Thu, 30 Apr 2026 01:06:41 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:40 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 3/8] test: cmd: add unit tests for part command
Date: Thu, 30 Apr 2026 10:06:04 +0200
Message-ID: <20260430080627.849636-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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

Changes in v8:
- Skip the test in case the CONFIG_MCC is not enabled or the mmc
  device is not found.

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
 test/cmd/part.c   | 183 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 test/cmd/part.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 5f2815b1bb65..8d6932f1176c 100644
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
index 000000000000..cac57a1a0e35
--- /dev/null
+++ b/test/cmd/part.c
@@ -0,0 +1,183 @@
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
+	int i, ret;
+
+	if (!CONFIG_IS_ENABLED(MMC))
+		return -EAGAIN;
+
+	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
+
+	ret = blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
+	if (ret == -ENODEV)
+		return -EAGAIN;
+
+	ut_asserteq(mmc_dev_num, ret);
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
+	int i, ret;
+
+	ret = setup_gpt_partitions(uts, mmc_dev_num);
+	if (ret == -EAGAIN)
+		return ret;
+
+	ut_assertok(ret);
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
+	int i, ret;
+
+	ret = setup_gpt_partitions(uts, mmc_dev_num);
+	if (ret == -EAGAIN)
+		return ret;
+
+	ut_assertok(ret);
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
+	int i, ret;
+
+	ret = setup_gpt_partitions(uts, mmc_dev_num);
+	if (ret == -EAGAIN)
+		return ret;
+
+	ut_assertok(ret);
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

