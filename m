Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3636BCD13D9
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 20:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0CF88D92;
	Sat, 31 Aug 2024 22:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yGvbMWy0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k9CRa70Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CA688DA4; Sat, 31 Aug 2024 22:32:16 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53F888D64
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 22:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wx6Bk55cqz9sxL;
 Sat, 31 Aug 2024 22:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GodN1tIKB5QEgValOwYfuz6cjNz8LYtxFfTDORziQQk=;
 b=yGvbMWy0MSkgf5kWPSIOunx3nrHB4DTT6o/6PAHfnp9figUwkXDWhX3lgEkLJlyH2ueWVl
 3FI5m1ItcGO0TYg+qc5Tpfv4g8Mf6iErIoofXhHNzmEt3MGI2vBGpePrMHcpPVsglADEhz
 O6k2M2ny6lA52e0jTpsjdUXa9KGj4yJxc0l8wVD/vXjyecNKi/9hfs0RU9SAX21YJ8vgz0
 tYyZV+dN7Ojh2G6deNQMjpGaBjRVuAUPJFIqVPzIMpP7NAA7Z5R3GO54PzNfeEsAMaCY38
 O8MzA7uxqv6ZonqUAgywxVRR4uiNffTWUwU60y1snVJJ/UaklqRgVL8nHeTC+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725136332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GodN1tIKB5QEgValOwYfuz6cjNz8LYtxFfTDORziQQk=;
 b=k9CRa70Z/LV18aRPWQ3Z0UAldVqu9zvpUlrWP4k/YO+Vnu4oNPcsVc7Xtv4la4lqexxkUc
 EFcyQ04bPe00UDzff+Yi9B/OzJMEK2LnheACk6dTNcWRyjEI5q2cY2KkWGNHUyJhcKuHle
 VMjPSE+WUIC7oZSjNG1kMzGQ7k/xN1y44Sv7On8oRFwRZRSkmRKLb8H8LrstRjTHnqx1PB
 XWS6KVqEsPVaqAztMYgckZDSb/yYddEVeFLzbMJ6imQ2c1xTGyEc7UyVkSQPn/33NmB1UJ
 Va2ZmlRBVvbi5q58iwo3dOuLFqu/REz8MFaVVVKWWocwVKSzS0jniwvRebCSDg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 4/5] mtd: spi: renesas: Configure RPC PHY timing registers
Date: Sat, 31 Aug 2024 22:31:47 +0200
Message-ID: <20240831203153.547743-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
References: <20240831203153.547743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3bb5f386fdc1b9bc746
X-MBO-RS-META: gw419sqagfbhg6fsfdajab9fj1ndi1ow
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

Make sure RPC PHY timing registers are configured before performing
bus access. These registers might have been left unconfigured or may
have been configured by a prior stage bootloader and leaving them
unconfigured or misconfigured would interfere with U-Boot operation.

Set PHYOFFSET1 DDRTMG field to 3 which enables DDR timing adjustment
when SPIDRE or DRDRE = 0 and set PHYOFFSET2 OCTTMG field to 4 which
makes the interface operate in Serial flash or HyperFlash mode.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: u-boot@lists.denx.de
---
 drivers/spi/renesas_rpc_spi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 50890981149..9aab71db1de 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -145,6 +145,12 @@
 #define RPC_PHYCNT_WBUF		BIT(2)
 #define RPC_PHYCNT_MEM(v)	(((v) & 0x3) << 0)
 
+#define RPCIF_PHYOFFSET1	0x0080	/* R/W */
+#define RPCIF_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
+
+#define RPCIF_PHYOFFSET2	0x0084	/* R/W */
+#define RPCIF_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
+
 #define RPC_PHYINT		0x0088	/* R/W */
 #define RPC_PHYINT_RSTEN	BIT(18)
 #define RPC_PHYINT_WPEN		BIT(17)
@@ -227,6 +233,12 @@ static int rpc_spi_claim_bus(struct udevice *dev, bool manual)
 	struct udevice *bus = dev->parent;
 	struct rpc_spi_priv *priv = dev_get_priv(bus);
 
+	setbits_le32(priv->regs + RPCIF_PHYOFFSET1,
+		     RPCIF_PHYOFFSET1_DDRTMG(3));
+	clrsetbits_le32(priv->regs + RPCIF_PHYOFFSET2,
+			RPCIF_PHYOFFSET2_OCTTMG(7),
+			RPCIF_PHYOFFSET2_OCTTMG(4));
+
 	/* NOTE: The 0x260 are undocumented bits, but they must be set. */
 	writel(RPC_PHYCNT_CAL | rpc_spi_get_strobe_delay() | 0x260,
 	       priv->regs + RPC_PHYCNT);
-- 
2.45.2

