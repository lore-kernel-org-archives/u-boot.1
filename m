Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E1C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 23:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BC984BBF;
	Fri, 10 Jul 2026 01:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="x+P6rcdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB2C84C40; Fri, 10 Jul 2026 01:03:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EECE84BA3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 01:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783638178; bh=eYXYjXHUYjig6zTG6imRisPxVGxTPm1wbbRn+2SLYP8=;
 b=x+P6rcddZZgclnps/rr7X2ZVUdGifCQwiVXTr0ut5UPlzztAjHXCbjftjMoBi7NgFyhWQB5n5
 99smO2XzNMHWCnwFSdbfgD7+hxcXei8WG7KQs6mDTE/7hbMtYX2LAKcFCI/FUooVjplKzJ8UnBe
 VxE9r3FlVEktB+ZaI9hfgvVTgd2EpKcbTJbho1uEOq7a/9ROEzlGAHI6X5y3IlGaf6apQ+Bfe7R
 XIdJj+xnhQg4BNoRdp5smvlkimhXJhZxdkmCwlLzw/kA0GPCnMDS3gyZ9ga8f+v0dbwzUsHW1gT
 8GybTcBMGbG6ihLBA4KPoZKkcEpoqQ7fBfakwFCyok8w==
X-Forward-Email-ID: 6a50289f145c9a471a72e2be
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/4] mmc: sdhci: Use CONFIG_IS_ENABLED for MMC_IO_VOLTAGE
Date: Thu,  9 Jul 2026 23:02:42 +0000
Message-ID: <20260709230244.3516247-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709230244.3516247-1-jonas@kwiboo.se>
References: <20260709230244.3516247-1-jonas@kwiboo.se>
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

Use CONFIG_IS_ENABLED() instead of IS_ENABLED() when checking the
MMC_IO_VOLTAGE symbol so the Kconfig option is evaluated correctly for
xPL builds.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
v2: Collect r-b tag
---
 drivers/mmc/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 08594e102669..71a6d8ea2f56 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -551,7 +551,7 @@ void sdhci_set_uhs_timing(struct sdhci_host *host)
 
 void sdhci_set_voltage(struct sdhci_host *host)
 {
-	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
+	if (CONFIG_IS_ENABLED(MMC_IO_VOLTAGE)) {
 		struct mmc *mmc = (struct mmc *)host->mmc;
 		u32 ctrl;
 
-- 
2.54.0

