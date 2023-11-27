Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1568C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C0F877B5;
	Mon, 27 Nov 2023 19:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="owAtwJ72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D33877B5; Mon, 27 Nov 2023 19:28:11 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB1F875A1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 0CBA1240104
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1701109689; bh=g9ukzM6uZ1p/qGbjYgoa2fB9Cx3+mq8HCWrf+jmxyB0=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=owAtwJ72+iQIlarCdATXDMg8nPBxy++lrnjkobZr6GlRenxvPS9+K7VrAiMLL0Opc
 s8hph+e6ox44vZsOgLBg3W5t+0hET7a6922WoU/eWBJrjb1gMDPHbSM6DQKSfQwosO
 ZVml7FsafTqIjb4JHmWxk4iRbC41l3iQ0ZBagwtd+hSTik58btmfjpslLx917HmVMl
 ZkntfoUgH0k3s0qlomxHbgZDS9fHbNrQNeatN8J4tbCmfEQL3OrrqioTOPTWfU5aFo
 dN0RnkgdVcsKhAeQyuDFdYt4DL2e1KFupWKxLDjmcFsxmKaHmWHKkPmqA3MYbG1ie0
 Sw3kf18V5k2Mg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4SfDbr3RJjz6tx8;
 Mon, 27 Nov 2023 19:28:08 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v2 2/2] arm: s5p4418: fix relocation of vectors
Date: Mon, 27 Nov 2023 18:26:09 +0000
Message-Id: <20231127182609.4663-3-stefan_b@posteo.net>
In-Reply-To: <20231127182609.4663-1-stefan_b@posteo.net>
References: <20231127182609.4663-1-stefan_b@posteo.net>
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

The header (NSIH) used for the s5p4418-SoC is not loaded into RAM by the
2nd-bootloader, see boot0.h. Therefore, use an adapted version of
relocate_vectors which relocates the vectors after the header (at _start)
instead of the 'dummy'-vectors at the start of the header (at
__image_copy_start).

Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
---

(no changes since v1)

 arch/arm/cpu/armv7/s5p4418/Makefile   |  3 +++
 arch/arm/cpu/armv7/s5p4418/relocate.S | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S

diff --git a/arch/arm/cpu/armv7/s5p4418/Makefile b/arch/arm/cpu/armv7/s5p4418/Makefile
index 321b257b6d..58042581c4 100644
--- a/arch/arm/cpu/armv7/s5p4418/Makefile
+++ b/arch/arm/cpu/armv7/s5p4418/Makefile
@@ -2,5 +2,8 @@
 #
 # (C) Copyright 2016 Nexell
 # Hyunseok, Jung <hsjung@nexell.co.kr>
+#
+# Copyright (C) 2023  Stefan Bosch <stefan_b@posteo.net>
 
 obj-y += cpu.o
+obj-y += relocate.o
diff --git a/arch/arm/cpu/armv7/s5p4418/relocate.S b/arch/arm/cpu/armv7/s5p4418/relocate.S
new file mode 100644
index 0000000000..d6e76adceb
--- /dev/null
+++ b/arch/arm/cpu/armv7/s5p4418/relocate.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  relocate - S5P4418 specific relocation for ARM U-Boot
+ *
+ *  Copyright (c) 2013  Albert ARIBAUD <albert.u.boot@aribaud.net>
+ *  Copyright (C) 2023  Stefan Bosch <stefan_b@posteo.net>
+ */
+
+#include <asm-offsets.h>
+#include <asm/assembler.h>
+#include <linux/linkage.h>
+
+ENTRY(relocate_vectors)
+
+	/*
+	 * The s5p4418 SoC has the security extensions, so use VBAR to relocate
+	 * the exception vectors.
+	 */
+	ldr	r0, [r9, #GD_RELOCADDR]	/* r0 = gd->relocaddr */
+	add	r0, #0x400			/* vectors are after NSIH + 0x200 */
+	mcr	p15, 0, r0, c12, c0, 0	/* Set VBAR */
+	ret	lr
+
+ENDPROC(relocate_vectors)
-- 
2.17.1

