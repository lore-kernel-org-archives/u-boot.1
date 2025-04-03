Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90599C3601E
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442CC820E2;
	Thu,  3 Apr 2025 14:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pqZvHdgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A34E81FC0; Thu,  3 Apr 2025 09:39:30 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5DC780194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97BE144385;
 Thu,  3 Apr 2025 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743665966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPKUaS6gWHxcUSRbB2TkoQ7gpmhof9M5hy9BNlb/SSc=;
 b=pqZvHdgnthBiNQWd7h6zVhrUTrQ/cqzQ4Ll3tVBMd5g5GScKmDwtdm4FEue5V/UTIRlDik
 zakq6O1RVR3tFSgNOd5Gq2obHYgMw9+ypouYBdUe03+OJrms+8O3LRukvDrMn0mbtTpfHs
 m2lkL6/A4SENDlWaHUFYIyw1mZ8TaL7CpIQ7w4ERNIY1gSL6gWceSKLXlqcNxM669QffZI
 xSsGWrGF2Qhtd5754dJAz1S1J/eFL8XuUjr27M/fslkA6lv3SRJaDrOyoLS5nQ1cRz5Jrr
 d9Z1Ekmnwr4N8E9ewhvUELBtjj1ElTWp8rtdU3xJI36R0i0/4p930g+dUafS9Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 03 Apr 2025 09:39:04 +0200
Subject: [PATCH v6 04/12] test: dm: test-fdt: Add checks for
 uclass_get_device_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-ge-mainline-display-support-v6-4-478b5e3dd872@bootlin.com>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplgduledvrdduieekrddurddutdeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghng
 idruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtoheptghlrghmohhrleehsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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
 configs/sandbox64_defconfig        |  2 ++
 configs/sandbox_flattree_defconfig |  2 ++
 test/dm/test-fdt.c                 | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 7960b2ef42e7ceee2a3646888ae159cdde9b59e0..d49adb6adcb55084daf8d6c1a9f8c95d3e4083ac 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -256,6 +256,8 @@ CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_I2C_EDID=y
 CONFIG_VIDEO_SANDBOX_SDL=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_BRIDGE_LVDS_CODEC=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_BMP_16BPP=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 563093dd8a426f98cdcfa342655bebb82dbefe86..67c0ed7353efc252cb31b31d94415f37a1f74c99 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -220,6 +220,8 @@ CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_I2C_EDID=y
 CONFIG_VIDEO_SANDBOX_SDL=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_BRIDGE_LVDS_CODEC=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_BMP_16BPP=y
diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index af8cd617108ac2421f7275948be000a7cbaebda0..295fdcaa0d83eb6129e9c0aee7a9146b01772d97 100644
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
+	ut_assertok(uclass_find_device_by_name(UCLASS_VIDEO_BRIDGE, "lvds-encoder", &dispc));
+	ut_assertnonnull(dispc);
+	ut_asserteq(0, device_active(dispc));
+	ut_assertok(uclass_find_device_by_name(UCLASS_PANEL, "panel", &panel));
+	ut_assertnonnull(panel);
+	ut_asserteq(0, device_active(panel));
+
+	ut_asserteq(-ENODEV, uclass_get_device_by_endpoint(UCLASS_PANEL_BACKLIGHT, dispc, 1, -1, &dev));
+	ut_asserteq(-EINVAL, uclass_get_device_by_endpoint(UCLASS_PANEL, dispc, 0, -1, &dev));
+	ut_assertok(uclass_get_device_by_endpoint(UCLASS_PANEL, dispc, 1, -1, &dev));
+	ut_asserteq_ptr(panel, dev);
+
+	ut_asserteq(-ENODEV, uclass_get_device_by_endpoint(UCLASS_PANEL_BACKLIGHT, panel, -1, -1, &dev2));
+	ut_asserteq(-EINVAL, uclass_get_device_by_endpoint(UCLASS_VIDEO_BRIDGE, panel, 1, -1, &dev2));
+	ut_assertok(uclass_get_device_by_endpoint(UCLASS_VIDEO_BRIDGE, panel, -1, -1, &dev2));
+	ut_asserteq_ptr(dispc, dev2);
+
 	return 0;
 }
 DM_TEST(dm_test_fdt_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.48.1

