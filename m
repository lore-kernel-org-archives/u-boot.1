Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C8C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3165F80E9A;
	Tue, 10 Jun 2025 10:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="YYlzP8oK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B3A82AC4; Tue, 10 Jun 2025 10:02:35 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142FE805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ad574992fcaso770338166b.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1749542552; x=1750147352;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ximZhOcqc1/RrAPJPBfmmdh++uHX+p9Kj4xckOO1ouE=;
 b=YYlzP8oKe9H6UgjPiPi1sbmrMwu2e9Nec+OQTDpK1BUjhWFP9dJUUnE4cKBE2/gRHU
 EnebRif0rN4/N+88diPtvH7x3UcnSryju63e4f4GlrXdZG8y2azMu9XmIKNWpvsw32y/
 vq/3zKEr3kzCCrlnybvtDJjEGjDdnMspStpfXvSkB4kc0gX5z7r4eoFtYt1wp5J7DJra
 9Lrd0Bdv8BbYm+QGsq1wwTwkUAQufH39SS2ktPNx+7HMTQpakZpbRiZo1k5P/wd6kavB
 DWj2MYdSpAFeDduCSWGl3vnvzhacJ81RaKmVz82+ssm9/NGmHZGqss0R597xTKx3ad8H
 cyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542552; x=1750147352;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ximZhOcqc1/RrAPJPBfmmdh++uHX+p9Kj4xckOO1ouE=;
 b=Pse29lrf/3weAQarPTGQ0dRo+ibBWO1gGsZXrd/cLdewF8q4X6ohUgHA0ncL8UCDYq
 kKSe/YZWLuaiXw6UsSaPWNcxhH4gq0futZbNe0yvqvZskCYJv8VFl5yoqYvnGUj1z45d
 pjOFlErOGYdYu/aJCYvyc1hiyEQgagdjh0jQZ9gMCkiJ9NIvK2q3i1q9lKzmEF1mirg2
 +yRMIyLgeoR/KU/7c9qjv7vyjsY37GXlt/7T7QUkLbc8st8CmRc/mXg1yHomIpJl/u4H
 wy8TSiCL7sojLZBYrU4Ws4yHCsVpI0Ynzpc1b+vOO9K3KLYkecJrPXjU+AFMtr+c6AfJ
 KK8g==
X-Gm-Message-State: AOJu0YwQGHCMtNHimJsruMx9y+177XSIXcNguXKccVF7YJvMzL0W5DvW
 mYGdWb1XjxiMpb1CumH49ytjzBdxGg8HoGe23NbCZZ4nr5lWCQ6x9IhKj4FZTIRsNBw=
X-Gm-Gg: ASbGncsv1NXuUsg3fjPsjcuwH0DU7CiFF0GczwIG/j/DYOTCp+33Jh/zmd1mCC9p8IQ
 fJoZd1t6yYd471tYJR8+0YXR6TPaBzDmyhtNwpxl9cIZf+mpjvGo9VMqj60A2JwbJa1UhtEg3yw
 4t+HIHC++WuoPTFRBOZfS7gL2A01BufPW7Hfj6Z+ipxcPA2Xfu2por+6xCHi4nNbQp0RrwISskq
 J6rnITJLdqapgGmM9ovUx7B8teq20bJWGzvVifsSR+zPsUaoKpyDd9PF326i8jq+pXSRacOShsH
 uD7fVb5DH3EapBjcCNlrXga9/s8Ixq9HmHwW4yIl+Vr785xMgZ7Nth+WCqRRrUwj/AN0EGpfh0s
 =
X-Google-Smtp-Source: AGHT+IEwSGUam4U+Si71oDcD7CGyq32d4yF3Kbh+CCiVJDf9uZuydz9uafw4pm3MaedaxAauL+5DFA==
X-Received: by 2002:a17:907:9307:b0:ad8:a935:b90b with SMTP id
 a640c23a62f3a-ade1a978b88mr1350737066b.28.1749542552360; 
 Tue, 10 Jun 2025 01:02:32 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade343eeea1sm578233766b.74.2025.06.10.01.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 01:02:31 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3 0/5] Extend usb_onboard_hub driver to support Cypress
 HX3 hub family
Date: Tue, 10 Jun 2025 10:02:08 +0200
Message-Id: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDmR2gC/43NQQ7CIBCF4asY1mJgKBVdeQ9jCAUqLFoMtKRN0
 7tLu3FhYlz+b5JvFpRs9Dah62FB0WaffOhLsOMBaaf6p8XelEZAgJMKOB5TI0PfBBWNdGMj9fy
 KNiXpJoZBMHoRrKXWWFSEcmn9tOv3R2nn0xDivD/LdFv/czPFBDOtuSI1EWfd3ganxk4NVp906
 NBmZ/h4HOrfHhSvZQIqyo0S1Ze3rusbN8ZaMhoBAAA=
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

This patch series extends the usb_onboard_hub driver to allow for
support of more types of onboard hub devices, and adds the Cypress
HX3 hub family.

First patch in the series updates the bind function, so that it no
longer uses hardcoded compatible strings.
Next patch simplifies the code, by removing unnecessary dm_gpio
function call.
Third patch updates the remove function, which allows the prevent
issues with usb devices reenumeration, in case of calling
"usb reset". Although the issue could still occur in case of invalid
initial state of reset gpio, it is minimized with no impact on main
usb_hub driver.
Fourth patch extends the driver with support for multiple power
supplies, the same way it is done in kernel driver.
Finally, last patch provides hub data and of_match table entries
for Cypress HX3

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Changes in v3:
- Rebased on top of latest master
- Updated usb_onboard_hub_power_off function to print error
  message in case regulator_set_enable_if_allowed call fails,
  as suggested by Quentin.
- Link to v2: https://lore.kernel.org/r/20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com

Changes in v2:
- Replaced the method for finding hub in bind function with
  uclass_find_device_by_ofnode, which seems more appropriate 
- Added new patch that removes unnecessary dm_gpio_free call
  in usb_onboard_hub_remove
- Create separate static method for disabling supply regulators
- Update error handling in probe function 
- Link to v1: https://lore.kernel.org/r/20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com

---
Lukasz Czechowski (5):
      usb: onboard-hub: Use the ofnode to check if the peer-hub was probed
      usb: onboard-hub: Use devm API do automatically free the reset GPIO
      usb: onboard-hub: Set the reset gpio pin before freeing
      usb: onboard-hub: Add support for multiple power supplies
      usb: onboard-hub: Add support for Cypress HX3 family

 common/usb_onboard_hub.c | 101 ++++++++++++++++++++++++++++++++++++-----------
 drivers/usb/Kconfig      |   1 +
 2 files changed, 79 insertions(+), 23 deletions(-)
---
base-commit: 5a8dd2e0c848135b5c96af291aa96e79acc923ec
change-id: 20250425-usb_onboard_hub_cypress_hx3-2831983f1ede

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

