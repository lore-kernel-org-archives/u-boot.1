Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA565FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07DC839D9;
	Sun, 26 Apr 2026 17:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dfCEcckP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E25F84105; Sun, 26 Apr 2026 17:36:28 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8F484099
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso67451055e9.2
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217785; x=1777822585;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hw9GLngKjgFma/Ds2VDGbYsokmFxr4udRFfMO00ab54=;
 b=dfCEcckPCUslanF2mi73jPQ7/52ROHQsotSdBIrrJAPBF6H7/7GXTVi+dG2ZDSoRp9
 gcrroBoUp8UGRva98eDneUi0BEBxz1bO0Fpzn4RylUsFbbD0tfEV6PV1y1QD8LzqGF69
 r/pD+JHBuqdd8lephMXu/gqsEFyrp2ELiTpXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217785; x=1777822585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hw9GLngKjgFma/Ds2VDGbYsokmFxr4udRFfMO00ab54=;
 b=i+wo4Ut0dekMkKFYxE1m97TDexqdMqb8QVYs09EnhIgzs1IJhC0k7iIQBlKxf6BKxQ
 hMHBMeJkghSDVrSdnioB6/toLucNS9oDem92l4vfOiOYLubhkaHezYBQfFIpOtmtobJV
 2XvN7x8s2PZ6+pKRDYjhrMyJNpdjlJ04mUYUcNROE+l3qfG5adrVwwDVwfHhtMft1F5g
 t21xOSTbFgP3++0EPWUJKPgkhFhF8l/NiU30ITyCW2iWHIIsTULXCHksr+uyyUCQwRC7
 S/BaveoEhfJs4dpLXOMUDRm/TDyGzxCwNwHeAUG5bY5d+XA1uOwRx4VKXudns2ijqbMn
 izQg==
X-Gm-Message-State: AOJu0YwcSa4vh8CbQ0sKIuAwomjB0uSyVUCvRiOsZOJnw92/FP7JJQ8v
 YKkMaYAKf/Sz1BDQQvDm9EfWMnRHJBiZTDdF+6FkR8TnYFpzs96WqxScGozHC8taON6Googj+NY
 37AO8
X-Gm-Gg: AeBDieuAr4KUjTXY6w6VYUkLHyErRu2jTTDZ7nV5DbmEoo7BmN0mh/tP2i5SDbVpWE/
 cVoOT7hGFlVWdVH8rJ8hPcsZvXwdIdZzz36zGaQHndX6jTsWF175pY38VZFAtR7+9UxVq/FyudT
 RtFxx+5ziiaqE7wgJkJt35ZMXj/qFcsw+ftdRVfQZBDFQFKDFDj9/xocD6rvDnAcxQqoSWpVjz3
 3eveTpFfqBZ9nVvMwqVRnhZBveUIE/nrcm2yiL8CL2no5Ui42hZY7xDWGkpNiMHYg5SzqPaxjDl
 Jm0LRHHVpaH2sEoPnc6rNUpCHQbJ74HQ9kx0n4XQRlGhKIqyzwCeuNFSmV697PDQ0ZWirPiVwv1
 F0eJHovIgaRzq+1B7+68MJaS8mhEQw2eoO5Q9s84Dqjot6DkC0d9P3J3PiK5BMwc3/0VemB5jWl
 wsUKWFxq23N7LEpcQ7okSHvNuJq2NUD/77+PNK04aoJJ5b2lKA/JfZd+h2Wej8+x1saCkMjoS7x
 Vivbyt/jWXR+elCVPpml0p3B+IB4s2TIKnnQfyawQVj5FfqF+FD6oZdxUXJg/vO+Jk79NT2PypJ
 KEgGVIUGx0OUvaaXsEK8omTZ0t6ifQ==
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-488fb6e8eb5mr550713775e9.0.1777217785396; 
 Sun, 26 Apr 2026 08:36:25 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:24 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 3/8] test: cmd: add unit tests for part command
Date: Sun, 26 Apr 2026 17:35:28 +0200
Message-ID: <20260426153617.2039651-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
References: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v4)

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

