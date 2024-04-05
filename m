Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF35CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCC2884DB;
	Fri,  5 Apr 2024 11:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3IRYfnKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B22884DE; Fri,  5 Apr 2024 11:03:02 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E64884D6
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34388753650so883060f8f.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712307780; x=1712912580;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KvLdyck/117IRX4bwLJCT/So7X2UX+XqZruYZgpX08k=;
 b=3IRYfnKpMC7sAWaV6KYhkBxUicpmlFJbtkCp4aRiMg/hWe3V0925Sn3wNDLaLoH6LP
 zHZdkdiWBfvVb8XkUReyzMUp8YfiU1zr/P9lBe717BRiM+tVRfZ7NgMtiuPbcAmpevRP
 AKAObF4qB9sn36pBPCQg2f7mbcBwCyASQ+eYy4YKb+l952mvcjYJuszbkPs37UOJO+Az
 wJ6EriFYIkeqVIarLUYFz2on3EWliMsUbPDmj0GKmddnBOV78qBXjYTvlbly83r8VzA9
 I0In2yD02pCbQsdWp2KZUxx9oquC3zOn6t6E8gXhFGN+O3sW7485icR8KvwwVFPa1iA/
 DHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712307780; x=1712912580;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KvLdyck/117IRX4bwLJCT/So7X2UX+XqZruYZgpX08k=;
 b=XPkQvgy5Dzq9g4luJtXS02T+DuqF5I4XLJ+E6LqtONxv2xpA3pCPoYYFAiMURHviib
 +zUyCirugs2MAiR/WdDAs2Hqz8vLEkN7A404Bj8PAl+l/KB8YyDOqmdqyLzjAfo2m1R7
 27sWgjca4wcn7ye+IVAAuNfnmFdFolnXAy/7W9S86QOYEXLOfJOcvKc53hKPg+8v1IvB
 naBp8i/YBlCFmJfBd2dix38xdItGYjkyw8ZI2DII439Py5CrXBwRAxsRF5YycT/qe/ma
 1EdnTgXQtcjiXmxS2ULJ2aSMsVWJckCB+LGNb5xPy1eZ7dGKff8e9ttJcWF/hNSyXl4G
 ocGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCToAOr12brxeU0GUsWTm9RzCxdeBy88YmysreHsuISwGIE0fBKB/wSr9gFKcSXuS3iy0lmxWnNQRem3p5PK0b2ocBVg==
X-Gm-Message-State: AOJu0YxgYr/dqW/35zg51KwW8uFJLE2ske+Egy1X1GIwjKtRIWQ/JaJ2
 MRtNMA9upTD6qwjTcwAxTgIk72rmJBeQLK7PfGFzxeuRaLrPb5JK+3VG8oicHrLVANA1PDJyGaX
 l
X-Google-Smtp-Source: AGHT+IGsxlFDqulJ8NSRSngYZDZllKkGRhbWhri9P49da37Zk7g/8KYesTVvWsf4+I8+Di+VfgjRLg==
X-Received: by 2002:a05:6000:1864:b0:343:5cac:8d9e with SMTP id
 d4-20020a056000186400b003435cac8d9emr776159wri.33.1712307779703; 
 Fri, 05 Apr 2024 02:02:59 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 m15-20020adffe4f000000b0033ed7181fd1sm1501712wrs.62.2024.04.05.02.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:02:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
In-Reply-To: <20240304140257.f3tguxyg3z47mhbi@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-3-avromanov@salutedevices.com>
 <871q9eytac.fsf@baylibre.com>
 <20240304140257.f3tguxyg3z47mhbi@cab-wsm-0029881.sigma.sbrf.ru>
Date: Fri, 05 Apr 2024 11:02:58 +0200
Message-ID: <87edbkfagt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Alexey,

On lun., mars 04, 2024 at 14:03, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Hello Mattijs,
>
> On Thu, Feb 15, 2024 at 10:24:11AM +0100, Mattijs Korpershoek wrote:
>> On jeu., f'evr. 01, 2024 at 12:20, Alexey Romanov <avromanov@salutedevices.com> wrote:
>> 
>> > An example of how we use fastboot oeam board subcommand
>> > for Sean Anderson.
>> >
>> > 1 - OEM_BOARD_WRITE_BOOTLOADER_CMD:
>> >
>> > We use it for custom Amlogic bootloader + tpl
>> > flashing protocol.
>> >
>> > 2 - OEM_BOARD_ERASE_CMD:
>> >
>> > Custom logic for erasing the env-emulated partition,
>> > which isn't in the mtd markup map.
>> >
>> > Example of the script which completely flashes the device:
>> >
>> >   $ fastboot erase bootloader
>> >   $ fastboot stage u-boot.bin
>> >   $ fastboot oem board:write_bootloader
>> >   $ fastboot reboot-bootloader
>> >   $ fastboot oem board:erase_env
>> >   $ fastboot erase misc
>> >   $ fastboot erase super
>> >   $ fastboot flash super rootfs
>> >   $ fastboot reboot
>> >
>> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> > ---
>> >  board/amlogic/ad401/fastboot.c | 222 +++++++++++++++++++++++++++++++++
>> >  1 file changed, 222 insertions(+)
>> >  create mode 100644 board/amlogic/ad401/fastboot.c
>> >
>> > diff --git a/board/amlogic/ad401/fastboot.c b/board/amlogic/ad401/fastboot.c
>> > new file mode 100644
>> > index 0000000000..01da8efa5b
>> > --- /dev/null
>> > +++ b/board/amlogic/ad401/fastboot.c
>> > @@ -0,0 +1,222 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * (C) Copyright 2023 SaluteDevices, Inc.
>> > + */
>> > +
>> > +#include <common.h>
>> > +#include <env.h>
>> > +#include <fastboot.h>
>> > +#include <nand.h>
>> > +#include <asm/arch/nand.h>
>> > +#include <jffs2/load_kernel.h>
>> > +#include <linux/sizes.h>
>> > +#include <linux/types.h>
>> > +#include <linux/mtd/mtd.h>
>> > +
>> > +enum {
>> > +	OEM_BOARD_ERASE_CMD,
>> > +	OEM_BOARD_WRITE_BOOTLOADER_CMD,
>> > +};
>> > +
>> > +struct defenv {
>> > +	char *name;
>> > +	char value[256];
>> > +};
>> > +
>> > +static void save_defenv(struct defenv *e, size_t cnt)
>> > +{
>> > +	int i;
>> > +
>> > +	for (i = 0; i < cnt; i++) {
>> > +		const char *env_val = env_get(e[i].name);
>> > +
>> > +		if (env_val)
>> > +			strlcpy(e[i].value, env_val, sizeof(e[i].value));
>> > +		else
>> > +			e[i].value[0] = '\0';
>> > +	}
>> > +}
>> > +
>> > +static void set_defenv(struct defenv *e, size_t cnt)
>> > +{
>> > +	int i;
>> > +
>> > +	for (i = 0; i < cnt; i++)
>> > +		env_set(e[i].name, e[i].value);
>> > +}
>> > +
>> > +static int fastboot_erase_env(void)
>> > +{
>> > +	char *const defenv_names[] = { "lock", "mtdparts", "mtdids" };
>> > +	struct defenv env[ARRAY_SIZE(defenv_names)];
>> > +	int err, i;
>> > +
>> > +	for (i = 0; i < ARRAY_SIZE(env); i++)
>> > +		env[i].name = defenv_names[i];
>> > +
>> > +	printf("ENV is being erased...\n");
>> > +
>> > +	/*
>> > +	 * Reset environment to the default, excluding 'lock' variable,
>> > +	 * because it reflects the fastboot's state after execution of
>> > +	 * 'flashing unlock' command, hence it must survive the env-erasing.
>> > +	 * Otherwise, further erase commands will fail on check_lock().
>> > +	 *
>> > +	 * Also, we have to save 'mtdparts' and 'mtdids' variables
>> > +	 * because they are necessary to obtain partition map.
>> > +	 */
>> > +
>> > +	save_defenv(env, ARRAY_SIZE(env));
>> > +	env_set_default(NULL, 0);
>> > +	set_defenv(env, ARRAY_SIZE(env));
>> > +
>> > +	err = env_save();
>> > +	if (err) {
>> > +		pr_err("Can't overwrite ENV-partition\n");
>> > +		return err;
>> > +	}
>> 
>> Hmm so the fastboot locked state is saved in the U-Boot environment.
>> There is probably a good reason for this (no secure storage for
>> example). But this does not feel board specific.
>> 
>> Wouldn't it be better if we could just run "fastboot erase bootenv" and
>> that the generic fastboot code does the right thing?
>
> Are you proposing to modify the code of fastboot in such a way
> that if user send 'erase bootenv' string, then we call generic
> function to cleanup environment, instead of try to search (and erase)
> in partition schema 'bootenv' partition?

I would have liked to have a generic "erase bootenv" command yes, but
your solution seems fine so no need to do something different.

Thank you for your patience with this !

>
>> (which is env default, and ignoring some magic/specific variables)
>> 
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int fastboot_nand_write_tpl(struct mtd_info *mtd, void *buffer,
>> > +				   u32 offset, size_t size, int flags)
>> > +{
>> > +	int boot_cpy_num = meson_bootloader_copy_num(BOOT_TPL);
>> > +	u64 size_per_copy = meson_bootloader_copy_size(mtd, BOOT_TPL);
>> > +	int i;
>> > +
>> > +	for (i = 0; i < boot_cpy_num; i++) {
>> > +		size_t retlen, len = size;
>> > +		int ret;
>> > +
>> > +		ret = nand_write_skip_bad(mtd, offset + (i * size_per_copy),
>> > +					  &len, &retlen, offset + size_per_copy,
>> > +					  buffer, flags);
>> > +		if (ret)
>> > +			return ret;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int fastboot_nand_write_bl2(struct mtd_info *mtd, void *buffer,
>> > +				   u32 offset, size_t size, int flags)
>> > +{
>> > +	int boot_cpy_num = meson_bootloader_copy_num(BOOT_BL2);
>> > +	u64 size_per_copy = meson_bootloader_copy_size(mtd, BOOT_BL2);
>> > +	int i;
>> > +
>> > +	for (i = 0; i < boot_cpy_num; i++) {
>> > +		int ret;
>> > +
>> > +		ret = meson_bootloader_write_bl2(mtd, buffer,
>> > +						 offset + (i * size_per_copy),
>> > +					         size, flags);
>> > +		if (ret)
>> > +			return ret;
>> > +	}
>> > +
>> > +	return meson_bootloader_write_info_pages();
>> > +}
>> > +
>> > +static int fastboot_nand_write_bootloader(void *buffer, u32 size)
>> > +{
>> > +	struct part_info *part;
>> > +	struct mtd_info *mtd = NULL;
>> > +	struct mtd_device *dev;
>> > +	u8 pnum;
>> > +	int ret;
>> > +
>> > +	if (size < BL2_SIZE)
>> > +		return 0;
>> > +
>> > +	if (!buffer)
>> > +		return -EINVAL;
>> > +
>> > +	ret = mtdparts_init();
>> > +	if (ret) {
>> > +		pr_err("Cannot initialize MTD partitions\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret = find_dev_and_part("bootloader", &dev, &pnum, &part);
>> > +	if (ret) {
>> > +		pr_err("cannot find 'bootloader' partition\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	mtd = get_nand_dev_by_index(dev->id->num);
>> > +	if (!mtd)
>> > +		return -EINVAL;
>> > +
>> > +	ret = fastboot_nand_write_bl2(mtd, buffer, part->offset,
>> > +				      BL2_SIZE, WITH_WR_VERIFY);
>> > +	if (ret) {
>> > +		pr_err("fastboot: failed to write BL2\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret = find_dev_and_part("tpl", &dev, &pnum, &part);
>> > +	if (ret) {
>> > +		pr_err("cannot find 'bootloader' partition\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	mtd = get_nand_dev_by_index(dev->id->num);
>> > +	if (!mtd)
>> > +		return -EINVAL;
>> > +
>> > +	ret = fastboot_nand_write_tpl(mtd, buffer + BL2_SIZE, part->offset,
>> > +				      size - BL2_SIZE, WITH_WR_VERIFY);
>> > +	if (ret) {
>> > +		pr_err("fastboot: failed to write TPL\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +int get_oem_board_command(const char *cmd)
>> > +{
>> > +	const char *oem_commands[] = {
>> > +		[OEM_BOARD_ERASE_CMD] = "erase_env",
>> > +		[OEM_BOARD_WRITE_BOOTLOADER_CMD] = "write_bootloader",
>> > +	};
>> > +	int i;
>> > +
>> > +	for (i = 0; i < ARRAY_SIZE(oem_commands); i++)
>> > +		if (!strcmp(cmd, oem_commands[i]))
>> > +			return i;
>> > +
>> > +	return -EINVAL;
>> > +}
>> > +
>> > +void fastboot_oem_board(const char *cmd_parameter, void *data, u32 size,
>> > +			char *response)
>> > +{
>> > +	char buf[128] = { 0 };
>> > +	int ret, cmd;
>> > +
>> > +	cmd = get_oem_board_command(cmd_parameter);
>> > +
>> > +	switch (cmd) {
>> > +		case OEM_BOARD_ERASE_CMD:
>> > +			ret = fastboot_erase_env();
>> > +			break;
>> > +		case OEM_BOARD_WRITE_BOOTLOADER_CMD:
>> > +			ret = fastboot_nand_write_bootloader(data, size);
>> > +			break;
>> > +		default:
>> > +			snprintf(buf, sizeof(buf),
>> > +				 "Command 'oem board %s' not supported",
>> > +				 cmd_parameter);
>> > +			fastboot_fail(buf, response);
>> > +			return;
>> > +	}
>> > +
>> > +	if (ret < 0)
>> > +		fastboot_fail("Failed to erase env partition", response);
>> > +	else
>> > +		fastboot_okay(NULL, response);
>> > +}
>> > -- 
>> > 2.30.1
>
> -- 
> Thank you,
> Alexey
