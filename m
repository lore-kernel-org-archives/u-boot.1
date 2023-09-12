Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940B3CA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4511386E64;
	Tue, 12 Sep 2023 08:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Eiwht21O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E358586E59; Tue, 12 Sep 2023 08:21:41 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED17686E4C
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5657ca46a56so637051a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499697; x=1695104497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwSGUibf6VBO3r+2EtN5iDbVW7vzTiS4mZzfrBU6fkY=;
 b=Eiwht21OEr/ayEwa1oqzp4JhyTMUdDy7k+1wc64hiu4DMwxwclNsFmvaJU5X8eRzJd
 kE8EEyJKJAwycTsFtr77/9fudjzwnex/p8+PNp1shWB9lxH7TzI3Og3JHU+jP/g0vN0d
 jFGOXc6rg11Vwrxu40nUiBcjkdofLL5f5WIlcZyCUkCHumkgPCRsgrY2DJR9KqUegb3L
 yci73O+irfpKH/0YjJMcbvfpJMB9/suhbGNnwEbPDm77KCYwNhCaT0pN6FDS3fCTI5fi
 OG2rskuWt3P08fUSnIZdY90t4aUQhxtdoCQ2CFbqvDVBa2Yxk+8KDAeRu2e6EibXW9EP
 dtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499697; x=1695104497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwSGUibf6VBO3r+2EtN5iDbVW7vzTiS4mZzfrBU6fkY=;
 b=f+UbGvU6EWH65Aq3xE2T68+RHou3ejQGd0F0kJT3l/4DDmw+1AQvj5U64El7PT8i5G
 a2pCaRNA2VH1pWJyWK2n/1UvYn+P5MjJy4EAjG5jtRTPT4NxHVhVHhzvcGuXuyJmD0BI
 YrLtgLVVZJ715rm9NvH7nzsvmOOfMaej68gZMtJxDO1wk+vhKWI6vEuAw4C0IYwAftOJ
 h6oPxNthOb1xHeNCzjM+HRDBojWhDmYltOpoXfwcwz7skiXzolfwNTEUt0hKppoGpf82
 HAbjuBno9wcO8A5MFjoexKbUOOWOfHFh3VAenvyUaxg2nNOz2BHW4fiuMrebF3CkOs10
 WP2Q==
X-Gm-Message-State: AOJu0YxZmedVrH2qejo3aJXngSCj47Tp9pZZDvi5da3aaGD851jjIDpu
 mQf3GY7XTGJs+Sb92o2B0Gq18g==
X-Google-Smtp-Source: AGHT+IGWQmFUhU8aMMwuGVFRISsw8G1F0B94dKxylzwQd5iAQzxJZJ3u5woXFONr7QVJm16y1NyN1Q==
X-Received: by 2002:a05:6a21:a587:b0:123:3ec2:360d with SMTP id
 gd7-20020a056a21a58700b001233ec2360dmr16666778pzc.5.1694499697378; 
 Mon, 11 Sep 2023 23:21:37 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:36 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 10/13] test: dm: add SCMI base protocol test
Date: Tue, 12 Sep 2023 15:19:59 +0900
Message-Id: <20230912062002.57361-11-takahiro.akashi@linaro.org>
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

Added is a new unit test for SCMI base protocol, which will exercise all
the commands provided by the protocol, except SCMI_BASE_NOTIFY_ERRORS.
  $ ut dm scmi_base
It is assumed that test.dtb is used as sandbox's device tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v4
* fix a typo fix in v3
  s/scmi_protocol_message_attrs/scmi_base_protocol_message_attrs/
v3
* typo: s/scmi_base_protocol_attrs/scmi_base_protocol_message_attrs/
* modify the code for dynamically allocated vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 test/dm/scmi.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 881be3171b7c..48610299c1a1 100644
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
@@ -95,6 +98,114 @@ static int dm_test_scmi_sandbox_agent(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_scmi_sandbox_agent, UT_TESTF_SCAN_FDT);
 
+static int dm_test_scmi_base(struct unit_test_state *uts)
+{
+	struct udevice *agent_dev, *base;
+	struct scmi_agent_priv *priv;
+	u32 version, num_agents, num_protocols, impl_version;
+	u32 attributes, agent_id;
+	u8 *vendor, *agent_name, *protocols;
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
+	ret = scmi_base_protocol_message_attrs(base,
+					       SCMI_BASE_DISCOVER_SUB_VENDOR,
+					       &attributes);
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

