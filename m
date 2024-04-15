Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E9A88158;
	Mon, 15 Apr 2024 13:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OdyTz41V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0CE881AE; Mon, 15 Apr 2024 13:50:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BC688089
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BDD93F118
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713181851;
 bh=g4ZDHQrwCzViuB6d3L/uWL8/RNUDV5PemNg3ueszkKk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=OdyTz41VJCpzgS7A671h/JaTQpgZMfMZg2XUrN/3AmLB3UNDRBup31K/JK1LKlhP8
 qFBPQwt/dDRaZ7Nxefn3mJLahnSe6Y0N/Skj32iLb6TI6mgmZR4ezD9N8oLLpYdUUJ
 KM/nBYugagLey5g6wbn4Iwn6LDnQCrWdSV604hDR4tuuGCL4QBgGy9Qj/VnXzkr69U
 eOxVBRzsVN0Ie1NGgDDQA69bf/lHb3eLq1uovqX9LhoL7ozQwzaz3CNsrN0qgKbZvF
 8PJc1wcmIajhJHSl/r3r0t53HTM9ZLKHlOROj57ijX+6cImGiWiRm7NDncMRAc1R2f
 /c8z0PzvgbOnw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416542ed388so10165865e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181851; x=1713786651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4ZDHQrwCzViuB6d3L/uWL8/RNUDV5PemNg3ueszkKk=;
 b=JYZs9QYuAopMjZ6TfRhNFvMtEc5J3uBGcdbGR1ucj5IL0RXKTppvAsniBj4A09ZYbZ
 YZlAQyZwjttB5F1oTpESlgQnAOwPNqv+S0mH2NonjU70vxTCyBbQdqmlzILJ37ds2k8/
 zs52v4aYMj0HOIMBqFzNqOcu0iros0NDx5ayOC3Ad+kBxi2yogG/jJtg9+ruBF/FRXq5
 iHo2R27kUuXwyn0isgdTi3I2XgWezREfUaS5ZdjQWIqfYH+Oi0JqeuNHU1ZSm021e2YH
 JRF71RMWw3xTGG/KIU7mwneGo5ZNujytFojXy0GYr0r+yDGgqrZOoC/BLvxKnO+uXnpI
 Wx3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzxC7NfI6l/6H8gWoKXsIjxa3/MSzLmXuOUFwOhPQpsbNkigpHj3uhlI4kr2PmlrDKC/sNHHU0My8FfPquRbLA5sdbmQ==
X-Gm-Message-State: AOJu0YyJTi9cOIGbzKxsr2OrpiB7AFgWgKcLUKlS0m3mSlE3+/ozIndl
 EhQ7XSMiy7smYc7JHA/rBzV70SfjTu0LcyEfPQEa45rhN83RzVsj07qLmd1ZxHoP57X4fg+Zfqx
 Y6HdO4R6zxFbBbffVfaGwA5yz+whqBc/k3dLkGHfrWoaj4R3r9bszc/Dl4wm0drvxTWA=
X-Received: by 2002:a05:600c:4f96:b0:418:5d6c:43ea with SMTP id
 n22-20020a05600c4f9600b004185d6c43eamr2308635wmq.4.1713181850833; 
 Mon, 15 Apr 2024 04:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUSAg7jcPOf2QaEBwy9Vf6qLigIUz8AQNuemj+GdiS0hMflaXHmLchxZQsKmzV/zY/rZHbQ==
X-Received: by 2002:a05:600c:4f96:b0:418:5d6c:43ea with SMTP id
 n22-20020a05600c4f9600b004185d6c43eamr2308618wmq.4.1713181850429; 
 Mon, 15 Apr 2024 04:50:50 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b003469e7f5c52sm11924130wro.80.2024.04.15.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:50:49 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] board: starfive: add Milk-V Mars CM support
Date: Mon, 15 Apr 2024 13:50:31 +0200
Message-ID: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

With this series the Milk-V Mars CM board can be booted.

NVMe, SD-card, Ethernet, UART are working but not USB.

The first series Milk-V Mars CM Lite board (the version without eMMC)
uses incorrect series numbers indicating eMMC presence. For these
CONFIG_STARFIVE_NO_EMMC=y must be set to indicate that eMMC is not
present.

Thanks to E. Shattow for all the helpful discussions.
He figured out what needed to be patched in the device-tree.

Heinrich Schuchardt (4):
  board: starfive: function to read eMMC size
  board: add support for MARS CM SD
  doc: Milk-V Mars CM and Milk-V Mars CM Lite
  configs: visionfive2: enable SPL_YMODEM_SUPPORT

 arch/riscv/include/asm/arch-jh7110/eeprom.h   |   7 +
 board/starfive/visionfive2/Kconfig            |   9 ++
 board/starfive/visionfive2/spl.c              |  27 +++-
 .../visionfive2/starfive_visionfive2.c        |  11 +-
 .../visionfive2/visionfive2-i2c-eeprom.c      |  18 +++
 configs/starfive_visionfive2_defconfig        |   1 +
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/milk-v_mars_cm.rst         | 125 ++++++++++++++++++
 8 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 doc/board/starfive/milk-v_mars_cm.rst

-- 
2.43.0

