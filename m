Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05309CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA101849BF;
	Sun, 21 Jun 2026 10:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KYdRcqQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75961849D1; Sun, 21 Jun 2026 10:19:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212C4848DC
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 58F6442075; 
 Sun, 21 Jun 2026 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029960;
 bh=qDYhxTUngbWNLRRrbcNzFNFp9S5A3qPqajl9FGoEAgA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KYdRcqQtkPpU+X60BMA4yXXBMV8vwPCy5+lDi0ltUBWgjx0vJUH7S26yXCXfw5Vza
 Na0wusAqsu3q7T/ocQQQNupwZwbTMSqm2RvHXbRv1QEsEKe0vD9I+nFdBhTOL9HFJp
 ttcZ5pXN/b/6GDJpUm8gkqFEMzLp0fjXXKVO36V6qyQa+jW36A1i1klnIxq5EOEiti
 0E9U6XegnE4Ii8GnyU47QiT1LCTOJD7DqKcbJJWIrpIJ2sb3R8LD4ialp6oYBTdWoz
 aScINCF36Y4GJhDAZqnc06rtglTfjzLI378nYvH9HH8vg0RwkF9eS5JGFbi0ylUslD
 GzMbhDEQ5/pm6SSr5QSfUONDcJ9Q+sBizljSPlACnARoxeR5wc5K4qCXEBNCDQOCxV
 sQkxZvg/yOBTA7ZmG9zWL0stKTZ17COcOIN+KgxrP2+sls/yFeWcTdBkTRUKfwhDtt
 AX2hrHov9PN2Q5iTwMMmTdbwC/TN/fxSzh/5SyE3T3jPVE1ZCvISTI3PNuNENSf56A
 s2tIbtuc7wtKJCcxO4ixERPmzP4x2Z1MVRvmt3yKJFUQCk+ceaWMswjlft8LYFamBY
 BObV/Yb1bm1DVhC0AfQJYbadZuiG5grVONxbG/pCgs3RY8rqn8lDJcIAuB8EjyzqyW
 wZAzWRDRjpc6/TRxg7PEQWhY=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 01/11] efi_loader: use pointers in efi_acpi_register()
Date: Sun, 21 Jun 2026 10:19:05 +0200
Message-ID: <20260621081915.19154-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

Both efi_add_memory_map() and efi_install_configuration_table() expect
pointers and not virtual sandbox addresses.

We need to convert the virtual sandbox addresses in efi_acpi_register() to
pointers in memory before using them.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Use uintptr_t instead of void* to simplify code.
	Use EFI_PAGE_SIZE instead of EFI_PAGE_MASK.
---
 lib/efi_loader/efi_acpi.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 046986a7518..43a6cbe6cfc 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -25,7 +25,8 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
  */
 efi_status_t efi_acpi_register(void)
 {
-	ulong addr, start, end;
+	void *addr;
+	uintptr_t start, end;
 	efi_status_t ret;
 
 	/*
@@ -37,39 +38,45 @@ efi_status_t efi_acpi_register(void)
 	 */
 	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
 		int size;
-		void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
 
-		if (!tab)
+		addr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
+
+		if (!addr)
 			return EFI_NOT_FOUND;
-		addr = map_to_sysmem(tab);
 
-		ret = efi_add_memory_map(addr, size,
+		ret = efi_add_memory_map((uintptr_t)addr, size,
 					 EFI_ACPI_RECLAIM_MEMORY);
 		if (ret != EFI_SUCCESS)
 			return ret;
 	} else {
 		/* Mark space used for tables */
-		start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
-		end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
+		start = ALIGN_DOWN((uintptr_t)map_sysmem(gd->arch.table_start,
+							 0),
+				   EFI_PAGE_SIZE);
+		end = ALIGN((uintptr_t)map_sysmem(gd->arch.table_end, 0),
+			    EFI_PAGE_SIZE);
 		ret = efi_add_memory_map(start, end - start,
 					 EFI_ACPI_RECLAIM_MEMORY);
 		if (ret != EFI_SUCCESS)
 			return ret;
 		if (gd->arch.table_start_high) {
-			start = ALIGN_DOWN(gd->arch.table_start_high,
-					   EFI_PAGE_MASK);
-			end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
+			start = ALIGN_DOWN(
+				(uintptr_t)map_sysmem(gd->arch.table_start_high,
+						      0),
+				EFI_PAGE_SIZE);
+			end = ALIGN((uintptr_t)map_sysmem(
+					    gd->arch.table_end_high, 0),
+				    EFI_PAGE_SIZE);
 			ret = efi_add_memory_map(start, end - start,
 						 EFI_ACPI_RECLAIM_MEMORY);
 			if (ret != EFI_SUCCESS)
 				return ret;
 		}
 
-		addr = gd_acpi_start();
+		addr = map_sysmem(gd_acpi_start(), 0);
 	}
-	log_debug("EFI using ACPI tables at %lx\n", addr);
+	log_debug("EFI using ACPI tables at %p\n", addr);
 
 	/* And expose them to our EFI payload */
-	return efi_install_configuration_table(&acpi_guid,
-					       (void *)(ulong)addr);
+	return efi_install_configuration_table(&acpi_guid, addr);
 }
-- 
2.53.0

