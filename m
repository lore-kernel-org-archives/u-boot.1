Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABAAC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB78181D65;
	Thu,  6 Mar 2025 17:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FNpb+QaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371DF81D25; Thu,  6 Mar 2025 17:05:59 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42C181D6C
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85ae65ba2f1so22170539f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277155; x=1741881955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnQvkjxejgtQsoJZCMItWFnO0NC3anMrsLYmvnDNxZ4=;
 b=FNpb+QaXpL2SBkh+bhhuVHKLNYF40cRs1JHMbP/mA77+Z9HG90cmxEjJuhfJUYcxkK
 M9BFZAqUHeRqjMmK7/gS+ty9oiDORnybH1tShdQ0zkUKzuU5Clbn/gx0Z7sRp4V0aGdF
 +9D1WMVmL1hYYpH2B9lY0uvz67RMOJMvtKdXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277155; x=1741881955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnQvkjxejgtQsoJZCMItWFnO0NC3anMrsLYmvnDNxZ4=;
 b=oRb4NLUQURiSFiuxlBiBdFr7pW1vbHjveLmMfErTZwJ3j+VNkBYc1Q+7V3mDti2LI/
 IqniXjZqUFq7HFdPNT6UNAgT0t43tac6s+C6kqqwiRAgMAYinJ1eMXOfcDgKdzi7K7GQ
 kHO3UiHAwVUv/X80MHMPDK8doyNb2/gkJil2qR99IOiwXsYsEHujU9oiWaYplIAfiABX
 L8n+JxiDvHi+WXf5biyyuSy9Sj5Cjj8ksdvaBok9gRWgEa2q5lD0e+mRHqPGmOkljb53
 2ueLl5pftMmphH2L1ozjJeTXajulHEHjzj9roVapvtzDLC+Dmm+lsw1MnTSxxHd5CnzM
 mZ1Q==
X-Gm-Message-State: AOJu0YwEu+CARCLbDIOjfqvlNbyuRKp2wieVNPTl4WFygrBuMqany3aS
 oIv+1GF03v9NRXhQwn2xM0oeYucdvP0sbIrNx/mwKYUNpuGdsscN1kR1VhrBNfWPdopA1b1bnRA
 =
X-Gm-Gg: ASbGncvC/mVW3FiIonae6O8JiNqo3Um+wNl6kFyFWy+s/L418BjMSvQ5J/hWpvLUaam
 TcvGBsspdXgKkwOD4gEeJrkBK9RICf6FN5zUI310qGQhdSqS/NqZYOTN2s3/K1VzrvxFpA3azDs
 iWtpxUmg9bTKDZo83Iyxay537b4aowj9pl87zEyGnxHuqShG5fQaNKBvP9jFXYJg93ibqxt8W4E
 PWdsn8Ggd2/d6Ni3QlHekgulmzGQKlyxAhbTxTOV2Upq9OTQjtLqneKuQmawBiCPIfpZytct5tb
 ngq5CF6RkZJlSx6/6/qY6jYeUANQVvdZHVHZ47qqgvnQ3O/+HahpfL9tiwp9q/sxm3ZwHuzVURq
 iXWN8OA==
X-Google-Smtp-Source: AGHT+IEMNAN7gjTOqr6uzNXuMi8A3LnMckAsvh9w6HMui+G5dBqknO0LKqRriPffc5nX64pHV+lN4w==
X-Received: by 2002:a05:6602:3982:b0:855:690e:ed8f with SMTP id
 ca18e2360f4ac-85b1d031e24mr3793339f.12.1741277154912; 
 Thu, 06 Mar 2025 08:05:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 32/47] x86: e820: Add a function to dump the e820 table
Date: Thu,  6 Mar 2025 09:03:59 -0700
Message-ID: <20250306160428.3041057-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

There is already code for this in zimage. Move it to the e820 file so
it can be used elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch with a function to dump the e820 table

 arch/x86/include/asm/e820.h |  8 ++++++++
 arch/x86/lib/e820.c         | 23 +++++++++++++++++++++++
 arch/x86/lib/zimage.c       | 22 ++--------------------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/e820.h b/arch/x86/include/asm/e820.h
index 1ab709abfc8..cc3758b59fd 100644
--- a/arch/x86/include/asm/e820.h
+++ b/arch/x86/include/asm/e820.h
@@ -39,6 +39,14 @@ unsigned int install_e820_map(unsigned int max_entries,
 unsigned int cb_install_e820_map(unsigned int max_entries,
 				 struct e820_entry *entries);
 
+/**
+ * e820_dump() - Dump an e820 table
+ *
+ * @entries: Pointer to first entry
+ * @count: Number of entries in the table
+ */
+void e820_dump(struct e820_entry *entries, uint count);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_E820_H */
diff --git a/arch/x86/lib/e820.c b/arch/x86/lib/e820.c
index d478b7486e3..00ca94776d2 100644
--- a/arch/x86/lib/e820.c
+++ b/arch/x86/lib/e820.c
@@ -10,6 +10,29 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static const char *const e820_type_name[E820_COUNT] = {
+	[E820_RAM] = "RAM",
+	[E820_RESERVED] = "Reserved",
+	[E820_ACPI] = "ACPI",
+	[E820_NVS] = "ACPI NVS",
+	[E820_UNUSABLE] = "Unusable",
+};
+
+void e820_dump(struct e820_entry *entries, uint count)
+{
+	int i;
+
+	printf("%12s  %10s  %s\n", "Addr", "Size", "Type");
+	for (i = 0; i < count; i++) {
+		struct e820_entry *entry = &entries[i];
+
+		printf("%12llx  %10llx  %s\n", entry->addr, entry->size,
+		       entry->type < E820_COUNT ?
+		       e820_type_name[entry->type] :
+		       simple_itoa(entry->type));
+	}
+}
+
 /*
  * Install a default e820 table with 4 entries as follows:
  *
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 26d623711bc..3ffc7593f87 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -475,14 +475,6 @@ static void print_num64(const char *name, u64 value)
 	printf("%-20s: %llx\n", name, value);
 }
 
-static const char *const e820_type_name[E820_COUNT] = {
-	[E820_RAM] = "RAM",
-	[E820_RESERVED] = "Reserved",
-	[E820_ACPI] = "ACPI",
-	[E820_NVS] = "ACPI NVS",
-	[E820_UNUSABLE] = "Unusable",
-};
-
 static const char *const bootloader_id[] = {
 	"LILO",
 	"Loadlin",
@@ -570,24 +562,14 @@ void zimage_dump(struct bootm_info *bmi, bool show_cmdline)
 {
 	struct boot_params *base_ptr;
 	struct setup_header *hdr;
-	int i;
 
 	base_ptr = bmi->base_ptr;
 	printf("Setup located at %p:\n\n", base_ptr);
 	print_num64("ACPI RSDP addr", base_ptr->acpi_rsdp_addr);
 
 	printf("E820: %d entries\n", base_ptr->e820_entries);
-	if (base_ptr->e820_entries) {
-		printf("%12s  %10s  %s\n", "Addr", "Size", "Type");
-		for (i = 0; i < base_ptr->e820_entries; i++) {
-			struct e820_entry *entry = &base_ptr->e820_map[i];
-
-			printf("%12llx  %10llx  %s\n", entry->addr, entry->size,
-			       entry->type < E820_COUNT ?
-			       e820_type_name[entry->type] :
-			       simple_itoa(entry->type));
-		}
-	}
+	if (base_ptr->e820_entries)
+		e820_dump(base_ptr->e820_map, base_ptr->e820_entries);
 
 	hdr = &base_ptr->hdr;
 	print_num("Setup sectors", hdr->setup_sects);
-- 
2.43.0

