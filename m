Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFBEEB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C9986A33;
	Fri,  8 Sep 2023 04:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CNrwkF4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBE686A2B; Fri,  8 Sep 2023 04:52:41 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F1686A2F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf11a7cf9fso3029725ad.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141557; x=1694746357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIaAJycgoZjI+6NxJ0ZDkEzIUsAQGu51dDrbUXEUrF4=;
 b=CNrwkF4S4iveHU7B3CpVTGe9uSx8po8nkGjwUoGPxfEZ6PwV4sinCtsEj3/rpz47ae
 KErDpKKH6DkHh00LBYQ6oTMKJg05hbjB0JU94I+BZkRtT21Mq41uhHVzVfKMWfmbLuMB
 MlRVeE3EvsgnUpsh1oW0cFI298hddy+3Vik5QyEYvDf9VDeDnSGmK6dZnIxaV1fQ41Rs
 CgHeoteiwxgyhxWnB7gfofrNf/n/7yHC4tocpG9nI7fxtydubtJyJ1v8tWlcNsJqX83m
 aM3DXiyy7497s3GDR5fNNGZwP6yaknUsW5Bfr9uLMrj10dWxdNGu7xouZahZmIA30PMx
 cMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141557; x=1694746357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIaAJycgoZjI+6NxJ0ZDkEzIUsAQGu51dDrbUXEUrF4=;
 b=dLqIpjoooVbDwB95ggu7D32kxXEoUZkyOYNmk6YV+mvcebXE2miybRSp5qTg5oPhJh
 EFC2AYBcbrUQb2p9YYKUV1POYwSoDjBKdWsDtMEJIWvFG9TDaKQIdDLr4wu7sL/zhv+J
 J3naIzeWhJ5ZIAxkIb0gq7DkBDMFRkL2IDW6tntPVW/KrYTB3H0I/U7sUfZMLyCwS5UC
 L8XrWPMLVzOynEn9jH83inY8wobMp9vk3ta0DlQg5HVa4MFpOMSdmXHRZ3zdioy7VjwF
 vA5UfGh/meMnDb61BEvQOiSdOIR9nUkriATKcBZCg1m1/8TNkLm2lZZreZ29TmNoMUjz
 jZvg==
X-Gm-Message-State: AOJu0YyFC/CRp9KKvb2xvH4espBSyoo4oPY1EuRDxm87+7wwT0/5hVJV
 BNmXU5XwsrW9e8vPQGsm+7XMcCYvryLTKJpKvatkAA==
X-Google-Smtp-Source: AGHT+IH8HqqSpvOiKPD3DmjOo4HmOHoAXktbU9D1UILI4P1AiHZwTp0R1yfM2qpeM8Oom/wp3wnfdg==
X-Received: by 2002:a17:902:e849:b0:1bb:83ec:832 with SMTP id
 t9-20020a170902e84900b001bb83ec0832mr1528338plg.2.1694141556695; 
 Thu, 07 Sep 2023 19:52:36 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:36 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 10/13] test: dm: add SCMI base protocol test
Date: Fri,  8 Sep 2023 11:51:35 +0900
Message-Id: <20230908025138.44405-11-takahiro.akashi@linaro.org>
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

Added is a new unit test for SCMI base protocol, which will exercise all
the commands provided by the protocol, except SCMI_BASE_NOTIFY_ERRORS.
  $ ut dm scmi_base
It is assumed that test.dtb is used as sandbox's device tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v3
* typo: s/scmi_base_protocol_attrs/scmi_base_protocol_message_attrs/
* modify the code for dynamically allocated vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 test/dm/scmi.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 881be3171b7c..0785948186f0 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -16,6 +16,9 @@
 #include <clk.h>
 #include <dm.h>
 #include <reset.h>
+#include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
+#include <scmi_protocols.h>
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
@@ -95,6 +98,115 @@ static int dm_test_scmi_sandbox_agent(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_scmi_sandbox_agent, UT_TESTF_SCAN_FDT);
 
+static int dm_test_scmi_base(struct unit_test_state *uts)
+{
+	struct udevice *agent_dev, *base;
+	struct scmi_agent_priv *priv;
+	u32 version, num_agents, num_protocols, impl_version;
+	u32 attributes, agent_id;
+	char *vendor, *agent_name;
+	u8 *protocols;
+	int ret;
+
+	/* preparation */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+	ut_assertnonnull(priv = dev_get_uclass_plat(agent_dev));
+	ut_assertnonnull(base = scmi_get_protocol(agent_dev,
+						  SCMI_PROTOCOL_ID_BASE));
+
+	/* version */
+	ret = scmi_base_protocol_version(base, &version);
+	ut_assertok(ret);
+	ut_asserteq(priv->version, version);
+
+	/* protocol attributes */
+	ret = scmi_base_protocol_attrs(base, &num_agents, &num_protocols);
+	ut_assertok(ret);
+	ut_asserteq(priv->num_agents, num_agents);
+	ut_asserteq(priv->num_protocols, num_protocols);
+
+	/* discover vendor */
+	ret = scmi_base_discover_vendor(base, &vendor);
+	ut_assertok(ret);
+	ut_asserteq_str(priv->vendor, vendor);
+	free(vendor);
+
+	/* message attributes */
+	ret = scmi_protocol_message_attrs(base,
+					  SCMI_BASE_DISCOVER_SUB_VENDOR,
+					  &attributes);
+	ut_assertok(ret);
+	ut_assertok(attributes);
+
+	/* discover sub vendor */
+	ret = scmi_base_discover_sub_vendor(base, &vendor);
+	ut_assertok(ret);
+	ut_asserteq_str(priv->sub_vendor, vendor);
+	free(vendor);
+
+	/* impl version */
+	ret = scmi_base_discover_impl_version(base, &impl_version);
+	ut_assertok(ret);
+	ut_asserteq(priv->impl_version, impl_version);
+
+	/* discover agent (my self) */
+	ret = scmi_base_discover_agent(base, 0xffffffff, &agent_id,
+				       &agent_name);
+	ut_assertok(ret);
+	ut_asserteq(priv->agent_id, agent_id);
+	ut_asserteq_str(priv->agent_name, agent_name);
+	free(agent_name);
+
+	/* discover protocols */
+	ret = scmi_base_discover_list_protocols(base, &protocols);
+	ut_asserteq(num_protocols, ret);
+	ut_asserteq_mem(priv->protocols, protocols, sizeof(u8) * num_protocols);
+	free(protocols);
+
+	/*
+	 * NOTE: Sandbox SCMI driver handles device-0 only. It supports setting
+	 * access and protocol permissions, but doesn't allow unsetting them nor
+	 * resetting the configurations.
+	 */
+	/* set device permissions */
+	ret = scmi_base_set_device_permissions(base, agent_id, 0,
+					       SCMI_BASE_SET_DEVICE_PERMISSIONS_ACCESS);
+	ut_assertok(ret); /* SCMI_SUCCESS */
+	ret = scmi_base_set_device_permissions(base, agent_id, 1,
+					       SCMI_BASE_SET_DEVICE_PERMISSIONS_ACCESS);
+	ut_asserteq(-ENOENT, ret); /* SCMI_NOT_FOUND */
+	ret = scmi_base_set_device_permissions(base, agent_id, 0, 0);
+	ut_asserteq(-EACCES, ret); /* SCMI_DENIED */
+
+	/* set protocol permissions */
+	ret = scmi_base_set_protocol_permissions(base, agent_id, 0,
+						 SCMI_PROTOCOL_ID_CLOCK,
+						 SCMI_BASE_SET_PROTOCOL_PERMISSIONS_ACCESS);
+	ut_assertok(ret); /* SCMI_SUCCESS */
+	ret = scmi_base_set_protocol_permissions(base, agent_id, 1,
+						 SCMI_PROTOCOL_ID_CLOCK,
+						 SCMI_BASE_SET_PROTOCOL_PERMISSIONS_ACCESS);
+	ut_asserteq(-ENOENT, ret); /* SCMI_NOT_FOUND */
+	ret = scmi_base_set_protocol_permissions(base, agent_id, 0,
+						 SCMI_PROTOCOL_ID_CLOCK, 0);
+	ut_asserteq(-EACCES, ret); /* SCMI_DENIED */
+
+	/* reset agent configuration */
+	ret = scmi_base_reset_agent_configuration(base, agent_id, 0);
+	ut_asserteq(-EACCES, ret); /* SCMI_DENIED */
+	ret = scmi_base_reset_agent_configuration(base, agent_id,
+						  SCMI_BASE_RESET_ALL_ACCESS_PERMISSIONS);
+	ut_asserteq(-EACCES, ret); /* SCMI_DENIED */
+	ret = scmi_base_reset_agent_configuration(base, agent_id, 0);
+	ut_asserteq(-EACCES, ret); /* SCMI_DENIED */
+
+	return 0;
+}
+
+DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
+
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
 	struct sandbox_scmi_agent *agent;
-- 
2.34.1

