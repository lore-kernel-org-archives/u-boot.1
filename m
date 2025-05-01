Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7B8C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B2158212B;
	Thu,  1 May 2025 15:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/GoaJf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88703826AA; Thu,  1 May 2025 15:37:55 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6B48212B
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d8020ba858so11012745ab.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106671; x=1746711471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qL9QPlOfhbYufofsm6KSSRw11Y9+dciOc5lRZrmv0Hw=;
 b=W/GoaJf+Wrgd1l8Voxy8Le/HbWHuoILQT5a9ywwqEx1rRuW+V2lRcxskELxEE5tQYg
 nikwGY+YdmJwQzYlw9uNiMWzShUDx1nTyideeYGfxxgWiuQfACv/UZx+sMJJmKK1qAIP
 wrW+PjM8yfB9ayO9sk2KIkfhyGaJs3DmIeSWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106671; x=1746711471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qL9QPlOfhbYufofsm6KSSRw11Y9+dciOc5lRZrmv0Hw=;
 b=bQ4Zcomlmujar16wIm3Loa0ucFNpC8gwVLgotn7Mjo6vGM3zP8a0CMtdmsvRlZKGvm
 p8hg/NwbVVTbp7a0+VpkoONXJb+0ldxDnJaht+MFLk/DekW/pFTVktFzW7AVGhQUiS9h
 z9pQP7GB48eKYNtDoAuQSUNWQlT9nPo3WWJajCujW7Mb3Dng1H95MrYERpdi+B3r1dfw
 r9WyrjqMNiUATVbBbv5ijocK6WMRkrTUcutCH1kJ09HFfqVWBmpiZPoZ8XjMi53H0XOx
 K39A6UWWWAUh6rwhA5YJgnFsn1atzaZ37lDiZgnsjXbTxE/LGtnZos8JQM27IxtUhZH3
 vgJg==
X-Gm-Message-State: AOJu0Yz+oI47SMgaS2laP1BA/l/H/ciTM3XwMOpa+HO0Yl4M3n5PuByH
 gYyv9RsPpx0rBHVGuFXJM3b25U3CMsymh4gpeqOaL7suTkot+D7x1mLO6bS/RhWDVpGTK0cPoeI
 =
X-Gm-Gg: ASbGncuuuIC5OzcR3UyZWfrC26i22iKkaX5YfSc4JNKftPIfyfu6hpRx2YOdsLr3ohK
 CUG/8dsQWlH18V9t4o5YAjldv/TTUrvUsmP0vRRZUvVUYMArgcbry01p79AdE8BcdNkvowBi6KM
 KwkBpQeBP3qQCWQtt7UsQ1sTSACpJKQfKo/JCcA+m/r7y21VmhRb257fim9NECeqZM3WlOfe8SH
 CGOgrfmM2dq6/A88Q9B2iVJsSv1FyVsVPhwyQ/a0jFBit3HlpGy/7vhlQb2qZ3NrttoCtZeqKfO
 iV4mSoYHsfmaGy75fM624DBmmKFx2PZTe/SzygAYD08fJR4Dh6j0Ty5nzVWrYVDs2hfK9o3jBgK
 U/A==
X-Google-Smtp-Source: AGHT+IF3nMtpL3m/OgaS5SoVhtr0Hn8zcp7lkZWnLQiY3K8ATimFXVWKwL4+bO2syTRFQ/CQhoFQxQ==
X-Received: by 2002:a05:6e02:1a8f:b0:3d0:10a6:99aa with SMTP id
 e9e14a558f8ab-3d9701a43e0mr33481235ab.4.1746106671408; 
 Thu, 01 May 2025 06:37:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/18] sandbox: Use a unique name for each USB controller
Date: Thu,  1 May 2025 07:37:12 -0600
Message-ID: <20250501133726.2627373-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a number after the node name so that it is clear which controller is
being used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/test.dts |  4 ++--
 test/boot/bootdev.c       | 12 ++++++------
 test/boot/bootflow.c      |  6 +++---
 test/dm/usb.c             |  4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 060c48eaefd..caec8c8fd01 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1495,7 +1495,7 @@
 	usb_0: usb@0 {
 		compatible = "sandbox,usb";
 		status = "disabled";
-		hub {
+		hub0 {
 			compatible = "sandbox,usb-hub";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1509,7 +1509,7 @@
 	usb_1: usb@1 {
 		compatible = "sandbox,usb";
 		iommus = <&iommu>;
-		hub {
+		hub1 {
 			compatible = "usb-hub";
 			usb,device-class = <9>;
 			#address-cells = <1>;
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 7ef724f65bb..0ace3d0699c 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -231,7 +231,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq(6, iter.num_devs);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
-	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub1.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[2]->name);
 	bootflow_iter_uninit(&iter);
 
@@ -277,7 +277,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
-	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub1.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[3]->name);
 	bootflow_iter_uninit(&iter);
 
@@ -343,11 +343,11 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
-	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub1.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[3]->name);
 
 	ut_assertok(bootdev_get_sibling_blk(iter.dev_used[3], &blk));
-	ut_asserteq_str("hub.p1.usb_mass_storage.lun0", blk->name);
+	ut_asserteq_str("hub1.p1.usb_mass_storage.lun0", blk->name);
 
 	/* adjust the priority of the first USB bootdev to the highest */
 	ucp = dev_get_uclass_plat(iter.dev_used[3]);
@@ -366,7 +366,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(8, iter.num_devs);
-	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub1.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
 
@@ -612,7 +612,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	test_set_skip_delays(true);
 	ut_assertok(bootdev_hunt_and_find_by_label("usb", &dev, &mflags));
 	ut_assertnonnull(dev);
-	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev", dev->name);
+	ut_asserteq_str("hub1.p1.usb_mass_storage.lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
 	ut_assert_nextlinen("Bus usb@1: scanning bus usb@1");
 	ut_assert_console_end();
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f1341312dac..cbb5bcc0cf3 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1307,9 +1307,9 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
 	ut_assert_nextlinen(
-		"  1  efi          ready   usb_mass_    1  hub.p2.usb_mass_storage.l /EFI/BOOT/BOOTSBOX.EFI");
+		"  1  efi          ready   usb_mass_    1  hub1.p2.usb_mass_storage. /EFI/BOOT/BOOTSBOX.EFI");
 	ut_assert_nextlinen(
-		"  2  extlinux     ready   usb_mass_    1  hub.p4.usb_mass_storage.l /extlinux/extlinux.conf");
+		"  2  extlinux     ready   usb_mass_    1  hub1.p4.usb_mass_storage. /extlinux/extlinux.conf");
 	ut_assert_nextlinen("---");
 	ut_assert_skip_to_line("(3 bootflows, 3 valid)");
 	ut_assert_console_end();
@@ -1325,7 +1325,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_asserteq(1, run_command("bootflow boot", 0));
 	ut_assert_nextline(
-		"** Booting bootflow 'hub.p2.usb_mass_storage.lun0.bootdev.part_1' with efi");
+		"** Booting bootflow 'hub1.p2.usb_mass_storage.lun0.bootdev.part_1' with efi");
 	if (IS_ENABLED(CONFIG_LOGF_FUNC))
 		ut_assert_skip_to_line("       efi_run_image() Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
 	else
diff --git a/test/dm/usb.c b/test/dm/usb.c
index d89d436d269..66777b5ef00 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -109,12 +109,12 @@ static int dm_test_usb_fdt_node(struct unit_test_state *uts)
 	state_set_skip_delays(true);
 	ut_assertok(usb_init());
 	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 0, &dev));
-	node = ofnode_path("/usb@1/hub/usbstor@1");
+	node = ofnode_path("/usb@1/hub1/usbstor@1");
 	ut_asserteq(1, ofnode_equal(node, dev_ofnode(dev)));
 	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 1, &dev));
 	ut_asserteq(1, ofnode_equal(ofnode_null(), dev_ofnode(dev)));
 	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 2, &dev));
-	node = ofnode_path("/usb@1/hub/usbstor@3");
+	node = ofnode_path("/usb@1/hub1/usbstor@3");
 	ut_asserteq(1, ofnode_equal(node, dev_ofnode(dev)));
 	ut_assertok(usb_stop());
 
-- 
2.43.0

