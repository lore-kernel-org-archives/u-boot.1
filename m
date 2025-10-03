Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2758CCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A70683893;
	Fri,  3 Oct 2025 18:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="m3RqmjeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF08483893; Fri,  3 Oct 2025 18:34:35 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDDDB83759
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7DB761A10EA;
 Fri,  3 Oct 2025 16:34:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4C57960683;
 Fri,  3 Oct 2025 16:34:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 85CEA102F1CFA; 
 Fri,  3 Oct 2025 18:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509272; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fRZpRjAGAro7d1+81Gr6iOqcUxbAcKpKQUGk8a6Srs0=;
 b=m3RqmjeOTozC2et91zqAGHe9le51sTvBdiJiIVKCU/gEWnnI60JcIQDz5qCBARJszufpQK
 1tLlwMdlEGn1G0tjxuQSetsHmXSh1DcrxB+Q9wtoCw76XMTBDIoHV1Su1cXNfvJOrGrIxa
 MztooiCOj1X8N9UYw8qlWzR9HATW25gZjjXAIaMbgLkdFzBoxr29KbSQklWdiS2j2DkHrq
 z5+r/lvJgMzPKDpdqC4u0lJcVYDeBI26gPkpuI8IFMWY35WcTi81itvcAzYNO/kZjyM9tv
 fD5ewgsWpzfU3nfcG/BT1/9OsdykHEVi0NGgKeMfi4sNM4M6QIbRketjLbtcZA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:48 +0200
Subject: [PATCH 08/16] board: sunxi: Convert extension support to UCLASS
 framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-8-458b8bf85325@bootlin.com>
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

Migrate sunxi board extension detection from legacy implementation to
the new UCLASS-based extension board framework.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/mach-sunxi/Kconfig |  2 +-
 board/sunxi/chip.c          | 17 ++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b04ec671696..f5696199516 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1223,7 +1223,7 @@ config BLUETOOTH_DT_DEVICE_FIXUP
 
 config CHIP_DIP_SCAN
 	bool "Enable DIPs detection for CHIP board"
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_DM_EXTENSION_SCAN
 	select W1
 	select W1_GPIO
 	select W1_EEPROM
diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
index ea0d3a56f5f..183b8ded170 100644
--- a/board/sunxi/chip.c
+++ b/board/sunxi/chip.c
@@ -40,7 +40,7 @@ struct dip_w1_header {
 	u8      data[16];               /* user data, per-dip specific */
 } __packed;
 
-int extension_board_scan(struct list_head *extension_list)
+static int sunxi_extension_board_scan(struct alist *extension_list)
 {
 	struct udevice *bus, *dev;
 	int num_dip = 0;
@@ -54,6 +54,7 @@ int extension_board_scan(struct list_head *extension_list)
 	}
 
 	for_each_w1_device(bus, &dev) {
+		struct extension dip = {0}, *_dip;
 		struct dip_w1_header w1_header;
 		struct extension *dip;
 		u32 vid;
@@ -82,18 +83,16 @@ int extension_board_scan(struct list_head *extension_list)
 		       w1_header.product_name, pid,
 		       w1_header.vendor_name, vid);
 
-		dip = calloc(1, sizeof(struct extension));
-		if (!dip) {
-			printf("Error in memory allocation\n");
-			return num_dip;
-		}
-
-		snprintf(dip->overlay, sizeof(dip->overlay), "dip-%x-%x.dtbo",
+		snprintf(dip.overlay, sizeof(dip.overlay), "dip-%x-%x.dtbo",
 			 vid, pid);
 		strlcpy(dip->name, w1_header.product_name, sizeof(dip->name));
 		strlcpy(dip->owner, w1_header.vendor_name, sizeof(dip->owner));
-		list_add_tail(&dip->list, extension_list);
+		_dip = alist_add(extension_list, dip);
+		if (!_dip)
+			return -ENOMEM;
 		num_dip++;
 	}
 	return num_dip;
 }
+
+U_BOOT_EXTENSION(dip, sunxi_extension_board_scan);

-- 
2.43.0

