Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8016D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDC7893FA;
	Fri, 11 Oct 2024 23:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PAQ8rDCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60A6893EC; Fri, 11 Oct 2024 23:23:46 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D7F3893DA
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so8007555ab.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728681823; x=1729286623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwNVWWybQFBd3j/dkMaJHg5S9menwyKZzi/Lk2dRQs8=;
 b=PAQ8rDCBclbuDYQrxtl8qcZshthIWOwfYc0PbiCbvYsykk374z7b2jW6w2cvgpvhfS
 6S5BeMUzKt1/8DN0KHe8Veitn3oOWlUJXTlborRDRdmH2Tpp6HVd2r6pXkdnNsrttZnM
 Nsk/rhfn9jEe5XfNP+jwUHqohd2xRP5606gVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728681823; x=1729286623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwNVWWybQFBd3j/dkMaJHg5S9menwyKZzi/Lk2dRQs8=;
 b=Cp87ugm8OgxGcJAX5YdSkDVr388f5ATOyQQ3fK2O4rL1iBQe40RnGDRYTaXKmmfUSn
 Niw0S04cEPUlQ+QLFyzXaTbjmN0vIANyyNPAe9Yj0lqKoUpe+b3gTEOadphLoDX+FGHU
 lBW0jcP8yxDG5OM7r7WM5tpFzhfls0GtrB7hB01eerSu/1+3JTqIJhbvVmtZU9MqAPzX
 KzK7ALDSGMaB2MSirj5FZVDeg6eJupwZNJDbDadtLmiCZLRLZtQuSU8BcBKEouQxqjq7
 7cmNnf3rfGBfmWd86VjkLDzyJpHZIPu42oAlhfbx5l+ERAdzzrijPCwyVZLXgFifkKF0
 EmHw==
X-Gm-Message-State: AOJu0YxKPS9Rh9QIT9vAOFyBactJFPuVgLzrw9C7rWpGlPcfS4mm2z+D
 IaznNmsuNzguzP+u7BpkXJoxQr6k7QcJUS4oy1+256U2/ypInXma5sP3ZyTAFNX59J9HB05SVCy
 rrg==
X-Google-Smtp-Source: AGHT+IH6+KwDf8XFtB0P/NZe7gL2ubinpFJXXyCCYbUwETuqgWfPjVCnkgLO9zcu+d5gyFtd2fOvCQ==
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a3b6009616mr31115725ab.24.1728681822928; 
 Fri, 11 Oct 2024 14:23:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b13e5sm784789173.1.2024.10.11.14.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:23:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 5/5] efi: Keep early allocations to the U-Boot region
Date: Fri, 11 Oct 2024 15:21:26 -0600
Message-Id: <20241011212126.747741-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011212126.747741-1-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
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
index 08e27e61b06..aa464e9d754 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -805,6 +805,19 @@ int efi_disk_probe(void *ctx, struct event *event);
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
index 9cc33397371..2cd0b00e9eb 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -30,6 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 #define EFI_EARLY_REGION_SIZE	SZ_256K
 
+/* Set when all memory has been added for use by EFI */
+static bool efi_full_memory;
+
 efi_uintn_t efi_memory_map_key;
 
 struct efi_mem_list {
@@ -932,8 +935,25 @@ static void add_u_boot_and_runtime(void)
 
 int efi_memory_init(void)
 {
-	efi_add_known_memory();
+	efi_status_t ret;
+
+	/* restrict EFI to its own region until efi_memory_coop() is called */
+	ret = efi_add_memory_map_pg((ulong)map_sysmem(gd->efi_region, 0),
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
@@ -943,7 +963,7 @@ int efi_memory_init(void)
 	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
 			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
 			       &efi_bounce_buffer_addr) != EFI_SUCCESS)
-		return -1;
+		return -ENOMEM;
 
 	efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
 #endif
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index a610e032d2f..40e23ca104c 100644
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
2.34.1

