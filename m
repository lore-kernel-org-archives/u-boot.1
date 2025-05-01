Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27897C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 299D28219D;
	Thu,  1 May 2025 15:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mSHHclWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CCB82169; Thu,  1 May 2025 15:37:54 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D79809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso31322139f.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106670; x=1746711470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYQ1UOFmSbHysqK5oJ/sr4icU6KYLg9lhD+3e4xzXHY=;
 b=mSHHclWBQpiN7BrvlXrpIp8cV12MwuIEJeogHgejauVUK0zWOUPOT2yBzIGUo5gPXw
 I08rbHEolUbVPBomt/NFhdvY334V2MrLFb86ql9ADVxkvlXwBW8KQP9sx/wRINlHR+X1
 mnFZASlQGfnXCmaw6k4tqVoN08wwfjbIzpsTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106670; x=1746711470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYQ1UOFmSbHysqK5oJ/sr4icU6KYLg9lhD+3e4xzXHY=;
 b=CRrqz2EHo82bAm6vpxlmcPxj6SZ19GJ9saFFReWnG9Eyvlc27Kckdcay/3BlfO/L5Y
 daCGIaPutDiWNI3CBEhZ94c3vP1lG4kGd4aTeJugKq1VOdqcMYNKPU9fXTnn6gzYQM/t
 K4FL9ETvBclzeCFHfjX7+F5MPK38/YLjODZdikTRVtxX3ITh2cNm31Q+1RkinlRs8PV/
 fk3E/oElCVv+P7gSPaEA9/BgHYrYWUNYDcbwXHr6S+C2PqU4KbyNnY9LuKHNpZ0p/oa9
 6njvaXWO2K3aoHuGAp7ga0egsCOpMjStn89zajgk+Xt/auvQXpPlyZqjB/XmvtJc5APt
 tnHg==
X-Gm-Message-State: AOJu0YyiAU6gxw/rko7UyGjtivlpyawliEKLQmH/lTe1PjfFhkla4y/r
 oBXsHIKyRZn8PwZu64FiAZQqn5xUnHpY71PAsgN/9QbY+ZZJgnLmfO9gZsVhuyV0R27gvTvj4uo
 =
X-Gm-Gg: ASbGnctNtL/HeoyyGdq0tOq/k5mj/8Uei4UqAGjsZhUTFw7Z5AF7OHQC4rmwVFareA6
 cpEZ1FNVquaOlJ+psruq7dIyPDDDoN9laZCht69WKog2qbAaQhRdh5CRu7CkyUrm1synheo+kdC
 X+33b0DI6sPiptxzChoY8JrJiGJ6AicLDFm/ipx4rIQ5nBNN+u6lEq203N1riYwtw5H9sgRlOBm
 CVoM65W6orFe3L7Nd8KRxmPNlUgAZvkQkZNdSigbKa7Z9Kohz5SWXzxr/e7JLkJeKXoUeB7W0rl
 GfOWDRiYP3OP1+ulDnroaMVgLqdzfij+VzG4exbN8E6xGJn8Ufz2UrKEIDr/mBVyly5NHw++uWS
 H8g==
X-Google-Smtp-Source: AGHT+IEidvMvifMlSvgTdd6KRhWtedsS9/0p00vyAxU2oqQt2c60MByv48RwFcmAkSgz3cpwVnvPtw==
X-Received: by 2002:a05:6e02:1a05:b0:3d9:6d6c:72be with SMTP id
 e9e14a558f8ab-3d96f191806mr41528425ab.3.1746106669804; 
 Thu, 01 May 2025 06:37:49 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/18] usb: Use more useful names for block devices
Date: Thu,  1 May 2025 07:37:11 -0600
Message-ID: <20250501133726.2627373-12-sjg@chromium.org>
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

The driver name is typically not unique so using that as a basis for the
block and bootdev devices makes them hard to distinguish. This happens
when there are multiple USB controllers using the same driver.

Make use of the parent-device name and the hub port number. This gives a
reasonable chance that the name is unique.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

