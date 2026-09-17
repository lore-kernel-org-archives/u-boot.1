Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B19CC982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3BDC60B2D;
	Thu, 17 Sep 2026 17:19:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id alS6K36TW-IT; Thu, 17 Sep 2026 17:19:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 436CE60B64
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665565;
	b=XC+U3wslzgIrt7dnz1pbb/TU3J7V8J5HD+9YGNJnpqh3zhY2xpRO6EOCsODes1z5LtGu
	 mvC0PtLZL8KBsJPEDZxd0BAxXRetGL3u70cVE7JH+LIOxeQR9jJpFm/+YM6+LN7ohja1i
	 B42z2eIj+4hub+lPxNABfOENCifIjP5CmntGQf0EUxJKKNGjLTYVhJgLg+EPoHVgUoeYf
	 UlsmvKVRW9HWOMq9moZ+GcR+f6P4ybszucw/3RA6wWHA9MZEarV4cHUs9282Kkd0U5t+2
	 yDIsfNh/UlyXpl1XuIzIQK2L22C6PwCBy5hzDJYhjVfop/KgFx6ANtKwjpV8UK8eRBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F37o0HUTbsmgeZE3dJYLcEbzA04mppcDxGFhvfkBNQs=;
	b=i8Z76uO1Cik1y0aYU+bqHEv3ea8JBECkCs6XC7Av+yEv9PvyAUdTX27IwW1VdRbvV2aT
	 a88vD/twKO+yLKRGXn33+6hKi7uPvQArpOrY8G8/KVNLMvwNAoOq1hGN9AAG0n/EqkZm+
	 cFwSu6JNXtF+qlfwDlqGhQxfkIh5PiGQfNvU02dxX9aAIzMIn9KaCr2g8h66MnItUX4u8
	 o0zRpyNtgJ2oJ/5oDPk1IDPKDP0QAsKpykSbNU54FdCXySmHAX8lOa8oP+9jUjBEkhh6p
	 00ML8P7N3jWRmTh0MnBQyKXKnsb/13tVmPLpS5AovhyyGrFjqOqyFUEn9EoVge9kYJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665565;
	bh=F37o0HUTbsmgeZE3dJYLcEbzA04mppcDxGFhvfkBNQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NxOShALQ6Psvn9w8bYuueBfWL+mRwcPfpRAbRsTc+3erBCQ2GgoFNi5VWGTmul/gQ
	 kdhQcRm84mJrsSbqv635TTnBwGQSfP+C4aDXrS1cHQl38h1Y0d5PLkGCJvbl36ziAQ
	 GasAanXrgwkDM/PbrCqj9DgnSKg0Mm4Gq8+rK0pqxIwEkEvePJr2xZvNSJzB3TEnjo
	 WNQ0S6L18okY3ILBbP3sEtNnBwsMdNQSm194pWOolDgsyQOTxn1El6qxqoYSKhIu46
	 iGyw9d0Q5Qun5Vnwo5gcbC67FhgFg9fenrUJ7E7sk3HjmSU4uvkZX77KCenceeU58K
	 b6Jk1zEDvRCIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 436CE60B64;
	Thu, 17 Sep 2026 17:19:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 295A813D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B3E44044A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ba9zryZKb0pQ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3BF6940427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665520;
 b=dipNClTUzpfyaLhY6Pn61kAVy91nQThibwSYBvEWVDoHPUyRT80KMWE84Nv32Wm67iJW
 HiRbFaJIhEyZ3P0LQMP6SbAqCSRnvJ9AuvbJA/RcuptG0cAo87/I8WVuAm1K1vGFiLtjz
 ZJJbVv99mLcEhvG1cBYQgNUVLaYWy/WqQXJeRombBZI53Y9OdriLt5Vp9qKpqCVYuFnwS
 PcdgPVrD+jrb9+Bmy/dYa2l0hc5yOWuwgkw71pn8L8PXhTQ6VGXTJEkYkg7ME+gwdwCRr
 4yL+OKGbxfpICL7pavTBpsq4lY7yXUCAMGwnMBMny/kxEN/yp0YPVaoJGCGwQQULFog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665520;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=F37o0HUTbsmgeZE3dJYLcEbzA04mppcDxGFhvfkBNQs=;
 b=GwIaBcI/qWz+MTYI27TMNrWFjjPVdMGe3/l4LqGhI1shx1hdVWHqycy8cVo1AVJIO4L6
 PMt4XdBkUy0DO65H09eLqaYSnNcRE6pnJFZLiz6CdaSdiMZfjUoq2iCURuuHIqQ5ZypoD
 yOjb2TRJbQaQSaQhZjhFjvl4/J+Vj0oBu+/dl46lJlPzxK27/MKuReWEkhdHYnvgPXlO4
 AUd+tz9n70RRpm/H/ygfF773aEN4O6IVBEV8iXd8T5bz4BOu8qUE6/OVIt4K7xgB90WQ/
 4xGQnLU5lEZBkja9jyg9nBrIpL4Xx+ohBHTQRJ1+H90KlPQkUgntokOrcRdJ7Flj0kw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=eG5lWh6B; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=eG5lWh6B
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BF6940427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 615FD1596;
 Thu, 17 Sep 2026 10:18:35 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A90F3F7B4;
 Thu, 17 Sep 2026 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665518; bh=dgaU1Fm4k+wcnDIiJ2hG+Jgmh2Anvm1zu4E6fyr8b5E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eG5lWh6BUsGls/6o5N2/U65OCuwwG9v2kekPRYNwwGoYXxacbSCZaDipAeuRCiWxm
 FJSPWEisMD5ew12rSEDvhPGvVezNp6X18Cfn8HRg6qe3ONVS8Cu755VunGetK/3TlK
 53QKebaKfUbgmQ69czy0sq3g+nxckhzjJy9WeQIE=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v6 01/24] arm_ffa: Add FFA_MEM_SHARE support
Date: Thu, 17 Sep 2026 18:17:47 +0100
Message-ID: <20260917171810.4122899-2-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add to the FF-A bus FFA_MEM_SHARE ABI

The FFA_MEM_SHARE is a memory management ABI described in the FF-A v1.0
specification [1].

This ABI starts a transaction to grant access to a memory region
to one or more Borrowers (aka Secure Partitions or endpoints).

This work is based on the implementation in Linux kernel [2].

[1]: https://developer.arm.com/documentation/den0077/a/?lang=en
[2]: commit cc2195fe536c28e192df5d07e6dd277af36814b4
     Files: drivers/firmware/arm_ffa/driver.c , include/linux/arm_ffa.h

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/arch/arm64.ffa.rst                    |   2 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 212 +++++++++++++++++++++-
 drivers/firmware/arm-ffa/arm-ffa.c        |   3 +-
 include/arm_ffa.h                         |  96 +++++++++-
 include/arm_ffa_priv.h                    | 152 +++++++++++++++-
 5 files changed, 460 insertions(+), 5 deletions(-)

diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
index f966f8ba6af..3eec735d741 100644
--- a/doc/arch/arm64.ffa.rst
+++ b/doc/arch/arm64.ffa.rst
@@ -185,6 +185,7 @@ The following features are provided:
     - FFA_INTERRUPT
     - FFA_MSG_SEND_DIRECT_REQ
     - FFA_MSG_SEND_DIRECT_RESP
+    - FFA_MEM_SHARE
 
 - Support for the 64-bit version of the following ABIs:
 
@@ -203,6 +204,7 @@ The following features are provided:
     - ffa_partition_info_get
     - ffa_sync_send_receive
     - ffa_rxtx_unmap
+    - ffa_memory_share
 
 - FF-A bus discovery makes sure FF-A framework is responsive and compatible
   with the driver
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 76a8775e911..deaff82c61d 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -92,6 +92,20 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
 			"DENIED: Buffer pair already registered",
 		},
 	},
+	[FFA_ID_TO_ERRMAP_ID(FFA_MEM_SHARE)] = {
+		{
+			[ABORTED] =
+			"ABORTED: Failure in the transmission of fragments or in time slicing",
+			[INVALID_PARAMETERS] =
+			"INVALID_PARAMETERS: Validation failed for the Memory Transaction or the Endpoint memory access descriptor",
+			[NO_MEMORY] =
+			"NO_MEMORY: Insufficient memory to complete this operation",
+			[BUSY] =
+			"BUSY: The TX buffer is busy",
+			[DENIED] =
+			"DENIED: Memory region ownership, permission, access or attributes error",
+		},
+	},
 };
 
 /**
@@ -926,6 +940,177 @@ int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 	return ffa_to_std_errno(ffa_errno);
 }
 
+/**
+ * ffa_mem_desc_offset() - helper for descriptors offset calculation
+ * @count: An integer defining the number of Endpoint memory access descriptors
+ *
+ * Calculate the offset of the Endpoint memory access descriptor and
+ * the Composite memory region descriptor.
+ *
+ * Return:
+ *
+ * The descriptor offset.
+ */
+static inline u32 ffa_mem_desc_offset(int count)
+{
+	u32 offset = count * sizeof(struct ffa_mem_region_attributes);
+
+	offset += sizeof(struct ffa_mem_region);
+
+	return offset;
+}
+
+/**
+ * ffa_setup_and_transmit() - set up the memory and transmit data using FF-A
+ * @dev: The FF-A bus device
+ * @func_id: An integer identifying the function
+ * @buffer: A pointer to the data to be transmitted (FF-A TX buffer)
+ * @args: A pointer to a structure containing additional user arguments
+ *
+ * Setup the memory transaction related to the access to a specified
+ * memory region.
+ * Currently we support FFA_MEM_SHARE only.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int ffa_setup_and_transmit(struct udevice *dev, u32 func_id,
+				  void *buffer, struct ffa_mem_ops_args *args)
+{
+	ffa_value_t res = {0};
+	int ffa_errno;
+	u32 composite_offset;
+	u32 total_length;
+	struct ffa_mem_region *mem_region = buffer;
+	struct ffa_composite_mem_region *composite;
+	struct ffa_mem_region_addr_range *constituent;
+	struct ffa_mem_region_attributes *ep_mem_access;
+	u32 idx;
+	struct ffa_priv *uc_priv;
+
+	uc_priv = dev_get_uclass_priv(dev);
+
+	mem_region->tag = args->tag;
+	mem_region->flags = args->flags;
+	mem_region->sender_id = uc_priv->id;
+
+	/*
+	 * These attributes are only valid for FFA_MEM_SHARE.
+	 * They are not valid for FFA_MEM_LEND (no implemented).
+	 */
+	if (func_id == FFA_MEM_SHARE)
+		mem_region->attributes = FFA_MEM_NORMAL | FFA_MEM_WRITE_BACK
+				 | FFA_MEM_INNER_SHAREABLE;
+	else
+		mem_region->attributes = 0;
+
+	mem_region->handle = 0;
+	mem_region->ep_count = args->nattrs;
+	mem_region->reserved1 = 0;
+	mem_region->reserved2 = 0;
+
+	ep_mem_access = buffer + ffa_mem_desc_offset(0);
+
+	composite_offset = ffa_mem_desc_offset(args->nattrs);
+
+	/* Multiple borrowers supported */
+	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {
+		ep_mem_access->receiver = args->attrs[idx].receiver;
+		ep_mem_access->attrs = args->attrs[idx].attrs;
+		ep_mem_access->composite_off = composite_offset;
+		ep_mem_access->flag = 0;
+		ep_mem_access->reserved = 0;
+	}
+
+	/* Only one Composite and one Constituent memory region supported */
+	composite = buffer + composite_offset;
+	composite->total_pg_cnt = args->pg_cnt;
+	composite->addr_range_cnt = FFA_MEM_CONSTITUENTS;
+	composite->reserved = 0;
+
+	constituent = &composite->constituents[0];
+	constituent->address = map_to_sysmem(args->address);
+	constituent->pg_cnt = args->pg_cnt;
+	constituent->reserved = 0;
+
+	total_length = composite_offset + sizeof(*composite) +
+		sizeof(*constituent);
+
+	/*
+	 * Note: Time slicing is not supported.
+	 * It's only available to EL1 and S-EL1 endpoints.
+	 */
+
+	invoke_ffa_fn((ffa_value_t){
+			.a0 = FFA_SMC_32(func_id),
+			.a1 = total_length,
+			.a2 = total_length,
+			.a3 = 0, /* the TX buffer is used */
+			.a4 = 0, /* the TX buffer is used */
+			},
+			&res
+	);
+
+	if (res.a0 != FFA_SMC_32(FFA_SUCCESS)) {
+		ffa_errno = res.a2;
+		ffa_print_error_log(func_id, ffa_errno);
+		return ffa_to_std_errno(ffa_errno);
+	}
+
+	args->g_handle = PACK_HANDLE(res.a2, res.a3);
+	return 0;
+}
+
+/**
+ * ffa_memory_ops() - wrapper for the memory management ABIs
+ * @dev: The FF-A bus device
+ * @func_id: An integer identifying the function
+ * @args: A pointer to a structure containing additional user arguments
+ *
+ * Verify the use of the TX buffer then call ffa_setup_and_transmit().
+ * Currently we support FFA_MEM_SHARE only.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+static int ffa_memory_ops(struct udevice *dev, u32 func_id,
+			  struct ffa_mem_ops_args *args)
+{
+	void *buffer;
+	struct ffa_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (!args->use_txbuf) {
+		log_err("only TX buffer supported\n");
+		return -EPROTONOSUPPORT;
+	}
+
+	buffer = uc_priv->pair.txbuf;
+
+	if (!buffer || !args->attrs || !args->address)
+		return -EINVAL;
+
+	return ffa_setup_and_transmit(dev, func_id, buffer, args);
+}
+
+/**
+ * ffa_memory_share_hdlr() - FFA_MEM_SHARE handler function
+ * @dev: The FF-A bus device
+ * @args: A pointer to a structure containing additional user arguments
+ *
+ * Implement FFA_MEM_SHARE FF-A function
+ * to grant access to a memory region to one or more Borrowers.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *args)
+{
+	return ffa_memory_ops(dev, FFA_MEM_SHARE, args);
+}
+
 /* FF-A driver operations (used by clients for communicating with FF-A)*/
 
 /**
@@ -1003,6 +1188,31 @@ int ffa_rxtx_unmap(struct udevice *dev)
 	return ops->rxtx_unmap(dev);
 }
 
+/**
+ * ffa_memory_share() - FFA_MEM_SHARE driver operation
+ * @dev: The FF-A bus device
+ * @args: A pointer to a structure containing additional user arguments
+ *
+ * Driver operation for FFA_MEM_SHARE.
+ * Please see ffa_memory_share_hdlr() description for more details.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args)
+{
+	struct ffa_bus_ops *ops = ffa_get_ops(dev);
+
+	if (!args)
+		return -EINVAL;
+
+	if (!ops->memory_share)
+		return -ENOSYS;
+
+	return ops->memory_share(dev, args);
+}
+
 /**
  * ffa_do_probe() - probing FF-A framework
  * @dev:	the FF-A bus device (arm_ffa)
diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
index 9e6b5dcc542..b245c24f27e 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -81,6 +81,7 @@ static const struct ffa_bus_ops ffa_ops = {
 	.partition_info_get = ffa_get_partitions_info_hdlr,
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
+	.memory_share = ffa_memory_share_hdlr,
 };
 
 /* Registering the FF-A driver as an SMCCC feature driver */
diff --git a/include/arm_ffa.h b/include/arm_ffa.h
index 2994d8ee3ae..ed8df747e9c 100644
--- a/include/arm_ffa.h
+++ b/include/arm_ffa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -81,11 +81,80 @@ struct ffa_send_direct_data {
 
 struct udevice;
 
+/**
+ * struct ffa_mem_region_attributes - Endpoint memory access descriptor
+ * @receiver: The ID of the VM to which the memory is being given or shared
+ * @attrs: Memory region permissions
+ * @flag: Flags for memory regions with multiple borrowers
+ * @composite_off: Offset in bytes
+ * @reserved: Reserved field
+ *
+ * The data structure used in memory management transactions to create an
+ * association between an endpoint, memory access permissions and a composite
+ * memory region description.
+ *
+ * For more details, please refer to Table 5.16 and Table 5.15 in the FF-A
+ * specification v1.0.
+ *
+ * This structure was taken from Linux.
+ */
+struct ffa_mem_region_attributes {
+	/* The ID of the VM to which the memory is being given or shared. */
+	u16 receiver;
+	/*
+	 * The permissions with which the memory region should be mapped in the
+	 * receiver's page table.
+	 */
+#define FFA_MEM_EXEC		BIT(3)
+#define FFA_MEM_NO_EXEC		BIT(2)
+#define FFA_MEM_RW		BIT(1)
+#define FFA_MEM_RO		BIT(0)
+	u8 attrs;
+	/*
+	 * Flags used during FFA_MEM_RETRIEVE_REQ and FFA_MEM_RETRIEVE_RESP
+	 * for memory regions with multiple borrowers.
+	 */
+#define FFA_MEM_RETRIEVE_SELF_BORROWER	BIT(0)
+	u8 flag;
+	/*
+	 * Offset in bytes from the start of the outer `ffa_memory_region` to
+	 * an `struct ffa_mem_region_addr_range`.
+	 */
+	u32 composite_off;
+	u64 reserved;
+};
+
+/**
+ * struct ffa_mem_ops_args - User arguments to the memory management ABIs
+ * @use_txbuf:	Whether to use the TX buffer for the memory transaction
+ * @nattrs:	Number of the borrowers
+ * @flags:	Memory transaction flags
+ * @tag:	The tag associated with the transaction
+ * @g_handle:	Globally unique Handle to identify the memory region (out)
+ * @address:	Virtual address of the memory region
+ * @pg_cnt:	Number of pages
+ * @attrs:	Memory access permissions of each borrower
+ *
+ * The structured filled by the user and passed to the memory
+ * management ABIs (e.g: FFA_MEM_SHARE)
+ */
+struct ffa_mem_ops_args {
+	bool use_txbuf;
+	u32 nattrs;
+	u32 flags;
+	u64 tag;
+	u64 g_handle;
+	void *address;
+	u32 pg_cnt;
+	struct ffa_mem_region_attributes *attrs;
+};
+
 /**
  * struct ffa_bus_ops - Operations for FF-A
  * @partition_info_get:	callback for the FFA_PARTITION_INFO_GET
  * @sync_send_receive:	callback for the FFA_MSG_SEND_DIRECT_REQ
  * @rxtx_unmap:	callback for the FFA_RXTX_UNMAP
+ * @memory_share:	callback for the FFA_MEM_SHARE
  *
  * The data structure providing all the operations supported by the driver.
  * This structure is EFI runtime resident.
@@ -97,6 +166,7 @@ struct ffa_bus_ops {
 				 struct ffa_send_direct_data *msg,
 				 bool is_smc64);
 	int (*rxtx_unmap)(struct udevice *dev);
+	int (*memory_share)(struct udevice *dev, struct ffa_mem_ops_args *args);
 };
 
 #define ffa_get_ops(dev)        ((struct ffa_bus_ops *)(dev)->driver->ops)
@@ -196,6 +266,30 @@ int ffa_partition_info_get(struct udevice *dev, const char *uuid_str,
 int ffa_get_partitions_info_hdlr(struct udevice *dev, const char *uuid_str,
 				 u32 *sp_count, struct ffa_partition_desc **sp_descs);
 
+/**
+ * ffa_memory_share() - FFA_MEM_SHARE driver operation
+ * @dev: The FF-A bus device
+ * @args: A pointer to a structure containing additional user arguments
+ * Please see ffa_memory_share_hdlr() description for more details.
+ *
+ * Return: 0 on success. Otherwise, failure
+ */
+int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args);
+
+/**
+ * ffa_memory_share_hdlr() - FFA_MEM_SHARE handler function
+ * @dev: The FF-A bus device
+ * @args: A pointer to a structure containing additional user arguments
+ *
+ * Implement FFA_MEM_SHARE FF-A function
+ * to grant access to a memory region to one or more Borrowers.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *args);
+
 struct ffa_priv;
 
 /**
diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
index d564c33c647..e1dd99e33ed 100644
--- a/include/arm_ffa_priv.h
+++ b/include/arm_ffa_priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -132,10 +132,11 @@ enum ffa_abis {
 	FFA_RUN                   = 0x6d,
 	FFA_MSG_SEND_DIRECT_REQ   = 0x6f,
 	FFA_MSG_SEND_DIRECT_RESP  = 0x70,
+	FFA_MEM_SHARE             = 0x73,
 
 	/* To be updated when adding new FFA IDs */
 	FFA_FIRST_ID              = FFA_ERROR, /* Lowest number ID */
-	FFA_LAST_ID               = FFA_MSG_SEND_DIRECT_RESP, /* Highest number ID */
+	FFA_LAST_ID               = FFA_MEM_SHARE, /* Highest number ID */
 };
 
 enum ffa_abi_errcode {
@@ -219,6 +220,153 @@ struct ffa_priv {
 	struct ffa_rxtxpair pair;
 };
 
+/* FF-A memory management ABIs data structures */
+
+/**
+ * struct ffa_mem_region - Lend, donate or share memory transaction descriptor
+ * @sender_id: The ID of the VM/owner
+ * @attributes: Memory region attributes
+ * @reserved1: Reserved
+ * @flags: Flags to control behaviour of the transaction
+ * @handle: A globally-unique ID
+ * @tag: An implementation defined value associated with the receiver
+ *       and the memory region
+ * @reserved2: Reserved
+ * @ep_count: The number of `ffa_mem_region_attributes` entries
+ *
+ * Specifies the data structure that must be used by the Owner/Lender and a
+ * Borrower/Receiver in a transaction to donate, lend or share a memory region.
+ * It specifies the memory region description, properties and other transaction
+ * attributes in an invocation of the following ABIs.
+ * FFA_MEM_DONATE.
+ * FFA_MEM_LEND.
+ * FFA_MEM_SHARE.
+ * FFA_MEM_RETRIEVE_REQ.
+ * FFA_MEM_RETRIEVE_RESP.
+ * For more details, please refer to the Table 5.19 in the FF-A specification
+ * v1.0.
+ * The interpretation of some fields depends on the ABI this structure is used
+ * with. This variance in behavior is also specified in the Table 5.19.
+ * This structure was taken from Linux and adapted to FF-A v1.0.
+ */
+struct ffa_mem_region {
+	/* The ID of the VM/owner which originally sent the memory region */
+	u16 sender_id;
+#define FFA_MEM_NORMAL		BIT(5)
+#define FFA_MEM_DEVICE		BIT(4)
+
+#define FFA_MEM_WRITE_BACK	(3 << 2)
+#define FFA_MEM_NON_CACHEABLE	BIT(2)
+
+#define FFA_DEV_nGnRnE		(0 << 2)
+#define FFA_DEV_nGnRE		BIT(2)
+#define FFA_DEV_nGRE		(2 << 2)
+#define FFA_DEV_GRE		(3 << 2)
+
+#define FFA_MEM_NON_SHAREABLE	(0)
+#define FFA_MEM_OUTER_SHAREABLE	(2)
+#define FFA_MEM_INNER_SHAREABLE	(3)
+	/* Memory region attributes */
+	u8 attributes;
+
+	u8 reserved1;
+
+/*
+ * Clear memory region contents after unmapping it from the sender and
+ * before mapping it for any receiver.
+ */
+#define FFA_MEM_CLEAR			BIT(0)
+/*
+ * Whether the hypervisor may time slice the memory sharing or retrieval
+ * operation.
+ */
+#define FFA_TIME_SLICE_ENABLE		BIT(1)
+
+#define FFA_MEM_RETRIEVE_TYPE_IN_RESP	(0 << 3)
+#define FFA_MEM_RETRIEVE_TYPE_SHARE	BIT(3)
+#define FFA_MEM_RETRIEVE_TYPE_LEND	(2 << 3)
+#define FFA_MEM_RETRIEVE_TYPE_DONATE	(3 << 3)
+
+#define FFA_MEM_RETRIEVE_ADDR_ALIGN_HINT	BIT(9)
+#define FFA_MEM_RETRIEVE_ADDR_ALIGN(x)		((x) << 5)
+	/* Flags to control behaviour of the transaction. */
+	u32 flags;
+#define HANDLE_LOW_MASK		GENMASK_ULL(31, 0)
+#define HANDLE_HIGH_MASK	GENMASK_ULL(63, 32)
+#define HANDLE_LOW(x)		((u32)(FIELD_GET(HANDLE_LOW_MASK, (x))))
+#define	HANDLE_HIGH(x)		((u32)(FIELD_GET(HANDLE_HIGH_MASK, (x))))
+
+#define PACK_HANDLE(l, h)		\
+	(FIELD_PREP(HANDLE_LOW_MASK, (l)) | FIELD_PREP(HANDLE_HIGH_MASK, (h)))
+	/*
+	 * A globally-unique ID assigned by the hypervisor for a region
+	 * of memory being sent between VMs.
+	 */
+	u64 handle;
+	/*
+	 * An implementation defined value associated with the receiver and the
+	 * memory region.
+	 */
+	u64 tag;
+
+	u32 reserved2;
+
+	/*
+	 * The number of `ffa_mem_region_attributes` entries included in this
+	 * transaction.
+	 */
+	u32 ep_count;
+};
+
+/**
+ * struct ffa_mem_region_addr_range - Constituent memory region descriptor
+ * @address: The base IPA of the constituent memory region
+ * @pg_cnt: The number of 4 kiB pages
+ * @reserved: Reserved
+ *
+ * Each descriptor specifies the base address and size of a virtually or
+ * physically contiguous memory region.
+ * For more details, please refer to Table 5.14 in the FF-A
+ * specification v1.0.
+ * This structure was taken from Linux.
+ */
+struct ffa_mem_region_addr_range {
+	/* The base IPA of the constituent memory region, aligned to 4 kiB */
+	u64 address;
+	/* The number of 4 kiB pages in the constituent memory region. */
+	u32 pg_cnt;
+	u32 reserved;
+};
+
+/**
+ * struct ffa_composite_mem_region - Composite memory region descriptor
+ * @total_pg_cnt: The total number of 4 kiB pages included in this memory region
+ * @addr_range_cnt: The number of constituents included
+ * @reserved: Reserved
+ * @constituents: An array of `addr_range_cnt` memory region constituents
+ *
+ * For more details, please refer to Table 5.13 in the FF-A
+ * specification v1.0.
+ *
+ * This structure was taken from Linux.
+ */
+struct ffa_composite_mem_region {
+	/*
+	 * The total number of 4 kiB pages included in this memory region. This
+	 * must be equal to the sum of page counts specified in each
+	 * `struct ffa_mem_region_addr_range`.
+	 */
+	u32 total_pg_cnt;
+	/* The number of constituents included in this memory region range */
+#define FFA_MEM_CONSTITUENTS		(1)
+	u32 addr_range_cnt;
+	u64 reserved;
+	/** An array of `addr_range_cnt` memory region constituents. */
+	struct ffa_mem_region_addr_range constituents[];
+};
+
+/* Functions prototypes */
+
 /**
  * ffa_get_version_hdlr() - FFA_VERSION handler function
  * @dev: The FF-A bus device
-- 
2.43.0

