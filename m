Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A185109C058
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6962083FAF;
	Wed, 25 Mar 2026 20:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Unbze9Ik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1E583FAF; Wed, 25 Mar 2026 20:00:27 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5096D838BB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-467e8aaa865so70777b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465224; x=1775070024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Dxmt9/mawhGzLvJBRaVKXv1krhXjBszqGKlDmexjCQ=;
 b=Unbze9IkSenk/ONS4O0w09ZUBhblqyWe3izC268wQ9gFV+1dJqle9wTGQJxwXod3g2
 t85scHgln/nXd0zUdB1N4Zy7WJ8sD0Kz3ODCvVeETVBi2M8r808N5Io7XvCk1zp6Qj7f
 Iz4nWSG/3MA39ENpxJ0jJI1vtoPNKKSTfHfPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465224; x=1775070024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Dxmt9/mawhGzLvJBRaVKXv1krhXjBszqGKlDmexjCQ=;
 b=mJOPmPZ2nZ/Ymj8aZVRXeEmou9m6WZNxAfy5QtJJbTrM5gX+FCfXC9G0e8gWq9IQN7
 z2RMlWoTijUa0KIlFdXfMZ/sZMo/nVbyO9s8h9gjG6qKBLhAiSQK51WeLDm9hGs4GGeN
 ReqsJtTb0snWtBWx5GT+7n0wO3NAZTC1rpZMl9u+hFUP+mau9sytmqRKs3qlLXOdpvUE
 ORugrDqMBbKyuwWO17EpyJCg1AHWPw2kagOJDVW/Y/02bK+98xELPRAXKPTmSOe39SNB
 5hTK2e+w7EtfPCCa3kwnTdHAOIhV4yY+w9P3/wBhUZKf4HVBQtzUQADdQCnIKb39Z5qG
 cw9g==
X-Gm-Message-State: AOJu0YwprD7Sae8YDSdQ6r7LCBU7efn1wnnlYscXvlfppZZIFUgJQWxa
 3PDcIbJ2OYmFOqlPjTkrGmt2NQxZu49R+pf7fBUk9H4k+JwSqubUPQDORu9LD1UXTU5201CIMTN
 66Dd4f0I=
X-Gm-Gg: ATEYQzxeGZr4/ATkZ9AgetnGFN+3OmM8GV4uFixfOPNgkJAD6CiR4Cp4tLvNIU0x7+9
 KcnkXRm1FK99ntD2QyMWG0Z44vwRzn4WKtKgutQGUIzBsEqQ84abhnO+T8TDIOvZxjM/1AKMsk7
 6a8mplptr2laHiYVFq95ioZ5L0bfbBHssbsc9TtPvGYafC4UiM5AIjXSfuHbAIB97+DsYCac7fk
 a7UpUjL+85d5jN50iYbM9dqWUGiQHD3uQVYGYGykqSMvjgsSDpQfupjwO8hJfp0drWf8uQc24oC
 FaNaGzBF9RW2WGjK2bUpWGEOp3gUuIi20ilFt85yTrNKUzyykPbEslfMAmn1wj7Wx13J2a3PAYp
 cWia2/rT3V0AYOqNTTlR3ckNHlhH3Wu4vW2pNLcL1HbD4JvOENRxRQnXptAj7kxQyxKambrK7hr
 PAnauFT8x0divyxYXRvU1/AtHmxG81eWCMAwzkkZWX+eMp4SWihM2y0Br5CmrKgpuWmTvBgt/au
 cXzw8K6+rUk4TVIswi7Lb3Fcc25QOYOP1pyhuciaqNeB/iNVqA=
X-Received: by 2002:a05:6808:e8c:b0:43c:8714:fe3c with SMTP id
 5614622812f47-46a5c736616mr2318333b6e.51.1774465223812; 
 Wed, 25 Mar 2026 12:00:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm220247b6e.15.2026.03.25.12.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Robert Marko <robert.marko@sartura.hr>,
 Konstantin Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>
Subject: [PATCH] arm: mvebu: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:22 -0600
Message-ID: <20260325190022.3428531-1-trini@konsulko.com>
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

All of these platforms enable CONFIG_BOARD_EARLY_INIT_F and then have a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Konstantin Porotchkin <kostap@marvell.com>
Cc: Ben Schneider <ben@bens.haus>
---
 board/Marvell/mvebu_armada-37xx/board.c           | 5 -----
 configs/eDPU_defconfig                            | 1 -
 configs/mvebu_db-88f3720_defconfig                | 1 -
 configs/mvebu_espressobin-88f3720_defconfig       | 1 -
 configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 -
 configs/uDPU_defconfig                            | 1 -
 6 files changed, 10 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index e44b713f96d7..c30fca6cffd8 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -102,11 +102,6 @@ static bool is_edpu_plus(void)
 		return false;
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* adress of boot parameters */
diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
index 0b7815c78a30..98ba91aa568f 100644
--- a/configs/eDPU_defconfig
+++ b/configs/eDPU_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_PBSIZE=1048
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="eDPU>> "
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_ELF is not set
diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f3720_defconfig
index 52ad18e4dd91..b7a2559997fe 100644
--- a/configs/mvebu_db-88f3720_defconfig
+++ b/configs/mvebu_db-88f3720_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index af3bf1a04fce..c101b342980c 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -25,7 +25,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_FUSE=y
diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
index 69d6f7e34c3b..157bd9696425 100644
--- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -24,7 +24,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_FUSE=y
diff --git a/configs/uDPU_defconfig b/configs/uDPU_defconfig
index 851d7bb2cb99..b819e978c3a5 100644
--- a/configs/uDPU_defconfig
+++ b/configs/uDPU_defconfig
@@ -22,7 +22,6 @@ CONFIG_SYS_PBSIZE=1048
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="uDPU>> "
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_ELF is not set
-- 
2.43.0

