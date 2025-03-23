Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D10C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94698211F;
	Sun, 23 Mar 2025 17:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745727;
	bh=iyazS+igS4Iz5J9qcfNs8FvUV19vBjjPwrHtX6dQXdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zNvrLiC51TNRBC/bmxXsIZ2H4O+HAevBpwV9b2ovE+RS5hdHqLmMoHRrq0dWjFPmO
	 GmBiwLI/4QJLyAvGEwt+oeyCTwqiyFTbFb4UUfZgWVjvpXbTn8kQMFEdh4BQRGhKCt
	 QvP9kWCmlLFciFBP95wiNNLoGxjjg/cStI4npDJtBOPgT1PU2AH2986d9SDvUo954p
	 RN4F+7QdODomo8WuqJ1Zwr8h3nsKjrEIV3gBpyzNIr0nWP4dIoInXcZssd5TX9Td9c
	 ITgeMgRh02Ra6ODfHsKqBRjuSwHfs+AzpZPNUZYywKU2tMGs0ltS/Mhr3Ja3XDkFwM
	 eiykAUZFn+N6g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2554820F0; Sun, 23 Mar 2025 17:02:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F68B820B7
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iLl5qAaa"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F3D6B10290254; Sun, 23 Mar 2025 17:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745719; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=iyazS+igS4Iz5J9qcfNs8FvUV19vBjjPwrHtX6dQXdA=;
 b=iLl5qAaaRuhPTApiAMlhISOv97NVWFJm/IwYvuGwoIY4jJtiAMNUBYhrCJ+AbBLhxdsURZ
 dAyIM4Wi2w0YRP6slrPnJM96+0o5Zdr1cmkX8dsfaU42PeQC/J34HKLFAuiHUgz8f85PXf
 Mcr0pTl2mlV54LMK9+1is2f9yoGGNoDAxTFjKeMpXTiCbCvGFkUfmQ+yUtavxPRiOfS9VY
 VOCllUuf0zjoZSNr0mA6CpVOk6T+Kg+FUJBMbTxtNjGbxeXZdSOh8GYPM0y9jBLW6Mxap+
 TPHstLDLiyoVKFzfh7AceQxex9L3AQzSqGNUcx79HtAPtIe2RgNm2RqwRhQFlw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 08/24] clk: clk-gate: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:37 +0100
Message-ID: <20250323160107.145749-9-marex@denx.de>
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
 drivers/clk/clk-gate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index cef98720b69..256ff108991 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -149,7 +149,8 @@ struct clk *clk_register_gate(struct udevice *dev, const char *name,
 	clk = &gate->clk;
 	clk->flags = flags;
 
-	ret = clk_register(clk, UBOOT_DM_CLK_GATE, name, parent_name);
+	ret = clk_register(clk, UBOOT_DM_CLK_GATE, name,
+		clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(gate);
 		return ERR_PTR(ret);
-- 
2.47.2

