Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3E11091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBAE8415D;
	Thu, 19 Mar 2026 22:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YtMFN5hW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F9B838FA; Thu, 19 Mar 2026 22:37:03 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76258410D
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d556c1a79eso1453810a34.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956218; x=1774561018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BtvRs7r92OFA8T8WnbvY0teXccjgAuOpzUgrtc6nF0=;
 b=YtMFN5hWJFGsNS6r4LvGdOq8PpJ1yBbZeh5pxAac+zUJoBsNWfAhWxP0DulbwlJUJ4
 H2bKQlWSHsdvA4aUvQO8g079C1rgsoJjIkUcGJ0Nf87VaO+NxGcMEc/UNY8SURtVFqqa
 wELkeWEZYSTYik76sXlqpgDr87yoW9pQMAX0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956218; x=1774561018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BtvRs7r92OFA8T8WnbvY0teXccjgAuOpzUgrtc6nF0=;
 b=f/SrFro+99MZJA97qRYKWALVWB1Xho+hiZFbkNUhUAGRPtnaRRipzLl/iObVMio2bv
 Vmly7Q1UQ95SyxqAAezggRu4bA6HcMBVPMjnQUbLp+rG8PdvaL61fNsyxrGZsnrzg4SP
 b65xcppLIPEUgjFXPldfTM2gyeHsbGSMsGogUMggchGAwuJ6ihLHkqzskcjNIBTroS8p
 GxMeJ3nGmcyXGdK3axY/+jvZiLSn0AGFKOQmHMmm432a//IA1LHOjkbjo4DUm75JkO5H
 hP+hx2VSQgMNWNvMEO9JZKfYPo1CAvmmNAJEXzij+MaLFqpzn0FmErpNGLlFWzUr/bZb
 0xPg==
X-Gm-Message-State: AOJu0YzeN72lHRrVMIHolsqzRsyC1mSP9IpOorPq9EgLIhZDtM3nPqy/
 Lihok4SyRAqlJNpePhfcXEmJw1zpP04jVKodttpu1QzQs9aYB3L/fwjtt9W5FRVrMJb9m/tIL5C
 ejzLCkg==
X-Gm-Gg: ATEYQzxufGj5lRWA5G+p8Bqmvxr7Cuu+v/2uL0yw1k+HK8FbP1hs+zoRumdzyTIAUCy
 bLYnhwg7CxKvK5aLgLIeDYhgu9By6YDDr2j/nl/jOr7IGHWMsyyOD3rR4Yw3taNLkCF25VpG3M5
 T81vFHEIgbKJAKl3B4V7FF6Kh/q7Bj3nHARF/eXf2w39lOkSB/qdReb+58Opf6o7NTFQ6QoBOCl
 0gGhG0f58ZM3uvpMKOi79Xbt4HQ0ebCeaw7pQZPnqB0LmmslNEgBNbAZ66m2Vvglgr06moYVLXJ
 2fTqHL+xIXqbQUIoo4CsLQE5dG9SKsrb5Ka9KyJCBu5Yp+yaaPKtrOY/78Zx/THzqB61GuNekp4
 Tjl1KyWLWP2Euh+2JCNTYQYiytCo4PZIWGsbYLDu1Q9WLWQs3ilyou/Yg9QNUpiKXx34BZEJHfe
 0I/gjNbQ4/Ty0fgL+afArZbRPhz771
X-Received: by 2002:a05:6830:410f:b0:7d7:3adf:a722 with SMTP id
 46e09a7af769-7d7eafe1fefmr589762a34.29.1773956217943; 
 Thu, 19 Mar 2026 14:36:57 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Brian Sune <briansune@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 15/15] power: pmic: raa215300: Convert sysreset to uclass
 adjunct
Date: Thu, 19 Mar 2026 15:35:45 -0600
Message-ID: <20260319213551.267031-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

Convert the RAA215300 PMIC's sysreset support from the child-device
pattern to use uclass adjuncts. Previously the PMIC driver's bind
function created a separate child device with a dedicated sysreset
driver. Now the PMIC driver registers itself as a sysreset adjunct
during probe, keeping all the functionality in a single device.

The key change is that raa215300_sysreset_request() no longer needs
dev_get_parent() to reach the PMIC, since the device itself is the
PMIC.

Remove the now-unused sysreset_raa215300.c driver.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/power/pmic/raa215300.c        | 60 ++++++++++++++++++++++-----
 drivers/sysreset/Kconfig              |  3 ++
 drivers/sysreset/Makefile             |  1 -
 drivers/sysreset/sysreset_raa215300.c | 58 --------------------------
 4 files changed, 52 insertions(+), 70 deletions(-)
 delete mode 100644 drivers/sysreset/sysreset_raa215300.c

diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
index a581a1f6dc1..279dbd29756 100644
--- a/drivers/power/pmic/raa215300.c
+++ b/drivers/power/pmic/raa215300.c
@@ -5,11 +5,14 @@
 
 #include <dm.h>
 #include <dm/device-internal.h>
-#include <dm/lists.h>
 #include <i2c.h>
 #include <power/pmic.h>
+#include <sysreset.h>
 
-#define RAA215300_REG_COUNT 0x80
+#define RAA215300_REG_COUNT	0x80
+#define RAA215300_REG_SWRESET	0x6D
+#define RAA215300_COLD_RESET	BIT(0)
+#define RAA215300_WARM_RESET	BIT(1)
 
 static int raa215300_reg_count(struct udevice *dev)
 {
@@ -27,24 +30,59 @@ static const struct udevice_id raa215300_ids[] = {
 	{ /* sentinel */ }
 };
 
-static int raa215300_bind(struct udevice *dev)
+#if IS_ENABLED(CONFIG_SYSRESET_RAA215300)
+static int raa215300_sysreset_request(struct udevice *dev,
+				      enum sysreset_t type)
 {
-	if (IS_ENABLED(CONFIG_SYSRESET_RAA215300)) {
-		struct driver *drv = lists_driver_lookup_name("raa215300_sysreset");
-		if (!drv)
-			return -ENOENT;
+	int ret;
+	u8 val;
 
-		return device_bind(dev, drv, dev->name, NULL, dev_ofnode(dev),
-				   NULL);
+	/*
+	 * The RAA215300 documentation names the available reset types
+	 * differently to U-Boot:
+	 *
+	 *   - A "warm" reset via the RAA215300 PMIC will fully reset the SoC
+	 *     (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
+	 *
+	 *   - A "cold" reset via the RAA215300 PMIC will cycle all power supply
+	 *     rails, so this corresponds to SYSRESET_POWER.
+	 */
+	switch (type) {
+	case SYSRESET_COLD:
+		val = RAA215300_WARM_RESET;
+		break;
+
+	case SYSRESET_POWER:
+		val = RAA215300_COLD_RESET;
+		break;
+
+	default:
+		return -EPROTONOSUPPORT;
 	}
 
-	return 0;
+	ret = pmic_reg_write(dev, RAA215300_REG_SWRESET, val);
+	if (ret)
+		return ret;
+
+	return -EINPROGRESS;
 }
 
+static struct sysreset_ops raa215300_sysreset_ops = {
+	.request = raa215300_sysreset_request,
+};
+
+static const struct driver_adjunct raa215300_adjuncts[] = {
+	{ UCLASS_SYSRESET, &raa215300_sysreset_ops },
+	{ }
+};
+#endif
+
 U_BOOT_DRIVER(raa215300_pmic) = {
 	.name = "raa215300_pmic",
 	.id = UCLASS_PMIC,
 	.of_match = raa215300_ids,
-	.bind = raa215300_bind,
 	.ops = &raa215300_ops,
+#if IS_ENABLED(CONFIG_SYSRESET_RAA215300)
+	.adjuncts = raa215300_adjuncts,
+#endif
 };
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 16ef434a8d9..737327b8197 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -290,8 +290,11 @@ config SYSRESET_MPC83XX
 config SYSRESET_RAA215300
 	bool "Support sysreset via Renesas RAA215300 PMIC"
 	depends on PMIC_RAA215300
+	select DM_UC_ADJUNCT
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
+	  Uses the uclass adjunct feature to register the PMIC as a
+	  sysreset device without creating a separate child device.
 
 config SYSRESET_QCOM_PSHOLD
 	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index d18a5d52360..0226eecca4d 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
 obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
-obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
 obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
diff --git a/drivers/sysreset/sysreset_raa215300.c b/drivers/sysreset/sysreset_raa215300.c
deleted file mode 100644
index 32dfcb0aec8..00000000000
--- a/drivers/sysreset/sysreset_raa215300.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2023 Renesas Electronics Corporation
- */
-
-#include <dm.h>
-#include <power/pmic.h>
-#include <sysreset.h>
-
-#define RAA215300_REG_SWRESET	0x6D
-#define RAA215300_COLD_RESET	BIT(0)
-#define RAA215300_WARM_RESET	BIT(1)
-
-static int raa215300_sysreset_request(struct udevice *dev, enum sysreset_t type)
-{
-	struct udevice *pmic = dev_get_parent(dev);
-	int ret;
-	u8 val;
-
-	/*
-	 * The RAA215300 documentation names the available reset types
-	 * differently to u-boot:
-	 *
-	 *   - A "warm" reset via the RAA215300 PMIC will fully reset the SoC
-	 *     (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
-	 *
-	 *   - A "cold" reset via the RAA215300 PMIC will cycle all power supply
-	 *     rails, so this corresponds to SYSRESET_POWER.
-	 */
-	switch (type) {
-	case SYSRESET_COLD:
-		val = RAA215300_WARM_RESET;
-		break;
-
-	case SYSRESET_POWER:
-		val = RAA215300_COLD_RESET;
-		break;
-
-	default:
-		return -EPROTONOSUPPORT;
-	}
-
-	ret = pmic_reg_write(pmic, RAA215300_REG_SWRESET, val);
-	if (ret)
-		return ret;
-
-	return -EINPROGRESS;
-}
-
-static struct sysreset_ops raa215300_sysreset_ops = {
-	.request = raa215300_sysreset_request,
-};
-
-U_BOOT_DRIVER(raa215300_sysreset) = {
-	.name = "raa215300_sysreset",
-	.id = UCLASS_SYSRESET,
-	.ops = &raa215300_sysreset_ops,
-};
-- 
2.43.0

