Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABECC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 13:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BC286F1C;
	Sat, 11 Nov 2023 14:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h1z7ZGLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCAE986F40; Sat, 11 Nov 2023 14:35:03 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2C786EF6
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 14:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507973f3b65so4146597e87.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699709700; x=1700314500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nJf6kIkbr+F5PCOidfJLrjL1YS3XUGsz96YErNYFtv8=;
 b=h1z7ZGLuM8zdp74NEaBiZqrnpd+8co8Uy0+qgd2dBatQ5hrQuUqp1L92YZNlOf2I6s
 SjAcjtvTIViFVOlcRwq+l5aJtkM2hdCfM2wNDzlJnvjSfEjyux4brKkeRr3dV8aoIXSc
 KlzKjYTHVurHQ6NgixfH5Qtw/iPmSBGEKCxMeJ14zvrJuNbhUtkX7ItCrXZWxDVwOLqd
 /WU7qmkBHFZ9Li9OP2tsWYUug2QVcfdg36ie6Tnn75UoF0x3KFDVDDdKWuODBGN16uy7
 h1hc04/V5Srl4RzuQ4IlupVMYJtb4m63KMdbh2Wl52NUBe2AIEHt4r1ZlRpArpQJncL0
 EpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699709700; x=1700314500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJf6kIkbr+F5PCOidfJLrjL1YS3XUGsz96YErNYFtv8=;
 b=pcVMUt2z/0ZqsTPjeVcLJQqyqjqSaHRAOwkQ2iHMx6c52JvcSQi+OOwLQgIZy/s70d
 KaX+jEw5+DaGetUv/vpmpRZNQVyKUn/cyVShZFQgd6rdZm9wjozMN37DkoRkBBDPLptJ
 DJgAv5ZQe+DgGU8PS1UOHBK2M5ZrIPvXaqGvs1lC03nJ4gfbN5fh5CtlNok7wsXPp6Os
 bjaRsk3qQVS4fjqi14v9+MJFX75T9Kfhd6S1Rk9CjM5WpMNDomr/ZlmmCSJrQN9SD5A/
 n8Hq25fHjM8HBZbRAIscnj8M7Cqb8lr58oyx2ZmfXGRN18r7XYFgB29gD4NbT9x5oBLv
 lEMA==
X-Gm-Message-State: AOJu0YwNErwnj+tg1szodOMttk+1qPUk/rkOuF8q5joa2aCSDzBV5q1e
 W7K8Z8zKlKlphMivAC5/lhdOrEr/f9mTvw==
X-Google-Smtp-Source: AGHT+IESnZ/KEibkRKq6fCcpqIcJ4HlsMjwufCj+rwsyND2PNmAMBDRwxRnT/CXVWpxxhdDjKpWsbQ==
X-Received: by 2002:a05:6512:3e5:b0:503:36cb:5438 with SMTP id
 n5-20020a05651203e500b0050336cb5438mr1121254lfq.21.1699709700057; 
 Sat, 11 Nov 2023 05:35:00 -0800 (PST)
Received: from user-PC.. ([178.134.170.122]) by smtp.gmail.com with ESMTPSA id
 h6-20020a0565123c8600b00509469ffb01sm277432lfv.193.2023.11.11.05.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 05:34:59 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Sam Edwards <CFSworks@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v1 0/2] Allwinner R329/D1/R528/T113 SPI support
Date: Sat, 11 Nov 2023 16:33:06 +0300
Message-Id: <20231111133432.755363-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This series adds support for SPI controller that pesent on
GEN_NCAT2 Allwinner SOCs (R329/D1/R528/T113).

In addition to changes in spi-sunxi U-boot driver, the series
also provides SPI controller support in SPL for R528/T113 SoCs.

Maksim Kiselev (2):
  sunxi: SPL SPI: Add SPI boot support for the Allwinner R528/T113 SoCs
  spi: sunxi: Add support for R329/D1/R528/T113 SPI controller

 arch/arm/mach-sunxi/Kconfig         |  2 +-
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 78 +++++++++++++++++++++--------
 drivers/spi/spi-sunxi.c             | 34 ++++++++++++-
 3 files changed, 91 insertions(+), 23 deletions(-)

-- 
2.40.1

