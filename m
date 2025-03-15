Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEE9C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E80C81D1F;
	Sat, 15 Mar 2025 15:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lNjUVzVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C647780F70; Sat, 15 Mar 2025 15:28:21 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B489B81ED8
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43948021a45so6380755e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048897; x=1742653697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnQvkjxejgtQsoJZCMItWFnO0NC3anMrsLYmvnDNxZ4=;
 b=lNjUVzVzWN2qZiA8UhOZNo74j2urNf7QD01EVIOSOxjTWDFOglBrrenn53h/ELha6A
 wOUaXDFOFq/QtwZ5gzhNRiYW+f4MtifinV1D8yBSazDRzs6u8ccCAm6S6Y6O4IWOg34x
 EePMmD9GmWBQRZ1KzoPeI41t3PRe3Az36xsz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048897; x=1742653697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnQvkjxejgtQsoJZCMItWFnO0NC3anMrsLYmvnDNxZ4=;
 b=j46zhnOV+2EdQlUWrz+BoDjCsw2sUjGMaw7jJp+K9JxN+YbuiffL6ImbsjW0bCePNn
 QTNoofahw4E0vgIwS6gzLSpaAXU9lsfdXB7jzjfkbuioQbVPWOheJto5+PNkOi6admmB
 JWINb6po4oskuS4HYDUWRKP26+9HAl7GSjKojoSUvhrGNC1rIRTp2sXESBCelygsLF6l
 7WBleXMchIT9x8PD6Y3GahAs0t5BN58gmCTsrZel7nTqsXlgeku1PtGM7RUe3utoudEa
 ZNLW5L/tAKCvt8O91SD9hCq/7ywd2rw2J7/oqTHGD2y4ZEksmQbfMshqs6CTGFaA9Nsk
 3rEw==
X-Gm-Message-State: AOJu0YygbZkARGtiPwsNPDyGYnZuyjF2nAR8aODX1zHRKFIcf1Edw5mD
 PJO8cve0PC5OkYyrW1xy/vKEk8T+9kTc65gmJbVzHHY/B8LwjfeyNYNC4SqzvMJui3OewmbFbNv
 ZwA==
X-Gm-Gg: ASbGnctXYNjuKc2gv+Fw/R0HR501jQUiip7MYN3T+PL97ukaX0HGAyCJWGPZJly1yET
 P0SQqyVJOwtJNnW9ZETI4pGJ3EZRhKfQDOpjdO54Fu2CFiOJr4fMSTEhIkq9p9I/YLP467FTbZ7
 D5J8lcm7cojG2xuOKC44c+GmpgpA/gqqPGD5f8lxgO4dlY4NnuXQ15RSIPsE/uJB31EntJZ1kGe
 i8QW7I//l439Ko7bjQd4cHjOBWR0PWNJO9T17QEzvQnGdoMvWMayWr3iz0Cv6FkekeVX+957dnt
 8y8rQg4ki6tw4qjWPXZJU7zVv6w7SUm1YSEoG/yDHqEJ/AM8KuCk
X-Google-Smtp-Source: AGHT+IFC+pYPD6WYbSP9ZzB1H/6Nn69DA+pWZIdqcSDIA+1qIvdvOjkAtTVSzMsaK6cw8LPpBmg5bA==
X-Received: by 2002:a05:600c:3b02:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43d1ecd2dbamr86234835e9.29.1742048897215; 
 Sat, 15 Mar 2025 07:28:17 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 32/46] x86: e820: Add a function to dump the e820 table
Date: Sat, 15 Mar 2025 14:25:52 +0000
Message-ID: <20250315142643.2600605-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

