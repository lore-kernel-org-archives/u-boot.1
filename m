Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683ECC3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D49A82AA8;
	Thu,  8 May 2025 23:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="MKWCujdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F5882AB2; Thu,  8 May 2025 23:24:30 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1856682952
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739467; x=1746998667;
 bh=dOaXIrDBvaTvV1fLieGzxnInh3RxsSilRX+UeiTJMDM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=MKWCujdN6uVY0qLWEdmvCI5h4WNyn7/RTXhBH3yd4RU8T1QhLHQAfuSTpy5VDULAx
 nMIcgVrb1CZ622JS31o4QzjGPrVTGN1lhcyCITdnCylXmXlvo9FUqfNXHE5M5pioZi
 ESzYsaM0M1Tfpx9MBrREhJ2NbB/V2S6fBNq0GKT5OOJejhCLpQS5Px8fvnWAtjrxgT
 fZ4YMH4xcIZ2H8AJeVDORFAWsVsxTIvpEgDaQnQldB2K0VW9pp4mqM4ecLCmFGs3vs
 88DO49AqD/fWsjlUDpo0u202G7YmL8Ol7+Ty7ovkteefGoOu1nFTc+YWqRzXKwFHXq
 0RJZamZt3FmQA==
Date: Thu, 08 May 2025 21:24:21 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 07/10] include: configs: add STM32H747 discovery board
Message-ID: <20250508212058.640483-8-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 57d18879da2bd9520fcbd742d9e6c54eacf2ffc6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add initial support for the STM32H747 discovery board. The
header is copied and modified from the STM32H743 discovery
board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 include/configs/stm32h747-disco.h | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 include/configs/stm32h747-disco.h

diff --git a/include/configs/stm32h747-disco.h b/include/configs/stm32h747-=
disco.h
new file mode 100644
index 00000000000..582c0289137
--- /dev/null
+++ b/include/configs/stm32h747-disco.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copied from include/configs/stm32h743-disco.h:
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroel=
ectronics.
+ *
+ * Modified for the STM32H747-DISCO: Author: Johannes Krottmayer <johannes=
@krotti42.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <config.h>
+#include <linux/sizes.h>
+
+/* For booting Linux, use the first 16MB of memory */
+#define CFG_SYS_BOOTMAPSZ=09=09SZ_16M
+
+#define CFG_SYS_FLASH_BASE=09=090x08000000
+
+#define CFG_SYS_HZ_CLOCK=09=091000000
+
+#define BOOT_TARGET_DEVICES(func) \
+=09func(MMC, mmc, 0)
+
+#include <config_distro_bootcmd.h>
+#define CFG_EXTRA_ENV_SETTINGS=09=09=09=09\
+=09=09=09"kernel_addr_r=3D0xD0008000\0"=09=09\
+=09=09=09"fdtfile=3Dstm32h747i-disco.dtb\0"=09\
+=09=09=09"fdt_addr_r=3D0xD0408000\0"=09=09\
+=09=09=09"scriptaddr=3D0xD0418000\0"=09=09\
+=09=09=09"pxefile_addr_r=3D0xD0428000\0" \
+=09=09=09"ramdisk_addr_r=3D0xD0438000\0"=09=09\
+=09=09=09BOOTENV
+
+#endif /* __CONFIG_H */
--=20
2.39.5


