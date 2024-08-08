Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C12C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FB0889EF;
	Thu,  8 Aug 2024 18:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OV+9gUd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAD188AE4; Thu,  8 Aug 2024 18:32:45 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E22889AF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so148511066b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134762; x=1723739562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t/eUZI1Lb+/Q0ukMoJrSThald7YT2QbdK55SQfMoJx0=;
 b=OV+9gUd4vOmVy1PU/W7PQwgKHD6noJDWRT0m5JJp9D8sOBSckczQFmJBT1u+II4O0J
 wgWb6uHnDGy1QStFD2SHRE4N85sf84qKkxNq6Q5e/zRr0SRVlMeotsZxaLboL8wvzQrD
 afv+6t3YKsUR5rSf2gPeGdTloJBE0CJw8XCvSpYQR97f4QlXXyzOUcwElDyNIHBv75eo
 2UUpsJA/bSuWgH+mjU1L0i1bzAU2NiyZKBTA93RXTszZ3/Zz9QLH9p+hYQwP//4eDXD7
 r3XyvKGug+ci4cneqn8BjuQcQSWTil/67ZyTI6UIWY+VZXmMJdRELqPlwkg3LKf75cVM
 SBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134762; x=1723739562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/eUZI1Lb+/Q0ukMoJrSThald7YT2QbdK55SQfMoJx0=;
 b=hCOPqrlkQtJL1nRANwEEp6HLspasfPSn7W49C/rcNJstPrxd6MA4vnl1px6oas0BPM
 BgKj1wuS5JPt/1NCZCS0u0YebsFjzz7vGKDRVDIZ7ekBdath5PQKm1dIHp6eEG1Wzcjo
 hlzUh2xKTT0I5K23Dtpsvbrv3+fPsL/bpNkKFw3F0SSJ57kIkkHguco1W6+3hppGpb/v
 5X3rjvjoUHfQCB6pXnboaHa0yLAbJBjRysXcFLwNxYbpr0EkQv846P/bznVXpIqUjquZ
 loSNaLpA/ULnZrKUx+/bhpYtgBgsGojJMAf0KTRFJhRwtAH1Fq1OY2rvFcFskQegVi9V
 C8vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIntwfH+YKdA+OwJVyYb8jC0POHJ+QmrhtNskeoMOFEN5b7ZzPL+TFJnaJv0Zt7tTi+3J/l4Xr5+t8C+ocWrUv8OCrEg==
X-Gm-Message-State: AOJu0Yw9FLHAm+9Hb1dWsy0pB8u8xTu2HWizN+f28N8HVHPw+xVUdqrR
 HvawzUCS+KtUFTJvodpXokK59jVVmE+jhysbXkXmIDJK8FjDSf/0Vp+xANJFYdc=
X-Google-Smtp-Source: AGHT+IHzmjqictXfD1zzizudgS/kZT8pVVQhH4PuaSJmqL8oKjKciY5N4ezIss+dDjrFL5SccKr6vA==
X-Received: by 2002:a17:907:7f8c:b0:a7a:b0a0:ebdb with SMTP id
 a640c23a62f3a-a8090c81d36mr187851766b.22.1723134762451; 
 Thu, 08 Aug 2024 09:32:42 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec7266sm761062966b.196.2024.08.08.09.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:32:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] cmd: add a fetch utility
Date: Thu,  8 Aug 2024 18:24:24 +0200
Message-ID: <20240808163153.2069650-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.0
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

While U-Boot does a pretty good job at printing information at startup
about what hardware it's running on, it can be hard to take pretty
pictures of this to show off on the internet (by far the most
important aspect of porting a device in 2024!).

Add a small utility "ufetch" for displaying some information about U-Boot and
the hardware it's running on in a similar fashion to the popular neofetch tool
for *nix's [1].

While the output is meant to be useful, it should also be pleasing to look at
and look good in screenshots. The ufetch command brings this to U-Boot,
featuring a colorful ASCII art version of the U-Boot logo and a fancy layout.

Finally, tireless device porters can properly show off their hard work and get
the internet points they so deserve!

Not everything is fully supported yet, but this seemed good enough for initial
inclusion. Only one MMC device is detected, and other than SCSI other storage
devices aren't supported.

[1]: https://en.wikipedia.org/wiki/Neofetch

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Ephemeral demo image: https://0x0.st/XVUa.png
---
 cmd/Kconfig  |   7 ++
 cmd/Makefile |   1 +
 cmd/ufetch.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 cmd/ufetch.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda426..70acb5727b04 100644
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
index 87133cc27a8a..ffb04c8f2e0a 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -53,8 +53,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
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
index 000000000000..f7374eb2e364
--- /dev/null
+++ b/cmd/ufetch.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Small "fetch" utility for U-Boot */
+
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
+static const char *logo_lines[] = {
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
+	BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-\033[38;5;7m=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
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
+	DEVICES,
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
+static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
+	const char *model, *compatible;
+	char *ipaddr;
+	int n_cmds, n_cpus = 0, ret, compatlen;
+	ofnode np;
+	struct mmc *mmc;
+	struct blk_desc *scsi_desc;
+	bool skip_ascii = false;
+
+	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
+		skip_ascii = true;
+		num_lines = LAST_LINE;
+	}
+
+	for (int i = 0; i < num_lines; i++) {
+		if (!skip_ascii) {
+			if (i < ARRAY_SIZE(logo_lines))
+				printf("%s ", logo_lines[i]);
+			else
+				printf("%*c ", LINE_WIDTH, ' ');
+		}
+		switch (i) {
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
+			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
+			       gd->baudrate);
+			break;
+		case DEVICES:
+			printf("Devices:" RESET " ");
+			/* TODO: walk the DM tree */
+			printf("Uncountable!\n");
+			break;
+		case FEATURES:
+			printf("Features:" RESET " ");
+			if (IS_ENABLED(CONFIG_NET))
+				printf("Net");
+			if (IS_ENABLED(CONFIG_EFI_LOADER))
+				printf(", EFI");
+			printf("\n");
+			break;
+		case RELOCATION:
+			if (gd->flags & GD_FLG_SKIP_RELOC)
+				printf("Relocated:" RESET " no\n");
+			else
+				printf("Relocated:" RESET " to %#09lx\n", gd->relocaddr);
+			break;
+		case CORES:
+			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
+				if (ofnode_name_eq(np, "cpu"))
+					n_cpus++;
+			}
+			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
+			break;
+		case MEMORY:
+			printf("Memory:" RESET " %lu MB\n", (ulong)gd->ram_size >> 20);
+			break;
+		case STORAGE:
+		default:
+			if (i == STORAGE && get_mmc_num() > 0) {
+				mmc = find_mmc_device(0);
+				if (mmc)
+					printf("Storage:" RESET "  mmc 0: %llu MB", mmc->capacity >> 20);
+			}
+			if (i >= STORAGE + 1) {
+				ret = blk_get_desc(UCLASS_SCSI, i - (STORAGE + 1), &scsi_desc);
+				if (!ret && scsi_desc->type != DEV_TYPE_UNKNOWN)
+					/* The calculation here is really lossy but close enough */
+					printf("Storage:" RESET " scsi %d: %lu MB", i - (STORAGE + 1),
+					       ((scsi_desc->lba >> 9) * scsi_desc->blksz) >> 11);
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
+	"U-Boot fetch utility",
+	"Print information about your device.\n"
+	"    -n    Don't print the ASCII logo"
+);
-- 
2.46.0

