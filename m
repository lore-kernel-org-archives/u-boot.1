Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD8FC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 01:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F7A87076;
	Mon, 13 Nov 2023 02:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U2YzNoZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F99870BC; Mon, 13 Nov 2023 02:49:45 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4183D87098
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bcbfecf314so812299b3a.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699840180; x=1700444980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVcsVYY843GHoeAsm03ODTeqNlct1/wIMe3XRv6dB1Y=;
 b=U2YzNoZzzBGx/Y18oCDmjpqX1LE0L0JMy9dpKu26cMSwISjv7Nj1CtI4evc3D58aaY
 pbl7DWunSZp3vJCFo9W0AXcfQ/+4DSiav5fo5Ad81dfS4dsWxZkexiA6C4HBwAWW0PCm
 g2q3/souapRERM8J6O06gYnNE6Z1LR6CHppZjVmhkkZfd2gE6ufW/pXhtP0icODP+z0D
 7rnXNvozmPuWCT0EyNhWUinmYx943lDfnpmGONG2u8Qngnuy3x9pKB0gI/EZ8Ww+w049
 Fm/76I82fFX7NIwt8giKdPOpO9VrPm64q6pW2OAvHGVcjSbRB+xj4lr53V3nxdYZyixW
 TYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699840180; x=1700444980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVcsVYY843GHoeAsm03ODTeqNlct1/wIMe3XRv6dB1Y=;
 b=Ret7+pKo4iZeAv3wIsLouPgZgp9kEMy7HPW//FUx1SRjiqyQOX1uvHxJYotZqlaNRi
 2tc16IX2iEg9Ng3VO+eBXtc2WgZzN1UgLBk+ZmdTwLv/GYpQn095LTPbqo0fP5CLjnWb
 rS4BjDDeBk28FRxeRjL842q3UsJEGg8wXaIG2DuoWUruK4G91sxuEpTzXBMdQIX7yRmF
 ogNYg/IxFRQUIuqr8jmEwGjEp41J3d96i6fWF5A++smNqciZUzkpM6HkHKq+qRRE/jcV
 KlPJXsUIRGntpy+FZWXocYK4vgFyWByycQg0u71DNmvgXzG1p7f0VYCkOvNU4bYLj/BI
 1RYw==
X-Gm-Message-State: AOJu0YxpqjuAO9y1+x+NBNLjvBhqSoYQuG0atCJzNbt2I+9RWP4oRbsc
 U0Mjn+PquEyMBLk58JLrYaQLKA==
X-Google-Smtp-Source: AGHT+IF63e6kz6Fg8pSzs4vC7PIOivQ6h/JOElE4dEf6PvK5yVTXA+AxpRMFTdch90c2t3e2ewTPyg==
X-Received: by 2002:a05:6a00:2d0f:b0:68a:6cbe:35a7 with SMTP id
 fa15-20020a056a002d0f00b0068a6cbe35a7mr6501971pfb.2.1699840180559; 
 Sun, 12 Nov 2023 17:49:40 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:ba59:509b:48bc:9f1])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a65644e000000b005b92e60cf57sm2635549pgv.56.2023.11.12.17.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:49:40 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 5/5] test: dm: add scmi command test
Date: Mon, 13 Nov 2023 10:49:11 +0900
Message-Id: <20231113014911.3308990-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
References: <20231113014911.3308990-1-takahiro.akashi@linaro.org>
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

