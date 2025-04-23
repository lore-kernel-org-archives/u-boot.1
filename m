Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A9BC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 21:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6DE81B4B;
	Wed, 23 Apr 2025 23:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KXT6l8+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBECD8059D; Wed, 23 Apr 2025 23:32:13 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC568059A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 23:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301302a328bso422474a91.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745443929; x=1746048729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naahOQfCQ9QFZUhdV0xqfJzvf7fY56aK2l8A56ypjVc=;
 b=KXT6l8+V1PCmuM+ALwD/01tWZhYHjEzEJIapvi5FPwdVGQ2B9CqMtIDZzRwNtgpUPL
 roYCCgNtd9c0KOAHEUfs4VBospM6U7BYboBOkt++I/PeA8y5Apqe3VfSnzF8pSpMNJA1
 SwrnwsRxmaHDfI8CNvLYwNf3dZEyVyhCsZQvOi4KO2kmch0HvTDdR8OFH025F19DuqBM
 yrSaxAFwevPHUJigTG0IY+WbbNH7EuPhpAA7sk7sLkQMeyv4fjLHorQdISmiz3UwKFc6
 yfhGfgkAviEpJeyckeRSCMWXwM+iwZvjkXLVzyVTcYcNiruEDnAbaEYLTNtXIBWkm/M9
 8foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745443929; x=1746048729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naahOQfCQ9QFZUhdV0xqfJzvf7fY56aK2l8A56ypjVc=;
 b=dJH7eU8JIqbJWyZ3iPIrppcae9APAO+Q7d6npWgr6A4qV9xGZmwHNHe1K3xjpeatI0
 dHufDHWYJWDWZrXjqx1Sb20oKrTVGtBLNuBOi4m/i7aWchtHviN9doyr/hPyDp8r+PkD
 cKclpWUFFR+zK/uptbij+IgMFPkcnvDCiQvEyKf6QNmR3zzUmYq6palYqKvKlDczMz4t
 NW59//ecEUNQnia+O6rCxyx/xOmgTwBXunU+ZuKpAb13T1e5MOQJfY5eAWb9YCLHpgVf
 FxJHnga4XsfOpM8kHHHvEpVl2IHUZAi1BPbHxDka3NqrULRrTGh+0dk5wwLoOxDrtwgL
 i2+Q==
X-Gm-Message-State: AOJu0YwNeZoDnLXAYmWvuMzPtuluXYhSPySHFeIqq12xg5DAexnVQWDh
 +YXKTtKNcfwR+nd4OwOY73tEBXPDFoBfkVh4s2k7ZCXWzEm38hCOlJeUGA==
X-Gm-Gg: ASbGncvfn9K8mSeJBvGn0YxZes5EMCze5Fe+ZEnCoudk3NqocKQgkoZCNa7k5y3JQM0
 ykYdgth+q2iGhdBTZrCl8ennIVoEM7UdqunCGMR/7Atn6RzEs+DVbivEKLgGmABlh5Lu9PGk0ax
 MdYTaGjdP0vMUj1nTddqL8HY95FBfdkNy54NcOXgaev/y3OrH81/wxRnNonm5lAPAEsvCc8QGAv
 Rtgjd/NPcTrQMijM+5jGFkqTZ4G5JhkTKPK1SlfdarsC27tiMpZU9cnfoIs7O4S0s9GucVLzRGN
 gkEvFCSrPRumovi1yoDgO4ro869wdLVsRAwL
X-Google-Smtp-Source: AGHT+IGxmky9AHX5IHaUj5wTf2U03NGYBJtyBijk4Zs1OysZGxUkM64jRBVc/ic3CXbVfwm85c1JDQ==
X-Received: by 2002:a17:90b:45:b0:2ff:5016:7fd2 with SMTP id
 98e67ed59e1d1-309ed35b230mr441030a91.24.1745443929218; 
 Wed, 23 Apr 2025 14:32:09 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309df922267sm2182182a91.0.2025.04.23.14.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 14:32:08 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/3] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Thu, 24 Apr 2025 05:31:42 +0800
Message-ID: <20250423213145.1959046-2-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423213145.1959046-1-paulliu@debian.org>
References: <20250423213145.1959046-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Add EFI_SYSTEM_TABLE_POINTER structure for debugger to locate
the address of EFI_SYSTEM_TABLE.

This feature is described in UEFI SPEC version 2.10. Section 18.4.2.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_api.h             |  6 +++++
 include/efi_loader.h          |  2 ++
 lib/efi_loader/efi_boottime.c | 44 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c    |  7 ++++++
 4 files changed, 59 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index eb61eafa028..5017d9037cd 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -259,6 +259,12 @@ struct efi_capsule_result_variable_header {
 	efi_status_t capsule_status;
 } __packed;
 
+struct efi_system_table_pointer {
+	u64 signature;
+	efi_physical_addr_t efi_system_table_base;
+	u32 crc32;
+};
+
 struct efi_memory_range {
 	efi_physical_addr_t	address;
 	u64			length;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 1d75d97ebbc..370bc042f70 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -615,6 +615,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
 efi_status_t efi_root_node_register(void);
 /* Called by bootefi to initialize runtime */
 efi_status_t efi_initialize_system_table(void);
+/* Called by bootefi to initialize debug */
+efi_status_t efi_initialize_system_table_pointer(void);
 /* efi_runtime_detach() - detach unimplemented runtime functions */
 void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 5164cb15986..366bc0d2b1d 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -4001,6 +4001,8 @@ struct efi_system_table __efi_runtime_data systab = {
 	.tables = NULL,
 };
 
+struct efi_system_table_pointer __efi_runtime_data * systab_pointer = NULL;
+
 /**
  * efi_initialize_system_table() - Initialize system table
  *
@@ -4035,3 +4037,45 @@ efi_status_t efi_initialize_system_table(void)
 
 	return ret;
 }
+
+/**
+ * efi_initialize_system_table() - Initialize system table
+ *
+ * Return:	status code
+ */
+efi_status_t efi_initialize_system_table_pointer(void)
+{
+	efi_status_t ret;
+	const int size_4MB = 0x00400000;
+	int pages = efi_size_in_pages(sizeof(struct efi_system_table_pointer));
+	int alignment_mask = size_4MB - 1;
+	int real_pages = pages + efi_size_in_pages(size_4MB);
+	u64 addr;
+	u64 aligned_addr;
+	u32 crc32_value;
+
+	/* Allocate configuration table array */
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_RUNTIME_SERVICES_DATA,
+				 real_pages,
+				 &addr);
+
+	/* alignment to 4MB boundary */
+	aligned_addr = (addr + alignment_mask) & ~alignment_mask;
+
+	systab_pointer = (struct efi_system_table_pointer *)aligned_addr;
+	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
+
+	/*
+	 * These entries will be set to NULL in ExitBootServices(). To avoid
+	 * relocation in SetVirtualAddressMap(), set them dynamically.
+	 */
+	systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
+	systab_pointer->efi_system_table_base = (efi_physical_addr_t)&systab;
+	systab_pointer->crc32 = 0;
+	crc32_value = crc32(0,
+			    (const unsigned char *)systab_pointer,
+			    sizeof(struct efi_system_table_pointer));
+	systab_pointer->crc32 = crc32_value;
+	return ret;
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..073a08b1127 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -259,6 +259,13 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Initialize system table */
+	ret = efi_initialize_system_table_pointer();
+	if (ret != EFI_SUCCESS) {
+		printf("EFI init system table pointer fail\n");
+		goto out;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
 		ret = efi_ecpt_register();
 		if (ret != EFI_SUCCESS)
-- 
2.39.5

