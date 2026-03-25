Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA3A109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D83EA840CB;
	Wed, 25 Mar 2026 20:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WnKCmxUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BF6840B5; Wed, 25 Mar 2026 20:00:41 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D27883FC6
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d7fdb922a5so104685a34.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465238; x=1775070038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zhbNFU7dUWu12/Z0tkZ8Q9oB0n7M1BzrH9XPkGPYae0=;
 b=WnKCmxUy7irBzmOulXn50bUTO++28MmeYIcWCTr4q1EmfjpyNn03Wx8xPwarmRHAzl
 0Q1duHjnTT9nyX/FH6YEvROIuNvHhFwEw/iob4WHkgKsrbFPVKJ+qRwHUCFCrLEiA6iT
 IyBZEOObIsv/iN3ms7gv19ZGEGv1b/Qq6UrBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465238; x=1775070038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhbNFU7dUWu12/Z0tkZ8Q9oB0n7M1BzrH9XPkGPYae0=;
 b=UIZx1VzupwglKssqyCzwMcUXXjWuuJcuQ6RBKDddkrduioUCjmMD+k1fGDwzcL/lNc
 3DTLYuucRS0PqOUmGgBk5MZyzkWvX+3XzyBybN3D8RkYSaezNJKRNFldKE/UT/xNm1R+
 oxb5xwOPhI2/2LGqC5ZDzKDQGHP6+bp/80hrbLwCRHTQxAEj3HMljgV91xRBO4xShd1i
 Wx8Wj5zKXfkQaxgb5vRfiFeqXbqeOk7n2Rs+r8dNdC2P0CcQ4FvX6QiWZgnyah71ldNV
 sk0cBG7KYuzQKEvFRufhIJDHwGurNJ5IMEe4ml7igdgb/IFrxw8Rh2GTWpPnsV2AuwPu
 TyVw==
X-Gm-Message-State: AOJu0YyxbvAOWNHj0Wa1SGpux/swoiLZ1MC2eJPTttcrm2LI2tNmJzZw
 yiBVpSs1R7eNpA8CuYcfOpVE8llK55wkpSEJL0sWpchydamQ+UJN9k40wziSTK5D1fG/S8BBBdi
 PmtVg/Ak=
X-Gm-Gg: ATEYQzz7HcDg5C2J4/AbhBg29XCWU9wo2/l6n2KnshI80j06Aoa/kwRwx8mOHWNjH8T
 P2xNJ4dWDTL+P1pJyQqnQEiCh4DY1r+tNC/PeCSswKRm1qKrBjHiHXYspsU3t6kb95ZoE26OWb+
 2hezhom0pmoactdvlEhDcrYUdyW9qXp49lriMv3uJi2plZi8dVIc9bQixVF3dRtH3bnmNhSts7h
 Cd3+ouMY1OcjEPs/oF7uSwA8riLSGieIkxp9qly7Y7KZGcrIqk/MoP5084HpVHBtetFsVMvsMXs
 2iy7OJ+pfsi22ndRU79x4XMSR3NVk2xqwl0n0hAV+sWtldUHIf9FGXV+VB4cFstO+EmAgiDtY3y
 ctKHSa60uT+P1xbcDCtWFnDIzElBgeoZXFP45nbKrikj0xQNxFzuF6xMK3mg6g2S/A8M7Yhqclz
 Sx/XGQtcX2zENxB/JNDINrmxc8bUP8E0SUGr2HpXNpzjjBcWDdJcdkdXzAGaWP+sgCSFLUVCGm/
 XMdXSz0SneWrH3NrCoK3vrYS+m3av3KPXlABb4RyKsJ9MUWqdc=
X-Received: by 2002:a05:6830:44a3:b0:7d7:fb11:b669 with SMTP id
 46e09a7af769-7d9d6800b79mr2291865a34.1.1774465238008; 
 Wed, 25 Mar 2026 12:00:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fb2da5sm403204a34.1.2026.03.25.12.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] imx8ulp_evk: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:36 -0600
Message-ID: <20260325190036.3428698-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8ulp_evk/imx8ulp_evk.c | 5 -----
 board/nxp/imx8ulp_evk/spl.c         | 2 --
 configs/imx8ulp_evk_defconfig       | 1 -
 3 files changed, 8 deletions(-)

diff --git a/board/nxp/imx8ulp_evk/imx8ulp_evk.c b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
index cc34ecdec20e..f4e85efb931c 100644
--- a/board/nxp/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
@@ -101,11 +101,6 @@ int board_init(void)
 	return 0;
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_late_init(void)
 {
 	ulong addr;
diff --git a/board/nxp/imx8ulp_evk/spl.c b/board/nxp/imx8ulp_evk/spl.c
index 162b3a1a2e0b..2d52e16007d2 100644
--- a/board/nxp/imx8ulp_evk/spl.c
+++ b/board/nxp/imx8ulp_evk/spl.c
@@ -74,8 +74,6 @@ void spl_board_init(void)
 	if (ret)
 		return;
 
-	board_early_init_f();
-
 	preloader_console_init();
 
 	puts("Normal Boot\n");
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index ff6cd8e6c98a..41025dc11424 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -32,7 +32,6 @@ CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_BOARD_INIT=y
-- 
2.43.0

