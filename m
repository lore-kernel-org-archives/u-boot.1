Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D27EC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A868960718;
	Wed, 29 Jul 2026 14:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUyQljyrAYto; Wed, 29 Jul 2026 14:48:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF137606D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336529;
	bh=fL41GQSQwZf94m3lC6+nxk8keK7aLUslNIEwn5xQS8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSMyyzVOZ3s2/wj6UdcZfH1M+tMd6GwKg2dam0r0FdFu2vKTKjVBBKI+u/3anbuyF
	 81D6XjNrROrtl4blRtc+SiyDE0k+L/0wHzlpqsuws+jOoDY/Px9xOLQ9/iPjNoorp1
	 7XiK9SGT7XlGnM/EAhSxhEoIZ6v4vJv7sVIr5Nokm5IqjRPeDkhp3eafZorQoCoh2+
	 aWZR0+APOT/JwzZg5GTiM7+75cQ5fY1dDikPk1Q6bWXYDWzO7vpHkKpj7dcv7uIti2
	 QjIFJRQFbFCYJr0I5kcxZ5QnrzUZqoMvL/OrxUAMF6KwCiLQKxsFBG9nfqjFABX/ds
	 hdZvxmZltBhWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF137606D3;
	Wed, 29 Jul 2026 14:48:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FAE4490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6146B4027A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATw-hW5NW-K0 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:48:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9F6B64009F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F6B64009F
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F6B64009F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:48:47 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-848743155bcso444192b3a.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336527; x=1785941327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fL41GQSQwZf94m3lC6+nxk8keK7aLUslNIEwn5xQS8I=;
 b=AYS3MpYxNQ4x2cl9SC5tzsixZ/vsxdIA9jpjbRuQYYccl5WrxBaWsm3X/wuZKy18B2
 DamDg6L4CNJqmPIsGPX+jq+TrdXUAiMpv61eHccG47Wp0Evc9HK5LUZaaDOYO5c4jdCC
 mIo4TWPfbQk9RBeM6K7bE+ILFWcxRCOBrqSKQZaidlla3sdBK3er2uoy55NRQdH4datF
 MjN/dmBV9nZkpcg2yXKVfVW2N0Ggf4UKNZ0Oh9ZLZym/ZOh9FEJPK4TEITWh80Uw2ehF
 l8VlZsx2zv99QtPo/nK0bejmvgKabeaEuZ/kdLJ08+ctF4i/NaQXLRkfA+l25Lhj3Pd5
 nPKw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roipwr/4LogwY+45fy6O9qdxghQU1whC2t6ATX4ZKczJ8ioIKT6qniVtv06Wm3mtIMBwJ5UPHA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yye9layFaifuqOqVGHOSASWutk+vi5fLbGwLg2cykuG6ZlPkUSX
 D6IIti6juiupju2oZJk53PTjojeGoVtW0tD0uLihV0KMLn6sWiaJwks4w9XnrLi7z6Y=
X-Gm-Gg: AR+sD120mZNPZwST2i62LuZEDjuMksoNcd42DO/C1QWcE4rDjjgpUg6zXP4VLztOLff
 9LUnsGOwU8aWA3QX0Kge/DMo8ANf4sffzNrprJQh+T05MRT/EdnRtnnnlicvvu6Nozw1dHAwM/g
 Ag9V3QNoMFNmmbKFK//kmffGKa4sszW+lH74w36H9dbCHYwzMNQ41Xa/GRyaLXKPBzBnf3SJVXi
 vRaJ9D9o3n3cWY+gIsPY7M++WWqk0H1RLBUQfZ4sMe5GluduiMR2n19QTk1fQI/OGPgI34FBX6s
 YcYquMQMS6aJsJ5AlOvcxBIEl1jrs/cdGRy6TVOJkuIg17kbK1TX5fFhDi6hPUvgcfi770GfqDd
 DAB2SflCp13TV6n0RGOqGanBSpRWuJzqoVq06fJ5i5UdCtxV5pORg0RL+ZJfcO92eK1SDKEQPmK
 uavZh1JoNPRO3Lr3bupB5robCk1682pdFA3jT5hrDVRj0iam9DznKvqMCy6yQdUmDwjhLL3U3bL
 6j6WAtN9j+YpVzIkx0EQZJEpBmkMylQPsa5UFVjSkGQIH/rVAviDhUSatWUs77oTy5X8Kd/alAU
 PG5DFmvb5v/FJZxEOOH6SN+lxA==
X-Received: by 2002:a05:6a20:d4c:b0:3c3:91f5:82c2 with SMTP id
 adf61e73a8af0-3c8ac2400e3mr8572257637.16.1785336526901; 
 Wed, 29 Jul 2026 07:48:46 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:48:46 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:19 +0800
Subject: [PATCH v7 01/11] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-1-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336527; x=1785941327;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fL41GQSQwZf94m3lC6+nxk8keK7aLUslNIEwn5xQS8I=;
 b=anpqYL3hilHAsHnc2XgbUOd/xsDV5jXO8SmoDCgTr7YtKBLwRLX+Ha+IJ5QFrT4XBD
 yzUrFspmnA41FGUSJ7eRcQt03HxsYy5VE2xcg8bTVqdH38H1X+mwTOM8m0ol5TqyPSH2
 A6Mr50Fq9My8Xx2XjucofXxqbLUYaqkq+ybfxyPhfcwEhsOnlYX/1+Ba/pAVa9kKjkCS
 NVoNisJ4Sv7+Cd0oWgXS+YOBU9EcdSEUMKDYC9N7HJvMTSJjA8VNMWmTWTyrv7nncr7v
 MJc6TXBBVlBYuhTmnY6WC5VgShn5o3vhuJO/t5zPfruBGXORzGJK0/1sT8e/Zfw4gTRx
 GK7Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=anpqYL3h
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
---
v5:
- Add blank lines around the switch statement.
v2:
- Use FIELD_GET() to parse boot strap mode.
- Remove comments on hacking. Since the sequence between eMMC
  and SD device is exchanged in the upstream DTS. So it isn't
  a hacking any more.
---
 board/spacemit/k1/spl.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a2d57..613e8c4cf02a 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
@@ -22,6 +23,17 @@
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
@@ -46,6 +58,17 @@ typedef void (*puts_func_t)(const char *s);
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
@@ -354,7 +377,53 @@ void board_init_f(ulong dummy)
 
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
+
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
+
+	return ret;
 }
 
 void spl_board_init(void)

-- 
2.51.0

