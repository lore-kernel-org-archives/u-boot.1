Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F795E7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C658486D8B;
	Tue, 26 Sep 2023 09:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LijeBl25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B0086D9A; Tue, 26 Sep 2023 09:01:10 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5178886D8E
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68cc1b70e05so1941547b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711667; x=1696316467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSDEfXbx1Ru9WjEtbD0zE1/a/iAr+2GqyYt7YedDTOw=;
 b=LijeBl25YkiBEW9nLoL2oQ2ZAsb/X8oQAYSKerClbLY2Pjq/KARtwYFkmT54EbZcgC
 a4iKh3GjexEehXWBHvBhjLvehKBYWAivMjifWaF6h0JTNtAjN7Yune0oteQioBNF6EkF
 mMSWnFTDWzHXaks1hP+7SG5v015gCJfe4OyMBRTZ5rLs5BA0dJvCtjQfIhy0CwghiBre
 bp/SamhwaYO1buqPqhaYgH5prl9jsO2CFsfUljxvoCPmC0kBcHTXpwXVxDbfcpy551NF
 efND8UmVZ3RZwHQdmlpePIoYjfcCRh0C+V1lODOb1gpxbIc/dBjKLZnW7hIh3tSspKs1
 Q0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711667; x=1696316467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSDEfXbx1Ru9WjEtbD0zE1/a/iAr+2GqyYt7YedDTOw=;
 b=hUeH+h3fZX73gwKMv4ThiwElmJaPxUAGrSz3DBqk9yMdFSZ43/X91RxaT4Ry6/ET65
 sVySWGu4c60gI2T9l+QyqG5bS7EfMILcdlZNdyLPexDIWULXJXDWlKBlZlwD5ZBGzUh+
 KtM92N8KxNwaNIy4h1hUJYDCKDjr3aUn6BKt8j+BnOC2xntw3u2YBYdmzZtdzJxZvuEV
 5w3fABQHf7Ldb2vwBZ/Ec7gz2j0+G/m+Z7+AWT+74sMsnjl6Q0DHBsg2yG9+qtpv1HeH
 rwfevfBQcBnnQ2WDmka2JZWzIuwVufO1hcDgPaoTpEwZ78p4tnhE7ECoN3FbDMSM423N
 GmYA==
X-Gm-Message-State: AOJu0Yy9gfd4Smh+YIFezYwUB9AO7c8B8kF572CjHNMsjj6+tPcZFEI4
 RtECtVR6KsvUsbhXHihXMqHq+A==
X-Google-Smtp-Source: AGHT+IGvQr2LnjfMRyWgjIMTnpUtA8/WhJl8b5/aJhUN1+Lo8KKs/1aR46oaQQk+1EP7BmPhGvYo7A==
X-Received: by 2002:a05:6a20:394c:b0:13d:fff1:c672 with SMTP id
 r12-20020a056a20394c00b0013dfff1c672mr8342037pzg.4.1695711666577; 
 Tue, 26 Sep 2023 00:01:06 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0027758c7f585sm3178480pjb.52.2023.09.26.00.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 00:01:06 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/4] power: domain: add SCMI driver
Date: Tue, 26 Sep 2023 16:00:41 +0900
Message-Id: <20230926070043.738340-3-takahiro.akashi@linaro.org>
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

Add power domain driver based on SCMI power domain management protocol.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 ++
 drivers/power/domain/Kconfig              |   7 +
 drivers/power/domain/Makefile             |   1 +
 drivers/power/domain/scmi-power-domain.c  | 197 ++++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +
 5 files changed, 218 insertions(+)
 create mode 100644 drivers/power/domain/scmi-power-domain.c

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 6f585b96f740..0f1003e167e6 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -86,6 +86,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_BASE:
 		proto = priv->base_dev;
 		break;
+	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+		proto = priv->pwdom_dev;
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		proto = priv->clock_dev;
 		break;
@@ -133,6 +136,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_BASE:
 		priv->base_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+		priv->pwdom_dev = proto;
+		break;
 	case SCMI_PROTOCOL_ID_CLOCK:
 		priv->clock_dev = proto;
 		break;
@@ -405,6 +411,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 		drv = NULL;
 		name = ofnode_get_name(node);
 		switch (protocol_id) {
+		case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+			if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_power_domain);
+			break;
 		case SCMI_PROTOCOL_ID_CLOCK:
 			if (CONFIG_IS_ENABLED(CLK_SCMI) &&
 			    scmi_protocol_is_supported(dev, protocol_id))
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 411c210756a3..bd82d2f7044b 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -83,6 +83,13 @@ config SANDBOX_POWER_DOMAIN
 	  simply accepts requests to power on/off various HW modules without
 	  actually doing anything beyond a little error checking.
 
+config SCMI_POWER_DOMAIN
+	bool "Enable SCMI power domain driver"
+	depends on POWER_DOMAIN && SCMI_FIRMWARE
+	help
+	  Enable power domain implementation based on SCMI power domain
+	  management protocol.
+
 config TEGRA186_POWER_DOMAIN
 	bool "Enable Tegra186 BPMP-based power domain driver"
 	depends on TEGRA186_BPMP
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index aa5a4ba57cd8..2daab73eb758 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
+obj-$(CONFIG_SCMI_POWER_DOMAIN) += scmi-power-domain.o
 obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
 obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
 obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
diff --git a/drivers/power/domain/scmi-power-domain.c b/drivers/power/domain/scmi-power-domain.c
new file mode 100644
index 000000000000..5ea9ff889231
--- /dev/null
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SCMI Power domain driver
+ *
+ * Copyright (C) 2023 Linaro Limited
+ *              author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <malloc.h>
+#include <power-domain.h>
+#include <power-domain-uclass.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <dm/device_compat.h>
+
+/**
+ * struct scmi_pwd_properties
+ * @attributes:	Power domain attributes
+ * @name:	Name of the domain
+ */
+struct scmi_pwd_properties {
+	u32 attributes;
+	u8 *name; /* not used now */
+};
+
+/**
+ * struct scmi_power_domain_priv
+ * @num_pwdoms:	Number of power domains
+ * @prop:	Pointer to domain's properties
+ * @stats_addr:	Address of statistics memory region
+ * @stats_len:	Length of statistics memory region
+ */
+struct scmi_power_domain_priv {
+	int num_pwdoms;
+	struct scmi_pwd_properties *prop;
+	u64 stats_addr;
+	size_t stats_len;
+};
+
+/**
+ * async_is_supported - check asynchronous transition
+ * @attributes:	Power domain attributes
+ *
+ * Determine if the power transition can be done asynchronously.
+ *
+ * Return: true if supported, false if not
+ */
+static bool async_is_supported(u32 attributes)
+{
+	if (attributes & SCMI_PWD_ATTR_PSTATE_ASYNC)
+		return true;
+
+	/* TODO: check attributes && SCMI_PWD_ATTR_PSTATE_SYNC */
+	return false;
+}
+
+/**
+ * scmi_power_domain_on - Enable the power domain
+ * @power_domain:	Power domain
+ *
+ * Turn on the power domain.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_power_domain_on(struct power_domain *power_domain)
+{
+	struct scmi_power_domain_priv *priv = dev_get_priv(power_domain->dev);
+	u32 flags, pstate;
+	int ret;
+
+	if (power_domain->id > priv->num_pwdoms)
+		return -EINVAL;
+
+	if (async_is_supported(priv->prop[power_domain->id].attributes))
+		flags = SCMI_PWD_SET_FLAGS_ASYNC;
+	else
+		flags = 0;
+
+	/* ON */
+	pstate = 0;
+
+	ret = scmi_pwd_state_set(power_domain->dev, flags, power_domain->id,
+				 pstate);
+	if (ret) {
+		dev_err(power_domain->dev, "failed to set the state on (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * scmi_power_domain_off - Disable the power domain
+ * @power_domain:	Power domain
+ *
+ * Turn off the power domain.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_power_domain_off(struct power_domain *power_domain)
+{
+	struct scmi_power_domain_priv *priv = dev_get_priv(power_domain->dev);
+	u32 flags, pstate;
+	int ret;
+
+	if (power_domain->id > priv->num_pwdoms)
+		return -EINVAL;
+
+	if (async_is_supported(priv->prop[power_domain->id].attributes))
+		flags = SCMI_PWD_SET_FLAGS_ASYNC;
+	else
+		flags = 0;
+
+	/* OFF */
+	pstate = SCMI_PWD_PSTATE_TYPE_LOST;
+
+	ret = scmi_pwd_state_set(power_domain->dev, flags, power_domain->id,
+				 pstate);
+	if (ret) {
+		dev_err(power_domain->dev, "failed to set the state off (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * scmi_power_domain_probe - Probe the power domain
+ * @dev:	Power domain device
+ *
+ * Probe the power domain and initialize the properties.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int scmi_power_domain_probe(struct udevice *dev)
+{
+	struct scmi_power_domain_priv *priv = dev_get_priv(dev);
+	u32 version;
+	int i, ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "failed to get channel (%d)\n", ret);
+		return ret;
+	}
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_POWER_DOMAIN,
+					    &version);
+#if 0 /* TODO */
+	if (ret || version < SCMI_POWER_DOMAIN_PROTOCOL_VERSION) {
+		dev_err(dev, "protocol version doesn't match (%d)\n", version);
+		return -EINVAL;
+	}
+#endif
+
+	ret = scmi_pwd_protocol_attrs(dev, &priv->num_pwdoms, &priv->stats_addr,
+				      &priv->stats_len);
+	if (ret) {
+		dev_err(dev, "failed to get protocol attributes (%d)\n", ret);
+		return ret;
+	}
+
+	priv->prop = calloc(sizeof(*priv->prop), priv->num_pwdoms);
+	if (!priv->prop)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pwdoms; i++) {
+		ret = scmi_pwd_attrs(dev, i, &priv->prop[i].attributes,
+				     &priv->prop[i].name);
+		if (ret) {
+			dev_err(dev, "failed to get attributes pwd:%d (%d)\n",
+				i, ret);
+			/* TODO: clean up */
+
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+struct power_domain_ops scmi_power_domain_ops = {
+	.on = scmi_power_domain_on,
+	.off = scmi_power_domain_off,
+};
+
+U_BOOT_DRIVER(scmi_power_domain) = {
+	.name = "scmi_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &scmi_power_domain_ops,
+	.probe = scmi_power_domain_probe,
+	.priv_auto = sizeof(struct scmi_power_domain_priv),
+};
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 35d96069645e..33e0e18c30d4 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -23,6 +23,7 @@ struct scmi_channel;
  * @agent_name:		Agent name
  * @agent_id:		Identifier of agent
  * @base_dev:		SCMI base protocol device
+ * @pwdom_dev:		SCMI power domain management protocol device
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
@@ -38,6 +39,7 @@ struct scmi_agent_priv {
 	u8 *agent_name;
 	u32 agent_id;
 	struct udevice *base_dev;
+	struct udevice *pwdom_dev;
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
-- 
2.34.1

