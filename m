Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1BFC77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875908304C;
	Wed,  2 Jul 2025 17:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F6E83095; Wed,  2 Jul 2025 17:26:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5088183045
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D193024;
 Wed,  2 Jul 2025 08:26:07 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E58A33F738;
 Wed,  2 Jul 2025 08:26:20 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Emekcan Aras <emekcan.aras@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 20/25] efi_loader: capsule: Add runtime capsule flags checks
Date: Wed,  2 Jul 2025 16:25:23 +0100
Message-Id: <20250702152528.1180414-21-abdellatif.elkhlifi@arm.com>
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

From: Emekcan Aras <emekcan.aras@arm.com>

Add missing checks according to the UEFI specification [1]

checks added for these capsule flags:

CAPSULE_FLAGS_PERSIST_ACROSS_RESET
CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
CAPSULE_FLAGS_INITIATE_RESET

[1]: Table 8.8 Flag Firmware Behavior,
        https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html

Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 113cfe30fde..a5ebe4994dc 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -769,6 +769,36 @@ efi_status_t EFIAPI efi_update_capsule(
 			continue;
 		}
 
+		/*
+		 * ScatterGatherList must point to a list when the
+		 * CAPSULE_FLAGS_PERSIST_ACROSS_RESET flag is set.
+		 */
+		if ((capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET) &&
+		    !scatter_gather_list) {
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+
+		/*
+		 * The CAPSULE_FLAGS_PERSIST_ACROSS_RESET flag must be set
+		 * along with the CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE flag.
+		 */
+		if ((capsule->flags & CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE) &&
+		    !(capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET)) {
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+
+		/*
+		 * The CAPSULE_FLAGS_PERSIST_ACROSS_RESET flag must be set
+		 * along with the CAPSULE_FLAGS_INITIATE_RESET flag.
+		 */
+		if ((capsule->flags & CAPSULE_FLAGS_INITIATE_RESET) &&
+		    !(capsule->flags & CAPSULE_FLAGS_PERSIST_ACROSS_RESET)) {
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+
 		log_debug("Capsule[%d] (guid:%pUs)\n",
 			  i, &capsule->capsule_guid);
 		ret  = efi_capsule_update_firmware(capsule);
-- 
2.25.1

