Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F9E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6026C894E0;
	Thu,  5 Dec 2024 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QcvHhrzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5287D88C98; Thu,  5 Dec 2024 14:54:51 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0557388F2E
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 118F14000E;
 Thu,  5 Dec 2024 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zZtmMcE1DtzGFrtTwXmXZr54qhRwL5b6np9T5HbtmY=;
 b=QcvHhrzX//NeWqb8m/lYrrC9ckgoEpj/XrHt3FaJHTrDRtTmVLJEStPlAia4tVZm7M2Xe0
 lrrEMy3KL57UzVr4gR04NFVC9XHi6XywuMtFizXQ1Ey5utnkNpuYKiDRx+2EazauiIHvau
 Ky7WTZFOIBdpIbHQ9tXpYjmKwRi/oCJMShJXXHgEJ3CKvFJsUwSCJH8w1PH55fBeRxmu5R
 KvHK9hznp2LVvQmrzcxqvMiBzTKM3fdaH7wkxxISfQCoZmPWT9oBfJL7qiz0201pEFQ/yB
 TFVSVh5Ex/qM0YFpCfeoPxg+H3lI9YjBvkQ9amDtKprNa9e9EYVORTb5LICxzQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:10 +0100
Subject: [PATCH v2 04/13] test: dm: test-fdt: Add checks for
 uclass_get_device_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-4-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
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
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 test/dm/test-fdt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index af8cd617108ac2421f7275948be000a7cbaebda0..309e9da0a8e01d0ac469ae78983edf9499f2a504 100644
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
+	ut_assertok(uclass_find_device_by_name(UCLASS_TEST_FDT, "display-controller", &dispc));
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
+	ut_asserteq(-EINVAL, uclass_get_device_by_endpoint(UCLASS_TEST_FDT, panel, 1, &dev2));
+	ut_assertok(uclass_get_device_by_endpoint(UCLASS_TEST_FDT, panel, 0, &dev2));
+	ut_asserteq_ptr(dispc, dev2);
+
 	return 0;
 }
 DM_TEST(dm_test_fdt_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.47.0

