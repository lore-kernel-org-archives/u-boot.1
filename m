Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF6DE78D70
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 09:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02E083C23;
	Mon,  9 Feb 2026 10:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wOdi5lEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446878397D; Mon,  9 Feb 2026 10:25:34 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B7C83BC9
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 10:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so59828135e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 01:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770629130; x=1771233930;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UmmbsoJdCWTwPU9XlUl3kTqhR1/w7PXjQxQWy3bgNg0=;
 b=wOdi5lEcBmBm7W1p+98zI3fX/1Ydg8ghCeqWpQkH1a+3p64qCBII43DHcCKOGSEOPu
 3UXi+fvrk2mj9JJcyykJDHSU24v++lMa2ljqn8QnZp7d+j+AC8RnmKtn04DaO+Pig5Q1
 FYHrGc15+bCA40DzUOCzb97mPnkhr8/8VQ3BKC9CUlZQpwGH06Wkj/EXyOEQ1Mppyycq
 Zu+z59m3YmNeu89VNjksbRctvM3oqbkrhNsQUwxUlJiTqjudbNuYRRurBDlYNnh83XSK
 A68EHC/pfiqse7/3ArEzBdmtqbvUFO+PAu/PPbXiFECpskGO2FYTcNxONCWhVAEC5818
 AV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770629130; x=1771233930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UmmbsoJdCWTwPU9XlUl3kTqhR1/w7PXjQxQWy3bgNg0=;
 b=gdM9JgU0RdC/tq8fzLJEkbTs5xpKBS0ze7/cc0FDSXaYZ1vVfDcMW71Lolrr0CPlam
 KrBlPkS+UpsA3uaH/6S65tsg7wgo5XxR5e+zm0mfuCps8fb5WwtjKFgziWeE7wp483Zj
 sAa1vSwQ/gWKo9/Uakya9ZZqFRI0m7LCNU9lAH7jt8C/9A3mQ4xpmUqlnbiiH/2I2XyR
 hMOM+7/8j8UUiF6yiDQhvljFKS5mbkx6TmLpyuuTIWu2/iw38LYDoC691uKaDW3FCmzo
 OaWNu4tRt6dvhHTyHH7b4KdE3TtpKVzmNGEvcGapTsiEAqEZwmGN+eZfs/ZRFc9GCWnJ
 4JvQ==
X-Gm-Message-State: AOJu0Yy6qAL3OmZqEUGPUvKWy0DLSeQlG/y87UwtyxojSl7N169GPpb3
 x2Xw9UBkl6VQXPbfxTznQZ63SldPIJCgEWoo1i4aawAajFH6iXD7TflvfyHPnSYr3/E=
X-Gm-Gg: AZuq6aJmZBj8BYn8jLLcoi/9Nq6U4CNQr7tW4Ey4bRwYLfcHLe80YMIKcgjCdaV4YWH
 GwxfuXYM7bvyf2f0yPxI+13DEA99T5GWWZBF729qOjBlodA4ugX1h97jNm5THLxSn+JL4N6TT3W
 k56UDIlcZdTpo38aQkFohMDtAr18G1ip32h/M7dMpEnr2ez8Vuk2Gjt/M90L6rHYoAIobOb7IoL
 TabLFM/WicEZ0rXRm1+WPWBCAJpzEOthKDz7HfZG/ljuQN1KrrAYsAcrpn4UAjt206Zf9fguwBr
 1b0GSwnfZxmS6J98XmZZwQQHXwSNqES8ZdizpwUhhl9orYzsQSLNcPBpN7PmKO+i6QxojizHNpu
 GyqnMd2WpxH/c/bE6+C2T1tw8nGpwUDIl70mVQhkyPcATQOKsA1igEjTabVzOQj/EkB5HF2vk1I
 Ez6YtaX1vE
X-Received: by 2002:a05:600c:1f16:b0:482:eec4:758 with SMTP id
 5b1f17b1804b1-4832021fe37mr157956465e9.26.1770629130309; 
 Mon, 09 Feb 2026 01:25:30 -0800 (PST)
Received: from localhost ([2001:4090:a244:8139:5278:cf5a:3494:5e80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-437699bc1cdsm11219028f8f.7.2026.02.09.01.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 01:25:29 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 09 Feb 2026 10:24:37 +0100
Subject: [PATCH v6 1/2] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-topic-musb-probing-v2026-01-v6-1-efce26b4917a@baylibre.com>
References: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
In-Reply-To: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=msp@baylibre.com;
 h=from:subject:message-id; bh=LGIqZg8UyaBQhQgrMzroA7ESb3WTXpJDvmyy2TxYZnE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszO5f9qpOM3TdrMoNiYYXZMZ5FAt9UjZa51+60s7gjMZ
 L6Q7tPeUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOR28TIMPHIvsuN9hOPnPac
 P32nsXZRlzWLpxt3oczPTVbHD70K+s/I8Fntjc1F67vpnzUqmW6cd0piml7j2KR5Qe7Y2tRfa6u
 cmQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

For the upstream DT the ctrl_mod node is using a relative register
address which is not translated by the current code.

Make address parsing understand relative addresses.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/usb/musb-new/ti-musb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index bcd31adba522fc55190fc43fd2dbd2dec93a2731..75dc2dc18748e33785c7312a24145544b659579d 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -83,17 +83,17 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 	struct ti_musb_plat *plat = dev_get_plat(dev);
 	const void *fdt = gd->fdt_blob;
 	int node = dev_of_offset(dev);
-	int phys;
-	int ctrl_mod;
+	ofnode phys_node;
+	ofnode ctrl_mod_node;
 	int usb_index;
 	int ret;
 	struct musb_hdrc_config *musb_config;
 
 	plat->base = devfdt_get_addr_index_ptr(dev, 1);
 
-	phys = fdtdec_lookup_phandle(fdt, node, "phys");
-	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
-	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
+	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
+	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
+	plat->ctrl_mod_base = (void *)ofnode_get_addr(ctrl_mod_node);
 	usb_index = ti_musb_get_usb_index(node);
 	switch (usb_index) {
 	case 1:

-- 
2.51.0

