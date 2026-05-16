Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6812CD4851
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 03:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E84846CE;
	Sun, 17 May 2026 05:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="vAB4VR3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162F4846AE; Sat, 16 May 2026 20:21:29 +0200 (CEST)
Received: from mxd-2-a08.seznam.cz (mxd-2-a08.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C16B28469D
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 20:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-f659df87d-k746b
 (smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
 id 499699c01298cda9483f559e; Sat, 16 May 2026 20:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778955642; bh=7NIqaG3XoX/YXKTYqapxQDeS9K6M234BGMic1B0jzDk=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=vAB4VR3GoZNSIAZiXlMLe9BGRn6gkFn/RoY7Eq+6frX4VNrwiU2ZSlj73aDthG5PN
 JJSYnjZehiW4YvvBZlHitm38nY3cnIPB8jReAol24g3XYP1+dAoSMYrBInZvgsmQ3s
 X6DJW4UTgyMkQjUL5W8cQ8WH/dL3rQBuFbsUZLoYDIjaTJXYiI3UJgD6UTfdMwxzoj
 i0k37Te5kIBmLhnT3xAra1IJ+pou1f0q3qFY3TGJ8gFnB+W90CPtcKFLLo/tiowIeW
 ZlXiJq/JqQZBGhe2Ck5CLxv+g1BHfiKQrOEJVEzGqgcwnlvil7qmZldwUgcADQpO4u
 Jfm7uqhVsu7JQ==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-745c4d9bbb-4gnxc (szn-email-smtpd/2.0.73) with ESMTPA
 id 36ec9091-32f3-4b4e-8aad-2074691af476;
 Sat, 16 May 2026 20:20:35 +0200
From: michael.srba@seznam.cz
Date: Sat, 16 May 2026 20:19:58 +0200
Subject: [PATCH v8 09/12] mach-snapdragon: move board_usb_init to
 dragonboard410c.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-qcom_spl-v8-9-69b55c9abffe@seznam.cz>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
In-Reply-To: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 17 May 2026 05:15:41 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

This function is currently only really needed on db410c,
move it to the board-specific .c file ahead of introducing
board_spl.c to simplify things. If db410c is to ever be
converted to not use board-spefific funtions, the generic
solution replacing this function should probably not be
Qualcomm-specific anyway.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 arch/arm/mach-snapdragon/board.c                 | 45 +-----------------------
 board/qualcomm/dragonboard410c/dragonboard410c.c | 41 +++++++++++++++++++++
 2 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 63055a60af4..b55d73e0e52 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -10,14 +10,10 @@
 #define pr_fmt(fmt) "QCOM: " fmt
 
 #include <asm/armv8/mmu.h>
-#include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/system.h>
-#include <dm/device.h>
-#include <dm/pinctrl.h>
-#include <dm/uclass-internal.h>
-#include <dm/read.h>
+#include <dm/ofnode.h>
 #include <power/regulator.h>
 #include <env.h>
 #include <fdt_support.h>
@@ -29,7 +25,6 @@
 #include <lmb.h>
 #include <malloc.h>
 #include <fdt_support.h>
-#include <usb.h>
 #include <soc/qcom/smem.h>
 #include <sort.h>
 #include <soc/qcom/smem.h>
@@ -151,44 +146,6 @@ int board_fdt_blob_setup(void **fdtp)
 	return ret;
 }
 
-/*
- * Some Qualcomm boards require GPIO configuration when switching USB modes.
- * Support setting this configuration via pinctrl state.
- */
-int board_usb_init(int index, enum usb_init_type init)
-{
-	struct udevice *usb;
-	int ret = 0;
-
-	/* USB device */
-	ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
-	if (ret) {
-		printf("Cannot find USB device\n");
-		return ret;
-	}
-
-	ret = dev_read_stringlist_search(usb, "pinctrl-names",
-					 "device");
-	/* No "device" pinctrl state, so just bail */
-	if (ret < 0)
-		return 0;
-
-	/* Select "default" or "device" pinctrl */
-	switch (init) {
-	case USB_INIT_HOST:
-		pinctrl_select_state(usb, "default");
-		break;
-	case USB_INIT_DEVICE:
-		pinctrl_select_state(usb, "device");
-		break;
-	default:
-		debug("Unknown usb_init_type %d\n", init);
-		break;
-	}
-
-	return 0;
-}
-
 /*
  * Some boards still need board specific init code, they can implement that by
  * overriding this function.
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 36e4d49046e..3c0d1cbb2d8 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -8,7 +8,10 @@
 #include <button.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/device.h>
 #include <dm/pinctrl.h>
+#include <dm/read.h>
+#include <dm/uclass-internal.h>
 #include <env.h>
 #include <init.h>
 #include <mmc.h>
@@ -19,6 +22,44 @@
 #include <fdt_support.h>
 #include <linux/delay.h>
 
+/*
+ * db410c requires GPIO configuration when switching USB modes.
+ * Support setting this configuration via pinctrl state.
+ */
+int board_usb_init(int index, enum usb_init_type init)
+{
+	struct udevice *usb;
+	int ret = 0;
+
+	/* USB device */
+	ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
+	if (ret) {
+		printf("Cannot find USB device\n");
+		return ret;
+	}
+
+	ret = dev_read_stringlist_search(usb, "pinctrl-names",
+					 "device");
+	/* No "device" pinctrl state, so just bail */
+	if (ret < 0)
+		return 0;
+
+	/* Select "default" or "device" pinctrl */
+	switch (init) {
+	case USB_INIT_HOST:
+		pinctrl_select_state(usb, "default");
+		break;
+	case USB_INIT_DEVICE:
+		pinctrl_select_state(usb, "device");
+		break;
+	default:
+		debug("Unknown usb_init_type %d\n", init);
+		break;
+	}
+
+	return 0;
+}
+
 static u32 msm_board_serial(void)
 {
 	struct mmc *mmc_dev;

-- 
2.54.0

