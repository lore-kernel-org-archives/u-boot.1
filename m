Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE88FC3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 17:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73ABD88176;
	Fri, 12 Jul 2024 19:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rHSq5n37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F97B887E8; Fri, 12 Jul 2024 19:15:14 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D3986E40
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 19:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E894CCE1B60;
 Fri, 12 Jul 2024 17:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D6BC4AF07;
 Fri, 12 Jul 2024 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720804510;
 bh=tuA162Lg+sUev45bw7CLK+NLi6CElPvdIby2hssLqbg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rHSq5n37oDMqfyc2JKAOw/JT9q/5jUX+k+PKIK0ApFagzRNdm9zyaCJDBMhLviWDj
 W4TsdhC/dF2FG2rNQDLOONB/sL9hLqgSbCvYWLS9ZMmduSqvN2PP7Q6N26WQgb7xWT
 igfhWW13ykhCqzZBnDQeE5TbFCzl2aJ8CP0v3R26O7hf7/N7CRzQfghJu8iPuzVnGx
 FgXqttwzq3JMg6KJhDpd2I5KMFSvgaR9T5HoCGfDUCGHAohkKEjEKa6kANqOxfH3On
 C3bFPH0RLeTVdQiQ8Rga592jkrKZnWNwvlwM4IatMDGSZNEtx944vyisR6WTlptm9G
 fjelkGVz3WrsQ==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/2] spi: sunxi: fix clock divider calculation for max
 frequency setting
Date: Fri, 12 Jul 2024 19:14:57 +0200
Message-Id: <20240712171457.3104804-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712171457.3104804-1-mwalle@kernel.org>
References: <20240712171457.3104804-1-mwalle@kernel.org>
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
index bfb402902b8..3048ab0ecf7 100644
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
@@ -256,12 +258,15 @@ static void sun4i_spi_set_speed_mode(struct udevice *dev)
 	 *
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
+	 * There is one exception if the requested clock is the input
+	 * clock. In that case we always use CDR1 because we'll get a
+	 * 1:1: ration for sun6i/sun8i variants.
 	 */
 
 	div = DIV_ROUND_UP(SUNXI_INPUT_CLOCK, priv->freq);
 	reg = readl(SPI_REG(priv, SPI_CCR));
 
-	if ((div / 2) <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
+	if (div != 1 && ((div / 2) <= (SUN4I_CLK_CTL_CDR2_MASK + 1))) {
 		div /= 2;
 		if (div > 0)
 			div--;
-- 
2.39.2

