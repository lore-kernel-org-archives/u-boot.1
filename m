Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1506C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C30C8318E;
	Mon, 21 Jul 2025 13:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95453801DD; Mon, 21 Jul 2025 13:18:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6550D8311B
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E14142681;
 Mon, 21 Jul 2025 04:18:32 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CF73F6A8;
 Mon, 21 Jul 2025 04:18:37 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 04/24] arm_ffa: sandbox: Improve the readability of
 clearing the X registers
Date: Mon, 21 Jul 2025 12:17:56 +0100
Message-Id: <20250721111816.62340-5-abdellatif.elkhlifi@arm.com>
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

Make clearing the must be zero registers more readable in the emulator

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 .../sandbox/include/asm/sandbox_arm_ffa_priv.h | 17 +++--------------
 drivers/firmware/arm-ffa/ffa-emul-uclass.c     | 18 +++++++++---------
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
index b0881822d78..8f442145eba 100644
--- a/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
+++ b/arch/sandbox/include/asm/sandbox_arm_ffa_priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -39,19 +39,8 @@
 #define RXTX_BUFFERS_MIN_SIZE (RXTX_4K)
 #define RXTX_BUFFERS_MIN_PAGES (1)
 
-/* MBZ registers info */
-
-/* x1-x7 MBZ */
-#define FFA_X1X7_MBZ_CNT (7)
-#define FFA_X1X7_MBZ_REG_START (&res->a1)
-
-/* x4-x7 MBZ */
-#define FFA_X4X7_MBZ_CNT (4)
-#define FFA_X4X7_MBZ_REG_START (&res->a4)
-
-/* x3-x7 MBZ */
-#define FFA_X3X7_MBZ_CNT (5)
-#define FFA_X3_MBZ_REG_START (&res->a3)
+/* A helper macro used for clearing registers that Must Be Zero (MBZ) */
+#define FFA_X_REG_SIZE_IN_BYTE sizeof((((ffa_value_t *)0)->a0))
 
 /* number of emulated FF-A secure partitions (SPs) */
 #define SANDBOX_PARTITIONS_CNT (4)
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index d2f051f7e2a..dcf5bce9435 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -83,7 +83,7 @@ static int sandbox_ffa_version(struct udevice *emul, ffa_value_t *pargs, ffa_val
 	res->a0 = priv->fwk_version;
 
 	/* x1-x7 MBZ */
-	memset(FFA_X1X7_MBZ_REG_START, 0, FFA_X1X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a1, 0, 7 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int sandbox_ffa_id_get(struct udevice *emul, ffa_value_t *pargs, ffa_valu
 	res->a2 = priv->id;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return 0;
 }
@@ -136,14 +136,14 @@ static int sandbox_ffa_features(ffa_value_t *pargs, ffa_value_t *res)
 		res->a2 = RXTX_BUFFERS_MIN_SIZE;
 		res->a3 = 0;
 		/* x4-x7 MBZ */
-		memset(FFA_X4X7_MBZ_REG_START, 0, FFA_X4X7_MBZ_CNT * sizeof(ulong));
+		memset(&res->a4, 0, 4 * FFA_X_REG_SIZE_IN_BYTE);
 		return 0;
 	}
 
 	res->a0 = FFA_SMC_32(FFA_ERROR);
 	res->a2 = -NOT_SUPPORTED;
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 	log_err("FF-A interface %lx not implemented\n", pargs->a1);
 
 	return ffa_to_std_errmap[NOT_SUPPORTED];
@@ -248,7 +248,7 @@ cleanup:
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -305,7 +305,7 @@ feedback:
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -352,7 +352,7 @@ feedback:
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -388,7 +388,7 @@ static int sandbox_ffa_rx_release(struct udevice *emul, ffa_value_t *pargs, ffa_
 	res->a1 = 0;
 
 	/* x3-x7 MBZ */
-	memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+	memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 	return ret;
 }
@@ -448,7 +448,7 @@ static int sandbox_ffa_msg_send_direct_req(struct udevice *emul,
 		res->a2 = -INVALID_PARAMETERS;
 
 		/* x3-x7 MBZ */
-		memset(FFA_X3_MBZ_REG_START, 0, FFA_X3X7_MBZ_CNT * sizeof(ulong));
+		memset(&res->a3, 0, 5 * FFA_X_REG_SIZE_IN_BYTE);
 
 		return ffa_to_std_errmap[INVALID_PARAMETERS];
 	}
-- 
2.25.1

