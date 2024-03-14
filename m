Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7238DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74D687FE9;
	Thu, 14 Mar 2024 15:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aCQGFu0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6FF87FE3; Thu, 14 Mar 2024 15:44:14 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B21F87FD2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710427451;
 bh=+Sy0kwHq+KTShHtJaS3pgqAXo/GfK+PHX0nZJW3GMCk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aCQGFu0ReFoNrR8Y0c7u9AYL3BT5yu9skX4SZ/cvK7N59PhlOG+HgHqWC6Dh8oM5H
 Ruirw2niKZIKFJhkM9Or8RbE1a0cH/gzlapUuDh3OtkwMssgQh3MHFm/349B+EB/dY
 EpbcAg8+S3wlqiPYbG/ZYC5OWRTVAsBZ1uGZGBSpLQCWNvhK9mGRu60npyBUGuELpK
 HFHkQ0iX4eqlcPSFfdKGwBthWQpE9Bb+WKgDsUuaPFYN54worgmM7cpmqI+IXMtLha
 Oj7nVkYLGska7fv1IggjLoakPc5r8hymephO6IufQ6d1kEpgO1B1tDzerL9FH1MlNh
 8YA6FRHQALmzQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4639937820F8;
 Thu, 14 Mar 2024 14:44:09 +0000 (UTC)
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
Subject: [PATCH 3/3] net: eth-uclass: Add driver source possibility
Date: Thu, 14 Mar 2024 10:43:48 -0400
Message-ID: <20240314144403.491850-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314144403.491850-1-detlev.casanova@collabora.com>
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
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
index f194df8512a..6e521955fa5 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -565,9 +565,13 @@ static int eth_post_probe(struct udevice *dev)
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
 		int ret = -1;
 		if (eth_get_ops(dev)->read_rom_hwaddr) {
-- 
2.43.2

