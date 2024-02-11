Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDF1C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 09:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C996B87B2D;
	Sun, 11 Feb 2024 10:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LDZFJTe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3569887B77; Sun, 11 Feb 2024 10:28:45 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31254879AF
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 10:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d0d799b55cso28750141fa.0
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707643722; x=1708248522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VFOQIImJ/u/wA5QB+9LgT6uQREsRBe/w07L4yHjHe6U=;
 b=LDZFJTe1OAfE4m3iopYO7cnhcgRnc6YOKcHtO65Bcr+hh+4pC3K1OFKpCcUK1bM5uT
 EWJcv/ZzvwIJLVV1RF962BgbpmUTxeLsocPWeXNOkclqyrT/F1m9qzA6bkPuo3XmYzT4
 PhUIF81scK/+su5tDa6O6ITz6NzkY9FTc98NGR+Ifmb81Kahiy/8/fIu7mfwRqEKEbzB
 28t4u4NeIl8bEzyY5BN/3IkyHBVil0MB/4+NjoJe2P6yY3N+fBAUKlFRsKFnVLhJ9qNY
 oxQvbT31dQdeAFPWNtHqTVHgwSTIloe751MXeaQVnIOB/SxbjV8hRaVDlI1cp7eW+Epr
 aZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707643722; x=1708248522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFOQIImJ/u/wA5QB+9LgT6uQREsRBe/w07L4yHjHe6U=;
 b=B85GhfxTtQKE+nVDcb6i7t4YADcubxM6A4U42ED1slP91UqjNojmQNMr6BonT5mNA5
 cbiV4qzOWzgOdLqukkjG6aOikm3oz09VD5a0I3lkz07WM+IeF/rsNH6KrzH5iiT2BwRy
 ZSLkOPZqRI5aGZoANRBA0luN/JeMTcYdUubMaK415utHRLFGv/BEK8C6dH72+wMaYv57
 rlSQfrkcCYClklX/M3Rk39nfzUWKKDBMOesBQdbp4UYfMGP7oqqMtLwey+XUUi+mSDf5
 McEplthChb9U6O8aEjVUce7rYH8Kgyj/9DkLUGLFZa96iYa7QwksMBdy24p9zEL1n3xk
 LUBQ==
X-Gm-Message-State: AOJu0YxwAO4wDqzLe3lzZqKs4UbQb5fbMrQf2Rik9LMUOcePbEliwfuo
 gYXc1lxsw9/OnFjDllqVUUuWSReuYKayMdgkQxEp/MSOnyS38L0G
X-Google-Smtp-Source: AGHT+IFB5hXesbl6Sg/vfI3rD3Hwdw22LFGJmzXFWMg6RPFXBtnUIVTEZIEp58FBUNw3kvotOq0OUg==
X-Received: by 2002:a05:651c:b11:b0:2d0:f41e:b4e0 with SMTP id
 b17-20020a05651c0b1100b002d0f41eb4e0mr723931ljr.10.1707643722102; 
 Sun, 11 Feb 2024 01:28:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFtpfAk8SLy00dtQftUZ9X5uEX4KMCxsB9Q7gFpfwQVmNFrr5BhMwvmoMQQde6ZP9GG/pyxhcvriWMnsJWcd9pw/ki3vBhwZwGbiSrkcuwbDwQL+PZ+KGKRZbU76IAf4mKeNt0UlricqK8wcOT1jbqwoHFazmXr027IaNEmYg2XDd68kEVd9OLH4XsYIfgCDZ/1ZbcZocMVYE+/IAzRn6UKBhuTLc+FQSJH/dkrsHrWnSZ8iyyV80uGe3Q/AaliUHGbILRuvlCLxsNBEWZs3y/M5SIMS0EpKeke8u3+Oo+NgkD
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a05651c103600b002d0f7eac111sm56096ljm.88.2024.02.11.01.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 01:28:41 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Ondrej Jirman <megi@xff.cz>, Arnav Singh <me@arnavion.dev>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH RFC] sunxi: pinephone: detect existed magnetometer and fixup
 dtb
Date: Sun, 11 Feb 2024 12:28:24 +0300
Message-ID: <20240211092824.395155-1-andrej.skvortzov@gmail.com>
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
---

AF8133J's driver isn't upstreamed yet, but it will be soon. Therefore this
is RFC patch. I'd like to know whether selected approach will be accepted
in u-boot before submiting coresponding dts changes to the Linux kernel.
Any feedback on this change would be very welcome.

 board/sunxi/board.c         | 26 ++++++++++++++++++++++++++
 configs/pinephone_defconfig |  1 +
 2 files changed, 27 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 1305302060..a4bfa24400 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -15,6 +15,7 @@
 #include <dm.h>
 #include <env.h>
 #include <hang.h>
+#include <i2c.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
@@ -920,6 +921,28 @@ static void bluetooth_dt_fixup(void *blob)
 			   "local-bd-address", bdaddr, ETH_ALEN, 1);
 }
 
+#ifdef CONFIG_PINEPHONE_DT_SELECTION
+
+#define PINEPHONE_LIS3MDL_I2C_ADDR	0x1E
+#define PINEPHONE_LIS3MDL_I2C_BUS	1 /* I2C1 */
+
+static	void board_dt_fixup(void *blob)
+{
+	struct udevice *bus, *dev;
+
+	if (!fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2"))
+		if (!uclass_get_device_by_seq(UCLASS_I2C, PINEPHONE_LIS3MDL_I2C_BUS, &bus)) {
+			dm_i2c_probe(bus, PINEPHONE_LIS3MDL_I2C_ADDR, 0, &dev);
+			fdt_set_status_by_compatible(
+				blob, "st,lis3mdl-magn",
+				dev ? FDT_STATUS_OKAY  : FDT_STATUS_DISABLED);
+			fdt_set_status_by_compatible(
+				blob, "voltafield,af8133j",
+				dev ? FDT_STATUS_DISABLED : FDT_STATUS_OKAY);
+		}
+}
+#endif
+
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	int __maybe_unused r;
@@ -934,6 +957,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	bluetooth_dt_fixup(blob);
 
+#ifdef CONFIG_PINEPHONE_DT_SELECTION
+	board_dt_fixup(blob);
+#endif
 #ifdef CONFIG_VIDEO_DT_SIMPLEFB
 	r = sunxi_simplefb_setup(blob);
 	if (r)
diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index eebc676901..457e7ee1e7 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -12,6 +12,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
+CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_LED_STATUS=y
 CONFIG_LED_STATUS_GPIO=y
 CONFIG_LED_STATUS0=y
-- 
2.43.0

