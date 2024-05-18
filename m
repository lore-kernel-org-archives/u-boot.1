Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61944C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44ED9886B4;
	Sat, 18 May 2024 17:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GYlXRRF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E5A8863A; Sat, 18 May 2024 14:03:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E574588659
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 14:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716033790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI0yQuNXDBo7e9q04lLjfppyXxiecW8tdOpwVXIx5TA=;
 b=GYlXRRF+ZVU/AeGtcbwFyAwAEbfK//EjBUOT7epScPV5rzWHKmGL3PcBEGsLZR/AUFjQ+v
 KF+DHv895g3yeHfpCTLXZyHBiKlWbFj8qYfytq/BLMCNHLLrDq++Cbti2sIHskrv6uUgB7
 u/1I9mJd6Vujs2l7sn6ittcmwzwANfw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-gVBEProkO2ej44a7Nn-lhA-1; Sat, 18 May 2024 08:03:09 -0400
X-MC-Unique: gVBEProkO2ej44a7Nn-lhA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-420094e8896so35966275e9.3
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716033788; x=1716638588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DI0yQuNXDBo7e9q04lLjfppyXxiecW8tdOpwVXIx5TA=;
 b=EKwRFHmjGl5JDBiP7npGPZn5sB6omuCwTHGacEhWsSEvrv5q4xNqBxjoAw8C6c5Tqg
 /u/18Pr2SVFBJuMei+BLDU7VwgFfGbbXUzvJ89/0aPHZuIb1052I7xeuDjPe+dbjjgiz
 zlT8mVencXOZVHmHc+gv+pIieqXzaUaWrEHFwGYmGpVDP6sQKv8OsFK2QMLSrcGpnxKe
 IkV6jMBsTEIvnyVsvF+24VuoKmUILhUvXPRq6wnNLtQ7uZBqOpuboNgSWdVy7+WAkLBb
 hRhzCvzWDCWdRv/haQzBP630E/AKITzgsDAoSA+csp70CjA1PjGVN6IQPsfbRAOpIKrH
 DHow==
X-Gm-Message-State: AOJu0YxeHqS5SVTRpqQOqjGWhiBAMA9q7rwki8jy/EouR8ld5x49fkgq
 Suc6rE13Ev9TAKeWa4FTfpNYohU3VcUWnO1MCdecIhVu8YDh5ydFQbwN/lgLtGCXWgtkV/zAQ38
 OL3WXKedq5GRIHOi6J3dE8dEKGzxc5IkX1ghiNVlU7adGgZOZLQCN6E332UGbFWDn22sBSTvOev
 QQ9xeGI+op6qFaV29KKXReQ87GnZwf124/6Q==
X-Received: by 2002:a7b:ce0e:0:b0:41f:bcd7:303f with SMTP id
 5b1f17b1804b1-41feaa38a8emr254674035e9.16.1716033788055; 
 Sat, 18 May 2024 05:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHADIXvj3wZjEH8pm430uMpHilS99+mV3AdMK0hUMot1MqyzLa9LRRGCGLDYzoisFXHsuCQmg==
X-Received: by 2002:a7b:ce0e:0:b0:41f:bcd7:303f with SMTP id
 5b1f17b1804b1-41feaa38a8emr254673645e9.16.1716033787354; 
 Sat, 18 May 2024 05:03:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce9348sm335893545e9.24.2024.05.18.05.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 05:03:07 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH 3/4] omap3: igep0x00: Update for DM SPL support
Date: Sat, 18 May 2024 14:02:31 +0200
Message-ID: <20240518120254.204138-4-javierm@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240518120254.204138-1-javierm@redhat.com>
References: <20240518120254.204138-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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

This change is heavily based on commit e0cc7df9fdf2 ("omap3_beagle: Update
for DM SPL support"), that did the same update for the OMAP3 Beagle board.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/dts/omap3-igep0020-u-boot.dtsi | 14 ++------------
 board/isee/igep00x0/igep00x0.c          | 12 ------------
 configs/igep00x0_defconfig              | 17 ++++++++---------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/omap3-igep0020-u-boot.dtsi b/arch/arm/dts/omap3-igep0020-u-boot.dtsi
index 41beaf0900c3..2c03701c896a 100644
--- a/arch/arm/dts/omap3-igep0020-u-boot.dtsi
+++ b/arch/arm/dts/omap3-igep0020-u-boot.dtsi
@@ -5,20 +5,10 @@
  * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
  */
 
+#include "omap3-u-boot.dtsi"
+
 / {
 	chosen {
 		stdout-path = &uart3;
 	};
 };
-
-&uart1 {
-	reg-shift = <2>;
-};
-
-&uart2 {
-	reg-shift = <2>;
-};
-
-&uart3 {
-	reg-shift = <2>;
-};
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index 8a3f290f678f..a35a7cd3b1f7 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -29,18 +29,6 @@
 #include <fdt_support.h>
 #include "igep00x0.h"
 
-static const struct ns16550_plat igep_serial = {
-	.base = OMAP34XX_UART3,
-	.reg_shift = 2,
-	.clock = V_NS16550_CLK,
-	.fcr = UART_FCR_DEFVAL,
-};
-
-U_BOOT_DRVINFO(igep_uart) = {
-	"ns16550_serial",
-	&igep_serial
-};
-
 /*
  * Routine: get_board_revision
  * Description: GPIO_28 and GPIO_129 are used to read board and revision from
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 6df6c33e25ab..c1b873a17efb 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -1,4 +1,6 @@
 CONFIG_ARM=y
+# CONFIG_SPL_USE_ARCH_MEMCPY is not set
+# CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
@@ -40,16 +42,7 @@ CONFIG_SPL_UBI_LEB_START=2048
 CONFIG_SPL_UBI_INFO_ADDR=0x88080000
 CONFIG_SPL_UBI_VOL_IDS=8
 CONFIG_SPL_UBI_LOAD_MONITOR_ID=0
-CONFIG_SPL_UBI_LOAD_KERNEL_ID=3
-CONFIG_SPL_UBI_LOAD_ARGS_ID=4
 CONFIG_SPL_ONENAND_SUPPORT=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x84000000
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
 CONFIG_CMD_SPL=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_ONENAND=y
@@ -59,7 +52,11 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_SPL_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
@@ -69,6 +66,7 @@ CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_NET is not set
+CONFIG_SPL_DM=y
 CONFIG_SYS_I2C_LEGACY=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MMC_OMAP_HS=y
@@ -81,5 +79,6 @@ CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
 CONFIG_MTD_UBI_FASTMAP=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_CONS_INDEX=3
 CONFIG_BCH=y
-- 
2.45.0

