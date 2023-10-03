Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9024BE7542C
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B47B387474;
	Tue,  3 Oct 2023 08:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZaOqU/Vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4C187282; Tue,  3 Oct 2023 08:37:12 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB688726E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5041335fb9cso614742e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315027; x=1696919827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teTE+pI+OzPCnhSLjdo18YswPYQQxjq06MTEYRf/5lc=;
 b=ZaOqU/Vo28LF7nAoZ76hRAo56XeBQbGpo0/qpGyiW5YmR6vg2CAyFlNEuL6IX6E74D
 FVtBdznklesetTE0XLhjQ17dRHj7wuU+DFOy/Nj651iMDm2+36FtL47b/EcvboZYdQOO
 iTXtX30PmQqH7+CZm4bhMqe1ZdOz086Wmag3t/Q+2vMqLGwuZKbWvsga1NQyvsUaLotI
 lMZxpKz+0Y7+rrjmPkPAD739BNMnS9FkNtvTtD/OzDBoispC43WHnnXfJw/2AwJa8kp6
 b45d3L3gKj/weMoUXDU4ZyGqdZ7gl5fqmq4gmVeI28m5KS8UyKEHFTHRWC7IPGP9Bzjj
 JWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315027; x=1696919827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teTE+pI+OzPCnhSLjdo18YswPYQQxjq06MTEYRf/5lc=;
 b=sQGWVBH4w1/WlBZsFdojmcTj6ZhUOK/0UKofDr0EP4DuRUkdne2ux+LfFG9cLc7TKT
 QZjGELm+pt87MzXLtABoVvkclgYfUCciJV7GlYcLsH6kKDvCUl+678Oynq2UwfTYC4CA
 yzzZ2hRw5B9dzX67rv/0+ldbij6gLxjw9lIkBI6g7G07zDMJC9+b9DeDBPNZdXFH+e1c
 UuPjYKk4N3/H0NB0MTWNf/xRvbNFaj+1Brjq9rG6kVgxylExefyYHJypoR73z7T8stch
 m+8Y4f9eXMaAYOKiUiZcnTp/SVkTHaSDu8MmIVuLnQ8pp8dDATfz5pivqo59BPwMvg6i
 KrpA==
X-Gm-Message-State: AOJu0YyVXtgyPzkj0ZloJQnAz1jHXCaX6U9tFxYWuWbbNn2Wz2MmmsQz
 3KMjFEqs05WjYBm1SuEhEkjclnQsjqs=
X-Google-Smtp-Source: AGHT+IFghpfhVXLcyDxX0o7oO6d8rMvTF6mg6ZQjhsCBPjGfHl3ySwQWeVdHnXKY78Pr6q/7y/dkQA==
X-Received: by 2002:a05:6512:36cc:b0:4fa:ad2d:6c58 with SMTP id
 e12-20020a05651236cc00b004faad2d6c58mr10383956lfs.61.1696315026935; 
 Mon, 02 Oct 2023 23:37:06 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:06 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 15/16] board: tegra30: remove nvidia_board_late_init calls
Date: Tue,  3 Oct 2023 09:36:46 +0300
Message-Id: <20231003063647.42770-16-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

