Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E402AC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 928BF81104;
	Thu, 17 Sep 2026 17:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbPCJm4zeY1z; Thu, 17 Sep 2026 17:19:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3DCCD81102
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665567;
	b=WaydcatHkEx2oJQP5DPIUhmmuhxibokxgTMfJmVjY00HPQhkY+sEDqQLAJu1DsQltDEs
	 AEVq/nYi8bTSYn7dc9d/pAjT2+4oXIVXRbKg1/htdQfsGYD7ZElC3WCiKIz+mUeWwX7XP
	 b41xEC9xZnucA+ahH52YAfPbf8+lKBDaftLIz79NXyeeAnRUUIBCJ+N3PI+2WrqdogzTB
	 oH5xYx4Qr1v2X6RXpv8FMw5zkg5GToKviqRe/QSO5VvfO3jrhDswUFzTQewzLyiv0C8Z4
	 HiWytxdOIo5ql99nHI2zRw84xT/PaC99IqOtGuh3R01QQ3d9cxRK7gOBw5AQd/xfedQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Cw58CaPN2yoSjb9lERjOF3QrM+GyaoXYNpTpiLrHJ0Y=;
	b=P0eq/cIUbyMBgKsIFBqe8Wj4s9Ef5K+Z5MfZ/6+1zMjpn9EPCoJNRWt7SPTO7rmPdA5M
	 UmFQWZqXOVt+hwN3CGv/FbamKL4fwqu+NAyvtk6hdD5ixLu6bdgOi4hG76UGUF/wk32Zn
	 pjPrphHxp83HulIjYz+APzYhWYNlQJ2D/tH9+ONMplEe2474a1x1zSC5AgH7aQeGyZd6T
	 OKhIZjid3gUSFLTRB7bajfdH6ORE3bXNlGrh2MtI6Q/lFYQEjY7N/pnEP8I30uD5lTTRK
	 WleXz0PcYLoJl2E52n/MVkFiVjDYN1m6vXZsyJbP6VStUI4+ABVA3jmN1xc8FRpNWQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665567;
	bh=Cw58CaPN2yoSjb9lERjOF3QrM+GyaoXYNpTpiLrHJ0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CViuM5BdkbNh0Kf444Cwubr7ec/nwCREMkOir7VyoIwMKn/cIJDTwcYaU7QzBCrGU
	 Rkdt80GqMYg6rPLQAc93omRSzkBrX+m2Xfb5hCFcZaHJAjOzvj25m/vtqXaOkIpQRZ
	 gWzwW9nQ5AGRxx9mfLNShuPj7Wd9UE4tUOG9fIycfyC1gYN6OMyiCv7Eycj54tzts8
	 9qgVoOgr3kDYWkD2MLwkbCJsneAY9iWfnMu5AUCCy97QAeJlM2fFn6PaCZqiTrw1+f
	 ooKh67J5zbvwmGoD19Cf58y+U6twtSCmI34SgNl9WGrWtyDlWL+F15OE4taqsUYPkh
	 FxcjbwSgdufmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DCCD81102;
	Thu, 17 Sep 2026 17:19:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B9337A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95B7040427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qN4gEJp19BsH for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5B71040378
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665521;
 b=WgOHFCYdnVrW+PpyxrRErj3hFvnaXjSnRcH+/ikXKxAiViiB7uGAuH6E514ZkWqNbT1V
 fmC8SneWEJ26K7kihFONhZWmOKlinrPb5ETazqHfrj5laHfbtyuHvxV8TxtAn2AA9cnhb
 FEMPdpXLLIWWQJdnbIU8Ku1S8DCWf0j+ByQuROXhbiWNI/hS1dcrPuT7tAsv1ZhtvlXhl
 LraCjj8J3fIjwpiH9Ba3NsXx6HtGAKQcKPY+UaGO6wFIVe5dNL4C8vbBViVWGX1Sm5icv
 eGpCEX4KqfywmPVYuvnzgfwTqKD6WPjAV3vnitkeT1InL7qKFK4XUeRIyJ0nlCisq6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665521;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Cw58CaPN2yoSjb9lERjOF3QrM+GyaoXYNpTpiLrHJ0Y=;
 b=fVh7jftlnmR35s6GFDCJgaS03w2X5pPxewDwXBkWLpwrSMXn8qbj0TiJYWoDBUmvIrRB
 vLfP5YpNMkREIJVslR7mq61mXOFk04uaXKdlgp4VKnnYuBKUlwopfj6yRKmT6PuCB081i
 JZRcKq2dqQ1uBUCC+SxUH4qyI6BmkJ/6K7QIcaUisAHJhf08yCjvI4HYFa7cVtHqejSH8
 AabBzqDGFjngMQWKp86BLTxx6oM/qMp7FR05Mm3aTE9TONRS0GM6Ck745yPqtaCYYMgtq
 lE5HGCX7A/+EyDQaSixhCev7W83tBMtcxFlXXmlilOixAoSjINZQZQI9x5yfTqdEOaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="YHBRhv/3"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=YHBRhv/3
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B71040378
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C391F02;
 Thu, 17 Sep 2026 10:18:36 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46CF63F7B4;
 Thu, 17 Sep 2026 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665520; bh=q/gMCxky7ne3wbbjNK/MZm3fFmjlWQ2sD4fGLh0nBgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YHBRhv/34ww/VPd/60+yCDDHabPPAv4+qWVoUx3wbpMRpJX/+ugHBGw0hVOY/kZJ4
 p74Lf50dwn+May5I8iuBE6Y+0dAEFsGBSwhHlmtFGDSLivQYY3EBxeYr8igBHiH0pb
 gpbWxdWr18MIsOOh4FlW/+9SS0arth+z5bzQisro=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v6 02/24] arm_ffa: Add FFA_MEM_RECLAIM support
Date: Thu, 17 Sep 2026 18:17:48 +0100
Message-ID: <20260917171810.4122899-3-harsimransingh.tungal@arm.com>
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

Add to the FF-A bus FFA_MEM_RECLAIM ABI

The FFA_MEM_RECLAIM is a memory management ABI described in the FF-A
v1.0 specification [1].

This ABI restores exclusive access to a memory region back to its Owner.

This work is based on the implementation in Linux [2].

[1]: https://developer.arm.com/documentation/den0077/a/?lang=en
[2]: commit cc2195fe536c28e192df5d07e6dd277af36814b4
     File: drivers/firmware/arm_ffa/driver.c

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 doc/arch/arm64.ffa.rst                    |  2 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 73 +++++++++++++++++++++++
 drivers/firmware/arm-ffa/arm-ffa.c        |  1 +
 include/arm_ffa.h                         | 32 +++++++++-
 include/arm_ffa_priv.h                    |  3 +-
 5 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
index 3eec735d741..d2c4fb49f79 100644
--- a/doc/arch/arm64.ffa.rst
+++ b/doc/arch/arm64.ffa.rst
@@ -186,6 +186,7 @@ The following features are provided:
     - FFA_MSG_SEND_DIRECT_REQ
     - FFA_MSG_SEND_DIRECT_RESP
     - FFA_MEM_SHARE
+    - FFA_MEM_RECLAIM
 
 - Support for the 64-bit version of the following ABIs:
 
@@ -205,6 +206,7 @@ The following features are provided:
     - ffa_sync_send_receive
     - ffa_rxtx_unmap
     - ffa_memory_share
+    - ffa_memory_reclaim
 
 - FF-A bus discovery makes sure FF-A framework is responsive and compatible
   with the driver
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index deaff82c61d..b8de85ed984 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -106,6 +106,18 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
 			"DENIED: Memory region ownership, permission, access or attributes error",
 		},
 	},
+	[FFA_ID_TO_ERRMAP_ID(FFA_MEM_RECLAIM)] = {
+		{
+			[ABORTED] =
+			"ABORTED: ABI invocation failure",
+			[INVALID_PARAMETERS] =
+			"INVALID_PARAMETERS: Invalid handle or flags",
+			[NO_MEMORY] =
+			"NO_MEMORY: Failure to create the Owner's mapping",
+			[DENIED] =
+			"DENIED: Memory region state issue",
+		},
+	},
 };
 
 /**
@@ -1111,6 +1123,44 @@ int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(dev, FFA_MEM_SHARE, args);
 }
 
+/**
+ * ffa_memory_reclaim_hdlr() - FFA_MEM_RECLAIM handler function
+ * @dev: The FF-A bus device
+ * @g_handle: The memory region globally unique Handle
+ * @flags: Zero memory and time slicing flags
+ *
+ * Implement FFA_MEM_RECLAIM FF-A function
+ * to restore exclusive access to a memory region back to its Owner.
+ * Note: FFA_MEM_RECLAIM can not be used at EFI runtime because memory that was
+ * lent as per the memory map during boot time can not be reclaimed into the
+ * memory map during runtime.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int ffa_memory_reclaim_hdlr(struct udevice *dev, u64 g_handle, u32 flags)
+{
+	ffa_value_t res;
+	int ffa_errno;
+
+	invoke_ffa_fn((ffa_value_t){
+			.a0 = FFA_SMC_32(FFA_MEM_RECLAIM),
+			.a1 = HANDLE_LOW(g_handle), .a2 = HANDLE_HIGH(g_handle),
+			.a3 = flags,
+			},
+			&res
+	);
+
+	if (res.a0 != FFA_SMC_32(FFA_SUCCESS)) {
+		ffa_errno = res.a2;
+		ffa_print_error_log(FFA_MEM_RECLAIM, ffa_errno);
+		return ffa_to_std_errno(ffa_errno);
+	}
+
+	return 0;
+}
+
 /* FF-A driver operations (used by clients for communicating with FF-A)*/
 
 /**
@@ -1213,6 +1263,29 @@ int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args)
 	return ops->memory_share(dev, args);
 }
 
+/**
+ * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
+ * @dev: The FF-A bus device
+ * @g_handle: The memory region globally unique Handle
+ * @flags: Zero memory and time slicing flags
+ *
+ * Driver operation for FFA_MEM_RECLAIM.
+ * Please see ffa_memory_reclaim_hdlr() description for more details.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int ffa_memory_reclaim(struct udevice *dev, u64 g_handle, u32 flags)
+{
+	struct ffa_bus_ops *ops = ffa_get_ops(dev);
+
+	if (!ops->memory_reclaim)
+		return -ENOSYS;
+
+	return ops->memory_reclaim(dev, g_handle, flags);
+}
+
 /**
  * ffa_do_probe() - probing FF-A framework
  * @dev:	the FF-A bus device (arm_ffa)
diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
index b245c24f27e..a1d4215e7f8 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -82,6 +82,7 @@ static const struct ffa_bus_ops ffa_ops = {
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
 	.memory_share = ffa_memory_share_hdlr,
+	.memory_reclaim = ffa_memory_reclaim_hdlr,
 };
 
 /* Registering the FF-A driver as an SMCCC feature driver */
diff --git a/include/arm_ffa.h b/include/arm_ffa.h
index ed8df747e9c..9ca0f38ef19 100644
--- a/include/arm_ffa.h
+++ b/include/arm_ffa.h
@@ -153,8 +153,9 @@ struct ffa_mem_ops_args {
  * struct ffa_bus_ops - Operations for FF-A
  * @partition_info_get:	callback for the FFA_PARTITION_INFO_GET
  * @sync_send_receive:	callback for the FFA_MSG_SEND_DIRECT_REQ
- * @rxtx_unmap:	callback for the FFA_RXTX_UNMAP
+ * @rxtx_unmap:		callback for the FFA_RXTX_UNMAP
  * @memory_share:	callback for the FFA_MEM_SHARE
+ * @memory_reclaim:	callback for the FFA_MEM_RECLAIM
  *
  * The data structure providing all the operations supported by the driver.
  * This structure is EFI runtime resident.
@@ -167,6 +168,7 @@ struct ffa_bus_ops {
 				 bool is_smc64);
 	int (*rxtx_unmap)(struct udevice *dev);
 	int (*memory_share)(struct udevice *dev, struct ffa_mem_ops_args *args);
+	int (*memory_reclaim)(struct udevice *dev, u64 g_handle, u32 flags);
 };
 
 #define ffa_get_ops(dev)        ((struct ffa_bus_ops *)(dev)->driver->ops)
@@ -290,6 +292,34 @@ int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args);
  */
 int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *args);
 
+/**
+ * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
+ * @dev: The FF-A bus device
+ * @g_handle: The memory region globally unique Handle
+ * @flags: Zero memory and time slicing flags
+ * Implement FFA_MEM_RECLAIM FF-A function
+ *
+ * Please see ffa_memory_reclaim_hdlr() description for more details.
+ *
+ * Return: 0 on success. Otherwise, failure
+ */
+int ffa_memory_reclaim(struct udevice *dev, u64 g_handle, u32 flags);
+
+/**
+ * ffa_memory_reclaim_hdlr() - FFA_MEM_RECLAIM handler function
+ * @dev: The FF-A bus device
+ * @g_handle: The memory region globally unique Handle
+ * @flags: Zero memory and time slicing flags
+ *
+ * Implement FFA_MEM_RECLAIM FF-A function
+ * to restore exclusive access to a memory region back to its Owner.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int ffa_memory_reclaim_hdlr(struct udevice *dev, u64 g_handle, u32 flags);
+
 struct ffa_priv;
 
 /**
diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
index e1dd99e33ed..d22ab5d2c05 100644
--- a/include/arm_ffa_priv.h
+++ b/include/arm_ffa_priv.h
@@ -133,10 +133,11 @@ enum ffa_abis {
 	FFA_MSG_SEND_DIRECT_REQ   = 0x6f,
 	FFA_MSG_SEND_DIRECT_RESP  = 0x70,
 	FFA_MEM_SHARE             = 0x73,
+	FFA_MEM_RECLAIM           = 0x77,
 
 	/* To be updated when adding new FFA IDs */
 	FFA_FIRST_ID              = FFA_ERROR, /* Lowest number ID */
-	FFA_LAST_ID               = FFA_MEM_SHARE, /* Highest number ID */
+	FFA_LAST_ID               = FFA_MEM_RECLAIM, /* Highest number ID */
 };
 
 enum ffa_abi_errcode {
-- 
2.43.0

