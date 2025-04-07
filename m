Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071CDC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EED582ED0;
	Mon,  7 Apr 2025 17:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n995VhsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B251C82F37; Mon,  7 Apr 2025 17:00:01 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72A382F3B
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso444269966b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744037998; x=1744642798; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+BZQBmk+RYhvNW54KiogFQfTrggnZfdRqrfFAl2xxzk=;
 b=n995VhsLU5n8x8AKLx6cgBpRI+LXCzrQMIps5LFX25xgSewVx2wj42hLZnM6G9c7wv
 eoTKfFcmQlUmTRTyediN96hzkIMkL4CR9Fot/yQPuy0yJwY4aXzcWNUApKjy7FecPJh4
 zlQBBe6cXTkLSaYZIGi6fGk31Mn1YO0o0fBtlS2r26gXKqwPUP1HJAdQZVkXtZjQE7hj
 7mDsWCnDYIWAjqqARTvdxF8huiY5b+PGboWjbFmni64GginRQb8HQmSrdEZ1WFJBgThp
 qMlaAQiwlG5wgW3X7apbHTIabXS8/Gla0hh6rwwka1dUfdXwbDYP2GM3+DKFaXcf01B/
 KrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037998; x=1744642798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BZQBmk+RYhvNW54KiogFQfTrggnZfdRqrfFAl2xxzk=;
 b=gZ7jukj8hWR9eemucjB1iFTII6VW7YFEkXZrwis96a2kodqnTNZ9iTEMuMWppk3yRh
 A6vCCBBNKqbnF83wOn79oCE3hIG5Cdr9E4ZwB+X2Gr/HTFp+MOYPkc8ejaok/MU2yqK2
 WKhNrnIRi9VTH4Par0+WQN27ki00m3d666GkTRqAE/c6Le2E2H1vYXe5/gQ6HI1c8InM
 hAaMaP8ipJRzGA3SGqnAoLDR1lUW2k03wY0QcdaynyJxOe2c9ALxeKJ3wpKXmEqlV7Rp
 kMEB8oqDf0DMp7UH/O0V6SsdjqrtNK2Giq0yr1nW4myAoJIg265IUsaK0IQd0R/zMyxF
 fdKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPxjDn4SI9YirHBuRuvV0qZKfRW9smfI2kIRlKCdNeKznsVsMYCrSRnxHE+Y8WbrPitV8BVIk=@lists.denx.de
X-Gm-Message-State: AOJu0YyeuHcZAo/b2swpa1mrcilJI9V9Y4V8qrtKrC5HVauZObtGK5rb
 ggs1UDWq/kI+vFJ7jZVUVj8vU31XIwF/WB0KRORGIlXwtRixZCXlNEd/Zmf68iQ=
X-Gm-Gg: ASbGnctGImxyQo0VAmJJ20/ysQQTsh1nb63fiPB7poclzlugwiGgSptHRGAFvIuE1St
 r+Pv3PDQwLSJckiMsm44uzDRu0joG0MZeIElJ3FQJD5yUljMKU4m/j3+5PyfsB6br917M+Zd7zV
 GtNS1FMMr9LEsbekBEojv3ZGqcDfsnMC1YMCp1Zr+9pjA55JAinQa+dD9nHVZTJV7cB0Fs/P4Gp
 DPZxf/5kpHef5Wdz2xBJipE9Gu57oQCqeeHagI3VEVmPD2z9x+wjL3ZIe/BH+tQ7l5N+JgNZRL3
 awC3QU9dr71zLnRljKI5FHfr4qCwnUDd5vIGXyZkQSSjWQ+kuFMekmCM1Q==
X-Google-Smtp-Source: AGHT+IGAZJ8kKi/qDaUGtUKxdEeyypqoMajYurQ9IGtCGD0GctksWvzD/KI84EYDI36gZBH6HrSpNg==
X-Received: by 2002:a17:907:9727:b0:ac4:4c8:5e30 with SMTP id
 a640c23a62f3a-ac7d1876af2mr1328826966b.17.1744037998403; 
 Mon, 07 Apr 2025 07:59:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea2224sm751585666b.74.2025.04.07.07.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:59:58 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 16:59:36 +0200
Subject: [PATCH 2/3] usb: gadget: f_acm: Allow restarting ACM console after
 stopping it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-acm-fixes-v1-2-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
In-Reply-To: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
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

When using IOMUX, the "usbacm" console can be added/removed dynamically
from the stdout/stderr/stdin environment variables to allow temporarily
starting other USB gadgets (e.g. Fastboot).

However, right now acm_stdio_stop() does not completely undo
acm_stdio_start(): The USB gadget is unregistered, but as long as dev->priv
stays set acm_stdio_start() will never register the USB gadget again.

Clear dev->priv after we detach to make sure a start operation after a stop
operation registers the gadget again.

Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/gadget/f_acm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index 2665fa4168f99b35a8c595aa24cb3fc4e8ab8529..8f7256069f58527b2e43e5add725a0b5f06baa6d 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -663,6 +663,7 @@ static int acm_stdio_stop(struct stdio_dev *dev)
 {
 	g_dnl_unregister();
 	g_dnl_clear_detach();
+	dev->priv = NULL;
 
 	return 0;
 }

-- 
2.47.2

