Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCC9C55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 938EA80E51;
	Sat,  1 Aug 2026 16:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHypkTH_VryG; Sat,  1 Aug 2026 16:41:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFFEA80E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602472;
	bh=ROR+qGCDwnxmrW5tdKeKQbw6hKqk4WyFrrTMRxwx9Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kISWZv6rsO6TtpRaYYQ97AgYeYp9sztLGKIQ83uZnuvqaLwbuXp7B63RBD7ZSFbDe
	 qFxoP/OxFnj46ZstCC/0Tro0D+emujwQBe2kNHQYGH2Q6yBrvcIa9FNuCZo2NdPDcz
	 z3Rne2xibWMljwFew7wAuTy3btZaoJgyTgBbQnfFnyShpFSbWcsf30389VG6hoxQnC
	 QAF1gSobox0xMeVrwqBEAtYRoElY8dVu/La0TgJ8Nu/EdXveGnuvGAmYr44WNML7nF
	 ZUfDEYlHv9iDNeGMayxj0D45KSrelGM3TzLM+ehef3mPNr5MMc1Z6u/+b8Cvam5ibf
	 YQkZoH2YHdnTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFFEA80E3B;
	Sat,  1 Aug 2026 16:41:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A93A73B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FBA640025
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uUhRArEaMpH8 for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C4CC740015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4CC740015
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4CC740015
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:09 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc891373e0so21429845ad.2
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602469; x=1786207269;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROR+qGCDwnxmrW5tdKeKQbw6hKqk4WyFrrTMRxwx9Zc=;
 b=Uk/ZhMDuDLJ/GDhAvdAxHbf/FsC3Yqff9yetK+wMOhm9udCv//UAenT1usjRm0D3sZ
 XUIV319tCXT+K47vR6QCyY8lV0itAtw6vF4Z+RoUXvG454O93w33TZ/fh/3V++VRcxbx
 71pZMoRpILNvYh6kdEW/A6fJ+WD+1vW4v9xSJ0rRe5OkLqIhOYYOLsqwA/DA3zUWsUpL
 U8GN02ThrV5ezjrN/nofy2Nd0ebIKfOWaWuaG0cTbCryxQ01GQa1ADSjdPMgRzBHmbM8
 QeSPAXALV7VIq4Yq9M04Ko2pjptehjRVwomHucNCMNNaQxLREz7OvUJ1uq25dd4GAt6o
 DxKw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+5Ol97i+1X3l50H4UWVfg/8TRlaNyEsg7cUYuxXcyiU4lkCgSBiczesK1BebUL6kWw54eTAc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YySR04Dg0OoXnJjDTYzxghBCSbc7GWWyfYuy7RkIjy3AiH9RYel
 FYkhT5nHoHygfUvTSkRQvqD2KxKckNdNNyHOmHsQRq6yJwrDyMTbhtR1ewTW8XixusY=
X-Gm-Gg: AR+sD10hHy9iixqueNOB+ggoBD4uVZo8Y7uQ1A9UM9zZsB3FM+sFmtrHwGGeRJK8FKY
 glT/OyBnuWidroe4SXMJcp8rMHeqRsscNlGeTtWdYutl3imBvrYnsEabE/7cDW8DvhXgmrZESLK
 axjCUrld+lEwfojMPtvdAQW68MCn/ezW9qwRzjy6z8OWhpHbsO3gt8lZ7aklWQQq8/Ns1BD+fdt
 T8WYc6C+nr8kk82+6uTbzfguX0jnPPW9Hiq2pMpp4FV1jgLoIWHMnMzZeHI3nhnWtp88ocMKcZC
 WesPQg7T7Oj4oDJfKU2H8tp7rPW3mRDa3JWsCPEXa1elLR0WGSraY1mvrrrkui+KBnhIVqGz0lP
 5qhV/kFA3AjfnxwsLvFsbVcmnpGjeTRCmaYy8Fc8+Jxjk29gDc8pbitwkjkGyW8aWLszjIFBARg
 TQq779pYyJZHoZMPy00yi+w6d+ELa/bxO2KWFCWJQqO+yNELGbqy7cjibyn6xtmuYDCvJSxKESL
 i85+VIXwTGkaZMWR3MtsHis2Ljd2lDeB9D09SF0lVGIbAyLeC6X0Wi/43Y+TH2gwd34XsUmQOfr
 e7UL+5gjGh2xxcubxxVLBQDHqg==
X-Received: by 2002:a05:6a20:9e46:b0:3c3:7fff:ba63 with SMTP id
 adf61e73a8af0-3c92a855d59mr4078844637.47.1785602468908; 
 Sat, 01 Aug 2026 09:41:08 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:08 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:43 +0800
Subject: [PATCH v8 02/11] pinctrl: k1: fix drive strength configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-2-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602469; x=1786207269;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ROR+qGCDwnxmrW5tdKeKQbw6hKqk4WyFrrTMRxwx9Zc=;
 b=yX5GA4UCny0PiDUQaN0AboCL1BbHI1a3Dunts456Do/Okxst1trZ5NqQeGlRuk/fsy
 w38yUWQfkL2MhjtQZ7nNlEpjk6roHf1tFlEqtVa+/8h2lKsdZpwR+qDeB/RWIiIRJJce
 iDry24si+BfUsBl08fT+L4sW+QfjfqS+3OKsV6h9yt9EgH/4jmL+xx4qPXV9kArik2z+
 pUTmRyLOfdXOYpiekxfB69Zn+Q2lsNn9mAiMW++sFTcHLrNJo6p0Vlb0kqriE0UnWdYs
 xWSjdajCF5sfvoK3FBm5WCLj+3BJbFZ2or96K02nukjcr+f96F92tCRZSH60emhE4ti5
 pSOg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yX5GA4UC
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
index a6a22eacac7b..6ed511879daf 100644
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

