Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1593AD68B18
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 13:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F95895AF;
	Thu, 14 Nov 2024 14:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vebxFDAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BF4895FF; Thu, 14 Nov 2024 14:44:19 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19CC89583
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 14:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso653695e87.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 05:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731591856; x=1732196656;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oxIoGs5sT5oPuBttCRuERVar1JdMkrm/owwDwh9TAMs=;
 b=vebxFDAd01giM4SsdG05xMTEpS7zHjOOwa2cnn8p/oVDFKsLPszVMquu23cWuFaWGr
 zHjvW1kf8/05R3r4zdi3TvrcGrizHfBve8qvZ/pMqCqj6IlKFmttNHjAi7RvZpowLA8D
 h2ckDWljvfolv9EFM2GfzYLhcR7icL4Rlz9/kSu35FIshfYGmPOVMieYBBjNv2ucCGQp
 ldrmMO+b+Ilbnb2jHkolfoxFdTe+QOJ8SLWD7++8/5Fp2CCiqy350W8xqJZGPPs2/qrg
 Pt9yruZvTT89HIunEapPdsHnj/YliYYJuhT80g9gfwV9JvbyFC3z57C23yLykIG3PDwQ
 iBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731591856; x=1732196656;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxIoGs5sT5oPuBttCRuERVar1JdMkrm/owwDwh9TAMs=;
 b=AVo4owO3jZhs4zzqWEnLs5lSXIcaWoD7zMKLvFKkJcc9HQyRu/k8+lTfTxn3JAX/lc
 SaiC0Xna2pKnk8fISnpal/Cvi+X0lVgA2qRkaaBCZJe66qMlcgIdRc08cF95Vtj62iF+
 uhGKF2/hBoKwd97XOtlI8N/v4D+cy3U3QHsBKhH8cRgigj8KfeEe4d9aBqOKfpZQlRU8
 5EpXkTtxUj/mEQ/Klp6Zr6tAX2cmuXNtCC432JjTtVjc7sHn2OmVreu+Ua0LtNFbPb4c
 SRrPqMOSg+v8OSPxzvEL+Tx1qRM6oM27lh+xylURR+2xcsxRhIaxPx9QRkqk83o4KF3C
 fQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxXJFkeQgorx23Iaongx93Ig8NqQhGmK9c4r7x6UeSey67WkSCd8OsXt0cJeYtfAqX3NGJEG8=@lists.denx.de
X-Gm-Message-State: AOJu0YxmnM0QtLAutPgnqy7yHU/YDVMN9QnO1rvyCFbPLZwrpM6Ycu0y
 1oo9DnEjtC+cnyGcCY4WeLxuFHd0P+446n6HCW7/xccssJjf05N7X2B8GXnJYJ4=
X-Google-Smtp-Source: AGHT+IFIzvqU9OFV/7Yh9UY4aqNqzheBfCiL8Z3/BVMF2zWwwqHgNTLX/AppxojnD+w0lYiUum77Bw==
X-Received: by 2002:a05:6512:138b:b0:53b:1625:bcf8 with SMTP id
 2adb3069b0e04-53d862c5905mr11532606e87.30.1731591854501; 
 Thu, 14 Nov 2024 05:44:14 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721efsm21662805e9.4.2024.11.14.05.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 05:44:13 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: add a fetch utility
In-Reply-To: <20241113042536.1792150-2-caleb.connolly@linaro.org>
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
Date: Thu, 14 Nov 2024 14:44:10 +0100
Message-ID: <87ed3eaq1h.fsf@baylibre.com>
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

Hi Caleb,

Thank you for the patch.

On mer., nov. 13, 2024 at 05:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Add a small utility for displaying some information about U-Boot and the
> hardware it's running on in a similar fashion to the popular neofetch
> tool for Linux [1].
>
> While the output is meant to be useful, it should also be pleasing to
> look at and perhaps entertaining. The ufetch command aims to bring this
> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo.
>
> [1]: https://en.wikipedia.org/wiki/Neofetch
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3

> ---
> Ephemeral screenshot: https://0x0.st/XkQU.png
>
> Changes since v1:
>  * Rework storage info to be more dynamic
>  * use print_size() helper everywhere
>  * manually walk RAM banks to report memory size correctly
>  * minor formatting changes and fixes
>  * MAINTAINERS entry
>  * V1: https://lore.kernel.org/u-boot/20240808163153.2069650-1-caleb.connolly@linaro.org
> ---
>  MAINTAINERS  |   5 ++
>  cmd/Kconfig  |   7 ++
>  cmd/Makefile |   1 +
>  cmd/ufetch.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 237 insertions(+)
>  create mode 100644 cmd/ufetch.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38c714cf46a6..d1eb164ad590 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1724,8 +1724,13 @@ M:	Heiko Schocher <hs@denx.de>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>  F:	drivers/mtd/ubi/
>  
> +UFETCH
> +M:	Caleb Connolly <caleb.connolly@linaro.org>
> +S:	Maintained
> +F:	cmd/ufetch.c
> +
>  UFS
>  M:	Neil Armstrong <neil.armstrong@linaro.org>
>  M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>  M:	Neha Malcom Francis <n-francis@ti.com>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4fba9fe67034..da736249a3cf 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -175,8 +175,15 @@ config CMD_CPU
>  	  number of CPUs, type (e.g. manufacturer, architecture, product or
>  	  internal name) and clock frequency. Other information may be
>  	  available depending on the CPU driver.
>  
> +config CMD_UFETCH
> +	bool "U-Boot fetch"
> +	depends on BLK
> +	help
> +	  Fetch utility for U-Boot (akin to neofetch). Prints information
> +	  about U-Boot and the board it is running on in a pleasing format.
> +
>  config CMD_FWU_METADATA
>  	bool "fwu metadata read"
>  	depends on FWU_MULTI_BANK_UPDATE
>  	help
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0a..1e6d3128c8ca 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -52,8 +52,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
>  obj-$(CONFIG_CMD_CPU) += cpu.o
>  obj-$(CONFIG_CMD_DATE) += date.o
>  obj-$(CONFIG_CMD_DEMO) += demo.o
>  obj-$(CONFIG_CMD_DM) += dm.o
> +obj-$(CONFIG_CMD_UFETCH) += ufetch.o
>  obj-$(CONFIG_CMD_SOUND) += sound.o
>  ifdef CONFIG_POST
>  obj-$(CONFIG_CMD_DIAG) += diag.o
>  endif
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> new file mode 100644
> index 000000000000..1bd0565b9f08
> --- /dev/null
> +++ b/cmd/ufetch.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Small "fetch" utility for U-Boot */
> +
> +#ifdef CONFIG_ARM
> +#include <asm/system.h>
> +#endif
> +#include <dm/device.h>
> +#include <dm/uclass-internal.h>
> +#include <display_options.h>
> +#include <mmc.h>
> +#include <time.h>
> +#include <asm/global_data.h>
> +#include <cli.h>
> +#include <command.h>
> +#include <dm/ofnode.h>
> +#include <env.h>
> +#include <rand.h>
> +#include <vsprintf.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <version.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define LINE_WIDTH 40
> +#define BLUE "\033[38;5;4m"
> +#define YELLOW "\033[38;5;11m"
> +#define BOLD "\033[1m"
> +#define RESET "\033[0m"
> +static const char * const logo_lines[] = {
> +	BLUE BOLD "                  ......::......                   ",
> +	BLUE BOLD "             ...::::::::::::::::::...              ",
> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +	BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
> +	BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
> +	BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE "::::::::::.::.     ",
> +	BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE ":....::::::::::.    ",
> +	BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-" BLUE "::::::::::.:.   ",
> +	BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-" BLUE "...::::::.:.  ",
> +	BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
> +	BLUE BOLD ".:.::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
> +	BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
> +	BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
> +	BLUE BOLD ".::" YELLOW "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
> +	BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
> +	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
> +	BLUE BOLD " ..::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
> +	BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-" YELLOW "=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
> +	BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
> +	BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
> +	BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
> +	BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +	BLUE BOLD "             ...::::::::::::::::::...              ",
> +	BLUE BOLD "                  ......::......                   ",
> +};
> +
> +enum output_lines {
> +	FIRST,
> +	SECOND,
> +	KERNEL,
> +	SYSINFO,
> +	HOST,
> +	UPTIME,
> +	IP,
> +	CMDS,
> +	CONSOLES,
> +	DEVICES,
> +	FEATURES,
> +	RELOCATION,
> +	CORES,
> +	MEMORY,
> +	STORAGE,
> +
> +	/* Up to 10 storage devices... Should be enough for anyone right? */
> +	_LAST_LINE = (STORAGE + 10),
> +#define LAST_LINE (_LAST_LINE - 1UL)
> +};
> +
> +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> +		     char *const argv[])
> +{
> +	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
> +	const char *model, *compatible;
> +	char *ipaddr;
> +	int n_cmds, n_cpus = 0, ret, compatlen;
> +	size_t size;
> +	ofnode np;
> +	struct udevice *dev;
> +	struct blk_desc *desc;
> +	bool skip_ascii = false;
> +
> +	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
> +		skip_ascii = true;
> +		num_lines = LAST_LINE;
> +	}
> +
> +	for (int line = 0; line < num_lines; line++) {
> +		if (!skip_ascii) {
> +			if (line < ARRAY_SIZE(logo_lines))
> +				printf("%s  ", logo_lines[line]);
> +			else
> +				printf("%*c  ", LINE_WIDTH, ' ');
> +		}
> +		switch (line) {
> +		case FIRST:
> +			compatible = ofnode_read_string(ofnode_root(), "compatible");
> +			if (!compatible)
> +				compatible = "unknown";
> +			printf(RESET "%s\n", compatible);
> +			compatlen = strlen(compatible);
> +			break;
> +		case SECOND:
> +			for (int j = 0; j < compatlen; j++)
> +				putc('-');
> +			putc('\n');
> +			break;
> +		case KERNEL:
> +			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
> +			break;
> +		case SYSINFO:
> +			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
> +			break;
> +		case HOST:
> +			model = ofnode_read_string(ofnode_root(), "model");
> +			if (model)
> +				printf("Host:" RESET " %s\n", model);
> +			break;
> +		case UPTIME:
> +			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
> +			break;
> +		case IP:
> +			ipaddr = env_get("ipvaddr");
> +			if (!ipaddr)
> +				ipaddr = "none";
> +			printf("IP Address:" RESET " %s", ipaddr);
> +			ipaddr = env_get("ipv6addr");
> +			if (ipaddr)
> +				printf(", %s\n", ipaddr);
> +			else
> +				putc('\n');
> +			break;
> +		case CMDS:
> +			n_cmds = ll_entry_count(struct cmd_tbl, cmd);
> +			printf("Commands:" RESET " %d (help)\n", n_cmds);
> +			break;
> +		case CONSOLES:
> +			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
> +			       gd->baudrate);
> +			break;
> +		case DEVICES:
> +			printf("Devices:" RESET " ");
> +			/* TODO: walk the DM tree */
> +			printf("Uncountable!\n");
> +			break;
> +		case FEATURES:
> +			printf("Features:" RESET " ");
> +			if (IS_ENABLED(CONFIG_NET))
> +				printf("Net");
> +			if (IS_ENABLED(CONFIG_EFI_LOADER))
> +				printf(", EFI");
> +			if (IS_ENABLED(CONFIG_CMD_CAT))
> +				printf(", cat :3");
> +#ifdef CONFIG_ARM
> +			switch (current_el()) {
> +			case 2:
> +				printf(", VMs");
> +				break;
> +			case 3:
> +				printf(", full control!");
> +				break;
> +			}
> +#endif
> +			printf("\n");
> +			break;
> +		case RELOCATION:
> +			if (gd->flags & GD_FLG_SKIP_RELOC)
> +				printf("Relocated:" RESET " no\n");
> +			else
> +				printf("Relocated:" RESET " to %#011lx\n", gd->relocaddr);
> +			break;
> +		case CORES:
> +			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
> +				if (ofnode_name_eq(np, "cpu"))
> +					n_cpus++;
> +			}
> +			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> +			break;
> +		case MEMORY:
> +			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
> +				size += gd->bd->bi_dram[j].size;
> +			printf("Memory:" RESET " ");
> +			print_size(size, "\n");
> +			break;
> +		case STORAGE:
> +		default:
> +			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
> +			if (!ret && dev) {
> +				desc = dev_get_uclass_plat(dev);
> +				size = desc->lba * desc->blksz;
> +				printf("%s %d: " RESET, desc->uclass_id == UCLASS_SCSI ? "SCSI" :
> +						desc->uclass_id == UCLASS_MMC
> +						? "MMC" : "Storage",
> +					desc->lun);
> +				if (size)
> +					print_size(size, "");
> +				else
> +					printf("No media");
> +			}
> +			printf("\n");
> +		}
> +	}
> +
> +	printf(RESET "\n\n");
> +
> +	return 0;
> +}
> +
> +U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
> +	   "U-Boot fetch utility",
> +	   "Print information about your device.\n"
> +	   "    -n    Don't print the ASCII logo"
> +);
> -- 
> 2.47.0
