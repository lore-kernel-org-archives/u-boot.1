Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DB4C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 20:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6E588C20;
	Fri, 19 Jul 2024 22:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFkfOHkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AF788C1F; Fri, 19 Jul 2024 22:33:25 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7B388204
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 22:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb71213df9so252514a91.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721421202; x=1722026002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmKV42ksGlLx77lO05gLq0meRRtD8AwNQ9JoVJxNgEg=;
 b=YFkfOHkZWQEznte3QN4DohtG7BO6ISdR6kiMGqCoNArkWGjzk6vqk+iayn0yM5fx9E
 sPqPvljIKXmFBhzxhgievsuGYf6ph7OdT3dRcdATrcaPX6uWegqkHO3JV299OKqZ4Lg8
 ujnBI3937613h0qg7VsMgmo0amRl+ZyMGKvpkTFf9cb2rNcSDNwbaH/UySYVi6YdXmv/
 x18++SsgdGM3gMyuZBDcNVnQRWjcYXBS+BnpAQdMfbT88Vvc5ky7fIEV5GzbCjFqB0yz
 ZnwrExvQCt2YE8nzkRpO6Md5WHYrMWC8JIO8/xteAbsqp+TEos6TM+A6Fwv9/C/b1IGV
 GDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721421202; x=1722026002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmKV42ksGlLx77lO05gLq0meRRtD8AwNQ9JoVJxNgEg=;
 b=FwoqDxBo6s8B3oraviFEBGRynG3wQ71uk0/djKmo89Xnu78XeB1U6Q9EzlrcmkrcOs
 3WTRfLnW1IKp2nK1OwLAsPbnZFjmf8nAjvwmoF5Jmv9Zjs7GbvXh7obcEYVKZrwv7VU7
 UcwLN5m5dIrJoCXX+hzd7mVpWGaNOaknriKQ5bWqgKl9SAqgKMT0CpjXcL2YfOz+MLdc
 84pUzYIlyTvSEPBf8+lsgRUqhk0veNip6SJRjpvJcBtElwjdQypV5lXE2G5yBt+7qc3W
 RDTNyc/AUW61VqZdy276Mth310I1K/kCCnelQQn8g1iY8M3kSkmo0pdDbzsjvKxHWGvG
 LOkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn6GsuM07aUug3nKpWiZEjHy/RQNG2G2GIBdLevVC0/beeZkSbYqHu2ZnvCx/cmMu+BcFNN/Vcucbs15K0iu+jmV3sDA==
X-Gm-Message-State: AOJu0Yy8PyXG0xEyZUcwHrCvyWSyrP86U5SRMFEsnydBgPP0/xTpq2oX
 WxcLu+fCN0cHYQAwvl8cYiLthAWHup3gI+kHBEuCwwLhT8u9/XSR
X-Google-Smtp-Source: AGHT+IGnYXYKnL7AtG68rpJiPYRu29NrYB9fMypA8P69Ox9TiM8wR/Eek5NDwzuD0C+xOa+1yv4ZVg==
X-Received: by 2002:a17:90a:ac06:b0:2cb:4382:9efe with SMTP id
 98e67ed59e1d1-2cd1607bfe0mr735540a91.5.1721421202089; 
 Fri, 19 Jul 2024 13:33:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:27e4:cf37:80d4:17f5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf8092da9sm2138230a91.37.2024.07.19.13.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 13:33:21 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: breno.lima@nxp.com
Cc: francesco.montefoschi@udoo.org, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 3/4] udoo-neo: Do not print devicetree model
Date: Fri, 19 Jul 2024 17:33:10 -0300
Message-Id: <20240719203311.1695523-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719203311.1695523-1-festevam@gmail.com>
References: <20240719203311.1695523-1-festevam@gmail.com>
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

The udoo_neo_defconfig target supports several board variants.
All of these variants use the imx6sx-udoo-neo-basic devicetree in U-Boot.
    
Currently, the devicetree model as well as the board variant name
are shown:
    
...
Model: UDOO Neo Basic
Board: UDOO Neo FULL
...

Printing the devicetree model that is used internally by U-Boot
may confuse users.
    
Unselect the CONFIG_DISPLAY_BOARDINFO option and move the board printing
inside board_init() so that only the real board name that is detected
in run-time is printed.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Newly introduced.

 board/udoo/neo/neo.c       | 43 +++++++++++++++++---------------------
 configs/udoo_neo_defconfig |  1 +
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index 1a0aaecc3328..4cf214bf17c6 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -136,8 +136,25 @@ static int setup_fec(void)
 	return enable_fec_anatop_clock(0, ENET_25MHZ);
 }
 
+static char *board_string(int type)
+{
+	switch (type) {
+	case UDOO_NEO_TYPE_BASIC:
+		return "BASIC";
+	case UDOO_NEO_TYPE_BASIC_KS:
+		return "BASICKS";
+	case UDOO_NEO_TYPE_FULL:
+		return "FULL";
+	case UDOO_NEO_TYPE_EXTENDED:
+		return "EXTENDED";
+	}
+	return "UNDEFINED";
+}
+
 int board_init(void)
 {
+	int *board_type = (int *)OCRAM_START;
+
 	/* Address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
@@ -149,6 +166,8 @@ int board_init(void)
 	gpio_request(IMX_GPIO_NR(4, 16), "ncp692");
 	gpio_direction_output(IMX_GPIO_NR(4, 16) , 1);
 
+	printf("Board: UDOO Neo %s\n", board_string(*board_type));
+
 	setup_fec();
 
 	return 0;
@@ -179,30 +198,6 @@ int board_mmc_init(struct bd_info *bis)
 	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
 }
 
-static char *board_string(int type)
-{
-	switch (type) {
-	case UDOO_NEO_TYPE_BASIC:
-		return "BASIC";
-	case UDOO_NEO_TYPE_BASIC_KS:
-		return "BASICKS";
-	case UDOO_NEO_TYPE_FULL:
-		return "FULL";
-	case UDOO_NEO_TYPE_EXTENDED:
-		return "EXTENDED";
-	}
-	return "UNDEFINED";
-}
-
-/* Override the default implementation, DT model is not accurate */
-int checkboard(void)
-{
-	int *board_type = (int *)OCRAM_START;
-
-	printf("Board: UDOO Neo %s\n", board_string(*board_type));
-	return 0;
-}
-
 int board_late_init(void)
 {
 	int *board_type = (int *)OCRAM_START;
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 97e3b379835f..826d5a115043 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -25,6 +25,7 @@ CONFIG_BOARD_SIZE_LIMIT=523264
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
 CONFIG_SYS_PBSIZE=532
+# CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
-- 
2.34.1

