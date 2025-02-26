Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E19C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C4F80F12;
	Wed, 26 Feb 2025 10:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740561550;
	bh=qcUwk/8VNTMba7xwgR0IskL0liseKfiIunP3365IawM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DnP5fXDENuUmkfZ8dGg80kS1gPFOYfiaRAUhtfRKgvXsbyTfxmOKSKyi4Sl2NwImv
	 zjG+mF0o6O9VWq449vpRN0ExIJpwNNMxDLA//kK6HV9yq1Qs+qDpVk8J9oF14or9oH
	 tVyt7a65V3zN2JSRQ+Oou1OtQ/zgfJCzRECNNNuBGOHO6noqNo2id/BTn9dwvVoJ9z
	 0qtGO2KABCn0HvfF+rrdUND1DwZvgb12xQDS5PWuYJDnyfXkHj6Vuo14lpbbHKTYjZ
	 QLNsWNVTqhw31Y2RkNUnicGZLKr3triknTeRgVZLqUvKT2EkJYIGhV+x6rs2pYmuiZ
	 r+yX3HxHE0yew==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C8F80F3F; Wed, 26 Feb 2025 10:19:09 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE9780977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ETp74QZy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB57910382D2E; Wed, 26 Feb 2025 10:19:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740561545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qcUwk/8VNTMba7xwgR0IskL0liseKfiIunP3365IawM=;
 b=ETp74QZyjOY0wrM+FJYAZWYG+85XuWqQymQlZKNv+r30rbYrOWqzdauJPl4wFmG79+Z+/k
 okeWeQVaTiAckRRZ6hSWR4OGR4YZY5ecfufmhpuLbDmLvBvIceAla75+T2jDf+KTLlGwyo
 8C74vJGtHHpA+ddmtFmFVzQB5iz3jJtTrc7IMWl9fQDv66U/W1y1HVJwnXCm8EWU8n7Tle
 P6RPzH5fi/cxdnGHdkOEC7Feib61Uj4mvY1UXT1eKrapBNQV4/cg0h+LWgxSYaDlXJpgSp
 yrRgy722oHX0G0DmW3qUX7vafS0qXeq8GGKfJhuBTT4BjrEB2FpPkDEO+uLlMg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 quentin.schulz@cherry.de
Subject: [PATCH v2] led: fix next coverity scan error
Date: Wed, 26 Feb 2025 10:18:58 +0100
Message-Id: <20250226091858.73197-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Tom reported the following covervity scan error:

*** CID 542488:  Control flow issues  (NO_EFFECT)
/drivers/led/led-uclass.c: 277 in led_get_function_name()
271                     return uc_plat->label;
272
273             /* Now try to detect function label name */
274             func = dev_read_string(dev, "function");
275             cp = dev_read_u32(dev, "color", &color);
276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>     CID 542488:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true.
"color < 0U".
277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
278                     cp = -EINVAL;
279

see:
https://lists.denx.de/pipermail/u-boot/2025-February/581567.html

Fix it.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=172&view=results

Changes in v2:
- Work in comment from Quentin and Tom
  remove changes in dts/upstream/include/dt-bindings/leds/common.h
  Add therefore a comment in the uclass check, that we only
  check the upper bound.
- added Quentin to cc

 drivers/led/led-uclass.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 22f61d12d38..edcdeee1e9a 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -273,8 +273,12 @@ static const char *led_get_function_name(struct udevice *dev)
 	/* Now try to detect function label name */
 	func = dev_read_string(dev, "function");
 	cp = dev_read_u32(dev, "color", &color);
-	// prevent coverity scan error CID 541279: (TAINTED_SCALAR)
-	if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
+	/*
+	 *  prevent coverity scan error CID 541279: (TAINTED_SCALAR)
+	 *  only check the upper bound. No need to check the lower bound
+	 *  as color is from type u32 and never can be lower than 0.
+	 */
+	if (color >= LED_COLOR_ID_MAX)
 		cp = -EINVAL;
 
 	if (cp == 0 || func) {
-- 
2.20.1

