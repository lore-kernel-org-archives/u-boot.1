Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD68C61DC6
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 08:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53E6340827;
	Fri, 28 Aug 2026 08:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mi-9p5edIx35; Fri, 28 Aug 2026 08:40:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787906414;
	bh=VPRTIZf/GF1Xhdyk9GalemchH5ozByyy+uLtbp9AXwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxHxba6C5g+khW5hSF3fjPGN9T/gtpjFWv+V/s65GsduqzSKzYiFECGZHWr8tcVIO
	 3wp7qK5AcdgOP+c6sI/3THw04k6yeusVUlY5f6IOxatGdhDopXfnHw3M/5bIBXvqea
	 Zd1gVW/Wfde88NLewqnTX+lQplfECnuiWIWXAhWCh3VG4xvrZhs9Lone433W9z+y7E
	 eqDS4OaSnuxJ8id8tGsR4Jx6kJx1DziIKwHXD7TZ+z+2cjViceGbf0c3HbbkSq0e/2
	 tTq2ZJ/7YkGpAOU8ffs0T1QHfEX7c2GGkoau/QsSXw7YsQ75PaER7w42qsLG2iu424
	 2VJaVhxl9yHFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36119407FB;
	Fri, 28 Aug 2026 08:40:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC8E1355
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA847400DC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6_4KfyTSkIs for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 08:40:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ir3WS07y
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F08C34005A
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:08 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495590dde14so6427785e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787906406; x=1788511206;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VPRTIZf/GF1Xhdyk9GalemchH5ozByyy+uLtbp9AXwE=;
 b=Ir3WS07y6KYq2INezRXkuAevDx2XtNy/E4AV54w7gehG5Yq0sCno9CM2JkKOtFNzJH
 cfBcKy9eH+QB+Yfagk6bhablvxngVVYCw+ZO328IrMF36VMlZsvo2DuwNyqq++opkyip
 IO4CPlNc+cBBaX9LCselTAVfu6g8y8ybJbCSnOs9ArjU90IlzD8HbCp5NCUuw6CAW90Y
 r3YJ4xZwH0zuy1fQ+/pYtObmDkaORIc0i1c5o68bg1ud3ol+7okO6V+MLLW8sxuJohD0
 0atHapMvCvZkKmNh0Fo+SwbTwLPzkGGMPmGoLpSOL5btpTMwUAv66kHJyBnRgHY3LeM7
 S4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787906406; x=1788511206;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VPRTIZf/GF1Xhdyk9GalemchH5ozByyy+uLtbp9AXwE=;
 b=Geigwfg+Cjhoi21pzOyOVRNmx8OapTA2jbNRjGy/1rbpBOr6PpPryIO8Gvd8r3LfsV
 z/mZRKT2JF4TFGk8cI6IqP64de87hMgp3gbvC+qnWqQFQhbox7rlaQfPKF+ZAFZEOxeL
 qXqQHrcyzUyRT5fKUpfTrIhAykwZ1L4jx1rLbIVlUPhAw2o0J98DQAuvIHTyoMqCZ0gq
 Icyd23xqXcELasDL/UYTIfIaHIO1/mZKgIHnvmoH6JNb48UcYYPIsQaPXGYF8uC1+3VW
 PIvXYNEJFQyLwSoMfRrZpNhKZMBX3dfymhLqbP4lD/wcHoum5nPdHTsrQt+or95ls8GA
 7IIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaLXxRs0pct+r1gNTNAhX6W23oqW2tHS2N5vegQZg+wXv+Nds6iWga4yyTp8OcjbFyk1p6n2M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++loMDt1rV5QS3Je/JTFgxuGU1hMPzgEw9qv1aQduXx6lIS7Hwrb
 8SFfsnxT5a9IEpVXshvHfkQ6LPMREo9OjrnVQmsBPp6LUBqB8ltkLrZkT6ngwXbWT4s=
X-Gm-Gg: AR+sD13yUy0yQaJrTTFELY6JPcZGnS5ysM9Qo2QqDQ9ef1pMQxHezWQops9u+MmS0mU
 WN0BO4nuOYX5rldxIMFhQWsP39bS8S0uP/2Mm30mWR5c12pX+yHIYBFhJvFes2PTRDeDiInMRsQ
 3X09T+WYxfEwbMLpvHgtBoP8X6jnx29BdgjSb/yA/LBZL4U/O22RBRPKKz5lWvcC7DCL8YUPZKH
 1zlWClbnne9CihDYL9YcJch0do1R3O4Mxnx8pMga2KR6KbroeY+ysKaL0Wxigy8HBXGIUMXCsid
 rQFS3L4tcu49RJKhk0af2rodbt22dFgKNrOnpFGXjwAVopJRJMS5BHN8Hp6Qm4de0srk1xp4QGY
 GQpraL5Z2kIWujnCCOmRcRJOHukirfOjNTgCeI4Geeu0CyyRvgWfiUVH+h4fPmOhWivHJ8eu33h
 IE5X6m66nE9FAmV8a/pVzT+bzKt+d8Tx44ola1O2/3mONY7Pi/eg79CJzvWo4AvwLmYO867U5HJ
 VdkzfFlO87WoHgQbos4J+U47iZJJnpoxCBmDMUUj3EhoXs4w4UbOTawENmiT2wEkBjcqNj8lEet
 RwpsOeXdUAE=
X-Received: by 2002:a05:600c:4e4c:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-49b91bd95b5mr7064935e9.0.1787906405805; 
 Fri, 28 Aug 2026 01:40:05 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm34428435e9.9.2026.08.28.01.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:40:05 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 28 Aug 2026 10:39:58 +0200
Subject: [PATCH 3/3] arm: mediatek: add bootembedded compatibility command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-3-bf80b489eb0f@baylibre.com>
References: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
In-Reply-To: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

RITY boot environments use bootembedded as the legacy boot target. The
command is part of the interface shared by the generated environment and
U-Boot.

Locate the appended RITY FIT script after U-Boot's separate control
devicetree and execute it through the standard source command. This avoids
duplicating the legacy boot policy in C and retains source and bootm
authentication for secure builds.

Keep the command independently selectable because legacy FIT boot does
not depend on mtk_fdt_prepare.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig            |  7 ++++
 arch/arm/mach-mediatek/Makefile           |  1 +
 arch/arm/mach-mediatek/cmd_bootembedded.c | 59 +++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index aedc5992965..a5541db13cf 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -243,6 +243,13 @@ config CMD_MTK_FDT_PREPARE
 	  Also provide the RITY-compatible dtbprobe command, or fdtprobe
 	  when devicetree authentication is enabled.
 
+config CMD_MTK_BOOTEMBEDDED
+	bool "Enable the RITY-compatible 'bootembedded' command"
+	depends on CMD_SOURCE && OF_SEPARATE
+	help
+	  Provide the RITY legacy-boot command. Locate and run the boot script
+	  appended after the separate U-Boot control devicetree.
+
 config MTK_FDT_AUTH
 	bool "Authenticate MediaTek RITY devicetrees"
 	depends on MTK_FDT_PREPARE && FIT_SIGNATURE
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index e11fddd27bc..9c595af75c4 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -5,6 +5,7 @@ obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_MTK_FDT_PREPARE)	+= fdt_prepare.o
 obj-$(CONFIG_CMD_MTK_FDT_PREPARE)	+= cmd_fdt_prepare.o
+obj-$(CONFIG_CMD_MTK_BOOTEMBEDDED)	+= cmd_bootembedded.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
diff --git a/arch/arm/mach-mediatek/cmd_bootembedded.c b/arch/arm/mach-mediatek/cmd_bootembedded.c
new file mode 100644
index 00000000000..99f92667223
--- /dev/null
+++ b/arch/arm/mach-mediatek/cmd_bootembedded.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include <asm-generic/sections.h>
+#include <command.h>
+#include <mapmem.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+
+static int do_bootembedded(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	ulong control_fdt_addr, script_addr;
+	const void *control_fdt, *script;
+	int ret;
+
+	/*
+	 * The control devicetree and the boot script are appended to the
+	 * U-Boot binary, so they stay at the load address even after U-Boot
+	 * has relocated itself. Derive that address from the image size,
+	 * which is relocation invariant, instead of from _end, which moves
+	 * with the relocated image.
+	 */
+	control_fdt_addr = CONFIG_TEXT_BASE + (ulong)(_end - (char *)&_start);
+	control_fdt = map_sysmem(control_fdt_addr, 0);
+	ret = fdt_check_header(control_fdt);
+	if (ret) {
+		printf("Invalid appended U-Boot control devicetree (%d)\n", ret);
+		goto unmap_control_fdt;
+	}
+
+	/*
+	 * RITY image generation pads the image to a multiple of 8 bytes before
+	 * appending the script ('dd bs=8 conv=sync'), because libfdt requires
+	 * 8-byte alignment. Keep both sides in sync.
+	 */
+	script_addr = ALIGN(control_fdt_addr + fdt_totalsize(control_fdt), 8);
+	unmap_sysmem(control_fdt);
+
+	script = map_sysmem(script_addr, 0);
+	ret = fdt_check_header(script);
+	unmap_sysmem(script);
+	if (ret) {
+		printf("No valid appended MediaTek boot script (%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Running appended MediaTek boot script at 0x%lx\n", script_addr);
+	return run_commandf("source %lx", script_addr);
+
+unmap_control_fdt:
+	unmap_sysmem(control_fdt);
+	return CMD_RET_FAILURE;
+}
+
+U_BOOT_CMD(bootembedded, 1, 1, do_bootembedded,
+	   "run the appended MediaTek embedded boot script", "");

-- 
2.55.0

