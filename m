Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F28ACD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA4284659;
	Mon, 11 May 2026 23:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NR+2Ect3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A0B80086; Mon, 11 May 2026 23:38:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1498B845C8
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FEED16F2;
 Mon, 11 May 2026 14:37:55 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5598A3F85F; Mon, 11 May 2026 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778535480; bh=huUaM+2jNsjuuFYu0LdBhE+OYXFSoWbfHGjyw/gu+ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NR+2Ect3BUvXRiWfJnijXhF8l4S93R9eVFTaysfpJ8bOL28BCdSrJjM4NJzg/KNRr
 K7QBOOttZPC3RSTeCZskvI4142l3d+yiIlEnqv2dN0RM/dqzX2oL3bTQTRPN75E0Xo
 nvBbcMR0HP9W9hpfoUMfYXV/Dq/ht+CkGY+EH+l8=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 1/5] spi: sunxi: add support for A523 SPI controller
Date: Mon, 11 May 2026 23:37:09 +0200
Message-ID: <20260511213713.15943-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260511213713.15943-1-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
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

The SPI controllers in the Allwinner A523/A527/T527 SoCs is very close
to the one used in the R329 and D1 generation, definitely as far as our
driver is concerned.

Add the new compatible string, but use the existing config section from
the previous SoC generation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/spi/spi-sunxi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index 08b603f04a2..4e91cf6b7fd 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -587,6 +587,10 @@ static const struct udevice_id sun4i_spi_ids[] = {
 	  .compatible = "allwinner,sun50i-r329-spi",
 	  .data = (ulong)&sun50i_r329_spi_variant,
 	},
+	{
+	  .compatible = "allwinner,sun55i-a523-spi",
+	  .data = (ulong)&sun50i_r329_spi_variant,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.46.4

