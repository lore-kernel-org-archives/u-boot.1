Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99760FF6E9A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CF98410A;
	Tue, 17 Mar 2026 23:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zA7zaiho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C238414B; Tue, 17 Mar 2026 23:57:19 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15DDE8409B
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-67bd4e63606so2200977eaf.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773788236; x=1774393036;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fkeSW/82kNPZCB5lT0mgGCDKY3mDUlYVT5wSdqrngik=;
 b=zA7zaihoFA1chP5NrHmmguCXAtGrkgwMhY7aaqWqsdKeHlsJiGpzslpQOX3tdEOLGv
 VJJhDnP7yo8ttGG+TPvjAzw5u6YqRqGExcY882sZ6BinJ7vHxENBoNAcfTJCjDN4pa5o
 rHcs/N1KHtB1Exxe1ERvegf+6qeikpagRsxOwn+41dMb8XQGQbMYYyzZ3AI5GZumhXmR
 Jqt7jWQkkMEzgmR6D8as+LEwoGxztTIv1fuCa4D/HzsuQW2DJsC5+XCYJT9QIjyh014G
 HZa8zaL74tRkoW2nhvpXgWmYc5FgvqhmvQ1zNykl0kpcoPtqd1NRaXrEtpgopV7qMR0I
 ibMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773788236; x=1774393036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkeSW/82kNPZCB5lT0mgGCDKY3mDUlYVT5wSdqrngik=;
 b=TwWYSc9EmQrwv9mKpV/RWjGD3jIW/UY0PZ+NXPcOTlCINzyeuQVAa7Kq2vNJ0f9jrG
 N3V9fJzruETavnQSCNTn42adsZO+uETQZneQWHqUXaUIO5H0x3Q7zNxPO7itoyySKzXa
 s/R1YKtdKgc3BYCbXcbG5HR2ZVxndIzVrenCCKDbk4HVnGGPSUysSTo1k9NfR1HwzTM/
 OEJK5O6n/pyt0S25hchSpe+0uiQLfE9mnhEKz9tkTtVjbwrl/aACDp+lr8JRYtaM6wn4
 aO2U+5P2C8Bi57ULv4Du0c/1m2bhfMoUCuAl7yPb36XniKNey0rtQIPLClNrv3yzIqEC
 La9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPXpGU70Y/gTqVC98XRLV/RQyCBnDPJeWlojMNnDIcVw644+YEnjgov2hZgJ6w2uFlAQWi/fo=@lists.denx.de
X-Gm-Message-State: AOJu0YzYl9TUAe50bl5BViw/n09K3mG0Vq25xBopgckJ/S7r+qNuoAwY
 6ZhMpqlAbGetbBzcKmo32mDsMnaPpu2t2tbqOBQ0GhF5O77k+TQYauxRv7tkKyQPjmg=
X-Gm-Gg: ATEYQzz3NAXrfrwGk9+Ys5heuD3je+SrQWbtQMsAHuzL2kUlZ16eyRS7+PgW/hvqaAG
 EabXkCbjq6ReRpF5LcSVez62reOaVFcbkbfr3XORCSgtSuYcqNnIbf4ANELU8k0URmRBujRebZY
 NjF+zO/98bT+TPp2b2whLXuExswa/muqcAJrBHNSgUy0OnXY7+Pxewew7IhixhbOSiXaZ6D4SnR
 8eqjCPObSVjpLgZMKLz10YmNUdYFaGDzCrxzDDsqqhna0M7AzLOY2L6/BsYT/PZyg9r5C/qeoog
 0z6w9h5kg6+F7fU3jBSwKAK+/ZV/mtHnY9BXn7jA2Tq+dL5HBUrvzMIGZbD/qAXNSSubNqElpf+
 UXqCu/UejzsftezfYDF713IihjWNMc+ZLMpq2E4sD9TjpeoxAjGq+MGzZtpWpefNp4QVyBeg2Pj
 mqIT6Z+K8hXYlQ5JtnfIKR/6o=
X-Received: by 2002:a05:6820:1746:b0:67b:be3c:f8b6 with SMTP id
 006d021491bc7-67c0db2a165mr809766eaf.49.1773788235672; 
 Tue, 17 Mar 2026 15:57:15 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2cbcdb4sm1000846fac.13.2026.03.17.15.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 15:57:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-03-17 into next
Date: Tue, 17 Mar 2026 17:56:06 -0500
Message-ID: <20260317225650.900269-1-dlechner@baylibre.com>
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

The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d221:

  kbuild: strip sub_make_done from test-script environment (2026-03-16 10:41:40 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-03-17

for you to fetch changes up to 142c805d470cd02470146d6d70aa9c522d4da16c:

  clk: mediatek: set CLK_PARENT_XTAL on fixed factor clocks (2026-03-17 17:28:43 -0500)

----------------------------------------------------------------
* A fix for mt8188 clock oscillator rates.
* New driver for mt8189 clocks.
* The rest is a first wave of a larger effort to refactor and clean up the
  mediatek clocks to replace various hacks that built up over time with
  something that is easier to understand and maintain.

----------------------------------------------------------------
Chris Chen (1):
      clk: mediatek: add clock driver for MT8189

David Lechner (11):
      clk: mediatek: mt8188: fix CLK_TOP_CLK{13,26}M rates
      clk: mediatek: use correct struct type for infrasys clocks
      clk: mediatek: refactor parent rate lookup functions
      clk: mediatek: add mtk_clk_id_is_* helper functions
      clk: mediatek: add CLK_PARENT_EXT
      clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS() macro
      clk: mediatek: rename HAVE_RST_BAR
      clk: mediatek: rename CLK_DOMAIN_SCPSYS
      clk: mediatek: add MUX_GATE_MIXED macros
      clk: mediatek: move common PARENT macros to header
      clk: mediatek: set CLK_PARENT_XTAL on fixed factor clocks

Irving-CH Lin (1):
      dt-bindings: clock: Add MediaTek MT8189 clock

 drivers/clk/mediatek/Makefile                   |    1 +
 drivers/clk/mediatek/clk-mt7622.c               |   10 +-
 drivers/clk/mediatek/clk-mt7623.c               |   15 +-
 drivers/clk/mediatek/clk-mt7629.c               |    8 +-
 drivers/clk/mediatek/clk-mt7981.c               |    3 -
 drivers/clk/mediatek/clk-mt7986.c               |    5 -
 drivers/clk/mediatek/clk-mt7987.c               |    2 -
 drivers/clk/mediatek/clk-mt7988.c               |    2 -
 drivers/clk/mediatek/clk-mt8183.c               |   12 +-
 drivers/clk/mediatek/clk-mt8188.c               |   10 +-
 drivers/clk/mediatek/clk-mt8189.c               | 1746 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8195.c               |    6 +-
 drivers/clk/mediatek/clk-mt8365.c               |    4 +-
 drivers/clk/mediatek/clk-mt8512.c               |    6 +-
 drivers/clk/mediatek/clk-mt8516.c               |    6 +-
 drivers/clk/mediatek/clk-mt8518.c               |    6 +-
 drivers/clk/mediatek/clk-mtk.c                  |  279 ++--
 drivers/clk/mediatek/clk-mtk.h                  |   54 +-
 include/dt-bindings/clock/mediatek,mt8189-clk.h |  580 ++++++++
 19 files changed, 2554 insertions(+), 201 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8189.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h
