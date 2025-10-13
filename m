Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704FBCCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7707F83993;
	Mon, 13 Oct 2025 15:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nx6i8Yrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3D2839B5; Mon, 13 Oct 2025 15:33:04 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A202839A7
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B8A4F4E41067;
 Mon, 13 Oct 2025 13:33:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8CD30606C6;
 Mon, 13 Oct 2025 13:33:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5AD01102F226E; 
 Mon, 13 Oct 2025 15:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760362380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MbK6KBfXLx1BzQGK+3BDEnBi9am5ZVPF5vk3b6/9LYE=;
 b=nx6i8YrsLFk5Vk5vT/Zh5iNtG5DMGvBV6WLhCr6/HZRkYW7gdWYKNybgtffFFsGRXcngKn
 EgVVU80uZ0psXk5CAT2HUHiBoJiR9OUFj78EYsJXy5qNjuVnPoRsf53hDHUO3nBqq0RZk+
 TtwF1N2HDibwyV/MwDMq9tzWgvOKZsL8dQgUASLFjGWR7cOkDXcTtcf52YQG3ZXz7pPnZE
 tBaqyp/jhCtUGp04I9u7gmPm2HUrzHnA8KFYNt5ievY4evVXOEKhmR3JPDiObzxSjNfDJw
 GHkHzIALXdFpesBC6hCfgpyCAL2QJnpA8XxyOjUA9wDAtNt5HVEkI2ULUjgAxQ==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 15:32:36 +0200
Subject: [PATCH v3 11/20] board: sunxi: Refactor CHIP board extension code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_sysboot_extension_board-v3-11-04067b7422a5@bootlin.com>
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

Clean up and improve code structure in the sunxi CHIP board extension
detection implementation.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Changes in v2:
- Fix a build error.
---
 board/sunxi/chip.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
index 270af2506d2..5e5ec0d1d89 100644
--- a/board/sunxi/chip.c
+++ b/board/sunxi/chip.c
@@ -42,14 +42,9 @@ struct dip_w1_header {
 
 int extension_board_scan(struct list_head *extension_list)
 {
-	struct extension *dip;
-	struct dip_w1_header w1_header;
 	struct udevice *bus, *dev;
-	u32 vid;
-	u16 pid;
-	int ret;
-
 	int num_dip = 0;
+	int ret;
 
 	sunxi_gpio_set_pull(SUNXI_GPD(2), SUNXI_GPIO_PULL_UP);
 
@@ -60,6 +55,11 @@ int extension_board_scan(struct list_head *extension_list)
 	}
 
 	for_each_w1_device(bus, &dev) {
+		struct dip_w1_header w1_header;
+		struct extension *dip;
+		u32 vid;
+		u16 pid;
+
 		if (w1_get_device_family(dev) != W1_FAMILY_DS2431)
 			continue;
 
@@ -90,8 +90,8 @@ int extension_board_scan(struct list_head *extension_list)
 
 		snprintf(dip->overlay, sizeof(dip->overlay), "dip-%x-%x.dtbo",
 			 vid, pid);
-		strncpy(dip->name, w1_header.product_name, 32);
-		strncpy(dip->owner, w1_header.vendor_name, 32);
+		strlcpy(dip->name, w1_header.product_name, sizeof(dip->name));
+		strlcpy(dip->owner, w1_header.vendor_name, sizeof(dip->owner));
 		list_add_tail(&dip->list, extension_list);
 		num_dip++;
 	}

-- 
2.43.0

