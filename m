Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1587CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D115684592;
	Thu,  9 Oct 2025 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="meG3tFTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2385D83F0A; Thu,  9 Oct 2025 16:51:24 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4400384584
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F1E921A1243;
 Thu,  9 Oct 2025 14:51:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C76D06062C;
 Thu,  9 Oct 2025 14:51:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 88B4A102F21F0; 
 Thu,  9 Oct 2025 16:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021481; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xzoraGGJgEqQuNHekZnl4hEycWCNX9PtwdbLouuW+to=;
 b=meG3tFTrnPH+Rm25xQX0t2f4sk85WXPNkIVNXGS01agTN8nLvUvqW11uLNM7MDTkrOYVNL
 sxR1A2thh+RyQLdv+ljS1KGVjh3/SuV/xvbo83RAdgT+5dsD8coSNgD5kOp9o9ma4XAM+6
 LDH9ynBmgKl+d2lFcOSCA7L5JxRhOb12do8KhfwmVYIHYgZg02oK2XSrstpo4AJEiX4Qfd
 kHc/H+d0M4M/QYdjPDkUTKJLmvelW3Bj3iFyKLQM7jE/lCHhFnCCXkYtCv0tUZ4L/s9goa
 +5/HzkeFwzISI24s0nU/uNovcf4iooDXZfF0Q+6SR1zorb7YgkfREi2FIH9XqA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:48 +0200
Subject: [PATCH v2 12/18] board: compulab: Exclude compulab extension board
 detection from XPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-12-e09b39e54de5@bootlin.com>
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

