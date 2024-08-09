Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD524C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 06:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0B588732;
	Fri,  9 Aug 2024 08:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Gv6x1ES5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88ED988770; Fri,  9 Aug 2024 08:18:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E7C886FD
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 08:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723184329; x=1723789129; i=xypron.glpk@gmx.de;
 bh=jHT0UxIxmdCNgvDHpjQ4vGAjFoZ0YhDQWX4cC10fRik=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Gv6x1ES5Po+nJWpJCef+1QdlMxasHIbo9ny8xXla0oGKFKvFGG23POMvcdeuXenA
 Wxh8bxwkUD4pXK+oCRPoHOrV1lK/Vwegs2i7cB+uBzOTSzzBocRmF9RczS/W+Smq/
 LwHnMglzR2Wew8SUJCN2SCSNYIH3zDZaqtcpztf7vCFz4XTphIaRK6fqa4SJtZAjf
 vnPPxZe50WEP09vgiYtXktWvDZdfDsdKvWL/2En9MMF/5yMby+D8GOD+IHElOB2h2
 0AZCjeFzrs7897F7LJais8qSVvgPHoZmSh0k2OkFhhFiY2Kw4Jzcp8L0rdPnccF14
 wwsKNk7X2v5QwXI2mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.164.168]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1sMZST2aU5-00uOVc; Fri, 09
 Aug 2024 08:18:49 +0200
Date: Fri, 09 Aug 2024 08:18:43 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
CC: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: add a fetch utility
User-Agent: K-9 Mail for Android
In-Reply-To: <20240808163153.2069650-1-caleb.connolly@linaro.org>
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
Message-ID: <0194AFA0-5D56-46F8-A385-D23AF7CDDD43@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9z++ORWBYYhhDn9Wzr3udnwlpuvoWtQ8j5rc+9/uNUslFmyJ8wr
 CYrbNuOKye6EcqPFFugXbn9dvIfgP2a219G9tLC28rQt4GQemm+MS83mm1C/htby6SejiFu
 CB90fqcjh1StkPL57NjTl/gt2qEwfuwNjugrzWo/Djxm+kD0A4OF3Sm9I2J2j/FBOWIQrk8
 CoL3qpiqsqsnHTg5XP5dA==
UI-OutboundReport: notjunk:1;M01:P0:Tyv/0Y8O6bc=;veBsTmtsRRI5icuDb3SEhGCjpD6
 jicGne8wQlZD+S/61IbcfXyG4lXC+6s0m5kvCupnfvBLnZulW/34YAnB0cyQzYyiudCO0UzW5
 74zkqJUo/6dCmQfuoxqofLjx4wby5kKEYy97TkSmmsLOPBEMilW+gy0HDfi+KtEpXBoAioqnF
 23qlPS2sJ8OvPH/Rpi9Z4zC3+6m4oLS8BIoSbIbL4fmeiEGx18ceDcUKA2nHHkPtGhloS5rpS
 mwkBjd6B2VWBDo7IJmV2jAzUkALe+0coS2+BYRzESiXYTsgERZ+pz0mRhSzdDnJp0vV/4RFwf
 ixoK43u8poAuSO6v7Wim9folMCVSRC19W33IIjVjqRRz5R3rZbYLJ+eXRnNM8Y2GIr9WJkK3g
 o/s9/wvOuQ0rHeyEzIhKitq12bxct4bj9WrMpAni+bb/ZrB/wtatuRShiFYFZbcV4WJi9ZLAD
 YLnjIU8Sg2oWyIxSZ1VZF520aQerdm/5yPpNQ4Ksfagt2n/sFQaJcdVtZIMPBdZ2lTp2AQ/zD
 CaF0YazaLIXHJaXRhhJHudDeZMCyhrYQxDH3lWFUB7PevuD9inn9FTUjeTne4uGHYQ9rokkZo
 TUCpXPs6MX5Gw84h5c5W5H9l1R9CyztCB2RF36EGyt+/jwIUFtIQ6JwQO5afYTKBsnPtgRf2e
 7C9+CgzkFyPXrHWu7kqpJxHR0+OZUEqkU3goRurMeorYb//KZnJoqgxo5L/MZSDuAjZ2n7Tlb
 Ra107ceBBBYpz43lLkHM8y/zsAzLyeWoJOvI+9t0ITU1cVSedHiGFw3JzOKH270/xsvHNW5eL
 YgXRHzv5o7CO/IjxhP4O29rZz0NClksZEAAHBPIafqsGEUopGq6SHyrkco5sWWlNTXm9wRikI
 qFLyWAXfE/ops8A==
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



Am 8=2E August 2024 18:24:24 MESZ schrieb Caleb Connolly <caleb=2Econnolly=
@linaro=2Eorg>:
>While U-Boot does a pretty good job at printing information at startup
>about what hardware it's running on, it can be hard to take pretty
>pictures of this to show off on the internet (by far the most
>important aspect of porting a device in 2024!)=2E
>
>Add a small utility "ufetch" for displaying some information about U-Boot=
 and
>the hardware it's running on in a similar fashion to the popular neofetch=
 tool
>for *nix's [1]=2E
>
>While the output is meant to be useful, it should also be pleasing to loo=
k at
>and look good in screenshots=2E The ufetch command brings this to U-Boot,
>featuring a colorful ASCII art version of the U-Boot logo and a fancy lay=
out=2E
>
>Finally, tireless device porters can properly show off their hard work an=
d get
>the internet points they so deserve!
>
>Not everything is fully supported yet, but this seemed good enough for in=
itial
>inclusion=2E Only one MMC device is detected, and other than SCSI other s=
torage
>devices aren't supported=2E


This command is not very generic=2E E=2Eg=2E it supports SCSI drives but n=
ot SATA=2E Many boards have eMMC and SD-card=2E This lks more ike an RFC ta=
n something ready to merge=2E

Why don't you use a script or an EFI program to print whatever information=
 you need?

>
>[1]: https://en=2Ewikipedia=2Eorg/wiki/Neofetch
>
>Signed-off-by: Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>---
>Ephemeral demo image: https://0x0=2Est/XVUa=2Epng
>---
> cmd/Kconfig  |   7 ++
> cmd/Makefile |   1 +
> cmd/ufetch=2Ec | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 209 insertions(+)
> create mode 100644 cmd/ufetch=2Ec
>
>diff --git a/cmd/Kconfig b/cmd/Kconfig
>index 978f44eda426=2E=2E70acb5727b04 100644
>--- a/cmd/Kconfig
>+++ b/cmd/Kconfig
>@@ -175,8 +175,15 @@ config CMD_CPU
> 	  number of CPUs, type (e=2Eg=2E manufacturer, architecture, product or
> 	  internal name) and clock frequency=2E Other information may be
> 	  available depending on the CPU driver=2E
>=20
>+config CMD_UFETCH
>+	bool "U-Boot fetch"
>+	depends on BLK
>+	help
>+	  Fetch utility for U-Boot (akin to neofetch)=2E Prints information
>+	  about U-Boot and the board it is running on in a pleasing format=2E
>+
> config CMD_FWU_METADATA
> 	bool "fwu metadata read"
> 	depends on FWU_MULTI_BANK_UPDATE
> 	help
>diff --git a/cmd/Makefile b/cmd/Makefile
>index 87133cc27a8a=2E=2Effb04c8f2e0a 100644
>--- a/cmd/Makefile
>+++ b/cmd/Makefile
>@@ -53,8 +53,9 @@ obj-$(CONFIG_CMD_CONSOLE) +=3D console=2Eo
> obj-$(CONFIG_CMD_CPU) +=3D cpu=2Eo
> obj-$(CONFIG_CMD_DATE) +=3D date=2Eo
> obj-$(CONFIG_CMD_DEMO) +=3D demo=2Eo
> obj-$(CONFIG_CMD_DM) +=3D dm=2Eo
>+obj-$(CONFIG_CMD_UFETCH) +=3D ufetch=2Eo
> obj-$(CONFIG_CMD_SOUND) +=3D sound=2Eo
> ifdef CONFIG_POST
> obj-$(CONFIG_CMD_DIAG) +=3D diag=2Eo
> endif
>diff --git a/cmd/ufetch=2Ec b/cmd/ufetch=2Ec
>new file mode 100644
>index 000000000000=2E=2Ef7374eb2e364
>--- /dev/null
>+++ b/cmd/ufetch=2Ec
>@@ -0,0 +1,201 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+
>+/* Small "fetch" utility for U-Boot */
>+
>+#include <mmc=2Eh>
>+#include <time=2Eh>
>+#include <asm/global_data=2Eh>
>+#include <cli=2Eh>
>+#include <command=2Eh>
>+#include <dm/ofnode=2Eh>
>+#include <env=2Eh>
>+#include <rand=2Eh>
>+#include <vsprintf=2Eh>
>+#include <linux/delay=2Eh>
>+#include <linux/kernel=2Eh>
>+#include <version=2Eh>
>+
>+DECLARE_GLOBAL_DATA_PTR;
>+
>+#define LINE_WIDTH 40
>+#define BLUE "\033[38;5;4m"
>+#define YELLOW "\033[38;5;11m"
>+#define BOLD "\033[1m"
>+#define RESET "\033[0m"
>+static const char *logo_lines[] =3D {
>+	BLUE BOLD "                  =2E=2E=2E=2E=2E=2E::=2E=2E=2E=2E=2E=2E    =
               ",
>+	BLUE BOLD "             =2E=2E=2E::::::::::::::::::=2E=2E=2E           =
   ",
>+	BLUE BOLD "          =2E=2E::::::::::::::::::::::::::=2E=2E           "=
,
>+	BLUE BOLD "        =2E::::=2E:::::::::::::::=2E=2E=2E::::=2E::::=2E    =
     ",
>+	BLUE BOLD "      =2E::::::::::::::::::::=2E=2E::::::::::::::=2E       "=
,
>+	BLUE BOLD "    =2E::=2E:::::::::::::::::::" YELLOW "=3D*%#*" BLUE "::::=
::::::=2E::=2E     ",
>+	BLUE BOLD "   =2E:::::::::::::::::=2E=2E=2E=2E=2E" YELLOW "*%%*-" BLUE =
":=2E=2E=2E=2E::::::::::=2E    ",
>+	BLUE BOLD "  =2E:=2E:::=2E=2E=2E:::::::::=2E:-" YELLOW "=3D=3D=3D##*---=
=3D=3D-" BLUE "::::::::::=2E:=2E   ",
>+	BLUE BOLD " =2E::::=2E=2E::::=2E=2E=2E=2E=2E=2E=2E=2E" YELLOW "-***#***=
*###****-" BLUE "=2E=2E=2E::::::=2E:=2E  ",
>+	BLUE BOLD " ::=2E:=2E-" YELLOW "+***+=3D" BLUE "::-" YELLOW "=3D+**#%%%=
%%%%%%%%%###*=3D " BLUE "-::=2E=2E=2E::::=2E ",
>+	BLUE BOLD "=2E:=2E::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=3D"=
 BLUE ":=2E=2E:::: ",
>+	BLUE BOLD "=2E::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%##=
##%%%%%####%%%*" BLUE "-=2E::=2E ",
>+	BLUE BOLD ":=2E:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#***=
**##%%##*****#%%+" BLUE "=2E::=2E",
>+	BLUE BOLD "=2E::" YELLOW "**=3D=3D#%%%%%%%##****#%%%%##****#%%%%#****##=
#%%" BLUE ":=2E=2E ",
>+	BLUE BOLD "=2E=2E:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%=
%%%%%%%%%%%%#%%%%%+ " BLUE "=2E:=2E",
>+	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%=
%%%%%%%%%%%%* " BLUE "-=2E:: ",
>+	BLUE BOLD " =2E=2E::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=3D"=
 BLUE "-=2E=2E::=2E  ",
>+	BLUE BOLD "  =2E=2E=2E:=3D" YELLOW "*****=3D" BLUE "::-\033[38;5;7m=3D+=
**###%%%%%%%%###**+=3D  " BLUE "--:=2E=2E=2E:::  ",
>+	BLUE BOLD "   =2E::=2E::--:=2E=2E=2E=2E=2E=2E=2E=2E::::::--::::::=2E=2E=
=2E=2E=2E=2E::::::=2E    ",
>+	BLUE BOLD "    =2E::=2E=2E=2E=2E=2E::::::::::=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E:::::::::=2E::=2E     ",
>+	BLUE BOLD "      =2E::::::::::::::::::::::::::::::::::::=2E       ",
>+	BLUE BOLD "        =2E::::=2E::::::::::::::::::::::=2E::::=2E         "=
,
>+	BLUE BOLD "          =2E=2E::::::::::::::::::::::::::=2E=2E           "=
,
>+	BLUE BOLD "             =2E=2E=2E::::::::::::::::::=2E=2E=2E           =
   ",
>+	BLUE BOLD "                  =2E=2E=2E=2E=2E=2E::=2E=2E=2E=2E=2E=2E    =
               ",
>+};
>+
>+enum output_lines {
>+	FIRST,
>+	SECOND,
>+	KERNEL,
>+	SYSINFO,
>+	HOST,
>+	UPTIME,
>+	IP,
>+	CMDS,
>+	CONSOLES,
>+	DEVICES,
>+	FEATURES,
>+	RELOCATION,
>+	CORES,
>+	MEMORY,
>+	STORAGE,
>+
>+	/* Up to 10 storage devices=2E=2E=2E Should be enough for anyone right?=
 */
>+	_LAST_LINE =3D (STORAGE + 10),
>+#define LAST_LINE (_LAST_LINE - 1UL)
>+};
>+
>+static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>+		     char *const argv[])
>+{
>+	int num_lines =3D max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>+	const char *model, *compatible;
>+	char *ipaddr;
>+	int n_cmds, n_cpus =3D 0, ret, compatlen;
>+	ofnode np;
>+	struct mmc *mmc;
>+	struct blk_desc *scsi_desc;
>+	bool skip_ascii =3D false;
>+
>+	if (argc > 1 && strcmp(argv[1], "-n") =3D=3D 0) {
>+		skip_ascii =3D true;
>+		num_lines =3D LAST_LINE;
>+	}
>+
>+	for (int i =3D 0; i < num_lines; i++) {
>+		if (!skip_ascii) {
>+			if (i < ARRAY_SIZE(logo_lines))
>+				printf("%s ", logo_lines[i]);
>+			else
>+				printf("%*c ", LINE_WIDTH, ' ');
>+		}
>+		switch (i) {
>+		case FIRST:
>+			compatible =3D ofnode_read_string(ofnode_root(), "compatible");
>+			if (!compatible)
>+				compatible =3D "unknown";
>+			printf(RESET "%s\n", compatible);
>+			compatlen =3D strlen(compatible);
>+			break;
>+		case SECOND:
>+			for (int j =3D 0; j < compatlen; j++)
>+				putc('-');
>+			putc('\n');
>+			break;
>+		case KERNEL:

Please, do not use misleading variable names=2E


>+			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
>+			break;
>+		case SYSINFO:
>+			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
>+			break;
>+		case HOST:
>+			model =3D ofnode_read_string(ofnode_root(), "model");
>+			if (model)
>+				printf("Host:" RESET " %s\n", model);
>+			break;
>+		case UPTIME:
>+			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
>+			break;
>+		case IP:
>+			ipaddr =3D env_get("ipvaddr");
>+			if (!ipaddr)
>+				ipaddr =3D "none";
>+			printf("IP Address:" RESET " %s", ipaddr);
>+			ipaddr =3D env_get("ipv6addr");
>+			if (ipaddr)
>+				printf(", %s\n", ipaddr);
>+			else
>+				putc('\n');
>+			break;
>+		case CMDS:
>+			n_cmds =3D ll_entry_count(struct cmd_tbl, cmd);

Who cares if you have 50 commands or 51 if you don't know which?


>+			printf("Commands:" RESET " %d (help)\n", n_cmds);
>+			break;
>+		case CONSOLES:
>+			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
>+			       gd->baudrate);
>+			break;
>+		case DEVICES:
>+			printf("Devices:" RESET " ");
>+			/* TODO: walk the DM tree */
>+			printf("Uncountable!\n");

Nothing we should merge=2E

>+			break;
>+		case FEATURES:
>+			printf("Features:" RESET " ");
>+			if (IS_ENABLED(CONFIG_NET))
>+				printf("Net");

Wouuldn't you want to know which devices where detected?

>+			if (IS_ENABLED(CONFIG_EFI_LOADER))
>+				printf(", EFI");
>+			printf("\n");
>+			break;
>+		case RELOCATION:
>+			if (gd->flags & GD_FLG_SKIP_RELOC)
>+				printf("Relocated:" RESET " no\n");
>+			else
>+				printf("Relocated:" RESET " to %#09lx\n", gd->relocaddr);
>+			break;
>+		case CORES:
>+			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
>+				if (ofnode_name_eq(np, "cpu"))
>+					n_cpus++;
>+			}
>+			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
>+			break;
>+		case MEMORY:
>+			printf("Memory:" RESET " %lu MB\n", (ulong)gd->ram_size >> 20);
>+			break;
>+		case STORAGE:
>+		default:
>+			if (i =3D=3D STORAGE && get_mmc_num() > 0) {
>+				mmc =3D find_mmc_device(0);
>+				if (mmc)
>+					printf("Storage:" RESET "  mmc 0: %llu MB", mmc->capacity >> 20);

And if my eMMC is device 1 and SD card is 0?

Why wouldn't you iterate over all UCLASS_BLK devices?

Best regards

Heinrich

>+			}
>+			if (i >=3D STORAGE + 1) {
>+				ret =3D blk_get_desc(UCLASS_SCSI, i - (STORAGE + 1), &scsi_desc);
>+				if (!ret && scsi_desc->type !=3D DEV_TYPE_UNKNOWN)
>+					/* The calculation here is really lossy but close enough */
>+					printf("Storage:" RESET " scsi %d: %lu MB", i - (STORAGE + 1),
>+					       ((scsi_desc->lba >> 9) * scsi_desc->blksz) >> 11);
>+			}
>+			printf("\n");
>+		}
>+	}
>+
>+	printf(RESET "\n\n");
>+
>+	return 0;
>+}
>+
>+U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
>+	"U-Boot fetch utility",
>+	"Print information about your device=2E\n"
>+	"    -n    Don't print the ASCII logo"
>+);
