Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0579ED31A2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59A88398C;
	Wed, 14 Jan 2026 10:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dr+FzVD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E138388D; Wed, 14 Jan 2026 09:34:44 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765B7830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65378ba2ff7so1943337a12.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768379682; x=1768984482;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=Dr+FzVD1IHPxHhVC9XdtfKWJ1EYGihDWQ9nvVjF3Pau15w2UmQAmVoV3xR9xjumUNh
 6tevkoyDzSXZZFu3PXYh49pnxuDTU12MBiiVyYfVSBjFNcL40mYnN0033BivL4OP9cX3
 93YiLGrkS+YLPUpKjqXrNtxBS5Kml2oxKQHIHzrfguPwEGHqsV1j+NzlwacAmPVFYm8q
 hY/yqBw1kGtLw2G6ztKXpoS0Aq9lcYwQSUvgrx6L+JiYRF/a+dApdHZQrjW2qLKODbK4
 h1TFerxGN0Bh/AkNcZyN6tW20WO7rkZ4ufJuDVB+9xu9598mfamztN7Y8EosP9NEGc12
 BvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379682; x=1768984482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=THtVO2dKwar0tjotcuPcuCgMroc6M/k3VJhOxj9mifZ9Jbu07Dmh+cVrSfAPNXwPw9
 FFosTZfvEUYZfKze8/Jms/91yFVrB8cbpjW29cK3JL2krZQT410qutLRCUr4rnIem9+k
 zYy3Ax+greJfXg5cA9UXSro+luOpRvjDazCd1PpuzFtjPue1V8QthG08RKdhdkJl9L/J
 o6pKmua7qd53h+HDm0hfmHtIAQpU5sqwgf9epI4ZbCB/YK0gYNCzf5BLtYbKTJ3k9YEL
 0jGvyafhNBw/wYKcRYG17FK7qejA0ONxIcHaQ17Zk/Jx8wTHfMvJzjvom8RCWtRMz6PU
 oSWA==
X-Gm-Message-State: AOJu0YxuFGuVTgrKERJPtMdV2ChO2WHUiVSXQqkOtd/+ubYJSlNuFjrh
 5rVwHOoJC+tAXVRFAvTYN/oPVYOW9Gjk2tLWsYzzgGpIpNEViwJB2mUaknCRMqHOFP4=
X-Gm-Gg: AY/fxX4yH2TBaLVQtPnL1OUd/J+J/zEBCFZs8iN6W1IWPE+Q5BbR02lsF59Pylbid9P
 PSqKNpVJTOYsz2raWY063qdz6ShmC5gII99oIgOIJuImw3/QHdzmlIBELyKkHvVVVSGJwEtsa4k
 SiOatAWSc53uWVUw71nZvHKSvAFawWZpB5/jDq9/1e8+XqcGK5dde1kC23alrF00ohtKnCV2eGO
 G6ReY8UNh6GG1FiQwqQkhlGlj8BAI65QBbCho2PfbLekFCqRgkHrTbAs+/P9d2QsrthiI2GMfBQ
 ZsXiWn1CjlZBndHRImptLu0CDb5QCgAWBFRkwB5DUmygq5zdEuUURYOIm9vQ2JQPMJ9oRClMhAA
 iGBCVjyEZCtBjM/4YiEp1Ihtb9lHX1/+jrfm+t0NU63e+ys14ZmXo6lO+symmCxi63S6KbQlvdt
 1G5d69Uy5F
X-Received: by 2002:a05:6402:3547:b0:64c:69e6:ad3e with SMTP id
 4fb4d7f45d1cf-653ec46debemr1501413a12.33.1768379681921; 
 Wed, 14 Jan 2026 00:34:41 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d5absm22207664a12.33.2026.01.14.00.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:34:39 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 14 Jan 2026 09:33:52 +0100
Subject: [PATCH v3 5/6] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-topic-musb-probing-v2026-01-v3-5-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=dDvD/x/4LymVEL1XBsIubCAquDLmvaK7eVpCHnTgwZ8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz0UH6lz+KvzXqzFLa9vHEnPnjfi53eDx5OZegPe6b+V
 2Vb6eZTHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRxniGv8If1qSlPK1pu3JM
 y/qE22P30EvTXSJvVFhO47j3JMXF4hQjwwWRR8cPeXP32baK6H77mW3Vuvliqv2rALbT2zRXxl9
 8zQcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:21 +0100
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

