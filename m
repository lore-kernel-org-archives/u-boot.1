Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004D4C3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1438782A39;
	Thu,  8 May 2025 23:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="RXjaTOVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4982828C2; Thu,  8 May 2025 23:24:18 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC09182A39
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739456; x=1746998656;
 bh=rG8H1fUfFpdfB2tgsS0VpOYOPML2LmWbd5tiOBSPvrk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=RXjaTOVo2ZPmygvXKEFLmT2Ljpey0BKAldibewdiGpsQ8S6aFxjcaP0qKOBHBZkNg
 JDFtJUmOkumQEh5aQnE13sC+8wmzGSMX/6t1TO+IzxIRPK60A6IwS0AqkfIwH/gvHf
 0DQJQC0zt7nbbpGnYisaLjZiUmqaZ0qcDZLsW2Y6XyQ716zOJuKFOl1dZkx24P6fKN
 z5q4WVUGDhsto5A3DUK8JzJrILkUetaRmpkkmDzHkFYDWxLo1/hvdTCFGUDvRT59Ul
 KPlMTxdxZ1E7DpiRoEkop1ojikKZxnZdyiww4Ig0TWKfClqCHXmvoS1Tp4QOKemCmC
 NYI4Ms/Nz9tqg==
Date: Thu, 08 May 2025 21:24:12 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 05/10] board: st: add STM32H747 discovery board
Message-ID: <20250508212058.640483-6-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 90b57302e21ae46cec56a001a3bf99bced65d811
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

The code was copied from the STM32H743 discovery board and
modified for the STM32H747 discovery board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 board/st/stm32h747-disco/Kconfig           | 15 ++++++++
 board/st/stm32h747-disco/MAINTAINERS       |  8 ++++
 board/st/stm32h747-disco/Makefile          | 10 +++++
 board/st/stm32h747-disco/stm32h747-disco.c | 43 ++++++++++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 board/st/stm32h747-disco/Kconfig
 create mode 100644 board/st/stm32h747-disco/MAINTAINERS
 create mode 100644 board/st/stm32h747-disco/Makefile
 create mode 100644 board/st/stm32h747-disco/stm32h747-disco.c

diff --git a/board/st/stm32h747-disco/Kconfig b/board/st/stm32h747-disco/Kc=
onfig
new file mode 100644
index 00000000000..a7b2c09a327
--- /dev/null
+++ b/board/st/stm32h747-disco/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_STM32H747_DISCO
+
+config SYS_BOARD
+=09default "stm32h747-disco"
+
+config SYS_VENDOR
+=09default "st"
+
+config SYS_SOC
+=09default "stm32h7"
+
+config SYS_CONFIG_NAME
+=09default "stm32h747-disco"
+
+endif
diff --git a/board/st/stm32h747-disco/MAINTAINERS b/board/st/stm32h747-disc=
o/MAINTAINERS
new file mode 100644
index 00000000000..afca1b913ce
--- /dev/null
+++ b/board/st/stm32h747-disco/MAINTAINERS
@@ -0,0 +1,8 @@
+STM32H747 DISCOVERY BOARD
+M:=09Patrice Chotard <patrice.chotard@foss.st.com>
+S:=09Maintained
+F:=09doc/board/st/
+F:=09board/st/stm32h747-disco
+F:=09include/configs/stm32h747-disco.h
+F:=09configs/stm32h747-disco_defconfig
+F:=09arch/arm/dts/stm32h7*
diff --git a/board/st/stm32h747-disco/Makefile b/board/st/stm32h747-disco/M=
akefile
new file mode 100644
index 00000000000..b0ba62fa3b7
--- /dev/null
+++ b/board/st/stm32h747-disco/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copied from board/st/stm32h743-disco/Makefile:
+#
+# Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+# Author(s): Patrice CHOTARD, <patrice.chotard@foss.st.com> for STMicroele=
ctronics.
+#
+# Modified for the STM32H747-DISCO: Author: Johannes Krottmayer <johannes@=
krotti42.com>
+
+obj-y=09:=3D stm32h747-disco.o
diff --git a/board/st/stm32h747-disco/stm32h747-disco.c b/board/st/stm32h74=
7-disco/stm32h747-disco.c
new file mode 100644
index 00000000000..538174391d6
--- /dev/null
+++ b/board/st/stm32h747-disco/stm32h747-disco.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copied from board/st/stm32h743-disco/stm32h743-disco.c:
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author(s): Patrice Chotard, <patrice.chotard@foss.st.com> for STMicroel=
ectronics.
+ */
+
+#include <dm.h>
+#include <init.h>
+#include <log.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+=09struct udevice *dev;
+=09int ret;
+
+=09ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
+=09if (ret) {
+=09=09debug("DRAM init failed: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09if (fdtdec_setup_mem_size_base() !=3D 0)
+=09=09ret =3D -EINVAL;
+
+=09return ret;
+}
+
+int dram_init_banksize(void)
+{
+=09fdtdec_setup_memory_banksize();
+
+=09return 0;
+}
+
+int board_init(void)
+{
+=09return 0;
+}
--=20
2.39.5


