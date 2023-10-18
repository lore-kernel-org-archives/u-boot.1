Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37793CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4EC86FA6;
	Wed, 18 Oct 2023 16:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBh4jP2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C3C86F94; Wed, 18 Oct 2023 16:02:04 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A00F86FAE
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9bdf5829000so793844466b.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637721; x=1698242521; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b3IJLujxp0SLHAD4nPHU3zw38oe62kuRWeVLfnXnN+w=;
 b=IBh4jP2hUkaQAR+619an2S4zBdY9OFqNDG7mVyoPUnZMMtW6+yq5CZLs+larp+2ZO7
 onZ1fPBeYAV741DmVbsb7Wz4IwkCMn/MguU7rKJ850KpyVE0a8HrGQpYYpQR5exYOTuR
 +ZxtjiUCpXMUh6VlqFzdc7MLi6IM9waJbqE+k8SG6q5bOz1zOBAM7WofZ2jlNGXV9lTc
 H2PzC+I/D3tcR9CL41shfbcs4uJmBVGARMBRZ4sOBUNM8658X0IwRm8U88hg+o2Fn6Jy
 JP38HFtyvc06QraCVqM4Gtnn7C7t3u9xzZsuaN3sM8+FbXop/cxHyImxj0ptiqEoJe7f
 Sozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637721; x=1698242521;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3IJLujxp0SLHAD4nPHU3zw38oe62kuRWeVLfnXnN+w=;
 b=lN/2Pf2bI6pL05+8FY1/gXk7HJ+7QOWK6HKBguqLL3z3wiysheeR+DwKkbJh+i1HJJ
 PMe8t14gfr7KvvIxDdf8ImGM0TKsu8A8Hy0QgF2XST4TbSRWCOmf0PghaZsB/Irs3SF9
 iyPio1+VCl+u7G1vM6MIBMSWVzWCt/DuFO3QFzf7pRCzzE+Zk2snnVzp6SHPN4AHq2iN
 Odk/SIRwMEnYzkN6zgWut5v2b2/GYTSSS5WEofMClU+87b9wuNKBdMuJLlapPF5Qauwp
 79rhOS4b6qBA9IgbALYz/N6io3IeaVIxieWiL8/RmOx+wjKsFLFGmCVQ9iv254NrJNka
 kqFA==
X-Gm-Message-State: AOJu0YxL19ZUWMnzfTxvI6UL2GVOSoNvdQsHHhqEKv81nqnHswtdzzAs
 NNyqmsAelhxedtRkdlM0CurQHGN00Ug=
X-Google-Smtp-Source: AGHT+IHDDCJ+r1c7VQlW6LCuOyZCXbWOM6IsgkWRcsNIFCJYNICO8irrSA/QnngTgY9D+hWeUr9+JQ==
X-Received: by 2002:a17:907:985:b0:9bd:d961:ddea with SMTP id
 bf5-20020a170907098500b009bdd961ddeamr3938681ejc.45.1697637720613; 
 Wed, 18 Oct 2023 07:02:00 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 y26-20020a170906519a00b00993a37aebc5sm1718596ejk.50.2023.10.18.07.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:02:00 -0700 (PDT)
Message-ID: <54e66a55-df5c-015f-2ecc-0abfb57e5bca@gmail.com>
Date: Wed, 18 Oct 2023 16:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 6/8] rockchip: test: dm: add rkmtd test
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Add Rockchip rkmtd test:
Create/attach/detach RKMTD device.
Send/read data with Rockchip boot block header.
Test that reusing the same label should work.
Basic test of 'rkmtd' commands.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V4:
  sort includes
  rename define
  use '\0'
  use UT_TESTF_CONSOLE_REC flag
  check RC4 result

Changed V3:
  New patch
---
 test/dm/Makefile |   1 +
 test/dm/rkmtd.c  | 200 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 test/dm/rkmtd.c

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 7ed00733c1a6..a5e0a2744375 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_REMOTEPROC) += remoteproc.o
 obj-$(CONFIG_DM_RESET) += reset.o
 obj-$(CONFIG_SYSRESET) += sysreset.o
 obj-$(CONFIG_DM_REGULATOR) += regulator.o
+obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
 obj-$(CONFIG_DM_RNG) += rng.o
 obj-$(CONFIG_DM_RTC) += rtc.o
 obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
diff --git a/test/dm/rkmtd.c b/test/dm/rkmtd.c
new file mode 100644
index 000000000000..3c3e8efa92f2
--- /dev/null
+++ b/test/dm/rkmtd.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * Test derived from:
+ * /test/dm/host.c
+ * Copyright 2022 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ *
+ * Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
+ */
+
+#include <common.h>
+#include <blk.h>
+#include <dm.h>
+#include <fs.h>
+#include <rkmtd.h>
+#include <asm/test.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define RW_BUF_SIZE	12 * 512
+
+/* Basic test of the RKMTD interface */
+static int dm_test_rkmtd(struct unit_test_state *uts)
+{
+	struct udevice *dev, *part, *chk, *blk;
+	char write[RW_BUF_SIZE], read[RW_BUF_SIZE];
+	static const char label[] = "test";
+	struct rkmtd_dev *plat;
+	struct blk_desc *desc;
+	struct sector0 *sec0;
+	int i;
+
+	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_RKMTD, &dev));
+	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
+
+	ut_assertok(rkmtd_create_device(label, &dev));
+
+	/* Check that the plat data has been allocated */
+	plat = dev_get_plat(dev);
+	ut_asserteq_str("test", plat->label);
+	ut_assert(label != plat->label);
+
+	/* Attach RKMTD driver */
+	ut_assertok(rkmtd_attach(dev));
+	ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &chk));
+	ut_asserteq_ptr(chk, dev);
+
+	/* Get RKMTD block device */
+	ut_assertok(blk_get_from_parent(dev, &blk));
+	ut_assertok(device_probe(blk));
+
+	/* There should be a GPT partition table in this device */
+	ut_asserteq(0, uclass_first_device_err(UCLASS_PARTITION, &part));
+
+	/* Write a boot block and verify that we get the same data back */
+	desc = dev_get_uclass_plat(blk);
+	ut_asserteq(true, desc->removable);
+	ut_asserteq(LBA, desc->lba);
+
+	memset(write, '\0', BLK_SIZE);
+
+	for (i = BLK_SIZE; i < sizeof(write); i++)
+		write[i] = i;
+
+	sec0 = (struct sector0 *)write;
+	sec0->magic = 0x0FF0AA55;
+	sec0->rc4_flag = 0;
+	sec0->boot_code1_offset = 4;
+	sec0->boot_code2_offset = 4;
+	sec0->flash_data_size = 4;
+	sec0->flash_boot_size = 8;
+
+	rkmtd_rc4(write, 512);
+	ut_asserteq(RK_TAG, sec0->magic);
+
+	ut_asserteq(12, blk_dwrite(desc, 64, 12, write));
+	ut_asserteq(12, blk_dread(desc, 64, 12, read));
+	ut_asserteq_mem(write, read, RW_BUF_SIZE);
+
+	ut_assertok(rkmtd_detach(dev));
+
+	ut_asserteq(-ENODEV, blk_get_from_parent(dev, &blk));
+	ut_assertok(device_unbind(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_rkmtd, UT_TESTF_SCAN_FDT);
+
+/* Reusing the same label should work */
+static int dm_test_rkmtd_dup(struct unit_test_state *uts)
+{
+	static const char label[] = "test";
+	struct udevice *dev, *chk;
+
+	/* Create a RKMTD device with label "test" */
+	ut_asserteq(0, uclass_id_count(UCLASS_RKMTD));
+	ut_assertok(rkmtd_create_device(label, &dev));
+	ut_assertok(rkmtd_attach(dev));
+	ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &chk));
+	ut_asserteq_ptr(chk, dev);
+	ut_asserteq(1, uclass_id_count(UCLASS_RKMTD));
+
+	/* Create another device with the same label (should remove old one) */
+	ut_assertok(rkmtd_create_device(label, &dev));
+	ut_assertok(rkmtd_attach(dev));
+	ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &chk));
+	ut_asserteq_ptr(chk, dev);
+
+	/* Make sure there is still only one device */
+	ut_asserteq(1, uclass_id_count(UCLASS_RKMTD));
+
+	return 0;
+}
+DM_TEST(dm_test_rkmtd_dup, UT_TESTF_SCAN_FDT);
+
+/* Basic test of the 'rkmtd' command */
+static int dm_test_rkmtd_cmd(struct unit_test_state *uts)
+{
+	struct udevice *dev, *blk;
+	struct blk_desc *desc;
+
+	/* First check 'rkmtd info' with binding */
+	ut_assertok(run_command("rkmtd info", 0));
+	ut_assert_nextline("dev       blocks label          ");
+	ut_assert_console_end();
+
+	/* Bind device 1 */
+	ut_assertok(run_commandf("rkmtd bind test1"));
+	ut_assertok(uclass_first_device_err(UCLASS_RKMTD, &dev));
+	ut_assertok(blk_get_from_parent(dev, &blk));
+	desc = dev_get_uclass_plat(blk);
+
+	ut_assertok(run_command("rkmtd info", 0));
+	ut_assert_nextline("dev       blocks label          ");
+	ut_assert_nextline("  0          609 test1          ");
+	ut_assert_console_end();
+
+	/* Bind device 2 */
+	ut_assertok(run_commandf("rkmtd bind test2"));
+	ut_assertok(uclass_next_device_err(&dev));
+	ut_assertok(blk_get_from_parent(dev, &blk));
+	desc = dev_get_uclass_plat(blk);
+
+	ut_assertok(run_command("rkmtd info", 0));
+	ut_assert_nextline("dev       blocks label          ");
+	ut_assert_nextline("  0          609 test1          ");
+	ut_assert_nextline("  1          609 test2          ");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("rkmtd info test", 0));
+	ut_assert_nextline("No such device 'test'");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("rkmtd info test2", 0));
+	ut_assert_nextline("dev       blocks label          ");
+	ut_assert_nextline("  1          609 test2          ");
+	ut_assert_console_end();
+
+	/* Check 'rkmtd dev' */
+	ut_asserteq(1, run_command("rkmtd dev", 0));
+	ut_assert_nextline("No current rkmtd device");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("rkmtd dev missing", 0));
+	ut_assert_nextline("No such device 'missing'");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("rkmtd dev test2", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("rkmtd dev", 0));
+	ut_assert_nextline("Current rkmtd device: 1: test2");
+	ut_assert_console_end();
+
+	/* Try a numerical label */
+	ut_assertok(run_command("rkmtd dev 0", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("rkmtd dev", 0));
+	ut_assert_nextline("Current rkmtd device: 0: test1");
+	ut_assert_console_end();
+
+	/* Remove one of the bindings */
+	ut_assertok(run_commandf("rkmtd unbind test1"));
+
+	/* There should now be no current device */
+	ut_asserteq(1, run_command("rkmtd dev", 0));
+	ut_assert_nextline("No current rkmtd device");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("rkmtd info", 0));
+	ut_assert_nextline("dev       blocks label          ");
+	ut_assert_nextline("  1          609 test2          ");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_rkmtd_cmd, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
--
2.39.2

