Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22EDC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096FC88B07;
	Fri,  9 Aug 2024 20:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aXDtsHHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E146A88B07; Fri,  9 Aug 2024 20:35:12 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85CF8895D
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b78c980981so13168346d6.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723228509; x=1723833309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dYzNqJ9BBIJ6Hkl4bEJuP3kuHE+Xp2sqR2oFLyVG52s=;
 b=aXDtsHHqW7c8GieehhMGp17vNADorfdwzMoZCwgX3+ga1OxyJ/fazFZ7aCyhu3cl3r
 WWInT+CyhXm1+mk0mF6UsKNzaE3F9MjT3ResedIfwyGomG788IChZ0XUTJVoDO1PEqfZ
 WGNMlFRKEoHIYhd5IX1U+PfDgQqgRLP73vXM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723228509; x=1723833309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYzNqJ9BBIJ6Hkl4bEJuP3kuHE+Xp2sqR2oFLyVG52s=;
 b=gLMNW9lqItGm23gJ/VnBTOPMbpChGj1OX/c7V0seqh7+BDzdqrQz1XjpIxYG07SsQU
 F1wHkEEyjGnGs16KirPCidrVVyqDwBgGmZgDEwNIhPdcY2RWDVJL3obRQYFju/iw0L8+
 av3dyz0AsmjsYdu3zxEP1N0i3WH/a9Du1KtJ2ThHQf42SO05VEPf/Dgyw8yjBvsgDMjx
 DMA+i27HBhSbWKY6J4Z/s9bLy9e78BJk6NCcNtFuVSWy+XkjSTKBSI1slsUlgYJCpAGi
 dqHiwXednlRikREstNAsiKVXl0q4XdcqdjVSc+FbgZG3DL4Kc3oizok1PzgcLkBPea4u
 cWIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/NhhTAbBh/iM5Mo8j2kfBjCX455/M6QbuQWuc1jeEy1KLA//SrIu+Zf4T/miJgB6tfp2HLPHLDeqlHzaGRqmf+WL3Dw==
X-Gm-Message-State: AOJu0YzZPkWKiLamDjqQYCRMxs4MKY1maUTjQhk647+SlkE4i77r9Qtb
 fU0l6BHDtS/RVAoTycfUwjguVPzMrhFwgvxNG9V4OrLa6dWtoFWPrr4SgUKdBgx9VDTxY+53VD2
 2LPngOo6RB5mrpk1vlrOgzqG3uwnnqUmX2jhB
X-Google-Smtp-Source: AGHT+IHlUr2P4qFSRaTEIA3lCSGcSgjQdPJP4DHG3KvbEwaXEE8wfxA+IEnwAegTxeOmblCgS03IceU6/tE1fteA++Q=
X-Received: by 2002:a05:6214:5c49:b0:6b7:9a1c:713b with SMTP id
 6a1803df08f44-6bd78e47196mr29215796d6.35.1723228508638; Fri, 09 Aug 2024
 11:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
 <CAFLszTjVOgUsjwthBNkn5LgoSRmA7iT4rPy80Gbji1=OZG7nTw@mail.gmail.com>
 <f2385971-cc48-4cc1-9857-d74b09f41338@linaro.org>
In-Reply-To: <f2385971-cc48-4cc1-9857-d74b09f41338@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 12:34:57 -0600
Message-ID: <CAFLszTgD1rh+v5_JzB-_GAEHRsY6AUbQcPQOUhzQ_mNfE3kMsA@mail.gmail.com>
Subject: Re: [PATCH] cmd: add a fetch utility
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Caleb,

On Fri, 9 Aug 2024 at 11:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 09/08/2024 03:55, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Thu, 8 Aug 2024 at 10:32, Caleb Connolly <caleb.connolly@linaro.org
> > <mailto:caleb.connolly@linaro.org>> wrote:
> >  >
> >  > While U-Boot does a pretty good job at printing information at startup
> >  > about what hardware it's running on, it can be hard to take pretty
> >  > pictures of this to show off on the internet (by far the most
> >  > important aspect of porting a device in 2024!).
> >  >
> >  > Add a small utility "ufetch" for displaying some information about
> > U-Boot and
> >  > the hardware it's running on in a similar fashion to the popular
> > neofetch tool
> >  > for *nix's [1].
> >  >
> >  > While the output is meant to be useful, it should also be pleasing to
> > look at
> >  > and look good in screenshots. The ufetch command brings this to U-Boot,
> >  > featuring a colorful ASCII art version of the U-Boot logo and a fancy
> > layout.
> >  >
> >  > Finally, tireless device porters can properly show off their hard
> > work and get
> >  > the internet points they so deserve!
> >  >
> >  > Not everything is fully supported yet, but this seemed good enough
> > for initial
> >  > inclusion. Only one MMC device is detected, and other than SCSI other
> > storage
> >  > devices aren't supported.
> >  >
> >  > [1]: https://en.wikipedia.org/wiki/Neofetch
> > <https://en.wikipedia.org/wiki/Neofetch>
> >  >
> >  > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org
> > <mailto:caleb.connolly@linaro.org>>
> >  > ---
> >  > Ephemeral demo image: https://0x0.st/XVUa.png <https://0x0.st/XVUa.png>
> >  > ---
> >  >  cmd/Kconfig  |   7 ++
> >  >  cmd/Makefile |   1 +
> >  >  cmd/ufetch.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  >  3 files changed, 209 insertions(+)
> >  >  create mode 100644 cmd/ufetch.c
> >
> > Very cute!
> >
> >  >
> >  > diff --git a/cmd/Kconfig b/cmd/Kconfig
> >  > index 978f44eda426..70acb5727b04 100644
> >  > --- a/cmd/Kconfig
> >  > +++ b/cmd/Kconfig
> >  > @@ -175,8 +175,15 @@ config CMD_CPU
> >  >           number of CPUs, type (e.g. manufacturer, architecture,
> > product or
> >  >           internal name) and clock frequency. Other information may be
> >  >           available depending on the CPU driver.
> >  >
> >  > +config CMD_UFETCH
> >  > +       bool "U-Boot fetch"
> >
> > How about default y if SANDBOX so that this gets built for that. You
> > should also add doc/ and test/ for the command (although the test can be
> > very basic).
>
> I was really aiming for cmd/2048.c levels of expectation and usability
> here, not to make this a rugged part of U-Boot's feature set (if someone
> else would like to go the extra mile they're certainly welcome to).
>
> Making it default y for sandbox so we can at least make sure it compiles
> sounds reasonable though.
> >
> >  > +       depends on BLK
> >  > +       help
> >  > +         Fetch utility for U-Boot (akin to neofetch). Prints information
> >  > +         about U-Boot and the board it is running on in a pleasing
> > format.
> >  > +
> >  >  config CMD_FWU_METADATA
> >  >         bool "fwu metadata read"
> >  >         depends on FWU_MULTI_BANK_UPDATE
> >  >         help
> >  > diff --git a/cmd/Makefile b/cmd/Makefile
> >  > index 87133cc27a8a..ffb04c8f2e0a 100644
> >  > --- a/cmd/Makefile
> >  > +++ b/cmd/Makefile
> >  > @@ -53,8 +53,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
> >  >  obj-$(CONFIG_CMD_CPU) += cpu.o
> >  >  obj-$(CONFIG_CMD_DATE) += date.o
> >  >  obj-$(CONFIG_CMD_DEMO) += demo.o
> >  >  obj-$(CONFIG_CMD_DM) += dm.o
> >  > +obj-$(CONFIG_CMD_UFETCH) += ufetch.o
> >  >  obj-$(CONFIG_CMD_SOUND) += sound.o
> >  >  ifdef CONFIG_POST
> >  >  obj-$(CONFIG_CMD_DIAG) += diag.o
> >  >  endif
> >  > diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> >  > new file mode 100644
> >  > index 000000000000..f7374eb2e364
> >  > --- /dev/null
> >  > +++ b/cmd/ufetch.c
> >  > @@ -0,0 +1,201 @@
> >  > +// SPDX-License-Identifier: GPL-2.0
> >  > +
> >  > +/* Small "fetch" utility for U-Boot */
> >
> > Isn't it a command, rather than a utility? I think of a utility as a
> > program I run.
>
> I feel like you could ask 5 different people about this and get 5
> different answers. As a native british english speaker I would view
> "utilities" as a subset of "commands" in this context. This isn't a high
> effort contribution for me so I'm really fine with whatever.

OK I see, fair enough.

> >
> >  > +
> >  > +#include <mmc.h>
> >  > +#include <time.h>
> >  > +#include <asm/global_data.h>
> >  > +#include <cli.h>
> >  > +#include <command.h>
> >  > +#include <dm/ofnode.h>
> >  > +#include <env.h>
> >  > +#include <rand.h>
> >  > +#include <vsprintf.h>
> >  > +#include <linux/delay.h>
> >  > +#include <linux/kernel.h>
> >  > +#include <version.h>
> >
> > Please check [1]
>
> Sure, I'll order these alphabetically.
> >
> >  > +
> >  > +DECLARE_GLOBAL_DATA_PTR;
> >  > +
> >  > +#define LINE_WIDTH 40
> >  > +#define BLUE "\033[38;5;4m"
> >  > +#define YELLOW "\033[38;5;11m"
> >  > +#define BOLD "\033[1m"
> >  > +#define RESET "\033[0m"
> >  > +static const char *logo_lines[] = {
> >  > +       BLUE BOLD "                  ......::......                   ",
> >  > +       BLUE BOLD "             ...::::::::::::::::::...              ",
> >  > +       BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> >  > +       BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
> >  > +       BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
> >  > +       BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE
> > "::::::::::.::.     ",
> >  > +       BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE
> > ":....::::::::::.    ",
> >  > +       BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-"
> > BLUE "::::::::::.:.   ",
> >  > +       BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-"
> > BLUE "...::::::.:.  ",
> >  > +       BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW
> > "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
> >  > +       BLUE BOLD ".:.::-" YELLOW
> > "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
> >  > +       BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW
> > "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
> >  > +       BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW
> > "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
> >  > +       BLUE BOLD ".::" YELLOW
> > "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
> >  > +       BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW
> > "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
> >  > +       BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW
> > "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
> >  > +       BLUE BOLD " ..::-" YELLOW
> > "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
> >  > +       BLUE BOLD "  ...:=" YELLOW "*****=" BLUE
> > "::-\033[38;5;7m=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
> >  > +       BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
> >  > +       BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
> >  > +       BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
> >  > +       BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
> >  > +       BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> >  > +       BLUE BOLD "             ...::::::::::::::::::...              ",
> >  > +       BLUE BOLD "                  ......::......                   ",
> >  > +};
> >  > +
> >  > +enum output_lines {
> >  > +       FIRST,
> >  > +       SECOND,
> >  > +       KERNEL,
> >  > +       SYSINFO,
> >  > +       HOST,
> >  > +       UPTIME,
> >  > +       IP,
> >  > +       CMDS,
> >  > +       CONSOLES,
> >  > +       DEVICES,
> >  > +       FEATURES,
> >  > +       RELOCATION,
> >  > +       CORES,
> >  > +       MEMORY,
> >  > +       STORAGE,
> >  > +
> >  > +       /* Up to 10 storage devices... Should be enough for anyone
> > right? */
> >  > +       _LAST_LINE = (STORAGE + 10),
> >  > +#define LAST_LINE (_LAST_LINE - 1UL)
> >  > +};
> >  > +
> >  > +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> >  > +                    char *const argv[])
> >  > +{
> >  > +       int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
> >  > +       const char *model, *compatible;
> >  > +       char *ipaddr;
> >  > +       int n_cmds, n_cpus = 0, ret, compatlen;
> >  > +       ofnode np;
> >  > +       struct mmc *mmc;
> >  > +       struct blk_desc *scsi_desc;
> >  > +       bool skip_ascii = false;
> >  > +
> >  > +       if (argc > 1 && strcmp(argv[1], "-n") == 0) {
> >  > +               skip_ascii = true;
> >  > +               num_lines = LAST_LINE;
> >  > +       }
> >  > +
> >  > +       for (int i = 0; i < num_lines; i++) {
> >  > +               if (!skip_ascii) {
> >  > +                       if (i < ARRAY_SIZE(logo_lines))
> >  > +                               printf("%s ", logo_lines[i]);
> >  > +                       else
> >  > +                               printf("%*c ", LINE_WIDTH, ' ');
> >  > +               }
> >  > +               switch (i) {
> >  > +               case FIRST:
> >  > +                       compatible =
> > ofnode_read_string(ofnode_root(), "compatible");
> >  > +                       if (!compatible)
> >  > +                               compatible = "unknown";
> >  > +                       printf(RESET "%s\n", compatible);
> >  > +                       compatlen = strlen(compatible);
> >  > +                       break;
> >  > +               case SECOND:
> >  > +                       for (int j = 0; j < compatlen; j++)
> >  > +                               putc('-');
> >  > +                       putc('\n');
> >  > +                       break;
> >  > +               case KERNEL:
> >  > +                       printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
> >  > +                       break;
> >  > +               case SYSINFO:
> >  > +                       printf("Config:" RESET " %s_defconfig\n",
> > CONFIG_SYS_CONFIG_NAME);
> >  > +                       break;
> >  > +               case HOST:
> >  > +                       model = ofnode_read_string(ofnode_root(),
> > "model");
> >  > +                       if (model)
> >  > +                               printf("Host:" RESET " %s\n", model);
> >  > +                       break;
> >  > +               case UPTIME:
> >  > +                       printf("Uptime:" RESET " %ld seconds\n",
> > get_timer(0) / 1000);
> >  > +                       break;
> >  > +               case IP:
> >  > +                       ipaddr = env_get("ipvaddr");
> >  > +                       if (!ipaddr)
> >  > +                               ipaddr = "none";
> >  > +                       printf("IP Address:" RESET " %s", ipaddr);
> >  > +                       ipaddr = env_get("ipv6addr");
> >  > +                       if (ipaddr)
> >  > +                               printf(", %s\n", ipaddr);
> >  > +                       else
> >  > +                               putc('\n');
> >  > +                       break;
> >  > +               case CMDS:
> >  > +                       n_cmds = ll_entry_count(struct cmd_tbl, cmd);
> >  > +                       printf("Commands:" RESET " %d (help)\n", n_cmds);
> >  > +                       break;
> >  > +               case CONSOLES:
> >  > +                       printf("Consoles:" RESET " %s (%d baud)\n",
> > env_get("stdout"),
> >  > +                              gd->baudrate);
> >  > +                       break;
> >  > +               case DEVICES:
> >  > +                       printf("Devices:" RESET " ");
> >  > +                       /* TODO: walk the DM tree */
> >  > +                       printf("Uncountable!\n");
> >
> > See dm_announce() for how to do that.
> >
> >  > +                       break;
> >  > +               case FEATURES:
> >  > +                       printf("Features:" RESET " ");
> >  > +                       if (IS_ENABLED(CONFIG_NET))
> >  > +                               printf("Net");
> >  > +                       if (IS_ENABLED(CONFIG_EFI_LOADER))
> >  > +                               printf(", EFI");
> >
> > How about EFI_LOADER ? After all, U-Boot can run as an EFI app so 'EFI'
> > might be better reserved for that.
> >
> >  > +                       printf("\n");
> >  > +                       break;
> >  > +               case RELOCATION:
> >  > +                       if (gd->flags & GD_FLG_SKIP_RELOC)
> >  > +                               printf("Relocated:" RESET " no\n");
> >  > +                       else
> >  > +                               printf("Relocated:" RESET " to
> > %#09lx\n", gd->relocaddr);
> >
> > Not for this patch but I'd really like to figure out a way to
> > enable/disable ANSI codes globally in U-Boot. For example, we should
> > disable them in tests, or when redirecting sandbox to a file. It affects
> > EFI tests too...so if you have any ideas... :-)
>
> Only thing that comes to mind would be adding a compile time flag to
> printf which teaches it to parse and skip ANSI escape codes.

Ideally it would have the option to be run-time, if we want to pay an
extra penalty. Then we can use the same sandbox build with tests as we
do for normal usage.

> >
> >  > +                       break;
> >  > +               case CORES:
> >  > +                       ofnode_for_each_subnode(np,
> > ofnode_path("/cpus")) {
> >  > +                               if (ofnode_name_eq(np, "cpu"))
> >  > +                                       n_cpus++;
> >  > +                       }
> >
> > uclass_id_count(UCLASS_CPU)
> >
> >  > +                       printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> >  > +                       break;
> >  > +               case MEMORY:
> >  > +                       printf("Memory:" RESET " %lu MB\n",
> > (ulong)gd->ram_size >> 20);
> >  > +                       break;
> >  > +               case STORAGE:
> >  > +               default:
> >  > +                       if (i == STORAGE && get_mmc_num() > 0) {
> >  > +                               mmc = find_mmc_device(0);
> >  > +                               if (mmc)
> >  > +                                       printf("Storage:" RESET "
> > mmc 0: %llu MB", mmc->capacity >> 20);
> >  > +                       }
> >
> > How about iterating through UCLASS_BLK ?
>
> Probably a much more sensible approach tbh, can you easily determine the
> size of a block device?

You can do something like this:

struct udevice *dev;   // block device
struct blk_desc *desc = dev_get_uclass_plat(dev);

size = desc->lba * desc->blksz

> >
> >  > +                       if (i >= STORAGE + 1) {
> >  > +                               ret = blk_get_desc(UCLASS_SCSI, i -
> > (STORAGE + 1), &scsi_desc);
> >  > +                               if (!ret && scsi_desc->type !=
> > DEV_TYPE_UNKNOWN)
> >  > +                                       /* The calculation here is
> > really lossy but close enough */
> >  > +                                       printf("Storage:" RESET "
> > scsi %d: %lu MB", i - (STORAGE + 1),
> >  > +                                              ((scsi_desc->lba >> 9)
> > * scsi_desc->blksz) >> 11);
> >
> > You can use print_size() - and same above I suppose
>
> haha yeahp i should really do that instead.
>
> Thanks for the review!
> >
> >  > +                       }
> >  > +                       printf("\n");
> >  > +               }
> >  > +       }
> >  > +
> >  > +       printf(RESET "\n\n");
> >  > +
> >  > +       return 0;
> >  > +}
> >  > +
> >  > +U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
> >  > +       "U-Boot fetch utility",
> >  > +       "Print information about your device.\n"
> >  > +       "    -n    Don't print the ASCII logo"
> >  > +);
> >  > --
> >  > 2.46.0
> >

> >
> > [1]
> > https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
> > <https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files>


Regards,
Simon
