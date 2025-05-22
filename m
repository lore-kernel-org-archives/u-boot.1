Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A8C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 01:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A07682F8E;
	Thu, 22 May 2025 03:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cAVc1xIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE56F82F84; Thu, 22 May 2025 03:18:05 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B47E82E7D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 03:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30dfd9e7fa8so8913992a91.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 18:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747876681; x=1748481481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYutLCDIdafRVL2TSuzMgXBpCNm8L8Ne2g8KNqDuj7k=;
 b=cAVc1xIp3VdZZ2WaDe6l+dVJPUd3N1R5PGJeKlS2jD9xOZh8MS2DDpqGwclWkJ4BxM
 Dx+btFUIgOBnKa7eC1Oj8KhbaLPY/PiSvMk8Mqc0PkOKE9SSolQUlvZ/+1auXaLAcBvr
 AMHxetoK0Tm4DbOhF07NlFrKZUwrpkT9BL7lI+cbnSInGqPCEeYVmIU850se/juv6j5F
 PHE2UW14NmNqwSpxyxrOy6+wY+Qv82nZPhGSFXAgazzTBxvvlvKS/qMwdS1VXjIO/A5r
 0frVeS5+9rgmyP5jFRZgPakIu3qm2fBSA4Mc5/aSRSOcYXbUxcx+hL8Wb0r4tZtlkojV
 SrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747876681; x=1748481481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IYutLCDIdafRVL2TSuzMgXBpCNm8L8Ne2g8KNqDuj7k=;
 b=pjwXPEJ4wQ4qVXm5q7gvvU/iLme8J+VEYDfg9UjBOeIykQZdoDrj+TvYOOA7Y62y8f
 V02W67dmM4Ltc4ZqGb2i8yGMbvFfAn1xrW1XFRhgc39pOCZin+9dMZ6Qlwz79TLkGcW7
 DGktcAyzFMjvnIcD2ei8wsj0PTZ1yERuiKYg7sbNk+oOd15al2tmCz/+XB8Lz6x0o6AL
 YXSGD04+eLVVYmk4Fpwj76w7VHiLoG6b0JtPZymqXixq4YKRZYnAtNN/CA3+QtbSrgVk
 YSVDfQnAc4FjVgPmE+KpiW4DJ7fYsuqfRSYpnJ0M0o1g7jMNUIQst2+GgDPfZ8n3MbjY
 ymdA==
X-Gm-Message-State: AOJu0YxaZxYWt32/Jw6vqnItw7cwpc9YAdGzGrtxzbFtgV2JC6oQMFlM
 xTDPEEfO+dyYcA96tJgvJqK97QCN88NwEME/IqeTp0RUtNujPIAPR5Jdpd4Xvg==
X-Gm-Gg: ASbGncsCXc31hRks5YID/mqw2wTLm10+TSLtwskPN5JlEsOwzxQDY3TDn7ZsWti/rc3
 kWjJ8ZhxemEogo1tdOxrKpXvugpWdLeuKSbhaEVC4efV24yjlP0IosDAIUJap3WXoA9q8+2m2lR
 RCVBus1YfqhzT4SNAMcmWkyWh8J7GXFL/UUAgZVfWlS3eDY8iKx/6ehs3mlUhYxYc5X+/u5JFUQ
 529hn1ZQOY0icmqjI6B/7NUJkfPJ9M5M1D3NiD/Ia/THq6WwJGBUaL1nZUNSdXA6vBG7H3CHBEo
 LFnysm80ZW2HRdMFp6LZC9Y88DEQcGLn5ToEJVsiZ3wZSCE=
X-Google-Smtp-Source: AGHT+IGlNMNBMHTeKTCIkB/xEeWkV5qcPAzp/GDJfO+2mYDBGO2PFAB5nHIXtpkpwtH6Coul8Ay04w==
X-Received: by 2002:a17:90b:5603:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-30e8323cd14mr30849833a91.30.1747876680435; 
 Wed, 21 May 2025 18:18:00 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30f364fff49sm4680523a91.36.2025.05.21.18.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 18:18:00 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 1/4] efi: add EFI_SYSTEM_TABLE_POINTER for debug
Date: Thu, 22 May 2025 09:17:45 +0800
Message-ID: <20250522011749.3498970-2-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522011749.3498970-1-paulliu@debian.org>
References: <20250522011749.3498970-1-paulliu@debian.org>
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

Add EFI_SYSTEM_TABLE_POINTER structure for remote debugger to locate
the address of EFI_SYSTEM_TABLE.

This feature is described in UEFI SPEC version 2.10. Section 18.4.2.
The implementation ensures support for hardware-assisted debugging and
provides a standardized mechanism for debuggers to discover the EFI
system table.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
V2: add Kconfig options to turn on/off this feature.
V3: make efi_initialize_system_table_pointer() do the job as described.
---
 include/efi_api.h             | 16 ++++++++++++
 include/efi_loader.h          |  2 ++
 lib/efi_loader/Kconfig        |  7 ++++++
 lib/efi_loader/efi_boottime.c | 46 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c    |  8 ++++++
 5 files changed, 79 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index eb61eafa028..6c4c1a0cc7b 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -259,6 +259,22 @@ struct efi_capsule_result_variable_header {
 	efi_status_t capsule_status;
 } __packed;
 
+/**
+ * struct efi_system_table_pointer - struct to store the pointer of system
+ * table.
+ * @signature: The signature of this struct.
+ * @efi_system_table_base: The physical address of System Table.
+ * @crc32: CRC32 checksum
+ *
+ * This struct is design for hardware debugger to search through memory to
+ * get the address of EFI System Table.
+ */
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
index 8f9f2bcf1cb..8f065244d8e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -646,6 +646,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb);
 efi_status_t efi_root_node_register(void);
 /* Called by bootefi to initialize runtime */
 efi_status_t efi_initialize_system_table(void);
+/* Called by bootefi to initialize debug */
+efi_status_t efi_initialize_system_table_pointer(void);
 /* efi_runtime_detach() - detach unimplemented runtime functions */
 void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 7f02a83e2a2..d878fc9021d 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -71,6 +71,13 @@ config EFI_SECURE_BOOT
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
index dbebb37dc04..5a4349f8679 100644
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
@@ -4035,3 +4037,47 @@ efi_status_t efi_initialize_system_table(void)
 
 	return ret;
 }
+
+/**
+ * efi_initialize_system_table() - Initialize system table pointer
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
+	if (ret != EFI_SUCCESS) {
+		log_err("Installing EFI system table pointer failed\n");
+		return ret;
+	}
+
+	/* alignment to 4MB boundary */
+	aligned_addr = (addr + alignment_mask) & ~alignment_mask;
+
+	systab_pointer = (struct efi_system_table_pointer *)aligned_addr;
+	memset(systab_pointer, 0, sizeof(struct efi_system_table_pointer));
+
+	systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
+	systab_pointer->efi_system_table_base = (efi_physical_addr_t)&systab;
+	systab_pointer->crc32 = 0;
+	crc32_value = crc32(0,
+			    (const unsigned char *)systab_pointer,
+			    sizeof(struct efi_system_table_pointer));
+	systab_pointer->crc32 = crc32_value;
+
+	return ret;
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 48f91da5df7..a6b37d994f6 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -278,6 +278,14 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	/* Initialize system table pointer */
+	if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
+		ret = efi_initialize_system_table_pointer();
+		if (ret != EFI_SUCCESS) {
+			goto out;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ECPT)) {
 		ret = efi_ecpt_register();
 		if (ret != EFI_SUCCESS)
-- 
2.39.5

