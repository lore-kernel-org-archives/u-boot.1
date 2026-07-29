Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A07C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF06181204;
	Wed, 29 Jul 2026 12:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAOTGZhGxLJ5; Wed, 29 Jul 2026 12:28:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A762811BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328097;
	bh=6IdFlk80W68Om9bKdr5/1riIG/Fd3UzNTNeZ9XjovaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZYM2loCKhA3wvWUEqc6LhAcGTDIYrzG+6CvFF+QIF7DetO0fsTxrU656DDSn3dpAs
	 rzxvkhsXoTLNrjLq0FhrthMPqd7OTrUHyPm2JjeWTABp+EF01SKqSzEe5/EWa9KurF
	 KWJHYKrbSHIGFCYz+qNcKmxI5RnYh7GKDbmztqseqKJ+7vyiQEfIToNskK+eH4OMgM
	 xC3hAd/vIUYIArLSR8V+0kV3lPr8Od1D4fQnhe7XAeIZrDF/bqex2nQcyAExiN2Ub0
	 rjJy7Uq6Pbcq1Jd9saSqoQ6Kjp+jeFbKHDN8wHyzUKT5Ayoku8txwee1t/xMBjslS0
	 QFlaYG95OwokA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A762811BD;
	Wed, 29 Jul 2026 12:28:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98AF33B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EADD4004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7Fv-492OITe for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:51:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AE2534009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE2534009C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE2534009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA0A849BC; Wed, 29 Jul 2026 10:51:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CE91F8493F
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A346169C;
 Wed, 29 Jul 2026 01:51:42 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752193F66F;
 Wed, 29 Jul 2026 01:51:44 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 02/22] arm-ffa: store boot-discovered runtime data
 separately
Date: Wed, 29 Jul 2026 09:51:04 +0100
Message-Id: <20260729085124.2618817-3-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315106; bh=PVQhgQNKu3ossKQrQP56LdchsNYBLhZ3hc2TeyRK2Es=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ada/qAulTcIKwlFeqiqO3AAMs9RG+rxbUKhxXTqfLhwqy9dwmVfnSmbih5XpTmMFL
 3rZ3fVYhM707ludmr8CyZCi3+5X/Lu8YxISYEqRHnhmecKP/3uSb7g7VfzVL1D5gSh
 6ETQnMg3+L0oC9n4x5cLzD6GAOAV4ssZvh5EYhd4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Ada/qAul
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="Ada/qAul"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The FF-A runtime transport needs the framework version and U-Boot
endpoint ID after ExitBootServices(). Keep these fields in a dedicated
runtime sub-structure inside struct ffa_priv so they can be copied into
resident storage later.

Update existing users to access the values through uc_priv->rt. This
does not enable runtime behaviour yet.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 12 ++++++------
 include/arm_ffa_priv.h                    | 22 +++++++++++++++++-----
 test/dm/ffa.c                             |  6 +++---
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 76a8775e911..eb159dbfade 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -204,7 +204,7 @@ int ffa_get_version_hdlr(struct udevice *dev)
 		if (dev) {
 			uc_priv = dev_get_uclass_priv(dev);
 			if (uc_priv)
-				uc_priv->fwk_version = res.a0;
+				uc_priv->rt.fwk_version = res.a0;
 		}
 
 		return 0;
@@ -238,8 +238,8 @@ static int ffa_get_endpoint_id(struct udevice *dev)
 			}, &res);
 
 	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
-		uc_priv->id = GET_SELF_ENDPOINT_ID((u32)res.a2);
-		log_debug("FF-A endpoint ID is %u\n", uc_priv->id);
+		uc_priv->rt.id = GET_SELF_ENDPOINT_ID((u32)res.a2);
+		log_debug("FF-A endpoint ID is %u\n", uc_priv->rt.id);
 
 		return 0;
 	}
@@ -461,7 +461,7 @@ int ffa_unmap_rxtx_buffers_hdlr(struct udevice *dev)
 
 	invoke_ffa_fn((ffa_value_t){
 			.a0 = FFA_SMC_32(FFA_RXTX_UNMAP),
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->id),
+			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->rt.id),
 			}, &res);
 
 	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
@@ -890,7 +890,7 @@ int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 
 	invoke_ffa_fn((ffa_value_t){
 			.a0 = req_mode,
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->id) |
+			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->rt.id) |
 				PREP_PART_ENDPOINT_ID(dst_part_id),
 			.a2 = 0,
 			.a3 = msg->data0,
diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
index d564c33c647..3c74c63dfa6 100644
--- a/include/arm_ffa_priv.h
+++ b/include/arm_ffa_priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -200,11 +200,24 @@ struct ffa_partitions {
 };
 
 /**
- * struct ffa_priv - the driver private data structure
+ * struct ffa_priv_runtime - the driver's private runtime data structure
  *
  * @fwk_version:	FF-A framework version
- * @emul:	FF-A sandbox emulator
  * @id:	u-boot endpoint ID
+ *
+ * The device private runtime data structure containing all the
+ * data read from secure world.
+ */
+struct ffa_priv_runtime {
+	u32 fwk_version;
+	u16 id;
+};
+
+/**
+ * struct ffa_priv - the driver private data structure
+ *
+ * @rt:		Runtime data captured at boot time
+ * @emul:	FF-A sandbox emulator
  * @partitions:	The partitions descriptors structure
  * @pair:	The RX/TX buffers pair
  *
@@ -212,9 +225,8 @@ struct ffa_partitions {
  * data read from secure world.
  */
 struct ffa_priv {
-	u32 fwk_version;
+	struct ffa_priv_runtime rt;
 	struct udevice *emul;
-	u16 id;
 	struct ffa_partitions partitions;
 	struct ffa_rxtxpair pair;
 };
diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 593b7177fce..a0c95e62607 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -2,7 +2,7 @@
 /*
  * Functional tests for UCLASS_FFA  class
  *
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -26,14 +26,14 @@ static int check_fwk_version(struct ffa_priv *uc_priv, struct unit_test_state *u
 	func_data.data0 = &fwk_version;
 	func_data.data0_size = sizeof(fwk_version);
 	ut_assertok(sandbox_query_ffa_emul_state(FFA_VERSION, &func_data));
-	ut_asserteq(uc_priv->fwk_version, fwk_version);
+	ut_asserteq(uc_priv->rt.fwk_version, fwk_version);
 
 	return 0;
 }
 
 static int check_endpoint_id(struct ffa_priv *uc_priv, struct unit_test_state *uts)
 {
-	ut_asserteq(0, uc_priv->id);
+	ut_asserteq(0, uc_priv->rt.id);
 
 	return 0;
 }
-- 
2.34.1

