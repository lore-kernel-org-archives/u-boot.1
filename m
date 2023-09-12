Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6543CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D02486CD9;
	Tue, 12 Sep 2023 08:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aS5FpLc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1E986CD9; Tue, 12 Sep 2023 08:21:47 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E1C86E68
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-573e931433aso630925a12.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499703; x=1695104503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jULBC+9kuCwtWkpMQe51eU0+5y//ch+u0sbCGsOqB1A=;
 b=aS5FpLc5PyD/ZAgaugSA7zTN1PpDPfxURhv3Qeu6nOo4RjXrnJ4HpjRwhA1taPNPAH
 Phi+z9Xhhvm/Z+QNx/1R1HdOgnb4uYlQ1gZxMAOAX46amH3pXwSLE7ztLDKX+UrSWI54
 JvD0BTa/17zEgqKjjEImtEERvBI5z3npn+frL8QH0R7aqNVpTbYVC83chNMyPEZCSdr4
 ZWquL8jh72MU8qPNEVemUzcqQPYj9dNXbrrvI05pmf9akIJ17Qckis2JLVs+g+9Wt8bZ
 95aY4S63wIKAJ4cg9k6trI0os5vktloABjGgl1wdjvTDZuj5AHkKQSqhpaLE9AhKZ4gz
 1WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499703; x=1695104503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jULBC+9kuCwtWkpMQe51eU0+5y//ch+u0sbCGsOqB1A=;
 b=aJG1Bw+FUAY2uL1d/nKkGjyDdtz16NMFDrk4qnZblKBXHdGpEh4BBTRRzQQ/AQDLpE
 PZajrfsOK9TSrB4PjdiD9Mg9VIFjGn40B8MPpGTH7ddQBQJkV8IkX+UBDrW2qwg/sJXP
 F2CH3LTSOTlHn4rINgTdYeFFPIbiAT+FD7sGoF2H7AET5SkrBl+QGwiuB/wDc9gXSHFl
 Ko0xlApePJNFYrR0FzjQ4e6KsyfwdknfDOdU2CM4Amos0wu8QyqpzBf9jEn3zLDM1cE8
 T/0js91Bux0gDySObzVUtA2EpxEDkWcYg8tac72dzzY/rMblLFdgiOLNZXq1EIXE/td2
 /dVQ==
X-Gm-Message-State: AOJu0Yy8lGR/PQSzLKv6QUedA59Qi3VCOwjosLUPM8omyijRip1T9Kpm
 s6e1EB2H66E7XS2FJOwRJHXJSQ==
X-Google-Smtp-Source: AGHT+IHUwGEz1upZcw61+cLF5YiC9pL4BXllvchnMBlv0Oc3mvd+zsI/lxCiX3tdEkB4BVXTAgOavg==
X-Received: by 2002:a05:6a20:a10c:b0:145:3bd9:1389 with SMTP id
 q12-20020a056a20a10c00b001453bd91389mr14081151pzk.6.1694499703219; 
 Mon, 11 Sep 2023 23:21:43 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:42 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 13/13] test: dm: add scmi command test
Date: Tue, 12 Sep 2023 15:20:02 +0900
Message-Id: <20230912062002.57361-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912062002.57361-1-takahiro.akashi@linaro.org>
References: <20230912062002.57361-1-takahiro.akashi@linaro.org>
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
v4
* move 'base'-related changes to the prior commit
* add CONFIG_CMD_SCMI to sandbox_defconfig
v3
* change char to u8 in vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 configs/sandbox_defconfig |  1 +
 test/dm/scmi.c            | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 1cd1c2ed7cd5..3906476bb4fc 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -122,6 +122,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AES=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_TPM_TEST=y
+CONFIG_CMD_SCMI=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 48610299c1a1..423b6ef70b29 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -206,6 +206,59 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 
 DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
 
+static int dm_test_scmi_cmd(struct unit_test_state *uts)
+{
+	struct udevice *agent_dev;
+
+	/* preparation */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+
+	/* scmi info */
+	ut_assertok(run_command("scmi info", 0));
+
+	ut_assert_nextline("SCMI device: scmi");
+	ut_assert_nextline("  protocol version: 0x20000");
+	ut_assert_nextline("  # of agents: 2");
+	ut_assert_nextline("      0: platform");
+	ut_assert_nextline("    > 1: OSPM");
+	ut_assert_nextline("  # of protocols: 3");
+	ut_assert_nextline("      Clock management");
+	ut_assert_nextline("      Reset domain management");
+	ut_assert_nextline("      Voltage domain management");
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
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
 	struct sandbox_scmi_agent *agent;
-- 
2.34.1

