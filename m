Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383F2CD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B3A86DFA;
	Wed, 11 Oct 2023 12:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xLNvnnHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE9686DC4; Wed, 11 Oct 2023 12:08:07 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDCD486CFF
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-690d935dbc2so1301805b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018867; x=1697623667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rakCvDE9tZqz9G3HX+dIGiG+qRW5YupxXYivPaan/vA=;
 b=xLNvnnHBL0h932MeqjKZxVpXDpqnLzEw/YHEXmqUuJvxawHuuxS9Hs8ErB3ipoUXxP
 YSm7DwkqAIlyFLYDDwf6WLQicw4DdjsErNAGfT7FuG5rlXn+6hPD3oZcGdkqQLUOk3we
 8YKQm+7bUFJV4k+lalEENopP+Cz38rt+x4VaINRoEfxdjSu2bmYgtfRscNhyAsqzbHDl
 LCd+SFCjsZG087rN6WLFl/5KKEK6/VSJY1dgwwRnYb2GehmdWgJRD8nQKvNZlEKg5J6H
 pZ+K4Q2ZQJsw25VQNIHZ9saHa7Bc5RqUtGXijeGQ4pHRLm4ycyqeZ5+H02OJaJaRsi61
 Vksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018867; x=1697623667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rakCvDE9tZqz9G3HX+dIGiG+qRW5YupxXYivPaan/vA=;
 b=lBWt+eeJDfRYI5QH7R+M+e/0MJFsbUkdXLiFUJaC1qDyceq6ylQL2srTBLPlBl1Wwi
 ljUYCBHTW/CKyfbK+UvQAiKH48M1z13eipXufjPVoWqQ1BqAJSd40rRiLu3qB76PY7wF
 ZsW/yAVCS7p+CQLk2Ii6nKqmr+H2rR+mv48AVWaJC/2KnUzbRPMrmOpnx+tON6LXQkSa
 VCOtXvke9o9oa3MlM+E8EN0bss1u/r+mHsJuiDQ7WHKUz3hwC93KoqjvL9rGfPHI9bk8
 cB7bsxG3lCif4tl7BQOnlXVwQryBY/l00m1lwQWJx+tXGaX2aXbv4r0QT5dQQgtQAtNJ
 792Q==
X-Gm-Message-State: AOJu0YwqDrYKn0AL1B0E/DrUxwIBoQq/83TTYz1dNUPW8HYJeN4nNpM3
 RYe94A7l4fyBDmyR5/07/0Uojw==
X-Google-Smtp-Source: AGHT+IHrPF8QmFkBuhJWLD8GKF070E26q6KNYFxYcIOtgv6QQEGYkPN1yqZnC0SaGeYYgnMX+G/vHg==
X-Received: by 2002:a05:6a00:2d1b:b0:68e:3eff:e93a with SMTP id
 fa27-20020a056a002d1b00b0068e3effe93amr22233685pfb.2.1697018866594; 
 Wed, 11 Oct 2023 03:07:46 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:46 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 10/14] test: dm: simplify SCMI unit test on sandbox
Date: Wed, 11 Oct 2023 19:07:03 +0900
Message-Id: <20231011100707.1007417-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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
v4
* move this patch forward in this series before installing base
  protocol to avoid collapsing existing SCMI test.
---
 arch/sandbox/include/asm/scmi_test.h       |  6 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c | 20 +------
 test/dm/scmi.c                             | 64 +++++++---------------
 3 files changed, 26 insertions(+), 64 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 75cb462a5584..ccb0df6c148f 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -98,9 +98,11 @@ unsigned int sandbox_scmi_channel_id(struct udevice *dev);
 
 /**
  * sandbox_scmi_service_ctx - Get the simulated SCMI services context
+ * sandbox_scmi_agent_ctx - Get the simulated SCMI agent context
+ * @dev:	Reference to the test agent
  * @return:	Reference to backend simulated resources state
  */
-struct sandbox_scmi_service *sandbox_scmi_service_ctx(void);
+struct sandbox_scmi_agent *sandbox_scmi_agent_ctx(struct udevice *dev);
 
 /**
  * sandbox_scmi_devices_ctx - Get references to devices accessed through SCMI
@@ -114,7 +116,7 @@ inline unsigned int sandbox_scmi_channel_id(struct udevice *dev);
 	return 0;
 }
 
-static inline struct sandbox_scmi_service *sandbox_scmi_service_ctx(void)
+static struct sandbox_scmi_agent *sandbox_scmi_agent_ctx(struct udevice *dev)
 {
 	return NULL;
 }
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 716bbf97d5c9..eb567dd900d7 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -86,11 +86,9 @@ static struct sandbox_scmi_voltd scmi_voltd[] = {
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
@@ -985,16 +983,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 
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
 
@@ -1002,9 +992,6 @@ static int sandbox_scmi_test_probe(struct udevice *dev)
 {
 	struct sandbox_scmi_agent *agent = dev_get_priv(dev);
 
-	if (sandbox_scmi_service_ctx()->agent)
-		return -EINVAL;
-
 	*agent = (struct sandbox_scmi_agent){
 		.clk = scmi_clk,
 		.clk_count = ARRAY_SIZE(scmi_clk),
@@ -1016,9 +1003,6 @@ static int sandbox_scmi_test_probe(struct udevice *dev)
 
 	debug_print_agent_state(dev, "probed");
 
-	/* Save reference for tests purpose */
-	sandbox_scmi_service_ctx()->agent = agent;
-
 	return 0;
 };
 
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 8db3ad32f85e..a7d05f66b753 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -25,22 +25,11 @@
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
@@ -50,10 +39,6 @@ static int ut_assert_scmi_state_postprobe(struct unit_test_state *uts,
 	ut_asserteq(2, scmi_devices->regul_count);
 
 	/* State of the simulated SCMI server exposed */
-	scmi_ctx = sandbox_scmi_service_ctx();
-	ut_assertnonnull(scmi_ctx);
-	agent = scmi_ctx->agent;
-	ut_assertnonnull(agent);
 	ut_asserteq(3, agent->clk_count);
 	ut_assertnonnull(agent->clk);
 	ut_asserteq(1, agent->reset_count);
@@ -65,27 +50,32 @@ static int ut_assert_scmi_state_postprobe(struct unit_test_state *uts,
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
 
+	*ctx = sandbox_scmi_agent_ctx(agent_dev);
+	ut_assertnonnull(*ctx);
+
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
 
@@ -95,10 +85,11 @@ static int release_sandbox_scmi_test_devices(struct unit_test_state *uts,
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
 
@@ -108,23 +99,18 @@ DM_TEST(dm_test_scmi_sandbox_agent, UT_TESTF_SCAN_FDT);
 
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
-	struct sandbox_scmi_devices *scmi_devices;
-	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
+	struct sandbox_scmi_devices *scmi_devices;
 	struct udevice *agent_dev, *clock_dev, *dev;
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
 
 	/* Sandbox SCMI clock protocol has its own channel */
 	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
@@ -179,22 +165,17 @@ DM_TEST(dm_test_scmi_clocks, UT_TESTF_SCAN_FDT);
 
 static int dm_test_scmi_resets(struct unit_test_state *uts)
 {
-	struct sandbox_scmi_devices *scmi_devices;
-	struct sandbox_scmi_service *scmi_ctx;
 	struct sandbox_scmi_agent *agent;
+	struct sandbox_scmi_devices *scmi_devices;
 	struct udevice *agent_dev, *reset_dev, *dev = NULL;
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
 
 	/* Sandbox SCMI reset protocol doesn't have its own channel */
 	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
@@ -219,21 +200,16 @@ DM_TEST(dm_test_scmi_resets, UT_TESTF_SCAN_FDT);
 
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

