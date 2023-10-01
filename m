Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C32E78482
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2CD86335;
	Sun,  1 Oct 2023 21:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="eLYpSZ88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1E086D14; Sun,  1 Oct 2023 21:17:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288AD870F3
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696187866; bh=wa5y/mh3IjopKVzzKYi4qg35EyLhoovmTjb8z33Fg9M=;
 b=eLYpSZ8837UB/gskW7/pGogMxt0801m9znYA55aMt1XezWiGzdvZX+khQhX4rcm0zz5ROE4qP
 8p7Tfex/7/is9gy7tJ2NDX8kkTR4PtssQ1+U8NrRtUfiqHEwv+aMmyf/pvuxbEn/STgb3by3cnR
 DzhMv5Gjn9B5Y1Vi7P50HJ0sQNgYcpZVd+myp/Yv5uvWHTzRPcWroR35V0ceUan6WEKjJ5GAbZy
 9VthTCvn0snOrmj3RSTA2L6VKs85HsWZT+e+III2wD5BTNpZEcCYWrkReHusyj1xKpjSDr3mIBX
 lfCcmg1PrEF7Afdhflv8A9Hz6U6iMwWtW4GHonrAfIsw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: David Wu <david.wu@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/7] net: dwc_eth_qos: Stop spam of RX packet not available
 message
Date: Sun,  1 Oct 2023 19:17:18 +0000
Message-ID: <20231001191730.4167035-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001191730.4167035-1-jonas@kwiboo.se>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6519c5d925909c3c56c79da3
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

Remove spam of RX packet not available debug messages when waiting to
receive a packet.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag

 drivers/net/dwc_eth_qos.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 7565e716823a..24fb3fac1f12 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1193,14 +1193,12 @@ static int eqos_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct eqos_desc *rx_desc;
 	int length;
 
-	debug("%s(dev=%p, flags=%x):\n", __func__, dev, flags);
-
 	rx_desc = eqos_get_desc(eqos, eqos->rx_desc_idx, true);
 	eqos->config->ops->eqos_inval_desc(rx_desc);
-	if (rx_desc->des3 & EQOS_DESC3_OWN) {
-		debug("%s: RX packet not available\n", __func__);
+	if (rx_desc->des3 & EQOS_DESC3_OWN)
 		return -EAGAIN;
-	}
+
+	debug("%s(dev=%p, flags=%x):\n", __func__, dev, flags);
 
 	*packetp = eqos->rx_dma_buf +
 		(eqos->rx_desc_idx * EQOS_MAX_PACKET_SIZE);
-- 
2.42.0

