Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D80BEB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654DE86A6A;
	Fri,  8 Sep 2023 04:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wUJdpQMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D4086A2F; Fri,  8 Sep 2023 04:52:47 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA14869B9
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-273b1ea30beso407531a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141562; x=1694746362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84CqU0uEmfuQ0jWgwbyKzdUtEfOlVHcjpgoNiLdVSgc=;
 b=wUJdpQMitVhnodRNq6SZ9fBhnwCtBgkATMMS6wZPHEwrYV9T5piAIHbj1QvSoPYpY8
 erpIgQ/EkqgeUHGcvPiWeaMBxb1AHfvsmQfnkhblOmJzZqJV0/VtA2Hgr6w8zyG037xg
 ha07XCMsrem67fmzFhOT3F3YxCV1zhiRkgrGDjJu/wI9ER7Gfx+HDzdN7uBDdbeAD4q/
 xCdmd9KC1ThZl6ApZr36TP1HgfNQFaXmMnP/MlN9Gq1cheNUT+2mjezwfgxvIfpwBkzH
 vzo9MFyG0S+F2UKJsd2xhaxs5zSwjZL7Tcakv0uPj0oUp/Yj3EF4O+5zkaUjKKxpWHCn
 scmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141562; x=1694746362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84CqU0uEmfuQ0jWgwbyKzdUtEfOlVHcjpgoNiLdVSgc=;
 b=W395hqkpTOLmJP5yzrkBstaScvxmflI3bOkRPip6VULwslKiqOtVN+SIHwXBMStbtb
 jj8FDDaxIHuGMcgBA/DhNPay8L12ejc88bQTODFccKRY3ameVjPH8QFdzOK2WU6XYA4n
 kX0+dJ3kdU1OCkT0mjWbMuYP3qU4tCswGuUdyZWLByXcbfWDQDT8+eZDqo/bK7xD6Cuv
 4MHJLwoC+6IXla5zieP9bMGY4XpuAG0tporPfIAiZbmiIhBXc91ey0bsxYgDZdT+3rLT
 UT9L4O2GW91p+Ujieg6M0RMYwqAHExBY9XWtEhnWmbBBMaSsakUA1Ngg+hRb4a+lbW+4
 aMHg==
X-Gm-Message-State: AOJu0YxVdqFBfWaUINMczVu24gLXGexcB63yUH1XHreAdXjO55ZONj4Z
 uqC6QAk/aqzda0mPCFMCvoX5OQ==
X-Google-Smtp-Source: AGHT+IFvvF6i8QErr1h0HAj3tdNrPB6KrRljtjnx7DQE/7q2pvzMM9J4sbfRmrewFea8YHBXyy/rWA==
X-Received: by 2002:a17:902:c94e:b0:1c3:4073:bf80 with SMTP id
 i14-20020a170902c94e00b001c34073bf80mr1573735pla.0.1694141562498; 
 Thu, 07 Sep 2023 19:52:42 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:42 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 13/13] test: dm: add scmi command test
Date: Fri,  8 Sep 2023 11:51:38 +0900
Message-Id: <20230908025138.44405-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908025138.44405-1-takahiro.akashi@linaro.org>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
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
v3
* change char to u8 in vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 0785948186f0..423b6ef70b29 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -104,8 +104,7 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 	struct scmi_agent_priv *priv;
 	u32 version, num_agents, num_protocols, impl_version;
 	u32 attributes, agent_id;
-	char *vendor, *agent_name;
-	u8 *protocols;
+	u8 *vendor, *agent_name, *protocols;
 	int ret;
 
 	/* preparation */
@@ -134,9 +133,9 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 	free(vendor);
 
 	/* message attributes */
-	ret = scmi_protocol_message_attrs(base,
-					  SCMI_BASE_DISCOVER_SUB_VENDOR,
-					  &attributes);
+	ret = scmi_base_protocol_message_attrs(base,
+					       SCMI_BASE_DISCOVER_SUB_VENDOR,
+					       &attributes);
 	ut_assertok(ret);
 	ut_assertok(attributes);
 
@@ -207,6 +206,59 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 
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

