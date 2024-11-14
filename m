Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A73D6A22C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 20:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A656589658;
	Thu, 14 Nov 2024 21:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T1901T0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CA188C98; Thu, 14 Nov 2024 21:09:33 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1633089658
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb51f39394so10762451fa.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731614969; x=1732219769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xw3lEUosd0cQI4nlUWj/+qoTZsz9T8G1QbZ+w5OLJ68=;
 b=T1901T0ab98+oD14rP+0dWyz6pvoVAqjV/Pl3GFUPP9QECcPA7lHBDl+MIwM3luek1
 jL0a0zd/mu/Y9Odob/EPJYnrpmJzNpg5eHF93estKlscXmKEBt+1H0qSSLA3LLcXlkjb
 X5UKyVZwN8hN9UQiYW7HlJ1i3ARBAi5sumVkE3Iupj0eEcdc5Uy6Z4W6H/Mi/+WiUqQ8
 AcTcfHtAe6lx2Bvzprk0f91fsapiPF3F7dbnJGlri8s/+Lb8yL8miLxGF4DznTNbnZH5
 zujQi+sz3m3kFjdkZgC9Yj/QeMaZ1W8Y0P7GbiMRxj5D9cxwFFX9vSF8mOE11RyJ+Rsh
 5NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731614969; x=1732219769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xw3lEUosd0cQI4nlUWj/+qoTZsz9T8G1QbZ+w5OLJ68=;
 b=a6pdy+V5vLdBx3wYdCu4l3HQ/VTrW3pEH82qtgozNs6fzKLxz9qmnHtl/Bvcii2L+m
 2PjhDawI8w1o2SC3K3hYcr88S6D2Neh5OmT0JFnn+xrlNmj5sVZGjekihNhP5OsRIxBC
 8k38Pcq3GiQ0nmwIkrUjUUaY/Inwbt/83Cp3GMJcZ7owtG/iQ8XGUCHAnIGcT0E4763D
 D1YlFkHp7w7PE+NXlaoNz+oYtZ1MEWWbfU+ghXwXfMnu5drUCDwnfLxVVEW/fdRQFPUW
 YVfCxp/5Cf8WdqXB4tzWpn6bVGklSeiRB9edgEc/ugi5UmtoYE2Oj/IT0eTmOxsxkEaM
 s/7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvumj5tXBDecHPf2vHehi2nS6vmQmJVhJAdIDYZuuFY8Mf286DWu74tppP7eTdN0WS8ByO1Ec=@lists.denx.de
X-Gm-Message-State: AOJu0YzV71PqXajCSqx+6wDlmNbtgfrVvqD/QpNVpIbumyg1E/CtN0E7
 4IadS1jm7X7pOe6jQZf+DkueONk6gm6mJeGDXZKX6KmMLz+myAmESKVYVOee32SqYpTClBphCfV
 G
X-Google-Smtp-Source: AGHT+IGfeQwCjlumX7K+kccF1eYIjg/f8YQCR7NfmIIFDAaDVAlanlBukkSMyuPzQ1QJGMp4WdLnIA==
X-Received: by 2002:a2e:a5c7:0:b0:2f4:3de7:ac4c with SMTP id
 38308e7fff4ca-2ff608e48ddmr1473451fa.8.1731614969142; 
 Thu, 14 Nov 2024 12:09:29 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df27068sm97852666b.8.2024.11.14.12.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:09:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, u-boot@lists.denx.de
Subject: [PATCH v3] cmd: add a fetch utility
Date: Thu, 14 Nov 2024 21:08:44 +0100
Message-ID: <20241114200856.3450012-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a small utility for displaying some information about U-Boot and the
hardware it's running on in a similar fashion to the popular neofetch
tool for Linux [1].

While the output is meant to be useful, it should also be pleasing to
look at and perhaps entertaining. The ufetch command aims to bring this
to U-Boot, featuring a colorful ASCII art version of the U-Boot logo.

[1]: https://en.wikipedia.org/wiki/Neofetch

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8560-QRD
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
For additional background/context see v1 thread.

I've enabled this for sandbox so it at least gets build-tested in CI as
Simon originally suggested in v1.

Changes since v2:
 * Fix building on 32-bit ARM
 * Enable for sandbox to avoid build regressions
 * Remove unused Devices line
 * Use blk_get_uclass_name()
 * Add TODO/ideas comment
 * Avoid printing blank lines at the end when running with -n
 * V2: https://lore.kernel.org/u-boot/20241113042536.1792150-2-caleb.connolly@linaro.org

Changes since v1:
 * Rework storage info to be more dynamic
 * use print_size() helper everywhere
 * manually walk RAM banks to report memory size correctly
 * minor formatting changes and fixes
 * MAINTAINERS entry
 * V1: https://lore.kernel.org/u-boot/20240808163153.2069650-1-caleb.connolly@linaro.org
---
 MAINTAINERS               |   5 +
 cmd/Kconfig               |   7 ++
 cmd/Makefile              |   1 +
 cmd/ufetch.c              | 229 ++++++++++++++++++++++++++++++++++++++
 configs/sandbox_defconfig |   1 +
 5 files changed, 243 insertions(+)
 create mode 100644 cmd/ufetch.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0399ed1dbf64..1d81bdecc7c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,8 +1732,13 @@ M:	Heiko Schocher <hs@denx.de>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
+UFETCH
+M:	Caleb Connolly <caleb.connolly@linaro.org>
+S:	Maintained
+F:	cmd/ufetch.c
+
 UFS
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 636833646f6e..253fbdfe1dd1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -175,8 +175,15 @@ config CMD_CPU
 	  number of CPUs, type (e.g. manufacturer, architecture, product or
 	  internal name) and clock frequency. Other information may be
 	  available depending on the CPU driver.
 
+config CMD_UFETCH
+	bool "U-Boot fetch"
+	depends on BLK
+	help
+	  Fetch utility for U-Boot (akin to neofetch). Prints information
+	  about U-Boot and the board it is running on in a pleasing format.
+
 config CMD_FWU_METADATA
 	bool "fwu metadata read"
 	depends on FWU_MULTI_BANK_UPDATE
 	help
diff --git a/cmd/Makefile b/cmd/Makefile
index d1f369deec0a..1e6d3128c8ca 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -52,8 +52,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
 obj-$(CONFIG_CMD_CPU) += cpu.o
 obj-$(CONFIG_CMD_DATE) += date.o
 obj-$(CONFIG_CMD_DEMO) += demo.o
 obj-$(CONFIG_CMD_DM) += dm.o
+obj-$(CONFIG_CMD_UFETCH) += ufetch.o
 obj-$(CONFIG_CMD_SOUND) += sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) += diag.o
 endif
diff --git a/cmd/ufetch.c b/cmd/ufetch.c
new file mode 100644
index 000000000000..61bf264d2afb
--- /dev/null
+++ b/cmd/ufetch.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Small "fetch" utility for U-Boot */
+
+#ifdef CONFIG_ARM64
+#include <asm/system.h>
+#endif
+#include <dm/device.h>
+#include <dm/uclass-internal.h>
+#include <display_options.h>
+#include <mmc.h>
+#include <time.h>
+#include <asm/global_data.h>
+#include <cli.h>
+#include <command.h>
+#include <dm/ofnode.h>
+#include <env.h>
+#include <rand.h>
+#include <vsprintf.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <version.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define LINE_WIDTH 40
+#define BLUE "\033[38;5;4m"
+#define YELLOW "\033[38;5;11m"
+#define BOLD "\033[1m"
+#define RESET "\033[0m"
+static const char * const logo_lines[] = {
+	BLUE BOLD "                  ......::......                   ",
+	BLUE BOLD "             ...::::::::::::::::::...              ",
+	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
+	BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
+	BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
+	BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE "::::::::::.::.     ",
+	BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE ":....::::::::::.    ",
+	BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-" BLUE "::::::::::.:.   ",
+	BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-" BLUE "...::::::.:.  ",
+	BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
+	BLUE BOLD ".:.::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
+	BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
+	BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
+	BLUE BOLD ".::" YELLOW "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
+	BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
+	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
+	BLUE BOLD " ..::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
+	BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-" YELLOW "=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
+	BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
+	BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
+	BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
+	BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
+	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
+	BLUE BOLD "             ...::::::::::::::::::...              ",
+	BLUE BOLD "                  ......::......                   ",
+};
+
+enum output_lines {
+	FIRST,
+	SECOND,
+	KERNEL,
+	SYSINFO,
+	HOST,
+	UPTIME,
+	IP,
+	CMDS,
+	CONSOLES,
+	FEATURES,
+	RELOCATION,
+	CORES,
+	MEMORY,
+	STORAGE,
+
+	/* Up to 10 storage devices... Should be enough for anyone right? */
+	_LAST_LINE = (STORAGE + 10),
+#define LAST_LINE (_LAST_LINE - 1UL)
+};
+
+/*
+ * TODO/ideas:
+ * - Refactor to not use a for loop
+ * - Handle multiple network interfaces
+ * - Include stats about number of bound/probed devices
+ * - Show U-Boot's size and malloc usage, fdt size, etc.
+ */
+
+
+static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
+	const char *model, *compatible;
+	char *ipaddr;
+	int n_cmds, n_cpus = 0, ret, compatlen;
+	size_t size;
+	ofnode np;
+	struct udevice *dev;
+	struct blk_desc *desc;
+	bool skip_ascii = false;
+
+	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
+		skip_ascii = true;
+		num_lines = LAST_LINE;
+	}
+
+	for (int line = 0; line < num_lines; line++) {
+		if (!skip_ascii) {
+			if (line < ARRAY_SIZE(logo_lines))
+				printf("%s  ", logo_lines[line]);
+			else
+				printf("%*c  ", LINE_WIDTH, ' ');
+		}
+		switch (line) {
+		case FIRST:
+			compatible = ofnode_read_string(ofnode_root(), "compatible");
+			if (!compatible)
+				compatible = "unknown";
+			printf(RESET "%s\n", compatible);
+			compatlen = strlen(compatible);
+			break;
+		case SECOND:
+			for (int j = 0; j < compatlen; j++)
+				putc('-');
+			putc('\n');
+			break;
+		case KERNEL:
+			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
+			break;
+		case SYSINFO:
+			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
+			break;
+		case HOST:
+			model = ofnode_read_string(ofnode_root(), "model");
+			if (model)
+				printf("Host:" RESET " %s\n", model);
+			break;
+		case UPTIME:
+			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
+			break;
+		case IP:
+			ipaddr = env_get("ipvaddr");
+			if (!ipaddr)
+				ipaddr = "none";
+			printf("IP Address:" RESET " %s", ipaddr);
+			ipaddr = env_get("ipv6addr");
+			if (ipaddr)
+				printf(", %s\n", ipaddr);
+			else
+				putc('\n');
+			break;
+		case CMDS:
+			n_cmds = ll_entry_count(struct cmd_tbl, cmd);
+			printf("Commands:" RESET " %d (help)\n", n_cmds);
+			break;
+		case CONSOLES:
+			printf("Consoles:" RESET " %s", env_get("stdout"));
+			if (gd->baudrate)
+				printf(" (%d baud)", gd->baudrate);
+			putc('\n');
+			break;
+		case FEATURES:
+			printf("Features:" RESET " ");
+			if (IS_ENABLED(CONFIG_NET))
+				printf("Net");
+			if (IS_ENABLED(CONFIG_EFI_LOADER))
+				printf(", EFI");
+			if (IS_ENABLED(CONFIG_CMD_CAT))
+				printf(", cat :3");
+#ifdef CONFIG_ARM64
+			switch (current_el()) {
+			case 2:
+				printf(", VMs");
+				break;
+			case 3:
+				printf(", full control!");
+				break;
+			}
+#endif
+			printf("\n");
+			break;
+		case RELOCATION:
+			if (gd->flags & GD_FLG_SKIP_RELOC)
+				printf("Relocated:" RESET " no\n");
+			else
+				printf("Relocated:" RESET " to %#011lx\n", gd->relocaddr);
+			break;
+		case CORES:
+			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
+				if (ofnode_name_eq(np, "cpu"))
+					n_cpus++;
+			}
+			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
+			break;
+		case MEMORY:
+			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
+				size += gd->bd->bi_dram[j].size;
+			printf("Memory:" RESET " ");
+			print_size(size, "\n");
+			break;
+		case STORAGE:
+		default:
+			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
+			if (!ret && dev) {
+				desc = dev_get_uclass_plat(dev);
+				size = desc->lba * desc->blksz;
+				printf("%4s %d: " RESET, blk_get_uclass_name(desc->uclass_id),
+					desc->lun);
+				if (size)
+					print_size(size, "");
+				else
+					printf("No media");
+			} else if (ret == -ENODEV && (skip_ascii || line > ARRAY_SIZE(logo_lines))) {
+				break;
+			}
+			printf("\n");
+		}
+	}
+
+	printf(RESET "\n\n");
+
+	return 0;
+}
+
+U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
+	   "U-Boot fetch utility",
+	   "Print information about your device.\n"
+	   "    -n    Don't print the ASCII logo"
+);
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index d111858082d5..fb2b5ff54f4a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -50,8 +50,9 @@ CONFIG_LOG_DEFAULT_LEVEL=6
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_STACKPROTECTOR=y
 CONFIG_CMD_CPU=y
+CONFIG_CMD_UFETCH=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTM_PRE_LOAD=y
 CONFIG_CMD_BOOTZ=y
-- 
2.47.0

