Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22954EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A60B89166;
	Wed, 11 Sep 2024 09:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H3mj7/UO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A46A891C8; Wed, 11 Sep 2024 09:11:33 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4345891C6
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so402462166b.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038690; x=1726643490; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PNUmMYvVDcaqlsiOyZtBstl8SyESzWDl+TaXv/gBnHM=;
 b=H3mj7/UOWr4ZLjZyldk1HLgt0IVffniw2SIqF0UtrOZ9dpRwFydKvexHM6Ya4SBt/X
 YYBZPhlpD2Sqcfko/WFCz0LdWOXsdJ8FhTRflhyM0IMike6f81q7T6eVffGrB5L+CFg6
 hmanL04JR5AZHv8HbTr9SdcRR4jXTCRTmMU8z0GatM0GOCAJYV1j2MnAuSrRqIirAlYj
 o7tLIQ9IXiTrk4ZqEB3CaGt6aIiAWqjesjRKxNIhszJG//shFiyzAwJgf9h0Bo1sdvoQ
 MEQYYGHG93XReIhorAy2JDk+WpGNgybaEE/NI8wSBoJwDvVBBGSdQJTX7RhQ9pNJ4joR
 WR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038690; x=1726643490;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNUmMYvVDcaqlsiOyZtBstl8SyESzWDl+TaXv/gBnHM=;
 b=e9D1q5AN91S+9bhLgSfv8easxSIzD7KuG8qjAWqjLU8TIjmWSymEZ3HNNlyQgfqG4L
 GpQRrN2f4/k2AbMAb/ZOAsE4+sbHonUi4Ehi2+ZLB9ka8h9UyCgJ0gNIdYYxCnfWwro4
 UYZMMVSedQrXhfaHPJYwDuwGdXTzLWdWzVuyMjhSoo7r+wCl25eSmzifWfjnEsih4Ilh
 t36HVkZQbueCAuPTS//I+sEJ11ZaxWN9J6BTfYjoViVH/8tudkYgacdLMYEqNPky/Qh7
 AObOcllt8pWKOU2oR9Lt89mhsJkPsFquFGfL5SSO4Ju+izTTZi+zwxEdmB5RG7XvKxh6
 36dg==
X-Gm-Message-State: AOJu0YyN9Ywhs7yLL3wYiAHCEpOaXBkMy4GT2hwI7aKmVTtBskm0nmqs
 +ze11FXhSxpRdLAm8z2558WvdvoFGFJNvPL/uRYfrCxHa90aSYIil3XNXIbHv3o=
X-Google-Smtp-Source: AGHT+IFkmckc4o3Y/BrI9LRvKzEZ0SArf9b/T2TZfHe8Sv01536GhHMq1HXeK9g1mqiKtYlf/cKuzQ==
X-Received: by 2002:a17:907:7ea4:b0:a8d:4845:de57 with SMTP id
 a640c23a62f3a-a8ffab2a19dmr341241966b.26.1726038689628; 
 Wed, 11 Sep 2024 00:11:29 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:29 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
Date: Wed, 11 Sep 2024 09:11:11 +0200
Message-Id: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9C4WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ND3aSi5Ny8xLwU3bTMitRi3ZTEpBRzUyNjg0QzYyWgpoKiVLAEUE9
 0bG0tAPAZ7qpgAAAA
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>
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

These are a number of assorted upstream Linux fixes to the
BRCMNAND driver that I have backported in an attempt to get
BRCMBCA working with U-Boot (still not there).

This patch set lowers the hamming distance between the Linux
and U-Boot drivers a bit as well, while we deviate quite
a bit it is still possible to bring fixes over thanks to
exercises like this.

The set tries to prepare the ground for the BCMBCA driver
which I have a port of which is however not yet working
as it should. This is why the read data callback is included.

These patches seem to work fine for me with my devices but
I know the maintainers have some nice test farms so try to
put these to test and see if we can merge them. I bet the
Broadcom folks has this on their TODO list anyway.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (1):
      mtd: rawnand: brcmnand: Add read data bus interface

William Zhang (6):
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix mtd oobsize
      mtd: rawnand: brcmnand: Support write protection setting from dts
      mtd: rawnand: brcmnand: Add support for getting ecc setting from strap

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 206 ++++++++++++++++++++++++-------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h |   2 +
 2 files changed, 164 insertions(+), 44 deletions(-)
---
base-commit: 5f044932413694475422d4b16607dfcf9aff8781
change-id: 20240911-brcmnand-fixes-dabd75230a63

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

