Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31EF1091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF2984148;
	Thu, 19 Mar 2026 22:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V6Tl46Pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D529B838FA; Thu, 19 Mar 2026 22:36:57 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0812084090
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d756f2a06dso1319306a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956213; x=1774561013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUVCebbxeQCYNhI/oOlHpKSagcDsfqF7KntsciY4yDg=;
 b=V6Tl46PlrG+gqVqlNjc2JCuh4XP5jP9OdtIeUsQxtCsWCdPH6dEfyj6+iIrfsEisJl
 wbWtyXB70sEp0nZx4xkvXxMW4D9jznTqAID3QpfMSdTAo+ot+yg9tqUquQwjVmsRAohZ
 8qs+xtM9XbjRXA5nLux294nCO5o1ilNsuPCkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956213; x=1774561013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XUVCebbxeQCYNhI/oOlHpKSagcDsfqF7KntsciY4yDg=;
 b=FnmXaED9A+9tXEnaikF/bxP42KRLRUdeKe8VZ1rH7gOtPdGdc4jyBT5XEpMqjooGO9
 T0rCb1Giav4umL7Ja1mJMu0ExzForqI9e10HX6ogHiopehxDLCt4300uNghx16fIQ8py
 WP6VZ9KxxUtp0et51S7wKqKuRcUAA94mqG1e+GiyF3N65wb0kjsvFlMLnpUZK9B+M1AJ
 90ftd2+d2eXgxE5qYiYk8Rhx9ohjPDl5jK715DgLGGfHqODPrkf8OKwRfc3ba/q8wZPg
 LYu9yQGMTIwd5B73PqOVGIhg99O6u8x/2QXVsr7DPFF8KiCOfbt23q/Uh7tGdtaAnfSI
 G09Q==
X-Gm-Message-State: AOJu0YzgZmwvIsHf5/gmyHyvmgX02KadxYEZWSSNeNAOd+6drItYgC3E
 /BNYQdQrEx5/c2C/Z66V6rwQ7xq79Ooge3Er1rZ6xAc6R+/ymE2hUSsp9Quy5rdxXTcNV02Kpx2
 r3JdUTw==
X-Gm-Gg: ATEYQzzHh3sX7kE2G8roWyNej6zAbHygBYK6WNKWFiN0bM3r70VeawOGjkOJNVLt/aQ
 cNN4v6cRoKbPKm0BXjx0p/+YdAhL9gmNmE5lmDwdKZQ070S3ZySaPy7+8wjJwfRnLGjmVjh+Suc
 Y07c7lDqfyKjGYQUJ+SUcAK3QQ/vF+U4LkttxUtKKcfvSOdBLlZl4wug5pxtG8TGfqcLFhTFABl
 kByHXkgqjIUxLmyqkvK2/8Q7PolNJIuMuWbXGKnnYr1pNB8kKQCCSo7/RxZP9qFowjSXS4Q0x9m
 LyDyXGBtEvR6ytVz3s173lebF/bcFzvow3VZL38S5CX1whVlXTc1rVSMOLPgqyrvjms7YNu+ldw
 iv0YMpDWTZLfN/J6h7H18Dl7PrhTK/FERJqTDuvuk7/9W9RmxnPS7CtL6MUoGxq1Hy4jtr28a+Z
 xxJ1swgg+JgcOaj89Ssw==
X-Received: by 2002:a05:6830:a85:b0:7d7:ec47:79f6 with SMTP id
 46e09a7af769-7d7ec477b3emr123174a34.13.1773956212950; 
 Thu, 19 Mar 2026 14:36:52 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 12/15] dm: test: Add tests for uclass adjuncts
Date: Thu, 19 Mar 2026 15:35:42 -0600
Message-ID: <20260319213551.267031-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a test driver and test cases for the DM_UC_ADJUNCT feature:

- testadj_drv: a UCLASS_TEST driver that registers an adjunct
  UCLASS_TEST_FDT uclass with custom ping ops during probe
- DTS node test-adj with compatible "denx,u-boot-test-adj"

Test cases:
- dm_test_adj_add: verify the device is discoverable in the adjunct
  uclass via uclass_find_device_by_ofnode()
- dm_test_adj_ops: verify device_get_adj_ops() returns the correct ops
  and the adjunct ping() produces the expected result
- dm_test_adj_uclass_ops: verify device_get_uclass_ops() resolves the
  correct ops for both primary and adjunct uclasses
- dm_test_adj_remove: verify removing a device cleans up adjuncts
- dm_test_adj_uclass_priv: verify per_device_auto allocation for
  adjuncts when the uclass driver requests it

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/test.dts |   4 +
 drivers/misc/test_drv.c   |  35 ++-
 test/dm/Makefile          |   1 +
 test/dm/adjunct.c         | 455 ++++++++++++++++++++++++++++++++++++++
 test/dm/bus.c             |   9 +-
 test/dm/test-fdt.c        |  39 ++--
 test/dm/test-uclass.c     |   2 +-
 7 files changed, 518 insertions(+), 27 deletions(-)
 create mode 100644 test/dm/adjunct.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ac92ebf1afd..fe2dea50f2c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -536,6 +536,10 @@
 		compatible = "google,another-fdt-test";
 	};
 
+	test-adj {
+		compatible = "denx,u-boot-test-adj";
+	};
+
 	e-test {
 		reg = <3 1>;
 		ping-expect = <6>;
diff --git a/drivers/misc/test_drv.c b/drivers/misc/test_drv.c
index 9b1e357a139..4c7ce36625b 100644
--- a/drivers/misc/test_drv.c
+++ b/drivers/misc/test_drv.c
@@ -200,7 +200,7 @@ int testfdt_ping(struct udevice *dev, int pingval, int *pingret)
 {
 	const struct test_ops *ops = device_get_ops(dev);
 
-	if (!ops->ping)
+	if (!ops || !ops->ping)
 		return -ENOSYS;
 
 	return ops->ping(dev, pingval, pingret);
@@ -229,3 +229,36 @@ UCLASS_DRIVER(testfdtm) = {
 	.id		= UCLASS_TEST_FDT_MANUAL,
 	.flags		= DM_UC_FLAG_SEQ_ALIAS | DM_UC_FLAG_NO_AUTO_SEQ,
 };
+
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+
+static int testadj_ping(struct udevice *dev, int pingval, int *pingret)
+{
+	*pingret = pingval + 100;
+
+	return 0;
+}
+
+static const struct test_ops testadj_ops = {
+	.ping = testadj_ping,
+};
+
+static const struct driver_adjunct testadj_adjuncts[] = {
+	{ UCLASS_TEST_FDT, &testadj_ops },
+	{ }
+};
+
+static const struct udevice_id testadj_ids[] = {
+	{ .compatible = "denx,u-boot-test-adj" },
+	{ }
+};
+
+U_BOOT_DRIVER(denx_u_boot_test_adj) = {
+	.name	= "testadj_drv",
+	.of_match	= testadj_ids,
+	.id	= UCLASS_TEST,
+	.adjuncts	= testadj_adjuncts,
+	.priv_auto	= sizeof(struct dm_test_priv),
+	.plat_auto	= sizeof(struct dm_test_pdata),
+};
+#endif /* DM_UC_ADJUNCT */
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 771b703b737..40819065c53 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_DM_GPIO) += gpio.o
 obj-y += irq.o
 endif
 obj-$(CONFIG_ADC) += adc.o
+obj-$(CONFIG_DM_UC_ADJUNCT) += adjunct.o
 obj-$(CONFIG_AES_SOFTWARE) += aes.o
 obj-$(CONFIG_SOUND) += audio.o
 obj-$(CONFIG_AXI) += axi.o
diff --git a/test/dm/adjunct.c b/test/dm/adjunct.c
new file mode 100644
index 00000000000..3879f098c86
--- /dev/null
+++ b/test/dm/adjunct.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for uclass adjunct support (DM_UC_ADJUNCT)
+ *
+ * Copyright 2026 Canonical Ltd.
+ * Simon Glass <simon.glass@canonical.com>
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <dm/uclass-internal.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+
+/* Test that a bound device is findable in its adjunct uclass */
+static int dm_test_adj_add(struct unit_test_state *uts)
+{
+	struct udevice *dev, *found;
+	ofnode node;
+
+	uts->skip_post_probe = 1;
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "test-adj",
+					       &dev));
+
+	node = dev_ofnode(dev);
+	ut_assert(ofnode_valid(node));
+
+	/* Static adjuncts are bound at bind time, so findable without probe */
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+
+	return 0;
+}
+DM_TEST(dm_test_adj_add, UTF_SCAN_FDT);
+
+/* Test that device_get_uclass_ops() resolves the right ops */
+static int dm_test_adj_uclass_ops(struct unit_test_state *uts)
+{
+	const struct test_ops *ops;
+	struct udevice *dev;
+	int pingret;
+
+	uts->skip_post_probe = 1;
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "test-adj",
+					       &dev));
+	ut_assertok(device_probe(dev));
+
+	/* Adjunct uclass should return the adjunct ops */
+	ops = (void *)device_get_uclass_ops(dev, UCLASS_TEST_FDT);
+	ut_assertnonnull(ops);
+	ut_assertok(ops->ping(dev, 7, &pingret));
+	ut_asserteq(107, pingret);
+
+	/* Primary uclass returns driver ops (NULL for this driver) */
+	ut_assertnull(device_get_uclass_ops(dev, UCLASS_TEST));
+
+	/* Unrelated uclass returns NULL */
+	ut_assertnull(device_get_uclass_ops(dev, UCLASS_NOP));
+
+	return 0;
+}
+DM_TEST(dm_test_adj_uclass_ops, UTF_SCAN_FDT);
+
+/* Test that removing and unbinding a device cleans up adjuncts */
+static int dm_test_adj_remove(struct unit_test_state *uts)
+{
+	struct udevice *dev, *found;
+	ofnode node;
+
+	uts->skip_post_probe = 1;
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "test-adj",
+					       &dev));
+	ut_assertok(device_probe(dev));
+
+	node = dev_ofnode(dev);
+
+	/* Verify it is findable before removal */
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+
+	/* Remove frees priv but adjunct stays bound */
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+
+	/* Unbind removes the adjunct from the uclass */
+	ut_assertok(device_unbind(dev));
+	ut_asserteq(-ENODEV,
+		    uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+
+	return 0;
+}
+DM_TEST(dm_test_adj_remove, UTF_SCAN_FDT);
+
+/*
+ * Test per_device_auto allocation for adjuncts.
+ *
+ * UCLASS_TEST_FDT does not have per_device_auto, so its uclass_priv_
+ * should be NULL. UCLASS_TEST_BUS has both per_device_auto and
+ * per_device_plat_auto, so adding it as an adjunct should allocate both.
+ *
+ * Also test the uclass-ID-keyed accessors (device_get_uclass_priv
+ * and device_get_uclass_plat).
+ */
+static int dm_test_adj_uclass_priv(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	uts->skip_post_probe = 1;
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "test-adj",
+					       &dev));
+	ut_assertok(device_probe(dev));
+
+	/* UCLASS_TEST_FDT has no per_device_auto, so priv is NULL */
+	ut_assertnull(device_get_adj_uclass_priv(dev, UCLASS_TEST_FDT));
+	ut_assertnull(device_get_uclass_priv(dev, UCLASS_TEST_FDT));
+
+	/*
+	 * Add a second adjunct for UCLASS_TEST_BUS which has
+	 * per_device_auto and per_device_plat_auto set. Since the
+	 * device is already probed, both plat and priv are allocated.
+	 */
+	ut_assertok(device_add_uclass_adj(dev, UCLASS_TEST_BUS, NULL));
+
+	/* Plat should be allocated */
+	ut_assertnonnull(device_get_uclass_plat(dev, UCLASS_TEST_BUS));
+
+	/* Priv should be allocated (device is active) */
+	ut_assertnonnull(device_get_adj_uclass_priv(dev, UCLASS_TEST_BUS));
+	ut_asserteq_ptr(device_get_adj_uclass_priv(dev, UCLASS_TEST_BUS),
+			device_get_uclass_priv(dev, UCLASS_TEST_BUS));
+
+	/* Non-existent adjunct should return NULL */
+	ut_assertnull(device_get_uclass_priv(dev, UCLASS_NOP));
+	ut_assertnull(device_get_uclass_plat(dev, UCLASS_NOP));
+
+	return 0;
+}
+DM_TEST(dm_test_adj_uclass_priv, UTF_SCAN_FDT);
+
+/*
+ * Test ucm_find_first/ucm_find_next - walk every member of UCLASS_TEST_FDT,
+ * asserting the device name and uclass at each step. The adjunct (test-adj)
+ * has primary uclass UCLASS_TEST but appears here via its adjunct
+ * registration.
+ */
+static int dm_test_ucm_find(struct unit_test_state *uts)
+{
+	struct uclass_member *ucm;
+
+	uts->skip_post_probe = 1;
+
+	ut_assertok(ucm_find_first(UCLASS_TEST_FDT, &ucm));
+	ut_asserteq_str("a-test", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST_FDT, device_get_uclass_id(ucm->dev));
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("b-test", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST_FDT, device_get_uclass_id(ucm->dev));
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("d-test", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST_FDT, device_get_uclass_id(ucm->dev));
+
+	/* The adjunct's device has primary uclass UCLASS_TEST */
+	ucm_find_next(&ucm);
+	ut_asserteq_str("test-adj", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST, device_get_uclass_id(ucm->dev));
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("e-test", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST_FDT, device_get_uclass_id(ucm->dev));
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("f-test", ucm->dev->name);
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("g-test", ucm->dev->name);
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("h-test", ucm->dev->name);
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("another-test", ucm->dev->name);
+
+	ucm_find_next(&ucm);
+	ut_asserteq_str("chosen-test", ucm->dev->name);
+
+	ucm_find_next(&ucm);
+	ut_assertnull(ucm);
+
+	return 0;
+}
+DM_TEST(dm_test_ucm_find, UTF_SCAN_FDT);
+
+/*
+ * Test ucm_first_check/ucm_next_check - iterate with probing, verify
+ * the adjunct device is found and probes OK.
+ */
+static int dm_test_ucm_check(struct unit_test_state *uts)
+{
+	struct uclass_member *ucm;
+
+	uts->skip_post_probe = 1;
+
+	/* ucm_first_check probes the first device */
+	ut_assertok(ucm_first_check(UCLASS_TEST_FDT, &ucm));
+	ut_asserteq_str("a-test", ucm->dev->name);
+
+	ut_assertok(ucm_next_check(&ucm));
+	ut_asserteq_str("b-test", ucm->dev->name);
+
+	ut_assertok(ucm_next_check(&ucm));
+	ut_asserteq_str("d-test", ucm->dev->name);
+
+	/* The adjunct device probes OK via its primary driver */
+	ut_assertok(ucm_next_check(&ucm));
+	ut_asserteq_str("test-adj", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST, device_get_uclass_id(ucm->dev));
+
+	return 0;
+}
+DM_TEST(dm_test_ucm_check, UTF_SCAN_FDT);
+
+/* Test ucm_first/ucm_next (probe-and-skip) */
+static int dm_test_ucm_first(struct unit_test_state *uts)
+{
+	struct uclass_member *ucm;
+
+	uts->skip_post_probe = 1;
+
+	/* ucm_first probes and returns the first usable member */
+	ucm = ucm_first(UCLASS_TEST_FDT);
+	ut_asserteq_str("a-test", ucm->dev->name);
+
+	ucm = ucm_next(ucm);
+	ut_asserteq_str("b-test", ucm->dev->name);
+
+	ucm = ucm_next(ucm);
+	ut_asserteq_str("d-test", ucm->dev->name);
+
+	/* The adjunct device probes OK and appears in iteration */
+	ucm = ucm_next(ucm);
+	ut_asserteq_str("test-adj", ucm->dev->name);
+	ut_asserteq(UCLASS_TEST, device_get_uclass_id(ucm->dev));
+
+	return 0;
+}
+DM_TEST(dm_test_ucm_first, UTF_SCAN_FDT);
+
+/* Test ucm_first_drvdata */
+static int dm_test_ucm_drvdata(struct unit_test_state *uts)
+{
+	struct uclass_member *ucm;
+	struct udevice *dev;
+
+	uts->skip_post_probe = 1;
+
+	/* Find a device with DM_TEST_TYPE_FIRST */
+	ut_assertok(ucm_first_drvdata(UCLASS_TEST_FDT, DM_TEST_TYPE_FIRST,
+				      &ucm));
+	ut_assertnonnull(ucm);
+	ut_asserteq(DM_TEST_TYPE_FIRST, dev_get_driver_data(ucm->dev));
+
+	/* Find a device with DM_TEST_TYPE_SECOND */
+	ut_assertok(ucm_first_drvdata(UCLASS_TEST_FDT, DM_TEST_TYPE_SECOND,
+				      &ucm));
+	ut_assertnonnull(ucm);
+	ut_asserteq(DM_TEST_TYPE_SECOND, dev_get_driver_data(ucm->dev));
+
+	/* Non-existent driver data should return -ENODEV */
+	ut_asserteq(-ENODEV, ucm_first_drvdata(UCLASS_TEST_FDT, 999, &ucm));
+
+	/* Probe the adjunct (its driver_data defaults to 0 = FIRST) */
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "test-adj",
+					       &dev));
+	ut_assertok(device_probe(dev));
+
+	/*
+	 * The adjunct should be findable with DM_TEST_TYPE_FIRST. Walk
+	 * all matches and check the adjunct device appears.
+	 */
+	ut_assertok(ucm_first_drvdata(UCLASS_TEST_FDT, DM_TEST_TYPE_FIRST,
+				      &ucm));
+	ut_assertnonnull(ucm);
+
+	return 0;
+}
+DM_TEST(dm_test_ucm_drvdata, UTF_SCAN_FDT);
+
+/* Test ucm_try_first */
+static int dm_test_ucm_try_first(struct unit_test_state *uts)
+{
+	struct uclass_member *ucm;
+
+	uts->skip_post_probe = 1;
+
+	/* Valid uclass with devices should return non-NULL */
+	ucm = ucm_try_first(UCLASS_TEST_FDT);
+	ut_assertnonnull(ucm);
+	ut_assertnonnull(ucm->dev);
+
+	/* Non-existent uclass should return NULL */
+	ucm = ucm_try_first(UCLASS_COUNT);
+	ut_assertnull(ucm);
+
+	return 0;
+}
+DM_TEST(dm_test_ucm_try_first, UTF_SCAN_FDT);
+
+/*
+ * Test the full adjunct lifecycle: bind → probe → remove → re-probe →
+ * remove → unbind, verifying allocations and uclass membership at each step.
+ *
+ * Uses UCLASS_TEST_BUS as a dynamic adjunct because it has both
+ * per_device_auto and per_device_plat_auto, so we can track priv and
+ * plat allocation across lifecycle transitions.
+ */
+static int dm_test_adj_lifecycle(struct unit_test_state *uts)
+{
+	void *priv1, *plat;
+	struct udevice *dev, *found;
+	ofnode node;
+
+	uts->skip_post_probe = 1;
+
+	/* 1. BIND: device is bound via FDT scan, static adjunct too */
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "test-adj",
+					       &dev));
+	node = dev_ofnode(dev);
+	ut_assert(ofnode_valid(node));
+
+	/* Static adjunct (TEST_FDT) is in the uclass before probe */
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+
+	/* No priv or plat yet (TEST_FDT has neither per_device_auto) */
+	ut_assertnull(device_get_adj_uclass_priv(dev, UCLASS_TEST_FDT));
+	ut_assertnull(device_get_adj_uclass_plat(dev, UCLASS_TEST_FDT));
+
+	/* Device should not be active */
+	ut_assert(!device_active(dev));
+
+	/* 2. PROBE: device and adjuncts get priv allocated */
+	ut_assertok(device_probe(dev));
+	ut_assert(device_active(dev));
+
+	/* Driver priv should now exist */
+	ut_assertnonnull(dev_get_priv(dev));
+
+	/* TEST_FDT still has no per_device_auto, so priv stays NULL */
+	ut_assertnull(device_get_adj_uclass_priv(dev, UCLASS_TEST_FDT));
+
+	/* 3. ADD DYNAMIC ADJUNCT: TEST_BUS has per_device_auto + plat_auto */
+	ut_assertok(device_add_uclass_adj(dev, UCLASS_TEST_BUS, NULL));
+
+	/* Device is active, so both should be allocated immediately */
+	plat = device_get_adj_uclass_plat(dev, UCLASS_TEST_BUS);
+	ut_assertnonnull(plat);
+	priv1 = device_get_adj_uclass_priv(dev, UCLASS_TEST_BUS);
+	ut_assertnonnull(priv1);
+
+	/* Findable in all three uclasses */
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_BUS, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+
+	/* 4. REMOVE: priv freed, adjuncts stay bound, plat stays */
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assert(!device_active(dev));
+
+	/* Priv is gone */
+	ut_assertnull(device_get_adj_uclass_priv(dev, UCLASS_TEST_BUS));
+
+	/* Plat survives removal (freed only at unbind) */
+	ut_asserteq_ptr(plat,
+			device_get_adj_uclass_plat(dev, UCLASS_TEST_BUS));
+
+	/* Both adjuncts still in their uclass lists */
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+	ut_assertok(uclass_find_device_by_ofnode(UCLASS_TEST_BUS, node,
+						 &found));
+	ut_asserteq_ptr(dev, found);
+
+	/* 5. RE-PROBE: priv gets reallocated */
+	ut_assertok(device_probe(dev));
+	ut_assert(device_active(dev));
+	ut_assertnonnull(device_get_adj_uclass_priv(dev, UCLASS_TEST_BUS));
+
+	/* 6. REMOVE + UNBIND: everything cleaned up */
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assertok(device_unbind(dev));
+
+	/* Adjuncts gone from their uclasses */
+	ut_asserteq(-ENODEV,
+		    uclass_find_device_by_ofnode(UCLASS_TEST_FDT, node,
+						 &found));
+	ut_asserteq(-ENODEV,
+		    uclass_find_device_by_ofnode(UCLASS_TEST_BUS, node,
+						 &found));
+
+	return 0;
+}
+DM_TEST(dm_test_adj_lifecycle, UTF_SCAN_FDT);
+
+/* Test uclass_foreach_dev_probe includes adjuncts */
+static int dm_test_ucm_foreach_probe(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	int count = 0;
+
+	uts->skip_post_probe = 1;
+
+	/* Walk the probed iteration - adjuncts are included */
+	uclass_foreach_dev_probe(UCLASS_TEST_FDT, dev) {
+		switch (count++) {
+		case 0:
+			ut_asserteq_str("a-test", dev->name);
+			break;
+		case 1:
+			ut_asserteq_str("b-test", dev->name);
+			break;
+		case 2:
+			ut_asserteq_str("d-test", dev->name);
+			break;
+		case 3:
+			ut_asserteq_str("test-adj", dev->name);
+			break;
+		case 4:
+			ut_asserteq_str("e-test", dev->name);
+			break;
+		case 5:
+			ut_asserteq_str("f-test", dev->name);
+			break;
+		}
+	}
+	ut_assert(count >= 6);
+
+	return 0;
+}
+DM_TEST(dm_test_ucm_foreach_probe, UTF_SCAN_FDT);
+
+#endif /* DM_UC_ADJUNCT */
diff --git a/test/dm/bus.c b/test/dm/bus.c
index 7dd0d040650..480bb2c7942 100644
--- a/test/dm/bus.c
+++ b/test/dm/bus.c
@@ -23,19 +23,16 @@ DECLARE_GLOBAL_DATA_PTR;
 /* Test that we can probe for children */
 static int dm_test_bus_children(struct unit_test_state *uts)
 {
-	int num_devices = 9;
+	int num_devices = 10;
 	struct udevice *bus;
-	struct uclass *uc;
 
-	ut_assertok(uclass_get(UCLASS_TEST_FDT, &uc));
-	ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
+	ut_asserteq(num_devices, uclass_id_count(UCLASS_TEST_FDT));
 
 	/* Probe the bus, which should yield 3 more devices */
 	ut_assertok(uclass_get_device(UCLASS_TEST_BUS, 0, &bus));
 	num_devices += 3;
 
-	ut_assertok(uclass_get(UCLASS_TEST_FDT, &uc));
-	ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
+	ut_asserteq(num_devices, uclass_id_count(UCLASS_TEST_FDT));
 
 	ut_assert(!dm_check_devices(uts, num_devices));
 
diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index 295fdcaa0d8..169f49a3cb0 100644
--- a/test/dm/test-fdt.c
+++ b/test/dm/test-fdt.c
@@ -129,6 +129,10 @@ int dm_check_devices(struct unit_test_state *uts, int num_devices)
 		ret = uclass_get_device(UCLASS_TEST_FDT, i, &dev);
 		ut_assert(!ret);
 
+		/* Skip adjunct members - they are tested separately */
+		if (device_get_uclass_id(dev) != UCLASS_TEST_FDT)
+			continue;
+
 		/*
 		 * Get the 'ping-expect' property, which tells us what the
 		 * ping add should be. We don't use the plat because we
@@ -150,20 +154,16 @@ int dm_check_devices(struct unit_test_state *uts, int num_devices)
 /* Test that FDT-based binding works correctly */
 static int dm_test_fdt(struct unit_test_state *uts)
 {
-	const int num_devices = 9;
+	const int num_devices = 10;
 	struct udevice *dev;
-	struct uclass *uc;
 	int ret;
 	int i;
 
 	ret = dm_extended_scan(false);
 	ut_assert(!ret);
 
-	ret = uclass_get(UCLASS_TEST_FDT, &uc);
-	ut_assert(!ret);
-
 	/* These are num_devices compatible root-level device tree nodes */
-	ut_asserteq(num_devices, list_count_nodes(&uc->dev_head));
+	ut_asserteq(num_devices, uclass_id_count(UCLASS_TEST_FDT));
 
 	/* Each should have platform data but no private data */
 	for (i = 0; i < num_devices; i++) {
@@ -271,10 +271,10 @@ static int dm_test_fdt_uclass_seq(struct unit_test_state *uts)
 	ut_asserteq_str("d-test", dev->name);
 	ut_asserteq(13, dev_seq(dev));
 
-	/* g-test gets the next value after f-test */
-	ut_assertok(uclass_get_device_by_seq(UCLASS_TEST_FDT, 15, &dev));
+	/* g-test gets the next value after f-test (adjunct takes 14) */
+	ut_assertok(uclass_get_device_by_seq(UCLASS_TEST_FDT, 16, &dev));
 	ut_asserteq_str("g-test", dev->name);
-	ut_asserteq(15, dev_seq(dev));
+	ut_asserteq(16, dev_seq(dev));
 
 	/* And we should still have holes in our sequence numbers */
 	ut_asserteq(-ENODEV, uclass_find_device_by_seq(UCLASS_TEST_FDT, 0,
@@ -342,21 +342,22 @@ static int dm_test_fdt_uclass_seq_more(struct unit_test_state *uts)
 	 * last alias is 12, so we have:
 	 *
 	 * 13 d-test
-	 * 14 f-test
-	 * 15 g-test
-	 * 16 h-test
-	 * 17 another-test
-	 * 18 chosen-test
+	 * 14 test-adj (adjunct)
+	 * 15 f-test
+	 * 16 g-test
+	 * 17 h-test
+	 * 18 another-test
+	 * 19 chosen-test
 	 *
-	 * So next available is 19
+	 * So next available is 20
 	 */
 	ut_assertok(device_bind(dm_root(), DM_DRIVER_GET(denx_u_boot_fdt_test),
 				"fred", NULL, ofnode_null(), &dev));
-	ut_asserteq(19, dev_seq(dev));
+	ut_asserteq(20, dev_seq(dev));
 
 	ut_assertok(device_bind(dm_root(), DM_DRIVER_GET(denx_u_boot_fdt_test),
 				"fred2", NULL, ofnode_null(), &dev));
-	ut_asserteq(20, dev_seq(dev));
+	ut_asserteq(21, dev_seq(dev));
 
 	return 0;
 }
@@ -467,12 +468,12 @@ static int dm_test_uclass_foreach(struct unit_test_state *uts)
 	count = 0;
 	uclass_id_foreach_dev(UCLASS_TEST_FDT, dev, uc)
 		count++;
-	ut_asserteq(9, count);
+	ut_asserteq(10, count);
 
 	count = 0;
 	uclass_foreach_dev(dev, uc)
 		count++;
-	ut_asserteq(9, count);
+	ut_asserteq(10, count);
 
 	return 0;
 }
diff --git a/test/dm/test-uclass.c b/test/dm/test-uclass.c
index ee2ed1b6643..b48f7d17b15 100644
--- a/test/dm/test-uclass.c
+++ b/test/dm/test-uclass.c
@@ -78,7 +78,7 @@ static int test_post_probe(struct udevice *dev)
 	priv->base_add = 0;
 	if (uts->skip_post_probe)
 		return 0;
-	if (&prev->ucm.uc_node != &uc->dev_head) {
+	if (&prev->ucm.uc_node != &uc->dev_head && device_active(prev)) {
 		struct dm_test_uclass_perdev_priv *prev_uc_priv
 				= dev_get_uclass_priv(prev);
 		struct dm_test_pdata *pdata = dev_get_plat(prev);
-- 
2.43.0

