Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADEBEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A5C89199;
	Wed, 11 Sep 2024 08:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="RT0dZsqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9F88918E; Wed, 11 Sep 2024 08:25:41 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2CB89199
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d43657255so463584566b.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035939; x=1726640739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMDHw7L+Ju8HxEXMxMRbBnxMUtJH8UpArzmiGFqk988=;
 b=RT0dZsqSmo36Mpwc+c11BJz89z1mruiMQvn6RgY5ndMZ/F5FY3HIC0tYYH30F5hCvU
 HWvEAnRcsh7j6K+KeQJLDWORq4Z4pniYS5+/9GvDenrnH/5Dry2iVwBtZ8OsEibAWxtn
 2277gPUg9ssmZzLVYG/9rjlVHyZBtI6IE9lS6+jSMnUW8wyAo6PedGG+w6NW0PF9HODq
 fPfV/StV2FXRCJAl2breTCEI4QdsYohRZZPtn2b4wcuo3BXHqlFpEkJK/oBODY3jXeJ0
 qS/JBde/9ug/MmreWkqP7ACAgNj4QogDcqyPkG9BqLXYAQwdgIHaNmdTkod3bVaBcZCB
 qasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035939; x=1726640739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMDHw7L+Ju8HxEXMxMRbBnxMUtJH8UpArzmiGFqk988=;
 b=QuRDMjaZSSUv9OiwtK0VrfIgK2nEOUboOqFQS8ak1K3GIR+0ZQYYT2VKoKViNqKwod
 glmBIKvjajqfnkZA55hSjsQk6dQ7BDzMHEoeSeZVBban2DcOOOxgjqAM0ERUjCLp/zGF
 XEdlDZwYpSexqUV+eemWjJyWxSPVq9bwM1OIswpJuIANsZyBgd/7+LcHr5eLDB5RsBVM
 hluqTrR2rUp+45wXZfUCyucvqm4Q6eYhvSTA+XJVTL1+WQH2eVFD3/3CAPKVRA4tRQEH
 Pb7yi8aed7n9PjJtdtnira/o+vlq6SX1NMNEio03Ic32r3eXUtsva4BNh1LLWbddLgwr
 LR3A==
X-Gm-Message-State: AOJu0YxnmdhUXPGP9DOUQ3LmuetgxFy4g5JoEmpxWJi/Pdm5Fp71Rd0c
 0jN3fQMtZQ5x5ebZMWSSzQUlfqtWXaOrF7CdPqMzqL/f02SZYwWzfvpuuFIMxt1z0t+7PIXfUzU
 i
X-Google-Smtp-Source: AGHT+IGJFWtRMz3OwdMwnuCNOKJxZQQEbYfA5dkX35SEQ8kuajlJi14L/szrfMIrXc5IRcXQ+j8+WA==
X-Received: by 2002:a17:907:9808:b0:a8a:ead3:8515 with SMTP id
 a640c23a62f3a-a8ffae0bc2fmr245149566b.65.1726035939119; 
 Tue, 10 Sep 2024 23:25:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:38 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/30] acpi: Move function prototype
Date: Wed, 11 Sep 2024 08:24:02 +0200
Message-ID: <20240911062511.494855-13-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

Allow other architectures to use acpi_create_mcfg_mmconfig as well
by moving the function prototype to common code.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/x86/include/asm/acpi_table.h |  2 --
 include/acpi/acpi_table.h         | 13 +++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index 3254bbc380..ff60384e62 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -31,8 +31,6 @@ int acpi_create_madt_irqoverride(struct acpi_madt_irqoverride *irqoverride,
 				 u8 bus, u8 source, u32 gsirq, u16 flags);
 int acpi_create_madt_lapic_nmi(struct acpi_madt_lapic_nmi *lapic_nmi,
 			       u8 cpu, u16 flags, u8 lint);
-int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
-			      u16 seg_nr, u8 start, u8 end);
 
 /**
  * acpi_write_hpet() - Write out a HPET table
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 82128c14d2..3dd24b520d 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -994,6 +994,19 @@ int acpi_get_table_revision(enum acpi_tables table);
  */
 int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar_flags flags);
 
+/**
+ * acpi_create_mcfg_mmconfig() - Create a MCFG table entry
+ *
+ * @mmconfig: Place to put the table
+ * @base: Base address of the ECAM space
+ * @seg_nr: PCI segment number
+ * @start: PCI bus start number
+ * @end: PCI bus end number
+ * Return: size of data written in bytes
+ */
+int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
+			      u16 seg_nr, u8 start, u8 end);
+
 /**
  * acpi_create_dbg2() - Create a DBG2 table
  *
-- 
2.46.0

