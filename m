Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92772C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 14:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88FB88A93;
	Thu, 18 Jul 2024 16:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IsThfgW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D7188AB2; Thu, 18 Jul 2024 16:41:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0FE88A91
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721313662; x=1721918462; i=xypron.glpk@gmx.de;
 bh=rRaSNjnDLXQpPFHAu4YurofEaz4Ct8GYjjM51dDFF4g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IsThfgW2cZok1ISkqI5+b70IWwhq2N3/A8NsLpZvyaFU9S6wgJiRqDHZ/RZuE2+X
 GgzfeGEemvKc683E2uvznp4YQpWZBOJiKHBEVWaOGvVM+XcyvamXC+BkhKOBBNOGk
 k5FJwNmGxmqXMYHg8t4oJHqcK7KAmCSW19rMLK5zYK6urOEXTSF7NcvI0CHEP3uA8
 tNO1egAbOIv1Gq5MQDmvqJpUgt98RynYAhXI6YQ1abqc1V0+gd9v7DJAQLcRD4nZe
 K+x5iwCkh0GIDit2RADX71Ce1QOOOkARtq2wTtdfOu8Vmi/EXyxh2+XE0R9OUuhuQ
 RY5ne2qMomjkbN8FFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1sFVsk32Gh-00xW7l; Thu, 18
 Jul 2024 16:41:01 +0200
Message-ID: <e3e22587-b573-4d07-8bbf-725802ba3036@gmx.de>
Date: Thu, 18 Jul 2024 16:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] upl: Add support for reading a upl handoff
To: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-11-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240713070055.2172883-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ykhIDgZEVip/3MvW9U7r795orYBuhltBJ255eArAIGFvzfstJt9
 WnZfqpnrHHZ1EbjQKE5rHlYRUTfNUknPkzZRdR86N0HUdF0VHz0ChnYymBN6CwwmN+sr1Gn
 IgPAII194X3sIieb+x9/z5j+GOjnyeWFMb1geqqxegMrZJnZLryZhhU7uotFCh03EuDC3l7
 aiIOvVkXKs/er3BWuuwZQ==
UI-OutboundReport: notjunk:1;M01:P0:mAs0oP61G04=;FFz2k6HuCzFZ81DksQJlLXDTWLS
 +xgVDweUARBnWs4ie0ZCqzbLYkNd4gA14J7UcSFTl372pBjVoufQRIhacZ0Fjmsv4zoLMBORe
 odtXb0OrxK5CaeZ7NHWOSIFbH89YecBHFWl/SopHdp4uLSkV86g4nda7G4b2NKd31hzpyo3rm
 nwBLt23IGXXn3qjTT9Uca+EXzDZmvhU6hx616xoAYAvOFmiPt6GC/aisiB+axRntJ8h1GCgAP
 n+f0WJEN04Mr8qRLXXPWPMgNFagVXTj5aK++ldpbeo06PjpuzwSK2a3IsIZvnrXlWOTeb1E6J
 zwbKycVBlf+qYPZAZHRDIODirrzgVTNWlFHa+gg8ZBnspNKoSiPBwIykRWndM3f2xb58QUR5K
 T0++LKzfIfguz9cLmZCwJ/l1uEPIeBothyg2NZoDJsF2Axxy6nFKirFYmzmXGfsLrOVx/vqcs
 cgSzr9Q9hyauxX0JPz9Dzfhefw/YktRF7e67qel3RDB9ny+YLiE7ANJTqehquJQO9alOpuqAq
 Yv0j/Pfpd3MlOl0FfnZTKIRvDb1FzWyYfeMc8y41443dB2wM9u5x5B8HcGtUSN6Gv/hupwWxr
 e/jftHbeuf7cvmV3S3qF1rnbnCfw5t5A80B6mz6dx/whh2bhBbu77eBcCnvOHAGDuxaxKWYKJ
 XKsMWPrTuOh8EENGOGnrUNN2ciaf474g9oZ+rj7EPDNZNZf4uWPf0P56S9cTAu6GJZ4ONxUR8
 U25yW9MxMvehqZE5oG56q9L6geR7HCa1rAowIRfIpT2H878Z492m+9Sntzf8asnzBTvQ05+4c
 sUszVMRWsiQmZIwcMa4y0ZQQ==
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

On 13.07.24 09:00, Simon Glass wrote:
> Universal Payload provides a standard way of handing off control between
> two firmware phases. Add support for reading the handoff information int=
o
> a structure.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   MAINTAINERS               |   7 +
>   boot/Kconfig              |  19 ++
>   boot/Makefile             |   3 +
>   boot/upl_common.c         |  60 ++++
>   boot/upl_common.h         |  24 ++
>   boot/upl_read.c           | 588 ++++++++++++++++++++++++++++++++++++++
>   configs/sandbox_defconfig |   1 +
>   include/upl.h             | 352 +++++++++++++++++++++++
>   8 files changed, 1054 insertions(+)
>   create mode 100644 boot/upl_common.c
>   create mode 100644 boot/upl_common.h
>   create mode 100644 boot/upl_read.c
>   create mode 100644 include/upl.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c6de3a1d84..23852fbde38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1694,6 +1694,13 @@ M:	Neha Malcom Francis <n-francis@ti.com>
>   S:	Maintained
>   F:	drivers/ufs/
>
> +UPL
> +M:	Simon Glass <sjg@chromium.org>
> +S:	Maintained
> +T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
> +F:	boot/upl*
> +F:	include/upl.h
> +
>   USB
>   M:	Marek Vasut <marex@denx.de>
>   S:	Maintained
> diff --git a/boot/Kconfig b/boot/Kconfig
> index ffcae840a50..f371772acb9 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -719,6 +719,25 @@ config BOOTMETH_SCRIPT
>   	  This provides a way to try out standard boot on an existing boot fl=
ow.
>   	  It is not enabled by default to save space.
>
> +config UPL
> +	bool "upl - Universal Payload Specification"
> +	imply UPL_READ
> +	help
> +	  Provides support for UPL payloads and handoff information. U-Boot
> +	  supports generating and accepting handoff information. The mkimage
> +	  tool will eventually support creating payloads.
> +
> +if UPL
> +
> +config UPL_READ
> +	bool "upl - Support reading a Universal Payload handoff"
> +	help
> +	  Provides support for decoding a UPL-format payload into a C structur=
e
> +	  which can be used elsewhere in U-Boot. This is just the reading
> +	  implementation, useful for trying it out.
> +
> +endif  # UPL
> +
>   endif # BOOTSTD
>
>   config LEGACY_IMAGE_FORMAT
> diff --git a/boot/Makefile b/boot/Makefile
> index 84ccfeaecec..c4720d93ca3 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -43,6 +43,9 @@ endif
>   obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) +=3D fdt_support.o
>   obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) +=3D fdt_simplefb.o
>
> +obj-$(CONFIG_$(SPL_TPL_)UPL) +=3D upl_common.o
> +obj-$(CONFIG_$(SPL_TPL_)UPL_READ) +=3D upl_read.o
> +
>   obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) +=3D image-fdt.o
>   obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) +=3D fdt_region.o
>   obj-$(CONFIG_$(SPL_TPL_)FIT) +=3D image-fit.o
> diff --git a/boot/upl_common.c b/boot/upl_common.c
> new file mode 100644
> index 00000000000..3924423abd5
> --- /dev/null
> +++ b/boot/upl_common.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * UPL handoff command functions
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <string.h>
> +#include <upl.h>
> +
> +/* Names of bootmodes */
> +const char *const bootmode_names[UPLBM_COUNT] =3D {
> +	[UPLBM_FULL]	=3D "full",
> +	[UPLBM_MINIMAL]	=3D "minimal",
> +	[UPLBM_FAST]	=3D "fast",
> +	[UPLBM_DIAG]	=3D "diag",
> +	[UPLBM_DEFAULT]	=3D "default",
> +	[UPLBM_S2]	=3D "s2",
> +	[UPLBM_S3]	=3D "s3",
> +	[UPLBM_S4]	=3D "s4",
> +	[UPLBM_S5]	=3D "s5",
> +	[UPLBM_FACTORY]	=3D "factory",
> +	[UPLBM_FLASH]	=3D "flash",
> +	[UPLBM_RECOVERY] =3D "recovery",
> +};
> +
> +/* Names of memory usages */
> +const char *const usage_names[UPLUS_COUNT] =3D {
> +	[UPLUS_ACPI_RECLAIM]	=3D "acpi-reclaim",
> +	[UPLUS_ACPI_NVS]	=3D "acpi-nvs",
> +	[UPLUS_BOOT_CODE]	=3D "boot-code",
> +	[UPLUS_BOOT_DATA]	=3D "boot-data",
> +	[UPLUS_RUNTIME_CODE]	=3D "runtime-code",
> +	[UPLUS_RUNTIME_DATA]	=3D "runtime-data",
> +};
> +
> +/* Names of access types */
> +const char *const access_types[UPLUS_COUNT] =3D {
> +	[UPLAT_MMIO]	=3D "mmio",
> +	[UPLAT_IO]	=3D "io",
> +};
> +
> +/* Names of graphics formats */
> +const char *const graphics_formats[UPLUS_COUNT] =3D {
> +	[UPLGF_ARGB32]	=3D "a8r8g8b8",
> +	[UPLGF_ABGR32]	=3D "a8b8g8r8",
> +	[UPLGF_ABGR64]	=3D "a16b16g16r16",
> +};
> +
> +void upl_init(struct upl *upl)
> +{
> +	memset(upl, '\0', sizeof(struct upl));
> +	alist_init_struct(&upl->image, struct upl_image);
> +	alist_init_struct(&upl->mem, struct upl_mem);
> +	alist_init_struct(&upl->memmap, struct upl_memmap);
> +	alist_init_struct(&upl->memres, struct upl_memres);
> +}
> diff --git a/boot/upl_common.h b/boot/upl_common.h
> new file mode 100644
> index 00000000000..cc517dc1de9
> --- /dev/null
> +++ b/boot/upl_common.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * UPL handoff command functions
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#ifndef __UPL_COMMON_H
> +#define __UPL_COMMON_H
> +
> +/* Names of bootmodes */
> +extern const char *const bootmode_names[UPLBM_COUNT];
> +
> +/* Names of memory usages */
> +extern const char *const usage_names[UPLUS_COUNT];
> +
> +/* Names of access types */
> +extern const char *const access_types[UPLUS_COUNT];
> +
> +/* Names of graphics formats */
> +extern const char *const graphics_formats[UPLUS_COUNT];
> +
> +#endif /* __UPL_COMMON_H */
> diff --git a/boot/upl_read.c b/boot/upl_read.c
> new file mode 100644
> index 00000000000..2d8caa6ef11
> --- /dev/null
> +++ b/boot/upl_read.c
> @@ -0,0 +1,588 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * UPL handoff parsing
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <log.h>
> +#include <upl.h>
> +#include <dm/ofnode.h>
> +#include "upl_common.h"
> +
> +/**
> + * read_addr() - Read an address
> + *
> + * Reads an address in the correct format, either 32- or 64-bit
> + *
> + * @upl: UPL state
> + * @node: Node to read from
> + * @prop: Property name to read
> + * @addr: Place to put the address
> + * Return: 0 if OK, -ve on error
> + */
> +static int read_addr(const struct upl *upl, ofnode node, const char *pr=
op,
> +		     ulong *addrp)
> +{
> +	int ret;
> +
> +	if (upl->addr_cells =3D=3D 1) {
> +		u32 val;
> +
> +		ret =3D ofnode_read_u32(node, prop, &val);
> +		if (!ret)
> +			*addrp =3D val;
> +	} else {
> +		u64 val;
> +
> +		ret =3D ofnode_read_u64(node, prop, &val);
> +		if (!ret)
> +			*addrp =3D val;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * read_size() - Read a size
> + *
> + * Reads a size in the correct format, either 32- or 64-bit
> + *
> + * @upl: UPL state
> + * @node: Node to read from
> + * @prop: Property name to read
> + * @addr: Place to put the size
> + * Return: 0 if OK, -ve on error
> + */
> +static int read_size(const struct upl *upl, ofnode node, const char *pr=
op,
> +		     ulong *sizep)
> +{
> +	int ret;
> +
> +	if (upl->size_cells =3D=3D 1) {
> +		u32 val;
> +
> +		ret =3D ofnode_read_u32(node, prop, &val);
> +		if (!ret)
> +			*sizep =3D val;
> +	} else {
> +		u64 val;
> +
> +		ret =3D ofnode_read_u64(node, prop, &val);
> +		if (!ret)
> +			*sizep =3D val;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * ofnode_read_bitmask() - Read a bit mask from a string list
> + *
> + * @node: Node to read from
> + * @prop: Property name to read
> + * @names: Array of names for each bit
> + * @count: Number of array entries
> + * @value: Returns resulting bit-mask value on success
> + * Return: 0 if OK, -EINVAL if a bit number is not defined, -ENOSPC if =
the
> + * string is too long for the (internal) buffer, -EINVAL if no such pro=
perty
> + */
> +static int ofnode_read_bitmask(ofnode node, const char *prop,
> +			       const char *const names[], uint count,
> +			       uint *valuep)
> +{
> +	const char **list;
> +	const char **strp;
> +	uint val;
> +	uint bit;
> +	int ret;
> +
> +	ret =3D ofnode_read_string_list(node, prop, &list);
> +	if (ret < 0)
> +		return log_msg_ret("rea", ret);
> +
> +	val =3D 0;
> +	for (strp =3D list; *strp; strp++) {
> +		const char *str =3D *strp;
> +		bool found =3D false;
> +
> +		for (bit =3D 0; bit < count; bit++) {
> +			if (!strcmp(str, names[bit])) {
> +				found =3D true;
> +				break;
> +			}
> +		}
> +		if (found)
> +			val |=3D BIT(bit);
> +		else
> +			log_warning("%s/%s: Invalid value '%s'\n",
> +				    ofnode_get_name(node), prop, str);
> +	}
> +	*valuep =3D val;
> +
> +	return 0;
> +}
> +
> +/**
> + * ofnode_read_value() - Read a string value as an int using a lookup
> + *
> + * @node: Node to read from
> + * @prop: Property name to read
> + * @names: Array of names for each int value
> + * @count: Number of array entries
> + * @valuep: Returns int value read
> + * Return: 0 if OK, -EINVAL if a bit number is not defined, -ENOENT if =
the
> + * property does not exist
> + */
> +static int ofnode_read_value(ofnode node, const char *prop,
> +			     const char *const names[], uint count,
> +			     uint *valuep)
> +{
> +	const char *str;
> +	int i;
> +
> +	str =3D ofnode_read_string(node, prop);
> +	if (!str)
> +		return log_msg_ret("rd", -ENOENT);
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (!strcmp(names[i], str)) {
> +			*valuep =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	log_debug("Unnamed value '%s'\n", str);
> +	return log_msg_ret("val", -EINVAL);
> +}
> +
> +static int read_uint(ofnode node, const char *prop, uint *valp)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D ofnode_read_u32(node, prop, &val);
> +	if (ret)
> +		return ret;
> +	*valp =3D val;
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_root_props() - Decode root properties from the tree
> + *
> + * @upl: UPL state
> + * @node: Node to decode
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_root_props(struct upl *upl, ofnode node)
> +{
> +	int ret;
> +
> +	ret =3D read_uint(node, UPLP_ADDRESS_CELLS, &upl->addr_cells);
> +	if (!ret)
> +		ret =3D read_uint(node, UPLP_SIZE_CELLS, &upl->size_cells);

Why do we need a special handling of addr_cells and size_cells?
The device-tree provided by UPL follows the device-tree specification
which requires to set these properties in the parent of the node.

Best regards

Heinrich

> +	if (ret)
> +		return log_msg_ret("cel", ret);
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_root_props() - Decode UPL parameters from the tree
> + *
> + * @upl: UPL state
> + * @node: Node to decode
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_params(struct upl *upl, ofnode options)
> +{
> +	ofnode node;
> +	int ret;
> +
> +	node =3D ofnode_find_subnode(options, UPLN_UPL_PARAMS);
> +	if (!ofnode_valid(node))
> +		return log_msg_ret("par", -EINVAL);
> +	log_debug("decoding '%s'\n", ofnode_get_name(node));
> +
> +	ret =3D read_addr(upl, node, UPLP_SMBIOS, &upl->smbios);
> +	if (ret)
> +		return log_msg_ret("smb", ret);
> +	ret =3D read_addr(upl, node, UPLP_ACPI, &upl->acpi);
> +	if (ret)
> +		return log_msg_ret("acp", ret);
> +	ret =3D ofnode_read_bitmask(node, UPLP_BOOTMODE, bootmode_names,
> +				  UPLBM_COUNT, &upl->bootmode);
> +	if (ret)
> +		return log_msg_ret("boo", ret);
> +	ret =3D read_uint(node, UPLP_ADDR_WIDTH, &upl->addr_width);
> +	if (ret)
> +		return log_msg_ret("add", ret);
> +	ret =3D read_uint(node, UPLP_ACPI_NVS_SIZE, &upl->acpi_nvs_size);
> +	if (ret)
> +		return log_msg_ret("nvs", ret);
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_upl_images() - Decode /options/upl-image nodes
> + *
> + * @node: /options node in which to look for the node
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_images(struct upl *upl, ofnode options)
> +{
> +	ofnode node, images;
> +	int ret;
> +
> +	images =3D ofnode_find_subnode(options, UPLN_UPL_IMAGE);
> +	if (!ofnode_valid(images))
> +		return log_msg_ret("img", -EINVAL);
> +	log_debug("decoding '%s'\n", ofnode_get_name(images));
> +
> +	ret =3D read_addr(upl, images, UPLP_FIT, &upl->fit);
> +	if (!ret)
> +		ret =3D read_uint(images, UPLP_CONF_OFFSET, &upl->conf_offset);
> +	if (ret)
> +		return log_msg_ret("cnf", ret);
> +
> +	ofnode_for_each_subnode(node, images) {
> +		struct upl_image img;
> +
> +		ret =3D read_addr(upl, node, UPLP_LOAD, &img.load);
> +		if (!ret)
> +			ret =3D read_size(upl, node, UPLP_SIZE, &img.size);
> +		if (!ret)
> +			ret =3D read_uint(node, UPLP_OFFSET, &img.offset);
> +		img.description =3D ofnode_read_string(node, UPLP_DESCRIPTION);
> +		if (!img.description)
> +			return log_msg_ret("sim", ret);
> +		if (!alist_add(&upl->image, img, struct upl_image))
> +			return log_msg_ret("img", -ENOMEM);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_addr_size() - Decide a set of addr/size pairs
> + *
> + * Each base/size value from the devicetree is written to the region li=
st
> + *
> + * @upl: UPL state
> + * @buf: Bytes to decode
> + * @size: Number of bytes to decode
> + * @regions: List of regions to process (struct memregion)
> + * Returns: number of regions found, if OK, else -ve on error
> + */
> +static int decode_addr_size(const struct upl *upl, const char *buf, int=
 size,
> +			    struct alist *regions)
> +{
> +	const char *ptr, *end =3D buf + size;
> +	int i;
> +
> +	alist_init_struct(regions, struct memregion);
> +	ptr =3D buf;
> +	for (i =3D 0; ptr < end; i++) {
> +		struct memregion reg;
> +
> +		if (upl->addr_cells =3D=3D 1)
> +			reg.base =3D fdt32_to_cpu(*(u32 *)ptr);
> +		else
> +			reg.base =3D fdt64_to_cpu(*(u64 *)ptr);
> +		ptr +=3D upl->addr_cells * sizeof(u32);
> +
> +		if (upl->size_cells =3D=3D 1)
> +			reg.size =3D fdt32_to_cpu(*(u32 *)ptr);
> +		else
> +			reg.size =3D fdt64_to_cpu(*(u64 *)ptr);
> +		ptr +=3D upl->size_cells * sizeof(u32);
> +		if (ptr > end)
> +			return -ENOSPC;
> +
> +		if (!alist_add(regions, reg, struct memregion))
> +			return log_msg_ret("reg", -ENOMEM);
> +	}
> +
> +	return i;
> +}
> +
> +/**
> + * node_matches_at() - Check if a node name matches "base@..."
> + *
> + * Return: true if the node name matches the base string followed by an=
 @ sign;
> + * false otherwise
> + */
> +static bool node_matches_at(ofnode node, const char *base)
> +{
> +	const char *name =3D ofnode_get_name(node);
> +	int len =3D strlen(base);
> +
> +	return !strncmp(base, name, len) && name[len] =3D=3D '@';
> +}
> +
> +/**
> + * decode_upl_memory_node() - Decode a /memory node from the tree
> + *
> + * @upl: UPL state
> + * @node: Node to decode
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_memory_node(struct upl *upl, ofnode node)
> +{
> +	struct upl_mem mem;
> +	const char *buf;
> +	int size, len;
> +
> +	buf =3D ofnode_read_prop(node, UPLP_REG, &size);
> +	if (!buf) {
> +		log_warning("Node '%s': Missing '%s' property\n",
> +			    ofnode_get_name(node), UPLP_REG);
> +		return log_msg_ret("reg", -EINVAL);
> +	}
> +	len =3D decode_addr_size(upl, buf, size, &mem.region);
> +	if (len < 0)
> +		return log_msg_ret("buf", len);
> +	mem.hotpluggable =3D ofnode_read_bool(node, UPLP_HOTPLUGGABLE);
> +	if (!alist_add(&upl->mem, mem, struct upl_mem))
> +		return log_msg_ret("mem", -ENOMEM);
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_upl_memmap() - Decode memory-map nodes from the tree
> + *
> + * @upl: UPL state
> + * @root: Parent node containing the /memory-map nodes
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_memmap(struct upl *upl, ofnode root)
> +{
> +	ofnode node;
> +
> +	ofnode_for_each_subnode(node, root) {
> +		struct upl_memmap memmap;
> +		int size, len, ret;
> +		const char *buf;
> +
> +		memmap.name =3D ofnode_get_name(node);
> +		memmap.usage =3D 0;
> +
> +		buf =3D ofnode_read_prop(node, UPLP_REG, &size);
> +		if (!buf) {
> +			log_warning("Node '%s': Missing '%s' property\n",
> +				    ofnode_get_name(node), UPLP_REG);
> +			continue;
> +		}
> +
> +		len =3D decode_addr_size(upl, buf, size, &memmap.region);
> +		if (len < 0)
> +			return log_msg_ret("buf", len);
> +		ret =3D ofnode_read_bitmask(node, UPLP_USAGE, usage_names,
> +					  UPLUS_COUNT, &memmap.usage);
> +		if (ret && ret !=3D -EINVAL)	/* optional property */
> +			return log_msg_ret("bit", ret);
> +
> +		if (!alist_add(&upl->memmap, memmap, struct upl_memmap))
> +			return log_msg_ret("mmp", -ENOMEM);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_upl_memres() - Decode reserved-memory nodes from the tree
> + *
> + * @upl: UPL state
> + * @root: Parent node containing the reserved-memory nodes
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_memres(struct upl *upl, ofnode root)
> +{
> +	ofnode node;
> +
> +	ofnode_for_each_subnode(node, root) {
> +		struct upl_memres memres;
> +		const char *buf;
> +		int size, len;
> +
> +		log_debug("decoding '%s'\n", ofnode_get_name(node));
> +		memres.name =3D ofnode_get_name(node);
> +
> +		buf =3D ofnode_read_prop(node, UPLP_REG, &size);
> +		if (!buf) {
> +			log_warning("Node '%s': Missing 'reg' property\n",
> +				    ofnode_get_name(node));
> +			continue;
> +		}
> +
> +		len =3D decode_addr_size(upl, buf, size, &memres.region);
> +		if (len < 0)
> +			return log_msg_ret("buf", len);
> +		memres.no_map =3D ofnode_read_bool(node, UPLP_NO_MAP);
> +
> +		if (!alist_add(&upl->memres, memres, struct upl_memres))
> +			return log_msg_ret("mre", -ENOMEM);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_upl_serial() - Decode the serial node
> + *
> + * @upl: UPL state
> + * @root: Parent node contain node
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_serial(struct upl *upl, ofnode node)
> +{
> +	struct upl_serial *ser =3D &upl->serial;
> +	const char *buf;
> +	int len, size;
> +	int ret;
> +
> +	ser->compatible =3D ofnode_read_string(node, UPLP_COMPATIBLE);
> +	if (!ser->compatible) {
> +		log_warning("Node '%s': Missing compatible string\n",
> +			    ofnode_get_name(node));
> +		return log_msg_ret("com", -EINVAL);
> +	}
> +	ret =3D read_uint(node, UPLP_CLOCK_FREQUENCY, &ser->clock_frequency);
> +	if (!ret)
> +		ret =3D read_uint(node, UPLP_CURRENT_SPEED, &ser->current_speed);
> +	if (ret)
> +		return log_msg_ret("spe", ret);
> +
> +	buf =3D ofnode_read_prop(node, UPLP_REG, &size);
> +	if (!buf) {
> +		log_warning("Node '%s': Missing 'reg' property\n",
> +			    ofnode_get_name(node));
> +		return log_msg_ret("reg", -EINVAL);
> +	}
> +
> +	len =3D decode_addr_size(upl, buf, sizeof(buf), &ser->reg);
> +	if (len < 0)
> +		return log_msg_ret("buf", len);
> +
> +	/* set defaults */
> +	ser->reg_io_shift =3D UPLD_REG_IO_SHIFT;
> +	ser->reg_offset =3D UPLD_REG_OFFSET;
> +	ser->reg_io_width =3D UPLD_REG_IO_WIDTH;
> +	read_uint(node, UPLP_REG_IO_SHIFT, &ser->reg_io_shift);
> +	read_uint(node, UPLP_REG_OFFSET, &ser->reg_offset);
> +	read_uint(node, UPLP_REG_IO_WIDTH, &ser->reg_io_width);
> +	read_addr(upl, node, UPLP_VIRTUAL_REG, &ser->virtual_reg);
> +	ret =3D ofnode_read_value(node, UPLP_ACCESS_TYPE, access_types,
> +				ARRAY_SIZE(access_types), &ser->access_type);
> +	if (ret && ret !=3D -ENOENT)
> +		return log_msg_ret("ser", ret);
> +
> +	return 0;
> +}
> +
> +/**
> + * decode_upl_graphics() - Decode graphics node
> + *
> + * @upl: UPL state
> + * @root: Node to decode
> + * Return 0 if OK, -ve on error
> + */
> +static int decode_upl_graphics(struct upl *upl, ofnode node)
> +{
> +	struct upl_graphics *gra =3D &upl->graphics;
> +	const char *buf, *compat;
> +	int len, size;
> +	int ret;
> +
> +	compat =3D ofnode_read_string(node, UPLP_COMPATIBLE);
> +	if (!compat) {
> +		log_warning("Node '%s': Missing compatible string\n",
> +			    ofnode_get_name(node));
> +		return log_msg_ret("com", -EINVAL);
> +	}
> +	if (strcmp(UPLC_GRAPHICS, compat)) {
> +		log_warning("Node '%s': Ignoring compatible '%s'\n",
> +			    ofnode_get_name(node), compat);
> +		return 0;
> +	}
> +
> +	buf =3D ofnode_read_prop(node, UPLP_REG, &size);
> +	if (!buf) {
> +		log_warning("Node '%s': Missing 'reg' property\n",
> +			    ofnode_get_name(node));
> +		return log_msg_ret("reg", -EINVAL);
> +	}
> +
> +	len =3D decode_addr_size(upl, buf, sizeof(buf), &gra->reg);
> +	if (len < 0)
> +		return log_msg_ret("buf", len);
> +
> +	ret =3D read_uint(node, UPLP_WIDTH, &gra->width);
> +	if (!ret)
> +		ret =3D read_uint(node, UPLP_HEIGHT, &gra->height);
> +	if (!ret)
> +		ret =3D read_uint(node, UPLP_STRIDE, &gra->stride);
> +	if (!ret) {
> +		ret =3D ofnode_read_value(node, UPLP_GRAPHICS_FORMAT,
> +					graphics_formats,
> +					ARRAY_SIZE(graphics_formats),
> +					&gra->format);
> +	}
> +	if (ret)
> +		return log_msg_ret("pro", ret);
> +
> +	return 0;
> +}
> +
> +int upl_read_handoff(struct upl *upl, oftree tree)
> +{
> +	ofnode root, node;
> +	int ret;
> +
> +	if (!oftree_valid(tree))
> +		return log_msg_ret("tre", -EINVAL);
> +
> +	root =3D oftree_root(tree);
> +
> +	upl_init(upl);
> +	ret =3D decode_root_props(upl, root);
> +	if (ret)
> +		return log_msg_ret("roo", ret);
> +
> +	ofnode_for_each_subnode(node, root) {
> +		const char *name =3D ofnode_get_name(node);
> +
> +		log_debug("decoding '%s'\n", name);
> +		if (!strcmp(UPLN_OPTIONS, name)) {
> +			ret =3D decode_upl_params(upl, node);
> +			if (ret)
> +				return log_msg_ret("opt", ret);
> +
> +			ret =3D decode_upl_images(upl, node);
> +		} else if (node_matches_at(node, UPLN_MEMORY)) {
> +			ret =3D decode_upl_memory_node(upl, node);
> +		} else if (!strcmp(UPLN_MEMORY_MAP, name)) {
> +			ret =3D decode_upl_memmap(upl, node);
> +		} else if (!strcmp(UPLN_MEMORY_RESERVED, name)) {
> +			ret =3D decode_upl_memres(upl, node);
> +		} else if (node_matches_at(node, UPLN_SERIAL)) {
> +			ret =3D decode_upl_serial(upl, node);
> +		} else if (node_matches_at(node, UPLN_GRAPHICS)) {
> +			ret =3D decode_upl_graphics(upl, node);
> +		} else {
> +			log_debug("Unknown node '%s'\n", name);
> +			ret =3D 0;
> +		}
> +		if (ret)
> +			return log_msg_ret("err", ret);
> +	}
> +
> +	return 0;
> +}
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index da8c1976d7b..b5d1b69da2a 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -15,6 +15,7 @@ CONFIG_FIT=3Dy
>   CONFIG_FIT_RSASSA_PSS=3Dy
>   CONFIG_FIT_CIPHER=3Dy
>   CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_UPL=3Dy
>   CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>   CONFIG_MEASURED_BOOT=3Dy
>   CONFIG_BOOTSTAGE=3Dy
> diff --git a/include/upl.h b/include/upl.h
> new file mode 100644
> index 00000000000..793d1e86dbb
> --- /dev/null
> +++ b/include/upl.h
> @@ -0,0 +1,352 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * UPL handoff generation
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#ifndef __UPL_WRITE_H
> +#define __UPL_WRITE_H
> +
> +#include <alist.h>
> +#include <dm/ofnode_decl.h>
> +
> +struct unit_test_state;
> +
> +#define UPLP_ADDRESS_CELLS	"#address-cells"
> +#define UPLP_SIZE_CELLS		"#size-cells"
> +
> +#define UPLN_OPTIONS		"options"
> +#define UPLN_UPL_PARAMS		"upl-params"
> +#define UPLP_SMBIOS		"smbios"
> +#define UPLP_ACPI		"acpi"
> +#define UPLP_BOOTMODE		"bootmode"
> +#define UPLP_ADDR_WIDTH		"addr-width"
> +#define UPLP_ACPI_NVS_SIZE	"acpi-nvs-size"
> +
> +#define UPLPATH_UPL_IMAGE	"/options/upl-image"
> +#define UPLN_UPL_IMAGE		"upl-image"
> +#define UPLN_IMAGE		"image"
> +#define UPLP_FIT		"fit"
> +#define UPLP_CONF_OFFSET	"conf-offset"
> +#define UPLP_LOAD		"load"
> +#define UPLP_SIZE		"size"
> +#define UPLP_OFFSET		"offset"
> +#define UPLP_DESCRIPTION	"description"
> +
> +#define UPLN_MEMORY		"memory"
> +#define UPLP_HOTPLUGGABLE	"hotpluggable"
> +
> +#define UPLPATH_MEMORY_MAP	"/memory-map"
> +#define UPLN_MEMORY_MAP		"memory-map"
> +#define UPLP_USAGE		"usage"
> +
> +#define UPLN_MEMORY_RESERVED	"reserved-memory"
> +#define UPLPATH_MEMORY_RESERVED	"/reserved-memory"
> +#define UPLP_NO_MAP		"no-map"
> +
> +#define UPLN_SERIAL		"serial"
> +#define UPLP_REG		"reg"
> +#define UPLP_COMPATIBLE		"compatible"
> +#define UPLP_CLOCK_FREQUENCY	"clock-frequency"
> +#define UPLP_CURRENT_SPEED	"current-speed"
> +#define UPLP_REG_IO_SHIFT	"reg-io-shift"
> +#define UPLP_REG_OFFSET		"reg-offset"
> +#define UPLP_REG_IO_WIDTH	"reg-io-width"
> +#define UPLP_VIRTUAL_REG	"virtual-reg"
> +#define UPLP_ACCESS_TYPE	"access-type"
> +
> +#define UPLN_GRAPHICS		"framebuffer"
> +#define UPLC_GRAPHICS		"simple-framebuffer"
> +#define UPLP_WIDTH		"width"
> +#define UPLP_HEIGHT		"height"
> +#define UPLP_STRIDE		"stride"
> +#define UPLP_GRAPHICS_FORMAT	"format"
> +
> +/**
> + * enum upl_boot_mode - Encodes the boot mode
> + *
> + * Each is a bit number from the boot_mode mask
> + */
> +enum upl_boot_mode {
> +	UPLBM_FULL,
> +	UPLBM_MINIMAL,
> +	UPLBM_FAST,
> +	UPLBM_DIAG,
> +	UPLBM_DEFAULT,
> +	UPLBM_S2,
> +	UPLBM_S3,
> +	UPLBM_S4,
> +	UPLBM_S5,
> +	UPLBM_FACTORY,
> +	UPLBM_FLASH,
> +	UPLBM_RECOVERY,
> +
> +	UPLBM_COUNT,
> +};
> +
> +/**
> + * struct upl_image - UPL image informaiton
> + *
> + * @load: Address image was loaded to
> + * @size: Size of image in bytes
> + * @offset: Offset of the image in the FIT (0=3Dnone)
> + * @desc: Description of the iamge (taken from the FIT)
> + */
> +struct upl_image {
> +	ulong load;
> +	ulong size;
> +	uint offset;
> +	const char *description;
> +};
> +
> +/**
> + * struct memregion - Information about a region of memory
> + *
> + * @base: Base address
> + * @size: Size in bytes
> + */
> +struct memregion {
> +	ulong base;
> +	ulong size;
> +};
> +
> +/**
> + * struct upl_mem - Information about physical-memory layout
> + *
> + * TODO: Figure out initial-mapped-area
> + *
> + * @region: Memory region list (struct memregion)
> + * @hotpluggable: true if hotpluggable
> + */
> +struct upl_mem {
> +	struct alist region;
> +	bool hotpluggable;
> +};
> +
> +/**
> + * enum upl_usage - Encodes the usage
> + *
> + * Each is a bit number from the usage mask
> + */
> +enum upl_usage {
> +	UPLUS_ACPI_RECLAIM,
> +	UPLUS_ACPI_NVS,
> +	UPLUS_BOOT_CODE,
> +	UPLUS_BOOT_DATA,
> +	UPLUS_RUNTIME_CODE,
> +	UPLUS_RUNTIME_DATA,
> +	UPLUS_COUNT
> +};
> +
> +/**
> + * struct upl_memmap - Information about logical-memory layout
> + *
> + * @name: Node name to use
> + * @region: Memory region list (struct memregion)
> + * @usage: Memory-usage mask (enum upl_usage)
> + */
> +struct upl_memmap {
> +	const char *name;
> +	struct alist region;
> +	uint usage;
> +};
> +
> +/**
> + * struct upl_memres - Reserved memory
> + *
> + * @name: Node name to use
> + * @region: Reserved memory region list (struct memregion)
> + * @no_map: true to indicate that a virtual mapping must not be created
> + */
> +struct upl_memres {
> +	const char *name;
> +	struct alist region;
> +	bool no_map;
> +};
> +
> +enum upl_serial_access_type {
> +	UPLSAT_MMIO,
> +	UPLSAT_IO,
> +};
> +
> +/* serial defaults */
> +enum {
> +	UPLD_REG_IO_SHIFT	=3D 0,
> +	UPLD_REG_OFFSET		=3D 0,
> +	UPLD_REG_IO_WIDTH	=3D 1,
> +};
> +
> +/**
> + * enum upl_access_type - Access types
> + *
> + * @UPLAT_MMIO: Memory-mapped I/O
> + * @UPLAT_IO: Separate I/O
> + */
> +enum upl_access_type {
> +	UPLAT_MMIO,
> +	UPLAT_IO,
> +};
> +
> +/**
> + * struct upl_serial - Serial console
> + *
> + * @compatible: Compatible string (NULL if there is no serial console)
> + * @clock_frequency: Input clock frequency of UART
> + * @current_speed: Current baud rate of UART
> + * @reg: List of base address and size of registers (struct memregion)
> + * @reg_shift_log2: log2 of distance between each register
> + * @reg_offset: Offset of registers from the base address
> + * @reg_width: Register width in bytes
> + * @virtual_reg: Virtual register access (0 for none)
> + * @access_type: Register access type to use
> + */
> +struct upl_serial {
> +	const char *compatible;
> +	uint clock_frequency;
> +	uint current_speed;
> +	struct alist reg;
> +	uint reg_io_shift;
> +	uint reg_offset;
> +	uint reg_io_width;
> +	ulong virtual_reg;
> +	enum upl_serial_access_type access_type;
> +};
> +
> +/**
> + * enum upl_graphics_format - Graphics formats
> + *
> + * @UPLGF_ARGB32: 32bpp format using 0xaarrggbb
> + * @UPLGF_ABGR32: 32bpp format using 0xaabbggrr
> + * @UPLGF_ARGB64: 64bpp format using 0xaaaabbbbggggrrrr
> + */
> +enum upl_graphics_format {
> +	UPLGF_ARGB32,
> +	UPLGF_ABGR32,
> +	UPLGF_ABGR64,
> +};
> +
> +/**
> + * @reg: List of base address and size of registers (struct memregion)
> + * @width: Width of display in pixels
> + * @height: Height of display in pixels
> + * @stride: Number of bytes from one line to the next
> + * @format: Pixel format
> + */
> +struct upl_graphics {
> +	struct alist reg;
> +	uint width;
> +	uint height;
> +	uint stride;
> +	enum upl_graphics_format format;
> +};
> +
> +/*
> + * Information about the UPL state
> + *
> + * @addr_cells: Number of address cells used in the handoff
> + * @size_cells: Number of size cells used in the handoff
> + * @bootmode: Boot-mode mask (enum upl_boot_mode)
> + * @fit: Address of FIT image that was loaded
> + * @conf_offset: Offset in FIT of the configuration that was selected
> + * @addr_width: Adress-bus width of machine, e.g. 46 for 46 bits
> + * @acpi_nvs_size: Size of the ACPI non-volatile-storage area in bytes
> + * @image: Information about each image (struct upl_image)
> + * @mem: Information about physical-memory regions (struct upl_mem)
> + * @nennap: Information about logical-memory regions (struct upl_memmap=
)
> + * @nennap: Information about reserved-memory regions (struct upl_memre=
s)
> + */
> +struct upl {
> +	int addr_cells;
> +	int size_cells;
> +
> +	ulong smbios;
> +	ulong acpi;
> +	uint bootmode;
> +	ulong fit;
> +	uint conf_offset;
> +	uint addr_width;
> +	uint acpi_nvs_size;
> +
> +	struct alist image;
> +	struct alist mem;
> +	struct alist memmap;
> +	struct alist memres;
> +	struct upl_serial serial;
> +	struct upl_graphics graphics;
> +};
> +
> +/**
> + * upl_write_handoff() - Write a Unversal Payload handoff structure
> + *
> + * upl: UPL state to write
> + * @root: root node to write it to
> + * @skip_existing: Avoid recreating any nodes which already exist in th=
e
> + * devicetree. For example, if there is a serial node, just leave it al=
one,
> + * since don't need to create a new one
> + * Return: 0 on success, -ve on error
> + */
> +int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_exi=
sting);
> +
> +/**
> + * upl_create_handoff_tree() - Write a Unversal Payload handoff structu=
re
> + *
> + * upl: UPL state to write
> + * @treep: Returns a new tree containing the handoff
> + * Return: 0 on success, -ve on error
> + */
> +int upl_create_handoff_tree(const struct upl *upl, oftree *treep);
> +
> +/**
> + * upl_read_handoff() - Read a Unversal Payload handoff structure
> + *
> + * upl: UPL state to read into
> + * @tree: Devicetree containing the data to read
> + * Return: 0 on success, -ve on error
> + */
> +int upl_read_handoff(struct upl *upl, oftree tree);
> +
> +#if CONFIG_IS_ENABLED(UPL)
> +
> +/**
> + * upl_set_fit_info() - Set up basic info about the FIT
> + *
> + * @fit: Address of FIT
> + * @conf_offset: Configuration node being used
> + * @entry_addr: Entry address for next phase
> + */
> +void upl_set_fit_info(ulong fit, int conf_offset, ulong entry_addr);
> +
> +/**
> + * upl_set_fit_addr() - Set up the address of the FIT
> + *
> + * @fit: Address of FIT
> + */
> +void upl_set_fit_addr(ulong fit);
> +
> +/**
> + * upl_add_image() - Add a new image to the UPL
> + *
> + * @node: Image node offset in FIT
> + * @load_addr: Address to which images was loaded
> + * @size: Image size in bytes
> + * @desc: Description of image
> + */
> +int upl_add_image(int node, ulong load_addr, ulong size, const char *de=
sc);
> +
> +#else
> +static inline void upl_set_fit_addr(ulong fit) {}
> +static inline void upl_set_fit_info(ulong fit, int conf_offset,
> +				    ulong entry_addr) {}
> +static inline int upl_add_image(int node, ulong load_addr, ulong size,
> +				const char *desc)
> +{
> +	return 0;
> +}
> +#endif /* UPL */
> +
> +/** upl_init() - Set up a UPL struct */
> +void upl_init(struct upl *upl);
> +
> +#endif /* __UPL_WRITE_H */

