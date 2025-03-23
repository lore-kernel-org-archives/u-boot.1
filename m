Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23A7C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED1B820AA;
	Sun, 23 Mar 2025 17:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745725;
	bh=XV6ZRl2zZQhObJIf2eeUW94FFhhQg5UyL+EKOJmFML4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RHN/5up39p1W6HVPNVardjCdI3sI9SfLqBI4uUhWN3e4ugmfzDkUt/HpaxJyRZENE
	 xecvt/+YQFFRCCllSSayBhFtozIjgAbvT79Dd9tVEUgZsf2+DBLImueVWlENpMUSu9
	 2GLUz5c5dlbiX4VWkt8pXiwqjD2qyTlEZW7F2Dq4qXrA+enlVOu0MvYCSo4gWwCmxy
	 aomTBt1Dz4Qbd17x563I9r9VmEpTulpQpXhLwyEMw0vYSrwTYWEeFyZihhdr3ZkHmr
	 YGjrRliMuZzjyApY8YcwrXvGZXwqDXfFYbRjiL/9G/kebXd1Oq9dp8+s/flcwYgkxV
	 JhCUiBQ7RdLMQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6450081CFD; Sun, 23 Mar 2025 17:01:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA9682008
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="f0FdOSjD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 261C51029024F; Sun, 23 Mar 2025 17:01:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745715; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=XV6ZRl2zZQhObJIf2eeUW94FFhhQg5UyL+EKOJmFML4=;
 b=f0FdOSjDTXtsPH1b4LyKOnrWOey5Y5AHyQneR/fbHXDPY+Ek0AUos3WVxHNjyBFZJnWxK0
 Ysh8PNyIe+NYGOXOgU21hqRmYYBriOA2yZTwlgth02DuWf5l5G4ba4tzIyJBt5Nm/QDKlG
 qEbFBCz/NV7j6ICB+koLbNd4RdpEAaL8rpaTUb71izoUSTG42UrFoUUZTPjvep6mfY3dxT
 Egpokq2Y44uYcMuzavdkOwtVzFA2xyY2pYwK8RA6t4wW2yo0Nhu3Sr+lJzD/08sRCtn9Fd
 qVil9P1IKLsffnAqsbafXbSIT8Xh9aEJRLZzCR0BIyyw5VllxGdh1Dw+iO2jzg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 04/24] clk: clk-mux: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:33 +0100
Message-ID: <20250323160107.145749-5-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
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
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
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

