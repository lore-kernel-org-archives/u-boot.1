Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE78CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2920340726;
	Wed, 14 Oct 2026 20:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPiox7Z4MwZc; Wed, 14 Oct 2026 20:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F4EF40709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008208;
	b=pQJzYIedsOIv6B/ddxD9y/CwFRGlys1Y6UnggYI0BHf62hCkGQVW0hAv7/fzF5Dzp47c
	 6+o/yU+SAgB4n7okDQPZ0FCF9hEXBhWM8tgy2ICKmYweqG7oEOl/R6dCAjv5UC0L6uhTR
	 0JywxOVcmpEplIPh781dQiz7Xjhiy6u8eAWMi4YweKKUzqh+uF6jDi24r7x2eLeSqTU27
	 5SmsFHVdKbT9cR8TqgoRA5jyTiSOLW1IWB4yoXw5rgh/toTjQhbz4d6ZKsjb1dbCjTv6Y
	 lIrHG1O47jNh+PhTvD+JZdzxI58moRdXm5WHJi4RrKwbFsDgkMZOIBPfQRXiAbZ8Jmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JOEooJH6+7iTugN5r5jcjocRaHZTSOs9rSXxABh7KVY=;
	b=kb7OQ3T9u8g1NkGO5gePUfY+DJmi+an+SAKXmAOVHzUS9XETTXaHQoowokH6Mf31tBcr
	 lNLFnONDdPd0DAA4ruKKuZkz00h3m8Yq1gywyKWKk85u9qYRhWXFkO9uZin6bSLnz4que
	 rA8YfimjIDconp2HskM20GG1tW44DODl7t3rp8AnjAysX9PgabvFDtp2AEdo+5g/6j2Kb
	 +CuFe8Mhq+MgbtfRG4KRqWXX29QkMgZy7Wi3V/MGOrMlylu/nw/x7jaCQg3S2qP6Os8fI
	 hUIzCHcOBSCfipNFjqIqtbDGvsh5d6oJJ/M6t/KDroHu7HWvn3YtIB1jKWXMIugu2cQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008208;
	bh=JOEooJH6+7iTugN5r5jcjocRaHZTSOs9rSXxABh7KVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKmeKbpb1QTnkvxjmiJKNd711NMH5B95cgyia+taYy+8UF6WxHNChUkSBv4VEi5Qi
	 2nNQQuMqQADEVgPs8lHSqvw/pgDpLNusYmpxTSI8MY9r4bQFvRKbYf3bFCQRXJsCJZ
	 vUTN5Z80AIO+PJaPSjY03Ro3fC7lcM+jSj9W/Rre+VmlfbpaqNUIq/35sdvmfZ479P
	 BbJmB+sVYY8ma2slD7kUiZONPIKmYnVRMUHnMKUwDZ5mXDOdzJFeooOgsi2eDtzn6h
	 wPxZQLmXxMf5UZI5jhGcRgruXtuFI/M+GiNTXzQ456d0Fm0A9hRhaxD2jntNBKRMmG
	 vW+q6G+lIa2Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F4EF40709;
	Wed, 14 Oct 2026 20:03:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C30471518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C123380FE8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I--D2o5m8qj4 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 915F880FDD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002200;
 b=rlz2Sq0mSkyDF8Vmc/0mdzFis28yb5egKc94d86nuZb8quxKrd35R0oYIgfolDwDGUtv
 NUsp/rXNEcCgm/565se1jiUAtoNrWg8xoeBtipCBBMZinhQ7ORPS667zkrzD6dOcIA6O0
 oJqYS0m8Ajzr4NoAVPe4WoUYWb5j3ki3CodanPG7EUgcfl3iqWuklOvOw9UVoMPhmjXIG
 aMzxEsequbxFZmHpomkJJ1BsAsLH5RxvyRIQ+7jn5gj+5JNMbvohafBzyFWz3L5sHp2e+
 fY2X1HaYtsgN5jMK1eBrQnLdi+aSYTAnMVaw7Pzhj/SgsMZSE9XaBi4A+wqwlv/xJlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002200;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JOEooJH6+7iTugN5r5jcjocRaHZTSOs9rSXxABh7KVY=;
 b=qW/nF1yUXQlJMwpw4eMfpeKA+OxJGT/JGeMLjlhg+GR6vCVkkrdorE4B8uWxN+oFk6mw
 1lcYUg3L4FpE7rX2Y6SWFxNon4NClxWfZtuM/co+zIFhvq1FYt5loIfrZ9RzdTbyMV3a6
 WItG+LQE6ahifITJnzoBdtibmBRYRuMn3/Em4nl7fj7W+4mdegDZK26vTYCcXzDqcHDwH
 FPrBVsJjN4QPpN/TOrDJbGRfWWo/tjbQjy/LaPCicPlHWjNSeeqMJEi/pyvS4xUEwfZjo
 G08jTs22YeMbUnuDaNDY2UIOGahc+fUw241perbMdIwG/VDF9rvekQrWOf7VwclaUBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=LyTgtG+K; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=LyTgtG+K
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 915F880FDD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EEF1153B;
 Wed, 14 Oct 2026 11:23:16 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CD6C3F871;
 Wed, 14 Oct 2026 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002199; bh=34R5lW37FPNwyAHdsem9LQKB8XTy1YEYvFyxnID54WU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LyTgtG+KPCfvsm7Clf9vXwcUyXgF9TNUxM9uZXvXAf/UGN+G2mWLTF3bsK1m7I7pv
 fQTse23uu39PXDfZW55KMIUkcoldQHbZ12QoPrUlplyIv+/hYj5ZIHmJVWiPvEGfY7
 POOBADLRnQVKCkQmU0CZQ6lSkWZNqFFYAJyp1UQI=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 05/22] arm-ffa: reuse direct-message helper at boot time
Date: Wed, 14 Oct 2026 19:22:45 +0100
Message-ID: <c218a395456d157505d91a79871cffb27df16d5c.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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

