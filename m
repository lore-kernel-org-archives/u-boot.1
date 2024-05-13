Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6724CC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 20:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C172C87E30;
	Mon, 13 May 2024 22:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kuLThESt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B63987C69; Mon, 13 May 2024 22:56:42 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56DF87E30
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 22:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1D780CE0FF7;
 Mon, 13 May 2024 20:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E04C32786;
 Mon, 13 May 2024 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715633796;
 bh=m50YoF4RVQNlKMsHFidjWk5b/jwLwWPvGIFHy1kZQac=;
 h=From:To:Cc:Subject:Date:From;
 b=kuLThEStUDvwYb+EDX+IBVcrFs9KTeRj6qYroFwtaKLCHhT9YPSMCwYBzy0bdOZur
 buBvIxxBCkPhMFFbZiR9fP8qPHqRasMWJu202v3vjz0f0wbzPFq3f3NWebK37+oBPG
 JaTyjLmMr/sl8dyiqOb0Fdk/0RSc1v5M3X28J2ezuOZeIRNRkFnUHaXRgDAIzWL7DD
 RvTVA95wmd4oSXQGP9Adtc80r0PBFTEiz/9mUULC3KcfCcgQ0Ld7kTDIArbK0nUW6X
 GjzWpIddIf99iTI/YGLPG5y8j2NhnYq0DogrjIUbBN8JcHmd6RtKWTa0+SzWwyPRok
 6AN3k1ecOCUOg==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/2] sunxi: v3s: add network support
Date: Mon, 13 May 2024 22:56:07 +0200
Message-Id: <20240513205609.1872861-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Add network support for the V3s which only supports the internal
PHY. Adding support was straight forward. The emac driver just needs
the compatible string and some platform data and the clock driver
needs to know the bits for the clock gating as well as the reset
bits.

This was tested on a custom board.

Michael Walle (2):
  clk: sunxi: add EMAC and EPHY clocks and resets for the V3s SoC
  net: sun8i_emac: add support for the V3s

 drivers/clk/sunxi/clk_v3s.c | 6 ++++++
 drivers/net/sun8i_emac.c    | 7 +++++++
 2 files changed, 13 insertions(+)

-- 
2.39.2

