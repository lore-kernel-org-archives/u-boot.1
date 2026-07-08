Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16087C44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A2D84AAC;
	Wed,  8 Jul 2026 14:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oHoZOLNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BA284A0B; Wed,  8 Jul 2026 07:13:53 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B51838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 07:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=win847@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-847d1e9db22so248709b3a.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 22:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783487630; x=1784092430; darn=lists.denx.de;
 h=mime-version:content-type:message-id:date:subject:cc:to:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hIFvZaVAqSVOsYqP1h6OTctB4e9lYffyzp0X8ztzGQk=;
 b=oHoZOLNF301QdSd7E1ESI5qu6fv8LVqYONBgiS1sUCjjNQR1YM5z8jpjm+KEMtiQ43
 bRZmOJF50TJUOTaZfNtcmK1llJWxx9ROjlgu/6173h+23oY3uL+kCXPD9ynLAlvvFNvt
 nTXJwH/TB8be7iZkHHRIlDu0cQHqENMHoKBnhICwDDq9Kd19jwYTYhiJ1bmK7aXAVYkc
 R2Mug4C24BrPOktKryqnC35ipXby4SY2fplLanz/wIWlJdfsGe/874Y8lWvw0iAWDE1u
 RoiwrOZ1Nu/1v900tnfJ9S9u3BL2rSXtBOQFon9HsVyQcYQAGLegtkWFw7TRq20zmKg9
 9xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783487630; x=1784092430;
 h=mime-version:content-type:message-id:date:subject:cc:to:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hIFvZaVAqSVOsYqP1h6OTctB4e9lYffyzp0X8ztzGQk=;
 b=IRx/DAT516AksKcsZyxBBBEoeysZr6XRqWiu60cVE3wMcrdWjqQneCKfXPbVRCFkHY
 grSMQC/jo8y5kXcVCgqObhdAllOMLTx3/wr4mtF/LewzFxuNUV06Ayh+65xHfHCaf/bl
 17YYjoqGDPEViXWzyruv/KkdbYn/QmakBTv+PP85ncHOVzpluQLYvczc+m5Z871dI1Mb
 kOsoanWoEQ8N3mGXWsBYotz7Dmzqz2wbMXzg2H0Pn+LYDSbCVZT9kaGlZ5OK4x2UnwK6
 VgW5xGE9TFR8bBwykNT9xVWmC+5yn6kvYU1JK1scrcqs7nGic7/z+Hcjhmp9aB7B3P58
 +JXA==
X-Gm-Message-State: AOJu0YwNuYiK173Rjw2YT6Rc5pij8leQpW4hFYpVRQkOSCdHOCWmXsSB
 TbmM5wjEYYQqnnW9z8C3zXKmSnQ11qz6X9dukvdMBNoQUm/500eXXRp+M5I9WAmh
X-Gm-Gg: AfdE7cln6G/gaQBTAmFizqFpzij3j3Tzo3qh/ddAQHpjDRKDyBodojfPbsCB2Ufw62p
 gllTjSxjyVRM6nUSE62lkH6O4OSnm6sHA6zj41hI42/iCM1qmDsNOH735t7yM33nQFfJIO99PU2
 hdMZLdZrPhEiLeZ4iJ40gCSg/H/eNfNGxqCJ/cECl8qYy5lTYBYblgr5D2atOVyQgEGkYmPF+Vu
 F2xCKXWvaeV4pLlwCooUldAxRszHa6IYUwF/cyPxo7ObGpy8f9NBrSiwOnUsTvGyyzamY5frvGf
 V8Ts8s/z5ev3hE9EPkT2d8OD4zo9aFBB879r44YEsuI5NCv5x0oqjO/MQjBx+um8XjSlVeS2JUn
 uYgMeZUYGTs1fsERuHFxfqfDFjYuHYHiBl/iX+mN8E0H7Rwh5isHSYlCI6iYmKd/z+Ne2N97H88
 TC3eJyFw==
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c0bd3a358bmr959350637.75.1783487629789; 
 Tue, 07 Jul 2026 22:13:49 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca75ef0c30dsm166547a12.17.2026.07.07.22.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 22:13:49 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] clk: airoha: fix off-by-one in clock ID boundary check
Date: Wed, 8 Jul 2026 12:06:08 +0800
Message-ID: <178348762707.85793.537680021676357783@gmail.com>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

The boundary checks in airoha_clk_enable(), airoha_clk_get_rate(), and
airoha_clk_set_rate() use "id > data->num_clocks" which allows id equal
to num_clocks to pass. Since data->descs[] has exactly num_clocks entries
(indices 0 to num_clocks-1), id=num_clocks results in an out-of-bounds
array access.

This is currently not triggered because the device tree clock IDs are
within bounds, but the check should be defensive. Fix by changing the
comparison from ">" to ">=".

Fixes: d0b81afb5ec9 ("clk: airoha: Add support for Airoha AN7581 SoC clock")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/clk/airoha/clk-airoha.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 49dbca82135..89a8b4cb1cf 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -327,7 +327,7 @@ static int airoha_clk_enable(struct clk *clk)
 	struct airoha_clk_soc_data *data = priv->data;
 	int id = clk->id;
 
-	if (id > data->num_clocks)
+	if (id >= data->num_clocks)
 		return -EINVAL;
 
 	return 0;
@@ -349,7 +349,7 @@ static ulong airoha_clk_get_rate(struct clk *clk)
 	ulong rate;
 	int ret;
 
-	if (id > data->num_clocks) {
+	if (id >= data->num_clocks) {
 		dev_err(clk->dev, "Invalid clk ID %d\n", id);
 		return 0;
 	}
@@ -412,7 +412,7 @@ static ulong airoha_clk_set_rate(struct clk *clk, ulong rate)
 	int div;
 	int ret;
 
-	if (id > data->num_clocks) {
+	if (id >= data->num_clocks) {
 		dev_err(clk->dev, "Invalid clk ID %d\n", id);
 		return 0;
 	}
-- 
2.51.0


