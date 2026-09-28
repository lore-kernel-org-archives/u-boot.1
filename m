Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E06FC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDC2780E1F;
	Mon, 28 Sep 2026 13:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0h1zL04oWyOS; Mon, 28 Sep 2026 13:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 66EBF80E0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602914;
	b=aDwzvI3nYh+D9yOlP35XiSI+AHsIDi/l5cUBfWhlOIkd8wd/EX9P5h5EwdbbWLmXtUfz
	 j1p1q+gEyeGF7u8ZYbnL3oTZrjHRbiUCis+K1Tw3W5NZTHkIwyvjS0vx6YO57Q1ace8xG
	 VRgKCm4vrajelKebw3LDbM8F1Pe1TbkuUIoz/1cESnYIbfsx3pHAQhESRi1LX3Y/MxjZy
	 uiecUsuiEMM4vsoYKhXetq6jyQGlfB4Hz6vcAIO0rdYsdC0dRXne103WQEnVfguRYdswZ
	 ycg4ssYllBgvxIJIMctcmVGWE6f9SlDaEWUqh5SbyF3f5HZPzMbTJkx5DWggpAhbpTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CKdNFVj5JnEg2Mn+lxPkqA68v1u16xLZ0awf3GF12zk=;
	b=Bfx5bEQdBr6PN06F3g40ATE51Eaa5/5EUk5ceW33mDYH0iwj6M8yCsj/ngsfFUzm0DW/
	 rEwE66RfPVYscTTL22F5fyGd0cSOIr8DcjAaRuO0GSFZ5Yi5XmgOa+q668sLv2SPI3RRB
	 mIxg7Doz5ndWTAtwtWaAOPKk4KjKpy26yznRVWg5Y15qaDxvgB+0fopY1ln44YbL8vDOv
	 x4UzyjRBdeOYJNiLi++XjVywlcKS7f35FRm/6AfTOZAqX19gVMvuZmqkBk6jkB5QNw/yy
	 wmoOUGhQDJQ6RHFpVMf569jvVEqCQtpbfNm5vtbuc/MFp6SgJ7Y/9mmhkHo9AzgKlWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cBQYUUOS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602914;
	bh=CKdNFVj5JnEg2Mn+lxPkqA68v1u16xLZ0awf3GF12zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rRxLZS+DvDNZW3zFUKLP0XXwlW/MNjVRqiIYuMwM/erzS70LtljRcBpxvhF4lsbs6
	 x9fgSNAIdOzviZbCaUL18JOoajzNRNf93zXYAFV4pbZdAV++BHuSFDTPDD/8oSe/09
	 312A82QOWstfEa9Rg0HODt5Jad+wH1CqFMExERakXy+57hcf78/OeQkI7Vw/gsgQ6I
	 yFAsJ1dJMLA9wKBd7Y476pKOiDeU/niqCzK2DxDXRsNmoIe5ekeAj2m9S86WYLr4+X
	 W8x4mZH4JC/8IQqhliFsZ1yxDUwjt80jJkCGEyzStPg2WC6Vw14XDTTs6ohh/OYu/u
	 WU5VmEiDt4XsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66EBF80E0B;
	Mon, 28 Sep 2026 13:41:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B18C724E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A304F80CC3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ku2ODoONvf1j for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A94A80CCB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790581143;
 b=LUw6lvURqCkoHTLFo2P490fTDq33MODuK9JsXhPsn0+Cf2qe37N1kkbmfY+E5RTnZOHG
 DVzB2zdp+9YsYnlAwkmFL8+mc9tWmJqWrIlz/M1AvK3SW4oTJOTiJpfzGb+M3VGd0Vonk
 Vhq3eQXmui8+fTVXnIa3KIpp3WuxirYru5HZhxsxSQ4tvxiL3K3kTYn/ao76NPeGdyn0q
 wmrTDo/VrOzfoO61iTYdaIfXOVPs7YjoQk9iHWzNlfdHeP3NdXvDrIgVyQ++pAhzDxbbs
 8tZDY0uTu7M2mHHfIooV+mHTFNBgP9VVpmcGd8C2JjSZX1Kx3u4AT4Iep8E2YeRzEjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790581143;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=CKdNFVj5JnEg2Mn+lxPkqA68v1u16xLZ0awf3GF12zk=;
 b=ZcOijKJBvWuf6rpgTFwKGetYPODYKxzPHYyQVpoZS2v6avgVMdH+FqMmZ4GI5+Q4Du+y
 wGOZG+3oTfqYOpTJo+gWpyHqITQIwFx7ainZ9gi7ksRM+Js+N7r7r6knq8/Lq57uD2CUa
 nUlB+SkTTbEs+EyqCyIdiIcoHE0zX77EQ77B8UngFV9wWPDo+7ff4MOaIiALBLkP6UAys
 10Q/M2cR8N6uHjVEZ31E32qFAL+Nb2fmR5vRilQtGDmybYwSLTfe49ONfhSgmf043iWPf
 xanPYAFoiQvAm+C3CzW2p11U5dtuBFYxff3QSPTWUaMCYdbIJlPgnjYlUQhe6zGrk7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cBQYUUOS; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+dinesh.v.adlinktech.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cBQYUUOS
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A94A80CCB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05B5D601FF;
 Mon, 28 Sep 2026 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEF94C4AF0B;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790581140;
 bh=k3WYtMWZ+RS0kIVX6FFycGBplaj+O9mfkzwk3L5EieM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=cBQYUUOSOVYzQ+HEO0LZWyWT9SLVsBS/BCjA0bL87UWslE4Xf/+H9vUSp5tTAI9VA
 hYK4BcVdjddUKgLDfqrP2+2zDqPX/SznmW+jDuHgweZkulu7rUdJZNFaQuro3c9m+P
 BzMlylrX6FNAz0/CJZ7g/j6XOCKTdYZVBEsd7/wlYsHTm6sFRZR4BYpENp7YnAWEb5
 FFtN0Qh+499BfWjUuEjDuNqW2KQyUL2+1PnoNx4rLwIPKbYnJEsSi7Qmd0d7mWf5rA
 DgS3hxfoMgMCPJzQ/zQe2wglRt6CWqnnvgjLqFuSK2O/2qjxN5VKovuSN2kmfi95IN
 7dDsUgnZFzqTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8F760C9833E;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
From: Dinesh kumar v via B4 Relay <devnull+dinesh.v.adlinktech.com@kernel.org>
Date: Mon, 28 Sep 2026 13:08:57 +0530
Subject: [PATCH 1/4] arm: imx9: Add ADLINK LEC-iMX95 board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lec-imx95-v1-v1-1-9e0c9b94ccbe@adlinktech.com>
References: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
In-Reply-To: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Alice Guo <alice.guo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790581138; l=11734;
 i=dinesh.v@adlinktech.com; s=20260928; h=from:subject:message-id;
 bh=qAQl2H2wr6JBFeH5/ykf13jVWFJT9XT1cyCSVHIqgfw=;
 b=qJc67zTrsokUnYTAilu/H0PgxEzcutaS8YXQjLbngjF1JljrsKFI+InT9NtPZeORz1feTiFKY
 i5c4QX7bcHQBiBmAK/sQY5aqJu7q5jZWLiJBUPuGJvVZt7ngV4usNdi
X-Developer-Key: i=dinesh.v@adlinktech.com; a=ed25519;
 pk=2+xm2aDQjQT68aPFzfLMgdZrQGpCMUU3Qp1CwWoRlus=
X-Endpoint-Received: by B4 Relay for dinesh.v@adlinktech.com/20260928 with
 auth_id=1074
X-Original-From: Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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
Reply-To: dinesh.v@adlinktech.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Dinesh kumar v <dinesh.v@adlinktech.com>

Add U-Boot support for the ADLINK LEC-iMX95 SMARC module
based on the NXP i.MX95 processor.

Add board initialization, SPL support, DDR size detection,
MMC environment handling and board configuration.

Signed-off-by: Dinesh kumar v <dinesh.v@adlinktech.com>
---
 arch/arm/mach-imx/imx9/Kconfig       | 10 +++-
 board/adlink/common/Makefile         | 26 ++++++++++
 board/adlink/common/mmc.c            | 49 ++++++++++++++++++
 board/adlink/lec_imx95/Kconfig       | 20 ++++++++
 board/adlink/lec_imx95/MAINTAINERS   |  7 +++
 board/adlink/lec_imx95/Makefile      | 11 +++++
 board/adlink/lec_imx95/lec_imx95.c   | 96 ++++++++++++++++++++++++++++++++++++
 board/adlink/lec_imx95/lec_imx95.env | 75 ++++++++++++++++++++++++++++
 board/adlink/lec_imx95/spl.c         | 79 +++++++++++++++++++++++++++++
 include/configs/lec_imx95.h          | 27 ++++++++++
 10 files changed, 399 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f95cecb6976..e13b74435f8 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -220,6 +220,14 @@ config TARGET_IMX952_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_LEC_IMX95
+	bool "ADLINK LEC-iMX95"
+	select IMX95
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	help
+	Support for the ADLINK LEC-iMX95 board
+	NXP i.MX95 Processor
 endchoice
 
 source "board/nxp/imx91_evk/Kconfig"
@@ -237,5 +245,5 @@ source "board/toradex/aquila-imx95/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
 source "board/toradex/verdin-imx95/Kconfig"
 source "board/nxp/imx952_evk/Kconfig"
-
+source "board/adlink/lec_imx95/Kconfig"
 endif
diff --git a/board/adlink/common/Makefile b/board/adlink/common/Makefile
new file mode 100644
index 00000000000..43a382431ef
--- /dev/null
+++ b/board/adlink/common/Makefile
@@ -0,0 +1,26 @@
+#
+# (C) Copyright 2006
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+MINIMAL=
+
+ifdef CONFIG_XPL_BUILD
+ifndef CONFIG_TPL_BUILD
+ifdef CONFIG_SPL_INIT_MINIMAL
+MINIMAL=y
+endif
+endif
+endif
+
+ifdef MINIMAL
+# necessary to create built-in.a
+obj- := __dummy__.a
+else
+
+obj-y += mmc.o
+
+
+endif
diff --git a/board/adlink/common/mmc.c b/board/adlink/common/mmc.c
new file mode 100644
index 00000000000..00e4f3675fe
--- /dev/null
+++ b/board/adlink/common/mmc.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2018-2022 NXP
+ */
+
+#include <command.h>
+#include <vsprintf.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/errno.h>
+#include <asm/io.h>
+#include <stdbool.h>
+#include <mmc.h>
+#include <env.h>
+
+static int check_mmc_autodetect(void)
+{
+	char *autodetect_str = env_get("mmcautodetect");
+
+	if (autodetect_str && !strcmp(autodetect_str, "yes"))
+		return 1;
+
+	return 0;
+}
+
+/* This should be defined for each board */
+__weak int mmc_map_to_kernel_blk(int dev_no)
+{
+	return dev_no;
+}
+
+void board_late_mmc_env_init(void)
+{
+	char cmd[32];
+	char mmcblk[32];
+	u32 dev_no = mmc_get_env_dev();
+
+	if (!check_mmc_autodetect())
+		return;
+
+	env_set_ulong("mmcdev", dev_no);
+
+	/* Set mmcblk env */
+	sprintf(mmcblk, "/dev/mmcblk%dp2 rootwait rw", mmc_map_to_kernel_blk(dev_no));
+	env_set("mmcroot", mmcblk);
+
+	sprintf(cmd, "mmc dev %d", dev_no);
+	run_command(cmd, 0);
+}
diff --git a/board/adlink/lec_imx95/Kconfig b/board/adlink/lec_imx95/Kconfig
new file mode 100644
index 00000000000..a23ad3cba0d
--- /dev/null
+++ b/board/adlink/lec_imx95/Kconfig
@@ -0,0 +1,20 @@
+if TARGET_LEC_IMX95
+
+config SYS_BOARD
+	default "lec_imx95"
+
+config SYS_VENDOR
+	default "adlink"
+
+config SYS_CONFIG_NAME
+	default "lec_imx95"
+
+endif
+
+if TARGET_LEC_IMX95
+
+config SKUGPIO
+	bool
+	default y
+
+endif
diff --git a/board/adlink/lec_imx95/MAINTAINERS b/board/adlink/lec_imx95/MAINTAINERS
new file mode 100644
index 00000000000..b526f047e12
--- /dev/null
+++ b/board/adlink/lec_imx95/MAINTAINERS
@@ -0,0 +1,7 @@
+LEC-i.MX95 Module
+M:	Dinesh kumar V <dinesh.v@adlinktech.com>
+S:	Maintained
+F:	board/adlink/
+F:	include/configs/lec_imx95.h
+F:	configs/lec-imx95_defconfig
+F:	doc/board/adlink/lec-imx95.rst
diff --git a/board/adlink/lec_imx95/Makefile b/board/adlink/lec_imx95/Makefile
new file mode 100644
index 00000000000..c0a042e5b1b
--- /dev/null
+++ b/board/adlink/lec_imx95/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2026 ADLINK
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += lec_imx95.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/adlink/lec_imx95/lec_imx95.c b/board/adlink/lec_imx95/lec_imx95.c
new file mode 100644
index 00000000000..fdb1635ce40
--- /dev/null
+++ b/board/adlink/lec_imx95/lec_imx95.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 ADLINK
+ */
+
+#include <env.h>
+#include <init.h>
+#include <asm/gpio.h>
+#include <asm/arch/clock.h>
+#include <linux/bitops.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/uclass.h>
+
+#define SKU_CFG_DDR_2G 0
+#define SKU_CFG_DDR_4G 1
+#define SKU_CFG_DDR_8G 2
+#define SKU_CFG_DDR_16G 3
+#define PDIR 0x50
+
+struct lec_imx95_ddr_size {
+	phys_size_t bank0;
+	phys_size_t bank1;
+};
+
+/*
+ * DDR bank sizes according to the LEC-iMX95 physical memory map.
+ */
+static const struct lec_imx95_ddr_size ddr_cfg[] = {
+	[SKU_CFG_DDR_2G] = {
+		.bank0 = 0x70000000ULL,
+		.bank1 = 0x00000000ULL,
+	},
+	[SKU_CFG_DDR_4G] = {
+		.bank0 = 0x70000000ULL,
+		.bank1 = 0x80000000ULL,
+	},
+	[SKU_CFG_DDR_8G] = {
+		.bank0 = 0x70000000ULL,
+		.bank1 = 0x180000000ULL,
+	},
+	[SKU_CFG_DDR_16G] = {
+		.bank0 = 0x70000000ULL,
+		.bank1 = 0x380000000ULL,
+	},
+};
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	return 0;
+}
+
+static int lec_imx95_get_sku(void)
+{
+	u32 skucfg;
+
+	u32 gpio;
+
+	gpio = ((readl(GPIO5_BASE_ADDR + PDIR) & 0x70) >> 4);
+	switch (gpio) {
+	case 0:
+	case 2:
+	case 4:
+	case 6:
+		skucfg = gpio >> 1;
+		break;
+	default:
+		skucfg = SKU_CFG_DDR_2G;
+	}
+
+	return skucfg;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	int sku;
+
+	if (!size)
+		return -EINVAL;
+
+	sku = lec_imx95_get_sku();
+
+	if (sku < 0 || sku >= ARRAY_SIZE(ddr_cfg))
+		sku = SKU_CFG_DDR_2G;
+
+	*size = ddr_cfg[sku].bank0 + ddr_cfg[sku].bank1;
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/adlink/lec_imx95/lec_imx95.env b/board/adlink/lec_imx95/lec_imx95.env
new file mode 100644
index 00000000000..56a71618d5f
--- /dev/null
+++ b/board/adlink/lec_imx95/lec_imx95.env
@@ -0,0 +1,75 @@
+sec_boot=no
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+image=Image
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_args pd_ignore_unused;
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${sec_boot} = yes; then
+		run auth_os;
+	else
+		if test ${boot_fit} = yes || test ${boot_fit} = try; then
+			bootm ${loadaddr};
+		else
+			if run loadfdt; then
+				run boot_os;
+			else
+				echo WARN: Cannot load the DT;
+			fi;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev}; if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else echo WARN: Secure container not found on MMC;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					if test ${mmcdev} = 1; then
+						setenv mmcdev 0;
+						setenv mmcroot /dev/mmcblk0p2 rootwait rw;
+						saveenv;
+						mmc dev ${mmcdev};
+					else
+						setenv mmcdev 1;
+						setenv mmcroot /dev/mmcblk1p2 rootwait rw;
+						saveenv;
+						mmc dev ${mmcdev};
+					fi;
+					if run loadimage; then
+						run mmcboot;
+					else echo WARN: Kernel image not found on fallback MMC;
+					fi;
+				fi;
+			fi;
+		fi;
+	fi;
+boot_fit=no
+boot_targets=mmc0 mmc1
diff --git a/board/adlink/lec_imx95/spl.c b/board/adlink/lec_imx95/spl.c
new file mode 100644
index 00000000000..72f5c8ab6f0
--- /dev/null
+++ b/board/adlink/lec_imx95/spl.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026-2027 ADLINK
+ */
+
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/sections.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+	case USB2_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#if IS_ENABLED(CONFIG_SPL_RECOVER_DATA_SECTION)
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/include/configs/lec_imx95.h b/include/configs/lec_imx95.h
new file mode 100644
index 00000000000..64e03f9c185
--- /dev/null
+++ b/include/configs/lec_imx95.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __LEC_IMX95_H
+#define __LEC_IMX95_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM				0x90000000
+
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000
+					/* Secure DDR region for A55, SPL could use first 2MB */
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+
+#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
+
+#endif

-- 
2.25.1


