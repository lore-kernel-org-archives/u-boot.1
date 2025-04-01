Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7A3C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535A781ECD;
	Wed,  2 Apr 2025 00:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EXxevabF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D2181E6C; Wed,  2 Apr 2025 00:52:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D4580F6B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so40220475e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547955; x=1744152755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKlxrt7Rq8JN+KZVmx3yKQ7LkgGOJPWyxoeR5CljXKg=;
 b=EXxevabFbFP/KE2HZnVgGLP/4INDePVWA+0ldJ00dgO+5U8wWMo2bHLyi9MSb67/2Z
 icbFRcdX83ovqnr45rMzPO6pcMxrQDwkwlHKNoL8PhGDrplVVWdwRUMW79Xk7QLO7ztG
 7+nGPTs8L6WNzHKf+VfVe5wquROmSQgFUAPra/FbvKbnobr1by6b6lTDaEzepsQB7Yu0
 oHV/vN4xtSsdf6kE69aV7xuUFwPHAoV1jaDPbgIJyPGdwRsTs+bEmYPlDkklTqiflHjE
 lRIAQB8gcWuit/qdcT56tJmt3jYHNUMgJ5SSa4SJjWenfhdpKMER5lsg263Edk/hNeW8
 fJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547955; x=1744152755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKlxrt7Rq8JN+KZVmx3yKQ7LkgGOJPWyxoeR5CljXKg=;
 b=TS5GlcT0aOuz4M6t3AFXL6jhk871Sv+flOxSOnk31p8zeLCSA4kID1zelFfZFJfGzZ
 XvURat8m1lnqMbH3BHTqJXzASOcaTgnzOwni3t89uHugkcCRQgjXYFFHKopvzSgR87WT
 XuEbUJVLt4Sgvi+uKWs3WQdf6xmd0H2TLuI7Glheti9CQ71h7AYR8Q8zVIZu5WVVlbLA
 VHW0acdG/CxbcLl7GKxvW4vVHQPkFOQ49zmgRI9D+UUMQvK3rtLycv1H3hJ5wpST31fB
 7T+GxQW6Qw8KfNskrrgXOtk/zgBf9RnmpQ7tUc8z4evrdOHKvy2pmZz6jJ/OgVj/q4ya
 V27w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLlPYioztBf2LVoSIXHeJWIWbXQzGeM1aaqGq6XSgjwI8PVdTanWwYZr43NqYe+UBb+ytn0wA=@lists.denx.de
X-Gm-Message-State: AOJu0YwdWOTZAzdPtb+cH/sbv4waZYSBHd5+Hq8Z0f1ergLOX3vsYr5C
 j3o+nZsEWYb9gjCirYmGvqqifpGFThM8+xrmIwiy5G7PAvA8fZdv
X-Gm-Gg: ASbGncvNOarz99+HrEpnH5xB1BIUMGkOCwEwSXnsNfNnrMSWxO4F43i4lKc2GB2GTUZ
 MQiL9VI1uPsbxOc2yGqZEUBAtC+Nc84l1AC9GxytjBw/FjrTeVbbQtuqaxJHjxT2oTsfP6WHsXp
 ywJriN3pnu1Ul9xPtOzbj96GKk3hRuoLAUvitd5jklRGZP+UjDAkBS9lzkyt2XY9Kxs20MwISXa
 UAazEzUZmag9CIXQUp80f4CFHhy7cvm7lfW2pMNad40ItUpqxxkx3Q6tc0sM9uO8VEB6doET5fn
 +r9Vw34P7GCb0JJlrJYO7oPBu0WL2b+5R92LBun99hCq5OMEhOlE+UPkl7VBvbmP5IOF2JPaBPd
 6NWtPTszE9U+vDg==
X-Google-Smtp-Source: AGHT+IFcmXQvDHZiqQD/mDlK4KEa1Y7oHqMXRC8REnclD0QZC8V1jiVvyFGAJKIyqxEJEIYR8XwvDw==
X-Received: by 2002:a05:600c:458b:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-43db624b447mr138748615e9.16.1743547954486; 
 Tue, 01 Apr 2025 15:52:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 00/14] airoha: add support spi/mmc/ethernet
Date: Wed,  2 Apr 2025 00:51:32 +0200
Message-ID: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

This is continuation of the initial patchset for airoha
support.

Some are trivial fix for spi.
A new concept to setup SPI from detected NAND.

Sadly DTS node still need to be merged upstream so we
are currently adding them to u-boot dtsi and it's planned
to be dropped once they are accepted in upstream kernel.

Christian Marangi (14):
  arch: arm: dts: an7581: add Chip SCU node
  net: airoha: Add Airoha Ethernet driver
  airoha: Add Ethernet config to defconfig
  arch: arm: dts: an7581: Add Ethernet nodes
  mmc: mediatek: permit to also build for Airoha arch
  arch: arm: dts: an7581: Add eMMC nodes
  airoha: Add eMMC config to defconfig
  regmap: Add regmap_set/clear_bits shorthands
  spi: drop unneeded spi.h header include from spinand.h
  spi: Introduce setup_for_spinand()
  spinand: call SPI setup_for_spinand if supported
  spi: airoha: Add Airoha SPI NAND driver
  arm: dts: an7581: Add SNAND node
  configs: airoha: an7581_evb: Enable Airoha SNFI SPI config

 arch/arm/dts/an7581-u-boot.dtsi |   90 ++
 configs/an7581_evb_defconfig    |    3 +
 drivers/mmc/Kconfig             |    2 +-
 drivers/mtd/nand/spi/core.c     |   18 +
 drivers/net/Kconfig             |    8 +
 drivers/net/Makefile            |    1 +
 drivers/net/airoha_eth.c        | 1448 +++++++++++++++++++++++++++++++
 drivers/spi/Kconfig             |    9 +
 drivers/spi/Makefile            |    1 +
 drivers/spi/airoha_snfi_spi.c   |  717 +++++++++++++++
 include/linux/mtd/spinand.h     |    2 +-
 include/regmap.h                |   28 +
 include/spi.h                   |   11 +
 13 files changed, 2336 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/airoha_eth.c
 create mode 100644 drivers/spi/airoha_snfi_spi.c

-- 
2.48.1

