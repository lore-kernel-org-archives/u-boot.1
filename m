Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307EACDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 05:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BEE886C65;
	Mon, 16 Oct 2023 07:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZwzW2AvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770C886958; Mon, 16 Oct 2023 07:40:31 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEF286DA2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 07:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so79158a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 22:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697434812; x=1698039612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0j2SXDyOINzcNZpUi2TReN/FcwaT02Nc3ilNBW+hho=;
 b=ZwzW2AvIbq4nUNn5qAQ5WUT1ynJUjkV8pchJdj8+kkhc23R0MKyPmxa7FQoJ95sL7f
 +Nl/CKuouDdnmR1fLNx7rPc3/vmyjCjqtoOzu0odW6ojNyDLs62FN8FR73sg4LASBSdg
 82hy9yhOYYplnwZj1CFS7nr+fJld8/aCJdJIk/fQ9u6je1HrHODqrhzcY/yUBFC6Yb5u
 5An6dRlc4a1TkRqz0/VmLMqE1NPtKM5hD7ldmOwOpbAr6ymKtCejWjUVyAQhPaHOSuZY
 AMtS1lIyrXmJ033AXalVeDMfb6xainzfFAf6Z/eYAG7/N0xsn4i1/gYlrReXZiWejDaI
 sbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697434812; x=1698039612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0j2SXDyOINzcNZpUi2TReN/FcwaT02Nc3ilNBW+hho=;
 b=j2H7vewduSCvFUbch97dsWyQIUhjtgm6jWuHA7pGWcbb7Spbahba4zRh1iUTqh7uCV
 K2ceMHzclmuLRDCIKzZWGxwauTaRqlBtBlQocYLmIO46xdQ4p7bZ/aygGAeKOg8bkcGF
 +SfopbEY5x5Yl0P+hvpYjsEx2vEDiZ8u/hdV5wNt8AW5HNd8xs/YrAYFQRLO6Eygxn43
 vTp1eHRfNb+4vYcm8dbnL8so7/RaGR+CLQat89hOt5WJrANocigL92k77vA8GUEP12EO
 /F13AJFYWv8LPbTJU1btITpXYUvBaWJUaM0qXDzTy5olnoua9ZZQHLdvIGWKzLkpy+E9
 CFFw==
X-Gm-Message-State: AOJu0Yx+//PpyZhdK/8HGFfghagAU2AYqEJt068qoSUpgZKboCr0hpFk
 jsXpixJkMLT7+RdnCm85DLnRMA==
X-Google-Smtp-Source: AGHT+IF4IhNYtax+xt5iMmmhhXF7c3en2afffWVME1S+OpaBmFAT9U4w5zsr/tfjwpzuC3plxNLmXA==
X-Received: by 2002:a17:90b:4b04:b0:27d:1593:2b08 with SMTP id
 lx4-20020a17090b4b0400b0027d15932b08mr12694459pjb.0.1697434812436; 
 Sun, 15 Oct 2023 22:40:12 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:4c30:a6e6:b316:7d31])
 by smtp.gmail.com with ESMTPSA id
 lb18-20020a17090b4a5200b002636dfcc6f5sm3878134pjb.3.2023.10.15.22.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 22:40:12 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 4/4] test: dm: add SCMI power domain protocol test
Date: Mon, 16 Oct 2023 14:39:46 +0900
Message-Id: <20231016053946.470458-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053946.470458-1-takahiro.akashi@linaro.org>
References: <20231016053946.470458-1-takahiro.akashi@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2
* remove a change at "test_scmi_cmd" because "scmi" command is no longer
  provided
---
 test/dm/scmi.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index d4ff60e00069..da45314f2e4c 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -206,6 +206,109 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 
 DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
 
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

