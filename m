Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D989C36014
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456C381E3E;
	Thu, 27 Mar 2025 05:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ToUSZh/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A8D681CAF; Wed, 26 Mar 2025 16:01:37 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D4E803CC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15FBF4428F;
 Wed, 26 Mar 2025 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKgcfqaAbtj2pnjgK+3w4d5ZJF0LWJi+9zEeilq1N4M=;
 b=ToUSZh/IOEmabaxhqS/YNWpINsNUlwQPIPuqQ4ht48zjvrqMPxZoved+AOrFF8dIwGaurR
 yYZyfk02KDDGgLe1gufcDEYfvLeKe3RaUbhjaaEHCFUKZMYE0p06O56Tcis3mEoSyD2FL1
 NygWp8GvtsxqbDjy/wTqC3DtdeVfn3J+QIri63+OBZQSOoSZLrIGVdh/8PFMzOSkkg7Zi7
 kL9f4ONK/tGlFe0xhA5sSDFhlSAJCOcWybszioBcx66ygl0n00O7JxzqeDB36LQkQWvo/W
 vg9nGpKWG9wsEGGemD2MHqUlQpznFEyascHXj36Scf0XA78hpVV/rFtVET69YA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 16:00:48 +0100
Subject: [PATCH v5 04/12] test: dm: test-fdt: Add checks for
 uclass_get_device_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ge-mainline-display-support-v5-4-ea4bc3fc9bca@bootlin.com>
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghinhgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhto
 hepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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
 test/dm/test-fdt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

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

