Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24000E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BFAD871D2;
	Mon,  2 Oct 2023 20:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HAAJsmaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871E4869C8; Mon,  2 Oct 2023 20:57:05 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61305871B3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59f57ad6126so1267507b3.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273022; x=1696877822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1KfdDVOfo9NPRGhbY51uatrPdH/SiJUmZQynEkhvta0=;
 b=HAAJsmaG0UDmhigArDKNtNrFMg3W+FOVTZ7yQ+IZe+WlbHlDmcQ1qmxbmbSKz4SGwr
 OCk3ZNmhSivqGxFFFwjX9JFE5OdSUSkHYOZTM25xcJzCdcSvZnbpSGKEtwONy9rlIQrU
 jvhT5J8K0MxTZ17tTs23gUMy//3Yxr6D3QZ7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273022; x=1696877822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KfdDVOfo9NPRGhbY51uatrPdH/SiJUmZQynEkhvta0=;
 b=l2tBhy1IPHCadgIWtPDIdDUrK61C1x7rvhry6jnn2pjWN30/S/k582Cx/bouhowYch
 PnJetdhh1FVcDu4MwuKMk+aHYP5SGZtXI/RZuDOD3jFWDMwa/K5tb8b0zAjpha2nQtfZ
 LcYHkzpVVp7l0y3p2GNxU86aA7CCdEe58fAPJ5XrnygnPs1ADYtHf85Kp9VzaTveEWSE
 4/fa68gUFpceoni8fKSsv53KQrNdEV3Dx4T4/LUp1MRcMrUeymssMg9P+GG559QESKHa
 9K/rvslsM6njtqo1nyI4y23U2deWVdl3vuKn1d4gR6HX1MWKqNKPg4WcxZ0z4hDhYNAj
 ul5Q==
X-Gm-Message-State: AOJu0Ywz94DlyroTHaqj1ExZDH7qZ9X2+RKR1ZbX7kF/VmrYfDFVvWbj
 fqc5UyB4AElJrFNIS+Ozzo8weUmpOJybrM9GAhzxRQ==
X-Google-Smtp-Source: AGHT+IHu/AryqOEdKVrYbFM9ydNHfln+cpBk91nkjOF0Yha5o1AEmp6z1atIYYw6SpchIcv7vXJhw9eQxHWDL7YRcEU=
X-Received: by 2002:a0d:dd45:0:b0:59b:5456:a9bb with SMTP id
 g66-20020a0ddd45000000b0059b5456a9bbmr12047271ywe.42.1696273021801; Mon, 02
 Oct 2023 11:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-3-detlev.casanova@collabora.com>
In-Reply-To: <20231002152142.76516-3-detlev.casanova@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:28 -0600
Message-ID: <CAPnjgZ1s3OP6cq94qLF3mzkK6YwrjEFc91LOiUQWadj0NBZSqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cmd: Add a sysinfo command
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2 Oct 2023 at 09:21, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The command is able to show different information for the running
> system:
> * Model name
> * Board ID
> * Revision
>
> This command can be used by boot shell scripts to select configurations
> depending on the specific running system.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  cmd/Kconfig   |   6 +++
>  cmd/Makefile  |   1 +
>  cmd/sysinfo.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 cmd/sysinfo.c

Reviewed-by: Simon Glass <sjg@chromium.org>

Would prefer more help text in the Kconfig as this is pretty vague


>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 43ca10f69cc..67d019aa795 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -218,6 +218,12 @@ config CMD_SBI
>         help
>           Display information about the SBI implementation.
>
> +config CMD_SYSINFO
> +       bool "sysinfo"
> +       depends on SYSINFO
> +       help
> +         Display information about the system.
> +
>  endmenu
>
>  menu "Boot commands"
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 9bebf321c39..972f3a4720e 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -167,6 +167,7 @@ obj-$(CONFIG_CMD_SPI) += spi.o
>  obj-$(CONFIG_CMD_STRINGS) += strings.o
>  obj-$(CONFIG_CMD_SMC) += smccc.o
>  obj-$(CONFIG_CMD_SYSBOOT) += sysboot.o
> +obj-$(CONFIG_CMD_SYSINFO) += sysinfo.o
>  obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) += stackprot_test.o
>  obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
>  obj-$(CONFIG_CMD_TERMINAL) += terminal.o
> diff --git a/cmd/sysinfo.c b/cmd/sysinfo.c
> new file mode 100644
> index 00000000000..46369ff9ac7
> --- /dev/null
> +++ b/cmd/sysinfo.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023
> + * Detlev Casanova <detlev.casanova@collabora.com>
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <sysinfo.h>
> +#include <exports.h>
> +
> +static int get_sysinfo(struct udevice **devp)
> +{
> +       int ret = sysinfo_get(devp);
> +
> +       if (ret) {
> +               printf("Cannot get sysinfo: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = sysinfo_detect(*devp);
> +       if (ret) {
> +               printf("Cannot detect sysinfo: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int do_sysinfo_model(struct cmd_tbl *cmdtp, int flag, int argc,
> +                           char *const argv[])
> +{
> +       struct udevice *dev;
> +       char model[64];
> +       int ret = get_sysinfo(&dev);
> +
> +       if (ret)
> +               return CMD_RET_FAILURE;
> +
> +       ret = sysinfo_get_str(dev,
> +                             SYSINFO_ID_BOARD_MODEL,
> +                             sizeof(model),
> +                             model);
> +       if (ret) {
> +               printf("Cannot get sysinfo str: %d\n", ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (argc == 2)
> +               ret = env_set(argv[1], model);
> +       else
> +               printf("%s\n", model);
> +
> +       if (ret)
> +               return CMD_RET_FAILURE;
> +       else
> +               return CMD_RET_SUCCESS;
> +}
> +
> +static int do_sysinfo_id(struct cmd_tbl *cmdtp, int flag, int argc,
> +                        char *const argv[])
> +{
> +       struct udevice *dev;
> +       u32 board_id;
> +       int ret = get_sysinfo(&dev);
> +
> +       if (ret)
> +               return CMD_RET_FAILURE;
> +
> +       ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_ID, &board_id);
> +       if (ret) {
> +               printf("Cannot get sysinfo int: %d\n", ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       if (argc == 2)
> +               ret = env_set_hex(argv[1], board_id);
> +       else
> +               printf("0x%02x\n", board_id);
> +
> +       if (ret)
> +               return CMD_RET_FAILURE;
> +       else
> +               return CMD_RET_SUCCESS;
> +}
> +
> +static int do_sysinfo_revision(struct cmd_tbl *cmdtp, int flag, int argc,
> +                              char *const argv[])
> +{
> +       struct udevice *dev;
> +       int rev_major;
> +       int rev_minor;
> +       char rev[64];
> +       int ret = get_sysinfo(&dev);
> +
> +       if (ret)
> +               return CMD_RET_FAILURE;
> +
> +       ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_REV_MAJOR, &rev_major);
> +       if (ret) {
> +               printf("Cannot get sysinfo int: %d\n", ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_REV_MINOR, &rev_minor);
> +       if (ret) {
> +               printf("Cannot get sysinfo int: %d\n", ret);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       snprintf(rev, sizeof(rev), "%d.%d", rev_major, rev_minor);
> +
> +       if (argc == 2)
> +               ret = env_set(argv[1], rev);
> +       else
> +               printf("%s\n", rev);
> +
> +       if (ret)
> +               return CMD_RET_FAILURE;
> +       else
> +               return CMD_RET_SUCCESS;
> +}
> +
> +static char sysinfo_help_text[] =
> +       "model <varname>     - Show or set the board model in varname\n"
> +       "sysinfo id <varname>        - Show or set the board id in varname (in format 0xHH)\n"
> +       "sysinfo revision <varname>  - Show or set the board revision in varname";
> +
> +U_BOOT_CMD_WITH_SUBCMDS(sysinfo, "System information", sysinfo_help_text,
> +                       U_BOOT_SUBCMD_MKENT(model, 2, 1, do_sysinfo_model),
> +                       U_BOOT_SUBCMD_MKENT(id, 2, 1, do_sysinfo_id),
> +                       U_BOOT_SUBCMD_MKENT(revision, 2, 1, do_sysinfo_revision),
> +);
> --
> 2.41.0
>
