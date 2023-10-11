Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35772CD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7540A86E22;
	Wed, 11 Oct 2023 12:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zx8WNuEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162C586D77; Wed, 11 Oct 2023 12:08:10 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E9F86D1D
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ae0df6494bso972420b6e.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018873; x=1697623673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nj98gsJlcxoLzaXSFIprsnNSBVTV3jRN9vqJRZp6D0=;
 b=Zx8WNuEaHST98fTpwMmHaKZ6CJEmGbT/YSk6ovqEdoIKrztJWXbLvi7gVxzEYNfK5U
 lzTtS8Wuf4FTr5zaPPOOf94qU3hQCuBhjX+trfDJ5UWbcFZLg+c+EOEPRVG9jkADz602
 ps1E3FplGetCaE3cWt7omQgFIIqhzFqmLs3p8iEJFMA9AqiggXeLNouQByo0IXk1yzNc
 MpesMkRodOdHeKjX98E7JriYu4Rx/ohkiXkJHmv6N0C7UyN7ogpj4yqEo//eeauo94dy
 OGcWV2TA/PTEVxTJo50x3L1Y7f0FibIiUjSb59sswZsXvS4+pn68Blw/YyRVLs58Lnnl
 +Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018873; x=1697623673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nj98gsJlcxoLzaXSFIprsnNSBVTV3jRN9vqJRZp6D0=;
 b=gYfBHraFth9D1IXxyjF0l61y6pLu3crVR/Y9YIpX8rnjzULYRh2PZV7SoXVwP64iaI
 dqdFPkuz8y3gNWdyHvlQaDZcW7tj1I5rSdNVvTf3gdd8jdhRUqyFhWW8mMYkaQQVTcp8
 xABs1bSZSVG2UPCeThsHYR/Crv+8ub1L+opOBCoaBgMHUwXXhrkORPHlZcJxBWfXHfQw
 f8RGrRWsn8qlxNk93FprEVzhsLeNTXRSbv14UwyOmJVCD5q9aHMSZqJnG0rhcQ3SqKPt
 ZdVphGdQhCnkOB/DRVuIaCa+yjAltD4NhZgRquaLZZt7fJo6SYAbM04NOrRMR59OWZv8
 5uPg==
X-Gm-Message-State: AOJu0YwDu4Y4roSg2igjS70h3++Klz0ChAXmq/kUqp1XdEy7GvSUFAND
 5LncperAsGt57YUnTWcBjil+GQ==
X-Google-Smtp-Source: AGHT+IGl1zWlO0ap+OZXwdWdBVfUNyQNbA2CR0vFe7gDDGyQCH8/arFS9QmfKzToitYS2AYyrF3xIA==
X-Received: by 2002:a05:6358:2d94:b0:163:e0a:68a4 with SMTP id
 m20-20020a0563582d9400b001630e0a68a4mr13694548rwn.2.1697018873277; 
 Wed, 11 Oct 2023 03:07:53 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:52 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 13/14] test: dm: add SCMI base protocol test
Date: Wed, 11 Oct 2023 19:07:06 +0900
Message-Id: <20231011100707.1007417-14-takahiro.akashi@linaro.org>
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

Added is a new unit test for SCMI base protocol, which will exercise all
the commands provided by the protocol, except SCMI_BASE_NOTIFY_ERRORS.
  $ ut dm scmi_base
It is assumed that test.dtb is used as sandbox's device tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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
 test/dm/scmi.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index a7d05f66b753..d4ff60e00069 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -17,6 +17,7 @@
 #include <dm.h>
 #include <reset.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
@@ -97,6 +98,114 @@ static int dm_test_scmi_sandbox_agent(struct unit_test_state *uts)
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

