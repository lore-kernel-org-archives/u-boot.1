Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B01CEB2E0
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 18:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2301F88875;
	Wed,  2 Oct 2024 20:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5973884DB; Wed,  2 Oct 2024 20:03:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 31C5388D29
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9447B339;
 Wed,  2 Oct 2024 11:03:40 -0700 (PDT)
Received: from [192.168.1.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3AE13F58B;
 Wed,  2 Oct 2024 11:03:09 -0700 (PDT)
Message-ID: <799c5b5a-a7c8-4f95-aee8-11bdc92f64e0@arm.com>
Date: Wed, 2 Oct 2024 19:03:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sunxi: Add a bootmeth for FEL
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20240901222734.462334-1-sjg@chromium.org>
 <20240901222734.462334-5-sjg@chromium.org>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240901222734.462334-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Simon,

On 01/09/2024 23:27, Simon Glass wrote:
> Add support for booting from a script loaded over FEL. This mirrors the
> bootcmd_fel provided by distro boot.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Put the FEL bootmeth before all other global bootmeths
> 
>   boot/Kconfig        | 14 ++++++++
>   boot/Makefile       |  1 +
>   boot/bootmeth_fel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+)
>   create mode 100644 boot/bootmeth_fel.c
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 291919ea1ef..7d6e819bde6 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -585,6 +585,20 @@ config BOOTMETH_EFI_BOOTMGR
>   	  the EFI binary to be launched is determined. To set the EFI variables
>   	  use the eficonfig command.
>   
> +config BOOTMETH_FEL
> +	bool "Bootdev support for Sunxi FEL"
> +	depends on ARCH_SUNXI
> +	default y
> +	help
> +	  Enables support for booting over USB on a Sunxi device. This uses
> +	  the FEL protocol and obtains the script address from the
> +	  'fel_scriptaddr' environment variable.

This is not quite accurate, can you please change this to something like 
(feel free to amend):
=======
Enables support for executing an explicit boot script uploaded before 
via the USB FEL protocol. The 'fel_scriptaddr' environment variable 
holds the address of this script, taken from the SPL header.
=======

(The flow is: The sunxi-fel tool detects an mkimage script file among 
its command line parameters, and amends the uploaded SPL header to store 
its upload address. U-Boot proper will detect the address in the SPL 
header, and sets the fel_scriptaddr variable.)

The actual code looks alright, and it seems to work (TM).

Just one thing I noticed:
....
Hit any key to stop autoboot:  0
** Booting bootflow '<NULL>' with fel
Hello from FEL script!

Is this <NULL> expected? Shall there be anything better in there?

Cheers,
Andre

> +
> +	  This method is only available if booting from FEL, i.e. the
> +	  'fel_booted' environment variable is set.
> +
> +	  See https://linux-sunxi.org/FEL/Protocol for more information.
> +
>   config BOOTMETH_QFW
>   	bool "Boot method using QEMU parameters"
>   	depends on QFW
> diff --git a/boot/Makefile b/boot/Makefile
> index f4675d6ffd5..295f27dfd39 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
> +obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_FEL) += bootmeth_fel.o
>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
> diff --git a/boot/bootmeth_fel.c b/boot/bootmeth_fel.c
> new file mode 100644
> index 00000000000..160ba6eb827
> --- /dev/null
> +++ b/boot/bootmeth_fel.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for sunxi FEL loading
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <bootdev.h>
> +#include <bootflow.h>
> +#include <bootmeth.h>
> +#include <command.h>
> +#include <dm.h>
> +#include <env.h>
> +
> +static int fel_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +	return 0;
> +}
> +
> +static int fel_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +	if (!env_get("fel_booted") || !env_get("fel_scriptaddr"))
> +		return -ENOENT;
> +
> +	bflow->state = BOOTFLOWST_READY;
> +
> +	return 0;
> +}
> +
> +static int fel_read_file(struct udevice *dev, struct bootflow *bflow,
> +			 const char *file_path, ulong addr, ulong *sizep)
> +{
> +	return -ENOSYS;
> +}
> +
> +static int fel_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +	ulong addr;
> +	int ret;
> +
> +	addr = env_get_hex("fel_scriptaddr", 0);
> +	ret = cmd_source_script(addr, NULL, NULL);
> +	if (ret)
> +		return log_msg_ret("boot", ret);
> +
> +	return 0;
> +}
> +
> +static int fel_bootmeth_bind(struct udevice *dev)
> +{
> +	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +	plat->desc = IS_ENABLED(CONFIG_BOOTSTD_FULL) ?
> +	   "Sunxi FEL boot over USB" : "FEL";
> +	plat->flags = BOOTMETHF_GLOBAL;
> +
> +	return 0;
> +}
> +
> +static struct bootmeth_ops fel_bootmeth_ops = {
> +	.check		= fel_check,
> +	.read_bootflow	= fel_read_bootflow,
> +	.read_file	= fel_read_file,
> +	.boot		= fel_boot,
> +};
> +
> +static const struct udevice_id fel_bootmeth_ids[] = {
> +	{ .compatible = "u-boot,fel-bootmeth" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_2fel) = {
> +	.name		= "bootmeth_fel",
> +	.id		= UCLASS_BOOTMETH,
> +	.of_match	= fel_bootmeth_ids,
> +	.ops		= &fel_bootmeth_ops,
> +	.bind		= fel_bootmeth_bind,
> +};
