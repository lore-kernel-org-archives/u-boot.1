Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27C2C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63AA0831A1;
	Mon, 21 Jul 2025 13:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1726F8311B; Mon, 21 Jul 2025 13:18:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DAB9A83108
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659681595;
 Mon, 21 Jul 2025 04:18:34 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17ABD3F6A8;
 Mon, 21 Jul 2025 04:18:38 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 05/24] arm_ffa: sandbox: Add FFA_MEM_SHARE emulation
Date: Mon, 21 Jul 2025 12:17:57 +0100
Message-Id: <20250721111816.62340-6-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
References: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add FFA_MEM_SHARE support to the FF-A emulator

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 .../include/asm/sandbox_arm_ffa_priv.h        |  4 ++
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    | 43 +++++++++++++++++++
 drivers/firmware/arm-ffa/sandbox_ffa.c        |  3 +-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
index 8f442145eba..fa09f9598ee 100644
--- a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
+++ b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
@@ -38,6 +38,7 @@
 /*  RX/TX buffers minimum size */
 #define RXTX_BUFFERS_MIN_SIZE (RXTX_4K)
 #define RXTX_BUFFERS_MIN_PAGES (1)
+#define RXTX_BUFFERS_MIN_PAGES_SIZE (RXTX_BUFFERS_MIN_PAGES * SZ_4K)
 
 /* A helper macro used for clearing registers that Must Be Zero (MBZ) */
 #define FFA_X_REG_SIZE_IN_BYTE sizeof((((ffa_value_t *)0)->a0))
@@ -59,6 +60,9 @@
 #define SANDBOX_SERVICE2_UUID_A3	0x9cc02d72
 #define SANDBOX_SERVICE2_UUID_A4	0xcdd998a7
 
+/* Globally unique Handle to identify the shared memory region */
+#define SANDBOX_MEM_HANDLE		0xffffffff
+
 /**
  * struct ffa_rxtxpair_info - structure hosting the RX/TX buffers flags
  * @rxbuf_owned:	RX buffer ownership flag (the owner is non secure world)
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index dcf5bce9435..4918404fb6d 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -563,6 +563,46 @@ static int sandbox_ffa_get_parts(struct udevice *emul, struct ffa_sandbox_data *
 	return 0;
 }
 
+/**
+ * sandbox_ffa_memory_share() - Emulated FFA_MEM_SHARE handler
+ * @emul: The sandbox FF-A emulator device
+ * @pargs: The SMC call input arguments a0-a7
+ * @res:  The SMC return data
+ *
+ * Emulate FFA_MEM_SHARE FF-A function.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int sandbox_ffa_memory_share(struct udevice *emul, ffa_value_t *pargs,
+				    ffa_value_t *res)
+{
+	int ret;
+
+	res->a1 = 0;
+
+	if (!pargs->a1 || pargs->a1 > RXTX_BUFFERS_MIN_PAGES_SIZE) {
+		/* FFA_ERROR encoding */
+		res->a0 = FFA_SMC_32(FFA_ERROR);
+		res->a2 = -INVALID_PARAMETERS;
+		ret = ffa_to_std_errmap[INVALID_PARAMETERS];
+		/* x3-x7 MBZ */
+		memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
+
+		return ret;
+	}
+
+	/* FFA_SUCCESS encoding */
+	res->a0 = FFA_SMC_32(FFA_SUCCESS);
+	res->a2 = SANDBOX_MEM_HANDLE;
+	res->a3 = SANDBOX_MEM_HANDLE;
+	/* x4-x7 MBZ */
+	memset(&res->a4, 0, 4 * FFA_X_REG_SIZE_IN_BYTE);
+
+	return 0;
+}
+
 /**
  * sandbox_query_ffa_emul_state() - Inspect the FF-A ABIs
  * @queried_func_id:	The FF-A function to be queried
@@ -653,6 +693,9 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
 	case FFA_SMC_32(FFA_RX_RELEASE):
 		ret = sandbox_ffa_rx_release(emul, args, res);
 		break;
+	case FFA_SMC_32(FFA_MEM_SHARE):
+		ret = sandbox_ffa_memory_share(emul, args, res);
+		break;
 	default:
 		log_err("Undefined FF-A interface (%lx)\n",
 			args->a0);
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
index 44b32a829dd..8d85e660e2b 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -91,6 +91,7 @@ static const struct ffa_bus_ops sandbox_ffa_ops = {
 	.partition_info_get = ffa_get_partitions_info_hdlr,
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
+	.memory_share = ffa_memory_share_hdlr,
 };
 
 static const struct udevice_id sandbox_ffa_id[] = {
-- 
2.25.1

