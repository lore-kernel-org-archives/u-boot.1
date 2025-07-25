Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B85DC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFD283A05;
	Fri, 25 Jul 2025 17:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8550A839F0; Fri, 25 Jul 2025 17:50:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6C78E8395B
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F365B1A00;
 Fri, 25 Jul 2025 08:50:28 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.31.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1F6C3F66E;
 Fri, 25 Jul 2025 08:50:34 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v4 07/24] arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
Date: Fri, 25 Jul 2025 16:49:53 +0100
Message-Id: <20250725155010.285831-8-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
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

Add FFA_MEM_RECLAIM support to the FF-A emulator

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c | 42 ++++++++++++++++++++++
 drivers/firmware/arm-ffa/sandbox_ffa.c     |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 4918404fb6d..a630392b6d1 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -603,6 +603,45 @@ static int sandbox_ffa_memory_share(struct udevice *emul, ffa_value_t *pargs,
 	return 0;
 }
 
+/**
+ * sandbox_ffa_memory_reclaim() - Emulated FFA_MEM_RECLAIM handler
+ * @emul: The sandbox FF-A emulator device
+ * @pargs: The SMC call input arguments a0-a7
+ * @res:  The SMC return data
+ *
+ * Emulate FFA_MEM_RECLAIM FF-A function.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int sandbox_ffa_memory_reclaim(struct udevice *emul, ffa_value_t *pargs,
+				      ffa_value_t *res)
+{
+	int ret;
+
+	res->a1 = 0;
+
+	if (pargs->a1 != SANDBOX_MEM_HANDLE ||
+	    pargs->a2 != SANDBOX_MEM_HANDLE) {
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
+	/* x2-x7 MBZ */
+	memset(&res->a2, 0, 6 * FFA_X_REG_SIZE_IN_BYTE);
+
+	return 0;
+}
+
 /**
  * sandbox_query_ffa_emul_state() - Inspect the FF-A ABIs
  * @queried_func_id:	The FF-A function to be queried
@@ -696,6 +735,9 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
 	case FFA_SMC_32(FFA_MEM_SHARE):
 		ret = sandbox_ffa_memory_share(emul, args, res);
 		break;
+	case FFA_SMC_32(FFA_MEM_RECLAIM):
+		ret = sandbox_ffa_memory_reclaim(emul, args, res);
+		break;
 	default:
 		log_err("Undefined FF-A interface (%lx)\n",
 			args->a0);
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
index 8d85e660e2b..54c81d12f92 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -92,6 +92,7 @@ static const struct ffa_bus_ops sandbox_ffa_ops = {
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
 	.memory_share = ffa_memory_share_hdlr,
+	.memory_reclaim = ffa_memory_reclaim_hdlr,
 };
 
 static const struct udevice_id sandbox_ffa_id[] = {
-- 
2.25.1

