Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839BCC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BB387D6B;
	Tue, 26 Mar 2024 21:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 235E387F78; Tue, 26 Mar 2024 21:08:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 40BB787C62
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59D3A2F4;
 Tue, 26 Mar 2024 13:08:57 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4763F64C;
 Tue, 26 Mar 2024 13:08:21 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/4] sandbox: capsule: remove capsule related configs
Date: Wed, 27 Mar 2024 01:37:55 +0530
Message-Id: <20240326200758.833689-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326200758.833689-1-sughosh.ganu@linaro.org>
References: <20240326200758.833689-1-sughosh.ganu@linaro.org>
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

The capsule update testing is carried out only on the sandbox and
sandbox_flattree variants. Remove the capsule update related configs
from the other sandbox variants. This ensures that the capsule files
are generated only on variants which are used for the feature's
testing.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 configs/sandbox64_defconfig      | 5 -----
 configs/sandbox_noinst_defconfig | 2 --
 configs/sandbox_spl_defconfig    | 2 --
 configs/sandbox_vpl_defconfig    | 2 --
 4 files changed, 11 deletions(-)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 3be9a00a85..a67f9f0265 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -134,7 +134,6 @@ CONFIG_CPU=y
 CONFIG_DM_DEMO=y
 CONFIG_DM_DEMO_SIMPLE=y
 CONFIG_DM_DEMO_SHAPE=y
-CONFIG_DFU_SF=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_ARM_FFA_TRANSPORT=y
@@ -267,12 +266,8 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
-CONFIG_FWU_MULTI_BANK_UPDATE=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 137b3c6b82..f37230151a 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -281,8 +281,6 @@ CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
 CONFIG_ERRNO_STR=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_UNIT_TEST=y
 CONFIG_SPL_UNIT_TEST=y
 CONFIG_UT_TIME=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index d0cd91ef4f..f7b92dc844 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -249,8 +249,6 @@ CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_HEXDUMP=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_UNIT_TEST=y
 CONFIG_SPL_UNIT_TEST=y
 CONFIG_UT_TIME=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index b138b352de..72483d8ba1 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -252,8 +252,6 @@ CONFIG_TPM=y
 CONFIG_ZSTD=y
 # CONFIG_VPL_LZMA is not set
 CONFIG_ERRNO_STR=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_UNIT_TEST=y
 CONFIG_SPL_UNIT_TEST=y
 CONFIG_UT_TIME=y
-- 
2.34.1

