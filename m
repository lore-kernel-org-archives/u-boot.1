Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE8C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E859760651;
	Mon, 27 Jul 2026 06:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lSUn_g5NnBMF; Mon, 27 Jul 2026 06:59:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B32C9605F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135563;
	bh=Uv0TwsTrmXRzrzIQJ00JXnTaAPezwxkmNdh9TpciAIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0dIoy+RQaD1S7ICMIHd6UZAsX4YctLFK6aZ52Zrp1PrEnNf5Hra7wX7NfiHWLowh
	 Gxk/hOfX2AyiIa0QLt89qKi9P8vvHc8wRXjLTY8zhJBbd9Pv6zY34Bg8fvbvsG4nKq
	 v8GDUue9RRCygAdnShCCJS4Dex1S67h4FV+L90VKeryhXsSfkH0WisdAAzYyW356Gt
	 Hw6PFqjOSntxuv/LH0lhBcOvuihEjKYuUWIzqLg6Xj7b5spRAmGHgZ3s4nwaLMryUO
	 XEqYsDy04TNHsJqDcUjWfDXqPKq4jxQXu0XP2Z6C7yS6FJkRjtTQAdktV/RUL3ghCy
	 tFIuJ8iGMcxxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B32C9605F5;
	Mon, 27 Jul 2026 06:59:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16FAC69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0956D4009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQz6FQmNE3JX for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:59:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D07E04008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D07E04008E
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D07E04008E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:21 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8423f236418so1620663b3a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135561; x=1785740361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uv0TwsTrmXRzrzIQJ00JXnTaAPezwxkmNdh9TpciAIc=;
 b=i1HoTQn/XWdkMpwpI7Lzw91x8MA2a6rgnstSWBDBmh9Dt3k6yc5nc4D4Vh5rPWgXMi
 TgHhRU4A5zPOLWuPiI0F/67pXETUWpqxnCriRJxvkziQ33wTNdhV9BgAltDfLXF6kxFJ
 Gl9UNrkjsQ4IjJm4r8iMN/uKdLY9x8dVcKqLqpxznFetlDQq6wztuXsC6k5GeKoXrO0a
 K3ZcQfqyYLMdwO22Wx6qNGOSdZ/KxibiuV5HAUf02NA5BVGcZ4KqIiwE0WDL+Ur6v8zc
 k9eC3eqmEfPzHep9a8+iQHOx48FaF20gdrloiwSEPKatigXd96EYZo5sOBzpGXpnO6YV
 GKrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEXbxcYtmwKFcNyPEHUYy0quGVbh6JthFPu7DHbta3gOtxh6UcV/9fmVkUJ/cT00+ybZWjkME=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwENVfTzDu9DFUrD2VU9qSR784yw6Sw8/nNwOo2g3lBLiL3/vWy
 izMaJnqXx778bNTwdxIQbbkBpQBxOs6RuTB5/MN+qoi0ol9HQcAPBcwzRLqNJzpVkb4=
X-Gm-Gg: AR+sD11rPvJM/qjSvQ6d0/S3nnOi+KiftA6k2jmCmQf3f+7E3eoHt0y/gvHFMA85uSk
 /l78v0H/NyoveOYs1wZbufyaEp9gnHw1Bjq64BXGR7ppIjhK9BKPGtjPvjiUXwZe9tu4gStuHKj
 mLjpJUj+cdeKdMxeGy2Ehmg1AUGp8PvtKdhEotEse5vLJB3gOKWG5WgjB99Jc8N6MG/5rwB2ikK
 ZvbOWymWjMqRBUDvgM44pX07vOVtDemDHXZfB1qJvb14auxVQ+tYpSkMB+DGs0DFWNdiimEq82/
 YFIHrhp6XZ4K5cCn5M8weaC0uTOCQ4jIjgX6a9SNccYpHPKQb8vRhZrhBvJcNN/Y+MIAfN/GiQB
 pHUru3XZPdd3cns/5DfTVZw4n6C3jFj11nKvf85qZ0UNzgclx+SVDsTZDUesGrHL6czFpqzTxgp
 g4eA4kc5HLanu1myOq+DVjOUuwRixG7Mg71J1lL68+3Xfi7d3PZzNgpqvdSxW87IBUl/yVRqhHN
 Fhx7oOo6WnLmRZbCbUPOx/7vSwKyYdBMeQ1n9azWY9SPvERzhkb9g==
X-Received: by 2002:a05:6a21:9cc9:b0:3bd:4698:e7c4 with SMTP id
 adf61e73a8af0-3c67df0ffcfmr6335080637.42.1785135561249; 
 Sun, 26 Jul 2026 23:59:21 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:59:20 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:03 +0800
Subject: [PATCH v6 01/11] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-1-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135561; x=1785740361;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uv0TwsTrmXRzrzIQJ00JXnTaAPezwxkmNdh9TpciAIc=;
 b=PegAPQceZ/7mn5FgKsHiaoYpeJF6MQKsQQ+K7sBxBqkYX+wPkIleO3uxFRSEROymSd
 OfafEO3g2Cm7nhXi/2DDcdNRHy78ksRfQL70vK0B19q+zNk8efqjAeVZBLkE3BvyBWfN
 PyABS48oPHywi+VVIlPMr4yQcZjmU7g/1LO/yV8zP0SalC1IKGwsMP28iyTX0rDhUuwy
 G0VCPhlDzQ2P1xqzr4Ek8SeQQOnfpBNIEw56t76gEzoz7tAt2UU5eR0UnCkVB3Eib6+w
 PsWVZJZlZd19rTgZJqIDkZpMaVFjg1FCBqdU+C6A0BZeh39fiEc+ibp+Xche3jfuQICw
 LJ7g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=PegAPQce
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
index d749e21a2d5..613e8c4cf02 100644
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

