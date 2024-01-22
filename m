Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2382BC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D39C87872;
	Mon, 22 Jan 2024 15:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HwVCtzX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D778879A3; Mon, 22 Jan 2024 15:33:29 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899FB8785F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2716CB80DD8;
 Mon, 22 Jan 2024 14:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A0BC433A6;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705934006;
 bh=Zmku0UV9IYx408MX10z9q9u/ur0i5iQ5I2p6j812hfU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HwVCtzX96RhUd+w+cIwVa2nDNzTQB+tKHw7/ewUG5nj7iZHLiTPKvWKKgyQHXzhDX
 i4fKEM4CTxfoW8KROBEfn1CbJerNbK9Qm/wi8Et89nlSnKxQi2O6XioQ/gwu0dZksb
 I19XBoY3HqfGzeEDylLwvY9/9rcnFDsd1Q0gpHm3jM237IZUkmn3wa5ojtKrgBIjox
 E7FLxjKXPyy67vy1U6ssO1pg3U94d43oSuLg/oSqslRDBjHf3JKsQax/cBuOa2ysFw
 gROqCW/1Tx8ZU0mtm2tVEN+ELEliWucfjjdQ9JyIJXrNZnB4IuAxeWRTWtGP2QzRHw
 Z1aAg2gO0eTTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 442F5C47DD9;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 22 Jan 2024 22:33:24 +0800
Subject: [PATCH v3 5/5] net: hifemac: make some functions static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-net-v3-5-f1e80564725b@outlook.com>
References: <20240122-net-v3-0-f1e80564725b@outlook.com>
In-Reply-To: <20240122-net-v3-0-f1e80564725b@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705934004; l=916;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=yN6bxCppLVd3zELKEWeh7jD0R+jNdNUufUTF79X0J6o=;
 b=fvrti5MvFqjgw2F8LuRaZGrYE01OV3iHKLe4ZMKxIonKJM7W9MNqPvDt+hsEMm5jiPZCI3mM6
 gmY6t01+RU6BUBBuIk8dhql6ryOKmlrAh64zb+imlfmWma3ipv/jXHI
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

They are not required to be global, make them static.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/hifemac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index d24023eefd..90cc247b3b 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -418,7 +418,7 @@ static void hisi_femac_get_stats(struct udevice *dev, u64 *data)
 	}
 }
 
-int hisi_femac_of_to_plat(struct udevice *dev)
+static int hisi_femac_of_to_plat(struct udevice *dev)
 {
 	int ret, i;
 	struct hisi_femac_priv *priv = dev_get_priv(dev);
@@ -553,7 +553,7 @@ static int hisi_femac_phy_reset(struct hisi_femac_priv *priv)
 	return 0;
 }
 
-int hisi_femac_probe(struct udevice *dev)
+static int hisi_femac_probe(struct udevice *dev)
 {
 	struct hisi_femac_priv *priv = dev_get_priv(dev);
 	int ret, i;

-- 
2.43.0

