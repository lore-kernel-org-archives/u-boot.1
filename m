Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13913CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2552683DE4;
	Tue, 18 Nov 2025 14:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tyEU0zL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6871883D07; Tue, 18 Nov 2025 11:42:24 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FA383C96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso8521573a12.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462542; x=1764067342;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=36zKLbsOc8eU8ITSTe67fp+NmdP1dyBkOB+niVXqR0c=;
 b=tyEU0zL97IrI8cPuEXaOt47q3Mi7JGe8VPaPuWDFlfgjK5vZGnYOZPMUsguwgj6ZQw
 fG6BrqX87wbvSk0Cwu+/YW3DUbqaaLrfo/4j0iPNAjf0+8Zex6WDVwAOI4ZzPhqAxYch
 KNUILi7mGzibBRFDgRyGTU1rqGhiTOBJ/X/m4KijwyydhjZdZ+5flOIWBySHCm66qwZN
 tfkOa0gFJT7W9+Sg3/ILlgNskgfeN579m2sowfJ3elxhdiqefqMlCF2eVkyDAPftuTrL
 KwIFF99Hjw6Jh8Nv0fBNcLVb0Zz7oC4qxcS0F2Axh+dksayavcpzGEK9b2hhqv8hF5mb
 w3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462542; x=1764067342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=36zKLbsOc8eU8ITSTe67fp+NmdP1dyBkOB+niVXqR0c=;
 b=eFJ36pY1AfBG3GOSu7VAkT2XRI7ALiV9vgv8aU7jwO8nh6/34CRtgvqLpGK/vlh2CR
 Vxj/PznppkQUDBStKXCyzEOZ5lFSFc7BQzw04JJq6rIZo+glqHfe6M4mubiMmVi5+tKp
 T19ehbFFT2dQi83LDZGNgBvbl+nGqurvySVEFb5smbYO8UWESwUXKZGyrrAhHrGko7zT
 VXz1PJ8W1e9qRxRLnRNvlY0lZi827i/jbvvdWZByloKL9SIHHhcgYkzG6xU07bI7BXIP
 ftfgREmO7g0aa48Z/ogllEbZtp82c014EFKEQUfgJkhHR8nhDtBrhlmAi0c43kFD9/S9
 DF1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnacEr1+Yl/oyqnBlmgqlIyq+DuBkFJMQ+qbD3QrWhd0OfW00l+Rnt2vy4+G7mMMwXdhDRkYo=@lists.denx.de
X-Gm-Message-State: AOJu0YzIiAsScI7y8zUgyPvkylBUwaUDAZXlQHfHrfHltgWo/jRkAoEx
 wGxZ0Ej5cFYtKTi5spJxzZNORfuSD/QAlNKvNg5LtDMYrwNF4NHTwzxHvE30OfdF81Q=
X-Gm-Gg: ASbGncuodYjXmHJq7KTQVAdhZHzCoKgJ9F9xASSJ711Sk5obDoQMb2g4Z9TdYAhfzjn
 kwkPz+fPDmtMbt8aO2J6SiyOYfsBd+0cpQuWoLGLzfVIZgnNMKmupKcpkBF8yiEKmMM35+YcVkm
 Zsb2J2yoQ6CxANPKZXat9ldXLw//H2o6uDqCSEsfUOESWCD1peUD2R2dZZdAbKrn9Lcgqo5RmZn
 R6OafHzfQGRP7RCl0Uk5kI9wzrrvqXMnEzTgQrewK7XPhvo68JUIvOJC8vLyfSLnLZYLNK9TOZX
 t/gQb8DNFXFj8WIzoCRhno2HV8jMmwN7q4fTFz4jIBoCivHvR+9uWmlklUT0Gv4H4oIhbDIK343
 EuCOAnzAZjmDq8vINXTlmVfVZE3GeNSUUFE0KGlfwxABnRcYmman+Xw7tInERFGIhjdM1d761ZD
 TvwYHqy5w=
X-Google-Smtp-Source: AGHT+IGi5Y6RUHdOSmdFIOSl+mlguaJq8A+ZAPLTW2eJVSjtGGO//w8/mZIxSXBbQiVp5HQeD0zRdQ==
X-Received: by 2002:a05:6402:270e:b0:640:b978:efdb with SMTP id
 4fb4d7f45d1cf-64350eab173mr14902050a12.25.1763462541042; 
 Tue, 18 Nov 2025 02:42:21 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6433a497f27sm12407034a12.17.2025.11.18.02.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:20 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:26 +0100
Subject: [PATCH 06/15] power: domain: Add ti-omap-prm stub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-6-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3171; i=msp@baylibre.com;
 h=from:subject:message-id; bh=EwyJXELEA9aPG/2BRcdMI9FEJrylYgULILbAMzXXUSo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZX/+TT39P+r/lOOO//fofj+aL/DHhz7lv4CJmcnihc
 /ms4pmlHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRAzGMDAun6H1zFe82eTdp
 Yed+w1XGf6YViAuu6K2vOxsiePskayTD//ilEexhmzgNK0w4dkRPfGAnpXBJySLJyVF6gm91dpw
 8EwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

-- 
2.51.0

