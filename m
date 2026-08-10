Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A332FC5AE49
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 14:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AA6F80BF5;
	Mon, 10 Aug 2026 14:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_jdoyw39lfa; Mon, 10 Aug 2026 14:38:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AFB680C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786372687;
	bh=i2DP6LhRQ9AVnawUGU46fuSWLfM4bF//mRfBvpU73so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pRUDDVkgJVV8LxWK+VifUUubmFzp+UomkKOLVNsyaP8rmq4y7dhemW255QdS4cWgc
	 hwyRB90EKqJPyMarTSNICP73wrOOJFLSei3eOQP5iibLhiy6gNoeD2lvGAZn8VGSC8
	 pgE6SFz/6pLaBeecB1Smh3yboBL3pYFwKf5XxmSp6gTgB8/W0r+h0krX2NbfaXiUTv
	 oFUPIW3ZZmX6HG6yqNrs7YjGJMvAmRqp31S+omGi4ZG+LeylOmqyQTU5jd5TZgG539
	 8LE2KCuv5xNZDI3DXxYaW2u4V5V56J1/UKakLv4A2ONJFNZiJR17tn18osLU0rX9Hj
	 12TeUw+Xd/5CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AFB680C1C;
	Mon, 10 Aug 2026 14:38:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0292910E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD5C980C1C
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yn2uLpBNTOSX for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 14:38:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::d9; helo=mta1.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EF8E280BF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF8E280BF5
Received: from mta1.migadu.com (out-217.mta1.migadu.com
 [IPv6:2001:41d0:203:375::d9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF8E280BF5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:38:03 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: from meli-email.org (160.90.43.132)
 by mta10.migadu.com with ESMTPS id 58c0de219b813361;
 Mon, 10 Aug 2026 14:37:51 +0000
X-Migadu-Scanner: mta10.migadu.com
Date: Mon, 10 Aug 2026 14:30:30 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 3/4] board: amlogic: add Khadas VIM4 support
User-Agent: meli/0.8.13
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-4-tanure@linux.com>
In-Reply-To: <20260806101809.72526-4-tanure@linux.com>
Message-ID: <tjk5yq.2kzx2i3phlgjs@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=qxhXtg9IYIx5zlh2t0bMQL/9ezBqi36a7f9x9EyrJ4s=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786372681; v=1; x=1786977481;
 b=lEkc0IdmGSSmieDjrqJtcxOaslQ7fNV2OS6PsRVgRi25Ai1HZ28bJYnGZI/7IIT76V1SSq3M
 bRn9A865QMtwialmkUlbYzMejvQQk86KWHUr62fuFgaXTp5hUdqakdC2Z/2vdeuZDKa0J2lZb7N
 dHvy/QIXKYez5w8o0DktJlHFch8/EophWxxo9S2B85PfDODoDkJporCSOZt+GzPi3el++i9XE10
 Irz3NXtBUMKza6G2dTNrmcuJp04EzlkyI/svFlFUsQtZcojXlcP0tvViEsv3iRpDNMaj8gxKyOx
 m5w4KbbECrRI0AVc43TIGqbl937C7HJ6Fz3DC+RH06B6w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=lEkc0Idm
X-Mailman-Original-Authentication-Results: mta10.migadu.com;
	none
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>Add initial support for the Khadas VIM4 board (Amlogic A311D2, T7
>family): UART console, DRAM (first bank), PSCI reset through BL31 and
>the secure monitor. Storage, network and USB support come later.
>
>The image is position independent with TEXT_BASE=0, so the same
>u-boot.bin can be chainloaded from the vendor U-Boot for development
>or packaged as BL33 into the vendor boot image.
>
>The console runs at 921600 baud, the serial console convention on the
>VIM4 (this is also how BL2 configures uart_a).
>
>Assisted-by: Claude:claude-fable-5
>Signed-off-by: Lucas Tanure <tanure@linux.com>
>---
> .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi | 22 +++++++++++++++
> board/amlogic/vim4/MAINTAINERS                |  7 +++++
> board/amlogic/vim4/Makefile                   |  4 +++
> board/amlogic/vim4/vim4.c                     | 14 ++++++++++
> configs/khadas-vim4_defconfig                 | 27 +++++++++++++++++++
> 5 files changed, 74 insertions(+)
> create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
> create mode 100644 board/amlogic/vim4/MAINTAINERS
> create mode 100644 board/amlogic/vim4/Makefile
> create mode 100644 board/amlogic/vim4/vim4.c
> create mode 100644 configs/khadas-vim4_defconfig
>
>diff --git a/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>new file mode 100644
>index 00000000000..dde2cd804e3
>--- /dev/null
>+++ b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>@@ -0,0 +1,22 @@
>+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>+/*
>+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+/ {
>+	chosen {
>+		stdout-path = "serial0:921600n8";
>+	};
>+
>+	soc {
>+		bootph-all;
>+	};
>+};
>+
>+&uart_a {
>+	bootph-all;
>+};
>+
>+&xtal {
>+	bootph-all;
>+};

Maybe this should go in a common amlogic-t7-u-boot dts instead of
something board-specific?

>diff --git a/board/amlogic/vim4/MAINTAINERS b/board/amlogic/vim4/MAINTAINERS
>new file mode 100644
>index 00000000000..5e1ec98b571
>--- /dev/null
>+++ b/board/amlogic/vim4/MAINTAINERS
>@@ -0,0 +1,7 @@
>+VIM4
>+M:	Lucas Tanure <tanure@linux.com>
>+S:	Maintained
>+L:	u-boot-amlogic@groups.io
>+F:	board/amlogic/vim4/
>+F:	configs/khadas-vim4_defconfig
>+F:	arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>diff --git a/board/amlogic/vim4/Makefile b/board/amlogic/vim4/Makefile
>new file mode 100644
>index 00000000000..0cc4078c549
>--- /dev/null
>+++ b/board/amlogic/vim4/Makefile
>@@ -0,0 +1,4 @@
>+# SPDX-License-Identifier: GPL-2.0+
>+# (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+
>+obj-y	:= vim4.o
>diff --git a/board/amlogic/vim4/vim4.c b/board/amlogic/vim4/vim4.c
>new file mode 100644
>index 00000000000..5db3deefe0e
>--- /dev/null
>+++ b/board/amlogic/vim4/vim4.c
>@@ -0,0 +1,14 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+#include <init.h>
>+#include <asm/arch/eth.h>
>+
>+int misc_init_r(void)
>+{
>+	meson_generate_serial_ethaddr();
>+
>+	return 0;
>+}
>diff --git a/configs/khadas-vim4_defconfig b/configs/khadas-vim4_defconfig
>new file mode 100644
>index 00000000000..10a64c07a88
>--- /dev/null
>+++ b/configs/khadas-vim4_defconfig
>@@ -0,0 +1,27 @@
>+CONFIG_ARM=y
>+CONFIG_POSITION_INDEPENDENT=y
>+CONFIG_ARCH_MESON=y
>+CONFIG_TEXT_BASE=0x00000000
>+CONFIG_NR_DRAM_BANKS=1
>+CONFIG_ENV_SIZE=0x2000
>+CONFIG_DM_GPIO=y
>+CONFIG_DEFAULT_DEVICE_TREE="amlogic/amlogic-t7-a311d2-khadas-vim4"
>+CONFIG_OF_LIBFDT_OVERLAY=y
>+CONFIG_MESON_T7=y
>+CONFIG_SYS_LOAD_ADDR=0x10000000
>+CONFIG_DEBUG_UART_BASE=0xfe078000
>+CONFIG_DEBUG_UART_CLOCK=24000000
>+CONFIG_IDENT_STRING=" khadas-vim4"
>+CONFIG_DEBUG_UART=y
>+CONFIG_OF_BOARD_SETUP=y
>+# CONFIG_DISPLAY_CPUINFO is not set
>+# CONFIG_DISPLAY_BOARDINFO is not set
>+CONFIG_SYS_PROMPT="kvim4> "

Leave this unset

>+# CONFIG_CMD_BDI is not set
>+# CONFIG_CMD_IMI is not set
>+CONFIG_CMD_CACHE=y
>+CONFIG_OF_CONTROL=y
>+CONFIG_BAUDRATE=921600
>+CONFIG_DEBUG_UART_ANNOUNCE=y
>+CONFIG_DEBUG_UART_SKIP_INIT=y
>+CONFIG_MESON_SERIAL=y
>-- 
>2.55.0

Best regards,
Ferass
