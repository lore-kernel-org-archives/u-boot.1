Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91210CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D765849AC;
	Sat,  6 Jun 2026 10:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kk+pcoC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C973484997; Sat,  6 Jun 2026 10:48:03 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029BA84944
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9982760132;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AD0FC2BCC6;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735671;
 bh=4r9V1UfmWobdHVl78aapNZXfy73331FR8RA/Ucnc2jg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kk+pcoC4gknnCWMt7PlQeFU08ac+/SmmDgRjmB513KVxoDcSdNHr5Hxkrz9dpjunS
 zlecMq0cDEolYGU6MKr/prZWgN5ZxsltXwfHep/yFV02l6zV9DYAC+lO6KmPosOTGU
 k7dK+0tt30PAquPzqJJWH4D94EsZEf1l+8Xx5EcmnfJ/ThP0IDm+RcV0Ba1H697Ger
 IBfDKC/pYXv6Ze3TM1J4jhUmakMC7x23XiNGJMlnZF8Pk497zmY3r3xVMlJqaacXm5
 CFkhiub+DgRALuS9Cil54sJ+qHBHYAf1qkk3ZFshgxyGNsirfzWEyamncIgO8m56f+
 Y3XofHyHNlyfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4183DCD8C90;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 18:47:39 +1000
Subject: [PATCH 08/11] mach-snapdragon: Integrate reboot-mode handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-pm8916-pon-v1-8-170c9cbe5099@samcday.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=3020;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=0WlTT8AEvmN650XdUlk6qx9h2kaVLx+Xcz/Pldn7PFw=;
 b=6ze8RW6YjXGlwejPD/sDVaBRBQxicAWkG8g9TZQcaTl3SJ3MGEDnaJVH1X1J4DFZjetarkLW1
 SK+stPbj+krCb3c9uSacHIsMZlMXpaSBvTeoHKWvNO0/I74qThV7YBI
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Add reboot-mode detection and automatic fastboot entry to Qualcomm board
initialization. This enables 'reboot bootloader' functionality on
platforms with reboot-mode device tree configuration.

Changes:
- Add qcom_handle_reboot_mode() call in board_late_init()
- Conditionally compile with CONFIG_DM_REBOOT_MODE
- Reorganize header includes

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-snapdragon/board.c | 56 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..c37195def57 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -9,6 +9,15 @@
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
 
+#include <command.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <lmb.h>
+#include <malloc.h>
+#include <sort.h>
+#include <time.h>
+#include <usb.h>
 #include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -16,22 +25,14 @@
 #include <asm/system.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
-#include <dm/uclass-internal.h>
 #include <dm/read.h>
-#include <power/regulator.h>
-#include <env.h>
-#include <fdt_support.h>
-#include <init.h>
+#include <dm/uclass-internal.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
-#include <lmb.h>
-#include <malloc.h>
-#include <fdt_support.h>
-#include <usb.h>
-#include <sort.h>
-#include <time.h>
+#include <power/regulator.h>
+#include <reboot-mode/reboot-mode.h>
 
 #include "qcom-priv.h"
 
@@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
 	env_set("boot_source", name);
 }
 
+/**
+ * qcom_handle_reboot_mode() - Process reboot-mode detection and handle fastboot entry
+ *
+ * This function detects the reboot reason from PMIC registers and automatically
+ * enters fastboot mode if the reboot reason was "bootloader".
+ */
+static void qcom_handle_reboot_mode(void)
+{
+	struct udevice *reboot_dev;
+	const char *reboot_mode;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &reboot_dev);
+	if (ret)
+		return;
+
+	ret = dm_reboot_mode_update(reboot_dev);
+	if (ret)
+		return;
+
+	reboot_mode = env_get("reboot-mode");
+	if (reboot_mode && !strcmp(reboot_mode, "bootloader")) {
+		printf("Entering fastboot mode due to reboot reason...\n");
+		run_command("run fastboot", 0);
+	}
+}
+
 void __weak qcom_late_init(void)
 {
 }
@@ -575,6 +603,12 @@ int board_late_init(void)
 	qcom_late_init();
 
 	qcom_show_boot_source();
+
+	/* Handle reboot-mode detection and fastboot entry */
+#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
+	qcom_handle_reboot_mode();
+#endif
+
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 

-- 
2.54.0


