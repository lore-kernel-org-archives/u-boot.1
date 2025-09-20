Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03B9CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 14:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42C1832DA;
	Sat, 20 Sep 2025 16:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mILx92nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AE583211; Sat, 20 Sep 2025 16:37:05 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C838004F
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so512317f8f.0
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758379023; x=1758983823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GdRpNyMmJR58NhEZdMBNzwbqbBxrsNkDNaO8dFKgOAA=;
 b=mILx92nWq+c8x7PI6eIvtCp/wxCMNycQIGI9bYwXr+bj9DjdQzWSFemEEIlRpwcb6k
 bQbuvuV9EVyLl7BJ9T79fqP008SuLzEaIzpkMLByTppedBLvGWBSnY+hNbh3zHyvE8/p
 DlYtSBZ+ydOQ50dzH1L/2ujaD3A33fHYjYv1JM7qaq7BJ2rQ0zfO0UD4/PYtDqH9KabF
 oLpTML+Rcvp3mkOxpw+iGLhxirwfr4eLUdGLS9ssgcoSoOe6hpQ5MTmmP1GjZGMwzdRT
 1bbLxXO0zySBAgSfVVR7+C/GyR31H9kzMRGBJ9NqOHxYMAVpOs92/KPx4ChVSvVNT990
 hiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758379023; x=1758983823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GdRpNyMmJR58NhEZdMBNzwbqbBxrsNkDNaO8dFKgOAA=;
 b=H+ptv5ws3kR/3wuXxOihjUxaaA8ovtY15RQSqEloR16B2DKSamr0bozuwggw0A8c1g
 9hsfqlu6bUt9w5RyRg/h3BlUWFrw8sON+GCLXpKPQ6at4jAB164CmfKzJXTiGZ1bQBZI
 yaEG8ng9lmDkx9Gtfe4p2nH2MiUZCEVTPJE6duDWDXTdAaeXCNGMNQWwoYwrqGfYsTtj
 mQV4kng5W9XJljyY+SaucPoUkxzioYf24cjsmfNgqfQBzd0ghLtKYuldCr7qpt2KJ5FH
 QaP/AWw3Uvae4xZt/mg37xQ7/Wv9WvCLWWwll228VOa7ZqA/PYLRvRpeUO8xxZoUA4eS
 mx0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGX9bEQa1ENdx2ux1Ms1Vz13a6HjaEe6iNNyjEIrsOUOx6TXYzvkvQbnRCbonbzUnH10pA1hE=@lists.denx.de
X-Gm-Message-State: AOJu0YwMZtPSVsQLfwRZ7nb2E+Z3JCGjo7FmYPdLf2OpYmvV9vRUKNwp
 1sUJIDta8utem8rKe4irOlKXBI454eh+3+0ShJ3cQNkw3+pfC0l1BE9H
X-Gm-Gg: ASbGnctwRVNw59Cg8pP8N4xF4bq2cQ+DkqLA4lsGBjHCNzZ6gBU2ZWrPIhNJGQlWhqN
 QlR7TnSnBWn0Cijhs21b8oSavS4qtieiCxPCcC2qayjBPJ2VEJ0Z9QpHZMDbHNBjbaYR+HsHNg2
 yd990gahb1XIjn1VtnVS+Ay7J9BGLCrse86pGU7qUf3FLCL8T7uwg/hxr/D5c3rasxESm9SDcow
 3lPdkq+PH6yLMc2QQZn7a6rL2KBcqIniekC9x2/9i+BHrKRFkSpjleiKdOZd3eoJRA8ekOlBvJp
 4iFDZUFSTDHd19uWB0Yr0REh9W5X4k7tW8Nyrm8NhE5Du3fnPefbKKqoEDx3+jqtLNEfbdMGE+J
 H3J81j/dAT+Ga/5xeOfXwevPO+5YTfKNxkXyrD6fkM8WprqEvWsX78GX0oITMTvLwdLFwBJI=
X-Google-Smtp-Source: AGHT+IG2UiUdracUG24Sq9xF8WRSZmFHRuEPJa0WgTgz1XbaveUEi96BAyssmq8M7qzIACtfVT1IZA==
X-Received: by 2002:a05:6000:22c7:b0:3ee:15bb:72c8 with SMTP id
 ffacd0b85a97d-3ee83cabc2cmr6731843f8f.36.1758379023087; 
 Sat, 20 Sep 2025 07:37:03 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm12353716f8f.63.2025.09.20.07.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:37:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/5] net: mediatek: mt7988: various fixup + MDIO detach
Date: Sat, 20 Sep 2025 16:36:45 +0200
Message-ID: <20250920143656.29770-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
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

This series is really required for Airoha AN7581 to provide support
for the MMIO MDIO bus. But to accomplish this, rework is needed
to the current MT7531 driver to prevent additional code duplication.

While at it also multiple BUG were notice on the MT7988 driver.

The additional MDIO MMIO driver expose an internal variant
to access the function directly from a manually crafted mii_bus
but also provide DM support used by AN7581.

Christian Marangi (5):
  net: mediatek: mt7988: fix broken phy_setting config
  net: mediatek: mt7988: restore PHY page on PHY setting exit
  net: mediatek: mt7988: free allocated MDIO bus on cleanup
  net: mediatek: move MT7531 MMIO MDIO to dedicated driver
  net: airoha: bind MDIO controller on Ethernet load

 drivers/net/Kconfig            |   4 +
 drivers/net/Makefile           |   1 +
 drivers/net/airoha_eth.c       |  26 +++++
 drivers/net/mdio-mt7531-mmio.c | 168 +++++++++++++++++++++++++++++++++
 drivers/net/mdio-mt7531-mmio.h |   9 ++
 drivers/net/mtk_eth/Kconfig    |   1 +
 drivers/net/mtk_eth/mt7988.c   |  92 +++++++++++++++---
 7 files changed, 287 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/mdio-mt7531-mmio.c
 create mode 100644 drivers/net/mdio-mt7531-mmio.h

-- 
2.51.0

