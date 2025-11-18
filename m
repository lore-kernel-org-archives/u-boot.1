Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35293CEDDA1
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A245083DE0;
	Tue, 18 Nov 2025 15:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CvL3Ec6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D3483E19; Tue, 18 Nov 2025 15:48:32 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F4D83C62
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b472842981fso699114666b.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763477310; x=1764082110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaGUXxI3DhgITmXFRkCFwLQfqMPd22l6qI7OyW/Y+Ko=;
 b=CvL3Ec6/iUaGqA41DnCv/IEkY5lKInmFATz2ApnDl/Or6UcLdWgLchSwCocy0RzOgB
 Yz49aVfHKTMcNeS9rU5ZFlbxqKKVOMwfroqO5iCMp1iBXmDXU7uscK3hg6pX5gwzLvU/
 qSwg96w5moj4bOkfKkWcChfRu66JVojm1nA9oTvrOgqnrwmV2hIUzchICQQK0354t/7x
 z2e+b0JCoPk1mi5l3aNplEs7vUNmxr2YwKK4dU2uGmaD/DXIi4d3qXUhrcogFFeAOIq8
 m20AhTkKqXwLuV7GURJ08XFDRgMEy417wBnba0SG7iblgREua7LiUy7v13J76urNmaHp
 4mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477310; x=1764082110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaGUXxI3DhgITmXFRkCFwLQfqMPd22l6qI7OyW/Y+Ko=;
 b=MiskkTHkeCFqjLJdv1sQ8NKDry7IvGDthuFXFwzvOacekLv4dXH6bESFxRch9wtHRE
 sHFw7SlDuiPmspE/qW/GB68aMkghyrouLjgq1sCVBciT8dll7BiqAMDqwnUshYut+JKa
 +ix+uf8703mV30Fdp/ufk7a9TcPdPZvDvNI84StWtZT2Mf4SIYHPnOvJVmOISRf6CjwV
 WQRosRTKJ5KZ3zTrzBW0ohZOJgbQ9dwruOIULWp1BRlchpMYOms9uWE+uE40M64N+h5L
 ch/XzTh1vSIW+vFvynG1Mh+kLw99Y5WPbtZYFfOi9EQDLuTCG5hGoEosLcxqLTrokg9+
 fN1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm+i8rO7KNlu37otvDqMa3PICsa8lpUWZlkQR6bdw939ghLpUBhH5o6kt0ehu4BuoONmg0Nws=@lists.denx.de
X-Gm-Message-State: AOJu0YzIWuk7LpReHfV8cMCJqexyJpiXvPHqDb5qdLlZ8ttVEtWQyKy0
 KgvjreZiKmnpRV/6s9PHaH1Lue6PAFx2nPSjdZvM/LOJzG7PyAFpJ9Bq
X-Gm-Gg: ASbGncvbgpRG4GBXkBAZ1MdBp28mjt5k7bYNn2Y39aqRf4FuXfHXfHdV98ETLZycsXW
 ucE9wvFRiyaUzft5fEtS0a+sMhGTHed4bP7JxlL8+x5Ra28GEmFjGCYI9rR8FTHeu2KqbQEPRQY
 DSaRfqkx+gJnBFEH/TMXlGUNEhzsw6HfHZfTGMQWbD2YbST6o6wb6Pquy1oRMAiXouMJSfMaEi6
 8EqZJnFjNqkyLr5rGBsZL+pIlUxUpMk3K/6ekwXPU1WovOC3ViaFOcGrCaDBvkflFA9DYH6ktBq
 5pDMjWy96ZLCo1CmG9Z4tbluKrFPsgZh/dnGAfgrAG5oy7ObqHows8g9TrX8oO5qZLlJtiTzZ+n
 XXDrn4rO07zKCNeSAV7ZPFpXMD+LH7CoGYpt72rnivpUmYKoi9XORku2oveHU0J29MkobaE1lVQ
 WCh9VLr3gZyrI2G7JgVsk/2FkykiBWMHiYeGbDGi9XSit3e9gGS8KLnk3jBxsaBLWvtX58WpOHs
 p77L3gHblK3v6Yw3/OiibL8dfsAAUjrrA==
X-Google-Smtp-Source: AGHT+IGIyT6TPv9NkGJEFawuhLS5uxgnbXfQH4kUh3AQq2VvCMdRQwH41iPhZAG2C39LU5FWSxEg+w==
X-Received: by 2002:a17:906:c142:b0:b41:4e72:309f with SMTP id
 a640c23a62f3a-b736793dd79mr1778243366b.50.1763477309540; 
 Tue, 18 Nov 2025 06:48:29 -0800 (PST)
Received: from ernest.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad3edasm1370617166b.17.2025.11.18.06.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:48:29 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2] configs: colibri-imx7*: set 'fdtfile' generically in
 PREBOOT
Date: Tue, 18 Nov 2025 15:48:00 +0100
Message-ID: <20251118144815.1242023-1-ernestvanhoecke@gmail.com>
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

In TEZI (Toradex Easy Installer), we use one U-Boot binary for both our
NAND and eMMC Colibri iMX7 modules. Currently, CONFIG_PREBOOT sets the
environment variable 'fdtfile' depending on which defconfig was used,
adding the '-emmc' variant for the emmc defconfig. Since we always build
the TEZI recovery U-Boot with the standard (non-emmc) defconfig, fdtfile
has to be overwritten later or it will be wrong there.

By using '$variant', the fdtfile var is properly constructed at run time
for both the NAND and eMMC variants, and we do not have to worry about
setting fdtfile again when building the recovery TEZI U-Boot.

This also synchronizes these configs with how we handle the iMX6ULL.

Fixes: 327381e8b57c ("colibri_imx7: use preboot for fdtfile evaluation")
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
v2: Do not erroneously replace the '${soc}' variable with imx7
v1: https://lore.kernel.org/u-boot/20251118123056.1124089-1-ernestvanhoecke@gmail.com/
---
 configs/colibri_imx7_defconfig      | 2 +-
 configs/colibri_imx7_emmc_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 5a415120bead..2a3cb84c3b6f 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot ; echo ; echo ubiboot failed ; run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb "
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb "
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index bae43fe45aa7..a95a3214d0c8 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -19,7 +19,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-emmc-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-- 
2.43.0

