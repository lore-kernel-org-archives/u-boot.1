Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43677C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603B4879FC;
	Mon, 22 Jan 2024 12:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22BA687BC9; Mon, 22 Jan 2024 12:56:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1D2DB87C9D
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8461FB;
 Mon, 22 Jan 2024 03:56:51 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6873F73F;
 Mon, 22 Jan 2024 03:56:02 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 17/18] configs: fwu: Re-enable FWU configs
Date: Mon, 22 Jan 2024 17:24:38 +0530
Message-Id: <20240122115439.653871-18-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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

Now that the migration to the FWU metadata version 2 is complete, the
feature can be re-enabled on platforms which had it enabled.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 configs/corstone1000_defconfig           | 2 ++
 configs/sandbox64_defconfig              | 1 +
 configs/synquacer_developerbox_defconfig | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 24b7984959..e45415b90c 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -25,6 +25,7 @@ CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="corstone1000# "
 CONFIG_SYS_MAXARGS=64
 # CONFIG_CMD_CONSOLE is not set
+CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_GPT=y
@@ -66,3 +67,4 @@ CONFIG_FFA_SHARED_MM_BUF_OFFSET=0
 CONFIG_FFA_SHARED_MM_BUF_ADDR=0x02000000
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_IGNORE_OSINDICATIONS=y
+CONFIG_FWU_MULTI_BANK_UPDATE=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 7b5888af38..996bb7aa4f 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -274,6 +274,7 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
+CONFIG_FWU_MULTI_BANK_UPDATE=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
diff --git a/configs/synquacer_developerbox_defconfig b/configs/synquacer_developerbox_defconfig
index 616d410074..1bb55be0a7 100644
--- a/configs/synquacer_developerbox_defconfig
+++ b/configs/synquacer_developerbox_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTSTAGE_STASH_SIZE=4096
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=128
+CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_NVEDIT_EFI=y
@@ -51,6 +52,7 @@ CONFIG_DFU_TFTP=y
 CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+CONFIG_FWU_MDATA_MTD=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SYNQUACER=y
 CONFIG_MMC_SDHCI=y
@@ -93,3 +95,4 @@ CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_IGNORE_OSINDICATIONS=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_FWU_MULTI_BANK_UPDATE=y
-- 
2.34.1

