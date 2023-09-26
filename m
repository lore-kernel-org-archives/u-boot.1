Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0910BE7E64B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 16:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE3B86DC1;
	Tue, 26 Sep 2023 18:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="L32L2FGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD11F86DB3; Tue, 26 Sep 2023 18:36:00 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C348186DA7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c02e232c48so156359341fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695746158; x=1696350958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYoyv29KmG7J2ehMuud2jHFqoTtzES4p4dgRyY4NBEI=;
 b=L32L2FGzsNL50YL/ISQxcyZpQsQ7ziQRjc6a0XTpkKclSwsJ8QdTH6L/kkkGX1HoSg
 UV69L8mTNwN7VmzvBPYQoFvGmAAkV2rx7CoR/lWremJTjEw5I1KiRJe6X07fJd542CuT
 4YTEZxtIfDWWxcCamU2w+1fM1Ym1yYQlTKCzEH5DZBqgF0aSNbKDlyvapAOUsepIn8DR
 Ry8DmitEqMUU6lQLK56dfnV/TvP5mIj/cYdQEE3/CXads+bHWreNQ9D8B3o0SOnFXGWs
 VrwQZ4JPmP3rj4zaZc0v6Fxq8BPLSiW237E6Sz3kvrd2AMk1qp8eM5iMdEYmWlHQhFBd
 v8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746158; x=1696350958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYoyv29KmG7J2ehMuud2jHFqoTtzES4p4dgRyY4NBEI=;
 b=naZWBvLvWahQMxck/g7PDqwUiCtZwHoQKsrn99fCwlnIbkjpoxfsX90Xwfjtuxd8sK
 sGhX3Hjq2JZQBOxF9iel6Gge59WFNiW8fJHKQl3lKcZWSsDnjcUtKDFUybK2qOlPac6S
 XMGfhcthmy/YdgU88pratRAKRshKgdQZ5yKpr107vl+NQdgQyxo0y8UNGlaTPGyat58v
 VXAgrnxiQrPsTOI0RXbS2JsOnfOMGkWXPA5fkMXC7wKbtorfnkCgRwj+9a/+g3dA/F6q
 GzYPfdkvC5FVNktV87wM6tozL66USIk2yPBY1emJ8C26GBhIncrPxYWgzYlcmWcGnkls
 LJ7w==
X-Gm-Message-State: AOJu0YyxS4OvZr1/5TqJIjYMeMuxnCeyMowWHIsSqAXCq5Ur49Cia0Kl
 2aU0ViRyUrRpIePQA9/+7v8tIw==
X-Google-Smtp-Source: AGHT+IHpxlzyIxvVby/M5VRpK/2CBf6wh2U7YLNxFKw89U1F8JjS65QISqO1L3YohTcOtBFpFw5vqg==
X-Received: by 2002:a05:651c:1030:b0:2c0:ff6:984f with SMTP id
 w16-20020a05651c103000b002c00ff6984fmr8382617ljm.49.1695746157762; 
 Tue, 26 Sep 2023 09:35:57 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 x18-20020a2e9c92000000b002c12630e4d3sm2698544lji.127.2023.09.26.09.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:35:57 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v2 0/3] Conclusive KSTR-SAMA5D27 support
Date: Tue, 26 Sep 2023 18:35:07 +0200
Message-ID: <20230926163510.219804-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
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

Hi all,

this is v2 of the Conclusive KSTR-SAMA5D27 support series.

Patch [1/3] now also renames the EEPROM serial number function and moves
its documentation from .c file to the .h. We should be fine doing that,
as - to my knowledge - no other part of U-Boot seems to be using this
symbol, as evidenced by the missing prototype.

Patch [2/3] is new. It is the direct result of moving i2c as a child of
flexcom (see below).

Patch [3/3] now also addresses multiple dts issues. In particular, all
node access is now being done through label references, unused nodes
have been removed, and the i2c now goes explicitly through flexcom.

Artur Rojek (3):
  common: add prototype & rename populate_serial_number()
  arm: dts: at91: sama5: Add flexcom4 node
  board: Add support for Conclusive KSTR-SAMA5D27

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/at91-kstr-sama5d27.dts           | 131 ++++++++++
 arch/arm/dts/sama5d2.dtsi                     |  20 ++
 arch/arm/mach-at91/Kconfig                    |  13 +
 board/conclusive/kstr-sama5d27/Kconfig        |  15 ++
 board/conclusive/kstr-sama5d27/MAINTAINERS    |   8 +
 board/conclusive/kstr-sama5d27/Makefile       |   5 +
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 234 ++++++++++++++++++
 cmd/tlv_eeprom.c                              |  14 +-
 configs/kstr_sama5d27_defconfig               |  80 ++++++
 include/configs/kstr-sama5d27.h               |  15 ++
 include/init.h                                |  14 ++
 12 files changed, 539 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
 create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
 create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
 create mode 100644 board/conclusive/kstr-sama5d27/Makefile
 create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
 create mode 100644 configs/kstr_sama5d27_defconfig
 create mode 100644 include/configs/kstr-sama5d27.h

-- 
2.42.0

