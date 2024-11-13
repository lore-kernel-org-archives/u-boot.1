Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02364D41C11
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 07:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8690288F8E;
	Wed, 13 Nov 2024 08:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q/+SAPHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C6A88AE8; Wed, 13 Nov 2024 08:44:55 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38AF89187
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so4490656a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 23:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731483891; x=1732088691; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cmjy7SV+VWms45qbGCSBIJcku+V9mn+SCIEDkP+zrnA=;
 b=Q/+SAPHAu/+uuD8Chqf4q9fYHOr8oEdoeU3/aNn+kd/IiWy0Qwc02+mwvNNq+jt0Tr
 TJlQXUqIc2HnD39NFGBDjWA7OGRjP1J3CUGPFQYLmV2B7kshQhl0Xiw3lrvN6nDTLqFU
 EQNOPhE/29GtTxN8q1UP6wVSPJU/QOszUpEjgrWd69OBDytZLrwLzMdFWE7q/W3FwROh
 uP3WmevV6QI6s0Nl/mE/Lk8bXkJIRpIVOnNyr/OQhpNp2r2xriEKFskkZhEpCoO3WkHc
 qqyTdTl3xGDIJqcBMRoU7ojCQIs0aV8BmieCGI8Cjyezs2AyM3y0C3vPPB5cIDbU0f2v
 OEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731483891; x=1732088691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmjy7SV+VWms45qbGCSBIJcku+V9mn+SCIEDkP+zrnA=;
 b=mrE/OWsqZzJME8vXq+Y7Lz0SP9Ub2cYilqk1wK1uA7+ypbxpWk+oY3Zb88gZNxjGVH
 wQDTQ3vUKuCDwBzvCtN0Q+xYtNsli/8DQcCzXWqAcMWRuc2ArWDM15AX7OetSzde7Jcd
 Ze1gktq0U9zrExg828XNL6uqFL80xzxGzRoYN9nWrdwY0NsXbKZovwVQpsgXOynFyHFm
 ipJm1sy94tmgRPHHf6U/2Tnc6V8YfuhWkyKZ6UPkxZlwGB0opdXY3Sa2AGBAh7xXMNF3
 P1ReUtP4FyJ6kXb5zIFEKomTessu0i3FrDpn4oUJD3DW1SySmTr/kzyIcbFr9WEgol1Q
 PC4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrb1f++bzfaBKjOyYgKTVEXIGkTHHcVu5IB/TwxV8mRPaWf05AC8XGgTxrFXumAfwf7KCQNwc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0zz6Lb4guYNN5N77UWTWYjgCSrT+9KFQ57LSUAFvC21lwAJd8
 Jh9VlWQiECuMw6+HMX++5cOmfIqsbMk9XcLODg97Ev3YFPqoa0oh/BrHsERfXjj7ebDKFEK8fET
 htio7XRKNcoupqjUI5GhKKewYdZPkbGJc7elvUw==
X-Google-Smtp-Source: AGHT+IHg+Ywh/yD//jw86in8CHFMTp1Y2nyHnO6Wlb3glHjGCn5dNgGm9+8amx1ckwmHJVUDVzHvi720KIWK0BJXkrc=
X-Received: by 2002:a05:6a20:7f97:b0:1db:dedd:fd51 with SMTP id
 adf61e73a8af0-1dc7033bef7mr2173125637.2.1731483891291; Tue, 12 Nov 2024
 23:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
In-Reply-To: <20241113042536.1792150-2-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 09:44:14 +0200
Message-ID: <CAC_iWjJuC-yteL9vPktw8LRcUDGGeXLG-qfSYnxKFqHZRvE4hA@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: add a fetch utility
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
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

On Wed, 13 Nov 2024 at 06:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
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
> @@ -1724,8 +1724,13 @@ M:       Heiko Schocher <hs@denx.de>
>  S:     Maintained
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>  F:     drivers/mtd/ubi/
>
> +UFETCH
> +M:     Caleb Connolly <caleb.connolly@linaro.org>
> +S:     Maintained
> +F:     cmd/ufetch.c
> +
>  UFS
>  M:     Neil Armstrong <neil.armstrong@linaro.org>
>  M:     Bhupesh Sharma <bhupesh.linux@gmail.com>
>  M:     Neha Malcom Francis <n-francis@ti.com>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4fba9fe67034..da736249a3cf 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -175,8 +175,15 @@ config CMD_CPU
>           number of CPUs, type (e.g. manufacturer, architecture, product or
>           internal name) and clock frequency. Other information may be
>           available depending on the CPU driver.
>
> +config CMD_UFETCH
> +       bool "U-Boot fetch"
> +       depends on BLK
> +       help
> +         Fetch utility for U-Boot (akin to neofetch). Prints information
> +         about U-Boot and the board it is running on in a pleasing format.
> +
>  config CMD_FWU_METADATA
>         bool "fwu metadata read"
>         depends on FWU_MULTI_BANK_UPDATE
>         help
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
> +       BLUE BOLD "                  ......::......                   ",
> +       BLUE BOLD "             ...::::::::::::::::::...              ",
> +       BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +       BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
> +       BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
> +       BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE "::::::::::.::.     ",
> +       BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE ":....::::::::::.    ",
> +       BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-" BLUE "::::::::::.:.   ",
> +       BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-" BLUE "...::::::.:.  ",
> +       BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
> +       BLUE BOLD ".:.::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
> +       BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
> +       BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
> +       BLUE BOLD ".::" YELLOW "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
> +       BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
> +       BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
> +       BLUE BOLD " ..::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
> +       BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-" YELLOW "=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
> +       BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
> +       BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
> +       BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
> +       BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
> +       BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +       BLUE BOLD "             ...::::::::::::::::::...              ",
> +       BLUE BOLD "                  ......::......                   ",
> +};
> +
> +enum output_lines {
> +       FIRST,
> +       SECOND,
> +       KERNEL,
> +       SYSINFO,
> +       HOST,
> +       UPTIME,
> +       IP,
> +       CMDS,
> +       CONSOLES,
> +       DEVICES,
> +       FEATURES,
> +       RELOCATION,
> +       CORES,
> +       MEMORY,
> +       STORAGE,
> +
> +       /* Up to 10 storage devices... Should be enough for anyone right? */
> +       _LAST_LINE = (STORAGE + 10),
> +#define LAST_LINE (_LAST_LINE - 1UL)
> +};
> +
> +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> +                    char *const argv[])
> +{
> +       int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
> +       const char *model, *compatible;
> +       char *ipaddr;
> +       int n_cmds, n_cpus = 0, ret, compatlen;
> +       size_t size;
> +       ofnode np;
> +       struct udevice *dev;
> +       struct blk_desc *desc;
> +       bool skip_ascii = false;
> +
> +       if (argc > 1 && strcmp(argv[1], "-n") == 0) {
> +               skip_ascii = true;
> +               num_lines = LAST_LINE;
> +       }
> +
> +       for (int line = 0; line < num_lines; line++) {
> +               if (!skip_ascii) {
> +                       if (line < ARRAY_SIZE(logo_lines))
> +                               printf("%s  ", logo_lines[line]);
> +                       else
> +                               printf("%*c  ", LINE_WIDTH, ' ');
> +               }
> +               switch (line) {
> +               case FIRST:
> +                       compatible = ofnode_read_string(ofnode_root(), "compatible");
> +                       if (!compatible)
> +                               compatible = "unknown";
> +                       printf(RESET "%s\n", compatible);
> +                       compatlen = strlen(compatible);
> +                       break;
> +               case SECOND:
> +                       for (int j = 0; j < compatlen; j++)
> +                               putc('-');
> +                       putc('\n');
> +                       break;
> +               case KERNEL:
> +                       printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
> +                       break;
> +               case SYSINFO:
> +                       printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
> +                       break;
> +               case HOST:
> +                       model = ofnode_read_string(ofnode_root(), "model");
> +                       if (model)
> +                               printf("Host:" RESET " %s\n", model);
> +                       break;
> +               case UPTIME:
> +                       printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
> +                       break;
> +               case IP:
> +                       ipaddr = env_get("ipvaddr");
> +                       if (!ipaddr)
> +                               ipaddr = "none";
> +                       printf("IP Address:" RESET " %s", ipaddr);
> +                       ipaddr = env_get("ipv6addr");
> +                       if (ipaddr)
> +                               printf(", %s\n", ipaddr);
> +                       else
> +                               putc('\n');
> +                       break;
> +               case CMDS:
> +                       n_cmds = ll_entry_count(struct cmd_tbl, cmd);
> +                       printf("Commands:" RESET " %d (help)\n", n_cmds);
> +                       break;
> +               case CONSOLES:
> +                       printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
> +                              gd->baudrate);
> +                       break;
> +               case DEVICES:
> +                       printf("Devices:" RESET " ");
> +                       /* TODO: walk the DM tree */
> +                       printf("Uncountable!\n");
> +                       break;
> +               case FEATURES:
> +                       printf("Features:" RESET " ");
> +                       if (IS_ENABLED(CONFIG_NET))
> +                               printf("Net");
> +                       if (IS_ENABLED(CONFIG_EFI_LOADER))
> +                               printf(", EFI");
> +                       if (IS_ENABLED(CONFIG_CMD_CAT))
> +                               printf(", cat :3");
> +#ifdef CONFIG_ARM
> +                       switch (current_el()) {
> +                       case 2:
> +                               printf(", VMs");
> +                               break;
> +                       case 3:
> +                               printf(", full control!");
> +                               break;
> +                       }
> +#endif
> +                       printf("\n");
> +                       break;
> +               case RELOCATION:
> +                       if (gd->flags & GD_FLG_SKIP_RELOC)
> +                               printf("Relocated:" RESET " no\n");
> +                       else
> +                               printf("Relocated:" RESET " to %#011lx\n", gd->relocaddr);
> +                       break;
> +               case CORES:
> +                       ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
> +                               if (ofnode_name_eq(np, "cpu"))
> +                                       n_cpus++;
> +                       }
> +                       printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> +                       break;
> +               case MEMORY:
> +                       for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
> +                               size += gd->bd->bi_dram[j].size;
> +                       printf("Memory:" RESET " ");
> +                       print_size(size, "\n");
> +                       break;
> +               case STORAGE:
> +               default:
> +                       ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
> +                       if (!ret && dev) {
> +                               desc = dev_get_uclass_plat(dev);
> +                               size = desc->lba * desc->blksz;
> +                               printf("%s %d: " RESET, desc->uclass_id == UCLASS_SCSI ? "SCSI" :
> +                                               desc->uclass_id == UCLASS_MMC
> +                                               ? "MMC" : "Storage",
> +                                       desc->lun);
> +                               if (size)
> +                                       print_size(size, "");
> +                               else
> +                                       printf("No media");
> +                       }
> +                       printf("\n");
> +               }
> +       }
> +
> +       printf(RESET "\n\n");
> +
> +       return 0;
> +}
> +
> +U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
> +          "U-Boot fetch utility",
> +          "Print information about your device.\n"
> +          "    -n    Don't print the ASCII logo"
> +);
> --
> 2.47.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
