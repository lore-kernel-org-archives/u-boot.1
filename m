Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7237C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD50B406CB;
	Wed, 26 Aug 2026 16:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MIXslK2EzyJf; Wed, 26 Aug 2026 16:35:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762103;
	bh=dwuVjsbcdQsZSecEPA+9bkKrQbnISz0KIVobGBbweXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=py1DqhfR58smvaXz1piwxdOKaEp3YBig3MZGE2Xt2R3WdMYEwAILK3Bx6BQrGDgHW
	 wmgJxHsRnaPMk3RMumstBBS+kcj9Tpa1wAZHAYQmCM124Ysa9PCO28Gms43BQpY3Yb
	 7SL5yYPTwZc9Izw2fwDXEIwcWChPB/mv8pndyWdi4/8zy1QPGf7zLTyI53i8knluPx
	 nAaWoLcAHigmhVr+A4eQIAlIh6RD7yRnD9dEntg61WjJOx66oOQyde0iCpKcnHgnFz
	 IXJuiUSCXzVAMtdVyGoiJAohXEFzWNdtcAGiQGWRa3pAIAm2PfWgBAf1V4maZ6UKtm
	 eMIHA5IY+kfPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E526406B9;
	Wed, 26 Aug 2026 16:35:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF3E2323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A774A406B3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8by6Rhd-iu1j for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:35:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=0xd6DyV8
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34738406C7
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:59 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso1977028a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762098; x=1788366898;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dwuVjsbcdQsZSecEPA+9bkKrQbnISz0KIVobGBbweXc=;
 b=0xd6DyV86Jo7PXmRpcuXWuYVtQjwTft43MvPC1w18xK80qmxjKlTSfgj13wVGEscey
 pIjqkDJjrDxzj+ChNjj0ce2XxyjqB5yDa9Bpcfym3oMnT2yJg9obW3NinRm4MUWSB291
 Zx+pH0w8/HF2cT5Whn215LihYnkyTVqAzQe3W+QsQWK9YghDDx4XntSs9UF8/UaSByoM
 IF5YHpgnSg5PXxXrD87Lv7kIwqsdkN461G6yT4UGBuO/Nl2sSUzgr8ztouMP3R6QytJG
 7o4dN72XO3Jo1gs2Y/wRHGPP/NDh6CI6QFQqesNKwMq4ZBI5UBzD3D3hR3ySMn/+v8Xd
 /rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762098; x=1788366898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dwuVjsbcdQsZSecEPA+9bkKrQbnISz0KIVobGBbweXc=;
 b=lySW4m9uX19cqx6FD2FvWgk+ByxrbF3tN8fOc4/w+VmRnN97G1WzQYF+0/pVSEHrwa
 juxVOwTJE7fLTq6g3r95iXWDSbaqkNuEgIg13xgm+SZ5cflXS9ABRXdUdW3PBJPt8Xfc
 fDus68KZV6U1DTdlp/gqSXdJvFQAbcT8lP12RZZ8jhOAgTyaEeKXoUmvbar1sw3O6L4i
 MUA+ceVpNHQqzjLrJAwolWtffdO/x3Ik7LdMGgzsZVM5HgmRd5Jsu2IEdKxkbnZxDSdo
 zkINu2vEX5PJLGe8OIF4h/QztpqvbTNfcHPhTl5+u4/1RVARQTteujt5bpfas/r2PMJ/
 JG0Q==
X-Gm-Message-State: AFuF++neY0gJ/hnhlVe6AQ8LOQf6MJNjg/MNSKFxYtMkTDjp5KkEqGJ8
 HdV79fzTHE5HYEFyIJz52MwafyUu9YGXkosfXy803JRenI233/9sWnuh7bb/1HKc0HY=
X-Gm-Gg: AR+sD12zj5O1z+VnjICvCSOq8Z85E2imCp2SDfVzr1vksB7t3zByiv1oAqKuLkAwop7
 N889Kt2RApMSsmwz1x0oRc260sZVvEgpIATlMvmq+Fgeejq0r+pk5Z6ZM9pccEpwlORrKNzpUjl
 unpucgH2zWYCIl2NoLQZSi2hBoA2AMb8ys+g7ENqoT6GwXTvLa/R0IyufSpdjDruq/85JUZmbHc
 dr2TMlu7s32Ng734C9uzBn8+jwzM8cgT1mOYoG+f5DJl9+YrAL4Av5WBc0CVPv1KyPYmPROY0r7
 1gXDkMqwa6vjsdHmjhIdMVEVsGSz0GxgZFZShArEWlrh7EQhcLBtRg1K4XOwwHJcnhLh3ZcDWzH
 La6En3t+NfDJdMPo1FnSdoWaGxI+mie91q3Wd7BZkF768cdviK13QjkOX91dk7GAkoJILWHPvTZ
 Qfrg8VB+Myr0+EyuHOZUIptswFBPUAA6ugiXEkbTH1OvllGRtANpRMb9cI3xc6uawfq6vyRO4PW
 3VON0amW8M23Vx0i6Qx3WnRgDLC4dX3/117vvisGg==
X-Received: by 2002:a17:907:7249:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c250bc37bb2mr958522066b.15.1787762097540; 
 Wed, 26 Aug 2026 09:34:57 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:56 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:34:03 +0400
Subject: [PATCH v2 11/13] sandbox: enable BLS boot method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-11-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=41198; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=vDVA4iQuUSQrlSB8yd+2DI3k6wo3nV2UNdZlW3Uku9E=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/ZayJW39bGYzJyn/XdO/Yn09un7DCsmXdvDWtbfs
 Nxq2cmVHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1S3NGht6Hh9ZYXxBY8OPkuuc/GLb8V/nqIL1Z+ozZe44+96B5y5YxMpx8sWE
 r2xz/WRMneC2N0+2bFcrg1GV4eve68wzW3vK6OrwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the Boot Loader Specification (BLS) boot method in the sandbox and
its test DTS to enable runtime testing of the BLS type #1 boot entries.

Binding a third bootmeth changes the exact bootmeth and bootflow listings
that the bootstd tests match against, so update those expectations. Make
them conditional on CONFIG_BOOTMETH_BLS rather than absolute, so the tests
keep describing the world correctly when the bootmeth is configured out.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/sandbox/dts/test.dts |   4 +
 configs/sandbox_defconfig |   1 +
 test/boot/bootdev.c       |  14 ++
 test/boot/bootflow.c      | 377 +++++++++++++++++++++++++++++++++++-----------
 test/boot/bootmeth.c      |  38 +++--
 5 files changed, 332 insertions(+), 102 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a5d8d3977a0d..189d83a81cf6 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -130,6 +130,10 @@
 			compatible = "u-boot,distro-efi";
 		};
 
+		bls {
+			compatible = "u-boot,bls";
+		};
+
 		theme {
 			font-size = <30>;
 			menu-inset = <3>;
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 5c97418783fc..824cb5a26052 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -26,6 +26,7 @@ CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERITY=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
+CONFIG_BOOTMETH_BLS=y
 CONFIG_BOOTMETH_RAUC=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index c2eaf0b2c559..37c829b06c47 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -221,6 +221,8 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	/* Use the environment variable to override it */
 	ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	/* get the usb device which has a backing file (flash1.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
@@ -237,6 +239,8 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(env_set("boot_targets", NULL));
 	ut_assertok(bootflow_scan_first(NULL, "mmc", &iter, 0, &bflow));
 	ut_asserteq(2, iter.num_devs);
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	/* Now scan past mmc1 and make sure that only mmc0 shows up */
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
@@ -250,6 +254,8 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(env_set("boot_targets", "mmc"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(2, iter.num_devs);
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	/* Now scan past mmc1 and make sure that only mmc0 shows up */
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
@@ -263,6 +269,8 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(env_set("boot_targets", "mmc usb"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(2, iter.num_devs);
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	/*
 	 * Now scan past mmc1 and make sure that the 3 USB devices show up. The
@@ -299,6 +307,8 @@ static int bootdev_test_order_default(struct unit_test_state *uts)
 	ut_asserteq(2, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(3, iter.num_devs);
@@ -333,6 +343,8 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	/* get the usb device which has a backing file (flash1.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(6, iter.num_devs);
@@ -354,6 +366,8 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	/* get the usb device which has a backing file (flash1.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(7, iter.num_devs);
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index ef4638ec7000..eb8e27fa2253 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -39,6 +39,12 @@ extern U_BOOT_DRIVER(bootmeth_2script);
 /* Use this as the vendor for EFI to tell the app to exit boot services */
 static u16 __efi_runtime_data test_vendor[] = u"U-Boot testing";
 
+/*
+ * How the BLS entry written to the mmc1 image by setup_extlinux_bls_image()
+ * shows up in a bootflow listing
+ */
+#define BLS_BFLOW "  1  bls          ready   mmc          1  mmc1.bootdev.part_1       /loader/entries/4098b3f648d74c13b1f04ccfba7798e8-5.3.7-301.fc31.armv7hl.conf"
+
 static int inject_response(struct unit_test_state *uts)
 {
 	/*
@@ -67,9 +73,14 @@ static int bootflow_cmd(struct unit_test_state *uts)
 	ut_assert_nextline("Scanning bootdev 'mmc2.bootdev':");
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
 	ut_assert_nextline("  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline(BLS_BFLOW);
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("(2 bootflows, 2 valid)");
+	else
+		ut_assert_nextline("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootflow list", 0));
@@ -77,16 +88,26 @@ static int bootflow_cmd(struct unit_test_state *uts)
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline(BLS_BFLOW);
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("(2 bootflows, 2 valid)");
+	else
+		ut_assert_nextline("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootstd images", 0));
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  mmc1.bootdev.part_1  extlinux_cfg");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen("  1  mmc1.bootdev.part_1  extlinux_cfg");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(1 image)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("(2 images)");
+	else
+		ut_assert_nextline("(1 image)");
 	ut_assert_console_end();
 
 	return 0;
@@ -100,7 +121,10 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 
 	ut_assertok(run_command("bootflow scan -lH mmc1", 0));
 	ut_assert_nextline("Scanning for bootflows with label 'mmc1'");
-	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	else
+		ut_assert_skip_to_line("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootflow scan -lH 0", 0));
@@ -136,7 +160,10 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 		ut_assertok(run_command("bootflow scan -lH 7", 0));
 		ut_assert_nextline("Scanning for bootflows with label '7'");
 	}
-	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	else
+		ut_assert_skip_to_line("(1 bootflow, 1 valid)");
 
 	ut_assertok(run_command("bootflow scan -lH 0", 0));
 	ut_assert_nextline("Scanning for bootflows with label '0'");
@@ -160,10 +187,15 @@ static int bootflow_cmd_glob(struct unit_test_state *uts)
 	ut_assert_nextline("Scanning bootdev 'mmc2.bootdev':");
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
 	ut_assert_nextline("  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline(BLS_BFLOW);
 	ut_assert_nextline("Scanning bootdev 'mmc0.bootdev':");
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("(2 bootflows, 2 valid)");
+	else
+		ut_assert_nextline("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootflow list", 0));
@@ -171,8 +203,13 @@ static int bootflow_cmd_glob(struct unit_test_state *uts)
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline(BLS_BFLOW);
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("(2 bootflows, 2 valid)");
+	else
+		ut_assert_nextline("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	return 0;
@@ -193,24 +230,45 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
 	ut_assert_nextline("  1  efi          media   mmc          0  mmc2.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_assert_nextline("  2  bls          media   mmc          0  mmc2.bootdev.whole        ");
+		ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
+	}
 
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
-	ut_assert_nextline("  2  extlinux     media   mmc          0  mmc1.bootdev.whole        ");
+	ut_assert_nextline("  %x  extlinux     media   mmc          0  mmc1.bootdev.whole        ",
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
-	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
+	ut_assert_nextline("  %x  efi          media   mmc          0  mmc1.bootdev.whole        ",
+			   3 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
-	ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_nextline(
-		"  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
-		efi_get_basename());
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_assert_nextline("  %x  bls          media   mmc          0  mmc1.bootdev.whole        ",
+				   4 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+		ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
+	}
+	ut_assert_nextline("  %x  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf",
+			   4 + 2 * IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextline("  %x  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/%s",
+			   5 + 2 * IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			   efi_get_basename());
 
 	ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
 	ut_assert_skip_to_line(
-		" 3f  efi          media   mmc          0  mmc0.bootdev.whole        ");
+		" %x  efi          media   mmc          0  mmc0.bootdev.whole        ",
+		1 + 31 * (2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)));
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_assert_skip_to_line(
+			" %x  bls          media   mmc          0  mmc0.bootdev.whole        ",
+			2 + 31 * (2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)));
+		ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
+	}
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(64 bootflows, 1 valid)");
+	ut_assert_nextline("(%d bootflows, %d valid)",
+			   32 * (2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)),
+			   1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootflow list", 0));
@@ -219,11 +277,17 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("  0  extlinux     media   mmc          0  mmc2.bootdev.whole        ");
 	ut_assert_nextline("  1  efi          media   mmc          0  mmc2.bootdev.whole        ");
-	ut_assert_skip_to_line(
-		"  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_skip_to_line(" 3f  efi          media   mmc          0  mmc0.bootdev.whole        ");
+	ut_assert_skip_to_line("  %x  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf",
+			       4 + 2 * IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_skip_to_line(" %x  efi          media   mmc          0  mmc0.bootdev.whole        ",
+			       1 + 31 * (2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline(" %x  bls          media   mmc          0  mmc0.bootdev.whole        ",
+			2 + 31 * (2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)));
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(64 bootflows, 1 valid)");
+	ut_assert_nextline("(%d bootflows, %d valid)",
+			   32 * (2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)),
+			   1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_console_end();
 
 	return 0;
@@ -285,6 +349,13 @@ static int bootflow_scan_boot(struct unit_test_state *uts)
 	 */
 	ut_assert_skip_to_line("sandbox: continuing, as we cannot run Linux");
 	ut_assert_nextline("Boot failed (err=-14)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_assert_nextline(
+			"** Booting bootflow 'mmc1.bootdev.part_1' with bls");
+		ut_assert_skip_to_line(
+			"sandbox: continuing, as we cannot run Linux");
+		ut_assert_nextline("Boot failed (err=-22)");
+	}
 	ut_assert_console_end();
 
 	return 0;
@@ -304,7 +375,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
 					BOOTFLOWIF_SKIP_GLOBAL |
 					BOOTFLOWIF_ONLY_BOOTABLE, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(0, iter.part);
 	ut_asserteq(0, iter.max_part);
@@ -325,7 +396,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	bootflow_free(&bflow);
 
 	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(1, iter.cur_method);
 	ut_asserteq(0, iter.part);
 	ut_asserteq(0, iter.max_part);
@@ -335,32 +406,58 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
 	bootflow_free(&bflow);
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
+		ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
+		ut_asserteq(2, iter.cur_method);
+		ut_asserteq(0, iter.part);
+		ut_asserteq(0, iter.max_part);
+		ut_asserteq_str("bls", iter.method->name);
+		ut_asserteq(0, bflow.err);
+		ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+		ut_asserteq(BIT(0) | BIT(1) | BIT(2), iter.methods_done);
+		bootflow_free(&bflow);
+	}
+
 	/* The next device is mmc1.bootdev - at first we use the whole device */
 	ut_asserteq(-ENOENT, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(0, iter.part);
 	ut_asserteq(0x1e, iter.max_part);
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
-	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
+	ut_asserteq(BIT(0) | BIT(1) | (IS_ENABLED(CONFIG_BOOTMETH_BLS) ? BIT(2) : 0), iter.methods_done);
 	bootflow_free(&bflow);
 
 	ut_asserteq(-ENOENT, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(1, iter.cur_method);
 	ut_asserteq(0, iter.part);
 	ut_asserteq(0x1e, iter.max_part);
 	ut_asserteq_str("efi", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
-	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
+	ut_asserteq(BIT(0) | BIT(1) | (IS_ENABLED(CONFIG_BOOTMETH_BLS) ? BIT(2) : 0), iter.methods_done);
 	bootflow_free(&bflow);
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_asserteq(-ENOENT, bootflow_scan_next(&iter, &bflow));
+		ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
+		ut_asserteq(2, iter.cur_method);
+		ut_asserteq(0, iter.part);
+		ut_asserteq(0x1e, iter.max_part);
+		ut_asserteq_str("bls", iter.method->name);
+		ut_asserteq(0, bflow.err);
+		ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
+		ut_asserteq(BIT(0) | BIT(1) | BIT(2), iter.methods_done);
+		bootflow_free(&bflow);
+	}
+
 	/* Then move to partition 1 where we find something */
 	ut_assertok(bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(1, iter.part);
 	ut_asserteq(0x1e, iter.max_part);
@@ -370,7 +467,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	bootflow_free(&bflow);
 
 	ut_asserteq(-ENOENT, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(1, iter.cur_method);
 	ut_asserteq(1, iter.part);
 	ut_asserteq(0x1e, iter.max_part);
@@ -379,16 +476,28 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq(BOOTFLOWST_FS, bflow.state);
 	bootflow_free(&bflow);
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		ut_assertok(bootflow_scan_next(&iter, &bflow));
+		ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
+		ut_asserteq(2, iter.cur_method);
+		ut_asserteq(1, iter.part);
+		ut_asserteq(0x1e, iter.max_part);
+		ut_asserteq_str("bls", iter.method->name);
+		ut_asserteq(0, bflow.err);
+		ut_asserteq(BOOTFLOWST_READY, bflow.state);
+		bootflow_free(&bflow);
+	}
+
 	/* Then more to partition 2 which exists but is not bootable */
 	ut_asserteq(-EINVAL, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(2, iter.part);
 	ut_asserteq(0x1e, iter.max_part);
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_asserteq(BOOTFLOWST_MEDIA, bflow.state);
-	ut_asserteq(BIT(0) | BIT(1), iter.methods_done);
+	ut_asserteq(BIT(0) | BIT(1) | (IS_ENABLED(CONFIG_BOOTMETH_BLS) ? BIT(2) : 0), iter.methods_done);
 	bootflow_free(&bflow);
 
 	bootflow_iter_uninit(&iter);
@@ -413,12 +522,12 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	ut_asserteq(-EINVAL,
 		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
 					BOOTFLOWIF_SHOW, &bflow));
-	ut_asserteq(3, iter.num_methods);
+	ut_asserteq(3 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_assert(iter.doing_global);
 	ut_assert(iter.have_global);
-	ut_asserteq(2, iter.first_glob_method);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.first_glob_method);
 
-	ut_asserteq(2, iter.cur_method);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.cur_method);
 	ut_asserteq(0, iter.part);
 	ut_asserteq(0, iter.max_part);
 	ut_asserteq_str("firmware0", iter.method->name);
@@ -429,8 +538,8 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
 
 	/* at this point the global bootmeths are stranded above num_methods */
-	ut_asserteq(3, iter.num_methods);
-	ut_asserteq(2, iter.first_glob_method);
+	ut_asserteq(3 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.first_glob_method);
 	ut_assert(!iter.doing_global);
 	ut_assert(iter.have_global);
 
@@ -461,9 +570,12 @@ static int bootflow_system(struct unit_test_state *uts)
 	bootstd_clear_glob();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
-		"  1  efi_mgr      ready   (none)       0  <NULL>                    ");
+		"  %x  efi_mgr      ready   (none)       0  <NULL>                    ",
+		1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_skip_to_line("No more bootdevs");
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_console_end();
 
 	return 0;
@@ -496,10 +608,10 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 
 	/* at this point the global bootmeths are stranded above num_methods */
-	ut_asserteq(4, iter.num_methods);
+	ut_asserteq(4 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 	ut_assert(!iter.doing_global);
 	ut_assert(iter.have_global);
-	ut_asserteq(3, iter.first_glob_method);
+	ut_asserteq(3 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.first_glob_method);
 	ut_asserteq_str("sandbox", iter.method->name);
 	ut_assertok(inject_response(uts));
 	ut_asserteq(-ENOTSUPP, bootflow_run_boot(&iter, &bflow));
@@ -508,13 +620,13 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* Check that the sandbox bootmeth has been removed */
-	ut_asserteq(3, iter.num_methods);
+	ut_asserteq(3 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.num_methods);
 
 	for (i = 0; i < iter.num_methods; i++)
 		ut_assert(strcmp("sandbox", iter.method_order[i]->name));
 
 	/* the first global bootmeth is now down one place in the list */
-	ut_asserteq(2, iter.first_glob_method);
+	ut_asserteq(2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), iter.first_glob_method);
 
 	return 0;
 }
@@ -736,7 +848,10 @@ static int bootflow_cmd_menu(struct unit_test_state *uts)
 	ut_asserteq(2, console_in_puts(prev));
 
 	ut_assertok(run_command("bootflow menu", 0));
-	ut_assert_nextline("Selected: Armbian");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("Selected: Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)");
+	else
+		ut_assert_nextline("Selected: Armbian");
 	ut_assertnonnull(std->cur_bootflow);
 	ut_assert_console_end();
 
@@ -759,18 +874,27 @@ static int bootflow_scan_menu(struct unit_test_state *uts)
 {
 	struct bootstd_priv *std;
 	const char **old_order, **new_order;
-	char prev[3];
+	char prev[4];
 
 	/* get access to the current bootflow */
 	ut_assertok(bootstd_get_priv(&std));
 
 	ut_assertok(prep_mmc_bootdev(uts, "mmc4", false, &old_order));
 
-	/* Add keypresses to move to and select the second one in the list */
-	prev[0] = CTL_CH('n');
-	prev[1] = '\r';
-	prev[2] = '\0';
-	ut_asserteq(2, console_in_puts(prev));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		/* Add keypresses to move to and select the third one in the list */
+		prev[0] = CTL_CH('n');
+		prev[1] = CTL_CH('n');
+		prev[2] = '\r';
+		prev[3] = '\0';
+		ut_asserteq(3, console_in_puts(prev));
+	} else {
+		/* Add keypresses to move to and select the second one in the list */
+		prev[0] = CTL_CH('n');
+		prev[1] = '\r';
+		prev[2] = '\0';
+		ut_asserteq(2, console_in_puts(prev));
+	}
 
 	ut_assertok(run_command("bootflow scan -lm", 0));
 	new_order = std->bootdev_order;
@@ -778,7 +902,9 @@ static int bootflow_scan_menu(struct unit_test_state *uts)
 
 	ut_assert_skip_to_line("No more bootdevs");
 	ut_assert_nextlinen("--");
-	ut_assert_nextline("(2 bootflows, 2 valid)");
+	ut_assert_nextline("(%d bootflows, %d valid)",
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assert_nextline("Selected: Armbian");
 	ut_assertnonnull(std->cur_bootflow);
@@ -794,7 +920,9 @@ static int bootflow_scan_menu(struct unit_test_state *uts)
 	std->bootdev_order = old_order;
 
 	ut_assertnull(std->cur_bootflow);
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextline("Nothing chosen");
 	ut_assert_console_end();
 
@@ -807,23 +935,34 @@ static int bootflow_scan_menu_boot(struct unit_test_state *uts)
 {
 	struct bootstd_priv *std;
 	const char **old_order;
-	char prev[3];
+	char prev[4];
 
 	/* get access to the current bootflow */
 	ut_assertok(bootstd_get_priv(&std));
 
 	ut_assertok(prep_mmc_bootdev(uts, "mmc4", false, &old_order));
 
-	/* Add keypresses to move to and select the second one in the list */
-	prev[0] = CTL_CH('n');
-	prev[1] = '\r';
-	prev[2] = '\0';
-	ut_asserteq(2, console_in_puts(prev));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		/* Add keypresses to move to and select the third one in the list */
+		prev[0] = CTL_CH('n');
+		prev[1] = CTL_CH('n');
+		prev[2] = '\r';
+		prev[3] = '\0';
+		ut_asserteq(3, console_in_puts(prev));
+	} else {
+		/* Add keypresses to move to and select the second one in the list */
+		prev[0] = CTL_CH('n');
+		prev[1] = '\r';
+		prev[2] = '\0';
+		ut_asserteq(2, console_in_puts(prev));
+	}
 
 	ut_assertok(run_command("bootflow scan -lmb", 0));
 	std->bootdev_order = old_order;
 
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assert_nextline("Selected: Armbian");
 
@@ -860,7 +999,10 @@ static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
 
 	ut_assertok(run_command("bootflow scan -l mmc1", 0));
 	ut_assert_nextline("Scanning for bootflows with label 'mmc1'");
-	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	else
+		ut_assert_skip_to_line("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	/* check that the hunter was used */
@@ -897,8 +1039,13 @@ static int bootflow_cmd_hunt_label(struct unit_test_state *uts)
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
 	ut_assert_nextline(
 		"  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline(BLS_BFLOW);
 	ut_assert_nextline("Scanning bootdev 'mmc0.bootdev':");
-	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	else
+		ut_assert_skip_to_line("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
 	return 0;
@@ -1262,23 +1409,37 @@ static int bootflow_cros(struct unit_test_state *uts)
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
-	ut_assert_nextlinen("  1  cros         ready   mmc          2  mmc5.bootdev.part_2       ");
-	ut_assert_nextlinen("  2  cros         ready   mmc          4  mmc5.bootdev.part_4       ");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen(BLS_BFLOW);
+	ut_assert_nextlinen("  %x  cros         ready   mmc          2  mmc5.bootdev.part_2       ",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  cros         ready   mmc          4  mmc5.bootdev.part_4       ",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_skip_to_line("(3 bootflows, 3 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       3 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       3 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assertok(run_command("bootstd images", 0));
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  mmc1.bootdev.part_1  extlinux_cfg");
-	ut_assert_nextlinen("  1  mmc5.bootdev.part_2  x86_setup");
-	ut_assert_nextlinen("  1  mmc5.bootdev.part_2  cmdline");
-	ut_assert_nextlinen("  1  mmc5.bootdev.part_2  kernel                 -      4000  kernel");
-	ut_assert_nextlinen("  2  mmc5.bootdev.part_4  x86_setup");
-	ut_assert_nextlinen("  2  mmc5.bootdev.part_4  cmdline");
-	ut_assert_nextlinen("  2  mmc5.bootdev.part_4  kernel                 -      4000  kernel");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen("  1  mmc1.bootdev.part_1  extlinux_cfg");
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_2  x86_setup",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_2  cmdline",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_2  kernel                 -      4000  kernel",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_4  x86_setup",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_4  cmdline",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_4  kernel                 -      4000  kernel",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(7 images)");
+	ut_assert_nextline("(%d images)", 7 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assert_console_end();
 
@@ -1299,9 +1460,14 @@ static int bootflow_android_image_v4(struct unit_test_state *uts)
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
-	ut_assert_nextlinen("  1  android      ready   mmc          0  mmc7.bootdev.whole        ");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen(BLS_BFLOW);
+	ut_assert_nextlinen("  %d  android      ready   mmc          0  mmc7.bootdev.whole        ",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assert_console_end();
 
@@ -1322,9 +1488,14 @@ static int bootflow_android_image_v2(struct unit_test_state *uts)
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
-	ut_assert_nextlinen("  1  android      ready   mmc          0  mmc8.bootdev.whole        ");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen(BLS_BFLOW);
+	ut_assert_nextlinen("  %d  android      ready   mmc          0  mmc8.bootdev.whole        ",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assert_console_end();
 
@@ -1363,13 +1534,20 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
-	ut_assert_nextlinen(
-		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen(BLS_BFLOW);
+	ut_assert_nextlinen("  %x  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_console_end();
 
-	ut_assertok(run_command("bootflow select 1", 0));
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assertok(run_command("bootflow select 2", 0));
+	else
+		ut_assertok(run_command("bootflow select 1", 0));
 	ut_assert_console_end();
 
 	systab.fw_vendor = test_vendor;
@@ -1519,30 +1697,49 @@ static int bootstd_images(struct unit_test_state *uts)
 	std->bootdev_order = old_order;
 
 	ut_assertok(run_command("bootflow list", 0));
-	ut_assert_skip_to_line("(4 bootflows, 4 valid)");
+	ut_assert_skip_to_line("(%d bootflows, %d valid)",
+			       4 + IS_ENABLED(CONFIG_BOOTMETH_BLS),
+			       4 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
 	ut_assertok(run_command("bootstd images", 0));
 	ut_assert_nextlinen("Seq");
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  mmc1.bootdev.part_1  extlinux_cfg");
-	ut_assert_nextlinen("  1  mmc4.bootdev.part_1  script");
-	ut_assert_nextlinen("  1  mmc4.bootdev.part_1  logo");
-	ut_assert_nextlinen("  2  mmc5.bootdev.part_2  x86_setup");
-	ut_assert_nextlinen("  2  mmc5.bootdev.part_2  cmdline");
-	ut_assert_nextlinen("  2  mmc5.bootdev.part_2  kernel                 -");
-	ut_assert_nextlinen("  3  mmc5.bootdev.part_4  x86_setup");
-	ut_assert_nextlinen("  3  mmc5.bootdev.part_4  cmdline");
-	ut_assert_nextlinen("  3  mmc5.bootdev.part_4  kernel                 -");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextlinen("  1  mmc1.bootdev.part_1  extlinux_cfg");
+	ut_assert_nextlinen("  %x  mmc4.bootdev.part_1  script",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc4.bootdev.part_1  logo",
+			    1 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_2  x86_setup",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_2  cmdline",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_2  kernel                 -",
+			    2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_4  x86_setup",
+			    3 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_4  cmdline",
+			    3 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
+	ut_assert_nextlinen("  %x  mmc5.bootdev.part_4  kernel                 -",
+			    3 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(9 images)");
+	ut_assert_nextline("(%d images)", 9 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 
-	/* check the first image */
+	/* check the extlinux.conf image */
 	bflow = alist_get(&std->bootflows, 0, struct bootflow);
 	img = alist_get(&bflow->images, 0, struct bootflow_img);
 	ut_asserteq_strn("# extlinux.conf", map_sysmem(img->addr, 0));
 
-	/* check the second image */
-	bflow = alist_get(&std->bootflows, 1, struct bootflow);
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS)) {
+		/* check the BLS entry image */
+		bflow = alist_get(&std->bootflows, 1, struct bootflow);
+		img = alist_get(&bflow->images, 0, struct bootflow_img);
+		ut_asserteq_strn("# BLS type 1 ", map_sysmem(img->addr, 0));
+	}
+
+	/* check the script image */
+	bflow = alist_get(&std->bootflows, 1 + IS_ENABLED(CONFIG_BOOTMETH_BLS), struct bootflow);
 	img = alist_get(&bflow->images, 0, struct bootflow_img);
 
 	/* this is the length of the script in bytes */
@@ -1552,7 +1749,7 @@ static int bootstd_images(struct unit_test_state *uts)
 	ut_asserteq_strn("# DO NOT EDIT THIS FILE", ptr);
 
 	/* check the ChromiumOS images */
-	bflow = alist_get(&std->bootflows, 2, struct bootflow);
+	bflow = alist_get(&std->bootflows, 2 + IS_ENABLED(CONFIG_BOOTMETH_BLS), struct bootflow);
 	img = alist_get(&bflow->images, 1, struct bootflow_img);
 	ptr = map_sysmem(img->addr, 0);
 	ut_asserteq_strn("BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=", ptr);
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 2ef3569ad837..8400a2e7879e 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -21,11 +21,15 @@ static int bootmeth_cmd_list(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    0    0  extlinux            Extlinux boot from a block device");
 	ut_assert_nextline("    1    1  efi                 EFI boot from an .efi file");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("    2    2  bls                 Boot Loader Specification");
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
-		ut_assert_nextline(" glob    2  firmware0           VBE simple");
+		ut_assert_nextline(" glob    %d  firmware0           VBE simple",
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+	ut_assert_nextline("(%d bootmeths)",
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
 	ut_assert_console_end();
 
 	return 0;
@@ -56,11 +60,15 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    0    0  extlinux            Extlinux boot from a block device");
 	ut_assert_nextline("    -    1  efi                 EFI boot from an .efi file");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("    -    2  bls                 Boot Loader Specification");
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
-		ut_assert_nextline(" glob    2  firmware0           VBE simple");
+		ut_assert_nextline(" glob    %d  firmware0           VBE simple",
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+	ut_assert_nextline("(%d bootmeths)",
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
 	ut_assert_console_end();
 
 	/* Check the -a flag with the reverse order */
@@ -71,11 +79,15 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    1    0  extlinux            Extlinux boot from a block device");
 	ut_assert_nextline("    0    1  efi                 EFI boot from an .efi file");
+	if (IS_ENABLED(CONFIG_BOOTMETH_BLS))
+		ut_assert_nextline("    -    2  bls                 Boot Loader Specification");
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL))
-		ut_assert_nextline(" glob    2  firmware0           VBE simple");
+		ut_assert_nextline(" glob    %d  firmware0           VBE simple",
+				   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
-	ut_assert_nextline(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+	ut_assert_nextline("(%d bootmeths)",
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+			     + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
 	ut_assert_console_end();
 
 	/* Now reset the order to empty, which should show all of them again */
@@ -83,8 +95,9 @@ static int bootmeth_cmd_order(struct unit_test_state *uts)
 	ut_assert_console_end();
 	ut_assertnull(env_get("bootmeths"));
 	ut_assertok(run_command("bootmeth list", 0));
-	ut_assert_skip_to_line(IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) ?
-		 "(3 bootmeths)" : "(2 bootmeths)");
+	ut_assert_skip_to_line("(%d bootmeths)",
+			       2 + IS_ENABLED(CONFIG_BOOTMETH_BLS)
+				 + IS_ENABLED(CONFIG_BOOTMETH_GLOBAL));
 
 	/* Try reverse order */
 	ut_assertok(run_command("bootmeth order \"efi extlinux\"", 0));
@@ -116,7 +129,8 @@ static int bootmeth_cmd_order_glob(struct unit_test_state *uts)
 	ut_assert_nextline("Order  Seq  Name                Description");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("    0    1  efi                 EFI boot from an .efi file");
-	ut_assert_nextline(" glob    2  firmware0           VBE simple");
+	ut_assert_nextline(" glob    %d  firmware0           VBE simple",
+			   2 + IS_ENABLED(CONFIG_BOOTMETH_BLS));
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(2 bootmeths)");
 	ut_assertnonnull(env_get("bootmeths"));

-- 
2.54.0

