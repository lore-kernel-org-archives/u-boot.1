Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF69C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCB38288D;
	Fri, 16 May 2025 01:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZqRy0YMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039A182BAA; Fri, 16 May 2025 01:42:28 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279EC82B7C
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c13802133so715483a34.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352544; x=1747957344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYKlzLtMREa5im+LNDTL2LhmOhd1Zx0Gn7fQuvmoDlE=;
 b=ZqRy0YMe84YYPitb8VIzR//JqY/Au7w1aQEBYuEbwzG6Trc5LYy0kVKkcyxEJ5M0xG
 zaQ8x2sKLBm+AILqL/KekCAC00NGOUER4nMwsO01KhQfZ7+US76+Nn9afZJJAjc0XCld
 aqJbG780opfnTHEcon36BtY8DeLegdneUMhOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352544; x=1747957344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYKlzLtMREa5im+LNDTL2LhmOhd1Zx0Gn7fQuvmoDlE=;
 b=kNLGWnmOsNBzS3zx16JSaZBM0WcWTCcNm+N+6SY8f3hga2nwOa4LELRSLwf91IEF+O
 Cc5JdCfuzDX+cS/4FcJRtxVVeYFYAVdwdqaPmU2OH1LupcECdbAu7iVDyI1IR/KYS5Uz
 ycLjusjwvDN+iqFjhE5G+U8gBcr9lZsmgc+Jb9Pz6taLjfmC9HTkZrXS/WQvJHkGKcRY
 CJL1e82hIrB1XO6Qkd9dWiaHpW7BhJVrdK1VsC636hymgteCryfYuGbjwHObeg458Mg9
 bpy4GG62ciJDT6Om4kgi/D6iO1mnmKf3hsEgCtRtid4t3JTcjFAO/DISrz2VX8mRRW7t
 wdaQ==
X-Gm-Message-State: AOJu0YzcPAR4Cdkvegy8S+1JIPaglJh3My8wdbt3DaRxci2vXstmE/W5
 IpM8T3QBVB7FpMZiYWDo6S2SmNRw6td9TwY8qth2srffOAf+4tb3HynDS019Njfa7kVhRFD8/ey
 C3EaP/R0=
X-Gm-Gg: ASbGnctzvBN89NpNu6LW67LB4E1R7D8eTe8EnKvmoXQlVCLuh787Qb3pGGRwzSFSPIO
 cKFPQQwUaQTJhDGv4nEG0dAih+0iZ6CLe9EKwYBl8QGdD0IXL9HXdUkR1VwFbmFqWLNCuKoC3SS
 njEyu+zSaOAouM+ierju3doEx/HQtAymk2bZpSGnRjQixOFo7o4vQlJZNGgw3mzBSyDAcWF4d1O
 BYgqrLNsBPK6PosMpa4KIBpHxBPV5fGuQ4HCtAr4ZH76UWfegqy1iexk9TWILp+rvQRP7oLc0CW
 gmEFFqdHuH+00KNEIZdbvW0TATsunvFb6qYiRXeALx2ltfDUm+Id0R4r+Y764yVnt4c8Y81KHko
 364sm7yt4EE3OK7c=
X-Google-Smtp-Source: AGHT+IE9pOrq6hLb/5DTYlI5s1iT7AVoGFPe2ugbq4dYRCt1mQUe9US0PwQbe+MiFYsLFUrq0lWyLw==
X-Received: by 2002:a05:6830:a92:b0:72b:8785:890 with SMTP id
 46e09a7af769-734f984a8abmr395913a34.4.1747352543849; 
 Thu, 15 May 2025 16:42:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Angus Ainslie <angus@akkea.ca>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Le Jin <le.jin@siemens.com>,
 Martyn Welch <martyn.welch@collabora.com>, Niel Fourie <lusus@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH v3 21/22] global: Avoid indirect inclusion of <env.h> from
 <net.h>
Date: Thu, 15 May 2025 17:31:50 -0600
Message-ID: <20250515234154.1859366-22-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

Now that env_get_ip() has been removed, the include file <net.h> does
not need anything from <env.h>. Furthermore, include/env.h itself
includes other headers which can lead to longer indirect inclusion
paths. To prepare to remove <env.h> from <net.h> fix all of the
remaining places which had relied on this indirect inclusion to instead
include <env.h> directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- New patch

Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Angus Ainslie <angus@akkea.ca> (supporter:PURISM LIBREM5 PHONE)
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ian Ray <ian.ray@gehealthcare.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Le Jin <le.jin@siemens.com>
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Niel Fourie <lusus@denx.de>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Rick Chen <rick@andestech.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---
 board/BuR/brppt2/board.c                            | 1 +
 board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c | 1 +
 board/andestech/ae350/ae350.c                       | 1 +
 board/data_modul/common/common.c                    | 1 +
 board/gateworks/gw_ventana/gw_ventana.c             | 1 +
 board/ge/b1x5v2/b1x5v2.c                            | 1 +
 board/keymile/kmcent2/kmcent2.c                     | 1 +
 board/purism/librem5/librem5.c                      | 1 +
 board/siemens/iot2050/board.c                       | 1 +
 board/ti/j721e/evm.c                                | 1 +
 boot/bootmeth_efi.c                                 | 1 +
 boot/bootmeth_pxe.c                                 | 1 +
 cmd/pxe.c                                           | 1 +
 drivers/net/pfe_eth/pfe_firmware.c                  | 1 +
 lib/efi_loader/efi_bootmgr.c                        | 1 +
 lib/efi_loader/efi_net.c                            | 1 +
 net/lwip/dhcp.c                                     | 1 +
 net/lwip/dns.c                                      | 1 +
 net/lwip/net-lwip.c                                 | 1 +
 net/lwip/tftp.c                                     | 1 +
 net/lwip/wget.c                                     | 1 +
 test/dm/dsa.c                                       | 1 +
 22 files changed, 22 insertions(+)

diff --git a/board/BuR/brppt2/board.c b/board/BuR/brppt2/board.c
index c0a163251b46..de206bdf1bc4 100644
--- a/board/BuR/brppt2/board.c
+++ b/board/BuR/brppt2/board.c
@@ -7,6 +7,7 @@
  *
  */
 #include <cpu_func.h>
+#include <env.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
index b9f47006d610..8c9e98308765 100644
--- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
+++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
@@ -7,6 +7,7 @@
 #include <dwc3-uboot.h>
 #include <efi.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <errno.h>
 #include <miiphy.h>
 #include <netdev.h>
diff --git a/board/andestech/ae350/ae350.c b/board/andestech/ae350/ae350.c
index 1d9d4a929c22..9bdd2ab17805 100644
--- a/board/andestech/ae350/ae350.c
+++ b/board/andestech/ae350/ae350.c
@@ -6,6 +6,7 @@
 
 #include <config.h>
 #include <cpu_func.h>
+#include <env.h>
 #include <flash.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index 9e35dc5d6cb1..7d344792937e 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -12,6 +12,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <dm/uclass.h>
+#include <env.h>
 #include <hang.h>
 #include <i2c_eeprom.h>
 #include <image.h>
diff --git a/board/gateworks/gw_ventana/gw_ventana.c b/board/gateworks/gw_ventana/gw_ventana.c
index 21a908c20dd5..457d8281a664 100644
--- a/board/gateworks/gw_ventana/gw_ventana.c
+++ b/board/gateworks/gw_ventana/gw_ventana.c
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <fdt_support.h>
 #include <gsc.h>
 #include <hwconfig.h>
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index c1aacd1458b1..ddb7304d493a 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/mach-imx/video.h>
 #include <command.h>
+#include <env.h>
 #include <i2c.h>
 #include <input.h>
 #include <ipu_pixfmt.h>
diff --git a/board/keymile/kmcent2/kmcent2.c b/board/keymile/kmcent2/kmcent2.c
index 783853d5c6f6..0f43ebfec4d5 100644
--- a/board/keymile/kmcent2/kmcent2.c
+++ b/board/keymile/kmcent2/kmcent2.c
@@ -6,6 +6,7 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
+#include <env.h>
 #include <event.h>
 #include <asm/cache.h>
 #include <asm/fsl_fdt.h>
diff --git a/board/purism/librem5/librem5.c b/board/purism/librem5/librem5.c
index 8ca8792fa422..5178ee6929d8 100644
--- a/board/purism/librem5/librem5.c
+++ b/board/purism/librem5/librem5.c
@@ -6,6 +6,7 @@
 
 #include <malloc.h>
 #include <errno.h>
+#include <env.h>
 #include <asm/io.h>
 #include <miiphy.h>
 #include <asm/mach-imx/iomux-v3.h>
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index d827f728a08c..161210c60a96 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -11,6 +11,7 @@
 #include <config.h>
 #include <bootstage.h>
 #include <dm.h>
+#include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
 #include <led.h>
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 0525f6e6f979..b1ed29af0018 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -8,6 +8,7 @@
  */
 
 #include <efi_loader.h>
+#include <env.h>
 #include <generic-phy.h>
 #include <image.h>
 #include <net.h>
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 0c9b4c3d59dc..0af23df3a4a5 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -15,6 +15,7 @@
 #include <dm.h>
 #include <efi.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <fs.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 6e5e0f99ea42..faa8d729b151 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -13,6 +13,7 @@
 #include <bootmeth.h>
 #include <command.h>
 #include <dm.h>
+#include <env.h>
 #include <extlinux.h>
 #include <fs.h>
 #include <log.h>
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 0f26b3b42197..e82247af6c07 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -5,6 +5,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <fs.h>
 #include <net.h>
 #include <net6.h>
diff --git a/drivers/net/pfe_eth/pfe_firmware.c b/drivers/net/pfe_eth/pfe_firmware.c
index da4f2ca42a5b..b821fb17a1d6 100644
--- a/drivers/net/pfe_eth/pfe_firmware.c
+++ b/drivers/net/pfe_eth/pfe_firmware.c
@@ -12,6 +12,7 @@
 
 #include <dm.h>
 #include <dm/device-internal.h>
+#include <env.h>
 #include <image.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c0df5cb9acd9..298149bcc332 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -12,6 +12,7 @@
 #include <charset.h>
 #include <dm.h>
 #include <efi.h>
+#include <env.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b3291b4f1d52..9db738ead9dd 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -18,6 +18,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <env.h>
 #include <dm.h>
 #include <linux/sizes.h>
 #include <malloc.h>
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 92bd7067a7fb..043d2ab6e946 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -3,6 +3,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <env.h>
 #include <log.h>
 #include <dm/device.h>
 #include <linux/delay.h>
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 19172ac959ac..6862869d9e30 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -3,6 +3,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <env.h>
 #include <lwip/dns.h>
 #include <lwip/timeouts.h>
 #include <net.h>
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index f05c4cd3f64f..abc52b32049c 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -3,6 +3,7 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
+#include <env.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <hexdump.h>
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 4f9b2049187c..56d27f821212 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -6,6 +6,7 @@
 #include <display_options.h>
 #include <dm/device.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <image.h>
 #include <linux/delay.h>
 #include <lwip/apps/tftp_client.h>
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index a3b82908877f..46c16edcc440 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -5,6 +5,7 @@
 #include <console.h>
 #include <display_options.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <image.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
diff --git a/test/dm/dsa.c b/test/dm/dsa.c
index 9a31ae39d952..46e48741fbaa 100644
--- a/test/dm/dsa.c
+++ b/test/dm/dsa.c
@@ -3,6 +3,7 @@
  * Copyright 2020-2021 NXP
  */
 
+#include <env.h>
 #include <net/dsa.h>
 #include <dm/test.h>
 #include <test/ut.h>
-- 
2.43.0

