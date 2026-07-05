Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561B0C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A57AA847C8;
	Sun,  5 Jul 2026 08:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Ph4j5Yiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52EB83314; Sun,  5 Jul 2026 08:08:26 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D2F846FD
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c96d2bebca3so982476a12.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231703; x=1783836503;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=opZdumh25smgHzQg8wjKjzwsUDxkfRieWmqzB6WE9B4=;
 b=Ph4j5Yiq3yPqe63aJm2Z6BXA56dG/5j2cga6urfDv1I1Z7F8vQ13So3uN0GdBiiME+
 OJHnEGSSwlVKczHg0obA8OWH4/Dw4u62htFsIujWW3TYA2aaxk/3KLk8+P+H83zRf2Qj
 nV7wYQ+3ywhH592svnHPYQUk7g8EVRz1+gSrvjBnCD85Rzz562d5gBUkDQ/a43KGzhmw
 J/ys9JJFF7Hn7h0u4US1Z8+izEY1WMAQHQtV45rXeuYuE+4v6FNyaoXxoeYwSF90e8B4
 SQrKWomWPp3bYakiEeaIGmlb4U9PGDKtjMBx7KyV50O4rhET7s1ShJxoXc5u8OJg17G6
 n9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231703; x=1783836503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=opZdumh25smgHzQg8wjKjzwsUDxkfRieWmqzB6WE9B4=;
 b=cgefuY/ohcxQ2LmyZ328DEUS2WHDq0maZ+8ITYISU7fcHplu8XxYSTZE9kQ50Md79J
 0emSbi+1Cikc2O4lnYsSedA3ljSNFhn4c0FtnvqO6UeMLvl72aeKDbLv7yW8cJG9AQfy
 +bz2vAyOI+RM9jxVRjxo7jvtFG6mINLu76PNfHzLgTEH5WSXBX3mNg0Arm7Gbog8QzBz
 elbvo/5s/JxRdZWFhTEif8IAqosV3thuQjLVURTfTETnWg0JYYTpxObYmZ/putkIZwvV
 jIajbuklMDniV+SMfLf/6HEcNgE8XiuRE4eSmNL9dX/UmxJbkyfmjK0sdAqKOW6RrGBE
 Z3VA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3/dgXJWV/T7WCQ7BoF96K5lWXtQbM9WDg7fexOuwQlLC1F7FzyTWHbbm7lDq0BwmnkZJDFBY=@lists.denx.de
X-Gm-Message-State: AOJu0YyDQLD2yoBT+yqvvCIpAQYApPLww6PZygzE4yWC8vr50AkpnDF0
 KihcU4RUdXgPIPwC1bBCOgSazB0epv5FwGaCA4Xm7iEIUtB92qhLhII9KQfLlZJ3EwM=
X-Gm-Gg: AfdE7ckOeywC4kgVzx61qyTCE+NRtnRcLmkCMFCgoNg/VJXfA+bVoRHraKDGQxDmBr9
 XwP/ISgzAhJXKKKQF/Nhco0pwQ/jgcDWAlfn3QR8t7fr/kenTa3YZIQRr0CZ5MijHw1I4AUd6fK
 82ENtP7N2lvXSkyWmGRTggeKaxPbKQkA9GfhLfW6x6tyFU8sEx5LSujSdwgMzkDHI8onaHYwOvS
 xbWL4ba5kUUDFbQCKVp+K5O/pRfBjl27Dny85hwtsyGx6ia9FN95rkjLr9eYeNGt/LmhFoJvR34
 wTCE5wziy2OgTJl3P5HLQBtjFwC3FmYa3W0dLbXnoVTBR2WIgHM2u1ZQOVMLg9ZxWPy4JxxM4pt
 3yPSb3iDKBG7pC+tv31sOzLPJGCmVVpqdc5zWdtNk1QqLT12AQizljsUEQdDFBoCKVMLweIQASj
 RhIKqcUzzluv7m9iABEgqpZcys7lDOX/tA8qf/FYJfUneGEJC4ICBfNmxo1Y+uruGqnbK8Q+njX
 V28Q99VjrLIH10CCRjmfLXCrreMXd8ScECDvG57y9wxrkPyLzoZHg==
X-Received: by 2002:a05:6a20:3c8d:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3c03e312e24mr6968920637.26.1783231702698; 
 Sat, 04 Jul 2026 23:08:22 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:08:22 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:07:52 +0800
Subject: [PATCH v3 1/9] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-1-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v2:
- Use FIELD_GET() to parse boot strap mode.
- Remove comments on hacking. Since the sequence between eMMC
  and SD device is exchanged in the upstream DTS. So it isn't
  a hacking any more.
---
 board/spacemit/k1/spl.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 0db362130e4..70579637b5e 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <log.h>
 #include <power/regulator.h>
@@ -21,6 +22,17 @@
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
 
+/* boot mode configs */
+#define BOOT_DEV_FLAG_REG	0xd4282d10
+#define BOOT_PIN_SEL_REG	0xd4282c20
+
+#define BOOT_STRAP_MODE_OFFSET	9
+#define BOOT_STRAP_MODE_MASK	3
+#define BOOT_STRAP_MODE_EMMC	0
+#define BOOT_STRAP_MODE_SPI	1
+#define BOOT_STRAP_MODE_NAND	2
+#define BOOT_STRAP_MODE_SD	3
+
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
 #define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
@@ -45,6 +57,17 @@ typedef void (*puts_func_t)(const char *s);
 typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
 			       puts_func_t puts);
 
+enum board_boot_mode {
+	BOOT_MODE_NONE = 0,
+	BOOT_MODE_USB = 0x55a,
+	BOOT_MODE_EMMC,
+	BOOT_MODE_NAND,
+	BOOT_MODE_SPI,
+	BOOT_MODE_SD,
+	BOOT_MODE_SHELL = 0x55f,
+	BOOT_MODE_BOOTSTRAP,
+};
+
 struct ddr_cfg {
 	u32     data_rate;
 	u32     cs_num;
@@ -379,7 +402,51 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	u32 mode, sel, ret = 0;
+
+	mode = readl(boot_dev);
+	if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
+		sel = FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MODE_OFFSET,
+				readl(boot_strap));
+		switch (sel) {
+		case BOOT_STRAP_MODE_EMMC:
+			mode = BOOT_MODE_EMMC;
+			break;
+		case BOOT_STRAP_MODE_NAND:
+			mode = BOOT_MODE_NAND;
+			break;
+		case BOOT_STRAP_MODE_SPI:
+			mode = BOOT_MODE_SPI;
+			break;
+		case BOOT_STRAP_MODE_SD:
+		default:
+			mode = BOOT_MODE_SD;
+			break;
+		}
+	}
+	switch (mode) {
+	case BOOT_MODE_EMMC:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	case BOOT_MODE_NAND:
+		ret = BOOT_DEVICE_NAND;
+		break;
+	case BOOT_MODE_SPI:
+		ret = BOOT_DEVICE_SPI;
+		break;
+	case BOOT_MODE_USB:
+		ret = BOOT_DEVICE_USB;
+		break;
+	case BOOT_MODE_SD:
+		ret = BOOT_DEVICE_MMC2;
+		break;
+	default:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	}
+	return ret;
 }
 
 void spl_board_init(void)

-- 
2.51.0

