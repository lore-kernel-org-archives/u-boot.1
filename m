Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4038CC982C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0332C6080F;
	Wed, 16 Sep 2026 09:38:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEQsGuJC_yOB; Wed, 16 Sep 2026 09:37:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F023607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551479;
	b=UEwwpb3yGFnPzSz18M/4lP4LaI1MKAucFLV80dS1pKB7XiVzYDaO+MVCeyYsqX5DYZyx
	 /dG1gmy3nq7U4MJE3KBsrV/55bpI2HVz0+AFFzHyj+gbLEf30InW377VIGRZSZmFM5G2H
	 nC4NlIT2Q4CuNZOn//UtkH4/IHDdi8YSY1+2+qKFIGWg55qCRTrrLI1Ji/U4vxmhleGi8
	 MH62GNbAyD9AiXm8/YjPJ+fen54grvlMzkX7683JAZ9ogwAEtW7a5o+iPM1jq1uopyGKT
	 ewu7ikrS6MmPqQ0W6ZVOn4Gv7jMf1tbtvUp1AJX+ptMZirh4JjQTIp64cmfqfkzmGkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tlbGFxkPqld7C1Ak/1Y3oc0vEAATPLkSSLHs7Dz8WDA=;
	b=kZ0zcWp6+w/U3mulKM/UGhcBOgHhUyV2YImrmzYfo4icI6tmYeSVLZzZAIa0xtvHTKF8
	 tO1YdRjxnCdUqv6IrLfdqrlB+Yr2219vEI1wHFJzJUh3vJPvrR2oq1MOMQVnYwjDEc65s
	 pDnvAkILFYXJEhZa/wyTrTq8RCFgE9xOl6EQqBv2hP8u1FOgoATt8ido7hCEwAeo20MFt
	 231PljRWD0mk8vfdr4Eurpe+m4v8yLjdBKt4nkPnHfvdLzyM0rfRTNsdKIhfMaHOddeXV
	 Jw4pBo+Dn3cpKT5c6IeqpXlRMqVhoR3fuPRz9zVKkbFFUhqo7l4UaXIARFKx+vQk+Uw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JkUjgLNF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551479;
	bh=tlbGFxkPqld7C1Ak/1Y3oc0vEAATPLkSSLHs7Dz8WDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tj4NfQV55llsZwRRNSKby91e2DZew3Dbgae+aM0fBM0lw9XV89CE6Qqe/Ne+SQlVc
	 n24GhGBDfQzXoTM5tekw9QpGoRnAgCx6NA0MTxudpVScGM5rtdw4CUFebTDIjaTMZ1
	 8ant7bTIUDarPQy+by4a0yvTs6EELzNRHUbPlySihaXBwoU97oj88DYdH1rt8RZABP
	 IuXYlg+HdVfCZ5uoZ39otvcIz0NEodXdkJxUHUHrWDvkASUL96BfM/rc9QWDcEG++6
	 VUURShwGDW9Dwe79xXbYV12UzLYPr5Ib29uStaaaU81n/tGvPyz3NLPEBLi2KHtmKT
	 V4fjOXs7QtAtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F023607FF;
	Wed, 16 Sep 2026 09:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BC53224
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20FDD60803
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stTh4YwYryra for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 50157607FD
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551475;
 b=QqQYn0CQ/F1eKACQE4TyOExKy7rnd/atn45nKwkpwjCvpdgEm22brLMMxQlar7UDImwl
 dlOPCOcpHK+djge/QDL1ZtTqaTsHWOcQX2koQp8YYFnd6owaxGTLdR/qnduXioaEA0wP9
 +rh2zugkVcqolSoJPHTuvoOV65gG61LmgHf5Z+REbMDzKmmV2Cks30x8jG0lSiblyPOyX
 3kG7tEdoUexxkhg/ayvkXJJfddBkGgylfg703MjQDR1Y0OHOZ7Mw8RLmO5dY/F0+VVw2g
 oLLWsNZ+VRp/7feqnoXIXq8iHUhGT2x4aTAYWe4VeHJVmtZkc/l7wMczyKKygiuxEtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551475;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=tlbGFxkPqld7C1Ak/1Y3oc0vEAATPLkSSLHs7Dz8WDA=;
 b=Y2PaWcGAB5pfVCqQx1xetLRopct/7COi5G4omMtoQTbex5p8FaAXknMP5/sFlVsDJFLG
 NoLafaU9Ga9+vTEPm3ggJrH65Qgbto/YiPMVwh12ZjUqFzWt/tc+S6EF4XEypzlXQyuaC
 YOC3CjN5L/0gueAALVQmky3lNQGLNbTUPdRImDQAZpfq+xdhr8S0kmXU2QsgXDB7Zkkb/
 fyIcUIkc5AeEBNoeKwujgWkOahnsjY6+OTXF2EnLCzEDcYtJhIA4vGkSb+7AZ8MBVI41W
 mtxqheRt6K58Q4rSGvSgmYjUFHp6D9gvobZp0rAmjfOe9bV09bWU3NqLFz2p/v74GNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JkUjgLNF; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JkUjgLNF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50157607FD
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 939F441671;
 Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E5A1F00893;
 Wed, 16 Sep 2026 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551474;
 bh=tlbGFxkPqld7C1Ak/1Y3oc0vEAATPLkSSLHs7Dz8WDA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JkUjgLNF7WJnsCZDuhzC3pUOoQ0HiS2vzIl2PxAkrpHlMdUr+skzKjrDVJIMgq4BJ
 Z+Q4Lu09WJQtee/30euTHelrsordmVid2jrNg/F/aZaYWOQELoghpcO6r7uSEnbYlj
 F+Ia/9Ttl31I+kScpv64qRD86JcXvPa4VvnkdhZBYhpnIPTZdJy3bfWI+zIHBnF3JI
 s+K96Gwec6UiJ/jASBhuSNejfsbLmvhmyikFg78wHF2dVsc25S5AkLChRK4Xg6eOKN
 aVVooZdgoYOk3URxopSp3jR2BOZlFpRm4sfBrTBMnfQEkPY6D5ka0yXAXg4+0HJIZY
 QdhmaoKxq55lA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:40 +0200
Subject: [PATCH 8/8] mmc: arm_pl180: Use variant FIFO sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-8-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The MMCI variants do not all expose the same FIFO capacity. The ARM
PL180 can transfer 16 words when the FIFO is full or empty, STM32 can
transfer 32 words, and Ux500 can transfer 30 words. Their half-full and
half-empty conditions guarantee eight words.

Store the full and half FIFO sizes in the host according to the
peripheral ID. Use the full size when the corresponding full or empty
status is asserted and otherwise retain the half-size burst. This
reduces the number of status polls and bulk I/O operations where the
larger FIFO capacity is available.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 47 ++++++++++++++++++++++++++------------------
 drivers/mmc/arm_pl180_mmci.h |  7 ++++++-
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 7d58c64df11d..31efa7576ff5 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -143,6 +143,7 @@ static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 	u32 *tempbuff = dest;
 	u64 xfercount = blkcount * blksize;
 	struct pl180_mmc_host *host = dev->priv;
+	unsigned int count;
 	u32 status, status_err;
 
 	debug("read_bytes: blkcount=%u blksize=%u\n", blkcount, blksize);
@@ -150,13 +151,18 @@ static int read_bytes(struct mmc *dev, u32 *dest, u32 blkcount, u32 blksize)
 	status = readl(&host->base->status);
 	status_err = status & (SDI_STA_DCRCFAIL | SDI_STA_DTIMEOUT |
 			       SDI_STA_RXOVERR);
-	while (!status_err &&
-	       xfercount >= SDI_FIFO_BURST_SIZE * sizeof(u32)) {
-		if (status & SDI_STA_RXFIFOBR) {
+	while (!status_err && xfercount >= host->fifo_half_size) {
+		count = 0;
+		if (status & SDI_STA_RXFIFOF)
+			count = min_t(u64, xfercount, host->fifo_size);
+		else if (status & SDI_STA_RXFIFOBR)
+			count = host->fifo_half_size;
+
+		if (count) {
 			readsl(&host->base->fifo, tempbuff,
-			       SDI_FIFO_BURST_SIZE);
-			tempbuff += SDI_FIFO_BURST_SIZE;
-			xfercount -= SDI_FIFO_BURST_SIZE * sizeof(u32);
+			       count / sizeof(u32));
+			tempbuff += count / sizeof(u32);
+			xfercount -= count;
 		}
 		status = readl(&host->base->status);
 		status_err = status & (SDI_STA_DCRCFAIL | SDI_STA_DTIMEOUT |
@@ -211,6 +217,7 @@ static int write_bytes(struct mmc *dev, u32 *src, u32 blkcount, u32 blksize)
 	u32 *tempbuff = src;
 	u64 xfercount = blkcount * blksize;
 	struct pl180_mmc_host *host = dev->priv;
+	unsigned int count;
 	u32 status, status_err;
 
 	debug("write_bytes: blkcount=%u blksize=%u\n", blkcount, blksize);
@@ -218,19 +225,17 @@ static int write_bytes(struct mmc *dev, u32 *src, u32 blkcount, u32 blksize)
 	status = readl(&host->base->status);
 	status_err = status & (SDI_STA_DCRCFAIL | SDI_STA_DTIMEOUT);
 	while (!status_err && xfercount) {
-		if (status & SDI_STA_TXFIFOBW) {
-			if (xfercount >= SDI_FIFO_BURST_SIZE * sizeof(u32)) {
-				writesl(&host->base->fifo, tempbuff,
-					SDI_FIFO_BURST_SIZE);
-				tempbuff += SDI_FIFO_BURST_SIZE;
-				xfercount -= SDI_FIFO_BURST_SIZE * sizeof(u32);
-			} else {
-				while (xfercount >= sizeof(u32)) {
-					writel(*(tempbuff), &host->base->fifo);
-					tempbuff++;
-					xfercount -= sizeof(u32);
-				}
-			}
+		count = 0;
+		if (status & SDI_STA_TXFIFOE)
+			count = min_t(u64, xfercount, host->fifo_size);
+		else if (status & SDI_STA_TXFIFOBW)
+			count = min_t(u64, xfercount, host->fifo_half_size);
+
+		if (count) {
+			writesl(&host->base->fifo, tempbuff,
+				count / sizeof(u32));
+			tempbuff += count / sizeof(u32);
+			xfercount -= count;
 		}
 		status = readl(&host->base->status);
 		status_err = status & (SDI_STA_DCRCFAIL | SDI_STA_DTIMEOUT);
@@ -451,6 +456,8 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	host->clkdiv_init = SDI_CLKCR_CLKDIV_INIT_V1 | SDI_CLKCR_CLKEN |
 			    SDI_CLKCR_PWRSAV | SDI_CLKCR_HWFC_EN;
 	host->clock_in = clk_get_rate(&clk);
+	host->fifo_size = SDI_FIFO_SIZE_ARM;
+	host->fifo_half_size = SDI_FIFO_HALF_SIZE;
 
 	cfg->name = dev->name;
 	cfg->voltages = VOLTAGE_WINDOW_SD;
@@ -462,9 +469,11 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	periphid = dev_read_u32_default(dev, "arm,primecell-periphid", 0);
 	switch (periphid) {
 	case STM32_MMCI_ID: /* stm32 variant */
+		host->fifo_size = SDI_FIFO_SIZE_STM32;
 		host->version2 = false;
 		break;
 	case UX500V2_MMCI_ID:
+		host->fifo_size = SDI_FIFO_SIZE_UX500;
 		host->pwr_init = SDI_PWR_OPD | SDI_PWR_PWRCTRL_ON;
 		host->clkdiv_init = SDI_CLKCR_CLKDIV_INIT_V2 | SDI_CLKCR_CLKEN |
 				    SDI_CLKCR_PWRSAV | SDI_CLKCR_HWFC_EN;
diff --git a/drivers/mmc/arm_pl180_mmci.h b/drivers/mmc/arm_pl180_mmci.h
index fca15910a8db..92057c18f55e 100644
--- a/drivers/mmc/arm_pl180_mmci.h
+++ b/drivers/mmc/arm_pl180_mmci.h
@@ -140,7 +140,10 @@
 #define SDI_DCTRL_DBLOCKSIZE_V2_MASK   0x7fff0000
 #define SDI_DCTRL_DBLOCKSIZE_V2_SHIFT  16
 
-#define SDI_FIFO_BURST_SIZE	8
+#define SDI_FIFO_SIZE_ARM	(16 * sizeof(u32))
+#define SDI_FIFO_SIZE_STM32	(32 * sizeof(u32))
+#define SDI_FIFO_SIZE_UX500	(30 * sizeof(u32))
+#define SDI_FIFO_HALF_SIZE	(8 * sizeof(u32))
 
 #define STM32_MMCI_ID		0x00880180
 #define UX500V2_MMCI_ID		0x10480180
@@ -189,6 +192,8 @@ struct pl180_mmc_host {
 	unsigned int clock_max;
 	unsigned int clkdiv_init;
 	unsigned int pwr_init;
+	unsigned int fifo_size;
+	unsigned int fifo_half_size;
 	int version2;
 	struct mmc_config cfg;
 #ifdef CONFIG_DM_MMC

-- 
2.55.0

