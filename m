Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92CEC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582A0889D0;
	Wed, 14 Aug 2024 13:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 229E7889B8; Wed, 14 Aug 2024 13:00:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 56A36889E3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2414DA7;
 Wed, 14 Aug 2024 04:01:07 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C9713F58B;
 Wed, 14 Aug 2024 04:00:37 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 02/32] lmb: ut: disable unit tests for lmb changes
Date: Wed, 14 Aug 2024 16:29:39 +0530
Message-Id: <20240814110009.45310-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

The LMB module code is being overhauled to make it's memory map global
and persistent. This involves extensive changes to the LMB
code. Disable the unit test code temporarily till the changes are in
place. These tests will be enabled in a subsequent commit once all the
LMB module and the corresponding test code changes have been made.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 configs/sandbox64_defconfig        | 4 +---
 configs/sandbox_defconfig          | 7 ++++---
 configs/sandbox_flattree_defconfig | 4 +---
 configs/sandbox_noinst_defconfig   | 8 ++++----
 configs/sandbox_spl_defconfig      | 8 ++++----
 configs/sandbox_vpl_defconfig      | 7 ++-----
 configs/snow_defconfig             | 2 +-
 7 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index dd0582d2a0..dbcf65d29f 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox64"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_SYS_LOAD_ADDR=0x0
@@ -270,6 +271,3 @@ CONFIG_GETOPT=y
 CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
-CONFIG_UNIT_TEST=y
-CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 484f9e1bf8..ec7e7d0ff6 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_PRE_CON_BUF_ADDR=0xf0000
 CONFIG_SYS_LOAD_ADDR=0x0
@@ -346,6 +347,9 @@ CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
+CONFIG_CRYPT_PW=y
+CONFIG_CRYPT_PW_SHA256=y
+CONFIG_CRYPT_PW_SHA512=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
@@ -357,6 +361,3 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
-CONFIG_UNIT_TEST=y
-CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 049a606613..b87bd145bb 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -2,6 +2,7 @@ CONFIG_TEXT_BASE=0
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
@@ -228,6 +229,3 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
-CONFIG_UNIT_TEST=y
-CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index f37230151a..3e5ef854f6 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -6,6 +6,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -131,6 +132,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
@@ -277,11 +279,9 @@ CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
+CONFIG_X509_CERTIFICATE_PARSER=y
+CONFIG_PKCS7_MESSAGE_PARSER=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
 CONFIG_ERRNO_STR=y
-CONFIG_UNIT_TEST=y
-CONFIG_SPL_UNIT_TEST=y
-CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index f7b92dc844..2823bde492 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -5,6 +5,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -107,6 +108,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
@@ -243,13 +245,11 @@ CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
+CONFIG_X509_CERTIFICATE_PARSER=y
+CONFIG_PKCS7_MESSAGE_PARSER=y
 CONFIG_TPM=y
 CONFIG_SPL_CRC8=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_HEXDUMP=y
-CONFIG_UNIT_TEST=y
-CONFIG_SPL_UNIT_TEST=y
-CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 96e9211bd1..f69eb76309 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -5,6 +5,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
 CONFIG_SPL_TEXT_BASE=0x100000
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -122,6 +123,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SPL_DM=y
 CONFIG_TPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
@@ -256,8 +258,3 @@ CONFIG_TPM=y
 CONFIG_ZSTD=y
 # CONFIG_VPL_LZMA is not set
 CONFIG_ERRNO_STR=y
-CONFIG_UNIT_TEST=y
-CONFIG_SPL_UNIT_TEST=y
-CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
-# CONFIG_SPL_UT_LOAD_OS is not set
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 2c0757194b..637c51d2c2 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -19,6 +19,7 @@ CONFIG_ENV_OFFSET=0x3FC000
 CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="exynos5250-snow"
 CONFIG_SPL_TEXT_BASE=0x02023400
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x12c30000
 CONFIG_DEBUG_UART_CLOCK=100000000
@@ -107,4 +108,3 @@ CONFIG_VIDEO_BRIDGE_PARADE_PS862X=y
 CONFIG_VIDEO_BRIDGE_NXP_PTN3460=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
-CONFIG_UNIT_TEST=y
-- 
2.34.1

