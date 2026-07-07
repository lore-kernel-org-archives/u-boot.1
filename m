Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB9C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E2A849B1;
	Tue,  7 Jul 2026 17:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="SPLDAzFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E9A849B1; Tue,  7 Jul 2026 17:22:15 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB59A84994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3825c406ffeso3567280a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437732; x=1784042532;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opZdumh25smgHzQg8wjKjzwsUDxkfRieWmqzB6WE9B4=;
 b=SPLDAzFlSEe0pSqN4R/9B7RjX76T/3RZXmXUfyZIOI8qnCcUpgJQD7pclAA8LvZFRc
 vr59cA/8ZDr5OHjYMnSY9whu7ogT2haZOq1fX1SllUcafIhHOnbT2YBE6f2EDY7o4vEQ
 Za3XE0Vn8JZdrtyW1xkCUdC6wZUzL1lFDfI0XU4stLGyeebl6c9RKXg1LVxPqPrYRaTu
 38I8gQZD7Dk9xcRvSgfgOUKJbxyrQ2AVTvQyuKKtRnLQLv3lwi6XFbc3/bheJCBdIuGM
 pFnS8luNXf1zbsUggST21FhzwWN4KtiRGSq3+E5xVVhV/2aIFyIBi9ZTlGqLUvM6osMx
 UGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437732; x=1784042532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=opZdumh25smgHzQg8wjKjzwsUDxkfRieWmqzB6WE9B4=;
 b=R+IycBAw4uJbxN4p9x8o9VG3CIP8rVN8CSbjpelPgO7QqhkJZBIDrFqhjbNBKuCKz9
 V+iuoFWI/H8gHZLjZ3G2QpaFfuuuUHFFAcDGy+9ua7lbrkqd0R4ZHSOZb7lhXu02CzgK
 GrtGBn3xb30fAbRwG7sOEi88XJIXUX6/gaHdeRSfqDGw3MQTUIRWp0pYbPcqSJixYKTy
 rMZ+Qt0pLRytCgPexTdBp4FhaBzFe9fM6YQRk/c4vX0jXuS75f/P+qlAu7SELILnV+4D
 Yu9PfuXNFWQc1f0ibtTmRfHZMPGnaO83b2P/omkppOtqH22nadZ7dvZIORRksUoTtiRe
 GaQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9ARbzqlJBJ4IuwG2rgq2RywXFnQUFq6soTpK6LaYnhei7iCMWaD990IQCLIMVkxnh/qNvXuE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywq/2tsfRlkpo25+CUuSE7eqPblsQUi+qKaWL2k+3r71gzm9rcS
 qkyLVN6j7HXvNpi3SsHSp2Pr0IrRkufyQAhkWris1OLw6mI/k+tPzHt62WUBcayGW9Q=
X-Gm-Gg: AfdE7cnbJTdmfWvLS/vVb7UJrt0E4Na0DIjGRjGils62Cq1F42CNBp8B8MhXszrG9l+
 GixqwlKJMBQC3zmHiHaoq4ZcWdEZOJjVUk3VrBfb5ODstBepTyLQSdx+opKpb11tknIY2LJSsjP
 JpXvr+XikRtR7orOmfnuUNIw7QdKBEmUb9K8feCCxYKt4zSuDO7LF9TiusCvwjFQthrGPyIuR6g
 QR+EL3cRpwFHcFOwcplGNXvFLoXVMHav92r/Tw5aIHfJwmdw2d97PokbmUYqSgTWQU+sa8bJ+Zr
 sZ8g5fw7tljsykopv2r2H29kHyPN9kdkExOYVq8CW3jN70yFww94h1H1Xg3FQkKY7qtfza8Y+fo
 nr1iSDfzIgY9AoA8qvOqngmiNjKCFlPaB+2f/Iom1E7Lken1qGWoG7+cTvNMLFJsaGw1t1PKPDh
 e1u1zCrI9DQYXp5Gj0xRCEiWDuEkKED+95AeayvzQhzmYVHUimKtMcb9Wvzm5qMjQL2lpgJkBEn
 +8gmD03I9DQcdC2+FHWuL5ysYXri2LmegzYFtyfx1kJXeTnLIFpqA==
X-Received: by 2002:a17:90b:58c6:b0:387:e0db:3d8f with SMTP id
 98e67ed59e1d1-387e0db4389mr2976233a91.42.1783437732206; 
 Tue, 07 Jul 2026 08:22:12 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:11 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:42 +0800
Subject: [PATCH v4 01/10] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-1-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
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

