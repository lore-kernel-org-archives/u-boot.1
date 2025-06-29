Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF62C7EE39
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 10:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BED582EC6;
	Sun, 29 Jun 2025 12:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NYk8CUMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F1481E13; Sun, 29 Jun 2025 12:57:44 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90C781FEE
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-553b584ac96so3274630e87.1
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194655; x=1751799455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0o60fe2rNs2unfQs2xasuwUlfd5707k4whVyMsFJC60=;
 b=NYk8CUMz2nxPK3fB8z1WlAU9QU6miOoFsaTLJjS+N2fhyTLcXnvza3rGMFwzGvX05k
 KVstyEodO4NZiWvhw2IsablftWt7Yjl/IEPxExtMfekszwVMxhCySVnhyw8WM/bd4Rk1
 wmaGs6GHzvtOjmJy1gvD050kJQBx/jqdZ4Nu61BHlFFI6mY7YLPbvb1OurJ3MoSri4AK
 MBQ6G0IucoKykY3KyqfoqcF3nlsztGVBDSpSGGqMNlKHy6mm+x4S7GmLmmw4X/DCA28G
 npCTJdENnp3+kjeTZCFIH6xKSWKDQ6jABALJXin/Kuoslc1uthg0Zw/Mbes9d91lXH5m
 TLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194655; x=1751799455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0o60fe2rNs2unfQs2xasuwUlfd5707k4whVyMsFJC60=;
 b=B+RcP37Ls1i75btbHj4Pwp9pdFyOMrX9vMtxldxruAsdqQrG2BDsJb3nPz7Tkg6oMo
 xP0YLhNrEplEW8q9khlpYiaQQ7FLB23lzeonajYViz5Y5nU58Jin3aBotOyDmGSBnK0l
 C5A9mE5/9DA5dV2AE1fruhkVbqapm4ihLO4SDjN0Ntr8gjPr2AHm/EJltNjhZA4Xe85C
 eQ24e9SdLxA5OYu/spP+0dGFdl3DrEijKspKRDCLo8IzP/lz6M04hAlOgQuXMSaqoLm1
 Nw6ty7DewsLZlSKisjEbMFr20jsTxutUX7sPhIEqhdpNu5GWNk0YQcYNg3huWyz0J/u2
 Jgbg==
X-Gm-Message-State: AOJu0Yx1P+A3kneKRf0GXnJUI2A1ufMkiXiX3ihhOwRILkOPdqA2ROXM
 0WcvVFG2dv/OHPAb6+vGUWhQkN29MScuSZJ3H8LPH+kD0vYwrCJc60we
X-Gm-Gg: ASbGncuIlA7USBS1h6JBmE4QgFlrFDaBu66SZMN2mjSUoBgzNMOBDG5TiKdqLlAoSSj
 q+NruzRbf9RMJx5TpTmy5T8kpDOP5VfwFwziI+Vs6eGCWT+v0RcDml6h7ucyENxvCIcLzsYVS1b
 ARfb/UVo/lt7z1HdMI2qIPEJXrsqyukMMU3WhUHPDFsuc7zUHMM2h1+1teToRhNRIYAalThke4V
 TdmkRmg3Pze8MwQvJ8hJp0sLvEZF0MN5D1F4IrEFx1Xh/F9lBCcTTiCRh++cnq4DncO3T7kGON8
 VRgmMXGerR/15824zFuKspIaZDrO9k1Md1MZP8yJKjinGmKDWZkoSg==
X-Google-Smtp-Source: AGHT+IE7ZNMtoRAYDZ53OKcWq/mp7QSLY6gS0vzBVnlypgQ7o/sztEBE0vX84rKn5bErMWfzhnJnGg==
X-Received: by 2002:ac2:4c54:0:b0:553:ab9a:c94 with SMTP id
 2adb3069b0e04-5550b869eefmr3641395e87.6.1751194654799; 
 Sun, 29 Jun 2025 03:57:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24d32esm1092514e87.69.2025.06.29.03.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 03:57:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wang Jie <dave.wang@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Create uclass for HW AES cryptographic devices
Date: Sun, 29 Jun 2025 13:57:07 +0300
Message-ID: <20250629105711.24687-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add uclass for HW AES cryptographic devices found on some devices, like
Tegra20/Tegra30 SoC AES engine.

Ion Agorria (3):
  dm: crypto: Create AES uclass
  crypto: aes: Add software AES DM driver
  cmd: aes: Add support for DM AES drivers

Svyatoslav Ryhel (1):
  test: dm: add AES engine test

 arch/sandbox/dts/test.dts          |   4 +
 cmd/aes.c                          | 275 ++++++++++++++++++++++++++---
 configs/sandbox64_defconfig        |   2 +
 configs/sandbox_defconfig          |   2 +
 configs/sandbox_flattree_defconfig |   3 +
 drivers/crypto/Kconfig             |   2 +
 drivers/crypto/Makefile            |   1 +
 drivers/crypto/aes/Kconfig         |  12 ++
 drivers/crypto/aes/Makefile        |   4 +
 drivers/crypto/aes/aes-sw.c        | 167 ++++++++++++++++++
 drivers/crypto/aes/aes-uclass.c    | 192 ++++++++++++++++++++
 include/dm/uclass-id.h             |   1 +
 include/uboot_aes.h                | 251 ++++++++++++++++++++++++++
 test/dm/Makefile                   |   1 +
 test/dm/aes.c                      |  57 ++++++
 15 files changed, 954 insertions(+), 20 deletions(-)
 create mode 100644 drivers/crypto/aes/Kconfig
 create mode 100644 drivers/crypto/aes/Makefile
 create mode 100644 drivers/crypto/aes/aes-sw.c
 create mode 100644 drivers/crypto/aes/aes-uclass.c
 create mode 100644 test/dm/aes.c

-- 
2.48.1

