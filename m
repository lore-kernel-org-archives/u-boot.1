Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D9606A7D6
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J5tPr0ZX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sV3K9C+X
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 372C28134F;
	Tue, 10 Nov 2026 13:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53k6024Dzok5; Tue, 10 Nov 2026 13:06:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A74D5814A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315983;
	b=oj3L/WtUnQbKc/ui5wO+s70Qybp7l3fvYLQIm8GJRbDQuJjfTmcJ6WjtPMKlJpcqCSdM
	 nFqNdn01sjsAzc8NtgqVuOr8Hd1956QGYYNp20gsKBTXnCe/ZmDatBgTPfs5f+ZvDAtzx
	 QfYmezVMTQrvsMMPoupH9xCMQs+6Bl08THdlcTV/y1XQQRx2jwpp+GT4r5I3rdZV1TOi8
	 jqxeDn4HMfXFdjyajmjWToZomeiVi6IN2cAhJDL7jhLEr8AGSOVlNjGdb3QYRB7rtx6Rk
	 jigurS7sRZrEhIFH4uuA9ILwh+5Re1CozdYjVMb16vDjTsdToUDw91tLdNMtNzWpXpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JOEooJH6+7iTugN5r5jcjocRaHZTSOs9rSXxABh7KVY=;
	b=cnrZU9+CIaxap1b74B79DUXlOxuX2hVIn6wE5I0r25R2JJAuzrzV8gAwmK2FH7tg4Rtn
	 /2MzO9fuo6qkFE7PbuuUrjEZDjwsXzjQvPjk0QWy8igk6wRqgi1b9xdYScpPhv7CqR86/
	 OZLzu7IKL/Q41aeB6HJcFylIuunUR5kfG1FUn8Dkc6El+bAfK4PNhIdkHFH++zZL3S8jM
	 4gZMUewHbWr6+B9WtSaSvmpM/gPdjyEd7CYkxpTFxSsWS4xIVTdexXRDzWWyT/JorIRvF
	 v64BRuzwrhLXvvwVf8QGWqFp/kFFW6B6TvBKL6WDssFIkNZxookeGWjouWf98KjQRcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315983;
	bh=JOEooJH6+7iTugN5r5jcjocRaHZTSOs9rSXxABh7KVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5tPr0ZXSEpujUj3tvbEq/ywmRUWoZRIkrHqT+Yw8qur5e3MtoU+FGLykHGBieTjg
	 5PLlng4u37x9uoQxGR4MRx9FOEgjkVZmaTHQlaqTt5NLhpoq9ivUSHItoOIMg9uGnB
	 2dMhO4xZHD6TseECmjpleYqeWLYkzZuxZP6Qhin/RxshrPM080Qw7Zfp7SYOJJgL8v
	 D2WAyS1WBa4hVl9Y6hGOIEjSb4FbIx3HRzxpPiPhyraLqoa/W0KB082dH7Hk92XZAZ
	 rrZ5DJEcPQvrJFtITObBneJx37WRiU5YbZ70j/7oEK6XLWU/fIrhtKkqZQBhFu9Mvy
	 7WF6nZpYG3bNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A74D5814A0;
	Tue, 10 Nov 2026 13:06:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55C89F15
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF1E16081E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bnBw-lfgS_I2 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9ABC6086F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=sV3K9C+X
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9ABC6086F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91BC61516;
 Tue, 10 Nov 2026 01:58:16 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743063F632;
 Tue, 10 Nov 2026 01:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304699; bh=34R5lW37FPNwyAHdsem9LQKB8XTy1YEYvFyxnID54WU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sV3K9C+Xg7FhL9XZJy1NvgBtaoz7lQX/Jfd3jVF9xJxSk+f41ef+6PRcC2l5XFwSp
 lN+ACHqnhqWKXEsD5xZguPOrZPhsNhJ8JCn1yDd5VOFHpxCKvkWllLF6TAwbWO7u8p
 UtsPvA8JI82BUAH6sL1GQZZO4papKw63g3hs+3ZU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 05/22] arm-ffa: reuse direct-message helper at boot time
Date: Tue, 10 Nov 2026 09:57:46 +0000
Message-ID: <874a1eeaefa77e5761f247c8af94d7fff7e94f6a.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The runtime transport adds ffa_invoke_msg_send_direct_req() as the common
implementation for FFA_MSG_SEND_DIRECT_REQ/RESP. Use the same helper from
the boot-time ffa_msg_send_direct_req_hdlr() instead of keeping a second
copy of the direct-message sequence in arm-ffa-uclass.c.

This keeps boot-time and runtime direct-message handling aligned.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

Simon:

- Fix commit message styling
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
2.43.0

