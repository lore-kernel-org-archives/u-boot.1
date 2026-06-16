Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82526CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 19:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDBF8496E;
	Tue, 16 Jun 2026 21:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJ8Tcs4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ACF884942; Tue, 16 Jun 2026 21:19:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C456A84968
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 21:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so34717935e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781637545; x=1782242345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YGALTYMS15EqjQ1MBXV91Hd8L1a2PKenMctiVDnqzaQ=;
 b=WJ8Tcs4yJ9VYsNYd2eUanytoMj7Olwz3ka1P+psqXAvZ7Q5h87mUkRNdth5y2b5qjQ
 RrG2rvruBmtGrU8lXqa8v4XRr/BntGpbkLnkRegZlyXUNj6BjV10AVBdFBUJFUVm4Jpn
 T7slTh12dmuoFl55VyCkrLoQHpmrHpbQGDqxuNmZKArHzeZ8L471l7DM13LqJ4qsDnm5
 QdkZ/1vtlVK38V+G0uOJ2XZ95Bz7xRyWWxk55aO9b+24fUB/+rlafUrsTofnnnfyqikp
 W/E14cPCL/QAdlkghsrFvvALKMh3VBhace6UqNgT62M82gLBp+NmR1OIpI+3U4Ll5Gg8
 nO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637545; x=1782242345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YGALTYMS15EqjQ1MBXV91Hd8L1a2PKenMctiVDnqzaQ=;
 b=NJEYYgQ427bIJtRGdQw2Mv/Q3R1bsD1YMOTfN2z4d12mj7ovxHz2RcVyWYPMM6wo1e
 Vzrz9q06V5FaZGw0rzO2NlggIaM+W62+GxSxQCZ/s88Bftgnzgq4PIa/X76/2t2MNEJs
 PW+cD2Pi4LqXDaUQrFpkygPRhvmQ2Vpir1Aja6XlXAJSMklGa6I9HeKi6yw8nAb4enmM
 WQtsPJZAhv0dU36AyvbUWf/v9IvNkTpsCDyThqU17zVO5E/IOxaBxFBYF9zxEW5Nbgcb
 Npo16OLjy3xe9k6BWlbkNp3FX03QoDZGaxfTZlBvilOFSV4ySNymPKTYUUCuMTcNyOW6
 8tyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CZ/I238aoDQObLcl1DrDpt5urKEd2+2flK5ITJNdQboKslpBkYdzwZKHWgzsTfL6a0yEyEbI=@lists.denx.de
X-Gm-Message-State: AOJu0YzwFT/RigNK7Aau2i5dIQ/nrE9tra/Lc6rb6vJiLWzsP4wUEUcZ
 EzCUZAjEUAd6Y8VAvTst3b87SFKx2uz+pQQ4s77Zufwo47uo2bfs0hM3
X-Gm-Gg: Acq92OEsfTF1ey3R5bY5Lh3jgbWDhIvGQKNhivgo+kxwlzX+eb1d8FHxD1APXuJO/qT
 vwoTO/rOb5VVtS7EOZnp57vh37dZVQiA8nBfULSVj6ADKayOb8sf/G/c2AeqC6MmPQhdmoQhSGT
 d4JHG3szSdIKkrpsvuxXspoUlrk0an1Y7PMSkfJ4IH+txA/KnuebI9R5PmDTgze73w0Kd3Vbe5k
 ysvr4+LL/ml+NIw0u5q0C2Q951auykzmiqWef2Qj29QVcY0TOPw2fcO5r/BVTk0TVlWlrvLbtdr
 l5he5hXS/uh7mFzYRoz9ZOcERk24qDeZTed/NTFtjc2DLZL8V5b86mrBaBzG/TXUMExSJBOhQFl
 TXNfbeMiuI4fGTHorsegbrCP/CF3zO/NcmIQzWKOHtINjn2k+ap7zokCUIedqqQysh2JKnpH/3u
 xZ/W3NquTa8i71VqB1tjD9m0dEE68NPnmLPGpuL/VUiVOTUyJOYryB9C8=
X-Received: by 2002:a05:600c:19c8:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-492333aa56fmr15125285e9.9.1781637544841; 
 Tue, 16 Jun 2026 12:19:04 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm91326895e9.0.2026.06.16.12.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:19:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Randolph Sapp <rs@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v7 7/7] test: dm: Add test for FW Loader feature
Date: Tue, 16 Jun 2026 21:18:42 +0200
Message-ID: <20260616191845.6182-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191845.6182-1-ansuelsmth@gmail.com>
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
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

Add basic test for FW Loader feature for the Filesystem way.

An additional MMC testing image is added that loads a dummy firmware.bin in
a fat partition. Update all the affected test for this additional eMMC
node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts          |  20 ++++++
 configs/sandbox64_defconfig        |   1 +
 configs/sandbox_defconfig          |   1 +
 configs/sandbox_flattree_defconfig |   1 +
 configs/sandbox_noinst_defconfig   |   1 +
 configs/sandbox_spl_defconfig      |   1 +
 configs/sandbox_vpl_defconfig      |   1 +
 test/boot/bootdev.c                |  34 +++++----
 test/boot/bootflow.c               |  12 +++-
 test/dm/Makefile                   |   1 +
 test/dm/blk.c                      |  41 +++++++----
 test/dm/fw_loader.c                | 112 +++++++++++++++++++++++++++++
 test/py/tests/test_ut.py           |  18 +++++
 13 files changed, 216 insertions(+), 28 deletions(-)
 create mode 100644 test/dm/fw_loader.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 074e5c06ec82..8132af5a677e 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -49,6 +49,7 @@
 		mmc8 = "/mmc8";
 		mmc9 = "/mmc9";
 		mmc10 = "/mmc10";
+		mmc11 = "/mmc11";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -184,6 +185,12 @@
 		};
 	};
 
+	fs_loader: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&mmc11 1>;
+	};
+
 	cedit: cedit {
 	};
 
@@ -1348,6 +1355,12 @@
 		filename = "mmc10.img";
 	};
 
+	/* This is used for FW Loader tests */
+	mmc11: mmc11 {
+		compatible = "sandbox,mmc";
+		filename = "mmc11.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
@@ -2081,6 +2094,13 @@
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 		};
+
+		ethernet-phy@2 {
+			reg = <2>;
+
+			firmware-name = "firmware.bin";
+			firmware-loader = <&fs_loader>;
+		};
 	};
 
 	pm-bus-test {
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index f5d5b21e7331..17c15e8db01a 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -271,6 +271,7 @@ CONFIG_WDT_ALARM_SANDBOX=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_EXFAT=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 512dbd6a0c6c..74661bc2560c 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -379,6 +379,7 @@ CONFIG_WDT_FTWDT010=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_EXFAT=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 CONFIG_ADDR_MAP=y
 CONFIG_PANIC_HANG=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 4ad2bb016738..141e540574d1 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -16,6 +16,7 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERITY=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_FS_LOADER=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 076be6586cf5..b29cb9ad4d11 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_MEMTEST_END=0x00101000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_FS_LOADER=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 3b6d18d7d76e..ae930a3aaf99 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -226,6 +226,7 @@ CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 363d73cf0307..9967e1973f0e 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -234,6 +234,7 @@ CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 0820bf10ee08..a0dc5270d841 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -34,8 +34,10 @@ static int bootdev_test_cmd_list(struct unit_test_state *uts)
 				   "mmc", "mmc1.bootdev");
 		ut_assert_nextline("%3x   [ %c ]  %6s  %-8s  %s", 2, probe_ch, "OK",
 				   "mmc", "mmc0.bootdev");
+		ut_assert_nextline("%3x   [ %c ]  %6s  %-8s  %s", 3, probe_ch, "OK",
+				   "mmc", "mmc11.bootdev");
 		ut_assert_nextlinen("---");
-		ut_assert_nextline("(3 bootdevs)");
+		ut_assert_nextline("(4 bootdevs)");
 		ut_assert_console_end();
 	}
 
@@ -240,10 +242,11 @@ static int bootdev_test_order(struct unit_test_state *uts)
 
 	/* Now scan past mmc1 and make sure that only mmc0 shows up */
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
+	ut_asserteq(4, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	ut_asserteq_str("mmc11.bootdev", iter.dev_used[3]->name);
 	bootflow_iter_uninit(&iter);
 
 	/* Try a single uclass with boot_targets */
@@ -253,10 +256,11 @@ static int bootdev_test_order(struct unit_test_state *uts)
 
 	/* Now scan past mmc1 and make sure that only mmc0 shows up */
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
+	ut_asserteq(4, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	ut_asserteq_str("mmc11.bootdev", iter.dev_used[3]->name);
 	bootflow_iter_uninit(&iter);
 
 	/* Try a single uclass with boot_targets */
@@ -270,12 +274,13 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	 */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(6, iter.num_devs);
+	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	ut_asserteq_str("mmc11.bootdev", iter.dev_used[3]->name);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
-			iter.dev_used[3]->name);
+			iter.dev_used[4]->name);
 	bootflow_iter_uninit(&iter);
 
 	return 0;
@@ -301,8 +306,9 @@ static int bootdev_test_order_default(struct unit_test_state *uts)
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(3, iter.num_devs);
+	ut_asserteq(4, iter.num_devs);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
+	ut_asserteq_str("mmc11.bootdev", iter.dev_used[3]->name);
 	bootflow_iter_uninit(&iter);
 
 	return 0;
@@ -328,23 +334,23 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	ut_assertok(bootstd_test_drop_bootdev_order(uts));
 
-	/* 3 MMC and 3 USB bootdevs: MMC should come before USB */
+	/* 4 MMC and 3 USB bootdevs: MMC should come before USB */
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 
 	/* get the usb device which has a backing file (flash1.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(6, iter.num_devs);
+	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
-			iter.dev_used[3]->name);
+			iter.dev_used[4]->name);
 
-	ut_assertok(bootdev_get_sibling_blk(iter.dev_used[3], &blk));
+	ut_assertok(bootdev_get_sibling_blk(iter.dev_used[4], &blk));
 	ut_asserteq_str("usb_mass_storage.lun0", blk->name);
 
 	/* adjust the priority of the first USB bootdev to the highest */
-	ucp = dev_get_uclass_plat(iter.dev_used[3]);
+	ucp = dev_get_uclass_plat(iter.dev_used[4]);
 	ucp->prio = BOOTDEVP_1_PRE_SCAN;
 
 	/* try again but enable hunting, which brings in SCSI */
@@ -356,7 +362,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(7, iter.num_devs);
+	ut_asserteq(8, iter.num_devs);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
 			iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
@@ -732,6 +738,10 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
 	ut_asserteq_str("mmc0.bootdev", dev->name);
 	ut_assert_console_end();
 
+	ut_assertok(bootdev_next_prio(&iter, &dev));
+	ut_asserteq_str("mmc11.bootdev", dev->name);
+	ut_assert_console_end();
+
 	ut_assertok(bootdev_next_prio(&iter, &dev));
 	ut_asserteq_str("spi.bin@0.bootdev", dev->name);
 	ut_assert_skip_to_line("Hunting with: spi_flash");
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 56ee1952357b..bc17f33be192 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -123,6 +123,7 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
 	 * 8   [   ]      OK  mmc       mmc2.bootdev
 	 * 9   [ + ]      OK  mmc       mmc1.bootdev
 	 * a   [   ]      OK  mmc       mmc0.bootdev
+	 * a   [   ]      OK  mmc       mmc11.bootdev
 	 *
 	 * However with CONFIG_DSA_SANDBOX=n we have two fewer (dsa-test@0 and
 	 * dsa-test@1).
@@ -159,6 +160,7 @@ static int bootflow_cmd_glob(struct unit_test_state *uts)
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
 	ut_assert_nextline("  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
 	ut_assert_nextline("Scanning bootdev 'mmc0.bootdev':");
+	ut_assert_nextline("Scanning bootdev 'mmc11.bootdev':");
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(1 bootflow, 1 valid)");
@@ -206,9 +208,13 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_skip_to_line(
 		" 3f  efi          media   mmc          0  mmc0.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
+	ut_assert_skip_to_line("Scanning bootdev 'mmc11.bootdev':");
+	ut_assert_skip_to_line(
+		" 7b  efi          media   mmc         1d  mmc11.bootdev.part_1d     ");
+	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(64 bootflows, 1 valid)");
+	ut_assert_nextline("(124 bootflows, 1 valid)");
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootflow list", 0));
@@ -220,8 +226,9 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_skip_to_line(
 		"  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
 	ut_assert_skip_to_line(" 3f  efi          media   mmc          0  mmc0.bootdev.whole        ");
+	ut_assert_skip_to_line(" 7b  efi          media   mmc         1d  mmc11.bootdev.part_1d     ");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("(64 bootflows, 1 valid)");
+	ut_assert_nextline("(124 bootflows, 1 valid)");
 	ut_assert_console_end();
 
 	return 0;
@@ -549,6 +556,7 @@ static int bootflow_scan_glob_bootmeth(struct unit_test_state *uts)
 	ut_assert_nextline("Scanning bootdev 'mmc2.bootdev':");
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
 	ut_assert_nextline("Scanning bootdev 'mmc0.bootdev':");
+	ut_assert_nextline("Scanning bootdev 'mmc11.bootdev':");
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(0 bootflows, 0 valid)");
diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66a..0f8a580eee7e 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
 endif
+obj-$(CONFIG_FW_LOADER_UCLASS) += fw_loader.o
 obj-$(CONFIG_FIRMWARE) += firmware.o
 obj-$(CONFIG_DM_FPGA) += fpga.o
 obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
diff --git a/test/dm/blk.c b/test/dm/blk.c
index f67869107da1..e9656da6cacb 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -79,12 +79,12 @@ static int dm_test_blk_usb(struct unit_test_state *uts)
 	ut_asserteq_ptr(usb_dev, dev_get_parent(dev));
 
 	/* Check we have one block device for each mass storage device */
-	ut_asserteq(6, count_blk_devices());
+	ut_asserteq(7, count_blk_devices());
 
 	/* Now go around again, making sure the old devices were unbound */
 	ut_assertok(usb_stop());
 	ut_assertok(usb_init());
-	ut_asserteq(6, count_blk_devices());
+	ut_asserteq(7, count_blk_devices());
 	ut_assertok(usb_stop());
 
 	return 0;
@@ -187,6 +187,8 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 	ut_asserteq_str("mmc1.blk", dev->name);
 	ut_assertok(blk_next_device_err(BLKF_REMOVABLE, &dev));
 	ut_asserteq_str("mmc0.blk", dev->name);
+	ut_assertok(blk_next_device_err(BLKF_REMOVABLE, &dev));
+	ut_asserteq_str("mmc11.blk", dev->name);
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_REMOVABLE, &dev));
 
 	ut_assertok(blk_first_device_err(BLKF_BOTH, &dev));
@@ -195,11 +197,13 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 	ut_asserteq_str("mmc1.blk", dev->name);
 	ut_assertok(blk_next_device_err(BLKF_BOTH, &dev));
 	ut_asserteq_str("mmc0.blk", dev->name);
+	ut_assertok(blk_next_device_err(BLKF_BOTH, &dev));
+	ut_asserteq_str("mmc11.blk", dev->name);
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_FIXED, &dev));
 
 	ut_asserteq(1, blk_count_devices(BLKF_FIXED));
-	ut_asserteq(2, blk_count_devices(BLKF_REMOVABLE));
-	ut_asserteq(3, blk_count_devices(BLKF_BOTH));
+	ut_asserteq(3, blk_count_devices(BLKF_REMOVABLE));
+	ut_asserteq(4, blk_count_devices(BLKF_BOTH));
 
 	i = 0;
 	blk_foreach_probe(BLKF_FIXED, dev)
@@ -208,14 +212,15 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 
 	i = 0;
 	blk_foreach_probe(BLKF_REMOVABLE, dev)
-		ut_asserteq_str(i++ ? "mmc0.blk" : "mmc1.blk", dev->name);
-	ut_asserteq(2, i);
+		ut_asserteq_str((++i == 1 ? "mmc1.blk" : i == 2 ?
+			"mmc0.blk" : "mmc11.blk"), dev->name);
+	ut_asserteq(3, i);
 
 	i = 0;
 	blk_foreach_probe(BLKF_BOTH, dev)
 		ut_asserteq_str((++i == 1 ? "mmc2.blk" : i == 2 ?
-			"mmc1.blk" : "mmc0.blk"), dev->name);
-	ut_asserteq(3, i);
+			"mmc1.blk" : i == 3 ? "mmc0.blk" : "mmc11.blk"), dev->name);
+	ut_asserteq(4, i);
 
 	return 0;
 }
@@ -239,6 +244,10 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc0.blk", dev->name);
 
+	ut_assertok(blk_next_device_err(BLKF_BOTH, &dev));
+	ut_assertnonnull(dev);
+	ut_asserteq_str("mmc11.blk", dev->name);
+
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_BOTH, &dev));
 
 	/* Look only for fixed devices */
@@ -257,6 +266,10 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc0.blk", dev->name);
 
+	ut_assertok(blk_next_device_err(BLKF_REMOVABLE, &dev));
+	ut_assertnonnull(dev);
+	ut_asserteq_str("mmc11.blk", dev->name);
+
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_REMOVABLE, &dev));
 
 	return 0;
@@ -269,24 +282,24 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
 	struct udevice *dev;
 	int found;
 
-	/* The test device tree has two fixed and one removable block device(s) */
+	/* The test device tree has three fixed and one removable block device(s) */
 	found = 0;
 	blk_foreach_probe(BLKF_BOTH, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(7, found);
-	ut_asserteq(3, blk_count_devices(BLKF_BOTH));
+	ut_asserteq(BIT(11) | BIT(2) | BIT(1) | BIT(0), found);
+	ut_asserteq(4, blk_count_devices(BLKF_BOTH));
 
 	found = 0;
 	blk_foreach_probe(BLKF_FIXED, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(4, found);
+	ut_asserteq(BIT(2), found);
 	ut_asserteq(1, blk_count_devices(BLKF_FIXED));
 
 	found = 0;
 	blk_foreach_probe(BLKF_REMOVABLE, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(3, found);
-	ut_asserteq(2, blk_count_devices(BLKF_REMOVABLE));
+	ut_asserteq(BIT(11) | BIT(1) | BIT(0), found);
+	ut_asserteq(3, blk_count_devices(BLKF_REMOVABLE));
 
 	return 0;
 }
diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
new file mode 100644
index 000000000000..b2863a0790ba
--- /dev/null
+++ b/test/dm/fw_loader.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/test.h>
+#include <fw_loader.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int dm_test_fw_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *mdio_dev, *fw_loader_dev = NULL;
+	ofnode mdio_node, phy_node;
+	int ret;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, "mdio-test",
+					      &mdio_dev));
+
+	mdio_node = dev_ofnode(mdio_dev);
+	ut_assert(ofnode_valid(mdio_node));
+
+	phy_node = ofnode_find_subnode(mdio_node, "ethernet-phy@1");
+	ut_assert(ofnode_valid(phy_node));
+
+	ret = get_fw_loader_from_node(phy_node, &fw_loader_dev);
+	ut_asserteq(-ENODEV, ret);
+	ut_assertnull(fw_loader_dev);
+
+	phy_node = ofnode_find_subnode(mdio_node, "ethernet-phy@2");
+	ut_assert(ofnode_valid(phy_node));
+
+	fw_loader_dev = NULL;
+	ret = get_fw_loader_from_node(phy_node, &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fw_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fw_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *mdio_dev, *fw_loader_dev = NULL;
+	ofnode mdio_node, phy_node;
+	int ret;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, "mdio-test",
+					      &mdio_dev));
+
+	mdio_node = dev_ofnode(mdio_dev);
+	ut_assert(ofnode_valid(mdio_node));
+
+	phy_node = ofnode_find_subnode(mdio_node, "ethernet-phy@2");
+	ut_assert(ofnode_valid(phy_node));
+
+	ret = get_fw_loader_from_node(phy_node, &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(256, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fw_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fw_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *mdio_dev, *fw_loader_dev = NULL;
+	ofnode mdio_node, phy_node;
+	int firmware_size = 256;
+	char *buf;
+	int ret;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, "mdio-test",
+					      &mdio_dev));
+
+	mdio_node = dev_ofnode(mdio_dev);
+	ut_assert(ofnode_valid(mdio_node));
+
+	phy_node = ofnode_find_subnode(mdio_node, "ethernet-phy@2");
+	ut_assert(ofnode_valid(phy_node));
+
+	ret = get_fw_loader_from_node(phy_node, &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(firmware_size, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 1, 0);
+	ut_asserteq(firmware_size - 1, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 10);
+	ut_asserteq(firmware_size - 10, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fw_loader_get_fw_in_buf, UTF_SCAN_FDT);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a58..e54ac0145834 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -557,6 +557,23 @@ def test_ut_dm_init(ubman):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+def setup_fw_loader_image(ubman):
+    """Create a 2MB disk image with a dummy firmware on it"""
+    mmc_dev = 11
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0xc, img_size=2)
+
+    fw = os.path.join(mnt, 'firmware.bin')
+    data = b'\xaa' * 256
+    with open(fw, 'wb') as fh:
+        fh.write(data)
+
+    fsfile = 'vfat1M.img'
+    utils.run_and_log(ubman, f'fallocate -l 1M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    copy_partition(ubman, fsfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
 
 def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
@@ -624,6 +641,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
     setup_android_image(ubman)
+    setup_fw_loader_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
 
-- 
2.53.0

