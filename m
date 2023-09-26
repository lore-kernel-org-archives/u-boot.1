Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA835E7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9139986D91;
	Tue, 26 Sep 2023 09:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FJUfO+LJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3267A86D9D; Tue, 26 Sep 2023 09:01:15 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7E486D88
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-277317a0528so931534a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711671; x=1696316471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwSwJEm2Sraaao7ArVGRtZyaqBvdJEcgFr5He7VTZEY=;
 b=FJUfO+LJoXMd9S9/BugPTixuObU5CuzztPPUg5as8lNgGv4h5dzAMNOuumXF3RB71t
 AcTh4QD04DoR8HKQMFqKrm+xoCPip9YB5MjNC4IEUKoH2ASvGWdK7bjT43Y1SQqyML+Q
 cc5MxrZM/x26/k0kZtZegsS32oa7KRb+MjXkCKiBAxd9fgbrqq0JmJ3mYEBUMOzX66XR
 yAMktLhFGpYrILpUUL6p97kL50y+po4OeLB6S4DzA9gAkGQLbNMxFiTgUUhtA1x8sJ0c
 Ikc7/kBmPn2Nad5ByYIJGfR5taEiRhBhpSLpezswm/ZgBFONGb6W/EoIVIDFN3z20R+q
 2KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711671; x=1696316471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwSwJEm2Sraaao7ArVGRtZyaqBvdJEcgFr5He7VTZEY=;
 b=jPeFHlMKaMewafXgDuM+IEe/odkGO5PzjN6R/gfFT7nDp+qiKY2XXDA1NZ/zb6GCeq
 uG8JaAthLYKUrkI3VZFNLPjNttNdbLTMpBHdl1sxZ0kq9tOF+AAnC7FAvOVYUTaIsPVf
 LdcZLuNrvdgZxHWcttyYklD+hHdCAVklUqi0BEVQOahIc+j4cWJhCP36iLLbLrttzkqh
 b26drOIVhCVxSmt8s6CB5s4/uAQKE4DB6HspwWJ4nYI19JuzJeOe5/vYJOW41M7fAczt
 XXftRxsCfoOv3emMN5JD1+6pIR5+s90byXmu6GDm6JeY/046nzRclqpdSnzcZz1W96+3
 h4mQ==
X-Gm-Message-State: AOJu0YzJ939FuFtz062395wpqUmZG6jOreXIMRg2WOKyAlDY1Q39Hf+d
 MDcUFtwpwC7fLSUkk0iP0E/xTQ==
X-Google-Smtp-Source: AGHT+IHxkHUPfw/UDDBxEZFJgaKSUWO2LfpTB6aQFVNxk7/jCMjTkahRof89vyIdeLJYbiivfVehzA==
X-Received: by 2002:a17:90a:d503:b0:277:2566:7ad7 with SMTP id
 t3-20020a17090ad50300b0027725667ad7mr7379180pju.0.1695711671242; 
 Tue, 26 Sep 2023 00:01:11 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0027758c7f585sm3178480pjb.52.2023.09.26.00.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 00:01:10 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 4/4] test: dm: add SCMI power domain protocol test
Date: Tue, 26 Sep 2023 16:00:43 +0900
Message-Id: <20230926070043.738340-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926070043.738340-1-takahiro.akashi@linaro.org>
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
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

This ut has tests for the SCMI power domain protocol as well as DM
interfaces for power domain devices.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 test/dm/scmi.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 949e49bd2c35..c2625373d84e 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -15,6 +15,7 @@
 #include <common.h>
 #include <clk.h>
 #include <dm.h>
+#include <malloc.h>
 #include <reset.h>
 #include <scmi_agent.h>
 #include <scmi_agent-uclass.h>
@@ -223,7 +224,8 @@ static int dm_test_scmi_cmd(struct unit_test_state *uts)
 	ut_assert_nextline("  # of agents: 2");
 	ut_assert_nextline("      0: platform");
 	ut_assert_nextline("    > 1: OSPM");
-	ut_assert_nextline("  # of protocols: 3");
+	ut_assert_nextline("  # of protocols: 4");
+	ut_assert_nextline("      Power domain management");
 	ut_assert_nextline("      Clock management");
 	ut_assert_nextline("      Reset domain management");
 	ut_assert_nextline("      Voltage domain management");
@@ -259,6 +261,109 @@ static int dm_test_scmi_cmd(struct unit_test_state *uts)
 
 DM_TEST(dm_test_scmi_cmd, UT_TESTF_SCAN_FDT);
 
+static int dm_test_scmi_power_domains(struct unit_test_state *uts)
+{
+	struct sandbox_scmi_agent *agent;
+	struct sandbox_scmi_devices *scmi_devices;
+	struct udevice *agent_dev, *pwd, *dev;
+	u32 version, count, attributes, pstate;
+	u64 stats_addr;
+	size_t stats_len;
+	u8 *name;
+	int ret;
+
+	/* preparation */
+	ut_assertok(load_sandbox_scmi_test_devices(uts, &agent, &dev));
+	ut_assertnonnull(agent);
+	scmi_devices = sandbox_scmi_devices_ctx(dev);
+	ut_assertnonnull(scmi_devices);
+	ut_asserteq(2, scmi_devices->pwdom->id); /* in test.dts */
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+	pwd = scmi_get_protocol(agent_dev, SCMI_PROTOCOL_ID_POWER_DOMAIN);
+	ut_assertnonnull(pwd);
+
+	/*
+	 * SCMI Power domain management protocol interfaces
+	 */
+	/* version */
+	ret = scmi_generic_protocol_version(pwd, SCMI_PROTOCOL_ID_POWER_DOMAIN,
+					    &version);
+	ut_assertok(ret);
+	ut_asserteq(agent->pwdom_version, version);
+
+	/* protocol attributes */
+	ret = scmi_pwd_protocol_attrs(pwd, &count, &stats_addr, &stats_len);
+	ut_assertok(ret);
+	ut_asserteq(agent->pwdom_count, count);
+	ut_asserteq(0, stats_len);
+
+	/* protocol message attributes */
+	ret = scmi_pwd_protocol_message_attrs(pwd, SCMI_PWD_STATE_SET,
+					      &attributes);
+	ut_assertok(ret);
+	ret = scmi_pwd_protocol_message_attrs(pwd, SCMI_PWD_STATE_NOTIFY,
+					      &attributes);
+	ut_asserteq(-ENOENT, ret); /* the protocol not supported */
+
+	/* power domain attributes */
+	ret = scmi_pwd_attrs(pwd, 0, &attributes, &name);
+	ut_assertok(ret);
+	ut_asserteq_str("power-domain--0", name);
+	free(name);
+
+	ret = scmi_pwd_attrs(pwd, 10, &attributes, &name);
+	ut_asserteq(-ENOENT, ret); /* domain-10 doesn't exist */
+
+	/* power domain state set/get */
+	ret = scmi_pwd_state_set(pwd, 0, 0, 0);
+	ut_assertok(ret);
+	ret = scmi_pwd_state_get(pwd, 0, &pstate);
+	ut_assertok(ret);
+	ut_asserteq(0, pstate); /* ON */
+
+	ret = scmi_pwd_state_set(pwd, 0, 0, SCMI_PWD_PSTATE_TYPE_LOST);
+	ut_assertok(ret);
+	ret = scmi_pwd_state_get(pwd, 0, &pstate);
+	ut_assertok(ret);
+	ut_asserteq(SCMI_PWD_PSTATE_TYPE_LOST, pstate); /* OFF */
+
+	ret = scmi_pwd_state_set(pwd, 0, 10, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	/* power domain name get */
+	ret = scmi_pwd_name_get(pwd, 0, &name);
+	ut_assertok(ret);
+	ut_asserteq_str("power-domain--0-extended", name);
+	free(name);
+
+	ret = scmi_pwd_name_get(pwd, 10, &name);
+	ut_asserteq(-ENOENT, ret); /* domain-10 doesn't exist */
+
+	/*
+	 * U-Boot driver model interfaces
+	 */
+	/* power_domain_on */
+	ret = power_domain_on(scmi_devices->pwdom);
+	ut_assertok(ret);
+	ret = scmi_pwd_state_get(pwd, scmi_devices->pwdom->id, &pstate);
+	ut_assertok(ret);
+	ut_asserteq(0, pstate); /* ON */
+
+	/* power_domain_off */
+	ret = power_domain_off(scmi_devices->pwdom);
+	ut_assertok(ret);
+	ret = scmi_pwd_state_get(pwd, scmi_devices->pwdom->id, &pstate);
+	ut_assertok(ret);
+	ut_asserteq(SCMI_PWD_PSTATE_TYPE_LOST, pstate); /* OFF */
+
+	return release_sandbox_scmi_test_devices(uts, dev);
+}
+
+DM_TEST(dm_test_scmi_power_domains, UT_TESTF_SCAN_FDT);
+
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
 	struct sandbox_scmi_agent *agent;
-- 
2.34.1

