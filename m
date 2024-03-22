Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA042C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6820881C5;
	Fri, 22 Mar 2024 11:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09AA881C2; Fri, 22 Mar 2024 11:58:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9F75E87F6A
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EE361007;
 Fri, 22 Mar 2024 03:58:45 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226A33F64C;
 Fri, 22 Mar 2024 03:58:07 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 01/20] configs: fwu: remove FWU configs for metadata V2
 support
Date: Fri, 22 Mar 2024 16:27:14 +0530
Message-Id: <20240322105733.203888-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

Support is to be added in the following commits for the FWU metadata
version 2. Disable the FWU feature on platforms that enable it for the
V2 addition work.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 configs/corstone1000_defconfig           | 2 --
 configs/sandbox64_defconfig              | 1 -
 configs/synquacer_developerbox_defconfig | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 8b2f77f648..29d7550afb 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -24,7 +24,6 @@ CONFIG_LOGLEVEL=7
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="corstone1000# "
 # CONFIG_CMD_CONSOLE is not set
-CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_GPT=y
@@ -67,4 +66,3 @@ CONFIG_FFA_SHARED_MM_BUF_OFFSET=0
 CONFIG_FFA_SHARED_MM_BUF_ADDR=0x02000000
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_IGNORE_OSINDICATIONS=y
-CONFIG_FWU_MULTI_BANK_UPDATE=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 3be9a00a85..7e8200e70c 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -272,7 +272,6 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
-CONFIG_FWU_MULTI_BANK_UPDATE=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
diff --git a/configs/synquacer_developerbox_defconfig b/configs/synquacer_developerbox_defconfig
index 2a0407de40..616d410074 100644
--- a/configs/synquacer_developerbox_defconfig
+++ b/configs/synquacer_developerbox_defconfig
@@ -11,14 +11,12 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="synquacer-sc2a11-developerbox"
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_TARGET_DEVELOPERBOX=y
-CONFIG_FWU_NUM_IMAGES_PER_BANK=1
 CONFIG_AHCI=y
 CONFIG_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTSTAGE_STASH_SIZE=4096
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=128
-CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_NVEDIT_EFI=y
@@ -53,7 +51,6 @@ CONFIG_DFU_TFTP=y
 CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
-CONFIG_FWU_MDATA_MTD=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SYNQUACER=y
 CONFIG_MMC_SDHCI=y
@@ -96,4 +93,3 @@ CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_IGNORE_OSINDICATIONS=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_FWU_MULTI_BANK_UPDATE=y
-- 
2.34.1

