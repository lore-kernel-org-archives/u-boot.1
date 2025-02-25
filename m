Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC551C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768E080F7B;
	Tue, 25 Feb 2025 14:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eedYfSDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6411680F9E; Tue, 25 Feb 2025 14:53:35 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4473D80977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30615661f98so54017891fa.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740491612; x=1741096412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YSh1V3rJ19Nympiu2/EVzgo3qpqO9j6SRL9PpH6fJe4=;
 b=eedYfSDxMlXQ7a2zFpP23MXsUjSXlsHHzEO2Fw8a/oz5vG85wOad4LRt4/52dn74hD
 l/zyHbOVjtjt8xH3Hna+rtbkpqrLRX+bib+y5wJGrvtcDKRdmdQbz9gTNDI8dXY7tIG4
 FJO5nf5nYEyLIF6tmSah/L8U/i6IQIuyVwuEUPW1/HAxzgOzxE5eyt0zhVxLipWIk5TY
 Mm0pcPJ3GgT3snBSB+V7HHwOwSNfkz3mgPWzX6uJKND51PH5ZOdzGI0mdcs8hvUpdQiJ
 9OwO4Vdfcp2DyhO1RyMBlPQ7TJyIv7kDVGdyq2BxlCcw4EEzVdZ5T9rNH45To9+yS3Ip
 6+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740491612; x=1741096412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSh1V3rJ19Nympiu2/EVzgo3qpqO9j6SRL9PpH6fJe4=;
 b=aabX+YGrqZej6F6u/Cm6PURczpvxfYxpD7rl6OIU1eUnPBFMMKNM/4Cp/TuPUMDTCk
 xEJ2HFOF5nAyOdKT50ssMNuck8Q9Wpq+y6e1/5XEbNFJnevQk0xGKZYrxj/gz367BTxB
 RhYDG5rV8e/i51nQ0FBilJhBuIC0PYTe9A5iSnX4ijy6Q0g+Awra/ns10zRMGxyIWkRO
 FYSJbSlOAWgEqisfx1ptdrUChE7MMlAKzl19GkBCda16Sq1vJ5iN+R9MliV+sMKOnE7+
 NKN6E1/wOaxMv40inzAXIT4n6MweTrI2AT4IVlmS4Oq1faxMXz0LR9B9oslhi4ffgm9N
 ya9Q==
X-Gm-Message-State: AOJu0YwwKt8lfNMTrsp6y0CQ4IBiGxUdHF/P4pbfH7Vl9A6zmOsxZQwo
 RvdwWCd9FgnfggGRx88IGqPbtjWioY1UZbrhg+6N0qSLUxvaPDeCwYNv/5kD
X-Gm-Gg: ASbGncvg6a7ksRPTp6dX7TC82yIiA6Hnb1wbnFZJ1bGx7vaUXC2QYm8n9K6Krz6zJ+m
 1wGgoHp5KAn44nNxLGBAnyIvgatjqOyJdXcJd1wa+W89CJKXBitQYqEDREoOhunt7GVKeYjaLPL
 a9uIXbG/o88F4/XdhG/Ub7LhojSSmqBNBqdD+NmCPDlxq9ZcbI599OU+evhQSASjGXhpfJKEvXq
 uGzGkohALG5YbW/JXmR2a4f7JBv7+B3KxQEVe16ibN2gy3TzUh6jpLQRXUFdpGOmTfkC1tOIII6
 U3wsVmmvc4C8ediJXOPNe4BhKaPTwzFOOzYVXCzmc53wIZenNDkKAJpZZwo9kBycB29pGpDWFzd
 USD0oO7AM
X-Google-Smtp-Source: AGHT+IEfGJYYasOzn+eabEgWcVGN6MreSyqTWm8o6jS6bmi4snT64J4eKHZ0YG9fmglsri8h1CvKPA==
X-Received: by 2002:a2e:3a0f:0:b0:309:1f98:2848 with SMTP id
 38308e7fff4ca-30a80c400d7mr12693701fa.19.1740491612052; 
 Tue, 25 Feb 2025 05:53:32 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru.
 [109.252.121.101]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30a81ac475bsm2360301fa.70.2025.02.25.05.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 05:53:31 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] lib: rsa: add NULL check for 'algo' in
Date: Tue, 25 Feb 2025 16:53:27 +0300
Message-Id: <20250225135327.33730-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

- Check return value of fdt_getprop for NULL.
- Return -EFAULT if 'algo' property is missing.
- Prevent NULL pointer dereference in strcmp."

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 lib/rsa/rsa-verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index d3b4f71d6b..43166b1f24 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -449,6 +449,11 @@ static int rsa_verify_with_keynode(struct image_sign_info *info,
 	}
 
 	algo = fdt_getprop(blob, node, "algo", NULL);
+	if (!algo) {
+		debug("%s: Missing 'algo' property\n", __func__);
+		return -EFAULT;
+	}
+
 	if (strcmp(info->name, algo)) {
 		debug("%s: Wrong algo: have %s, expected %s\n", __func__,
 		      info->name, algo);
-- 
2.30.2

