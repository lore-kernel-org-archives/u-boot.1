Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4EFC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 13:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B848B82E08;
	Sun, 29 Jun 2025 15:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpkM/4jO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 676BA82E40; Sun, 29 Jun 2025 15:21:56 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D8A81F6B
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 15:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so23328945e9.1
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751203310; x=1751808110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEsawCGlj1qTxiiKggfmzbU7eMkwniippXFbgIJVsRE=;
 b=OpkM/4jOQ+MFg/8wQ+vfttNNwl/MtDQPy2P7yWej7c56FVrYhUKFu1q9Aep6oP8nbH
 6onloSTCWRTW4SHlkLVhkeReE6b67vPTwJrWoOtcQg0AQj5uKhst/GrUnoxcBtEGhNNt
 KxMn6+oumZ5OOBZjysgv6C7KWjHk4Dwt4BCzbTQPH2PfXMzw+9v4ZM+tOVh0CsAWnFmA
 rU4E1q+0mEHxfgf9ZAJZfuDxgbVoSxx5ePlBDANZYshwFO5xQ3iNjBB251F32YoUQp4c
 /As6Ig7CQF1e46iTbZTRDXntpQp12CJzZjb1tL3/5RwgnRni2tUHtyYTnv8XJyGdtsUf
 S4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751203310; x=1751808110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZEsawCGlj1qTxiiKggfmzbU7eMkwniippXFbgIJVsRE=;
 b=xKlXomtt9XgSxB4uCnMeZZfRJkUUZveUmJvRHWj0li1SMfleHc1cfllRHxUPxrxxE/
 aJFd9+eEsw+FSNlWLAKh9mT35KYfGaASm041obQLn4ul0LHkALROMhM8V6CvXSTbUAJL
 WjTlTDmA9JZ1qtAD3oMKovdGPTojP2IbhxkigfARb7kOhjXzv0x95R4ClscvjfBLkgDi
 VoXJU4DhyV+myf9PtqiYxtVqjFZ9MJmYWKnbVA6BWm62RXN9MU4Ijtmuow4KXE+tXOMi
 Iwq/7bs7saovviyZSE/KNNV5XU+bBg63eQo90vWetyF44GIbCAwwJHWW9XuzdRjq5lIA
 2WuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWecSljJJTkADHhgQcd0j0DAzd37WhT6plJXHIo/+x2TZaR+oazFH6YlvUWNlPHmiydly5UZds=@lists.denx.de
X-Gm-Message-State: AOJu0YwB2HLNLOT7ZMzXjfmJvXaHMsaqt4BwXBK4URN0dJ8Dxmd9tJPH
 954J5PYg9x4zHMQeTA3HUxmyQMqG4wMTM3W4WSNe8WQyxi7LHZ2RtJQQ
X-Gm-Gg: ASbGncsvCPvD826v/ZQFSljIHbpvJlL7xBLeh/WdNRRQXbRXSA0EaFlm+g3EZZhSEpm
 pcxpWn5bhl1XWg/sncFt0h8qwefaUxQIfYGeL2PjzCMpzXC80JJSVbpxN22tUkJgODfobhtkkt1
 AYzS4+H7FOcwWFNmCuGR0J0W1zUF/YghDreyOoiwXaiZqA1XesEdxolwuU0jffqmkYfoEZA9Efv
 d/lUvtB7awS7I0jw5kRcB2g8BQIlOIHGIgtdbeH2Ueu/x45fn7m2RdYj4B19aDzOo63ZfTiPvy5
 m1iAzbl/CFbzUBZhle823ZLX3+GIV86BiV7lk5+TYY+Z+XdeVOZwdEEEUYwscjdGIFU3ZpyiLRJ
 FTh9PsjNZjDUY2MBJTyQc+m6yOLsxilOkAqzkLIa8P7Iz
X-Google-Smtp-Source: AGHT+IGkCR1sJj5UdtwO4r8A/REHSnaw/4wjrXF+juSTYoumdJzGKnlQc+kUkuD6Jw/82iAXhpCiEg==
X-Received: by 2002:a05:6000:20c4:b0:3aa:c95b:d1d9 with SMTP id
 ffacd0b85a97d-3aac95bd1ddmr3332613f8f.6.1751203310132; 
 Sun, 29 Jun 2025 06:21:50 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-3-254-137.retail.telecomitalia.it. [87.3.254.137])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-453823b75cdsm132284515e9.32.2025.06.29.06.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 06:21:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] env: Fix possible out-of-bound access in env_do_env_set
Date: Sun, 29 Jun 2025 15:21:18 +0200
Message-ID: <20250629132122.24389-1-ansuelsmth@gmail.com>
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

It was discovered that env_do_env_set() currently suffer from a long
time of a possible out-of-bound access for the argv array handling.

The BUG is present in the function env_do_env_set() line:

name = argv[1];

where the function at this point assume the argv at index 1 is always
present and can't be NULL. Aside from the fact that it's always
better to validate argv entry with the argc variable, situation where
the argv[1] is NULL is actually possible and not an error condition.

A example of where an out-of-bound access is triggered is with the
command "askenv - Press ENTER to ...".
This is a common pattern for bootmenu entry to ask the user input after
a bootmenu command succeeded.

In the context of such command, the while loop before "name = argv[1];"
parse the "-" char as an option arg and increment the argv pointer by
one (to make the rest of the logic code ignore the option argv) and
decrement argc value.

The while loop logic is correct but at the "name = argv[1];" line, the
argv have only one element left (the "-" char) and accessing argv[1]
(aka the secong element from argv pointer) cause an out-of-bound access
(making the bootloader eventually crash with strchr searching in invalid
data)

To better handle this and prevent the out-of-bound access, actually
check the argv entry left (with the use of the argc variable) and exit
early before doing any kind of array access.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 env/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/env/common.c b/env/common.c
index 86122582bc1..12570dee6f6 100644
--- a/env/common.c
+++ b/env/common.c
@@ -82,6 +82,10 @@ int env_do_env_set(int flag, int argc, char *const argv[], int env_flag)
 		}
 	}
 	debug("Final value for argc=%d\n", argc);
+	/* Exit early if we don't have an env to apply */
+	if (argc < 2)
+		return 0;
+
 	name = argv[1];
 
 	if (strchr(name, '=')) {
-- 
2.48.1

