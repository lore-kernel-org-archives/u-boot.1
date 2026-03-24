Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1257FFEC0F1
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 18:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A8C807C0;
	Tue, 24 Mar 2026 19:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QbspRX6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BED68352B; Tue, 24 Mar 2026 19:40:30 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0C88063E
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 19:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d7f09aa39fso4553975a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774377627; x=1774982427;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZCyKKIFTfUJmNzwMRU75uRYXa31+52pbz6S6XeyINU=;
 b=QbspRX6XwATAQK7uXbu/NSkpGYx36b/J148Uxum36itjRTHK4Q6wGkChb3CtAZ1iF/
 O/kb5Q0x9pf8+ISyp9IlSDs01azgMnAKJNaOtJrFdSmOeKanRXaVSvs5ZiQQpo5O2CCZ
 tA7s7Qr4q8rYaStP0VpSEeMbnnU8RBkcLeEfu0va0youUHsgxjLkel7+Nxo+2yYVQs8e
 DASP1PMJielvJ+N6SQq/ALIubthC1DBQ/yhCuxQwQt+m3sR26KxIDmkm/MlWuefnhJI3
 FZtE+b5zs6xLDtS4JnAE8LzrygordME40ZAI1kWRPKp7hpaBCdQEPqThaQekObsLN1Z/
 ZYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377627; x=1774982427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZCyKKIFTfUJmNzwMRU75uRYXa31+52pbz6S6XeyINU=;
 b=r+mF5Ms1ukH4kFPq0c5hBhajlxlZYm4Mk7n+axFALxalyHj/eGf8g3vPP9rsABXRTx
 7/oYmcPiEeApsWMUF2jMZURnFKjwjYAgq/z2nDfpLwo/Q6gp5csSnLtTMWWUk4FSQW/+
 xzdfBPQpi7/BCkgnRL8XLxUYi0k0wPTQ2iKOuGwUq0Z6P5Yj4vO2XA5WEoXPu1m/Ylcu
 4YZOP6/AdP6odiTyixZ4zaAdgKixxUR0pHTnU0+UjZIOZwPm0vIxdCYWEo2ANCQbrf3g
 GKX9OBpHroQKKrkBJzBunsx711E9POJN/QAxze9fk/zjpSXxZ0aWfONJSILg7VULeVl0
 dtxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa9QXP69SKn2+MnJOnzr82h+VZELkBfsLDonTbLlvF7p3F0801JNhQSc2Da9oBcKiNVf4Tq6Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxAvL6639lcUUj86NIqVsoQXrw5ULPXm2J0NKz/P9rRoRgc6KUC
 72ewTujVgFwdoxlvhRSYx+I4j6UyDaq0xBJsCh7dsjHO4DmulTKbNmfxMb8IAjZpjoE=
X-Gm-Gg: ATEYQzzeJao5XkcZFCvIvXBxctKCQMG76MjGOQQ8MeCc6dEsoxXwQ/oOKYLYBhFs6L2
 SRXctCzNXXRnjdoBNaMEsq2VjhS8NzPtJHKtK9tg5f+2LxGJL1whqFXuq3Qxk6wijqjZ/CFQgdi
 CiTELfhbE+pcjg9K6MGsp2hjBJp1R7S0Pgms0ffp5/IfrYD8daBfsJhFqizfqALvh1QMLKsryz4
 WE9cyvpXqorY0E3aOQUVRtf7n0fcuB8fSYHQ/inpZdB80VVw2BKbCeI4Tb+EkSeCfbEMnpXyGMV
 WHdGi8socSQg867QFuFHDcX0+/zdieIN0GAgxw2IOc6C4k4/NJnS1yucaoQDHYicgvyqBMPT6mf
 pcJIAbVva2s14xaYLpn1zEeTNOOOKclqNjU+5sisJhsh8Sf0o3X5YKAm8QNAozSR+uUhuH4E2gr
 UIczVjScgLVHQvMUgv2LgxhbGD
X-Received: by 2002:a05:6830:82b6:b0:7d7:f158:1f44 with SMTP id
 46e09a7af769-7d9d69eac69mr264506a34.21.1774377626621; 
 Tue, 24 Mar 2026 11:40:26 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:8a85:a776:3f75:a1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7fbee2c6dsm9987889a34.1.2026.03.24.11.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 11:40:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-03-24 into next
Date: Tue, 24 Mar 2026 13:39:20 -0500
Message-ID: <20260324184019.987767-1-dlechner@baylibre.com>
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

The following changes since commit 1ffc541eafc96d5eebcf837ab892dccec3b93568:

  Merge patch series "DDR configuration refactor and 16GB dual-rank support" (2026-03-23 09:19:00 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-03-24

for you to fetch changes up to 730958e9b01801fb2be194c1281e886236f4d08d:

  clk: mediatek: mt7623: fix pericfg priv_auto size (2026-03-24 12:32:02 -0500)

----------------------------------------------------------------
* MAINTAINERS patch for new MediaTek custodians
* MediaTek pinctrl fix to allow using GPIOs on recent platforms
* The rest is a second wave of MediaTek clock refactoring to remove duplicate
  ways of doing the same thing.

----------------------------------------------------------------
David Lechner (37):
      clk: mediatek: mt7622: convert to struct mtk_parent
      clk: mediatek: mt7623: convert to struct mtk_parent
      clk: mediatek: mt7629: convert to struct mtk_parent
      clk: mediatek: mt7981: convert to struct mtk_parent
      clk: mediatek: mt7987: convert to struct mtk_parent
      clk: mediatek: mt7988: convert to struct mtk_parent
      clk: mediatek: mt8183: convert to struct mtk_parent
      clk: mediatek: mt8188: convert to struct mtk_parent
      clk: mediatek: mt8195: convert to struct mtk_parent
      clk: mediatek: mt8365: convert to struct mtk_parent
      clk: mediatek: mt8512: convert to struct mtk_parent
      clk: mediatek: mt8516: convert to struct mtk_parent
      clk: mediatek: mt8518: convert to struct mtk_parent
      clk: mediatek: remove use of CLK_BYPASS_XTAL flag
      clk: mediatek: remove CLK_PARENT_MIXED flag
      clk: mediatek: refactor duplicate *_mux_get_rate()
      clk: mediatek: mt8365: drop topckgen map
      clk: mediatek: mt8188: use ext_clock_rates
      clk: mediatek: mt8195: use ext_clock_rates
      clk: mediatek: replace xtal2_rate with struct mtk_parent
      clk: mediatek: mt7622: convert CLK_XTAL to CLK_PAD_CLK25M
      clk: mediatek: mt7623: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt7629: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7981: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7986: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7987: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt7988: convert CLK_XTAL to CLK_PAD_CLK40M
      clk: mediatek: mt8183: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8188: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8195: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8365: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8512: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8516: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: mt8518: convert CLK_XTAL to CLK_PAD_CLK26M
      clk: mediatek: remove CLK_PARENT_XTAL
      MAINTAINERS: add new MediaTek custodians
      clk: mediatek: mt7623: fix pericfg priv_auto size

Julien Stephan (1):
      pinctrl: mediatek: Add missing bind callback for several SoCs

 MAINTAINERS                               |    6 +
 drivers/clk/mediatek/clk-mt7622.c         |  323 ++---
 drivers/clk/mediatek/clk-mt7623.c         |  696 +++++-----
 drivers/clk/mediatek/clk-mt7629.c         |  403 +++---
 drivers/clk/mediatek/clk-mt7981.c         |  250 +++-
 drivers/clk/mediatek/clk-mt7986.c         |   29 +-
 drivers/clk/mediatek/clk-mt7987.c         |  124 +-
 drivers/clk/mediatek/clk-mt7988.c         |  144 +-
 drivers/clk/mediatek/clk-mt8183.c         |  599 ++++----
 drivers/clk/mediatek/clk-mt8188.c         | 2058 ++++++++++++++--------------
 drivers/clk/mediatek/clk-mt8189.c         |   16 +-
 drivers/clk/mediatek/clk-mt8195.c         | 1990 +++++++++++++--------------
 drivers/clk/mediatek/clk-mt8365.c         |  678 ++++-----
 drivers/clk/mediatek/clk-mt8512.c         |  611 +++++----
 drivers/clk/mediatek/clk-mt8516.c         |  717 +++++-----
 drivers/clk/mediatek/clk-mt8518.c         | 2117 +++++++++++++++--------------
 drivers/clk/mediatek/clk-mtk.c            |  156 +--
 drivers/clk/mediatek/clk-mtk.h            |   78 +-
 drivers/pinctrl/mediatek/pinctrl-mt8188.c |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8189.c |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8195.c |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8365.c |    1 +
 22 files changed, 5537 insertions(+), 5462 deletions(-)
