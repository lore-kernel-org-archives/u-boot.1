Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C67C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B1382FCA;
	Fri, 11 Jul 2025 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FD8803DF; Fri, 11 Jul 2025 16:49:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 84619803DF
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6338F2247;
 Fri, 11 Jul 2025 07:49:25 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.35.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 390E83F738;
 Fri, 11 Jul 2025 07:49:34 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 03/25] arm_ffa: Add FFA_MEM_RECLAIM support
Date: Fri, 11 Jul 2025 15:48:55 +0100
Message-Id: <20250711144917.1876948-4-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
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

---

Changelog of changes:
===========================

v2:

* As suggested by Heinrich: The ops NULL check removed

v1:

* Add FFA_MEM_RECLAIM support

 doc/arch/arm64.ffa.rst                    |  2 +
 drivers/firmware/arm-ffa/arm-ffa-uclass.c | 73 +++++++++++++++++++++++
 drivers/firmware/arm-ffa/arm-ffa.c        |  1 +
 include/arm_ffa.h                         | 25 +++++++-
 include/arm_ffa_priv.h                    |  3 +-
 5 files changed, 102 insertions(+), 2 deletions(-)

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
index 9af574760d2..b9b66bf68f9 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -109,6 +109,18 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
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
@@ -1114,6 +1126,44 @@ int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *args)
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
@@ -1216,6 +1266,29 @@ int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args)
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
index df904cae412..de36f5647d2 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -85,6 +85,7 @@ static const struct ffa_bus_ops ffa_ops = {
 	.sync_send_receive = ffa_msg_send_direct_req_hdlr,
 	.rxtx_unmap = ffa_unmap_rxtx_buffers_hdlr,
 	.memory_share = ffa_memory_share_hdlr,
+	.memory_reclaim = ffa_memory_reclaim_hdlr,
 };
 
 /* Registering the FF-A driver as an SMCCC feature driver */
diff --git a/include/arm_ffa.h b/include/arm_ffa.h
index b91b0279371..1229e6e3d02 100644
--- a/include/arm_ffa.h
+++ b/include/arm_ffa.h
@@ -147,8 +147,9 @@ struct ffa_mem_ops_args {
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
@@ -161,6 +162,7 @@ struct ffa_bus_ops {
 				 bool is_smc64);
 	int (*rxtx_unmap)(struct udevice *dev);
 	int (*memory_share)(struct udevice *dev, struct ffa_mem_ops_args *args);
+	int (*memory_reclaim)(struct udevice *dev, u64 g_handle, u32 flags);
 };
 
 #define ffa_get_ops(dev)        ((struct ffa_bus_ops *)(dev)->driver->ops)
@@ -280,6 +282,27 @@ int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *args);
  */
 int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args *args);
 
+/**
+ * ffa_memory_reclaim() - FFA_MEM_RECLAIM driver operation
+ * Please see ffa_memory_reclaim_hdlr() description for more details.
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
index a259911d5b9..54196199ce3 100644
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
2.25.1

