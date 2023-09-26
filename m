Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6FAE7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6967286D67;
	Tue, 26 Sep 2023 08:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P5aPk6Uk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A8786D4C; Tue, 26 Sep 2023 08:58:44 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A58886C00
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1dd26c41fc8so361383fac.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711520; x=1696316320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79hlaO5yMrun8ZQmi4+Nlo82zoh8/1PuAEZB0NjCPmw=;
 b=P5aPk6UkmcAIAoo/gJwV3B7ApZo4qIHO1TAgQEiUkjsnUknSbnaTJT7HMiwFeqzZDd
 EE5I+4zQeAyjTlbVZXr1eE1RatNgRTh6SU1+uqhZeHJz7FbqvYSnTq8XgdRE53dzSvfs
 GrKXIofmONhClwZFF+WsvGeId3pSpYd+/Iak5NtdT7mQic+o9iCYkPFXf8Hkc4+FBVaj
 5eU0fduw0ehXPA4tBvSP40p6sWdfROjo1QEAL41pfTx6t9BqhAcBpeoDNErBz3qKBYvg
 Il1zGoyAaUbbgPMocY92D8TxuNCZFkfL88BCDkQ0Z+IZkiX2EZlrunPhwBG7fWe0+xxh
 TA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711520; x=1696316320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79hlaO5yMrun8ZQmi4+Nlo82zoh8/1PuAEZB0NjCPmw=;
 b=k2/GG2sUZLNOUIpwscCEDYejnTRnz/B/Wg+Muvjwb7GlUSzpgwfsbGb8CeUQ9Vszzu
 UzlWohk3xu7hhyhxY/EU6TPpjOGtWK586uJGJpMtMXmybcshYg6ecAZhgPg/c+1699pe
 BaymigqKZ8aM9xUwWDmXqbHCVa5dqLJL/Bq57SaI6lPWMyf9Llb42REeaZ557RrsbQ+c
 90uFTPGTcGlsa/MMyipXP897muRY2smUIM6MaDry3GjwK+xGH9HbaFa2jgI/rmSV1Mez
 vRRWdYFTGapZeQ5iP4hVT8hOB0KIR/6gQUEk6EgOysdcWthrid7J+na6B2qa7u1io4co
 W+3Q==
X-Gm-Message-State: AOJu0Yxy82U7QjTzVcDwwTG25vfiS15yw56kbOy3rMkI+Jo4Kw2xClxc
 uPJ3QnqIO9IfJv+HkYp2F5aLQQ==
X-Google-Smtp-Source: AGHT+IGjb8zOLt3SjPUUv2aI1XWGdxbDnRMPpxf7O5JVSntTFWhh5MCXrTHyLvaWOaylSm8ZJy+YHw==
X-Received: by 2002:a05:6359:5a2:b0:13c:b9a8:fe5b with SMTP id
 ee34-20020a05635905a200b0013cb9a8fe5bmr6556810rwb.3.1695711520552; 
 Mon, 25 Sep 2023 23:58:40 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:40 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 13/16] test: dm: add SCMI base protocol test
Date: Tue, 26 Sep 2023 15:57:47 +0900
Message-Id: <20230926065750.734440-14-takahiro.akashi@linaro.org>
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
index 913b6aba96ba..d4ff60e00069 100644
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

