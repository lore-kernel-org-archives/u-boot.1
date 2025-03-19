Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E69C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A46E81E76;
	Wed, 19 Mar 2025 15:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEoNNGrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402BB81F0B; Wed, 19 Mar 2025 15:39:08 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF98081F32
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39127512371so4228886f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395143; x=1742999943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISdHC4X6Qzgt3Y09ASG0VT6I8xZKJUQzf4cmueeAw1o=;
 b=WEoNNGrbNETqpH4WVfUeuPsJmNLiAdvEF9fHzNA2qPHZY3UO6sRumWAL3/n9LpxyHY
 ShVJCnWJkXxYTPLt4X7iXl0erz8mCDd4oqV9pIAonix/jgAMat+mYjfjmdnz/tJyE23v
 S6btcgYL4/GcZlY+u9iTUSHNtSTXhBRG8vI9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395143; x=1742999943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISdHC4X6Qzgt3Y09ASG0VT6I8xZKJUQzf4cmueeAw1o=;
 b=QRjTN3fz+okCSCaoWKRzFUwnTbL1Szj4q6ugDFKnOQBS3vC0RX+3MHrxeTYGOOoqgP
 sLE3eDlU2MmE6N+B6k2Vwk1R0SopIdB6DS9EWWedOlLFk4iel+Qc6t2HRVtuUNSyylsz
 zM2l4cTE+FVLDYyHlMMMxDSHT5rm9r0Syi/VI1ABzwolXTMoLjhGXlFkKHD2AhmeWpQg
 tLGnuKckCw+GwXvexQtsoUIpKgmmi36Kl/UDvRpxb37wFD2a38sOf2/eP0dcGXXFJmrD
 93eTiLlTQpK5KVoeX2orKbT/gogXyz8rmoYipNrwv7fBgKl5ntVDX2S4+VlCLDHMQC9v
 A0xQ==
X-Gm-Message-State: AOJu0YyVmMlvQ/j6jrZSkBOXhJlkhl9F7cCJPPIi1PZQ7MofCq0HOqr0
 CUVvLWt4Qt2gA3MN0TulmDvsWpxPQ+Tz7jF7U1MdPBb1HnHzuGehrC/1Tge48N2827lJDLoNLXY
 =
X-Gm-Gg: ASbGnctl7f7ec8yvLaElDAnbpcKoz9idjLhlfesnqOuB3+yhm8JV/28s/XG5kw7EHAl
 isnpBuBbbmRXxBeSNAKHegM9Q7EYeNuhYEbbGRrnh2cA3bHXkRO6c81X9vk0LNBygHX1TWI1ZTP
 G5hJ/tPVIjLSY11iXLxBUe5kg9SfU46qJvcM8msWThQ52RgVDH7FQzbfHUpJ9WFRxto/cVF47bi
 KujmxA6R/dzWgAggqXqvOEDT2PMWPUOJ4DOn/MojTIoLBQKdd0vJNzBn6l2OJmtd/zuGXY9+IlX
 t2v6Y64eKJ80HHqLPigRzuKZGDb2uRNXJzrKFlfbRA==
X-Google-Smtp-Source: AGHT+IGVRsRtc42SgrqxkHXvrKjyvjKnOWDRyUShs7jl9dLJRAUf2ZWFiCkC49PqbV53wFn4Xp59aQ==
X-Received: by 2002:a05:6000:2c7:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-399739b4c43mr2575041f8f.2.1742395143354; 
 Wed, 19 Mar 2025 07:39:03 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/17] sandbox: Use a unique name for each USB controller
Date: Wed, 19 Mar 2025 15:38:05 +0100
Message-ID: <20250319143820.2385092-12-sjg@chromium.org>
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

Add a number after the node name so that it is clear which controller is
being used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

