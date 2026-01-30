Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4602BD73EA9
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC8484175;
	Fri, 30 Jan 2026 01:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="f4P2CPlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E25A84114; Fri, 30 Jan 2026 01:30:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED35C84114
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769732999; bh=1RDp6nm9vMxjWEsq5Aes3doLRGymDFWnGelrIkEq4Fg=;
 b=f4P2CPlcJuHdjLwvQnCNV5WfRMG2cHMsLC2VXsgkhXMTBYC6NEhGX88B+N8YB5gcz9NiQwahZ
 iimd1r7GZ8C+VYulNGgHv4qjo+9Rjq6mUKOuUr3MrEjRYMJMjdV6YFWoA0czMCF+Y6iwmbCKVnf
 B16oBxQAJNW+enU0o936F5FsYP4bHUp/2akCdN2bJdWITEtU56Rey+gWJqzIV7KFahBinghK7hM
 OrowYI0qBmLyzA4FF2lXtY7IpPARqiXwSS2ANN8qKMbwvaWo4eHMx5OuC5OduoS1xAfhKcxPv0O
 11kQNJ4u7NrjSsy9nozhZl0v9IeX4ugg1tMokSl8KWBg==
X-Forward-Email-ID: 697bfb875af568bba11df475
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 6/6] usb: eth: asix88179: Add read_rom_hwaddr() ops
Date: Fri, 30 Jan 2026 00:29:31 +0000
Message-ID: <20260130002941.2336252-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130002941.2336252-1-jonas@kwiboo.se>
References: <20260130002941.2336252-1-jonas@kwiboo.se>
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

The ASIX 88179 driver already has helpers for reading the MAC address.

Add support for the read_rom_hwaddr() ops using the existing
asix_read_mac() helper function.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/eth/asix88179.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 1ce90eb794cd..3ac7dd276a03 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -629,6 +629,20 @@ static int ax88179_write_hwaddr(struct udevice *dev)
 	return asix_write_mac(ueth, pdata->enetaddr);
 }
 
+static int ax88179_read_rom_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct asix_private *priv = dev_get_priv(dev);
+	struct ueth_data *ueth = &priv->ueth;
+	int ret;
+
+	ret = asix_read_mac(ueth, pdata->enetaddr);
+	if (ret)
+		memset(pdata->enetaddr, 0, ETH_ALEN);
+
+	return 0;
+}
+
 static int ax88179_eth_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
@@ -666,6 +680,7 @@ static const struct eth_ops ax88179_eth_ops = {
 	.free_pkt = ax88179_free_pkt,
 	.stop = ax88179_eth_stop,
 	.write_hwaddr = ax88179_write_hwaddr,
+	.read_rom_hwaddr = ax88179_read_rom_hwaddr,
 };
 
 U_BOOT_DRIVER(ax88179_eth) = {
-- 
2.52.0

