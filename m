Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C609CEFD01
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 19:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567F083D9F;
	Tue,  6 Jan 2026 20:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="RXc0zAvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1BA283FBE; Tue,  6 Jan 2026 20:53:31 +0100 (CET)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D331B83B64
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 20:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767729209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0ebhCHoGp4J+nzZfJXsDsc0DVdhrDAVeZBjnKrLXPQ=;
 b=RXc0zAvXMeUQRtwX1qNQhmVk83Oyq6bP0tNwY/Z2aLs7QT/W5NYJa8tuTlgmSq54/j36ST
 lXqfZVNPW8BUJqGKWJfqPm7IPqX+TtExl2vczUbQrWAN+NN3848LFarjK33wDyiR7AuRPv
 yIdatzDih9Y/6F9HSO582xChfYvM1bI=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/2] clk: versaclock: Fix clk_get_rate
Date: Tue,  6 Jan 2026 14:53:21 -0500
Message-Id: <20260106195322.657150-2-sean.anderson@linux.dev>
In-Reply-To: <20260106195322.657150-1-sean.anderson@linux.dev>
References: <20260106195322.657150-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Devicetree clock references point at the main versaclock device. We
must determine the parent clock manually, as it depends on the clock id.
The device parent of the versaclock will generally be an I2C bus and not
another clock.

Fixes: dcf2cee77f2 ("clk: clk_versaclock: Add support for versaclock driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/clk/clk_versaclock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 19a787eaf0c..7a1052a1be7 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -633,7 +633,15 @@ static unsigned long vc5_clk_out_set_rate(struct clk *hw, unsigned long rate)
 
 static unsigned long vc5_clk_out_get_rate(struct clk *hw)
 {
-	return clk_get_parent_rate(hw);
+	struct udevice *dev;
+	struct vc5_driver_data *vc;
+	struct clk *parent;
+
+	uclass_get_device_by_name(UCLASS_CLK, clk_hw_get_name(hw), &dev);
+	vc = dev_get_priv(dev);
+	parent = clk_get_parent(&vc->clk_out[hw->id].hw);
+
+	return clk_get_rate(parent);
 }
 
 static const struct clk_ops vc5_clk_out_ops = {
-- 
2.35.1.1320.gc452695387.dirty

