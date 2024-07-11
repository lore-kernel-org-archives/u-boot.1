Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B0C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 20:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106E7885EB;
	Thu, 11 Jul 2024 22:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pX6VJV+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5493885EB; Thu, 11 Jul 2024 22:08:22 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95EF87D07
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 22:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C1FB7CE0121;
 Thu, 11 Jul 2024 20:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DD2C116B1;
 Thu, 11 Jul 2024 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720728498;
 bh=4zil9h1UsLiaMNhLCtqbBLTWljsAfEGZZx3OScPXxGQ=;
 h=From:To:Cc:Subject:Date:From;
 b=pX6VJV+cjVbYv6S8T0qDN0ePu0NtiR1Xx/H9g3k92T3PqC/luUON0i/tRlDvThbSz
 gvjizFvr6XN5E6YCIb0EhU8FVNr7kXdR5NVx2u2Jb9H1t3IINo4bRKyhNJZLijcSSU
 i+h5lIjJqrBvy2XXCcN3p2vjTRXxEe/OWRuQ9M87KqQ0MH+rtLj8XuyfIX/yEhkMEv
 TXUp+ic2ngKfVgVc8dp3c2qJU2+SMjUng1dGWecC2Q1KOzjbnd5UfjdlICGfEC6sFm
 jcOakqzuonQn8p0Qqhwe+SAoDpa1H0gSHSIWYQZjStQsaTIcs163pA4Z5HQa/KkRjR
 ymK9hc7yeebCw==
From: Michael Walle <mwalle@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] sunxi: board: probe USB gadget
Date: Thu, 11 Jul 2024 22:08:06 +0200
Message-Id: <20240711200806.2929452-1-mwalle@kernel.org>
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

Due to the lazy probing, the gadget driver might not be probed when the
u-boot cli is active. In this case the "ums" command won't work, for
example. If enabled, probe the USB gadget during board_init().

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/sunxi/board.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ed86f1df5dc..7f93aba9ee7 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -189,6 +189,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 int board_init(void)
 {
 	__maybe_unused int id_pfr1, ret;
+	struct udevice *dev;
 
 	gd->bd->bi_boot_params = (PHYS_SDRAM_0 + 0x100);
 
@@ -225,6 +226,9 @@ int board_init(void)
 	if (ret)
 		return ret;
 
+	if (CONFIG_IS_ENABLED(USB_GADGET))
+		uclass_get_device(UCLASS_USB_GADGET_GENERIC, 0, &dev);
+
 	eth_init_board();
 
 	return 0;
-- 
2.39.2

