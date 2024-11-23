Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DBDE66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DAD89152;
	Sat, 23 Nov 2024 22:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4GcUTTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6F7891B4; Sat, 23 Nov 2024 22:44:11 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058F588E96
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8EEBFA406DD;
 Sat, 23 Nov 2024 21:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0DA1C4CED3;
 Sat, 23 Nov 2024 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732398247;
 bh=w+URat6mv2Wfw1FbZT6WtxcRRu2A725jgcsMlRqRNlM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=L4GcUTTs+TnNwUwFteVRWgxE+boiacHpGNWmLlm7ysApAhlSrvNPkVA75bJKw5Xv9
 zOO1l/yPOQCKvgGp7oke99QJZK0nI9U1UAcyos3gxJ2SdFV7mNpIFDSHqP+M1uu+eb
 0hgr2XBGMJHzco0RTHadEmxjn6/rz/IPEaN+g1JrcfNVRwHIQ8WSVQLQIkZbyiWkze
 HSf0e3MBajAyrnB32v+vC8vTLTiZVgwHro1cO9VSBebwmNAhBLs0MMfAyu23YAz+am
 /sadAcW2tMBiaeIGd47h0ur0U6N5EkwThSmlI7aL0VQU0W7rvQl0GRrj3eq0YSx4f7
 McBKqz6Qnq6ZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DEE27E6688A;
 Sat, 23 Nov 2024 21:44:06 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 23 Nov 2024 22:44:05 +0100
Subject: [PATCH v2 2/2] dm: Add dm_remove_devices_active() for ordered
 device removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-iommu_apple_dart_ordering-v2-2-cc2ade6dde97@jannau.net>
References: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
In-Reply-To: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7254; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=QcYJlWjwyZlAvEnqZhxdvFJDLc5r4DFp/A6k/T2l2ew=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQnn6X/0/dva+O0mN74R6NBpjWW33mrooV4GsN8q4YXZ
 337/k/sKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJHLogz/U7c2xx7d3GSlbTJh
 0dXpujEzF/BYS20REJoTyrF0geXdGwx/uO9t1Oy6Z//WfaPan4MLE7ImtKWc4e3gEU7LXHv2wrs
 vvAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

This replaces dm_remove_devices_flags() calls in all boot
implementations to ensure non vital devices are consistently removed
first. All boot implementation except arch/arm/lib/bootm.c currently
just call dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL). This can result
in crashes when dependencies between devices exists. The driver model's
design document describes DM_FLAG_VITAL as "indicates that the device is
'vital' to the operation of other devices". Device removal at boot
should follow this.

Instead of adding dm_remove_devices_flags() with (DM_REMOVE_ACTIVE_ALL |
DM_REMOVE_NON_VITAL) everywhere add dm_remove_devices_active() which
does this.

Fixes a NULL pointer deref in the apple dart IOMMU driver during EFI
boot. The xhci-pci (driver which depends on the IOMMU to work) removes
its mapping on removal. This explodes when the IOMMU device was removed
first.

dm_remove_devices_flags() is kept since it is used for testing of
device_remove() calls in dm.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/lib/bootm.c          |  7 +++---
 arch/riscv/lib/bootm.c        |  2 +-
 arch/x86/lib/bootm.c          |  2 +-
 drivers/core/root.c           |  7 ++++++
 include/dm/root.h             | 10 +++++++++
 lib/efi_loader/efi_boottime.c |  2 +-
 test/dm/core.c                | 50 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 192c120a7d2ebe8a2c57f92b424c1699fd8e0e35..974cbfe8400eafb180e99039b4f1a61d52c898b8 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -73,11 +73,10 @@ static void announce_and_cleanup(int fake)
 	 * Call remove function of all devices with a removal flag set.
 	 * This may be useful for last-stage operations, like cancelling
 	 * of DMA operation or releasing device internal buffers.
+	 * dm_remove_devices_active() ensures that vital devices are removed in
+	 * a second round.
 	 */
-	dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
-
-	/* Remove all active vital devices next */
-	dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
+	dm_remove_devices_active();
 
 	cleanup_before_linux();
 }
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 82502972eec5148b8a36b45eef412a3ec2adb48c..76c610bcee03034cb34d850dbbdbe83cfd75cbd3 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -57,7 +57,7 @@ static void announce_and_cleanup(int fake)
 	 * This may be useful for last-stage operations, like cancelling
 	 * of DMA operation or releasing device internal buffers.
 	 */
-	dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
+	dm_remove_devices_active();
 
 	cleanup_before_linux();
 }
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 55f581836dfa6ea76f2b6ba63709544757d3bd52..0f79a5d54959fd50ffaadfefb3f7fedb841699c9 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -49,7 +49,7 @@ void bootm_announce_and_cleanup(void)
 	 * This may be useful for last-stage operations, like cancelling
 	 * of DMA operation or releasing device internal buffers.
 	 */
-	dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
+	dm_remove_devices_active();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 7a714f5478a9f3953b33de0e0ca78fe95db569f3..c7fb58285ca21ecb8c659ec9f3c203819056abec 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -147,6 +147,13 @@ int dm_remove_devices_flags(uint flags)
 
 	return 0;
 }
+
+void dm_remove_devices_active(void)
+{
+	/* Remove non-vital devices first */
+	device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
+	device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL);
+}
 #endif
 
 int dm_scan_plat(bool pre_reloc_only)
diff --git a/include/dm/root.h b/include/dm/root.h
index b2f30a842f515d70982ec8af7599a86d12002176..5651b868c8b88267d0b7fd7564d53fb519140b76 100644
--- a/include/dm/root.h
+++ b/include/dm/root.h
@@ -167,8 +167,18 @@ int dm_uninit(void);
  * Return: 0 if OK, -ve on error
  */
 int dm_remove_devices_flags(uint flags);
+
+/**
+ * dm_remove_devices_active - Call remove function of all active drivers heeding
+ *                            device dependencies as far as know, i.e. removing
+ *                            devices marked with DM_FLAG_VITAL last.
+ *
+ * All active devices will be removed
+ */
+void dm_remove_devices_active(void);
 #else
 static inline int dm_remove_devices_flags(uint flags) { return 0; }
+static inline void dm_remove_devices_active(void) { }
 #endif
 
 /**
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 4f52284b4c653c252b0ed6c0c87da8901448d4b4..080e7f78ae37a45d1e83566806b1fe2582160f2c 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2234,7 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 		if (IS_ENABLED(CONFIG_USB_DEVICE))
 			udc_disconnect();
 		board_quiesce_devices();
-		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
+		dm_remove_devices_active();
 	}
 
 	/* Patch out unsupported runtime function */
diff --git a/test/dm/core.c b/test/dm/core.c
index 7371d3ff42695b4eabaf8ff4b31e4197b3a0c8f8..c59ffc6f61126cad3f7b22b5bd66a5126824be8e 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -999,6 +999,56 @@ static int dm_test_remove_vital(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_remove_vital, 0);
 
+/* Test removal of 'active' devices */
+static int dm_test_remove_active(struct unit_test_state *uts)
+{
+	struct udevice *normal, *dma, *vital, *dma_vital;
+
+	/* Skip the behaviour in test_post_probe() */
+	uts->skip_post_probe = 1;
+
+	ut_assertok(device_bind_by_name(uts->root, false, &driver_info_manual,
+					&normal));
+	ut_assertnonnull(normal);
+
+	ut_assertok(device_bind_by_name(uts->root, false, &driver_info_act_dma,
+					&dma));
+	ut_assertnonnull(dma);
+
+	ut_assertok(device_bind_by_name(uts->root, false,
+					&driver_info_vital_clk, &vital));
+	ut_assertnonnull(vital);
+
+	ut_assertok(device_bind_by_name(uts->root, false,
+					&driver_info_act_dma_vital_clk,
+					&dma_vital));
+	ut_assertnonnull(dma_vital);
+
+	/* Probe the devices */
+	ut_assertok(device_probe(normal));
+	ut_assertok(device_probe(dma));
+	ut_assertok(device_probe(vital));
+	ut_assertok(device_probe(dma_vital));
+
+	/* Check that devices are active right now */
+	ut_asserteq(true, device_active(normal));
+	ut_asserteq(true, device_active(dma));
+	ut_asserteq(true, device_active(vital));
+	ut_asserteq(true, device_active(dma_vital));
+
+	/* Remove active devices in an ordered way */
+	dm_remove_devices_active();
+
+	/* Check that all devices are inactive right now */
+	ut_asserteq(true, device_active(normal));
+	ut_asserteq(false, device_active(dma));
+	ut_asserteq(true, device_active(vital));
+	ut_asserteq(false, device_active(dma_vital));
+
+	return 0;
+}
+DM_TEST(dm_test_remove_active, 0);
+
 static int dm_test_uclass_before_ready(struct unit_test_state *uts)
 {
 	struct uclass *uc;

-- 
2.47.0


