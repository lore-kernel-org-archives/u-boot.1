Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A38DF3D31C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 16:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE9483F8F;
	Thu,  5 Mar 2026 17:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A0F83F8F; Thu,  5 Mar 2026 17:14:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8442683E81
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 17:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18891339;
 Thu,  5 Mar 2026 08:13:59 -0800 (PST)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96DA73F694;
 Thu,  5 Mar 2026 08:14:04 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] efi_loader: export efi_ecpt_guid
Date: Thu,  5 Mar 2026 17:13:47 +0100
Message-ID: <20260305161349.2317130-3-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305161349.2317130-1-vincent.stehle@arm.com>
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
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

Export the ECPT GUID, to prepare accessing it from more than one location.

The C file containing the GUID is compiled only when CONFIG_EFI_ECPT is
set; gate the export accordingly.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 include/efi_loader.h             | 4 ++++
 lib/efi_loader/efi_conformance.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3e70ac07055..0ebc80e0af0 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -387,6 +387,10 @@ extern const efi_guid_t efi_guid_capsule_report;
 extern const efi_guid_t efi_guid_firmware_management_protocol;
 /* GUID for the ESRT */
 extern const efi_guid_t efi_esrt_guid;
+/* GUID for the ECPT */
+#if CONFIG_IS_ENABLED(EFI_ECPT)
+extern const efi_guid_t efi_ecpt_guid;
+#endif
 /* GUID of the SMBIOS table */
 extern const efi_guid_t smbios_guid;
 extern const efi_guid_t smbios3_guid;
diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
index 2d31800ccb8..470141af483 100644
--- a/lib/efi_loader/efi_conformance.c
+++ b/lib/efi_loader/efi_conformance.c
@@ -12,7 +12,7 @@
 #include <efi_api.h>
 #include <malloc.h>
 
-static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
+const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
 
 /**
  * efi_ecpt_register() - Install the ECPT system table.
-- 
2.51.0

