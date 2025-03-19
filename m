Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809E8C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3118281F66;
	Wed, 19 Mar 2025 04:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354381;
	bh=bsctK7QUD7OsiiT0skLs2TUF/iQHs0xyfqBHcgDOBic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zfdRh6ino8lcNNQO6U9y1Ng/qkvF5bUGsneJ1dA8VXAEkAzM7odhX2zLX3HOGqMJU
	 tH85rJ6NQX8W2Au4jMYiATdPiZtxh/Qcp96q7N2RUsHXbi783XjDRUyKcVAlzO5vCu
	 1PJw2FMLRPAW0blwztzu3AtjJ73yqDAezy6lieilttPgGWrZFTQyOlMKPaiwWgAayh
	 ulrZlI+jfTe2xLlZQzeRwqQZ2TcrMKm2OUfiNjvRnN2KFWDqd29VCY6fd2xe45p+lW
	 yy3zoFF9p/gwljor6awcNwFf1E1n0H2RXhrZ+UFPn0OBfWfHI1CtmMCkqnGS6k3xt3
	 MlnS2JrcRT2xg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B8681E13; Wed, 19 Mar 2025 04:19:38 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66DC081E92
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Nxs/j4QD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16D0B101E91CA; Wed, 19 Mar 2025 04:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354374; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=bsctK7QUD7OsiiT0skLs2TUF/iQHs0xyfqBHcgDOBic=;
 b=Nxs/j4QD+QQNd0nRGpk2feTWpzC2C1nFPUP6WnZMNIUhUgD0dGxjK6DXXr5SD9vFE1gNh9
 O00NDQSYnOzeuHi9M3xdvU6xLVCOLLkDi+IeA22PORoXAmTPXGqqVFduWHjw+Mu4EUa7w4
 eUgNXpwjTDuz7asOnIMpK61KgB95ldbA6iyDxac86DNaFKA8XzJUh2zA+kaLyrp+JTZQ/J
 8+jq+ahwHS8XaFKHzgPzrhsmGuCL52qcz+Jf3/p5XQyIMIWKqFg17+QibmbxJnt7plrxYl
 tTjI0WnEqpvBZuO/fSpeEViZcx2VAR4lj9rypSWaDReqyGOoacML7J68cnMibQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 19/24] clk: clk-divider: Use struct udevice instead of struct
 device
Date: Wed, 19 Mar 2025 04:17:29 +0100
Message-ID: <20250319031852.233537-20-marex@denx.de>
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

Use U-Boot specific struct udevice instead of Linux compatibility
struct device in clk-divider clock registration.

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
 drivers/clk/clk-divider.c    | 4 ++--
 include/linux/clk-provider.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index aa210e3d15f..3b4b3c4fa5f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -183,7 +183,7 @@ const struct clk_ops clk_divider_ops = {
 	.set_rate = clk_divider_set_rate,
 };
 
-static struct clk *_register_divider(struct device *dev, const char *name,
+static struct clk *_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table)
@@ -227,7 +227,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	return clk;
 }
 
-struct clk *clk_register_divider(struct device *dev, const char *name,
+struct clk *clk_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d44ead53079..198f3ff0e42 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -237,7 +237,7 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 
-struct clk *clk_register_divider(struct device *dev, const char *name,
+struct clk *clk_register_divider(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags);
-- 
2.47.2

