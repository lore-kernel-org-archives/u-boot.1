Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6077D59D90
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 10:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B5F896C8;
	Tue, 26 Nov 2024 11:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h1Nq9jaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2894896CF; Tue, 26 Nov 2024 11:17:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6857D896C1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732616215; x=1733221015; i=xypron.glpk@gmx.de;
 bh=jdTt5BnCBEZ+tZG7omVqnFYfroP+EXu0JG9xSkC4g+g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h1Nq9jaX9ko5wndoLK6NXwilO9/+LDnr1mLLz/gd45Cd2OFlMmzDjoNrBSto1doo
 Ry//M9Fgc80guzY7dkwGneaKvdzczLgEi6o8xHNMSqST0CA/OJNAmO33mA8MOhkqD
 FdTyfWYIzFjYc4lP8GS8xgwYm2dt4uZ66HOsYVQt390HIkCv47dJrTs0ek5LAdROO
 bEKve7/n0FLjiT/ldM+EAN4qcrW2xAAxtgvvXxBQIownchyw8U7sXf0EIO5BPu4zO
 kpFk0GHc567GSS8w12WXATWGNLk3QCwO7ZI8mGoLE6Fooks4FosOOrFaYPageaaHh
 ZRq9jSMWAuU5j551cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1tLgiG3CKl-00GEVE; Tue, 26
 Nov 2024 11:16:55 +0100
Message-ID: <ba686354-41a7-413f-aaae-77e286277510@gmx.de>
Date: Tue, 26 Nov 2024 11:16:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] efi_loader: Tidy up use of addresses
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qOs42xJM9LaRJha0F42owalqaz82jnqm8aTu9Opr1X0HvvCRIcg
 sQuhM996fgRBjuFvmIBiHuH7SnXQQPEj4KMXGMrKQQJaY/lykzIntX2iW+7+1WILVST32sa
 qqplolb7jesi/7oeh5Ioa5Ad4Cn1k9P5VkH3tr9yz/7VIlMr1povTnADtn2nxNJcwbu/LEh
 Ps4gXXEBukp9zLyxnaDHA==
UI-OutboundReport: notjunk:1;M01:P0:3Dc8kKde8q0=;nLiVVbrHIk3s6kTALnsNhXOqKta
 t8uvlorcFFbInVHF0XIAXQ/4kWtNmNC5tDsRkI0lnMW1QCWGkeqg7T7C0z5kHCrZAWysUtA7P
 6/EirXV3/2n+L+dojFk3bqwNoWhdPDX6t7Ho3uK5YbOsP+lb40+hAmDfStXo4kmlgLisQ+AnR
 mpmTsYsbG+fjl8b9s8bJyCG53/QGzqJ/7qipaaLHwOVDBhH8w3iJFjpc1kPuR2OGe2ACx0/Hb
 jXKcL8zMFHmQjdYhgNhhP4xq7hU/m9z0ICWDEobZ91qz2gRbMjSYWTijlT42YIB0pSxNCU1jc
 Wkbrfo9NfCrCoc6LKj+0o8eA7W8+cWKkGPpjWKQq5bKVHdYL1G9LgBes+bP6lg+TVltVe5k+H
 ItVhKvQE1Q+jTRXba4Y5FWwXUpyW8SRy/DpkXHInRhzb/rQttVr+8LUSHMUatiqaaNqXVyaHj
 +dkVPSf9eaIJs/yS9Lj7C5qVI8cLpiGz1BiD2Iv6bvgNLeBeqYdNW8cQ01pv12zcNPaISk1WN
 WohgJSDoirNPOEnZt+XWKvQjJv6KS7yf+bjON1VSdgWZ3k9epgM1yhKChODrw6vdq6HIbwFl6
 F2+MIZwNALV61hyoTylbhthZW9zNRw68N9uvuZSsb/W8O908aZm83aVq4nsutZzswMtvoEJ1Z
 0JHPdc7PAKE+s1984rZoIhQEN0NpwdgM3odZ4gzI5IdeD435QqRzXepQkhDoj0QiuqtMtiA09
 38GEiF9QcMKHvpJj4J2qiVQjtUbnf8BRYNGV6xMmXxAvjIKTGYuuxQXgArwobwK8iraSkxwiR
 ghSo5j7k83bLSeiTI4ct+IcyBwi9lnqMyCG50cxpGYF5mycbwuNnNmDaY6ym38PnDJyPSTUwo
 bf1bJhRlylQBcsh2jfjAsmReFo6i1hfpIXI4wHnMyUXirKy29l+QbRKh7jWfdLX2FKb26DG7d
 E2uk8QeOl97wVb42uu0XyU55BI7HYJx2oHvKdiPV2o2T2Nr9ndOv1HZqaiHg9qoVbj2rV9xfN
 yhMfMjyju+3hGdhRCiNZcCoSLG6YfuTub2iRKbdJs3TXzPy/JcN9d8gNzyVeKwqFrtVa9ydLN
 PmtABsbHaTcbFVc/SLJwXqTkSe9cgZ
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

On 25.11.24 21:44, Simon Glass wrote:
> The EFI loader's memory implementation is quite confusing. The EFI spec
> requires that addresses are used in the calls to allocate_pages(), etc.
> This is unavoidable.
>
> This usage then filters down to various functions within the
> implementation. This is unfortunate, as there is no clear separation
> between addresses and pointers. In some parts of the code things become
> hopelessly confusing, and several bugs have crept in.
>
> Adjust the internal functions to always use a ulong for an address or a
> void * for a pointer.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/efi_loader.h              | 13 +++--
>   lib/efi_loader/efi_bootmgr.c      |  9 ++--
>   lib/efi_loader/efi_boottime.c     | 37 ++++++++------
>   lib/efi_loader/efi_helper.c       |  7 +--
>   lib/efi_loader/efi_image_loader.c |  2 +-
>   lib/efi_loader/efi_memory.c       | 84 +++++++++++++------------------
>   lib/efi_loader/efi_var_mem.c      |  6 +--
>   7 files changed, 76 insertions(+), 82 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index cae94fc4661..c4afcf2b60b 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -791,7 +791,7 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memo=
ry_type mem_type,
>    */
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>   				enum efi_memory_type mem_type,
> -				efi_uintn_t pages, uint64_t *memoryp);
> +				efi_uintn_t pages, void **memoryp);
>
>   /**
>    * efi_free_pages() - free memory pages
> @@ -800,7 +800,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>    * @pages:	number of pages to be freed
>    * Return:	status code
>    */
> -efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages);
> +efi_status_t efi_free_pages(void *memory, efi_uintn_t pages);

Read the UEFI spec, please.

FreePages() expects EFI_PHYSICAL_ADDRESS which is defined as

typedef UINT64 EFI_PHYSICAL_ADDRESS;

Best regards

Heinrich

>
>   /**
>    * efi_allocate_pool - allocate memory from pool
> @@ -833,7 +833,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_=
map_size,
>
>   /**
>    * efi_add_memory_map() - Add a range into the EFI memory map
> - * @start: start address, must be a multiple of EFI_PAGE_SIZE
> + * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note tha=
t this
> + *	is an address, not a pointer. Use map_sysmem(start) to convert to a
> + *	pointer
>    * @size: Size, in bytes
>    * @mem_type: EFI type of memory added
>    * Return: status code
> @@ -844,8 +846,9 @@ efi_status_t efi_add_memory_map(ulong start, ulong s=
ize,
>   /**
>    * efi_add_memory_map_pg() - add pages to the memory map
>    *
> - * @start:			start address, must be a multiple of
> - *				EFI_PAGE_SIZE
> + * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note tha=
t this
> + *	is an address, not a pointer. Use map_sysmem(start) to convert to a
> + *	pointer
>    * @pages:			number of pages to add
>    * @mem_type:		EFI type of memory added
>    * @overlap_conventional:	region may only overlap free(conventional)
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8c51a6ef2ed..9e42fa03921 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -14,6 +14,7 @@
>   #include <efi.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <mapmem.h>
>   #include <net.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
> @@ -497,6 +498,7 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   	 * If the file is PE-COFF image, load the downloaded file.
>   	 */
>   	uri_len =3D strlen(uridp->uri);
> +	source_buffer =3D map_sysmem(image_addr, image_size);
>   	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
>   	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
>   		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
> @@ -506,7 +508,8 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>
>   		source_buffer =3D NULL;
>   		source_size =3D 0;
> -	} else if (efi_check_pe((void *)image_addr, image_size, NULL) =3D=3D E=
FI_SUCCESS) {
> +	} else if (efi_check_pe(source_buffer, image_size, NULL) =3D=3D
> +			EFI_SUCCESS) {
>   		/*
>   		 * loaded_dp must exist until efi application returns,
>   		 * will be freed in return_to_efibootmgr event callback.
> @@ -518,7 +521,6 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   		if (ret !=3D EFI_SUCCESS)
>   			goto err;
>
> -		source_buffer =3D (void *)image_addr;
>   		source_size =3D image_size;
>   	} else {
>   		log_err("Error: file type is not supported\n");
> @@ -1297,8 +1299,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>   	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
>   		free(fdt_lo);
>   		if (fdt_distro)
> -			efi_free_pages((uintptr_t)fdt_distro,
> -				       efi_size_in_pages(fdt_size));
> +			efi_free_pages(fdt_distro, efi_size_in_pages(fdt_size));
>   	}
>
>   	if (ret !=3D EFI_SUCCESS) {
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index efd9577c9d0..5ad80ff49cb 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -13,6 +13,7 @@
>   #include <irq_func.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <mapmem.h>
>   #include <pe.h>
>   #include <time.h>
>   #include <u-boot/crc.h>
> @@ -431,9 +432,15 @@ static efi_status_t EFIAPI efi_allocate_pages_ext(e=
num efi_allocate_type type,
>   						  uint64_t *memoryp)
>   {
>   	efi_status_t r;
> +	void *ptr;
>
> +	/* we should not read this unless type indicates it is being used */
> +	if (type =3D=3D EFI_ALLOCATE_MAX_ADDRESS || type =3D=3D EFI_ALLOCATE_A=
DDRESS)
> +		ptr =3D (void *)(ulong)*memoryp;
>   	EFI_ENTRY("%d, %d, 0x%zx, %p", type, mem_type, pages, memoryp);
> -	r =3D efi_allocate_pages(type, mem_type, pages, memoryp);
> +	r =3D efi_allocate_pages(type, mem_type, pages, &ptr);
> +	*memoryp =3D (ulong)ptr;
> +
>   	return EFI_EXIT(r);
>   }
>
> @@ -455,7 +462,7 @@ static efi_status_t EFIAPI efi_free_pages_ext(uint64=
_t memory,
>   	efi_status_t r;
>
>   	EFI_ENTRY("%llx, 0x%zx", memory, pages);
> -	r =3D efi_free_pages(memory, pages);
> +	r =3D efi_free_pages((void *)(ulong)memory, pages);
>   	return EFI_EXIT(r);
>   }
>
> @@ -1951,8 +1958,8 @@ efi_status_t efi_load_image_from_file(struct efi_d=
evice_path *file_path,
>   {
>   	struct efi_file_handle *f;
>   	efi_status_t ret;
> -	u64 addr;
>   	efi_uintn_t bs;
> +	void *ptr;
>
>   	/* Open file */
>   	f =3D efi_file_from_path(file_path);
> @@ -1971,17 +1978,17 @@ efi_status_t efi_load_image_from_file(struct efi=
_device_path *file_path,
>   	 */
>   	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>   				 EFI_BOOT_SERVICES_DATA,
> -				 efi_size_in_pages(bs), &addr);
> +				 efi_size_in_pages(bs), &ptr);
>   	if (ret !=3D EFI_SUCCESS) {
>   		ret =3D EFI_OUT_OF_RESOURCES;
>   		goto error;
>   	}
>
>   	/* Read file */
> -	EFI_CALL(ret =3D f->read(f, &bs, (void *)(uintptr_t)addr));
> +	EFI_CALL(ret =3D f->read(f, &bs, ptr));
>   	if (ret !=3D EFI_SUCCESS)
> -		efi_free_pages(addr, efi_size_in_pages(bs));
> -	*buffer =3D (void *)(uintptr_t)addr;
> +		efi_free_pages(ptr, efi_size_in_pages(bs));
> +	*buffer =3D ptr;
>   	*size =3D bs;
>   error:
>   	EFI_CALL(f->close(f));
> @@ -2009,9 +2016,10 @@ efi_status_t efi_load_image_from_path(bool boot_p=
olicy,
>   	struct efi_device_path *dp, *rem;
>   	struct efi_load_file_protocol *load_file_protocol =3D NULL;
>   	efi_uintn_t buffer_size;
> -	uint64_t addr, pages;
> +	ulong pages;
>   	const efi_guid_t *guid;
>   	struct efi_handler *handler;
> +	void *ptr;
>
>   	/* In case of failure nothing is returned */
>   	*buffer =3D NULL;
> @@ -2045,20 +2053,20 @@ efi_status_t efi_load_image_from_path(bool boot_=
policy,
>   		goto out;
>   	pages =3D efi_size_in_pages(buffer_size);
>   	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_BOOT_SERVICES_=
DATA,
> -				 pages, &addr);
> +				 pages, &ptr);
>   	if (ret !=3D EFI_SUCCESS) {
>   		ret =3D EFI_OUT_OF_RESOURCES;
>   		goto out;
>   	}
>   	ret =3D EFI_CALL(load_file_protocol->load_file(
>   					load_file_protocol, rem, boot_policy,
> -					&buffer_size, (void *)(uintptr_t)addr));
> +					&buffer_size, ptr));
>   	if (ret !=3D EFI_SUCCESS)
> -		efi_free_pages(addr, pages);
> +		efi_free_pages(ptr, pages);
>   out:
>   	efi_close_protocol(device, guid, efi_root, NULL);
>   	if (ret =3D=3D EFI_SUCCESS) {
> -		*buffer =3D (void *)(uintptr_t)addr;
> +		*buffer =3D ptr;
>   		*size =3D buffer_size;
>   	}
>
> @@ -2121,8 +2129,7 @@ efi_status_t EFIAPI efi_load_image(bool boot_polic=
y,
>   		ret =3D efi_load_pe(*image_obj, dest_buffer, source_size, info);
>   	if (!source_buffer)
>   		/* Release buffer to which file was loaded */
> -		efi_free_pages((uintptr_t)dest_buffer,
> -			       efi_size_in_pages(source_size));
> +		efi_free_pages(dest_buffer, efi_size_in_pages(source_size));
>   	if (ret =3D=3D EFI_SUCCESS || ret =3D=3D EFI_SECURITY_VIOLATION) {
>   		info->system_table =3D &systab;
>   		info->parent_handle =3D parent_image;
> @@ -3322,7 +3329,7 @@ close_next:
>   		}
>   	}
>
> -	efi_free_pages((uintptr_t)loaded_image_protocol->image_base,
> +	efi_free_pages(loaded_image_protocol->image_base,
>   		       efi_size_in_pages(loaded_image_protocol->image_size));
>   	efi_delete_handle(&image_obj->header);
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..1c264eabff9 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -456,7 +456,6 @@ static efi_status_t copy_fdt(void **fdtp)
>   	unsigned long fdt_ram_start =3D -1L, fdt_pages;
>   	efi_status_t ret =3D 0;
>   	void *fdt, *new_fdt;
> -	u64 new_fdt_addr;
>   	uint fdt_size;
>   	int i;
>
> @@ -480,17 +479,15 @@ static efi_status_t copy_fdt(void **fdtp)
>   	fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
>
>   	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> -				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
> -				 &new_fdt_addr);
> +				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages, &new_fdt);
>   	if (ret !=3D EFI_SUCCESS) {
>   		log_err("Failed to reserve space for FDT\n");
>   		goto done;
>   	}
> -	new_fdt =3D (void *)(uintptr_t)new_fdt_addr;
>   	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
>   	fdt_set_totalsize(new_fdt, fdt_size);
>
> -	*fdtp =3D (void *)(uintptr_t)new_fdt_addr;
> +	*fdtp =3D new_fdt;
>   done:
>   	return ret;
>   }
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index 0ddf69a0918..9bd77048adf 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -970,7 +970,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj=
 *handle,
>   	/* Run through relocations */
>   	if (efi_loader_relocate(rel, rel_size, efi_reloc,
>   				(unsigned long)image_base) !=3D EFI_SUCCESS) {
> -		efi_free_pages((uintptr_t) efi_reloc,
> +		efi_free_pages(efi_reloc,
>   			       (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
>   		ret =3D EFI_LOAD_ERROR;
>   		goto err;
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 4e9c372b622..f687e49c98e 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -418,9 +418,9 @@ static efi_status_t efi_check_allocated(ulong addr, =
bool must_be_allocated)
>
>   efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>   				enum efi_memory_type mem_type,
> -				efi_uintn_t pages, uint64_t *memory)
> +				efi_uintn_t pages, void **memoryp)
>   {
> -	ulong efi_addr, len;
> +	ulong len;
>   	uint flags;
>   	efi_status_t ret;
>   	phys_addr_t addr;
> @@ -428,7 +428,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   	/* Check import parameters */
>   	if (mem_type >=3D EFI_PERSISTENT_MEMORY_TYPE && mem_type <=3D 0x6ffff=
fff)
>   		return EFI_INVALID_PARAMETER;
> -	if (!memory)
> +	if (!memoryp)
>   		return EFI_INVALID_PARAMETER;
>   	len =3D (ulong)pages << EFI_PAGE_SHIFT;
>   	/* Catch possible overflow on 64bit systems */
> @@ -447,18 +447,18 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>   		break;
>   	case EFI_ALLOCATE_MAX_ADDRESS:
>   		/* Max address */
> -		addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
> +		addr =3D map_to_sysmem(*memoryp);
>   		addr =3D (u64)lmb_alloc_base_flags(len, EFI_PAGE_SIZE, addr,
>   						 flags);
>   		if (!addr)
>   			return EFI_OUT_OF_RESOURCES;
>   		break;
>   	case EFI_ALLOCATE_ADDRESS:
> -		if (*memory & EFI_PAGE_MASK)
> +		addr =3D map_to_sysmem(*memoryp);
> +		if (addr & EFI_PAGE_MASK)
>   			return EFI_NOT_FOUND;
>
> -		addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
> -		addr =3D (u64)lmb_alloc_addr_flags(addr, len, flags);
> +		addr =3D lmb_alloc_addr_flags(addr, len, flags);
>   		if (!addr)
>   			return EFI_NOT_FOUND;
>   		break;
> @@ -467,42 +467,33 @@ efi_status_t efi_allocate_pages(enum efi_allocate_=
type type,
>   		return EFI_INVALID_PARAMETER;
>   	}
>
> -	efi_addr =3D (u64)(uintptr_t)map_sysmem(addr, 0);
>   	/* Reserve that map in our memory maps */
> -	ret =3D efi_add_memory_map_pg(efi_addr, pages, mem_type, true);
> +	ret =3D efi_add_memory_map_pg(addr, pages, mem_type, true);
>   	if (ret !=3D EFI_SUCCESS) {
>   		/* Map would overlap, bail out */
>   		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> -		unmap_sysmem((void *)(uintptr_t)efi_addr);
> -		return  EFI_OUT_OF_RESOURCES;
> +		return EFI_OUT_OF_RESOURCES;
>   	}
>
> -	*memory =3D efi_addr;
> +	*memoryp =3D map_sysmem(addr, len);
>
>   	return EFI_SUCCESS;
>   }
>
> -/**
> - * efi_free_pages() - free memory pages
> - *
> - * @memory:	start of the memory area to be freed
> - * @pages:	number of pages to be freed
> - * Return:	status code
> - */
> -efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> +efi_status_t efi_free_pages(void *memory, efi_uintn_t pages)
>   {
> -	ulong len;
> +	ulong addr, len;
>   	long status;
>   	efi_status_t ret;
>
> -	ret =3D efi_check_allocated(memory, true);
> +	addr =3D map_to_sysmem(memory);
> +	ret =3D efi_check_allocated(addr, true);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>
>   	/* Sanity check */
> -	if (!memory || (memory & EFI_PAGE_MASK) || !pages) {
> -		printf("%s: illegal free 0x%llx, 0x%zx\n", __func__,
> -		       memory, pages);
> +	if (!addr || (addr & EFI_PAGE_MASK) || !pages) {
> +		printf("%s: illegal free %lx, %zx\n", __func__, addr, pages);
>   		return EFI_INVALID_PARAMETER;
>   	}
>
> @@ -512,12 +503,11 @@ efi_status_t efi_free_pages(uint64_t memory, efi_u=
intn_t pages)
>   	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
>   	 * it back to an address LMB understands
>   	 */
> -	status =3D lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), le=
n,
> -				LMB_NOOVERWRITE);
> +	status =3D lmb_free_flags(map_to_sysmem(memory), len, LMB_NOOVERWRITE)=
;
>   	if (status)
>   		return EFI_NOT_FOUND;
>
> -	unmap_sysmem((void *)(uintptr_t)memory);
> +	unmap_sysmem(memory);
>
>   	return ret;
>   }
> @@ -528,9 +518,9 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_memo=
ry_type mem_type,
>   	ulong req_pages =3D efi_size_in_pages(len);
>   	ulong true_pages =3D req_pages + efi_size_in_pages(align) - 1;
>   	ulong free_pages;
> -	ulong aligned_mem;
> +	void *aligned_ptr;
>   	efi_status_t r;
> -	u64 mem;
> +	void *ptr;
>
>   	/* align must be zero or a power of two */
>   	if (align & (align - 1))
> @@ -542,35 +532,35 @@ void *efi_alloc_aligned_pages(u64 len, enum efi_me=
mory_type mem_type,
>
>   	if (align < EFI_PAGE_SIZE) {
>   		r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
> -				       req_pages, &mem);
> -		return (r =3D=3D EFI_SUCCESS) ? (void *)(uintptr_t)mem : NULL;
> +				       req_pages, &ptr);
> +		return (r =3D=3D EFI_SUCCESS) ? ptr : NULL;
>   	}
>
>   	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type,
> -			       true_pages, &mem);
> +			       true_pages, &ptr);
>   	if (r !=3D EFI_SUCCESS)
>   		return NULL;
>
> -	aligned_mem =3D ALIGN(mem, align);
> +	aligned_ptr =3D (void *)ALIGN((ulong)ptr, align);
>   	/* Free pages before alignment */
> -	free_pages =3D efi_size_in_pages(aligned_mem - mem);
> +	free_pages =3D efi_size_in_pages(aligned_ptr - ptr);
>   	if (free_pages)
> -		efi_free_pages(mem, free_pages);
> +		efi_free_pages(ptr, free_pages);
>
>   	/* Free trailing pages */
>   	free_pages =3D true_pages - (req_pages + free_pages);
>   	if (free_pages) {
> -		mem =3D aligned_mem + req_pages * EFI_PAGE_SIZE;
> -		efi_free_pages(mem, free_pages);
> +		ptr =3D aligned_ptr + req_pages * EFI_PAGE_SIZE;
> +		efi_free_pages(ptr, free_pages);
>   	}
>
> -	return (void *)(uintptr_t)aligned_mem;
> +	return aligned_ptr;
>   }
>
>   efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uint=
n_t size, void **buffer)
>   {
>   	efi_status_t r;
> -	u64 addr;
> +	void *ptr;
>   	struct efi_pool_allocation *alloc;
>   	ulong num_pages =3D efi_size_in_pages(size +
>   					  sizeof(struct efi_pool_allocation));
> @@ -584,9 +574,9 @@ efi_status_t efi_allocate_pool(enum efi_memory_type =
mem_type, efi_uintn_t size,
>   	}
>
>   	r =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, mem_type, num_pages,
> -			       &addr);
> +			       &ptr);
>   	if (r =3D=3D EFI_SUCCESS) {
> -		alloc =3D (struct efi_pool_allocation *)(uintptr_t)addr;
> +		alloc =3D ptr;
>   		alloc->num_pages =3D num_pages;
>   		alloc->checksum =3D checksum(alloc);
>   		*buffer =3D alloc->data;
> @@ -617,7 +607,7 @@ efi_status_t efi_free_pool(void *buffer)
>   	if (!buffer)
>   		return EFI_INVALID_PARAMETER;
>
> -	ret =3D efi_check_allocated((uintptr_t)buffer, true);
> +	ret =3D efi_check_allocated(map_to_sysmem(buffer), true);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>
> @@ -632,7 +622,7 @@ efi_status_t efi_free_pool(void *buffer)
>   	/* Avoid double free */
>   	alloc->checksum =3D 0;
>
> -	ret =3D efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> +	ret =3D efi_free_pages(alloc, alloc->num_pages);
>
>   	return ret;
>   }
> @@ -788,14 +778,10 @@ int efi_memory_init(void)
>
>   #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>   	/* Request a 32bit 64MB bounce buffer region */
> -	uint64_t efi_bounce_buffer_addr =3D 0xffffffff;
> -
>   	if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DA=
TA,
>   			       (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> -			       &efi_bounce_buffer_addr) !=3D EFI_SUCCESS)
> +			       &efi_bounce_buffer) !=3D EFI_SUCCESS)
>   		return -1;
> -
> -	efi_bounce_buffer =3D (void*)(uintptr_t)efi_bounce_buffer_addr;
>   #endif
>
>   	return 0;
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 139e16aad7c..f3f8a25642d 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -216,17 +216,17 @@ efi_var_mem_notify_virtual_address_map(struct efi_=
event *event, void *context)
>
>   efi_status_t efi_var_mem_init(void)
>   {
> -	u64 memory;
> +	void *ptr;
>   	efi_status_t ret;
>   	struct efi_event *event;
>
>   	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>   				 EFI_RUNTIME_SERVICES_DATA,
>   				 efi_size_in_pages(EFI_VAR_BUF_SIZE),
> -				 &memory);
> +				 &ptr);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
> -	efi_var_buf =3D (struct efi_var_file *)(uintptr_t)memory;
> +	efi_var_buf =3D ptr;
>   	memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
>   	efi_var_buf->magic =3D EFI_VAR_FILE_MAGIC;
>   	efi_var_buf->length =3D (uintptr_t)efi_var_buf->var -

