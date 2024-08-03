Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397F0C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC2488C1F;
	Sat,  3 Aug 2024 13:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DS+3hWFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542A78827D; Sat,  3 Aug 2024 13:10:37 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBEB88732
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3685b3dbcdcso5125782f8f.3
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683435; x=1723288235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NiTwnwpBp337HwnY6aNp1/TaKXlReIC1X3PX64yKRdM=;
 b=DS+3hWFpsJNRADPyMLrHy+r8+Hl0bVLXPvFoYRLoE+utM8RuSmadlRDa5ARZRmkrru
 zB49cUnCiU5Oh9FGqxyDFtV2/FvogUyztLp62ALG5qxV35zqIIG9TO1hUp2i49onw/Fc
 ZHq3uchCxVzyaH8zwYMNOiZy4UMgCGQ5RXzz5YNoZCvFOiPspqS4hP2UE5Ko+KLgwH+5
 KtakFJpzBYlKGja/pt2pbOGURAOAocKJPPN0Hw2tvkK8g2GGR+QJVzPTNzve+q97O+XP
 VEbud1pNZzKjDIDnnTpIqTX0yJ5SxaxfZjjoSaRR0Hykoeg9X8e3w7NCw3knhxF13qt2
 nVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683435; x=1723288235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NiTwnwpBp337HwnY6aNp1/TaKXlReIC1X3PX64yKRdM=;
 b=YsNkezL7+uwhjLuC+FAmBqA8UNHo/m8TILUdpysPK2axT6VYb7ba5m0+deTKjseXGD
 FCl7A100ZOpseeGj/3TqWG9XBEoKif8XHdqL8+hIMkJ8WuoR/6/OV4Qk95N+3tJOM+Nh
 X1hrQ2vLHiWYL/BWMDoCihf30SM6lSY9bpuACD1HjZWDe7zTlbpzsRFmwBkEsFObxcil
 ULDZEB0B266VjJjmd7QJCMmzQkC57KK5DlDT9NmWEydaNdjMBcSyoFX9Ekt+xZotKdwi
 DudbB3Y6Lj5LVOQlvakT/ZKairSarFDSnbb9ixJG7RzPbLPe2LRR2UHcQKS05Vn/IUzL
 Yqsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1s2zpxoCN8UlB+5zB8c5atTlHF+gEbKB1Sr6rVZV31GfYu2ueIBuoim5I++S3Ork4juNk6p3OKVgmuoW61tj/eKXydA==
X-Gm-Message-State: AOJu0YxPe++NY9n1zvGXLXc30hynmQ8XpAFz5CmV41mTCtz9iehnD8NM
 J9Tl5uND1l/I92XS78nli4gh1qzk7fxC3fpApa+0V2qmwvsd2CAK
X-Google-Smtp-Source: AGHT+IH5shavBgl1ulOiYBKOY21hQKUBrb3Le6wQpc3Ksulw135Oyato1xSbqYTQc5F+0cPCtPnANQ==
X-Received: by 2002:a05:6000:e0c:b0:368:5858:826e with SMTP id
 ffacd0b85a97d-36bbc1c27a1mr3651948f8f.59.1722683434433; 
 Sat, 03 Aug 2024 04:10:34 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 00/15] clk: mediatek: mt7986: clk migration for OF_UPSTREAM
Date: Sat,  3 Aug 2024 10:40:33 +0200
Message-ID: <20240803084050.449-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

These are all the required patches to migrate clk and correctly support
OF_UPSTREAM. This will align the clk index to upstream to support the same
clk implementation with downstream and upstream DTS.

Christian Marangi (15):
  clk: mediatek: mt7986: fix wrong shift for PCIe clocks
  clk: mediatek: mt7986: rename CB_CKSQ_40M to TOP_XTAL
  clk: mediatek: mt7986: rename 66M_MCK to SYSAXI_D2
  clk: mediatek: mt7986: fix wrong parent for INFRA_ADC_26M_CK
  clk: mediatek: mt7986: drop 1/1 infracfg spurious factor
  clk: mediatek: mt7986: add missing entry for IPCIE_PIPE_CK infra gate
  clk: mediatek: mt7986: fix typo for infra_i2c0_ck
  clk: mediatek: mt7986: rename TOPCKGEN factor clock to upstream naming
  clk: mediatek: mt7986: reorder TOPCKGEN factor ID
  clk: mediatek: mt7986: drop 1/1 spurious factor for topckgen
  clk: mediatek: mt7986: comment out CK_TOP_A_TUNER as not used
  clk: mediatek: mt7986: move INFRA_TRNG_CK to the bottom of the list
  clk: mediatek: mt7986: replace infracfg ID with upstream linux
  clk: mediatek: mt7986: convert to unified infracfg gates + muxes
  clk: mediatek: mt7986: rename CK to CLK

 arch/arm/dts/mt7986.dtsi               |  95 ++--
 drivers/clk/mediatek/clk-mt7986.c      | 658 ++++++++++++-------------
 include/dt-bindings/clock/mt7986-clk.h | 359 ++++++--------
 3 files changed, 511 insertions(+), 601 deletions(-)

-- 
2.45.2

