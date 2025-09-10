Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B26CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 16:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FD683236;
	Wed, 10 Sep 2025 18:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE33F8323A; Wed, 10 Sep 2025 18:48:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6030D831D5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 18:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F3C216F2;
 Wed, 10 Sep 2025 09:48:07 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41A9F3F63F;
 Wed, 10 Sep 2025 09:48:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:48:09 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Said Nasibov <said.nasibov@arm.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <peter.hoyes@arm.com>, <david.hu2@arm.com>, <michael.zhao2@arm.com>,
 <marek.vasut+renesas@mailbox.org>, <mkorpershoek@kernel.org>,
 <pbrobinson@gmail.com>, <ilias.apalodimas@linaro.org>,
 <m.schwan@phytec.de>, <quentin.schulz@cherry.de>,
 <rayagonda.kokatanur@broadcom.com>, <tien.fong.chee@altera.com>,
 <casey.connolly@linaro.org>, <patrick.rudolph@9elements.com>,
 <alif.zakuan.yuslaimi@intel.com>, <boyan.karatotev@arm.com>,
 <Oliver.Gaskell@analog.com>, <duje@dujemihanovic.xyz>, <1425075683@qq.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [RFC PATCH 1/2] bootmeth: implement semihosting (smh) boot method
Message-ID: <20250910174809.64ad1ae2@donnerap>
In-Reply-To: <20250828130657.249153-2-said.nasibov@arm.com>
References: <20250828130657.249153-1-said.nasibov@arm.com>
 <20250828130657.249153-2-said.nasibov@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 28 Aug 2025 14:06:56 +0100
Said Nasibov <said.nasibov@arm.com> wrote:

Hi Said,

thanks for posting this!

(quite a long CC: list, but missing the semihosting maintainer! ;-) Adding
Sean)

> This commit introduces a new standard boot method that supports booting
> via semihosting as provided by ARM FVP platforms.
> 
> Semihosting enables the virtual platform to access host-side files as if
> they were block devices, which is particularly useful in early boot

it's not really "block devices", but "on a filesystem"

> development and simulation environments. It removes the need for physical
> storage or networking when loading kernel components.
> 
> This method mirrors the distroboot logic for semihosting, which is the
> default boot method for vexpress64 platform. The load_file_from_host
> helper function is implemented to mirror behaviour of "load hostfs" u-boot
> command, so it similarly sets filesize environment variable after loading a
> file - this is useful for later commands.
> 
> This implementation is marked with BOOTMETH_GLOBAL so it is always
> considered during bootflow scan without requiring a boot device.

So I like that this exposes this to all platforms, but it seems to
inherit some VExpress specific choices. And while $fdtfile seems to be used
quite universally across the tree, $kernel_name and $ramdisk_name seem more
arbitrary. I guess they are fine, but would be curious to hear if someone
else has a pointer to prior art which sets file names for those components.

Also, when stdboot replaces distroboot in the next patch, this will
silently drop support for the Android boot images. I am personally fine
with this, but wonder if we should keep the current boot flow, to not
break existing users.

So either we add bootimg support here, protected by ARCH_VEXPRESS, or we
add it in a separate file, with some kind of platform specific callback?

> 
> Signed-off-by: Said Nasibov <said.nasibov@arm.com>
> ---
>  boot/Kconfig        |  10 ++++
>  boot/Makefile       |   1 +
>  boot/bootmeth_smh.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 boot/bootmeth_smh.c
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2ff6f003738..fbd3f068908 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -936,6 +936,16 @@ config BOOTMETH_SCRIPT
>  	  This provides a way to try out standard boot on an existing boot flow.
>  	  It is not enabled by default to save space.
>  
> +config BOOTMETH_SMH
> +	bool "Bootdev support for semihosting"
> +	depends on SEMIHOSTING
> +	select CMD_FDT
> +	select BOOTMETH_GLOBAL
> +	help
> +	  Enables support for booting via semihosting. This bootmeth reads
> +	  files including the kernel, device tree and ramdisk directly from
> +	  the host's filesystem.
> +
>  config UPL
>  	bool "upl - Universal Payload Specification"
>  	imply CMD_UPL
> diff --git a/boot/Makefile b/boot/Makefile
> index 3da6f7a0914..5bed9e66507 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
>  obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_EFI_BOOTMGR) += bootmeth_efi_mgr.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_SMH) += bootmeth_smh.o
>  
>  obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += fdt_support.o
>  obj-$(CONFIG_$(PHASE_)FDT_SIMPLEFB) += fdt_simplefb.o
> diff --git a/boot/bootmeth_smh.c b/boot/bootmeth_smh.c
> new file mode 100644
> index 00000000000..2ceb66900ed
> --- /dev/null
> +++ b/boot/bootmeth_smh.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for booting using semihosting
> + *
> + * Copyright 2025 Arm Ltd.
> + * Written by Said Nasibov <said.nasibov@arm.com>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <bootmeth.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <fs.h>
> +
> +static int script_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +	return 0;
> +}
> +
> +static int load_file_from_host(const char *name_var, const char *addr_var)
> +{
> +	const char *filename = env_get(name_var);
> +	const char *addr_str = env_get(addr_var);
> +	ulong addr;
> +	loff_t len;
> +	int ret;
> +
> +	/* Mount hostfs (semihosting) */
> +	ret = fs_set_blk_dev("hostfs", NULL, FS_TYPE_ANY);
> +	if (ret)
> +		return log_msg_ret("hostfs", ret);
> +
> +	if (!filename || !addr_str)
> +		return log_msg_ret("env missing", -EINVAL);
> +
> +	addr = hextoul(addr_str, NULL);
> +	if (!addr)
> +		return log_msg_ret("invalid addr", -EINVAL);
> +
> +	/* Read file into memory */
> +	ret = fs_read(filename, addr, 0, 0, &len);
> +	if (ret)
> +		return log_msg_ret("fs_read", ret);
> +
> +	/* Set filesize environment variable in hex */
> +	char size_str[32];
> +	sprintf(size_str, "%lx", (unsigned long)len);
> +	env_set("filesize", size_str);
> +
> +	return 0;
> +}
> +
> +static int smh_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +	int ret;
> +
> +	ret = load_file_from_host("kernel_name", "kernel_addr_r");
> +	if (ret)
> +		return log_msg_ret("kernel", ret);
> +
> +	env_set("fdt_high", "0xffffffffffffffff");
> +	env_set("initrd_high", "0xffffffffffffffff");

As Tom already mentioned, this seems a bit of cargo cult, carried on from
generation to generation, we should drop this.

> +
> +	ret = load_file_from_host("fdtfile", "fdt_addr_r");
> +	if (ret) {
> +		ret = run_command("fdt move $fdtcontroladdr $fdt_addr_r;", 0);
> +		if (ret)
> +			return log_msg_ret("fdt move", ret);
> +	}
> +
> +	load_file_from_host("ramdisk_name", "ramdisk_addr_r");

Should we support running without an initramfs? So when this call fails,
we just use "-" for the second booti parameter.

But in general this seems to work, though it is a bit silent, in that it
doesn't announce the files (successfully) loaded, as it did before.

Cheers,
Andre

> +
> +	bflow->state = BOOTFLOWST_READY;
> +
> +	return 0;
> +}
> +
> +static int smh_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +	int ret = run_command("booti $kernel_addr_r ${ramdisk_addr_r}:${filesize} ${fdt_addr_r};", 0);
> +
> +	return ret;
> +}
> +
> +static int smh_bootmeth_bind(struct udevice *dev)
> +{
> +	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +	plat->desc = "semihosting";
> +	plat->flags = BOOTMETHF_GLOBAL;
> +
> +	return 0;
> +}
> +
> +static struct bootmeth_ops smh_bootmeth_ops = {
> +	.check		= script_check,
> +	.read_bootflow	= smh_read_bootflow,
> +	.boot		= smh_boot,
> +};
> +
> +static const struct udevice_id smh_bootmeth_ids[] = {
> +	{ .compatible = "u-boot,smh" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(bootmeth_0smh) = {
> +	.name		= "bootmeth_smh",
> +	.id		= UCLASS_BOOTMETH,
> +	.of_match	= smh_bootmeth_ids,
> +	.ops		= &smh_bootmeth_ops,
> +	.bind       = &smh_bootmeth_bind,
> +};

