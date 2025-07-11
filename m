Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E45C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E07E83108;
	Fri, 11 Jul 2025 17:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XDqpGq48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6F78313B; Fri, 11 Jul 2025 17:20:26 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A7D83108
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-611f48c6e30so1182570eaf.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247223; x=1752852023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=loXKM4R4k7H2kzxIOsA5jDgk5aQD3cjkk2ajH4JElmQ=;
 b=XDqpGq48Wr03mXydup421vjJiLFUzeLh1pnBO0KOLtU3ityRQ+3M9+5lkEqX44ZPBm
 7x0RCoYnGDmE2k4eKeWzyyl2y3w4wM86ZraBi/yWY2KP4/YUclgCSaf+as7rksGIkZtN
 qX0w1Knl/jjTgxlnS19Kuf3Iw9snnkf23IfCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247223; x=1752852023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loXKM4R4k7H2kzxIOsA5jDgk5aQD3cjkk2ajH4JElmQ=;
 b=GfyozSjj7r/yRCEzGwlRLuTaYqzX0R4NBEmZm6XaZQYGkpDYfleSRQuKZ4JAjCL3Ml
 MSMUsAC5t6T/Eij4zPpEAbiHOc0pnG13tAyByvS+/Kz/dpZtF4BH2FWBcdw30J/alqXA
 Zvyahmb9p3HLHKIn9zfxthrqkiWFIsFBx9kSiyl9TZ8gq1T4ocHuStucyMEkKO2iEjxJ
 hLDqlxNa3keBexrJcqZwk+3sRL8ZNBCLIRvKyiE7r98G6rZXKpckHx5cZ/sAWn8UelJk
 hldc90HrgBeH6SYImrp7e9jPUKl15KXtweIyCIPRJUgiaj8gQ4lOsLNqWr4MowOQUCOE
 94Ng==
X-Gm-Message-State: AOJu0YwSZpeWeFXF5S9f1YZRTI5gS4O1zFivKzfS89ym55I3O1guFKP7
 EMO/ra2X6Uy97cChLeZMhXpi6tPxssui6Xxvu4t2XbmeTzVnkzRR50S/8J2okuQvaMYevoA+2aL
 HnlxyAaM=
X-Gm-Gg: ASbGncuzor2fcRK6VzzNBHFiftWDtbrRvcgdprh1Mnh3ABzuhnFQonUEtRWiKSay6nM
 HiFEYoU9Zk/vHcwddAmrwFI5L/jfTj7DA9j5MsZeJfG7bBRS0QMKSKATybfWu0/0FZv53Lfkx0k
 4/GGEx8+3PSnaJLTJGRhrMrzc6QrjsQmNhcG8T+QPJWowtKGTJ1A7A/c/jxGXlbnO5EODrPLL93
 Wjd5D28BV/kHyq8XzRTg5JS/ep+wkKTTjyLA8DDEk+Z7h9vZ2yekb2CYH1vSJH+HdZ9qV2hSIip
 wBzD1t/Q9XODsmPDZgHzuQZ5m3/wcdX5rrXUZ8jpYZNmQOgB71JUhy8GlMsQY0rKK9gBJZIx8wU
 JUg5GsXy9gZ6DmVNFkChP/S/iPctUn28ONc/7Ap2HJSfOgpi7dC1z5VikusB/5zWSJOWRJg==
X-Google-Smtp-Source: AGHT+IGaLVFIVjNIblRlQt87mQqcB1oaC6wslatF8L3qnzcmaxtk1YSD7LAcEdpukEipw3zG9MSmIA==
X-Received: by 2002:a05:6808:1692:b0:40c:5b58:dbd4 with SMTP id
 5614622812f47-4151122da67mr3165392b6e.22.1752247221239; 
 Fri, 11 Jul 2025 08:20:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414196c6381sm566570b6e.14.2025.07.11.08.20.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] x86: Rename arch/x86/include/asm/pnp_def.h to
 include/pnp_def.h
Date: Fri, 11 Jul 2025 09:20:19 -0600
Message-ID: <20250711152019.2225509-1-trini@konsulko.com>
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

There is nothing x86-centric in this include file, and moving it will
allow for some drivers to be compile-tested on sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c | 2 +-
 board/dfi/dfi-bt700/dfi-bt700.c                            | 2 +-
 board/intel/crownbay/crownbay.c                            | 2 +-
 drivers/misc/nuvoton_nct6102d.c                            | 2 +-
 drivers/misc/smsc_lpc47m.c                                 | 2 +-
 drivers/misc/winbond_w83627.c                              | 2 +-
 {arch/x86/include/asm => include}/pnp_def.h                | 0
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename {arch/x86/include/asm => include}/pnp_def.h (100%)

diff --git a/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c b/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
index 4197e88fb6ff..153594c42bb0 100644
--- a/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
+++ b/board/congatec/conga-qeval20-qa3-e3845/conga-qeval20-qa3.c
@@ -5,10 +5,10 @@
 
 #include <i2c.h>
 #include <init.h>
+#include <pnp_def.h>
 #include <winbond_w83627.h>
 #include <asm/gpio.h>
 #include <asm/ibmpc.h>
-#include <asm/pnp_def.h>
 
 int board_early_init_f(void)
 {
diff --git a/board/dfi/dfi-bt700/dfi-bt700.c b/board/dfi/dfi-bt700/dfi-bt700.c
index 907cc985d7a9..69a6860c2dd3 100644
--- a/board/dfi/dfi-bt700/dfi-bt700.c
+++ b/board/dfi/dfi-bt700/dfi-bt700.c
@@ -6,9 +6,9 @@
 #include <init.h>
 #include <log.h>
 #include <nuvoton_nct6102d.h>
+#include <pnp_def.h>
 #include <asm/gpio.h>
 #include <asm/ibmpc.h>
-#include <asm/pnp_def.h>
 #include <linux/delay.h>
 
 int board_early_init_f(void)
diff --git a/board/intel/crownbay/crownbay.c b/board/intel/crownbay/crownbay.c
index 036beb1146dc..6c5d03c1d496 100644
--- a/board/intel/crownbay/crownbay.c
+++ b/board/intel/crownbay/crownbay.c
@@ -4,8 +4,8 @@
  */
 
 #include <init.h>
+#include <pnp_def.h>
 #include <asm/ibmpc.h>
-#include <asm/pnp_def.h>
 #include <smsc_lpc47m.h>
 
 int board_early_init_f(void)
diff --git a/drivers/misc/nuvoton_nct6102d.c b/drivers/misc/nuvoton_nct6102d.c
index a3ca037d25f7..c4a8ecaa1b38 100644
--- a/drivers/misc/nuvoton_nct6102d.c
+++ b/drivers/misc/nuvoton_nct6102d.c
@@ -4,8 +4,8 @@
  */
 
 #include <nuvoton_nct6102d.h>
+#include <pnp_def.h>
 #include <asm/io.h>
-#include <asm/pnp_def.h>
 
 static void superio_outb(int reg, int val)
 {
diff --git a/drivers/misc/smsc_lpc47m.c b/drivers/misc/smsc_lpc47m.c
index 1b15907b0933..cc3d3f9de06c 100644
--- a/drivers/misc/smsc_lpc47m.c
+++ b/drivers/misc/smsc_lpc47m.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <pnp_def.h>
 #include <asm/io.h>
-#include <asm/pnp_def.h>
 
 static void pnp_enter_conf_state(u16 dev)
 {
diff --git a/drivers/misc/winbond_w83627.c b/drivers/misc/winbond_w83627.c
index 87b9043e65c4..8c5b121b8e93 100644
--- a/drivers/misc/winbond_w83627.c
+++ b/drivers/misc/winbond_w83627.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
+#include <pnp_def.h>
 #include <asm/io.h>
-#include <asm/pnp_def.h>
 
 #define WINBOND_ENTRY_KEY	0x87
 #define WINBOND_EXIT_KEY	0xaa
diff --git a/arch/x86/include/asm/pnp_def.h b/include/pnp_def.h
similarity index 100%
rename from arch/x86/include/asm/pnp_def.h
rename to include/pnp_def.h
-- 
2.43.0

