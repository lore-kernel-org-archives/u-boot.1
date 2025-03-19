Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CFEC35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CC181F00;
	Wed, 19 Mar 2025 04:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354377;
	bh=ZOI7Nlw7VFPosyEJ6JAJ3JQmgF0cFheKT3O/CjQTr+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j7YA6C03YhELgV7Mw1rAtCE6giwteVIuA9bHJepSCYjVDJ1Y/BNON8nuBHruioox3
	 o+ysho6tpD1KEyM/wXx7E3tBAki0b/C3R7m6eztOHDfOf1qtSZTleqCgDhhSw8m6Gu
	 5llpd3jB8NIeJn1wjngZcIFDjq76ztbIBtqKxqiYxfM37IUoQlM6TTZlGchArzYRR/
	 2mBx7XpKpf4DK3mDEhz2WZgCwgo7YraJ0xalNlPTICJvNn2Fs+Y8kTOSWHvuVnImfW
	 XmP6aoJAQNZeZZw7cU5xEazoxkCx8Fd+NVKfkYjYGYIP5dLNxDOVkb5GNb1f1pCnuU
	 GCKQtBVnJzkKw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A598129F; Wed, 19 Mar 2025 04:19:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3D38129F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="H07YK+Nm"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86382101E91C4; Wed, 19 Mar 2025 04:19:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354369; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ZOI7Nlw7VFPosyEJ6JAJ3JQmgF0cFheKT3O/CjQTr+s=;
 b=H07YK+NmdDpXFRdlh1pK71YNnnfSljvv+PTO+N/8JbDujNChvtrquCqGfDdwayuem9/Wmh
 uoatALAlLXggAN5LtSMF3B8XQY0a1v64cHMoFewy5lYIW/vN2K+R4Tr+rju9iE/NGEp27x
 Uys7fXMIKAWeUt+uFcKyTwumH3LFsB93t89fdOgHbucX79IkiA9XuHl4ydFrnSn0H2C/zz
 9diotOvz1jII4rF4DAwMkIFOWqg9xt68FPatzBFiHpyLZdYhbMaYA4gmvErrbiQTyRFVH1
 Dea+b0QwtM81/d5X92BkSEKooAloR0clkg3Mi0RzCvQDzBb45Ea0l7pvDzuZBQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 14/24] clk: clk-composite: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:24 +0100
Message-ID: <20250319031852.233537-15-marex@denx.de>
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
 drivers/clk/clk-composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 1191bdf87df..9e3b5191767 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -149,7 +149,7 @@ struct clk *clk_register_composite(struct udevice *dev, const char *name,
 	clk = &composite->clk;
 	clk->flags = flags;
 	ret = clk_register(clk, UBOOT_DM_CLK_COMPOSITE, name,
-			   parent_names[clk_composite_get_parent(clk)]);
+		clk_resolve_parent_clk(dev, parent_names[clk_composite_get_parent(clk)]));
 	if (ret) {
 		clk = ERR_PTR(ret);
 		goto err;
-- 
2.47.2

