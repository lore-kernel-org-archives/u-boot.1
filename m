Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF019CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 05:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1495B86B43;
	Mon, 16 Oct 2023 07:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VeD/Nwps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C38486C65; Mon, 16 Oct 2023 07:40:14 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F02B86958
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 07:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd20c30831so283881b3a.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697434808; x=1698039608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkJQH4r3RXKY7R0SFOUQhPYOcZ+dcahzhTioVJxng0o=;
 b=VeD/NwpspH/nLH5i3O2256rbJsycc1QD2fDeXM+qe1wlUIJzdCk//iVA0iy5O90n87
 dCYxDmdFempxd37sHv01yXupmssOJNppg9Klble71B+jDXASHmDbiaYbihHX5e8bigHZ
 uSV/7kLWp2nz8pfFukD2mJE1UpEz1RivYBRhSo2dg2sJcZeVHFwh+6rAJE0zZgkvxcZO
 9aAJRyuRStV666S/hZhplL3yNCPCdyIeBD7xCEAPklFYMLJnz/J8gUdx9GwTchrVgN4U
 yNnRfKhIYU65bXRnq1MqhyIW6YVs9gKygZizj4Q7yZZjLDt3rBjzzzDAHXDlrwPmYjEt
 p3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697434808; x=1698039608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkJQH4r3RXKY7R0SFOUQhPYOcZ+dcahzhTioVJxng0o=;
 b=oB3Cmb0ym1V6GOxMfG45UPdO62OyXXy0UU2PY9i8zZBv21n2ORWaUqLoGvxd4PaY67
 omGr9olfrxnaVm6Fk4u13xpgvCYhcaYXLr0TP5YkzYxdDXuBGGRmav5v04FPGhg1nIcW
 Dmjpb99ugfm0Gk8HSZiRLZw/r6qc1gVYeTcKmqtQhvyEUGFb6cEGIvDKwyO40tFqg5bn
 dhyBeGzlN6aAXVVZGPuJviozc/OaVeTlH7HjpidbglfGzQay8I5qAkCyijnLD1/9jtn/
 xbJmNGbFZAtfH4R3kRSTeYhlxJ3I+tcHnQhLLzfw7mByolHN6SOc5o01tIeUPHsp3BnL
 V0sA==
X-Gm-Message-State: AOJu0Yz8C0sj4XaX8FhmdDe1Sx/tLuq9+YZgvfMm7kvV7hPU+V6tKGmR
 qdB7cvC4BTSXprURKqFHEvVN/A==
X-Google-Smtp-Source: AGHT+IGzytKzNZ+KbLdMBOmgREVLqTL6jTJtRZL5qN1k1wpoxGIbOaq4XzgUuaClV7NOrWdYCNGMBg==
X-Received: by 2002:a17:90a:b397:b0:27d:6268:b75c with SMTP id
 e23-20020a17090ab39700b0027d6268b75cmr4485335pjr.4.1697434808376; 
 Sun, 15 Oct 2023 22:40:08 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:4c30:a6e6:b316:7d31])
 by smtp.gmail.com with ESMTPSA id
 lb18-20020a17090b4a5200b002636dfcc6f5sm3878134pjb.3.2023.10.15.22.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 22:40:08 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/4] power: domain: add SCMI driver
Date: Mon, 16 Oct 2023 14:39:44 +0900
Message-Id: <20231016053946.470458-3-takahiro.akashi@linaro.org>
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

Add power domain driver based on SCMI power domain management protocol.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v2
* remove tentative code which was enclosed by "#if 0"
* free allocated memory at the failure of probe function
---
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 ++
 drivers/power/domain/Kconfig              |   7 +
 drivers/power/domain/Makefile             |   1 +
 drivers/power/domain/scmi-power-domain.c  | 193 ++++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +
 5 files changed, 214 insertions(+)
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
index 000000000000..2b85efc08914
--- /dev/null
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -0,0 +1,193 @@
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
+			for (i--; i >= 0; i--)
+				free(priv->prop[i].name);
+			free(priv->prop);
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

