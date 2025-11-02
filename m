Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBDDCCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 20:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE18783642;
	Sun,  2 Nov 2025 21:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tXlK6tZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98703838AE; Sun,  2 Nov 2025 21:08:21 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AB0830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 21:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3d5bb138b2cso1430750fac.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 12:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762114097; x=1762718897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gE4RXdQl4915WGZtjs+Z3emjb7TQTlbzcq6QsyZRFgs=;
 b=tXlK6tZ6N4Ugil+Q/BdeTKURBcwmyRvDzjL/B+qb27jZ3PeCXmmuI5b2ksGFWJPWU2
 8ITgnUYUyfMRkJ8D7sxRciO6/yc9vUvBk3fHguK68EowUsvdHx6PDsjlNraR8IDYFA+D
 dSCzLHfJZbQxa2cD1xeeiGJw2cXIVUqm106Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762114097; x=1762718897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gE4RXdQl4915WGZtjs+Z3emjb7TQTlbzcq6QsyZRFgs=;
 b=J5TPc8GqFvHaoOYvDdryKqPeO7srOegiNCaYZ2nWBpEQgzUviHT4kJUGuGAjXFIKPN
 FqgufPc6M9EdCRS+ygB6NWmikfUP952sf73CQdqDEgZv410rCARq4NnRnREOycdj4non
 HsM8GXR0GOd+3ZccLY5J1OdBht4/ElHhQXhOgK86dTDMoboRzCAZBMoo+p6VjtUL/VQ7
 ZGoimyr+KuRWi1obiPfQekwIkCwEEzdDpzFirzvH+mdXKYKg+b83aNwXJjZVnGtP4li0
 85q7ehYuV9cy1zEQgndtCn1ej+8c6yU0+iwlJ8fEeKKP/e3BqPUN66mIUFnQ80AYpf2p
 SdsQ==
X-Gm-Message-State: AOJu0YwEZzzRSmAbYQuNH6mRmuph0RoD0lWbEBsnle/6jZU3AXESGXS5
 FjIoZF7EYSuurU/9M+8GwSoQUIhqHW/cAS7HvcCXCZnpw72APcm/EHOfZtJoFJb9aGcq2azqf4e
 yPU1WXurmNg==
X-Gm-Gg: ASbGncuYqm/t/piddR8eqJXBM8Vp7MnAdppr1D7lEVKH9iGq/ozdHtE+q/tTxTv3Vm6
 dm5yOuY/loYVO6Jeh2Xbn3soN8dKBLciT7wN4nYjYqa3Txp1CG0Dyy4kqqEfEJSlpKDmsguWcxH
 4LVPmLLcJdGxcHUOs5cs+My/BFqkVfBPFHmrKWKXz8eS97LWcOvt+JVliXzhfItPRcvlNI5lqAt
 oAZ9KmtxgwZfp04g7ThOmEzQMQNRWomVfQFngMRtbbZn28zly1AL48TvN4U1y6+AkjlcFRxDG/N
 rm1BLEWKILVtD/hUQv3DKaYOMdrsWiOCFu1BMRfvoBYG6VUm42gbyFnvqKe06EOfDgSU539eHVi
 r5/4chIEWALmlsso0zKpC/SBY+6i0bfC/B2i+hQMUMoAt0yZyhZ2a0jMNaHA0g4U107nD1xRpEe
 dIugcNrAAzi+UFyp7Ni6CqpL5/gQJgFtLVkJEL7QFibhI9uMVSqjf7
X-Google-Smtp-Source: AGHT+IEpqobb0dEEajP0P2V9iTg8ICvu03TjzHLGhyWT74IlKl930x42hJIPq/vFml5DK4AS9b4gRA==
X-Received: by 2002:a05:6871:2088:b0:374:bdaa:47f9 with SMTP id
 586e51a60fabf-3dacc9dd897mr5055750fac.34.1762114097459; 
 Sun, 02 Nov 2025 12:08:17 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3db43809f4fsm2852229fac.24.2025.11.02.12.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 12:08:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dm: Remove pre-schema tag support
Date: Sun,  2 Nov 2025 14:08:12 -0600
Message-ID: <20251102200814.3059463-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Support for using "u-boot,dm-..." rather than "bootph-..." has been
deprecated since February 2023. Any platforms using this have had a
console message saying to migrate by 2023.07. Go and remove all support
here now, for the v2026.01 release.

The results of this change that aren't clear from the above are that we
still have a checkpatch.pl error message, and document in
doc/develop/spl.rst that they have been migrated since 2023. We also
change the key2dtsi.py tool to use the correct bootph phase rather than
the legacy phase.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 .azure-pipelines.yml                          |  12 --
 .gitlab-ci.yml                                |   9 --
 common/board_r.c                              |   7 --
 configs/ibex-ast2700_defconfig                |   1 -
 configs/jaguar-rk3588_defconfig               |   1 -
 configs/sama5d29_curiosity_mmc1_defconfig     |   1 -
 configs/sama5d29_curiosity_mmc_defconfig      |   1 -
 .../sama5d29_curiosity_qspiflash_defconfig    |   1 -
 configs/sama7g54_curiosity_mmc_defconfig      |   1 -
 .../sama7g54_curiosity_nandflash_defconfig    |   1 -
 .../sama7g54_curiosity_qspiflash_defconfig    |   1 -
 configs/tiger-rk3588_defconfig                |   1 -
 drivers/core/ofnode.c                         |  12 --
 dts/Kconfig                                   |  10 --
 include/asm-generic/global_data.h             |   6 +-
 scripts/Makefile.lib                          |   9 --
 test/py/tests/test_of_migrate.py              | 105 ------------------
 tools/key2dtsi.py                             |   2 +-
 tools/patman/test_checkpatch.py               |   6 -
 19 files changed, 4 insertions(+), 183 deletions(-)
 delete mode 100644 test/py/tests/test_of_migrate.py

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fc55c8b21006..0843204e5f82 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -188,18 +188,6 @@ stages:
           export PYTHONPATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt
           make pylint_err
 
-  - job: check_for_pre_schema_tags
-    displayName: 'Check for pre-schema driver model tags'
-    pool:
-      vmImage: $(ubuntu_vm)
-    container:
-      image: $(ci_runner_image)
-      options: $(container_option)
-    steps:
-      # If grep succeeds and finds a match the test fails as we should
-      # have no matches.
-      - script: git grep u-boot,dm- -- '*.dts*' && exit 1 || exit 0
-
   - job: check_packing_of_python_tools
     displayName: 'Check we can package the Python tools'
     pool:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 73ff975e5746..000ec1a14821 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -245,15 +245,6 @@ Run pylint:
     - export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt"
     - make pylint_err
 
-# Check for pre-schema driver model tags
-Check for pre-schema tags:
-  extends: .testsuites
-  script:
-    - git config --global --add safe.directory "${CI_PROJECT_DIR}";
-    # If grep succeeds and finds a match the test fails as we should
-    # have no matches.
-    - git grep u-boot,dm- -- '*.dts*' && exit 1 || exit 0
-
 # Check we can package the Python tools
 Check packing of Python tools:
   extends: .testsuites
diff --git a/common/board_r.c b/common/board_r.c
index 143d51d06330..76f9fc090fbe 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -572,13 +572,6 @@ static int dm_announce(void)
 			printf("Warning: Unexpected devicetree source (not from a prior stage)");
 			printf("Warning: U-Boot may not function properly\n");
 		}
-		if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE) &&
-		    (gd->flags & GD_FLG_OF_TAG_MIGRATE))
-			/*
-			 * U-Boot will silently fail to work after 2023.07 if
-			 * there are old tags present
-			 */
-			printf("Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!\n");
 	}
 
 	return 0;
diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
index 088eec1ec702..a4090f055133 100644
--- a/configs/ibex-ast2700_defconfig
+++ b/configs/ibex-ast2700_defconfig
@@ -65,7 +65,6 @@ CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_DEVICE_TREE_INCLUDES="ast2700-u-boot.dtsi"
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=2
 # CONFIG_DM_DEVICE_REMOVE is not set
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 3ed07d18e103..def0acf6cfdc 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -57,7 +57,6 @@ CONFIG_CMD_SQUASHFS=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/configs/sama5d29_curiosity_mmc1_defconfig b/configs/sama5d29_curiosity_mmc1_defconfig
index 4e56c670357e..ad835af5dbd9 100644
--- a/configs/sama5d29_curiosity_mmc1_defconfig
+++ b/configs/sama5d29_curiosity_mmc1_defconfig
@@ -65,7 +65,6 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_MTDIDS_DEFAULT="nor0=nor0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nor0:256k(bootstrap)ro,1M(u-boot)ro,256k(env)ro,512k(dtb)ro,6M(kernel)ro"
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/sama5d29_curiosity_mmc_defconfig b/configs/sama5d29_curiosity_mmc_defconfig
index 28d5626a2a59..e01332768b1f 100644
--- a/configs/sama5d29_curiosity_mmc_defconfig
+++ b/configs/sama5d29_curiosity_mmc_defconfig
@@ -65,7 +65,6 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_MTDIDS_DEFAULT="nor0=nor0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nor0:256k(bootstrap)ro,1M(u-boot)ro,256k(env)ro,512k(dtb)ro,6M(kernel)ro"
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/sama5d29_curiosity_qspiflash_defconfig b/configs/sama5d29_curiosity_qspiflash_defconfig
index e19e39cd6dc1..17504f5de14b 100644
--- a/configs/sama5d29_curiosity_qspiflash_defconfig
+++ b/configs/sama5d29_curiosity_qspiflash_defconfig
@@ -65,7 +65,6 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_MTDIDS_DEFAULT="nor0=nor0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nor0:256k(bootstrap)ro,1M(u-boot)ro,256k(env)ro,512k(dtb)ro,6M(kernel)ro"
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/sama7g54_curiosity_mmc_defconfig b/configs/sama7g54_curiosity_mmc_defconfig
index 557173d1af01..f6f552c00879 100644
--- a/configs/sama7g54_curiosity_mmc_defconfig
+++ b/configs/sama7g54_curiosity_mmc_defconfig
@@ -68,7 +68,6 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand0,nor0=nor0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro,256k(env-nand)ro,512k(dtb-nand)ro,6M(kernel-nand)ro,-(rootfs-nand)ro;nor0:256k(bootstrap-nor)ro,1M(u-boot-nor)ro,256k(env-nor)ro,512k(dtb-nor)ro,6M(kernel-nor)ro"
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/sama7g54_curiosity_nandflash_defconfig b/configs/sama7g54_curiosity_nandflash_defconfig
index 4a3b5e5f5b36..830454705c2c 100644
--- a/configs/sama7g54_curiosity_nandflash_defconfig
+++ b/configs/sama7g54_curiosity_nandflash_defconfig
@@ -67,7 +67,6 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand0,nor0=nor0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro,256k(env-nand)ro,512k(dtb-nand)ro,6M(kernel-nand)ro,-(rootfs-nand)ro;nor0:256k(bootstrap-nor)ro,1M(u-boot-nor)ro,256k(env-nor)ro,512k(dtb-nor)ro,6M(kernel-nor)ro"
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/sama7g54_curiosity_qspiflash_defconfig b/configs/sama7g54_curiosity_qspiflash_defconfig
index fee0a8bac040..d91eb28db0ff 100644
--- a/configs/sama7g54_curiosity_qspiflash_defconfig
+++ b/configs/sama7g54_curiosity_qspiflash_defconfig
@@ -68,7 +68,6 @@ CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand0,nor0=nor0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro,256k(env-nand)ro,512k(dtb-nand)ro,6M(kernel-nand)ro,-(rootfs-nand)ro;nor0:256k(bootstrap-nor)ro,1M(u-boot-nor)ro,256k(env-nor)ro,512k(dtb-nor)ro,6M(kernel-nor)ro"
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index 8ba2a996ee20..50a3b553a111 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -57,7 +57,6 @@ CONFIG_CMD_SQUASHFS=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_OF_TAG_MIGRATE is not set
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index e040e3f2806f..071d998a0a51 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1629,18 +1629,6 @@ bool ofnode_pre_reloc(ofnode node)
 	    ofnode_read_bool(node, "bootph-pre-sram"))
 		return gd->flags & GD_FLG_RELOC;
 
-	if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
-		/* detect and handle old tags */
-		if (ofnode_read_bool(node, "u-boot,dm-pre-reloc") ||
-		    ofnode_read_bool(node, "u-boot,dm-pre-proper") ||
-		    ofnode_read_bool(node, "u-boot,dm-spl") ||
-		    ofnode_read_bool(node, "u-boot,dm-tpl") ||
-		    ofnode_read_bool(node, "u-boot,dm-vpl")) {
-			gd->flags |= GD_FLG_OF_TAG_MIGRATE;
-			return true;
-		}
-	}
-
 	return false;
 #endif
 }
diff --git a/dts/Kconfig b/dts/Kconfig
index 4e2622d48d04..870f75ad3ec3 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -408,16 +408,6 @@ config SPL_MULTI_DTB_FIT_USER_DEF_ADDR
 	   at compilation time. This is the address of this area. It must be
 	   aligned on 2-byte boundary.
 
-config OF_TAG_MIGRATE
-	bool "Ease migration from old device trees with u-boot,dm- tags"
-	default y
-	help
-	  U-Boot moved over to use new tags to mark device tree nodes which need
-	  to be processed in SPL, before relocation, etc. Enable this option to
-	  detect old tags and handle them.
-
-	  Note: This option will be removed after the 2023.07 release.
-
 config OF_SPL_REMOVE_PROPS
 	string "List of device tree properties to drop for SPL"
 	depends on SPL_OF_CONTROL
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 506ee51cdb08..745d2c3a9663 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -671,10 +671,10 @@ enum gd_flags {
 	 * @GD_FLG_FDT_CHANGED: Device tree change has been detected by tests
 	 */
 	GD_FLG_FDT_CHANGED = 0x100000,
-	/**
-	 * @GD_FLG_OF_TAG_MIGRATE: Device tree has old u-boot,dm- tags
+	/*
+	 * @GD_FLG_OF_TAG_MIGRATE: Previously had the value of 0x200000 but was
+	 * freed when migration support was removed.
 	 */
-	GD_FLG_OF_TAG_MIGRATE = 0x200000,
 	/**
 	 * @GD_FLG_DM_DEAD: Driver model is not accessible. This can be set when
 	 * the memory used to holds its tables has been mapped out.
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a1..791eb1cb3276 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -671,15 +671,6 @@ cmd_mkimage = $(objtree)/tools/mkimage $(MKIMAGEFLAGS_$(@F)) -d $< $@ \
 # pass removes various unused properties from the remaining nodes.
 # The output is typically a much smaller device tree file.
 
-ifdef CONFIG_OF_TAG_MIGRATE
-# Support the old tags for a migration period
-migrate_tpl := -b u-boot,dm-pre-reloc -b u-boot,dm-tpl
-migrate_vpl := -b u-boot,dm-pre-reloc -b u-boot,dm-vpl
-migrate_spl := -b u-boot,dm-pre-reloc -b u-boot,dm-spl
-migrate_all := -P u-boot,dm-pre-reloc \
-	-P u-boot,dm-spl -P u-boot,dm-tpl -P u-boot,dm-vpl
-endif
-
 ifeq ($(CONFIG_VPL_BUILD),y)
 fdtgrep_props := -b bootph-all -b bootph-verify $(migrate_vpl)
 else
diff --git a/test/py/tests/test_of_migrate.py b/test/py/tests/test_of_migrate.py
deleted file mode 100644
index ab89332331e2..000000000000
--- a/test/py/tests/test_of_migrate.py
+++ /dev/null
@@ -1,105 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Copyright 2023 Google LLC
-# Written by Simon Glass <sjg@chromium.org>
-
-"""Test handling of unmigrated u-boot,dm- tags"""
-
-import os
-import pytest
-
-import utils
-
-# This is needed for Azure, since the default '..' directory is not writeable
-TMPDIR1 = '/tmp/test_no_migrate'
-TMPDIR2 = '/tmp/test_no_migrate_spl'
-TMPDIR3 = '/tmp/test_migrate'
-
-def build_for_migrate(ubman, replace_pair, board, tmpdir, disable_migrate=True):
-    """Build an updated U-Boot with a slightly modified device tree
-
-    Args:
-        ubman (ConsoleBase): U-Boot console
-        replace_pair (tuple):
-            String to find
-            String to replace it with
-        board (str): Board to build
-        tmpdir (str): Temporary directory to use
-        disable_migrate (bool): True to disable CONFIG_OF_TAG_MIGRATE in build
-    """
-    srcdir = ubman.config.source_dir
-    build_dir = ubman.config.build_dir
-
-    # Get the source for the existing dts
-    dt_dir = os.path.join(build_dir, 'arch', 'sandbox', 'dts')
-    orig_fname = os.path.join(dt_dir, 'sandbox.dtb')
-    out_dts = os.path.join(dt_dir, 'sandbox_out.dts')
-    utils.run_and_log(ubman, ['dtc', orig_fname, '-I', 'dtb', '-O', 'dts',
-                             '-o', out_dts])
-
-    # Update it to use an old tag
-    with open(out_dts) as inf:
-        data = inf.read()
-    data = data.replace(*replace_pair)
-
-    dts_fname = os.path.join(dt_dir, 'sandbox_oldtag.dts')
-    with open(dts_fname, 'w') as outf:
-        print(data, file=outf)
-    dtb_fname = os.path.join(dt_dir, 'sandbox_oldtag.dtb')
-    utils.run_and_log(ubman, ['dtc', dts_fname, '-o', dtb_fname])
-
-    migrate = ['-a', '~CONFIG_OF_TAG_MIGRATE'] if disable_migrate else []
-
-    # Build sandbox with this new dtb, turning off OF_TAG_MIGRATE
-    env = dict(os.environ)
-    env['EXT_DTB'] = dtb_fname
-    env['DEVICE_TREE'] = 'sandbox_new'
-    env['NO_LTO'] = '1'  # Speed up build
-    out = utils.run_and_log(
-        ubman, ['./tools/buildman/buildman', '-m', '--board', board,
-               *migrate, '-w', '-o', tmpdir], ignore_errors=True, env=env)
-    return out
-
-@pytest.mark.slow
-@pytest.mark.boardspec('sandbox')
-def test_of_no_migrate(ubman):
-    """Test sandbox with old boot phase tags like u-boot,dm-pre-proper"""
-
-    build_for_migrate(ubman, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
-                      'sandbox', TMPDIR1)
-
-    # It should fail to run, since the lcd device will not be bound before
-    # relocation. so won't get its frame-buffer memory
-    out = utils.run_and_log(
-        ubman, [os.path.join(TMPDIR1, 'u-boot'), '-D', '-c', 'help'],
-        ignore_errors=True)
-    assert "Video device 'lcd' cannot allocate frame buffer memory" in out
-
-
-@pytest.mark.slow
-@pytest.mark.boardspec('sandbox_spl')
-@pytest.mark.boardspec('spl_of_platdata_inst')
-@pytest.mark.boardspec('!sandbox_tpl')
-def test_of_no_migrate_spl(ubman):
-    """Test sandbox with old boot phase tags like u-boot,dm-spl"""
-
-    out = build_for_migrate(ubman, ['bootph-pre-ram', 'u-boot,dm-spl'],
-                            'sandbox_spl', TMPDIR2)
-
-    # It should fail to build, since the SPL DT will not include 'spl-test'
-    # node, among others
-    assert "undefined type ‘struct dtd_sandbox_spl_test’" in out
-
-
-@pytest.mark.slow
-@pytest.mark.boardspec('sandbox')
-def test_of_migrate(ubman):
-    """Test sandbox shows a message when tags were migrated"""
-
-    build_for_migrate(ubman, ['bootph-some-ram', 'u-boot,dm-pre-proper'],
-                      'sandbox', TMPDIR3, disable_migrate=False)
-
-    # It should show a migration message
-    out = utils.run_and_log(
-        ubman, [os.path.join(TMPDIR3, 'u-boot'), '-D', '-c', 'help'],
-        ignore_errors=True)
-    assert "Warning: Device tree includes old 'u-boot,dm-' tags" in out
diff --git a/tools/key2dtsi.py b/tools/key2dtsi.py
index 1dbb2cc94bf1..123bb3f218bf 100755
--- a/tools/key2dtsi.py
+++ b/tools/key2dtsi.py
@@ -58,7 +58,7 @@ if args.required_conf:
 elif args.required_image:
     out.write('\t\t\trequired = "image";\n')
 if args.spl:
-    out.write('\t\t\tu-boot,dm-spl;\n')
+    out.write('\t\t\tbootph-pre-ram;\n')
 out.write('\t\t};\n')
 out.write('\t};\n')
 out.write('};\n')
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index 4e8d163184e1..b4722330f867 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -522,11 +522,5 @@ index 0000000..2234c87
         self.check_strl("cat");
         self.check_strl("cpy");
 
-    def test_schema(self):
-        """Check for uses of strn(cat|cpy)"""
-        pm = PatchMaker()
-        pm.add_line('arch/sandbox/dts/sandbox.dtsi', '\tu-boot,dm-pre-proper;')
-        self.check_single_message(pm, 'PRE_SCHEMA', 'error')
-
 if __name__ == "__main__":
     unittest.main()
-- 
2.43.0

