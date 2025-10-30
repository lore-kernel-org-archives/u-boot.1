Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD48ACCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF7E83990;
	Thu, 30 Oct 2025 17:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lvtCnAk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB300839CC; Thu, 30 Oct 2025 17:45:42 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9627839B9
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8B2FD4E413FD;
 Thu, 30 Oct 2025 16:45:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 61F1660331;
 Thu, 30 Oct 2025 16:45:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DBEFA11808CA3; Thu, 30 Oct 2025 17:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842739; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qjm1W21DMccriZMOqUwb/KayRALQj5Hipu9KNl9rgNA=;
 b=lvtCnAk2Es+bJ7Kero5xxNJ3eJ87Pz0hvU1cP7xgv72KAL6czFaeeX+0x9uKZirOg6KuU+
 33iHffQuX+vQLAAfTRACWHwNJc67Swso9ptezt09hpG0DXmeub8d/XQfGrZgDx9KTGRMSq
 qsNxBZjVjHeJD4oNcj5RjemPeJBOrQQXjw0rKx0ETBflI9t6Mk+1oITVqGyDTu/FOjQYQt
 U0oxUACfarDV44hx9Xfh/IMxSCsfbtax3PKcoQDCzC1Mbt/Struwt8YqmGqf8xQ6r8S91c
 8BzDlOjCzZA3QPpip/cEL4bTrqqGRUWPMX+21KL2dKOTTP776qOY3oJOqcT7ag==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:08 +0100
Subject: [PATCH v5 15/20] board: compulab: Convert imx8mm-cl-iot-gate to
 UCLASS extension framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-15-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

Migrate CompuLab imx8mm-cl-iot-gate board extension detection from legacy
implementation to the new UCLASS-based extension board framework.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v3:
- Use U_BOOT_DRVINFO.

Change in v2:
- Fix build errors.
---
 arch/arm/mach-imx/imx8m/Kconfig                    |  4 +-
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        | 67 +++++++++++-----------
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index e7bc154b805..5324eff3084 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -359,14 +359,14 @@ config TARGET_IMX8MM_CL_IOT_GATE
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_DM_EXTENSION_SCAN
 
 config TARGET_IMX8MM_CL_IOT_GATE_OPTEE
 	bool "CompuLab iot-gate-imx8 with optee support"
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_DM_EXTENSION_SCAN
 
 config TARGET_IMX8MP_RSB3720A1_4G
 	bool "Support i.MX8MP RSB3720A1 4G"
diff --git a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
index be4f293bd4a..260d8757129 100644
--- a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
+++ b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
@@ -436,9 +436,10 @@ static int iot_gate_imx8_update_ext_ied(void)
 	return 0;
 }
 
-int extension_board_scan(struct list_head *extension_list)
+static int iot_gate_imx8_extension_board_scan(struct udevice *dev,
+					      struct alist *extension_list)
 {
-	struct extension *extension = NULL;
+	struct extension extension = {0};
 	int i;
 	int ret = 0;
 
@@ -448,25 +449,21 @@ int extension_board_scan(struct list_head *extension_list)
 	case IOT_GATE_EXT_EMPTY:
 		break;
 	case IOT_GATE_EXT_CAN:
-		extension = calloc(1, sizeof(struct extension));
-		snprintf(extension->name, sizeof(extension->name),
+		snprintf(extension.name, sizeof(extension.name),
 			 "IOT_GATE_EXT_CAN");
 		break;
 	case IOT_GATE_EXT_IED:
-		extension = calloc(1, sizeof(struct extension));
-		snprintf(extension->name, sizeof(extension->name),
+		snprintf(extension.name, sizeof(extension.name),
 			 "IOT_GATE_EXT_IED");
-		snprintf(extension->overlay, sizeof(extension->overlay),
+		snprintf(extension.overlay, sizeof(extension.overlay),
 			 "imx8mm-cl-iot-gate-ied.dtbo");
 		break;
 	case IOT_GATE_EXT_POE:
-		extension = calloc(1, sizeof(struct extension));
-		snprintf(extension->name, sizeof(extension->name),
+		snprintf(extension.name, sizeof(extension.name),
 			 "IOT_GATE_EXT_POE");
 		break;
 	case IOT_GATE_EXT_POEV2:
-		extension = calloc(1, sizeof(struct extension));
-		snprintf(extension->name, sizeof(extension->name),
+		snprintf(extension.name, sizeof(extension.name),
 			 "IOT_GATE_EXT_POEV2");
 		break;
 	default:
@@ -474,10 +471,11 @@ int extension_board_scan(struct list_head *extension_list)
 		break;
 	}
 
-	if (extension) {
-		snprintf(extension->owner, sizeof(extension->owner),
+	if (extension.name[0]) {
+		snprintf(extension.owner, sizeof(extension.owner),
 			 "Compulab");
-		list_add_tail(&extension->list, extension_list);
+		if (!alist_add(extension_list, extension))
+			return -ENOMEM;
 		ret = 1;
 	} else
 		return ret;
@@ -486,44 +484,38 @@ int extension_board_scan(struct list_head *extension_list)
 
 	iot_gate_imx8_update_ext_ied();
 	for (i=0; i<ARRAY_SIZE(iot_gate_imx8_ext_ied_id); i++) {
-		extension = NULL;
+		memset(&extension, 0, sizeof(extension));
 		switch (iot_gate_imx8_ext_ied_id[i]) {
 		case IOT_GATE_IMX8_CARD_ID_EMPTY:
 			break;
 		case IOT_GATE_IMX8_CARD_ID_RS_485:
-			extension = calloc(1, sizeof(struct extension));
-			snprintf(extension->name, sizeof(extension->name),
+			snprintf(extension.name, sizeof(extension.name),
 				 "IOT_GATE_IMX8_CARD_ID_RS_485");
 			break;
 		case IOT_GATE_IMX8_CARD_ID_RS_232:
-			extension = calloc(1, sizeof(struct extension));
-			snprintf(extension->name, sizeof(extension->name),
+			snprintf(extension.name, sizeof(extension.name),
 				 "IOT_GATE_IMX8_CARD_ID_RS_232");
 			break;
 		case IOT_GATE_IMX8_CARD_ID_CAN:
-			extension = calloc(1, sizeof(struct extension));
-			snprintf(extension->name, sizeof(extension->name),
+			snprintf(extension.name, sizeof(extension.name),
 				 "IOT_GATE_IMX8_CARD_ID_CAN");
-			snprintf(extension->overlay, sizeof(extension->overlay),
+			snprintf(extension.overlay, sizeof(extension.overlay),
 				 "imx8mm-cl-iot-gate-ied-can%d.dtbo", i);
 			break;
 		case IOT_GATE_IMX8_CARD_ID_TPM:
-			extension = calloc(1, sizeof(struct extension));
-			snprintf(extension->name, sizeof(extension->name),
+			snprintf(extension.name, sizeof(extension.name),
 				 "IOT_GATE_IMX8_CARD_ID_TPM");
-			snprintf(extension->overlay, sizeof(extension->overlay),
+			snprintf(extension.overlay, sizeof(extension.overlay),
 				 "imx8mm-cl-iot-gate-ied-tpm%d.dtbo", i);
 			break;
 		case IOT_GATE_IMX8_CARD_ID_CL420:
-			extension = calloc(1, sizeof(struct extension));
-			snprintf(extension->name, sizeof(extension->name),
+			snprintf(extension.name, sizeof(extension.name),
 				 "IOT_GATE_IMX8_CARD_ID_CL420");
-			snprintf(extension->overlay, sizeof(extension->overlay),
+			snprintf(extension.overlay, sizeof(extension.overlay),
 				 "imx8mm-cl-iot-gate-ied-can%d.dtbo", i);
 			break;
 		case IOT_GATE_IMX8_CARD_ID_DI4O4:
-			extension = calloc(1, sizeof(struct extension));
-			snprintf(extension->name, sizeof(extension->name),
+			snprintf(extension.name, sizeof(extension.name),
 				 "IOT_GATE_IMX8_CARD_ID_DI4O4");
 			break;
 		default:
@@ -531,18 +523,25 @@ int extension_board_scan(struct list_head *extension_list)
 			       __func__, i, iot_gate_imx8_ext_ied_id[i]);
 			break;
 		}
-		if (extension) {
-			snprintf(extension->owner, sizeof(extension->owner),
+		if (extension.name[0]) {
+			snprintf(extension.owner, sizeof(extension.owner),
 				 "Compulab");
-			snprintf(extension->other, sizeof(extension->other),
+			snprintf(extension.other, sizeof(extension.other),
 				 "On slot %d", i);
-			list_add_tail(&extension->list, extension_list);
+			if (!alist_add(extension_list, extension))
+				return -ENOMEM;
 			ret = ret + 1;
 		}
 	}
 
         return ret;
 }
+
+U_BOOT_EXTENSION(iot_gate_imx8_extension, iot_gate_imx8_extension_board_scan);
+
+U_BOOT_DRVINFO(iot_gate_imx8_extension) = {
+	.name = "iot_gate_imx8_extension",
+};
 #endif
 
 static int setup_mac_address(void)

-- 
2.43.0

