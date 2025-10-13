Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59591CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9328F83965;
	Mon, 13 Oct 2025 15:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="J29bMF2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0231838C8; Mon, 13 Oct 2025 15:32:52 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4ABB837E4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 972351A133F;
 Mon, 13 Oct 2025 13:32:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5BF06606C6;
 Mon, 13 Oct 2025 13:32:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C0196102F226B; 
 Mon, 13 Oct 2025 15:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362369; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xzoraGGJgEqQuNHekZnl4hEycWCNX9PtwdbLouuW+to=;
 b=J29bMF2Z1aUr5wOYnCGinH5AfJBS8eXFS4f/rT/o/+C8/F2h+eG2O68zfHcIvxgtysfh2L
 yot/XJ+J3Or7Y8YYSuPM5Y0Qjd8jUZW30VsNYctnzOopkoVWZs/+d+qgleSEoPXNPQLpKl
 qgTE4YTw1O/Azrv+9j4laQCt9nXuMEsol8tE7qVOpEkDgAN1xx/ahf7NaTJZ3qpjemdG37
 ZJkEr1/n88jv9I9qGqCr+984GgnbUtupA7JyZzQMpGT/LvEZzleQF3hlybH4R2n1d3f/ju
 RyQtArFAKqBVlhFVqRZosQrG8OotHitkK9lODlr1rYuRmrfMMGaPnOAnRNAbVQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:30 +0200
Subject: [PATCH v3 05/20] board: compulab: Exclude compulab extension board
 detection from XPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-5-04067b7422a5@bootlin.com>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
In-Reply-To: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
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

Disable compulab extension board detection functionality in XPL (eXtended
Program Loader) images to reduce size and complexity in the early boot
stage.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v2:
- New patch.
---
 board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
index bda7aac5be4..be4f293bd4a 100644
--- a/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
+++ b/board/compulab/imx8mm-cl-iot-gate/imx8mm-cl-iot-gate.c
@@ -249,6 +249,8 @@ int board_mmc_get_env_dev(int devno)
 #define IOT_GATE_IMX8_EXT_I2C_ADDR_GPIO 0x22 /* I2C address of the GPIO
 						extender */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 static int iot_gate_imx8_ext_id = IOT_GATE_EXT_EMPTY; /* Extension board ID */
 static int iot_gate_imx8_ext_ied_id [3] = {
 	IOT_GATE_IMX8_CARD_ID_EMPTY,
@@ -541,6 +543,7 @@ int extension_board_scan(struct list_head *extension_list)
 
         return ret;
 }
+#endif
 
 static int setup_mac_address(void)
 {

-- 
2.43.0

