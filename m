Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D3BD6A22D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 20:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7858989072;
	Thu, 14 Nov 2024 21:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DfJThZcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645018901D; Thu, 14 Nov 2024 21:56:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B8389678
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731617795; x=1732222595; i=xypron.glpk@gmx.de;
 bh=8Mbt+dnAxhBmc/UF5XDNHL64jDRvH0I+psME0a05f04=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DfJThZcr7DEU+YFMCp8U6LqU39G9zIeJCZ0eh51TVbaWK2GZX2aUdUk1GERxB4Uv
 Hacy7JoBJLWZtuZ8DrlapqE/Nn+NBmr4ZX2EWA99cZZESb9EJe6gXg+XIMKH07BsD
 KteDwNxIFkTaim9Zi4ZiaarZKxqeZIP3oopESZ5XcyyKfmacgRKDFZUu5tBnEPs2u
 ZHrFFxh63qXxgcPVZtQ0wa9ozHhbHQS4DDAXd/X4Nf1SLErgvZlDwJL+j6usmYVKe
 LbASXFOrPB+JSmHsYtHflzIT4XHswyW6PFW4AExwKrynkHO+LKGR73WCIaqjY4K8E
 UiTyrFBampo2AAu4Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1tDLqr16GQ-004BLf; Thu, 14
 Nov 2024 21:56:35 +0100
Date: Thu, 14 Nov 2024 21:56:31 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3] cmd: add a fetch utility
User-Agent: Thunderbird for Android
In-Reply-To: <20241114200856.3450012-1-caleb.connolly@linaro.org>
References: <20241114200856.3450012-1-caleb.connolly@linaro.org>
Message-ID: <6E0F0C37-76BD-4FA6-AC86-73D3DD795DBC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sZxx8FzFxrj/7hwUJBc0GYSlQMpxeG0YsL+7QpskW3PC3AG9Frm
 t4daoZ2HE5n5vEasXsrNhBSaWuuuKBt/UQD9Z55B4cdoZV6i6kIxIU4o1OqkA273rFDI7CL
 JycVmO2PxVAlIQ0oNOGGMPcxPZXT30InzF1rcSZVNGLqzE3RyYaN0CrVsfcCZ7qnXip1ieC
 TzjIQGAVrjdjBOieUsJtA==
UI-OutboundReport: notjunk:1;M01:P0:1DduxECx82c=;bFtS52EBpYnCCN17jLp6YSCUO0h
 d7Aou7WBnKTsnRxEXkWOWd0CBMNiAv6ZdNaOOP7E54s3lRKU3Mc+d9hF5GGNrmejxrboRnCDn
 46VcxzTllVpVFCBxFYuTR16utGJV5TZRS78szW0KwFTeDkOle2y/PGRkvAmSL/rpoIMzNFKBL
 GupnvRYotAu1xllR8i2nYrX9XD70nzlPtIq8hdmnrzs/PAz4/ML8Xk0ilTmuRk9j55rF5Tg2Y
 D8Pt5Cfuq11POcKlW3dP421EPf1xUg5ow/lF+vNRZx/guGhQPQ90wrkS561MWGgvrB5htvNGj
 OhFg3M0X1MGTRPuUkjfIMsnzGw0ulM8sCoe4YGDtou+FogWkL8REXnSyI4zukHVWcQTAdKa5B
 xA7g0KarDEKiLn8SP+/+Eq3KlykqBF7ABrQcrPCQghGYXONxmRgLHEMOOZr7e/LP66zl4gXAj
 chS1aLT3KDaIfGzZ1Xw1zJBm3+pP0D4ktW3AI1bku0/oqGqVgeG3JeynXfMtJjq63KFdeDqwq
 FLcTVEZYOUSTmjZNqx8Mqzv+DInTF1+eX9uozhgrMr+tAbwfXObbEYF4qlYHhQZ1wjrTjDJBA
 9jRE+thlZAwuc9pJlHFrSFXohaJ0FgZwljZAEOsAQz7PM2JpJmoIUs/pULV5afQdC31Bv0PmY
 6s3DvKV/P3FnkDm4Gn9V/RPtmkaEhHXsnl91m7khLKYfx/FuZJ9KqoxKCuEnCGqX7H5nYCDFh
 yTBXFBQwE6CyUP/pcXcmC0pMnGe+DRB3ZQhPyQzR16ZDEh+heudoV9IeUxCOWRpGw7GaYKbMi
 p8sjuXl1FHiZ8XP+TVu91mc5mQVsKXeq6AHdMIIsGjZA/LF4POrCiLKmshpMK0cvYtQK8vusY
 MvaBrN6JLzwAE+QXMvszucu+B6SlyfRaSYpfBQUpHXYveG7l8bektcUE7
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

Am 14=2E November 2024 21:08:44 MEZ schrieb Caleb Connolly <caleb=2Econnoll=
y@linaro=2Eorg>:
>Add a small utility for displaying some information about U-Boot and the
>hardware it's running on in a similar fashion to the popular neofetch
>tool for Linux [1]=2E
>
>While the output is meant to be useful, it should also be pleasing to
>look at and perhaps entertaining=2E The ufetch command aims to bring this
>to U-Boot, featuring a colorful ASCII art version of the U-Boot logo=2E
>
>[1]: https://en=2Ewikipedia=2Eorg/wiki/Neofetch
>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>Acked-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom> # vim3
>Tested-by: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg> # on SM8560-QRD
>Signed-off-by: Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>


Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
>For additional background/context see v1 thread=2E
>
>I've enabled this for sandbox so it at least gets build-tested in CI as
>Simon originally suggested in v1=2E
>
>Changes since v2:
> * Fix building on 32-bit ARM
> * Enable for sandbox to avoid build regressions
> * Remove unused Devices line
> * Use blk_get_uclass_name()
> * Add TODO/ideas comment
> * Avoid printing blank lines at the end when running with -n
> * V2: https://lore=2Ekernel=2Eorg/u-boot/20241113042536=2E1792150-2-cale=
b=2Econnolly@linaro=2Eorg
>
>Changes since v1:
> * Rework storage info to be more dynamic
> * use print_size() helper everywhere
> * manually walk RAM banks to report memory size correctly
> * minor formatting changes and fixes
> * MAINTAINERS entry
> * V1: https://lore=2Ekernel=2Eorg/u-boot/20240808163153=2E2069650-1-cale=
b=2Econnolly@linaro=2Eorg
>---
> MAINTAINERS               |   5 +
> cmd/Kconfig               |   7 ++
> cmd/Makefile              |   1 +
> cmd/ufetch=2Ec              | 229 ++++++++++++++++++++++++++++++++++++++
> configs/sandbox_defconfig |   1 +
> 5 files changed, 243 insertions(+)
> create mode 100644 cmd/ufetch=2Ec
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 0399ed1dbf64=2E=2E1d81bdecc7c3 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1732,8 +1732,13 @@ M:	Heiko Schocher <hs@denx=2Ede>
> S:	Maintained
> T:	git https://source=2Edenx=2Ede/u-boot/custodians/u-boot-ubi=2Egit
> F:	drivers/mtd/ubi/
>=20
>+UFETCH
>+M:	Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>+S:	Maintained
>+F:	cmd/ufetch=2Ec
>+
> UFS
> M:	Neil Armstrong <neil=2Earmstrong@linaro=2Eorg>
> M:	Bhupesh Sharma <bhupesh=2Elinux@gmail=2Ecom>
> M:	Neha Malcom Francis <n-francis@ti=2Ecom>
>diff --git a/cmd/Kconfig b/cmd/Kconfig
>index 636833646f6e=2E=2E253fbdfe1dd1 100644
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
>index d1f369deec0a=2E=2E1e6d3128c8ca 100644
>--- a/cmd/Makefile
>+++ b/cmd/Makefile
>@@ -52,8 +52,9 @@ obj-$(CONFIG_CMD_CONSOLE) +=3D console=2Eo
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
>index 000000000000=2E=2E61bf264d2afb
>--- /dev/null
>+++ b/cmd/ufetch=2Ec
>@@ -0,0 +1,229 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+
>+/* Small "fetch" utility for U-Boot */
>+
>+#ifdef CONFIG_ARM64
>+#include <asm/system=2Eh>
>+#endif
>+#include <dm/device=2Eh>
>+#include <dm/uclass-internal=2Eh>
>+#include <display_options=2Eh>
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
>+static const char * const logo_lines[] =3D {
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
>+	BLUE BOLD "  =2E=2E=2E:=3D" YELLOW "*****=3D" BLUE "::-" YELLOW "=3D+**=
###%%%%%%%%###**+=3D  " BLUE "--:=2E=2E=2E:::  ",
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
>+/*
>+ * TODO/ideas:
>+ * - Refactor to not use a for loop
>+ * - Handle multiple network interfaces
>+ * - Include stats about number of bound/probed devices
>+ * - Show U-Boot's size and malloc usage, fdt size, etc=2E
>+ */
>+
>+
>+static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>+		     char *const argv[])
>+{
>+	int num_lines =3D max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
>+	const char *model, *compatible;
>+	char *ipaddr;
>+	int n_cmds, n_cpus =3D 0, ret, compatlen;
>+	size_t size;
>+	ofnode np;
>+	struct udevice *dev;
>+	struct blk_desc *desc;
>+	bool skip_ascii =3D false;
>+
>+	if (argc > 1 && strcmp(argv[1], "-n") =3D=3D 0) {
>+		skip_ascii =3D true;
>+		num_lines =3D LAST_LINE;
>+	}
>+
>+	for (int line =3D 0; line < num_lines; line++) {
>+		if (!skip_ascii) {
>+			if (line < ARRAY_SIZE(logo_lines))
>+				printf("%s  ", logo_lines[line]);
>+			else
>+				printf("%*c  ", LINE_WIDTH, ' ');
>+		}
>+		switch (line) {
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
>+			printf("Commands:" RESET " %d (help)\n", n_cmds);
>+			break;
>+		case CONSOLES:
>+			printf("Consoles:" RESET " %s", env_get("stdout"));
>+			if (gd->baudrate)
>+				printf(" (%d baud)", gd->baudrate);
>+			putc('\n');
>+			break;
>+		case FEATURES:
>+			printf("Features:" RESET " ");
>+			if (IS_ENABLED(CONFIG_NET))
>+				printf("Net");
>+			if (IS_ENABLED(CONFIG_EFI_LOADER))
>+				printf(", EFI");
>+			if (IS_ENABLED(CONFIG_CMD_CAT))
>+				printf(", cat :3");
>+#ifdef CONFIG_ARM64
>+			switch (current_el()) {
>+			case 2:
>+				printf(", VMs");
>+				break;
>+			case 3:
>+				printf(", full control!");
>+				break;
>+			}
>+#endif
>+			printf("\n");
>+			break;
>+		case RELOCATION:
>+			if (gd->flags & GD_FLG_SKIP_RELOC)
>+				printf("Relocated:" RESET " no\n");
>+			else
>+				printf("Relocated:" RESET " to %#011lx\n", gd->relocaddr);
>+			break;
>+		case CORES:
>+			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
>+				if (ofnode_name_eq(np, "cpu"))
>+					n_cpus++;
>+			}
>+			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
>+			break;
>+		case MEMORY:
>+			for (int j =3D 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j]=2Esi=
ze; j++)
>+				size +=3D gd->bd->bi_dram[j]=2Esize;
>+			printf("Memory:" RESET " ");
>+			print_size(size, "\n");
>+			break;
>+		case STORAGE:
>+		default:
>+			ret =3D uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
>+			if (!ret && dev) {
>+				desc =3D dev_get_uclass_plat(dev);
>+				size =3D desc->lba * desc->blksz;
>+				printf("%4s %d: " RESET, blk_get_uclass_name(desc->uclass_id),
>+					desc->lun);
>+				if (size)
>+					print_size(size, "");
>+				else
>+					printf("No media");
>+			} else if (ret =3D=3D -ENODEV && (skip_ascii || line > ARRAY_SIZE(log=
o_lines))) {
>+				break;
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
>+	   "U-Boot fetch utility",
>+	   "Print information about your device=2E\n"
>+	   "    -n    Don't print the ASCII logo"
>+);
>diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
>index d111858082d5=2E=2Efb2b5ff54f4a 100644
>--- a/configs/sandbox_defconfig
>+++ b/configs/sandbox_defconfig
>@@ -50,8 +50,9 @@ CONFIG_LOG_DEFAULT_LEVEL=3D6
> CONFIG_LOGF_FUNC=3Dy
> CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> CONFIG_STACKPROTECTOR=3Dy
> CONFIG_CMD_CPU=3Dy
>+CONFIG_CMD_UFETCH=3Dy
> CONFIG_CMD_LICENSE=3Dy
> CONFIG_CMD_SMBIOS=3Dy
> CONFIG_CMD_BOOTM_PRE_LOAD=3Dy
> CONFIG_CMD_BOOTZ=3Dy

