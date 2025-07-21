Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00D6C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62C883835;
	Mon, 21 Jul 2025 13:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A654E83829; Mon, 21 Jul 2025 13:19:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8063B83804
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E763294;
 Mon, 21 Jul 2025 04:19:08 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFF543F6A8;
 Mon, 21 Jul 2025 04:19:12 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v3 22/24] fwu_arm_psa: corstone1000: Notify SE Proxy SP on
 ExitBootService()
Date: Mon, 21 Jul 2025 12:18:14 +0100
Message-Id: <20250721111816.62340-23-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
References: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
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

Implement the notification in fwu_notify_exit_boot_services()

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.c | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index 2ccf851e6c5..2532c5f10fa 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -5,6 +5,7 @@
  * Rui Miguel Silva <rui.silva@linaro.org>
  */
 
+#include <arm_ffa.h>
 #include <blk.h>
 #include <cpu_func.h>
 #include <dm.h>
@@ -19,11 +20,28 @@
 #include <dm/platform_data/serial_pl01x.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
+#include <linux/bitfield.h>
 
 #define CORSTONE1000_KERNEL_PARTS 2
 #define CORSTONE1000_KERNEL_PRIMARY "kernel_primary"
 #define CORSTONE1000_KERNEL_SECONDARY "kernel_secondary"
 
+/* The SE Proxy partition ID*/
+#define CORSTONE1000_SEPROXY_PART_ID (0x8002)
+
+/* Update service ID provided by  the SE Proxy SP*/
+#define CORSTONE1000_SEPROXY_UPDATE_SVC_ID (0x4)
+#define PREP_SEPROXY_SVC_ID_MASK GENMASK(31, 16)
+#define PREP_SEPROXY_SVC_ID(x)  (FIELD_PREP(PREP_SEPROXY_SVC_ID_MASK, (x)))
+
+/* Notification event used with SE Proxy SP */
+#define CORSTONE1000_UBOOT_EFI_STARTED_EVT (0x3)
+#define PREP_SEPROXY_EVT_MASK GENMASK(15, 0)
+#define PREP_SEPROXY_EVT(x) (FIELD_PREP(PREP_SEPROXY_EVT_MASK, (x)))
+
+/* Signal that there is no shared memory used when notifying SE Proxy SP */
+#define FFA_MEM_HANDLE_INVALID (0xffffffff)
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 
 /* The total number of upgradable images including the start and end dummy payloads */
@@ -291,3 +309,45 @@ void fwu_plat_get_bootidx(uint *boot_idx)
 				ret);
 	}
 }
+
+/**
+ * fwu_notify_exit_boot_services() - ExitBootService event handler
+ *
+ * Notify SE Proxy SP when reaching ExitBootService().
+ *
+ * Return:
+ *
+ * EFI_SUCCESS on success. Otherwise, failure
+ */
+efi_status_t fwu_notify_exit_boot_services(void)
+{
+	efi_status_t efi_ret = EFI_SUCCESS;
+	int ffa_ret;
+	struct ffa_send_direct_data msg = {0};
+	struct udevice *dev;
+
+	ffa_ret = uclass_first_device_err(UCLASS_FFA, &dev);
+	if (ffa_ret) {
+		log_err("Cannot find FF-A bus device, err (%d)\n", ffa_ret);
+		efi_ret = EFI_DEVICE_ERROR;
+		goto out;
+	}
+
+	msg.data0 = PREP_SEPROXY_SVC_ID(CORSTONE1000_SEPROXY_UPDATE_SVC_ID) |
+					PREP_SEPROXY_EVT(CORSTONE1000_UBOOT_EFI_STARTED_EVT);
+
+	msg.data1 = FFA_MEM_HANDLE_INVALID;
+	msg.data2 = FFA_MEM_HANDLE_INVALID;
+
+	ffa_ret = ffa_sync_send_receive(dev, CORSTONE1000_SEPROXY_PART_ID, &msg, 0);
+	if (ffa_ret) {
+		log_err("Cannot notify SE Proxy SP, err (%d)\n", ffa_ret);
+		efi_ret = EFI_NO_RESPONSE;
+		goto out;
+	}
+
+	log_debug("SE Proxy SP notified\n");
+
+out:
+	return efi_ret;
+}
-- 
2.25.1

