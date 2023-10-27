Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED81C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 17:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821C9871C4;
	Fri, 27 Oct 2023 19:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="itbB1/+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE5386E09; Fri, 27 Oct 2023 19:46:11 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B1586F53
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 19:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=troykiskyboundary@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so2296516b3a.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698428767; x=1699033567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ5iAu2lQCw37qgH4CvVU7DGfTa2wUiFtpmAGJtNu6U=;
 b=itbB1/+M4RhWL9763evCxrOJOgjkh2wYs4ltHWuBSydPb4OizXs1ktkD6Dsiicoudd
 SyPrvUri77QuspFGYr5JCdQmDzlMgIV89uNKbo6TtHl0ypPsG7IoV6QZXcYQnjs+6wjI
 OVAE77PLFh63gt/BNghi0whkPbmFZsrfcWd414O52ux5Zoq9AvzTDP+JdFanjI2GRbD6
 7GRxeTsg+hTgXwShMBR8RHKHOGH6J8FiRfa/lxL04393GbkwbqZwNXyBKhCGAGzr7Ypk
 V6akblL7KiYbBDlAhSB2Ez0U7LlJivKih04TK2n3m6Lan7060i1GkAtj0m41l1QpYZOB
 l0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698428767; x=1699033567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQ5iAu2lQCw37qgH4CvVU7DGfTa2wUiFtpmAGJtNu6U=;
 b=wB2rkp0Z4Fwz2rCNHRf/qMD629hGR153jUuLizkplaQB7aVDQxMdNmADCijI6fENuD
 z4hb9mhgswYp+Hu7f32sp4OZF77ZTadYOfwnqRWnhRL7jbrTft9LTJUxb3RrAx1JtsQL
 8GkSbP3E4ZodpK/b6MgCCbqnBuXlQC35+yf7bmkn0Rt5HA4KoisiUDXFg+GkRIh95tyx
 fsIgnid4FGnjFvJeRdegkq82nTCW2CBQBvcDhw/YwIrFeoEO4saS42RVuvquH4HTtwxh
 8/wmqmsBHLw7zACydjo5NOc7Cefj5X/H/se0zA6YYFJndxtZRP+RpxXll3V8aMii1u8b
 nxRw==
X-Gm-Message-State: AOJu0Yx1fzkEqXmq0prjOBowDOHonbQrYCBedsFQxgxLmziVgi3ZaCqp
 RXMz4ZdcCWujA6YrM/CPrys=
X-Google-Smtp-Source: AGHT+IFfkmQFkQ0NkHzydXWaKvZtp3g/hP887obWUMANJUdtWrDwOYXh9O/+jQD9TAmlxbpYTXAJQg==
X-Received: by 2002:a05:6a20:4282:b0:17a:eff5:fbbd with SMTP id
 o2-20020a056a20428200b0017aeff5fbbdmr4611102pzj.43.1698428766843; 
 Fri, 27 Oct 2023 10:46:06 -0700 (PDT)
Received: from OS2.boundarydevices.com. (wsip-184-189-120-117.oc.oc.cox.net.
 [184.189.120.117]) by smtp.gmail.com with ESMTPSA id
 v8-20020a63b648000000b00565e96d9874sm1127461pgt.89.2023.10.27.10.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 10:46:06 -0700 (PDT)
From: Troy Kisky <troykiskyboundary@gmail.com>
To: sjg@chromium.org,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: gary.bisson@lairdconnect.com, Troy Kisky <troykiskyboundary@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH v5 1/1] CI: add test/usage_of_is_enabled_check.sh
Date: Fri, 27 Oct 2023 10:45:57 -0700
Message-Id: <20231027174557.2993782-2-troykiskyboundary@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027174557.2993782-1-troykiskyboundary@gmail.com>
References: <20231027174557.2993782-1-troykiskyboundary@gmail.com>
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

Add script usage_of_is_enabled_check to print any configs that
use CONFIG_IS_ENABLED instead of IS_ENABLED and vice versa.

Add usage_of_is_enabled_commit.sh to generate commits to fix the above
issues.

You can remove entries from test/usage_of_is_enabled_todo.txt
or the entire file and then run
test/usage_of_is_enabled_commit.sh
to convert to suggested usage of CONFIG_IS_ENABLED/IS_ENABLED

or run test/usage_of_is_enabled_check.sh to
see which configs are still todo.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Troy Kisky <troykiskyboundary@gmail.com>
---

(no changes since v1)

 .azure-pipelines.yml                |  11 ++
 .gitlab-ci.yml                      |   5 +
 test/usage_of_is_enabled_check.sh   |  19 +++
 test/usage_of_is_enabled_commit.sh  |  12 ++
 test/usage_of_is_enabled_correct.sh |  50 ++++++
 test/usage_of_is_enabled_exempt.txt |   9 ++
 test/usage_of_is_enabled_list.sh    |  86 +++++++++++
 test/usage_of_is_enabled_splcfg.txt |  21 +++
 test/usage_of_is_enabled_todo.txt   | 232 ++++++++++++++++++++++++++++
 9 files changed, 445 insertions(+)
 create mode 100755 test/usage_of_is_enabled_check.sh
 create mode 100755 test/usage_of_is_enabled_commit.sh
 create mode 100755 test/usage_of_is_enabled_correct.sh
 create mode 100644 test/usage_of_is_enabled_exempt.txt
 create mode 100755 test/usage_of_is_enabled_list.sh
 create mode 100644 test/usage_of_is_enabled_splcfg.txt
 create mode 100644 test/usage_of_is_enabled_todo.txt

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 421c5018b40..f8d46ead97f 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -67,6 +67,17 @@ stages:
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
                   :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
 
+  - job: check_usage_of_is_enabled
+    displayName: 'Check usage of CONFIG_IS_ENABLED vs IS_ENABLED'
+    pool:
+      vmImage: $(ubuntu_vm)
+    container:
+      image: $(ci_runner_image)
+      options: $(container_option)
+    steps:
+      # generate list of SPL configs
+      - script: test/usage_of_is_enabled_check.sh
+
   - job: docs
     displayName: 'Build documentation'
     pool:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 981b95c00d8..6f4a016bf60 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -163,6 +163,11 @@ check for new CONFIG symbols outside Kconfig:
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
         :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
 
+check usage of CONFIG_IS_ENABLED vs IS_ENABLED:
+  stage: testsuites
+  script:
+    - ./test/usage_of_is_enabled_check.sh
+
 # build documentation
 docs:
   extends: .testsuites
diff --git a/test/usage_of_is_enabled_check.sh b/test/usage_of_is_enabled_check.sh
new file mode 100755
index 00000000000..6bd5d9c1ac7
--- /dev/null
+++ b/test/usage_of_is_enabled_check.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Written by Troy Kisky <troykiskyboundary@gmail.com>
+
+scriptdir=`dirname "$0"`;
+${scriptdir}/usage_of_is_enabled_list.sh | grep -vw FOO;
+if [ $? -eq 0 ] ; then
+	echo "The above may have incorrect usage of IS_ENABLED/"\
+"CONFIG_IS_ENABLED"
+	echo "Run test/usage_of_is_enabled_commit.sh and "\
+"squash with appropriate commit"
+	ret=1;
+else
+	ret=0;
+fi
+
+rm ${scriptdir}/splcfg.tmp ${scriptdir}/exclude.tmp
+exit ${ret}
diff --git a/test/usage_of_is_enabled_commit.sh b/test/usage_of_is_enabled_commit.sh
new file mode 100755
index 00000000000..593dbd1428c
--- /dev/null
+++ b/test/usage_of_is_enabled_commit.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Written by Troy Kisky <troykiskyboundary@gmail.com>
+
+scriptdir=`dirname "$0"`;
+${scriptdir}/usage_of_is_enabled_list.sh | \
+xargs -I {} sh -c "${scriptdir}/usage_of_is_enabled_correct.sh {}; \
+git commit -a -m\"CONFIG_{}: correct usage of CONFIG_IS_ENABLED/IS_ENABLED\";"
+
+
+rm ${scriptdir}/splcfg.tmp ${scriptdir}/exclude.tmp
diff --git a/test/usage_of_is_enabled_correct.sh b/test/usage_of_is_enabled_correct.sh
new file mode 100755
index 00000000000..8724747beed
--- /dev/null
+++ b/test/usage_of_is_enabled_correct.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Written by Troy Kisky <troykiskyboundary@gmail.com>
+
+scriptdir=`dirname "$0"`;
+
+if [ -z "$1" ] ; then
+	echo missing config
+	exit 1;
+fi
+if [ ! -f "${scriptdir}/splcfg.tmp" ] ; then
+	echo missing splcfg.tmp
+	exit 1;
+fi
+
+
+grep -qw $1 ${scriptdir}/splcfg.tmp
+if [ $? -ne 0 ] ; then
+    # not splcfg
+    # change CONFIG_IS_ENABLED to IS_ENABLED
+    git grep -l \
+    -e "CONFIG_IS_ENABLED($1)" \
+     | \
+    xargs -IFile sh -c \
+    " \
+    sed -i -E \"\
+s/CONFIG_IS_ENABLED\($1\)/IS_ENABLED\(CONFIG_$1\)/g; \
+\" File";
+else
+    # splcfg
+    # change IS_ENABLED to CONFIG_IS_ENABLED
+    # change ifdef to CONFIG_IS_ENABLED
+    # change ifndef to !CONFIG_IS_ENABLED
+    # change defined to CONFIG_IS_ENABLED
+    git grep -l \
+    -e "IS_ENABLED(CONFIG_$1)" \
+    -e "^#ifdef[ \t]\+CONFIG_$1\>" \
+    -e "^#ifndef[ \t]\+CONFIG_$1\>" \
+    -e "defined(CONFIG_$1)" \
+     | \
+    xargs -IFile sh -c \
+    " \
+    sed -i -E \"\
+s/([^_])IS_ENABLED\(CONFIG_$1\)/\1CONFIG_IS_ENABLED($1)/g; \
+s/^#ifdef[ \t]+CONFIG_$1\>/#if CONFIG_IS_ENABLED\($1\)/; \
+s/^#ifndef[ \t]+CONFIG_$1\>/#if !CONFIG_IS_ENABLED\($1\)/; \
+s/defined\(CONFIG_$1\)/CONFIG_IS_ENABLED\($1\)/; \
+\" File";
+fi
diff --git a/test/usage_of_is_enabled_exempt.txt b/test/usage_of_is_enabled_exempt.txt
new file mode 100644
index 00000000000..d9fefd6cb6c
--- /dev/null
+++ b/test/usage_of_is_enabled_exempt.txt
@@ -0,0 +1,9 @@
+BLOBLIST
+BLOBLIST_FIXED
+DM_PMIC_PFUZE100
+FOO
+NAND_BOOT
+OF_CONTROL
+SYS_L2_PL310
+WATCHDOG
+X86_64
diff --git a/test/usage_of_is_enabled_list.sh b/test/usage_of_is_enabled_list.sh
new file mode 100755
index 00000000000..0f51d3602ca
--- /dev/null
+++ b/test/usage_of_is_enabled_list.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Written by Troy Kisky <troykiskyboundary@gmail.com>
+
+scriptdir=`dirname "$0"`;
+# generate list of excluded configs
+{
+# 1. ignore configs that have a number or string for a value
+git grep -h -A2 -E "^config " '*Kconfig*' | \
+sed -En '/depends on/!p' | \
+sed -En '/^config/{h;$!d} ;H;x; s/config[ \t]+(.*)\n[ \t]*/config \1 #/p' | \
+sed -E "/#bool/d; /#def_bool/d; /#tristate/d; \
+/#default y/d; /#select/d; /#prompt/d; /#imply/d" |
+sed -n -r "s/^config[[:space:]]+([0-9a-zA-Z_]+)/\n\{\1\}\n/p" | \
+sed -n -r 's/^\{([0-9a-zA-Z_]+)\}/\1/p' | sort -u;
+# 2. configs that are exempt for other reasons
+cat ${scriptdir}/usage_of_is_enabled_exempt.txt;
+# 3. configs that need converted later
+[ -f ${scriptdir}/usage_of_is_enabled_todo.txt ] && \
+cat ${scriptdir}/usage_of_is_enabled_todo.txt
+} | sort -u > ${scriptdir}/exclude.tmp
+
+# generate list of CONFIGs that should use CONFIG_IS_ENABLED
+{
+# 1. all obj-$(CONFIG_$(SPL_)xxx in Makefiles
+git grep -h 'obj-$(CONFIG_$(SPL_' '*Makefile' | sed -e "s/SPL_TPL_/SPL_/"| \
+sed -n -r 's/obj\-\$\(CONFIG_\$\(SPL_\)([0-9a-zA-Z_]+)\)/\n\{\1\}\n/gp'| \
+sed -n -r 's/\{([0-9a-zA-Z_]+)\}/\1/p';
+
+# 2. all SPL_xxx in Kconfig files
+git grep -h -E 'config [ST]PL_' '*Kconfig*' | \
+sed -n -r "s/config [ST]PL_([0-9a-zA-Z_]+)/\n\{\1\}\n/p" | \
+sed -n -r 's/\{([0-9a-zA-Z_]+)\}/\1/p';
+
+# 3. all CONFIG_CMD_xxx which already use CONFIG_IS_ENABLED
+#    The Makefile for most if these use ifndef CONFIG_SPL_BUILD
+#    instead of obj-$(CONFIG_$(SPL_)xxx
+git grep -h -E 'CONFIG_IS_ENABLED\(CMD_' | \
+sed -n -e "s/\(CONFIG_IS_ENABLED(CMD_[0-9a-zA-Z_]*)\)/\n\1\n/gp"| \
+sed -n -r "s/CONFIG_IS_ENABLED\((CMD_[0-9a-zA-Z_]+)\)/\1/p";
+
+# 4. A list of other configs that should use CONFIG_IS_ENABLED
+#    This list could be reduced if obj-$(CONFIG_$(SPL_)xxx was used instead of
+#    ifndef CONFIG_SPL_BUILD in Makefiles
+# usage_of_is_enabled_splcfg.txt mostly contains configs that should always
+# be undefined in SPL/TPL
+# Note: CONFIG_CLK was included to prevent a change in test_checkpatch.py
+# which is checking for an error.
+cat ${scriptdir}/usage_of_is_enabled_splcfg.txt;
+} | sort -u | \
+comm -23 - ${scriptdir}/exclude.tmp >${scriptdir}/splcfg.tmp
+
+{
+# generate list of CONFIGs that incorrectly use CONFIG_IS_ENABLED
+git grep -h CONFIG_IS_ENABLED | \
+sed -n -e "s/\(CONFIG_IS_ENABLED([0-9a-zA-Z_]*)\)/\n\1\n/gp"| \
+sed -n -r "s/CONFIG_IS_ENABLED\(([0-9a-zA-Z_]+)\)/\1/p" |sort -u| \
+comm -23 - ${scriptdir}/exclude.tmp | \
+comm -23 - ${scriptdir}/splcfg.tmp ;
+
+# generate list of CONFIGs that incorrectly use IS_ENABLED
+git grep -h -w IS_ENABLED | \
+sed -n -e "s/\(IS_ENABLED(CONFIG_[0-9a-zA-Z_]*)\)/\n\1\n/gp"| \
+sed -n -r "s/IS_ENABLED\(CONFIG_([0-9a-zA-Z_]+)\)/\1/p" |sort -u| \
+join - ${scriptdir}/splcfg.tmp;
+
+# generate list of CONFIGs that incorrectly use ifdef
+git grep -h -E "^#ifdef[ \t]+CONFIG_" | \
+sed -n -E "s/(ifdef[ \t]+CONFIG_[0-9a-zA-Z_]+)/\n\1\n/p"| \
+sed -n -E "s/ifdef[ \t]+CONFIG_([0-9a-zA-Z_]+)/\1/p" |sort -u| \
+join - ${scriptdir}/splcfg.tmp ;
+
+# generate list of CONFIGs that incorrectly use ifndef
+git grep -h -E "^#ifndef[ \t]+CONFIG_" | \
+sed -n -E "s/(ifndef[ \t]+CONFIG_[0-9a-zA-Z_]+)/\n\1\n/p"| \
+sed -n -E "s/ifndef[ \t]+CONFIG_([0-9a-zA-Z_]+)/\1/p" |sort -u| \
+join - ${scriptdir}/splcfg.tmp ;
+
+# generate list of CONFIGs that incorrectly use defined
+git grep -h -E "defined\(CONFIG_" | \
+sed -n -E "s/(defined\(CONFIG_[0-9a-zA-Z_]+\))/\n\1\n/gp"| \
+sed -n -E "s/defined\(CONFIG_([0-9a-zA-Z_]+)\)/\1/p" |sort -u| \
+join - ${scriptdir}/splcfg.tmp ;
+
+} | sort -u;
diff --git a/test/usage_of_is_enabled_splcfg.txt b/test/usage_of_is_enabled_splcfg.txt
new file mode 100644
index 00000000000..29d6257c5c7
--- /dev/null
+++ b/test/usage_of_is_enabled_splcfg.txt
@@ -0,0 +1,21 @@
+BZIP2
+CONFIG_CLK
+CONSOLE_MUX
+DM_EVENT
+DM_HWSPINLOCK
+DM_RNG
+DM_STDIO
+EFI_DEVICE_PATH_TO_TEXT
+EFI_LOADER
+ERRNO_STR
+EVENT_DYNAMIC
+GENERATE_SMBIOS_TABLE
+IOMMU
+MMC_HW_PARTITIONING
+NAND_CS_INIT
+OFNODE_MULTI_TREE
+PINCTRL_ARMADA_38X
+PRE_CONSOLE_BUFFER
+RESET_MEDIATEK
+RESET_ROCKCHIP
+UT_DM
diff --git a/test/usage_of_is_enabled_todo.txt b/test/usage_of_is_enabled_todo.txt
new file mode 100644
index 00000000000..f272b1d874b
--- /dev/null
+++ b/test/usage_of_is_enabled_todo.txt
@@ -0,0 +1,232 @@
+ACPI
+ACPIGEN
+ARCH_VERSAL
+ARCH_VERSAL_NET
+ARM_FFA_TRANSPORT
+ARM_PSCI_FW
+ARMV8_SEC_FIRMWARE_SUPPORT
+ATMEL_PIT_TIMER
+BIOSEMU
+BLK
+BLOCK_CACHE
+BOOSTD_FULL
+BOOTCOUNT_LIMIT
+BOOTDEV_ETH
+BOOTDEV_SPI_FLASH
+BOOTSTAGE
+BOOTSTD
+BOOTSTD_FULL
+BZIP2
+CLK
+CLK_CCF
+CLK_IMX6Q
+CLK_SCMI
+CMD_BDINFO_EXTRA
+CMD_DHCP
+CMDLINE
+CMD_PXE
+CONSOLE_MUX
+COREBOOT_SYSINFO
+CPU
+CRC32_VERIFY
+CROS_EC_KEYB
+DFU_SF_PART
+DFU_VIRT
+DM
+DMA
+DM_CLK
+DM_DMA
+DM_ETH
+DM_GPIO
+DM_I2C
+DM_KEYBOARD
+DM_MDIO
+DM_MMC
+DM_PMIC
+DM_PMIC_DA9063
+DM_REGULATOR
+DM_RNG
+DM_RTC
+DM_SERIAL
+DM_SPI
+DM_SPI_FLASH
+DM_USB
+DM_USB_GADGET
+DOS_PARTITION
+DWC_AHSATA_AHCI
+EFI_DT_FIXUP
+EFI_EBBR_2_1_CONFORMANCE
+EFI_LOADER
+EFI_PARTITION
+EFI_SCROLL_ON_CLEAR_SCREEN
+EFI_TCG2_PROTOCOL_MEASURE_DTB
+EFI_UNICODE_CAPITALIZATION
+ENV_APPEND
+ENV_IS_IN_EXT4
+ENV_IS_IN_FAT
+ENV_IS_IN_FLASH
+ENV_IS_IN_MMC
+ENV_IS_IN_NAND
+ENV_IS_IN_SPI_FLASH
+ENV_IS_NOWHERE
+ENV_WRITEABLE_LIST
+ERRNO_STR
+EVENT_DEBUG
+EXPO
+EXYNOS7870
+EXYNOS7880
+FASTBOOT_UUU_SUPPORT
+FAT_WRITE
+FDT_SIMPLEFB
+FEC_MXC
+FIT
+FIT_CIPHER
+FIT_IMAGE_POST_PROCESS
+FIT_SIGNATURE
+FIT_VERBOSE
+FPGA
+FRU_SC
+FSL_ISBC_KEY_EXT
+FSL_LS_PPA
+FS_LOADER
+FSP_VERSION2
+FWU_MULTI_BANK_UPDATE
+GENERATE_ACPI_TABLE
+GENERATE_SMBIOS_TABLE
+GMAC_ROCKCHIP
+GZIP
+I2C_EEPROM
+I8259_PIC
+ID_EEPROM
+IMX8M_VDD_SOC_850MV
+IMX_RDC
+LED
+LEGACY_IMAGE_FORMAT
+LIB_UUID
+LOG
+LZ4
+LZMA
+LZO
+MALTA
+MARY
+MCFTMR
+MEMSIZE_IN_BYTES
+MIPS_BOOT_CMDLINE_LEGACY
+MIPS_BOOT_ENV_LEGACY
+MIPS_BOOT_FDT
+MMC
+MMC_IO_VOLTAGE
+MMC_VERBOSE
+MULTI_DTB_FIT
+MXC_OCOTP
+NAND_DENALI
+NET
+NO_FB_CLEAR
+NVME
+NXP_FSPI
+OF_LIBFDT
+OFNODE_MULTI_TREE
+OF_REAL
+OF_TRANSLATE
+OPTEE
+OPTEE_IMAGE
+PANEL
+PARTITIONS
+PARTITION_TYPE_GUID
+PARTITION_UUIDS
+PHY
+PHY_CADENCE_SIERRA
+PHY_CADENCE_TORRENT
+PINCTRL
+PKCS7_MESSAGE_PARSER
+PLATDATA
+POWER_DOMAIN
+POWER_I2C
+QFW_PIO
+RAM
+RANDOM_UUID
+RESET_MEDIATEK
+RESTORE_EXCEPTION_VECTOR_BASE
+RISCV_SMODE
+ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
+RSA_PUBLIC_KEY_PARSER
+RSA_VERIFY_WITH_PKEY
+RTC_SANDBOX
+SANDBOX
+SANDBOX64
+SATA
+SEC_FIRMWARE_ARMV8_PSCI
+SEMIHOSTING
+SERIAL
+SERIAL_PUTS
+SERIAL_RX_BUFFER
+SHA1
+SHA384
+SHA512
+SHA512_HW_ACCEL
+SHA_HW_ACCEL
+SHOW_BOOT_PROGRESS
+SILENT_CONSOLE
+SILENT_CONSOLE_UPDATE_ON_RELOC
+SILENT_CONSOLE_UPDATE_ON_SET
+SIMPLE_BUS_CORRECT_RANGE
+SKIP_LOWLEVEL_INIT
+SMC911X_32_BIT
+SMP
+SPI
+SPI_BOOT
+SPI_DIRMAP
+SPI_FLASH_BAR
+SPI_FLASH_MACRONIX
+SPI_FLASH_MTD
+SPI_FLASH_SFDP_SUPPORT
+SPI_NOR_BOOT_SOFT_RESET_EXT_INVERT
+SPLASH_SCREEN
+SPLASH_SOURCE
+SPL_LOAD_FIT
+STM32_ETZPC
+SYS_CONSOLE_IS_IN_ENV
+SYS_DCACHE_OFF
+SYS_DEVICE_NULLDEV
+SYS_ICACHE_OFF
+SYSINFO
+SYSRESET
+SYS_THUMB_BUILD
+TARGET_DENEB
+TARGET_EVB_RK3399
+TARGET_GIEDI
+TARGET_KMCOGE5NE
+TARGET_KMETER1
+TARGET_ST_STM32MP15x
+TEST_KCONFIG
+TIMER
+_UNDEFINED
+UNIT_TEST
+USB_CDNS3_GADGET
+USB_CDNS3_HOST
+USB_ETHER
+USB_ETH_RNDIS
+USB_GADGET
+USB_GADGET_OS_DESCRIPTORS
+USB_HOST
+USB_KEYBOARD
+USB_STORAGE
+USE_ARCH_MEMSET
+UT_DM
+UT_UNICODE
+VID
+VIDEO
+VIDEO_BPP16
+VIDEO_BPP32
+VIDEO_BPP8
+VIDEO_LOGO
+VIRTIO
+WDT
+X509_CERTIFICATE_PARSER
+X86_16BIT_INIT
+X86_32BIT_INIT
+XILINX_MICROBLAZE0_DELAY_SLOT_EXCEP
+XILINX_MICROBLAZE0_USR_EXCEP
+ZLIB
+ZSTD
+ZYNQMP_PSU_INIT_ENABLED
-- 
2.34.1

