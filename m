Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4803C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BCC81ECD;
	Wed, 19 Mar 2025 04:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354380;
	bh=QrsoQ6Nr6ZEaoqHFclqEdCybt1u7JhX/T0f3mu3IlQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u4dKFPKQbjc6yKs47NQImBRJJrIxqofqdHGjISZc+bmAZj7r3EOoaK9iiQ/FpEAQF
	 z43RT9mXWBryxGqLOVygwVbZOKyjsUVBnOrnirErq7m8jBBLm63UWe2YeMOW8bhVRn
	 SSME8u+1Y5u1m+5qQX+tzhcTuxfRtz9J/0Pomq4u4gNO7xxCklfj4SW9aFWvRlk0T5
	 lJqSuDZj93lth5+tyeKtbYFgJVN2D+4B3frnwJf479tWncymIJ/L2NSW07KD+GnY6G
	 Wt6COeim+K5RSJJhOXfFNC4Fw+mBM/OBaeWFZYZvweuPK4r99zEirlxfKD7AcJMhe8
	 Pm+4IZKK09xEQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA98D81026; Wed, 19 Mar 2025 04:19:36 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D0E81E76
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FYo57Uit"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E5D48101E91C9; Wed, 19 Mar 2025 04:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354373; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=QrsoQ6Nr6ZEaoqHFclqEdCybt1u7JhX/T0f3mu3IlQs=;
 b=FYo57Uitj0Y49+eyGMTFhay1aCyzy5PB91mVD4FazihjUdWCREMIQKHM9m8LoI8yxNfobP
 dnr8chJ+2WyYW8yKyKq5vlkLuWJC+tvJCxvZEgHPIINORh/YTgrdFa8jVM9451jX0YZ/vT
 GQiF+f2prT9jcQb8GWvhqmjy1UK+n+KALjwpFLcuxAKjThy0krguBIJSlCqJLtv9yBzHP9
 9PN8NLL5GRopj9L1ZtrQ3LAt0HsnT7VBSkOYZKwi03LA6FQboFSum9OcZEv+PUMsGnwN8R
 yrIhT8KO/HuT9UhzYbNK5nHh1QDg8EGQCNybhmZIDg7RGzpIxZk5e128wJZ51Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 18/24] clk: imx: pllv3: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:28 +0100
Message-ID: <20250319031852.233537-19-marex@denx.de>
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
 drivers/clk/imx/clk-pllv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index bc9916385c8..85b6a9809e8 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -339,7 +339,8 @@ struct clk *imx_clk_pllv3(struct udevice *dev, enum imx_pllv3_type type,
 	pll->div_mask = div_mask;
 	clk = &pll->clk;
 
-	ret = clk_register(clk, drv_name, name, parent_name);
+	ret = clk_register(clk, drv_name, name,
+			   clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(pll);
 		return ERR_PTR(ret);
-- 
2.47.2

