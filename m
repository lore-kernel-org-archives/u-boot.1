Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55484C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 14:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5549C887FB;
	Mon, 22 Apr 2024 16:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="P5n2iAQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7928D887FB; Mon, 22 Apr 2024 16:00:57 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D2588744
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 16:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713794453;
 bh=5aXCPkRkNojlRedYAjbZiy2bKvgmNZMkCa57kDfDIxk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P5n2iAQVPht2tYW9z8azKsZr4kKzidWGXlhQOnOACnyXRG+PCuK3EORh/HMSZbj2p
 q17IbErsN84EcqOjIBkStyE9Fz/obwdQcLb2aMB7epWgeMevYcxLCW42gAK0Ry8q6G
 Y1mZH4Y4TXzd+wgydyLWzQeS6gaVPxW/AJ5NNij+ibMlnWwSjm9/tF9obHPWqUORw1
 yEZcFHjiQ9/6LyNsT56q7pW7eDsd6ffkp/t6lE+0k4bhL0WgmGm6ByktWGLIPRYGkj
 SarA0Uc+uFk3Dher7JgX+RxGJMNsYObzhEz/NbytiC+jNYepdqlsLw8R5PFdDH/GFy
 eJOzoDYq8krKw==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95BCC3782134;
 Mon, 22 Apr 2024 14:00:51 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 3/3] net: eth-uclass: Add driver source possibility
Date: Mon, 22 Apr 2024 09:56:20 -0400
Message-ID: <20240422135927.23582-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135927.23582-1-detlev.casanova@collabora.com>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
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

Some net driver, like rtl8169, can set/get the MAC address from the
registers and store it in pdata->enetaddr.

When that happens, if there is a mismatch with the environment MAC
address, u-boot will show that the MAC address source is DT. This patch
ensures that the shown source is "driver" instead to avoid confusion.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 net/eth-uclass.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 682de3ec7bd..3caf03eaef6 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -559,9 +559,13 @@ static int eth_post_probe(struct udevice *dev)
 	priv->state = ETH_STATE_INIT;
 	priv->running = false;
 
+	/* Check if the driver has already set a valid MAC address */
+	if (is_valid_ethaddr(pdata->enetaddr)) {
+		source = "driver";
+	}
 	/* Check if the device has a valid MAC address in device tree */
-	if (!eth_dev_get_mac_address(dev, pdata->enetaddr) ||
-	    !is_valid_ethaddr(pdata->enetaddr)) {
+	else if (!eth_dev_get_mac_address(dev, pdata->enetaddr) ||
+		 !is_valid_ethaddr(pdata->enetaddr)) {
 		/* Check if the device has a MAC address in ROM */
 		if (eth_get_ops(dev)->read_rom_hwaddr) {
 			int ret;
-- 
2.43.2

