Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8655C0219E
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ACBB80824;
	Wed, 12 Feb 2025 10:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739351469;
	bh=ji2cX+t6TwhGwIH5lTO85rnEvyFMU4Jq/Bahu1icRoA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QaQXBGPvzsJ1YPkHX4SqybWzvTFTzWjky75KP4rjf4ObuA/Do0fjrJi1tyu3am3/u
	 7AagkBBLJ7TVtTFn7sPxEjM1iPiTjc5SI1wrLO7xsQGRWH8fchu+EPAswtN4K3rv5f
	 xnFBtMfMTbyU9KyHmjxDYyGgCrm0tsjjE4DHmo97Cgq4AhHtyNoG3rdkBTAh34VS2l
	 +JVNl1T3j9xWIIWssvs4NMelvLufYhV2WgofH9mFFKtOwkxTsiCY4PlqfkuPvLv4B0
	 FODZVkTw7oOcNASAP97Qen7I7vyVyMcvNUaI5SglL0R4Xpj06XoKP8pmq2OoH3zTAm
	 NKigi3OC+FDHQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9459980842; Wed, 12 Feb 2025 10:11:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3FC807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Uts+eudp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 54F45103718DE; Wed, 12 Feb 2025 10:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739351463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ji2cX+t6TwhGwIH5lTO85rnEvyFMU4Jq/Bahu1icRoA=;
 b=Uts+eudpz6hF2OD0EjZwxHRc6aYHpp7sM29+xYpH3HgEpIYNg4V2dKsupm5oyVpFY/h+mx
 /r3SBYI/1bybuuDJUqPZYEF6ytLATvnZ/gENcd904zG5CmfooUmWDiKU4PWJZR4QPAVkhi
 2XmlpLyVxsj1V3l2/hOoRiAWEkz0/VPlt4KukjasXgfFdmO3OfhMj0kwsmLH/w8dfEH81G
 nUa02ZaFaGHydcWZikueUmwjoG7jIV+hOTL0UHvVJtcOzx6L4rhKVmFeFqTnzJTpqncDq6
 zJ879UR9uaXrrF84XExQYeWHP9Mw7fZlOR1tfrS6UOLg87DE09Y8VeDZmRoudA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] led: fix coverity scan error
Date: Wed, 12 Feb 2025 10:10:55 +0100
Message-Id: <20250212091055.117111-1-hs@denx.de>
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

*** CID 541279:    (TAINTED_SCALAR)
/drivers/led/led-uclass.c: 284 in led_get_function_name()
278                     if (!ret) {
279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
280                                      "%s:%s-%d",
281                                      cp ? "" : led_colors[color],
282                                      func ? func : "", enumerator);
283                     } else {
>>>     CID 541279:    (TAINTED_SCALAR)
>>>     Using tainted variable "color" as an index into an array
"led_colors".

see:
https://lists.denx.de/pipermail/u-boot/2025-February/580250.html

Fix it.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=170&view=results

 drivers/led/led-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 27ef890ed0a..22f61d12d38 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -273,6 +273,10 @@ static const char *led_get_function_name(struct udevice *dev)
 	/* Now try to detect function label name */
 	func = dev_read_string(dev, "function");
 	cp = dev_read_u32(dev, "color", &color);
+	// prevent coverity scan error CID 541279: (TAINTED_SCALAR)
+	if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
+		cp = -EINVAL;
+
 	if (cp == 0 || func) {
 		ret = dev_read_u32(dev, "function-enumerator", &enumerator);
 		if (!ret) {
-- 
2.20.1

