Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D20CDE001
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DA98460E;
	Wed, 24 Jun 2026 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="YIPypRh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936A684671; Wed, 24 Jun 2026 17:35:08 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F34F80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4472500e25fso598432fac.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1782315305; x=1782920105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ffFovPxRl6FAmjIG4Fw31KRg5a9K2k0YiUTRK1T98js=;
 b=YIPypRh7gPjCW2lwgK66Mkdugf/wK1FZU0522FMCAJq4FFi0g2tJog2BQJh5glJR+i
 qB7ew4Eo86atsk1ERcWFZ1tkhQz3K2Y3RtYzjfQfeEZjMGMiGmTPg+AWUaVLlJDXyHDy
 CZjpmwtS/poZ7fzhcyqrl1USi1nad+nK/B6gQuGTqDsABeawY+fCTdKuUeio6Wq5gTEW
 a2NmLPTmOenpV2BPDWHHaFi+TeKvo6604xqRq3i6rcfL90+j2TZSSJQ2PylouILjjivG
 1ShSJy3MaplGHiMxe9OB7lifaQUrO2Km2HbgDxDJRyXnq8asDi7kULkxv3vj4w4GGY0E
 nCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315305; x=1782920105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffFovPxRl6FAmjIG4Fw31KRg5a9K2k0YiUTRK1T98js=;
 b=sLp6h56zjFkC0n+jBgX4RKiZ6Ff1ojGWfxIT+zRSdmnMN+lcgF6E7orT5o7WLqVuOl
 BLPn4n72wL2ESZUPshXp4v1ERiXZJ5lwAM8Vu9u48/IWLVa4/qJf/Ljbpi79lDH6b+WL
 xRVT7kCT5E75pdhxesI+nsX/m2mTGQhcFe+uVeihRifyc1bOKLoEDDv97F1GEOdc9paz
 ojKE6Lcdqgc730JXJFKoaD5lcAc6h4qSLJQt3sstmEzapZnXY7bouKi0dkKHX1P8GokF
 Pju6YQ85eT0kWv9X4/vSxES0HowBMSjgXoPHPQU1Kx6Tfr5tzatrNZlpOrJIiUuvSngR
 BSJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ron6sC95giHODVLhhw9rjLtk6a2dfClB093af+Ri/5KiFlfBjDrmMDFwda/Je9xuDOgk7IFNsU=@lists.denx.de
X-Gm-Message-State: AOJu0YwupXqRiX73SPZ82azpHOA7uar3bZNskAocT6qiohTTkDiz7k8T
 lS6sodN/GMRQeSMQM40yyKG+xvJcFyNsOkKFObxRjJp6kak7WT7fW/g6mxj5wUCQriE=
X-Gm-Gg: AfdE7cmIu6mZ+P9veu/qf4IvhHa0mkK1wWO7oRBlNKa778RWV/OUnX54JS5o1zB0XYh
 3HE750weY6IltzwJH/SfGXO85ndWAkXhQAG965KABiBLqP708IREtOGsMXhXa2YqPj/F9vFA3fv
 8e4SvtUDyLpu+Davtrus/LyDYWB60y76ZkPGC88B39Gc7IXjTEiGvf8GzWBpRqjxdxad2JYjpjE
 8sdjB+l5ZJnG+e18BUM+f//UYhWrmfwLP8MRrD6kNcqL14Bcpm/hbVMV4plnE5aIChp4vPKB12W
 azWNEU8WS2UWOwhdeYB5L9DzgXs6veKigu6PFaDWaJnMFK07rWyJdnx4hv82pLxzrLUAAC1hhof
 9sprXlgkcz5eYol9gTPAgepofPcsUlzrJD3gXKYG3kKdQIgaZc3jHnwuWUIeOklvaXw2MbKMvlu
 ZOchfqsFFUKcWUKrQUv9Lxsirs8w==
X-Received: by 2002:a05:6870:3268:b0:447:4c65:d956 with SMTP id
 586e51a60fabf-447dc40eca4mr2728783fac.0.1782315304775; 
 Wed, 24 Jun 2026 08:35:04 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472eccfa68sm9883118fac.5.2026.06.24.08.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:35:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-master-2026-06-24 into master
Date: Wed, 24 Jun 2026 10:31:53 -0500
Message-ID: <20260624153501.313881-1-dlechner@baylibre.com>
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

A few late fixes. One that we've been waiting a long time to finally get into
devicetree-rebasing so we could cherry-pick it and the rest is to fix a
regression that was reported a few weeks ago.

The following changes since commit fcda974e36033ad5331a9b4a4a551af4e141ad7d:

  arm: aspeed: Fix AST2600 SPL external DTB alignment (2026-06-23 10:41:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-master-2026-06-24

for you to fetch changes up to b4fa246a1565aa63375de06b732c6d1eb1f82d27:

  arm: mediatek: mt8512: fix gd->bd->bi_dram[0].size (2026-06-24 10:06:16 -0500)

----------------------------------------------------------------
* Cherry-pick upstream devicetree fix for duplicate regulator names.
* Fix regressions due to recent mach-wide cleanups accidentally changing
  gd->bd->bi_dram[0].size.

----------------------------------------------------------------
David Lechner (9):
      arm64: dts: mediatek: mt6359: give regulators unique names
      mmc: mtk-sd: select LMB_LIMIT_DMA_BELOW_RAM_TOP
      net: mtk_eth: select LMB_LIMIT_DMA_BELOW_RAM_TOP
      arm: mediatek: mt7987: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt7988: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8188: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8189: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8195: fix gd->bd->bi_dram[0].size
      arm: mediatek: mt8512: fix gd->bd->bi_dram[0].size

 arch/arm/mach-mediatek/Kconfig              |  2 --
 arch/arm/mach-mediatek/mt7988/init.c        | 10 ++++++++++
 arch/arm/mach-mediatek/mt8188/init.c        |  4 ++--
 arch/arm/mach-mediatek/mt8189/init.c        |  4 ++--
 arch/arm/mach-mediatek/mt8195/init.c        |  4 ++--
 arch/arm/mach-mediatek/mt8512/init.c        |  4 ++--
 arch/arm/mach-mediatek/tzcfg.c              | 22 +++++++++++++---------
 board/mediatek/mt7987/MAINTAINERS           |  1 -
 board/mediatek/mt7988/MAINTAINERS           |  1 -
 drivers/mmc/Kconfig                         |  1 +
 drivers/net/mtk_eth/Kconfig                 |  1 +
 dts/upstream/src/arm64/mediatek/mt6359.dtsi |  4 ++--
 include/configs/mt7987.h                    | 14 --------------
 include/configs/mt7988.h                    | 14 --------------
 14 files changed, 35 insertions(+), 51 deletions(-)
 delete mode 100644 include/configs/mt7987.h
 delete mode 100644 include/configs/mt7988.h
