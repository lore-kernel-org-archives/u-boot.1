Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD32C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51FB84661;
	Thu,  7 Aug 2025 18:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JxbJUXds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D3184659; Thu,  7 Aug 2025 18:35:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEAF83B4E
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so6636735e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584521; x=1755189321; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GOw6CKYdYW8kG/M0225OwYnz6AEeByQLA8KY9A1+xbs=;
 b=JxbJUXds4LFs/qnFRqIXcyOHyWGyIxRav75MLjPvDBi3XnQdKQTVSrig73BVzVlwZc
 jMJVmlmRsMYg753hcIjkYEE9jUwUwCSMtTeWq+O9JrcQnnskn0KjFADmtYzFJvKmAf5t
 q5V0wrzdt0TDhzycUCvAPeFbAra2QU0PmcRtXwSPUL+uJZMv7ARlf0chXWthSePrhusI
 OxRBr1UPvLbNkMGTtIpo1Xyx4Pu9LtBZSyfcGyo9xqO2wnaweooYDZF+6xQtt7Zyzk03
 +bEdp45zUReSlLoTnoPHBZ3HSoduIHoIMVk6nhDnafb4P7PfsOZlM7TKh7VybB2Jj1WG
 Rpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584521; x=1755189321;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOw6CKYdYW8kG/M0225OwYnz6AEeByQLA8KY9A1+xbs=;
 b=reH1JRFqBpxxS4PGiGPFRQqmSlP7aOF9cpkysNOc5jYx2RSgIbqtOic5UFP5z0VH4m
 bD+xTUKD3SDvLsIQGZ5C+goXVu9MSRSjgx+Y1CbDsYVGSSbyIH8/sJcBqtD8WgnHJ+DQ
 JQ/4AC+mRAEK6MTGFMAggSKbAXQkoYnAbpqyIyxTbBQaM7Mt7yXjl3+F3rAI2dSKU3IR
 4U0lWO5raNVSPKMRiD8EJPzkVU70KzodifTqasUK0KxpE8pbLih5o58mgcrgRkLs/zAN
 g371n4WVAbdmMmZMfNfIQ0yLXbe0uvlyF2LLWsAZeH3gK+YvVZcpRWNGUH0RyimgjDU5
 Re9w==
X-Gm-Message-State: AOJu0YyUQJgwWo52ZGvCi1TixOiwS273BoNstme9+ZDvCiUYilaqqe5F
 2CqyFO6MzxkEdL24zJu/50y96/JWMmaAVNeqdsqjPyb2cn1n0aWpMCj3m+852hMfGzo=
X-Gm-Gg: ASbGncsgdNTn/KsjyfwRA4uIO0l4etXrThrJlttGATdMYZzKkJ/UFmGOFsvgTE1ltZM
 h4KZOC2HJsaz3HnH+5KFhhZO6Qfaa3yXuzg4Ii+7xj0TBaVQvJre5HNQIkNM4kV2DrkViZ/pYM1
 iUU6OF4E3rZPOpdh7jDt+XPPvCCv0XT+3RhwcK9Blcy/3CHZcAVX2fv4Sq/xYlmaMeCd6bjm7VC
 sX+EbrbEO/lWXAfpsg+zDouukpFKHnJmZbcC+7KnHn6js3WuMAcZDaMBpFzncDoa0K+FvXojPbI
 777bw2jgRv1J1fm8WnEKikp7W4ycHjMLP9Qia40HNoLsJMIqbIoB2T+u5cokxWt1+npqPn70OTj
 Gx1Wa4m+TQ8nvWQLBSAOG/iloY1JXMeRLHAeijyudr8WoSXV2KNT9rtqUbVY1XA==
X-Google-Smtp-Source: AGHT+IGMnKMmlbuYKdJ9Czx//REi3FrzeC1UYNenDdi5/tQDbWzDvskokhyvx5RDnQADmq2Eb0mwFw==
X-Received: by 2002:a05:6000:250a:b0:3b7:9af4:9c75 with SMTP id
 ffacd0b85a97d-3b8f41d483emr5495314f8f.30.1754584521290; 
 Thu, 07 Aug 2025 09:35:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:20 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/6] power: regulator: Fix some Smatch reported issues
Date: Thu, 07 Aug 2025 17:35:17 +0100
Message-Id: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXVlGgC/x2N4QqCQBAGX0X2dweXFUmvEhF753e6UKfsWgriu
 3f2cxiGWcmgAqNbtZLiKyZDLnA8VBR7zh2ctIWp9vXFN/7qxlmfiu7z4mlQl7gJyePM8dRSaQI
 bXFDOsd+rN9sE3cWoSLL8R/fHtv0A7p2sUngAAAA=
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
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

Smatch reported some issues in the regulator drivers, mostly repeated
instances of testing an unsigned variable for being negative but also an
expression needing parenthesis to be interpreted as expected.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (6):
      power: regulator: lp873x: Cannot test unsigned for being negative
      power: regulator: lp87565: Cannot test unsigned for being negative
      power: regulator: palmas: Cannot test unsigned for being negative
      power: regulator: rzg2l-usbphy: Add parenthesis to return expression
      power: regulator: tps65910: Cannot test unsigned for being negative
      power: regulator: tps65941: Cannot test unsigned for being negative

 drivers/power/regulator/lp873x_regulator.c       | 8 ++++----
 drivers/power/regulator/lp87565_regulator.c      | 4 ++--
 drivers/power/regulator/palmas_regulator.c       | 8 ++++----
 drivers/power/regulator/rzg2l-usbphy-regulator.c | 2 +-
 drivers/power/regulator/tps65941_regulator.c     | 8 ++++----
 include/power/tps65910_pmic.h                    | 2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-pwr_regulator-fa8bf0e4ac3d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

