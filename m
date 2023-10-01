Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687EEE78482
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB965870EB;
	Sun,  1 Oct 2023 21:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zzn6LBKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D56870F6; Sun,  1 Oct 2023 21:17:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3416C870E5
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696187863; bh=40Uv0CtB3T/OYTkE44RMgvT6CPg+i83+B61EI2fRSVM=;
 b=zzn6LBKuu8ayheXTwC387wvv7C5w+erdlQ0cc//CoUVsNfJHBY+Xcc24IkAnxMNYel+6DYFk9
 dOGj1KuNq+KXnMaTjtoCCnXNBrjAcR4k7OFqJBL+yhMqFXze5h353BWniGByGUAeD6B8jKYGt4p
 3bMTmgO3VYBGWniOi+cmLL7gJu/EErfssUtVL+KleIZ7ePd7Sscp/2HCWoWdUt9vfhx/bM0wByW
 0CNJ24KjodVHvnTen7iiv9SxC3kamAyR2uqGC+5nY/i/vz97haXRpIvxP0duudlv/oodRgWEn0a
 x6f0AS8azHetnJJII7o27HQpgXr+NIGlErMsWWCamqYw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: David Wu <david.wu@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/7] net: dwc_eth_qos: Return error code when start fails
Date: Sun,  1 Oct 2023 19:17:17 +0000
Message-ID: <20231001191730.4167035-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6519c5d625909c3c56c79d96
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

Return error code when phy_connect fails or no link can be established.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag

 drivers/net/dwc_eth_qos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 555eaee3bbc3..7565e716823a 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -811,6 +811,7 @@ static int eqos_start(struct udevice *dev)
 
 		if (!eqos->phy) {
 			pr_err("phy_connect() failed");
+			ret = -ENODEV;
 			goto err_stop_resets;
 		}
 
@@ -838,6 +839,7 @@ static int eqos_start(struct udevice *dev)
 
 	if (!eqos->phy->link) {
 		pr_err("No link");
+		ret = -EAGAIN;
 		goto err_shutdown_phy;
 	}
 
-- 
2.42.0

