Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAAECCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B4F83948;
	Thu, 30 Oct 2025 17:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HLXrwxI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7123D8393D; Thu, 30 Oct 2025 17:45:22 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D89E838E5
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 307391A1757;
 Thu, 30 Oct 2025 16:45:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0703F60331;
 Thu, 30 Oct 2025 16:45:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D3C611808CA5; Thu, 30 Oct 2025 17:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xzoraGGJgEqQuNHekZnl4hEycWCNX9PtwdbLouuW+to=;
 b=HLXrwxI5CBdMvlCnzOAnWAffy2VlsIybuD5+CQ8BPbXMGxtYNlj2rwOtz0VRPwDoZ1ZJg0
 0eC+EAjmlImXXkI7j4GKeZasHBvtbPXGwQXk/6Hb8vSh64k2AXeAMYVa52rqCS7KjWUO3B
 wrFIZzBncYxGg0HFZPxUknX7n97TfetYgOfDSuH2Xe9K4Q7+vEZDY7D4ZXfRijO09iKE97
 rIACBE9GmXe60D87grvvIoBEp+5+y5coCQrp0hpJ02H6IXBVsyvXTqpcxKELAKBPuLh+Vk
 LH5Ow59aDx6PS6nw7JA0SfG/2YDXgE9EZ3y9EJ9pOXhT8YYrMHy86HHNOCZvjw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:44:58 +0100
Subject: [PATCH v5 05/20] board: compulab: Exclude compulab extension board
 detection from XPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-5-cfb77672fc68@bootlin.com>
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

