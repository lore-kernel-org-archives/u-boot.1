Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F27C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 02:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D056E8716C;
	Tue, 14 Nov 2023 03:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gm8wQwZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0BB86FB2; Tue, 14 Nov 2023 03:14:58 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 196FB871C0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 03:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc41afd376so3351555ad.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 18:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699928094; x=1700532894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cjaloo8fP4ejF1QQKCfPDBSHT99TfpromhN5WcQJSUk=;
 b=Gm8wQwZFlSVpTfBvBLE6a5FIOtUNoyjFN73ITe0/cNEmy2suw463oeO6lohrHZ/bfr
 HDq+d2pLE7mO9SpFUc/l/3wdl3fVGSaCakyBajWiJMi7IEpC+8pbYWkbr+4oVVkidtHp
 H5TA5UaD2uoSnCTcEATCLMfcdaFEmO3igO07F5BNv8mGHJ/PMzr771CBsD89j0zLxxSW
 JK29EHQ84WUiFFTA712LfwNdAH+k+B3p7IXZSWu8+wjEeWyJxWuJYXG2bcY8gTaolhvT
 pafzfcvdeGEEov/ESs8VTG6NQtqZUhiE6jKmTd/CjSHCM6bMuB4j2pHePll0q21h8NIp
 EFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699928094; x=1700532894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cjaloo8fP4ejF1QQKCfPDBSHT99TfpromhN5WcQJSUk=;
 b=Degdhn3TXWSqjQyURMjrkddVxwp7Tk9jC9c9AgHuMGYge6J2ZxyPaAwwuGt39dlqxU
 cXzSmO8qGU6V5aMmScTfz3Pc3kvbgfhM+SHo8Yi8YYTkudz4dxNVHEkbScyapMXUHu7J
 iyHKfj1bhkJK1VgvMnOgC1cbdEv49fKijF+UjHz4cLa0JmJXztmKyipqLlJ9yeFE5dfe
 9KbTA/LHGHjQd9asp43hujUv7onJ9akvkfLxrw7W7LdwzJLaIVyR6bc0drmCEcBfUdIF
 zTUCn/DzxfUwxcutPmnXOSun9qsmk23Ap1wQMj2FLbPp2eQp2qlHM0ZRCq51350aJVUd
 ojqw==
X-Gm-Message-State: AOJu0Ywz4YReKfNkvg8JvdaUut1tPyUpxi//SH5OM4FbOY2Q6YnzwhSK
 7YjWOVw+sUaVZYZFs8Gfr32MwQ==
X-Google-Smtp-Source: AGHT+IHyz4soaLwxUsDwhqXmPfg0ay3XwUf/DDwx/w8eZtKfory34FPtUXIKIB5K66x7ay4dUJ21tw==
X-Received: by 2002:a17:902:ce8c:b0:1cc:e66:f994 with SMTP id
 f12-20020a170902ce8c00b001cc0e66f994mr1134570plg.1.1699928094262; 
 Mon, 13 Nov 2023 18:14:54 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902c94400b001c61afa7009sm4680475pla.114.2023.11.13.18.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 18:14:54 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 5/5] test: dm: add scmi command test
Date: Tue, 14 Nov 2023 11:14:28 +0900
Message-Id: <20231114021428.531887-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114021428.531887-1-takahiro.akashi@linaro.org>
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
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
v9
* return -EAGAIN if we want to skip a test
* use CONFIG_IS_ENABLED() rather than IS_ENABLED()
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
index bc5bcb2a6237..c550af93b0ca 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -121,6 +121,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AES=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_TPM_TEST=y
+CONFIG_CMD_SCMI=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 582485471fff..e80667ef72a3 100644
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
+	if (!CONFIG_IS_ENABLED(CMD_SCMI))
+		return -EAGAIN;
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
+	if (CONFIG_IS_ENABLED(POWER_DOMAIN))
+		num_proto++;
+	if (CONFIG_IS_ENABLED(CLK_SCMI))
+		num_proto++;
+	if (CONFIG_IS_ENABLED(RESET_SCMI))
+		num_proto++;
+	if (CONFIG_IS_ENABLED(DM_REGULATOR_SCMI))
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
+	if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN))
+		ut_assert_nextline("      Power domain management");
+	if (CONFIG_IS_ENABLED(CLK_SCMI))
+		ut_assert_nextline("      Clock management");
+	if (CONFIG_IS_ENABLED(RESET_SCMI))
+		ut_assert_nextline("      Reset domain management");
+	if (CONFIG_IS_ENABLED(DM_REGULATOR_SCMI))
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

