Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C2D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5428914D;
	Sun,  1 Dec 2024 16:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dk2icMIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C2C88D51; Sun,  1 Dec 2024 16:28:45 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C968914D
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-84183532291so130608039f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066916; x=1733671716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHqI92O/TPj5I/NxW1Fha5h+iyyjwWm1PiXb1JyrxrI=;
 b=dk2icMIXE4vi2n4KclTdqwseui59n0FN3BiudTa1wpNl9D3LRijD4mYhRkO4pjlNwZ
 B4lT5A7ZQtuiGlUwXX9wjbP2tGwAqBNvl9gHiVeJX9FZGStpxPX1mdqLzZFkkRZlyp0+
 gOJxkVmwIVPM6dnQ1KbjxPKEDKvQbupopWtB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066916; x=1733671716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHqI92O/TPj5I/NxW1Fha5h+iyyjwWm1PiXb1JyrxrI=;
 b=jeF3vq5b3qsZ9rFuWGsxs1sop9PTzIY8EHVtPtSOsywiErl4owTVXUrp34r+TfpVie
 XkNxMYDcZ6FBvLWvqXKTTBsjFXOx/sev8QTohMXE1dj93yRPbjFKJQB6x61HILAyiI0K
 cjXLCJltm759dVgEd886zm2D6oTQ5iPiPwVP+nNEo8hP6dJejlpN/Q/k/VuL5kEI8BXM
 q8sgb5eEPV9dnsAUUdYv6T6Rn8944ldX3T+Ob36eCcUJqZQ0jL2QwBCD7yVQA1/A7amv
 cV/xB/okcz5VyB2J++V2k33ZhXsEbxZjbL9PRURYfnRNFK+7S0V8i/gafQFRw8R9nnqw
 DPHQ==
X-Gm-Message-State: AOJu0YzcWeygVb72UOes8ik4TpCF1wJah+9bDUvonZmDSSLsZpFiKWC9
 UDp/spnoOQegJQ3JB3KwAPhuwVArukd//SNhMes6oJS+A079lc6rnFd5+5Rujuv/8lJ9kCPK724
 =
X-Gm-Gg: ASbGncuu9uXqInSYz5ddKQhsexmWgO5oKedIyfLAHxUydBuwMfbLI4SMkUah9FrLJx8
 Ag4YntkX8ptCNopnvO41golL36BWgKq1zdiiAbWp/wlAUJ5Wh6gPAzu0fSvNSmYxYdokVH76Ums
 rF7KtRVu0gVgLR7pKQVsX2az6fpC5apwoBeO54heBeuPSOAkeRyAJc9lgCY1s1hl9zvVLi97178
 v29ieORMcAXhDU0NOdChjEdNk0e/Wcp8BXEPyjPguPK
X-Google-Smtp-Source: AGHT+IH1V0aQ9s2prLDoh/i97r6IstO04gvZA1Xh6yz+aYvy3Uffh0tsk8/SBBIBIaIhzxdfO7QsLQ==
X-Received: by 2002:a05:6602:3fcb:b0:83a:b52b:5cbb with SMTP id
 ca18e2360f4ac-843ecfd9e48mr2298221139f.5.1733066915859; 
 Sun, 01 Dec 2024 07:28:35 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 9/9] efi: Keep early allocations to the U-Boot region
Date: Sun,  1 Dec 2024 08:28:11 -0700
Message-ID: <20241201152815.1668093-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

Adjust EFI_LOADER to use the provided region for early memory
allocations, to avoid going outside the U-Boot region.

Expand the available memory when efi_init_obj_list() is called.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Rebase on top of efil and efik series
- Reword cover letter a little

Changes in v4:
- Use a different technique to keep the memory-usage in place
- Drop changes to pool allocation
- Reorder the patches
- Rewrite the cover letter
- Make it a debug message for now

Changes in v2:
- Drop patch 'Show more information in efi index'
- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
- Add the word 'warning', use log_warning() and show the end address

 include/efi_loader.h        | 13 +++++++++++++
 lib/efi_loader/efi_memory.c | 24 ++++++++++++++++++++++--
 lib/efi_loader/efi_setup.c  |  5 +++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index a0af0db6262..600dfc2b48c 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -871,6 +871,19 @@ int efi_disk_probe(void *ctx, struct event *event);
 int efi_disk_remove(void *ctx, struct event *event);
 /* Called by board init to initialize the EFI memory map */
 int efi_memory_init(void);
+
+/**
+ * efi_memory_coop() - Allow EFI to use all available memory
+ *
+ * Up until this function is called, only a small portion of memory is available
+ * for use by the EFI memory-allocator. This function is called at the
+ * 'point of cooperation', before jumping into an EFI app, which needs to be
+ * able to make use of all the memory in the machine
+ *
+ * Return: efi_status_t (EFI_SUCCESS on success)
+ */
+int efi_memory_coop(void);
+
 /* Adds new or overrides configuration table entry to the system table */
 efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
 /* Sets up a loaded image */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 344656c4eb0..88ef111dc70 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -32,6 +32,9 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 #define EFI_EARLY_REGION_SIZE	SZ_256K
 
+/* Set when all memory has been added for use by EFI */
+static bool efi_full_memory;
+
 efi_uintn_t efi_memory_map_key;
 
 /**
@@ -832,8 +835,25 @@ static void add_u_boot_and_runtime(void)
 
 int efi_memory_init(void)
 {
-	efi_add_known_memory();
+	efi_status_t ret;
+
+	/* restrict EFI to its own region until efi_memory_coop() is called */
+	ret = efi_add_memory_map_pg(gd->efi_region,
+				    EFI_EARLY_REGION_SIZE >> EFI_PAGE_SHIFT,
+				    EFI_CONVENTIONAL_MEMORY, false);
+
+	return ret;
+}
 
+int efi_memory_coop(void)
+{
+	if (efi_full_memory)
+		return 0;
+	log_debug("Enabling coop memory\n");
+
+	efi_full_memory = true;
+
+	efi_add_known_memory();
 	add_u_boot_and_runtime();
 
 #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
@@ -843,7 +863,7 @@ int efi_memory_init(void)
 	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
 			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
 			       &efi_bounce_buffer_addr) != EFI_SUCCESS)
-		return -1;
+		return -ENOMEM;
 
 	efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
 #endif
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 468156db813..c68f3ff0748 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -228,6 +228,11 @@ efi_status_t efi_init_obj_list(void)
 	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
 		return efi_obj_list_initialized;
 
+	/* Allow EFI to use all memory */
+	ret = efi_memory_coop();
+	if (ret != EFI_SUCCESS)
+		goto out;
+
 	/* Set up console modes */
 	efi_setup_console_size();
 
-- 
2.43.0

