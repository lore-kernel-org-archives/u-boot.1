Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B4EC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 09:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149F187CC1;
	Thu, 15 Feb 2024 10:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hnokteno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895E087D98; Thu, 15 Feb 2024 10:24:20 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6BF87CC1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 10:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41223e0777dso1163445e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707989053; x=1708593853;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=090QBtPxCADu0Wos+dXcEvjvL0pKTovaqSaSiHA24yo=;
 b=hnoktenojAxucQYC9bIyjNf8Xpa+EpFJ/RfYW7UauweYkkyO4hQn+ohBvAhCr4ljCV
 yaesiNHAKuocmhlx53nqnS7bgGt8JuxsHzabKHJMVO8dmKQtoIvi535Tr3NmJkbQCIAe
 S8Br7JhLazAwLAjufYHQ0ppRRPFUP5+do0/++RijumYbNVu01SDXkT7e4Em3LMyIrsRt
 h+pIIj+D3i1SXwuF0HAI+g4Bx1yHLNY07fud/l896Gs5dOIrm1KJIOxy5PbIjG1Sr/9I
 mY7y2BarqdqMZdwyLBawKjy1plVOgCyr9gCnPI3VexQld+8aEKPVTysyf3XvjxdeB34H
 Jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707989053; x=1708593853;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=090QBtPxCADu0Wos+dXcEvjvL0pKTovaqSaSiHA24yo=;
 b=F+69Z6EeFylO9z65QWrRw5BC1m1jQA4wBXwznLid8ezNYT91KmQVbI572Ba6AGhwOr
 XQD+gfjAjU9WYyWdRQLMgUu3WcYcjARbYeWtwECGdq+GYPSYBTJfFS9yYSgSNrpKZtpx
 xwfddaYICQMm8uFdQcYUcfmsoSmz1KcB/2XgGRRqqMv/khYI+a6TOufuUZm+Tzj31m9h
 p9wXb2ezjdzWMPhIJ9sexPMxKELgEyS9menSIqtT6yOIxr7gZLLhNypinEyrmzr49VOg
 8KgWzqhpYFfOp9TWkOZYrdUiRaStZDX52yWmZVpC5j4uG8EFXO23suzuHCBUwLUdn5Pc
 qrzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgUNQSfC0zfdTgNtbxXq3nN5GxKaiFZXjouQgV3HDNCPa5TQdgPpX6q7U93JLEKGVHX2grV6pjwSkdS7CoSkKr9U7u3g==
X-Gm-Message-State: AOJu0YwoDCXJhm3kwVdJHbEWwcAsqMXINuJVebN2FflHsMlfdr3JX+sb
 rNI+n1GzkqD0T8+ts51uoydz5VTiMuxeYK0+zsPzYtrgi9YTZzVxlUJ6HRdh3Zw=
X-Google-Smtp-Source: AGHT+IEOa6Y3XxXyVuXXIoxf9Fe37T5DtExB4zYeMdsAlH5NQVhoavUd54ImBspfyEgBws7P+eEY4Q==
X-Received: by 2002:a5d:5348:0:b0:33b:74a3:dcfb with SMTP id
 t8-20020a5d5348000000b0033b74a3dcfbmr812556wrv.1.1707989052827; 
 Thu, 15 Feb 2024 01:24:12 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 g10-20020adff40a000000b0033b4dae972asm1163649wro.37.2024.02.15.01.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:24:12 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, sean.anderson@seco.com, dimorinny@google.com,
 patrick.delaunay@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: Re: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
In-Reply-To: <20240201092027.6258-3-avromanov@salutedevices.com>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-3-avromanov@salutedevices.com>
Date: Thu, 15 Feb 2024 10:24:11 +0100
Message-ID: <871q9eytac.fsf@baylibre.com>
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

On jeu., f=C3=A9vr. 01, 2024 at 12:20, Alexey Romanov <avromanov@salutedevi=
ces.com> wrote:

> An example of how we use fastboot oeam board subcommand
> for Sean Anderson.
>
> 1 - OEM_BOARD_WRITE_BOOTLOADER_CMD:
>
> We use it for custom Amlogic bootloader + tpl
> flashing protocol.
>
> 2 - OEM_BOARD_ERASE_CMD:
>
> Custom logic for erasing the env-emulated partition,
> which isn't in the mtd markup map.
>
> Example of the script which completely flashes the device:
>
>   $ fastboot erase bootloader
>   $ fastboot stage u-boot.bin
>   $ fastboot oem board:write_bootloader
>   $ fastboot reboot-bootloader
>   $ fastboot oem board:erase_env
>   $ fastboot erase misc
>   $ fastboot erase super
>   $ fastboot flash super rootfs
>   $ fastboot reboot
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  board/amlogic/ad401/fastboot.c | 222 +++++++++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)
>  create mode 100644 board/amlogic/ad401/fastboot.c
>
> diff --git a/board/amlogic/ad401/fastboot.c b/board/amlogic/ad401/fastboo=
t.c
> new file mode 100644
> index 0000000000..01da8efa5b
> --- /dev/null
> +++ b/board/amlogic/ad401/fastboot.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2023 SaluteDevices, Inc.
> + */
> +
> +#include <common.h>
> +#include <env.h>
> +#include <fastboot.h>
> +#include <nand.h>
> +#include <asm/arch/nand.h>
> +#include <jffs2/load_kernel.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +#include <linux/mtd/mtd.h>
> +
> +enum {
> +	OEM_BOARD_ERASE_CMD,
> +	OEM_BOARD_WRITE_BOOTLOADER_CMD,
> +};
> +
> +struct defenv {
> +	char *name;
> +	char value[256];
> +};
> +
> +static void save_defenv(struct defenv *e, size_t cnt)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < cnt; i++) {
> +		const char *env_val =3D env_get(e[i].name);
> +
> +		if (env_val)
> +			strlcpy(e[i].value, env_val, sizeof(e[i].value));
> +		else
> +			e[i].value[0] =3D '\0';
> +	}
> +}
> +
> +static void set_defenv(struct defenv *e, size_t cnt)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < cnt; i++)
> +		env_set(e[i].name, e[i].value);
> +}
> +
> +static int fastboot_erase_env(void)
> +{
> +	char *const defenv_names[] =3D { "lock", "mtdparts", "mtdids" };
> +	struct defenv env[ARRAY_SIZE(defenv_names)];
> +	int err, i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(env); i++)
> +		env[i].name =3D defenv_names[i];
> +
> +	printf("ENV is being erased...\n");
> +
> +	/*
> +	 * Reset environment to the default, excluding 'lock' variable,
> +	 * because it reflects the fastboot's state after execution of
> +	 * 'flashing unlock' command, hence it must survive the env-erasing.
> +	 * Otherwise, further erase commands will fail on check_lock().
> +	 *
> +	 * Also, we have to save 'mtdparts' and 'mtdids' variables
> +	 * because they are necessary to obtain partition map.
> +	 */
> +
> +	save_defenv(env, ARRAY_SIZE(env));
> +	env_set_default(NULL, 0);
> +	set_defenv(env, ARRAY_SIZE(env));
> +
> +	err =3D env_save();
> +	if (err) {
> +		pr_err("Can't overwrite ENV-partition\n");
> +		return err;
> +	}

Hmm so the fastboot locked state is saved in the U-Boot environment.
There is probably a good reason for this (no secure storage for
example). But this does not feel board specific.

Wouldn't it be better if we could just run "fastboot erase bootenv" and
that the generic fastboot code does the right thing?
(which is env default, and ignoring some magic/specific variables)

> +
> +	return 0;
> +}
> +
> +static int fastboot_nand_write_tpl(struct mtd_info *mtd, void *buffer,
> +				   u32 offset, size_t size, int flags)
> +{
> +	int boot_cpy_num =3D meson_bootloader_copy_num(BOOT_TPL);
> +	u64 size_per_copy =3D meson_bootloader_copy_size(mtd, BOOT_TPL);
> +	int i;
> +
> +	for (i =3D 0; i < boot_cpy_num; i++) {
> +		size_t retlen, len =3D size;
> +		int ret;
> +
> +		ret =3D nand_write_skip_bad(mtd, offset + (i * size_per_copy),
> +					  &len, &retlen, offset + size_per_copy,
> +					  buffer, flags);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fastboot_nand_write_bl2(struct mtd_info *mtd, void *buffer,
> +				   u32 offset, size_t size, int flags)
> +{
> +	int boot_cpy_num =3D meson_bootloader_copy_num(BOOT_BL2);
> +	u64 size_per_copy =3D meson_bootloader_copy_size(mtd, BOOT_BL2);
> +	int i;
> +
> +	for (i =3D 0; i < boot_cpy_num; i++) {
> +		int ret;
> +
> +		ret =3D meson_bootloader_write_bl2(mtd, buffer,
> +						 offset + (i * size_per_copy),
> +					         size, flags);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return meson_bootloader_write_info_pages();
> +}
> +
> +static int fastboot_nand_write_bootloader(void *buffer, u32 size)
> +{
> +	struct part_info *part;
> +	struct mtd_info *mtd =3D NULL;
> +	struct mtd_device *dev;
> +	u8 pnum;
> +	int ret;
> +
> +	if (size < BL2_SIZE)
> +		return 0;
> +
> +	if (!buffer)
> +		return -EINVAL;
> +
> +	ret =3D mtdparts_init();
> +	if (ret) {
> +		pr_err("Cannot initialize MTD partitions\n");
> +		return ret;
> +	}
> +
> +	ret =3D find_dev_and_part("bootloader", &dev, &pnum, &part);
> +	if (ret) {
> +		pr_err("cannot find 'bootloader' partition\n");
> +		return ret;
> +	}
> +
> +	mtd =3D get_nand_dev_by_index(dev->id->num);
> +	if (!mtd)
> +		return -EINVAL;
> +
> +	ret =3D fastboot_nand_write_bl2(mtd, buffer, part->offset,
> +				      BL2_SIZE, WITH_WR_VERIFY);
> +	if (ret) {
> +		pr_err("fastboot: failed to write BL2\n");
> +		return ret;
> +	}
> +
> +	ret =3D find_dev_and_part("tpl", &dev, &pnum, &part);
> +	if (ret) {
> +		pr_err("cannot find 'bootloader' partition\n");
> +		return ret;
> +	}
> +
> +	mtd =3D get_nand_dev_by_index(dev->id->num);
> +	if (!mtd)
> +		return -EINVAL;
> +
> +	ret =3D fastboot_nand_write_tpl(mtd, buffer + BL2_SIZE, part->offset,
> +				      size - BL2_SIZE, WITH_WR_VERIFY);
> +	if (ret) {
> +		pr_err("fastboot: failed to write TPL\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int get_oem_board_command(const char *cmd)
> +{
> +	const char *oem_commands[] =3D {
> +		[OEM_BOARD_ERASE_CMD] =3D "erase_env",
> +		[OEM_BOARD_WRITE_BOOTLOADER_CMD] =3D "write_bootloader",
> +	};
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(oem_commands); i++)
> +		if (!strcmp(cmd, oem_commands[i]))
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +void fastboot_oem_board(const char *cmd_parameter, void *data, u32 size,
> +			char *response)
> +{
> +	char buf[128] =3D { 0 };
> +	int ret, cmd;
> +
> +	cmd =3D get_oem_board_command(cmd_parameter);
> +
> +	switch (cmd) {
> +		case OEM_BOARD_ERASE_CMD:
> +			ret =3D fastboot_erase_env();
> +			break;
> +		case OEM_BOARD_WRITE_BOOTLOADER_CMD:
> +			ret =3D fastboot_nand_write_bootloader(data, size);
> +			break;
> +		default:
> +			snprintf(buf, sizeof(buf),
> +				 "Command 'oem board %s' not supported",
> +				 cmd_parameter);
> +			fastboot_fail(buf, response);
> +			return;
> +	}
> +
> +	if (ret < 0)
> +		fastboot_fail("Failed to erase env partition", response);
> +	else
> +		fastboot_okay(NULL, response);
> +}
> --=20
> 2.30.1
