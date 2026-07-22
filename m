Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D000C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D31014089B;
	Wed, 22 Jul 2026 15:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iU_kcQOwaQFH; Wed, 22 Jul 2026 15:07:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55ED8408A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732852;
	bh=qaBASICGKT+139xNEa0zNRxQvQvPycskiNDeo7LRb0w=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XSyEeKgtCmaQ7ARdCIMpTmSNy7qm4jZKCxViA7qSDZnf0Mi3VXT3RpikE85ADbSTh
	 iPPFGG7wxWZSIsuo2Sp7uWX/+UWP0asYCLRvrr3UN8z20J2iUZtSks5dUpDNsCAh3H
	 04fXgB5aGY+G/WyxbT3nfFPoUecANJzVnXTwqFUNytqvbr/W+RWkkvjyhl25AS8/1X
	 i2smSzq8nPMMvC48wmdpe6OK65Trlo3wbnNrmcFTbUCChkxg80t4rwVyA+G5mS+mYF
	 Rs/UCilaOBzbK79laW6/YF+uzJkemJHNjGEiR05C0PDTxF7Kn2mJQF23gwtSiojo3E
	 QExgHybFqI+cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55ED8408A9;
	Wed, 22 Jul 2026 15:07:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FDA21093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65C5F400BD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zif7wEAtZj4X for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:07:30 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 201FD400B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 201FD400B8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 201FD400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8101F8494B; Wed, 22 Jul 2026 17:07:28 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC2E848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:07:26 +0200 (CEST)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso13792910b3a.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732844; x=1785337644;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qaBASICGKT+139xNEa0zNRxQvQvPycskiNDeo7LRb0w=;
 b=jaIVbO9szg9Y4UiOXxSXEsF/u8LzApYkcXS6LgBa1tFrt2239FjbiclCiPOmF3mcoH
 9Tp/zFwJh2YheCHQL+BJ/1fj9jlr4LXkPF+CGtGKWwCVu/0S8fDaGafivpvShwj8n18a
 tcAthpYR/lgAJI3U716/eQTJ3wCf+6h8s8y0jhAmNCZHzLx89pWONyY7Uoav83SNFScR
 ROUa1JzVJfjcLry8KW7sC1yZ8dI7EF++3d6MyZuuhJ52p8oHDQUKH/yszqJyF0x48p8y
 IMa6ExGuJJKYqjSdt4PC7GetApx9iIJiI61d/plueStaq7ckkoRTC+vY3zBvKaIYsQgq
 7Wig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpivqR5FDEWx5evKq/2zTCiKrSUo/wb7KYvUo/VW5D7e41RDoecgIgiV1CtwL88GxDfPG6O+bA=@lists.denx.de
X-Gm-Message-State: AOJu0YxHiYSBd+VHdO14nby5ScNsR3TFZfDbBgDnATybLooA+gWQvQ1C
 vZQmerC9FhZHdCYypRIEkPUfZCTvj7oUYA61iFyRhugUobqwxYrrvAmIxsjpi0rjBsA=
X-Gm-Gg: AR+sD10S/3E7RASNPb9Swptj7alqRt9Q8zdkfCRxWIYPyc146ZXiO9IbjRE+Zi2+V0X
 DQP2UqJ6GkNya/xOcgBGsAvutZIqtnzGghAjixp2ga/12DoJRCsb/qTRp7uM1k9AAMBQq8K/B6s
 /lV+x1rDaW7LYrXpeqxiWw6MSOujOKUPS9oHA8lL622pGAiaiktk3Ik/s6E2acdmh0xGiIAAjnS
 wfqf4xoqBjmI8OGacLPB/RPmQItKzniWkPDe1hXny6BP9vj5ThdvPoTmVy/InvPMDFE5rgTwR87
 bqU37KZJPzkR/LAHP9AclMlmfSsdIbJn/5Oi3/Nt4DVCpyp1qdkXMC2ID3hxjIHIewHGtkkvJf0
 1FLf3qXuYYz+wb3ROWg3HNrtk+vrSbwlwOPGu80hAFKmaZ4xi78MkfSP5CNcXbluYtHvJCVfzB/
 fRAYnhwwUviACRe3zuUmHIPOWTQqu0ynsH9rtuK/VoKWKmw/QM7W82J3Tb4hxukUIsqWyTh8mC7
 I/6ICLnbfDgCDJT36xDGN58EqUdvwAtOecqidztIAM=
X-Received: by 2002:a05:6a21:4591:b0:3b4:7eb0:47a1 with SMTP id
 adf61e73a8af0-3c3ad62ac62mr24617248637.19.1784732844083; 
 Wed, 22 Jul 2026 08:07:24 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:07:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:06:57 +0800
Subject: [PATCH v5 1/9] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-m4-v5-1-c41a951e5157@riscstar.com>
References: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
In-Reply-To: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
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
 Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732844; x=1785337644;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qaBASICGKT+139xNEa0zNRxQvQvPycskiNDeo7LRb0w=;
 b=qiyQ7JjXfz7GeSCh+YGlGyi62k4ocY3vxbwkC/YB+gKCDlh1H5hmlUQ3AIWJortTIj
 W3Cz8UbhE/UaC5Zx+hX8gT1Ed+E/8OTFeAHWO2ZTvs/toqq7L4a0kdh7j3S3CBqsviKu
 H6JYVOjHn6NmaSUDwf8cXeY7rw/IAypcC1inMhQgMHjayfaWDa0P8eKELeHqjfnJAWUX
 y1/MT8O1dQhoIPYEnK5M7iOsL2f/3Bip7DeF/CWyTyYvsVe62XHcqUR3fCsYXLpengvG
 V8LAtRpYgfL2EGIiZOyB7OKqOxsrZABbScsRbkiieWUGdeXC7ZWov8SCQkbP9Vz4F8pI
 u+zg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qiyQ7JjX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="qiyQ7JjX"; 
 dkim-atps=neutral
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
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
index 0db362130e4..cac89bb6844 100644
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
@@ -379,7 +402,53 @@ void board_init_f(ulong dummy)
 
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

