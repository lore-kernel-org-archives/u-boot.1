Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5167C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7126580C10;
	Mon, 27 Jul 2026 06:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRSAC4f-gN5v; Mon, 27 Jul 2026 06:59:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCA0480BA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135571;
	bh=x5dMYOObTt0p3kQPxcxabaqoJQ5ul/pm5yoMubiRJnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzhY3SmHd7K+hvfAUglXUU11KIZqKwjWQY9taVhyEHzlXIDvfuF+HZ4Ob8N+pmg7o
	 PAxq9hgfRIyH/mtlmYd7qLgL//LP7LE9ywM7TLbRmvDXLjO9KILiXeoy9dtSoxouRr
	 vPI1HQTXr4xElds5N/n7orH1J9+ValSxauC8N9A7ogF1SBYj4L8jcLLUvlmSh1VdX2
	 4DlelRhpZ1y1JwArnINwCH78bhKyxl1k+3rwEJysmrCIYjAFXEmS7JktbHKFJxONL6
	 JDVnq6w1owR86VOUwMdvYFkMxd31/iNeGMQU960LvcVtTb+D01TTlWUxec1VDzzRJt
	 vXxJ9jfEwnzSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCA0480BA2;
	Mon, 27 Jul 2026 06:59:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 227D12E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 089C060602
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNpI_zdJq-EX for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:59:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5A8B0605FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A8B0605FC
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A8B0605FC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:29 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca97d139d8dso1300652a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135568; x=1785740368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x5dMYOObTt0p3kQPxcxabaqoJQ5ul/pm5yoMubiRJnw=;
 b=c6LEJDGLQ2H0CipmYoEGSQcL7ldcCiONR3QlU1HlcZAmuujhfm7EhuYOUAylM7OH8H
 URZDRFz9IvaRUDZMJFNrFHD3ZsvgMnAEPrcbBPG422D2Mtq46GTLgyWj0aLiIhXqhFQF
 y/MBMbOp3W/ykvzHJJlVWoZXbUQo8zJcEJAWmP1+y7cniCwaOM6N4274yQqIM+eq8HsP
 CqN6lIaAjAN/z+aXAD1qF5uYqygZ8UCNkUaWDbBWTcmxZv/i71JAkNq/by+J8INioC9Q
 EymO4npAzGa053ueZ2Lca3NaCUP5Sz3YbrfE+2dm1bbO8Krk+Hj41CY94ml1MDIarY5S
 sdQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL0RFGSQhC7znz1YNpXsGkmEfYi4IGoA7KQ5gPjdhcGvzW1+ZBuaOWXzbyAdjJAffaIvG3m0Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxlvlII+T1e2QOi4bU4d52Izi1wrwja7gCyoqFPPIUjLwFutGsB
 mQ1Kpy/ksKTVOMwqqy2Nccy2ujXwzvS/SOvZotPg9umahW0+xStoyN87HAGYBUhCb68=
X-Gm-Gg: AR+sD11BIAFA9Y4k3g9Q7uClhGAcPI2rCPelBhFiRxgaHz/lLvDE2XNFvgk1wKmE+VX
 /hBf3xOiPvToDlXBoEw6TjZe7LuUBN4Xz+lhCHJg2NHFsTq3gapzgDyQbsecINiVPh+ddoEWKw/
 LOGXTPxP9ze2qQeAF1lNv+od6RVPC1xD6GOdLc1fj8qXafLLuZNF1SkOGMfSySM5Gc1OsWomFzm
 SLRuKfptGi+mZtRUgWoTPFZFFpAskDpDO7PokY31KAUvTyjAPklbS9oZoPPlyfUnYs6eU9Ny7rR
 c3fdrv1QEXp8NwWzRvsSXrmQhMmzS+3BLX3ufQl70uqHmZ+/HLLpjmwbkAHXL5OIgzFgk8gM3UY
 nyLFNCH6qj2yv/Ehs4Wt0oD00AvhefHfnmqfHlHk4H9QtsstDC2sLpZ23azwhl27kC4YJEw9/3M
 tb8b/VVU6tXaPwYrZftAC60rQT7GYlYAmTEisx+kp3vYOpkACklMH75xRGOOW4b1iGiTYzsgWSQ
 D3Au2YsZSLdUVpEn/a8wON5lJ2zRhIt1bobI4TQrzA=
X-Received: by 2002:a05:6a21:a05:b0:3c3:7c0d:fc85 with SMTP id
 adf61e73a8af0-3c67e0f1c33mr7740224637.76.1785135568589; 
 Sun, 26 Jul 2026 23:59:28 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:59:28 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:04 +0800
Subject: [PATCH v6 02/11] pinctrl: k1: fix drive strength configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-2-2f58566d48ca@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135568; x=1785740368;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x5dMYOObTt0p3kQPxcxabaqoJQ5ul/pm5yoMubiRJnw=;
 b=V09lu76LejSBYt0uwEMbFW9X7faqOqJyRsyIOkRb2oAJNKOjKXCYojcZxUXi/EXz3J
 DwWSMz0DgqZmyH15VYZ8jfzUIGHcFggritGYO1j/Sm0NhJnMISWRXpN1iKNuso1VmFQB
 eJck9p2a+AAvVR2S5mtn4Q/99YfZGs8aQyrmjpqCv/K1v3s4cUxlH48DkgvQpt2TiasY
 0iH2/UwCzFm4Kcs0bI6kS0ervzPZaPpkIJdRs6RmIOyCkH8D7nkJamwL7KYqJoVNhO2u
 gp5vCvqTbQWnQ/kBHOwzUGWWsQcrx3aIsFaOuSvenxIUxbnfv/X/HFAtk1Ya3qKy2ES2
 etLQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=V09lu76L
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

Fix drive strength configuration by:
- Using FIELD_PREP() to properly set the PAD_DRIVE mask bits
- Not overriding io_type with IO_TYPE_EXTERNAL for external pins
- Returning the pin number instead of 0 from pinmux_property_set
- Removing redundant zero-initialization of the mask variable

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v6:
- Fix drive strength configuration.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index a6a22eacac7..6ed511879da 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <dm/read.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -386,10 +387,12 @@ static int spacemit_pinmux_set(struct udevice *dev, unsigned int pin,
 static int spacemit_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
 {
 	u32 pin, mux;
+	int ret;
 
 	pin = spacemit_dt_get_pin(pinmux_group);
 	mux = spacemit_dt_get_pin_mux(pinmux_group);
-	return spacemit_pinmux_set(dev, pin, mux);
+	ret = spacemit_pinmux_set(dev, pin, mux);
+	return ret ? ret : pin;
 }
 
 static const struct pinconf_param spacemit_pinconf_params[] = {
@@ -406,7 +409,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask = 0;
+	u32 mask;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -433,7 +436,8 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		for (i = 0; i < priv->nr_io_pins; i++) {
 			if (priv->io_pins[i].pin != pin_selector)
 				continue;
-			io_type = priv->io_pins[i].io_type;
+			if (priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
+				io_type = priv->io_pins[i].io_type;
 			break;
 		}
 		if (io_type != IO_TYPE_3V3 && io_type != IO_TYPE_1V8) {
@@ -441,7 +445,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			return -EINVAL;
 		}
 		ds = spacemit_get_drive_strength(io_type, argument);
-		clrsetbits_le32(addr, PAD_DRIVE, ds);
+		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		for (i = 0, found = false; i < priv->nr_io_pins; i++) {

-- 
2.51.0

