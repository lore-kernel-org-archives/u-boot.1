Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F067E7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67EB86D09;
	Tue, 26 Sep 2023 08:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SAvaK/tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7847986D42; Tue, 26 Sep 2023 08:58:34 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE56F86D47
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ae473c0bd6so399743b6e.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711510; x=1696316310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rkVWVPg//wDy6E/QDf0dDFeyFNwMuQ2Qpw4+CUtJYE=;
 b=SAvaK/tpTDfQKj8yghXrn0WV6o7olZ0HhvvYOwTVC0N0lTChCQNavxCKIBjKgjNybM
 l443OUzsOW6Mlzv+ZpqIuStqG1QG0t6PAbwTUrLCERDR4XtHA3UZ819KsP1vz2v/RCwC
 ouzPhJiYMbvcfiSA9vaHsVG2q2bfleu7wD9NeglsbkgxKgz8Oh7Gxw2Crpe923WOZLGe
 FFmuto276xpvBmf0r7hATUBbeQJCBdY5nrK19GmP4PFU3N7NUgiP36t1bOv3NYxNIRuT
 MD0nzh/l0hdBCAxr37TPaRPM9bRhzC6OOYI3kP+l6vbSsGMVpNUKbv1Yw1TbckuMc5qg
 IWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711510; x=1696316310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rkVWVPg//wDy6E/QDf0dDFeyFNwMuQ2Qpw4+CUtJYE=;
 b=ewe0eV6HQksy0Pqghs+mryAbXHOijb9NeHEj33kz/ys3YU39l8OP4crZgp7/aBtIQr
 AYFuCo+EYwDFVZ92SXmckaG5Om6Sve8Ex0wqUWL6txmo79TEXTekiTUAZ3KH1tQjib7D
 X2UMll9pRixDHx3oy/2dP5wshlw6TC0tEXatk19YQavGkYGC/2BBydqVToQkJdEwYbiD
 CNAIFSmBoaYz8UArDmqy+z5Q3t8rMGasV6C4FhUnfnW7m9zAj/QfHu2Xs9Pfiv05wbEb
 36K+Rbjd8/cVB1eMYV1yQBQu5fEMkBO7m+zrER8IS+wMLTkYaQQeQErXUmqiCreRIp/Z
 yqTA==
X-Gm-Message-State: AOJu0YygrKpqdtDOO5kgS0wLGZ2BNIHi+gYKxiKwsccEO73Vr3sBLiSG
 NH4vziJrdSVfyqYxfLOj5EJdTQ==
X-Google-Smtp-Source: AGHT+IHmAz9chuPgkS5znFuTXsy9aS7OSOSAqnzKtaG23WkgT8IcRbh3rzdyze8/n+WNjKGNimolww==
X-Received: by 2002:a9d:7f83:0:b0:6b9:d3bd:3985 with SMTP id
 t3-20020a9d7f83000000b006b9d3bd3985mr8840578otp.1.1695711510530; 
 Mon, 25 Sep 2023 23:58:30 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:30 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 09/16] test: dm: simplify SCMI unit test on sandbox
Date: Tue, 26 Sep 2023 15:57:43 +0900
Message-Id: <20230926065750.734440-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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
index e4fb1bc635cb..913b6aba96ba 100644
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
@@ -177,22 +163,17 @@ DM_TEST(dm_test_scmi_clocks, UT_TESTF_SCAN_FDT);
 
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
@@ -217,21 +198,16 @@ DM_TEST(dm_test_scmi_resets, UT_TESTF_SCAN_FDT);
 
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

