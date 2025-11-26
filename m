Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1885DD111A7
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A1784262;
	Wed, 26 Nov 2025 23:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pCQhE7Fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F411683AA9; Wed, 26 Nov 2025 21:31:55 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1AD83AAC
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso563315e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764189113; x=1764793913;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=pCQhE7FiBp+/lsYEQwLvRrX2rPy0t34uYkp+ouaZpzjqQmpOlKwiP+QRuVm5gXlYx1
 W/AVoJakmUk/BhJfXyWlclaWaLcWHus2ZCQS/AIXU1UNvPnwfB+2OLm079jk8+ud0eK+
 mcb85unZauPD2fK2dmqsOjfSiPhu3MuEeKLi/Kszp9MliRWg3BbyUNX7s3oI8fptk+ce
 Jmg/1i3U/f0bupiPEPnhMF/Ly8b2+ybulWAO7cRuMB0GDM+44h+c2O6E/yIGSUqT4V32
 Eddx7byUp+8MqXF524snBqH5IFru7eXjAjEL7li/A5c0+ooAcpxeCyUUY69h7Wm7l8kr
 dDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764189113; x=1764793913;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=qIhGlM2M72oxWE7v+0QTWjtpWI01HrK6L9eO0m+cXjp38sagVQbf9cHreN9TFI3H3b
 Rk517gsC5Flvi+5eNFhtdME4ALeguHackOnbCBBkVxa/ZTcU3Z18mNWJhR3zGlYV3h0u
 KW1aw6r0aYrSGJ/dc+4DQjqYA2iMSdF5w0upO9hHi15w8RFkeup3RCvmcSupZEjLDVhv
 BDM5u3Cw3MXMZhnuhUaKFio+suYr63vF1K8MPdZ8Fu1ZxCk2lAkZdWPnEZFEBIDPsFsb
 Jh+RnDaGdpuV4KqaBIarBRoGBEi3UBHNZKcht+afqiAp0fpQVsTJzSYUqlKY7yH06nf8
 wkew==
X-Gm-Message-State: AOJu0YwMPwRyXrjJkJaVu/elcqYImEJ/nA/TQfItBjFcWTma541J66hO
 tk1KOVdQNA/+NN+YTwkhq15p5bV/dpdl6ejjpjCyJDVUaZ7CLntHa98KtfER7okggc4=
X-Gm-Gg: ASbGncvL81Zpyv5JxUC1fLkQhr7TXXi9suFBGNGSTaib4kX/IlLdR7jQMotSD7mbh/B
 ra/KAzZG4nuRSrC4bPmj3c0G/kQ+N5fxf+QIecQMURU0akxlxg14pr9R59QacAwlq8uM8llmC+a
 mM01rfxU5uQtiDvaySsy5pOcnfogN/MlKpXzvyBh7wwYBFITYkI2/raYw+MevfFnMoa8TSP8vVt
 u6sAHZjPILZ0eKO3WB6ddc3tyRy6x9ZV2Xlrk7xV5OVgLCvlRyHUXtQadweceBDglK0Ve+ey8B7
 XlMn+4BxD2BAiOWjo47/cqb5Se2P5ot2smNGHsOnOjhGxAQNf+Q8zPB47tL7Uc00Tgoo50l9Jcb
 37K+LhL9oLTWiIP/3KJUMQmBMubXk+1JCGboMfDQXa86i3EVXNGoegmBQ5rHCsSgQQsgG9zOX02
 i0s8+Z8s0=
X-Google-Smtp-Source: AGHT+IHi31qEFSmvO6OVVLluCEBXdsZh/KWHbQmoReDHHhpxlpCJl/MNwG3jAFQiNDPfik1+uexjUw==
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-477c1132bf2mr213778415e9.30.1764189113492; 
 Wed, 26 Nov 2025 12:31:53 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4790addddf6sm61431265e9.8.2025.11.26.12.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:31:53 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 26 Nov 2025 21:31:09 +0100
Subject: [PATCH 3/4] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-topic-musb-probing-v2026-01-v1-3-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=dDvD/x/4LymVEL1XBsIubCAquDLmvaK7eVpCHnTgwZ8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkz15NW3eLeH7L/Jpt/Czbvzvcoe+QaRB6aOZTqss6/ZW
 tzKWh/ZUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABMx2sjwPyjT+/LkMzp1AhVd
 /xnWJh3vlZeTdn5p2/XXb4ry3b1TKxkZJsaen6bjzz05YvI0o+TAFdGHAq8dUqn/KqbNV1Mdznq
 JDQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 26 Nov 2025 23:50:13 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/usb/musb-new/ti-musb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index bcd31adba522fc55190fc43fd2dbd2dec93a2731..d3c3d3057c1df2a5cc62df3c57d8b071bb0f12b8 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -93,7 +93,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	phys = fdtdec_lookup_phandle(fdt, node, "phys");
 	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
-	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
+	plat->ctrl_mod_base = (void *)ofnode_get_addr(offset_to_ofnode(ctrl_mod));
 	usb_index = ti_musb_get_usb_index(node);
 	switch (usb_index) {
 	case 1:

-- 
2.51.0

