Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CC3C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE4D82F40;
	Mon,  7 Apr 2025 17:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HABvjkHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB43282F41; Mon,  7 Apr 2025 16:59:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CE382CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso489210566b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744037997; x=1744642797; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DNA9MQePrF8FJb+p4qpdq0Ht6Kd8O7P7Hx2/PZVTGYA=;
 b=HABvjkHYn93C5kTwZ12OFM43FnfON0nRbI7PqnpWvQvYELPFgyrAOjAAZndQeBMeft
 8B9tAPBc2LWSvy4gbFZtVnGISMveXjp9s1H4VYxI1jEph9rzb765KODvVjq8JmkR9EHd
 ZA6awNkyZkLgwMnqrLeDOp2x3MOysZIPlGWnlSb6zHZKf/8J8MZSkIsfpw52a9E7JwU3
 HnaKCWrsqWrxOgVBpv5YoNB0A9amdd5WybDDwhTqLTwzQ1t4otvbwTMminY0l/qQwVyi
 EDt3llCLcYyhWPRKTt0xtJl6JpgE7JiH6COiy3l7fnBNf63GCHfRT97xRwcSvktuMjeM
 pCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037997; x=1744642797;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNA9MQePrF8FJb+p4qpdq0Ht6Kd8O7P7Hx2/PZVTGYA=;
 b=E5fjW8kf6wX3onWqqyWIhaccfbIjfcsoy27qIgRzHhN9l7DNw4WU8HQCdxvcjlAkwt
 qkQ7TN3Ad0KC1y4tgwOJ7hPt026eILzRhYzHxYbP4LVvq39cSkya775UN0Nk5hyky+qw
 u+ZS/QQssxRxakwb7R84FX+VYWldZZFKkaWGwqciXLWLMQPlYDU2Fq+BAZeBzjKaiYnw
 mN6KwxyY66cIdZc2nHDEjsiGbHFuefPkXxNI6gQy5DAqs0Glb2TYX7ssiCn76p8xL/P9
 iw8dZ9uahc9IcrYzpB/jQEkha6XYHaOLm6eiXmokRME9xdV6FPPGb497XLBSIgQHUvjf
 esCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSOWJAMBCkc05Hu5+Eo70GJLWo1Q8AJmodpfc+v7LCLR8z5kgI8KSyrePo6td9CmZ9C7aajV8=@lists.denx.de
X-Gm-Message-State: AOJu0YxkYkL2vgZyaWNO5i4mj5PODeeM3znGDp9Iz3utH0+WkOEQ9GjL
 QqmiXhPn6cTvUjPPfCKyFUmxnnF4F3TL6FU76bPc98KTrF7atrw54rPTLZIWbqQ=
X-Gm-Gg: ASbGncsH8llgwJ58SsOF/IwApir2j1yY2IUs8KZIvU6GWRod/JJrw7BLEgJEBpmxMNI
 yvE8alFfvB9WIyYdVKct9CG0RhlW9nSzn18WNWUpaw+ks2h/EYlJxWBvQqcIqDFiAiWowD56H0O
 s979URG15AyKKYfke07boyGlQAfBY79OUzzRO32niU8FQXTZokn2eKsXkEtZSsk1+taeFtg7zCH
 49O/eOAT302N2HqJakl3oaEJ61cCG4Avax+TCXvi4aZ1wcb6jBuQYybdCCozFQE4Ye2ZShGqtMk
 /5MOsLbqIz9xpppAhfhSHcoJRssIuBWZyT5Ogq0MFbiYskyCioPoW0rgwQ==
X-Google-Smtp-Source: AGHT+IF8ZJR2tjqOPmi0ptFEPNzU+Kl9YoikMH8gvCSDvz4cJgdE+PkHGzxIrODxTm1kI+z7eONc5Q==
X-Received: by 2002:a17:907:9727:b0:ac4:4c8:5e30 with SMTP id
 a640c23a62f3a-ac7d1876af2mr1328814866b.17.1744037996916; 
 Mon, 07 Apr 2025 07:59:56 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea2224sm751585666b.74.2025.04.07.07.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:59:56 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/3] usb: gadget: Fix issues when using f_acm with ci_udc
Date: Mon, 07 Apr 2025 16:59:34 +0200
Message-Id: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbo82cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNz3cTkXN20zIrUYl1LY9NEI/Nk80SjJFMloPqColSwBFB5dGxtLQD
 X6u/TWwAAAA==
X-Change-ID: 20250407-acm-fixes-935a27c7a2b5
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
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

The ACM console does not work properly with ci_udc, it crashes immediately
when setting it up, because usb_ep_disable() is called on an USB endpoint
that was never enabled before. There are also some other issues in f_acm
where state is not correctly claimed or cleaned up.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (3):
      usb: gadget: f_acm: Claim requested USB endpoints
      usb: gadget: f_acm: Allow restarting ACM console after stopping it
      usb: gadget: introduce 'enabled' flag in struct usb_ep

 drivers/usb/gadget/f_acm.c |  4 ++++
 include/linux/usb/gadget.h | 27 +++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)
---
base-commit: 0efe8ea57fc7a1a6fc5f64fb3cf6bc4a1a4fc219
change-id: 20250407-acm-fixes-935a27c7a2b5

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

