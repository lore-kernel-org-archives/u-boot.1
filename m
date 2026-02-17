Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689ABE909AE
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 14:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97AE83AC5;
	Tue, 17 Feb 2026 15:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hV2sua74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D00C783B99; Tue, 17 Feb 2026 15:54:47 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2532883981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8959dd02f04so1916286d6.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771340084; x=1771944884; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yfq3ozvii3Z3TlvwidhKUq2s0RefQaNwkCypxb/e5PY=;
 b=hV2sua74aR+Xvd7srwP8o82rkkuVTkvT0oVMj2FXJjYZBcyfacLnyqCPTVBejdu4GX
 g2+LkQkkVHGu82VDfi41OGm2RjXq7vByE7Hsq+ffmbnrDf3xCiUtMY+07KD7psBjTBZA
 R02iBdwSFSPxYSkpu+5vfbwQuO02AjK68NvnAs1T3y+/3wI4U3v+ytQdofgy6aqz/eM5
 +cZJLR0wMup4cpaZd/AEfHMJkjLVR0HIlI+gnYRRO9+5MtSKGjrfhrHEf+WKtnp5XfBz
 /rR2z1reY+BdSFs3s5f6miEMKkw8C6v9Kxo7XqcSfwIzA8dcTzS7BZe6o31lKaqdxamN
 GmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340084; x=1771944884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yfq3ozvii3Z3TlvwidhKUq2s0RefQaNwkCypxb/e5PY=;
 b=aVtEfNN9sv1w8cqa7tV1QD+gOd1+sbkz4qhBfprLTo2KSWB1nGnpOggb+HVnyS2Z1Q
 7OmMEQJwvxXZTaTM6ZHuqeoLswumUgtFURN88TTiiFniD2rOzWU9nBKsOTe0XSbwHKU0
 xD2cpwTTffS4ULb4Tk1d7dWsBpIAFvfZOPBnTPXvIVtGlu8ejMp905cEEmngbhO9Md/r
 MEPXS7q5L1tF4XkADbHEstZ3Pq/qnM7E7/spv8oZN2BnmGhzcWQsJfgOE8r9V5MrzogZ
 F5Qa6caimodQKS9LX7m40cBmeG2WMcZiwpHWB3iaFGMffShr6x5E9zP8gXCem3vgaFZ/
 Lq0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL0VtYtYQXZ50pGksg5EP9mzse2aMK+66irWE4KkrM8rtpRjPeid2RqMmh+e9JxK6+UWflz/k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz4Qm5fL/Jf8PgakkFVLkjZaC1GSK/XtbhBEQW4KWzWnGlH/2Q
 Wd0nKU6e9tTa+NHxFYT0mmCanZz5qUxQxm3MACduA8EYOxg24JoFvxJE
X-Gm-Gg: AZuq6aJDJFj7Vxdq5QNRTSbKTA5+6Hfe0UJVhdyqrIdvuXcOSRklxry7tXUKwHetbT1
 iT52swuLtLO77yl1SHEYT0SIvWIipz5cVHFDWN+zgmcSab6Hee0kJsVmMaEVDwHKp1Yj6PcbrtI
 Flgx8ZN+JNLk3HwmvYl8tL+VyB4G7j2mNenxoyKry7w3B2j53d/MpP80ebaWdfNoiQOUwZA/Jk2
 weD4dC0QVvuaZ8YCcf+BBMxZHjpf8Wa/V1Hh96FgwygzuJt6u79fxbD3jm0/CvT0A1TJSK/yMBh
 Swg4IuxllsIS5tnb/X/vAmDGHtp1cJ502fX9MZUg12VzCgltX5eyE6HylS6KO9dZYOaWa8GLV7a
 7IKfWtz4EhcWlk9xFkeFhLXJQTZbqE1gkTooqacNeTzj9Zbw8ygD8fSeqO98tdyusyjAIim+VIn
 zYs6q1sThU+fz69+2wSX28s4+iP7ZKdW34GfdxbM4i1kSmNyUNCuyO9mZ59PU1dbDE0Bc=
X-Received: by 2002:a05:6214:4f05:b0:897:1d50:2336 with SMTP id
 6a1803df08f44-897347ccd64mr156268956d6.6.1771340083856; 
 Tue, 17 Feb 2026 06:54:43 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cddc526sm164752366d6.53.2026.02.17.06.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 06:54:43 -0800 (PST)
Message-ID: <19023fd3-ca7d-ad84-5c65-837676b034ed@gmail.com>
Date: Tue, 17 Feb 2026 09:54:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] common: spl: mtd: Add support for loading images from
 MTD
Content-Language: en-US
To: Anurag Dutta <a-dutta@ti.com>, jagan@amarulasolutions.com,
 trini@konsulko.com
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 boon.khai.ng@altera.com, s-k6@ti.com, gehariprasath@ti.com, vigneshr@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260217112156.272154-1-a-dutta@ti.com>
 <20260217112156.272154-2-a-dutta@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260217112156.272154-2-a-dutta@ti.com>
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

On 2/17/26 06:21, Anurag Dutta wrote:
> From: Apurva Nandan <a-nandan@ti.com>
> 
> Introduce support for using MTD subsystem for loading images from
> memory flashes. This will provide the support of using mtd functions
> which are abstracted over the type of flash being used, to load the
> boot images from the flash.
> 
> Currently, add support for only SPI NAND flashes. This can be extended
> to all other flash types, when required.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>   common/spl/spl_mtd.c      | 90 +++++++++++++++++++++++++++++++++++++++
>   common/spl/spl_mtd_nand.c | 31 ++++++++++++++
>   include/spl.h             | 18 ++++++++
>   3 files changed, 139 insertions(+)
>   create mode 100644 common/spl/spl_mtd.c
>   create mode 100644 common/spl/spl_mtd_nand.c
> 
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> new file mode 100644
> index 00000000000..341e1a73392
> --- /dev/null
> +++ b/common/spl/spl_mtd.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * FIT image loader functions using MTD read
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com/
> + *	Apurva Nandan <a-nandan@ti.com>
> + */
> +#include <config.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/io.h>
> +#include <mtd.h>
> +
> +uint32_t __weak spl_mtd_get_uboot_offs(void)
> +{
> +	return CONFIG_SYS_MTD_U_BOOT_OFFS;
> +}
> +
> +static ulong spl_mtd_fit_read(struct spl_load_info *load, ulong offs,
> +			      ulong size, void *dst)
> +{
> +	struct mtd_info *mtd = load->priv;
> +	int err;
> +	size_t ret_len;
> +
> +	err = mtd_read(mtd, offs, size, &ret_len, dst);
> +	if (!err)
> +		return ret_len;
> +
> +	return 0;
> +}
> +
> +struct mtd_info *spl_prepare_mtd(uint boot_device)
> +{
> +	struct mtd_info *mtd = NULL;
> +
> +	mtd_probe_devices();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_SPINAND:
> +		mtd = get_mtd_device_nm("spi-nand0");
> +		break;
> +	default:
> +		puts(PHASE_PROMPT "Unsupported MTD Boot Device!\n");
> +		break;
> +	}
> +
> +	return mtd;
> +}
> +
> +int spl_mtd_load(struct spl_image_info *spl_image,
> +		 struct mtd_info *mtd, struct spl_boot_device *bootdev)
> +{
> +	int err;
> +	struct legacy_img_hdr *header;
> +	__maybe_unused struct spl_load_info load;
> +	size_t ret_len;
> +
> +	header = spl_get_load_buffer(0, sizeof(*header));
> +
> +	err = mtd_read(mtd, spl_mtd_get_uboot_offs(), sizeof(*header),
> +		       &ret_len, (void *)header);
> +	if (err)
> +		return err;
> +
> +	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
> +	    image_get_magic(header) == FDT_MAGIC) {
> +		debug("Found FIT\n");
> +		load.priv = mtd;
> +		load.bl_len = 1;
> +		load.read = spl_mtd_fit_read;
> +		return spl_load_simple_fit(spl_image, &load,
> +					   spl_mtd_get_uboot_offs(), header);
> +	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
> +		load.priv = mtd;
> +		load.bl_len = 1;
> +		load.read = spl_mtd_fit_read;
> +		return spl_load_imx_container(spl_image, &load,
> +					      spl_mtd_get_uboot_offs());
> +	} else {
> +		err = spl_parse_image_header(spl_image, bootdev, header);
> +		if (err)
> +			return err;
> +		return mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
> +				&ret_len, (void *)(ulong)spl_image->load_addr);
> +	}
>

Please use spl_load instead of hard-coding the image types. Thanks.

--Sean

> +	return -EINVAL;
> +}
> diff --git a/common/spl/spl_mtd_nand.c b/common/spl/spl_mtd_nand.c
> new file mode 100644
> index 00000000000..9bc6ff86ee8
> --- /dev/null
> +++ b/common/spl/spl_mtd_nand.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * FIT image loader using MTD read
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com/
> + *	Anurag Dutta <a-dutta@ti.com>
> + */
> +#include <config.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <asm/io.h>
> +#include <mtd.h>
> +
> +static int spl_mtd_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	struct mtd_info *mtd;
> +	int ret;
> +
> +	mtd = spl_prepare_mtd(BOOT_DEVICE_SPINAND);
> +	if (IS_ERR_OR_NULL(mtd)) {
> +		printf("MTD device %s not found, ret %ld\n", "spi-nand",
> +		       PTR_ERR(mtd));
> +		return -EINVAL;
> +	}
> +
> +	return spl_mtd_load(spl_image, mtd, bootdev);
> +}
> +
> +SPL_LOAD_IMAGE_METHOD("SPINAND", 0, BOOT_DEVICE_SPINAND, spl_mtd_load_image);
> diff --git a/include/spl.h b/include/spl.h
> index 06dc28362d3..c4442be4fdb 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -1219,4 +1219,22 @@ int spl_reloc_prepare(struct spl_image_info *image, ulong *addrp);
>    */
>   int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t func);
>   
> +/* SPL MTD functions */
> +/**
> + * spl_prepare_mtd() - Prepares the mtd for the corresponidng boot device
> + *
> + * @boot_device: A number indicating the BOOT_DEVICE type
> + */
> +struct mtd_info *spl_prepare_mtd(uint boot_device);
> +
> +/**
> + * spl_mtd_load() - FIT Image loader
> + *
> + * @spl_image: SPL image to jump to
> + * @mtd: MTD device descriptor with geometry, flags, and read/write/erase function pointers
> + * @bootdev: boot device used by SPL
> + */
> +int spl_mtd_load(struct spl_image_info *spl_image, struct mtd_info *mtd,
> +		 struct spl_boot_device *bootdev);
> +
>   #endif

