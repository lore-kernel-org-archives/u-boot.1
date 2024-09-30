Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0875CE8343
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3767F88B27;
	Mon, 30 Sep 2024 15:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IhVUzYAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DF388387; Mon, 30 Sep 2024 15:25:02 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0580888D6B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b4e0so1916583a12.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727702695; x=1728307495; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0NdhdUO3+LEmFo+b3aVZXOP92D9LENrRmHjkmSQQP6s=;
 b=IhVUzYAmte28mBxooJczKnFM4oi+zPNM1LCB4aUmXjBu670Qhj3rC4toD5juNkxwlM
 TidxSGFaMIBGIWxrlUojRnUOU8AFF4Oh7YR2MivYVDw5/89D6hOfKL2sR+b209aJe+ks
 GM2+NvYYur+XJnhxRn7G0lbZgpJhvTfC5Rd5VPxiqkElQyuvODatr81z37OOfftL00nU
 F/l2bJL/qeNL9VwGqpu29sy/Fly0yVmOtoJo/KMeoolkJfjyYhLQFA9ygXjbm4+yWtPf
 St+NPNFnh6JVisSWRvZsE3B4Lj8LomFR596N9MLDVKAfCozMRwI5w40MWrqx3N2da6gl
 ONjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702695; x=1728307495;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0NdhdUO3+LEmFo+b3aVZXOP92D9LENrRmHjkmSQQP6s=;
 b=P6/UFVP7GLj0l7LgPqiuswjzueMabNHlqHm1r79m1O8kbJkjoCPhWDnaq4ccq1mtOq
 Mmpa6OHTIABplrb18C7d0ugLV1KJJWWSSO5DHzni3PPTgZuoCrWwqNCTr5Rmiu1iB+dy
 hoy2mmM1dGJCQyulY7ShJun7o0vSmVpNs7tYXQkHKQfgNrP9CxVES2nbbIMTvPs+bI2s
 LiKD8adyejJGEjLXXLOwyPQAI4t6p+KjxGLFTXlk/sp8/LYHoo6+EJUrXKfGQ4c6uKWS
 Rd8HESFtX/ai/gCSYbpKJkSLtf64cJ088885jL/kriws/hCCgihu85QAf+FF4Tl9byWE
 gviA==
X-Gm-Message-State: AOJu0Yy4kgqblvnbvX8KWrp5rexg89pCZVnpvOD+O0c5DEd+wBKMtuzC
 dk9LBqCmDjEVBXB4CP3SzhJG2p79CMSrDUGLGAtwSfSZtD1m2a9F8UM47myM7TM=
X-Google-Smtp-Source: AGHT+IFHQ/dZD7WGxDrFTSXeGUR5Sg0HqRiNj14xNnGeSJzR9gw3EQqy/hhfMd7dDIaTMrdQTRNilw==
X-Received: by 2002:a50:cb8b:0:b0:5c2:5cf1:70e2 with SMTP id
 4fb4d7f45d1cf-5c8824f24b0mr9575280a12.20.1727702695103; 
 Mon, 30 Sep 2024 06:24:55 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88245fbeasm4484786a12.54.2024.09.30.06.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:24:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] mtd: rawnand: brcmnand: Add BCMBCA support
Date: Mon, 30 Sep 2024 15:24:52 +0200
Message-Id: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKSm+mYC/x3MQQ5AMBBA0avIrE1SNISriEWnHcxCNS0iEXfXW
 L7F/w8kjsIJhuKByJck2X1GVRZgV+MXRnHZUKtaq75RSHYja9Ab7zCdIezxQK11x1XXEpGDXIb
 Is9z/dZze9wPBQQkNZQAAAA==
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
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
Linus Walleij (4):
      mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
      arm: dts: bcm: Update bcm6846 and bcm96846
      drivers: nand: bcmbca: Enable on BCM6846
      board: bcm96846: Enable NAND options

 arch/arm/dts/bcm6846.dtsi                   |  34 +++++++
 arch/arm/dts/bcm96846.dts                   |  14 +++
 arch/arm/mach-bcmbca/bcm6846/Kconfig        |   3 +
 configs/bcm96846_defconfig                  |  12 +++
 drivers/mtd/nand/raw/Kconfig                |   7 ++
 drivers/mtd/nand/raw/brcmnand/Makefile      |   1 +
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 152 ++++++++++++++++++++++++++++
 7 files changed, 223 insertions(+)
---
base-commit: cd87faf0067493f97b3c0c83daccb2dc124fdd42
change-id: 20240930-bcmbca-nand-support-4447e176bbbd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

