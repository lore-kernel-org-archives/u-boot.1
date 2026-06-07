Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BD0CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7BA8489F;
	Sun,  7 Jun 2026 21:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJKUSdGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FD4838BB; Sun,  7 Jun 2026 17:43:34 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092EB801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so22859045ad.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780847010; x=1781451810; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=76wzbzNrcprk1MLO8xgiB3FBOJ2hnr9PszaslovfUpk=;
 b=ZJKUSdGxnCTpRYJHY0X85mdLt40YkeN076NyZmwhQs9iPhy6G7YNagHwhUIloMKBIN
 COYJozVMQGoa0fkGK+p7gRHeW5UX/l+1gIYYaD6+WeluSxFw905Z+5JFbWIrZJ7MdvuG
 Zq2FvmsobKCuLTopS2OYjUfYNz5aWlWHdXmMbxa0chIpPFoBnYmtHSB9XZgoTCEXVPfL
 mlVayk6LFxxeKQW2VEQ+DiQAchf4XyXO6Ls7wMJeDWM+fqF6Z347yZBULbxigY/ZFfLp
 yePUPD3BRyU8QLDAz3T2jlCUBN+bXXADGnvZ6fuBP6pmx7b4J3PyNhjd+d+LtXEZv105
 3kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780847010; x=1781451810;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76wzbzNrcprk1MLO8xgiB3FBOJ2hnr9PszaslovfUpk=;
 b=AJQpX/gmQc9dGTv/PckuatOmoKUHR/2s9Q6MqMrC0cexVt2554xneWcHrBJP2t9ZlF
 5qLPP7n8seFnO8DrH53ul02X9SIJJ+xFXj96iiGdqBtiPCml9K8bH1/wikPRbv0UN5NR
 oPpP2oYo/LKukdI7Nbw9mP2lU53YmHbYPpBYf3gX2jz3gdJI9B5ZE93sV7iljWJ/cFwX
 s9wrO0UsWlG7BVQTYX4/rlgxAq9+MUKeWKZwhRxtaHhsoqjemVkOB1vNIetOLYoZEAuS
 gKukXLbreAtBE7k0IE+vkeD4YVAdaV+SbUE/G/aBA+Zj/AtVpxk9cCXHEmDoyTgcrlsm
 FROw==
X-Gm-Message-State: AOJu0YzVzznsUcu3VBz8eR0Nd5QwamQnB+5Xzu7Fk5fJe9N0RfORC0Y0
 LrVU3EiYf3m1kZ7iPdkf7QSnUXcAc6d7fZu7gCiKNMw3Ww42iwuaK/HVaziXTQ==
X-Gm-Gg: Acq92OHGZyqtl0uSAh0yBGhQlCbQ4/uC+prT50hj6RVIDgZmmhl1YGX8jpmobGdKgrB
 6EDNKZvTAESjkg6JayA042hvBwwS0JmRWOKHhuqPVjRqCbyRwFlJXjzy8bcs/S9xDjtBYXeIex9
 9u4mSqpNY2SPjH/iZ89D33Rah7D+jzYYBsIrZY/7xw7EzztFlG3DN1JwDZosPrNYYFs0ZqfcgfR
 oP+5HhxuHJOJwc0NaZWzBN/bolMtCCUnm8y+c04201trvgulpqNLiGttS/+97Im8b0aFFTU7IPp
 IvUL3hca9g80NXTl/Fnh388QVFZxbrpLwb5lInx5XPXjaKarXufQYVYQqF6aVd9sDpgH7glHCK9
 UX4htm1ddCV1dQHkqB+STkVee4TpBLkKwJ45b5q1rZzkypIkZ4Y2cZYgSJ+UqnFmpRgU7h+qrB5
 5kkgUQXx0L/xhQGhxcbgTuuAC94YFGbd8s6wM=
X-Received: by 2002:a17:903:38d0:b0:2bd:ba75:81c4 with SMTP id
 d9443c01a7336-2c1e7b150a9mr149295075ad.13.1780847010363; 
 Sun, 07 Jun 2026 08:43:30 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609e2d7sm156750725ad.39.2026.06.07.08.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:43:30 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:13:28 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] serial: lpuart: guard against division-by-zero in setbrg
 functions
Message-ID: <xh7ydtfvepgceyyzmqzq2bzv7allmqt25brtdhnpl27muyap7h@v5tqjilbwfav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

_lpuart_serial_setbrg(), _lpuart32_serial_setbrg_7ulp(), and
_lpuart32_serial_setbrg() all divide by baudrate without validating
it first. If baudrate is zero due to misconfiguration or an
uninitialized value, this can cause a division-by-zero.

As a safety measure, add an early return when baudrate is zero in
all three functions.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 drivers/serial/serial_lpuart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085..76646e856fc 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -155,6 +155,9 @@ static void _lpuart_serial_setbrg(struct udevice *dev,
 	u16 sbr;
 	int ret;
 
+	if (!baudrate)
+		return;
+
 	if (CONFIG_IS_ENABLED(CLK)) {
 		ret = get_lpuart_clk_rate(dev, &clk);
 		if (ret)
@@ -245,6 +248,9 @@ static void _lpuart32_serial_setbrg_7ulp(struct udevice *dev,
 	u32 clk;
 	int ret;
 
+	if (!baudrate)
+		return;
+
 	if (CONFIG_IS_ENABLED(CLK)) {
 		ret = get_lpuart_clk_rate(dev, &clk);
 		if (ret)
@@ -314,6 +320,9 @@ static void _lpuart32_serial_setbrg(struct udevice *dev,
 	u32 sbr;
 	int ret;
 
+	if (!baudrate)
+		return;
+
 	if (CONFIG_IS_ENABLED(CLK)) {
 		ret = get_lpuart_clk_rate(dev, &clk);
 		if (ret)
-- 
2.43.0

