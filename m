Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E51EC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 05:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF9887A4A;
	Wed, 25 Oct 2023 07:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V+qLWoRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B3C87A3C; Wed, 25 Oct 2023 07:15:09 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D2C87A36
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bcbfecf314so1138833b3a.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698210905; x=1698815705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hD60SfHV9nxHXcrI7Ny6Jjph+UCCDkTfF34GTIduQEo=;
 b=V+qLWoRuB5nW6i8P0WbE3obToz0k8MwSbsbJSqzkTbQ0wLToYd44b5he/Q1gWpyV98
 VZ3oaldh1aBc7MhoJGQs8Ir5mN62BbIiTwHatdFWWH8nd94urSegQmbmQSGhvRd7JR7Z
 qJvWnItOpV3v5ArrgN5CrqJ83qtdrm3p3rpOi21PEjXsmvt9sFe2vJY05Y9U8geq/R4W
 FoRSW+kIzIkHYyFzrm/EgAHFKQ0YdOXWtFVOPXzEKd1GapGwhm6goWholMce2Bo/hujT
 5+mGh5a6k8+SLPS4ghTheYVsIzq/8ki/7gWasb9wo9umYHiuGvElWDCrKYfVS0koOZmT
 7j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698210905; x=1698815705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD60SfHV9nxHXcrI7Ny6Jjph+UCCDkTfF34GTIduQEo=;
 b=fRs2N4/2PYaQX/vJCWrv5uAT80guyWc2PvpfpBHcoFAvlSd/UOWirxJwLT9etem3HN
 UAl/7PNOTlMtg0RiLq5xsjjf97+HVHcRbYV0vRnSHyYY76JSj87TcSeX2MoAE2Z1/q6K
 DkmV/ajXEkUwTxgMQLefjfuSjz5sI0UIYT0T1oeN9VU4rQEokEDcHFDKSRMINPx9V27y
 UMxsto5znnz+5UG2qeFrKAAP3zqmtqT6L4Czs6rabIisP2IczLfpUdtgS6j340RVHX08
 a5yRZ1VYuw+f1Nzi2MefkbvVrR4qEVhrNXUk+aiuv+wFGu5BqF0JBJln/OowmpEiX3wn
 jCTQ==
X-Gm-Message-State: AOJu0Yzp0sZs4MKO/wc5hAwxgjJS+3MSYSG8GEFb0rVHCuwpuSGspJGr
 adF5m2qv30gbQXcWKOTfB4CYVA==
X-Google-Smtp-Source: AGHT+IG4ldCsWs1V+kSVYp3S6svu9doZEg9EUTnaAyZmmwzZgLj8j9FuOuBgkQ4zFVRYHi8Y1miErg==
X-Received: by 2002:a17:90b:4b8f:b0:27c:f653:37b2 with SMTP id
 lr15-20020a17090b4b8f00b0027cf65337b2mr16464858pjb.1.1698210905512; 
 Tue, 24 Oct 2023 22:15:05 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 fz3-20020a17090b024300b002609cadc56esm7715815pjb.11.2023.10.24.22.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:15:05 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 5/5] test: dm: add scmi command test
Date: Wed, 25 Oct 2023 14:14:27 +0900
Message-Id: <20231025051427.509602-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051427.509602-1-takahiro.akashi@linaro.org>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
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

In this test, "scmi" command is tested against different sub-commands.
Please note that scmi command is for debug purpose and is not intended
in production system.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v7
* make test assertions more flexible depending on the number of provided
  protocols
v4
* move 'base'-related changes to the prior commit
* add CONFIG_CMD_SCMI to sandbox_defconfig
v3
* change char to u8 in vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 configs/sandbox_defconfig |  1 +
 test/dm/scmi.c            | 81 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index e3a2f9eb1708..34e3cc281d7f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -120,6 +120,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AES=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_TPM_TEST=y
+CONFIG_CMD_SCMI=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 2f63f2da16fb..2bcf7ac6fcc3 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -19,6 +19,7 @@
 #include <scmi_agent.h>
 #include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
+#include <vsprintf.h>
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
@@ -206,6 +207,86 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 
 DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
 
+static int dm_test_scmi_cmd(struct unit_test_state *uts)
+{
+	struct udevice *agent_dev;
+	int num_proto = 0;
+	char cmd_out[30];
+
+	if (!IS_ENABLED(CONFIG_CMD_SCMI))
+		return 0;
+
+	/* preparation */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+
+	/*
+	 * Estimate the number of provided protocols.
+	 * This estimation is correct as far as a corresponding
+	 * protocol support is added to sandbox fake serer.
+	 */
+	if (IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
+		num_proto++;
+	if (IS_ENABLED(CONFIG_CLK_SCMI))
+		num_proto++;
+	if (IS_ENABLED(CONFIG_RESET_SCMI))
+		num_proto++;
+	if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
+		num_proto++;
+
+	/* scmi info */
+	ut_assertok(run_command("scmi info", 0));
+
+	ut_assert_nextline("SCMI device: scmi");
+	snprintf(cmd_out, 30, "  protocol version: 0x%x",
+		 SCMI_BASE_PROTOCOL_VERSION);
+	ut_assert_nextline(cmd_out);
+	ut_assert_nextline("  # of agents: 2");
+	ut_assert_nextline("      0: platform");
+	ut_assert_nextline("    > 1: OSPM");
+	snprintf(cmd_out, 30, "  # of protocols: %d", num_proto);
+	ut_assert_nextline(cmd_out);
+	if (IS_ENABLED(CONFIG_SCMI_POWER_DOMAIN))
+		ut_assert_nextline("      Power domain management");
+	if (IS_ENABLED(CONFIG_CLK_SCMI))
+		ut_assert_nextline("      Clock management");
+	if (IS_ENABLED(CONFIG_RESET_SCMI))
+		ut_assert_nextline("      Reset domain management");
+	if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI))
+		ut_assert_nextline("      Voltage domain management");
+	ut_assert_nextline("  vendor: U-Boot");
+	ut_assert_nextline("  sub vendor: Sandbox");
+	ut_assert_nextline("  impl version: 0x1");
+
+	ut_assert_console_end();
+
+	/* scmi perm_dev */
+	ut_assertok(run_command("scmi perm_dev 1 0 1", 0));
+	ut_assert_console_end();
+
+	ut_assert(run_command("scmi perm_dev 1 0 0", 0));
+	ut_assert_nextline("Denying access to device:0 failed (-13)");
+	ut_assert_console_end();
+
+	/* scmi perm_proto */
+	ut_assertok(run_command("scmi perm_proto 1 0 14 1", 0));
+	ut_assert_console_end();
+
+	ut_assert(run_command("scmi perm_proto 1 0 14 0", 0));
+	ut_assert_nextline("Denying access to protocol:0x14 on device:0 failed (-13)");
+	ut_assert_console_end();
+
+	/* scmi reset */
+	ut_assert(run_command("scmi reset 1 1", 0));
+	ut_assert_nextline("Reset failed (-13)");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_scmi_cmd, UT_TESTF_SCAN_FDT);
+
 static int dm_test_scmi_power_domains(struct unit_test_state *uts)
 {
 	struct sandbox_scmi_agent *agent;
-- 
2.34.1

