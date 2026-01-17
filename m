Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326DCC9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D78F839E2;
	Sun, 18 Jan 2026 14:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DeHLV0yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77FF83015; Sat, 17 Jan 2026 20:05:18 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47D882BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-502a98c66f7so12975471cf.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676715; x=1769281515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV/BhhLI5JPybX5GYaA/r6ogdk290irrIQHF+qAJrwA=;
 b=DeHLV0ybOLXf0IyxA5Py0NkJ1jwstVZDbmLWuIKYBHFH+81hjtuk5qAocqWczDZ12q
 ZEWwlPJuWnzFyLd4hKE8OPq2cysU+78C1xO27kHRblithucJUvYcUh4rnuLD7jRMQ7ov
 HK5Vi0gb/2DP0M/9s3EfeikDiHX9acYCU3kEFX/Y4Lf6u8hVaABhEVkRZYU174LacDgT
 6hDazXPDt0hbZljRJT/I37IgCXQ7hkcxFGk09fKnCwRAXJjh2b+TJs6wvCwvp+TQ6+m2
 FExMsRuMa09qj+I5/usKnxusNyALOmLaw7uTTDqsUUEeV8riVgOp3Xy/PYjhca382XNe
 s0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676715; x=1769281515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZV/BhhLI5JPybX5GYaA/r6ogdk290irrIQHF+qAJrwA=;
 b=RdDaEqpFUISvSyWLpp5EsXAqdv4cU/9BLlhUbnOk+mZfPRREwW+P0f88JkEQ6u3CUP
 req9wpF522LWT8JYEsQY9S7QwADZxIcREFWYaaFIwKo1EAAYCh5ZeyuCAkHdlW22BQPt
 c7a0+0MNCVvcY/4sb0kkdPUEOpP2Q9QEHOyzgJvkyOyKHlHhQtLwMzMGrLUPvPTzW0R7
 DoEWGzwR27b4y5F5PqPOmzsBHDj+B54At5VQD/WMNY1HlUYFR/buvXA3UQD8VEr0HKNH
 z/h+SauLh785s9eDqw8WSKskzFgJDYlEX0eHAVutDzdamd+x52VFkGjYXqdEu7Xlkz39
 WpHA==
X-Gm-Message-State: AOJu0YyP8q608dXan+rrLmA2crwiNVqEXAl2r5dqeQ3v8KiW8tDcc5dC
 dboZjW7ZIbS8vpqE22+GM9kReH4nzeMJlBgJtFTCw08odZDITscML/npZr36/A==
X-Gm-Gg: AY/fxX46SIJc41UyJIA+ox/ooae3AVTXyT9cBYlKE+mov8GQivrryQ6E4CQ4K/tyhJu
 FIktot7OH15jFupcsaGgWjxb04YoU1zYp10qVXvsV30ypaDhp42+cSzUaWcd1ygcYoNgiXMdXoa
 r5iMRTEVzQDDknV5GAXp+0GYljZYXVuvOudFnlLuBxYy96bUZ6V8A1YrXjB6eK/8DNh08IP7iI9
 cYLJGv8tm79u5lC6xm1xJgK13s9nPiF4HRMPqFGoCiB78WWvlPjqN2H+gDCUTooyb+4pSDx9FER
 b73MxGKPeTNnSI8U65dsnBCkbFeYEmM8jiBzPjYly6ZFsIZjGBzweFImpuWG+C4+teh6Q0VZhlu
 0Ib38PsFtgJQQaARiwHg1hKYWmEgVUM0TmwG4FI40T5MzMlD+fiLukb4m7tLsBPpZk0wCeXeMJD
 vM7tQc0pyeFkuIZUs06WIoKGv9UxX14DhegsSr798Gd5nvuakExndlAYNTxZBCUwOU2vZu6LA=
X-Received: by 2002:ac8:5f94:0:b0:4ed:bbca:fdff with SMTP id
 d75a77b69052e-502a165323cmr86770351cf.9.1768676715128; 
 Sat, 17 Jan 2026 11:05:15 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:05:14 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Samuel Holland <samuel@sholland.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 04/17] reset: k1: add SPL support and enable TWSI8 reset
Date: Sat, 17 Jan 2026 14:01:38 -0500
Message-Id: <20260117190231.977686-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

This commit enhances the K1 reset controller driver:

1. Enable SPL support
   - Select CONFIG_SPL_RESET_SPACEMIT_K1 for SPL builds
   - Reset controller is required during early boot for
     proper hardware initialization sequence

2. Remove TWSI8 (I2C8) reset restriction
   - TWSI8 is now fully controllable by reset controller

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 drivers/reset/Kconfig             | 7 +++++++
 drivers/reset/Makefile            | 2 +-
 drivers/reset/reset-spacemit-k1.c | 4 ----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 74c267dfc4e..1e69024ce74 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -252,5 +252,12 @@ config RESET_SPACEMIT_K1
 	  Support for SPACEMIT's K1 Reset system. Basic Assert/Deassert
 	  is supported.
 
+config SPL_RESET_SPACEMIT_K1
+	bool "SPL Reset driver for Spacemit K1 SoC"
+	depends on SPL && RESET_SPACEMIT_K1
+	default y
+	help
+	  Support for reset controller on Spacemit K1 SoCs in SPL.
+
 source "drivers/reset/stm32/Kconfig"
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index ee5b009d134..ec6893b1c45 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -33,8 +33,8 @@ obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o
 obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
+obj-$(CONFIG_$(PHASE_)RESET_SPACEMIT_K1) += reset-spacemit-k1.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
-obj-$(CONFIG_RESET_SPACEMIT_K1) += reset-spacemit-k1.o
 
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
diff --git a/drivers/reset/reset-spacemit-k1.c b/drivers/reset/reset-spacemit-k1.c
index 613e002fc4f..99dce90b4c4 100644
--- a/drivers/reset/reset-spacemit-k1.c
+++ b/drivers/reset/reset-spacemit-k1.c
@@ -452,10 +452,6 @@ static int spacemit_reset_update(struct reset_ctl *rst, bool assert)
 	if (rst->id < RESET_UART1 || rst->id >= RESET_NUMBER)
 		return 0;
 
-	/* can not write to twsi8 */
-	if (rst->id == RESET_TWSI8)
-		return 0;
-
 	spacemit_reset_set(rst, rst->id, assert);
 	return 0;
 }
-- 
2.25.1

