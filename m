Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9554C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D70181E67;
	Wed, 19 Mar 2025 04:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354371;
	bh=I2ILQxF9qS7wg2b7tFYCsHbUsYx5kPEi6Xa+nFPhQq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R2KRKsYORlwx1zLDvuduSGNli65zrWKBw2SUBlPpBDilSDed5wCkxKn2OphDZRjmM
	 csRQRBNtBDacvNA9VxYR9PRAafC9U4qdWB9cIYeGJW6hTG6VVoDq4OQLhKGe0HDWdb
	 NOzANPmGCw+PWUpvY/6rpk/O2zG1s3gcBFgcBwCq8MIfHhT1P2e3W3dMK6v5o1Qm73
	 UUYFRjIRQKdF+RSfXbwgcXEucSkin2lKn46xcXrjlA9Pa0qHYWs+Wb2VmNHY+pXMvn
	 7ETCXVzko7KfeBcB8bqxkqfzADUD6P2tWDnEAWSyStlhpBTyhKiEe0m8mFuMJLLukF
	 6HddMAaGAhG9Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114488129F; Wed, 19 Mar 2025 04:19:28 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6267981026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Rts/ASm+"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 06773101E91CD; Wed, 19 Mar 2025 04:19:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354364; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=I2ILQxF9qS7wg2b7tFYCsHbUsYx5kPEi6Xa+nFPhQq4=;
 b=Rts/ASm+vBUvq2eBdSjB0YzGPvVL/5NawSG4jOLS2C9RTAgnWP5vrMYJ7MrRtCFMCBoyia
 WGwk2qm1z67aPC5kZh2DzO5n+reM1t1yt+rLbQAWPbb3dzl7hWUlaY8vd4mm1ccNmpeAge
 BTmHKQW4CAnTrXmbdk3RbSi0bVMbOUCnlEWHudTtSHc60AcCuEYVZMha9bVTpK0vFtFy1K
 hXzoXYzEbEIKJ1gT40UvhhVb3jyS+LKhrWwFgRSX1yyb7BoD8f1FXBc7OpmLl81Gx5SseT
 lGpY+6szAyQg9r660P1JLRFVlEYIOjlFewKxONUar9U6M+Rej/Liq3Q33ju0/A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 10/24] clk: imx: gate2: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:20 +0100
Message-ID: <20250319031852.233537-11-marex@denx.de>
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
 drivers/clk/imx/clk-gate2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 400121a8ae1..fa07b13249b 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -111,7 +111,8 @@ struct clk *clk_register_gate2(struct udevice *dev, const char *name,
 
 	clk = &gate->clk;
 
-	ret = clk_register(clk, UBOOT_DM_CLK_IMX_GATE2, name, parent_name);
+	ret = clk_register(clk, UBOOT_DM_CLK_IMX_GATE2, name,
+		clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(gate);
 		return ERR_PTR(ret);
-- 
2.47.2

