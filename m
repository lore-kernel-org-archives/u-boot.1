Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCDDC47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 18:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CFC87BB8;
	Thu, 18 Jan 2024 19:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D8hdJ01U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C7687BAE; Thu, 18 Jan 2024 19:11:28 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9047F87BC2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 19:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e779f0273so45877685e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705601484; x=1706206284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ucwzGKurAqEvkgkUNgA58bIFgZY88dRO3UDWmpIaIrA=;
 b=D8hdJ01U8pUelppYyZyGUYqgkO26j/0E8wnmzuPK4MIJsfergtmqHyVOCUnMZCBQ1M
 +Lb2ZUTlZYX5tZcrCKvtbxzS9xuqTfydhdRUw3+3REsruF/LGsixzlZJq79gY6MMFnDW
 s3svWMnrDG1KBSPiAAi04qWAAW9koMq9JMjtBZSy3xIEPmeqbBLssV/Ookq3g5iWxO8O
 FAbo0GJqL2wLSUMnUpPhR7jYtTnjWPQg1U7NzYkZskfzWSmfZ57Sa4q+m2y/CeKoPD7o
 VyyuczAtXewbptJlJ2Q0FTAR34mkG/eTH7WSFrnXh23dSK479B8VHpIbSKvG2YOTMdTz
 +HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705601484; x=1706206284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucwzGKurAqEvkgkUNgA58bIFgZY88dRO3UDWmpIaIrA=;
 b=N06lrZojHYb6X1oKfvQAqEUAybFZ5sXTnYZQdidXhPlosHd9XKjsJpL3llF1a1du7a
 dXM5l0LG+VMM1Vrx4ah9S+b9zxjoqOBBxr29CotHBeTHiM2Y9nah49rV/UWzPSEqam5m
 W+tXLTceUzBr7ozI9SFtxNp7hur6/ft1IjWHDV1V++CeEQxyAyiqWPKrAKgGnxzaLKMS
 Vk1tlf4CwoJSU3xcPSLLn/ECtHpyCRj+5PiKLB2dmXKc8bBEiCYpfUMKcTgjaCKDuEuD
 ZHy1wonr/+AXwq6fE8E5HRhFS7+1e07tpfRHTzYtRjBvQd99C87FMSRIYClDUkXTVMb9
 omOw==
X-Gm-Message-State: AOJu0YwrpZ5bhZ6Y6GrzIfn+dDh9Li/1YzP0fXgjjAKyTbt3fk8lmjHn
 AZ7+xoq/tTFaEiVe92DgzKbFFNdNwExa+ntRRn9zSR0vMgdV4R9Nf5UI9Ecu
X-Google-Smtp-Source: AGHT+IFukQadPNiBoNJN3GTKRvGS0h0K+xe9RNBRp76i3ONY+Q+labx7fT7hN16afvo8a5Abwvq25w==
X-Received: by 2002:a05:600c:314e:b0:40e:66a5:574 with SMTP id
 h14-20020a05600c314e00b0040e66a50574mr769958wmo.120.1705601484046; 
 Thu, 18 Jan 2024 10:11:24 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 o19-20020a17090608d300b00a2adc93e308sm9328406eje.222.2024.01.18.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 10:11:23 -0800 (PST)
From: max.oss.09@gmail.com
To: u-boot@lists.denx.de
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Josua Mayer <josua@solid-run.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] headers: don't depend on errno.h being available
Date: Thu, 18 Jan 2024 19:10:47 +0100
Message-ID: <20240118181106.4133924-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
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

From: Max Krummenacher <max.krummenacher@toradex.com>

These headers follow the pattern:

| #if CONFIG_IS_ENABLED(FANCY_FEATURE)
|   void foo(void);
| #else
|   static inline void foo(void) { return -ENOSYS; }
| #endif

In the #else path ENOSYS is used, however linux/errno.h is not included.
If errno.h has not been included already the compiler errors out even
if the inline function is not referenced.

Make those headers self contained.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 include/dfu.h             | 1 +
 include/dm/pinctrl.h      | 2 ++
 include/hwspinlock.h      | 2 ++
 include/i2c_eeprom.h      | 2 ++
 include/nvmem.h           | 2 ++
 include/power-domain.h    | 2 ++
 include/power/regulator.h | 2 ++
 include/remoteproc.h      | 1 +
 include/soc.h             | 2 ++
 include/spi-mem.h         | 2 ++
 include/sysinfo.h         | 2 ++
 include/tlv_eeprom.h      | 2 ++
 12 files changed, 22 insertions(+)

diff --git a/include/dfu.h b/include/dfu.h
index 2f42781888a..fa1918cd663 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -10,6 +10,7 @@
 #ifndef __DFU_ENTITY_H_
 #define __DFU_ENTITY_H_
 
+#include <linux/errno.h>
 #include <linux/list.h>
 #include <mmc.h>
 #include <spi_flash.h>
diff --git a/include/dm/pinctrl.h b/include/dm/pinctrl.h
index 70d8cc5ecac..e41baea6200 100644
--- a/include/dm/pinctrl.h
+++ b/include/dm/pinctrl.h
@@ -6,6 +6,8 @@
 #ifndef __PINCTRL_H
 #define __PINCTRL_H
 
+#include <linux/errno.h>
+
 #define PINNAME_SIZE	10
 #define PINMUX_SIZE	90
 
diff --git a/include/hwspinlock.h b/include/hwspinlock.h
index d8556c0b4b4..dd5135442ec 100644
--- a/include/hwspinlock.h
+++ b/include/hwspinlock.h
@@ -6,6 +6,8 @@
 #ifndef _HWSPINLOCK_H_
 #define _HWSPINLOCK_H_
 
+#include <linux/errno.h>
+
 /**
  * Implement a hwspinlock uclass.
  * Hardware spinlocks are used to perform hardware protection of
diff --git a/include/i2c_eeprom.h b/include/i2c_eeprom.h
index 32dcb034973..cba991e3574 100644
--- a/include/i2c_eeprom.h
+++ b/include/i2c_eeprom.h
@@ -6,6 +6,8 @@
 #ifndef __I2C_EEPROM
 #define __I2C_EEPROM
 
+#include <linux/errno.h>
+
 struct udevice;
 
 struct i2c_eeprom_ops {
diff --git a/include/nvmem.h b/include/nvmem.h
index 822e698bdd4..e6a8a98828b 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -6,6 +6,8 @@
 #ifndef NVMEM_H
 #define NVMEM_H
 
+#include <linux/errno.h>
+
 /**
  * DOC: Design
  *
diff --git a/include/power-domain.h b/include/power-domain.h
index 2ff6c77cd76..18525073e5e 100644
--- a/include/power-domain.h
+++ b/include/power-domain.h
@@ -6,6 +6,8 @@
 #ifndef _POWER_DOMAIN_H
 #define _POWER_DOMAIN_H
 
+#include <linux/errno.h>
+
 /**
  * A power domain is a portion of an SoC or chip that is powered by a
  * switchable source of power. In many cases, software has control over the
diff --git a/include/power/regulator.h b/include/power/regulator.h
index 200652cb3d7..bb07a814c79 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -7,6 +7,8 @@
 #ifndef _INCLUDE_REGULATOR_H_
 #define _INCLUDE_REGULATOR_H_
 
+#include <linux/errno.h>
+
 struct udevice;
 
 /**
diff --git a/include/remoteproc.h b/include/remoteproc.h
index a11dc8a9b6c..91a88791a47 100644
--- a/include/remoteproc.h
+++ b/include/remoteproc.h
@@ -14,6 +14,7 @@
  * platforms have moved to dm/fdt.
  */
 #include <dm/platdata.h>	/* For platform data support - non dt world */
+#include <linux/errno.h>
 
 /**
  * struct fw_rsc_hdr - firmware resource entry header
diff --git a/include/soc.h b/include/soc.h
index 850db28b76a..b8cfc507706 100644
--- a/include/soc.h
+++ b/include/soc.h
@@ -7,6 +7,8 @@
 #ifndef __SOC_H
 #define __SOC_H
 
+#include <linux/errno.h>
+
 #define SOC_MAX_STR_SIZE	128
 
 struct udevice;
diff --git a/include/spi-mem.h b/include/spi-mem.h
index b07cf2ed83d..3c8e95b6f53 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -11,6 +11,8 @@
 #ifndef __UBOOT_SPI_MEM_H
 #define __UBOOT_SPI_MEM_H
 
+#include <linux/errno.h>
+
 struct udevice;
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
diff --git a/include/sysinfo.h b/include/sysinfo.h
index f2c1aa29d18..524c7d6b223 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -7,6 +7,8 @@
 #ifndef __SYSINFO_H__
 #define __SYSINFO_H__
 
+#include <linux/errno.h>
+
 struct udevice;
 
 /*
diff --git a/include/tlv_eeprom.h b/include/tlv_eeprom.h
index fd45e5f6ebb..2b1e19b2bdd 100644
--- a/include/tlv_eeprom.h
+++ b/include/tlv_eeprom.h
@@ -7,6 +7,8 @@
 #ifndef __TLV_EEPROM_H_
 #define __TLV_EEPROM_H_
 
+#include <linux/errno.h>
+
 /*
  *  The Definition of the TlvInfo EEPROM format can be found at onie.org or
  *  github.com/onie
-- 
2.42.0

