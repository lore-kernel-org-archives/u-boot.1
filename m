Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAADC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB15C88A9F;
	Wed, 14 Aug 2024 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9DD88815; Wed, 14 Aug 2024 13:03:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 40CFC88AD8
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D47CDA7;
 Wed, 14 Aug 2024 04:03:34 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29E0B3F58B;
 Wed, 14 Aug 2024 04:03:03 -0700 (PDT)
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
Subject: [PATCH v2 31/32] lmb: ut: re-enable unit tests
Date: Wed, 14 Aug 2024 16:30:08 +0530
Message-Id: <20240814110009.45310-32-sughosh.ganu@linaro.org>
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

All the changes needed for making the LMB memory map persistent and
global have been made, including making corresponding changes in the
test code. Re-enable the unit tests on the platforms.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 configs/sandbox64_defconfig        | 4 +++-
 configs/sandbox_defconfig          | 7 +++----
 configs/sandbox_flattree_defconfig | 4 +++-
 configs/sandbox_noinst_defconfig   | 8 ++++----
 configs/sandbox_spl_defconfig      | 8 ++++----
 configs/sandbox_vpl_defconfig      | 6 ++++--
 configs/snow_defconfig             | 2 +-
 7 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index dbcf65d29f..dd0582d2a0 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox64"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_SYS_LOAD_ADDR=0x0
@@ -271,3 +270,6 @@ CONFIG_GETOPT=y
 CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
+CONFIG_UNIT_TEST=y
+CONFIG_UT_TIME=y
+CONFIG_UT_DM=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ec7e7d0ff6..484f9e1bf8 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -3,7 +3,6 @@ CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_PRE_CON_BUF_ADDR=0xf0000
 CONFIG_SYS_LOAD_ADDR=0x0
@@ -347,9 +346,6 @@ CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
-CONFIG_CRYPT_PW=y
-CONFIG_CRYPT_PW_SHA256=y
-CONFIG_CRYPT_PW_SHA512=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
@@ -361,3 +357,6 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
+CONFIG_UNIT_TEST=y
+CONFIG_UT_TIME=y
+CONFIG_UT_DM=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index b87bd145bb..049a606613 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -2,7 +2,6 @@ CONFIG_TEXT_BASE=0
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
@@ -229,3 +228,6 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
+CONFIG_UNIT_TEST=y
+CONFIG_UT_TIME=y
+CONFIG_UT_DM=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 6150f55072..e930162937 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -6,7 +6,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -132,7 +131,6 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_SPL_DM=y
-CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
@@ -279,10 +277,12 @@ CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
-CONFIG_X509_CERTIFICATE_PARSER=y
-CONFIG_PKCS7_MESSAGE_PARSER=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_LMB=y
+CONFIG_UNIT_TEST=y
+CONFIG_SPL_UNIT_TEST=y
+CONFIG_UT_TIME=y
+CONFIG_UT_DM=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 3dd4c7ab43..31ccdbd502 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -5,7 +5,6 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -108,7 +107,6 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_SPL_DM=y
-CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
@@ -245,8 +243,6 @@ CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
-CONFIG_X509_CERTIFICATE_PARSER=y
-CONFIG_PKCS7_MESSAGE_PARSER=y
 CONFIG_TPM=y
 CONFIG_SPL_CRC8=y
 CONFIG_ZSTD=y
@@ -254,3 +250,7 @@ CONFIG_SPL_LZMA=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_HEXDUMP=y
 CONFIG_SPL_LMB=y
+CONFIG_UNIT_TEST=y
+CONFIG_SPL_UNIT_TEST=y
+CONFIG_UT_TIME=y
+CONFIG_UT_DM=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index f69eb76309..7cce422cb2 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -5,7 +5,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
 CONFIG_SPL_TEXT_BASE=0x100000
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -123,7 +122,6 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SPL_DM=y
 CONFIG_TPL_DM=y
-CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_DMA=y
 CONFIG_REGMAP=y
@@ -258,3 +256,7 @@ CONFIG_TPM=y
 CONFIG_ZSTD=y
 # CONFIG_VPL_LZMA is not set
 CONFIG_ERRNO_STR=y
+CONFIG_UNIT_TEST=y
+CONFIG_SPL_UNIT_TEST=y
+CONFIG_UT_TIME=y
+CONFIG_UT_DM=y
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 637c51d2c2..2c0757194b 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -19,7 +19,6 @@ CONFIG_ENV_OFFSET=0x3FC000
 CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="exynos5250-snow"
 CONFIG_SPL_TEXT_BASE=0x02023400
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0x12c30000
 CONFIG_DEBUG_UART_CLOCK=100000000
@@ -108,3 +107,4 @@ CONFIG_VIDEO_BRIDGE_PARADE_PS862X=y
 CONFIG_VIDEO_BRIDGE_NXP_PTN3460=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
+CONFIG_UNIT_TEST=y
-- 
2.34.1

