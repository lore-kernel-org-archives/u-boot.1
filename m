Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E6DC47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 20:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16AA387705;
	Sun, 21 Jan 2024 21:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="INJAzIaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DF887708; Sun, 21 Jan 2024 21:38:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5DC80785
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 21:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7b12=JA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1705869504;
 bh=wk5SUW0ElFDu5mYyvHnnFgipNxW0pkFAKrYPLeoB3wM=;
 b=INJAzIaAbd5//rZGpa6GbcLEGcKBY+9YJGnF1V92SpchfmKMvZOrLHprjPchh6GGIlbZW3OuY
 rKAvU+Ay+KJ6KgB4rnUPpoovHOpuKqBhqz72fudGTOPR6G2K+O32zjAsOoVngyg40QtYMVK7A5y
 jF0SxHrLrmEKcQRYZnFoXVs4TV/QTbrZxvk3kMovz0lCdUvqmxuQS0iHfNPOGvY9+e+ZmMXOQ4J
 kKJY9QXCihr4v4CBWAaU642jBIvrGclABbTJu0Q6EuolWwsmTiatciczVMd9jGqrurEimTg+eR6
 DmC2U0MPP7u6Pck23XPYbM5dwmeG4+mTVeYwx4lDIl7w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] usb: dwc3-of-simple: Remove Amlogic and Rockchip compatible
Date: Sun, 21 Jan 2024 20:38:16 +0000
Message-ID: <20240121203818.2075381-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65ad80bf2b94fffc7315befa
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

Remove the rockchip,rk3399-dwc3 compatible from the dwc3-of-simple
driver now that all boards have changed to use the dwc3-generic driver.

Also remove the amlogic,meson-gxl-dwc3 compatible, it is no longer in
use by any device tree in mainline linux or U-Boot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/host/dwc3-of-simple.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/dwc3-of-simple.c b/drivers/usb/host/dwc3-of-simple.c
index f9df59d2e5d7..de1797d02ec0 100644
--- a/drivers/usb/host/dwc3-of-simple.c
+++ b/drivers/usb/host/dwc3-of-simple.c
@@ -90,8 +90,6 @@ static int dwc3_of_simple_remove(struct udevice *dev)
 }
 
 static const struct udevice_id dwc3_of_simple_ids[] = {
-	{ .compatible = "amlogic,meson-gxl-dwc3" },
-	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "ti,dwc3" },
 	{ }
 };
-- 
2.43.0

