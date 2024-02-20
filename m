Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA9EC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B738A87FB8;
	Tue, 20 Feb 2024 09:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o5k9jY6W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bnd3o71+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBB587F9F; Tue, 20 Feb 2024 09:39:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBB687F8D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TfCVW5g09z9snY;
 Tue, 20 Feb 2024 09:38:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qeG5R0482QLv9LMvMH2cfpK0uRJDm4M8DBGlt8onVAI=;
 b=o5k9jY6W+ypPUy+TBGW7xQOFezyiWGDs1GXtxMcAwl6Y2oIMt7RBh2CinkYqIyvJoZ/bnw
 4io86IfschixTtoBGLYs0NNJgaONehQzUmoQe7JPqYSCDQ/jQNqtsu87y8r99cLEgyKbyb
 jjYMglybbZ6jNal0M92UwSylYzfZlwgsT0f/QHxZ2OVc2jRcYPJFwi1RF8IkkDhiaVJSwd
 pXuElIJ9dejc0splcUbN4nM/VGRxAHy7/RlnqnkSCiVaTnlWPQR4Qz7DecQOc3z39pUTvs
 RplZHwu71Qg/SndG5vNbaOmnts9kSyvK7p+2E6HCBdRHm0XFtMO6sw+qqNP9GA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qeG5R0482QLv9LMvMH2cfpK0uRJDm4M8DBGlt8onVAI=;
 b=bnd3o71+pI+YePYotMSN8YdBZhZ4+0phwY4bAucozAPNWxHD/iH4ldoSwGv866EfTjEDL8
 /3/jDJArVWp6mS49dJHvTr+UkLVSMCFqzTqW8F4t8pRv4DJ9vhP18U4rlaOHqXMboo0byb
 gWPKtfjbN3lHNsGyImAnQ/3pZBZmysHlCAaajEUO/P6DaqJ8pUZ4ccRlfwwYPuMEc1OUFi
 6Zbz9Aq3Fgi/CGFt+NtUlKShaDh9QILYAQPLS09C3apUuUFJ7vND/ZKENBTDNQAjxczhJE
 j3EkSiJKIro3gGm/GPAoAjC31FnqB78LtQBvG6XZhipgThyiwNLc0RKPK5L7wQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] mmc: tmio: Check INFO1 for completion during DMA transfer
Date: Tue, 20 Feb 2024 09:38:14 +0100
Message-ID: <20240220083827.34473-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 50b421bb4776fd8fdcf
X-MBO-RS-META: wrfd5uqbyuqh8s9o1pnytgfggn3p16mz
X-Rspamd-Queue-Id: 4TfCVW5g09z9snY
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

In case a CRC error occurs during DMA transfer, the transfer completion
flag is not set in TMIO_SD_DMA_INFO1 and the transfer would eventually
time out. The timeout could be very long in case the transfer consists
of a large amount of blocks, the base timeout is 10 seconds and every
block adds 100 us more.

In case a CRC error does occur, a completion flag is set in a different
register, TMIO_SD_INFO1. Use this other completion flag to detect DMA
transfer ended and stop waiting for TMIO_SD_DMA_INFO1 completion flag.
This reduces the lengthy timeout in case of an error. The unconditional
check of TMIO_SD_DMA_INFO2 register for DMA related errors must not be
skipped in any case to actually recognize the DMA error and report it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/tmio-common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
index 890c496b535..719c4830bc3 100644
--- a/drivers/mmc/tmio-common.c
+++ b/drivers/mmc/tmio-common.c
@@ -299,7 +299,13 @@ static int tmio_sd_dma_wait_for_irq(struct udevice *dev, u32 flag,
 	struct tmio_sd_priv *priv = dev_get_priv(dev);
 	long wait = 1000000 + 10 * blocks;
 
-	while (!(tmio_sd_readl(priv, TMIO_SD_DMA_INFO1) & flag)) {
+	for (;;) {
+		if (tmio_sd_readl(priv, TMIO_SD_DMA_INFO1) & flag)
+			break;
+
+		if (tmio_sd_readl(priv, TMIO_SD_INFO1) & TMIO_SD_INFO1_CMP)
+			break;
+
 		if (wait-- < 0) {
 			dev_err(dev, "timeout during DMA\n");
 			return -ETIMEDOUT;
-- 
2.43.0

