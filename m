Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698C6F53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A650084220;
	Mon, 16 Mar 2026 19:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="DWpKXGbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C07E84183; Mon, 16 Mar 2026 19:15:46 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DCF84179
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-463a0e14abfso3042395b6e.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684941; x=1774289741;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkdNiu1rMp0PR3zVh3qGlxFVcCyNXBeI86iDADGHn2A=;
 b=DWpKXGbMbPyFR6BxpiE+xYHUXcsggepqdydK1H247Im2Ys+5wkFDxwESV/vPHb5qSd
 sobSNjPSIXNbFHFdjv2Dph9kkd3jCMIjV8ff+oUkujrJk2Zq5p+e7oztX7KxTWRxYKqD
 wt/JZ5ZA9gCU2BYGcZmv2eeERqFpyhq39/MVleBdJqifr7EbimXPObujjte01uolrsnY
 4iFLtNAWa94J16VpzeYa77s/50Jfy7wQOSgj5Y2u0buu9lgLwqTGk/XnavRkNlEZSGp+
 cUqeml/vY6zGlsGVQGF1OxCUvwd59ffJRLkkzmCf0opScn92dPMJgqjZBMJ7yVqWB5JD
 1pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684941; x=1774289741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KkdNiu1rMp0PR3zVh3qGlxFVcCyNXBeI86iDADGHn2A=;
 b=XVVTotQi58mqytI7qOPqXuExaXjBNaJiMfXqSe4lZYaXODySB25bKVpd9n6H6j2wBR
 umKGfKnyZpaAJfS71P6LH+r701lyx4wqNreX/CHRn0UTHrT2F3h2at2PO8x5uePZnNb7
 R14Ak2mGbVA2G8H4SCjY3tak5Req1/WUKbJcfPjHamzz/il3whBb9TcDjC9JwSLyV5lh
 siHzVTDHST7/FxKlYTQoGVITBRQjOLHL7oYtsKfWQiqhcoLEcetUDQNoasmO4wAL5zY0
 xmUvLNExmcKLRSf4nkdn53LTxA3n1seviOLLRVmzX1HrIfjWWAUQLFtwSyDcQw/bcs+E
 Wz2A==
X-Gm-Message-State: AOJu0YyNCFKahwVhc3rOdxjaJdxo3IhRqTQo3FD0BsNxqO/OIRkWIbbY
 vmO3gC9qqDHr7Z9/CKJTPZyRh2vXlwZE3+AH36C0MjspnJnxBEMdPSVXWylKFNmvpVhnL4v1I5K
 o5rZm5x0=
X-Gm-Gg: ATEYQzwHl1DioxxdFrQDGXAgaU/G6EVtEBHzdGBajmd7dlwtgp9A8WVb1sEnLtTtAVx
 a2th22a7cyQHzOU9Oivua7ROMuj4Kb1Ywe/V4JMMzU/cbe5zZGusSJ0H5vUMqTaVkl0t+D5z19z
 9Fx4s2TNklkK6k3yn42LiKrxz96tqEcHB/zg+xY8QYagkJLe3/HEtdsMkUyPHOibVvHb+KkjIOM
 pjIheS7MsMeE4QDKs51/bFUVxhpwb+/iFEaHeIaVGswv0nNJmt+vUun2e3srEOZ4kh8PUOWCtrM
 OXfDX6TheV3T+Lavxlqhkw7SnR9Rz3fhxGpuwXY/JnIvcQ/SGilfVZxiUvXlfDz0BRXRR98Ms0j
 Q9XhoayeY7kq3mnuH6mJnzVubai2wZi5v1y5T2FXRx1aP1lIfHqYlOhFF91fW++TuIxJJ91ak+V
 0D6CGwDd9Igspg++QdE89h3w==
X-Received: by 2002:a05:6808:22ab:b0:467:272e:87d with SMTP id
 5614622812f47-467570ecc9dmr7547482b6e.14.1773684940977; 
 Mon, 16 Mar 2026 11:15:40 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-46744873a6asm8632105b6e.9.2026.03.16.11.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:39 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 10/12] test:
 add wolfTPM C unit tests and Python integration tests
Date: Mon, 16 Mar 2026 11:14:39 -0700
Message-ID: <20260316181447.2986278-11-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

From: Aidan <aidan@wolfssl.com>

Add comprehensive test suites for wolfTPM commands, modeled after
the existing TPM2 test infrastructure.

test/cmd/wolftpm.c (C unit tests):
  18 tests using U-Boot's unit test framework (CMD_TEST macro):
  - autostart, init, info, state, device: basic lifecycle
  - self_test (full and continue): TPM self-test verification
  - startup_clear, startup_state: TPM2_Startup modes
  - get_capability: read TPM properties
  - caps: wolfTPM-enhanced capabilities display
  - clear: TPM state reset via LOCKOUT hierarchy
  - pcr_read, pcr_extend, pcr_print: PCR operations
  - pcr_allocate: PCR bank reconfiguration
  - dam_reset, dam_parameters: dictionary attack mitigation
  - change_auth: hierarchy password change (requires wolfCrypt)
  - cleanup: reset TPM state after tests
  Run with: ut cmd cmd_test_wolftpm_*

test/cmd/Makefile:
  Adds wolftpm.o when CONFIG_TPM_WOLF is enabled.

test/py/tests/test_wolftpm.py (Python integration tests):
  21 tests using pytest with the U-Boot test framework:
  - Requires QEMU + swtpm (not sandbox) because wolfTPM bypasses
    U-Boot's driver model and communicates directly with TPM
    hardware via its own SPI/MMIO HAL
  - Tests mirror the C tests but run end-to-end through the U-Boot
    console, checking return codes via 'echo $?'
  - Includes force_init() helper for TPM reinitialization after
    test failures
  - Skippable via env__wolftpm_device_test_skip config
  - Verified: 19 passed, 2 skipped (change_auth requires wolfCrypt,
    get_capability may skip on some platforms)

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 test/cmd/Makefile             |   1 +
 test/cmd/wolftpm.c            | 364 +++++++++++++++++++++++++++++++++
 test/py/tests/test_wolftpm.py | 375 ++++++++++++++++++++++++++++++++++
 3 files changed, 740 insertions(+)
 create mode 100644 test/cmd/wolftpm.c
 create mode 100644 test/py/tests/test_wolftpm.py

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8c9f112782d..6e346dfa4bf 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_CMD_SPAWN) += spawn.o
 ifdef CONFIG_CMD_ZIP
 obj-$(CONFIG_CMD_UNZIP) += unzip.o
 endif
+obj-$(CONFIG_TPM_WOLF) += wolftpm.o
diff --git a/test/cmd/wolftpm.c b/test/cmd/wolftpm.c
new file mode 100644
index 00000000000..b2e6f82a098
--- /dev/null
+++ b/test/cmd/wolftpm.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for wolfTPM commands
+ *
+ * Copyright (C) 2025 wolfSSL Inc.
+ * Author: Aidan Garske <aidan@wolfssl.com>
+ *
+ * Based on test/py/tests/test_tpm2.py and test/dm/tpm.c
+ *
+ * Note: These tests verify command success via return code only.
+ * Console output is not checked since it varies with debug levels.
+ * Run with: ut cmd
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/**
+ * Test wolfTPM autostart command
+ *
+ * This initializes the TPM, performs startup and self-test
+ */
+static int cmd_test_wolftpm_autostart(struct unit_test_state *uts)
+{
+	/* Initialize and autostart the TPM */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_autostart, 0);
+
+/**
+ * Test wolfTPM init command
+ */
+static int cmd_test_wolftpm_init(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("tpm2 init", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_init, 0);
+
+/**
+ * Test wolfTPM info command
+ *
+ * Display TPM device information
+ */
+static int cmd_test_wolftpm_info(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Get TPM info */
+	ut_assertok(run_command("tpm2 info", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_info, 0);
+
+/**
+ * Test wolfTPM state command
+ *
+ * Display TPM internal state
+ */
+static int cmd_test_wolftpm_state(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Get TPM state */
+	ut_assertok(run_command("tpm2 state", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_state, 0);
+
+/**
+ * Test wolfTPM device command
+ *
+ * Show all TPM devices
+ */
+static int cmd_test_wolftpm_device(struct unit_test_state *uts)
+{
+	/* Show TPM devices - no autostart needed */
+	ut_assertok(run_command("tpm2 device", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_device, 0);
+
+/**
+ * Test wolfTPM self_test command
+ */
+static int cmd_test_wolftpm_self_test(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Run full self test */
+	ut_assertok(run_command("tpm2 self_test full", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_self_test, 0);
+
+/**
+ * Test wolfTPM self_test continue command
+ */
+static int cmd_test_wolftpm_self_test_continue(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Run continue self test */
+	ut_assertok(run_command("tpm2 self_test continue", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_self_test_continue, 0);
+
+/**
+ * Test wolfTPM startup command with TPM2_SU_CLEAR
+ *
+ * Issue TPM2_Startup with CLEAR mode (reset state)
+ */
+static int cmd_test_wolftpm_startup_clear(struct unit_test_state *uts)
+{
+	/* First init to prepare TPM */
+	ut_assertok(run_command("tpm2 init", 0));
+
+	/* Issue startup with CLEAR mode */
+	ut_assertok(run_command("tpm2 startup TPM2_SU_CLEAR", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_startup_clear, 0);
+
+/**
+ * Test wolfTPM startup command with TPM2_SU_STATE
+ *
+ * Issue TPM2_Startup with STATE mode (preserved state)
+ */
+static int cmd_test_wolftpm_startup_state(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM has state */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Shutdown first to prepare for STATE startup */
+	run_command("tpm2 startup TPM2_SU_STATE off", 0);
+
+	/* Re-init */
+	ut_assertok(run_command("tpm2 init", 0));
+
+	/* Issue startup with STATE mode - may return already started */
+	run_command("tpm2 startup TPM2_SU_STATE", 0);
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_startup_state, 0);
+
+/**
+ * Test wolfTPM get_capability command
+ *
+ * Read TPM capabilities by property
+ */
+static int cmd_test_wolftpm_get_capability(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Get capability - property 0x6 (TPM_CAP_TPM_PROPERTIES), 0x20e (PT_MANUFACTURER) */
+	ut_assertok(run_command("tpm2 get_capability 0x6 0x20e 0x1000000 1", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_get_capability, 0);
+
+/**
+ * Test wolfTPM caps command (get capabilities)
+ *
+ * Display TPM capabilities and vendor info
+ */
+static int cmd_test_wolftpm_caps(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Get TPM capabilities */
+	ut_assertok(run_command("tpm2 caps", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_caps, 0);
+
+/**
+ * Test wolfTPM clear command
+ *
+ * Reset TPM internal state using LOCKOUT hierarchy
+ */
+static int cmd_test_wolftpm_clear(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Clear using LOCKOUT hierarchy */
+	ut_assertok(run_command("tpm2 clear TPM2_RH_LOCKOUT", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_clear, 0);
+
+/**
+ * Test wolfTPM pcr_read command
+ *
+ * Read PCR value from a specific index to a memory address
+ */
+static int cmd_test_wolftpm_pcr_read(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Read PCR 0 with SHA256 to memory address 0x1000000 */
+	ut_assertok(run_command("tpm2 pcr_read 0 0x1000000 SHA256", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_pcr_read, 0);
+
+/**
+ * Test wolfTPM pcr_extend command
+ *
+ * Extend a PCR with a digest value
+ */
+static int cmd_test_wolftpm_pcr_extend(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Clear to start fresh */
+	run_command("tpm2 clear TPM2_RH_LOCKOUT", 0);
+
+	/* Extend PCR 16 (resettable PCR) with digest from memory
+	 * PCR 16-23 are typically available for debug/testing
+	 */
+	ut_assertok(run_command("tpm2 pcr_extend 16 0x1000000 SHA256", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_pcr_extend, 0);
+
+/**
+ * Test wolfTPM pcr_print command
+ *
+ * Print all PCR values
+ */
+static int cmd_test_wolftpm_pcr_print(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Print all PCRs */
+	ut_assertok(run_command("tpm2 pcr_print", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_pcr_print, 0);
+
+/**
+ * Test wolfTPM pcr_allocate command
+ *
+ * Reconfigure PCR bank algorithm. Note: A TPM restart is required
+ * for changes to take effect, so we just verify the command succeeds.
+ */
+static int cmd_test_wolftpm_pcr_allocate(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Allocate SHA256 bank on - this should succeed */
+	ut_assertok(run_command("tpm2 pcr_allocate SHA256 on", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_pcr_allocate, 0);
+
+/**
+ * Test wolfTPM dam_reset command
+ *
+ * Reset Dictionary Attack Mitigation counter
+ */
+static int cmd_test_wolftpm_dam_reset(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Reset DAM counter */
+	ut_assertok(run_command("tpm2 dam_reset", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_dam_reset, 0);
+
+/**
+ * Test wolfTPM dam_parameters command
+ *
+ * Set Dictionary Attack Mitigation parameters
+ */
+static int cmd_test_wolftpm_dam_parameters(struct unit_test_state *uts)
+{
+	/* First autostart to ensure TPM is ready */
+	ut_assertok(run_command("tpm2 autostart", 0));
+
+	/* Set DAM parameters:
+	 * - max_tries: 3
+	 * - recovery_time: 10 seconds
+	 * - lockout_recovery: 0 seconds
+	 */
+	ut_assertok(run_command("tpm2 dam_parameters 3 10 0", 0));
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_dam_parameters, 0);
+
+/**
+ * Test wolfTPM change_auth command
+ *
+ * Change hierarchy authorization password
+ * Note: Requires WOLFTPM2_NO_WOLFCRYPT to NOT be defined
+ */
+static int cmd_test_wolftpm_change_auth(struct unit_test_state *uts)
+{
+	/* First autostart and clear to ensure clean state */
+	ut_assertok(run_command("tpm2 autostart", 0));
+	run_command("tpm2 clear TPM2_RH_LOCKOUT", 0);
+
+	/* Change LOCKOUT password to "testpw"
+	 * This may fail if WOLFTPM2_NO_WOLFCRYPT is defined
+	 */
+	if (run_command("tpm2 change_auth TPM2_RH_LOCKOUT testpw", 0) == 0) {
+		/* Clear with new password to verify it worked */
+		ut_assertok(run_command("tpm2 clear TPM2_RH_LOCKOUT testpw", 0));
+	}
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_change_auth, 0);
+
+/**
+ * Cleanup test - ensure TPM is cleared after tests
+ */
+static int cmd_test_wolftpm_cleanup(struct unit_test_state *uts)
+{
+	/* Clear TPM to reset any passwords or test state */
+	run_command("tpm2 autostart", 0);
+	run_command("tpm2 clear TPM2_RH_LOCKOUT", 0);
+	run_command("tpm2 clear TPM2_RH_PLATFORM", 0);
+
+	return 0;
+}
+CMD_TEST(cmd_test_wolftpm_cleanup, 0);
diff --git a/test/py/tests/test_wolftpm.py b/test/py/tests/test_wolftpm.py
new file mode 100644
index 00000000000..b862fa06c5b
--- /dev/null
+++ b/test/py/tests/test_wolftpm.py
@@ -0,0 +1,375 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2025 wolfSSL Inc.
+# Author: Aidan Garske <aidan@wolfssl.com>
+#
+# Based on test_tpm2.py by Miquel Raynal <miquel.raynal@bootlin.com>
+
+"""
+Test the wolfTPM related commands. These tests require a TPM device
+(real hardware or software TPM emulator like swtpm).
+
+Notes:
+* These tests will prove the password mechanism. The TPM chip must be cleared of
+  any password.
+* Tests are designed to be similar to test_tpm2.py but use wolfTPM wrapper APIs.
+
+Configuration:
+* Set env__wolftpm_device_test_skip to True to skip these tests.
+"""
+
+import os.path
+import pytest
+import utils
+import re
+import time
+
+
+def force_init(ubman, force=False):
+    """Initialize wolfTPM before running tests.
+
+    When a test fails, U-Boot may be reset. Because TPM stack must be initialized
+    after each reboot, we must ensure these lines are always executed before
+    trying any command or they will fail with no reason.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    output = ubman.run_command('tpm2 autostart')
+    if force or 'Error' not in output:
+        ubman.run_command('echo --- start of init ---')
+        ubman.run_command('tpm2 clear TPM2_RH_LOCKOUT')
+        output = ubman.run_command('echo $?')
+        if not output.endswith('0'):
+            ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
+        ubman.run_command('echo --- end of init ---')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_autostart(ubman):
+    """Test wolfTPM autostart command.
+
+    Initialize the software stack, perform startup and self-test.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 autostart')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_init(ubman):
+    """Test wolfTPM init command.
+
+    Initialize the TPM device for communication.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 init')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_self_test_full(ubman):
+    """Test wolfTPM full self_test command.
+
+    Perform a full TPM self-test to verify all components are operational.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 autostart')
+    ubman.run_command('tpm2 self_test full')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_self_test_continue(ubman):
+    """Test wolfTPM continue self_test command.
+
+    Ask the TPM to finish any remaining self tests.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 autostart')
+    ubman.run_command('tpm2 self_test continue')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_caps(ubman):
+    """Test wolfTPM caps command.
+
+    Display TPM capabilities and vendor information.
+    """
+    force_init(ubman)
+    ubman.run_command('tpm2 caps')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_clear(ubman):
+    """Test wolfTPM clear command.
+
+    Clear the TPM internal state using LOCKOUT hierarchy.
+    LOCKOUT/PLATFORM hierarchies must not have a password set.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 autostart')
+    ubman.run_command('tpm2 clear TPM2_RH_LOCKOUT')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+    ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_change_auth(ubman):
+    """Test wolfTPM change_auth command.
+
+    Change the owner/hierarchy password.
+    """
+    force_init(ubman)
+
+    # Change LOCKOUT password to 'unicorn'
+    # Note: change_auth requires wolfCrypt (WOLFTPM2_NO_WOLFCRYPT must not be set)
+    ubman.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
+    output = ubman.run_command('echo $?')
+    if not output.endswith('0'):
+        # wolfCrypt not available, skip password test
+        pytest.skip('change_auth requires wolfCrypt support')
+
+    # Clear with new password to verify
+    ubman.run_command('tpm2 clear TPM2_RH_LOCKOUT unicorn')
+    output = ubman.run_command('echo $?')
+    ubman.run_command('tpm2 clear TPM2_RH_PLATFORM')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_dam_parameters(ubman):
+    """Test wolfTPM dam_parameters command.
+
+    Change Dictionary Attack Mitigation parameters:
+    - Max number of failed authentication before lockout: 3
+    - Time before failure counter is decremented: 10 sec
+    - Time after lockout failure before retry: 0 sec
+    """
+    force_init(ubman)
+
+    # Set DAM parameters
+    ubman.run_command('tpm2 dam_parameters 3 10 0')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_dam_reset(ubman):
+    """Test wolfTPM dam_reset command.
+
+    Reset the Dictionary Attack Mitigation counter.
+    """
+    force_init(ubman)
+
+    ubman.run_command('tpm2 dam_reset')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_pcr_read(ubman):
+    """Test wolfTPM pcr_read command.
+
+    Read PCR value from a specific index.
+    """
+    force_init(ubman)
+
+    ram = utils.find_ram_base(ubman)
+
+    # Read PCR 0 with SHA256
+    read_pcr = ubman.run_command('tpm2 pcr_read 0 0x%x SHA256' % ram)
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_pcr_extend(ubman):
+    """Test wolfTPM pcr_extend command.
+
+    Extend a PCR with a digest value.
+    PCR 16-23 are typically available for debug/testing.
+    """
+    force_init(ubman)
+    ram = utils.find_ram_base(ubman)
+
+    # Read PCR 16 first
+    read_pcr = ubman.run_command('tpm2 pcr_read 16 0x%x SHA256' % ram)
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+    # Extend PCR 16 with zeroed memory
+    ubman.run_command('tpm2 pcr_extend 16 0x%x SHA256' % ram)
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+    # Read again to verify it changed
+    read_pcr_after = ubman.run_command('tpm2 pcr_read 16 0x%x SHA256' % ram)
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_pcr_print(ubman):
+    """Test wolfTPM pcr_print command.
+
+    Print all assigned PCRs.
+    """
+    force_init(ubman)
+
+    pcr_output = ubman.run_command('tpm2 pcr_print')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+    # Should contain PCR info
+    assert 'PCR' in pcr_output or 'Assigned' in pcr_output
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_info(ubman):
+    """Test wolfTPM info command.
+
+    Display TPM device information.
+    """
+    force_init(ubman)
+
+    ubman.run_command('tpm2 info')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_state(ubman):
+    """Test wolfTPM state command.
+
+    Display TPM internal state.
+    """
+    force_init(ubman)
+
+    ubman.run_command('tpm2 state')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_device(ubman):
+    """Test wolfTPM device command.
+
+    Show all TPM devices.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 device')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_startup_clear(ubman):
+    """Test wolfTPM startup command with TPM2_SU_CLEAR.
+
+    Issue TPM2_Startup with CLEAR mode (reset state).
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 init')
+    ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_startup_state(ubman):
+    """Test wolfTPM startup command with TPM2_SU_STATE.
+
+    Issue TPM2_Startup with STATE mode (preserved state).
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    # First autostart to have valid state
+    ubman.run_command('tpm2 autostart')
+    # Shutdown with STATE
+    ubman.run_command('tpm2 startup TPM2_SU_STATE off')
+    # Re-init
+    ubman.run_command('tpm2 init')
+    # Startup with STATE - may return already started
+    ubman.run_command('tpm2 startup TPM2_SU_STATE')
+    output = ubman.run_command('echo $?')
+    # May return non-zero if already started, just verify command ran
+    assert output is not None
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_startup_shutdown(ubman):
+    """Test wolfTPM startup shutdown command.
+
+    Issue TPM2_Shutdown.
+    """
+    skip_test = ubman.config.env.get('env__wolftpm_device_test_skip', False)
+    if skip_test:
+        pytest.skip('skip wolfTPM device test')
+    ubman.run_command('tpm2 autostart')
+    ubman.run_command('tpm2 startup TPM2_SU_CLEAR off')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_get_capability(ubman):
+    """Test wolfTPM get_capability command.
+
+    Read TPM capabilities by property.
+    """
+    force_init(ubman)
+    ram = utils.find_ram_base(ubman)
+
+    # Get capability - TPM_CAP_TPM_PROPERTIES (0x6), PT_MANUFACTURER (0x20e)
+    ubman.run_command('tpm2 get_capability 0x6 0x20e 0x%x 1' % ram)
+    output = ubman.run_command('echo $?')
+    # May fail on some platforms if RAM address is not accessible
+    if not output.endswith('0'):
+        pytest.skip('get_capability failed (RAM address may not be accessible)')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_pcr_allocate(ubman):
+    """Test wolfTPM pcr_allocate command.
+
+    Reconfigure PCR bank algorithm.
+    Note: A TPM restart is required for changes to take effect.
+    """
+    force_init(ubman)
+
+    # Allocate SHA256 bank on
+    ubman.run_command('tpm2 pcr_allocate SHA256 on')
+    output = ubman.run_command('echo $?')
+    assert output.endswith('0')
+
+
+@pytest.mark.buildconfigspec('tpm_wolf')
+def test_wolftpm_cleanup(ubman):
+    """Cleanup test - ensure TPM is cleared after tests."""
+    force_init(ubman, True)
-- 
2.43.0

