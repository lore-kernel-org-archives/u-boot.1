Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498AEC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B51688BBB;
	Wed,  1 May 2024 04:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PZh2TgsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6412288BD0; Wed,  1 May 2024 04:44:56 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B26488BB8
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b4043b7b3so36829446d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531493; x=1715136293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe3m2h+uWwx9QgZAercqZnZVdRmK92/5BWIxB30XEgQ=;
 b=PZh2TgsDSxneOQofnUjJzzEz+pIV3kXoUboSvBXyupMTTcddY2SXIOkifdbmxGucBh
 swYt7olOznANuIEbgaCOFo52HbgxaiNfXWFkBRESGqwlb+/JyULiCBfK1mx1eTQ1k8J+
 Ok1lzwnArVD6Eu8hWonLkUMkDKM5PedjQetuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531493; x=1715136293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qe3m2h+uWwx9QgZAercqZnZVdRmK92/5BWIxB30XEgQ=;
 b=seVTl1xxjOKrh2753eQeS8ZUkjOYJaTAinEE2ctSb9q81gFql+TUnHbVgL7ygWPc/G
 cpawlCK08wWT43SEQqeu+XuAPh3vPBdfhEpTkCC5/uQEV7ep7W3qrbi9JXyR7USqoc0B
 cYMqM/lR+M3vesPhF7l0hXeyPNjOPdmz21/0frZElW1WccAMmK5bmQ4EZ83Gsc+Sxqg/
 BY4K7MSKp0sAmOfFTffalfh9wqfOfLnhs1/pEoqjPjBG87cTxBj7mTS3NmQTQyCwiJZK
 8oTACY+y7RLwgEC7NJb70AMDAj/zZLOcAZU1nBNrA6TbEAQ/n1WJYKXK7/S2hh2HvtPz
 uZnQ==
X-Gm-Message-State: AOJu0YxWTAQLERK07qtUxfh1ZGecDuS8fYnv7vSBjm0wk2KzSydhP9df
 OuwbbRn9iJRhH8fG8eFTP54GO6wV6EAFsct9wW2WmXk/ZBKdU3gNuj4J0/E4CYXfokMvaXblWjA
 7HO0Blw==
X-Google-Smtp-Source: AGHT+IEllgMIHWTpzDB+06VfS8u0qfDj+BlKnBUwRrmnI8PFlmu9UTmqZOUqjkQ5335O2NyjlqB21Q==
X-Received: by 2002:a05:6214:29c3:b0:6a0:cd13:fb7a with SMTP id
 gh3-20020a05621429c300b006a0cd13fb7amr1252366qvb.24.1714531492664; 
 Tue, 30 Apr 2024 19:44:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>
Subject: [PATCH 080/149] board: kontron: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:07 -0600
Message-Id: <20240501024316.1767971-80-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heiko Thiery <heiko.thiery@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Michael Walle <michael@walle.cc>
---
 board/kontron/pitx_imx8m/pitx_imx8m.c  | 1 -
 board/kontron/pitx_imx8m/spl.c         | 2 +-
 board/kontron/sl-mx8mm/lpddr4_timing.c | 1 -
 board/kontron/sl28/cmds.c              | 3 ++-
 board/kontron/sl28/common.c            | 2 +-
 board/kontron/sl28/ddr.c               | 2 +-
 board/kontron/sl28/sl28.c              | 1 -
 board/kontron/sl28/spl.c               | 2 +-
 board/kontron/sl28/spl_atf.c           | 2 +-
 9 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/board/kontron/pitx_imx8m/pitx_imx8m.c b/board/kontron/pitx_imx8m/pitx_imx8m.c
index 4548e7c1dff9..a908aee9eccf 100644
--- a/board/kontron/pitx_imx8m/pitx_imx8m.c
+++ b/board/kontron/pitx_imx8m/pitx_imx8m.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include "pitx_misc.h"
-#include <common.h>
 #include <efi.h>
 #include <efi_loader.h>
 #include <init.h>
diff --git a/board/kontron/pitx_imx8m/spl.c b/board/kontron/pitx_imx8m/spl.c
index a247803a4b46..475e52f62314 100644
--- a/board/kontron/pitx_imx8m/spl.c
+++ b/board/kontron/pitx_imx8m/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
+#include <config.h>
 #include <errno.h>
 #include <fsl_esdhc_imx.h>
 #include <hang.h>
diff --git a/board/kontron/sl-mx8mm/lpddr4_timing.c b/board/kontron/sl-mx8mm/lpddr4_timing.c
index 74b79c7a009f..851aeef8f8c2 100644
--- a/board/kontron/sl-mx8mm/lpddr4_timing.c
+++ b/board/kontron/sl-mx8mm/lpddr4_timing.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/kontron/sl28/cmds.c b/board/kontron/sl28/cmds.c
index 08a22b5d01e0..7851361c48cc 100644
--- a/board/kontron/sl28/cmds.c
+++ b/board/kontron/sl28/cmds.c
@@ -5,10 +5,11 @@
  * Copyright (c) 2020 Kontron Europe GmbH
  */
 
-#include <common.h>
 #include <command.h>
 #include <i2c.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 
 #define CPLD_I2C_ADDR 0x4a
 #define REG_UFM_CTRL 0x02
diff --git a/board/kontron/sl28/common.c b/board/kontron/sl28/common.c
index 331de29baee6..d8d0172a21b7 100644
--- a/board/kontron/sl28/common.c
+++ b/board/kontron/sl28/common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 
diff --git a/board/kontron/sl28/ddr.c b/board/kontron/sl28/ddr.c
index 315d9f99c71d..9b881fdc265e 100644
--- a/board/kontron/sl28/ddr.c
+++ b/board/kontron/sl28/ddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <fsl_ddr_sdram.h>
diff --git a/board/kontron/sl28/sl28.c b/board/kontron/sl28/sl28.c
index 4ab221c12bf6..adfec8ba2379 100644
--- a/board/kontron/sl28/sl28.c
+++ b/board/kontron/sl28/sl28.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <efi.h>
diff --git a/board/kontron/sl28/spl.c b/board/kontron/sl28/spl.c
index 80acde74956d..45a4fc65120e 100644
--- a/board/kontron/sl28/spl.c
+++ b/board/kontron/sl28/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/spl.h>
 #include <asm/arch-fsl-layerscape/fsl_serdes.h>
diff --git a/board/kontron/sl28/spl_atf.c b/board/kontron/sl28/spl_atf.c
index a9cd6850e983..0710316a48bc 100644
--- a/board/kontron/sl28/spl_atf.c
+++ b/board/kontron/sl28/spl_atf.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2020 Michael Walle <michael@walle.cc>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <atf_common.h>
-- 
2.34.1

