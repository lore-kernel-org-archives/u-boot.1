Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14434C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 09:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF6B82C84;
	Tue, 24 Jun 2025 11:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="opwsvged";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D094082D88; Tue, 24 Jun 2025 11:01:44 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84B582C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 11:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AEAB84423C;
 Tue, 24 Jun 2025 09:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0CDC4CEE3;
 Tue, 24 Jun 2025 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750755699;
 bh=6dA7x8COWPdSWZW1RBSAhBnD4qsJp0qV52wOVTCXZp8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=opwsvgednwI00CnchWTK6CVsdZWboe051tZnE+qHyKOg4pya37tKGxjV/6pwMUSf6
 dbgMKtgo364X2R9OI+4Qu1/MFFv1I2G1nZWBOe2SFo7f8v5EY4cFG+gXRzjtffIPqc
 S8jC2oM95XuU/yfbM8gWPoWRL0OzFLZ6rPlUbldJ9AogXHExmz3wxTF778hTyjX5uC
 r/7r74Ni0Dvc2BPvYoBjW6/zkBhA1uX6uIu1ML3r6U5Ml8mxKMiVpfWKbMy3BsZ1m3
 jB+QsxuCQ1dotq8qQesaFkRgKTv/cOQxZjXnzLMdHzUwmjBtBjdWb2xYMM2TSVjR0z
 BunfYV5zz35Vg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Hrushikesh Salunke <h-salunke@ti.com>, trini@konsulko.com,
 Oliver.Gaskell@analog.com, peng.fan@nxp.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, twoerner@gmail.com, sjg@chromium.org,
 contact@paulk.fr, marex@denx.de, anshuld@ti.com,
 dario.binacchi@amarulasolutions.com, jerome.forissier@linaro.org,
 michael@amarulasolutions.com, a-dutta@ti.com, kever.yang@rock-chips.com,
 jonas@kwiboo.se, mkorpershoek@kernel.org
Cc: u-boot@lists.denx.de, h-salunke@ti.com, danishanwar@ti.com,
 s-vadapalli@ti.com, srk@ti.com
Subject: Re: [PATCH v3] spl: Add support for Device Firmware Upgrade (DFU)
 over PCIe
In-Reply-To: <20250619071841.1265364-1-h-salunke@ti.com>
References: <20250619071841.1265364-1-h-salunke@ti.com>
Date: Tue, 24 Jun 2025 11:01:37 +0200
Message-ID: <87v7olfr7y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Hrushikesh,

Thank you for the patch.

On Thu, Jun 19, 2025 at 12:48, Hrushikesh Salunke <h-salunke@ti.com> wrote:

> Introduces support for Device Firmware Upgrade (DFU) over PCIe in
> U-Boot. Traditionally, the DFU protocol is used over USB, where a
> device enters DFU mode and allows a host to upload firmware or binary
> images directly via the USB interface. This is a widely adopted and
> convenient method for updating firmware.
>
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
>
> By extending the DFU framework in U-Boot to support PCIe, it will be
> possible to flash images over PCIe. While this implementation is
> motivated by TI SoC use cases, the framework is generic and can be
> adopted by everyone for platforms that support PCIe Endpoint mode.
> Platforms with hardware support for PCIe-based memory loading can use
> this to implement PCIe as a boot mode, as well as to enable flashing
> and recovery scenarios similar to DFU over USB.
>
> In summary, enable support for:
> - DFU-style flashing of firmware/images over PCIe, analogous to existing
> USB DFU workflows
> - PCIe as a boot mode where a host can load images directly into device
> memory using DFU over PCIe
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
> This patch is based on commit
> 9de873b4c30 Merge patch series "linux/bitfield.h: sync <linux/bitfield.h>=
 from Linux 6.15 + winbond"
>
> Changes since v2
> Put the usage of macro BOOT_DEVICE_PCIE under #ifdef CONFIG_SPL_PCI_DFU
> to avoid potential compilation errors. This is required as=20
> BOOT_DEVICE_PCIE macro is defined for only those platforms which support
> PCIE as a valid boot device.
>
> v2 : https://patchwork.ozlabs.org/project/uboot/patch/20250616164444.6315=
75-1-h-salunke@ti.com/
>
>  common/spl/Kconfig   | 62 +++++++++++++++++++++++++++++
>  common/spl/spl_dfu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  common/spl/spl_ram.c | 18 +++++++++
>  drivers/Makefile     |  1 +
>  4 files changed, 174 insertions(+)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 880192043c4..212b4fc4e9e 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1268,6 +1268,14 @@ config SPL_PCI
>  	  necessary driver support. This enables the drivers in drivers/pci
>  	  as part of an SPL build.
>=20=20
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
>=20=20
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

Can we please prefix this symbol and all others with SPL_ as well?

SPL_PCI_DFU_LOAD_FIT_ADDRESS

Rationale: if we ever get DFU over PCIe in U-Boot proper, there will be
a naming clash.

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
>=20=20
>  static int run_dfu(int usb_index, char *interface, char *devstring)
>  {
> @@ -32,11 +43,93 @@ exit:
>  	return ret;
>  }
>=20=20
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

These seem like debug leftovers. Are we sure we need to be this verbose
in a normal operation mode?

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

Maybe be more specific: "Not copying boot phase. String too long\n"

This way, we inform the user about both the problem and the action the
code has taken (to not copy)

> +	} else {
> +		bootphase =3D (char *)(addr + CONFIG_PCI_DFU_BAR_SIZE -
> +				  (BOOT_PHASE_STRING_SIZE + MAGIC_WORD_SIZE));
> +		strncpy(bootphase, CONFIG_PCI_DFU_BOOT_PHASE,

Can't we use strlcpy here instead of strlcpy ?

> +			sizeof(CONFIG_PCI_DFU_BOOT_PHASE));
> +		bootphase[sizeof(CONFIG_PCI_DFU_BOOT_PHASE)] =3D '\0';

What happens when CONFIG_PCI_DFU_BOOT_PHASE is exactly 64 characters?
Won't we truncate the last character here in order to put '\0' ?

If so, maybe we should test for 63 characters max (like mentioned in the
KConfig entry description) ?

> +	}
> +
> +	addr =3D addr + offset;
> +	magic_word =3D CONFIG_PCI_DFU_MAGIC_WORD;
> +	(*(int *)addr) =3D 0;
> +	printf("%s: Waiting for an image .....\n", __func__);

Is this also a debug leftover?

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
>=20=20
> +#ifdef CONFIG_SPL_PCI_DFU

Can't we use if (IS_ENABLED(CONFIG...)) instead of #ifdef?

> +	if (spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +		return dfu_over_pcie();
> +#endif
> +
>  	/* set default environment */
>  	env_set_default(NULL, 0);
>  	str_env =3D env_get(dfu_alt_info);
> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 71b7a8374bb..c8a62a438bb 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -27,6 +27,11 @@ static ulong spl_ram_load_read(struct spl_load_info *l=
oad, ulong sector,
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>  		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>  				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +
> +#ifdef	CONFIG_SPL_PCI_DFU

Can't we use if (IS_ENABLED(CONFIG...)) instead of #ifdef?

Same for all occurences below

> +		if (spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +			addr =3D CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
> +#endif
>  	}
>  	addr +=3D sector;
>  	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
> @@ -47,6 +52,11 @@ static int spl_ram_load_image(struct spl_image_info *s=
pl_image,
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>  		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>  				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +
> +#ifdef	CONFIG_SPL_PCI_DFU
> +		if (spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +			addr =3D CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
> +#endif
>  	}
>=20=20
>  	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
> @@ -64,6 +74,11 @@ static int spl_ram_load_image(struct spl_image_info *s=
pl_image,
>  		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
>  #endif
>=20=20
> +#if CONFIG_IS_ENABLED(PCI_DFU)
> +	if (bootdev->boot_device =3D=3D BOOT_DEVICE_PCIE)
> +		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
> +#endif
> +
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
>  	    image_get_magic(header) =3D=3D FDT_MAGIC) {
>  		struct spl_load_info load;
> @@ -102,3 +117,6 @@ SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_=
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
> --=20
> 2.34.1
