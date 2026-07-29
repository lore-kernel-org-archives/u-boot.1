Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B1C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0797C81259;
	Wed, 29 Jul 2026 12:28:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tefzTg6y5SxX; Wed, 29 Jul 2026 12:28:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A7B981221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328102;
	bh=KHypYPDZ2xtSPf9v1iVHBZjogKaljUKweKPu4suH4YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JUBdvZrSeGXEIr6/IIYxPIf6WMX2LN2LQH95PIYIpKq/SEsYANIKFETkn3Rcm5Rp4
	 B5jVQWOyn5mH4obKHtLFzMGCVxd7vv2eRJujNRgk2da6gRDNMugCagdtXsabIDdHHq
	 IEqHXLFRWzB4JSkRUhWgPxPgGEIh5lQHTQ3sRDXP5mXQTVSyubkbNOPTooXsCBhs+f
	 LruyyMuEdO/jvHozVZhUAXksp04Bi6GhjeEoxovaiHml+1dNBVR6e1dEPCMleVwBCO
	 S6QruUF6RavuyXO32p24Zl+TFebgBN88xqQm6ZNQ7/pwPobhb7H4jNO/IlbUbT92eG
	 WYwIjA+YrBU9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A7B981221;
	Wed, 29 Jul 2026 12:28:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13B8C788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 062E940891
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1y6RjQ8NR-x3 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:51:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B72274087A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B72274087A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B72274087A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B2D8498B; Wed, 29 Jul 2026 10:51:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E55D38404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:52 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 074CF169E;
 Wed, 29 Jul 2026 01:51:48 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 949733F66F;
 Wed, 29 Jul 2026 01:51:50 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 05/22] arm-ffa: reuse direct-message helper at boot time
Date: Wed, 29 Jul 2026 09:51:07 +0100
Message-Id: <20260729085124.2618817-6-harsimransingh.tungal@arm.com>
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
 t=1785315112; bh=i4vr1kPtoqYKH+oWpaz9KZyIy94sgeWt09boHOZgaQM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vcrdky4bUjBQg9Xu44aU1FoYYMHlqc37H31cxkrTAJ977h++fwdR4S7nxq/+BOUOr
 M1klnKqtvCQ2kh7H++KyjuJvNIdLFlsOeRAbWOuLYDO5Qi6cdIhj39f27N48pfruhY
 lmj5AMrJAZGlNxItP5KKwnLMyzhOwvWl2t1EjoGo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Vcrdky4b
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="Vcrdky4b"; 
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

The runtime transport adds ffa_invoke_msg_send_direct_req() as the common
implementation for FFA_MSG_SEND_DIRECT_REQ/RESP. Use the same helper from
the boot-time ffa_msg_send_direct_req_hdlr() instead of keeping a second
copy of the direct-message sequence in arm-ffa-uclass.c.

This keeps boot-time and runtime direct-message handling aligned.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 60 ++---------------------
 include/arm_ffa.h                         | 16 ++----
 2 files changed, 7 insertions(+), 69 deletions(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 13e22a1b7f7..668c2156f8b 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -818,16 +818,8 @@ static int ffa_cache_partitions_info(struct udevice *dev)
  * @msg: pointer to the message data preallocated by the client (in/out)
  * @is_smc64: select 64-bit or 32-bit FF-A ABI
  *
- * Implement FFA_MSG_SEND_DIRECT_{REQ,RESP}
- * FF-A functions.
- *
- * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
- * The response from the secure partition is handled by reading the
- * FFA_MSG_SEND_DIRECT_RESP arguments.
- *
- * The maximum size of the data that can be exchanged is 40 bytes which is
- * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
- * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
  *
  * Return:
  *
@@ -836,9 +828,6 @@ static int ffa_cache_partitions_info(struct udevice *dev)
 int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 				 struct ffa_send_direct_data *msg, bool is_smc64)
 {
-	ffa_value_t res = {0};
-	int ffa_errno;
-	u64 req_mode, resp_mode;
 	struct ffa_priv *uc_priv;
 
 	uc_priv = dev_get_uclass_priv(dev);
@@ -847,50 +836,7 @@ int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 	if (!uc_priv->partitions.count || !uc_priv->partitions.descs)
 		return -ENODEV;
 
-	if (is_smc64) {
-		req_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_REQ);
-		resp_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_RESP);
-	} else {
-		req_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_REQ);
-		resp_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_RESP);
-	}
-
-	invoke_ffa_fn((ffa_value_t){
-			.a0 = req_mode,
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->rt.id) |
-				PREP_PART_ENDPOINT_ID(dst_part_id),
-			.a2 = 0,
-			.a3 = msg->data0,
-			.a4 = msg->data1,
-			.a5 = msg->data2,
-			.a6 = msg->data3,
-			.a7 = msg->data4,
-			}, &res);
-
-	while (res.a0 == FFA_SMC_32(FFA_INTERRUPT))
-		invoke_ffa_fn((ffa_value_t){
-			.a0 = FFA_SMC_32(FFA_RUN),
-			.a1 = res.a1,
-			}, &res);
-
-	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
-		/* Message sent with no response */
-		return 0;
-	}
-
-	if (res.a0 == resp_mode) {
-		/* Message sent with response extract the return data */
-		msg->data0 = res.a3;
-		msg->data1 = res.a4;
-		msg->data2 = res.a5;
-		msg->data3 = res.a6;
-		msg->data4 = res.a7;
-
-		return 0;
-	}
-
-	ffa_errno = res.a2;
-	return ffa_to_std_errno(ffa_errno);
+	return ffa_invoke_msg_send_direct_req(uc_priv->rt.id, dst_part_id, msg, is_smc64);
 }
 
 /* FF-A driver operations (used by clients for communicating with FF-A)*/
diff --git a/include/arm_ffa.h b/include/arm_ffa.h
index 2994d8ee3ae..6a03aad81a8 100644
--- a/include/arm_ffa.h
+++ b/include/arm_ffa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -129,21 +129,13 @@ int ffa_sync_send_receive(struct udevice *dev, u16 dst_part_id,
 
 /**
  * ffa_msg_send_direct_req_hdlr() - FFA_MSG_SEND_DIRECT_{REQ,RESP} handler function
- * @dev: The arm_ffa bus device
+ * @dev: The FF-A bus device
  * @dst_part_id: destination partition ID
  * @msg: pointer to the message data preallocated by the client (in/out)
  * @is_smc64: select 64-bit or 32-bit FF-A ABI
  *
- * This function implements FFA_MSG_SEND_DIRECT_{REQ,RESP}
- * FF-A functions.
- *
- * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
- * The response from the secure partition is handled by reading the
- * FFA_MSG_SEND_DIRECT_RESP arguments.
- *
- * The maximum size of the data that can be exchanged is 40 bytes which is
- * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
- * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
  *
  * Return:
  *
-- 
2.34.1

