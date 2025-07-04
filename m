Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F428C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 14:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACF0801BE;
	Fri,  4 Jul 2025 16:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a/A04XH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC95803DF; Fri,  4 Jul 2025 16:22:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECCC800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 16:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D25573F691
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751638939;
 bh=e2IUOrZwI74TwWVTbpC4qqzWjQLpb+n9bXMwWd1dp6A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=a/A04XH5PWwfQSMvGKGKWTzvjzNkh/x9Jdw8ZxTFJy1PODFhuYvnn1lP1HbeVeNoK
 hMhu6XdAA5JQ88brVt0EZ3VEMgcdTN9tlEBJJNy/xhykwjuZwU4I7bkRZV+eMJEN0M
 uuh4J/LEDefhNJYNheCaoYezj5aCxfCL4URuuNRP80nl7uZ0qcKKqi1Ie+LWo9e6ze
 Lydav35xfBDJYWzIGhGwxK0yojgYeVajqfiOPNjkXbhkQzSQS0D6rLrybp2GExGo+Q
 S7UWpxRnx8iUjBcUFXYnSh6FVSVYI82XX3cQfileNH3yr/isyODf1tbVPn9eqMPeed
 wXQC7AdDmWtbw==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ade81d27cddso114040566b.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 07:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638939; x=1752243739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2IUOrZwI74TwWVTbpC4qqzWjQLpb+n9bXMwWd1dp6A=;
 b=FPY2CZUwJZ/SayAIyJVOG51p1HvsZhkexUdtNDTvhbvIU7bGhus9pyjZPGYc3eOsGv
 DWx7Al2ro38X9WRD6EvZzyeVjjjZQDFC8WRnxz1NCpre7kzlxXLijL3Bso3PKnChx46z
 WGYRC+Vy9eX7OKxcG1q+oz7qDvyqO0DKULuVC6yRWxm+LglPKPvwdw7L9P7ZdCazasGB
 P15dMOI7LxdI/+7MVfexlbU5Lgj64LyTGY/uDpUERQdjshlMpCfsuNOFF8EWdl7V4EZK
 lG8dqi2q9KYCVGDR89u+OS6xGF6vQGLbRotxnr1xjovOATb0WB16Q1zMKbI0f7bn+6Yo
 Fwbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU/KyenEvyAtECmrFgOcIOq9IWY/Yf75kUqQ6qLmpGVf/+j5YkdTPp3tHCtYM7jXYXRRX7M+s=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmbtla1rdu9U7CVIF13biA/y8KwXtHRHGmy0TKG9FsR495JtSK
 jnwMdoYtOlTNS7b6ATcnmoRHUHAWv9VAhl32W930GsTewzKBsdhx0AzHR9DJjkbxuRuZLfYeoV2
 Ei+0rJNY3fTVQgjwyhkRH/IG7I+B62n7CwxVAnC7XFA2IqDELUtBJUyTIO+w0SGYdszIRSyc=
X-Gm-Gg: ASbGnctDH+D8Q7Ivy1Yy2OBTpYnSODKMUWhXVMYICI4MYyg4dsorqVBUU17z9CzTDqc
 +BsICUcMxqn94+AYwERcZrzxWX7V9XWYOhBJGMB0Ou2cFubZANVCEw4Q/R4DA9Lj2D1KgVY6/k4
 N801/tr61DXthG2VbbH6VVnt0JowIuE8bZzLELLWy0TMoSFozVZdmn9pRDLl1MpTHvXKb0cRvOR
 r4BGiCT6XPLrlSY3juYzNH2Bm2NJWOM3azElZzw0y5Co1ly3QMf2qtW7AMKTgriD9DIGoQlIGiM
 WPlTvUQ7mfJ65TtcnHdU+Xwr2SIMPDko2e936POmgSm2r1YNDYMd7NBs9XZGm7XreazGlrh7V3D
 sFQco58aThuNk63FM1Pt1PJ1L
X-Received: by 2002:a17:906:d7cb:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae3fbd499ddmr291090566b.29.1751638939209; 
 Fri, 04 Jul 2025 07:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkZUQqq/rfMMqEmUOlrqoqm71lqYESb5K6ZvV4iQywWPwSzaGKvuTUXxoDOD11YJjj2DAC2Q==
X-Received: by 2002:a17:906:d7cb:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae3fbd499ddmr291088166b.29.1751638938748; 
 Fri, 04 Jul 2025 07:22:18 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm185482866b.10.2025.07.04.07.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:22:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: check system table pointer
Date: Fri,  4 Jul 2025 16:22:12 +0200
Message-ID: <20250704142212.186229-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Enhance the debug support unit test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_debug_support.c | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_debug_support.c b/lib/efi_selftest/efi_selftest_debug_support.c
index 9ca8b3f82f5..ac77caaf561 100644
--- a/lib/efi_selftest/efi_selftest_debug_support.c
+++ b/lib/efi_selftest/efi_selftest_debug_support.c
@@ -9,6 +9,7 @@
 
 #include <efi_loader.h>
 #include <efi_selftest.h>
+#include <linux/sizes.h>
 
 /**
  * efi_st_debug_support_execute() - execute test
@@ -21,6 +22,12 @@ static int efi_st_debug_support_execute(void)
 {
 	struct efi_debug_image_info_table_header *efi_st_debug_info_table_header = NULL;
 	efi_guid_t efi_debug_image_info_table_guid = EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+	struct efi_mem_desc *memory_map;
+	efi_uintn_t map_size = 0;
+	efi_uintn_t map_key;
+	efi_uintn_t desc_size;
+	u32 desc_version;
+	efi_status_t ret;
 
 	/* get EFI_DEBUG_IMAGE_INFO_TABLE */
 	efi_st_debug_info_table_header = efi_st_get_config_table(&efi_debug_image_info_table_guid);
@@ -30,7 +37,66 @@ static int efi_st_debug_support_execute(void)
 		return EFI_ST_FAILURE;
 	}
 
-	return EFI_ST_SUCCESS;
+	/* Load memory map */
+	ret = st_boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
+					  &desc_version);
+	if (ret != EFI_BUFFER_TOO_SMALL) {
+		efi_st_error
+			("GetMemoryMap did not return EFI_BUFFER_TOO_SMALL\n");
+		return EFI_ST_FAILURE;
+	}
+	/* Allocate extra space for newly allocated memory */
+	map_size += sizeof(struct efi_mem_desc);
+	ret = st_boottime->allocate_pool(EFI_BOOT_SERVICES_DATA, map_size,
+					 (void **)&memory_map);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("AllocatePool failed\n");
+		return EFI_ST_FAILURE;
+	}
+	ret = st_boottime->get_memory_map(&map_size, memory_map, &map_key,
+					  &desc_size, &desc_version);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetMemoryMap failed\n");
+		return EFI_ST_FAILURE;
+	}
+	/* Find the system table pointer */
+	for (efi_uintn_t i = 0; map_size; ++i, map_size -= desc_size) {
+		struct efi_mem_desc *entry = &memory_map[i];
+		u64 end;
+
+		if (entry->type != EFI_RUNTIME_SERVICES_DATA)
+			continue;
+
+		end = entry->physical_start +
+		      (entry->num_pages << EFI_PAGE_SHIFT);
+		for (u64 pos = ALIGN(entry->physical_start, SZ_4M);
+		     pos <= end; pos += SZ_4M) {
+			struct efi_system_table_pointer *systab_pointer =
+				(void *)(uintptr_t)pos;
+
+			/* check for overflow */
+			if (pos < entry->physical_start)
+				break;
+			if (systab_pointer->signature ==
+			    EFI_SYSTEM_TABLE_SIGNATURE) {
+				if (systab_pointer->efi_system_table_base !=
+				    (uintptr_t)st_systable) {
+					efi_st_error("Wrong system table address\n");
+					ret = EFI_ST_FAILURE;
+					goto out;
+				}
+				ret = EFI_ST_SUCCESS;
+				goto out;
+			}
+		}
+	}
+	efi_st_error("System table pointer not found\n");
+	ret = EFI_ST_FAILURE;
+
+out:
+	st_boottime->free_pool(memory_map);
+
+	return ret;
 }
 
 EFI_UNIT_TEST(debug_support) = {
-- 
2.48.1

