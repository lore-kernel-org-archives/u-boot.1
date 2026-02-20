Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872B5C5AD6A
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 19:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3458983D3D;
	Fri, 20 Feb 2026 20:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tdHJkSfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73F583A5E; Fri, 20 Feb 2026 20:33:59 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947E283A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f04f1348cso1539047b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771616036; x=1772220836;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+D0HHfn2K0Gd48nNC7u0JmRsUd1pn76/LwW67Pb5how=;
 b=tdHJkSfIDl2gcdIAmDalxQpfbSmYzAusEBJQeBjzGpoLoXBqmWzM+UVxdc0CLmBuow
 Mz14bCiTppZ3bxGfb6KHgcniKsBYL+Ip/xxRiiRSuQLzgiGIJnk46GtCEoy7UDhB41fo
 r1EOAEsCUa4++1L700rq4jBitLk2kl5kJV1o7NVczk/Lc/RBKEKgERlXQpnJdfpt9vnQ
 n8eHlF3ynBAjlW/xXJbW+RGrxgg+c1cJfae9wrvekBWMuryIezG4//Pml6VVLf1a2Gw+
 UFl+9Y2zCFgMXrVkh/w84jbudgk2+I39KO4OUPpfgACsEiwmBiRcA8sQxJ4uw5nt7cix
 VxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616036; x=1772220836;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+D0HHfn2K0Gd48nNC7u0JmRsUd1pn76/LwW67Pb5how=;
 b=NioFpvFRRYwY28pnm+cSehEUDVtm6tJlJuwHD7vs5Sxvr8oULRKZuOfMVyDDnzxdvN
 hZQpBcxWGWFR6Zl0Cb5Gj+aRM4BQCR3P1Hrp76a75fSa3ZqUmsDs9Xg1KqcZFWhOywZQ
 DR84gAWQrj8FhTAPovplQeaoa0ZB6Entgu4V0GTpIBdBMTfBT+QzInLwrpDR8KR+bnt9
 fCwiv+gWo9s09FTcy8UyG0ZsErfSGbh3E88qMTwiGMATcudm3PlF+Yxjym/iRyO+Qn70
 hKUYEev7K1vBomJb9SgdXhZo5yl5r1Qe6qHvN6U5TZeGkK3/N3KYm8x3wxIrjOdp4f2T
 Fvig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX052vB8xxlNa5f0A5T89IzW1VBwVY3d21CsycHAGhlYy7mx3FFvPcHnX64o1Ox1gPh2BySgsk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1vHJkcmyCy44BsUVPZyJ21Kj2NNJcPXqyYDCwP9sEeaKNCLqe
 YoBZ2GqzSaP6nVZWZP8qj1E8E0wlZfjBBHHZW8vk9IjMWmG/+zdGkrYfPhBXHlB1Lec=
X-Gm-Gg: AZuq6aKc72LuixB+r3V48OONyQhrQYQUT4T47WKzO4FcLW1QRpRA6rZciy9aso7u1bX
 X6bIVje922u2V8JziVmyuWbMkk2ldq7sWpFmNNvdcS5ibJ5zM/MJ5LgZpFTEqysb2tD1Qdjv9PW
 bk/Fu7nt93QyjW3Tu9ilW6QWSYFRLQjlfFWFZQRgxphQlFz/wODiFB2uZV1wwGlnOgGKEg5e4ZY
 qYdKpLyN/G2gpRjYowgrGYEO+44wSGSTQHagJ1vuliAsKK7omuBlOs6ej4DQNEqp0zNxdMR6+bU
 pcp7ByEgG3pY03k4qvGP6Di6QDYM6i7w8C+TteJ9QyCrWgObWUViEzUnUumLlH9KJWkr48Y6EXV
 MSCutL75gd2QiLFJlmVfZ1GjgZ/GxztKUJAqHBPSN7r/CWPnFgoGqLgnaa79pMw637DuOxp7HQS
 /E2NFI/8pfybcnOixkIJ3M4v/WCnk=
X-Received: by 2002:a05:6808:221e:b0:450:5e3a:6f1a with SMTP id
 5614622812f47-4644623cbadmr690557b6e.20.1771616036161; 
 Fri, 20 Feb 2026 11:33:56 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:339f:eabc:8753:3aa4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm52370b6e.6.2026.02.20.11.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 11:33:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] power: pmic: MediaTek PMIC wrapper and regulators
Date: Fri, 20 Feb 2026 13:33:02 -0600
Message-Id: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBCF4VcJs3awjaChryJdJHFaB8nFSaqF0
 nc32OV34PwbFBKmAoPaQOjDhVNs6E8K/NPGmZAfzaA7fe10bzDUF+bAHvNXbMay5Jyk4sV678z
 kvLk5aOcsNPH6D9/Hw0LvpfXrMYKzhdCnELgOKgnPHM+R1grjvv8AgpR08pcAAAA=
X-Change-ID: 20260218-mtk-pmic-pwrap-support-3accb8fbc87b
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BcOatd4OtMH/DeeiovgPZNGLRHx+gnaiH42QBnQRmZg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpmLb/fcXRVIigq1xmo8vqRRp3DtnBxFtrSX6X7
 lDp9O3BYFCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZi2/xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AozwH/1kIhZUk9o8jFuvtWZxwXFBOoTJ45IyQFqPIDxK
 Lzn6oZvLiOsG600/b4+HuWhyo+bprsC4y1smXiK1IrDt4zxYTSE0k3pz5hG0/liavv8TTyj+tpW
 cY5Kxd+mMrRJCQFgBxX8VH36sO35hRjW1mmbWj0D9q7/epHfKJVEbDJLaxw5l3uHIlPsZnxXrdx
 ipOAR2f43IGDazQw6uH4CGKwYBmrQG/DVRSTeKxBKSGKHeCnmAhzGoGWDDMUjmgEhRsoOrAlzx0
 D1wuGp1AgVCnVl92U2uIRfbSz8PeiLKSvwM7eo8rGm+EzW79GxM8prhMxfPOMQMEVYutyjrwJvS
 HPcs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

This series is adding support for some regulators that U-Boot needs to
turn on for a few peripherals. The regulators are part of a PMIC and
the PMIC connects to a special PMIC wrapper IP block on the SoCs.

The regulator drivers are added first in the series to avoid compile
error in the PMIC driver when it is added.

This has been tested on the MT8365 EVK for the mt6357 regulators and on
the Genio 720 EVK for the mt6359 regulators. Upstream support for
Genio 720 EVK is still a work in progress, the the defconfig patch for
that will come later.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Bo-Chen Chen (1):
      power: regulator: mt6359: add driver for MT6359P

David Lechner (1):
      configs: mt8365_evk_defconfig: enable PMIC and regulators

Julien Masson (2):
      power: regulator: add MediaTek MT6357 driver
      power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver

 MAINTAINERS                                |   3 +
 configs/mt8365_evk_defconfig               |   6 +
 drivers/power/pmic/Kconfig                 |   8 +
 drivers/power/pmic/Makefile                |   1 +
 drivers/power/pmic/mtk-pwrap.c             | 896 +++++++++++++++++++++++++++++
 drivers/power/regulator/Kconfig            |  18 +
 drivers/power/regulator/Makefile           |   2 +
 drivers/power/regulator/mt6357_regulator.c | 512 +++++++++++++++++
 drivers/power/regulator/mt6359_regulator.c | 711 +++++++++++++++++++++++
 include/power/mt6357.h                     | 159 +++++
 include/power/mt6359.h                     | 225 ++++++++
 include/power/mt6359p.h                    | 230 ++++++++
 12 files changed, 2771 insertions(+)
---
base-commit: cf6aa7cf731d3b1b296802e47e9800b0d6bed65a
change-id: 20260218-mtk-pmic-pwrap-support-3accb8fbc87b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

