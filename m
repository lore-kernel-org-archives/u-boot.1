Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A39C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 10:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6676583121;
	Wed, 23 Jul 2025 12:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x9puga4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316498341A; Wed, 23 Jul 2025 12:34:39 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A2482E26
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 12:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b611665b96so3684590f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753266876; x=1753871676; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4vkAFUE0NSTZ2qFX53pInGuZiwITymhxL+AAVU0iVLY=;
 b=x9puga4PqTPKh/+i4g8zNw5+Vsb//JCeZrwdDfIVhNW+ZnyGBH+l1lP5RpNOLQOcuF
 tiXibzdrYfvVgDZ2oE+4fiA7DDoetxZMrvunx6Q0KRBTmC7+EDa1WH9yedU/u+FK+o9S
 p6HVcZ3p9/HJWppx8jcTqdxD5gv+VZnnoYJUozttn2cSJ/L8Ti95cdNiYs63M4sPAIlu
 up3VRfKEChsiLyv81mnQwg12BCJkHqjLFas2O4yV6JtannHonbm2xiUkz+0JDvj3KMnV
 3H5YaCfnENliAwM3zISuw9xz1U0nSEv/sArW8KMlfYqfdJA4XYHkmLS2AD19SfIPpCiU
 lxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753266876; x=1753871676;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vkAFUE0NSTZ2qFX53pInGuZiwITymhxL+AAVU0iVLY=;
 b=IuNuA91geO8GcDArGt2mAcNpPWll6VbP/CRPgEcY4ZnjpccZFK33NQGqHpPNAI+MGH
 i6CHuJjTlvPzWtRk1VeHOj0HxMo6nzMcs93xkW7YQhFp7NJ7UyA54qNrhSnvEQXYeUQ8
 l4HOnNonmvJWo1pB2kIvrwsBj6w6JDOz5FJ9FXCPy56rZ0WbjFaF/zh79+mnAgmNdHyT
 CdI/c/OxB9uSje6mx0QGlKchsUTXlzeIMMEj21G0QjiOUn91w+8fRSXEkp21WOEcNLcx
 yUXZjt/AlGpAg5Lkq46qtxM75LlAF5v+QKD2m2yoErodTboVuOAHqqJ+U+VgdazkedOo
 bitA==
X-Gm-Message-State: AOJu0Yye4KD7MSZQ+Ghbbc/IdUSxz8h4+g8EeYpBUeZocNf5q8e800lo
 fy3DRXKdBQ9mIxA/t4l3pUc3kEObGvd0t9mQPxRg/TKq8qoMLDIhaapb0aVZApqKsow=
X-Gm-Gg: ASbGncsS/derviD2VubqmVMyDQMr/x4mkBQbMOMaW6wigRx/l/8vX0uJsTx6/CrJaNq
 v88+FSLqpoYNNTuSfwCqiiHP5dwN08KI2kfJWEXuju6VtKLXaDHCo9QlOJ3ELW2TdcwEKGC9cpO
 NrSy+65z7AS1VE3gYOvKn7EQIZkISCkySgCDWtFOs5TGIhZoa7StNI6leI0PTRpn+y5ggdtRWKH
 9UOB1hWleUO6UYFc1+2IUOqJ2Fg5qjRVl2Tdlm8YYDzj5bmDU/flHpyiRSumnm/lDDpvXK1U0Lr
 HcZQIf8ejhN0/hRvcPAyonuA92AGIdK/yDivJj/U0y8uoXSMUF04hTJgMA6m/PvRCkePV92hOc8
 uIfPrUQlRGoTq/DpHkLPy18fd+YRvph/BNslDNa2jxzvUwHk/AgA=
X-Google-Smtp-Source: AGHT+IEx/9vMoEeucRzY1TSP1MMVO092OUDfmw361rlRp2SQlsztRlFDkFJFQnxa6/qtKliT7g94xA==
X-Received: by 2002:a5d:5d13:0:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3b768cb1b1cmr2010122f8f.24.1753266876033; 
 Wed, 23 Jul 2025 03:34:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:5143:c98d:3163:b66b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2dfe0sm16015964f8f.36.2025.07.23.03.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 03:34:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] bios_emulator: Fix two issues found by Smatch
Date: Wed, 23 Jul 2025 11:34:34 +0100
Message-Id: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALq6gGgC/x2N4QqCQBAGX0X2dwe2aUWvEhJ7+pULeRe7FoH47
 p39HIZhFnKYwulSLWT4qGtOBfa7ivpR0gNBh8LENbf1iQ8havYbpvdT5mzhyCLSDDi3DVNpojh
 CNEn9uFWT+AzbxMtw1+9/dO3W9QcP5YwweAAAAA==
To: Tom Rini <trini@konsulko.com>
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

Smatch found two issues in bios_emulator, a buffer overflow and missing
parens for a macro. Fix them both.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      bios_emulator: Fix buffer overflow
      bios_emulator: Add parens to xorl macro

 drivers/bios_emulator/atibios.c     | 2 +-
 drivers/bios_emulator/x86emu/ops2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-bios_emulator-62aaa4de8542

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

