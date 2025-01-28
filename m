Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4832C0218F
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 03:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5008187B;
	Tue, 28 Jan 2025 04:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="idJXmaKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A848981951; Tue, 28 Jan 2025 04:01:17 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6050981875
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 04:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michaelsunn101@gmail.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso389340039f.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 19:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738033273; x=1738638073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zamSqw6MoVug5NQ4G++iOUyja4wz6nFach+US7B+rL8=;
 b=idJXmaKUTjyc3nVuQDmkD4WpXcXhPVrfxLDxvaHdIbMCu8fYlZiYD/FTA+K49OZ5yb
 JJwanKYW8sBdQQFL0H2KKTjNOw3BClE6mj5Vq+V3XElh7eLWg66QtNTtY8hQQt9PKgso
 41fktHGEu4i2eHAB+aM2wpk4z20LfHW2nOf15qQ+TGN23yeapq3ZV5NMBvTOyL1JbMcT
 LKebpTFHgZwATxSUnikm/UNPADS4OICWuAaGL1Yywi6jAIG/aPq7C81MnGPjWnD9IQKV
 HNFoi1lwIh39oYPSMiwHqqRXaoqC4rogHK6l74wwFtUKGdUhDDfpOTMW94cEAlLRAWRe
 rhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738033273; x=1738638073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zamSqw6MoVug5NQ4G++iOUyja4wz6nFach+US7B+rL8=;
 b=Fej52tKUoiKpgZMj+m4t0qs+HtMwaYGRwrD/eVcIGfXGrogATe+AVQbqkQ0ZqzzPA2
 XGTBCWMd5at20x84Jf48XlSWJqbDX9ti8m/M6083GsNWl/9Fy8sXYeNr4TNPTmoAHfL4
 m1Q7863sTI+ga3v5RNjKdcy7YNzyyg1Wd2wIUEXdFuv6ls3UHCCyynDPxRzV39PREgoW
 dscCns/RZ/FYBsac/8OolJ9l72LKG3uJCYZHVn6csjgtrL6hTSi6YhXYXmpyeXlr7Cy5
 ebKNzMRR3MwKp5T5MXzPHQ4Sz/fk7DrQAYr+mDvjCupBBUIkANqvRm+LDxLQC7Ksh3Bg
 4MbA==
X-Gm-Message-State: AOJu0YzO21mZBIuUL7ePvx5tndUdE4LRxG3S87/JR0tos9erAJn7hVq5
 jcxNUM/qsprVSF1CDfverz55genboQ8oh9Ka/Mdzyfw9FxmEptjmLwKsl3Y=
X-Gm-Gg: ASbGncsxuXyvke1lgesZhKHzTG+ERHycZrZiPoZS1fkVXjpV+bY6p8OsjNnRv4OC9Vr
 n99oU9qUFA3wN4vWpt+xdF6Fwdulbt3GEMHsUxGp/SzuZm5+Mqzcp+avilj68SoGJ0Z9nyCUNfe
 +226fURxpGy3ITDwo2p4lpiooWy+jRNTarcGR0Dxnd7vY4hIa3MnEzsFQ3gk3RFluKo3g8ZkGMI
 vpRV3zyRE2kuDnEeZPZ3QqTQPRW3Yyl6NOq9kd+8+DuUmcbgouYnaQi9yPu/AgjSaPT9XErq9Y4
 9lHfmeZ/H5JkaHhNafLDgZNCUtxWRoBKztdxtsCh6WU=
X-Google-Smtp-Source: AGHT+IF4NviwI6c2+/Gxl8IMWX4dL7gq+5WLMQkBdEl1HqoQYdXqpk5TeBaYMBpy0qhXZDxiumvaFg==
X-Received: by 2002:a05:6602:26c5:b0:83b:5221:2a87 with SMTP id
 ca18e2360f4ac-851b616986dmr3930031139f.3.1738033273512; 
 Mon, 27 Jan 2025 19:01:13 -0800 (PST)
Received: from valinor-2.taildfe5c2.ts.net
 ([2604:2b40:2185:31:7b1b:4ebd:7d46:b4bd])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521de0b2easm311675739f.12.2025.01.27.19.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 19:01:13 -0800 (PST)
From: Michael Ferolito <michaelsunn101@gmail.com>
To: u-boot@lists.denx.de
Cc: Michael Ferolito <michaelsunn101@gmail.com>, Marek Vasut <marex@denx.de>,
 Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH v3] usb: gadget: g_dnl: Fix NULLPTR dereference
Date: Mon, 27 Jan 2025 21:01:03 -0600
Message-ID: <20250128030103.1191705-1-michaelsunn101@gmail.com>
X-Mailer: git-send-email 2.48.1
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

The current behaviour of this function will dereference a null pointer
if the serial# environment variable is unset. This was discovered on a
board where U-Boot did not have access to the first 256MB of ram,
resulting in a board crash.
In the event that U-Boot has full access to memory, it will still read
from address 0, which is probably not optimal.
This simple check is enough to fix it

Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/gadget/g_dnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index 631969b340..f2540eb6de 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
 static int on_serialno(const char *name, const char *value, enum env_op op,
 		int flags)
 {
-	g_dnl_set_serialnumber((char *)value);
+	if (value)
+		g_dnl_set_serialnumber((char *)value);
 	return 0;
 }
 U_BOOT_ENV_CALLBACK(serialno, on_serialno);
-- 
2.48.1

