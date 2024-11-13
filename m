Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B6ED462B9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D5C88FD0;
	Wed, 13 Nov 2024 15:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GJUXqVDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C4589170; Wed, 13 Nov 2024 15:54:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABF888EFB
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731509653; x=1732114453; i=xypron.glpk@gmx.de;
 bh=2G4lyg0M3mqAm1xYDe8kAqcOcG2aWGYLM/V2U/8BWcY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GJUXqVDkkbiB3IUOrm0KiN7wpOcNaCZULH5+iuIDLNl20e4eGBU163uabDGZaUWH
 QiKt+DGUfhhaEyeGtupFBAdyRlWUDnLDs4q3m5xjuSugrEtm5PDYHGU4vJ47eN5fz
 TfLp2KoxRz5CBptoaq2m+1/8joUJbzD6CKVdHGcqp0gJ/AELugq/Cyg1uAwb9PkLh
 TilbrkthiqG3Gy2GiC5z1RNeNJWorma+IT/0s0sNoBoKyk4bgtQ/MZ4Mm7v4L5Y86
 evMceBPXL60/o+PzKRejlS/0MeCoyRl/iq1KE8d5lQRA+TrDMn/PrrPKq4vaV5xHd
 kpSnrOvCkOahfdTfew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1tCK9h0uD6-001NUi; Wed, 13
 Nov 2024 15:54:13 +0100
Date: Wed, 13 Nov 2024 15:40:01 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: neil.armstrong@linaro.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: add a fetch utility
User-Agent: Thunderbird for Android
In-Reply-To: <4dc079b8-4087-4c50-919b-dc676d38191d@linaro.org>
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
 <4dc079b8-4087-4c50-919b-dc676d38191d@linaro.org>
Message-ID: <47DE77F8-1EC3-44F6-AB70-2D7599A79FDC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3/9sQT4jPIbq7P8x0sRoZSGWQr0LS+ZFzrTNtRMJaLlJlcnNgbn
 fFIGE9GAD1GrODZ+ZbZ4KtU1oNlRu6kogajdfwZLso24ZADplOXr5RS7pxR5ucwoMehn2uy
 079lbypNyYw52Bt5u/A7J/97Is1EX+MLbkELUzlU+uhJxGHPcuuWcm5+4SaNA6YXHyB4TpS
 LxV81hzXDkH8qXrDkWxNw==
UI-OutboundReport: notjunk:1;M01:P0:9JVFhzb3ckc=;mguX8TTTtnN2cKhBbdxpvXD6Us1
 kL9yi0MT97uj8O3+/W3tmt6wl/Nb5/jqyybp3VEsZC8/xXFFzXlWQKZFUVXS28bk/rDZlN6vM
 1/NU/KVG8mEdaiXgSrqisgW3cgBNsXUyjMH/eyVIJR1EJIMfjZ3Jiz5Au9F/nY52gDe5BgRpG
 Q1RJh+aU0oWEgUuH0FTOgYSBr7h7uG7g1btpIE/x8Tiim0rAifZYRWc8LDoJt959TJ+gSsB5f
 sJh1/Y9yaRShESC1ScWbFn7bNr8lCmaWC7+eNm7/vILLilDy0sZOgZnW00SXQai3JCk6gNW3F
 1Xyky8rgAUV3B2/pz9sAqotrdPNghvVZSswOyiUi39auEcFgU/8Q6LyrQ7X0IWQGYwVm1oDO4
 Zc5ag1sgdLsR/zOOMx1ldXlFJc3aDtxBCBzcTwniekCjUDK4sxCKssJbanPeSc5yKhMCwUK6V
 Yd7QLyOd8eIIBge6jdMysnyJB5Pmiz0PV01TQ/PkZWN4/bSBTfJdkWqd81BkM5tWL92waENfB
 63u0h00xr7YJ2RQkWKlGB9wnQV4Lmgn+OiXA31+nPXjPoaQbOATrpHf1U2dy9yP7fkkVNlpuD
 CpAuqWtua5ST8Dony1qllzVfaMeyDFEUb7vp4tRD0D+ewOvIgxnfeYEhl4kjEBUzYaeH9ViPe
 l7oV/b8DVUyq/MwNLM79IlWHgwNl0m1PyY939gUVw5l+08Qd09iXfLl7cLseRoAOXKzvVcC+b
 h1t2e3MSkbc3eNmaw+Ts+bWY9ihnruI8FKPqu8A/2UyFKWHStgIiGkeZSkfAAGQreV+1tWUgh
 yjYdlNSFXG7wAZ2m2dpuzIECaNDIbQeT644Hqhbm1HP/OMI75ILWsetZW+JNayXDuzQMDlj8u
 rYT+hfkjwAMAv5BMwrJ8YjPmcwfWnKnh0b/sx25kU4l88hQ8gmgbXPvDecjsuOVsL5krFqeNE
 Oj6rXURlCibKtwvva99uiqvD0/M=
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

Am 13=2E November 2024 14:32:57 MEZ schrieb Neil Armstrong <neil=2Earmstron=
g@linaro=2Eorg>:
>On 13/11/2024 05:22, Caleb Connolly wrote:
>> Add a small utility for displaying some information about U-Boot and th=
e
>> hardware it's running on in a similar fashion to the popular neofetch
>> tool for Linux [1]=2E
>>=20
>> While the output is meant to be useful, it should also be pleasing to
>> look at and perhaps entertaining=2E The ufetch command aims to bring th=
is
>> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo=2E
>>=20
>> [1]: https://en=2Ewikipedia=2Eorg/wiki/Neofetch
>>=20
>> Signed-off-by: Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>> ---
>> Ephemeral screenshot: https://0x0=2Est/XkQU=2Epng
>>=20
>> Changes since v1:
>>   * Rework storage info to be more dynamic
>>   * use print_size() helper everywhere
>>   * manually walk RAM banks to report memory size correctly
>>   * minor formatting changes and fixes
>>   * MAINTAINERS entry
>>   * V1: https://lore=2Ekernel=2Eorg/u-boot/20240808163153=2E2069650-1-c=
aleb=2Econnolly@linaro=2Eorg
>> ---
>>   MAINTAINERS  |   5 ++
>>   cmd/Kconfig  |   7 ++
>>   cmd/Makefile |   1 +
>>   cmd/ufetch=2Ec | 224 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>>   4 files changed, 237 insertions(+)
>>   create mode 100644 cmd/ufetch=2Ec
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 38c714cf46a6=2E=2Ed1eb164ad590 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1724,8 +1724,13 @@ M:	Heiko Schocher <hs@denx=2Ede>
>>   S:	Maintained
>>   T:	git https://source=2Edenx=2Ede/u-boot/custodians/u-boot-ubi=2Egit
>>   F:	drivers/mtd/ubi/
>>   +UFETCH
>> +M:	Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>> +S:	Maintained
>> +F:	cmd/ufetch=2Ec
>> +
>>   UFS
>>   M:	Neil Armstrong <neil=2Earmstrong@linaro=2Eorg>
>>   M:	Bhupesh Sharma <bhupesh=2Elinux@gmail=2Ecom>
>>   M:	Neha Malcom Francis <n-francis@ti=2Ecom>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 4fba9fe67034=2E=2Eda736249a3cf 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -175,8 +175,15 @@ config CMD_CPU
>>   	  number of CPUs, type (e=2Eg=2E manufacturer, architecture, product=
 or
>>   	  internal name) and clock frequency=2E Other information may be
>>   	  available depending on the CPU driver=2E
>>   +config CMD_UFETCH
>> +	bool "U-Boot fetch"
>> +	depends on BLK
>> +	help
>> +	  Fetch utility for U-Boot (akin to neofetch)=2E Prints information
>> +	  about U-Boot and the board it is running on in a pleasing format=2E

The information is already available in other commands with greater detail=
=2E

What is your use case?

>> +
>>   config CMD_FWU_METADATA
>>   	bool "fwu metadata read"
>>   	depends on FWU_MULTI_BANK_UPDATE
>>   	help
>> diff --git a/cmd/Makefile b/cmd/Makefile
>> index d1f369deec0a=2E=2E1e6d3128c8ca 100644
>> --- a/cmd/Makefile
>> +++ b/cmd/Makefile
>> @@ -52,8 +52,9 @@ obj-$(CONFIG_CMD_CONSOLE) +=3D console=2Eo
>>   obj-$(CONFIG_CMD_CPU) +=3D cpu=2Eo
>>   obj-$(CONFIG_CMD_DATE) +=3D date=2Eo
>>   obj-$(CONFIG_CMD_DEMO) +=3D demo=2Eo
>>   obj-$(CONFIG_CMD_DM) +=3D dm=2Eo
>> +obj-$(CONFIG_CMD_UFETCH) +=3D ufetch=2Eo
>>   obj-$(CONFIG_CMD_SOUND) +=3D sound=2Eo
>>   ifdef CONFIG_POST
>>   obj-$(CONFIG_CMD_DIAG) +=3D diag=2Eo
>>   endif
>> diff --git a/cmd/ufetch=2Ec b/cmd/ufetch=2Ec
>> new file mode 100644
>> index 000000000000=2E=2E1bd0565b9f08
>> --- /dev/null
>> +++ b/cmd/ufetch=2Ec
>> @@ -0,0 +1,224 @@
>> +// SPDX-License-Identifier: GPL-2=2E0
>> +
>> +/* Small "fetch" utility for U-Boot */
>> +
>> +#ifdef CONFIG_ARM
>> +#include <asm/system=2Eh>
>> +#endif
>> +#include <dm/device=2Eh>
>> +#include <dm/uclass-internal=2Eh>
>> +#include <display_options=2Eh>
>> +#include <mmc=2Eh>
>> +#include <time=2Eh>
>> +#include <asm/global_data=2Eh>
>> +#include <cli=2Eh>
>> +#include <command=2Eh>
>> +#include <dm/ofnode=2Eh>
>> +#include <env=2Eh>
>> +#include <rand=2Eh>
>> +#include <vsprintf=2Eh>
>> +#include <linux/delay=2Eh>
>> +#include <linux/kernel=2Eh>
>> +#include <version=2Eh>
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define LINE_WIDTH 40
>> +#define BLUE "\033[38;5;4m"
>> +#define YELLOW "\033[38;5;11m"
>> +#define BOLD "\033[1m"
>> +#define RESET "\033[0m"
>> +static const char * const logo_lines[] =3D {
>> +	BLUE BOLD "                  =2E=2E=2E=2E=2E=2E::=2E=2E=2E=2E=2E=2E  =
                 ",
>> +	BLUE BOLD "             =2E=2E=2E::::::::::::::::::=2E=2E=2E         =
     ",
>> +	BLUE BOLD "          =2E=2E::::::::::::::::::::::::::=2E=2E          =
 ",
>> +	BLUE BOLD "        =2E::::=2E:::::::::::::::=2E=2E=2E::::=2E::::=2E  =
       ",
>> +	BLUE BOLD "      =2E::::::::::::::::::::=2E=2E::::::::::::::=2E      =
 ",
>> +	BLUE BOLD "    =2E::=2E:::::::::::::::::::" YELLOW "=3D*%#*" BLUE "::=
::::::::=2E::=2E     ",
>> +	BLUE BOLD "   =2E:::::::::::::::::=2E=2E=2E=2E=2E" YELLOW "*%%*-" BLU=
E ":=2E=2E=2E=2E::::::::::=2E    ",
>> +	BLUE BOLD "  =2E:=2E:::=2E=2E=2E:::::::::=2E:-" YELLOW "=3D=3D=3D##*-=
--=3D=3D-" BLUE "::::::::::=2E:=2E   ",
>> +	BLUE BOLD " =2E::::=2E=2E::::=2E=2E=2E=2E=2E=2E=2E=2E" YELLOW "-***#*=
***###****-" BLUE "=2E=2E=2E::::::=2E:=2E  ",
>> +	BLUE BOLD " ::=2E:=2E-" YELLOW "+***+=3D" BLUE "::-" YELLOW "=3D+**#%=
%%%%%%%%%%%###*=3D " BLUE "-::=2E=2E=2E::::=2E ",
>> +	BLUE BOLD "=2E:=2E::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=
=3D" BLUE ":=2E=2E:::: ",
>> +	BLUE BOLD "=2E::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%=
####%%%%%####%%%*" BLUE "-=2E::=2E ",
>> +	BLUE BOLD ":=2E:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*=
****##%%##*****#%%+" BLUE "=2E::=2E",
>> +	BLUE BOLD "=2E::" YELLOW "**=3D=3D#%%%%%%%##****#%%%%##****#%%%%#****=
###%%" BLUE ":=2E=2E ",
>> +	BLUE BOLD "=2E=2E:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%=
%%%%%%%%%%%%%%#%%%%%+ " BLUE "=2E:=2E",
>> +	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%=
%%%%%%%%%%%%%%* " BLUE "-=2E:: ",
>> +	BLUE BOLD " =2E=2E::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=
=3D" BLUE "-=2E=2E::=2E  ",
>> +	BLUE BOLD "  =2E=2E=2E:=3D" YELLOW "*****=3D" BLUE "::-" YELLOW "=3D+=
**###%%%%%%%%###**+=3D  " BLUE "--:=2E=2E=2E:::  ",
>> +	BLUE BOLD "   =2E::=2E::--:=2E=2E=2E=2E=2E=2E=2E=2E::::::--::::::=2E=
=2E=2E=2E=2E=2E::::::=2E    ",
>> +	BLUE BOLD "    =2E::=2E=2E=2E=2E=2E::::::::::=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E:::::::::=2E::=2E     ",
>> +	BLUE BOLD "      =2E::::::::::::::::::::::::::::::::::::=2E       ",
>> +	BLUE BOLD "        =2E::::=2E::::::::::::::::::::::=2E::::=2E        =
 ",
>> +	BLUE BOLD "          =2E=2E::::::::::::::::::::::::::=2E=2E          =
 ",
>> +	BLUE BOLD "             =2E=2E=2E::::::::::::::::::=2E=2E=2E         =
     ",
>> +	BLUE BOLD "                  =2E=2E=2E=2E=2E=2E::=2E=2E=2E=2E=2E=2E  =
                 ",
>> +};

The lines above are not informative but increase code size=2E They should =
be removable from code=2E

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
>> +	/* Up to 10 storage devices=2E=2E=2E Should be enough for anyone righ=
t? */
>> +	_LAST_LINE =3D (STORAGE + 10),
>> +#define LAST_LINE (_LAST_LINE - 1UL)
>> +};

Please, avoid unnecessary assumptions=2E

What stops me from having a few dozen drives on my NAS or in my VM?

>> +
>> +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>> +		     char *const argv[])
>> +{
>> +	int num_lines =3D max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>> +	const char *model, *compatible;
>> +	char *ipaddr;
>> +	int n_cmds, n_cpus =3D 0, ret, compatlen;
>> +	size_t size;
>> +	ofnode np;
>> +	struct udevice *dev;
>> +	struct blk_desc *desc;
>> +	bool skip_ascii =3D false;
>> +
>> +	if (argc > 1 && strcmp(argv[1], "-n") =3D=3D 0) {
>> +		skip_ascii =3D true;
>> +		num_lines =3D LAST_LINE;
>> +	}
>> +
>> +	for (int line =3D 0; line < num_lines; line++) {

This loop is makes adjustments to the code difficult especially for output=
 where there are multiple devices like network and storage=2E

If the board supports ANSI you can easily position the cursor whereever yo=
u want=2E

>> +		if (!skip_ascii) {
>> +			if (line < ARRAY_SIZE(logo_lines))
>> +				printf("%s  ", logo_lines[line]);
>> +			else
>> +				printf("%*c  ", LINE_WIDTH, ' ');
>> +		}
>> +		switch (line) {
>> +		case FIRST:
>> +			compatible =3D ofnode_read_string(ofnode_root(), "compatible");
>> +			if (!compatible)
>> +				compatible =3D "unknown";
>> +			printf(RESET "%s\n", compatible);
>> +			compatlen =3D strlen(compatible);
>> +			break;
>> +		case SECOND:
>> +			for (int j =3D 0; j < compatlen; j++)
>> +				putc('-');
>> +			putc('\n');
>> +			break;
>> +		case KERNEL:
>> +			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
>> +			break;
>> +		case SYSINFO:
>> +			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
>> +			break;
>> +		case HOST:
>> +			model =3D ofnode_read_string(ofnode_root(), "model");
>> +			if (model)
>> +				printf("Host:" RESET " %s\n", model);
>> +			break;
>> +		case UPTIME:
>> +			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
>> +			break;
>> +		case IP:
>> +			ipaddr =3D env_get("ipvaddr");
>> +			if (!ipaddr)
>> +				ipaddr =3D "none";
>> +			printf("IP Address:" RESET " %s", ipaddr);
>> +			ipaddr =3D env_get("ipv6addr");
>> +			if (ipaddr)

Do your boards only have a single network interface? Mine have multiple=2E=
 Why wouldn't you list them all?

>> +				printf(", %s\n", ipaddr);
>> +			else
>> +				putc('\n');

Why waste an output line on something that does not exist=2E Get rid of th=
e loop!

>> +			break;
>> +		case CMDS:
>> +			n_cmds =3D ll_entry_count(struct cmd_tbl, cmd);
>> +			printf("Commands:" RESET " %d (help)\n", n_cmds);

Who cares about the number of commands if the one he needs is not provided=
=2E

This information is not helpful=2E

>> +			break;
>> +		case CONSOLES:
>> +			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
>> +			       gd->baudrate);

Please, do not assume that stdout relates to a serial console=2E

>> +			break;
>> +		case DEVICES:
>> +			printf("Devices:" RESET " ");
>> +			/* TODO: walk the DM tree */
>> +			printf("Uncountable!\n");

Please, do not write non-information to the screen=2E

>> +			break;
>> +		case FEATURES:
>> +			printf("Features:" RESET " ");
>> +			if (IS_ENABLED(CONFIG_NET))
>> +				printf("Net");
>> +			if (IS_ENABLED(CONFIG_EFI_LOADER))
>> +				printf(", EFI");
>> +			if (IS_ENABLED(CONFIG_CMD_CAT))
>> +				printf(", cat :3");

:3 relates to what in U-Boot?

No clue, why you consider the cat command the relevant one, needing specia=
l mention=2E

>> +#ifdef CONFIG_ARM
>> +			switch (current_el()) {
>> +			case 2:
>> +				printf(", VMs");

Neither full control nor VMs are provided by U-Boot=2E

Why don't you simply write "EL%d"?

>> +				break;
>> +			case 3:
>> +				printf(", full control!");
>> +				break;
>> +			}
>> +#endif
>> +			printf("\n");
>> +			break;
>> +		case RELOCATION:
>> +			if (gd->flags & GD_FLG_SKIP_RELOC)
>> +				printf("Relocated:" RESET " no\n");
>> +			else
>> +				printf("Relocated:" RESET " to %#011lx\n", gd->relocaddr);
>> +			break;
>> +		case CORES:
>> +			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
>> +				if (ofnode_name_eq(np, "cpu"))
>> +					n_cpus++;
>> +			}
>> +			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);

Who knows how many cores are used in the secure world?

This (1 in use) is not oroviding information=2E

>> +			break;
>> +		case MEMORY:
>> +			for (int j =3D 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j]=2E=
size; j++)
>> +				size +=3D gd->bd->bi_dram[j]=2Esize;
>> +			printf("Memory:" RESET " ");
>> +			print_size(size, "\n");
>> +			break;
>> +		case STORAGE:
>> +		default:
>> +			ret =3D uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev)=
;
>> +			if (!ret && dev) {
>> +				desc =3D dev_get_uclass_plat(dev);
>> +				size =3D desc->lba * desc->blksz;
>> +				printf("%s %d: " RESET, desc->uclass_id =3D=3D UCLASS_SCSI ? "SCSI=
" :
>> +						desc->uclass_id =3D=3D UCLASS_MMC
>> +						? "MMC" : "Storage",

SCSI is so old fashioned=2E How about NVMe?

There is a library function to get the display name for a block device=2E

>> +					desc->lun);
>> +				if (size)
>> +					print_size(size, "");
>> +				else
>> +					printf("No media");
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
>> +	   "U-Boot fetch utility",
>> +	   "Print information about your device=2E\n"
>> +	   "    -n    Don't print the ASCII logo"

And how I do I get rid of the other ANSI output?

Best regards

Heinrich

>> +);
>
>Tested-by: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg> # on SM8560-QRD
>
>Ephemeral screenshot: https://0x0=2Est/Xk2N=2Epng
>
>Thanks,
>Neil

