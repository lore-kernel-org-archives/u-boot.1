Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E3ACED24E
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 00:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6608688CEA;
	Tue,  8 Oct 2024 02:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lRVrnMfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A7A88D47; Tue,  8 Oct 2024 02:35:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6EC88CEA
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 02:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1914=RE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1728347713;
 bh=lGUAUTdzLdbm18/RI1yB4ti7YyMtGSY7tmYH6fCp7uI=;
 b=lRVrnMfPS5l+RY4IqsUo0JCvp+c83EJCrooOr+qJF43t4EKoEjkp09oEwDqSmnCrcpt5q4/O/
 5uLFP6FD1EtI0G5jA0hP03vZ/sQHKsJUMeNUCHTQXX3EvSBtA+VPlOdm2xwUhmcaWV2mAuoE+i3
 4gKunu3ZP+HN1CiZZZyBsg9c5Np++YsO1phFqeZby5iDVnWBkfZQMwxQ7AAR7Pv2igsyJAlLgv2
 QXFUdG5kPdNFn1RSsXjbSYoaDSwig5PxqsVBkuprseKilhDX+NkRQjJGwSqJ6QJ0pQ/8IRZnXJ3
 I4rghDI+Bv0B161Z5qzJM6ZGvHz3imBwNTrR9Fq5ZBwg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] mmc: dw_mmc: Fix FIFO data transfer timeout
Date: Tue,  8 Oct 2024 00:35:00 +0000
Message-ID: <20241008003503.1914718-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67047e3f4974d3ecbfa24cd6
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
DWMCI_INTMSK_DTO or timeout. The remaining size to read is no longer
tracked across dwmci_data_transfer_fifo() calls and because of this an
extra call to fifo() and dwmci_fifo_ready() may now trigger a FIFO
underflow timeout.

  Buswidth = 4, clock: 50000000
  Sending CMD16
  Sending CMD17
  dwmci_fifo_ready: FIFO underflow timeout
  Sending CMD16
  Sending CMD18
  dwmci_fifo_ready: FIFO underflow timeout
  Sending CMD12
  ## Checking hash(es) for config config-1 ... OK

Restore old behavior and track remaining size to read across calls to
fix this.

Fixes: 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a separate routine")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Reading FIT from SD-card take ~20-30 seconds on a Rockchip RK3328 board
without this fixed, and goes back to sub second once fixed.
---
 drivers/mmc/dw_mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 8551eac70185..98b85fd1795a 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -214,16 +214,15 @@ static unsigned int dwmci_get_timeout(struct mmc *mmc, const unsigned int size)
 	return timeout;
 }
 
-static int dwmci_data_transfer_fifo(struct dwmci_host *host,
-				    struct mmc_data *data, u32 mask)
+static u32 dwmci_data_transfer_fifo(struct dwmci_host *host,
+				    struct mmc_data *data, u32 size, u32 mask)
 {
 	const u32 int_rx = mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO);
 	const u32 int_tx = mask & DWMCI_INTMSK_TXDR;
 	int ret = 0;
-	u32 len = 0, size, i;
+	u32 len = 0, i;
 	u32 *buf;
 
-	size = (data->blocksize * data->blocks) / 4;
 	if (!host->fifo_mode || !size)
 		return 0;
 
@@ -261,7 +260,7 @@ static int dwmci_data_transfer_fifo(struct dwmci_host *host,
 		dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_TXDR);
 	}
 
-	return ret;
+	return size;
 }
 
 static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
@@ -273,6 +272,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 
 	size = data->blocksize * data->blocks;
 	timeout = dwmci_get_timeout(mmc, size);
+	size /= 4;
 
 	for (;;) {
 		mask = dwmci_readl(host, DWMCI_RINTSTS);
@@ -283,7 +283,7 @@ static int dwmci_data_transfer(struct dwmci_host *host, struct mmc_data *data)
 			break;
 		}
 
-		ret = dwmci_data_transfer_fifo(host, data, mask);
+		size = dwmci_data_transfer_fifo(host, data, size, mask);
 
 		/* Data arrived correctly */
 		if (mask & DWMCI_INTMSK_DTO) {
-- 
2.46.2

