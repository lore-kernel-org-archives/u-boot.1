Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D3EE14D7
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173F1869D7;
	Fri,  8 Sep 2023 04:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HGcZZbuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457DA869D7; Fri,  8 Sep 2023 04:52:39 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429EA86995
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1d549d01c74so307287fac.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141555; x=1694746355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cw+gCr9HDSitMmo/NFMCEk5FCyJsX7Ju3WfgGv1u50=;
 b=HGcZZbuO0o68dDo9AfLToIJt4vCF4tdGXBFO82/D1txfpZJTJ8uPZrF18FUXfKbsbP
 ec8mMaUHuwjrFLBZllBcxLn5RQ6PzrKZsPU1B+gIUhBJYSZgcmoA342dBJ6fA2pt3glp
 /t7xdv28O2WOZBpHHMymlpEB08Sbc2L8ICEZZrIkNDrg8i5J6VTzzcOAZVu1T66CSgrj
 tRB6Xnc4VrhUHLEKApwGFL1ECPQJiF6ihlsamni0jaGJIT8qRdK+hEHwcMzNpe0uctOn
 O3D+PUFhd5GLf0Wk4jYtGJv6Hd4rFcnfQULgf+mM7Futq0+n38MAjFERhwkwp5AJFAha
 t/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141555; x=1694746355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cw+gCr9HDSitMmo/NFMCEk5FCyJsX7Ju3WfgGv1u50=;
 b=TyYq4ViRxWq4Uxr1AhrY9BgqxOHq9HF6elkcr7U9f2k+dZqC13siP6joELV9r9Mwu/
 h4WhandiIzcLL4ThW6pWDNpgcqgSvkUPl4Umdl5SUajYOUF41Q24BUhCyVb28U6nHoTr
 CiPSmvq+Nm1ZaZE/aQAvQKzUWN5CStQqFtEs0EY5cojoNbm3YRTUYmi8sCIFYzkJ0z+v
 ySFGUCvKGqx+SP4aaFyXwZLLew9EGxIcgeozCeyCPGD3dFdhEgN3ym8S+fCzXVkX3dj3
 mJCxjfrT01wpyPuzpY4hSXXVTvXmV5iFGT0NKxXzCFJuxgvFXrHv0OYDdnJGYmwBroUb
 9UqA==
X-Gm-Message-State: AOJu0YwtRM4tAvgKcRkwftKQAqNKSyxaNrzFerTsn3p9ZXYf/9+bKy+J
 LkHfRzAFPzWgNoWInqiyGQkR9w==
X-Google-Smtp-Source: AGHT+IHTLligElxV9vIqkqCgm+gUjgScn3VWyaFdNue3Tuf/DG092qmRdkN1vMWXObc8tderPkyshg==
X-Received: by 2002:a05:6808:218f:b0:3a1:d457:83b5 with SMTP id
 be15-20020a056808218f00b003a1d45783b5mr1570743oib.3.1694141554762; 
 Thu, 07 Sep 2023 19:52:34 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:34 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 09/13] test: dm: simplify SCMI unit test on sandbox
Date: Fri,  8 Sep 2023 11:51:34 +0900
Message-Id: <20230908025138.44405-10-takahiro.akashi@linaro.org>
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

Adding SCMI base protocol makes it inconvenient to hold the agent instance
(udevice) locally since the agent device will be re-created per each test.
Just remove it and simplify the test flows.
The test scenario is not changed at all.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  7 ++-
 drivers/firmware/scmi/sandbox-scmi_agent.c | 20 +------
 drivers/firmware/scmi/scmi_agent-uclass.c  |  3 -
 test/dm/scmi.c                             | 64 +++++++---------------
 4 files changed, 26 insertions(+), 68 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index c72ec1e1cb25..2718336a9a50 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -89,10 +89,11 @@ struct sandbox_scmi_devices {
 
 #ifdef CONFIG_SCMI_FIRMWARE
 /**
- * sandbox_scmi_service_ctx - Get the simulated SCMI services context
+ * sandbox_scmi_agent_ctx - Get the simulated SCMI agent context
+ * @dev:	Reference to the test agent
  * @return:	Reference to backend simulated resources state
  */
-struct sandbox_scmi_service *sandbox_scmi_service_ctx(void);
+struct sandbox_scmi_agent *sandbox_scmi_agent_ctx(struct udevice *dev);
 
 /**
  * sandbox_scmi_devices_ctx - Get references to devices accessed through SCMI
@@ -101,7 +102,7 @@ struct sandbox_scmi_service *sandbox_scmi_service_ctx(void);
  */
 struct sandbox_scmi_devices *sandbox_scmi_devices_ctx(struct udevice *dev);
 #else
-static inline struct sandbox_scmi_service *sandbox_scmi_service_ctx(void)
+static struct sandbox_scmi_agent *sandbox_scmi_agent_ctx(struct udevice *dev)
 {
 	return NULL;
 }
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 42a5a1f37f8b..27d17809be43 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -66,11 +66,9 @@ static struct sandbox_scmi_voltd scmi_voltd[] = {
 	{ .id = 1, .voltage_uv = 1800000 },
 };
 
-static struct sandbox_scmi_service sandbox_scmi_service_state;
-
-struct sandbox_scmi_service *sandbox_scmi_service_ctx(void)
+struct sandbox_scmi_agent *sandbox_scmi_agent_ctx(struct udevice *dev)
 {
-	return &sandbox_scmi_service_state;
+	return dev_get_priv(dev);
 }
 
 static void debug_print_agent_state(struct udevice *dev, char *str)
@@ -898,16 +896,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 
 static int sandbox_scmi_test_remove(struct udevice *dev)
 {
-	struct sandbox_scmi_agent *agent = dev_get_priv(dev);
-
-	if (agent != sandbox_scmi_service_ctx()->agent)
-		return -EINVAL;
-
 	debug_print_agent_state(dev, "removed");
 
-	/* We only need to dereference the agent in the context */
-	sandbox_scmi_service_ctx()->agent = NULL;
-
 	return 0;
 }
 
@@ -915,9 +905,6 @@ static int sandbox_scmi_test_probe(struct udevice *dev)
 {
 	struct sandbox_scmi_agent *agent = dev_get_priv(dev);
 
-	if (sandbox_scmi_service_ctx()->agent)
-		return -EINVAL;
-
 	*agent = (struct sandbox_scmi_agent){
 		.clk = scmi_clk,
 		.clk_count = ARRAY_SIZE(scmi_clk),
@@ -929,9 +916,6 @@ static int sandbox_scmi_test_probe(struct udevice *dev)
 
 	debug_print_agent_state(dev, "probed");
 
-	/* Save reference for tests purpose */
-	sandbox_scmi_service_ctx()->agent = agent;
-
 	return 0;
 };
 
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 54e17992af00..b37acbb9f9db 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -455,9 +455,6 @@ static int scmi_bind_protocols(struct udevice *dev)
 		}
 	}
 
-	if (!ret)
-		scmi_agent = dev;
-
 	return ret;
 }
 
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index d87e2731ce42..881be3171b7c 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -23,22 +23,11 @@
 #include <power/regulator.h>
 #include <test/ut.h>
 
-static int ut_assert_scmi_state_preprobe(struct unit_test_state *uts)
-{
-	struct sandbox_scmi_service *scmi_ctx = sandbox_scmi_service_ctx();
-
-	ut_assertnonnull(scmi_ctx);
-	ut_assertnull(scmi_ctx->agent);
-
-	return 0;
-}
-
 static int ut_assert_scmi_state_postprobe(struct unit_test_state *uts,
+					  struct sandbox_scmi_agent *agent,
 					  struct udevice *dev)
 {
 	struct sandbox_scmi_devices *scmi_devices;
-	struct sandbox_scmi_service *scmi_ctx;
-	struct sandbox_scmi_agent *agent;
 
 	/* Device references to check context against test sequence */
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
@@ -48,10 +37,6 @@ static int ut_assert_scmi_state_postprobe(struct unit_test_state *uts,
 	ut_asserteq(2, scmi_devices->regul_count);
 
 	/* State of the simulated SCMI server exposed */
-	scmi_ctx = sandbox_scmi_service_ctx();
-	ut_assertnonnull(scmi_ctx);
-	agent = scmi_ctx->agent;
-	ut_assertnonnull(agent);
 	ut_asserteq(3, agent->clk_count);
 	ut_assertnonnull(agent->clk);
 	ut_asserteq(1, agent->reset_count);
@@ -63,27 +48,32 @@ static int ut_assert_scmi_state_postprobe(struct unit_test_state *uts,
 }
 
 static int load_sandbox_scmi_test_devices(struct unit_test_state *uts,
+					  struct sandbox_scmi_agent **ctx,
 					  struct udevice **dev)
 {
-	int ret;
+	struct udevice *agent_dev;
 
-	ret = ut_assert_scmi_state_preprobe(uts);
-	if (ret)
-		return ret;
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+
+	*ctx = sandbox_scmi_agent_ctx(agent_dev);
+	ut_assertnonnull(*ctx);
 
+	/* probe */
 	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "sandbox_scmi",
 					      dev));
 	ut_assertnonnull(*dev);
 
-	return ut_assert_scmi_state_postprobe(uts, *dev);
+	return ut_assert_scmi_state_postprobe(uts, *ctx, *dev);
 }
 
 static int release_sandbox_scmi_test_devices(struct unit_test_state *uts,
 					     struct udevice *dev)
 {
+	/* un-probe */
 	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
 
-	/* Not sure test devices are fully removed, agent may not be visible */
 	return 0;
 }
 
@@ -93,10 +83,11 @@ static int release_sandbox_scmi_test_devices(struct unit_test_state *uts,
  */
 static int dm_test_scmi_sandbox_agent(struct unit_test_state *uts)
 {
+	struct sandbox_scmi_agent *ctx;
 	struct udevice *dev = NULL;
 	int ret;
 
-	ret = load_sandbox_scmi_test_devices(uts, &dev);
+	ret = load_sandbox_scmi_test_devices(uts, &ctx, &dev);
 	if (!ret)
 		ret = release_sandbox_scmi_test_devices(uts, dev);
 
@@ -106,23 +97,18 @@ DM_TEST(dm_test_scmi_sandbox_agent, UT_TESTF_SCAN_FDT);
 
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
-	struct sandbox_scmi_devices *scmi_devices;
-	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
+	struct sandbox_scmi_devices *scmi_devices;
 	struct udevice *dev;
 	int ret_dev;
 	int ret;
 
-	ret = load_sandbox_scmi_test_devices(uts, &dev);
+	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
 
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
 	ut_assertnonnull(scmi_devices);
-	scmi_ctx = sandbox_scmi_service_ctx();
-	ut_assertnonnull(scmi_ctx);
-	agent = scmi_ctx->agent;
-	ut_assertnonnull(agent);
 
 	/* Test SCMI clocks rate manipulation */
 	ut_asserteq(333, agent->clk[0].rate);
@@ -169,22 +155,17 @@ DM_TEST(dm_test_scmi_clocks, UT_TESTF_SCAN_FDT);
 
 static int dm_test_scmi_resets(struct unit_test_state *uts)
 {
-	struct sandbox_scmi_devices *scmi_devices;
-	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
+	struct sandbox_scmi_devices *scmi_devices;
 	struct udevice *dev = NULL;
 	int ret;
 
-	ret = load_sandbox_scmi_test_devices(uts, &dev);
+	ret = load_sandbox_scmi_test_devices(uts, &agent, &dev);
 	if (ret)
 		return ret;
 
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
 	ut_assertnonnull(scmi_devices);
-	scmi_ctx = sandbox_scmi_service_ctx();
-	ut_assertnonnull(scmi_ctx);
-	agent = scmi_ctx->agent;
-	ut_assertnonnull(agent);
 
 	/* Test SCMI resect controller manipulation */
 	ut_assert(!agent->reset[0].asserted);
@@ -201,21 +182,16 @@ DM_TEST(dm_test_scmi_resets, UT_TESTF_SCAN_FDT);
 
 static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 {
-	struct sandbox_scmi_devices *scmi_devices;
-	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
+	struct sandbox_scmi_devices *scmi_devices;
 	struct dm_regulator_uclass_plat *uc_pdata;
 	struct udevice *dev;
 	struct udevice *regul0_dev;
 
-	ut_assertok(load_sandbox_scmi_test_devices(uts, &dev));
+	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
 
 	scmi_devices = sandbox_scmi_devices_ctx(dev);
 	ut_assertnonnull(scmi_devices);
-	scmi_ctx = sandbox_scmi_service_ctx();
-	ut_assertnonnull(scmi_ctx);
-	agent = scmi_ctx->agent;
-	ut_assertnonnull(agent);
 
 	/* Set/Get an SCMI voltage domain level */
 	regul0_dev = scmi_devices->regul[0];
-- 
2.34.1

