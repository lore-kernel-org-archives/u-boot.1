Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DDECD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 23:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E2B88035;
	Wed, 27 Mar 2024 00:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ld3/XN/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFA388035; Wed, 27 Mar 2024 00:35:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5937487D9B
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 00:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab23=LB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1711496109;
 bh=TV9G6kJ9pxv28uMo676yBtfXY2PDJCVXLRvcgVTtgfY=;
 b=Ld3/XN/JYMFQVBz+jjPjFFaIt4PS65hbmbYeIhNP4yC7xv2l9RAWxPgT1y6jVmKdHdHbABwwM
 cxaGL2xaG1LF3gYK5BvHs0NVyXXoNntyfCcL9TFVyc/ZtTLtaQyvdGgKbGP0Ll03FxhB5fwjBni
 CpXpBOto7EHz/p6jlmAu/Ghq81O7dGC8Cdaagv88+66aVMcuDLtGiRTme5a7IDuNLj1zPGqUFuk
 F9sxD2x9ISBu+V/FJY92n1df3/dLb/dPMFzpSTAcgIRVNtK+GJjXBkTrSJN3JNaNpkB9nx4PaTZ
 ggQQGj44sjpnF6V9IGfYdCGf9TGhmxRaEarMb7tD3/0Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] mmc: rockchip_sdhci: Revert 4 blocks PIO mode read limit for
 RK35xx
Date: Tue, 26 Mar 2024 23:35:00 +0000
Message-ID: <20240326233502.2625015-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66035bac486fd343c7f8a81d
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

The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
read in a single command") introduced a limit of number of blocks to
read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
affect of significant slowing down reading FIT from eMMC.

After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 mode
by default") the limit of number of blocks to read workaround is no
longer necessary and a Data End Bit Error is no longer happening using
PIO mode.

Revert this limitation to allow reading more than 4 blocks with a single
CMD18 command in PIO mode and speed up reading FIT from eMMC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This is a replacement for the prior [1] "mmc: rockchip_sdhci: Use bounce
buffer in SPL to fix read performance" patch.

[1] https://patchwork.ozlabs.org/patch/1895377/
---
 drivers/mmc/rockchip_sdhci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 706fb1235796..45587222a230 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -598,16 +598,6 @@ static int rockchip_sdhci_probe(struct udevice *dev)
 	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
 		host->flags &= ~USE_DMA;
 
-	/*
-	 * Reading more than 4 blocks with a single CMD18 command in PIO mode
-	 * triggers Data End Bit Error on RK3568 and RK3588. Limit to reading
-	 * max 4 blocks in one command when using PIO mode.
-	 */
-	if (!(host->flags & USE_DMA) &&
-	    (device_is_compatible(dev, "rockchip,rk3568-dwcmshc") ||
-	     device_is_compatible(dev, "rockchip,rk3588-dwcmshc")))
-		cfg->b_max = 4;
-
 	return sdhci_probe(dev);
 }
 
-- 
2.43.2

