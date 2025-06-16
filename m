Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F89C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 17:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB16582C2F;
	Mon, 16 Jun 2025 19:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hZZ5LEua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFD182C4D; Mon, 16 Jun 2025 19:03:44 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DD182BCD
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 19:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ea35edc691so1128143fac.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750093420; x=1750698220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y013At6RFLxMmLu1qoLOuuMLkh0qQBQxOeJ6P/9uRNk=;
 b=hZZ5LEuah7lflgEOGf+PzCGvCHj8/tA979YSvarJ9TtzFp7h/M/3M7YKNC6AlOEFW+
 A9ZIvPyIA4agVj66epNboXyFojkV0aKrtfHeQ0jSVKAC1uOLtyrKQAKUXlAYgyUOvtct
 91+hxNn9HpZbPDqYHT37dqzkbe3UXTgn8+1Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750093420; x=1750698220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y013At6RFLxMmLu1qoLOuuMLkh0qQBQxOeJ6P/9uRNk=;
 b=Yo+YfYFogUItZWnP9hFMYDGnWenrp3/AJEFrR45zS52otpyS7PJQteRGSI6yxp1Fc/
 nWoTkhtyD5A3i5Q385jfl/07BY8a0QNUzvfzCXMXg09mbEM0njwqv0pf+OIhmnQS6ZAg
 NZWSbyADtFNM+gqgBaAGR8O/endxqwFZuer0EeSzUnBbbH5Rgxkmj/cQoKy435In4TdP
 byJArghfh4Yw0kZwS5RwY986Umgw1XeiXlNtL722MOZKWX0utsZZvGFbvkxWnvPr+9NQ
 kW8WALGHx4QG6gUKXT2ltubPDmhnQBznuqq5yFXOLx2cPl/jXkFLSz4cnq5q9HKOE+Hm
 Sj9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK1rRa6a6Bx8/79h+HY27kKFyBjetrp2IGgFZ7fGWSBL5GrfPbUn6Wg50N2y/S4AmMwLWXvEg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2FMGOerV6PGUMMRQebmydU+/WOtzXqF/TtY4p/RLkg3wDyiT7
 OSebCFolpZzg+N2iNmGRt8lZfejyQkU88y05HQgTXHHll2De5VZmFHBB2NP0aXRIaKk=
X-Gm-Gg: ASbGnctPVuKWagBXcQSX4q26Ki8TG/WXlrTSur2sxzNfwv/JAsu4ovP+suluaxPWN75
 mnmK3FTnxCDgyp3j+aT+bbBLFp+JdveB8npzsolLx53tRGrZZLSfgYBc74/YhRfc4Tb7SrVhn74
 fKLTPlQkCsV5VnTiIzHTZLcKAplFUgCn2RXVnv7lUcSqOQGj78lxRCrdhCBYS1geyJN6fL8VqNg
 vyX/DLmJta2QFC1NZBBuM30BQHDtawQo9ejQcYANX9s1eE64dQePEHtVpd8FpO0jPLor6Uxtwm2
 +oWdhWjnO+TOe8vPvfbwik2pJmEBNGVQW5Y4mh+ZHfvWo26KJwarZdC4xq7reb0a+ndffX+Tv3d
 +muyTMlaXiH0Qrrz1UzLtzmw=
X-Google-Smtp-Source: AGHT+IFGriMCjFSAvrOdMrMVbafJeiq1W+i5mvFkJSqAAvriMo/hzzC39s5OceKy/aTbVTr+o9tvfQ==
X-Received: by 2002:a05:6870:6ec2:b0:29e:67cd:1a8f with SMTP id
 586e51a60fabf-2eaf0bb3704mr5317632fac.37.1750093420001; 
 Mon, 16 Jun 2025 10:03:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8de67e9sm2018202fac.30.2025.06.16.10.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 10:03:38 -0700 (PDT)
Date: Mon, 16 Jun 2025 11:03:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Oliver.Gaskell@analog.com, peng.fan@nxp.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, twoerner@gmail.com, sjg@chromium.org,
 contact@paulk.fr, marex@denx.de, anshuld@ti.com,
 dario.binacchi@amarulasolutions.com, jerome.forissier@linaro.org,
 michael@amarulasolutions.com, a-dutta@ti.com,
 kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com
Subject: Re: [PATCH v2] spl: Add support for Device Firmware Upgrade (DFU)
 over PCIe
Message-ID: <20250616170335.GI1382132@bill-the-cat>
References: <20250616164444.631575-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FZBP+mnZKzhKNNTS"
Content-Disposition: inline
In-Reply-To: <20250616164444.631575-1-h-salunke@ti.com>
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


--FZBP+mnZKzhKNNTS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 10:14:44PM +0530, Hrushikesh Salunke wrote:

> Introduces support for Device Firmware Upgrade (DFU) over PCIe in
> U-Boot. Traditionally, the DFU protocol is used over USB, where a
> device enters DFU mode and allows a host to upload firmware or binary
> images directly via the USB interface. This is a widely adopted and
> convenient method for updating firmware.
>=20
> In the context of Texas Instruments (TI) SoCs, PCIe can be used as a
> boot interface in a manner that differs from the conventional
> "PCIe Boot" process, which typically refers to booting an OS or
> firmware image from an NVMe SSD or other PCIe-attached storage devices.
> Instead, TI SoCs can be configured as a PCIe Endpoint, allowing a
> connected PCIe Root Complex (host) to transfer images directly into the
> device=E2=80=99s memory over the PCIe bus for boot purposes. This mechani=
sm is
> analogous to DFU over USB, but leverages the high-speed PCIe link and
> does not depend on traditional storage devices.
>=20
> By extending the DFU framework in U-Boot to support PCIe, it will be
> possible to flash images over PCIe. While this implementation is
> motivated by TI SoC use cases, the framework is generic and can be
> adopted by everyone for platforms that support PCIe Endpoint mode.
> Platforms with hardware support for PCIe-based memory loading can use
> this to implement PCIe as a boot mode, as well as to enable flashing
> and recovery scenarios similar to DFU over USB.
>=20
> In summary, enable support for:
> - DFU-style flashing of firmware/images over PCIe, analogous to existing
> USB DFU workflows
> - PCIe as a boot mode where a host can load images directly into device
> memory using DFU over PCIe
>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
> This patch is based on commit
> 9de873b4c30 Merge patch series "linux/bitfield.h: sync <linux/bitfield.h>=
 from Linux 6.15 + winbond"
>=20
> Changes since v1
> As per feedback from Tom Rini
>=20
> 1. Added depends on SPL_PCI_ENDPOINT for SPL_PCI_DFU
> 2. Fixed spacing in help text in Kconfig
> 3. Removed defaults from PCI DFU configs
> 4. Grouped PCI DFU configs under 'if SPL_PCI_DFU'
> 5. Added IS_ENABLED(CONFIG_SPL_PCI_DFU) check in spl_ram.c
> 6. Rebased on current next
>=20
> v1 : https://patchwork.ozlabs.org/project/uboot/patch/20250612084910.3457=
060-1-h-salunke@ti.com/
>=20
>  common/spl/Kconfig   | 62 +++++++++++++++++++++++++++++
>  common/spl/spl_dfu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  common/spl/spl_ram.c | 14 ++++++-
>  drivers/Makefile     |  1 +
>  4 files changed, 169 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 880192043c4..212b4fc4e9e 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1268,6 +1268,14 @@ config SPL_PCI
>  	  necessary driver support. This enables the drivers in drivers/pci
>  	  as part of an SPL build.
> =20
> +config SPL_PCI_ENDPOINT
> +	bool "Support for PCI endpoint drivers"
> +	help
> +	   Enable this configuration option to support configurable PCI
> +	   endpoints at SPL. This should be enabled if the platform has
> +	   a PCI controllers that can operate in endpoint mode (as a device
> +	   connected to PCI host or bridge).
> +
>  config SPL_PCH
>  	bool "Support PCH drivers"
>  	help
> @@ -1328,6 +1336,60 @@ config SPL_RAM_DEVICE
>  	  be already in memory when SPL takes over, e.g. loaded by the boot
>  	  ROM.
> =20
> +config SPL_PCI_DFU
> +	bool "PCIe boot support"
> +	depends on SPL_PCI_ENDPOINT
> +	help
> +	  This config enables support to download bootloaders over PCIe
> +	  when device is acting as an PCI endpoint.
> +
> +if SPL_PCI_DFU
> +
> +config PCI_DFU_SPL_LOAD_FIT_ADDRESS
> +	hex "Address to load FIT image when booting via DFU over PCIe"
> +	help
> +	  Specify the load address of the fit image that will be loaded
> +	  by SPL via DFU over PCIe.
> +
> +config PCI_DFU_BAR_SIZE
> +	hex "BAR size to advertise for PCIe DFU"
> +	default 0x800000
> +	help
> +	  This config sets the size of BAR to be advertised to the Root
> +	  Complex. The size should be large enough to fit the FIT image
> +	  being downloaded via DFU over PCIe.
> +
> +config PCI_DFU_MAGIC_WORD
> +	hex "Completion magic word for PCIe DFU boot"
> +	default 0xdeadbeef
> +	help
> +	  Specify the magic word which will be written to a specific
> +	  address to signal the completion of transfer of FIT image
> +	  when using DFU over PCIe to download the image. Size of magic
> +	  word should be 32-bit.
> +
> +config PCI_DFU_VENDOR_ID
> +	hex "PCI Vendor ID for PCI endpoint"
> +	help
> +	  PCI Vendor ID for endpoint device for DFU over PCIe. This should
> +	  be set to your assigned 16-bit PCI Vendor ID.
> +
> +config PCI_DFU_DEVICE_ID
> +	hex "PCI Vendor ID for PCI endpoint"
> +	help
> +	  A 16-bit PCI Vendor ID for endpoint device for DFU over PCIe.
> +
> +config PCI_DFU_BOOT_PHASE
> +	string "Current boot phase for PCI DFU boot"
> +	help
> +	  Specify the current boot phase when booting via DFU over PCIe.
> +	  This value can be read by the root complex to determine the
> +	  current boot phase. Value of this config is written to memory
> +	  location (BAR_start + PCI_DFU_BAR_SIZE - 70). Max size of this
> +	  config is 63 bytes.
> +
> +endif
> +
>  config SPL_REMOTEPROC
>  	bool "Support REMOTEPROCS"
>  	default y if (CPU_V7R && ARCH_K3)
> diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
> index e9f381c392c..1fb5fb2bf6b 100644
> --- a/common/spl/spl_dfu.c
> +++ b/common/spl/spl_dfu.c
> @@ -15,6 +15,17 @@
>  #include <usb.h>
>  #include <dfu.h>
>  #include <linux/printk.h>
> +#include <pci_ep.h>
> +#include <dm/uclass.h>
> +#include <cpu_func.h>
> +#include <linux/io.h>
> +
> +/*
> + * Macros define size of magic word and boot phase string
> + * in bytes.
> + */
> +#define MAGIC_WORD_SIZE 4
> +#define BOOT_PHASE_STRING_SIZE 64
> =20
>  static int run_dfu(int usb_index, char *interface, char *devstring)
>  {
> @@ -32,11 +43,93 @@ exit:
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_SPL_PCI_DFU
> +static int dfu_over_pcie(void)
> +{
> +	u32 offset, magic_word;
> +	void *addr;
> +	struct udevice *dev;
> +	struct pci_bar bar;
> +	struct pci_ep_header hdr;
> +	uint fn =3D 0;
> +	int ret;
> +	char *bootphase;
> +
> +	uclass_get_device_by_seq(UCLASS_PCI_EP, 0, &dev);
> +	if (!dev) {
> +		pr_err("Failed to get pci ep device\n");
> +		return -ENODEV;
> +	}
> +
> +	printf("%s: Configuring PCIe endpoint\n", __func__);
> +	hdr.deviceid =3D CONFIG_PCI_DFU_DEVICE_ID;
> +	hdr.vendorid =3D CONFIG_PCI_DFU_VENDOR_ID;
> +	hdr.baseclass_code =3D PCI_BASE_CLASS_MEMORY;
> +
> +	ret =3D pci_ep_write_header(dev, fn, &hdr);
> +	if (ret) {
> +		pr_err("Failed to write header: %d\n", ret);
> +		return ret;
> +	}
> +
> +	bar.barno =3D BAR_0;
> +	bar.phys_addr =3D (dma_addr_t)CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
> +	bar.flags =3D PCI_BASE_ADDRESS_SPACE_MEMORY |
> +			  PCI_BASE_ADDRESS_MEM_TYPE_32 |
> +			  PCI_BASE_ADDRESS_MEM_PREFETCH;
> +
> +	bar.size =3D CONFIG_PCI_DFU_BAR_SIZE;
> +
> +	ret =3D pci_ep_set_bar(dev, fn, &bar);
> +	if (ret) {
> +		pr_err("Failed to set bar: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pci_ep_start(dev);
> +	if (ret) {
> +		pr_err("Failed to start ep: %d\n", ret);
> +		return ret;
> +	}
> +
> +	addr =3D (void *)CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
> +	offset =3D CONFIG_PCI_DFU_BAR_SIZE - MAGIC_WORD_SIZE;
> +
> +	if (sizeof(CONFIG_PCI_DFU_BOOT_PHASE) > BOOT_PHASE_STRING_SIZE) {
> +		pr_err("Boot phase string too long\n");
> +	} else {
> +		bootphase =3D (char *)(addr + CONFIG_PCI_DFU_BAR_SIZE -
> +				  (BOOT_PHASE_STRING_SIZE + MAGIC_WORD_SIZE));
> +		strncpy(bootphase, CONFIG_PCI_DFU_BOOT_PHASE,
> +			sizeof(CONFIG_PCI_DFU_BOOT_PHASE));
> +		bootphase[sizeof(CONFIG_PCI_DFU_BOOT_PHASE)] =3D '\0';
> +	}
> +
> +	addr =3D addr + offset;
> +	magic_word =3D CONFIG_PCI_DFU_MAGIC_WORD;
> +	(*(int *)addr) =3D 0;
> +	printf("%s: Waiting for an image .....\n", __func__);
> +	for (;;) {
> +		if (*(int *)addr =3D=3D magic_word)
> +			break;
> +		invalidate_dcache_all();
> +	}
> +	printf("Image loaded\n");
> +
> +	return 0;
> +}
> +#endif
> +
>  int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *=
devstr)
>  {
>  	char *str_env;
>  	int ret;
> =20
> +#ifdef CONFIG_SPL_PCI_DFU
> +	if (spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +		return dfu_over_pcie();
> +#endif
> +
>  	/* set default environment */
>  	env_set_default(NULL, 0);
>  	str_env =3D env_get(dfu_alt_info);
> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 71b7a8374bb..e8bd3334994 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -27,6 +27,10 @@ static ulong spl_ram_load_read(struct spl_load_info *l=
oad, ulong sector,
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>  		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>  				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +
> +		if (IS_ENABLED(CONFIG_SPL_PCI_DFU) &&
> +		    spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +			addr =3D CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
>  	}
>  	addr +=3D sector;
>  	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
> @@ -47,6 +51,10 @@ static int spl_ram_load_image(struct spl_image_info *s=
pl_image,
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>  		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>  				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +
> +		if (IS_ENABLED(CONFIG_SPL_PCI_DFU) &&
> +		    spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +			addr =3D CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
>  	}
> =20
>  	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
> @@ -60,7 +68,8 @@ static int spl_ram_load_image(struct spl_image_info *sp=
l_image,
>  	header =3D map_sysmem(addr, 0);
> =20
>  #if CONFIG_IS_ENABLED(DFU)
> -	if (bootdev->boot_device =3D=3D BOOT_DEVICE_DFU)
> +	if (bootdev->boot_device =3D=3D BOOT_DEVICE_DFU ||
> +	    bootdev->boot_device =3D=3D BOOT_DEVICE_PCIE)
>  		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
>  #endif
> =20
> @@ -102,3 +111,6 @@ SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_=
ram_load_image);
>  #if CONFIG_IS_ENABLED(DFU)
>  SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
>  #endif
> +#if CONFIG_IS_ENABLED(PCI_DFU)
> +SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
> +#endif
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 3c0ad17138f..bd15e89adb0 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_MULTIPLEXER) +=3D mux/
>  obj-$(CONFIG_$(PHASE_)ETH) +=3D net/
>  obj-$(CONFIG_$(PHASE_)PCH) +=3D pch/
>  obj-$(CONFIG_$(PHASE_)PCI) +=3D pci/
> +obj-$(CONFIG_$(PHASE_)PCI_ENDPOINT) +=3D pci_endpoint/
>  obj-$(CONFIG_$(PHASE_)PHY) +=3D phy/
>  obj-$(CONFIG_$(PHASE_)PINCTRL) +=3D pinctrl/
>  obj-$(CONFIG_$(PHASE_)POWER) +=3D power/

Adding in Mattijs Korpershoek as well.

--=20
Tom

--FZBP+mnZKzhKNNTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhQTmQACgkQFHw5/5Y0
tyzTZwv/Rmq2+UeO1NOblYolXg5d7u37FRgCso9PA2Po1nCWQH4GTLMPB9nb0e5T
OcRa4ZEujZguhLicfutqb0ALUQhGtXQgwvGdO+YygwHLxh+CP2Q0MharbFW0+9ff
xb8zs/2vjP4KQtju2Z2JEf6ajkdVOUMCm+xmk4AylI252BfM4LMMaNXYuZX+A+6O
JTNKxPodurXxW1DOTFTgN++8+f/yxoKFT+FH+W42OKfAeuSyaA8M72CRd5/GeYGK
6p+GVJaqzhgBJFL7VeuI18PXMNi3LcGf6PJgmN3Zg7gvn5Wr5/Q9is6Kb1+RXoUS
gtYaJD2wGM3lsbWnV2xeStlo3+BlV2oU+Jv8vWCFlV+19Sz0+zqVFuy3IlPORBIl
1349ZrvBBq1utHO2+fyntoGv8ZOODuSdKfynTklfIOO7UezEXWY3EB5bLmMUxOoS
jArl6dW8gU9fjq3iOqEDv2IECxIX0KAsaGS3ipYVjpxMClthrf4zbxwUw6jPUKMl
qeB1vDHI
=6gID
-----END PGP SIGNATURE-----

--FZBP+mnZKzhKNNTS--
