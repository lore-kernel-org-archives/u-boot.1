Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E68BD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79C783AEF;
	Fri, 28 Nov 2025 17:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ejs3B1Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B77A8457A; Fri, 28 Nov 2025 15:31:19 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4649984564
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so1185151f8f.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764340277; x=1764945077;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LIFloz8h+ZbuCmYh3VGSGhb4RfETp6sodp9Kfsf8Apc=;
 b=Ejs3B1YpNMJHizlBe8lwQO9wphEFv+b5w2yn6VyCoTOjsvRPhzu9pslz13EGV5QD8C
 GZ/Le7+QKpjMElp90T6jN0P2Hj/9ynaXwJ0rPIsVQ98x+mIgRVffx9Tpju8sIH60z9JN
 6LHcFEZ5TSgOu/fHf1rXH1pBrtUC49WulASQ5euhzIYo1n9OIK8SzKiIsu39idwDiJ3Q
 WIrFtKHRT2AteTpWeXIfR7wwx16BW8QZSeyYWClThcYsM2teMvVGcVPUWzTR/j6BQA7k
 uN3l9h2vA3CEAbMYHaYGAMmzVeq0/Jv47Cl3Ju27n39ioQaeeufUZERt8gOZZtVAFXX3
 yE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764340277; x=1764945077;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIFloz8h+ZbuCmYh3VGSGhb4RfETp6sodp9Kfsf8Apc=;
 b=Kj86vGf1jS7IQJtTkmhMIYUfdr3QbmnwwPaTAvSwzsUPry/6reUgRPuKFSGl1FBdbL
 XMdGmqIMGi29muB8y/iypnlQxg/kABGa5phS9Dj+nNtwFaNCUvChjh7Ulo0YL8crU+Pe
 JOKQR4zq3Q/e/yQtGZyw6J9DbrX485hdHxJyM8IJvpzFLAxoTyStQ1l1HyLZe1YFpnrG
 QClmx0RsBG6b/5tZtyaMGQR5e0mMQAuKugkDcLuadScTSyIXYuZbJXaUeC/rM7P3F1PV
 CD0WjaQz8GyFnNJZWDLmq2wfPZYiF7iHijeqLYWay/+O52JFiXgrzW+Ue9Qpzopprgce
 ZbDA==
X-Gm-Message-State: AOJu0YwYjMPei7A60/9LAk1enU07I72rGu+6vGB4/ECcTDfqrDffO3uu
 hQijx3+nzj0V+hV6gxMqV8zE/ICOtz7Xcsx8Ub7oUsDlDUfnlyPN6mL88Xmn71eR46M=
X-Gm-Gg: ASbGncuUH19kkpjvq32z7X1GyBEUD/qd/Z22mZnS9P9BL76M4sn9H+/o68Sqi5uWmv/
 lV0OJQSLhqUie0EAa0pUmQzdkkcXu1dd8eJxmuF7PJWQGZtevqn3PGLZZRpmjcQ71KGwUer/36E
 +RrLn/tD858AtvQsmqP8FJy5d/7Yf6J5LGL93vVEnSvE/DzelY1Kzz5RIyrg2rh/yAnkcNEwK6+
 /+ErnakNpDJfYpEbmJoVFYLB5gKni+ZJ54osw7TlS2LCKnpLtbl40o6ttjg2BZIu+E8Cb7Rluio
 W9KPuAOQ9cSocrAuV2xS8vc0eZHSp6+mwo/PfFphiMfTbGaa+gVCI9heW1iMhuyuUy7b1DkhjCJ
 M5Z1GOJLwGl6DZkG15ugQN8VfQ5/qDr3BSYm/D4kjJCuxZXx/YfFWBBplq81JDs4+HM3NZBxanj
 P6ANxtBLk=
X-Google-Smtp-Source: AGHT+IGj4MUXX5h/JYKSIQlahX55kXK0inJaB9r5I7fGYfNsAUD8MzGikK7R9RaqGEbXAcrXbWHfCw==
X-Received: by 2002:a05:6000:3106:b0:429:cda2:9ffe with SMTP id
 ffacd0b85a97d-42e0f1fb97amr17163726f8f.7.1764340276640; 
 Fri, 28 Nov 2025 06:31:16 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1caa767dsm10100990f8f.38.2025.11.28.06.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:31:16 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 15:31:06 +0100
Subject: [PATCH] power: domain: Add ti-omap-prm stub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-omap-prm-v2026-01-v1-1-72c5cc4c7728@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACmyKWkC/x2MywqAIBAAfyX23IIK9vqV6CDbVnswRSMC6d+Tj
 sMwUyBzEs4wNQUS35IlnBV02wAd7twZZa0MRhmrtRnwClEIg3cRY/J4V9Gh0khjT0bRatk5qHV
 MvMnzn+flfT8yf9AdaQAAAA==
X-Change-ID: 20251128-topic-omap-prm-v2026-01-c97c20cd5eaa
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PP24nOxnzuLxEnE/i/cUR7QDLP0+fPrz+ZlT99ppZaQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNTTordseeF1kuwNwspP3xSOTDHf+uXZs36+DiPYevN
 F7YxGP+vqOUhUGMi0FWTJGlMzE07b/8zmPJi5ZthpnDygQyhIGLUwAm4tjH8N9PbZpcVdTmKIN/
 N8K2fzS3kt5gqlqgMf8Y2xreSwUKsZMYfrM9dFz3Qp3ng72Hm/CEr0G9xmzqS3Vc46YV7prA28+
 WwwwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 17:28:20 +0100
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

Upstream DT uses simple-pm-bus instead of simple-bus. simple-pm-bus
requires power domain support. On am33xx, PRM manages power domains but
all domains are enabled at boot. Add stub driver with custom of_xlate
that expects no argumetns to allow simple-pm-bus and dependent devices
to probe.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/power/domain/Kconfig       |  8 ++++++++
 drivers/power/domain/Makefile      |  1 +
 drivers/power/domain/ti-omap-prm.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 0ad885c9e8ba7fe7f687b5d9bad4ef6384d55276..935f282d6c53acd3f02b8894764cc317c109c41f 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -125,6 +125,14 @@ config TI_POWER_DOMAIN
 	help
 	  Generic power domain implementation for TI K3 devices.
 
+config TI_OMAP_PRM_POWER_DOMAIN
+	bool "Enable the TI OMAP PRM power domain driver"
+	depends on POWER_DOMAIN && ARCH_OMAP2PLUS
+	help
+	  Enable support for TI OMAP Power and Reset Manager (PRM) power domains.
+	  The driver is currently a stub to be able to probe devices that
+	  require this type of power domain device.
+
 config ZYNQMP_POWER_DOMAIN
 	bool "Enable the Xilinx ZynqMP Power domain driver"
 	depends on POWER_DOMAIN && ZYNQMP_FIRMWARE
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 8e03f620437edc6f3d39922b0d5c972fdcd57801..b2c0bd8a61a1f289cbc4d14fa3da13b9781d70e5 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_SCMI_POWER_DOMAIN) += scmi-power-domain.o
 obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
 obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
 obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
+obj-$(CONFIG_TI_OMAP_PRM_POWER_DOMAIN) += ti-omap-prm.o
 obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
diff --git a/drivers/power/domain/ti-omap-prm.c b/drivers/power/domain/ti-omap-prm.c
new file mode 100644
index 0000000000000000000000000000000000000000..c240e2682ea93c9e9addcbac9c3a3ea66a0196b7
--- /dev/null
+++ b/drivers/power/domain/ti-omap-prm.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TI OMAP PRM (Power and Reset Manager) power domain driver
+ *
+ * Stub driver to provide power domain support.
+ */
+
+#include <dm.h>
+#include <power-domain-uclass.h>
+
+static int ti_omap_prm_xlate(struct power_domain *power_domain,
+			     struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id ti_omap_prm_ids[] = {
+	{ .compatible = "ti,am3-prm-inst" },
+	{ .compatible = "ti,am4-prm-inst" },
+	{ .compatible = "ti,omap-prm-inst" },
+	{ }
+};
+
+static struct power_domain_ops ti_omap_prm_ops = {
+	.of_xlate = ti_omap_prm_xlate,
+};
+
+U_BOOT_DRIVER(ti_omap_prm) = {
+	.name = "ti-omap-prm",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = ti_omap_prm_ids,
+	.ops = &ti_omap_prm_ops,
+};

---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251128-topic-omap-prm-v2026-01-c97c20cd5eaa

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

