Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70435C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3D688C45;
	Thu,  2 May 2024 03:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Joln6AVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05FB488C41; Thu,  2 May 2024 03:32:18 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE29588C33
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43ca9047bd2so2677081cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613533; x=1715218333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wfcyb8JsrGIkvSSRPO2MuNqbiuPyHUzyNimH/tuOsak=;
 b=Joln6AVF10zBWXnzM3NfiJQ3KlOVF4iHXstFlORX3e84conr0qBQ9t69LBjeiQ0pwv
 J2iq0CXxj1awRKGuiGSfcnifg8XQyT2v8U2XvoowbePQ9e2TAL5VOgw9hZj3/CN2cCeo
 DoNdd7QrOYb4Pnwq/9J6fRmsBNbwXQdf5Rke4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613533; x=1715218333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wfcyb8JsrGIkvSSRPO2MuNqbiuPyHUzyNimH/tuOsak=;
 b=LrB/oHXsDk/cg2Tw/5K8iIkNRJ+MOnEco6pz/hY1B2L65u1rww8ZgFfrYXpLL6rL/F
 uLItzao5QdmSB/OLL+lGwvfbGh2n6kL1K2cfkLehHdR3Gqf6NcfMq7rNTCH5NfJG4tfh
 Jsyk8oOd4e6wHwxJcjczeeVvgNW9rV/0nhdNjKrEZEQTUlV85mZwmh+jXx7Dvw8pQ4ZF
 nDDywudZaxYIrS1vKGzFxiC9Fo5KzIsJsDEAM5Iu1wfO8WksNR6p/AbpP92e7k710dUb
 N02Gia71pMcXh9NqItfNGETG+llLDu96Z+YQlNOFMRBfh66K3ofa6jVNp904O8CcJ1VD
 /++Q==
X-Gm-Message-State: AOJu0YyyXkRZvZmxUDou3tGEeDNVJNHhqbg2kN79UklLZjaw+lybR0jq
 vIli4AHBgzpvSy/VUqYLBCCSk3pZHJBW9Pr6G/O8MPyuS/hEB/6D381b1fNdVLp3S82Ogz4I8bo
 A+7cHrOHv
X-Google-Smtp-Source: AGHT+IFKzWy2sUITSHObM/FOxCyCU0wgEPiDve+OdGeN3reebxUzDGS9+oMLLnGALSWlq1Nax6sqQA==
X-Received: by 2002:a05:622a:5e0f:b0:437:9f6e:8296 with SMTP id
 eq15-20020a05622a5e0f00b004379f6e8296mr2837717qtb.12.1714613533493; 
 Wed, 01 May 2024 18:32:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 21/81] cpu: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:38 -0600
Message-Id: <20240502013138.2383421-21-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/cpu/at91_cpu.c       | 1 -
 drivers/cpu/bmips_cpu.c      | 1 -
 drivers/cpu/cpu-uclass.c     | 1 -
 drivers/cpu/cpu_sandbox.c    | 1 -
 drivers/cpu/imx8_cpu.c       | 1 -
 drivers/cpu/microblaze_cpu.c | 1 -
 drivers/cpu/mpc83xx_cpu.c    | 1 -
 drivers/cpu/riscv_cpu.c      | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/cpu/at91_cpu.c b/drivers/cpu/at91_cpu.c
index 34a3f61c7e95..b45cc6ca1a9a 100644
--- a/drivers/cpu/at91_cpu.c
+++ b/drivers/cpu/at91_cpu.c
@@ -5,7 +5,6 @@
  * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <div64.h>
diff --git a/drivers/cpu/bmips_cpu.c b/drivers/cpu/bmips_cpu.c
index 3dd04fa88581..db624ee47fb0 100644
--- a/drivers/cpu/bmips_cpu.c
+++ b/drivers/cpu/bmips_cpu.c
@@ -7,7 +7,6 @@
  *	Copyright (C) 2009 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <display_options.h>
 #include <dm.h>
diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
index 9772578968ba..16f8f2e52194 100644
--- a/drivers/cpu/cpu-uclass.c
+++ b/drivers/cpu/cpu-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_CPU
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/cpu/cpu_sandbox.c b/drivers/cpu/cpu_sandbox.c
index 2e871fe313c1..e65e1bdc51bf 100644
--- a/drivers/cpu/cpu_sandbox.c
+++ b/drivers/cpu/cpu_sandbox.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <cpu.h>
 
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 98ff95f5ff5c..4781a565547a 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -3,7 +3,6 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <thermal.h>
diff --git a/drivers/cpu/microblaze_cpu.c b/drivers/cpu/microblaze_cpu.c
index a229f6913b07..4e24ada40022 100644
--- a/drivers/cpu/microblaze_cpu.c
+++ b/drivers/cpu/microblaze_cpu.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2022, Ovidiu Panait <ovpanait@gmail.com>
  */
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <asm/cpuinfo.h>
diff --git a/drivers/cpu/mpc83xx_cpu.c b/drivers/cpu/mpc83xx_cpu.c
index e451c11116ab..9a7b5fd7c423 100644
--- a/drivers/cpu/mpc83xx_cpu.c
+++ b/drivers/cpu/mpc83xx_cpu.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <bitfield.h>
 #include <clk.h>
 #include <cpu.h>
diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index 9b1950efe05e..4f2958a23cee 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <cpu.h>
 #include <dm.h>
 #include <errno.h>
-- 
2.34.1

