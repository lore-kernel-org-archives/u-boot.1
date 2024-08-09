Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128CCC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 17:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4538088A6B;
	Fri,  9 Aug 2024 19:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ILVqwlFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C259D88B36; Fri,  9 Aug 2024 19:23:47 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CD088A2F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 19:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135dso2945758a12.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723224224; x=1723829024; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcWGEBSgAPgIe3F2QzT7ARIbd/dyjuXym/Hhpa+saTk=;
 b=ILVqwlFl5VvcjdBxVHKddqno38msRNrK2Ilnm+alAuSWdzcPY9z+sfadNWOGu6lt5z
 SvTbO9Pt7g+jdAVw73lnQCvX73rwmreZFU0ftfxhGEKyl/wCun2gZJJ5GKWvWwEwOhZ/
 nF6Rqj9UNO7XzdrMsWLvY40SGagcwTMugJzD4R5Dzo9g6VPEpH5Xv5NvGsYEPTyzeJ4/
 04Bu443Z+pdpVcKmv5Khc0CuiaxfQH2iwqqYyAMf90710fuBS/3sq0BKZ2KMJoECv13k
 go8L1RhlRw8dRp8nj8wPQK7i6ZK0M7S8eJwYUfwwaeZSoyAzVrJ5FJssL4pvGhLbXpLa
 0tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723224224; x=1723829024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IcWGEBSgAPgIe3F2QzT7ARIbd/dyjuXym/Hhpa+saTk=;
 b=naxKG2xc69thP2h3lWxOJMdMFMBgtmiW44r2pHq3/6fvBhNawsvuiMr2S0NDHEPIZA
 lcZZ5bG761twfqPhGZ/49n+Sg2KinZEQi3Ko1JSyqkTB1WfAU3ZqHiTwL5ePtlrXJuRn
 10qBaV0beNBDD+dysZZQpeOk6HLGMVzVBS6gIJS3rARhw5kCqdUOlO1kiYq8GgEVeyCb
 AcNwpHUK6cjeMsd/+r4n0PH1vW6OYq0/ZtHgVWiZmzQIPwpU6c6BRj6RQZ2wPfW2lPX/
 2UKbBBQ6DYE6wPTqltVA10LqyvlIPLY6z3PaTUYmDPg6bzzZ3MpHGFoWVskcOYBCe9dk
 YKTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFgt8go4dEePcsGFSEBCQAZ6Q5h3nZ5jW+m34Ry5GngLRw4gxcYXjOmYpgsMDdiAcBsiaY6K3FQLIg/2lFttxGe2bm4Q==
X-Gm-Message-State: AOJu0YzBKIe5HUOMWe9SKDnnVir1ZZaKmkJiCG8hF9ShaJ758SndksPi
 VTHRKzfsMjhyyGX/xzOb7RCFuU7OyGgTtH9w+j0Dygqe96No/MnXKDUilaCJHpY=
X-Google-Smtp-Source: AGHT+IHOSFfuK2pwF9NXoLR9ksFXs0jIOEcBcdLHU6jZZr5rXKtAWrEb8cnwRLJpiCBdA2vYwrDYMA==
X-Received: by 2002:a05:6402:1909:b0:5a8:2f2b:d2c9 with SMTP id
 4fb4d7f45d1cf-5bd0a57c3dbmr1637760a12.21.1723224223970; 
 Fri, 09 Aug 2024 10:23:43 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4fee? ([2a02:8109:aa0d:be00::4fee])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2c1f622sm1708855a12.30.2024.08.09.10.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 10:23:43 -0700 (PDT)
Message-ID: <c25c559d-97ab-4abf-bee3-77dc38802e71@linaro.org>
Date: Fri, 9 Aug 2024 19:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: add a fetch utility
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Anand Moon
 <linux.amoon@gmail.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
 <0194AFA0-5D56-46F8-A385-D23AF7CDDD43@gmx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <0194AFA0-5D56-46F8-A385-D23AF7CDDD43@gmx.de>
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



On 09/08/2024 08:18, Heinrich Schuchardt wrote:
> 
> 
> Am 8. August 2024 18:24:24 MESZ schrieb Caleb Connolly <caleb.connolly@linaro.org>:
>> While U-Boot does a pretty good job at printing information at startup
>> about what hardware it's running on, it can be hard to take pretty
>> pictures of this to show off on the internet (by far the most
>> important aspect of porting a device in 2024!).
>>
>> Add a small utility "ufetch" for displaying some information about U-Boot and
>> the hardware it's running on in a similar fashion to the popular neofetch tool
>> for *nix's [1].
>>
>> While the output is meant to be useful, it should also be pleasing to look at
>> and look good in screenshots. The ufetch command brings this to U-Boot,
>> featuring a colorful ASCII art version of the U-Boot logo and a fancy layout.
>>
>> Finally, tireless device porters can properly show off their hard work and get
>> the internet points they so deserve!
>>
>> Not everything is fully supported yet, but this seemed good enough for initial
>> inclusion. Only one MMC device is detected, and other than SCSI other storage
>> devices aren't supported.
> 
> 
> This command is not very generic. E.g. it supports SCSI drives but not SATA. Many boards have eMMC and SD-card. This lks more ike an RFC tan something ready to merge.

Honestly it didn't even occur to me to send an RFC since this is purely 
a vanity thing...

I'll make it generic over UCLASS_BLK if possible for the next revision.
> 
> Why don't you use a script or an EFI program to print whatever information you need?

Well , then you'd need to have a way to load the script or EFI binary, 
which might not be possible for an early U-Boot port which doesn't have 
storage support yet (or at least, be a bunch of effort).

The only motivation to have this in U-Boot is really because

a) it's cute
b) it motivates "reward oriented" people like myself to get U-Boot 
booting on new/interesting devices because now it can be really easily 
shown off.

Maybe it's a cynical take, but I think stuff like this really has the 
potential to get more folks interested. Nobody likes doing the invisible 
background work, so why not bring some visibility to things?

Assuming I did a bad job at conveying my intent in the patch 
description: the point here is not to convey useful debugging 
information to developers, it's to show off, look pretty, and be 
amusing. Plenty of other U-Boot commands can convey information, this 
one is more like the 2048 port.
> 
>>
>> [1]: https://en.wikipedia.org/wiki/Neofetch
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Ephemeral demo image: https://0x0.st/XVUa.png
>> ---
>> cmd/Kconfig  |   7 ++
>> cmd/Makefile |   1 +
>> cmd/ufetch.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 209 insertions(+)
>> create mode 100644 cmd/ufetch.c
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 978f44eda426..70acb5727b04 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -175,8 +175,15 @@ config CMD_CPU
>> 	  number of CPUs, type (e.g. manufacturer, architecture, product or
>> 	  internal name) and clock frequency. Other information may be
>> 	  available depending on the CPU driver.
>>
>> +config CMD_UFETCH
>> +	bool "U-Boot fetch"
>> +	depends on BLK
>> +	help
>> +	  Fetch utility for U-Boot (akin to neofetch). Prints information
>> +	  about U-Boot and the board it is running on in a pleasing format.
>> +
>> config CMD_FWU_METADATA
>> 	bool "fwu metadata read"
>> 	depends on FWU_MULTI_BANK_UPDATE
>> 	help
>> diff --git a/cmd/Makefile b/cmd/Makefile
>> index 87133cc27a8a..ffb04c8f2e0a 100644
>> --- a/cmd/Makefile
>> +++ b/cmd/Makefile
>> @@ -53,8 +53,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
>> obj-$(CONFIG_CMD_CPU) += cpu.o
>> obj-$(CONFIG_CMD_DATE) += date.o
>> obj-$(CONFIG_CMD_DEMO) += demo.o
>> obj-$(CONFIG_CMD_DM) += dm.o
>> +obj-$(CONFIG_CMD_UFETCH) += ufetch.o
>> obj-$(CONFIG_CMD_SOUND) += sound.o
>> ifdef CONFIG_POST
>> obj-$(CONFIG_CMD_DIAG) += diag.o
>> endif
>> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
>> new file mode 100644
>> index 000000000000..f7374eb2e364
>> --- /dev/null
>> +++ b/cmd/ufetch.c
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Small "fetch" utility for U-Boot */
>> +
>> +#include <mmc.h>
>> +#include <time.h>
>> +#include <asm/global_data.h>
>> +#include <cli.h>
>> +#include <command.h>
>> +#include <dm/ofnode.h>
>> +#include <env.h>
>> +#include <rand.h>
>> +#include <vsprintf.h>
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <version.h>
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define LINE_WIDTH 40
>> +#define BLUE "\033[38;5;4m"
>> +#define YELLOW "\033[38;5;11m"
>> +#define BOLD "\033[1m"
>> +#define RESET "\033[0m"
>> +static const char *logo_lines[] = {
>> +	BLUE BOLD "                  ......::......                   ",
>> +	BLUE BOLD "             ...::::::::::::::::::...              ",
>> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
>> +	BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
>> +	BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
>> +	BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE "::::::::::.::.     ",
>> +	BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE ":....::::::::::.    ",
>> +	BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-" BLUE "::::::::::.:.   ",
>> +	BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-" BLUE "...::::::.:.  ",
>> +	BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
>> +	BLUE BOLD ".:.::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
>> +	BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
>> +	BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
>> +	BLUE BOLD ".::" YELLOW "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
>> +	BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
>> +	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
>> +	BLUE BOLD " ..::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
>> +	BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-\033[38;5;7m=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
>> +	BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
>> +	BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
>> +	BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
>> +	BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
>> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
>> +	BLUE BOLD "             ...::::::::::::::::::...              ",
>> +	BLUE BOLD "                  ......::......                   ",
>> +};
>> +
>> +enum output_lines {
>> +	FIRST,
>> +	SECOND,
>> +	KERNEL,
>> +	SYSINFO,
>> +	HOST,
>> +	UPTIME,
>> +	IP,
>> +	CMDS,
>> +	CONSOLES,
>> +	DEVICES,
>> +	FEATURES,
>> +	RELOCATION,
>> +	CORES,
>> +	MEMORY,
>> +	STORAGE,
>> +
>> +	/* Up to 10 storage devices... Should be enough for anyone right? */
>> +	_LAST_LINE = (STORAGE + 10),
>> +#define LAST_LINE (_LAST_LINE - 1UL)
>> +};
>> +
>> +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>> +		     char *const argv[])
>> +{
>> +	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>> +	const char *model, *compatible;
>> +	char *ipaddr;
>> +	int n_cmds, n_cpus = 0, ret, compatlen;
>> +	ofnode np;
>> +	struct mmc *mmc;
>> +	struct blk_desc *scsi_desc;
>> +	bool skip_ascii = false;
>> +
>> +	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
>> +		skip_ascii = true;
>> +		num_lines = LAST_LINE;
>> +	}
>> +
>> +	for (int i = 0; i < num_lines; i++) {
>> +		if (!skip_ascii) {
>> +			if (i < ARRAY_SIZE(logo_lines))
>> +				printf("%s ", logo_lines[i]);
>> +			else
>> +				printf("%*c ", LINE_WIDTH, ' ');
>> +		}
>> +		switch (i) {
>> +		case FIRST:
>> +			compatible = ofnode_read_string(ofnode_root(), "compatible");
>> +			if (!compatible)
>> +				compatible = "unknown";
>> +			printf(RESET "%s\n", compatible);
>> +			compatlen = strlen(compatible);
>> +			break;
>> +		case SECOND:
>> +			for (int j = 0; j < compatlen; j++)
>> +				putc('-');
>> +			putc('\n');
>> +			break;
>> +		case KERNEL:
> 
> Please, do not use misleading variable names.

it is meant to be a little satirical, but I get it.
> 
> 
>> +			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
>> +			break;
>> +		case SYSINFO:
>> +			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
>> +			break;
>> +		case HOST:
>> +			model = ofnode_read_string(ofnode_root(), "model");
>> +			if (model)
>> +				printf("Host:" RESET " %s\n", model);
>> +			break;
>> +		case UPTIME:
>> +			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
>> +			break;
>> +		case IP:
>> +			ipaddr = env_get("ipvaddr");
>> +			if (!ipaddr)
>> +				ipaddr = "none";
>> +			printf("IP Address:" RESET " %s", ipaddr);
>> +			ipaddr = env_get("ipv6addr");
>> +			if (ipaddr)
>> +				printf(", %s\n", ipaddr);
>> +			else
>> +				putc('\n');
>> +			break;
>> +		case CMDS:
>> +			n_cmds = ll_entry_count(struct cmd_tbl, cmd);
> 
> Who cares if you have 50 commands or 51 if you don't know which?

This is a play on the neofetch "packages" counter.
> 
> 
>> +			printf("Commands:" RESET " %d (help)\n", n_cmds);
>> +			break;
>> +		case CONSOLES:
>> +			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
>> +			       gd->baudrate);
>> +			break;
>> +		case DEVICES:
>> +			printf("Devices:" RESET " ");
>> +			/* TODO: walk the DM tree */
>> +			printf("Uncountable!\n");
> 
> Nothing we should merge.
> 
>> +			break;
>> +		case FEATURES:
>> +			printf("Features:" RESET " ");
>> +			if (IS_ENABLED(CONFIG_NET))
>> +				printf("Net");
> 
> Wouuldn't you want to know which devices where detected?
> 
>> +			if (IS_ENABLED(CONFIG_EFI_LOADER))
>> +				printf(", EFI");
>> +			printf("\n");
>> +			break;
>> +		case RELOCATION:
>> +			if (gd->flags & GD_FLG_SKIP_RELOC)
>> +				printf("Relocated:" RESET " no\n");
>> +			else
>> +				printf("Relocated:" RESET " to %#09lx\n", gd->relocaddr);
>> +			break;
>> +		case CORES:
>> +			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
>> +				if (ofnode_name_eq(np, "cpu"))
>> +					n_cpus++;
>> +			}
>> +			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
>> +			break;
>> +		case MEMORY:
>> +			printf("Memory:" RESET " %lu MB\n", (ulong)gd->ram_size >> 20);
>> +			break;
>> +		case STORAGE:
>> +		default:
>> +			if (i == STORAGE && get_mmc_num() > 0) {
>> +				mmc = find_mmc_device(0);
>> +				if (mmc)
>> +					printf("Storage:" RESET "  mmc 0: %llu MB", mmc->capacity >> 20);
> 
> And if my eMMC is device 1 and SD card is 0?
> 
> Why wouldn't you iterate over all UCLASS_BLK devices?
> 
> Best regards
> 
> Heinrich
> 
>> +			}
>> +			if (i >= STORAGE + 1) {
>> +				ret = blk_get_desc(UCLASS_SCSI, i - (STORAGE + 1), &scsi_desc);
>> +				if (!ret && scsi_desc->type != DEV_TYPE_UNKNOWN)
>> +					/* The calculation here is really lossy but close enough */
>> +					printf("Storage:" RESET " scsi %d: %lu MB", i - (STORAGE + 1),
>> +					       ((scsi_desc->lba >> 9) * scsi_desc->blksz) >> 11);
>> +			}
>> +			printf("\n");
>> +		}
>> +	}
>> +
>> +	printf(RESET "\n\n");
>> +
>> +	return 0;
>> +}
>> +
>> +U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
>> +	"U-Boot fetch utility",
>> +	"Print information about your device.\n"
>> +	"    -n    Don't print the ASCII logo"
>> +);

-- 
// Caleb (they/them)
