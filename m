Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29126C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 20:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9130885A5;
	Fri, 17 May 2024 22:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LbxHil/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298DB885A6; Fri, 17 May 2024 22:19:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A02885A4
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 22:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715977135; x=1716581935; i=xypron.glpk@gmx.de;
 bh=wkF1eOnWXjQT/7HtwIRnWGMNGbvM+7koUTc3fidGWkk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LbxHil/p+rUw/Ssp1u2gOQHYW2+/EniUCO4p/HZdo+G3xgZD6XeOkG7bXr9nEvO+
 01SSb1tOWNSG/W7+7mcrXDoxOjk6Ba2H477V9jQBC8eQTToHTLv/gmug26L2sNW8f
 Pjc+BOXYrb/S0l2cYab/5zpsmb/Gk16RugzS1DyOuNY4mvPcS/1qtwkhHzqFr5GS1
 r3nRZ1pZ1JN6auVpr+F1FIYM44j7uU5gvRb+ejcqzhynqeHdaw6vcAfSsVNgbaJhd
 tUgU4X/vfEpCXktIBLtdE65k5D5Rf4QAiF9/pCaz6SC6Ng/7k8p0m9s+5+b4jVWIA
 LYdNiCcibNywIpgq/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.1.13.130]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1sG07R2fMx-00D2ly; Fri, 17
 May 2024 22:18:54 +0200
Date: Fri, 17 May 2024 20:45:08 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
CC: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/7] efi: Allow runtime relocate to be disabled
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
Message-ID: <2CD8D385-F0A9-4A1B-827D-1C55CD7E32ED@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:El4y25gKoxU/SsNTXOPqekGGoq5R0dtO0PIUDV6BqGWd/KcCCwG
 PCDnAB4I8tnHXUXM2A+6r9DPRdcaEMShEgQDtnAr8cVxKeC92K9Z561f3NNopYU8U7iPrAP
 F13RzzhHPVkbcL+f1zni7zJtNsNR9BTtfHYI/x4nLrWvU2kv/vWYp2heNZenhmj1t/FSwwQ
 YxEVvSXfJenjrlC9dTIGg==
UI-OutboundReport: notjunk:1;M01:P0:uuKwdkZ2Pp0=;3vVsLOpycfd2++/LWNwWOSesjvX
 aSJ1cUh0zVzr900XmE0iAIwxfCoVdOMdr6TujAyGrM0OkRqdtiVNmmLfpwVeYA/De3Cq3SQIa
 7+WD1o828GWStKPXGY8zvC7KaUYItck4VO98saFVxJvOWVwSml5V9Lw8mn1MN7LjQ2I9BJJB+
 Veu2H+Xf+olfvUlepCPjzymLDRi4GNtMRkLi91Keb7sbf5B0QC9ehMBey732kO+UggyzYhkho
 BknU3N/b+CWvhXUpp0BXVoDy+Wj4ANLHoE4yLRZYvdjANICr3OrFCmHir7WCyOR6DK/+t1huL
 Ee6XFA3mZS/CkHrLgapeeunqSLjjqCDjorGY0W3tBbuyu6b1OKEHQXvWOUC43ZNrybu3zK2Uy
 1JDFz7teKgyy9M5EiFi0Sg5xjLpe1RXzixz5BBb7yn7bhcaohrln0KmTnStyuhFdr0MrzmMJK
 GXvjBNfNNTNNKbcEaKXDC1wnNNLCjB4RmPkyAdTuHxs0w6vhSiJuwQF74QEjeXh2Wtlw6hFoj
 G/PACKT94hYc6p1bB3X6mKkUwMNBmUZPauvtXCzUvlYO90Xm9AO6KtkJmhHlHVBtb8epVzCgC
 jIJAN0t1xBci14fWwAk0KlhCJ2fMZdWDJaNRjTHyZE9zUpVYseUaHeacJjE+1DrdnoBpF9C/R
 NBxlFLxQ1WMDEzwbGDFpRHKpxaUCiq9IPOn2gzainGPzYSWlhHNXbAFI3qmv1cqgBnbfGsQyy
 2gjKFXllDabR6jSQkKLuv8UTaTSODEiKQO8eEqQ2vBSwlc6Hzj+x2cyV5E8tUlfZ+BJP4s9zz
 TbGxguHJb2SI6A4/egfT1XHTLDSdSSVho+SpnMjcqlGHI=
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



Am 17=2E Mai 2024 18:32:53 MESZ schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>Allow runtime relocate to be disabled because on MIPS we
>never do that=2E It's guaranteed that OS won't call
>set_virtual_address_map and convert_pointer as well=2E
>
>On MIPS KSEG0 is always mapped to memory and there is no
>way to disable it for kernel mode=2E Both EFI runtime and
>kernel lays in this segment, so relocation is totally
>unnecessary=2E
>
>Also U-Boot does not use traditional =2Edyn=2Erel to perform
>relocation on MIPS, that makes implementation of runtime
>relocation pretty hard=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> include/efi_loader=2Eh              | 26 ++++++++++++++++++--------
> lib/efi_loader/Kconfig            | 10 ++++++++++
> lib/efi_loader/efi_image_loader=2Ec |  1 +
> lib/efi_loader/efi_memory=2Ec       | 14 +++++++++++---
> lib/efi_loader/efi_runtime=2Ec      | 11 ++++++++++-
> lib/efi_loader/efi_var_mem=2Ec      |  6 +++++-
> lib/efi_selftest/Makefile         |  2 +-
> 7 files changed, 56 insertions(+), 14 deletions(-)
>
>diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>index 9600941aa327=2E=2E1ae62906e099 100644
>--- a/include/efi_loader=2Eh
>+++ b/include/efi_loader=2Eh
>@@ -31,7 +31,7 @@ static inline void *guidcpy(void *dst, const void *src)
> 	return memcpy(dst, src, sizeof(efi_guid_t));
> }
>=20
>-#if CONFIG_IS_ENABLED(EFI_LOADER)
>+#if CONFIG_IS_ENABLED(EFI_LOADER) && CONFIG_IS_ENABLED(EFI_RUNTIME_RELOC=
ATE)
>=20
> /**
>  * __efi_runtime_data - declares a non-const variable for EFI runtime se=
ction
>@@ -79,6 +79,23 @@ static inline void *guidcpy(void *dst, const void *src=
)
>  */
> #define __efi_runtime __section("=2Etext=2Eefi_runtime")
>=20
>+/* Call this to relocate the runtime section to an address space */
>+void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map);
>+
>+#else /* CONFIG_IS_ENABLED(EFI_LOADER) && CONFIG_IS_ENABLED(EFI_RUNTIME_=
RELOCATE) */
>+
>+/* Without CONFIG_EFI_LOADER we don't have a runtime section, stub it ou=
t */
>+#define __efi_runtime_data
>+#define __efi_runtime_rodata
>+#define __efi_runtime
>+
>+static inline void efi_runtime_relocate(ulong offset,
>+					struct efi_mem_desc *map) {};
>+
>+#endif /* CONFIG_IS_ENABLED(EFI_LOADER) && CONFIG_IS_ENABLED(EFI_RUNTIME=
_RELOCATE) */
>+
>+#if CONFIG_IS_ENABLED(EFI_LOADER)
>+
> /*
>  * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO regi=
on
>  * to make it available at runtime
>@@ -101,10 +118,6 @@ efi_status_t efi_launch_capsules(void);
>=20
> #else /* CONFIG_IS_ENABLED(EFI_LOADER) */
>=20
>-/* Without CONFIG_EFI_LOADER we don't have a runtime section, stub it ou=
t */
>-#define __efi_runtime_data
>-#define __efi_runtime_rodata
>-#define __efi_runtime
> static inline efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
> {
> 	return EFI_SUCCESS;
>@@ -118,7 +131,6 @@ static inline efi_status_t efi_launch_capsules(void)
> {
> 	return EFI_SUCCESS;
> }
>-
> #endif /* CONFIG_IS_ENABLED(EFI_LOADER) */
>=20
> #if CONFIG_IS_ENABLED(EFI_BINARY_EXEC)
>@@ -641,8 +653,6 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj =
*handle,
> 			 struct efi_loaded_image *loaded_image_info);
> /* Called once to store the pristine gd pointer */
> void efi_save_gd(void);
>-/* Call this to relocate the runtime section to an address space */
>-void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map);
> /* Call this to get image parameters */
> void efi_get_image_parameters(void **img_addr, size_t *img_size);
> /* Add a new object to the object list=2E */
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 430bb7f0f7dc=2E=2Ebc5ae9086ea2 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -359,6 +359,16 @@ config EFI_UNICODE_CAPITALIZATION
>=20
> endif
>=20
>+config EFI_RUNTIME_RELOCATE
>+	bool "Support relocation for EFI runtime service"
>+	depends on ARM || X86 || RISCV || SANDBOX

The sandbox should build on all architectures with EFI support=2E So for t=
he sandbox I guess you should consider the host architecture=2E

>+	default y
>+	help
>+	  Select this option to enable relocation for EFI runtime service=2E It
>+	  enables set_virtual_address_map and convert_pointer runtime service=
=2E
>+	  It is required for OS on most architectures to make use of EFI runtim=
e
>+	  services=2E
>+
> config EFI_LOADER_BOUNCE_BUFFER
> 	bool "EFI Applications use bounce buffers for DMA operations"
> 	depends on ARM64
>diff --git a/lib/efi_loader/efi_image_loader=2Ec b/lib/efi_loader/efi_ima=
ge_loader=2Ec
>index 604243603289=2E=2Ecedc4d822fe7 100644
>--- a/lib/efi_loader/efi_image_loader=2Ec
>+++ b/lib/efi_loader/efi_image_loader=2Ec
>@@ -50,6 +50,7 @@ static int machines[] =3D {
> #if defined(__riscv) && (__riscv_xlen =3D=3D 64)
> 	IMAGE_FILE_MACHINE_RISCV64,
> #endif
>+
> 	0 };
>=20
> /**
>diff --git a/lib/efi_loader/efi_memory=2Ec b/lib/efi_loader/efi_memory=2E=
c
>index 12cf23fa3fa8=2E=2E7a1959d2409a 100644
>--- a/lib/efi_loader/efi_memory=2Ec
>+++ b/lib/efi_loader/efi_memory=2Ec
>@@ -908,8 +908,8 @@ __weak void efi_add_known_memory(void)
>  */
> static void add_u_boot_and_runtime(void)
> {
>-	unsigned long runtime_start, runtime_end, runtime_pages;
>-	unsigned long runtime_mask =3D EFI_PAGE_MASK;
>+	__maybe_unused unsigned long runtime_start, runtime_end, runtime_pages;
>+	__maybe_unused unsigned long runtime_mask =3D EFI_PAGE_MASK;
> 	unsigned long uboot_start, uboot_pages;
> 	unsigned long uboot_stack_size =3D CONFIG_STACK_SIZE;
>=20
>@@ -918,7 +918,13 @@ static void add_u_boot_and_runtime(void)
> 		       uboot_stack_size) & ~EFI_PAGE_MASK;
> 	uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> 		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>-	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
>+	/*
>+	 * In case runtime relocate is not enabled just mark whole U-Boot
>+	 * as EFI_RUNTIME_SERVICES_CODE because all are required at runtime=2E
>+	 */
>+	efi_add_memory_map_pg(uboot_start, uboot_pages,
>+			      CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE) ?
>+			      EFI_BOOT_SERVICES_CODE : EFI_RUNTIME_SERVICES_CODE,
> 			      false);
>=20
> #if defined(__aarch64__)
>@@ -930,6 +936,7 @@ static void add_u_boot_and_runtime(void)
> 	runtime_mask =3D SZ_64K - 1;
> #endif
>=20
>+#if CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
> 	/*
> 	 * Add Runtime Services=2E We mark surrounding boottime code as runtime=
 as
> 	 * well to fulfill the runtime alignment constraints but avoid padding=
=2E
>@@ -940,6 +947,7 @@ static void add_u_boot_and_runtime(void)
> 	runtime_pages =3D (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> 	efi_add_memory_map_pg(runtime_start, runtime_pages,
> 			      EFI_RUNTIME_SERVICES_CODE, false);
>+#endif
> }
>=20
> int efi_memory_init(void)
>diff --git a/lib/efi_loader/efi_runtime=2Ec b/lib/efi_loader/efi_runtime=
=2Ec
>index 011bcd04836d=2E=2E9a6a131e5695 100644
>--- a/lib/efi_loader/efi_runtime=2Ec
>+++ b/lib/efi_loader/efi_runtime=2Ec
>@@ -37,6 +37,7 @@ static LIST_HEAD(efi_runtime_mmio);
>=20
> static efi_status_t __efi_runtime EFIAPI efi_unimplemented(void);
>=20
>+#if (CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE))
> /*
>  * TODO(sjg@chromium=2Eorg): These defines and structures should come fr=
om the ELF
>  * header for each architecture (or a generic header) rather than being =
repeated
>@@ -94,6 +95,7 @@ struct elf_rela {
> static __efi_runtime_data struct efi_mem_desc *efi_virtmap;
> static __efi_runtime_data efi_uintn_t efi_descriptor_count;
> static __efi_runtime_data efi_uintn_t efi_descriptor_size;
>+#endif
>=20
> /*
>  * EFI runtime code lives in two stages=2E In the first stage, U-Boot an=
d an EFI
>@@ -546,7 +548,7 @@ static efi_status_t __efi_runtime EFIAPI efi_query_ca=
psule_caps_unsupported(
>  * Return:	true if the pointer points to a service function pointer in t=
he
>  *		runtime table
>  */
>-static bool efi_is_runtime_service_pointer(void *p)
>+static bool __maybe_unused efi_is_runtime_service_pointer(void *p)
> {
> 	return (p >=3D (void *)&efi_runtime_services=2Eget_time &&
> 		p <=3D (void *)&efi_runtime_services=2Equery_variable_info) ||
>@@ -574,6 +576,7 @@ void efi_runtime_detach(void)
> 	efi_update_table_header_crc32(&efi_runtime_services=2Ehdr);
> }
>=20
>+#if (CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE))
> /**
>  * efi_set_virtual_address_map_runtime() - change from physical to virtu=
al
>  *					   mapping
>@@ -910,6 +913,7 @@ static efi_status_t EFIAPI efi_set_virtual_address_ma=
p(
> out:
> 	return EFI_EXIT(ret);
> }
>+#endif
>=20
> /**
>  * efi_add_runtime_mmio() - add memory-mapped IO region
>@@ -987,8 +991,13 @@ struct efi_runtime_services __efi_runtime_data efi_r=
untime_services =3D {
> 	=2Eset_time =3D &efi_set_time_boottime,
> 	=2Eget_wakeup_time =3D (void *)&efi_unimplemented,
> 	=2Eset_wakeup_time =3D (void *)&efi_unimplemented,
>+#if (CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE))
> 	=2Eset_virtual_address_map =3D &efi_set_virtual_address_map,
> 	=2Econvert_pointer =3D efi_convert_pointer,
>+#else
>+	=2Eset_virtual_address_map =3D (void *)&efi_unimplemented,
>+	=2Econvert_pointer =3D (void *)&efi_unimplemented,
>+#endif
> 	=2Eget_variable =3D efi_get_variable,
> 	=2Eget_next_variable_name =3D efi_get_next_variable_name,
> 	=2Eset_variable =3D efi_set_variable,
>diff --git a/lib/efi_loader/efi_var_mem=2Ec b/lib/efi_loader/efi_var_mem=
=2Ec
>index 139e16aad7c6=2E=2E7afad47b9e12 100644
>--- a/lib/efi_loader/efi_var_mem=2Ec
>+++ b/lib/efi_loader/efi_var_mem=2Ec
>@@ -201,6 +201,7 @@ u64 __efi_runtime efi_var_mem_free(void)
> 	       sizeof(struct efi_var_entry);
> }
>=20
>+#if CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
> /**
>  * efi_var_mem_notify_exit_boot_services() - SetVirtualMemoryMap callbac=
k
>  *
>@@ -213,12 +214,13 @@ efi_var_mem_notify_virtual_address_map(struct efi_e=
vent *event, void *context)
> 	efi_convert_pointer(0, (void **)&efi_var_buf);
> 	efi_current_var =3D NULL;
> }
>+#endif
>=20
> efi_status_t efi_var_mem_init(void)
> {
> 	u64 memory;
> 	efi_status_t ret;
>-	struct efi_event *event;
>+	struct efi_event *event __maybe_unused;
>=20
> 	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> 				 EFI_RUNTIME_SERVICES_DATA,
>@@ -232,11 +234,13 @@ efi_status_t efi_var_mem_init(void)
> 	efi_var_buf->length =3D (uintptr_t)efi_var_buf->var -
> 			      (uintptr_t)efi_var_buf;
>=20
>+#if CONFIG_IS_ENABLED(EFI_RUNTIME_RELOCATE)
> 	ret =3D efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBAC=
K,
> 			       efi_var_mem_notify_virtual_address_map, NULL,
> 			       NULL, &event);
> 	if (ret !=3D EFI_SUCCESS)
> 		return ret;
>+#endif
> 	return ret;
> }
>=20
>diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
>index 414701893f65=2E=2Ed707d921bc8e 100644
>--- a/lib/efi_selftest/Makefile
>+++ b/lib/efi_selftest/Makefile
>@@ -37,7 +37,6 @@ efi_selftest_memory=2Eo \
> efi_selftest_open_protocol=2Eo \
> efi_selftest_register_notify=2Eo \
> efi_selftest_reset=2Eo \
>-efi_selftest_set_virtual_address_map=2Eo \
> efi_selftest_startimage_exit=2Eo \
> efi_selftest_startimage_return=2Eo \
> efi_selftest_textinput=2Eo \
>@@ -50,6 +49,7 @@ efi_selftest_variables=2Eo \
> efi_selftest_variables_runtime=2Eo \
> efi_selftest_watchdog=2Eo
>=20
>+obj-$(CONFIG_EFI_RUNTIME_RELOCATE) +=3D efi_selftest_set_virtual_address=
_map=2Eo
> obj-$(CONFIG_EFI_ECPT) +=3D efi_selftest_ecpt=2Eo
> obj-$(CONFIG_NETDEVICES) +=3D efi_selftest_snp=2Eo
>=20
>
