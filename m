Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE9FC88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCE1F80F6A;
	Mon, 14 Sep 2026 14:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4TiOvo5B1HpK; Mon, 14 Sep 2026 14:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 016C38062F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395481;
	b=cBpH7rRB5HA2IgqTBpdBGc0V2MOhyTv1K84U7/6EF7RsNTGW+Mp3DZd94MJ+k5IR9234
	 Hj3W/MIH54/foBzEKaevxsIhg09y3C9BxgbhY/qzViLauzOb9ApK3I+XvckcXlpiaSlfn
	 tiMktTrqIzR/JormU2/5V8MHrRQj1u2y3FbeEJldxvSAV8uVpr6SK4XzWEnM370Lb2DV0
	 oUH+k6mlQYbqIDs0s/HxIq8pG1mTwA14TSVukQhEhdUX1rEV/TkL8D3ybjLTqoiVKWjxl
	 lY/BExC7rCbzOdwhUWiuKp8jiIDpNeeF0bhXKTZzipGqCpwOftHDg2BvTLRJiXzZmYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AOuufdglInILqNmqYj4K/Go2t9/GDKYbPnyPlx+SWGk=;
	b=KjQS6hXKJ/koIUUDVLefRdDGbfALShPibbYaSImsMtpPmvyjVAgUF6h79XAXauvD9Js1
	 dKmuzntn5Xo6suG10YE8EE0hxo/vj6kDEMMCS2uRRZgV+/HI81To9eA+XtXAKiBqtdoG6
	 6PUCAGCFVFgmTRGxYOrRTQAHCh9TKemf6999GSnXF8wjCHkQqJ8k7dE1Pu/1w8RenhewW
	 CKJoyXSvPzk0M8eHPCPhR9UqzZn2znIg8aL9YpnO+O42XQENn4NcQeJzdo6xNMFdhHZiq
	 m4UNNwULVqD+CLW7/xMZfnSpNzJjKDwfBuKN6avk0MlSDcFqdJlnZObtW7U68srk30Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395481;
	bh=AOuufdglInILqNmqYj4K/Go2t9/GDKYbPnyPlx+SWGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOgLWBACVKti4UBe5+wUhMw9LiDtyTJgkEUX5DK4BXXjC7Fho77DfyB3jb5AVtKIk
	 B5r1Jm2aGnV5Jw6KBOYcxWrcKTEi3ty3Z1L4aghvfE46gXmXWZxxalJLY6SYIaz3k/
	 J51HerHhC3imXbI0GGJciivAXJU9MS+y2k12Bs/OAsrn3i4zTDy3Jau6vik3+DdGOI
	 i/4ktK9sLJmzsVTPPSc+zOV8zXYb5iOomzEom3BZF0Hy8h3HpfEpVw+kqqvIrTNc+z
	 uIkPOGNNEFFcWiykJjl+L8v/1ueO5cNJFgieH9DzWxPweSTpR7Ajq8Exd840+Usxzr
	 c8+KlUfLlPpbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 016C38062F;
	Mon, 14 Sep 2026 14:18:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA52724D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC0CB60692
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6o3HSsQqgNEF for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D8A28605EF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384216;
 b=UZmgCYrGWq4FK+I/1aI6BUoCwr3mH9S5FNiAxYJ79xOr/hqMjtYT5IVdYPwtnu3UZMwT
 +vqmuw+snYruPNxBOgNdVd/IzPy+a4b32ehPbqdLX5o89EPZeWOlb3eFlIAyUbjG2Nbmo
 nt2ogni8vQuk3Pzpmx395BdvgC/jYAz7MM0d2KHymHDxIszErzVxyn3cx1v9qiIChcDbN
 5RhWBSbViCkG7Hv+ZDsmy+Npppzjz3+Ts1uiiSF1i2w4T8vgW91SNKwfIX0cbmzKP2E7A
 fqAFt16d6xgxSWDa4zwUQ4XMOu8cnhcvZij7rSY6U8ZUiqCRNzqBmgDgB33dQYt70tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384216;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AOuufdglInILqNmqYj4K/Go2t9/GDKYbPnyPlx+SWGk=;
 b=lcXL2+0Krc/t8Vtq0HXNbWUWMSgkvtEYvzZzhvTti6ss1d+ZMw/7VY/MomA8G6QRHLZC
 8yLnLZWM+rgKkOUGOx1xDMPQf7DO06UKIOjiS2iUvRfKq43ye4cHB/c54XEnJoO/x8uYd
 KfekTIvuGjKnsZs2lkmG4/KFD25x7DBlf4dMqW3sUFSZPpjw7ankyRLmMDHdC5dWNoFQT
 SwYO2WmJet8clVeYH7NgU9RK1TphQZ3XruAz06tGK30gwNxk8z8RGtlCMgojexKOHzuMl
 84SVn/Je1X7gPUjjA0LChxWKJhdA/k5NpFuh2CMagtp2rCtJOPfRZpIejLWnBXRMYtw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=F4PSz5hF; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=F4PSz5hF
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8A28605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1F81D13;
 Mon, 14 Sep 2026 04:01:32 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A7D73F86F;
 Mon, 14 Sep 2026 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383695; bh=+W8CmTNCvU/uI+jomqOY9n+f+uOP0qXMR2a9AuqMEZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F4PSz5hFX1nWmz8d4uuSCYvr7bHJPl8lx3DJq8oxljSRpajpCFB+SbgZ65/N+lJ5F
 CUePIeeU/EUkZOZJ7QHWs8fRmUjQRgnqflnePL7BE26PtuAtokR12DnULqTPUw0csm
 6+uShXQtaCYUvO0/szcwbnmhdn9tX3jUEuVn0PcM=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 05/22] arm-ffa: reuse direct-message helper at boot time
Date: Mon, 14 Sep 2026 12:00:49 +0100
Message-Id: <20260914110106.1974894-6-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
2.34.1

