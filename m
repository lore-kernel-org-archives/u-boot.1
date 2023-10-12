Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB69CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 20:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49BF86E73;
	Thu, 12 Oct 2023 22:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kciNjkPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E3086D41; Thu, 12 Oct 2023 22:53:40 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506C186DD3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 22:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so216851766b.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697143951; x=1697748751; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EUHGoulrsTOYk8JEqBThjlp8upyvCb61OVYZjrWb0g8=;
 b=kciNjkPeUB7N31xKyY8exFrRrSGWrjE0IbFCKAORrpWFcIXEw/3+a1Zu0eCYHTE/vv
 zSbrPeM5MDNPaPwPlxxx6HzFjsZOptekTVQ3UAHUBmVePjPpr1lqDmYe/c5y9EOS0kL3
 UphWysuom3Aejwx9mmQniABwkUXKdizwp0Icb+2HJ1r9ffSi1DD8/mTgYoQaSs4eGblo
 LloNk/IR3C+0BB0JpNA8UZY/2KbCwGoXcZo92XXaHvT81p73UIr1fhiF1H9fLb9mZbNB
 UCUy1XQR1eQTUd6e2RGN0BUxWVcgJfzXTyqGmYzqUSRRLAI+i1yZBNiNmkMJMFRqEvzh
 JPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143951; x=1697748751;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EUHGoulrsTOYk8JEqBThjlp8upyvCb61OVYZjrWb0g8=;
 b=YETUuV7B+530TPBqDDGP0HkvpR8F+jCOmMtj9l6j9saO2BR48YVZMme0QxBPobRQfU
 P9ls7plnIJdIdUWUx7Rk/1MM7eeaWPhi9OpWLQ52OU8rlwLioFcI81SiH/9TrOQKypaS
 V7hoscPnlsU7MxIDwKoaWIy2GRPKXZ+t3Xejot/70a6Ome7LblPlcvusL3CM3ug2DN2q
 MUGjxYHZ128jwHrM04Kh0O9u5azKcNDAvGVbRTmclW8LQLHS64/qeX7jL5OIWCxDn2gA
 KgVytjqwWPHTMeO6sMPVkxHR7PjqfRb1UcG6z8n6pO4JI+lgYJ2smNtZeaYuFMgZVGWO
 yrtg==
X-Gm-Message-State: AOJu0YzdBn5ox9XfbiOq8x0c7b73k+8QXmn3KN8b0C5/c7KyXy8FUfkE
 MummKJo7Bx3GHbWTMWt78W8=
X-Google-Smtp-Source: AGHT+IHHRysz7lsXbUPsxAsqy0rBlhJNK6LgMcQh5AxWj/zKrrTX74KuYfceWX5I9XQ60tVQkJa8HA==
X-Received: by 2002:a17:907:75cc:b0:9ba:1691:60d6 with SMTP id
 jl12-20020a17090775cc00b009ba169160d6mr11965911ejc.53.1697143950593; 
 Thu, 12 Oct 2023 13:52:30 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a170906299400b009b2f2451381sm11547844eje.182.2023.10.12.13.52.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 13:52:30 -0700 (PDT)
Message-ID: <e0bbaa48-6a9a-f56c-a9b9-809e7ca11592@gmail.com>
Date: Thu, 12 Oct 2023 22:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 6/7] rockchip: test: dm: add rkmtd test
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
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
---

Changed V3:
  New patch
---
 test/dm/Makefile |   1 +
 test/dm/rkmtd.c  | 201 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)
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
index 000000000000..90b404f85441
--- /dev/null
+++ b/test/dm/rkmtd.c
@@ -0,0 +1,201 @@
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
+#include <asm/test.h>
+#include <blk.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <fs.h>
+#include <rkmtd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define BUF_SIZE	12 * 512
+
+/* Basic test of the RKMTD interface */
+static int dm_test_rkmtd(struct unit_test_state *uts)
+{
+	struct udevice *dev, *part, *chk, *blk;
+	char write[BUF_SIZE], read[BUF_SIZE];
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
+	memset(write, 0, BLK_SIZE);
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
+
+	ut_asserteq(12, blk_dwrite(desc, 64, 12, write));
+	ut_asserteq(12, blk_dread(desc, 64, 12, read));
+	ut_asserteq_mem(write, read, BUF_SIZE);
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
+	console_record_reset();
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
+DM_TEST(dm_test_rkmtd_cmd, UT_TESTF_SCAN_FDT);
--
2.39.2

