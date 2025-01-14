Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B75E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887398070F;
	Tue, 14 Jan 2025 18:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="OW1DOj4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A821E8060C; Tue, 14 Jan 2025 17:47:32 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F848007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736873248; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NS/uX7kXD+lmnSUe00T1OMtRNHzAUuUuanz7JHsgoBrlW73GySOphZ0aP2mnkrkKDU2o0/Q4ckTreE6nUWwgga2YF0hFx0VzmrxBUjtAYC+9nk5BppSOlyubstZjK6sIcFimncqutRmxhyWdpM2xczaRGLjfcLH1AKBWw1S4uBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736873248;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cM+0bdRI4hRxjAjNHqrtZXnyivPlM8kSud5+VzRtOX8=; 
 b=g9xqI5dEMte1J19tmRWrjc9O2hMOsT+5DcEUvBARhSP2ErJFekFViQLgAstsf7aYwBeD5nUmyFEBw9SA48lC/a4zl3GO51HK3rvui/or6xMp3MZGPFYvsZjwtSk8P4TTFR2MGoawsMmgBp9EbPGQmdJ6S3qVrh6BeYkCt42SwB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736873248; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=cM+0bdRI4hRxjAjNHqrtZXnyivPlM8kSud5+VzRtOX8=;
 b=OW1DOj4bCYsHuhHwcIUiJd8PMfyWIPMfBkb/p+6QEGPH0k+fZMWLz/AU6gmMs7rS
 1kQnH4uHuP1eH+AYUsm2DLDLt5R29Tth6JME0CHHc2KBdUyD8HF7s7TS8gLqaQKk161
 lyrjNtTtqpFoTbML1PCi5o1M96/fRQzWvJ3StqJ4=
Received: by mx.zohomail.com with SMTPS id 1736873245733592.4976481646285;
 Tue, 14 Jan 2025 08:47:25 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 15 Jan 2025 00:46:40 +0800
Subject: [PATCH 4/5] riscv: canaan: k230_canmv: Add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-k230-dev-1-v1-4-f4b77259e34a@pigmoral.tech>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
In-Reply-To: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736873211; l=3142;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=J3TIvCk6QCxoTuYwfGTD1QIfouiGEHus6nTA58p70A4=;
 b=djN0081mP1q7FhLaWozClU7Y/N2UUorp48hwKyM0TWf6xGXFYZ/oRety4XOgW32unnBM7ydxC
 741b1gR2VP7Cn/fxmtQlUstJP47QGtPx9j4SHUealnxpkbAwVMObDxb
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 14 Jan 2025 18:26:11 +0100
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

Add support for K230 CanMV board with serial console and usb otg
support. It can boot via vendor's u-boot-spl and boot into Linux
via tftp through the onboard RTL8152.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 board/canaan/k230_canmv/Kconfig     | 19 +++++++++++++++++++
 board/canaan/k230_canmv/MAINTAINERS |  6 ++++++
 board/canaan/k230_canmv/Makefile    |  5 +++++
 board/canaan/k230_canmv/board.c     |  9 +++++++++
 configs/k230_canmv_defconfig        | 19 +++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/board/canaan/k230_canmv/Kconfig b/board/canaan/k230_canmv/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..e793e9993e8e72de43931f3a40b1020c43b7160b
--- /dev/null
+++ b/board/canaan/k230_canmv/Kconfig
@@ -0,0 +1,19 @@
+if TARGET_K230_CANMV
+
+config SYS_BOARD
+	default "k230_canmv"
+
+config SYS_VENDOR
+	default "canaan"
+
+config SYS_CPU
+	default "k230"
+
+config TEXT_BASE
+	default 0x0
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select CANAAN_K230
+
+endif
diff --git a/board/canaan/k230_canmv/MAINTAINERS b/board/canaan/k230_canmv/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..fb925e1b16748754e289ce28a29b7acb890b2e2f
--- /dev/null
+++ b/board/canaan/k230_canmv/MAINTAINERS
@@ -0,0 +1,6 @@
+K230 CANMV
+M:	Junhui Liu <junhui.liu@pigmoral.tech>
+S:	Maintained
+F:	board/canaan/k230_canmv/
+F:	configs/k230_canmv_defconfig
+F:	doc/board/canaan/k230_canmv.rst
diff --git a/board/canaan/k230_canmv/Makefile b/board/canaan/k230_canmv/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..acab631106ab17db04d2e98b0a7fa2a00b4f7d2f
--- /dev/null
+++ b/board/canaan/k230_canmv/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
+
+obj-y += board.o
diff --git a/board/canaan/k230_canmv/board.c b/board/canaan/k230_canmv/board.c
new file mode 100644
index 0000000000000000000000000000000000000000..a705ee8f67be5ae5b1b3e7e4371a71f82da1b4c3
--- /dev/null
+++ b/board/canaan/k230_canmv/board.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/k230_canmv_defconfig b/configs/k230_canmv_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..47fa1add2a9c5a80bb613216bd4b7363b486ae29
--- /dev/null
+++ b/configs/k230_canmv_defconfig
@@ -0,0 +1,19 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80400000
+CONFIG_DEFAULT_DEVICE_TREE="k230-canmv"
+CONFIG_SYS_LOAD_ADDR=0xc000000
+CONFIG_TARGET_K230_CANMV=y
+CONFIG_ARCH_RV64I=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="K230# "
+CONFIG_CMD_USB=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_RTL8152=y

-- 
2.47.1

