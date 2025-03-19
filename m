Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC00C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99BD481CFD;
	Wed, 19 Mar 2025 04:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354370;
	bh=aUenrE4Wtj6yR7vYIauf86rLqOc2i8VWlXmM6LnHHRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mdbFXY6JqbePIQpzbIRJoorZVSnCk6e5G2WfFjSvHJZjoc2CJx0D88L1T97vw4Sq4
	 25Z8DJgiKoJuSKQM2vaoRpx75gIjmx5oS4yQWXFl0cJS1V+zd23PiCMjrB5b0ZU1YO
	 G1yB8rZ1+8Wbhky+g6VOJEq2SnsVIOixihUbkQbpJlDYkRmVCL4aFCFzVvn5dilmuP
	 hUYJ6O9HqheTzNhyRh5GiiVdQU2penEkICovkcR9QOPvNuzjD+yTRzjLAPQlHkXKWH
	 /ZdmMvkvboTs92phTW7qak7TQcT0sdvDgNgtG75Y6ej4bh5wDcEyTQdLvtwwq5BHl8
	 3xqwyF+PFPGvQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743BF81E5A; Wed, 19 Mar 2025 04:19:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3587E81DCA
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="h+IY1tKE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA1D1101F63AB; Wed, 19 Mar 2025 04:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354362; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=aUenrE4Wtj6yR7vYIauf86rLqOc2i8VWlXmM6LnHHRo=;
 b=h+IY1tKE3zAuAqmbuszWEjpLqChUKt9os8+yYqunAuiEmX7a23iN/vZwKR/kg7YsRNIH0M
 zcP2nwbt6/5+tuoml4wVPZb/dqXAx4ruAty6WRjoUeK2T4MOjf1nTyTJPPPWGPxtL8IXGU
 ITZMFstLIWk4aYrZwvAFgIjhKIIEG7Q9bf4kZvC8MrDr97ksIwtEbqznV4hKempJVfkYCQ
 bv2ZWLKh+lmzx1e2OLB1h6Yy+XEwNr9VKI1DNP1WCgkpLw7qlg6v0yNmzYLu94yUDB62W8
 bnVTP18Nv5odf0xp++P93n63G+El6wFLfcCBJU3m2PVjs3Lzz9jwj5AQzp5X4g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 08/24] clk: clk-gate: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:18 +0100
Message-ID: <20250319031852.233537-9-marex@denx.de>
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

