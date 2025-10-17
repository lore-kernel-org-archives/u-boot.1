Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B33CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404FD83869;
	Fri, 17 Oct 2025 17:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="FM4N1qPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B968051F; Fri, 17 Oct 2025 17:22:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4840C8383E
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 18A95262D9;
 Fri, 17 Oct 2025 17:22:39 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8cnoCB2hV9S; Fri, 17 Oct 2025 17:22:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714558; bh=QdSRgtmdlLr2G4unmQk3xApe1VgmsuvtK5e6CGnmy8E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FM4N1qPKsPCLIU/DaZ6NV0lsqrUDF8fE7VbN5js5OxO0PLqVcBvM33TvbvKN+fql3
 bn/W1IL3ZAtLyUFN5J4vVFeCG/7A2SeHdUbKjTC6k9W64n2ADGDqm+0tKpgUUQyvuC
 XFr5Sb91u3wR8S/y3yiMv8hq4BbxEgJsM/Oh1ooQbH8XGdN7uEeKF91hWDyiWKWBCB
 NvUIyPlokQMlTa2sSI4bHk5SDlTGDEnKcT2cpEPAOULhPzyRClZ8wGE8d/3FR6ZysO
 rPMZsazR+NK8GmQfdd9K50dctrmNactFmjEmknyVgYgmO3yXkCKydVe16fwJJdGTvj
 mZHfo17rJAqcA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:51:34 +0530
Subject: [PATCH 6/6] clk: use private clk struct to access clock flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-clk-exynos7870-v1-6-83f90d425699@disroot.org>
References: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
In-Reply-To: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714499; l=1410;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=QdSRgtmdlLr2G4unmQk3xApe1VgmsuvtK5e6CGnmy8E=;
 b=pVcTO/OVnsoVVnx6krDbjLwOqElbfPNzaC7mMKwxxfPWCAK0T7iqsfNtjLkw0QvlZFiJkZU4w
 mYxaeTFGIVmB7VGYJ/9+b1zvQSaUlT9IaXmKcZS7JI51x7ANQ7LGB4m
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:23:00 +0200
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

There may be cases where the flags set for a clock is not available.
This is usually the case with clocks which have been retrieved using
clk_request(). However, clock flags are found in their respective
private clock struct, so use that instead.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/clk/clk-uclass.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3dbe1ce9441ca513d41be90520ff175c96b4253a..f7709d89a82cc576d6a522c7cdafc4e8fb521db7 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -594,12 +594,13 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);
+	clk_get_priv(clk, &clkp);
 
 	/* Try to find parents which can set rate */
 	while (!ops->set_rate) {
 		struct clk *parent;
 
-		if (!(clk->flags & CLK_SET_RATE_PARENT))
+		if (!(clkp->flags & CLK_SET_RATE_PARENT))
 			return -ENOSYS;
 
 		parent = clk_get_parent(clk);
@@ -608,10 +609,9 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
 
 		clk = parent;
 		ops = clk_dev_ops(clk->dev);
+		clk_get_priv(clk, &clkp);
 	}
 
-	/* get private clock struct used for cache */
-	clk_get_priv(clk, &clkp);
 	/* Clean up cached rates for us and all child clocks */
 	clk_clean_rate_cache(clkp);
 

-- 
2.51.0

