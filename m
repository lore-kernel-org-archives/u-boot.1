Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFF5CEFC43
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 19:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D8D88EEF;
	Tue,  8 Oct 2024 21:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qOeBH/Qw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B2288B1F; Tue,  8 Oct 2024 21:18:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9A888EEF
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 21:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecb7=RF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1728415122;
 bh=RB+Vfo6km66Y4e9lWGgKUv5n5DwySN0S7Km6kiyZrsU=;
 b=qOeBH/Qwr8eRyki+NfzkE97MuurPdD1HSyda/6+qvs2EiTSATp3O0gzCtDbWtbWb4nUKy26jb
 upOsiX5sJverNKwBX5eHZgVF2y40kL1ym5zUaSIYu82mKB0D37OhBypfxp10PVeOiQvDGMfFhLZ
 T2G0RIeAfU18IOY0I2Qci0x8UlOCBNUYJZd2cdhSvF1Jr46+Sk+W73RhHqDcfF2G8VCKqyWrij7
 pvRMbTCjfSbIZcIChKDpDz6jZ4gABHjV+LqN4ldnXLZXq4cbsJE/5pOk+v6hz2B+pkf4Y5r/+V8
 nfBT6MeVBKteXKNhY72WuoxVZ8WHZDIl21AAjy0qhcxQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH v2] Revert "mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine"
Date: Tue,  8 Oct 2024 19:18:31 +0000
Message-ID: <20241008191834.2190270-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 670585917d6a06543222cc1c
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

The commit 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a
separate routine") unintentionally changed behavior of the FIFO data
transfer routine.

When data is read and size reaches 0 the original loop would wait on
DWMCI_INTMSK_DTO or timeout. The remaining size to read and buf position
is no longer tracked across dwmci_data_transfer_fifo() calls and because
of this an extra call to fifo() and dwmci_fifo_ready() may now trigger a
FIFO underflow timeout error and slows down FIFO reading.

  Buswidth = 4, clock: 50000000
  Sending CMD16
  Sending CMD17
  dwmci_fifo_ready: FIFO underflow timeout
  Sending CMD16
  Sending CMD18
  dwmci_fifo_ready: FIFO underflow timeout
  Sending CMD12
  ## Checking hash(es) for config config-1 ... OK

This reverts commit 0252924ac6d4af69061bb9589d16b30c5bdb7178 to restore
the old working behavior.

Fixes: 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a separate routine")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Change to revert the offending commit, both size and buf where reset
  between fifo() calls, easier to do a full revert.
- R-b tag not collected because of this being a different patch.

Reading FIT from SD-card take ~20-30 seconds on a Rockchip RK3328 board
without this reverted, and goes back to sub second once reverted.
---
 drivers/mmc/dw_mmc.c | 103 ++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 8551eac70185..e1110cace897 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -214,66 +214,24 @@ static unsigned int dwmci_get_timeout(struct mmc *mmc, const unsigned int size)
 	return timeout;
 }
 
-static int dwmci_data_transfer_fifo(struct dwmci_host *host,
-				    struct mmc_data *data, u32 mask)
+static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 {
-	const u32 int_rx = mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO);
-	const u32 int_tx = mask & DWMCI_INTMSK_TXDR;
+	struct mmc *mmc = host->mmc;
 	int ret = 0;
-	u32 len = 0, size, i;
-	u32 *buf;
-
-	size = (data->blocksize * data->blocks) / 4;
-	if (!host->fifo_mode || !size)
-		return 0;
+	u32 timeout, mask, size, i, len = 0;
+	u32 *buf = NULL;
+	ulong start = get_timer(0);
 
+	size = data->blocksize * data->blocks;
 	if (data->flags == MMC_DATA_READ)
 		buf = (unsigned int *)data->dest;
 	else
 		buf = (unsigned int *)data->src;
 
-	if (data->flags == MMC_DATA_READ && int_rx) {
-		dwmci_writel(host, DWMCI_RINTSTS, int_rx);
-		while (size) {
-			ret = dwmci_fifo_ready(host, DWMCI_FIFO_EMPTY, &len);
-			if (ret < 0)
-				break;
-
-			len = (len >> DWMCI_FIFO_SHIFT) & DWMCI_FIFO_MASK;
-			len = min(size, len);
-			for (i = 0; i < len; i++)
-				*buf++ = dwmci_readl(host, DWMCI_DATA);
-			size = size > len ? (size - len) : 0;
-		}
-	} else if (data->flags == MMC_DATA_WRITE && int_tx) {
-		while (size) {
-			ret = dwmci_fifo_ready(host, DWMCI_FIFO_FULL, &len);
-			if (ret < 0)
-				break;
-
-			len = host->fifo_depth - ((len >> DWMCI_FIFO_SHIFT) &
-						  DWMCI_FIFO_MASK);
-			len = min(size, len);
-			for (i = 0; i < len; i++)
-				dwmci_writel(host, DWMCI_DATA, *buf++);
-			size = size > len ? (size - len) : 0;
-		}
-		dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_TXDR);
-	}
-
-	return ret;
-}
-
-static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
-{
-	struct mmc *mmc = host->mmc;
-	int ret = 0;
-	u32 timeout, mask, size;
-	ulong start = get_timer(0);
-
-	size = data->blocksize * data->blocks;
 	timeout = dwmci_get_timeout(mmc, size);
 
+	size /= 4;
+
 	for (;;) {
 		mask = dwmci_readl(host, DWMCI_RINTSTS);
 		/* Error during data transfer */
@@ -283,7 +241,50 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 			break;
 		}
 
-		ret = dwmci_data_transfer_fifo(host, data, mask);
+		if (host->fifo_mode && size) {
+			len = 0;
+			if (data->flags == MMC_DATA_READ &&
+			    (mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO))) {
+				dwmci_writel(host, DWMCI_RINTSTS,
+					     mask & (DWMCI_INTMSK_RXDR |
+						     DWMCI_INTMSK_DTO));
+				while (size) {
+					ret = dwmci_fifo_ready(host,
+							DWMCI_FIFO_EMPTY,
+							&len);
+					if (ret < 0)
+						break;
+
+					len = (len >> DWMCI_FIFO_SHIFT) &
+						    DWMCI_FIFO_MASK;
+					len = min(size, len);
+					for (i = 0; i < len; i++)
+						*buf++ =
+						dwmci_readl(host, DWMCI_DATA);
+					size = size > len ? (size - len) : 0;
+				}
+			} else if (data->flags == MMC_DATA_WRITE &&
+				   (mask & DWMCI_INTMSK_TXDR)) {
+				while (size) {
+					ret = dwmci_fifo_ready(host,
+							DWMCI_FIFO_FULL,
+							&len);
+					if (ret < 0)
+						break;
+
+					len = host->fifo_depth - ((len >>
+						   DWMCI_FIFO_SHIFT) &
+						   DWMCI_FIFO_MASK);
+					len = min(size, len);
+					for (i = 0; i < len; i++)
+						dwmci_writel(host, DWMCI_DATA,
+							     *buf++);
+					size = size > len ? (size - len) : 0;
+				}
+				dwmci_writel(host, DWMCI_RINTSTS,
+					     DWMCI_INTMSK_TXDR);
+			}
+		}
 
 		/* Data arrived correctly */
 		if (mask & DWMCI_INTMSK_DTO) {
-- 
2.46.2

