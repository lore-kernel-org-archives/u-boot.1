Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D9DC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D07280F98;
	Tue, 25 Feb 2025 00:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GR01cnQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF2E80F67; Tue, 25 Feb 2025 00:08:07 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F19280F67
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-854a68f5afcso132684339f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438481; x=1741043281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nc+bI3IddQtJu5bc+00Ci4B/sc+hoxyEZKD6N2BCdNs=;
 b=GR01cnQnUVNRNsalpurI/KluL/bfHyY85kNImt0xeeaVMtAFM6bVwqAI7spusCE0/U
 Nkt4bzZzGZRIBqzXgTELKB29Y3WjVHRT1nszy04773R+MGGmXlMlS7c6xIkMNbV+mzBB
 /wlE4tqWCxT0Z0CiWRCRhzsw8R5SO8VNL0xaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438481; x=1741043281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nc+bI3IddQtJu5bc+00Ci4B/sc+hoxyEZKD6N2BCdNs=;
 b=hGLsv78mm+PNEDmkAVymnaTUOkPk4UpS4s7ldUMeaFaE3nySLTn4s9UaQMFKRRXbHh
 sfSS/sDd7mHJXjV1hM9XlOa/7KMBcTlrcVHE6+tPzaVHuS1bN8IQi8trfdSRZg87CkaO
 XNhcbMlptK/RmujATrt7i/NXN9oaSSEErDVO7jBghineaTvlS4TANq5njhWQVtXPCr3y
 k8EP5cAyswsW2PoYesZtQkPlLlxBVsuSskp6+lGrfKxK4vJhppCDqgpyobnxT8l4DZa/
 em7KBYeazMszBlAG8GTYKsMzhkFpCMH6PMxr1wQ1YRgchzUfLhELv/1G3sIsYPkEBvnk
 ITBg==
X-Gm-Message-State: AOJu0Yzx0a5i321pzL5s7/NqaAjK0pEbZpC+SXNx9cbCGVj5Rd/zYL9p
 LnPFqljas0Z/KDVnGqdHMCLjaivk3EiM3IzvvhNPAAIZANUd2MEJo9Kzq+S92RhOcdLBCyIgVc0
 =
X-Gm-Gg: ASbGnctB9fRULL4hIJ5fk8vVLe1E13jdklo5+bZsMJuV+MA9JYgJdWlm5dK5g+k5bxk
 X0y2nM+ZLpiEyGw3swKyY4Wm/NZgEGVki5MEQ+aBO/G9NnTmzrk8ASEq/e3aVL1oOg6kVDQWSqW
 5bZWYM+Q1QEgZIZwMWXWGZXxV0TRwjJxUO1kUH537VIUdXDi7s5UJzgqvN8jMeazP8db94ULSfR
 SiOIT7yOwICEzUWH0WKafHbAxUX+FLbHKc2IB2206Qf9xE+lMHBzKzLKD3juNTCBt4fx3FYhlry
 PoUGZw073GK1uRNUzVbykvHeQyg3RK4wmZXfvrts2F8jG0Jpd6HAN2QmGOpeWcQ=
X-Google-Smtp-Source: AGHT+IEADTEXQ//XrRM2kOv/Jv6uqnV9Uq/pOoV83ys7jMOAla88RHw3DIds8t5VlYYHSsyCzNmUCg==
X-Received: by 2002:a05:6602:14d3:b0:855:bd9c:7175 with SMTP id
 ca18e2360f4ac-856203c12a0mr151289439f.12.1740438481423; 
 Mon, 24 Feb 2025 15:08:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 30/44] x86: e820: Add a function to dump the e820 table
Date: Mon, 24 Feb 2025 16:06:19 -0700
Message-ID: <20250224230640.2665206-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

