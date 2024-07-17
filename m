Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB507C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 12:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC9488A4D;
	Wed, 17 Jul 2024 14:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721219374;
	bh=y5O9EzvPtRZcO8W7ap7eYUdsFegi3y+WTJWaVRSxaOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wof8DQtI2aMm/MTHpNThHBSXxm3HQ2e9bwpQ8Xp+86yKDbVysq9+mCm8TvW/t2Dni
	 xeS0YX/Ya9VWaO0LYT0vBxfN/rK4al1Evlz/pY0F4tvWR7BImbxKq68U0xxJ1TnPfH
	 zhIMYwSVrbwu85HGgKMD++390Q5VnO23yvlnBCsK2hAP5UYLTKGULIWmuFekGF6fOO
	 4wa40amvceiSOJ8CQlG0H0J7D62G2uLyK0htKXNpRmAi0FOTNRr2cVXJbqs1YMcvj5
	 IJGpIPOXbji3T1w1o4/cEvATsTw464NKxQ2Yl3lFel1+rGeeO8j6dz8o2wR+v7YG2w
	 nkU/Jamnlc9Dw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 968BB88A73;
 Wed, 17 Jul 2024 14:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721219373;
 bh=y5O9EzvPtRZcO8W7ap7eYUdsFegi3y+WTJWaVRSxaOY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A/vqtnILmmNJQhqqMrTcQB0KF2XED6V7Y9c+GxJKfglcswsERo0rGCYqUKEqmiUHp
 g/y+t8gJESBnn+1URh/M8nQDkNGFFYkSpsifRaz62CP4QBvz7aY0I0QRPyjjtixOYi
 v6On/8gM9oeFPVZmQg2bEYOOSvWDOf4ihroxrqr3XGuuUg+ZS/QJbH1bnjYrzT7yXG
 gONX6gZz12rDGJq4n+7EzmGr5QDMnc6HjHDbKqw1R82dR7mysz+U7rD8sXKAnRnoUB
 WhF8phs63ro7DNGigfXooPARbex/1sagxD8jbcjcGoodjln0Ff/2j0ZMaecxfpMQv4
 DUfpXLGLFrFyg==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v3 4/5] net: dwc_eth_qos: Implement bind() for PCI devices
Date: Wed, 17 Jul 2024 14:29:05 +0200
Message-Id: <20240717122906.117861-5-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717122906.117861-1-pro@denx.de>
References: <20240717122906.117861-1-pro@denx.de>
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

PCI devices do not necessarily use a device tree. Implement a bind()
function to assign unique device names in that case.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 drivers/net/dwc_eth_qos.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 039d7d409e3..b7aef751866 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1361,6 +1361,21 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
 	return 0;
 }
 
+static int eqos_bind(struct udevice *dev)
+{
+	static int dev_num;
+	const size_t name_sz = 16;
+	char name[name_sz];
+
+	/* Device name defaults to DT node name. */
+	if (ofnode_valid(dev_ofnode(dev)))
+		return 0;
+
+	/* Assign unique names in case there is no DT node. */
+	snprintf(name, name_sz, "eth_eqos#%d", dev_num++);
+	return device_set_name(dev, name);
+}
+
 /*
  * Get driver data based on the device tree. Boards not using a device tree can
  * overwrite this function.
@@ -1587,6 +1602,7 @@ U_BOOT_DRIVER(eth_eqos) = {
 	.name = "eth_eqos",
 	.id = UCLASS_ETH,
 	.of_match = of_match_ptr(eqos_ids),
+	.bind	= eqos_bind,
 	.probe = eqos_probe,
 	.remove = eqos_remove,
 	.ops = &eqos_ops,
-- 
2.39.2

