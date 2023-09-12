Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873BDCA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08D186E49;
	Tue, 12 Sep 2023 08:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T2YbeHTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C5A86E41; Tue, 12 Sep 2023 08:21:35 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8449386E46
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c39500767aso7950315ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499690; x=1695104490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp60XCjde0FMeobwFAGuW5n67iFjwV0y7hf8SXDVWD8=;
 b=T2YbeHTNz00TetuO0Wf/oQvw5BLvdfT75qtM1bSRsizEGmIOSoDz3t7GoOapeYOGNM
 A79fp7hQ0g9tT/fwYfpAeAK17tT2x3QRiu7s7RGcGibTHSc71V3di9gRc/IKjWa2GCTY
 0MJKpFJo+hJzXq72CQEM2BrL4/yVYc3oCAjl9+UYaSH/7XzzE/A3uXz6gN94UKjZnfjA
 jPsFua3vI8dXICH99U/1k0ySQkANfaYE0u7OHELqsSqw4mGB2AH0G3ZD+ZAY6PczlWnt
 tz6eQfW/gXuCopnvpB7Xa0zhZm9h9cklQswed6Z7etf9lbKVHnoDYXWnrHHyC/nTEdIR
 2YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499690; x=1695104490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp60XCjde0FMeobwFAGuW5n67iFjwV0y7hf8SXDVWD8=;
 b=lZv/TS55F1xUwcsIEen3TGF1AGNibG5TqH/Us6QYUh8lE1SiBJ5mXZZGGJlrpfxvAE
 nDQKZU9DJHstThNj94V9iMP93KAmljA/izaTcHdWfifzsUkx8Vro5Kx9dnXf2M8sByUQ
 /4tLaVcKQD8l57zocR/eI0IEzr3IPIAAA4+SQuq0EESwfEhVJjv3JvIZPFI+kxlAk22L
 s2amH8Ezb2TrqANKgA8P1KUgWmftE4YEdmLDttqp3hggy+3sZ+F0LKnbV7nh4CI3fmij
 KC2EKvY5zdjrjRPsCWy1Tv5TBX3kHsvkbjVRNgo74E0EIKwXhC/ZsMbxvUdqzxf4Q8Fq
 W5iQ==
X-Gm-Message-State: AOJu0YxZFxl0T/EAOgx4I6bJEq0+tvH1B2CFa32EYoTqY366pKnN2GeH
 EevNJf3wdhIk+fMrl7E7cuUDLA==
X-Google-Smtp-Source: AGHT+IErBjY2gevJSCZ6zPMMNU2VgB8m07Y3dSNdq5tXSnpzzNkkJia0lCxVbzhl5eot9RcyAvk0Jw==
X-Received: by 2002:a17:903:2448:b0:1bf:1a9e:85f7 with SMTP id
 l8-20020a170903244800b001bf1a9e85f7mr13145808pls.1.1694499689755; 
 Mon, 11 Sep 2023 23:21:29 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:29 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 06/13] test: dm: simplify SCMI unit test on sandbox
Date: Tue, 12 Sep 2023 15:19:55 +0900
Message-Id: <20230912062002.57361-7-takahiro.akashi@linaro.org>
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
 arch/sandbox/include/asm/scmi_test.h       |  7 ++-
 drivers/firmware/scmi/sandbox-scmi_agent.c | 20 +------
 test/dm/scmi.c                             | 64 +++++++---------------
 3 files changed, 26 insertions(+), 65 deletions(-)

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

