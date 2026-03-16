Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF52FD8741
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B7D8421C;
	Tue, 17 Mar 2026 12:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="eYjhDpWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6198401A; Tue, 17 Mar 2026 06:07:08 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552928405A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1926B10D17D; Tue, 17 Mar 2026 06:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773724026;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ycgtL7OJzIQ84YEmOKdPNrpAnvuWZueAOYO7tgNVRf0=;
 b=eYjhDpWqJrnwdUJWRA5SJ9QvngdwXVtKnkzTn1Iq4XWvl8lgmF5OM2v4hElgh1HPiZEyXP
 fv1expaN1sLUgt7H7xOek8uwczY+08hOfRxkIgT7RhB2VDeJvoG1ZFJzBFWpmv8jwjmjMp
 laiJKf6tNzhvwmozqK04kpn7bOiT/4EqcUtgErEJ1sWa7vxHzC1ZRYrVhhYcSJ7s5ydBC/
 dVloKfsMsMuIwLVzKyoN4ijh+OFtfBdN1rY+3pelgR7J6BYa482MOkkXgjW7Ml2An+czc7
 hspHymnempUptO7QiTVAOK1s3Lezhn+DrRoZWyeXS3opXIL5pqeAICSjdahKVg==
Message-ID: <1e3b41bf-b6fe-4307-b6d1-dbc3ce0615e0@nabladev.com>
Date: Mon, 16 Mar 2026 13:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm: mach-imx: Add command to expose QB
 functionality
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <2c33ee004dd272b8427b3d1962ade06cbb220149.1773648510.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <2c33ee004dd272b8427b3d1962ade06cbb220149.1773648510.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 12:56:37 +0100
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

On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:

[...]

> +++ b/arch/arm/mach-imx/Kconfig
> @@ -71,6 +71,17 @@ config CSF_SIZE
>   	  Define the maximum size for Command Sequence File (CSF) binary
>   	  this information is used to define the image boot data.
>   
> +config CMD_IMX_QB
> +	bool "Support the 'qb' command"
> +	default y
> +	depends on IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)

94 should be before 95

> +	help
> +	  Enable qb command to write/erase DDR quick boot training
> +	  data to/from a chosen boot device. Using 'qb save/erase'
> +	  without args

arguments ... please avoid abbreviations

> implies using the current boot device. For
> +	  use in uuu scripts, the boot device must be specified
> +	  explicitly.
> +
>   config CMD_BMODE
>   	bool "Support the 'bmode' command"
>   	default y
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 0f6e737c0b9..dfa9eca43eb 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_CMD_BMODE) += cmd_bmode.o
>   obj-$(CONFIG_CMD_HDMIDETECT) += cmd_hdmidet.o
>   obj-$(CONFIG_CMD_DEKBLOB) += cmd_dek.o
>   obj-$(CONFIG_CMD_NANDBCB) += cmd_nandbcb.o
> +obj-$(CONFIG_CMD_IMX_QB) += cmd_qb.o

Keep the list sorted

>   endif
>   
>   ifeq ($(CONFIG_XPL_BUILD),y)
> diff --git a/arch/arm/mach-imx/cmd_qb.c b/arch/arm/mach-imx/cmd_qb.c
> new file mode 100644
> index 00000000000..54733c1ad88
> --- /dev/null
> +++ b/arch/arm/mach-imx/cmd_qb.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/**
> + * Copyright 2024-2026 NXP
> + */
> +#include <command.h>
> +#include <spl.h>
> +#include <stdlib.h>
> +
> +#include <asm/mach-imx/boot_mode.h>
> +#include <asm/mach-imx/sys_proto.h>
> +#include <asm/mach-imx/qb.h>
> +
> +static int get_board_boot_device(enum boot_device dev)
> +{
> +	switch (dev) {
> +	case SD1_BOOT:
> +	case MMC1_BOOT:
> +		return BOOT_DEVICE_MMC1;
> +	case SD2_BOOT:
> +	case MMC2_BOOT:
> +		return BOOT_DEVICE_MMC2;
> +	case USB_BOOT:
> +		return BOOT_DEVICE_BOARD;
> +	case QSPI_BOOT:
> +		return BOOT_DEVICE_SPI;
> +	default:
> +		return BOOT_DEVICE_NONE;
> +	}
> +}
> +
> +static void parse_qb_args(int argc, char * const argv[],
> +			  int *qb_dev, int qb_bootdev)
> +{
> +	long dev = -1;
> +	char *interface = "";
> +
> +	if (argc >= 2) {
> +		interface = argv[1];
> +	} else {
> +		/* qb save -> use boot device */
> +		*qb_dev = qb_bootdev;

Maybe invert the conditional, if (args < 2) qb_dev = ... to make it more 
obvious what is going on here ?

> +	}
> +
> +	if (argc == 3)
> +		dev = simple_strtol(argv[2], NULL, 10);
> +
> +	if (!strcmp(interface, "mmc") && dev >= 0 &&
> +	    dev <= (BOOT_DEVICE_MMC2_2 - BOOT_DEVICE_MMC1))
> +		*qb_dev = BOOT_DEVICE_MMC1 + dev;
> +
> +	if (!strcmp(interface, "spi"))

Shouldn't this be "else if" here, since interface can not be both mmc 
and spi ?

> +		*qb_dev = BOOT_DEVICE_SPI;
> +}
> +
> +static int do_qb(struct cmd_tbl *cmdtp, int flag, int argc,
> +		 char * const argv[], bool save)
> +{
> +	int ret = CMD_RET_FAILURE;
> +	enum boot_device boot_dev = UNKNOWN_BOOT;
> +	int qb_dev = BOOT_DEVICE_NONE, qb_bootdev;
> +
> +	boot_dev = get_boot_device();
> +	qb_bootdev = get_board_boot_device(boot_dev);
> +
> +	parse_qb_args(argc, argv, &qb_dev, qb_bootdev);
> +
> +	ret = qb(qb_dev, qb_bootdev, save);
> +
> +	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> +}
> +
> +static int do_qb_check(struct cmd_tbl *cmdtp, int flag,
> +		       int argc, char * const argv[])
> +{
> +	return qb_check() ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
> +}
> +
> +static int do_qb_save(struct cmd_tbl *cmdtp, int flag,
> +		      int argc, char * const argv[])
> +{
> +	return do_qb(cmdtp, flag, argc, argv, true);
> +}
> +
> +static int do_qb_erase(struct cmd_tbl *cmdtp, int flag,
> +		       int argc, char * const argv[])
> +{
> +	return do_qb(cmdtp, flag, argc, argv, false);
> +}
> +
> +static struct cmd_tbl cmd_qb[] = {
> +	U_BOOT_CMD_MKENT(check, 1, 1, do_qb_check, "", ""),
> +	U_BOOT_CMD_MKENT(save,  3, 1, do_qb_save,  "", ""),
> +	U_BOOT_CMD_MKENT(erase, 3, 1, do_qb_erase, "", ""),
> +};
> +
> +static int do_qbops(struct cmd_tbl *cmdtp, int flag, int argc,
> +		    char *const argv[])
> +{
> +	struct cmd_tbl *cp;
> +
> +	cp = find_cmd_tbl(argv[1], cmd_qb, ARRAY_SIZE(cmd_qb));
> +
> +	/* Drop the qb command */
> +	argc--;
> +	argv++;
> +
> +	if (!cp) {
> +		printf("%s cp is null\n", __func__);

What does this error output even mean ? The user will be confused, 
please reword it.

> +		return CMD_RET_USAGE;
> +	}
> +
> +	if (argc > cp->maxargs) {
> +		printf("%s argc(%d) > cp->maxargs(%d)\n", __func__, argc, cp->maxargs);

Reword this too please.

> +		return CMD_RET_USAGE;
> +	}
> +
> +	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp)) {
> +		printf("%s %s repeat flag set  but command is not repeatable\n",

One space is enough.

> +		       __func__, cp->name);
> +		return CMD_RET_SUCCESS;
> +	}
> +
> +	return cp->cmd(cmdtp, flag, argc, argv);
> +}
> +
> +U_BOOT_CMD(
> +	qb, 4, 1, do_qbops,
> +	"DDR Quick Boot sub system",
> +	"check - check if quick boot data is stored in mem by training flow\n"
> +	"qb save [interface] [dev]  - save quick boot data in NVM location    => trigger quick boot flow\n"
> +	"qb erase [interface] [dev] - erase quick boot data from NVM location => trigger training flow\n"
> +);
> diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
> index 3018d128a36..7dee144e0f4 100644
> --- a/arch/arm/mach-imx/imx9/Makefile
> +++ b/arch/arm/mach-imx/imx9/Makefile
> @@ -15,5 +15,7 @@ obj-y += imx_bootaux.o
>   endif
>   
>   ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
> -obj-y += qb.o
> +ifneq ($(CONFIG_XPL_BUILD),y)
> +obj-$(CONFIG_CMD_IMX_QB) += qb.o
> +endif

This shoudld be part of 1/5 , should it not ?
