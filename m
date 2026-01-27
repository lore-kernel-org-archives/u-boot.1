Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B6ED2D8F9
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D2984021;
	Tue, 27 Jan 2026 12:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1DsEvak4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7289384013; Tue, 27 Jan 2026 12:04:24 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540C784013
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so3239508f8f.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511862; x=1770116662;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Bjh23mVOwOI6dKGgKe0vkZo/tYx4ppMi6B2s4QJA/E=;
 b=1DsEvak4zOcEAeL/KOWxgIHB9cDBp+KJGlqr8gLNEiR6OSrplSkAC0VDifkXB0Xim4
 lQorezNgOdqInoi19BqPVg4VThgfTjajfo9leZrVNFTpgGSi9p4cZPGy2TSGcTRDmGOn
 5/fwtCgnGpMam3Fh2btYKOVBHbjmdld6YzDvC1imgQlETgr8muEDFf/WeofzAOUf5RBE
 5XnYOIqSrEAgcsUVx83Hw3BXY+NDz5Of8WTgBzzlA1z3ZowEXK0DT/8stTXKx/4gzRkt
 2W5bR6dJlw48aqHozVhrwfH/Fh5UXXXqfev1+ddqUZGU3vw7XiuBAkMRrw1zrR0djrsE
 1yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511862; x=1770116662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Bjh23mVOwOI6dKGgKe0vkZo/tYx4ppMi6B2s4QJA/E=;
 b=GXSeU6SdAcoKxJoS3fU+BDknO+7n+i+lRcU+yXN9fPf9wp10oE80n+8BgG0fPJcwLq
 wijRx2YPSsgb+fgsY3UfDmHqP6xBZ3B34jmfBCvv6VM8Ik9HuDYw8h9osMeF8caDFZ3V
 mdnv623IZpXvxs+ixgW4jg/P1mU5MWyyhmuz47XIhi0+N23U2C0RmfIrXtI9bDDivbNq
 x2NV5BN0cNWHAmNZjLwkzxw7jnabQdLnAdKQl/w0g6Zb6SpINdiEczINZNa0QwGQD87A
 ujb26bOFeHpoqlQigOvMUVT27gcy0S6BsSXvZphOe0dGsPj4aeWsU7mUHDOAmuGkh/K8
 ds0A==
X-Gm-Message-State: AOJu0Yxjl9Xzx+I1DM9IDWJUpWTouFJ/CjMEXc8/X7bBDRBxiQTbzQUn
 nosvRnuTjimzWFzK1oLzTNi57boZ4XLKZazwwnHIT1xe+8vNe+xONGv8ahh7TzGQnv4=
X-Gm-Gg: AZuq6aK8k3l/GkuO4AENX2MvjNXNoOWQXjFzMFYTQ/Fc84apxOrVIdxbwWj56Ic/VyS
 M5yT5f+g7c2l9QP+67b1eerHwOCnRYoyTal3WebZjG1ukox3crcXqYaaxAXgwEnMV1Md2L1ZWIB
 e59L/qccjVnoQippHI6D2sU3R20OP335WrU/S1yrelyqw+wBeAn0Ja919hxBVEE6+2ZqxCkZ4Hp
 k5l5X30YeNgtJHM2K7GRODWohsnLY2bbp4N1h9H7ErX6KAkC4RDQ8vWv9TC2hNkKa7Sowc8FgnI
 MoxiIYC6eESz7ztkgrtgYgW/sA/CZJV+KwYJPYHQOA3jg1ArxAUARs1xrBjEw0PHsygihr05TzZ
 hfqAVPhzuCuKkiQazN4cA4uWxiOa2NSQfzmauIkNK0dLH26EnJPeHmGehJiPrRect+koWz5cr5V
 V613p7JX8i
X-Received: by 2002:a05:6000:613:b0:432:c39d:102d with SMTP id
 ffacd0b85a97d-435dcf6c313mr1548006f8f.0.1769511861603; 
 Tue, 27 Jan 2026 03:04:21 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24f15sm38266006f8f.18.2026.01.27.03.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:21 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:36 +0100
Subject: [PATCH v4 2/7] dm: core: lists_bind_fdt: Replace found variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-2-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kqQaif7xUIJrpaaDGEiImOBuUq7kmhC5O73WsEoMxGA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2VNPVS9eFfxvo6ySySOdw2X/1opnPayPY3KKKH0+9
 /AOHoWKjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIn1xGhtu7NMvfKBpNelXv
 87KFsY9hztPatDcn/uz6VxzZ+DmkhJWRYcvv73ULUvIW2/a2+Cw/OyPf681Xo3K9Seeit09j6dy
 9nwkA
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

'found' is only used at the end of the function to print a debug
message. No need to maintain a variable if we can just return 0
immediately when a driver was bound successfully.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 52ba6c7bfa007b660b854de62c97ad3c1761f1a5..9d1ca38212ee7f53b8894f964f096611c8ec20a5 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -204,7 +204,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	const struct udevice_id *id;
 	struct driver *entry;
 	struct udevice *dev;
-	bool found = false;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
 	int ret = 0;
@@ -275,14 +274,14 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 				ret);
 			return log_msg_ret("bind", ret);
 		} else {
-			found = true;
 			if (devp)
 				*devp = dev;
+			return 0;
 		}
 		break;
 	}
 
-	if (!found && ret != -ENODEV)
+	if (ret != -ENODEV)
 		log_debug("No match for node '%s'\n", name);
 
 	return 0;

-- 
2.51.0

