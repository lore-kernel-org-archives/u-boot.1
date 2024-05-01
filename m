Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C28C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080E888A83;
	Wed,  1 May 2024 04:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rfj7gE/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09F688AB3; Wed,  1 May 2024 04:43:35 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A190088A8B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6a06b12027cso4375986d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531412; x=1715136212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4XyX9jKronJmmrXRldXXgs1ZfDfUF9PqGDtHQPElNY=;
 b=Rfj7gE/qYctdBVFU9IpVqIuobUBhKSovtiX02ShyxUZZjxBMlrT+NhC4yA9HAUzUKt
 ICv9osgxsSHvNzTh7LL2CuQ0QvYgIysX1diWYaWC0NmoSJmHBDlcVqdeL/qJ8k4vJVxm
 eRSKId3ZU/REzdVjCwuzDVHIfueG9yKRsk4lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531412; x=1715136212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4XyX9jKronJmmrXRldXXgs1ZfDfUF9PqGDtHQPElNY=;
 b=s4pAHMMhfxRjvvCDaH9b1BBOa+rwjoc6qAa0AJw3Hz06AbRXm8NFBOFwJsKZa2E4lu
 qdCEogvPxxBnaGiZHd4LkRKpnCJ0up7MmVJdaKW64rYJSSk+6NijM8ctLhGkmHNGPS1k
 9MV6N0A2NgFKkzmQwccalZ7PZPCAIOyoFF43TMlqtFeaI/9RwQds2KiEdIuS8bDxmmS7
 HqzAOzng77KKQeBmIYHPnjdZZ2PVmksCOeK/28hx1/bbuBh5chVaCRUFvx1i6sEH35HR
 +shLIAof4ZGquVD+SPrLUp/71s8/TuCzXTGVIVT4wX92hOgb7LU7Jbz6m51ajwh2pv2B
 r2kg==
X-Gm-Message-State: AOJu0YwBbdJ2rTkiGtTR6MAQ9RoKpVY6NNCV4DI8ljbe8+NlCReLfKN/
 Gapn081c28JQ0vNXQuYzf9u8eyF9y8g8yNxkXS76Cu0h8hxPMEr6bgvwJ9Ope5+i0Tc9tLNtYKV
 urCb2/A==
X-Google-Smtp-Source: AGHT+IG8gDDoI68f03T3q1yX06oR0+z5F3zypHdHxM41EBrmS/q1pGBH16C4R+9BsAb+35ycXu8hGQ==
X-Received: by 2002:a05:6214:2484:b0:6a0:e457:c3dd with SMTP id
 gi4-20020a056214248400b006a0e457c3ddmr2701536qvb.9.1714531412375; 
 Tue, 30 Apr 2024 19:43:32 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 George McCollister <george.mccollister@gmail.com>
Subject: [PATCH 013/149] board: advantech: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:00 -0600
Message-Id: <20240501024316.1767971-13-trini@konsulko.com>
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
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Oliver Graute <oliver.graute@kococonnector.com>
Cc: George McCollister <george.mccollister@gmail.com>
---
 board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       | 1 -
 board/advantech/imx8mp_rsb3720a1/spl.c                    | 2 +-
 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     | 1 -
 board/advantech/imx8qm_dmsse20_a1/spl.c                   | 2 +-
 board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c     | 1 -
 board/advantech/imx8qm_rom7720_a1/spl.c                   | 2 +-
 board/advantech/som-db5800-som-6867/som-db5800-som-6867.c | 1 -
 7 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
index d87fe3606f6a..070933fb54b2 100644
--- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
+++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
@@ -4,7 +4,6 @@
  * Copyright 2022 Linaro
  */
 
-#include <common.h>
 #include <dwc3-uboot.h>
 #include <efi.h>
 #include <efi_loader.h>
diff --git a/board/advantech/imx8mp_rsb3720a1/spl.c b/board/advantech/imx8mp_rsb3720a1/spl.c
index f4257bc993d6..1f7c1f25adcf 100644
--- a/board/advantech/imx8mp_rsb3720a1/spl.c
+++ b/board/advantech/imx8mp_rsb3720a1/spl.c
@@ -4,7 +4,7 @@
  * Copyright 2022 Linaro
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <errno.h>
diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
index 56b7bdb57c94..50b35db5f6cf 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
@@ -4,7 +4,6 @@
  * Copyright 2019-2023 Kococonnector GmbH
  */
 
-#include <common.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <asm/io.h>
diff --git a/board/advantech/imx8qm_dmsse20_a1/spl.c b/board/advantech/imx8qm_dmsse20_a1/spl.c
index e8959ede51d9..93cf07440026 100644
--- a/board/advantech/imx8qm_dmsse20_a1/spl.c
+++ b/board/advantech/imx8qm_dmsse20_a1/spl.c
@@ -3,7 +3,7 @@
  * Copyright 2017-2018 NXP
  * Copyright 2019-2023 Kococonnector GmbH
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <spl.h>
 #include <init.h>
diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
index 7f766a688bb5..3def182f2967 100644
--- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
+++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2019 Oliver Graute <oliver.graute@kococonnector.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
diff --git a/board/advantech/imx8qm_rom7720_a1/spl.c b/board/advantech/imx8qm_rom7720_a1/spl.c
index d32400101fc9..5863e335a8bc 100644
--- a/board/advantech/imx8qm_rom7720_a1/spl.c
+++ b/board/advantech/imx8qm_rom7720_a1/spl.c
@@ -2,7 +2,7 @@
 /*
  * Copyright 2017-2018 NXP
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c b/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c
index 8499fc541fa7..9bbd5fd291aa 100644
--- a/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c
+++ b/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2016 George McCollister <george.mccollister@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/fsp1/fsp_support.h>
 
-- 
2.34.1

