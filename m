Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65713EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704A1864EA;
	Tue, 22 Aug 2023 13:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bNuFWwMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DF7864E7; Tue, 22 Aug 2023 13:22:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA2B86489
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c4923195dso565159966b.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703374; x=1693308174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teTE+pI+OzPCnhSLjdo18YswPYQQxjq06MTEYRf/5lc=;
 b=bNuFWwMW6+xXvWjI3k/TdnrGuY9OBK4QYJKuDe1mNeSUd/n4vXS2yp2YQmwIqJUzEB
 jDMJ+1yHgcW8QS5IyzmpjZiY1oJtFerZ/uNqMAusEYNDhpqwJvA9m2YQyU3J8IeLyjqs
 fH/y2wqbZTThdCMGe9p3qH9J55nDL4D6leh3aS/RfxK3zTQHI6uAupHaXnCh0AfP8PaT
 083zaQKHC4Rbqv6Kfw15HWElILVEdJ6WEnaGz1z7pcjYzFpIDgzBDfkaJBAfDT+B0kQF
 +AfmMccig3LLtbBEk7r9oI2p7JB9wN2qzDyiqOLWp9OU8xK9U+WP4hXs91W2J4Tgzzga
 ZpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703374; x=1693308174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teTE+pI+OzPCnhSLjdo18YswPYQQxjq06MTEYRf/5lc=;
 b=Iav0x2BEqVkhlFyeAfVo7J5C+LdWwJbe9yaFSjOJWZETG4FEozJ8WlERrGaDItrqWE
 CFLSUfZJFbyrmrHnhCiadIrJkxMlPZO7+aocjJsOVpptawldyEI2T2XQUUZd0V/SS9ym
 nCYgrTMXfWWb8q76Wxgt0iCsiNMx7bqJnFf5J40biT6scbPFRJjlKEgvypd97K2exBQi
 VtJxVyBS1/LAC62p0qguesjmj0RlRk5gBbz8QGo+rDiJGKn7V45waSKP+dAjOr0qVZ5T
 kyTrG6KBVVAtXoFo9uPDAANW6xMKCPY1qX0L99GdT7CKTqSzg7uhCpNjZ/NXXbQjaMia
 rwOA==
X-Gm-Message-State: AOJu0YwOaHINMzW8N1lhi/mKs17xl81KK0cmfQh/AZn3Tf4aFWBtNR2Y
 0iWR9Vl6YpveUeyZrrOYcodGkWEKlPkJ0A==
X-Google-Smtp-Source: AGHT+IHkwRAlVecfBrw/W4hv9cDXR/T2E7KniK9UEHEbRS+bFxObkQgrecl8IysgJ2uLgPCerzp7BQ==
X-Received: by 2002:a17:906:cc5b:b0:993:d88e:41ed with SMTP id
 mm27-20020a170906cc5b00b00993d88e41edmr6790005ejb.3.1692703373709; 
 Tue, 22 Aug 2023 04:22:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 16/19] board: tegra30: remove nvidia_board_late_init calls
Date: Tue, 22 Aug 2023 14:22:14 +0300
Message-Id: <20230822112217.4646-17-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

Remove nvidia_board_late_init calls from board since this setup is
performed in board2 of mach-tegra. Call of nvidia_board_late_init
from within the board does not provide any additional data.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Transformer T30
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895 T30
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/grouper/grouper.c                 | 12 ------------
 board/asus/transformer-t30/transformer-t30.c | 12 ------------
 board/htc/endeavoru/endeavoru.c              | 12 ------------
 board/lg/x3-t30/x3-t30.c                     | 11 -----------
 4 files changed, 47 deletions(-)

diff --git a/board/asus/grouper/grouper.c b/board/asus/grouper/grouper.c
index 2769313e68..5398ec8b9f 100644
--- a/board/asus/grouper/grouper.c
+++ b/board/asus/grouper/grouper.c
@@ -9,14 +9,12 @@
 
 #include <common.h>
 #include <dm.h>
-#include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/gp_padctrl.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch-tegra/fuse.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include "pinmux-config-grouper.h"
@@ -190,13 +188,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-
-void nvidia_board_late_init(void)
-{
-	char serialno_str[17];
-
-	/* Set chip id as serialno */
-	sprintf(serialno_str, "%016llx", tegra_chip_uid());
-	env_set("serial#", serialno_str);
-	env_set("platform", "Tegra 3 T30");
-}
diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
index 5c1bac004f..ba795a802e 100644
--- a/board/asus/transformer-t30/transformer-t30.c
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -11,14 +11,12 @@
 
 #include <common.h>
 #include <dm.h>
-#include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/gp_padctrl.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch-tegra/fuse.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include "pinmux-config-transformer.h"
@@ -164,13 +162,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-
-void nvidia_board_late_init(void)
-{
-	char serialno_str[17];
-
-	/* Set chip id as serialno */
-	sprintf(serialno_str, "%016llx", tegra_chip_uid());
-	env_set("serial#", serialno_str);
-	env_set("platform", "Tegra 3 T30");
-}
diff --git a/board/htc/endeavoru/endeavoru.c b/board/htc/endeavoru/endeavoru.c
index 1d92870f91..e1a0b242e2 100644
--- a/board/htc/endeavoru/endeavoru.c
+++ b/board/htc/endeavoru/endeavoru.c
@@ -9,14 +9,12 @@
 
 #include <common.h>
 #include <dm.h>
-#include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/gp_padctrl.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch-tegra/fuse.h>
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include "pinmux-config-endeavoru.h"
@@ -104,13 +102,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-
-void nvidia_board_late_init(void)
-{
-	char serialno_str[17];
-
-	/* Set chip id as serialno */
-	sprintf(serialno_str, "%016llx", tegra_chip_uid());
-	env_set("serial#", serialno_str);
-	env_set("platform", "Tegra 3 T30");
-}
diff --git a/board/lg/x3-t30/x3-t30.c b/board/lg/x3-t30/x3-t30.c
index 594563cf52..a08e00dd87 100644
--- a/board/lg/x3-t30/x3-t30.c
+++ b/board/lg/x3-t30/x3-t30.c
@@ -9,7 +9,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
@@ -164,13 +163,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-
-void nvidia_board_late_init(void)
-{
-	char serialno_str[17];
-
-	/* Set chip id as serialno */
-	sprintf(serialno_str, "%016llx", tegra_chip_uid());
-	env_set("serial#", serialno_str);
-	env_set("platform", "Tegra 3 T30");
-}
-- 
2.39.2

