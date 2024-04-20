Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133CAC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D105788524;
	Sat, 20 Apr 2024 12:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N+NR9lcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C268288126; Sat, 20 Apr 2024 09:09:41 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A161C8811C
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so20442005ad.1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596978; x=1714201778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BfUFkPRZwVWaoDWnbKPBvHqKaLg9D5jiyn4JVT3gw5w=;
 b=N+NR9lcLZYEkMVVC6+ToXeCX63zv76DW08t1oIX8psj8iEHMX7LReh+tlAzNHoZ30s
 daZFRviAVt3OJan5FG+BLh+Q3Oz5za/NXYx3zlkRzvuX47CvG8Q4300YejRAi6P2puYj
 161PYaE+ujs8RhlDT7hyptUFHUKvTKxNHiPCC7ysWL76qpWwZ7i+KPdnqJEvkamsP4Ja
 WrgfTd53fpO1Qx/wzVMYdf/kMUNzlgrL054u+W2LhNsGVmsjs2D4CjxM4I1BfxWoZgcJ
 Acn76uetfQKRKCXoyPMBGK+bKTHfiqPExkQPx7bGQJUt7GvhQUf204wHdkqBgqdgZ52S
 vREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596978; x=1714201778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfUFkPRZwVWaoDWnbKPBvHqKaLg9D5jiyn4JVT3gw5w=;
 b=UjQ6l16VhurM8tF9i9qadYZxr7KaWGusYkYrKEWPdP5NWdPJoMDPvHqi+3ZWVk7TZR
 +qwVszlZR/MrgxIiXpgm69gZDw3QSabilbsdnoOdqVrYeqm4rc4sd2kXmIwK8s61ZcbQ
 +N3kMfXYbhuwi4DO04fiYHMRahsPydCmKC8AwkJiKzMPZCi5mnjmYzmHIqEclawX3TbG
 c27kUhP2sa27hw2wm9SsVcEa108wtGAkXSyuKVsFmdmc2GgiCvzUH8LW0czpceKwsXYL
 hv0GzNMSbWd5+8/nb0xtYTkLfAumthha7Z0YhsrjG+JAen8cMC15a0IYbFWfdDX/mRsY
 ++fQ==
X-Gm-Message-State: AOJu0YyDx/H7qg4k/B+496mdJBu9+BSTAPBmPO8mx9RhrL3EvVylnQ/a
 KvHh8RKINqKXjFuoyDmZ23VLkTUPUbaBTjHa7/euoPn4xbW3H3WpNZROIy/11M8=
X-Google-Smtp-Source: AGHT+IHokWH7QJkJX77wjJ0kJB0r8NXnd7sY9/mhh8hsgJusnIicEmo8q9lzOn1uNgI3SDk42t4A1A==
X-Received: by 2002:a17:903:249:b0:1e2:58f:7ed4 with SMTP id
 j9-20020a170903024900b001e2058f7ed4mr6387460plh.5.1713596977515; 
 Sat, 20 Apr 2024 00:09:37 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170903248500b001e43576a7a1sm4443065plw.222.2024.04.20.00.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:09:37 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hai Pham <hai.pham.ud@renesas.com>, Igor Prusov <IVPrusov@sberdevices.ru>,
 Jagan Teki <jagan@amarulasolutions.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Michal Simek <michal.simek@amd.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 0/3] spi: sophgo: milkv_duo: Add spi nor flash support for
 Milk-V Duo board
Date: Sat, 20 Apr 2024 15:08:22 +0800
Message-ID: <20240420070923.9154-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

This series add spi nor flash controller driver for cv1800b SoC and enable it
for Sophgo Milk-V Duo board.


Kongyang Liu (3):
  spi: cv1800b: Add spi nor flash controller driver for cv1800b SoC
  riscv: dts: sophgo: Add spi nor flash controller node
  configs: milkv_duo: Add spi nor configs

 arch/riscv/dts/cv1800b-milkv-duo.dts |  13 ++
 arch/riscv/dts/cv18xx.dtsi           |  17 ++
 configs/milkv_duo_defconfig          |   3 +
 drivers/spi/Kconfig                  |   8 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/cv1800b_spif.c           | 321 +++++++++++++++++++++++++++
 6 files changed, 363 insertions(+)
 create mode 100644 drivers/spi/cv1800b_spif.c

-- 
2.41.0

