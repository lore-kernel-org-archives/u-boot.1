Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FB7C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3A681DE3;
	Wed, 19 Mar 2025 04:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354363;
	bh=azg9kmGw7nv464zi7CiVyDZHzCztrJ4JPtY58Y5FLtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DwBFa1KGwMLMOexqS6vMUwWxtmRCu8NBzX2sAFKWz7qeSpImaPUZqzzRoE7KdnKWX
	 pkMdSpa6Kc+1+nXLT66AQRAZR6Uk1+DecESabOiCjob0zb+BoVlQVLvtpATS8s96CY
	 +xvNJbAAej7p2AVNLcJuKuERVsxC/KS7jJyqkN6qhragH0kVagLG+XkO4nLuVnKKDa
	 l94WueCyyFjT2evbEeIVvTGuLw2IKZZb52xktZNs3cKBd5nhCXg1/IRhw8b+AEWJjw
	 n+IZzTg285jNxc707PXj5PSwDG8bht3CgziUIAO0lh3jNLZyhVW3+s3Us8Rg0xNl+h
	 i6YmFWuCI+jSg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67EC81DCA; Wed, 19 Mar 2025 04:19:20 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4B481C84
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Wg5fF0mX"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5C53101E91C5; Wed, 19 Mar 2025 04:19:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354358; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=azg9kmGw7nv464zi7CiVyDZHzCztrJ4JPtY58Y5FLtU=;
 b=Wg5fF0mX+tIb9KejyL5SkJ8TTkVQhqYfSyFzsSXOxPiW3ItBABkGIpqJw+Rz4UyT1KpTRx
 6vjscglDenpr+B8ZSJku6Tj1FFFNWP38xSoasnKzi0QOPSEKm5P9tr3su74900DUoZRW0R
 oJqj7KAqYjp+zn7bTwfm1zYsI+xPiYUXcFUHrYMC/AcuH1Jsq2J8hLAzBv7J81/T2oDJB/
 kOjsceHR3fj7y4IrBJ8RU3op4N2THgYiewsCH8vjgm5FDcvFkSzNrCc2FXQY8DFMwU3qZD
 QjctLafpOxAWcbNTiTQrMN1KSrMdtTdghaXGpNj33PV2q3+5SS66i8g4jkFjXw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 04/24] clk: clk-mux: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:14 +0100
Message-ID: <20250319031852.233537-5-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Use clock-names property which is accessible via parent clock OF node
to look up the parent clock by name instead of depending on unreliable
global clock name to perform look up.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/clk-mux.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index e2331a07840..d7411f8f282 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -113,6 +113,11 @@ int clk_mux_fetch_parent_index(struct clk *clk, struct clk *parent)
 	for (i = 0; i < mux->num_parents; i++) {
 		if (!strcmp(parent->dev->name, mux->parent_names[i]))
 			return i;
+		if (!strcmp(parent->dev->name,
+			    clk_resolve_parent_clk(clk->dev,
+						   mux->parent_names[i])))
+			return i;
+
 	}
 
 	return -EINVAL;
@@ -207,7 +212,8 @@ struct clk *clk_register_mux(struct udevice *dev, const char *name,
 	 * for the corresponding clock (to do that define .set_parent() method).
 	 */
 	ret = clk_register(clk, UBOOT_DM_CLK_CCF_MUX, name,
-			   parent_names[clk_mux_get_parent(clk)]);
+			   clk_resolve_parent_clk(dev,
+				parent_names[clk_mux_get_parent(clk)]));
 	if (ret) {
 		kfree(mux);
 		return ERR_PTR(ret);
-- 
2.47.2

