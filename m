Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F50D0D7AB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C238934F;
	Fri, 11 Oct 2024 16:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RrxXMzGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDDE98934A; Fri, 11 Oct 2024 16:49:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93086892F8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c920611a86so2751509a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728658196; x=1729262996; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPEmfYA/cUnYLvoG/1t8re3fZki3W4KQo2K5uvA2baw=;
 b=RrxXMzGXrK6xVb0bM+ZbIUMVboY1zGFlfMe/GT3p29LDSnjihsoh1kIT673wU2EF1d
 6Oe6iK1FFLvG1mUHyhLxm34N+G+K/UQsQjEb+x8OjozHrc+IW8rZ/aSMq7xmwAcm6lAs
 jQQcQylEaU7BhZy7xp811Xc0AGbH18+/3zOCfd0cQrU9W3R/N6iX4jkSywb44I+WiZJ7
 T7CHOpYacrVmWN20wxUTxqq4vBIWcygrNerMkEKpsCyxGRJIN0RjCTVv2oajq7n5xDzD
 N9hvcMFrDMc9yj9NHHwRsV+oUOQQLr1pJgOmFYtFlaTDueiVwlzYyKRcKmFrOoa1VfiT
 1Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728658196; x=1729262996;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPEmfYA/cUnYLvoG/1t8re3fZki3W4KQo2K5uvA2baw=;
 b=sCHwxBpzK+ImCCABRzHwdr9n2b7BRtyLqh0f7ybwAHrkWNkKeraPcB0sg8KYOOJvT6
 kqg9+31aVdTtb4k9t5M5qIZMywu6rE+GMU2AKuMP6cY+76vUBE/OxEM9usBuZLY4kp2E
 kJl4F2spw1gXnd+xOgu4ApZgK0D4+tCtQ//heE5hUeuU/Gy8PfH/zxbOimNMAkGy+hA3
 Yx8xUCRCFYL8qupEHsi/j//vkTAtQgqJWqwIrjKP/aHEyQJAmjxV3tZUp6RLkY2Pgwnj
 y0SnWhcu9t5wM8eoIe/KMryab/liQnvo8L7MArOfOlN4A5cTco2rdfPN52SO6O436fpN
 Yhjg==
X-Gm-Message-State: AOJu0YzmDwQvjEJzfMef8aC1u1E3sDGoJPWdxG6ehs3WNpts01sh8a2B
 AIIQK0mrCO+9nbKZqzcIQvHQosXnNmY1WWD3IjirR/ixR3700YN3HSU5k5QUT7o=
X-Google-Smtp-Source: AGHT+IHRWLob/4RFQAihZcb/NcfoL+Z0tI0PPCRHjIGbGqDdkRD8mbty6um4x5KqmoARXUChd8BrEQ==
X-Received: by 2002:a05:6402:2748:b0:5c9:4a9b:31f9 with SMTP id
 4fb4d7f45d1cf-5c94a9b5292mr1969237a12.35.1728658195982; 
 Fri, 11 Oct 2024 07:49:55 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372940e3sm2006113a12.81.2024.10.11.07.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:49:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/4] mtd: rawnand: brcmnand: Add BCMBCA support
Date: Fri, 11 Oct 2024 16:49:53 +0200
Message-Id: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABE7CWcC/32NTQ6CMBBGr0Jm7ZgClUZX3sOw6M8Ik2hLpkg0h
 LtbOYDL95LvfStkEqYMl2oFoYUzp1igOVTgRxsHQg6FoVGNVudWofNP5y1GGwPm1zQlmVFrbag
 2nXMuQFlOQnd+79VbX3jkPCf57CdL/bP/e0uNCqlrje9Ogc7aXB8craRjkgH6bdu+FHwc6LcAA
 AA=
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
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

This adds support for the NAND controller on the Broadcom
BCA (Broadband Access) platforms.

This requires the series with brcmnand fixes that I sent
separately to be merged first. See:
https://patchwork.ozlabs.org/project/uboot/list/?series=424109

The development was done on the Genexis XG6846B which is
a derivative of the BCM96846 reference design, but probably
has a different flash layout, be sure to check the last
patch in the series for a comment on that.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Switch to using OF_UPSTREAM instead of syncing DTS files.
- Mention the Linux version the BCMBCA NAND driver is based on.
- Link to v1: https://lore.kernel.org/r/20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org

---
Linus Walleij (4):
      mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
      drivers: nand: bcmbca: Enable on BCM6846
      board: bcm96846: Enable NAND options
      board: bcm96846: Switch to using OF_UPSTREAM

 arch/arm/dts/bcm6846.dtsi                   | 103 -------------------
 arch/arm/dts/bcm96846.dts                   |  30 ------
 arch/arm/mach-bcmbca/bcm6846/Kconfig        |   4 +
 configs/bcm96846_defconfig                  |  15 ++-
 drivers/mtd/nand/raw/Kconfig                |   7 ++
 drivers/mtd/nand/raw/brcmnand/Makefile      |   1 +
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 152 ++++++++++++++++++++++++++++
 7 files changed, 178 insertions(+), 134 deletions(-)
---
base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
change-id: 20240930-bcmbca-nand-support-4447e176bbbd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

