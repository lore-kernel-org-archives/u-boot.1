Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E429EC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636CD81E14;
	Thu, 24 Apr 2025 22:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="US544qc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4041881D5D; Thu, 24 Apr 2025 22:19:43 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01E58056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224341bbc1dso19547955ad.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745525979; x=1746130779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7CUD5mTR6NvTEpbFCKEGhRSLhxcJ1slxKlB6mjaUrk=;
 b=US544qc1ShyVg/qrgx9YU8NJAbpUnkTgfaMHY8eEFuqQAoQjNdGq64u5jZ2DSU/CR2
 4h7Gi4PAwu3rkQXzH3OlhDPmo4l968ErAfjRySVrDra3mn80EOzI75KjD4j46jiEX3KO
 CPFaNNnSAZS8L+bmU16x/Yo5+um6JJMDVN3UDdPDpB0Ziimx10s0BHSP65JIfVUCb8dN
 I6rwqAY6m0h5dSih1uqbJaRcj9eQMSqvyWDYK3TbwnTMeOR0XAhngO1m/ct1Ue2oAdvV
 3BNaoSuY7wmknz6xX5RCE91Cim4KCwY6s7SUK6LpHz1sDroQ1DSjEchAud+pQENLJ6Uw
 4nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745525979; x=1746130779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7CUD5mTR6NvTEpbFCKEGhRSLhxcJ1slxKlB6mjaUrk=;
 b=PtQ9TTrd2Gq159TZdJ9upUo7TC/OwO9YWR/LfwU/U5g5RXTLtaxN5oI3WRHMCxmEtD
 dYg2yKRRTr12vtq1PA9oTNsLxpuOP9B9t70aX3uSnh2qvetMtb9ERgVLTg7AGVxb3eWQ
 NKKUrXuln0PdvqSZDhtpx3GKFTs3mvYbtj/L9imNGpWdJneX9JxLG5fzdtpJoMVfw1ed
 Wmvk+4T0NSSr9Tug7O75Jz1B9+8hnLFg1oexaM0WKnzTjBq9E1U2DH2Ow3zrCLU3hTJS
 kUQ9dmBY1waQGZ+MxIblubG9gmWYlFBhiS+rVq2ZNl9stiYMBzq1tVFQUhUT4UeYziIM
 hxAg==
X-Gm-Message-State: AOJu0Yy5+apN84WVWxTmpsB+2Qv29jnTeHOUj5chHrBgXazJWDehuQF/
 tizFCTiCAHOp1vVHlGYbvx11Myo+s3QN0HMFGujk27Fk/sMy/UWCRoRgQg==
X-Gm-Gg: ASbGnct5jQL/5dvbHjvQOTXa2h3RS2ZquYPDaNy2RaSS+0exO289S2SP3LwOn7X8Xcl
 HJNn3pMk8rOn3WgJZ1RQlNvgzl9Hawt/691tUM2wE6FsuseIWEhkHKMe0muQa5eJywhWdjJKWxT
 raCwMUn4CddCiN/LRgFKHaBv8MDWgGZ2nl/sYtUPibspNdBBCCBGXD2pTtSUk6DuVGmRczY+gIF
 iIUljNcJ3X13ckYHInAXHkiLwJtlb1/bkoN/9zm+Lqmf1YnBLmFbA0aSOIahAQGPR6a3hGD0I7O
 hgJOV4Mp/87iOJYs/oVqPmzqTdwpMtIo1GQZ
X-Google-Smtp-Source: AGHT+IFQyUpJlUFwA/I+bfVK9+XSepI9BO2q84KM1dvB6ERZB52M0SDIGuO9bYdBchCDeUUB/DCqpQ==
X-Received: by 2002:a17:903:244f:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22db3bec08cmr60144795ad.21.1745525978830; 
 Thu, 24 Apr 2025 13:19:38 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db5221cbbsm17868255ad.221.2025.04.24.13.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 13:19:38 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/3] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Fri, 25 Apr 2025 04:19:24 +0800
Message-ID: <20250424201927.2027257-2-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250424201927.2027257-1-paulliu@debian.org>
References: <20250424201927.2027257-1-paulliu@debian.org>
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
V2: add Kconfig options to turn on/off this feature.
---
 include/efi_api.h             |  6 +++++
 include/efi_loader.h          |  2 ++
 lib/efi_loader/Kconfig        |  7 ++++++
 lib/efi_loader/efi_boottime.c | 44 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c    |  9 +++++++
 5 files changed, 68 insertions(+)

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
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d4f6b56afaa..94a75981389 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -70,6 +70,13 @@ config EFI_SECURE_BOOT
 config EFI_SIGNATURE_SUPPORT
 	bool
 
+config EFI_DEBUG_SUPPORT_TABLE
+	bool "EFI Debug Support Table"
+	help
+	  Select this option if you want to setup the EFI Debug Support
+	  Table which is used by the debug agent or an external debugger to
+	  determine loaded image information in a quiescent manner.
+
 menu "UEFI services"
 
 config EFI_GET_TIME
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
index aa59bc7779d..6be23ca43bf 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -259,6 +259,15 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Initialize system table */
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
+		ret = efi_initialize_system_table_pointer();
+		if (ret != EFI_SUCCESS) {
+			printf("EFI init system table pointer fail\n");
+			goto out;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
 		ret = efi_ecpt_register();
 		if (ret != EFI_SUCCESS)
-- 
2.39.5

