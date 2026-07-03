Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C8C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2202184A0F;
	Fri,  3 Jul 2026 18:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="YBZsf5pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D11849F0; Fri,  3 Jul 2026 18:43:54 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B4984A35
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 18:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gsKMV0HjJzd70;
 Fri,  3 Jul 2026 18:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783097029;
 bh=mjQ6mgk44D/R5w5piMk7XASxEDLQt3Nkp2KOgHM4+UI=;
 h=From:Date:Subject:To:Cc:From;
 b=YBZsf5pi1M0XwCavJW084At2jVC0lWaFHo9WagARhzbi7NqSKWlobVGVo7GwBCEZ4
 R1wVSM/94UK4rMVR76CgtPlnP0fijGQnRTzGjMFgIhYFXe5XKZ3QgnEKirET4XumZd
 axKAFSK1Gz9F2M8IJHQ/ePPy+K7/YD3EVKtyJ94o6qcw+0mZ7w9LJRsvoIcDR2aWgU
 OX1smHLXiVSKhqmc7EqQ5JEC4rNDekqlKjrMfsKRnmK/gwaa4QKkMLtDFMna8H7jh0
 Tp4ADrY5UqSSxF541jMGXsERqXv1n2CIObtqeagCqSTfe+fos8Tj7Tesf8Yg7N4H4p
 w8mKmYB+4v0dw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gsKMS2n4Rz1hl; Fri,  3 Jul 2026 18:43:48 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 03 Jul 2026 18:43:32 +0200
Subject: [PATCH v2] drivers: sysreset: revert support for args in request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-revert-sysreset-v2-1-ac999d2ff82f@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2pq28hBX/odhUctF6gLMTCUSw
 r9bcO3yJOeeu5CAA4Qu2UKMKUgYhwT2kJHv3fCACm1istqWutJWJQkclczCEESVF1XtkBfnzoL
 S6sXowmcv3pofy/v+hI9bZjP6IHHkeb+czOb9r09GaVXVVntTOtOd3NX3YJ6PLahZ1/ULd2/fv
 sAAAAA=
X-Change-ID: 20260702-revert-sysreset-4579ae458f2e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Michal Simek <michal.simek@amd.com>, 
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

This reverts:
- commit e49c84f7bb7b ("doc: usage: cmd: reset: specify when the -edl
  option is available")
- commit 1076feb8a3f9 ("cmd: boot: fix edl being shown when not
  supported")
- commit 63c806ba0e12 ("qcom_defconfig: enable psci based sysreset")
- commit ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command
  documentation")
- commit 32825eaddc37 ("sysreset: Implement PSCI based reset to EDL mode
  for QCOM SoCs")
- commit fcb48b89813b ("drivers: sysreset: Add sysreset op that can take
  arguments")

There was a conflict reverting commit 63c806ba0e12 ("qcom_defconfig:
enable psci based sysreset") due to commit 02ef1859b44f ("configs:
Resync with savedefconfig"), but the conflict resolution was trivial.

The args support for the sysreset uclass contains a logic bug. The first
sysreset device implementing the request_arg callback will consume the
args, not support the specified arg and thus return -EPROTONOSUPPORT
which will stop the iteration over all sysreset devices.

This is an issue if one has multiple sysreset devices and each with
support for different (valid) args. If a sysreset device implements a
-dummy argument and another -foo and a user calls reset -dummy from the
U-Boot CLI, it'll depend on which sysreset device will be attempted
first. If it is the one implementing -foo, it'll return it doesn't
support the argument with -EPROTONOSUPPORT in which case the device
implementing -dummy will never be attempted and instead we'll do a cold
reset which is very likely not what's expected from the user.

Casey suggested[1] we revert this and start from scratch again with a
different implementation instead.

[1] https://lore.kernel.org/u-boot/77ff0f56-5c3b-42e7-bdd1-bf90296da900@linaro.org/

Acked-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- squashed all reverts into one big patch, as suggested by Marek and Tom
  on IRC,
- added information about conflict during one revert in commit log,
- added Acked-by from Casey,
- Link to v1: https://patch.msgid.link/20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de
---
 cmd/boot.c                            |  6 -----
 configs/qcom_defconfig                |  2 --
 doc/usage/cmd/reset.rst               | 10 +-------
 drivers/firmware/psci.c               |  4 ----
 drivers/sysreset/Kconfig              | 15 ------------
 drivers/sysreset/Makefile             |  1 -
 drivers/sysreset/sysreset-uclass.c    | 37 ----------------------------
 drivers/sysreset/sysreset_qcom-psci.c | 45 -----------------------------------
 include/sysreset.h                    | 18 --------------
 9 files changed, 1 insertion(+), 137 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 29cdf4a9a81a..23496cafdf5c 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,12 +60,6 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-// All options handled by sysreset drivers via their sysreset_ops.request_arg callback
-#ifdef CONFIG_SYSRESET_QCOM_PSCI
-	"reset -edl - Boot to Emergency DownLoad mode\n"
-#endif
-#endif
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70b..b0d0f51b1c02 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -133,8 +133,6 @@ CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
-CONFIG_SYSRESET_CMD_RESET_ARGS=y
-CONFIG_SYSRESET_QCOM_PSCI=y
 CONFIG_SYSRESET_QCOM_PSHOLD=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 79bc8b9deca5..78c9c8873bc9 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -11,9 +11,7 @@ Synopsis
 
 ::
 
-    reset
-    reset -w
-    reset -edl
+    reset [-w]
 
 Description
 -----------
@@ -24,12 +22,6 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
-All other options require CONFIG_SYSRESET_CMD_RESET_ARGS=y.
-
--edl
-    Boot to Emergency DownLoad mode on supported Qualcomm platforms. Unsupported
-    platforms will print an error message but the command will successfully
-    return (having done nothing). Requires CONFIG_SYSRESET_QCOM_PSCI=y.
 
 Return value
 ------------
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
index 90f740f51d42..16ef434a8d9c 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -49,14 +49,6 @@ config SYSRESET_CMD_RESET
 	help
 	  Enable sysreset implementation of the reset command.
 
-config SYSRESET_CMD_RESET_ARGS
-	bool "Enable reset command to take arguments"
-	help
-	  Pass on the arguments received by the 'reset' command to the
-	  sysreset driver(s). The sysreset driver(s) may make use of the
-	  additional arguments for implementing arch/board specific
-	  functionality.
-
 if CMD_POWEROFF
 
 config SYSRESET_CMD_POWEROFF
@@ -301,13 +293,6 @@ config SYSRESET_RAA215300
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
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd06..536ac7271427 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -32,18 +32,6 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return ops->request(dev, type);
 }
 
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
-{
-	struct sysreset_ops *ops = sysreset_get_ops(dev);
-
-	if (!ops->request_arg)
-		return -ENOSYS;
-
-	return ops->request_arg(dev, argc, argv);
-}
-#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
-
 int sysreset_get_status(struct udevice *dev, char *buf, int size)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -83,26 +71,6 @@ int sysreset_walk(enum sysreset_t type)
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-int sysreset_walk_arg(int argc, char * const argv[])
-{
-	struct udevice *dev;
-	int ret = -ENOSYS;
-
-	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
-		for (uclass_first_device(UCLASS_SYSRESET, &dev);
-		     dev;
-		     uclass_next_device(&dev)) {
-			ret = sysreset_request_arg(dev, argc, argv);
-			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
-				break;
-		}
-	}
-
-	return ret;
-}
-#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
-
 int sysreset_get_last_walk(void)
 {
 	struct udevice *dev;
@@ -164,11 +132,6 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	printf("resetting ...\n");
 	mdelay(100);
 
-#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
-		return 0;
-#endif
-
 	sysreset_walk_halt(reset_type);
 
 	return 0;
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
diff --git a/include/sysreset.h b/include/sysreset.h
index d1cc9ebc542a..ff20abdeed3c 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -43,24 +43,6 @@ struct sysreset_ops {
 	 * (in which case this method will not actually return)
 	 */
 	int (*request)(struct udevice *dev, enum sysreset_t type);
-
-	/**
-	 * @request_arg: Reset handler implementations that might need to process
-	 *		 arguments given to the 'reset' command.
-	 *
-	 * Note that this function may return before the reset takes effect.
-	 *
-	 * @dev:	Device to be used for system reset
-	 * @argc:	No. of items in @argv
-	 * @argv:	Arguments given to 'reset' command
-	 * Return:
-	 * -EINPROGRESS		if the reset has started and will complete soon
-	 * -EPROTONOSUPPORT	if not supported by this device
-	 * 0			if the reset has already happened
-	 * (in which case this method will not actually return)
-	 */
-	int (*request_arg)(struct udevice *dev, int argc, char * const argv[]);
-
 	/**
 	 * @get_status:	get printable reset status information
 	 *

---
base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
change-id: 20260702-revert-sysreset-4579ae458f2e

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

