Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D47D3C53E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA178915F;
	Fri, 18 Oct 2024 03:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tLQJFhRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A4D89148; Fri, 18 Oct 2024 03:30:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F2DB8915A
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 94BAE408B4; 
 Fri, 18 Oct 2024 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729215022;
 bh=P1pPyk+3KqvCSxAAmAycKJlWwN1RkrzgvcTuUl4wMZo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tLQJFhRqIgRlFhKIfh28PpP5Ks0vLjan09ksqMy4NSRlKqHx2jWjdUHBjy0o1YayC
 wwAxDGKCzqxNVH7N/VblvREECyNnv8I/RTJj/I0OiiZkLEbW3eft/SHG7RWfEXQ69Y
 etQvsKOTC+xf+/Ok1TjSVVca1YM2Y3zrDVgm603qw0Ju8wXKwVNZEBzpK4CxUpNlEI
 IsHVdPgOZBPIxHqJwghLzQdq2VTEhXpL+AKdrbhVAsePYrk9Cu3xLtj0gLP9E93en9
 mzfT9I0JJ27HOoAB5JRWqoh6HlAg72Dx0c4+aLpSl5h1yjM2lKQ/j/eX+TRN2TM31M
 rhnBCBZKH1dhQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] rockchip: block: simplify rkmtd driver
Date: Fri, 18 Oct 2024 03:30:13 +0200
Message-ID: <20241018013015.127620-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
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

By using blk_create_devicef() instead of blk_create_devicef() the driver
can be simplified and brought into line with other block device drivers.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/block/rkmtd.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
index c55f052e51b..f84cacd7ead 100644
--- a/drivers/block/rkmtd.c
+++ b/drivers/block/rkmtd.c
@@ -794,36 +794,19 @@ int rkmtd_init_plat(struct udevice *dev)
 	return 0;
 }
 
-static void rkmtd_blk_kmalloc_release(struct udevice *dev, void *res)
-{
-	/* noop */
-}
-
 static int rkmtd_bind(struct udevice *dev)
 {
 	struct rkmtd_dev *plat = dev_get_plat(dev);
-	char dev_name[30], *str;
 	struct blk_desc *desc;
 	struct udevice *bdev;
 	int ret;
 
-	snprintf(dev_name, sizeof(dev_name), "%s.%s", dev->name, "blk");
-
-	str = devres_alloc(rkmtd_blk_kmalloc_release, strlen(dev_name) + 1, GFP_KERNEL);
-	if (unlikely(!str))
-		return -ENOMEM;
-
-	strcpy(str, dev_name);
-
-	ret = blk_create_device(dev, "rkmtd_blk", str, UCLASS_RKMTD,
-				-1, 512, LBA, &bdev);
+	ret = blk_create_devicef(dev, "rkmtd_blk", "blk", UCLASS_RKMTD,
+				 -1, 512, LBA, &bdev);
 	if (ret) {
-		free(str);
 		return log_msg_ret("blk", ret);
 	}
 
-	devres_add(dev, str);
-
 	desc = dev_get_uclass_plat(bdev);
 	sprintf(desc->vendor, "0x%.4x", 0x2207);
 	memcpy(desc->product, "RKMTD", sizeof("RKMTD"));
-- 
2.45.2

