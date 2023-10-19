Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89302CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBAA7871F6;
	Thu, 19 Oct 2023 17:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bN241BPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A987871C6; Thu, 19 Oct 2023 17:28:33 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A7C871F6
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7b3d33663so108189487b3.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697729304; x=1698334104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8X1KZ1FK99qw3wJW7wD0NIiohd4nOct/8O4RKMZXQ/Q=;
 b=bN241BPgV7Vdwc1Jow1GRtpbcC4U9S1OLwoq4wneC6m0m73ufePULtqk3mK9GmxB36
 5WpWBiedmY1OUFfcPmpP3+HNAJtPKOT+d/W54h1LGJHe1ZSZmG8XncdA2TMaS2y6BUQo
 BMwgSY2Nh1wJPczkE1x4jwXzP4YfZEK7b6vUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697729304; x=1698334104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8X1KZ1FK99qw3wJW7wD0NIiohd4nOct/8O4RKMZXQ/Q=;
 b=bHqij48kKIv9K6N7eswMN7OirMOWJ7VxPu6ufGtFZK3TmcR8T8t+AI9rS+6c6AduYs
 nIsreIJRK0LGRoopNze4EeUk1LWvzPkQkHUi4zx8nrhIeaMmMltOJePwjr+6jKkzDxBj
 jKUkMRWC8w3cU0mFqF/MWl0fCvJdNISVIskqLBPW+gTIVdeWXww6HVgYC89Baf5oY4+M
 wbWPKDzaHuA8OHxRk/ZkRbTVvJZIOrtsY980x6ycbjt/tjtKk9HNgOfILI08KfdGwy0I
 iBOsW/hr91dBDbiN9A/+hfSZEmpX9X5YtHr8keZi1m/AvzemhS3L1nWnNa34f/qdO9TD
 HDSg==
X-Gm-Message-State: AOJu0Yw7GW0TZBtKTFbdov5x2X8OPmjWY2mAJbB3w1KGMKl7/oAY8MWs
 ZKXza513TmZar1WB0+7OjoRXtQ==
X-Google-Smtp-Source: AGHT+IG15s+G7l25yEdBcvnmtIfqbXejNFZriRWyWT4HHw/RDqo+uosItPpCris0fjxo4GBHnkyqnA==
X-Received: by 2002:a81:6f04:0:b0:594:e2e6:25e8 with SMTP id
 k4-20020a816f04000000b00594e2e625e8mr2453874ywc.48.1697729304061; 
 Thu, 19 Oct 2023 08:28:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v194-20020a8148cb000000b0057a918d6644sm2488760ywa.128.2023.10.19.08.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:28:23 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:28:21 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Message-ID: <20231019152821.GD3119521@bill-the-cat>
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-11-trini@konsulko.com>
 <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
 <20231019151933.GC3119521@bill-the-cat>
 <5f4d1fd6-3f6f-4c68-a65b-ac4ab43f0490@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CKxE+g6drjFgPIdr"
Content-Disposition: inline
In-Reply-To: <5f4d1fd6-3f6f-4c68-a65b-ac4ab43f0490@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--CKxE+g6drjFgPIdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 05:24:33PM +0200, Heinrich Schuchardt wrote:
> On 19.10.23 17:19, Tom Rini wrote:
> > On Thu, Oct 19, 2023 at 05:16:28PM +0200, Heinrich Schuchardt wrote:
> > > On 19.10.23 17:00, Tom Rini wrote:
> > > > From: Simon Glass <sjg@chromium.org>
> > > >=20
> > > > The command should not be used to enable library functionality. Add=
 a
> > > > new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that=
 the
> > > > same code is built.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Changes in v4:
> > > > - Integrate AKASHI Takahiro's feedback from v3
> > > > - Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
> > > > ---
> > > >    cmd/Kconfig             | 11 ++++++++++-
> > > >    lib/efi_loader/Kconfig  |  6 +++---
> > > >    lib/efi_loader/Makefile |  2 +-
> > > >    3 files changed, 14 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index 16e5cb8f0633..872cb49150cc 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -379,6 +379,15 @@ config CMD_BOOTEFI
> > > >    	help
> > > >    	  Boot an EFI image from memory.
> > > > +config CMD_BOOTEFI_BOOTMGR
> > > > +	bool "UEFI Boot Manager command"
> > > > +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> > > > +	default y
> > > > +	help
> > > > +	  Select this option to enable the 'bootmgr' subcommand of 'boote=
fi'.
> > > > +	  This subcommand will allow you to select the UEFI binary to be =
booted
> > > > +	  via UEFI variables Boot####, BootOrder, and BootNext.
> > > > +
> > > >    config CMD_BOOTEFI_HELLO_COMPILE
> > > >    	bool "Compile a standard EFI hello world binary for testing"
> > > >    	depends on CMD_BOOTEFI && !CPU_V7M
> > > > @@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
> > > >    config CMD_EFICONFIG
> > > >    	bool "eficonfig - provide menu-driven uefi variables maintenanc=
e interface"
> > > >    	default y if !HAS_BOARD_SIZE_LIMIT
> > > > -	depends on CMD_BOOTEFI_BOOTMGR
> > > > +	depends on BOOTEFI_BOOTMGR
> > > >    	select MENU
> > > >    	help
> > > >    	  Enable the 'eficonfig' command which provides the menu-driven=
 UEFI
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index d20aaab6dba4..13cad6342c36 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -32,14 +32,14 @@ config EFI_LOADER
> > > >    if EFI_LOADER
> > > > -config CMD_BOOTEFI_BOOTMGR
> > > > +config BOOTEFI_BOOTMGR
> > > >    	bool "UEFI Boot Manager"
> > > >    	default y
> > > >    	select BOOTMETH_GLOBAL if BOOTSTD
> > > >    	help
> > > >    	  Select this option if you want to select the UEFI binary to b=
e booted
> > > > -	  via UEFI variables Boot####, BootOrder, and BootNext. This enab=
les the
> > > > -	  'bootefi bootmgr' command.
> > > > +	  via UEFI variables Boot####, BootOrder, and BootNext. You shoul=
d also
> > > > +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is avai=
lable.
> > > >    choice
> > > >    	prompt "Store for non-volatile UEFI variables"
> > > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > > > index 8d31fc61c601..0a2cb6e3c476 100644
> > > > --- a/lib/efi_loader/Makefile
> > > > +++ b/lib/efi_loader/Makefile
> > > > @@ -42,7 +42,7 @@ targets +=3D initrddump.o
> > > >    endif
> > > >    obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
> > > > -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > > > +obj-$(CONFIG_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
> > > >    obj-y +=3D efi_boottime.o
> > > >    obj-y +=3D efi_helper.o
> > > >    obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D efi_capsule.o
> > >=20
> > > This patch looks wrong.
> > >=20
> > > Symbol CONFIG_CMD_BOOTEFI_BOOTMGR is used in a lot of places where it=
 is not
> > > related to the 'bootefi bootmgr' subcommand.
> > >=20
> > > I see no benefit in two separate symbols. If you want to rename the s=
ymbol,
> > > please, replace *all* occurrences:
> > >=20
> > > %s/CONFIG_CMD_BOOTEFI_BOOTMGR/CONFIG_BOOTEFI_BOOTMGR/
> >=20
> > Yes, there's work on the EFI_LOADER side of things to support the use
> > case of "boot to menu" (or, "boot to efi bootmgr") of which this is the
> > starting point. The follow-up work that I'm hoping you or someone else
> > with more EFI_LOADER experience will pick up is splitting cmd/bootefi.c
> > such that we can call in to starting an EFI payload (or bootmgr) without
> > the command line.
> >=20
>=20
> Even after factoring out the boot functionality I would not know why we
> should have two separate symbols. I am fine with a rename which makes it
> clear that this symbol is about a library functionality.

Because there's the library functionality and there's the literal
command code. If you're arguing that long term we should have the
command side of all library functionality be automatic based on
CMDLINE=3Dy/CMDLINE=3Dn, that's another discussion for later.  This just
start the split.  I had made a very very rough pass at starting the
split:

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33a4..fe4f3b4fe4bc 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -27,379 +27,6 @@
 #include <asm-generic/sections.h>
 #include <linux/linkage.h>
=20
-DECLARE_GLOBAL_DATA_PTR;
-
-static struct efi_device_path *bootefi_image_path;
-static struct efi_device_path *bootefi_device_path;
-static void *image_addr;
-static size_t image_size;
-
-/**
- * efi_get_image_parameters() - return image parameters
- *
- * @img_addr:		address of loaded image in memory
- * @img_size:		size of loaded image
- */
-void efi_get_image_parameters(void **img_addr, size_t *img_size)
-{
-	*img_addr =3D image_addr;
-	*img_size =3D image_size;
-}
-
-/**
- * efi_clear_bootdev() - clear boot device
- */
-static void efi_clear_bootdev(void)
-{
-	efi_free_pool(bootefi_device_path);
-	efi_free_pool(bootefi_image_path);
-	bootefi_device_path =3D NULL;
-	bootefi_image_path =3D NULL;
-	image_addr =3D NULL;
-	image_size =3D 0;
-}
-
-/**
- * efi_set_bootdev() - set boot device
- *
- * This function is called when a file is loaded, e.g. via the 'load' comm=
and.
- * We use the path to this file to inform the UEFI binary about the boot d=
evice.
- *
- * @dev:		device, e.g. "MMC"
- * @devnr:		number of the device, e.g. "1:2"
- * @path:		path to file loaded
- * @buffer:		buffer with file loaded
- * @buffer_size:	size of file loaded
- */
-void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
-		     void *buffer, size_t buffer_size)
-{
-	struct efi_device_path *device, *image;
-	efi_status_t ret;
-
-	log_debug("dev=3D%s, devnr=3D%s, path=3D%s, buffer=3D%p, size=3D%zx\n", d=
ev,
-		  devnr, path, buffer, buffer_size);
-
-	/* Forget overwritten image */
-	if (buffer + buffer_size >=3D image_addr &&
-	    image_addr + image_size >=3D buffer)
-		efi_clear_bootdev();
-
-	/* Remember only PE-COFF and FIT images */
-	if (efi_check_pe(buffer, buffer_size, NULL) !=3D EFI_SUCCESS) {
-		if (IS_ENABLED(CONFIG_FIT) &&
-		    !fit_check_format(buffer, IMAGE_SIZE_INVAL)) {
-			/*
-			 * FIT images of type EFI_OS are started via command
-			 * bootm. We should not use their boot device with the
-			 * bootefi command.
-			 */
-			buffer =3D 0;
-			buffer_size =3D 0;
-		} else {
-			log_debug("- not remembering image\n");
-			return;
-		}
-	}
-
-	/* efi_set_bootdev() is typically called repeatedly, recover memory */
-	efi_clear_bootdev();
-
-	image_addr =3D buffer;
-	image_size =3D buffer_size;
-
-	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
-	if (ret =3D=3D EFI_SUCCESS) {
-		bootefi_device_path =3D device;
-		if (image) {
-			/* FIXME: image should not contain device */
-			struct efi_device_path *image_tmp =3D image;
-
-			efi_dp_split_file_path(image, &device, &image);
-			efi_free_pool(image_tmp);
-		}
-		bootefi_image_path =3D image;
-		log_debug("- boot device %pD\n", device);
-		if (image)
-			log_debug("- image %pD\n", image);
-	} else {
-		log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
-		efi_clear_bootdev();
-	}
-}
-
-/**
- * efi_env_set_load_options() - set load options from environment variable
- *
- * @handle:		the image handle
- * @env_var:		name of the environment variable
- * @load_options:	pointer to load options (output)
- * Return:		status code
- */
-static efi_status_t efi_env_set_load_options(efi_handle_t handle,
-					     const char *env_var,
-					     u16 **load_options)
-{
-	const char *env =3D env_get(env_var);
-	size_t size;
-	u16 *pos;
-	efi_status_t ret;
-
-	*load_options =3D NULL;
-	if (!env)
-		return EFI_SUCCESS;
-	size =3D sizeof(u16) * (utf8_utf16_strlen(env) + 1);
-	pos =3D calloc(size, 1);
-	if (!pos)
-		return EFI_OUT_OF_RESOURCES;
-	*load_options =3D pos;
-	utf8_utf16_strcpy(&pos, env);
-	ret =3D efi_set_load_options(handle, size, *load_options);
-	if (ret !=3D EFI_SUCCESS) {
-		free(*load_options);
-		*load_options =3D NULL;
-	}
-	return ret;
-}
-
-#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
-
-/**
- * copy_fdt() - Copy the device tree to a new location available to EFI
- *
- * The FDT is copied to a suitable location within the EFI memory map.
- * Additional 12 KiB are added to the space in case the device tree needs =
to be
- * expanded later with fdt_open_into().
- *
- * @fdtp:	On entry a pointer to the flattened device tree.
- *		On exit a pointer to the copy of the flattened device tree.
- *		FDT start
- * Return:	status code
- */
-static efi_status_t copy_fdt(void **fdtp)
-{
-	unsigned long fdt_ram_start =3D -1L, fdt_pages;
-	efi_status_t ret =3D 0;
-	void *fdt, *new_fdt;
-	u64 new_fdt_addr;
-	uint fdt_size;
-	int i;
-
-	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		u64 ram_start =3D gd->bd->bi_dram[i].start;
-		u64 ram_size =3D gd->bd->bi_dram[i].size;
-
-		if (!ram_size)
-			continue;
-
-		if (ram_start < fdt_ram_start)
-			fdt_ram_start =3D ram_start;
-	}
-
-	/*
-	 * Give us at least 12 KiB of breathing room in case the device tree
-	 * needs to be expanded later.
-	 */
-	fdt =3D *fdtp;
-	fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
-	fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
-
-	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
-				 &new_fdt_addr);
-	if (ret !=3D EFI_SUCCESS) {
-		log_err("ERROR: Failed to reserve space for FDT\n");
-		goto done;
-	}
-	new_fdt =3D (void *)(uintptr_t)new_fdt_addr;
-	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
-	fdt_set_totalsize(new_fdt, fdt_size);
-
-	*fdtp =3D (void *)(uintptr_t)new_fdt_addr;
-done:
-	return ret;
-}
-
-/**
- * get_config_table() - get configuration table
- *
- * @guid:	GUID of the configuration table
- * Return:	pointer to configuration table or NULL
- */
-static void *get_config_table(const efi_guid_t *guid)
-{
-	size_t i;
-
-	for (i =3D 0; i < systab.nr_tables; i++) {
-		if (!guidcmp(guid, &systab.tables[i].guid))
-			return systab.tables[i].table;
-	}
-	return NULL;
-}
-
-#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
-
-/**
- * efi_install_fdt() - install device tree
- *
- * If fdt is not EFI_FDT_USE_INTERNAL, the device tree located at that mem=
ory
- * address will will be installed as configuration table, otherwise the de=
vice
- * tree located at the address indicated by environment variable fdt_addr =
or as
- * fallback fdtcontroladdr will be used.
- *
- * On architectures using ACPI tables device trees shall not be installed =
as
- * configuration table.
- *
- * @fdt:	address of device tree or EFI_FDT_USE_INTERNAL to use the
- *		the hardware device tree as indicated by environment variable
- *		fdt_addr or as fallback the internal device tree as indicated by
- *		the environment variable fdtcontroladdr
- * Return:	status code
- */
-efi_status_t efi_install_fdt(void *fdt)
-{
-	/*
-	 * The EBBR spec requires that we have either an FDT or an ACPI table
-	 * but not both.
-	 */
-#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
-	if (fdt) {
-		log_warning("WARNING: Can't have ACPI table and device tree - ignoring D=
T.\n");
-		return EFI_SUCCESS;
-	}
-#else
-	struct bootm_headers img =3D { 0 };
-	efi_status_t ret;
-
-	if (fdt =3D=3D EFI_FDT_USE_INTERNAL) {
-		const char *fdt_opt;
-		uintptr_t fdt_addr;
-
-		/* Look for device tree that is already installed */
-		if (get_config_table(&efi_guid_fdt))
-			return EFI_SUCCESS;
-		/* Check if there is a hardware device tree */
-		fdt_opt =3D env_get("fdt_addr");
-		/* Use our own device tree as fallback */
-		if (!fdt_opt) {
-			fdt_opt =3D env_get("fdtcontroladdr");
-			if (!fdt_opt) {
-				log_err("ERROR: need device tree\n");
-				return EFI_NOT_FOUND;
-			}
-		}
-		fdt_addr =3D hextoul(fdt_opt, NULL);
-		if (!fdt_addr) {
-			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
-			return EFI_LOAD_ERROR;
-		}
-		fdt =3D map_sysmem(fdt_addr, 0);
-	}
-
-	/* Install device tree */
-	if (fdt_check_header(fdt)) {
-		log_err("ERROR: invalid device tree\n");
-		return EFI_LOAD_ERROR;
-	}
-
-	/* Prepare device tree for payload */
-	ret =3D copy_fdt(&fdt);
-	if (ret) {
-		log_err("ERROR: out of memory\n");
-		return EFI_OUT_OF_RESOURCES;
-	}
-
-	if (image_setup_libfdt(&img, fdt, 0, NULL)) {
-		log_err("ERROR: failed to process device tree\n");
-		return EFI_LOAD_ERROR;
-	}
-
-	/* Create memory reservations as indicated by the device tree */
-	efi_carve_out_dt_rsv(fdt);
-
-	efi_try_purge_kaslr_seed(fdt);
-
-	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
-		ret =3D efi_tcg2_measure_dtb(fdt);
-		if (ret =3D=3D EFI_SECURITY_VIOLATION) {
-			log_err("ERROR: failed to measure DTB\n");
-			return ret;
-		}
-	}
-
-	/* Install device tree as UEFI table */
-	ret =3D efi_install_configuration_table(&efi_guid_fdt, fdt);
-	if (ret !=3D EFI_SUCCESS) {
-		log_err("ERROR: failed to install device tree\n");
-		return ret;
-	}
-#endif /* GENERATE_ACPI_TABLE */
-
-	return EFI_SUCCESS;
-}
-
-/**
- * do_bootefi_exec() - execute EFI binary
- *
- * The image indicated by @handle is started. When it returns the allocated
- * memory for the @load_options is freed.
- *
- * @handle:		handle of loaded image
- * @load_options:	load options
- * Return:		status code
- *
- * Load the EFI binary into a newly assigned memory unwinding the relocati=
on
- * information, install the loaded image protocol, and call the binary.
- */
-static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_option=
s)
-{
-	efi_status_t ret;
-	efi_uintn_t exit_data_size =3D 0;
-	u16 *exit_data =3D NULL;
-
-	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
-	switch_to_non_secure_mode();
-
-	/*
-	 * The UEFI standard requires that the watchdog timer is set to five
-	 * minutes when invoking an EFI boot option.
-	 *
-	 * Unified Extensible Firmware Interface (UEFI), version 2.7 Errata A
-	 * 7.5. Miscellaneous Boot Services - EFI_BOOT_SERVICES.SetWatchdogTimer
-	 */
-	ret =3D efi_set_watchdog(300);
-	if (ret !=3D EFI_SUCCESS) {
-		log_err("ERROR: Failed to set watchdog timer\n");
-		goto out;
-	}
-
-	/* Call our payload! */
-	ret =3D EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data));
-	if (ret !=3D EFI_SUCCESS) {
-		log_err("## Application failed, r =3D %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		if (exit_data) {
-			log_err("## %ls\n", exit_data);
-			efi_free_pool(exit_data);
-		}
-	}
-
-	efi_restore_gd();
-
-out:
-	free(load_options);
-
-	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-		if (efi_initrd_deregister() !=3D EFI_SUCCESS)
-			log_err("Failed to remove loadfile2 for initrd\n");
-	}
-
-	/* Control is returned to U-Boot, disable EFI watchdog */
-	efi_set_watchdog(0);
-
-	return ret;
-}
-
 /**
  * do_efibootmgr() - execute EFI boot manager
  *
@@ -461,6 +88,9 @@ static int do_bootefi_image(const char *image_opt, const=
 char *size_opt)
 				return CMD_RET_USAGE;
 			efi_clear_bootdev();
 		} else {
+			size_t image_size;
+			void *image_addr;
+			efi_get_image_parameters(&image_addr, &image_size);
 			if (image_buf !=3D image_addr) {
 				log_err("No UEFI binary known at %s\n",
 					image_opt);
@@ -477,135 +107,7 @@ static int do_bootefi_image(const char *image_opt, co=
nst char *size_opt)
 	return CMD_RET_SUCCESS;
 }
=20
-/**
- * efi_run_image() - run loaded UEFI image
- *
- * @source_buffer:	memory address of the UEFI image
- * @source_size:	size of the UEFI image
- * Return:		status code
- */
-efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
-{
-	efi_handle_t mem_handle =3D NULL, handle;
-	struct efi_device_path *file_path =3D NULL;
-	struct efi_device_path *msg_path;
-	efi_status_t ret, ret2;
-	u16 *load_options;
-
-	if (!bootefi_device_path || !bootefi_image_path) {
-		log_debug("Not loaded from disk\n");
-		/*
-		 * Special case for efi payload not loaded from disk,
-		 * such as 'bootefi hello' or for example payload
-		 * loaded directly into memory via JTAG, etc:
-		 */
-		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)source_buffer,
-					    source_size);
-		/*
-		 * Make sure that device for device_path exist
-		 * in load_image(). Otherwise, shell and grub will fail.
-		 */
-		ret =3D efi_install_multiple_protocol_interfaces(&mem_handle,
-							       &efi_guid_device_path,
-							       file_path, NULL);
-		if (ret !=3D EFI_SUCCESS)
-			goto out;
-		msg_path =3D file_path;
-	} else {
-		file_path =3D efi_dp_append(bootefi_device_path,
-					  bootefi_image_path);
-		msg_path =3D bootefi_image_path;
-		log_debug("Loaded from disk\n");
-	}
-
-	log_info("Booting %pD\n", msg_path);
-
-	ret =3D EFI_CALL(efi_load_image(false, efi_root, file_path, source_buffer,
-				      source_size, &handle));
-	if (ret !=3D EFI_SUCCESS) {
-		log_err("Loading image failed\n");
-		goto out;
-	}
-
-	/* Transfer environment variable as load options */
-	ret =3D efi_env_set_load_options(handle, "bootargs", &load_options);
-	if (ret !=3D EFI_SUCCESS)
-		goto out;
-
-	ret =3D do_bootefi_exec(handle, load_options);
-
-out:
-	ret2 =3D efi_uninstall_multiple_protocol_interfaces(mem_handle,
-							  &efi_guid_device_path,
-							  file_path, NULL);
-	efi_free_pool(file_path);
-	return (ret !=3D EFI_SUCCESS) ? ret : ret2;
-}
-
 #ifdef CONFIG_CMD_BOOTEFI_SELFTEST
-static efi_status_t bootefi_run_prepare(const char *load_options_path,
-		struct efi_device_path *device_path,
-		struct efi_device_path *image_path,
-		struct efi_loaded_image_obj **image_objp,
-		struct efi_loaded_image **loaded_image_infop)
-{
-	efi_status_t ret;
-	u16 *load_options;
-
-	ret =3D efi_setup_loaded_image(device_path, image_path, image_objp,
-				     loaded_image_infop);
-	if (ret !=3D EFI_SUCCESS)
-		return ret;
-
-	/* Transfer environment variable as load options */
-	return efi_env_set_load_options((efi_handle_t)*image_objp,
-					load_options_path,
-					&load_options);
-}
-
-/**
- * bootefi_test_prepare() - prepare to run an EFI test
- *
- * Prepare to run a test as if it were provided by a loaded image.
- *
- * @image_objp:		pointer to be set to the loaded image handle
- * @loaded_image_infop:	pointer to be set to the loaded image protocol
- * @path:		dummy file path used to construct the device path
- *			set in the loaded image protocol
- * @load_options_path:	name of a U-Boot environment variable. Its value is
- *			set as load options in the loaded image protocol.
- * Return:		status code
- */
-static efi_status_t bootefi_test_prepare
-		(struct efi_loaded_image_obj **image_objp,
-		 struct efi_loaded_image **loaded_image_infop, const char *path,
-		 const char *load_options_path)
-{
-	efi_status_t ret;
-
-	/* Construct a dummy device path */
-	bootefi_device_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, 0, 0);
-	if (!bootefi_device_path)
-		return EFI_OUT_OF_RESOURCES;
-
-	bootefi_image_path =3D efi_dp_from_file(NULL, path);
-	if (!bootefi_image_path) {
-		ret =3D EFI_OUT_OF_RESOURCES;
-		goto failure;
-	}
-
-	ret =3D bootefi_run_prepare(load_options_path, bootefi_device_path,
-				  bootefi_image_path, image_objp,
-				  loaded_image_infop);
-	if (ret =3D=3D EFI_SUCCESS)
-		return ret;
-
-failure:
-	efi_clear_bootdev();
-	return ret;
-}
-
 /**
  * do_efi_selftest() - execute EFI selftest
  *
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f40..6663a972c124 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -91,6 +91,7 @@ efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len=
);
  * back to u-boot world
  */
 void efi_restore_gd(void);
+void efi_clear_bootdev(void);
 /* Call this to set the current device name */
 void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 		     void *buffer, size_t buffer_size);
@@ -526,12 +527,15 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *b=
uf,
 efi_status_t efi_bootmgr_update_media_device_boot_option(void);
 /* Delete selected boot option */
 efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
+efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env=
_var,
+				      u16 **load_options);
 /* search the boot option index in BootOrder */
 bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32=
 *index);
 /* Set up console modes */
 void efi_setup_console_size(void);
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
+efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
 /* Run loaded UEFI image */
 efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size);
 /* Initialize variable services */
@@ -885,6 +889,9 @@ efi_status_t __efi_runtime EFIAPI efi_set_time(struct e=
fi_time *time);
  */
 efi_status_t EFIAPI efi_selftest(efi_handle_t image_handle,
 				 struct efi_system_table *systab);
+efi_status_t bootefi_test_prepare (struct efi_loaded_image_obj **image_obj=
p,
+		 struct efi_loaded_image **loaded_image_infop, const char *path,
+		 const char *load_options_path);
 #endif
=20
 efi_status_t EFIAPI efi_get_variable(u16 *variable_name,
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8d31fc61c601..529a9756a98c 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -44,6 +44,7 @@ endif
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
 obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) +=3D efi_bootmgr.o
 obj-y +=3D efi_boottime.o
+obj-y +=3D bootefi.o
 obj-y +=3D efi_helper.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D efi_capsule.o
 obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) +=3D efi_firmware.o
diff --git a/lib/efi_loader/bootefi.c b/lib/efi_loader/bootefi.c
new file mode 100644
index 000000000000..7b02b6f46eb5
--- /dev/null
+++ b/lib/efi_loader/bootefi.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  EFI application loader
+ *
+ *  Copyright (c) 2016 Alexander Graf
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <common.h>
+#include <bootm.h>
+#include <charset.h>
+#include <command.h>
+#include <dm.h>
+#include <efi_loader.h>
+#include <efi_selftest.h>
+#include <env.h>
+#include <errno.h>
+#include <image.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/global_data.h>
+#include <linux/libfdt.h>
+#include <linux/libfdt_env.h>
+#include <mapmem.h>
+#include <memalign.h>
+#include <asm-generic/sections.h>
+#include <linux/linkage.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct efi_device_path *bootefi_image_path;
+static struct efi_device_path *bootefi_device_path;
+static void *image_addr;
+static size_t image_size;
+
+/**
+ * efi_get_image_parameters() - return image parameters
+ *
+ * @img_addr:		address of loaded image in memory
+ * @img_size:		size of loaded image
+ */
+void efi_get_image_parameters(void **img_addr, size_t *img_size)
+{
+	*img_addr =3D image_addr;
+	*img_size =3D image_size;
+}
+
+/**
+ * efi_clear_bootdev() - clear boot device
+ */
+void efi_clear_bootdev(void)
+{
+	efi_free_pool(bootefi_device_path);
+	efi_free_pool(bootefi_image_path);
+	bootefi_device_path =3D NULL;
+	bootefi_image_path =3D NULL;
+	image_addr =3D NULL;
+	image_size =3D 0;
+}
+
+/**
+ * efi_set_bootdev() - set boot device
+ *
+ * This function is called when a file is loaded, e.g. via the 'load' comm=
and.
+ * We use the path to this file to inform the UEFI binary about the boot d=
evice.
+ *
+ * @dev:		device, e.g. "MMC"
+ * @devnr:		number of the device, e.g. "1:2"
+ * @path:		path to file loaded
+ * @buffer:		buffer with file loaded
+ * @buffer_size:	size of file loaded
+ */
+void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
+		     void *buffer, size_t buffer_size)
+{
+	struct efi_device_path *device, *image;
+	efi_status_t ret;
+
+	log_debug("dev=3D%s, devnr=3D%s, path=3D%s, buffer=3D%p, size=3D%zx\n", d=
ev,
+		  devnr, path, buffer, buffer_size);
+
+	/* Forget overwritten image */
+	if (buffer + buffer_size >=3D image_addr &&
+	    image_addr + image_size >=3D buffer)
+		efi_clear_bootdev();
+
+	/* Remember only PE-COFF and FIT images */
+	if (efi_check_pe(buffer, buffer_size, NULL) !=3D EFI_SUCCESS) {
+		if (IS_ENABLED(CONFIG_FIT) &&
+		    !fit_check_format(buffer, IMAGE_SIZE_INVAL)) {
+			/*
+			 * FIT images of type EFI_OS are started via command
+			 * bootm. We should not use their boot device with the
+			 * bootefi command.
+			 */
+			buffer =3D 0;
+			buffer_size =3D 0;
+		} else {
+			log_debug("- not remembering image\n");
+			return;
+		}
+	}
+
+	/* efi_set_bootdev() is typically called repeatedly, recover memory */
+	efi_clear_bootdev();
+
+	image_addr =3D buffer;
+	image_size =3D buffer_size;
+
+	ret =3D efi_dp_from_name(dev, devnr, path, &device, &image);
+	if (ret =3D=3D EFI_SUCCESS) {
+		bootefi_device_path =3D device;
+		if (image) {
+			/* FIXME: image should not contain device */
+			struct efi_device_path *image_tmp =3D image;
+
+			efi_dp_split_file_path(image, &device, &image);
+			efi_free_pool(image_tmp);
+		}
+		bootefi_image_path =3D image;
+		log_debug("- boot device %pD\n", device);
+		if (image)
+			log_debug("- image %pD\n", image);
+	} else {
+		log_debug("- efi_dp_from_name() failed, err=3D%lx\n", ret);
+		efi_clear_bootdev();
+	}
+}
+
+/**
+ * efi_env_set_load_options() - set load options from environment variable
+ *
+ * @handle:		the image handle
+ * @env_var:		name of the environment variable
+ * @load_options:	pointer to load options (output)
+ * Return:		status code
+ */
+efi_status_t efi_env_set_load_options(efi_handle_t handle,
+					     const char *env_var,
+					     u16 **load_options)
+{
+	const char *env =3D env_get(env_var);
+	size_t size;
+	u16 *pos;
+	efi_status_t ret;
+
+	*load_options =3D NULL;
+	if (!env)
+		return EFI_SUCCESS;
+	size =3D sizeof(u16) * (utf8_utf16_strlen(env) + 1);
+	pos =3D calloc(size, 1);
+	if (!pos)
+		return EFI_OUT_OF_RESOURCES;
+	*load_options =3D pos;
+	utf8_utf16_strcpy(&pos, env);
+	ret =3D efi_set_load_options(handle, size, *load_options);
+	if (ret !=3D EFI_SUCCESS) {
+		free(*load_options);
+		*load_options =3D NULL;
+	}
+	return ret;
+}
+
+#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
+
+/**
+ * copy_fdt() - Copy the device tree to a new location available to EFI
+ *
+ * The FDT is copied to a suitable location within the EFI memory map.
+ * Additional 12 KiB are added to the space in case the device tree needs =
to be
+ * expanded later with fdt_open_into().
+ *
+ * @fdtp:	On entry a pointer to the flattened device tree.
+ *		On exit a pointer to the copy of the flattened device tree.
+ *		FDT start
+ * Return:	status code
+ */
+static efi_status_t copy_fdt(void **fdtp)
+{
+	unsigned long fdt_ram_start =3D -1L, fdt_pages;
+	efi_status_t ret =3D 0;
+	void *fdt, *new_fdt;
+	u64 new_fdt_addr;
+	uint fdt_size;
+	int i;
+
+	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		u64 ram_start =3D gd->bd->bi_dram[i].start;
+		u64 ram_size =3D gd->bd->bi_dram[i].size;
+
+		if (!ram_size)
+			continue;
+
+		if (ram_start < fdt_ram_start)
+			fdt_ram_start =3D ram_start;
+	}
+
+	/*
+	 * Give us at least 12 KiB of breathing room in case the device tree
+	 * needs to be expanded later.
+	 */
+	fdt =3D *fdtp;
+	fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
+	fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
+
+	ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
+				 &new_fdt_addr);
+	if (ret !=3D EFI_SUCCESS) {
+		log_err("ERROR: Failed to reserve space for FDT\n");
+		goto done;
+	}
+	new_fdt =3D (void *)(uintptr_t)new_fdt_addr;
+	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
+	fdt_set_totalsize(new_fdt, fdt_size);
+
+	*fdtp =3D (void *)(uintptr_t)new_fdt_addr;
+done:
+	return ret;
+}
+
+/**
+ * get_config_table() - get configuration table
+ *
+ * @guid:	GUID of the configuration table
+ * Return:	pointer to configuration table or NULL
+ */
+static void *get_config_table(const efi_guid_t *guid)
+{
+	size_t i;
+
+	for (i =3D 0; i < systab.nr_tables; i++) {
+		if (!guidcmp(guid, &systab.tables[i].guid))
+			return systab.tables[i].table;
+	}
+	return NULL;
+}
+
+#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
+
+/**
+ * efi_install_fdt() - install device tree
+ *
+ * If fdt is not EFI_FDT_USE_INTERNAL, the device tree located at that mem=
ory
+ * address will will be installed as configuration table, otherwise the de=
vice
+ * tree located at the address indicated by environment variable fdt_addr =
or as
+ * fallback fdtcontroladdr will be used.
+ *
+ * On architectures using ACPI tables device trees shall not be installed =
as
+ * configuration table.
+ *
+ * @fdt:	address of device tree or EFI_FDT_USE_INTERNAL to use the
+ *		the hardware device tree as indicated by environment variable
+ *		fdt_addr or as fallback the internal device tree as indicated by
+ *		the environment variable fdtcontroladdr
+ * Return:	status code
+ */
+efi_status_t efi_install_fdt(void *fdt)
+{
+	/*
+	 * The EBBR spec requires that we have either an FDT or an ACPI table
+	 * but not both.
+	 */
+#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
+	if (fdt) {
+		log_warning("WARNING: Can't have ACPI table and device tree - ignoring D=
T.\n");
+		return EFI_SUCCESS;
+	}
+#else
+	struct bootm_headers img =3D { 0 };
+	efi_status_t ret;
+
+	if (fdt =3D=3D EFI_FDT_USE_INTERNAL) {
+		const char *fdt_opt;
+		uintptr_t fdt_addr;
+
+		/* Look for device tree that is already installed */
+		if (get_config_table(&efi_guid_fdt))
+			return EFI_SUCCESS;
+		/* Check if there is a hardware device tree */
+		fdt_opt =3D env_get("fdt_addr");
+		/* Use our own device tree as fallback */
+		if (!fdt_opt) {
+			fdt_opt =3D env_get("fdtcontroladdr");
+			if (!fdt_opt) {
+				log_err("ERROR: need device tree\n");
+				return EFI_NOT_FOUND;
+			}
+		}
+		fdt_addr =3D hextoul(fdt_opt, NULL);
+		if (!fdt_addr) {
+			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
+			return EFI_LOAD_ERROR;
+		}
+		fdt =3D map_sysmem(fdt_addr, 0);
+	}
+
+	/* Install device tree */
+	if (fdt_check_header(fdt)) {
+		log_err("ERROR: invalid device tree\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	/* Prepare device tree for payload */
+	ret =3D copy_fdt(&fdt);
+	if (ret) {
+		log_err("ERROR: out of memory\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	if (image_setup_libfdt(&img, fdt, 0, NULL)) {
+		log_err("ERROR: failed to process device tree\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	/* Create memory reservations as indicated by the device tree */
+	efi_carve_out_dt_rsv(fdt);
+
+	efi_try_purge_kaslr_seed(fdt);
+
+	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
+		ret =3D efi_tcg2_measure_dtb(fdt);
+		if (ret =3D=3D EFI_SECURITY_VIOLATION) {
+			log_err("ERROR: failed to measure DTB\n");
+			return ret;
+		}
+	}
+
+	/* Install device tree as UEFI table */
+	ret =3D efi_install_configuration_table(&efi_guid_fdt, fdt);
+	if (ret !=3D EFI_SUCCESS) {
+		log_err("ERROR: failed to install device tree\n");
+		return ret;
+	}
+#endif /* GENERATE_ACPI_TABLE */
+
+	return EFI_SUCCESS;
+}
+
+#ifdef CONFIG_CMD_BOOTEFI_SELFTEST
+static efi_status_t bootefi_run_prepare(const char *load_options_path,
+		struct efi_device_path *device_path,
+		struct efi_device_path *image_path,
+		struct efi_loaded_image_obj **image_objp,
+		struct efi_loaded_image **loaded_image_infop)
+{
+	efi_status_t ret;
+	u16 *load_options;
+
+	ret =3D efi_setup_loaded_image(device_path, image_path, image_objp,
+				     loaded_image_infop);
+	if (ret !=3D EFI_SUCCESS)
+		return ret;
+
+	/* Transfer environment variable as load options */
+	return efi_env_set_load_options((efi_handle_t)*image_objp,
+					load_options_path,
+					&load_options);
+}
+
+/**
+ * bootefi_test_prepare() - prepare to run an EFI test
+ *
+ * Prepare to run a test as if it were provided by a loaded image.
+ *
+ * @image_objp:		pointer to be set to the loaded image handle
+ * @loaded_image_infop:	pointer to be set to the loaded image protocol
+ * @path:		dummy file path used to construct the device path
+ *			set in the loaded image protocol
+ * @load_options_path:	name of a U-Boot environment variable. Its value is
+ *			set as load options in the loaded image protocol.
+ * Return:		status code
+ */
+efi_status_t bootefi_test_prepare (struct efi_loaded_image_obj **image_obj=
p,
+		 struct efi_loaded_image **loaded_image_infop, const char *path,
+		 const char *load_options_path)
+{
+	efi_status_t ret;
+
+	/* Construct a dummy device path */
+	bootefi_device_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, 0, 0);
+	if (!bootefi_device_path)
+		return EFI_OUT_OF_RESOURCES;
+
+	bootefi_image_path =3D efi_dp_from_file(NULL, path);
+	if (!bootefi_image_path) {
+		ret =3D EFI_OUT_OF_RESOURCES;
+		goto failure;
+	}
+
+	ret =3D bootefi_run_prepare(load_options_path, bootefi_device_path,
+				  bootefi_image_path, image_objp,
+				  loaded_image_infop);
+	if (ret =3D=3D EFI_SUCCESS)
+		return ret;
+
+failure:
+	efi_clear_bootdev();
+	return ret;
+}
+#endif
+
+/**
+ * do_bootefi_exec() - execute EFI binary
+ *
+ * The image indicated by @handle is started. When it returns the allocated
+ * memory for the @load_options is freed.
+ *
+ * @handle:		handle of loaded image
+ * @load_options:	load options
+ * Return:		status code
+ *
+ * Load the EFI binary into a newly assigned memory unwinding the relocati=
on
+ * information, install the loaded image protocol, and call the binary.
+ */
+efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
+{
+	efi_status_t ret;
+	efi_uintn_t exit_data_size =3D 0;
+	u16 *exit_data =3D NULL;
+
+	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
+	switch_to_non_secure_mode();
+
+	/*
+	 * The UEFI standard requires that the watchdog timer is set to five
+	 * minutes when invoking an EFI boot option.
+	 *
+	 * Unified Extensible Firmware Interface (UEFI), version 2.7 Errata A
+	 * 7.5. Miscellaneous Boot Services - EFI_BOOT_SERVICES.SetWatchdogTimer
+	 */
+	ret =3D efi_set_watchdog(300);
+	if (ret !=3D EFI_SUCCESS) {
+		log_err("ERROR: Failed to set watchdog timer\n");
+		goto out;
+	}
+
+	/* Call our payload! */
+	ret =3D EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data));
+	if (ret !=3D EFI_SUCCESS) {
+		log_err("## Application failed, r =3D %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		if (exit_data) {
+			log_err("## %ls\n", exit_data);
+			efi_free_pool(exit_data);
+		}
+	}
+
+	efi_restore_gd();
+
+out:
+	free(load_options);
+
+	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
+		if (efi_initrd_deregister() !=3D EFI_SUCCESS)
+			log_err("Failed to remove loadfile2 for initrd\n");
+	}
+
+	/* Control is returned to U-Boot, disable EFI watchdog */
+	efi_set_watchdog(0);
+
+	return ret;
+}
+
+/**
+ * efi_run_image() - run loaded UEFI image
+ *
+ * @source_buffer:	memory address of the UEFI image
+ * @source_size:	size of the UEFI image
+ * Return:		status code
+ */
+efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+{
+	efi_handle_t mem_handle =3D NULL, handle;
+	struct efi_device_path *file_path =3D NULL;
+	struct efi_device_path *msg_path;
+	efi_status_t ret, ret2;
+	u16 *load_options;
+
+	if (!bootefi_device_path || !bootefi_image_path) {
+		log_debug("Not loaded from disk\n");
+		/*
+		 * Special case for efi payload not loaded from disk,
+		 * such as 'bootefi hello' or for example payload
+		 * loaded directly into memory via JTAG, etc:
+		 */
+		file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)source_buffer,
+					    source_size);
+		/*
+		 * Make sure that device for device_path exist
+		 * in load_image(). Otherwise, shell and grub will fail.
+		 */
+		ret =3D efi_install_multiple_protocol_interfaces(&mem_handle,
+							       &efi_guid_device_path,
+							       file_path, NULL);
+		if (ret !=3D EFI_SUCCESS)
+			goto out;
+		msg_path =3D file_path;
+	} else {
+		file_path =3D efi_dp_append(bootefi_device_path,
+					  bootefi_image_path);
+		msg_path =3D bootefi_image_path;
+		log_debug("Loaded from disk\n");
+	}
+
+	log_info("Booting %pD\n", msg_path);
+
+	ret =3D EFI_CALL(efi_load_image(false, efi_root, file_path, source_buffer,
+				      source_size, &handle));
+	if (ret !=3D EFI_SUCCESS) {
+		log_err("Loading image failed\n");
+		goto out;
+	}
+
+	/* Transfer environment variable as load options */
+	ret =3D efi_env_set_load_options(handle, "bootargs", &load_options);
+	if (ret !=3D EFI_SUCCESS)
+		goto out;
+
+	ret =3D do_bootefi_exec(handle, load_options);
+
+out:
+	ret2 =3D efi_uninstall_multiple_protocol_interfaces(mem_handle,
+							  &efi_guid_device_path,
+							  file_path, NULL);
+	efi_free_pool(file_path);
+	return (ret !=3D EFI_SUCCESS) ? ret : ret2;
+}

But that left needing to implement an API to start bootefi / bootefi
bootmgr itself as we still end up in C making a string and calling the
command, and ideally we would not be doing that with CMDLINE disabled.

--=20
Tom

--CKxE+g6drjFgPIdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxSxUACgkQFHw5/5Y0
tyxsmQv+LT3/5qZAOgfs97LnE3XkexpvftYzsGGm+APY2H3GOvvx0ykZFqPJj5k9
AztsNjNm0rDE1SMFU9GqbN72pqJVnCNRaEWPjxoWb5lPYVwvQI9Z6ajvi5lxindN
Pj7SnxmD7Am8njsUvNbuDsvSQxtLD3BT80OeaQhz59z3rxcGuwKvZ0DwmL+/k1Oe
alaR0ULlxSgPhjdxF8Xwtf1K9jfrg0FeNiq5Ihy7xwyAxzIl0U7SbZSbCxOQBanM
DtAN7rxnnob2y7XeQPmwFyHLJI4L0RrMM2XQvbEAUyjZ3De6mSAhghZh7iUVYbHn
nTgqmrjcaRTrondtPXOTdgI+rLDRslMSXINxyADIzuN61RaXYyUfvQyO0AeBmSvU
hNrrpo7RIh+6g872E0arJolNhZc9kMl+MqRWr6QVBtC585Ej0VBfehjGE65R8lTy
p47L+i33eObsmWNE/6ZzBY4NI28yVloEamjAcPp20OHiTeKz/Zna0YVzQL6C86tZ
XySgj+eA
=ow51
-----END PGP SIGNATURE-----

--CKxE+g6drjFgPIdr--
