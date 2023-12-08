Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141BBC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48571876DD;
	Fri,  8 Dec 2023 23:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XWiwF+OJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B03876DE; Fri,  8 Dec 2023 23:31:39 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69211876E2
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-40c09d62b70so29599185e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074690; x=1702679490;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vl55jmEKD+hgbFn1OasdkHoDqG6ND0JNtKsLKEbFPR8=;
 b=XWiwF+OJClSzLAyT/9ys0twFZ8ijbJL5IYQbeH015uStcQkl5BnICDmAv93lYMGDzH
 c9ozhhh4lParenKwxNYzR5ZY9fr8O/WWS89RPLJzcD9A8vwcqMLXoDNk7ShtBBi4ik6J
 U/XJuEh6dUgLaqSmPf5qAEL1SU/f9kpRlyiuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074690; x=1702679490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vl55jmEKD+hgbFn1OasdkHoDqG6ND0JNtKsLKEbFPR8=;
 b=DZFiYtvOmlHFSzUHxnkkaXRbJxHHc1uU8QC48DMBBnMnAYIJu4nMHyP0Kna/ovvqiU
 bdsrmI2RsBT6LMivcgRDl68m7/QVb3Da4fAhaS5gFVfWLqw6pWf4ftZuwETWZf2nzwDv
 4iFI7di4U4YG4HjSY7Jt2XW1AzzMyyOia6wjS+IbEBFaDlnhGyDMlVH7/NSknGR5BBXp
 q2HJORDP7FPow7cMP5lzokqmT9NvAgZM7zXvZmIoStQFOV8m4v3Q/MEEpdjOJ4ANIIFr
 tNbKbHAeYv3FWOAoqpnLYyZnl0Xj/KhotAoj60X/9h2XlC2Ypc8y4/j3mwGmtIVZYOWV
 2mZw==
X-Gm-Message-State: AOJu0YxCipCLFWApE8z+CfBNAwUn8nv8pT/kkNpgecGz/I81H44o7Pp+
 sWh0CLFuX8CYx3WHsh4eQintlgilA2qo+kpcd8uz/60u
X-Google-Smtp-Source: AGHT+IFERlZMGS5gtZ0l13/bV7H6cUdD+fp4F69mqgAznetSK9tvsCgHYdt8szJHvfaqzIdIeupZcw==
X-Received: by 2002:a05:600c:12c6:b0:40c:3132:88ae with SMTP id
 v6-20020a05600c12c600b0040c313288aemr248823wmd.109.1702074689954; 
 Fri, 08 Dec 2023 14:31:29 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:29 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Niel Fourie <lusus@denx.de>, Heiko Schocher <hs@denx.de>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Rainer Boschung <rainer.boschung@hitachienergy.com>
Subject: [PATCH v12 24/24] configs: Use old hush for several boards
Date: Fri,  8 Dec 2023 23:30:25 +0100
Message-Id: <20231208223025.55076-25-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

The keymile board family is not compatible with modern hush parser.
Indeed, This boards used set_local_var() to store some variables as local shell.
They then used get_local_var() to retrieve the variables values.
Sadly, this two functions do not exist with CONFIG_HUSH_MODERN_PARSER.
A patch was proposed to use environment variables rather than local variables
but it does not tackle the problem, so complementary work is needed to make
this boards use CONFIG_HUSH_MODERN_PARSER.

Also, with CONFIG_HUSH_MODERN_PARSER, kirkwoord sheevaplug and phytec bk4r1 hit
their board limits, so better to stick with old hush.

Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Link: https://marc.info/?l=u-boot&m=165541917618725&w=2
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 configs/kmcent2_defconfig              | 1 +
 configs/kmcoge5ne_defconfig            | 1 +
 configs/kmeter1_defconfig              | 1 +
 configs/kmopti2_defconfig              | 1 +
 configs/kmsupx5_defconfig              | 1 +
 configs/kmtepr2_defconfig              | 1 +
 configs/pg_wcom_expu1_defconfig        | 1 +
 configs/pg_wcom_expu1_update_defconfig | 1 +
 configs/pg_wcom_seli8_defconfig        | 1 +
 configs/pg_wcom_seli8_update_defconfig | 1 +
 configs/socfpga_secu1_defconfig        | 1 +
 configs/tuge1_defconfig                | 1 +
 configs/tuxx1_defconfig                | 1 +
 13 files changed, 13 insertions(+)

diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig
index 2cf9565fc9..ac272b3840 100644
--- a/configs/kmcent2_defconfig
+++ b/configs/kmcent2_defconfig
@@ -111,3 +111,4 @@ CONFIG_BCH=y
 CONFIG_PANIC_HANG=y
 CONFIG_LZO=y
 CONFIG_POST=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 257ceeca90..ace5080690 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -202,3 +202,4 @@ CONFIG_QE=y
 CONFIG_SYS_NS16550=y
 CONFIG_BCH=y
 CONFIG_POST=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index 46e0370e35..56b83c085d 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -173,3 +173,4 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_QE_UEC=y
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index c6c021adde..08c7602f5d 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -183,3 +183,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index 25642e7018..72db26f320 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -166,3 +166,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index ea37a29060..ed908d3c77 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -182,3 +182,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 455b439151..0337447f79 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -105,3 +105,4 @@ CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 CONFIG_POST=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index 269116cd0d..e5daa306ab 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -103,3 +103,4 @@ CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 CONFIG_POST=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index 678bc10070..e86a17abdf 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -105,3 +105,4 @@ CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 CONFIG_POST=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 7c7b001903..886334a043 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -103,3 +103,4 @@ CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 CONFIG_POST=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index b8052f1dee..2622bb0432 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -113,3 +113,4 @@ CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index 9ff5d1599f..5c4d33235e 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -166,3 +166,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
+CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index 5b33e8fa64..16b50dd571 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -183,3 +183,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
+CONFIG_HUSH_OLD_PARSER=y
-- 
2.34.1

