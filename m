Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A1C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 21:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4A580214;
	Thu, 23 Jan 2025 22:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="K3HefVF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1625F80243; Thu, 23 Jan 2025 22:49:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B11780087
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 22:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1737668947;
 bh=UimDi1/PhjVqv300D8Ywt7sYHVuJncNdnZaZIWTb658=;
 b=K3HefVF14l7BtpFvGNMBN/FKmDO1aD4S4cH/fmeHaRB+zhxUqqPpXY5FiykEGHNcY32l5C+iK
 yRF6iTMx7k76V32toQspSD0FW3HAud74nQ3G3tAJ0hbeaFphZc6ZbgdSGwr0gTfoyGmdsZkiwtB
 PRhrrfdsRXWfIiuPNvibJRkrK8KJbKIzkNpDR9qI3o1SSIaM3RJwNKQ5VPKiA65XgFnwmLSsdsk
 AWyYNl+zQkrrk4vi7IGZbHllS/m22UQ7jsjCgjplykLpdxdm60A8jTFV9TpNB5sZbxD7r8C/zzh
 yFU18NVWk8qZlA5TDKAp74y6SevFYNgyre/hapTAcjsw==
X-Forward-Email-ID: 6792b94a558c5134dca368fd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] mmc: sdhci: Fix possible Synchronous Abort using PIO mode
Date: Thu, 23 Jan 2025 21:48:48 +0000
Message-ID: <20250123214850.3085559-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

When MMC_SDHCI_SDMA=y or MMC_SDHCI_ADMA=y and PIO mode is used
dma_unmap_single() is called on an unmapped address, 0x0. This may
result in a Synchronous Abort:

  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  CMD_SEND:16
                  ARG                      0x00000200
                  MMC_RSP_R1,5,6,7         0x00000900
  CMD_SEND:18
                  ARG                      0x00004005
  "Synchronous Abort" handler, esr 0x96000147
  elr: 00000000400015bc lr : 0000000040012b4c
  x 0: 0000000000008000 x 1: 0000000000092600
  x 2: 0000000000000040 x 3: 000000000000003f
  x 4: 0000000000000030 x 5: 0000000000000001
  x 6: 0000000000000001 x 7: 0000000000000000
  x 8: 000000000000000a x 9: 0000000000000090
  x10: 0000000043dffc68 x11: 0000000043c00440
  x12: 0000000043c00440 x13: ffffffffbfe00000
  x14: 000000000000031c x15: 0000000240000000
  x16: 000000004001145c x17: 0000000000000032
  x18: 0000000043dffef0 x19: 0000000043c00000
  x20: 0000000043dffbc8 x21: 0000000000000000
  x22: 00000000000f3d95 x23: 0000000000000002
  x24: 0000000000000493 x25: 0000000000092600
  x26: 0000000000000001 x27: 0000000000000001
  x28: 0000000000000008 x29: 0000000043dffab0

  Code: d2800082 9ac32042 d1000443 8a230000 (d5087620)
  Resetting CPU ...

  resetting ...

Fix this by only dma_unmap_single() when DMA mode is used and
sdhci_prepare_dma() has been called to map host->start_addr.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mmc/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 4833b5158c79..dc7f0724a7b6 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -177,8 +177,10 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
 	} while (!(stat & SDHCI_INT_DATA_END));
 
 #if (CONFIG_IS_ENABLED(MMC_SDHCI_SDMA) || CONFIG_IS_ENABLED(MMC_SDHCI_ADMA))
-	dma_unmap_single(host->start_addr, data->blocks * data->blocksize,
-			 mmc_get_dma_dir(data));
+	if (host->flags & USE_DMA) {
+		dma_unmap_single(host->start_addr, data->blocks * data->blocksize,
+				 mmc_get_dma_dir(data));
+	}
 #endif
 
 	return 0;
-- 
2.48.1

