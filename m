Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34363C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B338B86A04;
	Thu, 24 Aug 2023 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VgUiGTOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76988698E; Thu, 24 Aug 2023 21:27:05 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E5A869B7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so318609a12.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905223; x=1693510023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teTE+pI+OzPCnhSLjdo18YswPYQQxjq06MTEYRf/5lc=;
 b=VgUiGTOB53rjxwCJBASp44Bbz3uue7mPHRbPlaRrqapJEkAeIR2aDI7k3rSdFQFT2B
 wJr+fuEvZjkhuYTbTg0WCtIwap6WVAJPQ06mDJ/0LdWdmsBPX5ffJdO7kmz3atYd23Wn
 +uRwC9XtWUMrE2RQe0drqWY9V1IEEpIDh7zbZftGf1otOJ/uyNcPKSPE7eY8uZz4yhCg
 TXVMYCyP/qwlN8WLfOS1Nba5+IWD5O4se+mk16vLoyYVRSEJw3YtBjFujyhVpr3o7Ac1
 NQTTbVWGhYhfHRlFXLlRSDZccqiuj5S+SNvrfIAAzzAsRC5LFyt6VHH+5Sop6azIgJOc
 keTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905223; x=1693510023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teTE+pI+OzPCnhSLjdo18YswPYQQxjq06MTEYRf/5lc=;
 b=QVaRgTbz5c1FzUD+z/1RmSSJ7DtZOvgf1gA/fQRL9XcDqpuCc4YRJVsqglU2mUagFc
 ffbStot4Fd2/2VVYg/Cjan9+QKqvJcMFJ7+A43okEogrjXmmpyURjKn/OX5PXoPPBqbz
 8c+Fins2IPmff3tL8DFkKLv4/0g8gKXylGDw+kn7fqpjAvqfzTPIgTsx+zEycOZLtXXn
 dFusac3rgE7hhwLM13opNa83exP2mVeIYtNLtoLMzMcCo92bBtm4S4L0jd95PjJcxEOV
 rHm6BL8DHF4kR2a1QgklZmDDzAKe9OEn4DoLSNUpJO8lujlmD95pyeuKw4v5BaX6Q+a8
 +nDA==
X-Gm-Message-State: AOJu0YzkifitTxKfRvtP09jIzYooAOWfpquWmi+nEyWUCQxDGa9TJ7De
 kTbLoAGh5zNmssKyOYv7o0POdgY5e6babQ==
X-Google-Smtp-Source: AGHT+IFLn7DMJQMufq21ASDxMNAdvd/Sh+5eERtAR7xPVlvHKjX9PZrYKDo1DZ55uAxMAstbXw311A==
X-Received: by 2002:aa7:cf98:0:b0:522:3790:1303 with SMTP id
 z24-20020aa7cf98000000b0052237901303mr11430479edx.32.1692905222817; 
 Thu, 24 Aug 2023 12:27:02 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:27:02 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 15/16] board: tegra30: remove nvidia_board_late_init calls
Date: Thu, 24 Aug 2023 22:26:02 +0300
Message-Id: <20230824192603.240104-16-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

