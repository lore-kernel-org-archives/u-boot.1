Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0592DC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCF682F35;
	Mon, 30 Jun 2025 20:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MQehlEyS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kiL6Edq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE9E81FFC; Mon, 30 Jun 2025 20:51:52 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF3A81D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bWFd04PrHz9t2j;
 Mon, 30 Jun 2025 20:51:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1kU3qEWT+pBBzRzj4E74rGyifRnt4Mh+Ct5iU+bZjM=;
 b=MQehlEySj9Z/r39mjLTgnP/r5Z63DPBZE7TSxoNgl2uoptgYgVAO8kepeMQi6T0+FZjoGL
 2BOHTTczq8SAxBqKp7Y1TXcKjCzjLtCMRvL5O2eQtfJZ4Drn6b/62apybppN9DnqzjeSty
 QgbbedHquWxVE8f1LLGTc4JTv2bHZZ7aLXe3OtqUz5lmasIsfAOpOc4Z5HGC7xQOw2Tm3n
 tK9VG/mRqeC3AuXWx+X73oUBA4JbWxpX1mSqmdO+02/F3zVBtMoHM7muypj84K6NUxrh0O
 sjgxZR+mWZLnCI8zAS7y0dsTry3CE39WQ/XwTcA0kBiebwBoZKCRh2J+Jr7TPg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1kU3qEWT+pBBzRzj4E74rGyifRnt4Mh+Ct5iU+bZjM=;
 b=kiL6Edq8TUQzsXC8c9ZUQWsJmmATtpBzQX7utyHmQZKGFsjc1+bWGEg6tGJ4ysuzLrA169
 6NNiaQTyxSpS2vjXRAsWdNiVXhQmiC+GjdtoR8h/OGYZli1Gvdw63cwR5r1Q7VhPpGROsg
 2adVpVBuAm0e0h07TLSWSS+b+BPXfGLE2UABKv/z4U88ahcLuR9Yt0e03wwRvU4WjmGgU5
 4ZKl3vPPHpsDMfSFyWnEvmcOwRTZcFuvHHaBPeTB8hRxx34LXgW7QVTyekUkVsKIsCqcvH
 d8zeHI//8XKR8rc4B2OBhr/nyyWtokzUXDsDw5wDdUHEv4JjsHIX7ywPEWiEFQ==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] net: sh_eth: Drop phy_addr assignment
Date: Mon, 30 Jun 2025 20:51:14 +0200
Message-ID: <20250630185124.1099147-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6272b2de2a9270bccf0
X-MBO-RS-META: fz9edwygy7f9wazbnn7h8bzcx9gkeczq
X-Rspamd-Queue-Id: 4bWFd04PrHz9t2j
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

Drop unused struct sh_eth_info *port_info .phy_addr member assignment.
PHY address is extracted from control DT. No functional change intended.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/sh_eth.c | 1 -
 drivers/net/sh_eth.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index d372ece8e46..4d9cdf17b46 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -727,7 +727,6 @@ static int sh_ether_probe(struct udevice *udev)
 
 	priv->bus = mdiodev;
 
-	port_info->phy_addr = CFG_SH_ETHER_PHY_ADDR;
 	port_info->iobase = (void __iomem *)(uintptr_t)BASE_IO_ADDR;
 
 #if CONFIG_IS_ENABLED(CLK)
diff --git a/drivers/net/sh_eth.h b/drivers/net/sh_eth.h
index 006f12a37b9..c395e6e8fc7 100644
--- a/drivers/net/sh_eth.h
+++ b/drivers/net/sh_eth.h
@@ -78,7 +78,6 @@ struct sh_eth_info {
 	u8 *rx_buf_alloc;
 	u8 *rx_buf_base;
 	u8 mac_addr[6];
-	u8 phy_addr;
 	struct eth_device *dev;
 	struct phy_device *phydev;
 	void __iomem *iobase;
-- 
2.47.2

