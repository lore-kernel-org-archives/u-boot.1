Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EB4C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E6684A27;
	Thu,  2 Jul 2026 20:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="EJ/Xf506";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCE184A57; Thu,  2 Jul 2026 20:27:48 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F3584A0E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grljs6KXSzHfk;
 Thu,  2 Jul 2026 20:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783016865;
 bh=AKoNETyTA2Kw1xzVRYphRoDxefgIF6MCnqdOai50Pl4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EJ/Xf506bGXiSIEyTS3m1uGru4MwL4xiIb8H72I7WroOZC+Y/rMLfTPV3fyW1/cL7
 D7n0DA3Ch8BzPDHA5FJlDYtjYUF11TRCyuC8JbUFNLmUA/VT2e6dct/fTaQEI1WYQE
 V98lj4Y7vM1OB1zZrEbo5SxJQjIUTSf6bI0jGObm777GGIyB/T451y/3r/NZxcD0oG
 KeGJ9VqWPX+ZwQqfdItM5JOxS04kPkWBA1H/L6P6MH6OTbXTq4xYoxt4eth98B7wDA
 0zWmAKdRBPezGzcMObvq//yhe+feNLXWU1L5AKgkAyUuh7yOx9wp9eELlwci3c8T1z
 YcoruAstSGFBw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4grljr5zvdztTS; Thu,  2 Jul 2026 20:27:44 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 02 Jul 2026 20:27:35 +0200
Subject: [PATCH 5/6] Revert "sysreset: Implement PSCI based reset to EDL
 mode for QCOM SoCs"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-revert-sysreset-v1-5-7920c16a1f3a@cherry.de>
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
In-Reply-To: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This reverts commit 32825eaddc37670bb87f98b338aef8238e259e72.

The args support for the sysreset uclass contains a logic bug. The first
sysreset device implementing the request_arg callback will consume the
args, not support the specified arg and thus return -EPROTONOSUPPORT
which will stop the iteration over all sysreset devices.

This is an issue if one has multiple sysreset devices and each with
support for different (valid) args. If a sysreset device implements a
-dummy argument and another -foo and one calls reset -dummy on the
U-Boot CLI, it'll depend on which sysreset device will be attempted
first. If it is the one implementing -foo, it'll return it doesn't
support the argument with -EPROTONOSUPPORT in which case the device
implementing -dummy will never be attempted and instead we'll do a cold
reset which is very likely not what's expected.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/firmware/psci.c               |  4 ----
 drivers/sysreset/Kconfig              |  7 ------
 drivers/sysreset/Makefile             |  1 -
 drivers/sysreset/sysreset_qcom-psci.c | 45 -----------------------------------
 4 files changed, 57 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index b6838a244d2b..2e3223e1c32a 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -186,10 +186,6 @@ static int psci_bind(struct udevice *dev)
 					 NULL);
 		if (ret)
 			pr_debug("PSCI System Reset was not bound.\n");
-		if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
-		    device_bind_driver(dev, "qcom_psci-sysreset",
-				       "qcom_psci-sysreset", NULL))
-			pr_debug("QCOM PSCI System Reset was not bound.\n");
 	}
 
 	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 90f740f51d42..f589ad154186 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -301,13 +301,6 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
-config SYSRESET_QCOM_PSCI
-	bool "Support reset to EDL for Qualcomm SoCs via PSCI"
-	depends on ARM_SMCCC
-	help
-	  Add support for the reset to EDL (Emergency Download) on Qualcomm
-	  SoCs via PSCI.
-
 config SYSRESET_QCOM_PSHOLD
 	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
 	help
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index b5b99235b6ef..d18a5d523605 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
-obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
 obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
deleted file mode 100644
index 3627bbf5c820..000000000000
--- a/drivers/sysreset/sysreset_qcom-psci.c
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
- * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
- */
-
-#include <dm.h>
-#include <sysreset.h>
-#include <asm/system.h>
-#include <linux/errno.h>
-#include <linux/psci.h>
-#include <asm/psci.h>
-
-static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
-{
-	return -EOPNOTSUPP;
-}
-
-static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
-					  char * const argv[])
-{
-	if (!strncasecmp(argv[1], "-edl", 4)) {
-		/* Supported in qcs9100, qcs8300, sc7280, qcs615 */
-		if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
-							ARM_PSCI_RET_SUCCESS) {
-			psci_system_reset2(0, 1);
-			return -EINPROGRESS;
-		}
-		printf("PSCI SYSTEM_RESET2 not supported\n");
-	}
-
-	return -EPROTONOSUPPORT;
-}
-
-static struct sysreset_ops qcom_psci_sysreset_ops = {
-	.request_arg = qcom_psci_sysreset_request_arg,
-	.get_status = qcom_psci_sysreset_get_status,
-};
-
-U_BOOT_DRIVER(qcom_psci_sysreset) = {
-	.name = "qcom_psci-sysreset",
-	.id = UCLASS_SYSRESET,
-	.ops = &qcom_psci_sysreset_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};

-- 
2.55.0

