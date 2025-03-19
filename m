Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE40C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1B981F66;
	Wed, 19 Mar 2025 15:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ixbSe4cY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D96681F30; Wed, 19 Mar 2025 15:39:06 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A8181ED8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3777728f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395141; x=1742999941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcsOskkNFD8+UdxxfblO67y/d3LBNSCfMhBProJOdFc=;
 b=ixbSe4cY6NzZxJbHWX2Omn1KnZWK08AowMaAtWq2Qf1cbvip2mKP0WNAUQZ/IqLywr
 7t+BNOhFrUoxRTJu1kSHnde0SVHpQ051JZKW4N4/q2KW1qK/NZ7e2tdEO6h2mI4dPMHn
 3IQ2JL3mq+RdHozGsvIb1lCsNgOlMi14zGWC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395141; x=1742999941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcsOskkNFD8+UdxxfblO67y/d3LBNSCfMhBProJOdFc=;
 b=n9uOKSbtXxhDfAGAjk4nk+VeP3wzQxUw6f0jvyUb2y92ONxGzub4ciEn+Crz2mVsS4
 hO2rqUKM1Ca8/O7MjVOjkKTZUxiC3vdAn6jG5yTxLAMJCFpjPLsyP8fMrKKg/xhzqnPu
 KlTzXn6WDy7tq+tZpRbOw2WkUgIj7ORnCFZctABMVv98/10vXmU9XmhUBORSv/Q1EgMo
 wKcDSRHG5O7Uh42y0lC/mtw4f2qLM8HcDB6hkE6yPo5nAWR1iWKmvLiglmv7Ci+7iwbF
 eU/rEDx+D8BUaYotsiaAKSXDsMF3h71PjzEibRN7KxAhhzYr99+WtBPlxc7MebG9Bjeq
 kYRw==
X-Gm-Message-State: AOJu0YwYu2iZ2LNsjhZg9eObKlUv/Fzlbj7kIqn4KV2L7Ykn1c9AgYWK
 oQ1lW7VLJ6WqzwD2cU7YPR22MMYveSCJpdLHfgzc5ERN6MlKfpCETJeD0fDhbZIiXmLsyhS6tos
 =
X-Gm-Gg: ASbGncuYYL3ZCPeZHC0m6d15XWEee9CHp5Gh4mcytlQRTpDTUxK8Pl9ykYec3C3Wsb7
 i911jhK1AEaiz2cNavqLK0GE/hU7MlY6bkhoNyeEv2pdf+JkI/O1kpiiQHTLB0K4ySU+frJLxPX
 e44dL4qqOv00qKyJVyZ/GvGR+OHTCao+ZtAbZApW9qq+DpAu7zPxQSHS3wNuBXdhGh3qJHy2ppK
 q5KoWjzE1+dMIwGqrR0sH9/EEGODTLGteVB9MasCihb0F1jIY7Oal762mf5GoEvwJENJgExbMT2
 AJpgpMlGUSjkrnGtgNE1HqpcQNKUR2CRAy4H5u+l+w==
X-Google-Smtp-Source: AGHT+IHBwLd3b3dBgDtQsJjxTb3+S38gU4PZv8hDb4mZkJA1k4xmeK2i2qbcFrt4slCGuuMCFA/5tg==
X-Received: by 2002:a05:6000:1541:b0:391:4389:f363 with SMTP id
 ffacd0b85a97d-399739bf77amr3309725f8f.21.1742395141375; 
 Wed, 19 Mar 2025 07:39:01 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/17] usb: Use more useful names for block devices
Date: Wed, 19 Mar 2025 15:38:04 +0100
Message-ID: <20250319143820.2385092-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

The driver name is typically not unique so using that as a basis for the
block and bootdev devices makes them hard to distinguish. This happens
when there are multiple USB controllers using the same driver.

Make use of the parent-device name and the hub port number. This gives a
reasonable chance that the name is unique.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/usb/host/usb-uclass.c | 14 ++++++++++++--
 test/boot/bootdev.c           | 12 ++++++------
 test/boot/bootflow.c          |  6 +++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index bfec303e7af..43c8ec352f0 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -574,10 +574,20 @@ static int usb_find_and_bind_driver(struct udevice *parent,
 		struct usb_dev_plat *plat;
 
 		for (id = entry->match; id->match_flags; id++) {
+			char dev_name[30], *str;
+
 			if (!usb_match_one_id(desc, iface, id))
 				continue;
 
 			drv = entry->driver;
+			snprintf(dev_name, sizeof(dev_name), "%s.p%d.%s",
+				 parent->name, port, drv->name);
+			str = strdup(dev_name);
+			if (!str) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
 			/*
 			 * We could pass the descriptor to the driver as
 			 * plat (instead of NULL) and allow its bind()
@@ -586,10 +596,10 @@ static int usb_find_and_bind_driver(struct udevice *parent,
 			 * find another driver. For now this doesn't seem
 			 * necesssary, so just bind the first match.
 			 */
-			ret = device_bind(parent, drv, drv->name, NULL, node,
-					  &dev);
+			ret = device_bind(parent, drv, str, NULL, node, &dev);
 			if (ret)
 				goto error;
+			device_set_name_alloced(dev);
 			debug("%s: Match found: %s\n", __func__, drv->name);
 			dev->driver_data = id->driver_info;
 			plat = dev_get_parent_plat(dev);
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 4333f3c977c..7ef724f65bb 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -231,7 +231,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq(6, iter.num_devs);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
-	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[2]->name);
 	bootflow_iter_uninit(&iter);
 
@@ -277,7 +277,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
-	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[3]->name);
 	bootflow_iter_uninit(&iter);
 
@@ -343,11 +343,11 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
-	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[3]->name);
 
 	ut_assertok(bootdev_get_sibling_blk(iter.dev_used[3], &blk));
-	ut_asserteq_str("usb_mass_storage.lun0", blk->name);
+	ut_asserteq_str("hub.p1.usb_mass_storage.lun0", blk->name);
 
 	/* adjust the priority of the first USB bootdev to the highest */
 	ucp = dev_get_uclass_plat(iter.dev_used[3]);
@@ -366,7 +366,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(8, iter.num_devs);
-	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
+	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev",
 			iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
 
@@ -612,7 +612,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
 	test_set_skip_delays(true);
 	ut_assertok(bootdev_hunt_and_find_by_label("usb", &dev, &mflags));
 	ut_assertnonnull(dev);
-	ut_asserteq_str("usb_mass_storage.lun0.bootdev", dev->name);
+	ut_asserteq_str("hub.p1.usb_mass_storage.lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
 	ut_assert_nextlinen("Bus usb@1: scanning bus usb@1");
 	ut_assert_console_end();
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 3ee87145dc8..f1341312dac 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1307,9 +1307,9 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
 	ut_assert_nextlinen(
-		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+		"  1  efi          ready   usb_mass_    1  hub.p2.usb_mass_storage.l /EFI/BOOT/BOOTSBOX.EFI");
 	ut_assert_nextlinen(
-		"  2  extlinux     ready   usb_mass_    1  usb_mass_storage.lun0.boo /extlinux/extlinux.conf");
+		"  2  extlinux     ready   usb_mass_    1  hub.p4.usb_mass_storage.l /extlinux/extlinux.conf");
 	ut_assert_nextlinen("---");
 	ut_assert_skip_to_line("(3 bootflows, 3 valid)");
 	ut_assert_console_end();
@@ -1325,7 +1325,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_asserteq(1, run_command("bootflow boot", 0));
 	ut_assert_nextline(
-		"** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi");
+		"** Booting bootflow 'hub.p2.usb_mass_storage.lun0.bootdev.part_1' with efi");
 	if (IS_ENABLED(CONFIG_LOGF_FUNC))
 		ut_assert_skip_to_line("       efi_run_image() Booting /\\EFI\\BOOT\\BOOTSBOX.EFI");
 	else
-- 
2.43.0

