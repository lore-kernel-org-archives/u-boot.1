Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B7E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 18:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17885806EB;
	Fri, 10 Jan 2025 19:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SuQk4fPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565C78060C; Fri, 10 Jan 2025 19:43:08 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405E180050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 19:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29C3460012;
 Fri, 10 Jan 2025 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1736534585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CO3s4b4+EMdgrbO5U0rGfv4tRRunrIXEJ+s6J9U4NbU=;
 b=SuQk4fPqclBD/sKzrzS2E4kfgrTVJ0A+Pk2Je8Ce6wCIXUfNiQL6ng2i153pe8UYVeETrX
 5L1/cha49CUNcQ6C1LFH6XBWZVxF01yM4F4OSUey6ilfF64uo+FpPZ1ZrsBW0YnGCZt5iQ
 1BcYrex7WbJVOgLuGGT0IVL8bIsjBmUMov/giIM7nAlIlEbCt9XwEp4grxDRpu8gTUesBE
 9HxBxeNyjIWNohHO8ppFzWcbYnx/GLo8bZIVHuwlB/ljTFqCdmUm65y4q+IIX++VRS1IFg
 XYcKYFQtwh+bQvvnzNnmn95OUOasyQd9nF8jQJIDKnC6fR6sRem3CbDlAJ+TSQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 19:43:01 +0100
Subject: [PATCH v3 04/13] test: dm: test-fdt: Add checks for
 uclass_get_device_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-ge-mainline-display-support-v3-4-d2c0acea6feb@bootlin.com>
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
In-Reply-To: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

This is a new DM core helper. There is now a graph endpoint
representation in the sandbox test DTS, so we can just use it to verify
the helper proper behavior.

Suggested-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 configs/sandbox64_defconfig        |  1 +
 configs/sandbox_flattree_defconfig |  1 +
 test/dm/test-fdt.c                 | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 7960b2ef42e7ceee2a3646888ae159cdde9b59e0..359c12b88c904c995ca63bf3c17324c8eb02257a 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -256,6 +256,7 @@ CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_I2C_EDID=y
 CONFIG_VIDEO_SANDBOX_SDL=y
+CONFIG_VIDEO_DSI_HOST_SANDBOX=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_BMP_16BPP=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 563093dd8a426f98cdcfa342655bebb82dbefe86..f08dfef9056c4a2c86650f43298b3f506fae8d4c 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -220,6 +220,7 @@ CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_I2C_EDID=y
 CONFIG_VIDEO_SANDBOX_SDL=y
+CONFIG_VIDEO_DSI_HOST_SANDBOX=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_BMP_16BPP=y
diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index af8cd617108ac2421f7275948be000a7cbaebda0..e3c8c07066a00d55b2319e8f028b8ce9906efe28 100644
--- a/test/dm/test-fdt.c
+++ b/test/dm/test-fdt.c
@@ -792,7 +792,7 @@ DM_TEST(dm_test_fdt_disable_enable_by_path, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 /* Test a few uclass phandle functions */
 static int dm_test_fdt_phandle(struct unit_test_state *uts)
 {
-	struct udevice *back, *dev, *dev2;
+	struct udevice *back, *dispc, *panel, *dev, *dev2;
 
 	ut_assertok(uclass_find_first_device(UCLASS_PANEL_BACKLIGHT, &back));
 	ut_assertnonnull(back);
@@ -807,6 +807,24 @@ static int dm_test_fdt_phandle(struct unit_test_state *uts)
 						 "power-supply", &dev2));
 	ut_asserteq_ptr(dev, dev2);
 
+	/* Test uclass_get_device_by_endpoint() */
+	ut_assertok(uclass_find_device_by_name(UCLASS_DSI_HOST, "dsi_host", &dispc));
+	ut_assertnonnull(dispc);
+	ut_asserteq(0, device_active(dispc));
+	ut_assertok(uclass_find_device_by_name(UCLASS_PANEL, "panel", &panel));
+	ut_assertnonnull(panel);
+	ut_asserteq(0, device_active(panel));
+
+	ut_asserteq(-ENODEV, uclass_get_device_by_endpoint(UCLASS_PANEL_BACKLIGHT, dispc, 1, &dev));
+	ut_asserteq(-EINVAL, uclass_get_device_by_endpoint(UCLASS_PANEL, dispc, 0, &dev));
+	ut_assertok(uclass_get_device_by_endpoint(UCLASS_PANEL, dispc, 1, &dev));
+	ut_asserteq_ptr(panel, dev);
+
+	ut_asserteq(-ENODEV, uclass_get_device_by_endpoint(UCLASS_PANEL_BACKLIGHT, panel, 0, &dev2));
+	ut_asserteq(-EINVAL, uclass_get_device_by_endpoint(UCLASS_DSI_HOST, panel, 1, &dev2));
+	ut_assertok(uclass_get_device_by_endpoint(UCLASS_DSI_HOST, panel, 0, &dev2));
+	ut_asserteq_ptr(dispc, dev2);
+
 	return 0;
 }
 DM_TEST(dm_test_fdt_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.47.0

