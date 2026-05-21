Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63664CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE5F8486B;
	Thu, 21 May 2026 20:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eD64TX2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072C784713; Thu, 21 May 2026 20:50:33 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FBC58482E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-111-011.46.114.pool.telefonica.de
 [46.114.111.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3E08F41795; 
 Thu, 21 May 2026 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779389430;
 bh=QI9of6zBmVHLGGjzIf82Srx2oQiEXoy+tiF5S63B6e0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eD64TX2JKRJxw4LUrYkGYO6scGOOfw5TfuYxyH4k50z00orkyDXOvxjEz3dFsYhfS
 3Pv+uG3Sr1R7EZDk6IFzrb7u5qirfpnBShh3CnPZQew0IQVtFvcrsQGQ6x5lWEVkmy
 nh8F07bPTOYm2o/qfa1Yif1yrj1RNjCahof/4Bb+m5C3htsCX16NYpOqAsnNfslNU3
 3P8cNceHomURsiYx1IDgrr4yUgV+Lak/z9+UyIGfauLsBsxbw5qRDAm9HT5bT4m0F7
 qpSNZg76kWg9nUilh10LOWxUNMg2ngu6IDxzhdswwuP+FjEHY9kFV48yL2CRn8nzKQ
 BRK3ChrRzwT/fNWim87Ea0/BOzcika6ng1praRgsLczajB2R+tc4eqVEryVYwQbO0q
 JPrE4nwWdWVrsrRPAtGfSfQx9u5aaH7hBoMusz5s3ev5+3aZCxG3lIfEqLiFicyGi1
 OXBijDVcAWa5JHd86ERVXdfg7Yd6ayMlv8M8PPZhjhSfncBovTPGjcLjNH0V/She4b
 TvlWx1kTrQp0cziL/K+2o1h86pP+xjZPHAzP5KYYBES5ComBABIiMU8jPbIbtuy3w8
 EGHATYdS3r77f3G0bATSbZSXLIqhNM38FgRRP1DAayHvnRocISo48O7jRbMBAzot2Z
 2582ZQlO62rtRCUQb9f4yaZU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] efi_loader: use pointers in efi_acpi_register()
Date: Thu, 21 May 2026 20:50:23 +0200
Message-ID: <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
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
 lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 046986a7518..70cb896ac25 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
  */
 efi_status_t efi_acpi_register(void)
 {
-	ulong addr, start, end;
+	void *addr, *start, *end;
 	efi_status_t ret;
 
 	/*
@@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
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
-		ret = efi_add_memory_map(start, end - start,
+		start = (void *)ALIGN_DOWN(
+			(uintptr_t)map_sysmem(gd->arch.table_start, 0),
+			(uintptr_t)EFI_PAGE_MASK);
+		end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
+							  0),
+				    (uintptr_t)EFI_PAGE_MASK);
+		ret = efi_add_memory_map((uintptr_t)start,
+					 (uintptr_t)end - (uintptr_t)start,
 					 EFI_ACPI_RECLAIM_MEMORY);
 		if (ret != EFI_SUCCESS)
 			return ret;
 		if (gd->arch.table_start_high) {
-			start = ALIGN_DOWN(gd->arch.table_start_high,
-					   EFI_PAGE_MASK);
-			end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
-			ret = efi_add_memory_map(start, end - start,
+			start = (void *)ALIGN_DOWN(
+				(uintptr_t)map_sysmem(gd->arch.table_start_high,
+						      0),
+				(uintptr_t)EFI_PAGE_MASK);
+			end = (void *)ALIGN((uintptr_t)map_sysmem(
+						    gd->arch.table_end_high, 0),
+					    EFI_PAGE_MASK);
+			ret = efi_add_memory_map((uintptr_t)start,
+						 (uintptr_t)end -
+							 (uintptr_t)start,
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

