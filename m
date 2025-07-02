Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61DDC83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B5D8301E;
	Wed,  2 Jul 2025 17:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34278301E; Wed,  2 Jul 2025 17:26:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AE1DC8300B
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 455DE2EDF;
 Wed,  2 Jul 2025 08:25:57 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F06523F6A8;
 Wed,  2 Jul 2025 08:26:09 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 15/25] efi_loader: fwu: fwu_arm_psa: Skip accepting the
 payload after set_image()
Date: Wed,  2 Jul 2025 16:25:18 +0100
Message-Id: <20250702152528.1180414-16-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
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

Do not update the acceptance metadata bit after updating an image

The update agent (secure world) is responsible of setting the acceptance
bit in the metadata.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/efi_capsule.c | 23 +++++++++++++----------
 lib/fwu_updates/fwu.c        | 21 +++++++++++++++++++++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 234e3c1b3c0..1dac691d24d 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -696,17 +696,20 @@ static efi_status_t efi_capsule_update_firmware(
 				status = fwu_clear_accept_image(image_type_id,
 								update_index);
 			}
-			ret = fwu_to_efi_error(status);
-			if (ret != EFI_SUCCESS) {
-				log_err("Unable to %s the accept bit for the image %pUs\n",
-					fw_accept_os ? "clear" : "set",
-					image_type_id);
-				goto out;
-			}
 
-			log_debug("%s the accepted bit for Image %pUs\n",
-				  fw_accept_os ? "Cleared" : "Set",
-				  image_type_id);
+			if (!IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+				ret = fwu_to_efi_error(status);
+				if (ret != EFI_SUCCESS) {
+					log_err("Unable to %s the accept bit for the image %pUs\n",
+						fw_accept_os ? "clear" : "set",
+						image_type_id);
+					goto out;
+				}
+
+				log_debug("%s the accepted bit for Image %pUs\n",
+					  fw_accept_os ? "Cleared" : "Set",
+					  image_type_id);
+			}
 		}
 
 	}
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 7f085a0211f..46b6f9356a7 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2022, Linaro Limited
+ *
+ * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Author:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
 #include <dm.h>
@@ -586,6 +591,14 @@ out:
  */
 int fwu_accept_image(efi_guid_t *img_type_id, u32 bank)
 {
+	/*
+	 * In case of Arm PSA accepting images is either
+	 * at ExitBootServices() or in the OS. So, let's skip setting the
+	 * acceptance bit (not used in Arm PSA)
+	 */
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA))
+		return EFI_SUCCESS;
+
 	return fwu_clrset_image_accept(img_type_id, bank,
 				       IMAGE_ACCEPT_SET);
 }
@@ -606,6 +619,14 @@ int fwu_accept_image(efi_guid_t *img_type_id, u32 bank)
  */
 int fwu_clear_accept_image(efi_guid_t *img_type_id, u32 bank)
 {
+	/*
+	 * In case of Arm PSA accepting images is either
+	 * at ExitBootServices() or in the OS. So, let's skip clearing the
+	 * acceptance bit (not used in Arm PSA)
+	 */
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA))
+		return EFI_SUCCESS;
+
 	return fwu_clrset_image_accept(img_type_id, bank,
 				       IMAGE_ACCEPT_CLEAR);
 }
-- 
2.25.1

