Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E9CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2313C84584;
	Thu,  9 Oct 2025 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vLtSKLRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC5B8459C; Thu,  9 Oct 2025 16:51:26 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6FA83F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DF2F94E40FB4;
 Thu,  9 Oct 2025 14:51:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B6D316062C;
 Thu,  9 Oct 2025 14:51:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 679AD102F21E2; 
 Thu,  9 Oct 2025 16:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021482; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=yNbIjdNMMbGFyh48zUFCjXeq7/aHFRhnlKQlRLOOMrA=;
 b=vLtSKLRp4Plp9qY/FmY4I0r2SQgoQSERFSqhNRdISMRCW06OdD0/ES9J7EU/Ex6ens9hmv
 Ie8SIVo8YoOUzU1HJNF49JoCjcvmdf2ppBJNZXJNDA/65nFuBVPlaQzwOKwywyJtueQEfB
 1gfoK6Q02PJAkPxBhw8xQudIhX/JN6DdpnC5e7LV62QnspSg4rxRrAd0MeBgaEui9txAAA
 Wm1POduWfNuCxJ2WZQD7MUnEH5FFA6+9DsybKRGzqBgrlMrpZHVQZ1lsqM07L3XINz43xR
 IgWZhdBB4zvLvkc/oqzEndSxKTvAa/nH6XmO/VL6gw0bJJBiNgCQbq9uqM8Cyw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:49 +0200
Subject: [PATCH v2 13/18] board: compulab: Convert imx8mm-cl-iot-gate to
 UCLASS extension framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-13-e09b39e54de5@bootlin.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
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

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v2:
- Fix build errors.
---
 arch/arm/mach-imx/imx8m/Kconfig                    |  4 +-
 .../imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c        | 64 ++++++++++------------
 2 files changed, 32 insertions(+), 36 deletions(-)

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
index be4f293bd4a..e6f0c374067 100644
--- a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
+++ b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
@@ -436,9 +436,9 @@ static int iot_gate_imx8_update_ext_ied(void)
 	return 0;
 }
 
-int extension_board_scan(struct list_head *extension_list)
+static int iot_gate_imx8_extension_board_scan(struct alist *extension_list)
 {
-	struct extension *extension = NULL;
+	struct extension extension = {0}, *_extension = NULL;
 	int i;
 	int ret = 0;
 
@@ -448,25 +448,21 @@ int extension_board_scan(struct list_head *extension_list)
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
@@ -474,10 +470,12 @@ int extension_board_scan(struct list_head *extension_list)
 		break;
 	}
 
-	if (extension) {
-		snprintf(extension->owner, sizeof(extension->owner),
+	if (extension.name[0]) {
+		snprintf(extension.owner, sizeof(extension.owner),
 			 "Compulab");
-		list_add_tail(&extension->list, extension_list);
+		_extension = alist_add(extension_list, extension);
+		if (!_extension)
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
@@ -531,18 +523,22 @@ int extension_board_scan(struct list_head *extension_list)
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
+			_extension = alist_add(extension_list, extension);
+			if (!_extension)
+				return -ENOMEM;
 			ret = ret + 1;
 		}
 	}
 
         return ret;
 }
+
+U_BOOT_EXTENSION(iot_gate_imx8_extension, iot_gate_imx8_extension_board_scan);
 #endif
 
 static int setup_mac_address(void)

-- 
2.43.0

