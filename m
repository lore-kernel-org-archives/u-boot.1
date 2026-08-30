Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04964C61DE5
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 10:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37EBE60650;
	Sun, 30 Aug 2026 10:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqtG85lxY5Xa; Sun, 30 Aug 2026 10:18:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788085138;
	bh=wO4Az9WH4jzQhmeiEqCK0hxgVpcwZ4ZmBmCoqHKe8zI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0tRHnV3wghG7SQXOx+lbZGnPoKqJyb2kTritugZqmpoPphh2mqbFFmd+kKr6J2XvY
	 nDF2ZS5ETVto4H4ldtgQhaCmzBZTSSplkXKbTUVXsqYAAor0nTHIjpuo1ZU2qoqvKm
	 rxdUbAbYlAzeXkSUFR18neKXiExMapXLEiVkQQ5LKpOSwEhZcsdV+lHQVHujXL12al
	 69bNRJVObXyK+rLft+OesjYpsrrsJb8XJyUiop5YM3RQNnbSzczRNno1nxecHqP1xX
	 4rvy/idLlohAVcm5DRkUhGRUDDRNrYdYgDq7uITIgnsG1E5wwERkQXqsC9WIegAqIi
	 sfCA1PagbFbkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFDB16062D;
	Sun, 30 Aug 2026 10:18:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0871C2FD
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDE50405E8
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14BlYBi7aZa3 for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 10:18:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CDtoaGNf
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB588405D8
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:51 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so108768f8f.2
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788085129; x=1788689929;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wO4Az9WH4jzQhmeiEqCK0hxgVpcwZ4ZmBmCoqHKe8zI=;
 b=CDtoaGNfS29dWIubTCEUCUkORDV+phnJR3amK/nJ0rOsuIplya+/ommhGC0nso8lB5
 JJ0xGVXNdQsmu6uI+L69mrHpFFIWEtPm3hW+epS4TzAo+hYIGjEDQM7QIR4XBkzHehSn
 PyMaF7PyfY6tpEoAyz3th3vzkxEM1rvqPAmC4jwE3475Y9g1D3E/Yro3iPfmjxpggtUI
 36sNVTVcBnwojw24SL1XG4kGuB85OPzjF+x59eIPFvsDyyS4xDJbMdAZzcTBQxdK3c7V
 lR7NXPy2EM5qSc+o2jS/TrSSIEQetN8ibmpD1K90k+lLCcw7HtHwm/NH2wVZYWehKDfq
 rEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788085129; x=1788689929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wO4Az9WH4jzQhmeiEqCK0hxgVpcwZ4ZmBmCoqHKe8zI=;
 b=MNGwRnqiep4mSM+3Kl1/AJnX8q1mjo6tGi9b2PV6uS6ZFa5/r0b2CeL8agv2agNRU8
 Tfy8UXfOp64ky6R20UerUfRdwEOShAxifK6yN3ZcUNCsAAkS9Ecq5Jm+xsE8afcmomEp
 sKRAEjlqF8C0QaWNO8gwEsfq9VxGS5UBUAofBmeUQsS2McGrPL+gbQscs///OU0N5AyM
 X1XcSn8takqCnlJNkNi2tv2kPL8sDs3dlpQugOR1OPQ8MJckUssJyjmxIPTn71/b22/r
 8ld5lkrpy86Ss9krMMotR8jJcywAO8LgLWBJN+FKzCFl8VChzkOOnPF+N8KR+R4X/evZ
 jWzw==
X-Forwarded-Encrypted: i=1;
 AKwUvByRV8s0CtaePapGSxu1Lrn2WpdoEkqm8wW+kvoJuKM7yZp5P1Wmsypno1IhIEipVzh10G1G6Pg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n+i2oRvhQjBGcNBOOvyYC76eP9zdkDmqykveY3CgIWLrvC+fyt
 L6n6MWZ9qsyKuzZRy28VropphENyhNURzulIv+62lKaJV7KU8csWnWWClhv4wrQXxVg=
X-Gm-Gg: AYBFou28m9MhbARsLYyYVbFuonfi/nG3iMvMxbgWjOx2rfC6gpAPzS/24AuISHrFET+
 8gLrsY305exnafYUca7v0qapxGFRmor/tbpGBi7Fe5ZRBgyMyeikYJl2slOYd4rfBd52qx0jQ0W
 +DQeGzxRUcTPGuQt3Yk/SGZelflSu1PnYL+XyeiiuSSc2L5JOdTXkyDf4LUxi/AoKLWNohTbK4V
 wkoPgLXazysusdjsQ5jNkI0UfMegfFuGXyx1tCvUWCGqEsaNNPsJGDhMt67Mm2jhWZjFqv82FH6
 Q1XYz00SIG9W23+7LYZgFaVnZBd5N33sUP5ZLTQAIiOXqmiNdU7gbDfIY+EMnqp4bg1MFPM/1J2
 eTRQNBXso8VbAVWCeh5ZgzHUpR57FYZej9yCqOXJqn3+4EvSJXHuBg5pVjQYjnkfn/clcXKvqPZ
 tPYbo8yPUNIc5EqtNj/xzxyvMRyOiPUQsjTM57zhQSXUAVRPTzFawL0FcKeoZZPIEFRL8zdmZ1O
 fK/lb8u63t1P9lqnatH1/JCaJjyAvDAmruyzxnmD1ygyy1oWLMIokiZGswmwnVjMiyiV3dhHriV
 /ENw
X-Received: by 2002:a05:6000:71d:b0:481:57ef:9221 with SMTP id
 ffacd0b85a97d-482f79fbba8mr33326101f8f.22.1788085129433; 
 Sun, 30 Aug 2026 03:18:49 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fcesm14644619f8f.5.2026.08.30.03.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 03:18:49 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 30 Aug 2026 12:18:41 +0200
Subject: [PATCH v2 3/3] arm: mediatek: add bootembedded compatibility command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-3-f9cfce2ed42a@baylibre.com>
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
In-Reply-To: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
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
 <pablo.sun@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Ramax_Lo_=28=E7=BE=85=E6=98=8E=E9=81=A0=29?= <Ramax.Lo@mediatek.com>,
 =?utf-8?q?Chris-qj_Chen_=28=E9=99=B3=E5=A5=87=E9=80=B2=29?=
 <Chris-qj.Chen@mediatek.com>
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
not depend on mtk_fdt_prepare. Place it under cmd/mediatek and document the
expected appended-image layout and execution path.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/mediatek/Kconfig           |  7 +++++
 cmd/mediatek/Makefile          |  1 +
 cmd/mediatek/bootembedded.c    | 59 ++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/bootembedded.rst | 51 ++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/cmd/mediatek/Kconfig b/cmd/mediatek/Kconfig
index 31fa6e8d528..1a06c25c627 100644
--- a/cmd/mediatek/Kconfig
+++ b/cmd/mediatek/Kconfig
@@ -21,4 +21,11 @@ config CMD_MTK_FDT_PREPARE
 	  Also provide the RITY-compatible dtbprobe command, or fdtprobe
 	  when devicetree authentication is enabled.
 
+config CMD_MTK_BOOTEMBEDDED
+	bool "Enable the RITY-compatible 'bootembedded' command"
+	depends on CMD_SOURCE && OF_SEPARATE
+	help
+	  Provide the RITY legacy-boot command. Locate and run the boot script
+	  appended after the separate U-Boot control devicetree.
+
 endif
diff --git a/cmd/mediatek/Makefile b/cmd/mediatek/Makefile
index 82f3d0dc412..93e6847d7ac 100644
--- a/cmd/mediatek/Makefile
+++ b/cmd/mediatek/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_CMD_MTK_FDT_PREPARE) += fdt_prepare.o
+obj-$(CONFIG_CMD_MTK_BOOTEMBEDDED) += bootembedded.o
diff --git a/cmd/mediatek/bootembedded.c b/cmd/mediatek/bootembedded.c
new file mode 100644
index 00000000000..99f92667223
--- /dev/null
+++ b/cmd/mediatek/bootembedded.c
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
diff --git a/doc/usage/cmd/bootembedded.rst b/doc/usage/cmd/bootembedded.rst
new file mode 100644
index 00000000000..ebb2e5a32b0
--- /dev/null
+++ b/doc/usage/cmd/bootembedded.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com>
+
+.. index::
+   single: bootembedded (command)
+
+bootembedded command
+====================
+
+Synopsis
+--------
+
+::
+
+    bootembedded
+
+Description
+-----------
+
+The ``bootembedded`` command runs the RITY legacy boot script appended to the
+U-Boot image. It locates U-Boot's separate control devicetree immediately
+after the binary, validates it and uses its size to locate the script at the
+next 8-byte-aligned address.
+
+The appended script is passed to the standard :doc:`source` command. The
+script retains the legacy boot policy and can use the standard ``bootm``
+authentication path for secure boot.
+
+Image layout
+------------
+
+The command expects this layout at ``CONFIG_TEXT_BASE``::
+
+    +----------------------------+
+    | U-Boot binary              |
+    +----------------------------+
+    | separate control DTB       |
+    +----------------------------+
+    | padding to 8-byte boundary |
+    +----------------------------+
+    | RITY FIT boot script       |
+    +----------------------------+
+
+RITY image generation pads the control devicetree and script boundary with
+``dd bs=8 conv=sync``.
+
+Configuration
+-------------
+
+The command is available when ``CONFIG_CMD_MTK_BOOTEMBEDDED`` is enabled. It
+requires ``CONFIG_CMD_SOURCE`` and ``CONFIG_OF_SEPARATE``.

-- 
2.55.0

