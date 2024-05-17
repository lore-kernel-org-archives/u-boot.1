Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0393FC25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9943D88498;
	Fri, 17 May 2024 18:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="u8+KTsgd";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpTgewWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF133883BD; Fri, 17 May 2024 18:33:03 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC6E883E6
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 39A681380113;
 Fri, 17 May 2024 12:33:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 12:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715963580;
 x=1716049980; bh=wjkmgf9J+/fdJ2PwuOHuU0WgzPm/ytasE/GFkqa/ixE=; b=
 u8+KTsgdKQ3SMNIwP6P4EbhzwhI8RM3b0L6/If2OguaJDEnzF2Hxj9VbqOcd6F6S
 A2HlZ5uklBhCQ0j5wDiW7gxNwA/vjpT/cRhlfXhW7pGoDf/QDU+Pxmzx7iVU6Aue
 9IiBOiIl8iIdxs0bt0+VUlqvkShLxZoh2ltv6vE3HES27oDm2c70rSEcwZ73JoDj
 JrUWBOaLeYr9wFmed3ffI7/BhbA/vys1ww8hypIU//q4rAZJ6gJ/0fs653HWT+ar
 aj3PSPOOzebmQddf0W7+d8mJQTqjuZ/jySZm2j+vObJbcW5O2FAp5R9zFjzM980/
 TnDGO2tMQUe0E9gxU0iFPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715963580; x=
 1716049980; bh=wjkmgf9J+/fdJ2PwuOHuU0WgzPm/ytasE/GFkqa/ixE=; b=D
 pTgewWu15lS6AzryEkcsCtf+ZAhj+6KNjiFR4QUu1znIiA1ejgUyjSCLKGQi+WCm
 hkbIsYfApIFLbXeNA9/pGL2ob5uODYXVmO55UfoifvWbVomo6D7dm4xn6roRB2Xz
 dWeHiue1GPf7oCUFNfr+xGRYFzt7osqSOauvLkLtM+I4qViBC6Sm/QL+mu6rTRlp
 hOl8zQJUEwJpmMIw/BQ7ZR2Fp7M3kjCYzaHhIWrP29JD0sv5boOWf9UMWXSO11eN
 ccRcWB+iolvqIj12zZM/ju7hQ0N9sqrE5nw/SRyQJUTBSnr+qIhfCM1R/CnC0JyR
 bfPcHpt++nIpnzUYzETvg==
X-ME-Sender: <xms:u4ZHZgHJQBpLEsv_JW3kCvNcKvdelaPOeXXfuS-K4K6vEAUR3Rc6AQ>
 <xme:u4ZHZpWXDtXTLBmEdCfKflbP4dDgHsKnj-II79QXu_3RspzXhT4yTBkh_QKLZVoKH
 v7swiQYW7Yvc6sPgUo>
X-ME-Received: <xmr:u4ZHZqLAIr6F346LGChESAGB0Dz7Q3xnd-5KrtkokwCCPlciJPnVaWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:vIZHZiH9GIQ9Q8SMTjCfJBcfeOjJCuVdh3FZ-1CTYdjiSPId6GeUQA>
 <xmx:vIZHZmUxv-Z9meht04PxqzLS3lQlpM-F_sWyw_1ETA30FxXkBtnf4w>
 <xmx:vIZHZlNiy6V48wElv7X3bBr5gYFENCmy0Ljz2p6O5gdsSBt2utz2rA>
 <xmx:vIZHZt0AEWM6G9FggqLCF14F1xT6_yrd7zOrAWb3RfWgb8Xxg6iVFQ>
 <xmx:vIZHZoJw5kvKKnHr74nGcdavQza7vaI8LlXDR0naHSk7fof0f4ZyO_Tm>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 12:32:59 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 17:32:53 +0100
Subject: [PATCH 2/7] efi: Allow runtime relocate to be disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
In-Reply-To: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10883;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7qcOntXfyyGxkPxHf7zfVGYxvmOXBYSmjvzfPWzDxvk=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3th22PaeU2ZraVj++LPjzjPmOJg3mPatX+N8/8lptf
 i2n+FeLjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIw2dGhhVHuyQ1PDUC/O7v
 dvlp9+lX5bnKt3vqOo15Tr05tEa88DvD//S9Fc++7U17sdlh6zp9LrELwhHvTi+VlXt/8/Od5/N
 OvWYEAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Allow runtime relocate to be disabled because on MIPS we
never do that. It's guaranteed that OS won't call
set_virtual_address_map and convert_pointer as well.

On MIPS KSEG0 is always mapped to memory and there is no
way to disable it for kernel mode. Both EFI runtime and
kernel lays in this segment, so relocation is totally
unnecessary.

Also U-Boot does not use traditional .dyn.rel to perform
relocation on MIPS, that makes implementation of runtime
relocation pretty hard.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/efi_loader.h              | 26 ++++++++++++++++++--------
 lib/efi_loader/Kconfig            | 10 ++++++++++
 lib/efi_loader/efi_image_loader.c |  1 +
 lib/efi_loader/efi_memory.c       | 14 +++++++++++---
 lib/efi_loader/efi_runtime.c      | 11 ++++++++++-
 lib/efi_loader/efi_var_mem.c      |  6 +++++-
 lib/efi_selftest/Makefile         |  2 +-
 7 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9600941aa327..1ae62906e099 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -31,7 +31,7 @@ static inline void *guidcpy(void *dst, const void *src)
 	return memcpy(dst, src, sizeof(efi_guid_t));
 }
 
-#if CONFIG_IS_ENABLED(EFI_LOADER)
+#if CONFIG_IS_ENABLED(EFI_LOADER) && CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
 
 /**
  * __efi_runtime_data - declares a non-const variable for EFI runtime section
@@ -79,6 +79,23 @@ static inline void *guidcpy(void *dst, const void *src)
  */
 #define __efi_runtime __section(".text.efi_runtime")
 
+/* Call this to relocate the runtime section to an address space */
+void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map);
+
+#else /* CONFIG_IS_ENABLED(EFI_LOADER) && CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE) */
+
+/* Without CONFIG_EFI_LOADER we don't have a runtime section, stub it out */
+#define __efi_runtime_data
+#define __efi_runtime_rodata
+#define __efi_runtime
+
+static inline void efi_runtime_relocate(ulong offset,
+					struct efi_mem_desc *map) {};
+
+#endif /* CONFIG_IS_ENABLED(EFI_LOADER) && CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE) */
+
+#if CONFIG_IS_ENABLED(EFI_LOADER)
+
 /*
  * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO region
  * to make it available at runtime
@@ -101,10 +118,6 @@ efi_status_t efi_launch_capsules(void);
 
 #else /* CONFIG_IS_ENABLED(EFI_LOADER) */
 
-/* Without CONFIG_EFI_LOADER we don't have a runtime section, stub it out */
-#define __efi_runtime_data
-#define __efi_runtime_rodata
-#define __efi_runtime
 static inline efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
 {
 	return EFI_SUCCESS;
@@ -118,7 +131,6 @@ static inline efi_status_t efi_launch_capsules(void)
 {
 	return EFI_SUCCESS;
 }
-
 #endif /* CONFIG_IS_ENABLED(EFI_LOADER) */
 
 #if CONFIG_IS_ENABLED(EFI_BINARY_EXEC)
@@ -641,8 +653,6 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			 struct efi_loaded_image *loaded_image_info);
 /* Called once to store the pristine gd pointer */
 void efi_save_gd(void);
-/* Call this to relocate the runtime section to an address space */
-void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map);
 /* Call this to get image parameters */
 void efi_get_image_parameters(void **img_addr, size_t *img_size);
 /* Add a new object to the object list. */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7dc..bc5ae9086ea2 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -359,6 +359,16 @@ config EFI_UNICODE_CAPITALIZATION
 
 endif
 
+config EFI_RUNTIME_RELOCATE
+	bool "Support relocation for EFI runtime service"
+	depends on ARM || X86 || RISCV || SANDBOX
+	default y
+	help
+	  Select this option to enable relocation for EFI runtime service. It
+	  enables set_virtual_address_map and convert_pointer runtime service.
+	  It is required for OS on most architectures to make use of EFI runtime
+	  services.
+
 config EFI_LOADER_BOUNCE_BUFFER
 	bool "EFI Applications use bounce buffers for DMA operations"
 	depends on ARM64
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 604243603289..cedc4d822fe7 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -50,6 +50,7 @@ static int machines[] = {
 #if defined(__riscv) && (__riscv_xlen == 64)
 	IMAGE_FILE_MACHINE_RISCV64,
 #endif
+
 	0 };
 
 /**
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 12cf23fa3fa8..7a1959d2409a 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -908,8 +908,8 @@ __weak void efi_add_known_memory(void)
  */
 static void add_u_boot_and_runtime(void)
 {
-	unsigned long runtime_start, runtime_end, runtime_pages;
-	unsigned long runtime_mask = EFI_PAGE_MASK;
+	__maybe_unused unsigned long runtime_start, runtime_end, runtime_pages;
+	__maybe_unused unsigned long runtime_mask = EFI_PAGE_MASK;
 	unsigned long uboot_start, uboot_pages;
 	unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
 
@@ -918,7 +918,13 @@ static void add_u_boot_and_runtime(void)
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
 	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
 		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
+	/*
+	 * In case runtime relocate is not enabled just mark whole U-Boot
+	 * as EFI_RUNTIME_SERVICES_CODE because all are required at runtime.
+	 */
+	efi_add_memory_map_pg(uboot_start, uboot_pages,
+			      CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE) ?
+			      EFI_BOOT_SERVICES_CODE : EFI_RUNTIME_SERVICES_CODE,
 			      false);
 
 #if defined(__aarch64__)
@@ -930,6 +936,7 @@ static void add_u_boot_and_runtime(void)
 	runtime_mask = SZ_64K - 1;
 #endif
 
+#if CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
 	/*
 	 * Add Runtime Services. We mark surrounding boottime code as runtime as
 	 * well to fulfill the runtime alignment constraints but avoid padding.
@@ -940,6 +947,7 @@ static void add_u_boot_and_runtime(void)
 	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
 	efi_add_memory_map_pg(runtime_start, runtime_pages,
 			      EFI_RUNTIME_SERVICES_CODE, false);
+#endif
 }
 
 int efi_memory_init(void)
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 011bcd04836d..9a6a131e5695 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -37,6 +37,7 @@ static LIST_HEAD(efi_runtime_mmio);
 
 static efi_status_t __efi_runtime EFIAPI efi_unimplemented(void);
 
+#if (CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE))
 /*
  * TODO(sjg@chromium.org): These defines and structures should come from the ELF
  * header for each architecture (or a generic header) rather than being repeated
@@ -94,6 +95,7 @@ struct elf_rela {
 static __efi_runtime_data struct efi_mem_desc *efi_virtmap;
 static __efi_runtime_data efi_uintn_t efi_descriptor_count;
 static __efi_runtime_data efi_uintn_t efi_descriptor_size;
+#endif
 
 /*
  * EFI runtime code lives in two stages. In the first stage, U-Boot and an EFI
@@ -546,7 +548,7 @@ static efi_status_t __efi_runtime EFIAPI efi_query_capsule_caps_unsupported(
  * Return:	true if the pointer points to a service function pointer in the
  *		runtime table
  */
-static bool efi_is_runtime_service_pointer(void *p)
+static bool __maybe_unused efi_is_runtime_service_pointer(void *p)
 {
 	return (p >= (void *)&efi_runtime_services.get_time &&
 		p <= (void *)&efi_runtime_services.query_variable_info) ||
@@ -574,6 +576,7 @@ void efi_runtime_detach(void)
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 }
 
+#if (CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE))
 /**
  * efi_set_virtual_address_map_runtime() - change from physical to virtual
  *					   mapping
@@ -910,6 +913,7 @@ static efi_status_t EFIAPI efi_set_virtual_address_map(
 out:
 	return EFI_EXIT(ret);
 }
+#endif
 
 /**
  * efi_add_runtime_mmio() - add memory-mapped IO region
@@ -987,8 +991,13 @@ struct efi_runtime_services __efi_runtime_data efi_runtime_services = {
 	.set_time = &efi_set_time_boottime,
 	.get_wakeup_time = (void *)&efi_unimplemented,
 	.set_wakeup_time = (void *)&efi_unimplemented,
+#if (CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE))
 	.set_virtual_address_map = &efi_set_virtual_address_map,
 	.convert_pointer = efi_convert_pointer,
+#else
+	.set_virtual_address_map = (void *)&efi_unimplemented,
+	.convert_pointer = (void *)&efi_unimplemented,
+#endif
 	.get_variable = efi_get_variable,
 	.get_next_variable_name = efi_get_next_variable_name,
 	.set_variable = efi_set_variable,
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 139e16aad7c6..7afad47b9e12 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -201,6 +201,7 @@ u64 __efi_runtime efi_var_mem_free(void)
 	       sizeof(struct efi_var_entry);
 }
 
+#if CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
 /**
  * efi_var_mem_notify_exit_boot_services() - SetVirtualMemoryMap callback
  *
@@ -213,12 +214,13 @@ efi_var_mem_notify_virtual_address_map(struct efi_event *event, void *context)
 	efi_convert_pointer(0, (void **)&efi_var_buf);
 	efi_current_var = NULL;
 }
+#endif
 
 efi_status_t efi_var_mem_init(void)
 {
 	u64 memory;
 	efi_status_t ret;
-	struct efi_event *event;
+	struct efi_event *event __maybe_unused;
 
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
 				 EFI_RUNTIME_SERVICES_DATA,
@@ -232,11 +234,13 @@ efi_status_t efi_var_mem_init(void)
 	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
 			      (uintptr_t)efi_var_buf;
 
+#if CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
 	ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
 			       efi_var_mem_notify_virtual_address_map, NULL,
 			       NULL, &event);
 	if (ret != EFI_SUCCESS)
 		return ret;
+#endif
 	return ret;
 }
 
diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 414701893f65..d707d921bc8e 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -37,7 +37,6 @@ efi_selftest_memory.o \
 efi_selftest_open_protocol.o \
 efi_selftest_register_notify.o \
 efi_selftest_reset.o \
-efi_selftest_set_virtual_address_map.o \
 efi_selftest_startimage_exit.o \
 efi_selftest_startimage_return.o \
 efi_selftest_textinput.o \
@@ -50,6 +49,7 @@ efi_selftest_variables.o \
 efi_selftest_variables_runtime.o \
 efi_selftest_watchdog.o
 
+obj-$(CONFIG_EFI_RUNTIME_RELOCATE) += efi_selftest_set_virtual_address_map.o
 obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
 obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
 

-- 
2.34.1

