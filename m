Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFB6C0218F
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC2E81DD3;
	Wed, 29 Jan 2025 11:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="X8T69xT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055CF81CC5; Wed, 29 Jan 2025 11:22:15 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C95A807E1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4AE2D43152;
 Wed, 29 Jan 2025 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1738146130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CO3s4b4+EMdgrbO5U0rGfv4tRRunrIXEJ+s6J9U4NbU=;
 b=X8T69xT7lEsxq8um69/fiY9JqFx9xI6lqFxnURIvE5urD7wjxQ55Usqju4zYXICaPLwpYd
 HFTR1AVr9riHoz7P+Mz6aN5YMQnDL7sFdNd2uu0TQBrScwTLGabiDFK2q5fZLHmf4WCOVo
 8l42L/ZmCed191Q74lWmzqHP+b9zEMkcgIBJRFhS4J2LYsmDE4AfhE9kNjA8F3EkOZAAAi
 nNIedOoBT5QLeE8WiBiWHcCP9bSHphwY0QDUAI4NUdZsy1jiNe1jbHN9S818Er0b5+xd4e
 AN7nJGZ8Tk6L8h3E5yxCZ6njoRg46FGx4YF6Px4Bt906yPmO/0eHXx8a0KMTyA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Jan 2025 11:21:58 +0100
Subject: [PATCH v4 04/12] test: dm: test-fdt: Add checks for
 uclass_get_device_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-ge-mainline-display-support-v4-4-a43b3657ed7c@bootlin.com>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
In-Reply-To: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghin
 hgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
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

