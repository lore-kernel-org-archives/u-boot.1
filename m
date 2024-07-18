Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8DCC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 20:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A12088B19;
	Thu, 18 Jul 2024 22:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jo9R8rrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCC28859C; Thu, 18 Jul 2024 22:43:10 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2535885F1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 22:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CD0C2CE1AC0;
 Thu, 18 Jul 2024 20:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FADCC4AF0B;
 Thu, 18 Jul 2024 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721335386;
 bh=gZ+COJ2VUsvaZRqOD7Elg7+VPVWt9kfwLQVtvM4HI0I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jo9R8rrkUmX2uffPhSiMj8vRN34C6H9ns3th5qI4BssOKw9oqNL3ahJe4p/kHgDxt
 ntnSdfoAfLD8x0SZpzvPWD8qycW45UBN7DWTMO0+KR9FPHqVyVU7gmJLkThtrRJEMc
 c7EnmUnrJvkwwb+mgTVeRpEv/VLO6QHFgC6elPNmb6bxZCqRTYw4pHeRPRhuzRKo2/
 UCD10swfighECtARxT/jKRdbnUXKSPp509bbJ7gEUpDM2kN5cUGFFlWryQ2ouhJzD3
 38p+ObI4G4GoWjkE1D75s9IlfM+KqHP97Jxok5MSRpf4YdIRgERS3uQoQuAb0QPPrz
 J/1QM/Z1vmDig==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 2/2] spi: sunxi: fix clock divider calculation for max
 frequency setting
Date: Thu, 18 Jul 2024 22:42:53 +0200
Message-Id: <20240718204253.1180233-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718204253.1180233-1-mwalle@kernel.org>
References: <20240718204253.1180233-1-mwalle@kernel.org>
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

If the maximum frequency is requested, we still fall into the CDR2
handling. But there the minimal divider is 2. For the sun6i and sun8i we
can do better with the CDR1 setting where the minimal divider is 1:
  SPI_CLK = MOD_CLK / 2 ^ cdr with cdr = 0

Thus, handle the div = 1 case specially.

While at it, correct the comment above the calculation.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/spi/spi-sunxi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index f110a8b7658..81f1298adea 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -249,6 +249,8 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
 	 * We have two choices there. Either we can use the clock
 	 * divide rate 1, which is calculated thanks to this formula:
 	 * SPI_CLK = MOD_CLK / (2 ^ (cdr + 1))
+	 * Or for sun6i/sun8i variants:
+	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
 	 * Or we can use CDR2, which is calculated with the formula:
 	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
 	 * Whether we use the former or the latter is set through the
@@ -256,13 +258,16 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
 	 *
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
+	 * There is one exception if the requested clock is the input
+	 * clock. In that case we always use CDR1 because we'll get a
+	 * 1:1 ration for sun6i/sun8i variants.
 	 */
 
 	div = DIV_ROUND_UP(SUNXI_INPUT_CLOCK, priv->freq);
 	div_cdr2 = DIV_ROUND_UP(div, 2);
 	reg = readl(SPI_REG(priv, SPI_CCR));
 
-	if (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
+	if (div != 1 && (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1))) {
 		reg &= ~(SUN4I_CLK_CTL_CDR2_MASK | SUN4I_CLK_CTL_DRS);
 		reg |= SUN4I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN4I_CLK_CTL_DRS;
 	} else {
-- 
2.39.2

