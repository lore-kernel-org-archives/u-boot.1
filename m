Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A7CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 20:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1048349B;
	Mon, 29 Sep 2025 22:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TXCDYDJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7370A832AD; Mon, 29 Sep 2025 22:39:55 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4A1832DA
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 22:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-54bbe260539so2067089e0c.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759178392; x=1759783192; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hq1mE6yv0lZWyTB7/dFXmfH/7v1xs7QK6zIzdhNgaSY=;
 b=TXCDYDJhbPo7RUVOZSqUHJjv6K0keHMLd2p9FnsDArfgKLVKnYCmKzOCs71330bICS
 0lZ5qkecEBG5pJnG9cXN0X65l9WzqfkS/864y8Fohox+tn1Qk5UYyubVzHbKlAsoben4
 mp1UM1kSxgXVGQujAbLaIgdy649DAfZ8MP9gf5Geltzl7LG6yO4j9KCL5O1pTo0vM8Ss
 4psNt+zAZvUdTVpYNI5+ELekb62CrZLQh/KieUjJ8h8LM1g8/Ax5Qny4WlUSzG1u47Pd
 l9SoP/sKkL8vJF21mKGBI2sj5BLRNi/5ajHslceM9HLV0iEYcawvbTqUtYSJSp6G0T38
 SSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759178392; x=1759783192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hq1mE6yv0lZWyTB7/dFXmfH/7v1xs7QK6zIzdhNgaSY=;
 b=bZNdL4TQACph3cIwMFn0Xi0xhluSk5cdQCCROQOLfn9HyxKG+dK+D6j2DQnOvKuGHs
 QuF/s3u4Rl4m1pRj8RxUl8wjCpZ8B1EHXTZ9p2WOLPipmR1jhjHB6fDymGYjUErq2Y/h
 0vtSBqs2t0DUoDNhLZ0TBsrEZ3UbK0MNBsdDw4dFN3w0RLdYXWurs5DpeE8rDe+/QI8l
 wCy3UC/Z3pGFZQDk7fblBcSd6mimiTy2GvGgS1hL50vNbcUDOPld8QdDsXGWjsCbPWnv
 UpcmtYzQ6Iw1h8qcbwLznKx/HsRefTKrGurt7Inf6PyIjJoCvH3KuESi5RW4/Nnn/7Uo
 f0kg==
X-Gm-Message-State: AOJu0YxzSR19+ddS2Rt8KvqPdVUVLgwaIM/d9xXTqLpKp0lJedaaf/gv
 EiTy0WknQkjGCn8WnNa29LE/z/hWW2M45WLGvjKt4C/iekRJNDnDUohktnNjbx6S8hI=
X-Gm-Gg: ASbGncvabkjMKfcD/HyM3wOjv1wW3WtIAnVjViszDY/9Fff8ZMXIsmUC4SX1HW8G7K/
 UJrCNk3uuAo5XO9zc5KTwMWndqSYTab9A148WXA1Fdhl0bxYSL41GH3+hG+/sDTt6/2ppdx37ne
 Q5ZcvYQbCr6e2hMhVFizk2m8VWdfDsmZ1dH0o+eLRpF4z3bBA3bddsIqfUHJ7R252m02zExr8Jv
 Z29ZY3EUx9rF39TjsibpYB7or0/RnNAlJN+fOBkf2qnEMF1WFL+aVX/01nvtCL5iX8W3OvkwtwT
 q8keHUWyQa8w8yt4mgbbrObYefvaBqEx7fP1NfrGmh2NcXMscmEijMRkaYyKY69/8Od5CsBXzW5
 I3VtNwDo5WI6pFThUMjirgliM0JX5rv01fCFCJESIYK24YIk+JB/ZpiiXOQ1pKC4LVak=
X-Google-Smtp-Source: AGHT+IE4Xsjjs4zIu6KaA13jVkOd+OpWypF7WY+Z+mQLx7U8r4QmO2fE2rg8b2Skdn1ssonSG+1bZw==
X-Received: by 2002:a05:6122:8c15:b0:54b:d89d:6971 with SMTP id
 71dfb90a1353d-54bea1e1d62mr7248561e0c.13.1759178391747; 
 Mon, 29 Sep 2025 13:39:51 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.188])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-916d1518f84sm2651076241.6.2025.09.29.13.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 13:39:51 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Date: Mon, 29 Sep 2025 14:39:29 -0600
Subject: [PATCH 2/2] b4-config: Simplify configuration by relying on
 default b4 maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250929-b4-docs-v1-2-a56c1a1856c5@linaro.org>
References: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
In-Reply-To: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.2
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

Remove explicit settings for send-auto-to-cmd and send-auto-cc-cmd from
the project’s .b4-config. The b4 tool provides sensible defaults that
automatically invoke scripts/get_maintainer.pl with recommended
parameters, making the custom overrides unnecessary.

This simplifies the configuration file, reduces maintenance overhead,
and ensures contributors benefit from ongoing improvements in b4’s
built-in maintainer discovery.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 .b4-config | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.b4-config b/.b4-config
index 6ba10cf9b50e6acb8a789544d35a13641e6c0411..3a9c7c406b0188c043c28bc9a67e04d6a77ea260 100644
--- a/.b4-config
+++ b/.b4-config
@@ -2,6 +2,6 @@
 # See https://b4.docs.kernel.org/en/latest/config.html
 
 [b4]
-    send-series-to = u-boot@lists.denx.de
-    send-auto-to-cmd = echo ""
-    send-auto-cc-cmd = scripts/get_maintainer.pl
+# send-auto-to-cmd and send-auto-cc-cmd are populated automatically by b4, and
+# the default configuration functions effectively as it executes
+# scripts/get_maintainer.pl with the recommended parameters

-- 
2.51.0

