Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0633ECAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBDB838C2;
	Fri,  3 Oct 2025 18:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IqLckMYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB623838C2; Fri,  3 Oct 2025 18:34:43 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8783838AE
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8FA554E40EA5;
 Fri,  3 Oct 2025 16:34:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 60E3560683;
 Fri,  3 Oct 2025 16:34:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99006102F17C4; 
 Fri,  3 Oct 2025 18:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509280; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ywvMn/fYDjYkyA/DjbAlGckCKsfFNXKwaTn4g2+p1h8=;
 b=IqLckMYj80VOHXunOkeUz1tsljzms3UBpqZ4UNxFzyWMBHxB6ro0kufK7403e07TsouLfz
 iqDFM5kOHYwoqQNGKcXczsOt4s8YgPjM5nvyRPRQzlRxnw8K9S1eAGhp1d7leTIlcSd76i
 IhxzbkAki2uDvSbmSxtKyqlijYlBIuneBYqbTRtZJpiC9jIyAFye5iwx9d2vbv2VRiDzVn
 VbHn08rwEMX1KBDpAz+zFRBHpKfY423UGeemaB//NGf/nCbwaYTn+R4uK09RWQedhGSZDI
 MlJNKpDxH9J/7x5HaTVHmg3JOPxTcUszr9qyAcZtQkSIEY4TH6e6lgivuKYnqw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:51 +0200
Subject: [PATCH 11/16] board: compulab: Convert imx8mm-cl-iot-gate to
 UCLASS extension framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-11-458b8bf85325@bootlin.com>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/mach-imx/imx8m/Kconfig                    |  4 +-
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        | 60 ++++++++++------------
 2 files changed, 30 insertions(+), 34 deletions(-)

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
index bda7aac5be4..4fc87944810 100644
--- a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
+++ b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
@@ -434,9 +434,9 @@ static int iot_gate_imx8_update_ext_ied(void)
 	return 0;
 }
 
-int extension_board_scan(struct list_head *extension_list)
+static int iot_gate_imx8_extension_board_scan(struct list_head *extension_list)
 {
-	struct extension *extension = NULL;
+	struct extension extension = {0}, *_extension = NULL;
 	int i;
 	int ret = 0;
 
@@ -446,25 +446,21 @@ int extension_board_scan(struct list_head *extension_list)
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
@@ -473,9 +469,11 @@ int extension_board_scan(struct list_head *extension_list)
 	}
 
 	if (extension) {
-		snprintf(extension->owner, sizeof(extension->owner),
+		snprintf(extension.owner, sizeof(extension.owner),
 			 "Compulab");
-		list_add_tail(&extension->list, extension_list);
+		_estension = alist_add(extension_list, extension);
+		if (!_extension)
+			return -ENOMEM;
 		ret = 1;
 	} else
 		return ret;
@@ -484,44 +482,38 @@ int extension_board_scan(struct list_head *extension_list)
 
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
@@ -530,11 +522,13 @@ int extension_board_scan(struct list_head *extension_list)
 			break;
 		}
 		if (extension) {
-			snprintf(extension->owner, sizeof(extension->owner),
+			snprintf(extension.owner, sizeof(extension.owner),
 				 "Compulab");
-			snprintf(extension->other, sizeof(extension->other),
+			snprintf(extension.other, sizeof(extension.other),
 				 "On slot %d", i);
-			list_add_tail(&extension->list, extension_list);
+			_extension = alist_add(extension_list, extension);
+			if (!_extension)
+				return -ENOMEM;
 			ret = ret + 1;
 		}
 	}
@@ -542,6 +536,8 @@ int extension_board_scan(struct list_head *extension_list)
         return ret;
 }
 
+U_BOOT_EXTENSION(iot_gate_imx8_extension, iot_gate_imx8_extension_board_scan);
+
 static int setup_mac_address(void)
 {
 	unsigned char enetaddr[6];

-- 
2.43.0

