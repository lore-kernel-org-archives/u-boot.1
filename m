Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC804C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 18:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F00187EF7;
	Wed,  8 May 2024 20:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="TOA16KH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B898829E; Wed,  8 May 2024 20:36:44 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015D987DEA
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 20:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20240508183641bc433e76b0b937bd0e for <u-boot@lists.denx.de>;
 Wed, 08 May 2024 20:36:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ecfVIJExc2q3sh/DTthiGmD9Lftdkr+fNkXMVjtr1VI=;
 b=TOA16KH1EFxZhfD9EY9BJx1iY2RgTjIi8wwzuYKy3kKKhSs+qxJGeJc0h6ADFtOdaB37lk
 EvvfJvCtS9oXmgGkcMLwD+JHvw7lVaXBlVJthG/nHFBlx5pMVpxFh/5drgVB7DMmGYbJHKhD
 OTPhjqvQXAGly2C7mphSDpNN8s2bk=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ti: am65-cpsw-nuss: don't touch DMA after stop
Date: Wed,  8 May 2024 20:36:00 +0200
Message-ID: <20240508183605.955341-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Contrary to doc/develop/driver-model/ethernet.rst contract, eth_ops
.free_pkt can be called after .stop, there are several error paths in TFTP,
for instance:

eth_halt() <= tftp_handler() <= net_process_received_packet() <= eth_rx()
...
am65_cpsw_free_pkt() <= eth_rx()

Which results in (deliberately "tftpboot"ing non-existing file):

TFTP error: 'File not found' (1)
Not retrying...
am65_cpsw_nuss_port ethernet@8000000port@1: RX dma free_pkt failed -22

Avoid the error message by checking that the interface is still not stopped
in am65_cpsw_free_pkt().

Fixes: 9d0dca1199d1 ("net: ethernet: ti: Introduce am654 gigabit eth switch subsystem driver")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ti/am65-cpsw-nuss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 65ade1afd05..646f618afcf 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -523,6 +523,9 @@ static int am65_cpsw_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct am65_cpsw_common	*common = priv->cpsw_common;
 	int ret;
 
+	if (!common->started)
+		return -ENETDOWN;
+
 	if (length > 0) {
 		u32 pkt = common->rx_next % UDMA_RX_DESC_NUM;
 
-- 
2.44.0

