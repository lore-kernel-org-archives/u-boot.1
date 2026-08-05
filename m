Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A61C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 20:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 139C2407CD;
	Wed,  5 Aug 2026 20:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PbSn5EJN2rWw; Wed,  5 Aug 2026 20:12:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8098A40435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785960775;
	bh=8syyKHikVWquhzysvWMXrf+jdNf7vnFhYy43Uqdq+VM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BF6h8CIeD5Dzn/sCdp1ONA109/iyYlZlq4tjyu61puOGwg6ldWxD8Fh3/bY5Rtybb
	 C3+G/OLCeBYGJ7C1G0oVybszP1bGW93F91L504qkZnlhVJoaX7/zXeyADRqkJ5WApE
	 UJKssfncsIH7Nc1/4DOh3/3OhHhF0XW0FTn4FqwTFmVrwYwkZi56DPHTlsnoZsWX1x
	 2kOohvs6UcsunNSvfNWjmQMJX6hLtbHmEGn/3gbx84RuszcjKrE8H4En2ibomJwpxv
	 DAiURXQRWwmRElZaNcXv6D4th994Lng9Xlz1kG/jHL2G1yfAaI86QTBlcynEocBvS/
	 qI3ieexpG9fTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8098A40435;
	Wed,  5 Aug 2026 20:12:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C52AA397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAEE880DA9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLzZ4-3DqmRg for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 20:12:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 40B6680DA5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40B6680DA5
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40B6680DA5
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 20:12:51 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a46a53abc9so864748b6e.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 13:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960771; x=1786565571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8syyKHikVWquhzysvWMXrf+jdNf7vnFhYy43Uqdq+VM=;
 b=mLNrPBGV+ElWTBJuV9lhF2ShowE81hESoOjyqG38jmhqJP9FfEWZw1PkhexKXfmYgI
 L03YsSV2Qy6nc9SOvdQ74vtMyr5GvDkz8e1TF1u0FHQwEAOK0U1k5M84+PtQpkcZkwIL
 W13XqtlbcgSdFrldsbA73gRbOLOKcgqeIY4EGGfogXafA4uplulbQQiV07opzPoNtddq
 LW8qa21qIfNqEbmxr8VDVyiTdLs2EdvBGYCb2QYcE/yrTUeS39oeL+phOa55pgQB7D1T
 BmCnnXhMMQxpvwvDE5RpEcMeQw4+aJbVBltbCfIa4EEbiBP+EhTVZAmlZc6wwTEuKwY2
 VhcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwoNHCeK+AhRg4UyJkGmSGh+W+XIq/lIGkQ/swq2f70u9Z+gkxUkky8Ordv+5wQNDRwTuz6DA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy6w7KNU0CHwtNV7J3o8yX5Tll33MFcdDCdCgGyMlHiVGdkxhEA
 JA5S5lSHH218pqbCCT3u2OfMcVzeF+wlikfhkufWuth5TrtCst2wSDr/sjoXvG+HrZs=
X-Gm-Gg: AR+sD10jgQ8zz9I6cnkluyrCALKdeo3ODtAAunhJqpEXqvOLjpkdtAl9+p+rLKepiFj
 eHVb9HCdcfmJHqkurcvvG7GHi3ACjygVywMQNkoEauSgshCUAaokFcp+PT13KTole409eiouNqQ
 pTahOJEz7pSaP0e6uNs61ZN0h1LmU68lZv0+GwvPe7yZ2+ofm++fl/zvrh4qR3Uq59pOqBpIMmi
 pxs92SOzxTmadKoEZ4xj4CZiWBi2AodB0knnc080kAdj5BXdf/XQmXNjsvDRn7Jlmd8ILbxCN9V
 XdtFNqE3EbVC0VkLo/kNf0XNSRvkSKlyZj7Q9o+aEfWAhB3itkOLOQ7ciOQAt4OTpb+shCRLQnT
 RFscbS3yyOME6FvSipvEIMKHlafUkOc27DJGKrnbLyS1WgCV/tibbh/olVuaX9w02Sg6XYzDffo
 FqnrYFU6s0HQ392g/ujsyRHowM05W2CpV68ZXvjliihfSKePOHtHuctXHZurEA6l4=
X-Received: by 2002:a05:6808:524b:b0:496:892:c58f with SMTP id
 5614622812f47-4afaddd8294mr5023704b6e.2.1785960771001; 
 Wed, 05 Aug 2026 13:12:51 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae45b630sm2949689b6e.1.2026.08.05.13.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 13:12:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL v2] Please pull mediatek-for-main-2026-08-05 into main
Date: Wed,  5 Aug 2026 15:10:33 -0500
Message-ID: <20260805201244.2615610-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785960771; x=1786565571;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8syyKHikVWquhzysvWMXrf+jdNf7vnFhYy43Uqdq+VM=;
 b=D+kO4jVSi4yDf7rmDq6l3nZasDefqL119oiBQxy3cpbXr2/D0ncrLVEZjS7k950rxh
 OEt5aDPAA77MMwvzNKfFPvay0P2nE6Be706WlTWICvknOsKgaoGvkbgc98Ec7gqv3cfK
 nLIzgaK5h3z6K4O5qRnKL6+jkaR+h2J17oqfMOC5cjhp7txPPnXWq7R5lFGQmvg0KNCN
 SQqP17pSDzltjFU6fsV16xs3lMr6F1cj6GttD2v5yiXvVGY7qrV7o/UKK/1kgAGMqJ6y
 UB+llko8Bayxhn71SCo43aWHlNjlUl7SCnBrNTBxUK3DbDvI7/hvquR8rW0aJ9Ec0okd
 6TMA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D+kO4jVS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

v2 changes:
* v1 was missing most of these patches.

The following changes since commit 616c3d79f01cf9204e38738857c4647a730dcb3b:

  ram: k3-ddrss: fix ecc range checking bug (2026-07-28 12:30:55 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-08-05

for you to fetch changes up to 6a77840b2f01e98bbad157fd1984a2dce2a3eecd:

  clk: mediatek: mt8188: fix top0 gate polarity (2026-08-05 15:05:37 -0500)

----------------------------------------------------------------
* Clock fix for MT8188 (Genio 700/520)
* SPL support preparatory patch for MT8188.
* Compile error fix for when enabling LWIP network stack on some MediaTek targets.
* Fix a regression in clock driver binding from the previous PR.
* Add display-related clocks on MT8188.
* Another wave of clock driver refactoring and de-duplication.

----------------------------------------------------------------
Carlo Caione (2):
      clk: mediatek: probe parent providers on demand
      arm: mediatek: use phase-aware PSCI reset on MT8188

David Lechner (2):
      clk: mediatek: drop probe-after-bind provider setup
      cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME

Julien Stephan (34):
      clk: mediatek: mt8188: deduplicate clock gate drivers
      clk: mediatek: mt8188: use driver data to store the clock tree
      clk: mediatek: mt7622: deduplicate clock gate drivers
      clk: mediatek: mt7622: use driver data to store the clock tree
      clk: mediatek: mt7623: deduplicate clock gate drivers
      clk: mediatek: mt7623: use driver data to store the clock tree
      clk: mediatek: mt7629: deduplicate clock gate drivers
      clk: mediatek: mt7629: use driver data to store the clock tree
      clk: mediatek: mt7981: deduplicate clock gate drivers
      clk: mediatek: mt7981: use driver data to store the clock tree
      clk: mediatek: mt7986: deduplicate clock gate drivers
      clk: mediatek: mt7986: use driver data to store the clock tree
      clk: mediatek: mt7987: deduplicate clock gate drivers
      clk: mediatek: mt7987: use driver data to store the clock tree
      clk: mediatek: mt7988: deduplicate clock gate drivers
      clk: mediatek: mt7988: use driver data to store the clock tree
      clk: mediatek: mt8183: deduplicate clock gate drivers
      clk: mediatek: mt8183: use driver data to store the clock tree
      clk: mediatek: mt8516: deduplicate clock gate drivers
      clk: mediatek: mt8516: use driver data to store the clock tree
      clk: mediatek: mt8518: deduplicate clock gate drivers
      clk: mediatek: mt8518: use driver data to store the clock tree
      clk: mediatek: mt8195: deduplicate clock gate drivers
      clk: mediatek: mt8195: use driver data to store the clock tree
      clk: mediatek: mt8365: deduplicate clock gate drivers
      clk: mediatek: mt8365: use driver data to store the clock tree
      clk: mediatek: mt8512: deduplicate clock gate drivers
      clk: mediatek: mt8512: use driver data to store the clock tree
      clk: mediatek: mt8189: deduplicate clock gate drivers
      clk: mediatek: mt8189: use driver data to store the clock tree
      clk: mediatek: remove the dedicated clock gate code path
      clk: mediatek: get the clock tree from the driver data in mtk_common_clk_init
      clk: mediatek: mt8188: add display related clock driver
      clk: mediatek: mt8188: fix top0 gate polarity

 arch/arm/mach-mediatek/mt8188/init.c |   2 +-
 cmd/ufetch.c                         |   4 +
 drivers/clk/mediatek/clk-mt7622.c    | 208 +++++--------
 drivers/clk/mediatek/clk-mt7623.c    | 117 ++++----
 drivers/clk/mediatek/clk-mt7629.c    | 167 +++++------
 drivers/clk/mediatek/clk-mt7981.c    | 125 ++++----
 drivers/clk/mediatek/clk-mt7986.c    |  66 ++--
 drivers/clk/mediatek/clk-mt7987.c    |  67 ++---
 drivers/clk/mediatek/clk-mt7988.c    | 138 ++++-----
 drivers/clk/mediatek/clk-mt8183.c    |  51 ++--
 drivers/clk/mediatek/clk-mt8188.c    | 564 +++++++++++++++++++++++++++--------
 drivers/clk/mediatek/clk-mt8189.c    | 104 +++----
 drivers/clk/mediatek/clk-mt8195.c    |  46 ++-
 drivers/clk/mediatek/clk-mt8365.c    |  45 ++-
 drivers/clk/mediatek/clk-mt8512.c    |  85 +++---
 drivers/clk/mediatek/clk-mt8516.c    |  45 ++-
 drivers/clk/mediatek/clk-mt8518.c    |  45 ++-
 drivers/clk/mediatek/clk-mtk.c       | 162 +++-------
 drivers/clk/mediatek/clk-mtk.h       |  24 +-
 19 files changed, 1061 insertions(+), 1004 deletions(-)
