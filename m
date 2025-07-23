Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CC7C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 14:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D03783477;
	Wed, 23 Jul 2025 16:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JFJfogr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FD88352B; Wed, 23 Jul 2025 16:13:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49DCE8317B
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a528243636so4081333f8f.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753280030; x=1753884830; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9LRLlXeeXcPS0bq77R9meGueMGDxrCBr1RYmCDEZ6Y=;
 b=JFJfogr1b/dJjRfN89RFjeyDxDA+dd+uHQkQdVAkysOX372TMkmoLTExu+ntUcAEkT
 /MKCYxFCXyBlpngFpHPqWN6D1fnwSv3xFkAArqYTTffdwOCjh67fWHSuqJQGTtdYPPPY
 pHSNk1jGlMpjwnIgU373BBWvnExA8sxnoBQSJFtXZXK21rCeEGuDOpvvEtxD2+hfXa7V
 Hnz3xRcs1iD2b5cW2bb5gYvNFczeK3guq3f3J7f5cNP9xIJHUxtPKHXPG6RDocQIsnDj
 PplY0k+I3LfWaNb7fuMcRt49v85BEhHQl8W/6y9bunDmO9gJ86DAQc0o9tglL63H4fQJ
 iQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280030; x=1753884830;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9LRLlXeeXcPS0bq77R9meGueMGDxrCBr1RYmCDEZ6Y=;
 b=Zh3UjdB5ry0q/Qt9/C8Zacjr/Io+6YqoRbSFbHN+kS/YE28O8e4xTDfiEvA6/+CYgJ
 //23tauVMmIGfrTTNVcwWk7UId62GnhvPTMcMwTYZLIoo75La117OlpImlIYdi182Jz4
 dtWQ+9im26k55q1NI0+5qZedyvM3/hNKmLa0Edx0D4dyoXhnTh1H5IoJcmB0OGnvcaD1
 ktWXEF4TL9rzoX7bIKZzhNCgkJBqR/n3lXHIHLPXbd0fgsiwx3h1wnjJ67FegTs1nmCq
 YALhewHTMJ9DhDAAk1GBmEABVyrg9VAfhAFjWrkGZcmCB5LEMtG9nTVHUn4IH8j/ZMs/
 9XJA==
X-Gm-Message-State: AOJu0Yw9fHyyzry8bSGWao535mbR5nkqXVycDJgtjz410cCTwSKBIctQ
 B/OJuH5TLAB8H02ZGYWCAezrBV9bjsrrcfvEsb0uTLy1tyPjCOMVFfhlNM4OdiNwotA=
X-Gm-Gg: ASbGnctOj5vfaTtgepGnGX4tiHFi41sLMAAW1dMrGdB/O7Ff8UiLs9Yp4t+L8b/T3sC
 0fTkmwy727qT0OBib3LvtlZZiAXwO1Txvx4SVv5eLb3W6yKUeJlLui0zzUnF7WwJ+7VTT93gq41
 f13qetWdEV34z2mdqpsxlg0Twsb8pwj3JRNBgkIdNNpe3cYk3GMzLAtggnMxaKTv7+ZHYpL0ibP
 xk16hf/pZpR23frfghOQj1Rg6U9+HdHQ6RoSQXopCZDojAvy+2ttqXalG7aysz8xW4abyqUbUD5
 JghxCmVw9o6TXAUXiP65/a/NmiYNf82/G6kfMGZuPgMTUiwVNuNJFY5FjdqrSYXnVErNC7dvrQi
 LkaNRciqj5joyA2+TMOkGeQKtfLkEO9LLKaXD0P6gDK8ZD2Cd1zA=
X-Google-Smtp-Source: AGHT+IEqglYZ+kjRRtOSt3jB8yxBH3NyElMjJaHIAydQWKRN3VlvJM+eK84KJqCPK6n+PUAJfb9MSg==
X-Received: by 2002:a5d:5f4a:0:b0:3b5:def6:4e4 with SMTP id
 ffacd0b85a97d-3b768f22fe6mr2867308f8f.46.1753280029598; 
 Wed, 23 Jul 2025 07:13:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b75baa7072sm9416857f8f.2.2025.07.23.07.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:13:49 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] clk: at91: Fix issues found by Smatch
Date: Wed, 23 Jul 2025 15:13:47 +0100
Message-Id: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvugGgC/x2NUQrCMBAFr1L220ATtVGvIiLb9NUurVF2iwild
 zf1c3jzmIUMKjC6VAspPmLyygX8rqI0cH7ASVeYQh2OdQx7x/PZ39M0OkR/ag6cGkRQ0Vs2uFY
 5p2E7PNlm6Da8Fb18/43rbV1/YgkeAXMAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Unsigned variables will always fail tests that check for being negative.
Use signed variables instead.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      clk: at91: Fix testing of unsigned variable to be negative
      clk: at91: Fix use of unsigned loop index

 drivers/clk/at91/clk-main.c   | 3 ++-
 drivers/clk/at91/clk-master.c | 4 ++--
 drivers/clk/at91/sckc.c       | 8 +++++---
 3 files changed, 9 insertions(+), 6 deletions(-)
---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-at91_clk-e71864ac6e7e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

