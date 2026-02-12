Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B504EE3690
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 14:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D2B38388D;
	Thu, 12 Feb 2026 15:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBCB83AAB; Thu, 12 Feb 2026 15:40:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 664B683015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 15:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D146339;
 Thu, 12 Feb 2026 06:40:12 -0800 (PST)
Received: from debian (MacBookPro.nice.arm.com [10.34.124.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCBFD3F632;
 Thu, 12 Feb 2026 06:40:17 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>
Subject: [PATCH v2] efi_loader: fix ecpt size computation
Date: Thu, 12 Feb 2026 15:40:15 +0100
Message-ID: <20260212144015.3898750-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211093308.3265022-1-vincent.stehle@arm.com>
References: <20260211093308.3265022-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The size of the memory allocated for the EFI Conformance Profiles Table is
computed with `num_entries' always equal to zero, which is incorrect when
CONFIG_EFI_EBBR_2_1_CONFORMANCE is enabled.

This can be verified by allocating the ECPT memory with malloc() instead of
efi_allocate_pool(), building u-boot with sandbox_defconfig and
CONFIG_VALGRIND=y, and by finally running the following command:

  valgrind --suppressions=scripts/u-boot.supp \
    ./u-boot -T -c 'efidebug tables'

Fix this by using an array of the supported profiles GUIDs instead, which
should also be easier to extend in the future as U-Boot should publish the
GUIDs for all supported EBBR revisions.

Fixes: 6b92c1735205 ("efi: Create ECPT table")
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Jose Marinho <jose.marinho@arm.com>
---


Changes for v2:
- Mention in the commit message that U-Boot should publish all supported
  EBBR GUIDs (suggested by Heinrich)
- Move the array declaration into the function (suggested by Heinrich)


 lib/efi_loader/efi_conformance.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
index 2bae93a94bd..2d31800ccb8 100644
--- a/lib/efi_loader/efi_conformance.c
+++ b/lib/efi_loader/efi_conformance.c
@@ -13,8 +13,6 @@
 #include <malloc.h>
 
 static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
-static const efi_guid_t efi_ebbr_2_1_guid =
-	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
 
 /**
  * efi_ecpt_register() - Install the ECPT system table.
@@ -23,12 +21,17 @@ static const efi_guid_t efi_ebbr_2_1_guid =
  */
 efi_status_t efi_ecpt_register(void)
 {
-	u16 num_entries = 0;
 	struct efi_conformance_profiles_table *ecpt;
 	efi_status_t ret;
 	size_t ecpt_size;
 
-	ecpt_size = num_entries * sizeof(efi_guid_t)
+	static const efi_guid_t profiles[] = {
+	#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
+		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
+	#endif
+	};
+
+	ecpt_size = sizeof(profiles)
 		+ sizeof(struct efi_conformance_profiles_table);
 	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, ecpt_size,
 				(void **)&ecpt);
@@ -39,12 +42,9 @@ efi_status_t efi_ecpt_register(void)
 		return ret;
 	}
 
-	if (CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE))
-		guidcpy(&ecpt->conformance_profiles[num_entries++],
-			&efi_ebbr_2_1_guid);
-
+	memcpy(ecpt->conformance_profiles, profiles, sizeof(profiles));
 	ecpt->version = EFI_CONFORMANCE_PROFILES_TABLE_VERSION;
-	ecpt->number_of_profiles = num_entries;
+	ecpt->number_of_profiles = ARRAY_SIZE(profiles);
 
 	/* Install the ECPT in the system configuration table. */
 	ret = efi_install_configuration_table(&efi_ecpt_guid, (void *)ecpt);
-- 
2.51.0

