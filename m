Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09156FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B53F83AA9;
	Mon, 27 Apr 2026 15:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fZ42R2kL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ACB28407E; Mon, 27 Apr 2026 15:58:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9AEFA83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651EC1684;
 Mon, 27 Apr 2026 06:58:20 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218233F763;
 Mon, 27 Apr 2026 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777298305; bh=dyihYbwMvXKYdp3CZnjWD1HdmuQWHDIWFRFll7ya8jY=;
 h=From:To:Cc:Subject:Date:From;
 b=fZ42R2kLPvuMyQu18nh42i8Wo1CpbojXpL3I4eGs5qv8c1g3KlNdIarCZihgpFFVc
 wnaXX9tXUocbyaT3MXgg1A3sgkplWnpBba8SFkiSdo/NI8KcfpZi833levxqM9tYGa
 QgMTW6X5q6ywDpC8nH0mvpwXOBPEjajlOs4C1Bhc=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Philippe Simons <simons.philippe@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: [PATCH v3 0/2] sunxi: H616: DRAM: Fix TPR6 parameter parsing
Date: Mon, 27 Apr 2026 15:58:17 +0200
Message-ID: <20260427135819.2577234-1-andre.przywara@arm.com>
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

As multiple people reported, the TPR6 DRAM parameter is parsed wrongly
for the H616 DRAM setup. Fix that and clean up the confusing default
value on the way.

Many thanks to Philippe for pushing this upstream!

Cheers,
Andre

Andre Przywara (1):
  sunxi: H616: dram: drop default TPR6 Kconfig value

Jernej Skrabec (1):
  sunxi: H616: dram: fix LPDDR3 TPR6 parsing

 arch/arm/mach-sunxi/Kconfig            | 1 -
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
 configs/orangepi_zero2_defconfig       | 1 +
 configs/transpeed-8k618-t_defconfig    | 1 +
 configs/x96_mate_defconfig             | 1 +
 configs/x96q_defconfig                 | 1 +
 6 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.43.0

