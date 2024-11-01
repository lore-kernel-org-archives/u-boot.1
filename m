Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E6E6F061
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D3889330;
	Fri,  1 Nov 2024 15:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E236889A2; Fri,  1 Nov 2024 15:20:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9F5F4892E1
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE8641007;
 Fri,  1 Nov 2024 07:21:09 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F1EB3F528;
 Fri,  1 Nov 2024 07:20:39 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 7/8] arm_ffa: sandbox: Add FFA_MEM_RECLAIM emulation
Date: Fri,  1 Nov 2024 14:20:16 +0000
Message-Id: <20241101142017.79311-8-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
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
---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c | 43 ++++++++++++++++++++++
 drivers/firmware/arm-ffa/sandbox_ffa.c     |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index a859d2e26cc..b628e2c5c63 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -604,6 +604,46 @@ feedback:
 	return ret;
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
+	if (pargs->a1 != SANDBOX_MEM_HANDLE ||
+	    pargs->a2 != SANDBOX_MEM_HANDLE) {
+		res->a0 = FFA_SMC_32(FFA_ERROR);
+		res->a2 = -INVALID_PARAMETERS;
+		ret = ffa_to_std_errmap[INVALID_PARAMETERS];
+		goto feedback;
+	}
+
+	res->a0 = FFA_SMC_32(FFA_SUCCESS);
+	res->a2 = 0;
+	ret = 0;
+
+feedback:
+
+	res->a1 = 0;
+	res->a3 = 0;
+
+	/* x4-x7 MBZ */
+	memset(FFA_X4X7_MBZ_REG_START, 0, FFA_X4X7_MBZ_CNT * sizeof(ulong));
+
+	return ret;
+}
+
 /**
  * sandbox_query_ffa_emul_state() - Inspect the FF-A ABIs
  * @queried_func_id:	The FF-A function to be queried
@@ -697,6 +737,9 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
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
index a81455ce5ff..8af9c8ac005 100644
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

