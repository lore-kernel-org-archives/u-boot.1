Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA33C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD7580761;
	Fri, 17 Jan 2025 15:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YX06OE5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9085F80312; Fri, 17 Jan 2025 07:33:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E206A8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737095633; x=1768631633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q1/XiEP4qXCTX/MvKpDIOfujRUtiau8Z4ZmKx4Yjg0E=;
 b=YX06OE5H89+Agg3QzqhjvuzBBznK5nMv/C5kOKxBYBObXUaft4FrIk0c
 PQfYcm8NhhtB+nChG9OvQEg/WH6K+hf9e1BecHR80cQjokzxxQMX+VSUW
 C2fudLzvQknWt/GTdPIYIIoO/smA5/DZ3swhcKr0e289eEKdEmzJmPe9A
 Vimx9NWVi4//juTlJsr7fiF4X68CHu4KAUqKpQEHgEJG33HUsMwKSJ5Vs
 OQMMpshDNiU0Yz9Yfz7fJO1H5CvrNiHbTAb07VO8JpdEuZFN+FA87U6oQ
 OQehVJ3rdbfcIzjGkdCkCJfch4Wt8XVyC7RQJ8AJnoNS7WECGml7hrP3c w==;
X-CSE-ConnectionGUID: 31QyCh6kSR6w2olfkuireQ==
X-CSE-MsgGUID: 7BlNwUm/Touxf//TO6mZOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54928891"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="54928891"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 22:33:52 -0800
X-CSE-ConnectionGUID: AhPWs7rHRA2gy1oerw+6lw==
X-CSE-MsgGUID: KMi7G+rqR/2lIolTRHQikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; d="scan'208";a="136567695"
Received: from apgcp0d551112.png.altera.com ([10.244.77.50])
 by orviesa002.jf.intel.com with ESMTP; 16 Jan 2025 22:33:47 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Uboot Open List <u-boot@lists.denx.de>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [mailbox error message v1 1/1] fpga: intel_sdm_mb: add support for
 query SDM config error and status
Date: Fri, 17 Jan 2025 14:33:31 +0800
Message-Id: <20250117063331.13890-2-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250117063331.13890-1-boon.khai.ng@intel.com>
References: <20250117063331.13890-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:26 +0100
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

Currently the FPGA reconfig status only return a single error status
which make the debugging of FPGA reconfiguration hard.

This patch is to expose the error status, major error code and
minor error code, for the FPGA reconfig to upper layer app.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 .../mach-socfpga/include/mach/mailbox_s10.h   | 218 ++++++
 drivers/fpga/intel_sdm_mb.c                   | 641 +++++++++++++++++-
 2 files changed, 852 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index 2cc7c89044..45cc9912f9 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -8,6 +8,7 @@
 #define _MAILBOX_S10_H_
 
 /* user define Uboot ID */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #define MBOX_CLIENT_ID_UBOOT	0xB
 #define MBOX_ID_UBOOT		0x1
@@ -57,6 +58,9 @@
 #define MBOX_RESP_CLIENT_GET(resp)			\
 	(((resp) & MBOX_HDR_CLIENT_MSK) >> MBOX_HDR_CLIENT_LSB)
 
+#define MBOX_CFG_STATUS_MAJOR_ERR_MSK	GENMASK(31, 16)
+#define MBOX_CFG_STATUS_MINOR_ERR_MSK	GENMASK(15, 0)
+
 /* Response error list */
 enum ALT_SDM_MBOX_RESP_CODE {
 	/* CMD completed successfully, but check resp ARGS for any errors */
@@ -162,6 +166,220 @@ enum ALT_SDM_MBOX_RESP_CODE {
 #define MBOX_CFGSTAT_STATE_ERROR_BOOT_INFO		0xf0000007
 #define MBOX_CFGSTAT_STATE_ERROR_QSPI_ERROR		0xf0000008
 
+enum MBOX_CFGSTAT_MAJOR_ERR_CODE {
+	MBOX_CFGSTATE_MAJOR_ERR_UNK = -1,
+	MBOX_CFGSTATE_MAJOR_ERR_WRONG_BL31_VER = 0x0,
+	MBOX_CFGSTATE_MAJOR_ERR_STATE_CONFIG = 0x1000,
+	MBOX_CFGSTATE_MAJOR_ERR_BITSTREAM_ERR = 0xf001,
+	MBOX_CFGSTATE_MAJOR_ERR_EXT_HW_ACCESS_FAIL,
+	MBOX_CFGSTATE_MAJOR_ERR_BITSTREAM_CORRUPTION,
+	MBOX_CFGSTATE_MAJOR_ERR_INTERNAL_ERR,
+	MBOX_CFGSTATE_MAJOR_ERR_DEVICE_ERR,
+	MBOX_CFGSTATE_MAJOR_ERR_HPS_WDT,
+	MBOX_CFGSTATE_MAJOR_ERR_INTERNAL_UNKNOWN_ERR,
+	MBOX_CFGSTATE_MAJOR_ERR_SYSTEM_INIT_ERR,
+	MBOX_CFGSTATE_MAJOR_ERR_DECRYPTION_ERR,
+	MBOX_CFGSTATE_MAJOR_ERR_VERIFY_IMAGE_ERR = 0xf00b
+};
+
+enum MBOX_CFGSTAT_MINOR_ERR_CODE {
+	MBOX_CFGSTATE_MINOR_ERR_UNK = -1,
+	MBOX_CFGSTATE_MINOR_ERR_BASIC_ERR = 0x0,
+	MBOX_CFGSTATE_MINOR_ERR_CNT_RESP_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_QSPI_DEV_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_INV,
+	MBOX_CFGSTATE_MINOR_ERR_BS_INCOMPATIBLE,
+	MBOX_CFGSTATE_MINOR_ERR_BS_INV_SHA,
+	MBOX_CFGSTATE_MINOR_ERR_ROUTE_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_GO_BIT_ALREADY_SET,
+	MBOX_CFGSTATE_MINOR_ERR_CPU_BLK_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_SKIP_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_MCAST_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_IND_SZ_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_IF_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_PIN_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_FUSEFLTR_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_GENERIC_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_DATA_STARVE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_CNT_RAM_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_SETUP_S4,
+	MBOX_CFGSTATE_MINOR_ERR_WIPE_DATA_STARVE,
+	MBOX_CFGSTATE_MINOR_ERR_FUSE_RD_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_AUTH_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SHA_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SKIP_DATA_RAM_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_FIXED_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_MCAST_FLTR_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_SECTOR_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_HASH_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_DECOMP_SETUP_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_INTERNAL_OS_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_WIPE_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_CNOC_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_RESUME_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_RUN_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_PAUSE_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_RET_INT_ASSERT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_STATE_MACHINE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_CMF_TRANSITION_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SHA_SETUP_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_WR_DMA_TIMEOUT,
+	MBOX_CFGSTATE_MINOR_ERR_MEM_ALLOC_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SYNC_RD_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_CHK_CFG_REQ_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_HPS_CFG_REQ_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_CFG_HANDLE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_INV_ACTION_ITEM,
+	MBOX_CFGSTATE_MINOR_ERR_SKIP_DATA_PREBUF_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_TIMEOUT,
+	MBOX_CFGSTATE_MINOR_ERR_AVST_FIFO_OVERFLOW_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RD_DMA_TIMEOUT,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_INIT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_SHUTDOWN_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_BITSTREAM_INTERRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_FPGA_MBOX_WIPE_TIMEOUT,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_TYPE_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_VERSION_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_DEVICE_TYPE_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_DESIGN_HASH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_EXT_REF_CLK_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PWR_TBL_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PIN_TBL_OFST_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PIN_TBL_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_NO_PIN_TBL,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_CFG_CLK_PLL_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_AS_CLK_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_POF_ID_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PW_TBL_OFST_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PP_TBL_OFST_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PP_TBL_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SP_TBL_OFST_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SP_TBL_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SU_TBL_OFST_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SU_TBL_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_CRYPTO_SRC_CLR_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_EVENT_GROUP_POST_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRNG_TEST_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_ANTI_DOS_TMR_INIT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_OS_STK_CHK_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_INIT,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_COMPAT_ID_MATCH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_COMPAT_ID_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_AES_ECRYPT_CHK_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_KEY_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_KEY_CHALLENGE_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_MSGQ_DEQUEUE_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SECT_COMPAT_CHK_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SECT_COMPAT_UPDATE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SECT_SEC_CHK_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_CNT_RAM_ECC_ERR_UNRECOVERABLE,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_REFORMAT_INPUT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_REFORMAT_OUTPUT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_WLBL_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MBOX_HOOK_CB_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_CMF_RLD_DECOMP_LOAD_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_CMF_RLD_DECOMP_RUN_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_CNT_PERIPH_ECC_ERR_UNRECOVERABLE,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_SECT_ADDR_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SCRAMBLE_RATIO_CHK_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_TAMPER_EVENT_TRIGGERED,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_ANTI_TAMPER_TBL_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_EXT_CLCK_MODE_DISALLOWED,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SEC_OPTIONS_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_EN_USR_CAN_FUSE_INV,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_AS_DEVICE_NO_SGX_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_POF_ID_LIMIT_EXCEED_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_INV_STATE,
+	MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_FATAL_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_SM_EXIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_SM_ENTRY_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACTION_DATA_UNSUPPORTED_CTX,
+	MBOX_CFGSTATE_MINOR_ERR_CMF_EXCEPTION,
+	MBOX_CFGSTATE_MINOR_ERR_ECC_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_DEFAULT_UNREGISTERED_ISR,
+	MBOX_CFGSTATE_MINOR_ERR_GENERAL_TIMEOUT,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_OPERATION_CLK_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_VERIFY_HASH_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_CFG_STATE_UPDATE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_READ_DDR_HASH_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_CVP_FLOW_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_KEYED_HASH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_CMF_DESC_BAD_JTAG_ID = 0x7a,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PMF_NOT_SUPPORTED = 0x7d,
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_ANTI_TAMPER_NOT_SUPPORTED,
+	MBOX_CFGSTATE_MINOR_ERR_ACT_RECOVERY_FAIL = 0x80,
+	MBOX_CFGSTATE_MINOR_ERR_COLD_RESET_CMF_CORRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_COLD_RESET_IO_HPS_CORRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_COLD_RESET_FPGA_CORRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_CRC_CHK_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_COMPAT_TBL_SFIXED_VALUE_INV,
+	MBOX_CFGSTATE_MINOR_ERR_FEATURE_EN_FUSE_NOT_BLOWN = 0x87,
+	MBOX_CFGSTATE_MINOR_ERR_UIB_REFCLK_MISSING,
+	MBOX_CFGSTATE_MINOR_ERR_UIB_REFCLK_TIMEOUT,
+	MBOX_CFGSTATE_MINOR_ERR_UIB_REFCLK_TIMEOUT_MISSING,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_SYNC_BLCK_ERR = 0xc001,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_SSBL_SHA_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_BLCK0_SHA_MISMATCH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_BLCK0_AUTH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_TRAMP_LOAD_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_CMF_SIZE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_TRANSITION_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_SYNC_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_LOAD_CERT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_LOAD_NOT_ALLOWED_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_FUSE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_INPUT_BUFFER_ERR = 0xc00d,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_CMF_TYPE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_TRAMP_QSPI_INDR_READ_START_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_I2C_COMM_ERR = 0xc801,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_TARGET_VOLTAGE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_HANDSHAKE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_ITD_OUT_OF_RANGE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_PWR_TABLE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_EFUSE_DECODE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_VCCL_PWRGOOD_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_CLR_FAULTS_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_VOUT_MODE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_PAGE_COMMAND_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_VOUT_COMMAND_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_READ_VOUT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_LTM4677_DEFAULT_ADC_CTRL_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_PMF_FIRST_I2C_CMD_FAILED_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_CMF_AUTH_ERR = 0xd001,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_USER_AUTH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_CMF_DESC_SHA_MISMATCH,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_POINTERS_NOT_FOUND_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_QSPI_FREQ_CHANGE,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_FACTORY_IMG_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_CMF_TYPE_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_SIG_DESC_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_INTERNAL_AUTH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_COPY_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_ERASE_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_RM_UCMF_FROM_CPB_FAILED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_COMBINED_APP_AUTH_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_FLASH_ACCESS_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_DCMF_DCIO_CORRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_DCMF_CPB0_CORRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_DCMF_CPB1_CORRUPTED,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_PROVISION_COMPLETE,
+	MBOX_CFGSTATE_MINOR_ERR_RSU_PROVISION_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_EFUSE_INIT_FAIL = 0xe001,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_SEC_PROT_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_EFUSE_LCK_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_SEC_BBRAM_CLEAN_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_ENG_LOAD_DIMK_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_SEC_UKV_CLEAN_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_EFUSE_ZERO_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_ENG_LOAD_ERR,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_PERST_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_DIMK_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_PERST_SECONDARY_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_BR_INFO_INIT_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_CMF_DESC_FAIL,
+	MBOX_CFGSTATE_MINOR_ERR_SYSINIT_DRNG_INIT_FAIL
+};
+
 #define RCF_SOFTFUNC_STATUS_CONF_DONE			BIT(0)
 #define RCF_SOFTFUNC_STATUS_INIT_DONE			BIT(1)
 #define RCF_SOFTFUNC_STATUS_SEU_ERROR			BIT(3)
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 5a65bd9877..5fe4dbdfd3 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -22,18 +22,630 @@
 #define BITSTREAM_CHUNK_SIZE				0xFFFF0
 #define RECONFIG_STATUS_POLL_RETRY_MAX			100
 
+static const struct mbox_cfgstat_major_err {
+	int			err_no;
+	const char		*error_name;
+} mbox_cfgstat_major_err[] = {
+	{MBOX_CFGSTATE_MAJOR_ERR_WRONG_BL31_VER,
+	"Please check ATF BL31 version, require v2.11 above to print more error status."},
+	{MBOX_CFGSTATE_MAJOR_ERR_STATE_CONFIG,
+	"Mailbox in configuration state."},
+	{MBOX_CFGSTATE_MAJOR_ERR_BITSTREAM_ERR,
+	"Bitstream Invalid."},
+	{MBOX_CFGSTATE_MAJOR_ERR_EXT_HW_ACCESS_FAIL,
+	"External HW access failure."},
+	{MBOX_CFGSTATE_MAJOR_ERR_BITSTREAM_CORRUPTION,
+	"Bitstream valid but corrupted. Bitstream corruption error when reading the bitstream from the source."
+	},
+	{MBOX_CFGSTATE_MAJOR_ERR_INTERNAL_ERR,
+	"Bitstream element not understood. Internal error."},
+	{MBOX_CFGSTATE_MAJOR_ERR_DEVICE_ERR,
+	"Unable to communicate on internal configuration network. Device operation error."},
+	{MBOX_CFGSTATE_MAJOR_ERR_HPS_WDT,
+	"HPS Watchdog Timer. HPS watchdog timeout failure."},
+	{MBOX_CFGSTATE_MAJOR_ERR_INTERNAL_UNKNOWN_ERR,
+	"Other unknown error occurred"},
+	{MBOX_CFGSTATE_MAJOR_ERR_SYSTEM_INIT_ERR,
+	"Error before main CMF start. System initialization failure."},
+	{MBOX_CFGSTATE_MAJOR_ERR_DECRYPTION_ERR,
+	"Decryption Error."},
+	{MBOX_CFGSTATE_MAJOR_ERR_VERIFY_IMAGE_ERR,
+	"Verify image error."},
+	{MBOX_CFGSTATE_MAJOR_ERR_UNK,
+	"Unknown error number at major field!"}
+};
+
+#define MBOX_CFGSTAT_MAJOR_ERR_MAX ARRAY_SIZE(mbox_cfgstat_major_err)
+
+static const struct mbox_cfgstat_minor_err {
+	int			err_no;
+	const char		*error_name;
+} mbox_cfgstat_minor_err[] = {
+	{MBOX_CFGSTATE_MINOR_ERR_BASIC_ERR,
+	"Catchall Error."},
+	{MBOX_CFGSTATE_MINOR_ERR_CNT_RESP_ERR,
+	"Detected an error during configuration. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_QSPI_DEV_ERR,
+	"QSPI Device related error. Detected QSPI device related error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_INV,
+	"Bitstream section main descriptor invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_BS_INCOMPATIBLE,
+	"Bistream not compatible with device. Detected an error during configuration due to incompatible bitstream with the device."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_BS_INV_SHA,
+	"Bitstream invalid SHA setting. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_ROUTE_FAIL,
+	"Bitstream processing route failed. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_GO_BIT_ALREADY_SET,
+	"Failed DMA during bitstream processing. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_CPU_BLK_FAIL,
+	"Failed DMA during bitstream processing. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_SKIP_FAIL,
+	"Skip action failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_MCAST_FAIL,
+	"Multicast Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_IND_SZ_FAIL,
+	"Index Size Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_IF_FAIL,
+	"If Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_PIN_FAIL,
+	"Pin Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_FUSEFLTR_FAIL,
+	"Fuse Filter Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_GENERIC_FAIL,
+	"Other Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_DATA_STARVE_ERR,
+	"Datapath starved. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CNT_RAM_INIT_FAIL,
+	"CNT/SSM RAM Initialization Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_SETUP_S4,
+	"S4 Setup Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_WIPE_DATA_STARVE,
+	"Datapath starved during wipe. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_FUSE_RD_FAIL,
+	"eFUSE Read Failure. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_AUTH_FAIL,
+	"Authentication Failure. Detected a bitstream authentication error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SHA_FAIL,
+	"Bitstream Section Main Descriptor Hash Check Failed. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SKIP_DATA_RAM_FAIL,
+	"Skip Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_FIXED_FAIL,
+	"Fixed Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_MCAST_FLTR_FAIL,
+	"Multicast Filter Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_SECTOR_FAIL,
+	"Sector Group Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_HASH_FAIL,
+	"Hash Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_DECOMP_SETUP_FAIL,
+	"Decompression Setup Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_INTERNAL_OS_ERR,
+	"RTOS Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_WIPE_FAIL,
+	"Wipe Bitstream Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CNOC_ERR,
+	"Internal Configuration Network Failure. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_RESUME_FAIL,
+	"Power Management Firmware Failed Resume. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_RUN_FAIL,
+	"Power Management Firmware Failed Run. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_PAUSE_FAIL,
+	"Power Management Firmware Failed Pause. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RET_INT_ASSERT_FAIL,
+	"Internal Configuration Network Return Interrupt Failure. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_STATE_MACHINE_ERR,
+	"Configuration State Machine Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CMF_TRANSITION_FAIL,
+	"Error during CMF load/reload. Detected a firmware transition error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SHA_SETUP_FAIL,
+	"Error setting up SHA engine. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_WR_DMA_TIMEOUT,
+	"Write DMA timed out. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MEM_ALLOC_FAIL,
+	"Out of Memory. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYNC_RD_FAIL,
+	"Sync Block Read Fail. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CHK_CFG_REQ_FAIL,
+	"Configuration Status Check Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_HPS_CFG_REQ_FAIL,
+	"HPS Configuration Request Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CFG_HANDLE_ERR,
+	"Driver Handle Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_INV_ACTION_ITEM,
+	"Bistream contains invalid action. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_SKIP_DATA_PREBUF_ERR,
+	"Prebuffer Error during Skip Action. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_TIMEOUT,
+	"Mailbox Processing Timeout. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_AVST_FIFO_OVERFLOW_ERR,
+	"AVST FIFO Overflow. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_RD_DMA_TIMEOUT,
+	"Read DMA timed out. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_INIT_ERR,
+	"Power Management Firmware Initialization Error. Detected a PMBUS error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_SHUTDOWN_ERR,
+	"Power Management Firmware Shutdown Error. Detected a PMBUS error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_BITSTREAM_INTERRUPTED,
+	"Bitstream processing was interrupted by another event. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_FPGA_MBOX_WIPE_TIMEOUT,
+	"Mailbox Wipe Timeout. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_TYPE_INV,
+	"Bitstream Section Main Descriptor Type is Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_VERSION_INV,
+	"Bitstream Section Main Descriptor Version is Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_DEVICE_TYPE_INV,
+	"Bitstream Section Main Descriptor Device is Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_DESIGN_HASH_ERR,
+	"Bitstream Section Main Descriptor Hash Mismatch. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_EXT_REF_CLK_ERR,
+	"Bitstream Section Main Descriptor External Clock Setting Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PWR_TBL_INV,
+	"Bitstream Section Main Descriptor Power Table is invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PIN_TBL_OFST_ERR,
+	"Bitstream Section Main Descriptor Offset to Pin Table is Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PIN_TBL_INV,
+	"Bitstream Section Main Descriptor Pin Table is Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_NO_PIN_TBL,
+	"Bitstream Section Main Descriptor missing pin table. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_CFG_CLK_PLL_FAILED,
+	"Bitstream Section Main Descriptor PLL setting failure. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_AS_CLK_FAILED,
+	"Bitstream Section Main Descriptor QSPI Clock Setting Failure. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_POF_ID_FAILED,
+	"Bitstream Section Main Descriptor POF ID not valid. Detected an incompatible PR bitstream during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PW_TBL_OFST_ERR,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PP_TBL_OFST_ERR,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PP_TBL_INV,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SP_TBL_OFST_ERR,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SP_TBL_INV,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SU_TBL_OFST_ERR,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SU_TBL_INV,
+	"code not used."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_CRYPTO_SRC_CLR_ERR,
+	"Mailbox Source Failed to Clear. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_EVENT_GROUP_POST_ERR,
+	"Mailbox Event Post Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_TRNG_TEST_FAIL,
+	"True Random Number Generator Failed Test. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_ANTI_DOS_TMR_INIT_ERR,
+	"Mailbox Anti-DOS Timer failed initialization. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_OS_STK_CHK_ERR,
+	"RTOS Stack Check Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_INIT,
+	"Mailbox Task failed to initialize. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_COMPAT_ID_MATCH_ERR,
+	"Bitstream Section Main Descriptor Compatibility ID mismatch. Detected a bitstream error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_COMPAT_ID_INV,
+	"Bitstream Section Main Descriptor Compatibility ID not Valid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_AES_ECRYPT_CHK_FAIL,
+	"Bitstream Section Main Descriptor AES Test Failed. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_KEY_FAIL,
+	"Key Action Failure. Detected a bitstream decryption error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_KEY_CHALLENGE_FAIL,
+	"Key Challenge Failure. Detected a bitstream decryption error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_TASK_MSGQ_DEQUEUE_FAIL,
+	"Mailbox Task Queue failed to dequeue. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_SECT_COMPAT_CHK_ERR,
+	"Bitstream Section Compatibility Check Error. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SECT_COMPAT_UPDATE_ERR,
+	"Bitstream Section Compatibility Update Error. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SECT_SEC_CHK_FAILED,
+	"Bitstream Section Security Check Failed. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_CNT_RAM_ECC_ERR_UNRECOVERABLE,
+	"Unrecoverable Error in CNT/SSM RAM. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_REFORMAT_INPUT_ERR,
+	"Mailbox Input Processing Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_REFORMAT_OUTPUT_ERR,
+	"Mailbox Output Processing Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_WLBL_ERR,
+	"(Provision only) Provision CMF's allowed mailbox cmd group is invalid. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MBOX_HOOK_CB_ERR,
+	"Mailbox Callback Error. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CMF_RLD_DECOMP_LOAD_ERR,
+	"CMF Reload failed to load Decompression Code. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_CMF_RLD_DECOMP_RUN_ERR,
+	"CMF Reload failed to run Decompression Code. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_CNT_PERIPH_ECC_ERR_UNRECOVERABLE,
+	"Unrecoverable Error in CNT/SSM Peripheral. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_SECT_ADDR_ERR,
+	"(Provision only) invalid Flash image CMF header's main section address. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SCRAMBLE_RATIO_CHK_FAIL,
+	"Bitstream Section Main Descriptor Invalid Scrambler Ratio. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TAMPER_EVENT_TRIGGERED,
+	"Tamper Detected. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_ANTI_TAMPER_TBL_INV,
+	"Bitstream Section Main Descriptor Anti Tamper Table Invalid. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_EXT_CLCK_MODE_DISALLOWED,
+	"External Clock info presented, but external clock not allowed on device. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_SEC_OPTIONS_INIT_FAIL,
+	"Bitstream Section Main Descriptor Security Option Initialization Failed. Detected an error during configuration due to a corrupted bitstream."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_EN_USR_CAN_FUSE_INV,
+	"User cancellation fuse table initialization failed. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_AS_DEVICE_NO_SGX_ERR,
+	"Not yet turned on for Rearch code. Detected an incompatible bitstream during configuration. You cannot use the bitstream from an advanced security-enabled devices on a non-advanced security-enabled device."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_POF_ID_LIMIT_EXCEED_ERR,
+	"Not yet turned on for Rearch code. Detected an invalid bitstream during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_INV_STATE,
+	"(Provision only) Internal state machine wrong state. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_FATAL_ERR,
+	"(Provision only) Fatal error detected with Provision CMF. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_SM_EXIT_FAIL,
+	"(Provision only) State machine's state function exit error. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PROVISION_CMF_SM_ENTRY_FAIL,
+	"(Provision only) State machine's state function entry error. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_ACTION_DATA_UNSUPPORTED_CTX,
+	"Not yet turned on for Rearch code. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CMF_EXCEPTION,
+	"Processor Exception. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ECC_INIT_FAIL,
+	"SDM Peripheral ECC Initialization Failure. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_DEFAULT_UNREGISTERED_ISR,
+	"Unregistered Interrupt Occurred. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_GENERAL_TIMEOUT,
+	"Execution Timeout. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_OPERATION_CLK_FAIL,
+	"Clock Operation Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_VERIFY_HASH_FAIL,
+	"Verify Hash Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_CFG_STATE_UPDATE_ERR,
+	"Error updating configuration state. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_READ_DDR_HASH_FAIL,
+	"Error while reading HPS DDR hash from main descriptor."},
+	{MBOX_CFGSTATE_MINOR_ERR_CVP_FLOW_ERR,
+	"Error during CvP Phase 2 data flow handling or handshake."},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_KEYED_HASH_ERR,
+	"Encountered keyed hash error while processing a main descriptor."},
+	{MBOX_CFGSTATE_MINOR_ERR_CMF_DESC_BAD_JTAG_ID,
+	"New CMF Descriptor JTAG ID mismatch with original configured CMF JTAG ID."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_PMF_NOT_SUPPORTED,
+	"The IO Descriptor contains a power table but the current CMF does not support PMF. Bitstream incompatile with Firmware."
+	},
+	{
+	MBOX_CFGSTATE_MINOR_ERR_MAIN_DESC_ANTI_TAMPER_NOT_SUPPORTED,
+	"The IO Descriptor contains anti-tamper setting but the current CMF does not support anti-tamper. Bitstream incompatile with Firmware."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_ACT_RECOVERY_FAIL,
+	"Recovery Action Failed. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_COLD_RESET_CMF_CORRUPTED,
+	"Error when process CMF section after cold reset. Detected CMF section error or incompatible upon cold reset using JTAG or AVST."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_COLD_RESET_IO_HPS_CORRUPTED,
+	"Error when process IO/HPIO/HPS section after cold reset and hps wipe. Detected an error when try to bring up HPS again after cold reset."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_COLD_RESET_FPGA_CORRUPTED,
+	"Error when process FPGA section header after cold reset. Detected an error in FPGA after successfully bring up HPS."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_CRC_CHK_FAIL,
+	" CRC32 Check Fail. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_COMPAT_TBL_SFIXED_VALUE_INV,
+	"Error when process compatibility table in main section header. SFixed offset value in compatibility table is not valid."
+	},
+	{
+	MBOX_CFGSTATE_MINOR_ERR_FEATURE_EN_FUSE_NOT_BLOWN,
+	"Error bitstream contains feature(s) that are only allowed when a feature fuse is blown on the device, and the device did not have the feature fuse blown. Bitstream requires feature enable fuse to be blown."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_UIB_REFCLK_MISSING,
+	"UIB REFCLK missing. Device requires refclk to proceed configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_UIB_REFCLK_TIMEOUT,
+	"UIB REFCLK timeout. Device requires refclk to proceed configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_UIB_REFCLK_TIMEOUT_MISSING,
+	"UIB REFCLK missing and timeout. Device requires refclk to proceed configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_SYNC_BLCK_ERR,
+	"Sync block before SSBL processing failure. Detected a firmware error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_SSBL_SHA_ERR,
+	"SSBL sha mismatch with bitstream. Detected a bitstream error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_BLCK0_SHA_MISMATCH_ERR,
+	"Block0 Sha mismatch when trampoline reloads. Detected a bitstream error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_BLCK0_AUTH_ERR,
+	"Trampoline authentication failure. Detected a bitstream error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_TRAMP_LOAD_ERR,
+	"Trampoline Load compressed tramp failure. Detected a bitstream error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_CMF_SIZE_ERR,
+	"Trampoline failed to retrieve SSBL or TSBL load information. Detected a bitstream error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_TRANSITION_ERR,
+	"Trampoline failed to find a bootable DCMF. Detected an error during application images transition."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_SYNC_ERR,
+	"Only used by RMA and ENG loader on legacy code. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_LOAD_CERT_ERR,
+	"Main CMF failed to authenticate a certificate bitstream. Detected a bitstream authentication error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_LOAD_NOT_ALLOWED_ERR,
+	"Only used by Provision CMF, failure to initialize HW drivers. Detected an error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_FUSE_ERR,
+	"Only used by RMA and Eng loader on Legacy code. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_INPUT_BUFFER_ERR,
+	"Provision CMF only, Trampoline inbuf HW access error. Detected a hardware error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_CMF_TYPE_ERR,
+	"Trampoline/DCMF loading another CMF andfound CMF type mismatched with current one. Detected a bitstream error during reconfiguration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_TRAMP_QSPI_INDR_READ_START_ERR,
+	"Trampoline QSPI indirect read start error. Detected an error when accessing the QSPI flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_I2C_COMM_ERR,
+	"Generic I2C error, ie Bad Address."},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_TARGET_VOLTAGE_ERR,
+	"Failed to reach Target Voltage. Voltage Regulator unable to achieve the requested voltage."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_HANDSHAKE_ERR,
+	"Slave Mode ALERT/VOUT_COMMAND handshake did not happen."},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_ITD_OUT_OF_RANGE_ERR,
+	"Fuse values calculated voltage greater that cutoff max. ITD fuse is out of range."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_PWR_TABLE_ERR,
+	"Error while reading or processing the Power Table. Internal Error while reading or decoding the Bitstream's Power Table."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_EFUSE_DECODE_ERR,
+	"Error while reading or decoding the efuse values. Internal Error while reading or decoding the efuse values."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_VCCL_PWRGOOD_ERR,
+	"Failed to verify the vccl power is good. Failed to validate the vccl power is valid on the board."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_CLR_FAULTS_ERR,
+	"Error while sending CLEAR_FAULTS command. Error while sending CLEAR_FAULTS command,"
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_VOUT_MODE_ERR,
+	"Error while sending VOUT_MODE command. Error while sending VOUT_MODE command,"},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_PAGE_COMMAND_ERR,
+	"Error while sending PAGE_COMMAND command. Error while sending PAGE_COMMAND command,"
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_VOUT_COMMAND_ERR,
+	"Error while sending VOUT_COMMAND command. Error while sending VOUT_COMMAND command,"
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_READ_VOUT_ERR,
+	"Error while sending READ_VOUT command. Error while sending READ_VOUT command,"},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_LTM4677_DEFAULT_ADC_CTRL_ERR,
+	"Error while sending the vendor specific LTM4677 MFR_ADC_CTRL command. Error while sending the vendor specific LTM4677 MFR_ADC_CTRL command,"
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_PMF_FIRST_I2C_CMD_FAILED_ERR,
+	"First I2C messaged failed, ie Bad Address. The first I2C command has failed, no response from Voltage Regulator."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_CMF_AUTH_ERR,
+	"Failed to authenticate CMF section. Detected a firmware authentication error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_USER_AUTH_ERR,
+	"Failed to authenticate USER section. Detected a bitstream authentication error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_CMF_DESC_SHA_MISMATCH,
+	"Block0 SHA mismatch when DCMF loads an APP image. Detected an error when loading the application image from flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_POINTERS_NOT_FOUND_ERR,
+	"RSU CPB table parsing failed. Detected an error when parsing the RSU CPB block."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_QSPI_FREQ_CHANGE,
+	"QSPI reference clock freq update failed. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_FACTORY_IMG_FAILED,
+	"RSU factory image failed to boot. Detected an error when loading the factory image. Check the factory image validity. If corrupted, regenerate and reprogram again the factory image in the flash. When authentication enabled,"
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_CMF_TYPE_ERR,
+	"APP image CMF type mismatched with DCMF. Detected an error when loading the application image."
+	},
+	{
+	MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_SIG_DESC_ERR,
+	"UCMF reports failure in parsing of an signature block, can be from new DCMF, new DCIO or new Factory. Detected an error during factory image update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_INTERNAL_AUTH_ERR,
+	"UCMF reports authentication failure of new DCMF, new DCIO or new Factory. Detected an error during DCMF update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_COPY_FAILED,
+	"UCMF reports QSPI flash write failure while upgrading DCMF, DCIO or Factory. Detected an error during DCMF update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_ERASE_FAILED,
+	"UCMF reports QSPI flash erase failure while upgrading DCMF, DCIO or Factory. Detected an error during DCMF update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_RM_UCMF_FROM_CPB_FAILED,
+	"UCMF reports failure to remove UCMF address from RSU CPB table. Detected an error during RSU CPB table update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_COMBINED_APP_AUTH_ERR,
+	"UCMF reports authentication failure of new combined app image. Detected an error during combined app image update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_UCMF_FLASH_ACCESS_ERR,
+	"UCMF failed to upgrade for more than max retry times. Detected an error during DCMF update in flash."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_DCMF_DCIO_CORRUPTED,
+	"DCMF reports failure when parse dcio section, causing force factory boot. Detected an error when parsing dcio section."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_DCMF_CPB0_CORRUPTED,
+	"DCMF reports failure when parse cpb0 and thus cpb1 is used. Detected an error in RSU CPB0 table."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_DCMF_CPB1_CORRUPTED,
+	"DCMF reports failure when parse both cpb0 and cpb1, causing force factory boot. Detected an error in both RSU CPB0 and CPB1 table."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_PROVISION_COMPLETE,
+	"Non-JTAG Provisioning Successful. Non-Jtag Provisioning was Successful DCMF will load next highest priority application image."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_RSU_PROVISION_ERR,
+	"Non-JTAG Provisioning Failed. An error occurred while provisioning the device."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_EFUSE_INIT_FAIL,
+	"Efuse cache generation failure. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_SEC_PROT_ERR,
+	"Security lock and disable driver failure. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_EFUSE_LCK_ERR,
+	"efuse lock operation failure."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_SEC_BBRAM_CLEAN_ERR,
+	"BBRAM clean up failure."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_ENG_LOAD_DIMK_ERR,
+	"DIMK failed to derive device identity."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_SEC_UKV_CLEAN_ERR,
+	"Key Vault clean up failure."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_EFUSE_ZERO_ERR,
+	"No security efuse allowed."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_ENG_LOAD_ERR,
+	"efuse policy check failed."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_PERST_INIT_FAIL,
+	"Peristent data initialization failure. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_DIMK_INIT_FAIL,
+	"DIMK Initialization failure. Detected an error during configuration."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_PERST_SECONDARY_INIT_FAIL,
+	"Handoff data include CMF main and signature blocks validation failure. Detected an error during configuration."
+	},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_BR_INFO_INIT_FAIL,
+	"CMF Bootrom header validation failure."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_CMF_DESC_FAIL,
+	"CMF Descriptor failure."},
+	{MBOX_CFGSTATE_MINOR_ERR_SYSINIT_DRNG_INIT_FAIL,
+	"DRNG Initialization failed."},
+	{MBOX_CFGSTATE_MINOR_ERR_UNK,
+	"Unknown error number at minor field!"}
+};
+
+#define MBOX_CFGSTAT_MINOR_ERR_MAX ARRAY_SIZE(mbox_cfgstat_minor_err)
+
+struct mbox_err_msg {
+	const char *major_err_str;
+	const char *minor_err_str;
+};
+
+static void mbox_cfgstat_to_str(int err, struct mbox_err_msg *err_msg)
+{
+	int i;
+	u32 major_err;
+	u32 minor_err;
+
+	major_err = FIELD_GET(MBOX_CFG_STATUS_MAJOR_ERR_MSK, err);
+
+	minor_err = FIELD_GET(MBOX_CFG_STATUS_MINOR_ERR_MSK, err);
+
+	if (!err_msg) {
+		printf("Invalid argument\n");
+		return;
+	}
+
+	err_msg->major_err_str = "";
+	err_msg->minor_err_str = "";
+
+	/*
+	 * In the case of getting error number 0, meaning the
+	 * ATF BL31 is not supporting the feature yet thus,
+	 * the SMC call will return 0 at the second argument
+	 * return the message to indicate that current BL31
+	 * is not yet supporting feature and need to check
+	 * the BL31 version.
+	 */
+	if (err == 0) {
+		err_msg->major_err_str = mbox_cfgstat_major_err[err].error_name;
+		return;
+	}
+
+	/* Initialize the major error string with unknown error */
+	err_msg->major_err_str = mbox_cfgstat_major_err[0].error_name;
+
+	for (i = 0; i < MBOX_CFGSTAT_MAJOR_ERR_MAX - 1; i++) {
+		if (mbox_cfgstat_major_err[i].err_no == major_err) {
+			err_msg->major_err_str = mbox_cfgstat_major_err[i].error_name;
+			break;
+		}
+	}
+
+	/* Return configuration state if device still under config state */
+	if (major_err == MBOX_CFGSTATE_MAJOR_ERR_STATE_CONFIG)
+		return;
+
+	/* Initialize the minor error string with unknown error */
+	err_msg->minor_err_str = mbox_cfgstat_minor_err[0].error_name;
+
+	for (i = 0; i < MBOX_CFGSTAT_MINOR_ERR_MAX - 1; i++) {
+		if (mbox_cfgstat_minor_err[i].err_no == minor_err) {
+			err_msg->minor_err_str = mbox_cfgstat_minor_err[i].error_name;
+			break;
+		}
+	}
+}
+
 /*
  * Polling the FPGA configuration status.
  * Return 0 for success, non-zero for error.
  */
-static int reconfig_status_polling_resp(void)
+static int reconfig_status_polling_resp(uint32_t *error_status)
 {
 	int ret;
+	u64 res_buf[3];
 	unsigned long start = get_timer(0);
 
 	while (1) {
 		ret = invoke_smc(INTEL_SIP_SMC_FPGA_CONFIG_ISDONE, NULL, 0,
-				 NULL, 0);
+				res_buf, ARRAY_SIZE(res_buf));
+
+		if (error_status)
+			*error_status = (uint32_t)res_buf[0];
 
 		if (!ret)
 			return 0;	/* configuration success */
@@ -120,29 +732,44 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
 {
 	int ret;
 	u64 arg = 1;
+	u32 err_status = 0;
+	u64 res_buf[3];
+	struct mbox_err_msg err_msg;
 
 	debug("Invoking FPGA_CONFIG_START...\n");
 
 	ret = invoke_smc(INTEL_SIP_SMC_FPGA_CONFIG_START, &arg, 1, NULL, 0);
 
 	if (ret) {
-		puts("Failure in RECONFIG mailbox command!\n");
+		puts("U-Boot SMC: Failure in RECONFIG mailbox command!\n");
 		return ret;
 	}
 
 	ret = send_bitstream(rbf_data, rbf_size);
 	if (ret) {
-		puts("Error sending bitstream!\n");
+		puts("\nU-Boot SMC: Error sending bitstream!\n");
+		ret = invoke_smc(INTEL_SIP_SMC_FPGA_CONFIG_ISDONE, NULL, 0,
+				 res_buf, ARRAY_SIZE(res_buf));
+
+		err_status = res_buf[0];
+		mbox_cfgstat_to_str(err_status, &err_msg);
+		printf("SDM: Config status: (0x%x)\nSDM Err: %s\n%s\n", err_status,
+		       err_msg.major_err_str, err_msg.minor_err_str);
+
 		return ret;
 	}
 
 	/* Make sure we don't send MBOX_RECONFIG_STATUS too fast */
 	udelay(RECONFIG_STATUS_INTERVAL_DELAY_US);
 
-	debug("Polling with MBOX_RECONFIG_STATUS...\n");
-	ret = reconfig_status_polling_resp();
+	debug("U-Boot SMC: Polling with MBOX_RECONFIG_STATUS...\n");
+	ret = reconfig_status_polling_resp(&err_status);
 	if (ret) {
-		puts("FPGA reconfiguration failed!");
+		printf("\nU-Boot SMC: FPGA reconfiguration failed!\n");
+		mbox_cfgstat_to_str(err_status, &err_msg);
+		printf("SDM: Config status: (0x%x)\nSDM Err:%s\n%s\n", err_status,
+		       err_msg.major_err_str, err_msg.minor_err_str);
+
 		return ret;
 	}
 
-- 
2.26.2

