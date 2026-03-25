Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD04109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8D783FEC;
	Wed, 25 Mar 2026 20:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vw0uLX3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC7F84137; Wed, 25 Mar 2026 20:00:50 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 878B9840AE
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d744d9acbeso64239a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465245; x=1775070045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFGGo3PRmdLT5f2SFZupziXkYSHatzR3Xux7xSoTY2A=;
 b=Vw0uLX3r3PXcBVB8wJaB5wDO+hDWmwgK3RTbkt0EdWhJ5Picv0nZjWtojsK2VWbI+p
 A0sV0J9vYCI5RPL5QyYe13ov1AAFs2Wm+WyjLzV5nFkes+yFrtd3QJ/qH7OJ8KwWtG66
 UDOzn9p0tR7uxuPfYl5U3YU0GAmwHWmoVtf54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465245; x=1775070045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFGGo3PRmdLT5f2SFZupziXkYSHatzR3Xux7xSoTY2A=;
 b=rtx/tL+vp8BBpL09dKBaCfkxkCRswGnxYi5aNOw28TwxB2wuM7fgnX19pxRJUi6Q90
 nhSSbOeOkVz53H+0r+ulbzaXvHItmKQKhgKITBTeG+gfPdpF1y3byAePRjCVx/te3+hY
 tWVtmA5GSIr/gXnSduCrxWT7csSrMtPuM8Wg9he0llMqUHkfUJBkPPuh+cfaPxjz0947
 JFxr4aFPY0l02qrkEXK5+9F+YXXfVwvTDWAt4ghr6ARgKA3KEUV16QsNdQ3HZWbUSl2X
 B5JbAfhgXFcfvwaNP37IWhdrdXlvBAdfE4x/7Sy5DeQVgn92CdVRW33iejRPoL/0DHF4
 Xzpw==
X-Gm-Message-State: AOJu0YzjDDukTYEW92tEzeF6CAKxvNjJK4JNOm+2sbCSjzfxFCCdKI6/
 a0VBDi7Ihc1xLWKLRZy38mqM3S2/HiJpgtE0wjaKgkjun2seX2XImZchEyL4ayrJirChPNLPlC7
 JKYTsMow=
X-Gm-Gg: ATEYQzz4b8V1IM2S8hRFnX6JZmtoLnpbgKExFTlvyRl+jz3E5MNJjF59mp5ZUiejHiH
 sakTQUaAXaKnnKCVhSQ4+dCPhiGjC75MfwQ4U+4ti5r//3PErLlYgXb8OKkPsTNWtdtBiL1uHn4
 nZSac0rk2uCuvyCNfeqou/+rNCyWZcpREzxw/9TVLM4WxzjXHmWlnUokLA+YIUtWkYKykVH4Ja9
 S5UbsvUJ7IGMG/VOeppv5W+atunIpr5u5akVSkBXRI1HoLhC7r9MWJMgWXtscpIq3vkpYEnd1UK
 VjBxbciEFLBX9Qn5V1dHFwcOnVWVuWjufYPesYrEoyWsIHRZJ+TeA6oaXWTUDi+qVjmGt4hj55W
 4TLPS9dQDdAqEv2vYifeXUJ5xcAOgFNvZ/MZq7UqD1t3lOW9cHg2K20QPeC634leuZCNURJvrW+
 PEAvhA495mndwoDxsfO+QhBEjdilEPTq/hUrsZ/qDrDyeSZ65Vb9WYwg/yEgEfOOeCz9df2aYXD
 GZyvGi8g+UCs+j4cbkZ8fAZTJ8KVDpBwypf+Xw3UgF4kLSvmDk=
X-Received: by 2002:a05:6830:374a:b0:7d7:f623:680a with SMTP id
 46e09a7af769-7d9d6749b07mr2551318a34.2.1774465245309; 
 Wed, 25 Mar 2026 12:00:45 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fb2e11sm471911a34.3.2026.03.25.12.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6ullevk: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:43 -0600
Message-ID: <20260325190043.3428756-1-trini@konsulko.com>
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
 board/nxp/mx6ullevk/mx6ullevk.c           | 5 -----
 configs/mx6ull_14x14_evk_defconfig        | 1 -
 configs/mx6ull_14x14_evk_plugin_defconfig | 1 -
 configs/mx6ulz_14x14_evk_defconfig        | 1 -
 4 files changed, 8 deletions(-)

diff --git a/board/nxp/mx6ullevk/mx6ullevk.c b/board/nxp/mx6ullevk/mx6ullevk.c
index 189eddefea3f..7a02b571c563 100644
--- a/board/nxp/mx6ullevk/mx6ullevk.c
+++ b/board/nxp/mx6ullevk/mx6ullevk.c
@@ -41,11 +41,6 @@ int mmc_map_to_kernel_blk(int devno)
 	return devno;
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #ifdef CONFIG_FEC_MXC
 static int setup_fec(int fec_id)
 {
diff --git a/configs/mx6ull_14x14_evk_defconfig b/configs/mx6ull_14x14_evk_defconfig
index 36c342bcfe2f..983b8aeb407c 100644
--- a/configs/mx6ull_14x14_evk_defconfig
+++ b/configs/mx6ull_14x14_evk_defconfig
@@ -16,7 +16,6 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
diff --git a/configs/mx6ull_14x14_evk_plugin_defconfig b/configs/mx6ull_14x14_evk_plugin_defconfig
index 28961f5a13f9..c88d18dbf9be 100644
--- a/configs/mx6ull_14x14_evk_plugin_defconfig
+++ b/configs/mx6ull_14x14_evk_plugin_defconfig
@@ -17,7 +17,6 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
diff --git a/configs/mx6ulz_14x14_evk_defconfig b/configs/mx6ulz_14x14_evk_defconfig
index 9db0251a8a0f..8f4a92e4a5f7 100644
--- a/configs/mx6ulz_14x14_evk_defconfig
+++ b/configs/mx6ulz_14x14_evk_defconfig
@@ -16,7 +16,6 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
-- 
2.43.0

