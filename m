Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8425DCCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CF6802C1;
	Tue, 30 Sep 2025 17:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vUKUFhsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D007683526; Tue, 30 Sep 2025 17:52:26 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E60A800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso35916855e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759247543; x=1759852343; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KXG2NAkZiKHsdjMBcf9vPuI0dLemThpXUu9bh2mjZZc=;
 b=vUKUFhsv2dtWyEtFUEo15f2oMfNLZ3JcAIYsR42xiF0IGhlMPdf8NA9DMTidWJkO1T
 rBJXl5nPt4UAWOchSagLT+k09HELlXS/dFDWzStC/5kEK2uQaeKQTgT3/xoWl/9QKb2B
 2kfCu5YGHk/lemCCzv8sP1XE+SSQO2V4LQKjGxXGKiN+l9rkRSQSxkXRl0ZtccWf003/
 gwZ6uC/N2cMF3C2TUfysvkcWp0QqCPFJklaOLYZjzc5YZE1+dptE75A9bhp92EtrQOoi
 qStg5vbF6UZA0F7JubgB9OG2d5B9Pm3/F7ol6iXKg33uEzTts8RZghzRsx7Mj8Kaa5eb
 thuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759247543; x=1759852343;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXG2NAkZiKHsdjMBcf9vPuI0dLemThpXUu9bh2mjZZc=;
 b=c6ZNtySH3UY5tPycqcWN8H/ZnTTluOtO6jBUv56N4i81+hQEDHDqAgJ68mWGOhmPAA
 JDtVUu3UqBjnRVqDBfK6Q1saBLN7fjD/Q6PDkyoqGUOFdl1lexZHsujBnOh0MOhqxQwE
 kp07BMGGO66qYzGd/SVLAk8a377ZYmUhuCTXCUtCCUPTNqiO08LfgGGYJdF6IGYr2IC0
 qcRhWJHVDPNSehUNH7ulvvLULxna/HfIyXgS2ZEawUQow+wCUtYOv8c275PHl66FAoBO
 gSsRzvLq6+LtkcdlBHrOKoVTntr+J9Aw/eO5Ec/yH9T/+LcSg4fVOWcf3rBbuS/FyUHt
 rPjQ==
X-Gm-Message-State: AOJu0YzYjqbtiLkixNqZjPjOkZBBTTH7hKcjS+HkLEnYoicnB+PipFFM
 yPB9d4J0KV8XpDi6rskN9wxUbJsxQPdbUMvMTSa1fqTCFrInhhmVl4HQcurfAlbPg/Oa9M25Z07
 wROsx
X-Gm-Gg: ASbGncuyeEjvVCd6yzCqOEWNtNsJhx9lijxsbbh/rYX22JHIP5AB4U5slT/2zomHETe
 2OSN0vA2e69+JnT7bP87OJgQRyCZ3NgVjOs3exSjw0LoAcTcb6OGu9xvJ9rUJ5nikakXXLrHsyS
 TUmuOpxe1dvYzQXSQMKUGVTByD/PAey3quuQpCiBMUzIOQoKJ1wPP+SpIAa+a4EPO2Rxc9PdEkZ
 WlsVURb3wOKVAPNO5pzNoUdY4kpU1kDkl+xjjhDuTSBS/jM/fl9SFHfunfC+PgphvAfvV82RplP
 f2fq8Bdiaf0c+08I14m25XDWZv1YgVbprgm9uWcQSIVJwPb8XWk2fvT/ryBx2yf8aqMoSqxP/w0
 bFZGg4emTv8ZtwCZcJCt+TFf097QoeUAYC9oDQinE2QAWVrzD8i7IH6Z5kE/Cyx/+wXwtZBd5+T
 NhX1V4P9zU
X-Google-Smtp-Source: AGHT+IGSzQIswEhGEpDz8aeHyQliaipwRmsNsbi5nTBZ+vbr2kzdCRLK1shrObWC9FNj4GagIm4B/Q==
X-Received: by 2002:a05:600c:34cb:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-46e613dd3cemr2797565e9.36.1759247543591; 
 Tue, 30 Sep 2025 08:52:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm64747165e9.2.2025.09.30.08.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:52:23 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] usb: musb-new: Address some Smatch issues
Date: Tue, 30 Sep 2025 16:52:21 +0100
Message-Id: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALX822gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3dLipPhcIKGbl1qum5piYJicaGaQlGhhqQTUUlCUmpZZATYuOra
 2FgBTG+QjXgAAAA==
X-Change-ID: 20250930-usb_musb-new-ed01ca60ba89
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Smatch reported some issues with the musb-new driver which included a
variable being dereferenced before being null checked, an array index
being used before being limit checked and unsigned values being tested
for being negative.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      usb: musb-new: Null check before dereference
      usb: musb-new: Limit check array index before use
      usb: musb-new: Cannot test unsigned member to be negative

 drivers/usb/musb-new/am35x.c           |  4 ++--
 drivers/usb/musb-new/musb_gadget_ep0.c |  5 ++++-
 drivers/usb/musb-new/omap2430.c        | 34 +++++++++++++++++++++-------------
 drivers/usb/musb-new/ti-musb.c         | 28 +++++++++++++++++-----------
 4 files changed, 44 insertions(+), 27 deletions(-)
---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250930-usb_musb-new-ed01ca60ba89

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

