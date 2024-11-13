Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC0D637CE
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 22:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35E989198;
	Wed, 13 Nov 2024 23:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QOc7QylQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9A3891F1; Wed, 13 Nov 2024 23:29:58 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0346D890D9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9eb3794a04so5860466b.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731536995; x=1732141795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KiFMJ79Dx6WwGVlWS+efbcCvi09vg39bmGOQ2Tfaook=;
 b=QOc7QylQ2hpblGRZF1GxLE+ZmKCvwmoNqSlJfVGsk/edNuY/Y3HHcEHZbsOeajR9T1
 jRg7xfqQmjtqVlya0JCvZ17gRVgIQ2KtGCkphQ8//rMh1maG6WPgyM3vmrJFfIuW8jgW
 uGtRHZK4r7+8voccMD64wbJx5NfsR2+pmy2yPSbKg1aT1hXjzCeYOELHObDnmgbIRL/w
 xYEfSxUdg7bAOgJr0RvZ3aQqsEER6GWHbu2If/1GnXtCFSU/bPWGbZcd5rpgQbAqQL3m
 7IkMCJL06RVVzFY6+Gpi+lfb+oU0+heW9VYEz5tOUq5ODjKqbYq9GEb2XnPSD5bHGgoS
 Et2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731536995; x=1732141795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiFMJ79Dx6WwGVlWS+efbcCvi09vg39bmGOQ2Tfaook=;
 b=s9YJRiLPkGknOp1I9h3eFg/H1CvWdT99FuZNpxv5Ivrk2YOdXo5LRV+zg6/fn8OSEI
 W6igbqJxLllO2Zux8oMzLa6lHVIBU4Oy7T78Hw5HOHPSlbAu6SBY/f6ABPC3i0446XhD
 OwVbdf3GgLTKxxnJ2qcss/y4XKQLbr6Y8Gw8WZ0s1d2rVtN9qQ5axRuVYbTpBheJTuXc
 /6A/P2vBcqYB7+sVXdexppfAzaDucGn0wshvrRlHr97pHsXfLHQasWHSfJKroy+p3a7S
 L1shAF1HFxxPMuRj7HkYZFUs1DS0s6OoFt+hqSl7UGbj0gkfIj1bY+gSJ159Atyr7K3T
 oc0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ/vYs2ArksTE1QejeYZomkXB0R+BHRhqkRiKjAIvPKPxh8wMeD4fD78EawpAJWrsISaDK/a0=@lists.denx.de
X-Gm-Message-State: AOJu0YxEEqPaEC5diVjKx+LIbtVUvPd0/WETWuBAkPDZ71G6ebFMV6G6
 PTdmfS6AnK68W/91xxBU5shSqWW3i8DCJiLcn+m7GT3tsjGuSQ9o
X-Google-Smtp-Source: AGHT+IElQHek+iiu5/H1MZzs6NkXfSCJY3KQrts8hF8XvZYeqKmtJlt5Ife6jmbfL9IWD6JcI7lOig==
X-Received: by 2002:a17:907:3e02:b0:a9e:b378:6c13 with SMTP id
 a640c23a62f3a-aa1b1058071mr792383066b.17.1731536995186; 
 Wed, 13 Nov 2024 14:29:55 -0800 (PST)
Received: from localhost.localdomain ([94.19.228.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17651sm923088966b.38.2024.11.13.14.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 14:29:54 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel@sholland.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] sunxi: pinephone: detect existed magnetometer and fixup dtb
Date: Thu, 14 Nov 2024 01:28:48 +0300
Message-ID: <20241113222848.103032-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
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

In newer 1.2 PinePhone board revisions LIS3MDL magnetometer was replaced by
AF8133J. They use the same PB1 pin in different modes.

LIS3MDL uses it as an gpio input to handle interrupt.
AF8133J uses it as an gpio output as a reset signal.

It wasn't possible at runtime to enable both device tree
nodes and detect supported sensor at probe time.

AF8133J has reset pin (PB1) connected to the SoC. By default AF8133J
is in a reset state and don't respond to probe request on I2C
bus. Extra code would be needed to handle reset signal. Therefore this
code uses LIS3MDL magnetometer instead of AF8133J.

Introducing new dts 1.2b with AF8133J sensor would require probing in
SPL. That would lead to pulling in into SPL I2C controller driver,
RSB controller driver, introducing new AXP803 driver to power-up
sensors for probe. It's working, but SPL is pretty size-constrained on
A64 and doesn't have much space. Therefore fdt fixup is done in U-Boot
proper without introducing new board revision and new dts.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Link: https://lore.kernel.org/all/20240908214718.36316-1-andrej.skvortzov@gmail.com/
Link: https://lists.denx.de/pipermail/u-boot/2024-February/545700.html
---

This patch was discussed previously as RFC. [1]
All relevant kernel device-tree changes are merged. [2]

1. https://lists.denx.de/pipermail/u-boot/2024-February/545700.html
2. https://lore.kernel.org/all/20240908214718.36316-1-andrej.skvortzov@gmail.com/


board/sunxi/board.c         | 23 +++++++++++++++++++++++
 configs/pinephone_defconfig |  1 +
 2 files changed, 24 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 824c322a0dc..703081b403f 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <env.h>
 #include <hang.h>
+#include <i2c.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
@@ -876,6 +877,27 @@ static void bluetooth_dt_fixup(void *blob)
 			   "local-bd-address", bdaddr, ETH_ALEN, 1);
 }
 
+#define PINEPHONE_LIS3MDL_I2C_ADDR	0x1E
+#define PINEPHONE_LIS3MDL_I2C_BUS	1 /* I2C1 */
+
+static	void board_dt_fixup(void *blob)
+{
+	struct udevice *bus, *dev;
+
+	if (IS_ENABLED(CONFIG_PINEPHONE_DT_SELECTION) &&
+	    !fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2")) {
+		if (!uclass_get_device_by_seq(UCLASS_I2C, PINEPHONE_LIS3MDL_I2C_BUS, &bus)) {
+			dm_i2c_probe(bus, PINEPHONE_LIS3MDL_I2C_ADDR, 0, &dev);
+			fdt_set_status_by_compatible(
+				blob, "st,lis3mdl-magn",
+				dev ? FDT_STATUS_OKAY  : FDT_STATUS_DISABLED);
+			fdt_set_status_by_compatible(
+				blob, "voltafield,af8133j",
+				dev ? FDT_STATUS_DISABLED : FDT_STATUS_OKAY);
+		}
+	}
+}
+
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	int __maybe_unused r;
@@ -889,6 +911,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_ethernet(blob);
 
 	bluetooth_dt_fixup(blob);
+	board_dt_fixup(blob);
 
 #ifdef CONFIG_VIDEO_DT_SIMPLEFB
 	r = sunxi_simplefb_setup(blob);
diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a439..0f9ab0c4662 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -11,6 +11,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
+CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_LED_STATUS=y
 CONFIG_LED_STATUS_GPIO=y
 CONFIG_LED_STATUS0=y
-- 
2.45.2

